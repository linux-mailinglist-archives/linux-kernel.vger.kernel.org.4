Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC05363BF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiK2L6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiK2L5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:57:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391E5A6CD;
        Tue, 29 Nov 2022 03:57:29 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATB8CuE004015;
        Tue, 29 Nov 2022 11:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=J4E37CBbGAXXSsT9zVTThxpL7c5Xv4PRkiuxD6bWjas=;
 b=PouKKYjPgR8J/SxauOVdnd8XKpR7+URGpAxajX9+tEj4FrIEmZmmuPFvXiIBJBxd/7Js
 K4g4oHS7jGA6V3PLl42/nrVLfd6cBI0KVVAfaCoFephwTtEzUL/D+DPRVtE+HHaFr3k/
 2QQgzcSbv+8+6iJ6jPffRVBRzRp1mPxOswjzRie84WKVnVZLVGk0bCMSxH/aB5Ltt7gL
 XwGrC1g3RL3bseaw89Xp1m/fKpHea1PxZNJpdEFui8Dqo8+vCr34G7GjY+okC0sEGDWj
 S4UHF1zDsIKjoF52+Jw3gPNItNXCFfXBZEtkzpaq2e6+slICIguSwjIz0Cdqm38NN7rU 6A== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5gxds3cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:56:50 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATBpVEo010929;
        Tue, 29 Nov 2022 11:56:50 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3m3ae9c7v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:56:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATBul6Y38666658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 11:56:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B97BA58057;
        Tue, 29 Nov 2022 11:56:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63AA058059;
        Tue, 29 Nov 2022 11:56:46 +0000 (GMT)
Received: from Dannys-MacBook-Pro.local (unknown [9.211.123.96])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Nov 2022 11:56:46 +0000 (GMT)
Date:   Tue, 29 Nov 2022 19:56:43 +0800
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@linux.ibm.com
Subject: [PATCH 6/6] crypto: A perl script to process PowerPC assembler.
Message-ID: <Y4Xze3tOTrUQG+bi@Dannys-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qk81mhktWl3E7gTZkFgx_2m7yhvxpotT
X-Proofpoint-GUID: qk81mhktWl3E7gTZkFgx_2m7yhvxpotT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/ppc-xlate.pl | 229 +++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl

diff --git a/arch/powerpc/crypto/ppc-xlate.pl b/arch/powerpc/crypto/ppc-xlate.pl
new file mode 100644
index 000000000000..36db2ef09e5b
--- /dev/null
+++ b/arch/powerpc/crypto/ppc-xlate.pl
@@ -0,0 +1,229 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+
+# PowerPC assembler distiller by <appro>.
+
+my $flavour = shift;
+my $output = shift;
+open STDOUT,">$output" || die "can't open $output: $!";
+
+my %GLOBALS;
+my $dotinlocallabels=($flavour=~/linux/)?1:0;
+
+################################################################
+# directives which need special treatment on different platforms
+################################################################
+my $globl = sub {
+    my $junk = shift;
+    my $name = shift;
+    my $global = \$GLOBALS{$name};
+    my $ret;
+
+    $name =~ s|^[\.\_]||;
+ 
+    SWITCH: for ($flavour) {
+	/aix/		&& do { $name = ".$name";
+				last;
+			      };
+	/osx/		&& do { $name = "_$name";
+				last;
+			      };
+	/linux/
+			&& do {	$ret = "_GLOBAL($name)";
+				last;
+			      };
+    }
+
+    $ret = ".globl	$name\nalign 5\n$name:" if (!$ret);
+    $$global = $name;
+    $ret;
+};
+my $text = sub {
+    my $ret = ($flavour =~ /aix/) ? ".csect\t.text[PR],7" : ".text";
+    $ret = ".abiversion	2\n".$ret	if ($flavour =~ /linux.*64le/);
+    $ret;
+};
+my $machine = sub {
+    my $junk = shift;
+    my $arch = shift;
+    if ($flavour =~ /osx/)
+    {	$arch =~ s/\"//g;
+	$arch = ($flavour=~/64/) ? "ppc970-64" : "ppc970" if ($arch eq "any");
+    }
+    ".machine	$arch";
+};
+my $size = sub {
+    if ($flavour =~ /linux/)
+    {	shift;
+	my $name = shift; $name =~ s|^[\.\_]||;
+	my $ret  = ".size	$name,.-".($flavour=~/64$/?".":"").$name;
+	$ret .= "\n.size	.$name,.-.$name" if ($flavour=~/64$/);
+	$ret;
+    }
+    else
+    {	"";	}
+};
+my $asciz = sub {
+    shift;
+    my $line = join(",",@_);
+    if ($line =~ /^"(.*)"$/)
+    {	".byte	" . join(",",unpack("C*",$1),0) . "\n.align	2";	}
+    else
+    {	"";	}
+};
+my $quad = sub {
+    shift;
+    my @ret;
+    my ($hi,$lo);
+    for (@_) {
+	if (/^0x([0-9a-f]*?)([0-9a-f]{1,8})$/io)
+	{  $hi=$1?"0x$1":"0"; $lo="0x$2";  }
+	elsif (/^([0-9]+)$/o)
+	{  $hi=$1>>32; $lo=$1&0xffffffff;  } # error-prone with 32-bit perl
+	else
+	{  $hi=undef; $lo=$_; }
+
+	if (defined($hi))
+	{  push(@ret,$flavour=~/le$/o?".long\t$lo,$hi":".long\t$hi,$lo");  }
+	else
+	{  push(@ret,".quad	$lo");  }
+    }
+    join("\n",@ret);
+};
+
+################################################################
+# simplified mnemonics not handled by at least one assembler
+################################################################
+my $cmplw = sub {
+    my $f = shift;
+    my $cr = 0; $cr = shift if ($#_>1);
+    # Some out-of-date 32-bit GNU assembler just can't handle cmplw...
+    ($flavour =~ /linux.*32/) ?
+	"	.long	".sprintf "0x%x",31<<26|$cr<<23|$_[0]<<16|$_[1]<<11|64 :
+	"	cmplw	".join(',',$cr,@_);
+};
+my $bdnz = sub {
+    my $f = shift;
+    my $bo = $f=~/[\+\-]/ ? 16+9 : 16;	# optional "to be taken" hint
+    "	bc	$bo,0,".shift;
+} if ($flavour!~/linux/);
+my $bltlr = sub {
+    my $f = shift;
+    my $bo = $f=~/\-/ ? 12+2 : 12;	# optional "not to be taken" hint
+    ($flavour =~ /linux/) ?		# GNU as doesn't allow most recent hints
+	"	.long	".sprintf "0x%x",19<<26|$bo<<21|16<<1 :
+	"	bclr	$bo,0";
+};
+my $bnelr = sub {
+    my $f = shift;
+    my $bo = $f=~/\-/ ? 4+2 : 4;	# optional "not to be taken" hint
+    ($flavour =~ /linux/) ?		# GNU as doesn't allow most recent hints
+	"	.long	".sprintf "0x%x",19<<26|$bo<<21|2<<16|16<<1 :
+	"	bclr	$bo,2";
+};
+my $beqlr = sub {
+    my $f = shift;
+    my $bo = $f=~/-/ ? 12+2 : 12;	# optional "not to be taken" hint
+    ($flavour =~ /linux/) ?		# GNU as doesn't allow most recent hints
+	"	.long	".sprintf "0x%X",19<<26|$bo<<21|2<<16|16<<1 :
+	"	bclr	$bo,2";
+};
+# GNU assembler can't handle extrdi rA,rS,16,48, or when sum of last two
+# arguments is 64, with "operand out of range" error.
+my $extrdi = sub {
+    my ($f,$ra,$rs,$n,$b) = @_;
+    $b = ($b+$n)&63; $n = 64-$n;
+    "	rldicl	$ra,$rs,$b,$n";
+};
+my $vmr = sub {
+    my ($f,$vx,$vy) = @_;
+    "	vor	$vx,$vy,$vy";
+};
+
+# Some ABIs specify vrsave, special-purpose register #256, as reserved
+# for system use.
+my $no_vrsave = ($flavour =~ /linux-ppc64le/);
+my $mtspr = sub {
+    my ($f,$idx,$ra) = @_;
+    if ($idx == 256 && $no_vrsave) {
+	"	or	$ra,$ra,$ra";
+    } else {
+	"	mtspr	$idx,$ra";
+    }
+};
+my $mfspr = sub {
+    my ($f,$rd,$idx) = @_;
+    if ($idx == 256 && $no_vrsave) {
+	"	li	$rd,-1";
+    } else {
+	"	mfspr	$rd,$idx";
+    }
+};
+
+# PowerISA 2.06 stuff
+sub vsxmem_op {
+    my ($f, $vrt, $ra, $rb, $op) = @_;
+    "	.long	".sprintf "0x%X",(31<<26)|($vrt<<21)|($ra<<16)|($rb<<11)|($op*2+1);
+}
+# made-up unaligned memory reference AltiVec/VMX instructions
+my $lvx_u	= sub {	vsxmem_op(@_, 844); };	# lxvd2x
+my $stvx_u	= sub {	vsxmem_op(@_, 972); };	# stxvd2x
+my $lvdx_u	= sub {	vsxmem_op(@_, 588); };	# lxsdx
+my $stvdx_u	= sub {	vsxmem_op(@_, 716); };	# stxsdx
+my $lvx_4w	= sub { vsxmem_op(@_, 780); };	# lxvw4x
+my $stvx_4w	= sub { vsxmem_op(@_, 908); };	# stxvw4x
+
+# PowerISA 2.07 stuff
+sub vcrypto_op {
+    my ($f, $vrt, $vra, $vrb, $op) = @_;
+    "	.long	".sprintf "0x%X",(4<<26)|($vrt<<21)|($vra<<16)|($vrb<<11)|$op;
+}
+my $vcipher	= sub { vcrypto_op(@_, 1288); };
+my $vcipherlast	= sub { vcrypto_op(@_, 1289); };
+my $vncipher	= sub { vcrypto_op(@_, 1352); };
+my $vncipherlast= sub { vcrypto_op(@_, 1353); };
+my $vsbox	= sub { vcrypto_op(@_, 0, 1480); };
+my $vshasigmad	= sub { my ($st,$six)=splice(@_,-2); vcrypto_op(@_, $st<<4|$six, 1730); };
+my $vshasigmaw	= sub { my ($st,$six)=splice(@_,-2); vcrypto_op(@_, $st<<4|$six, 1666); };
+my $vpmsumb	= sub { vcrypto_op(@_, 1032); };
+my $vpmsumd	= sub { vcrypto_op(@_, 1224); };
+my $vpmsubh	= sub { vcrypto_op(@_, 1096); };
+my $vpmsumw	= sub { vcrypto_op(@_, 1160); };
+my $vaddudm	= sub { vcrypto_op(@_, 192);  };
+my $vadduqm	= sub { vcrypto_op(@_, 256);  };
+
+my $mtsle	= sub {
+    my ($f, $arg) = @_;
+    "	.long	".sprintf "0x%X",(31<<26)|($arg<<21)|(147*2);
+};
+
+print "#include <asm/ppc_asm.h>\n" if $flavour =~ /linux/;
+
+while($line=<>) {
+
+    $line =~ s|[#!;].*$||;	# get rid of asm-style comments...
+    $line =~ s|/\*.*\*/||;	# ... and C-style comments...
+    $line =~ s|^\s+||;		# ... and skip white spaces in beginning...
+    $line =~ s|\s+$||;		# ... and at the end
+
+    {
+	$line =~ s|\b\.L(\w+)|L$1|g;	# common denominator for Locallabel
+	$line =~ s|\bL(\w+)|\.L$1|g	if ($dotinlocallabels);
+    }
+
+    {
+	$line =~ s|^\s*(\.?)(\w+)([\.\+\-]?)\s*||;
+	my $c = $1; $c = "\t" if ($c eq "");
+	my $mnemonic = $2;
+	my $f = $3;
+	my $opcode = eval("\$$mnemonic");
+	$line =~ s/\b(c?[rf]|v|vs)([0-9]+)\b/$2/g if ($c ne "." and $flavour !~ /osx/);
+	if (ref($opcode) eq 'CODE') { $line = &$opcode($f,split(',',$line)); }
+	elsif ($mnemonic)           { $line = $c.$mnemonic.$f."\t".$line; }
+    }
+
+    print $line if ($line);
+    print "\n";
+}
+
+close STDOUT;
-- 
2.31.1


