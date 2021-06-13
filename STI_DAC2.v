module STI_DAC(clk ,reset, load, pi_data, pi_length, pi_fill, pi_msb, pi_low, pi_end,
	       so_data, so_valid,
	       oem_finish, oem_dataout, oem_addr,
	       odd1_wr, odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr);

input		clk, reset;
input		load, pi_msb, pi_low, pi_end; 
input	[15:0]	pi_data;
input	[1:0]	pi_length;
input		pi_fill;
output		so_data, so_valid;

output  oem_finish, odd1_wr, odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr;
output [4:0] oem_addr;
output [7:0] oem_dataout;

//==============================================================================

reg so_data, so_valid;
reg oem_dataout;
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7;
parameter S8 = 8, S9 = 9, S10 = 10, S11 = 11, S12 = 12, S13 = 13, S14 = 14, S15 = 15;
parameter S16 = 16, S17 = 17, S18 = 18, S19 = 19, S20 = 20, S21 = 21, S22 = 22, S23 = 23;
parameter S24 = 24, S25 = 25, S26 = 26, S27 = 27, S28 = 28, S29 = 29, S30 = 30, S31 = 31;
parameter S32 = 32, S00 = 33, S01 = 34;
reg [5:0] state, next_state;
reg  next_so_data;
reg [7:0] next_oem_dataout;
reg wr;
reg [6:0] cnt1;
reg [2:0] cnt2;
reg [3:0] cnt3;
reg [5:0] cnt4;

always@(*) begin
	case(pi_length)
		2'b00:
			case(state)
				S00: begin
					if(load) begin
						next_state = S0;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end
					else begin
						next_state = S00;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end			
				end	
				S0: begin
					next_state = S1;
					next_so_data = pi_low ? pi_data[15] : pi_data[7];
					next_oem_dataout = 8'b0;
				end
				S1: begin
					next_state = S2;
					next_so_data = pi_low ? pi_data[14] : pi_data[6];
					next_oem_dataout[7] = so_data;
				end
				S2: begin
					next_state = S3;
					next_so_data = pi_low ? pi_data[13] : pi_data[5];
					next_oem_dataout[6] = so_data;
				end	
				S3:	begin
					next_state = S4;
					next_so_data = pi_low ? pi_data[12] : pi_data[4];
					next_oem_dataout[5] = so_data;
				end	
				S4: begin
					next_state = S5;
					next_so_data = pi_low ? pi_data[11] : pi_data[3];
					next_oem_dataout[4] = so_data;
				end	
				S5: begin
					next_state = S6;
					next_so_data = pi_low ? pi_data[10] : pi_data[2];
					next_oem_dataout[3] = so_data;
				end	
				S6: begin
					next_state = S7;
					next_so_data = pi_low ? pi_data[9] : pi_data[1];
					next_oem_dataout[2] = so_data;
				end	
				S7: begin
					next_state = S8;
					next_so_data = pi_low ? pi_data[8] : pi_data[0];
					next_oem_dataout[1] = so_data;
				end	
				S8: begin
					next_state = S01;
					next_so_data = 1'b0;
					next_oem_dataout[0] = so_data;
				end
				S01: begin
					next_state = S00;
					next_so_data = 1'b0;
					next_oem_dataout = 8'b0;
				end	
				default: begin
					next_state = S00;
					next_so_data = so_data;
					next_oem_dataout = 8'b0;
				end					
			endcase
		2'b01:
			case(state)
				S00: begin
					if(load) begin
						next_state = S0;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end
					else begin
						next_state = S00;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end			
				end
				S0: begin
					next_state = S1;
					next_so_data = pi_msb ? pi_data[15] : pi_data[0];
				end
				S1: begin
					next_state = S2;
					next_so_data = pi_msb ? pi_data[14] : pi_data[1];
					next_oem_dataout[7] = so_data;
				end	
				S2: begin
					next_state = S3;
					next_so_data = pi_msb ? pi_data[13] : pi_data[2];
					next_oem_dataout[6] = so_data;
				end
				S3: begin
					next_state = S4;
					next_so_data = pi_msb ? pi_data[12] : pi_data[3];
					next_oem_dataout[5] = so_data;
				end	
				S4: begin
					next_state = S5;
					next_so_data = pi_msb ? pi_data[11] : pi_data[4];
					next_oem_dataout[4] = so_data;
				end	
				S5: begin
					next_state = S6;
					next_so_data = pi_msb ? pi_data[10] : pi_data[5];
					next_oem_dataout[3] = so_data;
				end	
				S6: begin
					next_state = S7;
					next_so_data = pi_msb ? pi_data[9] : pi_data[6];
					next_oem_dataout[2] = so_data;
				end
				S7: begin
					next_state = S8;
					next_so_data = pi_msb ? pi_data[8] : pi_data[7];
					next_oem_dataout[1] = so_data;
				end
				S8: begin
					next_state = S9;
					next_so_data = pi_msb ? pi_data[7] : pi_data[8];
					next_oem_dataout[0] = so_data;
				end	
				S9: begin
					next_state = S10;
					next_so_data = pi_msb ? pi_data[6] : pi_data[9];
					next_oem_dataout[7] = so_data;
				end	
				S10: begin
					next_state = S11;
					next_so_data = pi_msb ? pi_data[5] : pi_data[10];
					next_oem_dataout[6] = so_data;
				end	
				S11: begin
					next_state = S12;
					next_so_data = pi_msb ? pi_data[4] : pi_data[11];
					next_oem_dataout[5] = so_data;
				end	
				S12: begin
					next_state = S13;
					next_so_data = pi_msb ? pi_data[3] : pi_data[12];
					next_oem_dataout[4] = so_data;
				end		
				S13: begin
					next_state = S14;
					next_so_data = pi_msb ? pi_data[2] : pi_data[13];
					next_oem_dataout[3] = so_data;
				end	
				S14: begin
					next_state = S15;
					next_so_data = pi_msb ? pi_data[1] : pi_data[14];
					next_oem_dataout[2] = so_data;
				end
				S15: begin
					next_state = S16;
					next_so_data = pi_msb ? pi_data[0] : pi_data[15];
					next_oem_dataout[1] = so_data;
				end	
				S16: begin
					next_state = S01;
					next_so_data = 1'b0;
					next_oem_dataout[0] = so_data;
				end
				S01: begin
					next_state = S00;
					next_so_data = 1'b0;
					next_oem_dataout = 8'b0;
				end	
				default: begin
					next_state = S00;
					next_so_data = so_data;
					next_oem_dataout = 8'b0;
				end
			endcase
		2'b10:
			case(state)
				S00: begin
					if(load) begin
						next_state = S0;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end
					else begin
						next_state = S00;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end			
				end
				S0: begin
					next_state = S1;
					next_so_data = pi_fill ? pi_data[15] : 1'b0;
					next_oem_dataout = 8'b0;
				end	
				S1: begin
					next_state = S2;
					next_so_data = pi_fill ? pi_data[14] : 1'b0;
					next_oem_dataout[7] = so_data;
				end	
				S2: begin
					next_state = S3;
					next_so_data = pi_fill ? pi_data[13] : 1'b0;
					next_oem_dataout[6] = so_data;
				end	
				S3: begin
					next_state = S4;
					next_so_data = pi_fill ? pi_data[12] : 1'b0;
					next_oem_dataout[5] = so_data;
				end	
				S4: begin
					next_state = S5;
					next_so_data = pi_fill ? pi_data[11] : 1'b0;
					next_oem_dataout[4] = so_data;
				end	
				S5: begin
					next_state = S6;
					next_so_data = pi_fill ? pi_data[10] : 1'b0;
					next_oem_dataout[3] = so_data;
				end	
				S6: begin
					next_state = S7;
					next_so_data = pi_fill ? pi_data[9] : 1'b0;
					next_oem_dataout[2] = so_data;
				end	
				S7: begin
					next_state = S8;
					next_so_data = pi_fill ? pi_data[8] : 1'b0;
					next_oem_dataout[1] = so_data;
				end	
				S8: begin
					next_state = S9;
					next_so_data = pi_fill ? pi_data[7] : pi_data[15];
					next_oem_dataout[0] = so_data;
				end
				S9: begin
					next_state = S10;
					next_so_data = pi_fill ? pi_data[6] : pi_data[14];
					next_oem_dataout[7] = so_data;
				end	
				S10: begin
					next_state = S11;
					next_so_data = pi_fill ? pi_data[5] : pi_data[13];
					next_oem_dataout[6] = so_data;
				end	
				S11: begin
					next_state = S12;
					next_so_data = pi_fill ? pi_data[4] : pi_data[12];
					next_oem_dataout[5] = so_data;
				end	
				S12: begin
					next_state = S13;
					next_so_data = pi_fill ? pi_data[3] : pi_data[11];
					next_oem_dataout[4] = so_data;
				end		
				S13: begin
					next_state = S14;
					next_so_data = pi_fill ? pi_data[2] : pi_data[10];
					next_oem_dataout[3] = so_data;
				end	
				S14: begin
					next_state = S15;
					next_so_data = pi_fill ? pi_data[1] : pi_data[9];
					next_oem_dataout[2] = so_data;
				end	
				S15: begin
					next_state = S16;
					next_so_data = pi_fill ? pi_data[0] : pi_data[8];
					next_oem_dataout[1] = so_data;
				end	
				S16: begin
					next_state = S17;
					next_so_data = pi_fill ? 1'b0 : pi_data[7];
					next_oem_dataout[0] = so_data;
				end	
				S17: begin
					next_state = S18;
					next_so_data = pi_fill ? 1'b0 : pi_data[6];
					next_oem_dataout[7] = so_data;
				end	
				S18: begin
					next_state = S19;
					next_so_data = pi_fill ? 1'b0 : pi_data[5];
					next_oem_dataout[6] = so_data;
				end	
				S19: begin
					next_state = S20;
					next_so_data = pi_fill ? 1'b0 : pi_data[4];
					next_oem_dataout[5] = so_data;
				end	
				S20: begin
					next_state = S21;
					next_so_data = pi_fill ? 1'b0 : pi_data[3];
					next_oem_dataout[4] = so_data;
				end	
				S21: begin
					next_state = S22;
					next_so_data = pi_fill ? 1'b0 : pi_data[2];
					next_oem_dataout[3] = so_data;
				end	
				S22: begin
					next_state = S23;
					next_so_data = pi_fill ? 1'b0 : pi_data[1];
					next_oem_dataout[2] = so_data;
				end	
				S23: begin
					next_state = S24;
					next_so_data = pi_fill ? 1'b0 : pi_data[0];
					next_oem_dataout[1] = so_data;
				end	
				S24: begin
					next_state = S01;
					next_so_data = 1'b0;
					next_oem_dataout[0] = so_data;
				end
				S01: begin
					next_state = S00;
					next_so_data = 1'b0;
					next_oem_dataout[0] = 8'b0;
				end		
				default: begin
					next_state = S00;
					next_so_data = so_data;
					next_oem_dataout = 8'b0;
				end			
			endcase
		2'b11:
			case(state)
				S00: begin
					if(load) begin
						next_state = S0;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end
					else begin
						next_state = S00;
						next_so_data = 1'b0;
						next_oem_dataout = 8'b0;
					end			
				end
				S0: begin
					next_state = S1;
					next_so_data = pi_fill ? pi_data[15] : 1'b0;
					next_oem_dataout = 8'b0;
				end	
				S1: begin
					next_state = S2;
					next_so_data = pi_fill ? pi_data[14] : 1'b0;
					next_oem_dataout[7] = so_data;
				end
				S2: begin
					next_state = S3;
					next_so_data = pi_fill ? pi_data[13] : 1'b0;
					next_oem_dataout[6] = so_data;
				end	
				S3: begin
					next_state = S4;
					next_so_data = pi_fill ? pi_data[12] : 1'b0;
					next_oem_dataout[5] = so_data;
				end	
				S4: begin
					next_state = S5;
					next_so_data = pi_fill ? pi_data[11] : 1'b0;
					next_oem_dataout[4] = so_data;
				end	
				S5: begin
					next_state = S6;
					next_so_data = pi_fill ? pi_data[10] : 1'b0;
					next_oem_dataout[3] = so_data;
				end	
				S6: begin
					next_state = S7;
					next_so_data = pi_fill ? pi_data[9] : 1'b0;
					next_oem_dataout[2] = so_data;
				end	
				S7: begin
					next_state = S8;
					next_so_data = pi_fill ? pi_data[8] : 1'b0;
					next_oem_dataout[1] = so_data;
				end
				S8: begin
					next_state = S9;
					next_so_data = pi_fill ? pi_data[7] : 1'b0;
					next_oem_dataout[0] = so_data;
				end	
				S9: begin
					next_state = S10;
					next_so_data = pi_fill ? pi_data[6] : 1'b0;
					next_oem_dataout[7] = so_data;
				end	
				S10: begin
					next_state = S11;
					next_so_data = pi_fill ? pi_data[5] : 1'b0;
					next_oem_dataout[6] = so_data;
				end	
				S11: begin
					next_state = S12;
					next_so_data = pi_fill ? pi_data[4] : 1'b0;
					next_oem_dataout[5] = so_data;
				end	
				S12: begin
					next_state = S13;
					next_so_data = pi_fill ? pi_data[3] : 1'b0;	
					next_oem_dataout[4] = so_data;
				end
				S13: begin
					next_state = S14;
					next_so_data = pi_fill ? pi_data[2] : 1'b0;
					next_oem_dataout[3] = so_data;
				end	
				S14: begin
					next_state = S15;
					next_so_data = pi_fill ? pi_data[1] : 1'b0;
					next_oem_dataout[2] = so_data;
				end	
				S15: begin
					next_state = S16;
					next_so_data = pi_fill ? pi_data[0] : 1'b0;
					next_oem_dataout[1] = so_data;
				end	
				S16: begin
					next_state = S17;
					next_so_data = pi_fill ? 1'b0 : pi_data[15];
					next_oem_dataout[0] = so_data;
				end	
				S17: begin
					next_state = S18;
					next_so_data = pi_fill ? 1'b0 : pi_data[14];
					next_oem_dataout[7] = so_data;
				end	
				S18: begin
					next_state = S19;
					next_so_data = pi_fill ? 1'b0 : pi_data[13];
					next_oem_dataout[6] = so_data;
				end
				S19: begin
					next_state = S20;
					next_so_data = pi_fill ? 1'b0 : pi_data[12];
					next_oem_dataout[5] = so_data;
				end	
				S20: begin
					next_state = S21;
					next_so_data = pi_fill ? 1'b0 : pi_data[11];
					next_oem_dataout[4] = so_data;
				end	
				S21: begin
					next_state = S22;
					next_so_data = pi_fill ? 1'b0 : pi_data[10];
					next_oem_dataout[3] = so_data;
				end	
				S22: begin
					next_state = S23;
					next_so_data = pi_fill ? 1'b0 : pi_data[9];
					next_oem_dataout[2] = so_data;
				end	
				S23: begin
					next_state = S24;
					next_so_data = pi_fill ? 1'b0 : pi_data[8];
					next_oem_dataout[1] = so_data;
				end	
				S24: begin
					next_state = S25;
					next_so_data = pi_fill ? 1'b0 : pi_data[7];
					next_oem_dataout[0] = so_data;
				end	
				S25: begin
					next_state = S26;
 					next_so_data = pi_fill ? 1'b0 : pi_data[6];
					next_oem_dataout[7] = so_data;
				end	
				S26: begin
					next_state = S27;
					next_so_data = pi_fill ? 1'b0 : pi_data[5];
					next_oem_dataout[6] = so_data;
				end	
				S27: begin
					next_state = S28;
					next_so_data = pi_fill ? 1'b0 : pi_data[4];
					next_oem_dataout[5] = so_data;
				end	
				S28: begin
					next_state = S29;
					next_so_data = pi_fill ? 1'b0 : pi_data[3];
					next_oem_dataout[4] = so_data;
				end		
				S29: begin
					next_state = S30;
					next_so_data = pi_fill ? 1'b0 : pi_data[2];
					next_oem_dataout[3] = so_data;
				end	
				S30: begin
					next_state = S31;
					next_so_data = pi_fill ? 1'b0 : pi_data[1];
					next_oem_dataout[2] = so_data;
				end	
				S31: begin
					next_state = S32;
					next_so_data = pi_fill ? 1'b0 : pi_data[0];
					next_oem_dataout[1] = so_data;					
				end
				S32: begin
					next_state = S01;
					next_so_data = 1'b0;
					next_oem_dataout[0] = so_data;
				end
				S01: begin
					next_state = S00;
					next_so_data = 1'b0;
					next_oem_dataout = 8'b0;
				end	
				default: begin
					next_state = S00;
					next_so_data = so_data;
					next_oem_dataout = 8'b0;
				end	
			endcase
	endcase
end

always@(posedge clk or posedge reset) begin
	if(reset) begin
		state <= S00;
		so_data <= 1'b0;
		oem_dataout <= 8'b0;
	end
	else begin
		state <= next_state;
		so_data <= next_so_data;
		oem_dataout <= next_oem_dataout;
	end
end	
		
always@(*) begin
	case(pi_length)
		2'b00:
			so_valid = (state == S1) || (state == S2) || (state == S3) || (state == S4) || (state == S5) || (state == S6) || (state == S7) || (state == S8);
		2'b01:
			so_valid = (state == S1) || (state == S2) || (state == S3) || (state == S4) || (state == S5) || (state == S6) || (state == S7) || (state == S8) ||
				(state == S9) || (state == S10) || (state == S11) || (state == S12) || (state == S13) || (state == S14) || (state == S15) || (state == S16);
		2'b10:
			so_valid = (state == S1) || (state == S2) || (state == S3) || (state == S4) || (state == S5) || (state == S6) || (state == S7) || (state == S8) ||
				(state == S9) || (state == S10) || (state == S11) || (state == S12) || (state == S13) || (state == S14) || (state == S15) || (state == S16) ||			
				(state == S17) || (state == S18) || (state == S19) || (state == S20) || (state == S21) || (state == S22) || (state == S23) || (state == S24);
		2'b11:
			so_valid = (state == S1) || (state == S2) || (state == S3) || (state == S4) || (state == S5) || (state == S6) || (state == S7) || (state == S8) ||
				(state == S9) || (state == S10) || (state == S11) || (state == S12) || (state == S13) || (state == S14) || (state == S15) || (state == S16) ||			
				(state == S17) || (state == S18) || (state == S19) || (state == S20) || (state == S21) || (state == S22) || (state == S23) || (state == S24)||
				(state == S25) || (state == S26) || (state == S27) || (state == S28) || (state == S29) || (state == S30) || (state == S31) || (state == S32);
	endcase
end

always@(posedge clk) begin
	case(pi_length)
		2'b00:
			if(state == S01) begin
				wr <= 1'b1;
			end	
			else begin
				wr <= 1'b0;
			end
		2'b01:
			if((state == S9) || (state == S01)) begin
				wr <= 1'b1;
			end	
			else begin
				wr <= 1'b0;
			end
		2'b10:
			if((state == S9) || (state == S17) || (state == S01)) begin
				wr <= 1'b1;
			end
			else begin
				wr <= 1'b0;
			end	
		2'b11:
			if((state == S9) || (state == S17) || (state == S25) || (state == S01)) begin
				wr <= 1'b1;
			end
			else begin
				wr <= 1'b0;
			end
	endcase
end

always@(posedge clk or posedge reset) begin
	if(reset) begin
		cnt1 <= 7'b0;
	end
	else if(cnt1 == 64) begin
		cnt1 <= 7'b0;
	end	
	else begin
		case(pi_length)
			2'b00:
				if(state == S8) begin
					cnt1 <= cnt1 + 1;
				end	
				else begin
					cnt1 <= cnt1;
				end
			2'b01:
				if((state == S8) || (state == S16)) begin
					cnt1 <= cnt1 + 1;
				end	
				else begin
					cnt1 <= cnt1;
				end
			2'b10:
				if((state == S8) || (state == S16) || (state == S24)) begin
					cnt1 <= cnt1 + 1;
				end
				else begin
					cnt1 <= cnt1;
				end	
			2'b11:
				if((state == S8) || (state == S16) || (state == S24) || (state == S32)) begin
					cnt1 <= cnt1 + 1;
				end
				else begin
					cnt1 <= cnt1;
				end
		endcase
	end	
end	

always@(posedge clk or posedge reset) begin
	if(reset) begin
		cnt2 <= 3'b0;
	end
	else if(cnt1 == 64) begin
		cnt2 <= cnt2 + 1;
	end
	else begin
		cnt2 <= cnt2;
	end	
end

always@(posedge clk or posedge reset) begin
	if(reset) begin
		cnt3 <= 4'b0;
		cnt4 <= 6'b0;
	end
	else if(cnt3 == 8) begin
		cnt3 <= 4'b0;
		cnt4 <= cnt4 + 1;
	end	
	else if(wr) begin
		cnt3 <= cnt3 + 1;
		cnt4 <= cnt4;
	end
	else begin
		cnt3 <= cnt3;
		cnt4 <= cnt4;
	end	
end
	
	
assign odd1_wr = (((cnt1 % 2 == 1) && (cnt4 % 2 == 0) && (cnt2 == 0)) || ((cnt1 % 2 == 0) && (cnt4 % 2 == 1) && (cnt2 == 0))) ? wr : 1'b0;
assign even1_wr = (((cnt1 % 2 == 0) && (cnt4 % 2 == 0) && (cnt2 == 0)) && ((cnt1 % 2 == 1) && (cnt4 % 2 == 1) && (cnt2 == 0))) ? wr : 1'b0;
assign odd2_wr = ((cnt1 % 2 == 1) && (cnt2 == 1)) ? wr : 1'b0;
assign even2_wr = ((cnt1 % 2 == 0) && (cnt2 == 1)) ? wr : 1'b0;
assign odd3_wr = ((cnt1 % 2 == 1) && (cnt2 == 2)) ? wr : 1'b0;
assign even3_wr = ((cnt1 % 2 == 0) && (cnt2 == 2)) ? wr : 1'b0;
assign odd4_wr = ((cnt1 % 2 == 1) && (cnt2 == 3)) ? wr : 1'b0;
assign even4_wr = ((cnt1 % 2 == 0) && (cnt2 == 3)) ? wr : 1'b0;

assign oem_addr = (cnt1 % 2 == 1) ? (cnt1 - 1) / 2 : (cnt1 / 2) - 1;
assign oem_finish = (cnt4 == 32);
	
endmodule
