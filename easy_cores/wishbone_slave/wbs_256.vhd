-- This file is part of easyFPGA.
-- Copyright 2013,2014 os-cillation GmbH
--
-- easyFPGA is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- easyFPGA is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with easyFPGA.  If not, see <http://www.gnu.org/licenses/>.

--===========================================================================--
-- WISHBONE SLAVE (256 registers)
-- generated with sdk-java for testing purposes
--===========================================================================--

--===========================================================================--
-- Type and component definition package
--===========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.interfaces.all;

package package_wbs256 is

   type reg_wbs256_t is record
      reg0 : std_logic_vector(WB_DW-1 downto 0);
      reg1 : std_logic_vector(WB_DW-1 downto 0);
      reg2 : std_logic_vector(WB_DW-1 downto 0);
      reg3 : std_logic_vector(WB_DW-1 downto 0);
      reg4 : std_logic_vector(WB_DW-1 downto 0);
      reg5 : std_logic_vector(WB_DW-1 downto 0);
      reg6 : std_logic_vector(WB_DW-1 downto 0);
      reg7 : std_logic_vector(WB_DW-1 downto 0);
      reg8 : std_logic_vector(WB_DW-1 downto 0);
      reg9 : std_logic_vector(WB_DW-1 downto 0);
      reg10 : std_logic_vector(WB_DW-1 downto 0);
      reg11 : std_logic_vector(WB_DW-1 downto 0);
      reg12 : std_logic_vector(WB_DW-1 downto 0);
      reg13 : std_logic_vector(WB_DW-1 downto 0);
      reg14 : std_logic_vector(WB_DW-1 downto 0);
      reg15 : std_logic_vector(WB_DW-1 downto 0);
      reg16 : std_logic_vector(WB_DW-1 downto 0);
      reg17 : std_logic_vector(WB_DW-1 downto 0);
      reg18 : std_logic_vector(WB_DW-1 downto 0);
      reg19 : std_logic_vector(WB_DW-1 downto 0);
      reg20 : std_logic_vector(WB_DW-1 downto 0);
      reg21 : std_logic_vector(WB_DW-1 downto 0);
      reg22 : std_logic_vector(WB_DW-1 downto 0);
      reg23 : std_logic_vector(WB_DW-1 downto 0);
      reg24 : std_logic_vector(WB_DW-1 downto 0);
      reg25 : std_logic_vector(WB_DW-1 downto 0);
      reg26 : std_logic_vector(WB_DW-1 downto 0);
      reg27 : std_logic_vector(WB_DW-1 downto 0);
      reg28 : std_logic_vector(WB_DW-1 downto 0);
      reg29 : std_logic_vector(WB_DW-1 downto 0);
      reg30 : std_logic_vector(WB_DW-1 downto 0);
      reg31 : std_logic_vector(WB_DW-1 downto 0);
      reg32 : std_logic_vector(WB_DW-1 downto 0);
      reg33 : std_logic_vector(WB_DW-1 downto 0);
      reg34 : std_logic_vector(WB_DW-1 downto 0);
      reg35 : std_logic_vector(WB_DW-1 downto 0);
      reg36 : std_logic_vector(WB_DW-1 downto 0);
      reg37 : std_logic_vector(WB_DW-1 downto 0);
      reg38 : std_logic_vector(WB_DW-1 downto 0);
      reg39 : std_logic_vector(WB_DW-1 downto 0);
      reg40 : std_logic_vector(WB_DW-1 downto 0);
      reg41 : std_logic_vector(WB_DW-1 downto 0);
      reg42 : std_logic_vector(WB_DW-1 downto 0);
      reg43 : std_logic_vector(WB_DW-1 downto 0);
      reg44 : std_logic_vector(WB_DW-1 downto 0);
      reg45 : std_logic_vector(WB_DW-1 downto 0);
      reg46 : std_logic_vector(WB_DW-1 downto 0);
      reg47 : std_logic_vector(WB_DW-1 downto 0);
      reg48 : std_logic_vector(WB_DW-1 downto 0);
      reg49 : std_logic_vector(WB_DW-1 downto 0);
      reg50 : std_logic_vector(WB_DW-1 downto 0);
      reg51 : std_logic_vector(WB_DW-1 downto 0);
      reg52 : std_logic_vector(WB_DW-1 downto 0);
      reg53 : std_logic_vector(WB_DW-1 downto 0);
      reg54 : std_logic_vector(WB_DW-1 downto 0);
      reg55 : std_logic_vector(WB_DW-1 downto 0);
      reg56 : std_logic_vector(WB_DW-1 downto 0);
      reg57 : std_logic_vector(WB_DW-1 downto 0);
      reg58 : std_logic_vector(WB_DW-1 downto 0);
      reg59 : std_logic_vector(WB_DW-1 downto 0);
      reg60 : std_logic_vector(WB_DW-1 downto 0);
      reg61 : std_logic_vector(WB_DW-1 downto 0);
      reg62 : std_logic_vector(WB_DW-1 downto 0);
      reg63 : std_logic_vector(WB_DW-1 downto 0);
      reg64 : std_logic_vector(WB_DW-1 downto 0);
      reg65 : std_logic_vector(WB_DW-1 downto 0);
      reg66 : std_logic_vector(WB_DW-1 downto 0);
      reg67 : std_logic_vector(WB_DW-1 downto 0);
      reg68 : std_logic_vector(WB_DW-1 downto 0);
      reg69 : std_logic_vector(WB_DW-1 downto 0);
      reg70 : std_logic_vector(WB_DW-1 downto 0);
      reg71 : std_logic_vector(WB_DW-1 downto 0);
      reg72 : std_logic_vector(WB_DW-1 downto 0);
      reg73 : std_logic_vector(WB_DW-1 downto 0);
      reg74 : std_logic_vector(WB_DW-1 downto 0);
      reg75 : std_logic_vector(WB_DW-1 downto 0);
      reg76 : std_logic_vector(WB_DW-1 downto 0);
      reg77 : std_logic_vector(WB_DW-1 downto 0);
      reg78 : std_logic_vector(WB_DW-1 downto 0);
      reg79 : std_logic_vector(WB_DW-1 downto 0);
      reg80 : std_logic_vector(WB_DW-1 downto 0);
      reg81 : std_logic_vector(WB_DW-1 downto 0);
      reg82 : std_logic_vector(WB_DW-1 downto 0);
      reg83 : std_logic_vector(WB_DW-1 downto 0);
      reg84 : std_logic_vector(WB_DW-1 downto 0);
      reg85 : std_logic_vector(WB_DW-1 downto 0);
      reg86 : std_logic_vector(WB_DW-1 downto 0);
      reg87 : std_logic_vector(WB_DW-1 downto 0);
      reg88 : std_logic_vector(WB_DW-1 downto 0);
      reg89 : std_logic_vector(WB_DW-1 downto 0);
      reg90 : std_logic_vector(WB_DW-1 downto 0);
      reg91 : std_logic_vector(WB_DW-1 downto 0);
      reg92 : std_logic_vector(WB_DW-1 downto 0);
      reg93 : std_logic_vector(WB_DW-1 downto 0);
      reg94 : std_logic_vector(WB_DW-1 downto 0);
      reg95 : std_logic_vector(WB_DW-1 downto 0);
      reg96 : std_logic_vector(WB_DW-1 downto 0);
      reg97 : std_logic_vector(WB_DW-1 downto 0);
      reg98 : std_logic_vector(WB_DW-1 downto 0);
      reg99 : std_logic_vector(WB_DW-1 downto 0);
      reg100 : std_logic_vector(WB_DW-1 downto 0);
      reg101 : std_logic_vector(WB_DW-1 downto 0);
      reg102 : std_logic_vector(WB_DW-1 downto 0);
      reg103 : std_logic_vector(WB_DW-1 downto 0);
      reg104 : std_logic_vector(WB_DW-1 downto 0);
      reg105 : std_logic_vector(WB_DW-1 downto 0);
      reg106 : std_logic_vector(WB_DW-1 downto 0);
      reg107 : std_logic_vector(WB_DW-1 downto 0);
      reg108 : std_logic_vector(WB_DW-1 downto 0);
      reg109 : std_logic_vector(WB_DW-1 downto 0);
      reg110 : std_logic_vector(WB_DW-1 downto 0);
      reg111 : std_logic_vector(WB_DW-1 downto 0);
      reg112 : std_logic_vector(WB_DW-1 downto 0);
      reg113 : std_logic_vector(WB_DW-1 downto 0);
      reg114 : std_logic_vector(WB_DW-1 downto 0);
      reg115 : std_logic_vector(WB_DW-1 downto 0);
      reg116 : std_logic_vector(WB_DW-1 downto 0);
      reg117 : std_logic_vector(WB_DW-1 downto 0);
      reg118 : std_logic_vector(WB_DW-1 downto 0);
      reg119 : std_logic_vector(WB_DW-1 downto 0);
      reg120 : std_logic_vector(WB_DW-1 downto 0);
      reg121 : std_logic_vector(WB_DW-1 downto 0);
      reg122 : std_logic_vector(WB_DW-1 downto 0);
      reg123 : std_logic_vector(WB_DW-1 downto 0);
      reg124 : std_logic_vector(WB_DW-1 downto 0);
      reg125 : std_logic_vector(WB_DW-1 downto 0);
      reg126 : std_logic_vector(WB_DW-1 downto 0);
      reg127 : std_logic_vector(WB_DW-1 downto 0);
      reg128 : std_logic_vector(WB_DW-1 downto 0);
      reg129 : std_logic_vector(WB_DW-1 downto 0);
      reg130 : std_logic_vector(WB_DW-1 downto 0);
      reg131 : std_logic_vector(WB_DW-1 downto 0);
      reg132 : std_logic_vector(WB_DW-1 downto 0);
      reg133 : std_logic_vector(WB_DW-1 downto 0);
      reg134 : std_logic_vector(WB_DW-1 downto 0);
      reg135 : std_logic_vector(WB_DW-1 downto 0);
      reg136 : std_logic_vector(WB_DW-1 downto 0);
      reg137 : std_logic_vector(WB_DW-1 downto 0);
      reg138 : std_logic_vector(WB_DW-1 downto 0);
      reg139 : std_logic_vector(WB_DW-1 downto 0);
      reg140 : std_logic_vector(WB_DW-1 downto 0);
      reg141 : std_logic_vector(WB_DW-1 downto 0);
      reg142 : std_logic_vector(WB_DW-1 downto 0);
      reg143 : std_logic_vector(WB_DW-1 downto 0);
      reg144 : std_logic_vector(WB_DW-1 downto 0);
      reg145 : std_logic_vector(WB_DW-1 downto 0);
      reg146 : std_logic_vector(WB_DW-1 downto 0);
      reg147 : std_logic_vector(WB_DW-1 downto 0);
      reg148 : std_logic_vector(WB_DW-1 downto 0);
      reg149 : std_logic_vector(WB_DW-1 downto 0);
      reg150 : std_logic_vector(WB_DW-1 downto 0);
      reg151 : std_logic_vector(WB_DW-1 downto 0);
      reg152 : std_logic_vector(WB_DW-1 downto 0);
      reg153 : std_logic_vector(WB_DW-1 downto 0);
      reg154 : std_logic_vector(WB_DW-1 downto 0);
      reg155 : std_logic_vector(WB_DW-1 downto 0);
      reg156 : std_logic_vector(WB_DW-1 downto 0);
      reg157 : std_logic_vector(WB_DW-1 downto 0);
      reg158 : std_logic_vector(WB_DW-1 downto 0);
      reg159 : std_logic_vector(WB_DW-1 downto 0);
      reg160 : std_logic_vector(WB_DW-1 downto 0);
      reg161 : std_logic_vector(WB_DW-1 downto 0);
      reg162 : std_logic_vector(WB_DW-1 downto 0);
      reg163 : std_logic_vector(WB_DW-1 downto 0);
      reg164 : std_logic_vector(WB_DW-1 downto 0);
      reg165 : std_logic_vector(WB_DW-1 downto 0);
      reg166 : std_logic_vector(WB_DW-1 downto 0);
      reg167 : std_logic_vector(WB_DW-1 downto 0);
      reg168 : std_logic_vector(WB_DW-1 downto 0);
      reg169 : std_logic_vector(WB_DW-1 downto 0);
      reg170 : std_logic_vector(WB_DW-1 downto 0);
      reg171 : std_logic_vector(WB_DW-1 downto 0);
      reg172 : std_logic_vector(WB_DW-1 downto 0);
      reg173 : std_logic_vector(WB_DW-1 downto 0);
      reg174 : std_logic_vector(WB_DW-1 downto 0);
      reg175 : std_logic_vector(WB_DW-1 downto 0);
      reg176 : std_logic_vector(WB_DW-1 downto 0);
      reg177 : std_logic_vector(WB_DW-1 downto 0);
      reg178 : std_logic_vector(WB_DW-1 downto 0);
      reg179 : std_logic_vector(WB_DW-1 downto 0);
      reg180 : std_logic_vector(WB_DW-1 downto 0);
      reg181 : std_logic_vector(WB_DW-1 downto 0);
      reg182 : std_logic_vector(WB_DW-1 downto 0);
      reg183 : std_logic_vector(WB_DW-1 downto 0);
      reg184 : std_logic_vector(WB_DW-1 downto 0);
      reg185 : std_logic_vector(WB_DW-1 downto 0);
      reg186 : std_logic_vector(WB_DW-1 downto 0);
      reg187 : std_logic_vector(WB_DW-1 downto 0);
      reg188 : std_logic_vector(WB_DW-1 downto 0);
      reg189 : std_logic_vector(WB_DW-1 downto 0);
      reg190 : std_logic_vector(WB_DW-1 downto 0);
      reg191 : std_logic_vector(WB_DW-1 downto 0);
      reg192 : std_logic_vector(WB_DW-1 downto 0);
      reg193 : std_logic_vector(WB_DW-1 downto 0);
      reg194 : std_logic_vector(WB_DW-1 downto 0);
      reg195 : std_logic_vector(WB_DW-1 downto 0);
      reg196 : std_logic_vector(WB_DW-1 downto 0);
      reg197 : std_logic_vector(WB_DW-1 downto 0);
      reg198 : std_logic_vector(WB_DW-1 downto 0);
      reg199 : std_logic_vector(WB_DW-1 downto 0);
      reg200 : std_logic_vector(WB_DW-1 downto 0);
      reg201 : std_logic_vector(WB_DW-1 downto 0);
      reg202 : std_logic_vector(WB_DW-1 downto 0);
      reg203 : std_logic_vector(WB_DW-1 downto 0);
      reg204 : std_logic_vector(WB_DW-1 downto 0);
      reg205 : std_logic_vector(WB_DW-1 downto 0);
      reg206 : std_logic_vector(WB_DW-1 downto 0);
      reg207 : std_logic_vector(WB_DW-1 downto 0);
      reg208 : std_logic_vector(WB_DW-1 downto 0);
      reg209 : std_logic_vector(WB_DW-1 downto 0);
      reg210 : std_logic_vector(WB_DW-1 downto 0);
      reg211 : std_logic_vector(WB_DW-1 downto 0);
      reg212 : std_logic_vector(WB_DW-1 downto 0);
      reg213 : std_logic_vector(WB_DW-1 downto 0);
      reg214 : std_logic_vector(WB_DW-1 downto 0);
      reg215 : std_logic_vector(WB_DW-1 downto 0);
      reg216 : std_logic_vector(WB_DW-1 downto 0);
      reg217 : std_logic_vector(WB_DW-1 downto 0);
      reg218 : std_logic_vector(WB_DW-1 downto 0);
      reg219 : std_logic_vector(WB_DW-1 downto 0);
      reg220 : std_logic_vector(WB_DW-1 downto 0);
      reg221 : std_logic_vector(WB_DW-1 downto 0);
      reg222 : std_logic_vector(WB_DW-1 downto 0);
      reg223 : std_logic_vector(WB_DW-1 downto 0);
      reg224 : std_logic_vector(WB_DW-1 downto 0);
      reg225 : std_logic_vector(WB_DW-1 downto 0);
      reg226 : std_logic_vector(WB_DW-1 downto 0);
      reg227 : std_logic_vector(WB_DW-1 downto 0);
      reg228 : std_logic_vector(WB_DW-1 downto 0);
      reg229 : std_logic_vector(WB_DW-1 downto 0);
      reg230 : std_logic_vector(WB_DW-1 downto 0);
      reg231 : std_logic_vector(WB_DW-1 downto 0);
      reg232 : std_logic_vector(WB_DW-1 downto 0);
      reg233 : std_logic_vector(WB_DW-1 downto 0);
      reg234 : std_logic_vector(WB_DW-1 downto 0);
      reg235 : std_logic_vector(WB_DW-1 downto 0);
      reg236 : std_logic_vector(WB_DW-1 downto 0);
      reg237 : std_logic_vector(WB_DW-1 downto 0);
      reg238 : std_logic_vector(WB_DW-1 downto 0);
      reg239 : std_logic_vector(WB_DW-1 downto 0);
      reg240 : std_logic_vector(WB_DW-1 downto 0);
      reg241 : std_logic_vector(WB_DW-1 downto 0);
      reg242 : std_logic_vector(WB_DW-1 downto 0);
      reg243 : std_logic_vector(WB_DW-1 downto 0);
      reg244 : std_logic_vector(WB_DW-1 downto 0);
      reg245 : std_logic_vector(WB_DW-1 downto 0);
      reg246 : std_logic_vector(WB_DW-1 downto 0);
      reg247 : std_logic_vector(WB_DW-1 downto 0);
      reg248 : std_logic_vector(WB_DW-1 downto 0);
      reg249 : std_logic_vector(WB_DW-1 downto 0);
      reg250 : std_logic_vector(WB_DW-1 downto 0);
      reg251 : std_logic_vector(WB_DW-1 downto 0);
      reg252 : std_logic_vector(WB_DW-1 downto 0);
      reg253 : std_logic_vector(WB_DW-1 downto 0);
      reg254 : std_logic_vector(WB_DW-1 downto 0);
      reg255 : std_logic_vector(WB_DW-1 downto 0);
   end record;

   component wbs256
      port (
         -- register outputs
         reg0_out : out std_logic_vector(WB_DW-1 downto 0);
         reg1_out : out std_logic_vector(WB_DW-1 downto 0);
         reg2_out : out std_logic_vector(WB_DW-1 downto 0);
         reg3_out : out std_logic_vector(WB_DW-1 downto 0);
         reg4_out : out std_logic_vector(WB_DW-1 downto 0);
         reg5_out : out std_logic_vector(WB_DW-1 downto 0);
         reg6_out : out std_logic_vector(WB_DW-1 downto 0);
         reg7_out : out std_logic_vector(WB_DW-1 downto 0);
         reg8_out : out std_logic_vector(WB_DW-1 downto 0);
         reg9_out : out std_logic_vector(WB_DW-1 downto 0);
         reg10_out : out std_logic_vector(WB_DW-1 downto 0);
         reg11_out : out std_logic_vector(WB_DW-1 downto 0);
         reg12_out : out std_logic_vector(WB_DW-1 downto 0);
         reg13_out : out std_logic_vector(WB_DW-1 downto 0);
         reg14_out : out std_logic_vector(WB_DW-1 downto 0);
         reg15_out : out std_logic_vector(WB_DW-1 downto 0);
         reg16_out : out std_logic_vector(WB_DW-1 downto 0);
         reg17_out : out std_logic_vector(WB_DW-1 downto 0);
         reg18_out : out std_logic_vector(WB_DW-1 downto 0);
         reg19_out : out std_logic_vector(WB_DW-1 downto 0);
         reg20_out : out std_logic_vector(WB_DW-1 downto 0);
         reg21_out : out std_logic_vector(WB_DW-1 downto 0);
         reg22_out : out std_logic_vector(WB_DW-1 downto 0);
         reg23_out : out std_logic_vector(WB_DW-1 downto 0);
         reg24_out : out std_logic_vector(WB_DW-1 downto 0);
         reg25_out : out std_logic_vector(WB_DW-1 downto 0);
         reg26_out : out std_logic_vector(WB_DW-1 downto 0);
         reg27_out : out std_logic_vector(WB_DW-1 downto 0);
         reg28_out : out std_logic_vector(WB_DW-1 downto 0);
         reg29_out : out std_logic_vector(WB_DW-1 downto 0);
         reg30_out : out std_logic_vector(WB_DW-1 downto 0);
         reg31_out : out std_logic_vector(WB_DW-1 downto 0);
         reg32_out : out std_logic_vector(WB_DW-1 downto 0);
         reg33_out : out std_logic_vector(WB_DW-1 downto 0);
         reg34_out : out std_logic_vector(WB_DW-1 downto 0);
         reg35_out : out std_logic_vector(WB_DW-1 downto 0);
         reg36_out : out std_logic_vector(WB_DW-1 downto 0);
         reg37_out : out std_logic_vector(WB_DW-1 downto 0);
         reg38_out : out std_logic_vector(WB_DW-1 downto 0);
         reg39_out : out std_logic_vector(WB_DW-1 downto 0);
         reg40_out : out std_logic_vector(WB_DW-1 downto 0);
         reg41_out : out std_logic_vector(WB_DW-1 downto 0);
         reg42_out : out std_logic_vector(WB_DW-1 downto 0);
         reg43_out : out std_logic_vector(WB_DW-1 downto 0);
         reg44_out : out std_logic_vector(WB_DW-1 downto 0);
         reg45_out : out std_logic_vector(WB_DW-1 downto 0);
         reg46_out : out std_logic_vector(WB_DW-1 downto 0);
         reg47_out : out std_logic_vector(WB_DW-1 downto 0);
         reg48_out : out std_logic_vector(WB_DW-1 downto 0);
         reg49_out : out std_logic_vector(WB_DW-1 downto 0);
         reg50_out : out std_logic_vector(WB_DW-1 downto 0);
         reg51_out : out std_logic_vector(WB_DW-1 downto 0);
         reg52_out : out std_logic_vector(WB_DW-1 downto 0);
         reg53_out : out std_logic_vector(WB_DW-1 downto 0);
         reg54_out : out std_logic_vector(WB_DW-1 downto 0);
         reg55_out : out std_logic_vector(WB_DW-1 downto 0);
         reg56_out : out std_logic_vector(WB_DW-1 downto 0);
         reg57_out : out std_logic_vector(WB_DW-1 downto 0);
         reg58_out : out std_logic_vector(WB_DW-1 downto 0);
         reg59_out : out std_logic_vector(WB_DW-1 downto 0);
         reg60_out : out std_logic_vector(WB_DW-1 downto 0);
         reg61_out : out std_logic_vector(WB_DW-1 downto 0);
         reg62_out : out std_logic_vector(WB_DW-1 downto 0);
         reg63_out : out std_logic_vector(WB_DW-1 downto 0);
         reg64_out : out std_logic_vector(WB_DW-1 downto 0);
         reg65_out : out std_logic_vector(WB_DW-1 downto 0);
         reg66_out : out std_logic_vector(WB_DW-1 downto 0);
         reg67_out : out std_logic_vector(WB_DW-1 downto 0);
         reg68_out : out std_logic_vector(WB_DW-1 downto 0);
         reg69_out : out std_logic_vector(WB_DW-1 downto 0);
         reg70_out : out std_logic_vector(WB_DW-1 downto 0);
         reg71_out : out std_logic_vector(WB_DW-1 downto 0);
         reg72_out : out std_logic_vector(WB_DW-1 downto 0);
         reg73_out : out std_logic_vector(WB_DW-1 downto 0);
         reg74_out : out std_logic_vector(WB_DW-1 downto 0);
         reg75_out : out std_logic_vector(WB_DW-1 downto 0);
         reg76_out : out std_logic_vector(WB_DW-1 downto 0);
         reg77_out : out std_logic_vector(WB_DW-1 downto 0);
         reg78_out : out std_logic_vector(WB_DW-1 downto 0);
         reg79_out : out std_logic_vector(WB_DW-1 downto 0);
         reg80_out : out std_logic_vector(WB_DW-1 downto 0);
         reg81_out : out std_logic_vector(WB_DW-1 downto 0);
         reg82_out : out std_logic_vector(WB_DW-1 downto 0);
         reg83_out : out std_logic_vector(WB_DW-1 downto 0);
         reg84_out : out std_logic_vector(WB_DW-1 downto 0);
         reg85_out : out std_logic_vector(WB_DW-1 downto 0);
         reg86_out : out std_logic_vector(WB_DW-1 downto 0);
         reg87_out : out std_logic_vector(WB_DW-1 downto 0);
         reg88_out : out std_logic_vector(WB_DW-1 downto 0);
         reg89_out : out std_logic_vector(WB_DW-1 downto 0);
         reg90_out : out std_logic_vector(WB_DW-1 downto 0);
         reg91_out : out std_logic_vector(WB_DW-1 downto 0);
         reg92_out : out std_logic_vector(WB_DW-1 downto 0);
         reg93_out : out std_logic_vector(WB_DW-1 downto 0);
         reg94_out : out std_logic_vector(WB_DW-1 downto 0);
         reg95_out : out std_logic_vector(WB_DW-1 downto 0);
         reg96_out : out std_logic_vector(WB_DW-1 downto 0);
         reg97_out : out std_logic_vector(WB_DW-1 downto 0);
         reg98_out : out std_logic_vector(WB_DW-1 downto 0);
         reg99_out : out std_logic_vector(WB_DW-1 downto 0);
         reg100_out : out std_logic_vector(WB_DW-1 downto 0);
         reg101_out : out std_logic_vector(WB_DW-1 downto 0);
         reg102_out : out std_logic_vector(WB_DW-1 downto 0);
         reg103_out : out std_logic_vector(WB_DW-1 downto 0);
         reg104_out : out std_logic_vector(WB_DW-1 downto 0);
         reg105_out : out std_logic_vector(WB_DW-1 downto 0);
         reg106_out : out std_logic_vector(WB_DW-1 downto 0);
         reg107_out : out std_logic_vector(WB_DW-1 downto 0);
         reg108_out : out std_logic_vector(WB_DW-1 downto 0);
         reg109_out : out std_logic_vector(WB_DW-1 downto 0);
         reg110_out : out std_logic_vector(WB_DW-1 downto 0);
         reg111_out : out std_logic_vector(WB_DW-1 downto 0);
         reg112_out : out std_logic_vector(WB_DW-1 downto 0);
         reg113_out : out std_logic_vector(WB_DW-1 downto 0);
         reg114_out : out std_logic_vector(WB_DW-1 downto 0);
         reg115_out : out std_logic_vector(WB_DW-1 downto 0);
         reg116_out : out std_logic_vector(WB_DW-1 downto 0);
         reg117_out : out std_logic_vector(WB_DW-1 downto 0);
         reg118_out : out std_logic_vector(WB_DW-1 downto 0);
         reg119_out : out std_logic_vector(WB_DW-1 downto 0);
         reg120_out : out std_logic_vector(WB_DW-1 downto 0);
         reg121_out : out std_logic_vector(WB_DW-1 downto 0);
         reg122_out : out std_logic_vector(WB_DW-1 downto 0);
         reg123_out : out std_logic_vector(WB_DW-1 downto 0);
         reg124_out : out std_logic_vector(WB_DW-1 downto 0);
         reg125_out : out std_logic_vector(WB_DW-1 downto 0);
         reg126_out : out std_logic_vector(WB_DW-1 downto 0);
         reg127_out : out std_logic_vector(WB_DW-1 downto 0);
         reg128_out : out std_logic_vector(WB_DW-1 downto 0);
         reg129_out : out std_logic_vector(WB_DW-1 downto 0);
         reg130_out : out std_logic_vector(WB_DW-1 downto 0);
         reg131_out : out std_logic_vector(WB_DW-1 downto 0);
         reg132_out : out std_logic_vector(WB_DW-1 downto 0);
         reg133_out : out std_logic_vector(WB_DW-1 downto 0);
         reg134_out : out std_logic_vector(WB_DW-1 downto 0);
         reg135_out : out std_logic_vector(WB_DW-1 downto 0);
         reg136_out : out std_logic_vector(WB_DW-1 downto 0);
         reg137_out : out std_logic_vector(WB_DW-1 downto 0);
         reg138_out : out std_logic_vector(WB_DW-1 downto 0);
         reg139_out : out std_logic_vector(WB_DW-1 downto 0);
         reg140_out : out std_logic_vector(WB_DW-1 downto 0);
         reg141_out : out std_logic_vector(WB_DW-1 downto 0);
         reg142_out : out std_logic_vector(WB_DW-1 downto 0);
         reg143_out : out std_logic_vector(WB_DW-1 downto 0);
         reg144_out : out std_logic_vector(WB_DW-1 downto 0);
         reg145_out : out std_logic_vector(WB_DW-1 downto 0);
         reg146_out : out std_logic_vector(WB_DW-1 downto 0);
         reg147_out : out std_logic_vector(WB_DW-1 downto 0);
         reg148_out : out std_logic_vector(WB_DW-1 downto 0);
         reg149_out : out std_logic_vector(WB_DW-1 downto 0);
         reg150_out : out std_logic_vector(WB_DW-1 downto 0);
         reg151_out : out std_logic_vector(WB_DW-1 downto 0);
         reg152_out : out std_logic_vector(WB_DW-1 downto 0);
         reg153_out : out std_logic_vector(WB_DW-1 downto 0);
         reg154_out : out std_logic_vector(WB_DW-1 downto 0);
         reg155_out : out std_logic_vector(WB_DW-1 downto 0);
         reg156_out : out std_logic_vector(WB_DW-1 downto 0);
         reg157_out : out std_logic_vector(WB_DW-1 downto 0);
         reg158_out : out std_logic_vector(WB_DW-1 downto 0);
         reg159_out : out std_logic_vector(WB_DW-1 downto 0);
         reg160_out : out std_logic_vector(WB_DW-1 downto 0);
         reg161_out : out std_logic_vector(WB_DW-1 downto 0);
         reg162_out : out std_logic_vector(WB_DW-1 downto 0);
         reg163_out : out std_logic_vector(WB_DW-1 downto 0);
         reg164_out : out std_logic_vector(WB_DW-1 downto 0);
         reg165_out : out std_logic_vector(WB_DW-1 downto 0);
         reg166_out : out std_logic_vector(WB_DW-1 downto 0);
         reg167_out : out std_logic_vector(WB_DW-1 downto 0);
         reg168_out : out std_logic_vector(WB_DW-1 downto 0);
         reg169_out : out std_logic_vector(WB_DW-1 downto 0);
         reg170_out : out std_logic_vector(WB_DW-1 downto 0);
         reg171_out : out std_logic_vector(WB_DW-1 downto 0);
         reg172_out : out std_logic_vector(WB_DW-1 downto 0);
         reg173_out : out std_logic_vector(WB_DW-1 downto 0);
         reg174_out : out std_logic_vector(WB_DW-1 downto 0);
         reg175_out : out std_logic_vector(WB_DW-1 downto 0);
         reg176_out : out std_logic_vector(WB_DW-1 downto 0);
         reg177_out : out std_logic_vector(WB_DW-1 downto 0);
         reg178_out : out std_logic_vector(WB_DW-1 downto 0);
         reg179_out : out std_logic_vector(WB_DW-1 downto 0);
         reg180_out : out std_logic_vector(WB_DW-1 downto 0);
         reg181_out : out std_logic_vector(WB_DW-1 downto 0);
         reg182_out : out std_logic_vector(WB_DW-1 downto 0);
         reg183_out : out std_logic_vector(WB_DW-1 downto 0);
         reg184_out : out std_logic_vector(WB_DW-1 downto 0);
         reg185_out : out std_logic_vector(WB_DW-1 downto 0);
         reg186_out : out std_logic_vector(WB_DW-1 downto 0);
         reg187_out : out std_logic_vector(WB_DW-1 downto 0);
         reg188_out : out std_logic_vector(WB_DW-1 downto 0);
         reg189_out : out std_logic_vector(WB_DW-1 downto 0);
         reg190_out : out std_logic_vector(WB_DW-1 downto 0);
         reg191_out : out std_logic_vector(WB_DW-1 downto 0);
         reg192_out : out std_logic_vector(WB_DW-1 downto 0);
         reg193_out : out std_logic_vector(WB_DW-1 downto 0);
         reg194_out : out std_logic_vector(WB_DW-1 downto 0);
         reg195_out : out std_logic_vector(WB_DW-1 downto 0);
         reg196_out : out std_logic_vector(WB_DW-1 downto 0);
         reg197_out : out std_logic_vector(WB_DW-1 downto 0);
         reg198_out : out std_logic_vector(WB_DW-1 downto 0);
         reg199_out : out std_logic_vector(WB_DW-1 downto 0);
         reg200_out : out std_logic_vector(WB_DW-1 downto 0);
         reg201_out : out std_logic_vector(WB_DW-1 downto 0);
         reg202_out : out std_logic_vector(WB_DW-1 downto 0);
         reg203_out : out std_logic_vector(WB_DW-1 downto 0);
         reg204_out : out std_logic_vector(WB_DW-1 downto 0);
         reg205_out : out std_logic_vector(WB_DW-1 downto 0);
         reg206_out : out std_logic_vector(WB_DW-1 downto 0);
         reg207_out : out std_logic_vector(WB_DW-1 downto 0);
         reg208_out : out std_logic_vector(WB_DW-1 downto 0);
         reg209_out : out std_logic_vector(WB_DW-1 downto 0);
         reg210_out : out std_logic_vector(WB_DW-1 downto 0);
         reg211_out : out std_logic_vector(WB_DW-1 downto 0);
         reg212_out : out std_logic_vector(WB_DW-1 downto 0);
         reg213_out : out std_logic_vector(WB_DW-1 downto 0);
         reg214_out : out std_logic_vector(WB_DW-1 downto 0);
         reg215_out : out std_logic_vector(WB_DW-1 downto 0);
         reg216_out : out std_logic_vector(WB_DW-1 downto 0);
         reg217_out : out std_logic_vector(WB_DW-1 downto 0);
         reg218_out : out std_logic_vector(WB_DW-1 downto 0);
         reg219_out : out std_logic_vector(WB_DW-1 downto 0);
         reg220_out : out std_logic_vector(WB_DW-1 downto 0);
         reg221_out : out std_logic_vector(WB_DW-1 downto 0);
         reg222_out : out std_logic_vector(WB_DW-1 downto 0);
         reg223_out : out std_logic_vector(WB_DW-1 downto 0);
         reg224_out : out std_logic_vector(WB_DW-1 downto 0);
         reg225_out : out std_logic_vector(WB_DW-1 downto 0);
         reg226_out : out std_logic_vector(WB_DW-1 downto 0);
         reg227_out : out std_logic_vector(WB_DW-1 downto 0);
         reg228_out : out std_logic_vector(WB_DW-1 downto 0);
         reg229_out : out std_logic_vector(WB_DW-1 downto 0);
         reg230_out : out std_logic_vector(WB_DW-1 downto 0);
         reg231_out : out std_logic_vector(WB_DW-1 downto 0);
         reg232_out : out std_logic_vector(WB_DW-1 downto 0);
         reg233_out : out std_logic_vector(WB_DW-1 downto 0);
         reg234_out : out std_logic_vector(WB_DW-1 downto 0);
         reg235_out : out std_logic_vector(WB_DW-1 downto 0);
         reg236_out : out std_logic_vector(WB_DW-1 downto 0);
         reg237_out : out std_logic_vector(WB_DW-1 downto 0);
         reg238_out : out std_logic_vector(WB_DW-1 downto 0);
         reg239_out : out std_logic_vector(WB_DW-1 downto 0);
         reg240_out : out std_logic_vector(WB_DW-1 downto 0);
         reg241_out : out std_logic_vector(WB_DW-1 downto 0);
         reg242_out : out std_logic_vector(WB_DW-1 downto 0);
         reg243_out : out std_logic_vector(WB_DW-1 downto 0);
         reg244_out : out std_logic_vector(WB_DW-1 downto 0);
         reg245_out : out std_logic_vector(WB_DW-1 downto 0);
         reg246_out : out std_logic_vector(WB_DW-1 downto 0);
         reg247_out : out std_logic_vector(WB_DW-1 downto 0);
         reg248_out : out std_logic_vector(WB_DW-1 downto 0);
         reg249_out : out std_logic_vector(WB_DW-1 downto 0);
         reg250_out : out std_logic_vector(WB_DW-1 downto 0);
         reg251_out : out std_logic_vector(WB_DW-1 downto 0);
         reg252_out : out std_logic_vector(WB_DW-1 downto 0);
         reg253_out : out std_logic_vector(WB_DW-1 downto 0);
         reg254_out : out std_logic_vector(WB_DW-1 downto 0);
         reg255_out : out std_logic_vector(WB_DW-1 downto 0);

         -- wishbone interface
         wbs_in   : in  wbs_in_type;
         wbs_out  : out wbs_out_type
      );
   end component;

end package;

--===========================================================================--
-- Entity
--===========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;
use work.package_wbs256.all;

-------------------------------------------------------------------------------
entity wbs256 is
-------------------------------------------------------------------------------
   port (
         -- register outputs
         reg0_out : out std_logic_vector(WB_DW-1 downto 0);
         reg1_out : out std_logic_vector(WB_DW-1 downto 0);
         reg2_out : out std_logic_vector(WB_DW-1 downto 0);
         reg3_out : out std_logic_vector(WB_DW-1 downto 0);
         reg4_out : out std_logic_vector(WB_DW-1 downto 0);
         reg5_out : out std_logic_vector(WB_DW-1 downto 0);
         reg6_out : out std_logic_vector(WB_DW-1 downto 0);
         reg7_out : out std_logic_vector(WB_DW-1 downto 0);
         reg8_out : out std_logic_vector(WB_DW-1 downto 0);
         reg9_out : out std_logic_vector(WB_DW-1 downto 0);
         reg10_out : out std_logic_vector(WB_DW-1 downto 0);
         reg11_out : out std_logic_vector(WB_DW-1 downto 0);
         reg12_out : out std_logic_vector(WB_DW-1 downto 0);
         reg13_out : out std_logic_vector(WB_DW-1 downto 0);
         reg14_out : out std_logic_vector(WB_DW-1 downto 0);
         reg15_out : out std_logic_vector(WB_DW-1 downto 0);
         reg16_out : out std_logic_vector(WB_DW-1 downto 0);
         reg17_out : out std_logic_vector(WB_DW-1 downto 0);
         reg18_out : out std_logic_vector(WB_DW-1 downto 0);
         reg19_out : out std_logic_vector(WB_DW-1 downto 0);
         reg20_out : out std_logic_vector(WB_DW-1 downto 0);
         reg21_out : out std_logic_vector(WB_DW-1 downto 0);
         reg22_out : out std_logic_vector(WB_DW-1 downto 0);
         reg23_out : out std_logic_vector(WB_DW-1 downto 0);
         reg24_out : out std_logic_vector(WB_DW-1 downto 0);
         reg25_out : out std_logic_vector(WB_DW-1 downto 0);
         reg26_out : out std_logic_vector(WB_DW-1 downto 0);
         reg27_out : out std_logic_vector(WB_DW-1 downto 0);
         reg28_out : out std_logic_vector(WB_DW-1 downto 0);
         reg29_out : out std_logic_vector(WB_DW-1 downto 0);
         reg30_out : out std_logic_vector(WB_DW-1 downto 0);
         reg31_out : out std_logic_vector(WB_DW-1 downto 0);
         reg32_out : out std_logic_vector(WB_DW-1 downto 0);
         reg33_out : out std_logic_vector(WB_DW-1 downto 0);
         reg34_out : out std_logic_vector(WB_DW-1 downto 0);
         reg35_out : out std_logic_vector(WB_DW-1 downto 0);
         reg36_out : out std_logic_vector(WB_DW-1 downto 0);
         reg37_out : out std_logic_vector(WB_DW-1 downto 0);
         reg38_out : out std_logic_vector(WB_DW-1 downto 0);
         reg39_out : out std_logic_vector(WB_DW-1 downto 0);
         reg40_out : out std_logic_vector(WB_DW-1 downto 0);
         reg41_out : out std_logic_vector(WB_DW-1 downto 0);
         reg42_out : out std_logic_vector(WB_DW-1 downto 0);
         reg43_out : out std_logic_vector(WB_DW-1 downto 0);
         reg44_out : out std_logic_vector(WB_DW-1 downto 0);
         reg45_out : out std_logic_vector(WB_DW-1 downto 0);
         reg46_out : out std_logic_vector(WB_DW-1 downto 0);
         reg47_out : out std_logic_vector(WB_DW-1 downto 0);
         reg48_out : out std_logic_vector(WB_DW-1 downto 0);
         reg49_out : out std_logic_vector(WB_DW-1 downto 0);
         reg50_out : out std_logic_vector(WB_DW-1 downto 0);
         reg51_out : out std_logic_vector(WB_DW-1 downto 0);
         reg52_out : out std_logic_vector(WB_DW-1 downto 0);
         reg53_out : out std_logic_vector(WB_DW-1 downto 0);
         reg54_out : out std_logic_vector(WB_DW-1 downto 0);
         reg55_out : out std_logic_vector(WB_DW-1 downto 0);
         reg56_out : out std_logic_vector(WB_DW-1 downto 0);
         reg57_out : out std_logic_vector(WB_DW-1 downto 0);
         reg58_out : out std_logic_vector(WB_DW-1 downto 0);
         reg59_out : out std_logic_vector(WB_DW-1 downto 0);
         reg60_out : out std_logic_vector(WB_DW-1 downto 0);
         reg61_out : out std_logic_vector(WB_DW-1 downto 0);
         reg62_out : out std_logic_vector(WB_DW-1 downto 0);
         reg63_out : out std_logic_vector(WB_DW-1 downto 0);
         reg64_out : out std_logic_vector(WB_DW-1 downto 0);
         reg65_out : out std_logic_vector(WB_DW-1 downto 0);
         reg66_out : out std_logic_vector(WB_DW-1 downto 0);
         reg67_out : out std_logic_vector(WB_DW-1 downto 0);
         reg68_out : out std_logic_vector(WB_DW-1 downto 0);
         reg69_out : out std_logic_vector(WB_DW-1 downto 0);
         reg70_out : out std_logic_vector(WB_DW-1 downto 0);
         reg71_out : out std_logic_vector(WB_DW-1 downto 0);
         reg72_out : out std_logic_vector(WB_DW-1 downto 0);
         reg73_out : out std_logic_vector(WB_DW-1 downto 0);
         reg74_out : out std_logic_vector(WB_DW-1 downto 0);
         reg75_out : out std_logic_vector(WB_DW-1 downto 0);
         reg76_out : out std_logic_vector(WB_DW-1 downto 0);
         reg77_out : out std_logic_vector(WB_DW-1 downto 0);
         reg78_out : out std_logic_vector(WB_DW-1 downto 0);
         reg79_out : out std_logic_vector(WB_DW-1 downto 0);
         reg80_out : out std_logic_vector(WB_DW-1 downto 0);
         reg81_out : out std_logic_vector(WB_DW-1 downto 0);
         reg82_out : out std_logic_vector(WB_DW-1 downto 0);
         reg83_out : out std_logic_vector(WB_DW-1 downto 0);
         reg84_out : out std_logic_vector(WB_DW-1 downto 0);
         reg85_out : out std_logic_vector(WB_DW-1 downto 0);
         reg86_out : out std_logic_vector(WB_DW-1 downto 0);
         reg87_out : out std_logic_vector(WB_DW-1 downto 0);
         reg88_out : out std_logic_vector(WB_DW-1 downto 0);
         reg89_out : out std_logic_vector(WB_DW-1 downto 0);
         reg90_out : out std_logic_vector(WB_DW-1 downto 0);
         reg91_out : out std_logic_vector(WB_DW-1 downto 0);
         reg92_out : out std_logic_vector(WB_DW-1 downto 0);
         reg93_out : out std_logic_vector(WB_DW-1 downto 0);
         reg94_out : out std_logic_vector(WB_DW-1 downto 0);
         reg95_out : out std_logic_vector(WB_DW-1 downto 0);
         reg96_out : out std_logic_vector(WB_DW-1 downto 0);
         reg97_out : out std_logic_vector(WB_DW-1 downto 0);
         reg98_out : out std_logic_vector(WB_DW-1 downto 0);
         reg99_out : out std_logic_vector(WB_DW-1 downto 0);
         reg100_out : out std_logic_vector(WB_DW-1 downto 0);
         reg101_out : out std_logic_vector(WB_DW-1 downto 0);
         reg102_out : out std_logic_vector(WB_DW-1 downto 0);
         reg103_out : out std_logic_vector(WB_DW-1 downto 0);
         reg104_out : out std_logic_vector(WB_DW-1 downto 0);
         reg105_out : out std_logic_vector(WB_DW-1 downto 0);
         reg106_out : out std_logic_vector(WB_DW-1 downto 0);
         reg107_out : out std_logic_vector(WB_DW-1 downto 0);
         reg108_out : out std_logic_vector(WB_DW-1 downto 0);
         reg109_out : out std_logic_vector(WB_DW-1 downto 0);
         reg110_out : out std_logic_vector(WB_DW-1 downto 0);
         reg111_out : out std_logic_vector(WB_DW-1 downto 0);
         reg112_out : out std_logic_vector(WB_DW-1 downto 0);
         reg113_out : out std_logic_vector(WB_DW-1 downto 0);
         reg114_out : out std_logic_vector(WB_DW-1 downto 0);
         reg115_out : out std_logic_vector(WB_DW-1 downto 0);
         reg116_out : out std_logic_vector(WB_DW-1 downto 0);
         reg117_out : out std_logic_vector(WB_DW-1 downto 0);
         reg118_out : out std_logic_vector(WB_DW-1 downto 0);
         reg119_out : out std_logic_vector(WB_DW-1 downto 0);
         reg120_out : out std_logic_vector(WB_DW-1 downto 0);
         reg121_out : out std_logic_vector(WB_DW-1 downto 0);
         reg122_out : out std_logic_vector(WB_DW-1 downto 0);
         reg123_out : out std_logic_vector(WB_DW-1 downto 0);
         reg124_out : out std_logic_vector(WB_DW-1 downto 0);
         reg125_out : out std_logic_vector(WB_DW-1 downto 0);
         reg126_out : out std_logic_vector(WB_DW-1 downto 0);
         reg127_out : out std_logic_vector(WB_DW-1 downto 0);
         reg128_out : out std_logic_vector(WB_DW-1 downto 0);
         reg129_out : out std_logic_vector(WB_DW-1 downto 0);
         reg130_out : out std_logic_vector(WB_DW-1 downto 0);
         reg131_out : out std_logic_vector(WB_DW-1 downto 0);
         reg132_out : out std_logic_vector(WB_DW-1 downto 0);
         reg133_out : out std_logic_vector(WB_DW-1 downto 0);
         reg134_out : out std_logic_vector(WB_DW-1 downto 0);
         reg135_out : out std_logic_vector(WB_DW-1 downto 0);
         reg136_out : out std_logic_vector(WB_DW-1 downto 0);
         reg137_out : out std_logic_vector(WB_DW-1 downto 0);
         reg138_out : out std_logic_vector(WB_DW-1 downto 0);
         reg139_out : out std_logic_vector(WB_DW-1 downto 0);
         reg140_out : out std_logic_vector(WB_DW-1 downto 0);
         reg141_out : out std_logic_vector(WB_DW-1 downto 0);
         reg142_out : out std_logic_vector(WB_DW-1 downto 0);
         reg143_out : out std_logic_vector(WB_DW-1 downto 0);
         reg144_out : out std_logic_vector(WB_DW-1 downto 0);
         reg145_out : out std_logic_vector(WB_DW-1 downto 0);
         reg146_out : out std_logic_vector(WB_DW-1 downto 0);
         reg147_out : out std_logic_vector(WB_DW-1 downto 0);
         reg148_out : out std_logic_vector(WB_DW-1 downto 0);
         reg149_out : out std_logic_vector(WB_DW-1 downto 0);
         reg150_out : out std_logic_vector(WB_DW-1 downto 0);
         reg151_out : out std_logic_vector(WB_DW-1 downto 0);
         reg152_out : out std_logic_vector(WB_DW-1 downto 0);
         reg153_out : out std_logic_vector(WB_DW-1 downto 0);
         reg154_out : out std_logic_vector(WB_DW-1 downto 0);
         reg155_out : out std_logic_vector(WB_DW-1 downto 0);
         reg156_out : out std_logic_vector(WB_DW-1 downto 0);
         reg157_out : out std_logic_vector(WB_DW-1 downto 0);
         reg158_out : out std_logic_vector(WB_DW-1 downto 0);
         reg159_out : out std_logic_vector(WB_DW-1 downto 0);
         reg160_out : out std_logic_vector(WB_DW-1 downto 0);
         reg161_out : out std_logic_vector(WB_DW-1 downto 0);
         reg162_out : out std_logic_vector(WB_DW-1 downto 0);
         reg163_out : out std_logic_vector(WB_DW-1 downto 0);
         reg164_out : out std_logic_vector(WB_DW-1 downto 0);
         reg165_out : out std_logic_vector(WB_DW-1 downto 0);
         reg166_out : out std_logic_vector(WB_DW-1 downto 0);
         reg167_out : out std_logic_vector(WB_DW-1 downto 0);
         reg168_out : out std_logic_vector(WB_DW-1 downto 0);
         reg169_out : out std_logic_vector(WB_DW-1 downto 0);
         reg170_out : out std_logic_vector(WB_DW-1 downto 0);
         reg171_out : out std_logic_vector(WB_DW-1 downto 0);
         reg172_out : out std_logic_vector(WB_DW-1 downto 0);
         reg173_out : out std_logic_vector(WB_DW-1 downto 0);
         reg174_out : out std_logic_vector(WB_DW-1 downto 0);
         reg175_out : out std_logic_vector(WB_DW-1 downto 0);
         reg176_out : out std_logic_vector(WB_DW-1 downto 0);
         reg177_out : out std_logic_vector(WB_DW-1 downto 0);
         reg178_out : out std_logic_vector(WB_DW-1 downto 0);
         reg179_out : out std_logic_vector(WB_DW-1 downto 0);
         reg180_out : out std_logic_vector(WB_DW-1 downto 0);
         reg181_out : out std_logic_vector(WB_DW-1 downto 0);
         reg182_out : out std_logic_vector(WB_DW-1 downto 0);
         reg183_out : out std_logic_vector(WB_DW-1 downto 0);
         reg184_out : out std_logic_vector(WB_DW-1 downto 0);
         reg185_out : out std_logic_vector(WB_DW-1 downto 0);
         reg186_out : out std_logic_vector(WB_DW-1 downto 0);
         reg187_out : out std_logic_vector(WB_DW-1 downto 0);
         reg188_out : out std_logic_vector(WB_DW-1 downto 0);
         reg189_out : out std_logic_vector(WB_DW-1 downto 0);
         reg190_out : out std_logic_vector(WB_DW-1 downto 0);
         reg191_out : out std_logic_vector(WB_DW-1 downto 0);
         reg192_out : out std_logic_vector(WB_DW-1 downto 0);
         reg193_out : out std_logic_vector(WB_DW-1 downto 0);
         reg194_out : out std_logic_vector(WB_DW-1 downto 0);
         reg195_out : out std_logic_vector(WB_DW-1 downto 0);
         reg196_out : out std_logic_vector(WB_DW-1 downto 0);
         reg197_out : out std_logic_vector(WB_DW-1 downto 0);
         reg198_out : out std_logic_vector(WB_DW-1 downto 0);
         reg199_out : out std_logic_vector(WB_DW-1 downto 0);
         reg200_out : out std_logic_vector(WB_DW-1 downto 0);
         reg201_out : out std_logic_vector(WB_DW-1 downto 0);
         reg202_out : out std_logic_vector(WB_DW-1 downto 0);
         reg203_out : out std_logic_vector(WB_DW-1 downto 0);
         reg204_out : out std_logic_vector(WB_DW-1 downto 0);
         reg205_out : out std_logic_vector(WB_DW-1 downto 0);
         reg206_out : out std_logic_vector(WB_DW-1 downto 0);
         reg207_out : out std_logic_vector(WB_DW-1 downto 0);
         reg208_out : out std_logic_vector(WB_DW-1 downto 0);
         reg209_out : out std_logic_vector(WB_DW-1 downto 0);
         reg210_out : out std_logic_vector(WB_DW-1 downto 0);
         reg211_out : out std_logic_vector(WB_DW-1 downto 0);
         reg212_out : out std_logic_vector(WB_DW-1 downto 0);
         reg213_out : out std_logic_vector(WB_DW-1 downto 0);
         reg214_out : out std_logic_vector(WB_DW-1 downto 0);
         reg215_out : out std_logic_vector(WB_DW-1 downto 0);
         reg216_out : out std_logic_vector(WB_DW-1 downto 0);
         reg217_out : out std_logic_vector(WB_DW-1 downto 0);
         reg218_out : out std_logic_vector(WB_DW-1 downto 0);
         reg219_out : out std_logic_vector(WB_DW-1 downto 0);
         reg220_out : out std_logic_vector(WB_DW-1 downto 0);
         reg221_out : out std_logic_vector(WB_DW-1 downto 0);
         reg222_out : out std_logic_vector(WB_DW-1 downto 0);
         reg223_out : out std_logic_vector(WB_DW-1 downto 0);
         reg224_out : out std_logic_vector(WB_DW-1 downto 0);
         reg225_out : out std_logic_vector(WB_DW-1 downto 0);
         reg226_out : out std_logic_vector(WB_DW-1 downto 0);
         reg227_out : out std_logic_vector(WB_DW-1 downto 0);
         reg228_out : out std_logic_vector(WB_DW-1 downto 0);
         reg229_out : out std_logic_vector(WB_DW-1 downto 0);
         reg230_out : out std_logic_vector(WB_DW-1 downto 0);
         reg231_out : out std_logic_vector(WB_DW-1 downto 0);
         reg232_out : out std_logic_vector(WB_DW-1 downto 0);
         reg233_out : out std_logic_vector(WB_DW-1 downto 0);
         reg234_out : out std_logic_vector(WB_DW-1 downto 0);
         reg235_out : out std_logic_vector(WB_DW-1 downto 0);
         reg236_out : out std_logic_vector(WB_DW-1 downto 0);
         reg237_out : out std_logic_vector(WB_DW-1 downto 0);
         reg238_out : out std_logic_vector(WB_DW-1 downto 0);
         reg239_out : out std_logic_vector(WB_DW-1 downto 0);
         reg240_out : out std_logic_vector(WB_DW-1 downto 0);
         reg241_out : out std_logic_vector(WB_DW-1 downto 0);
         reg242_out : out std_logic_vector(WB_DW-1 downto 0);
         reg243_out : out std_logic_vector(WB_DW-1 downto 0);
         reg244_out : out std_logic_vector(WB_DW-1 downto 0);
         reg245_out : out std_logic_vector(WB_DW-1 downto 0);
         reg246_out : out std_logic_vector(WB_DW-1 downto 0);
         reg247_out : out std_logic_vector(WB_DW-1 downto 0);
         reg248_out : out std_logic_vector(WB_DW-1 downto 0);
         reg249_out : out std_logic_vector(WB_DW-1 downto 0);
         reg250_out : out std_logic_vector(WB_DW-1 downto 0);
         reg251_out : out std_logic_vector(WB_DW-1 downto 0);
         reg252_out : out std_logic_vector(WB_DW-1 downto 0);
         reg253_out : out std_logic_vector(WB_DW-1 downto 0);
         reg254_out : out std_logic_vector(WB_DW-1 downto 0);
         reg255_out : out std_logic_vector(WB_DW-1 downto 0);

         -- wishbone interface
         wbs_in   : in  wbs_in_type;
         wbs_out  : out wbs_out_type
   );
end wbs256;

-------------------------------------------------------------------------------
architecture behavioral of wbs256 is
 
-------------------------------------------------------------------------------
   ----------------------------------------------
   -- register addresses
   ----------------------------------------------
   constant REG0_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"00";
   constant REG1_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"01";
   constant REG2_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"02";
   constant REG3_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"03";
   constant REG4_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"04";
   constant REG5_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"05";
   constant REG6_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"06";
   constant REG7_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"07";
   constant REG8_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"08";
   constant REG9_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"09";
   constant REG10_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"0A";
   constant REG11_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"0B";
   constant REG12_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"0C";
   constant REG13_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"0D";
   constant REG14_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"0E";
   constant REG15_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"0F";
   constant REG16_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"10";
   constant REG17_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"11";
   constant REG18_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"12";
   constant REG19_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"13";
   constant REG20_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"14";
   constant REG21_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"15";
   constant REG22_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"16";
   constant REG23_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"17";
   constant REG24_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"18";
   constant REG25_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"19";
   constant REG26_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"1A";
   constant REG27_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"1B";
   constant REG28_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"1C";
   constant REG29_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"1D";
   constant REG30_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"1E";
   constant REG31_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"1F";
   constant REG32_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"20";
   constant REG33_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"21";
   constant REG34_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"22";
   constant REG35_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"23";
   constant REG36_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"24";
   constant REG37_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"25";
   constant REG38_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"26";
   constant REG39_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"27";
   constant REG40_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"28";
   constant REG41_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"29";
   constant REG42_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"2A";
   constant REG43_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"2B";
   constant REG44_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"2C";
   constant REG45_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"2D";
   constant REG46_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"2E";
   constant REG47_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"2F";
   constant REG48_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"30";
   constant REG49_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"31";
   constant REG50_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"32";
   constant REG51_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"33";
   constant REG52_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"34";
   constant REG53_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"35";
   constant REG54_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"36";
   constant REG55_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"37";
   constant REG56_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"38";
   constant REG57_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"39";
   constant REG58_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"3A";
   constant REG59_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"3B";
   constant REG60_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"3C";
   constant REG61_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"3D";
   constant REG62_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"3E";
   constant REG63_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"3F";
   constant REG64_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"40";
   constant REG65_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"41";
   constant REG66_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"42";
   constant REG67_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"43";
   constant REG68_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"44";
   constant REG69_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"45";
   constant REG70_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"46";
   constant REG71_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"47";
   constant REG72_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"48";
   constant REG73_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"49";
   constant REG74_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"4A";
   constant REG75_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"4B";
   constant REG76_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"4C";
   constant REG77_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"4D";
   constant REG78_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"4E";
   constant REG79_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"4F";
   constant REG80_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"50";
   constant REG81_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"51";
   constant REG82_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"52";
   constant REG83_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"53";
   constant REG84_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"54";
   constant REG85_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"55";
   constant REG86_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"56";
   constant REG87_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"57";
   constant REG88_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"58";
   constant REG89_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"59";
   constant REG90_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"5A";
   constant REG91_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"5B";
   constant REG92_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"5C";
   constant REG93_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"5D";
   constant REG94_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"5E";
   constant REG95_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"5F";
   constant REG96_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"60";
   constant REG97_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"61";
   constant REG98_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"62";
   constant REG99_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"63";
   constant REG100_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"64";
   constant REG101_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"65";
   constant REG102_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"66";
   constant REG103_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"67";
   constant REG104_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"68";
   constant REG105_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"69";
   constant REG106_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"6A";
   constant REG107_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"6B";
   constant REG108_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"6C";
   constant REG109_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"6D";
   constant REG110_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"6E";
   constant REG111_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"6F";
   constant REG112_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"70";
   constant REG113_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"71";
   constant REG114_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"72";
   constant REG115_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"73";
   constant REG116_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"74";
   constant REG117_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"75";
   constant REG118_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"76";
   constant REG119_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"77";
   constant REG120_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"78";
   constant REG121_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"79";
   constant REG122_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"7A";
   constant REG123_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"7B";
   constant REG124_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"7C";
   constant REG125_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"7D";
   constant REG126_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"7E";
   constant REG127_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"7F";
   constant REG128_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"80";
   constant REG129_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"81";
   constant REG130_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"82";
   constant REG131_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"83";
   constant REG132_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"84";
   constant REG133_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"85";
   constant REG134_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"86";
   constant REG135_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"87";
   constant REG136_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"88";
   constant REG137_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"89";
   constant REG138_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"8A";
   constant REG139_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"8B";
   constant REG140_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"8C";
   constant REG141_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"8D";
   constant REG142_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"8E";
   constant REG143_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"8F";
   constant REG144_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"90";
   constant REG145_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"91";
   constant REG146_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"92";
   constant REG147_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"93";
   constant REG148_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"94";
   constant REG149_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"95";
   constant REG150_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"96";
   constant REG151_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"97";
   constant REG152_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"98";
   constant REG153_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"99";
   constant REG154_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"9A";
   constant REG155_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"9B";
   constant REG156_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"9C";
   constant REG157_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"9D";
   constant REG158_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"9E";
   constant REG159_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"9F";
   constant REG160_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A0";
   constant REG161_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A1";
   constant REG162_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A2";
   constant REG163_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A3";
   constant REG164_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A4";
   constant REG165_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A5";
   constant REG166_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A6";
   constant REG167_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A7";
   constant REG168_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A8";
   constant REG169_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"A9";
   constant REG170_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"AA";
   constant REG171_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"AB";
   constant REG172_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"AC";
   constant REG173_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"AD";
   constant REG174_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"AE";
   constant REG175_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"AF";
   constant REG176_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B0";
   constant REG177_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B1";
   constant REG178_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B2";
   constant REG179_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B3";
   constant REG180_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B4";
   constant REG181_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B5";
   constant REG182_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B6";
   constant REG183_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B7";
   constant REG184_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B8";
   constant REG185_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"B9";
   constant REG186_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"BA";
   constant REG187_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"BB";
   constant REG188_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"BC";
   constant REG189_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"BD";
   constant REG190_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"BE";
   constant REG191_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"BF";
   constant REG192_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C0";
   constant REG193_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C1";
   constant REG194_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C2";
   constant REG195_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C3";
   constant REG196_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C4";
   constant REG197_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C5";
   constant REG198_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C6";
   constant REG199_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C7";
   constant REG200_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C8";
   constant REG201_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"C9";
   constant REG202_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"CA";
   constant REG203_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"CB";
   constant REG204_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"CC";
   constant REG205_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"CD";
   constant REG206_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"CE";
   constant REG207_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"CF";
   constant REG208_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D0";
   constant REG209_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D1";
   constant REG210_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D2";
   constant REG211_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D3";
   constant REG212_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D4";
   constant REG213_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D5";
   constant REG214_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D6";
   constant REG215_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D7";
   constant REG216_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D8";
   constant REG217_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"D9";
   constant REG218_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"DA";
   constant REG219_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"DB";
   constant REG220_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"DC";
   constant REG221_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"DD";
   constant REG222_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"DE";
   constant REG223_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"DF";
   constant REG224_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E0";
   constant REG225_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E1";
   constant REG226_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E2";
   constant REG227_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E3";
   constant REG228_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E4";
   constant REG229_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E5";
   constant REG230_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E6";
   constant REG231_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E7";
   constant REG232_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E8";
   constant REG233_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"E9";
   constant REG234_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"EA";
   constant REG235_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"EB";
   constant REG236_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"EC";
   constant REG237_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"ED";
   constant REG238_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"EE";
   constant REG239_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"EF";
   constant REG240_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F0";
   constant REG241_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F1";
   constant REG242_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F2";
   constant REG243_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F3";
   constant REG244_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F4";
   constant REG245_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F5";
   constant REG246_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F6";
   constant REG247_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F7";
   constant REG248_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F8";
   constant REG249_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"F9";
   constant REG250_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"FA";
   constant REG251_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"FB";
   constant REG252_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"FC";
   constant REG253_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"FD";
   constant REG254_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"FE";
   constant REG255_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"FF";

   ----------------------------------------------
   -- signals
   ----------------------------------------------
   signal reg_out_s, reg_in_s : reg_wbs256_t;
   signal reg0_adr_match_s, reg1_adr_match_s, reg2_adr_match_s, reg3_adr_match_s, reg4_adr_match_s, reg5_adr_match_s, reg6_adr_match_s, reg7_adr_match_s, reg8_adr_match_s, reg9_adr_match_s, reg10_adr_match_s, reg11_adr_match_s, reg12_adr_match_s, reg13_adr_match_s, reg14_adr_match_s, reg15_adr_match_s, reg16_adr_match_s, reg17_adr_match_s, reg18_adr_match_s, reg19_adr_match_s, reg20_adr_match_s, reg21_adr_match_s, reg22_adr_match_s, reg23_adr_match_s, reg24_adr_match_s, reg25_adr_match_s, reg26_adr_match_s, reg27_adr_match_s, reg28_adr_match_s, reg29_adr_match_s, reg30_adr_match_s, reg31_adr_match_s, reg32_adr_match_s, reg33_adr_match_s, reg34_adr_match_s, reg35_adr_match_s, reg36_adr_match_s, reg37_adr_match_s, reg38_adr_match_s, reg39_adr_match_s, reg40_adr_match_s, reg41_adr_match_s, reg42_adr_match_s, reg43_adr_match_s, reg44_adr_match_s, reg45_adr_match_s, reg46_adr_match_s, reg47_adr_match_s, reg48_adr_match_s, reg49_adr_match_s, reg50_adr_match_s, reg51_adr_match_s, reg52_adr_match_s, reg53_adr_match_s, reg54_adr_match_s, reg55_adr_match_s, reg56_adr_match_s, reg57_adr_match_s, reg58_adr_match_s, reg59_adr_match_s, reg60_adr_match_s, reg61_adr_match_s, reg62_adr_match_s, reg63_adr_match_s, reg64_adr_match_s, reg65_adr_match_s, reg66_adr_match_s, reg67_adr_match_s, reg68_adr_match_s, reg69_adr_match_s, reg70_adr_match_s, reg71_adr_match_s, reg72_adr_match_s, reg73_adr_match_s, reg74_adr_match_s, reg75_adr_match_s, reg76_adr_match_s, reg77_adr_match_s, reg78_adr_match_s, reg79_adr_match_s, reg80_adr_match_s, reg81_adr_match_s, reg82_adr_match_s, reg83_adr_match_s, reg84_adr_match_s, reg85_adr_match_s, reg86_adr_match_s, reg87_adr_match_s, reg88_adr_match_s, reg89_adr_match_s, reg90_adr_match_s, reg91_adr_match_s, reg92_adr_match_s, reg93_adr_match_s, reg94_adr_match_s, reg95_adr_match_s, reg96_adr_match_s, reg97_adr_match_s, reg98_adr_match_s, reg99_adr_match_s, reg100_adr_match_s, reg101_adr_match_s, reg102_adr_match_s, reg103_adr_match_s, reg104_adr_match_s, reg105_adr_match_s, reg106_adr_match_s, reg107_adr_match_s, reg108_adr_match_s, reg109_adr_match_s, reg110_adr_match_s, reg111_adr_match_s, reg112_adr_match_s, reg113_adr_match_s, reg114_adr_match_s, reg115_adr_match_s, reg116_adr_match_s, reg117_adr_match_s, reg118_adr_match_s, reg119_adr_match_s, reg120_adr_match_s, reg121_adr_match_s, reg122_adr_match_s, reg123_adr_match_s, reg124_adr_match_s, reg125_adr_match_s, reg126_adr_match_s, reg127_adr_match_s, reg128_adr_match_s, reg129_adr_match_s, reg130_adr_match_s, reg131_adr_match_s, reg132_adr_match_s, reg133_adr_match_s, reg134_adr_match_s, reg135_adr_match_s, reg136_adr_match_s, reg137_adr_match_s, reg138_adr_match_s, reg139_adr_match_s, reg140_adr_match_s, reg141_adr_match_s, reg142_adr_match_s, reg143_adr_match_s, reg144_adr_match_s, reg145_adr_match_s, reg146_adr_match_s, reg147_adr_match_s, reg148_adr_match_s, reg149_adr_match_s, reg150_adr_match_s, reg151_adr_match_s, reg152_adr_match_s, reg153_adr_match_s, reg154_adr_match_s, reg155_adr_match_s, reg156_adr_match_s, reg157_adr_match_s, reg158_adr_match_s, reg159_adr_match_s, reg160_adr_match_s, reg161_adr_match_s, reg162_adr_match_s, reg163_adr_match_s, reg164_adr_match_s, reg165_adr_match_s, reg166_adr_match_s, reg167_adr_match_s, reg168_adr_match_s, reg169_adr_match_s, reg170_adr_match_s, reg171_adr_match_s, reg172_adr_match_s, reg173_adr_match_s, reg174_adr_match_s, reg175_adr_match_s, reg176_adr_match_s, reg177_adr_match_s, reg178_adr_match_s, reg179_adr_match_s, reg180_adr_match_s, reg181_adr_match_s, reg182_adr_match_s, reg183_adr_match_s, reg184_adr_match_s, reg185_adr_match_s, reg186_adr_match_s, reg187_adr_match_s, reg188_adr_match_s, reg189_adr_match_s, reg190_adr_match_s, reg191_adr_match_s, reg192_adr_match_s, reg193_adr_match_s, reg194_adr_match_s, reg195_adr_match_s, reg196_adr_match_s, reg197_adr_match_s, reg198_adr_match_s, reg199_adr_match_s, reg200_adr_match_s, reg201_adr_match_s, reg202_adr_match_s, reg203_adr_match_s, reg204_adr_match_s, reg205_adr_match_s, reg206_adr_match_s, reg207_adr_match_s, reg208_adr_match_s, reg209_adr_match_s, reg210_adr_match_s, reg211_adr_match_s, reg212_adr_match_s, reg213_adr_match_s, reg214_adr_match_s, reg215_adr_match_s, reg216_adr_match_s, reg217_adr_match_s, reg218_adr_match_s, reg219_adr_match_s, reg220_adr_match_s, reg221_adr_match_s, reg222_adr_match_s, reg223_adr_match_s, reg224_adr_match_s, reg225_adr_match_s, reg226_adr_match_s, reg227_adr_match_s, reg228_adr_match_s, reg229_adr_match_s, reg230_adr_match_s, reg231_adr_match_s, reg232_adr_match_s, reg233_adr_match_s, reg234_adr_match_s, reg235_adr_match_s, reg236_adr_match_s, reg237_adr_match_s, reg238_adr_match_s, reg239_adr_match_s, reg240_adr_match_s, reg241_adr_match_s, reg242_adr_match_s, reg243_adr_match_s, reg244_adr_match_s, reg245_adr_match_s, reg246_adr_match_s, reg247_adr_match_s, reg248_adr_match_s, reg249_adr_match_s, reg250_adr_match_s, reg251_adr_match_s, reg252_adr_match_s, reg253_adr_match_s, reg254_adr_match_s, reg255_adr_match_s : std_logic;
   signal reg0_re_s, reg1_re_s, reg2_re_s, reg3_re_s, reg4_re_s, reg5_re_s, reg6_re_s, reg7_re_s, reg8_re_s, reg9_re_s, reg10_re_s, reg11_re_s, reg12_re_s, reg13_re_s, reg14_re_s, reg15_re_s, reg16_re_s, reg17_re_s, reg18_re_s, reg19_re_s, reg20_re_s, reg21_re_s, reg22_re_s, reg23_re_s, reg24_re_s, reg25_re_s, reg26_re_s, reg27_re_s, reg28_re_s, reg29_re_s, reg30_re_s, reg31_re_s, reg32_re_s, reg33_re_s, reg34_re_s, reg35_re_s, reg36_re_s, reg37_re_s, reg38_re_s, reg39_re_s, reg40_re_s, reg41_re_s, reg42_re_s, reg43_re_s, reg44_re_s, reg45_re_s, reg46_re_s, reg47_re_s, reg48_re_s, reg49_re_s, reg50_re_s, reg51_re_s, reg52_re_s, reg53_re_s, reg54_re_s, reg55_re_s, reg56_re_s, reg57_re_s, reg58_re_s, reg59_re_s, reg60_re_s, reg61_re_s, reg62_re_s, reg63_re_s, reg64_re_s, reg65_re_s, reg66_re_s, reg67_re_s, reg68_re_s, reg69_re_s, reg70_re_s, reg71_re_s, reg72_re_s, reg73_re_s, reg74_re_s, reg75_re_s, reg76_re_s, reg77_re_s, reg78_re_s, reg79_re_s, reg80_re_s, reg81_re_s, reg82_re_s, reg83_re_s, reg84_re_s, reg85_re_s, reg86_re_s, reg87_re_s, reg88_re_s, reg89_re_s, reg90_re_s, reg91_re_s, reg92_re_s, reg93_re_s, reg94_re_s, reg95_re_s, reg96_re_s, reg97_re_s, reg98_re_s, reg99_re_s, reg100_re_s, reg101_re_s, reg102_re_s, reg103_re_s, reg104_re_s, reg105_re_s, reg106_re_s, reg107_re_s, reg108_re_s, reg109_re_s, reg110_re_s, reg111_re_s, reg112_re_s, reg113_re_s, reg114_re_s, reg115_re_s, reg116_re_s, reg117_re_s, reg118_re_s, reg119_re_s, reg120_re_s, reg121_re_s, reg122_re_s, reg123_re_s, reg124_re_s, reg125_re_s, reg126_re_s, reg127_re_s, reg128_re_s, reg129_re_s, reg130_re_s, reg131_re_s, reg132_re_s, reg133_re_s, reg134_re_s, reg135_re_s, reg136_re_s, reg137_re_s, reg138_re_s, reg139_re_s, reg140_re_s, reg141_re_s, reg142_re_s, reg143_re_s, reg144_re_s, reg145_re_s, reg146_re_s, reg147_re_s, reg148_re_s, reg149_re_s, reg150_re_s, reg151_re_s, reg152_re_s, reg153_re_s, reg154_re_s, reg155_re_s, reg156_re_s, reg157_re_s, reg158_re_s, reg159_re_s, reg160_re_s, reg161_re_s, reg162_re_s, reg163_re_s, reg164_re_s, reg165_re_s, reg166_re_s, reg167_re_s, reg168_re_s, reg169_re_s, reg170_re_s, reg171_re_s, reg172_re_s, reg173_re_s, reg174_re_s, reg175_re_s, reg176_re_s, reg177_re_s, reg178_re_s, reg179_re_s, reg180_re_s, reg181_re_s, reg182_re_s, reg183_re_s, reg184_re_s, reg185_re_s, reg186_re_s, reg187_re_s, reg188_re_s, reg189_re_s, reg190_re_s, reg191_re_s, reg192_re_s, reg193_re_s, reg194_re_s, reg195_re_s, reg196_re_s, reg197_re_s, reg198_re_s, reg199_re_s, reg200_re_s, reg201_re_s, reg202_re_s, reg203_re_s, reg204_re_s, reg205_re_s, reg206_re_s, reg207_re_s, reg208_re_s, reg209_re_s, reg210_re_s, reg211_re_s, reg212_re_s, reg213_re_s, reg214_re_s, reg215_re_s, reg216_re_s, reg217_re_s, reg218_re_s, reg219_re_s, reg220_re_s, reg221_re_s, reg222_re_s, reg223_re_s, reg224_re_s, reg225_re_s, reg226_re_s, reg227_re_s, reg228_re_s, reg229_re_s, reg230_re_s, reg231_re_s, reg232_re_s, reg233_re_s, reg234_re_s, reg235_re_s, reg236_re_s, reg237_re_s, reg238_re_s, reg239_re_s, reg240_re_s, reg241_re_s, reg242_re_s, reg243_re_s, reg244_re_s, reg245_re_s, reg246_re_s, reg247_re_s, reg248_re_s, reg249_re_s, reg250_re_s, reg251_re_s, reg252_re_s, reg253_re_s, reg254_re_s, reg255_re_s : std_logic;

begin

-------------------------------------------------------------------------------
-- Concurrent
-------------------------------------------------------------------------------

-- register address decoder/comparator
reg0_adr_match_s <= '1' when wbs_in.adr = REG0_ADR else '0';
reg1_adr_match_s <= '1' when wbs_in.adr = REG1_ADR else '0';
reg2_adr_match_s <= '1' when wbs_in.adr = REG2_ADR else '0';
reg3_adr_match_s <= '1' when wbs_in.adr = REG3_ADR else '0';
reg4_adr_match_s <= '1' when wbs_in.adr = REG4_ADR else '0';
reg5_adr_match_s <= '1' when wbs_in.adr = REG5_ADR else '0';
reg6_adr_match_s <= '1' when wbs_in.adr = REG6_ADR else '0';
reg7_adr_match_s <= '1' when wbs_in.adr = REG7_ADR else '0';
reg8_adr_match_s <= '1' when wbs_in.adr = REG8_ADR else '0';
reg9_adr_match_s <= '1' when wbs_in.adr = REG9_ADR else '0';
reg10_adr_match_s <= '1' when wbs_in.adr = REG10_ADR else '0';
reg11_adr_match_s <= '1' when wbs_in.adr = REG11_ADR else '0';
reg12_adr_match_s <= '1' when wbs_in.adr = REG12_ADR else '0';
reg13_adr_match_s <= '1' when wbs_in.adr = REG13_ADR else '0';
reg14_adr_match_s <= '1' when wbs_in.adr = REG14_ADR else '0';
reg15_adr_match_s <= '1' when wbs_in.adr = REG15_ADR else '0';
reg16_adr_match_s <= '1' when wbs_in.adr = REG16_ADR else '0';
reg17_adr_match_s <= '1' when wbs_in.adr = REG17_ADR else '0';
reg18_adr_match_s <= '1' when wbs_in.adr = REG18_ADR else '0';
reg19_adr_match_s <= '1' when wbs_in.adr = REG19_ADR else '0';
reg20_adr_match_s <= '1' when wbs_in.adr = REG20_ADR else '0';
reg21_adr_match_s <= '1' when wbs_in.adr = REG21_ADR else '0';
reg22_adr_match_s <= '1' when wbs_in.adr = REG22_ADR else '0';
reg23_adr_match_s <= '1' when wbs_in.adr = REG23_ADR else '0';
reg24_adr_match_s <= '1' when wbs_in.adr = REG24_ADR else '0';
reg25_adr_match_s <= '1' when wbs_in.adr = REG25_ADR else '0';
reg26_adr_match_s <= '1' when wbs_in.adr = REG26_ADR else '0';
reg27_adr_match_s <= '1' when wbs_in.adr = REG27_ADR else '0';
reg28_adr_match_s <= '1' when wbs_in.adr = REG28_ADR else '0';
reg29_adr_match_s <= '1' when wbs_in.adr = REG29_ADR else '0';
reg30_adr_match_s <= '1' when wbs_in.adr = REG30_ADR else '0';
reg31_adr_match_s <= '1' when wbs_in.adr = REG31_ADR else '0';
reg32_adr_match_s <= '1' when wbs_in.adr = REG32_ADR else '0';
reg33_adr_match_s <= '1' when wbs_in.adr = REG33_ADR else '0';
reg34_adr_match_s <= '1' when wbs_in.adr = REG34_ADR else '0';
reg35_adr_match_s <= '1' when wbs_in.adr = REG35_ADR else '0';
reg36_adr_match_s <= '1' when wbs_in.adr = REG36_ADR else '0';
reg37_adr_match_s <= '1' when wbs_in.adr = REG37_ADR else '0';
reg38_adr_match_s <= '1' when wbs_in.adr = REG38_ADR else '0';
reg39_adr_match_s <= '1' when wbs_in.adr = REG39_ADR else '0';
reg40_adr_match_s <= '1' when wbs_in.adr = REG40_ADR else '0';
reg41_adr_match_s <= '1' when wbs_in.adr = REG41_ADR else '0';
reg42_adr_match_s <= '1' when wbs_in.adr = REG42_ADR else '0';
reg43_adr_match_s <= '1' when wbs_in.adr = REG43_ADR else '0';
reg44_adr_match_s <= '1' when wbs_in.adr = REG44_ADR else '0';
reg45_adr_match_s <= '1' when wbs_in.adr = REG45_ADR else '0';
reg46_adr_match_s <= '1' when wbs_in.adr = REG46_ADR else '0';
reg47_adr_match_s <= '1' when wbs_in.adr = REG47_ADR else '0';
reg48_adr_match_s <= '1' when wbs_in.adr = REG48_ADR else '0';
reg49_adr_match_s <= '1' when wbs_in.adr = REG49_ADR else '0';
reg50_adr_match_s <= '1' when wbs_in.adr = REG50_ADR else '0';
reg51_adr_match_s <= '1' when wbs_in.adr = REG51_ADR else '0';
reg52_adr_match_s <= '1' when wbs_in.adr = REG52_ADR else '0';
reg53_adr_match_s <= '1' when wbs_in.adr = REG53_ADR else '0';
reg54_adr_match_s <= '1' when wbs_in.adr = REG54_ADR else '0';
reg55_adr_match_s <= '1' when wbs_in.adr = REG55_ADR else '0';
reg56_adr_match_s <= '1' when wbs_in.adr = REG56_ADR else '0';
reg57_adr_match_s <= '1' when wbs_in.adr = REG57_ADR else '0';
reg58_adr_match_s <= '1' when wbs_in.adr = REG58_ADR else '0';
reg59_adr_match_s <= '1' when wbs_in.adr = REG59_ADR else '0';
reg60_adr_match_s <= '1' when wbs_in.adr = REG60_ADR else '0';
reg61_adr_match_s <= '1' when wbs_in.adr = REG61_ADR else '0';
reg62_adr_match_s <= '1' when wbs_in.adr = REG62_ADR else '0';
reg63_adr_match_s <= '1' when wbs_in.adr = REG63_ADR else '0';
reg64_adr_match_s <= '1' when wbs_in.adr = REG64_ADR else '0';
reg65_adr_match_s <= '1' when wbs_in.adr = REG65_ADR else '0';
reg66_adr_match_s <= '1' when wbs_in.adr = REG66_ADR else '0';
reg67_adr_match_s <= '1' when wbs_in.adr = REG67_ADR else '0';
reg68_adr_match_s <= '1' when wbs_in.adr = REG68_ADR else '0';
reg69_adr_match_s <= '1' when wbs_in.adr = REG69_ADR else '0';
reg70_adr_match_s <= '1' when wbs_in.adr = REG70_ADR else '0';
reg71_adr_match_s <= '1' when wbs_in.adr = REG71_ADR else '0';
reg72_adr_match_s <= '1' when wbs_in.adr = REG72_ADR else '0';
reg73_adr_match_s <= '1' when wbs_in.adr = REG73_ADR else '0';
reg74_adr_match_s <= '1' when wbs_in.adr = REG74_ADR else '0';
reg75_adr_match_s <= '1' when wbs_in.adr = REG75_ADR else '0';
reg76_adr_match_s <= '1' when wbs_in.adr = REG76_ADR else '0';
reg77_adr_match_s <= '1' when wbs_in.adr = REG77_ADR else '0';
reg78_adr_match_s <= '1' when wbs_in.adr = REG78_ADR else '0';
reg79_adr_match_s <= '1' when wbs_in.adr = REG79_ADR else '0';
reg80_adr_match_s <= '1' when wbs_in.adr = REG80_ADR else '0';
reg81_adr_match_s <= '1' when wbs_in.adr = REG81_ADR else '0';
reg82_adr_match_s <= '1' when wbs_in.adr = REG82_ADR else '0';
reg83_adr_match_s <= '1' when wbs_in.adr = REG83_ADR else '0';
reg84_adr_match_s <= '1' when wbs_in.adr = REG84_ADR else '0';
reg85_adr_match_s <= '1' when wbs_in.adr = REG85_ADR else '0';
reg86_adr_match_s <= '1' when wbs_in.adr = REG86_ADR else '0';
reg87_adr_match_s <= '1' when wbs_in.adr = REG87_ADR else '0';
reg88_adr_match_s <= '1' when wbs_in.adr = REG88_ADR else '0';
reg89_adr_match_s <= '1' when wbs_in.adr = REG89_ADR else '0';
reg90_adr_match_s <= '1' when wbs_in.adr = REG90_ADR else '0';
reg91_adr_match_s <= '1' when wbs_in.adr = REG91_ADR else '0';
reg92_adr_match_s <= '1' when wbs_in.adr = REG92_ADR else '0';
reg93_adr_match_s <= '1' when wbs_in.adr = REG93_ADR else '0';
reg94_adr_match_s <= '1' when wbs_in.adr = REG94_ADR else '0';
reg95_adr_match_s <= '1' when wbs_in.adr = REG95_ADR else '0';
reg96_adr_match_s <= '1' when wbs_in.adr = REG96_ADR else '0';
reg97_adr_match_s <= '1' when wbs_in.adr = REG97_ADR else '0';
reg98_adr_match_s <= '1' when wbs_in.adr = REG98_ADR else '0';
reg99_adr_match_s <= '1' when wbs_in.adr = REG99_ADR else '0';
reg100_adr_match_s <= '1' when wbs_in.adr = REG100_ADR else '0';
reg101_adr_match_s <= '1' when wbs_in.adr = REG101_ADR else '0';
reg102_adr_match_s <= '1' when wbs_in.adr = REG102_ADR else '0';
reg103_adr_match_s <= '1' when wbs_in.adr = REG103_ADR else '0';
reg104_adr_match_s <= '1' when wbs_in.adr = REG104_ADR else '0';
reg105_adr_match_s <= '1' when wbs_in.adr = REG105_ADR else '0';
reg106_adr_match_s <= '1' when wbs_in.adr = REG106_ADR else '0';
reg107_adr_match_s <= '1' when wbs_in.adr = REG107_ADR else '0';
reg108_adr_match_s <= '1' when wbs_in.adr = REG108_ADR else '0';
reg109_adr_match_s <= '1' when wbs_in.adr = REG109_ADR else '0';
reg110_adr_match_s <= '1' when wbs_in.adr = REG110_ADR else '0';
reg111_adr_match_s <= '1' when wbs_in.adr = REG111_ADR else '0';
reg112_adr_match_s <= '1' when wbs_in.adr = REG112_ADR else '0';
reg113_adr_match_s <= '1' when wbs_in.adr = REG113_ADR else '0';
reg114_adr_match_s <= '1' when wbs_in.adr = REG114_ADR else '0';
reg115_adr_match_s <= '1' when wbs_in.adr = REG115_ADR else '0';
reg116_adr_match_s <= '1' when wbs_in.adr = REG116_ADR else '0';
reg117_adr_match_s <= '1' when wbs_in.adr = REG117_ADR else '0';
reg118_adr_match_s <= '1' when wbs_in.adr = REG118_ADR else '0';
reg119_adr_match_s <= '1' when wbs_in.adr = REG119_ADR else '0';
reg120_adr_match_s <= '1' when wbs_in.adr = REG120_ADR else '0';
reg121_adr_match_s <= '1' when wbs_in.adr = REG121_ADR else '0';
reg122_adr_match_s <= '1' when wbs_in.adr = REG122_ADR else '0';
reg123_adr_match_s <= '1' when wbs_in.adr = REG123_ADR else '0';
reg124_adr_match_s <= '1' when wbs_in.adr = REG124_ADR else '0';
reg125_adr_match_s <= '1' when wbs_in.adr = REG125_ADR else '0';
reg126_adr_match_s <= '1' when wbs_in.adr = REG126_ADR else '0';
reg127_adr_match_s <= '1' when wbs_in.adr = REG127_ADR else '0';
reg128_adr_match_s <= '1' when wbs_in.adr = REG128_ADR else '0';
reg129_adr_match_s <= '1' when wbs_in.adr = REG129_ADR else '0';
reg130_adr_match_s <= '1' when wbs_in.adr = REG130_ADR else '0';
reg131_adr_match_s <= '1' when wbs_in.adr = REG131_ADR else '0';
reg132_adr_match_s <= '1' when wbs_in.adr = REG132_ADR else '0';
reg133_adr_match_s <= '1' when wbs_in.adr = REG133_ADR else '0';
reg134_adr_match_s <= '1' when wbs_in.adr = REG134_ADR else '0';
reg135_adr_match_s <= '1' when wbs_in.adr = REG135_ADR else '0';
reg136_adr_match_s <= '1' when wbs_in.adr = REG136_ADR else '0';
reg137_adr_match_s <= '1' when wbs_in.adr = REG137_ADR else '0';
reg138_adr_match_s <= '1' when wbs_in.adr = REG138_ADR else '0';
reg139_adr_match_s <= '1' when wbs_in.adr = REG139_ADR else '0';
reg140_adr_match_s <= '1' when wbs_in.adr = REG140_ADR else '0';
reg141_adr_match_s <= '1' when wbs_in.adr = REG141_ADR else '0';
reg142_adr_match_s <= '1' when wbs_in.adr = REG142_ADR else '0';
reg143_adr_match_s <= '1' when wbs_in.adr = REG143_ADR else '0';
reg144_adr_match_s <= '1' when wbs_in.adr = REG144_ADR else '0';
reg145_adr_match_s <= '1' when wbs_in.adr = REG145_ADR else '0';
reg146_adr_match_s <= '1' when wbs_in.adr = REG146_ADR else '0';
reg147_adr_match_s <= '1' when wbs_in.adr = REG147_ADR else '0';
reg148_adr_match_s <= '1' when wbs_in.adr = REG148_ADR else '0';
reg149_adr_match_s <= '1' when wbs_in.adr = REG149_ADR else '0';
reg150_adr_match_s <= '1' when wbs_in.adr = REG150_ADR else '0';
reg151_adr_match_s <= '1' when wbs_in.adr = REG151_ADR else '0';
reg152_adr_match_s <= '1' when wbs_in.adr = REG152_ADR else '0';
reg153_adr_match_s <= '1' when wbs_in.adr = REG153_ADR else '0';
reg154_adr_match_s <= '1' when wbs_in.adr = REG154_ADR else '0';
reg155_adr_match_s <= '1' when wbs_in.adr = REG155_ADR else '0';
reg156_adr_match_s <= '1' when wbs_in.adr = REG156_ADR else '0';
reg157_adr_match_s <= '1' when wbs_in.adr = REG157_ADR else '0';
reg158_adr_match_s <= '1' when wbs_in.adr = REG158_ADR else '0';
reg159_adr_match_s <= '1' when wbs_in.adr = REG159_ADR else '0';
reg160_adr_match_s <= '1' when wbs_in.adr = REG160_ADR else '0';
reg161_adr_match_s <= '1' when wbs_in.adr = REG161_ADR else '0';
reg162_adr_match_s <= '1' when wbs_in.adr = REG162_ADR else '0';
reg163_adr_match_s <= '1' when wbs_in.adr = REG163_ADR else '0';
reg164_adr_match_s <= '1' when wbs_in.adr = REG164_ADR else '0';
reg165_adr_match_s <= '1' when wbs_in.adr = REG165_ADR else '0';
reg166_adr_match_s <= '1' when wbs_in.adr = REG166_ADR else '0';
reg167_adr_match_s <= '1' when wbs_in.adr = REG167_ADR else '0';
reg168_adr_match_s <= '1' when wbs_in.adr = REG168_ADR else '0';
reg169_adr_match_s <= '1' when wbs_in.adr = REG169_ADR else '0';
reg170_adr_match_s <= '1' when wbs_in.adr = REG170_ADR else '0';
reg171_adr_match_s <= '1' when wbs_in.adr = REG171_ADR else '0';
reg172_adr_match_s <= '1' when wbs_in.adr = REG172_ADR else '0';
reg173_adr_match_s <= '1' when wbs_in.adr = REG173_ADR else '0';
reg174_adr_match_s <= '1' when wbs_in.adr = REG174_ADR else '0';
reg175_adr_match_s <= '1' when wbs_in.adr = REG175_ADR else '0';
reg176_adr_match_s <= '1' when wbs_in.adr = REG176_ADR else '0';
reg177_adr_match_s <= '1' when wbs_in.adr = REG177_ADR else '0';
reg178_adr_match_s <= '1' when wbs_in.adr = REG178_ADR else '0';
reg179_adr_match_s <= '1' when wbs_in.adr = REG179_ADR else '0';
reg180_adr_match_s <= '1' when wbs_in.adr = REG180_ADR else '0';
reg181_adr_match_s <= '1' when wbs_in.adr = REG181_ADR else '0';
reg182_adr_match_s <= '1' when wbs_in.adr = REG182_ADR else '0';
reg183_adr_match_s <= '1' when wbs_in.adr = REG183_ADR else '0';
reg184_adr_match_s <= '1' when wbs_in.adr = REG184_ADR else '0';
reg185_adr_match_s <= '1' when wbs_in.adr = REG185_ADR else '0';
reg186_adr_match_s <= '1' when wbs_in.adr = REG186_ADR else '0';
reg187_adr_match_s <= '1' when wbs_in.adr = REG187_ADR else '0';
reg188_adr_match_s <= '1' when wbs_in.adr = REG188_ADR else '0';
reg189_adr_match_s <= '1' when wbs_in.adr = REG189_ADR else '0';
reg190_adr_match_s <= '1' when wbs_in.adr = REG190_ADR else '0';
reg191_adr_match_s <= '1' when wbs_in.adr = REG191_ADR else '0';
reg192_adr_match_s <= '1' when wbs_in.adr = REG192_ADR else '0';
reg193_adr_match_s <= '1' when wbs_in.adr = REG193_ADR else '0';
reg194_adr_match_s <= '1' when wbs_in.adr = REG194_ADR else '0';
reg195_adr_match_s <= '1' when wbs_in.adr = REG195_ADR else '0';
reg196_adr_match_s <= '1' when wbs_in.adr = REG196_ADR else '0';
reg197_adr_match_s <= '1' when wbs_in.adr = REG197_ADR else '0';
reg198_adr_match_s <= '1' when wbs_in.adr = REG198_ADR else '0';
reg199_adr_match_s <= '1' when wbs_in.adr = REG199_ADR else '0';
reg200_adr_match_s <= '1' when wbs_in.adr = REG200_ADR else '0';
reg201_adr_match_s <= '1' when wbs_in.adr = REG201_ADR else '0';
reg202_adr_match_s <= '1' when wbs_in.adr = REG202_ADR else '0';
reg203_adr_match_s <= '1' when wbs_in.adr = REG203_ADR else '0';
reg204_adr_match_s <= '1' when wbs_in.adr = REG204_ADR else '0';
reg205_adr_match_s <= '1' when wbs_in.adr = REG205_ADR else '0';
reg206_adr_match_s <= '1' when wbs_in.adr = REG206_ADR else '0';
reg207_adr_match_s <= '1' when wbs_in.adr = REG207_ADR else '0';
reg208_adr_match_s <= '1' when wbs_in.adr = REG208_ADR else '0';
reg209_adr_match_s <= '1' when wbs_in.adr = REG209_ADR else '0';
reg210_adr_match_s <= '1' when wbs_in.adr = REG210_ADR else '0';
reg211_adr_match_s <= '1' when wbs_in.adr = REG211_ADR else '0';
reg212_adr_match_s <= '1' when wbs_in.adr = REG212_ADR else '0';
reg213_adr_match_s <= '1' when wbs_in.adr = REG213_ADR else '0';
reg214_adr_match_s <= '1' when wbs_in.adr = REG214_ADR else '0';
reg215_adr_match_s <= '1' when wbs_in.adr = REG215_ADR else '0';
reg216_adr_match_s <= '1' when wbs_in.adr = REG216_ADR else '0';
reg217_adr_match_s <= '1' when wbs_in.adr = REG217_ADR else '0';
reg218_adr_match_s <= '1' when wbs_in.adr = REG218_ADR else '0';
reg219_adr_match_s <= '1' when wbs_in.adr = REG219_ADR else '0';
reg220_adr_match_s <= '1' when wbs_in.adr = REG220_ADR else '0';
reg221_adr_match_s <= '1' when wbs_in.adr = REG221_ADR else '0';
reg222_adr_match_s <= '1' when wbs_in.adr = REG222_ADR else '0';
reg223_adr_match_s <= '1' when wbs_in.adr = REG223_ADR else '0';
reg224_adr_match_s <= '1' when wbs_in.adr = REG224_ADR else '0';
reg225_adr_match_s <= '1' when wbs_in.adr = REG225_ADR else '0';
reg226_adr_match_s <= '1' when wbs_in.adr = REG226_ADR else '0';
reg227_adr_match_s <= '1' when wbs_in.adr = REG227_ADR else '0';
reg228_adr_match_s <= '1' when wbs_in.adr = REG228_ADR else '0';
reg229_adr_match_s <= '1' when wbs_in.adr = REG229_ADR else '0';
reg230_adr_match_s <= '1' when wbs_in.adr = REG230_ADR else '0';
reg231_adr_match_s <= '1' when wbs_in.adr = REG231_ADR else '0';
reg232_adr_match_s <= '1' when wbs_in.adr = REG232_ADR else '0';
reg233_adr_match_s <= '1' when wbs_in.adr = REG233_ADR else '0';
reg234_adr_match_s <= '1' when wbs_in.adr = REG234_ADR else '0';
reg235_adr_match_s <= '1' when wbs_in.adr = REG235_ADR else '0';
reg236_adr_match_s <= '1' when wbs_in.adr = REG236_ADR else '0';
reg237_adr_match_s <= '1' when wbs_in.adr = REG237_ADR else '0';
reg238_adr_match_s <= '1' when wbs_in.adr = REG238_ADR else '0';
reg239_adr_match_s <= '1' when wbs_in.adr = REG239_ADR else '0';
reg240_adr_match_s <= '1' when wbs_in.adr = REG240_ADR else '0';
reg241_adr_match_s <= '1' when wbs_in.adr = REG241_ADR else '0';
reg242_adr_match_s <= '1' when wbs_in.adr = REG242_ADR else '0';
reg243_adr_match_s <= '1' when wbs_in.adr = REG243_ADR else '0';
reg244_adr_match_s <= '1' when wbs_in.adr = REG244_ADR else '0';
reg245_adr_match_s <= '1' when wbs_in.adr = REG245_ADR else '0';
reg246_adr_match_s <= '1' when wbs_in.adr = REG246_ADR else '0';
reg247_adr_match_s <= '1' when wbs_in.adr = REG247_ADR else '0';
reg248_adr_match_s <= '1' when wbs_in.adr = REG248_ADR else '0';
reg249_adr_match_s <= '1' when wbs_in.adr = REG249_ADR else '0';
reg250_adr_match_s <= '1' when wbs_in.adr = REG250_ADR else '0';
reg251_adr_match_s <= '1' when wbs_in.adr = REG251_ADR else '0';
reg252_adr_match_s <= '1' when wbs_in.adr = REG252_ADR else '0';
reg253_adr_match_s <= '1' when wbs_in.adr = REG253_ADR else '0';
reg254_adr_match_s <= '1' when wbs_in.adr = REG254_ADR else '0';
reg255_adr_match_s <= '1' when wbs_in.adr = REG255_ADR else '0';

-- register enable signals
reg0_re_s <= wbs_in.stb AND wbs_in.we AND reg0_adr_match_s;
reg1_re_s <= wbs_in.stb AND wbs_in.we AND reg1_adr_match_s;
reg2_re_s <= wbs_in.stb AND wbs_in.we AND reg2_adr_match_s;
reg3_re_s <= wbs_in.stb AND wbs_in.we AND reg3_adr_match_s;
reg4_re_s <= wbs_in.stb AND wbs_in.we AND reg4_adr_match_s;
reg5_re_s <= wbs_in.stb AND wbs_in.we AND reg5_adr_match_s;
reg6_re_s <= wbs_in.stb AND wbs_in.we AND reg6_adr_match_s;
reg7_re_s <= wbs_in.stb AND wbs_in.we AND reg7_adr_match_s;
reg8_re_s <= wbs_in.stb AND wbs_in.we AND reg8_adr_match_s;
reg9_re_s <= wbs_in.stb AND wbs_in.we AND reg9_adr_match_s;
reg10_re_s <= wbs_in.stb AND wbs_in.we AND reg10_adr_match_s;
reg11_re_s <= wbs_in.stb AND wbs_in.we AND reg11_adr_match_s;
reg12_re_s <= wbs_in.stb AND wbs_in.we AND reg12_adr_match_s;
reg13_re_s <= wbs_in.stb AND wbs_in.we AND reg13_adr_match_s;
reg14_re_s <= wbs_in.stb AND wbs_in.we AND reg14_adr_match_s;
reg15_re_s <= wbs_in.stb AND wbs_in.we AND reg15_adr_match_s;
reg16_re_s <= wbs_in.stb AND wbs_in.we AND reg16_adr_match_s;
reg17_re_s <= wbs_in.stb AND wbs_in.we AND reg17_adr_match_s;
reg18_re_s <= wbs_in.stb AND wbs_in.we AND reg18_adr_match_s;
reg19_re_s <= wbs_in.stb AND wbs_in.we AND reg19_adr_match_s;
reg20_re_s <= wbs_in.stb AND wbs_in.we AND reg20_adr_match_s;
reg21_re_s <= wbs_in.stb AND wbs_in.we AND reg21_adr_match_s;
reg22_re_s <= wbs_in.stb AND wbs_in.we AND reg22_adr_match_s;
reg23_re_s <= wbs_in.stb AND wbs_in.we AND reg23_adr_match_s;
reg24_re_s <= wbs_in.stb AND wbs_in.we AND reg24_adr_match_s;
reg25_re_s <= wbs_in.stb AND wbs_in.we AND reg25_adr_match_s;
reg26_re_s <= wbs_in.stb AND wbs_in.we AND reg26_adr_match_s;
reg27_re_s <= wbs_in.stb AND wbs_in.we AND reg27_adr_match_s;
reg28_re_s <= wbs_in.stb AND wbs_in.we AND reg28_adr_match_s;
reg29_re_s <= wbs_in.stb AND wbs_in.we AND reg29_adr_match_s;
reg30_re_s <= wbs_in.stb AND wbs_in.we AND reg30_adr_match_s;
reg31_re_s <= wbs_in.stb AND wbs_in.we AND reg31_adr_match_s;
reg32_re_s <= wbs_in.stb AND wbs_in.we AND reg32_adr_match_s;
reg33_re_s <= wbs_in.stb AND wbs_in.we AND reg33_adr_match_s;
reg34_re_s <= wbs_in.stb AND wbs_in.we AND reg34_adr_match_s;
reg35_re_s <= wbs_in.stb AND wbs_in.we AND reg35_adr_match_s;
reg36_re_s <= wbs_in.stb AND wbs_in.we AND reg36_adr_match_s;
reg37_re_s <= wbs_in.stb AND wbs_in.we AND reg37_adr_match_s;
reg38_re_s <= wbs_in.stb AND wbs_in.we AND reg38_adr_match_s;
reg39_re_s <= wbs_in.stb AND wbs_in.we AND reg39_adr_match_s;
reg40_re_s <= wbs_in.stb AND wbs_in.we AND reg40_adr_match_s;
reg41_re_s <= wbs_in.stb AND wbs_in.we AND reg41_adr_match_s;
reg42_re_s <= wbs_in.stb AND wbs_in.we AND reg42_adr_match_s;
reg43_re_s <= wbs_in.stb AND wbs_in.we AND reg43_adr_match_s;
reg44_re_s <= wbs_in.stb AND wbs_in.we AND reg44_adr_match_s;
reg45_re_s <= wbs_in.stb AND wbs_in.we AND reg45_adr_match_s;
reg46_re_s <= wbs_in.stb AND wbs_in.we AND reg46_adr_match_s;
reg47_re_s <= wbs_in.stb AND wbs_in.we AND reg47_adr_match_s;
reg48_re_s <= wbs_in.stb AND wbs_in.we AND reg48_adr_match_s;
reg49_re_s <= wbs_in.stb AND wbs_in.we AND reg49_adr_match_s;
reg50_re_s <= wbs_in.stb AND wbs_in.we AND reg50_adr_match_s;
reg51_re_s <= wbs_in.stb AND wbs_in.we AND reg51_adr_match_s;
reg52_re_s <= wbs_in.stb AND wbs_in.we AND reg52_adr_match_s;
reg53_re_s <= wbs_in.stb AND wbs_in.we AND reg53_adr_match_s;
reg54_re_s <= wbs_in.stb AND wbs_in.we AND reg54_adr_match_s;
reg55_re_s <= wbs_in.stb AND wbs_in.we AND reg55_adr_match_s;
reg56_re_s <= wbs_in.stb AND wbs_in.we AND reg56_adr_match_s;
reg57_re_s <= wbs_in.stb AND wbs_in.we AND reg57_adr_match_s;
reg58_re_s <= wbs_in.stb AND wbs_in.we AND reg58_adr_match_s;
reg59_re_s <= wbs_in.stb AND wbs_in.we AND reg59_adr_match_s;
reg60_re_s <= wbs_in.stb AND wbs_in.we AND reg60_adr_match_s;
reg61_re_s <= wbs_in.stb AND wbs_in.we AND reg61_adr_match_s;
reg62_re_s <= wbs_in.stb AND wbs_in.we AND reg62_adr_match_s;
reg63_re_s <= wbs_in.stb AND wbs_in.we AND reg63_adr_match_s;
reg64_re_s <= wbs_in.stb AND wbs_in.we AND reg64_adr_match_s;
reg65_re_s <= wbs_in.stb AND wbs_in.we AND reg65_adr_match_s;
reg66_re_s <= wbs_in.stb AND wbs_in.we AND reg66_adr_match_s;
reg67_re_s <= wbs_in.stb AND wbs_in.we AND reg67_adr_match_s;
reg68_re_s <= wbs_in.stb AND wbs_in.we AND reg68_adr_match_s;
reg69_re_s <= wbs_in.stb AND wbs_in.we AND reg69_adr_match_s;
reg70_re_s <= wbs_in.stb AND wbs_in.we AND reg70_adr_match_s;
reg71_re_s <= wbs_in.stb AND wbs_in.we AND reg71_adr_match_s;
reg72_re_s <= wbs_in.stb AND wbs_in.we AND reg72_adr_match_s;
reg73_re_s <= wbs_in.stb AND wbs_in.we AND reg73_adr_match_s;
reg74_re_s <= wbs_in.stb AND wbs_in.we AND reg74_adr_match_s;
reg75_re_s <= wbs_in.stb AND wbs_in.we AND reg75_adr_match_s;
reg76_re_s <= wbs_in.stb AND wbs_in.we AND reg76_adr_match_s;
reg77_re_s <= wbs_in.stb AND wbs_in.we AND reg77_adr_match_s;
reg78_re_s <= wbs_in.stb AND wbs_in.we AND reg78_adr_match_s;
reg79_re_s <= wbs_in.stb AND wbs_in.we AND reg79_adr_match_s;
reg80_re_s <= wbs_in.stb AND wbs_in.we AND reg80_adr_match_s;
reg81_re_s <= wbs_in.stb AND wbs_in.we AND reg81_adr_match_s;
reg82_re_s <= wbs_in.stb AND wbs_in.we AND reg82_adr_match_s;
reg83_re_s <= wbs_in.stb AND wbs_in.we AND reg83_adr_match_s;
reg84_re_s <= wbs_in.stb AND wbs_in.we AND reg84_adr_match_s;
reg85_re_s <= wbs_in.stb AND wbs_in.we AND reg85_adr_match_s;
reg86_re_s <= wbs_in.stb AND wbs_in.we AND reg86_adr_match_s;
reg87_re_s <= wbs_in.stb AND wbs_in.we AND reg87_adr_match_s;
reg88_re_s <= wbs_in.stb AND wbs_in.we AND reg88_adr_match_s;
reg89_re_s <= wbs_in.stb AND wbs_in.we AND reg89_adr_match_s;
reg90_re_s <= wbs_in.stb AND wbs_in.we AND reg90_adr_match_s;
reg91_re_s <= wbs_in.stb AND wbs_in.we AND reg91_adr_match_s;
reg92_re_s <= wbs_in.stb AND wbs_in.we AND reg92_adr_match_s;
reg93_re_s <= wbs_in.stb AND wbs_in.we AND reg93_adr_match_s;
reg94_re_s <= wbs_in.stb AND wbs_in.we AND reg94_adr_match_s;
reg95_re_s <= wbs_in.stb AND wbs_in.we AND reg95_adr_match_s;
reg96_re_s <= wbs_in.stb AND wbs_in.we AND reg96_adr_match_s;
reg97_re_s <= wbs_in.stb AND wbs_in.we AND reg97_adr_match_s;
reg98_re_s <= wbs_in.stb AND wbs_in.we AND reg98_adr_match_s;
reg99_re_s <= wbs_in.stb AND wbs_in.we AND reg99_adr_match_s;
reg100_re_s <= wbs_in.stb AND wbs_in.we AND reg100_adr_match_s;
reg101_re_s <= wbs_in.stb AND wbs_in.we AND reg101_adr_match_s;
reg102_re_s <= wbs_in.stb AND wbs_in.we AND reg102_adr_match_s;
reg103_re_s <= wbs_in.stb AND wbs_in.we AND reg103_adr_match_s;
reg104_re_s <= wbs_in.stb AND wbs_in.we AND reg104_adr_match_s;
reg105_re_s <= wbs_in.stb AND wbs_in.we AND reg105_adr_match_s;
reg106_re_s <= wbs_in.stb AND wbs_in.we AND reg106_adr_match_s;
reg107_re_s <= wbs_in.stb AND wbs_in.we AND reg107_adr_match_s;
reg108_re_s <= wbs_in.stb AND wbs_in.we AND reg108_adr_match_s;
reg109_re_s <= wbs_in.stb AND wbs_in.we AND reg109_adr_match_s;
reg110_re_s <= wbs_in.stb AND wbs_in.we AND reg110_adr_match_s;
reg111_re_s <= wbs_in.stb AND wbs_in.we AND reg111_adr_match_s;
reg112_re_s <= wbs_in.stb AND wbs_in.we AND reg112_adr_match_s;
reg113_re_s <= wbs_in.stb AND wbs_in.we AND reg113_adr_match_s;
reg114_re_s <= wbs_in.stb AND wbs_in.we AND reg114_adr_match_s;
reg115_re_s <= wbs_in.stb AND wbs_in.we AND reg115_adr_match_s;
reg116_re_s <= wbs_in.stb AND wbs_in.we AND reg116_adr_match_s;
reg117_re_s <= wbs_in.stb AND wbs_in.we AND reg117_adr_match_s;
reg118_re_s <= wbs_in.stb AND wbs_in.we AND reg118_adr_match_s;
reg119_re_s <= wbs_in.stb AND wbs_in.we AND reg119_adr_match_s;
reg120_re_s <= wbs_in.stb AND wbs_in.we AND reg120_adr_match_s;
reg121_re_s <= wbs_in.stb AND wbs_in.we AND reg121_adr_match_s;
reg122_re_s <= wbs_in.stb AND wbs_in.we AND reg122_adr_match_s;
reg123_re_s <= wbs_in.stb AND wbs_in.we AND reg123_adr_match_s;
reg124_re_s <= wbs_in.stb AND wbs_in.we AND reg124_adr_match_s;
reg125_re_s <= wbs_in.stb AND wbs_in.we AND reg125_adr_match_s;
reg126_re_s <= wbs_in.stb AND wbs_in.we AND reg126_adr_match_s;
reg127_re_s <= wbs_in.stb AND wbs_in.we AND reg127_adr_match_s;
reg128_re_s <= wbs_in.stb AND wbs_in.we AND reg128_adr_match_s;
reg129_re_s <= wbs_in.stb AND wbs_in.we AND reg129_adr_match_s;
reg130_re_s <= wbs_in.stb AND wbs_in.we AND reg130_adr_match_s;
reg131_re_s <= wbs_in.stb AND wbs_in.we AND reg131_adr_match_s;
reg132_re_s <= wbs_in.stb AND wbs_in.we AND reg132_adr_match_s;
reg133_re_s <= wbs_in.stb AND wbs_in.we AND reg133_adr_match_s;
reg134_re_s <= wbs_in.stb AND wbs_in.we AND reg134_adr_match_s;
reg135_re_s <= wbs_in.stb AND wbs_in.we AND reg135_adr_match_s;
reg136_re_s <= wbs_in.stb AND wbs_in.we AND reg136_adr_match_s;
reg137_re_s <= wbs_in.stb AND wbs_in.we AND reg137_adr_match_s;
reg138_re_s <= wbs_in.stb AND wbs_in.we AND reg138_adr_match_s;
reg139_re_s <= wbs_in.stb AND wbs_in.we AND reg139_adr_match_s;
reg140_re_s <= wbs_in.stb AND wbs_in.we AND reg140_adr_match_s;
reg141_re_s <= wbs_in.stb AND wbs_in.we AND reg141_adr_match_s;
reg142_re_s <= wbs_in.stb AND wbs_in.we AND reg142_adr_match_s;
reg143_re_s <= wbs_in.stb AND wbs_in.we AND reg143_adr_match_s;
reg144_re_s <= wbs_in.stb AND wbs_in.we AND reg144_adr_match_s;
reg145_re_s <= wbs_in.stb AND wbs_in.we AND reg145_adr_match_s;
reg146_re_s <= wbs_in.stb AND wbs_in.we AND reg146_adr_match_s;
reg147_re_s <= wbs_in.stb AND wbs_in.we AND reg147_adr_match_s;
reg148_re_s <= wbs_in.stb AND wbs_in.we AND reg148_adr_match_s;
reg149_re_s <= wbs_in.stb AND wbs_in.we AND reg149_adr_match_s;
reg150_re_s <= wbs_in.stb AND wbs_in.we AND reg150_adr_match_s;
reg151_re_s <= wbs_in.stb AND wbs_in.we AND reg151_adr_match_s;
reg152_re_s <= wbs_in.stb AND wbs_in.we AND reg152_adr_match_s;
reg153_re_s <= wbs_in.stb AND wbs_in.we AND reg153_adr_match_s;
reg154_re_s <= wbs_in.stb AND wbs_in.we AND reg154_adr_match_s;
reg155_re_s <= wbs_in.stb AND wbs_in.we AND reg155_adr_match_s;
reg156_re_s <= wbs_in.stb AND wbs_in.we AND reg156_adr_match_s;
reg157_re_s <= wbs_in.stb AND wbs_in.we AND reg157_adr_match_s;
reg158_re_s <= wbs_in.stb AND wbs_in.we AND reg158_adr_match_s;
reg159_re_s <= wbs_in.stb AND wbs_in.we AND reg159_adr_match_s;
reg160_re_s <= wbs_in.stb AND wbs_in.we AND reg160_adr_match_s;
reg161_re_s <= wbs_in.stb AND wbs_in.we AND reg161_adr_match_s;
reg162_re_s <= wbs_in.stb AND wbs_in.we AND reg162_adr_match_s;
reg163_re_s <= wbs_in.stb AND wbs_in.we AND reg163_adr_match_s;
reg164_re_s <= wbs_in.stb AND wbs_in.we AND reg164_adr_match_s;
reg165_re_s <= wbs_in.stb AND wbs_in.we AND reg165_adr_match_s;
reg166_re_s <= wbs_in.stb AND wbs_in.we AND reg166_adr_match_s;
reg167_re_s <= wbs_in.stb AND wbs_in.we AND reg167_adr_match_s;
reg168_re_s <= wbs_in.stb AND wbs_in.we AND reg168_adr_match_s;
reg169_re_s <= wbs_in.stb AND wbs_in.we AND reg169_adr_match_s;
reg170_re_s <= wbs_in.stb AND wbs_in.we AND reg170_adr_match_s;
reg171_re_s <= wbs_in.stb AND wbs_in.we AND reg171_adr_match_s;
reg172_re_s <= wbs_in.stb AND wbs_in.we AND reg172_adr_match_s;
reg173_re_s <= wbs_in.stb AND wbs_in.we AND reg173_adr_match_s;
reg174_re_s <= wbs_in.stb AND wbs_in.we AND reg174_adr_match_s;
reg175_re_s <= wbs_in.stb AND wbs_in.we AND reg175_adr_match_s;
reg176_re_s <= wbs_in.stb AND wbs_in.we AND reg176_adr_match_s;
reg177_re_s <= wbs_in.stb AND wbs_in.we AND reg177_adr_match_s;
reg178_re_s <= wbs_in.stb AND wbs_in.we AND reg178_adr_match_s;
reg179_re_s <= wbs_in.stb AND wbs_in.we AND reg179_adr_match_s;
reg180_re_s <= wbs_in.stb AND wbs_in.we AND reg180_adr_match_s;
reg181_re_s <= wbs_in.stb AND wbs_in.we AND reg181_adr_match_s;
reg182_re_s <= wbs_in.stb AND wbs_in.we AND reg182_adr_match_s;
reg183_re_s <= wbs_in.stb AND wbs_in.we AND reg183_adr_match_s;
reg184_re_s <= wbs_in.stb AND wbs_in.we AND reg184_adr_match_s;
reg185_re_s <= wbs_in.stb AND wbs_in.we AND reg185_adr_match_s;
reg186_re_s <= wbs_in.stb AND wbs_in.we AND reg186_adr_match_s;
reg187_re_s <= wbs_in.stb AND wbs_in.we AND reg187_adr_match_s;
reg188_re_s <= wbs_in.stb AND wbs_in.we AND reg188_adr_match_s;
reg189_re_s <= wbs_in.stb AND wbs_in.we AND reg189_adr_match_s;
reg190_re_s <= wbs_in.stb AND wbs_in.we AND reg190_adr_match_s;
reg191_re_s <= wbs_in.stb AND wbs_in.we AND reg191_adr_match_s;
reg192_re_s <= wbs_in.stb AND wbs_in.we AND reg192_adr_match_s;
reg193_re_s <= wbs_in.stb AND wbs_in.we AND reg193_adr_match_s;
reg194_re_s <= wbs_in.stb AND wbs_in.we AND reg194_adr_match_s;
reg195_re_s <= wbs_in.stb AND wbs_in.we AND reg195_adr_match_s;
reg196_re_s <= wbs_in.stb AND wbs_in.we AND reg196_adr_match_s;
reg197_re_s <= wbs_in.stb AND wbs_in.we AND reg197_adr_match_s;
reg198_re_s <= wbs_in.stb AND wbs_in.we AND reg198_adr_match_s;
reg199_re_s <= wbs_in.stb AND wbs_in.we AND reg199_adr_match_s;
reg200_re_s <= wbs_in.stb AND wbs_in.we AND reg200_adr_match_s;
reg201_re_s <= wbs_in.stb AND wbs_in.we AND reg201_adr_match_s;
reg202_re_s <= wbs_in.stb AND wbs_in.we AND reg202_adr_match_s;
reg203_re_s <= wbs_in.stb AND wbs_in.we AND reg203_adr_match_s;
reg204_re_s <= wbs_in.stb AND wbs_in.we AND reg204_adr_match_s;
reg205_re_s <= wbs_in.stb AND wbs_in.we AND reg205_adr_match_s;
reg206_re_s <= wbs_in.stb AND wbs_in.we AND reg206_adr_match_s;
reg207_re_s <= wbs_in.stb AND wbs_in.we AND reg207_adr_match_s;
reg208_re_s <= wbs_in.stb AND wbs_in.we AND reg208_adr_match_s;
reg209_re_s <= wbs_in.stb AND wbs_in.we AND reg209_adr_match_s;
reg210_re_s <= wbs_in.stb AND wbs_in.we AND reg210_adr_match_s;
reg211_re_s <= wbs_in.stb AND wbs_in.we AND reg211_adr_match_s;
reg212_re_s <= wbs_in.stb AND wbs_in.we AND reg212_adr_match_s;
reg213_re_s <= wbs_in.stb AND wbs_in.we AND reg213_adr_match_s;
reg214_re_s <= wbs_in.stb AND wbs_in.we AND reg214_adr_match_s;
reg215_re_s <= wbs_in.stb AND wbs_in.we AND reg215_adr_match_s;
reg216_re_s <= wbs_in.stb AND wbs_in.we AND reg216_adr_match_s;
reg217_re_s <= wbs_in.stb AND wbs_in.we AND reg217_adr_match_s;
reg218_re_s <= wbs_in.stb AND wbs_in.we AND reg218_adr_match_s;
reg219_re_s <= wbs_in.stb AND wbs_in.we AND reg219_adr_match_s;
reg220_re_s <= wbs_in.stb AND wbs_in.we AND reg220_adr_match_s;
reg221_re_s <= wbs_in.stb AND wbs_in.we AND reg221_adr_match_s;
reg222_re_s <= wbs_in.stb AND wbs_in.we AND reg222_adr_match_s;
reg223_re_s <= wbs_in.stb AND wbs_in.we AND reg223_adr_match_s;
reg224_re_s <= wbs_in.stb AND wbs_in.we AND reg224_adr_match_s;
reg225_re_s <= wbs_in.stb AND wbs_in.we AND reg225_adr_match_s;
reg226_re_s <= wbs_in.stb AND wbs_in.we AND reg226_adr_match_s;
reg227_re_s <= wbs_in.stb AND wbs_in.we AND reg227_adr_match_s;
reg228_re_s <= wbs_in.stb AND wbs_in.we AND reg228_adr_match_s;
reg229_re_s <= wbs_in.stb AND wbs_in.we AND reg229_adr_match_s;
reg230_re_s <= wbs_in.stb AND wbs_in.we AND reg230_adr_match_s;
reg231_re_s <= wbs_in.stb AND wbs_in.we AND reg231_adr_match_s;
reg232_re_s <= wbs_in.stb AND wbs_in.we AND reg232_adr_match_s;
reg233_re_s <= wbs_in.stb AND wbs_in.we AND reg233_adr_match_s;
reg234_re_s <= wbs_in.stb AND wbs_in.we AND reg234_adr_match_s;
reg235_re_s <= wbs_in.stb AND wbs_in.we AND reg235_adr_match_s;
reg236_re_s <= wbs_in.stb AND wbs_in.we AND reg236_adr_match_s;
reg237_re_s <= wbs_in.stb AND wbs_in.we AND reg237_adr_match_s;
reg238_re_s <= wbs_in.stb AND wbs_in.we AND reg238_adr_match_s;
reg239_re_s <= wbs_in.stb AND wbs_in.we AND reg239_adr_match_s;
reg240_re_s <= wbs_in.stb AND wbs_in.we AND reg240_adr_match_s;
reg241_re_s <= wbs_in.stb AND wbs_in.we AND reg241_adr_match_s;
reg242_re_s <= wbs_in.stb AND wbs_in.we AND reg242_adr_match_s;
reg243_re_s <= wbs_in.stb AND wbs_in.we AND reg243_adr_match_s;
reg244_re_s <= wbs_in.stb AND wbs_in.we AND reg244_adr_match_s;
reg245_re_s <= wbs_in.stb AND wbs_in.we AND reg245_adr_match_s;
reg246_re_s <= wbs_in.stb AND wbs_in.we AND reg246_adr_match_s;
reg247_re_s <= wbs_in.stb AND wbs_in.we AND reg247_adr_match_s;
reg248_re_s <= wbs_in.stb AND wbs_in.we AND reg248_adr_match_s;
reg249_re_s <= wbs_in.stb AND wbs_in.we AND reg249_adr_match_s;
reg250_re_s <= wbs_in.stb AND wbs_in.we AND reg250_adr_match_s;
reg251_re_s <= wbs_in.stb AND wbs_in.we AND reg251_adr_match_s;
reg252_re_s <= wbs_in.stb AND wbs_in.we AND reg252_adr_match_s;
reg253_re_s <= wbs_in.stb AND wbs_in.we AND reg253_adr_match_s;
reg254_re_s <= wbs_in.stb AND wbs_in.we AND reg254_adr_match_s;
reg255_re_s <= wbs_in.stb AND wbs_in.we AND reg255_adr_match_s;

-- acknowledge output
wbs_out.ack <= wbs_in.stb;

-- register inputs always get data from wbs_in
reg_in_s.reg0 <= wbs_in.dat;
reg_in_s.reg1 <= wbs_in.dat;
reg_in_s.reg2 <= wbs_in.dat;
reg_in_s.reg3 <= wbs_in.dat;
reg_in_s.reg4 <= wbs_in.dat;
reg_in_s.reg5 <= wbs_in.dat;
reg_in_s.reg6 <= wbs_in.dat;
reg_in_s.reg7 <= wbs_in.dat;
reg_in_s.reg8 <= wbs_in.dat;
reg_in_s.reg9 <= wbs_in.dat;
reg_in_s.reg10 <= wbs_in.dat;
reg_in_s.reg11 <= wbs_in.dat;
reg_in_s.reg12 <= wbs_in.dat;
reg_in_s.reg13 <= wbs_in.dat;
reg_in_s.reg14 <= wbs_in.dat;
reg_in_s.reg15 <= wbs_in.dat;
reg_in_s.reg16 <= wbs_in.dat;
reg_in_s.reg17 <= wbs_in.dat;
reg_in_s.reg18 <= wbs_in.dat;
reg_in_s.reg19 <= wbs_in.dat;
reg_in_s.reg20 <= wbs_in.dat;
reg_in_s.reg21 <= wbs_in.dat;
reg_in_s.reg22 <= wbs_in.dat;
reg_in_s.reg23 <= wbs_in.dat;
reg_in_s.reg24 <= wbs_in.dat;
reg_in_s.reg25 <= wbs_in.dat;
reg_in_s.reg26 <= wbs_in.dat;
reg_in_s.reg27 <= wbs_in.dat;
reg_in_s.reg28 <= wbs_in.dat;
reg_in_s.reg29 <= wbs_in.dat;
reg_in_s.reg30 <= wbs_in.dat;
reg_in_s.reg31 <= wbs_in.dat;
reg_in_s.reg32 <= wbs_in.dat;
reg_in_s.reg33 <= wbs_in.dat;
reg_in_s.reg34 <= wbs_in.dat;
reg_in_s.reg35 <= wbs_in.dat;
reg_in_s.reg36 <= wbs_in.dat;
reg_in_s.reg37 <= wbs_in.dat;
reg_in_s.reg38 <= wbs_in.dat;
reg_in_s.reg39 <= wbs_in.dat;
reg_in_s.reg40 <= wbs_in.dat;
reg_in_s.reg41 <= wbs_in.dat;
reg_in_s.reg42 <= wbs_in.dat;
reg_in_s.reg43 <= wbs_in.dat;
reg_in_s.reg44 <= wbs_in.dat;
reg_in_s.reg45 <= wbs_in.dat;
reg_in_s.reg46 <= wbs_in.dat;
reg_in_s.reg47 <= wbs_in.dat;
reg_in_s.reg48 <= wbs_in.dat;
reg_in_s.reg49 <= wbs_in.dat;
reg_in_s.reg50 <= wbs_in.dat;
reg_in_s.reg51 <= wbs_in.dat;
reg_in_s.reg52 <= wbs_in.dat;
reg_in_s.reg53 <= wbs_in.dat;
reg_in_s.reg54 <= wbs_in.dat;
reg_in_s.reg55 <= wbs_in.dat;
reg_in_s.reg56 <= wbs_in.dat;
reg_in_s.reg57 <= wbs_in.dat;
reg_in_s.reg58 <= wbs_in.dat;
reg_in_s.reg59 <= wbs_in.dat;
reg_in_s.reg60 <= wbs_in.dat;
reg_in_s.reg61 <= wbs_in.dat;
reg_in_s.reg62 <= wbs_in.dat;
reg_in_s.reg63 <= wbs_in.dat;
reg_in_s.reg64 <= wbs_in.dat;
reg_in_s.reg65 <= wbs_in.dat;
reg_in_s.reg66 <= wbs_in.dat;
reg_in_s.reg67 <= wbs_in.dat;
reg_in_s.reg68 <= wbs_in.dat;
reg_in_s.reg69 <= wbs_in.dat;
reg_in_s.reg70 <= wbs_in.dat;
reg_in_s.reg71 <= wbs_in.dat;
reg_in_s.reg72 <= wbs_in.dat;
reg_in_s.reg73 <= wbs_in.dat;
reg_in_s.reg74 <= wbs_in.dat;
reg_in_s.reg75 <= wbs_in.dat;
reg_in_s.reg76 <= wbs_in.dat;
reg_in_s.reg77 <= wbs_in.dat;
reg_in_s.reg78 <= wbs_in.dat;
reg_in_s.reg79 <= wbs_in.dat;
reg_in_s.reg80 <= wbs_in.dat;
reg_in_s.reg81 <= wbs_in.dat;
reg_in_s.reg82 <= wbs_in.dat;
reg_in_s.reg83 <= wbs_in.dat;
reg_in_s.reg84 <= wbs_in.dat;
reg_in_s.reg85 <= wbs_in.dat;
reg_in_s.reg86 <= wbs_in.dat;
reg_in_s.reg87 <= wbs_in.dat;
reg_in_s.reg88 <= wbs_in.dat;
reg_in_s.reg89 <= wbs_in.dat;
reg_in_s.reg90 <= wbs_in.dat;
reg_in_s.reg91 <= wbs_in.dat;
reg_in_s.reg92 <= wbs_in.dat;
reg_in_s.reg93 <= wbs_in.dat;
reg_in_s.reg94 <= wbs_in.dat;
reg_in_s.reg95 <= wbs_in.dat;
reg_in_s.reg96 <= wbs_in.dat;
reg_in_s.reg97 <= wbs_in.dat;
reg_in_s.reg98 <= wbs_in.dat;
reg_in_s.reg99 <= wbs_in.dat;
reg_in_s.reg100 <= wbs_in.dat;
reg_in_s.reg101 <= wbs_in.dat;
reg_in_s.reg102 <= wbs_in.dat;
reg_in_s.reg103 <= wbs_in.dat;
reg_in_s.reg104 <= wbs_in.dat;
reg_in_s.reg105 <= wbs_in.dat;
reg_in_s.reg106 <= wbs_in.dat;
reg_in_s.reg107 <= wbs_in.dat;
reg_in_s.reg108 <= wbs_in.dat;
reg_in_s.reg109 <= wbs_in.dat;
reg_in_s.reg110 <= wbs_in.dat;
reg_in_s.reg111 <= wbs_in.dat;
reg_in_s.reg112 <= wbs_in.dat;
reg_in_s.reg113 <= wbs_in.dat;
reg_in_s.reg114 <= wbs_in.dat;
reg_in_s.reg115 <= wbs_in.dat;
reg_in_s.reg116 <= wbs_in.dat;
reg_in_s.reg117 <= wbs_in.dat;
reg_in_s.reg118 <= wbs_in.dat;
reg_in_s.reg119 <= wbs_in.dat;
reg_in_s.reg120 <= wbs_in.dat;
reg_in_s.reg121 <= wbs_in.dat;
reg_in_s.reg122 <= wbs_in.dat;
reg_in_s.reg123 <= wbs_in.dat;
reg_in_s.reg124 <= wbs_in.dat;
reg_in_s.reg125 <= wbs_in.dat;
reg_in_s.reg126 <= wbs_in.dat;
reg_in_s.reg127 <= wbs_in.dat;
reg_in_s.reg128 <= wbs_in.dat;
reg_in_s.reg129 <= wbs_in.dat;
reg_in_s.reg130 <= wbs_in.dat;
reg_in_s.reg131 <= wbs_in.dat;
reg_in_s.reg132 <= wbs_in.dat;
reg_in_s.reg133 <= wbs_in.dat;
reg_in_s.reg134 <= wbs_in.dat;
reg_in_s.reg135 <= wbs_in.dat;
reg_in_s.reg136 <= wbs_in.dat;
reg_in_s.reg137 <= wbs_in.dat;
reg_in_s.reg138 <= wbs_in.dat;
reg_in_s.reg139 <= wbs_in.dat;
reg_in_s.reg140 <= wbs_in.dat;
reg_in_s.reg141 <= wbs_in.dat;
reg_in_s.reg142 <= wbs_in.dat;
reg_in_s.reg143 <= wbs_in.dat;
reg_in_s.reg144 <= wbs_in.dat;
reg_in_s.reg145 <= wbs_in.dat;
reg_in_s.reg146 <= wbs_in.dat;
reg_in_s.reg147 <= wbs_in.dat;
reg_in_s.reg148 <= wbs_in.dat;
reg_in_s.reg149 <= wbs_in.dat;
reg_in_s.reg150 <= wbs_in.dat;
reg_in_s.reg151 <= wbs_in.dat;
reg_in_s.reg152 <= wbs_in.dat;
reg_in_s.reg153 <= wbs_in.dat;
reg_in_s.reg154 <= wbs_in.dat;
reg_in_s.reg155 <= wbs_in.dat;
reg_in_s.reg156 <= wbs_in.dat;
reg_in_s.reg157 <= wbs_in.dat;
reg_in_s.reg158 <= wbs_in.dat;
reg_in_s.reg159 <= wbs_in.dat;
reg_in_s.reg160 <= wbs_in.dat;
reg_in_s.reg161 <= wbs_in.dat;
reg_in_s.reg162 <= wbs_in.dat;
reg_in_s.reg163 <= wbs_in.dat;
reg_in_s.reg164 <= wbs_in.dat;
reg_in_s.reg165 <= wbs_in.dat;
reg_in_s.reg166 <= wbs_in.dat;
reg_in_s.reg167 <= wbs_in.dat;
reg_in_s.reg168 <= wbs_in.dat;
reg_in_s.reg169 <= wbs_in.dat;
reg_in_s.reg170 <= wbs_in.dat;
reg_in_s.reg171 <= wbs_in.dat;
reg_in_s.reg172 <= wbs_in.dat;
reg_in_s.reg173 <= wbs_in.dat;
reg_in_s.reg174 <= wbs_in.dat;
reg_in_s.reg175 <= wbs_in.dat;
reg_in_s.reg176 <= wbs_in.dat;
reg_in_s.reg177 <= wbs_in.dat;
reg_in_s.reg178 <= wbs_in.dat;
reg_in_s.reg179 <= wbs_in.dat;
reg_in_s.reg180 <= wbs_in.dat;
reg_in_s.reg181 <= wbs_in.dat;
reg_in_s.reg182 <= wbs_in.dat;
reg_in_s.reg183 <= wbs_in.dat;
reg_in_s.reg184 <= wbs_in.dat;
reg_in_s.reg185 <= wbs_in.dat;
reg_in_s.reg186 <= wbs_in.dat;
reg_in_s.reg187 <= wbs_in.dat;
reg_in_s.reg188 <= wbs_in.dat;
reg_in_s.reg189 <= wbs_in.dat;
reg_in_s.reg190 <= wbs_in.dat;
reg_in_s.reg191 <= wbs_in.dat;
reg_in_s.reg192 <= wbs_in.dat;
reg_in_s.reg193 <= wbs_in.dat;
reg_in_s.reg194 <= wbs_in.dat;
reg_in_s.reg195 <= wbs_in.dat;
reg_in_s.reg196 <= wbs_in.dat;
reg_in_s.reg197 <= wbs_in.dat;
reg_in_s.reg198 <= wbs_in.dat;
reg_in_s.reg199 <= wbs_in.dat;
reg_in_s.reg200 <= wbs_in.dat;
reg_in_s.reg201 <= wbs_in.dat;
reg_in_s.reg202 <= wbs_in.dat;
reg_in_s.reg203 <= wbs_in.dat;
reg_in_s.reg204 <= wbs_in.dat;
reg_in_s.reg205 <= wbs_in.dat;
reg_in_s.reg206 <= wbs_in.dat;
reg_in_s.reg207 <= wbs_in.dat;
reg_in_s.reg208 <= wbs_in.dat;
reg_in_s.reg209 <= wbs_in.dat;
reg_in_s.reg210 <= wbs_in.dat;
reg_in_s.reg211 <= wbs_in.dat;
reg_in_s.reg212 <= wbs_in.dat;
reg_in_s.reg213 <= wbs_in.dat;
reg_in_s.reg214 <= wbs_in.dat;
reg_in_s.reg215 <= wbs_in.dat;
reg_in_s.reg216 <= wbs_in.dat;
reg_in_s.reg217 <= wbs_in.dat;
reg_in_s.reg218 <= wbs_in.dat;
reg_in_s.reg219 <= wbs_in.dat;
reg_in_s.reg220 <= wbs_in.dat;
reg_in_s.reg221 <= wbs_in.dat;
reg_in_s.reg222 <= wbs_in.dat;
reg_in_s.reg223 <= wbs_in.dat;
reg_in_s.reg224 <= wbs_in.dat;
reg_in_s.reg225 <= wbs_in.dat;
reg_in_s.reg226 <= wbs_in.dat;
reg_in_s.reg227 <= wbs_in.dat;
reg_in_s.reg228 <= wbs_in.dat;
reg_in_s.reg229 <= wbs_in.dat;
reg_in_s.reg230 <= wbs_in.dat;
reg_in_s.reg231 <= wbs_in.dat;
reg_in_s.reg232 <= wbs_in.dat;
reg_in_s.reg233 <= wbs_in.dat;
reg_in_s.reg234 <= wbs_in.dat;
reg_in_s.reg235 <= wbs_in.dat;
reg_in_s.reg236 <= wbs_in.dat;
reg_in_s.reg237 <= wbs_in.dat;
reg_in_s.reg238 <= wbs_in.dat;
reg_in_s.reg239 <= wbs_in.dat;
reg_in_s.reg240 <= wbs_in.dat;
reg_in_s.reg241 <= wbs_in.dat;
reg_in_s.reg242 <= wbs_in.dat;
reg_in_s.reg243 <= wbs_in.dat;
reg_in_s.reg244 <= wbs_in.dat;
reg_in_s.reg245 <= wbs_in.dat;
reg_in_s.reg246 <= wbs_in.dat;
reg_in_s.reg247 <= wbs_in.dat;
reg_in_s.reg248 <= wbs_in.dat;
reg_in_s.reg249 <= wbs_in.dat;
reg_in_s.reg250 <= wbs_in.dat;
reg_in_s.reg251 <= wbs_in.dat;
reg_in_s.reg252 <= wbs_in.dat;
reg_in_s.reg253 <= wbs_in.dat;
reg_in_s.reg254 <= wbs_in.dat;
reg_in_s.reg255 <= wbs_in.dat;

-- register output -> wbs_out via demultiplexer
with wbs_in.adr select
   wbs_out.dat <= reg_out_s.reg0   when REG0_ADR,
                  reg_out_s.reg1   when REG1_ADR,
                  reg_out_s.reg2   when REG2_ADR,
                  reg_out_s.reg3   when REG3_ADR,
                  reg_out_s.reg4   when REG4_ADR,
                  reg_out_s.reg5   when REG5_ADR,
                  reg_out_s.reg6   when REG6_ADR,
                  reg_out_s.reg7   when REG7_ADR,
                  reg_out_s.reg8   when REG8_ADR,
                  reg_out_s.reg9   when REG9_ADR,
                  reg_out_s.reg10   when REG10_ADR,
                  reg_out_s.reg11   when REG11_ADR,
                  reg_out_s.reg12   when REG12_ADR,
                  reg_out_s.reg13   when REG13_ADR,
                  reg_out_s.reg14   when REG14_ADR,
                  reg_out_s.reg15   when REG15_ADR,
                  reg_out_s.reg16   when REG16_ADR,
                  reg_out_s.reg17   when REG17_ADR,
                  reg_out_s.reg18   when REG18_ADR,
                  reg_out_s.reg19   when REG19_ADR,
                  reg_out_s.reg20   when REG20_ADR,
                  reg_out_s.reg21   when REG21_ADR,
                  reg_out_s.reg22   when REG22_ADR,
                  reg_out_s.reg23   when REG23_ADR,
                  reg_out_s.reg24   when REG24_ADR,
                  reg_out_s.reg25   when REG25_ADR,
                  reg_out_s.reg26   when REG26_ADR,
                  reg_out_s.reg27   when REG27_ADR,
                  reg_out_s.reg28   when REG28_ADR,
                  reg_out_s.reg29   when REG29_ADR,
                  reg_out_s.reg30   when REG30_ADR,
                  reg_out_s.reg31   when REG31_ADR,
                  reg_out_s.reg32   when REG32_ADR,
                  reg_out_s.reg33   when REG33_ADR,
                  reg_out_s.reg34   when REG34_ADR,
                  reg_out_s.reg35   when REG35_ADR,
                  reg_out_s.reg36   when REG36_ADR,
                  reg_out_s.reg37   when REG37_ADR,
                  reg_out_s.reg38   when REG38_ADR,
                  reg_out_s.reg39   when REG39_ADR,
                  reg_out_s.reg40   when REG40_ADR,
                  reg_out_s.reg41   when REG41_ADR,
                  reg_out_s.reg42   when REG42_ADR,
                  reg_out_s.reg43   when REG43_ADR,
                  reg_out_s.reg44   when REG44_ADR,
                  reg_out_s.reg45   when REG45_ADR,
                  reg_out_s.reg46   when REG46_ADR,
                  reg_out_s.reg47   when REG47_ADR,
                  reg_out_s.reg48   when REG48_ADR,
                  reg_out_s.reg49   when REG49_ADR,
                  reg_out_s.reg50   when REG50_ADR,
                  reg_out_s.reg51   when REG51_ADR,
                  reg_out_s.reg52   when REG52_ADR,
                  reg_out_s.reg53   when REG53_ADR,
                  reg_out_s.reg54   when REG54_ADR,
                  reg_out_s.reg55   when REG55_ADR,
                  reg_out_s.reg56   when REG56_ADR,
                  reg_out_s.reg57   when REG57_ADR,
                  reg_out_s.reg58   when REG58_ADR,
                  reg_out_s.reg59   when REG59_ADR,
                  reg_out_s.reg60   when REG60_ADR,
                  reg_out_s.reg61   when REG61_ADR,
                  reg_out_s.reg62   when REG62_ADR,
                  reg_out_s.reg63   when REG63_ADR,
                  reg_out_s.reg64   when REG64_ADR,
                  reg_out_s.reg65   when REG65_ADR,
                  reg_out_s.reg66   when REG66_ADR,
                  reg_out_s.reg67   when REG67_ADR,
                  reg_out_s.reg68   when REG68_ADR,
                  reg_out_s.reg69   when REG69_ADR,
                  reg_out_s.reg70   when REG70_ADR,
                  reg_out_s.reg71   when REG71_ADR,
                  reg_out_s.reg72   when REG72_ADR,
                  reg_out_s.reg73   when REG73_ADR,
                  reg_out_s.reg74   when REG74_ADR,
                  reg_out_s.reg75   when REG75_ADR,
                  reg_out_s.reg76   when REG76_ADR,
                  reg_out_s.reg77   when REG77_ADR,
                  reg_out_s.reg78   when REG78_ADR,
                  reg_out_s.reg79   when REG79_ADR,
                  reg_out_s.reg80   when REG80_ADR,
                  reg_out_s.reg81   when REG81_ADR,
                  reg_out_s.reg82   when REG82_ADR,
                  reg_out_s.reg83   when REG83_ADR,
                  reg_out_s.reg84   when REG84_ADR,
                  reg_out_s.reg85   when REG85_ADR,
                  reg_out_s.reg86   when REG86_ADR,
                  reg_out_s.reg87   when REG87_ADR,
                  reg_out_s.reg88   when REG88_ADR,
                  reg_out_s.reg89   when REG89_ADR,
                  reg_out_s.reg90   when REG90_ADR,
                  reg_out_s.reg91   when REG91_ADR,
                  reg_out_s.reg92   when REG92_ADR,
                  reg_out_s.reg93   when REG93_ADR,
                  reg_out_s.reg94   when REG94_ADR,
                  reg_out_s.reg95   when REG95_ADR,
                  reg_out_s.reg96   when REG96_ADR,
                  reg_out_s.reg97   when REG97_ADR,
                  reg_out_s.reg98   when REG98_ADR,
                  reg_out_s.reg99   when REG99_ADR,
                  reg_out_s.reg100   when REG100_ADR,
                  reg_out_s.reg101   when REG101_ADR,
                  reg_out_s.reg102   when REG102_ADR,
                  reg_out_s.reg103   when REG103_ADR,
                  reg_out_s.reg104   when REG104_ADR,
                  reg_out_s.reg105   when REG105_ADR,
                  reg_out_s.reg106   when REG106_ADR,
                  reg_out_s.reg107   when REG107_ADR,
                  reg_out_s.reg108   when REG108_ADR,
                  reg_out_s.reg109   when REG109_ADR,
                  reg_out_s.reg110   when REG110_ADR,
                  reg_out_s.reg111   when REG111_ADR,
                  reg_out_s.reg112   when REG112_ADR,
                  reg_out_s.reg113   when REG113_ADR,
                  reg_out_s.reg114   when REG114_ADR,
                  reg_out_s.reg115   when REG115_ADR,
                  reg_out_s.reg116   when REG116_ADR,
                  reg_out_s.reg117   when REG117_ADR,
                  reg_out_s.reg118   when REG118_ADR,
                  reg_out_s.reg119   when REG119_ADR,
                  reg_out_s.reg120   when REG120_ADR,
                  reg_out_s.reg121   when REG121_ADR,
                  reg_out_s.reg122   when REG122_ADR,
                  reg_out_s.reg123   when REG123_ADR,
                  reg_out_s.reg124   when REG124_ADR,
                  reg_out_s.reg125   when REG125_ADR,
                  reg_out_s.reg126   when REG126_ADR,
                  reg_out_s.reg127   when REG127_ADR,
                  reg_out_s.reg128   when REG128_ADR,
                  reg_out_s.reg129   when REG129_ADR,
                  reg_out_s.reg130   when REG130_ADR,
                  reg_out_s.reg131   when REG131_ADR,
                  reg_out_s.reg132   when REG132_ADR,
                  reg_out_s.reg133   when REG133_ADR,
                  reg_out_s.reg134   when REG134_ADR,
                  reg_out_s.reg135   when REG135_ADR,
                  reg_out_s.reg136   when REG136_ADR,
                  reg_out_s.reg137   when REG137_ADR,
                  reg_out_s.reg138   when REG138_ADR,
                  reg_out_s.reg139   when REG139_ADR,
                  reg_out_s.reg140   when REG140_ADR,
                  reg_out_s.reg141   when REG141_ADR,
                  reg_out_s.reg142   when REG142_ADR,
                  reg_out_s.reg143   when REG143_ADR,
                  reg_out_s.reg144   when REG144_ADR,
                  reg_out_s.reg145   when REG145_ADR,
                  reg_out_s.reg146   when REG146_ADR,
                  reg_out_s.reg147   when REG147_ADR,
                  reg_out_s.reg148   when REG148_ADR,
                  reg_out_s.reg149   when REG149_ADR,
                  reg_out_s.reg150   when REG150_ADR,
                  reg_out_s.reg151   when REG151_ADR,
                  reg_out_s.reg152   when REG152_ADR,
                  reg_out_s.reg153   when REG153_ADR,
                  reg_out_s.reg154   when REG154_ADR,
                  reg_out_s.reg155   when REG155_ADR,
                  reg_out_s.reg156   when REG156_ADR,
                  reg_out_s.reg157   when REG157_ADR,
                  reg_out_s.reg158   when REG158_ADR,
                  reg_out_s.reg159   when REG159_ADR,
                  reg_out_s.reg160   when REG160_ADR,
                  reg_out_s.reg161   when REG161_ADR,
                  reg_out_s.reg162   when REG162_ADR,
                  reg_out_s.reg163   when REG163_ADR,
                  reg_out_s.reg164   when REG164_ADR,
                  reg_out_s.reg165   when REG165_ADR,
                  reg_out_s.reg166   when REG166_ADR,
                  reg_out_s.reg167   when REG167_ADR,
                  reg_out_s.reg168   when REG168_ADR,
                  reg_out_s.reg169   when REG169_ADR,
                  reg_out_s.reg170   when REG170_ADR,
                  reg_out_s.reg171   when REG171_ADR,
                  reg_out_s.reg172   when REG172_ADR,
                  reg_out_s.reg173   when REG173_ADR,
                  reg_out_s.reg174   when REG174_ADR,
                  reg_out_s.reg175   when REG175_ADR,
                  reg_out_s.reg176   when REG176_ADR,
                  reg_out_s.reg177   when REG177_ADR,
                  reg_out_s.reg178   when REG178_ADR,
                  reg_out_s.reg179   when REG179_ADR,
                  reg_out_s.reg180   when REG180_ADR,
                  reg_out_s.reg181   when REG181_ADR,
                  reg_out_s.reg182   when REG182_ADR,
                  reg_out_s.reg183   when REG183_ADR,
                  reg_out_s.reg184   when REG184_ADR,
                  reg_out_s.reg185   when REG185_ADR,
                  reg_out_s.reg186   when REG186_ADR,
                  reg_out_s.reg187   when REG187_ADR,
                  reg_out_s.reg188   when REG188_ADR,
                  reg_out_s.reg189   when REG189_ADR,
                  reg_out_s.reg190   when REG190_ADR,
                  reg_out_s.reg191   when REG191_ADR,
                  reg_out_s.reg192   when REG192_ADR,
                  reg_out_s.reg193   when REG193_ADR,
                  reg_out_s.reg194   when REG194_ADR,
                  reg_out_s.reg195   when REG195_ADR,
                  reg_out_s.reg196   when REG196_ADR,
                  reg_out_s.reg197   when REG197_ADR,
                  reg_out_s.reg198   when REG198_ADR,
                  reg_out_s.reg199   when REG199_ADR,
                  reg_out_s.reg200   when REG200_ADR,
                  reg_out_s.reg201   when REG201_ADR,
                  reg_out_s.reg202   when REG202_ADR,
                  reg_out_s.reg203   when REG203_ADR,
                  reg_out_s.reg204   when REG204_ADR,
                  reg_out_s.reg205   when REG205_ADR,
                  reg_out_s.reg206   when REG206_ADR,
                  reg_out_s.reg207   when REG207_ADR,
                  reg_out_s.reg208   when REG208_ADR,
                  reg_out_s.reg209   when REG209_ADR,
                  reg_out_s.reg210   when REG210_ADR,
                  reg_out_s.reg211   when REG211_ADR,
                  reg_out_s.reg212   when REG212_ADR,
                  reg_out_s.reg213   when REG213_ADR,
                  reg_out_s.reg214   when REG214_ADR,
                  reg_out_s.reg215   when REG215_ADR,
                  reg_out_s.reg216   when REG216_ADR,
                  reg_out_s.reg217   when REG217_ADR,
                  reg_out_s.reg218   when REG218_ADR,
                  reg_out_s.reg219   when REG219_ADR,
                  reg_out_s.reg220   when REG220_ADR,
                  reg_out_s.reg221   when REG221_ADR,
                  reg_out_s.reg222   when REG222_ADR,
                  reg_out_s.reg223   when REG223_ADR,
                  reg_out_s.reg224   when REG224_ADR,
                  reg_out_s.reg225   when REG225_ADR,
                  reg_out_s.reg226   when REG226_ADR,
                  reg_out_s.reg227   when REG227_ADR,
                  reg_out_s.reg228   when REG228_ADR,
                  reg_out_s.reg229   when REG229_ADR,
                  reg_out_s.reg230   when REG230_ADR,
                  reg_out_s.reg231   when REG231_ADR,
                  reg_out_s.reg232   when REG232_ADR,
                  reg_out_s.reg233   when REG233_ADR,
                  reg_out_s.reg234   when REG234_ADR,
                  reg_out_s.reg235   when REG235_ADR,
                  reg_out_s.reg236   when REG236_ADR,
                  reg_out_s.reg237   when REG237_ADR,
                  reg_out_s.reg238   when REG238_ADR,
                  reg_out_s.reg239   when REG239_ADR,
                  reg_out_s.reg240   when REG240_ADR,
                  reg_out_s.reg241   when REG241_ADR,
                  reg_out_s.reg242   when REG242_ADR,
                  reg_out_s.reg243   when REG243_ADR,
                  reg_out_s.reg244   when REG244_ADR,
                  reg_out_s.reg245   when REG245_ADR,
                  reg_out_s.reg246   when REG246_ADR,
                  reg_out_s.reg247   when REG247_ADR,
                  reg_out_s.reg248   when REG248_ADR,
                  reg_out_s.reg249   when REG249_ADR,
                  reg_out_s.reg250   when REG250_ADR,
                  reg_out_s.reg251   when REG251_ADR,
                  reg_out_s.reg252   when REG252_ADR,
                  reg_out_s.reg253   when REG253_ADR,
                  reg_out_s.reg254   when REG254_ADR,
                  reg_out_s.reg255   when REG255_ADR,
                  (others => '-')  when others;

-- register outputs -> non-wishbone outputs
reg0_out <= reg_out_s.reg0;
reg1_out <= reg_out_s.reg1;
reg2_out <= reg_out_s.reg2;
reg3_out <= reg_out_s.reg3;
reg4_out <= reg_out_s.reg4;
reg5_out <= reg_out_s.reg5;
reg6_out <= reg_out_s.reg6;
reg7_out <= reg_out_s.reg7;
reg8_out <= reg_out_s.reg8;
reg9_out <= reg_out_s.reg9;
reg10_out <= reg_out_s.reg10;
reg11_out <= reg_out_s.reg11;
reg12_out <= reg_out_s.reg12;
reg13_out <= reg_out_s.reg13;
reg14_out <= reg_out_s.reg14;
reg15_out <= reg_out_s.reg15;
reg16_out <= reg_out_s.reg16;
reg17_out <= reg_out_s.reg17;
reg18_out <= reg_out_s.reg18;
reg19_out <= reg_out_s.reg19;
reg20_out <= reg_out_s.reg20;
reg21_out <= reg_out_s.reg21;
reg22_out <= reg_out_s.reg22;
reg23_out <= reg_out_s.reg23;
reg24_out <= reg_out_s.reg24;
reg25_out <= reg_out_s.reg25;
reg26_out <= reg_out_s.reg26;
reg27_out <= reg_out_s.reg27;
reg28_out <= reg_out_s.reg28;
reg29_out <= reg_out_s.reg29;
reg30_out <= reg_out_s.reg30;
reg31_out <= reg_out_s.reg31;
reg32_out <= reg_out_s.reg32;
reg33_out <= reg_out_s.reg33;
reg34_out <= reg_out_s.reg34;
reg35_out <= reg_out_s.reg35;
reg36_out <= reg_out_s.reg36;
reg37_out <= reg_out_s.reg37;
reg38_out <= reg_out_s.reg38;
reg39_out <= reg_out_s.reg39;
reg40_out <= reg_out_s.reg40;
reg41_out <= reg_out_s.reg41;
reg42_out <= reg_out_s.reg42;
reg43_out <= reg_out_s.reg43;
reg44_out <= reg_out_s.reg44;
reg45_out <= reg_out_s.reg45;
reg46_out <= reg_out_s.reg46;
reg47_out <= reg_out_s.reg47;
reg48_out <= reg_out_s.reg48;
reg49_out <= reg_out_s.reg49;
reg50_out <= reg_out_s.reg50;
reg51_out <= reg_out_s.reg51;
reg52_out <= reg_out_s.reg52;
reg53_out <= reg_out_s.reg53;
reg54_out <= reg_out_s.reg54;
reg55_out <= reg_out_s.reg55;
reg56_out <= reg_out_s.reg56;
reg57_out <= reg_out_s.reg57;
reg58_out <= reg_out_s.reg58;
reg59_out <= reg_out_s.reg59;
reg60_out <= reg_out_s.reg60;
reg61_out <= reg_out_s.reg61;
reg62_out <= reg_out_s.reg62;
reg63_out <= reg_out_s.reg63;
reg64_out <= reg_out_s.reg64;
reg65_out <= reg_out_s.reg65;
reg66_out <= reg_out_s.reg66;
reg67_out <= reg_out_s.reg67;
reg68_out <= reg_out_s.reg68;
reg69_out <= reg_out_s.reg69;
reg70_out <= reg_out_s.reg70;
reg71_out <= reg_out_s.reg71;
reg72_out <= reg_out_s.reg72;
reg73_out <= reg_out_s.reg73;
reg74_out <= reg_out_s.reg74;
reg75_out <= reg_out_s.reg75;
reg76_out <= reg_out_s.reg76;
reg77_out <= reg_out_s.reg77;
reg78_out <= reg_out_s.reg78;
reg79_out <= reg_out_s.reg79;
reg80_out <= reg_out_s.reg80;
reg81_out <= reg_out_s.reg81;
reg82_out <= reg_out_s.reg82;
reg83_out <= reg_out_s.reg83;
reg84_out <= reg_out_s.reg84;
reg85_out <= reg_out_s.reg85;
reg86_out <= reg_out_s.reg86;
reg87_out <= reg_out_s.reg87;
reg88_out <= reg_out_s.reg88;
reg89_out <= reg_out_s.reg89;
reg90_out <= reg_out_s.reg90;
reg91_out <= reg_out_s.reg91;
reg92_out <= reg_out_s.reg92;
reg93_out <= reg_out_s.reg93;
reg94_out <= reg_out_s.reg94;
reg95_out <= reg_out_s.reg95;
reg96_out <= reg_out_s.reg96;
reg97_out <= reg_out_s.reg97;
reg98_out <= reg_out_s.reg98;
reg99_out <= reg_out_s.reg99;
reg100_out <= reg_out_s.reg100;
reg101_out <= reg_out_s.reg101;
reg102_out <= reg_out_s.reg102;
reg103_out <= reg_out_s.reg103;
reg104_out <= reg_out_s.reg104;
reg105_out <= reg_out_s.reg105;
reg106_out <= reg_out_s.reg106;
reg107_out <= reg_out_s.reg107;
reg108_out <= reg_out_s.reg108;
reg109_out <= reg_out_s.reg109;
reg110_out <= reg_out_s.reg110;
reg111_out <= reg_out_s.reg111;
reg112_out <= reg_out_s.reg112;
reg113_out <= reg_out_s.reg113;
reg114_out <= reg_out_s.reg114;
reg115_out <= reg_out_s.reg115;
reg116_out <= reg_out_s.reg116;
reg117_out <= reg_out_s.reg117;
reg118_out <= reg_out_s.reg118;
reg119_out <= reg_out_s.reg119;
reg120_out <= reg_out_s.reg120;
reg121_out <= reg_out_s.reg121;
reg122_out <= reg_out_s.reg122;
reg123_out <= reg_out_s.reg123;
reg124_out <= reg_out_s.reg124;
reg125_out <= reg_out_s.reg125;
reg126_out <= reg_out_s.reg126;
reg127_out <= reg_out_s.reg127;
reg128_out <= reg_out_s.reg128;
reg129_out <= reg_out_s.reg129;
reg130_out <= reg_out_s.reg130;
reg131_out <= reg_out_s.reg131;
reg132_out <= reg_out_s.reg132;
reg133_out <= reg_out_s.reg133;
reg134_out <= reg_out_s.reg134;
reg135_out <= reg_out_s.reg135;
reg136_out <= reg_out_s.reg136;
reg137_out <= reg_out_s.reg137;
reg138_out <= reg_out_s.reg138;
reg139_out <= reg_out_s.reg139;
reg140_out <= reg_out_s.reg140;
reg141_out <= reg_out_s.reg141;
reg142_out <= reg_out_s.reg142;
reg143_out <= reg_out_s.reg143;
reg144_out <= reg_out_s.reg144;
reg145_out <= reg_out_s.reg145;
reg146_out <= reg_out_s.reg146;
reg147_out <= reg_out_s.reg147;
reg148_out <= reg_out_s.reg148;
reg149_out <= reg_out_s.reg149;
reg150_out <= reg_out_s.reg150;
reg151_out <= reg_out_s.reg151;
reg152_out <= reg_out_s.reg152;
reg153_out <= reg_out_s.reg153;
reg154_out <= reg_out_s.reg154;
reg155_out <= reg_out_s.reg155;
reg156_out <= reg_out_s.reg156;
reg157_out <= reg_out_s.reg157;
reg158_out <= reg_out_s.reg158;
reg159_out <= reg_out_s.reg159;
reg160_out <= reg_out_s.reg160;
reg161_out <= reg_out_s.reg161;
reg162_out <= reg_out_s.reg162;
reg163_out <= reg_out_s.reg163;
reg164_out <= reg_out_s.reg164;
reg165_out <= reg_out_s.reg165;
reg166_out <= reg_out_s.reg166;
reg167_out <= reg_out_s.reg167;
reg168_out <= reg_out_s.reg168;
reg169_out <= reg_out_s.reg169;
reg170_out <= reg_out_s.reg170;
reg171_out <= reg_out_s.reg171;
reg172_out <= reg_out_s.reg172;
reg173_out <= reg_out_s.reg173;
reg174_out <= reg_out_s.reg174;
reg175_out <= reg_out_s.reg175;
reg176_out <= reg_out_s.reg176;
reg177_out <= reg_out_s.reg177;
reg178_out <= reg_out_s.reg178;
reg179_out <= reg_out_s.reg179;
reg180_out <= reg_out_s.reg180;
reg181_out <= reg_out_s.reg181;
reg182_out <= reg_out_s.reg182;
reg183_out <= reg_out_s.reg183;
reg184_out <= reg_out_s.reg184;
reg185_out <= reg_out_s.reg185;
reg186_out <= reg_out_s.reg186;
reg187_out <= reg_out_s.reg187;
reg188_out <= reg_out_s.reg188;
reg189_out <= reg_out_s.reg189;
reg190_out <= reg_out_s.reg190;
reg191_out <= reg_out_s.reg191;
reg192_out <= reg_out_s.reg192;
reg193_out <= reg_out_s.reg193;
reg194_out <= reg_out_s.reg194;
reg195_out <= reg_out_s.reg195;
reg196_out <= reg_out_s.reg196;
reg197_out <= reg_out_s.reg197;
reg198_out <= reg_out_s.reg198;
reg199_out <= reg_out_s.reg199;
reg200_out <= reg_out_s.reg200;
reg201_out <= reg_out_s.reg201;
reg202_out <= reg_out_s.reg202;
reg203_out <= reg_out_s.reg203;
reg204_out <= reg_out_s.reg204;
reg205_out <= reg_out_s.reg205;
reg206_out <= reg_out_s.reg206;
reg207_out <= reg_out_s.reg207;
reg208_out <= reg_out_s.reg208;
reg209_out <= reg_out_s.reg209;
reg210_out <= reg_out_s.reg210;
reg211_out <= reg_out_s.reg211;
reg212_out <= reg_out_s.reg212;
reg213_out <= reg_out_s.reg213;
reg214_out <= reg_out_s.reg214;
reg215_out <= reg_out_s.reg215;
reg216_out <= reg_out_s.reg216;
reg217_out <= reg_out_s.reg217;
reg218_out <= reg_out_s.reg218;
reg219_out <= reg_out_s.reg219;
reg220_out <= reg_out_s.reg220;
reg221_out <= reg_out_s.reg221;
reg222_out <= reg_out_s.reg222;
reg223_out <= reg_out_s.reg223;
reg224_out <= reg_out_s.reg224;
reg225_out <= reg_out_s.reg225;
reg226_out <= reg_out_s.reg226;
reg227_out <= reg_out_s.reg227;
reg228_out <= reg_out_s.reg228;
reg229_out <= reg_out_s.reg229;
reg230_out <= reg_out_s.reg230;
reg231_out <= reg_out_s.reg231;
reg232_out <= reg_out_s.reg232;
reg233_out <= reg_out_s.reg233;
reg234_out <= reg_out_s.reg234;
reg235_out <= reg_out_s.reg235;
reg236_out <= reg_out_s.reg236;
reg237_out <= reg_out_s.reg237;
reg238_out <= reg_out_s.reg238;
reg239_out <= reg_out_s.reg239;
reg240_out <= reg_out_s.reg240;
reg241_out <= reg_out_s.reg241;
reg242_out <= reg_out_s.reg242;
reg243_out <= reg_out_s.reg243;
reg244_out <= reg_out_s.reg244;
reg245_out <= reg_out_s.reg245;
reg246_out <= reg_out_s.reg246;
reg247_out <= reg_out_s.reg247;
reg248_out <= reg_out_s.reg248;
reg249_out <= reg_out_s.reg249;
reg250_out <= reg_out_s.reg250;
reg251_out <= reg_out_s.reg251;
reg252_out <= reg_out_s.reg252;
reg253_out <= reg_out_s.reg253;
reg254_out <= reg_out_s.reg254;
reg255_out <= reg_out_s.reg255;

-------------------------------------------------------------------------------
   REGISTERS : process(wbs_in.clk)
-------------------------------------------------------------------------------
   begin
      -- everything sync to clk
      if (rising_edge(wbs_in.clk)) then

         -- reset all registers
         if (wbs_in.rst = '1') then
            reg_out_s.reg0 <= (others => '0');
            reg_out_s.reg1 <= (others => '0');
            reg_out_s.reg2 <= (others => '0');
            reg_out_s.reg3 <= (others => '0');
            reg_out_s.reg4 <= (others => '0');
            reg_out_s.reg5 <= (others => '0');
            reg_out_s.reg6 <= (others => '0');
            reg_out_s.reg7 <= (others => '0');
            reg_out_s.reg8 <= (others => '0');
            reg_out_s.reg9 <= (others => '0');
            reg_out_s.reg10 <= (others => '0');
            reg_out_s.reg11 <= (others => '0');
            reg_out_s.reg12 <= (others => '0');
            reg_out_s.reg13 <= (others => '0');
            reg_out_s.reg14 <= (others => '0');
            reg_out_s.reg15 <= (others => '0');
            reg_out_s.reg16 <= (others => '0');
            reg_out_s.reg17 <= (others => '0');
            reg_out_s.reg18 <= (others => '0');
            reg_out_s.reg19 <= (others => '0');
            reg_out_s.reg20 <= (others => '0');
            reg_out_s.reg21 <= (others => '0');
            reg_out_s.reg22 <= (others => '0');
            reg_out_s.reg23 <= (others => '0');
            reg_out_s.reg24 <= (others => '0');
            reg_out_s.reg25 <= (others => '0');
            reg_out_s.reg26 <= (others => '0');
            reg_out_s.reg27 <= (others => '0');
            reg_out_s.reg28 <= (others => '0');
            reg_out_s.reg29 <= (others => '0');
            reg_out_s.reg30 <= (others => '0');
            reg_out_s.reg31 <= (others => '0');
            reg_out_s.reg32 <= (others => '0');
            reg_out_s.reg33 <= (others => '0');
            reg_out_s.reg34 <= (others => '0');
            reg_out_s.reg35 <= (others => '0');
            reg_out_s.reg36 <= (others => '0');
            reg_out_s.reg37 <= (others => '0');
            reg_out_s.reg38 <= (others => '0');
            reg_out_s.reg39 <= (others => '0');
            reg_out_s.reg40 <= (others => '0');
            reg_out_s.reg41 <= (others => '0');
            reg_out_s.reg42 <= (others => '0');
            reg_out_s.reg43 <= (others => '0');
            reg_out_s.reg44 <= (others => '0');
            reg_out_s.reg45 <= (others => '0');
            reg_out_s.reg46 <= (others => '0');
            reg_out_s.reg47 <= (others => '0');
            reg_out_s.reg48 <= (others => '0');
            reg_out_s.reg49 <= (others => '0');
            reg_out_s.reg50 <= (others => '0');
            reg_out_s.reg51 <= (others => '0');
            reg_out_s.reg52 <= (others => '0');
            reg_out_s.reg53 <= (others => '0');
            reg_out_s.reg54 <= (others => '0');
            reg_out_s.reg55 <= (others => '0');
            reg_out_s.reg56 <= (others => '0');
            reg_out_s.reg57 <= (others => '0');
            reg_out_s.reg58 <= (others => '0');
            reg_out_s.reg59 <= (others => '0');
            reg_out_s.reg60 <= (others => '0');
            reg_out_s.reg61 <= (others => '0');
            reg_out_s.reg62 <= (others => '0');
            reg_out_s.reg63 <= (others => '0');
            reg_out_s.reg64 <= (others => '0');
            reg_out_s.reg65 <= (others => '0');
            reg_out_s.reg66 <= (others => '0');
            reg_out_s.reg67 <= (others => '0');
            reg_out_s.reg68 <= (others => '0');
            reg_out_s.reg69 <= (others => '0');
            reg_out_s.reg70 <= (others => '0');
            reg_out_s.reg71 <= (others => '0');
            reg_out_s.reg72 <= (others => '0');
            reg_out_s.reg73 <= (others => '0');
            reg_out_s.reg74 <= (others => '0');
            reg_out_s.reg75 <= (others => '0');
            reg_out_s.reg76 <= (others => '0');
            reg_out_s.reg77 <= (others => '0');
            reg_out_s.reg78 <= (others => '0');
            reg_out_s.reg79 <= (others => '0');
            reg_out_s.reg80 <= (others => '0');
            reg_out_s.reg81 <= (others => '0');
            reg_out_s.reg82 <= (others => '0');
            reg_out_s.reg83 <= (others => '0');
            reg_out_s.reg84 <= (others => '0');
            reg_out_s.reg85 <= (others => '0');
            reg_out_s.reg86 <= (others => '0');
            reg_out_s.reg87 <= (others => '0');
            reg_out_s.reg88 <= (others => '0');
            reg_out_s.reg89 <= (others => '0');
            reg_out_s.reg90 <= (others => '0');
            reg_out_s.reg91 <= (others => '0');
            reg_out_s.reg92 <= (others => '0');
            reg_out_s.reg93 <= (others => '0');
            reg_out_s.reg94 <= (others => '0');
            reg_out_s.reg95 <= (others => '0');
            reg_out_s.reg96 <= (others => '0');
            reg_out_s.reg97 <= (others => '0');
            reg_out_s.reg98 <= (others => '0');
            reg_out_s.reg99 <= (others => '0');
            reg_out_s.reg100 <= (others => '0');
            reg_out_s.reg101 <= (others => '0');
            reg_out_s.reg102 <= (others => '0');
            reg_out_s.reg103 <= (others => '0');
            reg_out_s.reg104 <= (others => '0');
            reg_out_s.reg105 <= (others => '0');
            reg_out_s.reg106 <= (others => '0');
            reg_out_s.reg107 <= (others => '0');
            reg_out_s.reg108 <= (others => '0');
            reg_out_s.reg109 <= (others => '0');
            reg_out_s.reg110 <= (others => '0');
            reg_out_s.reg111 <= (others => '0');
            reg_out_s.reg112 <= (others => '0');
            reg_out_s.reg113 <= (others => '0');
            reg_out_s.reg114 <= (others => '0');
            reg_out_s.reg115 <= (others => '0');
            reg_out_s.reg116 <= (others => '0');
            reg_out_s.reg117 <= (others => '0');
            reg_out_s.reg118 <= (others => '0');
            reg_out_s.reg119 <= (others => '0');
            reg_out_s.reg120 <= (others => '0');
            reg_out_s.reg121 <= (others => '0');
            reg_out_s.reg122 <= (others => '0');
            reg_out_s.reg123 <= (others => '0');
            reg_out_s.reg124 <= (others => '0');
            reg_out_s.reg125 <= (others => '0');
            reg_out_s.reg126 <= (others => '0');
            reg_out_s.reg127 <= (others => '0');
            reg_out_s.reg128 <= (others => '0');
            reg_out_s.reg129 <= (others => '0');
            reg_out_s.reg130 <= (others => '0');
            reg_out_s.reg131 <= (others => '0');
            reg_out_s.reg132 <= (others => '0');
            reg_out_s.reg133 <= (others => '0');
            reg_out_s.reg134 <= (others => '0');
            reg_out_s.reg135 <= (others => '0');
            reg_out_s.reg136 <= (others => '0');
            reg_out_s.reg137 <= (others => '0');
            reg_out_s.reg138 <= (others => '0');
            reg_out_s.reg139 <= (others => '0');
            reg_out_s.reg140 <= (others => '0');
            reg_out_s.reg141 <= (others => '0');
            reg_out_s.reg142 <= (others => '0');
            reg_out_s.reg143 <= (others => '0');
            reg_out_s.reg144 <= (others => '0');
            reg_out_s.reg145 <= (others => '0');
            reg_out_s.reg146 <= (others => '0');
            reg_out_s.reg147 <= (others => '0');
            reg_out_s.reg148 <= (others => '0');
            reg_out_s.reg149 <= (others => '0');
            reg_out_s.reg150 <= (others => '0');
            reg_out_s.reg151 <= (others => '0');
            reg_out_s.reg152 <= (others => '0');
            reg_out_s.reg153 <= (others => '0');
            reg_out_s.reg154 <= (others => '0');
            reg_out_s.reg155 <= (others => '0');
            reg_out_s.reg156 <= (others => '0');
            reg_out_s.reg157 <= (others => '0');
            reg_out_s.reg158 <= (others => '0');
            reg_out_s.reg159 <= (others => '0');
            reg_out_s.reg160 <= (others => '0');
            reg_out_s.reg161 <= (others => '0');
            reg_out_s.reg162 <= (others => '0');
            reg_out_s.reg163 <= (others => '0');
            reg_out_s.reg164 <= (others => '0');
            reg_out_s.reg165 <= (others => '0');
            reg_out_s.reg166 <= (others => '0');
            reg_out_s.reg167 <= (others => '0');
            reg_out_s.reg168 <= (others => '0');
            reg_out_s.reg169 <= (others => '0');
            reg_out_s.reg170 <= (others => '0');
            reg_out_s.reg171 <= (others => '0');
            reg_out_s.reg172 <= (others => '0');
            reg_out_s.reg173 <= (others => '0');
            reg_out_s.reg174 <= (others => '0');
            reg_out_s.reg175 <= (others => '0');
            reg_out_s.reg176 <= (others => '0');
            reg_out_s.reg177 <= (others => '0');
            reg_out_s.reg178 <= (others => '0');
            reg_out_s.reg179 <= (others => '0');
            reg_out_s.reg180 <= (others => '0');
            reg_out_s.reg181 <= (others => '0');
            reg_out_s.reg182 <= (others => '0');
            reg_out_s.reg183 <= (others => '0');
            reg_out_s.reg184 <= (others => '0');
            reg_out_s.reg185 <= (others => '0');
            reg_out_s.reg186 <= (others => '0');
            reg_out_s.reg187 <= (others => '0');
            reg_out_s.reg188 <= (others => '0');
            reg_out_s.reg189 <= (others => '0');
            reg_out_s.reg190 <= (others => '0');
            reg_out_s.reg191 <= (others => '0');
            reg_out_s.reg192 <= (others => '0');
            reg_out_s.reg193 <= (others => '0');
            reg_out_s.reg194 <= (others => '0');
            reg_out_s.reg195 <= (others => '0');
            reg_out_s.reg196 <= (others => '0');
            reg_out_s.reg197 <= (others => '0');
            reg_out_s.reg198 <= (others => '0');
            reg_out_s.reg199 <= (others => '0');
            reg_out_s.reg200 <= (others => '0');
            reg_out_s.reg201 <= (others => '0');
            reg_out_s.reg202 <= (others => '0');
            reg_out_s.reg203 <= (others => '0');
            reg_out_s.reg204 <= (others => '0');
            reg_out_s.reg205 <= (others => '0');
            reg_out_s.reg206 <= (others => '0');
            reg_out_s.reg207 <= (others => '0');
            reg_out_s.reg208 <= (others => '0');
            reg_out_s.reg209 <= (others => '0');
            reg_out_s.reg210 <= (others => '0');
            reg_out_s.reg211 <= (others => '0');
            reg_out_s.reg212 <= (others => '0');
            reg_out_s.reg213 <= (others => '0');
            reg_out_s.reg214 <= (others => '0');
            reg_out_s.reg215 <= (others => '0');
            reg_out_s.reg216 <= (others => '0');
            reg_out_s.reg217 <= (others => '0');
            reg_out_s.reg218 <= (others => '0');
            reg_out_s.reg219 <= (others => '0');
            reg_out_s.reg220 <= (others => '0');
            reg_out_s.reg221 <= (others => '0');
            reg_out_s.reg222 <= (others => '0');
            reg_out_s.reg223 <= (others => '0');
            reg_out_s.reg224 <= (others => '0');
            reg_out_s.reg225 <= (others => '0');
            reg_out_s.reg226 <= (others => '0');
            reg_out_s.reg227 <= (others => '0');
            reg_out_s.reg228 <= (others => '0');
            reg_out_s.reg229 <= (others => '0');
            reg_out_s.reg230 <= (others => '0');
            reg_out_s.reg231 <= (others => '0');
            reg_out_s.reg232 <= (others => '0');
            reg_out_s.reg233 <= (others => '0');
            reg_out_s.reg234 <= (others => '0');
            reg_out_s.reg235 <= (others => '0');
            reg_out_s.reg236 <= (others => '0');
            reg_out_s.reg237 <= (others => '0');
            reg_out_s.reg238 <= (others => '0');
            reg_out_s.reg239 <= (others => '0');
            reg_out_s.reg240 <= (others => '0');
            reg_out_s.reg241 <= (others => '0');
            reg_out_s.reg242 <= (others => '0');
            reg_out_s.reg243 <= (others => '0');
            reg_out_s.reg244 <= (others => '0');
            reg_out_s.reg245 <= (others => '0');
            reg_out_s.reg246 <= (others => '0');
            reg_out_s.reg247 <= (others => '0');
            reg_out_s.reg248 <= (others => '0');
            reg_out_s.reg249 <= (others => '0');
            reg_out_s.reg250 <= (others => '0');
            reg_out_s.reg251 <= (others => '0');
            reg_out_s.reg252 <= (others => '0');
            reg_out_s.reg253 <= (others => '0');
            reg_out_s.reg254 <= (others => '0');
            reg_out_s.reg255 <= (others => '0');

         -- store reg0
         elsif(reg0_re_s = '1') then
            reg_out_s.reg0 <= reg_in_s.reg0;

         -- store reg1
         elsif(reg1_re_s = '1') then
            reg_out_s.reg1 <= reg_in_s.reg1;

         -- store reg2
         elsif(reg2_re_s = '1') then
            reg_out_s.reg2 <= reg_in_s.reg2;

         -- store reg3
         elsif(reg3_re_s = '1') then
            reg_out_s.reg3 <= reg_in_s.reg3;

         -- store reg4
         elsif(reg4_re_s = '1') then
            reg_out_s.reg4 <= reg_in_s.reg4;

         -- store reg5
         elsif(reg5_re_s = '1') then
            reg_out_s.reg5 <= reg_in_s.reg5;

         -- store reg6
         elsif(reg6_re_s = '1') then
            reg_out_s.reg6 <= reg_in_s.reg6;

         -- store reg7
         elsif(reg7_re_s = '1') then
            reg_out_s.reg7 <= reg_in_s.reg7;

         -- store reg8
         elsif(reg8_re_s = '1') then
            reg_out_s.reg8 <= reg_in_s.reg8;

         -- store reg9
         elsif(reg9_re_s = '1') then
            reg_out_s.reg9 <= reg_in_s.reg9;

         -- store reg10
         elsif(reg10_re_s = '1') then
            reg_out_s.reg10 <= reg_in_s.reg10;

         -- store reg11
         elsif(reg11_re_s = '1') then
            reg_out_s.reg11 <= reg_in_s.reg11;

         -- store reg12
         elsif(reg12_re_s = '1') then
            reg_out_s.reg12 <= reg_in_s.reg12;

         -- store reg13
         elsif(reg13_re_s = '1') then
            reg_out_s.reg13 <= reg_in_s.reg13;

         -- store reg14
         elsif(reg14_re_s = '1') then
            reg_out_s.reg14 <= reg_in_s.reg14;

         -- store reg15
         elsif(reg15_re_s = '1') then
            reg_out_s.reg15 <= reg_in_s.reg15;

         -- store reg16
         elsif(reg16_re_s = '1') then
            reg_out_s.reg16 <= reg_in_s.reg16;

         -- store reg17
         elsif(reg17_re_s = '1') then
            reg_out_s.reg17 <= reg_in_s.reg17;

         -- store reg18
         elsif(reg18_re_s = '1') then
            reg_out_s.reg18 <= reg_in_s.reg18;

         -- store reg19
         elsif(reg19_re_s = '1') then
            reg_out_s.reg19 <= reg_in_s.reg19;

         -- store reg20
         elsif(reg20_re_s = '1') then
            reg_out_s.reg20 <= reg_in_s.reg20;

         -- store reg21
         elsif(reg21_re_s = '1') then
            reg_out_s.reg21 <= reg_in_s.reg21;

         -- store reg22
         elsif(reg22_re_s = '1') then
            reg_out_s.reg22 <= reg_in_s.reg22;

         -- store reg23
         elsif(reg23_re_s = '1') then
            reg_out_s.reg23 <= reg_in_s.reg23;

         -- store reg24
         elsif(reg24_re_s = '1') then
            reg_out_s.reg24 <= reg_in_s.reg24;

         -- store reg25
         elsif(reg25_re_s = '1') then
            reg_out_s.reg25 <= reg_in_s.reg25;

         -- store reg26
         elsif(reg26_re_s = '1') then
            reg_out_s.reg26 <= reg_in_s.reg26;

         -- store reg27
         elsif(reg27_re_s = '1') then
            reg_out_s.reg27 <= reg_in_s.reg27;

         -- store reg28
         elsif(reg28_re_s = '1') then
            reg_out_s.reg28 <= reg_in_s.reg28;

         -- store reg29
         elsif(reg29_re_s = '1') then
            reg_out_s.reg29 <= reg_in_s.reg29;

         -- store reg30
         elsif(reg30_re_s = '1') then
            reg_out_s.reg30 <= reg_in_s.reg30;

         -- store reg31
         elsif(reg31_re_s = '1') then
            reg_out_s.reg31 <= reg_in_s.reg31;

         -- store reg32
         elsif(reg32_re_s = '1') then
            reg_out_s.reg32 <= reg_in_s.reg32;

         -- store reg33
         elsif(reg33_re_s = '1') then
            reg_out_s.reg33 <= reg_in_s.reg33;

         -- store reg34
         elsif(reg34_re_s = '1') then
            reg_out_s.reg34 <= reg_in_s.reg34;

         -- store reg35
         elsif(reg35_re_s = '1') then
            reg_out_s.reg35 <= reg_in_s.reg35;

         -- store reg36
         elsif(reg36_re_s = '1') then
            reg_out_s.reg36 <= reg_in_s.reg36;

         -- store reg37
         elsif(reg37_re_s = '1') then
            reg_out_s.reg37 <= reg_in_s.reg37;

         -- store reg38
         elsif(reg38_re_s = '1') then
            reg_out_s.reg38 <= reg_in_s.reg38;

         -- store reg39
         elsif(reg39_re_s = '1') then
            reg_out_s.reg39 <= reg_in_s.reg39;

         -- store reg40
         elsif(reg40_re_s = '1') then
            reg_out_s.reg40 <= reg_in_s.reg40;

         -- store reg41
         elsif(reg41_re_s = '1') then
            reg_out_s.reg41 <= reg_in_s.reg41;

         -- store reg42
         elsif(reg42_re_s = '1') then
            reg_out_s.reg42 <= reg_in_s.reg42;

         -- store reg43
         elsif(reg43_re_s = '1') then
            reg_out_s.reg43 <= reg_in_s.reg43;

         -- store reg44
         elsif(reg44_re_s = '1') then
            reg_out_s.reg44 <= reg_in_s.reg44;

         -- store reg45
         elsif(reg45_re_s = '1') then
            reg_out_s.reg45 <= reg_in_s.reg45;

         -- store reg46
         elsif(reg46_re_s = '1') then
            reg_out_s.reg46 <= reg_in_s.reg46;

         -- store reg47
         elsif(reg47_re_s = '1') then
            reg_out_s.reg47 <= reg_in_s.reg47;

         -- store reg48
         elsif(reg48_re_s = '1') then
            reg_out_s.reg48 <= reg_in_s.reg48;

         -- store reg49
         elsif(reg49_re_s = '1') then
            reg_out_s.reg49 <= reg_in_s.reg49;

         -- store reg50
         elsif(reg50_re_s = '1') then
            reg_out_s.reg50 <= reg_in_s.reg50;

         -- store reg51
         elsif(reg51_re_s = '1') then
            reg_out_s.reg51 <= reg_in_s.reg51;

         -- store reg52
         elsif(reg52_re_s = '1') then
            reg_out_s.reg52 <= reg_in_s.reg52;

         -- store reg53
         elsif(reg53_re_s = '1') then
            reg_out_s.reg53 <= reg_in_s.reg53;

         -- store reg54
         elsif(reg54_re_s = '1') then
            reg_out_s.reg54 <= reg_in_s.reg54;

         -- store reg55
         elsif(reg55_re_s = '1') then
            reg_out_s.reg55 <= reg_in_s.reg55;

         -- store reg56
         elsif(reg56_re_s = '1') then
            reg_out_s.reg56 <= reg_in_s.reg56;

         -- store reg57
         elsif(reg57_re_s = '1') then
            reg_out_s.reg57 <= reg_in_s.reg57;

         -- store reg58
         elsif(reg58_re_s = '1') then
            reg_out_s.reg58 <= reg_in_s.reg58;

         -- store reg59
         elsif(reg59_re_s = '1') then
            reg_out_s.reg59 <= reg_in_s.reg59;

         -- store reg60
         elsif(reg60_re_s = '1') then
            reg_out_s.reg60 <= reg_in_s.reg60;

         -- store reg61
         elsif(reg61_re_s = '1') then
            reg_out_s.reg61 <= reg_in_s.reg61;

         -- store reg62
         elsif(reg62_re_s = '1') then
            reg_out_s.reg62 <= reg_in_s.reg62;

         -- store reg63
         elsif(reg63_re_s = '1') then
            reg_out_s.reg63 <= reg_in_s.reg63;

         -- store reg64
         elsif(reg64_re_s = '1') then
            reg_out_s.reg64 <= reg_in_s.reg64;

         -- store reg65
         elsif(reg65_re_s = '1') then
            reg_out_s.reg65 <= reg_in_s.reg65;

         -- store reg66
         elsif(reg66_re_s = '1') then
            reg_out_s.reg66 <= reg_in_s.reg66;

         -- store reg67
         elsif(reg67_re_s = '1') then
            reg_out_s.reg67 <= reg_in_s.reg67;

         -- store reg68
         elsif(reg68_re_s = '1') then
            reg_out_s.reg68 <= reg_in_s.reg68;

         -- store reg69
         elsif(reg69_re_s = '1') then
            reg_out_s.reg69 <= reg_in_s.reg69;

         -- store reg70
         elsif(reg70_re_s = '1') then
            reg_out_s.reg70 <= reg_in_s.reg70;

         -- store reg71
         elsif(reg71_re_s = '1') then
            reg_out_s.reg71 <= reg_in_s.reg71;

         -- store reg72
         elsif(reg72_re_s = '1') then
            reg_out_s.reg72 <= reg_in_s.reg72;

         -- store reg73
         elsif(reg73_re_s = '1') then
            reg_out_s.reg73 <= reg_in_s.reg73;

         -- store reg74
         elsif(reg74_re_s = '1') then
            reg_out_s.reg74 <= reg_in_s.reg74;

         -- store reg75
         elsif(reg75_re_s = '1') then
            reg_out_s.reg75 <= reg_in_s.reg75;

         -- store reg76
         elsif(reg76_re_s = '1') then
            reg_out_s.reg76 <= reg_in_s.reg76;

         -- store reg77
         elsif(reg77_re_s = '1') then
            reg_out_s.reg77 <= reg_in_s.reg77;

         -- store reg78
         elsif(reg78_re_s = '1') then
            reg_out_s.reg78 <= reg_in_s.reg78;

         -- store reg79
         elsif(reg79_re_s = '1') then
            reg_out_s.reg79 <= reg_in_s.reg79;

         -- store reg80
         elsif(reg80_re_s = '1') then
            reg_out_s.reg80 <= reg_in_s.reg80;

         -- store reg81
         elsif(reg81_re_s = '1') then
            reg_out_s.reg81 <= reg_in_s.reg81;

         -- store reg82
         elsif(reg82_re_s = '1') then
            reg_out_s.reg82 <= reg_in_s.reg82;

         -- store reg83
         elsif(reg83_re_s = '1') then
            reg_out_s.reg83 <= reg_in_s.reg83;

         -- store reg84
         elsif(reg84_re_s = '1') then
            reg_out_s.reg84 <= reg_in_s.reg84;

         -- store reg85
         elsif(reg85_re_s = '1') then
            reg_out_s.reg85 <= reg_in_s.reg85;

         -- store reg86
         elsif(reg86_re_s = '1') then
            reg_out_s.reg86 <= reg_in_s.reg86;

         -- store reg87
         elsif(reg87_re_s = '1') then
            reg_out_s.reg87 <= reg_in_s.reg87;

         -- store reg88
         elsif(reg88_re_s = '1') then
            reg_out_s.reg88 <= reg_in_s.reg88;

         -- store reg89
         elsif(reg89_re_s = '1') then
            reg_out_s.reg89 <= reg_in_s.reg89;

         -- store reg90
         elsif(reg90_re_s = '1') then
            reg_out_s.reg90 <= reg_in_s.reg90;

         -- store reg91
         elsif(reg91_re_s = '1') then
            reg_out_s.reg91 <= reg_in_s.reg91;

         -- store reg92
         elsif(reg92_re_s = '1') then
            reg_out_s.reg92 <= reg_in_s.reg92;

         -- store reg93
         elsif(reg93_re_s = '1') then
            reg_out_s.reg93 <= reg_in_s.reg93;

         -- store reg94
         elsif(reg94_re_s = '1') then
            reg_out_s.reg94 <= reg_in_s.reg94;

         -- store reg95
         elsif(reg95_re_s = '1') then
            reg_out_s.reg95 <= reg_in_s.reg95;

         -- store reg96
         elsif(reg96_re_s = '1') then
            reg_out_s.reg96 <= reg_in_s.reg96;

         -- store reg97
         elsif(reg97_re_s = '1') then
            reg_out_s.reg97 <= reg_in_s.reg97;

         -- store reg98
         elsif(reg98_re_s = '1') then
            reg_out_s.reg98 <= reg_in_s.reg98;

         -- store reg99
         elsif(reg99_re_s = '1') then
            reg_out_s.reg99 <= reg_in_s.reg99;

         -- store reg100
         elsif(reg100_re_s = '1') then
            reg_out_s.reg100 <= reg_in_s.reg100;

         -- store reg101
         elsif(reg101_re_s = '1') then
            reg_out_s.reg101 <= reg_in_s.reg101;

         -- store reg102
         elsif(reg102_re_s = '1') then
            reg_out_s.reg102 <= reg_in_s.reg102;

         -- store reg103
         elsif(reg103_re_s = '1') then
            reg_out_s.reg103 <= reg_in_s.reg103;

         -- store reg104
         elsif(reg104_re_s = '1') then
            reg_out_s.reg104 <= reg_in_s.reg104;

         -- store reg105
         elsif(reg105_re_s = '1') then
            reg_out_s.reg105 <= reg_in_s.reg105;

         -- store reg106
         elsif(reg106_re_s = '1') then
            reg_out_s.reg106 <= reg_in_s.reg106;

         -- store reg107
         elsif(reg107_re_s = '1') then
            reg_out_s.reg107 <= reg_in_s.reg107;

         -- store reg108
         elsif(reg108_re_s = '1') then
            reg_out_s.reg108 <= reg_in_s.reg108;

         -- store reg109
         elsif(reg109_re_s = '1') then
            reg_out_s.reg109 <= reg_in_s.reg109;

         -- store reg110
         elsif(reg110_re_s = '1') then
            reg_out_s.reg110 <= reg_in_s.reg110;

         -- store reg111
         elsif(reg111_re_s = '1') then
            reg_out_s.reg111 <= reg_in_s.reg111;

         -- store reg112
         elsif(reg112_re_s = '1') then
            reg_out_s.reg112 <= reg_in_s.reg112;

         -- store reg113
         elsif(reg113_re_s = '1') then
            reg_out_s.reg113 <= reg_in_s.reg113;

         -- store reg114
         elsif(reg114_re_s = '1') then
            reg_out_s.reg114 <= reg_in_s.reg114;

         -- store reg115
         elsif(reg115_re_s = '1') then
            reg_out_s.reg115 <= reg_in_s.reg115;

         -- store reg116
         elsif(reg116_re_s = '1') then
            reg_out_s.reg116 <= reg_in_s.reg116;

         -- store reg117
         elsif(reg117_re_s = '1') then
            reg_out_s.reg117 <= reg_in_s.reg117;

         -- store reg118
         elsif(reg118_re_s = '1') then
            reg_out_s.reg118 <= reg_in_s.reg118;

         -- store reg119
         elsif(reg119_re_s = '1') then
            reg_out_s.reg119 <= reg_in_s.reg119;

         -- store reg120
         elsif(reg120_re_s = '1') then
            reg_out_s.reg120 <= reg_in_s.reg120;

         -- store reg121
         elsif(reg121_re_s = '1') then
            reg_out_s.reg121 <= reg_in_s.reg121;

         -- store reg122
         elsif(reg122_re_s = '1') then
            reg_out_s.reg122 <= reg_in_s.reg122;

         -- store reg123
         elsif(reg123_re_s = '1') then
            reg_out_s.reg123 <= reg_in_s.reg123;

         -- store reg124
         elsif(reg124_re_s = '1') then
            reg_out_s.reg124 <= reg_in_s.reg124;

         -- store reg125
         elsif(reg125_re_s = '1') then
            reg_out_s.reg125 <= reg_in_s.reg125;

         -- store reg126
         elsif(reg126_re_s = '1') then
            reg_out_s.reg126 <= reg_in_s.reg126;

         -- store reg127
         elsif(reg127_re_s = '1') then
            reg_out_s.reg127 <= reg_in_s.reg127;

         -- store reg128
         elsif(reg128_re_s = '1') then
            reg_out_s.reg128 <= reg_in_s.reg128;

         -- store reg129
         elsif(reg129_re_s = '1') then
            reg_out_s.reg129 <= reg_in_s.reg129;

         -- store reg130
         elsif(reg130_re_s = '1') then
            reg_out_s.reg130 <= reg_in_s.reg130;

         -- store reg131
         elsif(reg131_re_s = '1') then
            reg_out_s.reg131 <= reg_in_s.reg131;

         -- store reg132
         elsif(reg132_re_s = '1') then
            reg_out_s.reg132 <= reg_in_s.reg132;

         -- store reg133
         elsif(reg133_re_s = '1') then
            reg_out_s.reg133 <= reg_in_s.reg133;

         -- store reg134
         elsif(reg134_re_s = '1') then
            reg_out_s.reg134 <= reg_in_s.reg134;

         -- store reg135
         elsif(reg135_re_s = '1') then
            reg_out_s.reg135 <= reg_in_s.reg135;

         -- store reg136
         elsif(reg136_re_s = '1') then
            reg_out_s.reg136 <= reg_in_s.reg136;

         -- store reg137
         elsif(reg137_re_s = '1') then
            reg_out_s.reg137 <= reg_in_s.reg137;

         -- store reg138
         elsif(reg138_re_s = '1') then
            reg_out_s.reg138 <= reg_in_s.reg138;

         -- store reg139
         elsif(reg139_re_s = '1') then
            reg_out_s.reg139 <= reg_in_s.reg139;

         -- store reg140
         elsif(reg140_re_s = '1') then
            reg_out_s.reg140 <= reg_in_s.reg140;

         -- store reg141
         elsif(reg141_re_s = '1') then
            reg_out_s.reg141 <= reg_in_s.reg141;

         -- store reg142
         elsif(reg142_re_s = '1') then
            reg_out_s.reg142 <= reg_in_s.reg142;

         -- store reg143
         elsif(reg143_re_s = '1') then
            reg_out_s.reg143 <= reg_in_s.reg143;

         -- store reg144
         elsif(reg144_re_s = '1') then
            reg_out_s.reg144 <= reg_in_s.reg144;

         -- store reg145
         elsif(reg145_re_s = '1') then
            reg_out_s.reg145 <= reg_in_s.reg145;

         -- store reg146
         elsif(reg146_re_s = '1') then
            reg_out_s.reg146 <= reg_in_s.reg146;

         -- store reg147
         elsif(reg147_re_s = '1') then
            reg_out_s.reg147 <= reg_in_s.reg147;

         -- store reg148
         elsif(reg148_re_s = '1') then
            reg_out_s.reg148 <= reg_in_s.reg148;

         -- store reg149
         elsif(reg149_re_s = '1') then
            reg_out_s.reg149 <= reg_in_s.reg149;

         -- store reg150
         elsif(reg150_re_s = '1') then
            reg_out_s.reg150 <= reg_in_s.reg150;

         -- store reg151
         elsif(reg151_re_s = '1') then
            reg_out_s.reg151 <= reg_in_s.reg151;

         -- store reg152
         elsif(reg152_re_s = '1') then
            reg_out_s.reg152 <= reg_in_s.reg152;

         -- store reg153
         elsif(reg153_re_s = '1') then
            reg_out_s.reg153 <= reg_in_s.reg153;

         -- store reg154
         elsif(reg154_re_s = '1') then
            reg_out_s.reg154 <= reg_in_s.reg154;

         -- store reg155
         elsif(reg155_re_s = '1') then
            reg_out_s.reg155 <= reg_in_s.reg155;

         -- store reg156
         elsif(reg156_re_s = '1') then
            reg_out_s.reg156 <= reg_in_s.reg156;

         -- store reg157
         elsif(reg157_re_s = '1') then
            reg_out_s.reg157 <= reg_in_s.reg157;

         -- store reg158
         elsif(reg158_re_s = '1') then
            reg_out_s.reg158 <= reg_in_s.reg158;

         -- store reg159
         elsif(reg159_re_s = '1') then
            reg_out_s.reg159 <= reg_in_s.reg159;

         -- store reg160
         elsif(reg160_re_s = '1') then
            reg_out_s.reg160 <= reg_in_s.reg160;

         -- store reg161
         elsif(reg161_re_s = '1') then
            reg_out_s.reg161 <= reg_in_s.reg161;

         -- store reg162
         elsif(reg162_re_s = '1') then
            reg_out_s.reg162 <= reg_in_s.reg162;

         -- store reg163
         elsif(reg163_re_s = '1') then
            reg_out_s.reg163 <= reg_in_s.reg163;

         -- store reg164
         elsif(reg164_re_s = '1') then
            reg_out_s.reg164 <= reg_in_s.reg164;

         -- store reg165
         elsif(reg165_re_s = '1') then
            reg_out_s.reg165 <= reg_in_s.reg165;

         -- store reg166
         elsif(reg166_re_s = '1') then
            reg_out_s.reg166 <= reg_in_s.reg166;

         -- store reg167
         elsif(reg167_re_s = '1') then
            reg_out_s.reg167 <= reg_in_s.reg167;

         -- store reg168
         elsif(reg168_re_s = '1') then
            reg_out_s.reg168 <= reg_in_s.reg168;

         -- store reg169
         elsif(reg169_re_s = '1') then
            reg_out_s.reg169 <= reg_in_s.reg169;

         -- store reg170
         elsif(reg170_re_s = '1') then
            reg_out_s.reg170 <= reg_in_s.reg170;

         -- store reg171
         elsif(reg171_re_s = '1') then
            reg_out_s.reg171 <= reg_in_s.reg171;

         -- store reg172
         elsif(reg172_re_s = '1') then
            reg_out_s.reg172 <= reg_in_s.reg172;

         -- store reg173
         elsif(reg173_re_s = '1') then
            reg_out_s.reg173 <= reg_in_s.reg173;

         -- store reg174
         elsif(reg174_re_s = '1') then
            reg_out_s.reg174 <= reg_in_s.reg174;

         -- store reg175
         elsif(reg175_re_s = '1') then
            reg_out_s.reg175 <= reg_in_s.reg175;

         -- store reg176
         elsif(reg176_re_s = '1') then
            reg_out_s.reg176 <= reg_in_s.reg176;

         -- store reg177
         elsif(reg177_re_s = '1') then
            reg_out_s.reg177 <= reg_in_s.reg177;

         -- store reg178
         elsif(reg178_re_s = '1') then
            reg_out_s.reg178 <= reg_in_s.reg178;

         -- store reg179
         elsif(reg179_re_s = '1') then
            reg_out_s.reg179 <= reg_in_s.reg179;

         -- store reg180
         elsif(reg180_re_s = '1') then
            reg_out_s.reg180 <= reg_in_s.reg180;

         -- store reg181
         elsif(reg181_re_s = '1') then
            reg_out_s.reg181 <= reg_in_s.reg181;

         -- store reg182
         elsif(reg182_re_s = '1') then
            reg_out_s.reg182 <= reg_in_s.reg182;

         -- store reg183
         elsif(reg183_re_s = '1') then
            reg_out_s.reg183 <= reg_in_s.reg183;

         -- store reg184
         elsif(reg184_re_s = '1') then
            reg_out_s.reg184 <= reg_in_s.reg184;

         -- store reg185
         elsif(reg185_re_s = '1') then
            reg_out_s.reg185 <= reg_in_s.reg185;

         -- store reg186
         elsif(reg186_re_s = '1') then
            reg_out_s.reg186 <= reg_in_s.reg186;

         -- store reg187
         elsif(reg187_re_s = '1') then
            reg_out_s.reg187 <= reg_in_s.reg187;

         -- store reg188
         elsif(reg188_re_s = '1') then
            reg_out_s.reg188 <= reg_in_s.reg188;

         -- store reg189
         elsif(reg189_re_s = '1') then
            reg_out_s.reg189 <= reg_in_s.reg189;

         -- store reg190
         elsif(reg190_re_s = '1') then
            reg_out_s.reg190 <= reg_in_s.reg190;

         -- store reg191
         elsif(reg191_re_s = '1') then
            reg_out_s.reg191 <= reg_in_s.reg191;

         -- store reg192
         elsif(reg192_re_s = '1') then
            reg_out_s.reg192 <= reg_in_s.reg192;

         -- store reg193
         elsif(reg193_re_s = '1') then
            reg_out_s.reg193 <= reg_in_s.reg193;

         -- store reg194
         elsif(reg194_re_s = '1') then
            reg_out_s.reg194 <= reg_in_s.reg194;

         -- store reg195
         elsif(reg195_re_s = '1') then
            reg_out_s.reg195 <= reg_in_s.reg195;

         -- store reg196
         elsif(reg196_re_s = '1') then
            reg_out_s.reg196 <= reg_in_s.reg196;

         -- store reg197
         elsif(reg197_re_s = '1') then
            reg_out_s.reg197 <= reg_in_s.reg197;

         -- store reg198
         elsif(reg198_re_s = '1') then
            reg_out_s.reg198 <= reg_in_s.reg198;

         -- store reg199
         elsif(reg199_re_s = '1') then
            reg_out_s.reg199 <= reg_in_s.reg199;

         -- store reg200
         elsif(reg200_re_s = '1') then
            reg_out_s.reg200 <= reg_in_s.reg200;

         -- store reg201
         elsif(reg201_re_s = '1') then
            reg_out_s.reg201 <= reg_in_s.reg201;

         -- store reg202
         elsif(reg202_re_s = '1') then
            reg_out_s.reg202 <= reg_in_s.reg202;

         -- store reg203
         elsif(reg203_re_s = '1') then
            reg_out_s.reg203 <= reg_in_s.reg203;

         -- store reg204
         elsif(reg204_re_s = '1') then
            reg_out_s.reg204 <= reg_in_s.reg204;

         -- store reg205
         elsif(reg205_re_s = '1') then
            reg_out_s.reg205 <= reg_in_s.reg205;

         -- store reg206
         elsif(reg206_re_s = '1') then
            reg_out_s.reg206 <= reg_in_s.reg206;

         -- store reg207
         elsif(reg207_re_s = '1') then
            reg_out_s.reg207 <= reg_in_s.reg207;

         -- store reg208
         elsif(reg208_re_s = '1') then
            reg_out_s.reg208 <= reg_in_s.reg208;

         -- store reg209
         elsif(reg209_re_s = '1') then
            reg_out_s.reg209 <= reg_in_s.reg209;

         -- store reg210
         elsif(reg210_re_s = '1') then
            reg_out_s.reg210 <= reg_in_s.reg210;

         -- store reg211
         elsif(reg211_re_s = '1') then
            reg_out_s.reg211 <= reg_in_s.reg211;

         -- store reg212
         elsif(reg212_re_s = '1') then
            reg_out_s.reg212 <= reg_in_s.reg212;

         -- store reg213
         elsif(reg213_re_s = '1') then
            reg_out_s.reg213 <= reg_in_s.reg213;

         -- store reg214
         elsif(reg214_re_s = '1') then
            reg_out_s.reg214 <= reg_in_s.reg214;

         -- store reg215
         elsif(reg215_re_s = '1') then
            reg_out_s.reg215 <= reg_in_s.reg215;

         -- store reg216
         elsif(reg216_re_s = '1') then
            reg_out_s.reg216 <= reg_in_s.reg216;

         -- store reg217
         elsif(reg217_re_s = '1') then
            reg_out_s.reg217 <= reg_in_s.reg217;

         -- store reg218
         elsif(reg218_re_s = '1') then
            reg_out_s.reg218 <= reg_in_s.reg218;

         -- store reg219
         elsif(reg219_re_s = '1') then
            reg_out_s.reg219 <= reg_in_s.reg219;

         -- store reg220
         elsif(reg220_re_s = '1') then
            reg_out_s.reg220 <= reg_in_s.reg220;

         -- store reg221
         elsif(reg221_re_s = '1') then
            reg_out_s.reg221 <= reg_in_s.reg221;

         -- store reg222
         elsif(reg222_re_s = '1') then
            reg_out_s.reg222 <= reg_in_s.reg222;

         -- store reg223
         elsif(reg223_re_s = '1') then
            reg_out_s.reg223 <= reg_in_s.reg223;

         -- store reg224
         elsif(reg224_re_s = '1') then
            reg_out_s.reg224 <= reg_in_s.reg224;

         -- store reg225
         elsif(reg225_re_s = '1') then
            reg_out_s.reg225 <= reg_in_s.reg225;

         -- store reg226
         elsif(reg226_re_s = '1') then
            reg_out_s.reg226 <= reg_in_s.reg226;

         -- store reg227
         elsif(reg227_re_s = '1') then
            reg_out_s.reg227 <= reg_in_s.reg227;

         -- store reg228
         elsif(reg228_re_s = '1') then
            reg_out_s.reg228 <= reg_in_s.reg228;

         -- store reg229
         elsif(reg229_re_s = '1') then
            reg_out_s.reg229 <= reg_in_s.reg229;

         -- store reg230
         elsif(reg230_re_s = '1') then
            reg_out_s.reg230 <= reg_in_s.reg230;

         -- store reg231
         elsif(reg231_re_s = '1') then
            reg_out_s.reg231 <= reg_in_s.reg231;

         -- store reg232
         elsif(reg232_re_s = '1') then
            reg_out_s.reg232 <= reg_in_s.reg232;

         -- store reg233
         elsif(reg233_re_s = '1') then
            reg_out_s.reg233 <= reg_in_s.reg233;

         -- store reg234
         elsif(reg234_re_s = '1') then
            reg_out_s.reg234 <= reg_in_s.reg234;

         -- store reg235
         elsif(reg235_re_s = '1') then
            reg_out_s.reg235 <= reg_in_s.reg235;

         -- store reg236
         elsif(reg236_re_s = '1') then
            reg_out_s.reg236 <= reg_in_s.reg236;

         -- store reg237
         elsif(reg237_re_s = '1') then
            reg_out_s.reg237 <= reg_in_s.reg237;

         -- store reg238
         elsif(reg238_re_s = '1') then
            reg_out_s.reg238 <= reg_in_s.reg238;

         -- store reg239
         elsif(reg239_re_s = '1') then
            reg_out_s.reg239 <= reg_in_s.reg239;

         -- store reg240
         elsif(reg240_re_s = '1') then
            reg_out_s.reg240 <= reg_in_s.reg240;

         -- store reg241
         elsif(reg241_re_s = '1') then
            reg_out_s.reg241 <= reg_in_s.reg241;

         -- store reg242
         elsif(reg242_re_s = '1') then
            reg_out_s.reg242 <= reg_in_s.reg242;

         -- store reg243
         elsif(reg243_re_s = '1') then
            reg_out_s.reg243 <= reg_in_s.reg243;

         -- store reg244
         elsif(reg244_re_s = '1') then
            reg_out_s.reg244 <= reg_in_s.reg244;

         -- store reg245
         elsif(reg245_re_s = '1') then
            reg_out_s.reg245 <= reg_in_s.reg245;

         -- store reg246
         elsif(reg246_re_s = '1') then
            reg_out_s.reg246 <= reg_in_s.reg246;

         -- store reg247
         elsif(reg247_re_s = '1') then
            reg_out_s.reg247 <= reg_in_s.reg247;

         -- store reg248
         elsif(reg248_re_s = '1') then
            reg_out_s.reg248 <= reg_in_s.reg248;

         -- store reg249
         elsif(reg249_re_s = '1') then
            reg_out_s.reg249 <= reg_in_s.reg249;

         -- store reg250
         elsif(reg250_re_s = '1') then
            reg_out_s.reg250 <= reg_in_s.reg250;

         -- store reg251
         elsif(reg251_re_s = '1') then
            reg_out_s.reg251 <= reg_in_s.reg251;

         -- store reg252
         elsif(reg252_re_s = '1') then
            reg_out_s.reg252 <= reg_in_s.reg252;

         -- store reg253
         elsif(reg253_re_s = '1') then
            reg_out_s.reg253 <= reg_in_s.reg253;

         -- store reg254
         elsif(reg254_re_s = '1') then
            reg_out_s.reg254 <= reg_in_s.reg254;

         -- store reg255
         elsif(reg255_re_s = '1') then
            reg_out_s.reg255 <= reg_in_s.reg255;


         -- hold
         else
            reg_out_s <= reg_out_s;
         end if;
      end if;
   end process REGISTERS;

end behavioral;
