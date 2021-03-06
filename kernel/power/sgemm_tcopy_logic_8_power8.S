/***************************************************************************
Copyright (c) 2013-2016, The OpenBLAS Project
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:
1. Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in
the documentation and/or other materials provided with the
distribution.
3. Neither the name of the OpenBLAS project nor the names of
its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE OPENBLAS PROJECT OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*****************************************************************************/

/**************************************************************************************
* 2016/04/23 Werner Saar (wernsaar@googlemail.com)
* 	 BLASTEST 		: OK
* 	 CTEST			: OK
* 	 TEST			: OK
*	 LAPACK-TEST		: OK
**************************************************************************************/


	srawi.		I,	M,	2
	ble		SCOPYOT_L2_BEGIN


SCOPYOT_L4_BEGIN:

	mr		A0,	A
	add		A1,	A0,	LDA
	add		A2,	A1,	LDA
	add		A3,	A2,	LDA
	add		A,	A3,	LDA
	mr		B8,	B
	addi		B,	B,	32*SIZE

	sradi.		J,	N,	3
	ble		SCOPYOT_L4x4_BEGIN

	mr		BO,	B8
	.align 5

SCOPYOT_L4x8_LOOP:

	dcbt		A0, PREA
	dcbt		A1, PREA
	dcbt		A2, PREA
	dcbt		A3, PREA
	COPY_4x8

	addi		A0,	A0,	8*SIZE
	addi		A1,	A1,	8*SIZE
	addi		A2,	A2,	8*SIZE
	addi		A3,	A3,	8*SIZE
	add		BO,	BO,	M8

	addic.		J,	J,	-1
	ble		SCOPYOT_L4x4_BEGIN

	COPY_4x8

	addi		A0,	A0,	8*SIZE
	addi		A1,	A1,	8*SIZE
	addi		A2,	A2,	8*SIZE
	addi		A3,	A3,	8*SIZE
	add		BO,	BO,	M8

	addic.		J,	J,	-1
	ble		SCOPYOT_L4x4_BEGIN

	COPY_4x8

	addi		A0,	A0,	8*SIZE
	addi		A1,	A1,	8*SIZE
	addi		A2,	A2,	8*SIZE
	addi		A3,	A3,	8*SIZE
	add		BO,	BO,	M8

	addic.		J,	J,	-1
	ble		SCOPYOT_L4x4_BEGIN

	COPY_4x8

	addi		A0,	A0,	8*SIZE
	addi		A1,	A1,	8*SIZE
	addi		A2,	A2,	8*SIZE
	addi		A3,	A3,	8*SIZE
	add		BO,	BO,	M8

	addic.		J,	J,	-1
	bgt		SCOPYOT_L4x8_LOOP

SCOPYOT_L4x4_BEGIN:

	andi.		T1,	N,	4
	ble		SCOPYOT_L4x2_BEGIN

	mr		BO,	B4

	COPY_4x4

	addi		A0,	A0,	4*SIZE
	addi		A1,	A1,	4*SIZE
	addi		A2,	A2,	4*SIZE
	addi		A3,	A3,	4*SIZE

	addi		B4,	B4,	16*SIZE

SCOPYOT_L4x2_BEGIN:

	andi.		T1,	N,	2
	ble		SCOPYOT_L4x1_BEGIN

	mr		BO,	B2

	COPY_4x2

	addi		A0,	A0,	2*SIZE
	addi		A1,	A1,	2*SIZE
	addi		A2,	A2,	2*SIZE
	addi		A3,	A3,	2*SIZE

	addi		B2,	B2,	8*SIZE

SCOPYOT_L4x1_BEGIN:

	andi.		T1,	N,	1
	ble		SCOPYOT_L4_END

	mr		BO,	B1

	COPY_4x1

	addi		A0,	A0,	1*SIZE
	addi		A1,	A1,	1*SIZE
	addi		A2,	A2,	1*SIZE
	addi		A3,	A3,	1*SIZE

	addi		B1,	B1,	4*SIZE

SCOPYOT_L4_END:

	addic.		I,	I,	-1
	bgt		SCOPYOT_L4_BEGIN



SCOPYOT_L2_BEGIN:

	andi.		T1,	M,	2
	ble		SCOPYOT_L1_BEGIN

	mr		A0,	A
	add		A1,	A0,	LDA
	add		A,	A1,	LDA
	mr		B8,	B
	addi		B,	B,	16*SIZE

	sradi.		J,	N,	3
	ble		SCOPYOT_L2x4_BEGIN

	mr		BO,	B8

SCOPYOT_L2x8_LOOP:

	COPY_2x8

	addi		A0,	A0,	8*SIZE
	addi		A1,	A1,	8*SIZE
	add		BO,	BO,	M8

	addic.		J,	J,	-1
	bgt		SCOPYOT_L2x8_LOOP

SCOPYOT_L2x4_BEGIN:

	andi.		T1,	N,	4
	ble		SCOPYOT_L2x2_BEGIN

	mr		BO,	B4

	COPY_2x4

	addi		A0,	A0,	4*SIZE
	addi		A1,	A1,	4*SIZE

	addi		B4,	B4,	8*SIZE

SCOPYOT_L2x2_BEGIN:

	andi.		T1,	N,	2
	ble		SCOPYOT_L2x1_BEGIN

	mr		BO,	B2

	COPY_2x2

	addi		A0,	A0,	2*SIZE
	addi		A1,	A1,	2*SIZE

	addi		B2,	B2,	4*SIZE

SCOPYOT_L2x1_BEGIN:

	andi.		T1,	N,	1
	ble		SCOPYOT_L2_END

	mr		BO,	B1

	COPY_2x1

	addi		A0,	A0,	1*SIZE
	addi		A1,	A1,	1*SIZE

	addi		B1,	B1,	2*SIZE

SCOPYOT_L2_END:


SCOPYOT_L1_BEGIN:

	andi.		T1,	M,	1
	ble		L999

	mr		A0,	A
	add		A,	A0,	LDA
	mr		B8,	B
	addi		B,	B,	8*SIZE

	sradi.		J,	N,	3
	ble		SCOPYOT_L1x4_BEGIN

	mr		BO,	B8

SCOPYOT_L1x8_LOOP:

	COPY_1x8

	addi		A0,	A0,	8*SIZE
	add		BO,	BO,	M8

	addic.		J,	J,	-1
	bgt		SCOPYOT_L1x8_LOOP

SCOPYOT_L1x4_BEGIN:

	andi.		T1,	N,	4
	ble		SCOPYOT_L1x2_BEGIN

	mr		BO,	B4

	COPY_1x4

	addi		A0,	A0,	4*SIZE

	addi		B4,	B4,	4*SIZE

SCOPYOT_L1x2_BEGIN:

	andi.		T1,	N,	2
	ble		SCOPYOT_L1x1_BEGIN

	mr		BO,	B2

	COPY_1x2

	addi		A0,	A0,	2*SIZE

	addi		B2,	B2,	2*SIZE

SCOPYOT_L1x1_BEGIN:

	andi.		T1,	N,	1
	ble		SCOPYOT_L1_END

	mr		BO,	B1

	COPY_1x1

	addi		A0,	A0,	1*SIZE

	addi		B1,	B1,	1*SIZE

SCOPYOT_L1_END:

