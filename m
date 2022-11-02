Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9710616DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiKBTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKBTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:33:33 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1A2ADC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:33:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z30so12448905qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2CefYhKNzgp79ypbHnSizLdxwSk630ek8DWtkcvmuU=;
        b=SEL+TEmXPenFH9WZf7nRRsKJhNOSkGKXixAJgiZ+4obv9xC1DRrrTwhtGWPtRwWKQ9
         WDXIV+wvyd+rWgwh3XkYxmgNO9xWNO0ZQD4QGxb55vzHyCs72C52sth5fZpcT1QrI/Kz
         ivIPqdmHZyRSG3a+cqjQK/eBD3PSK0yFt9DDYmHpwViYmuoWb+fmoyFoX8zUIWEz2F6i
         L4+rRLeiK43XYqhLV0RURZATh9IVkjHe0h6rNUPCltVK75FnXn5SaVaUmNDuzGoaYKzk
         8r9iYwtmInlF9HIwlRHREMkHlXQmPjGnZfN8bXnFVSOMtLSGaXul9RsYRKioeeEop6w9
         M9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2CefYhKNzgp79ypbHnSizLdxwSk630ek8DWtkcvmuU=;
        b=Qy9wrBPYby8F3hMhM4uZxfSGmnK5WphdoyCdZwL6j88Th6d1VaRVNFQZToKsOOJWcm
         AJNxl9mpPm05oMjU7ZULnVdolbC67U7I3iiGoFXh4zNgflOz9suDBAy441DeFlTxpmT9
         KV3mmkKK2JVGYDxT+dK4vZtQbob2+XkqALTHUV6nuIpMnSBVfsbmeLHxVwKMGpHKQX1e
         I9Sx13/hNICgrJdFf7e8bDSYubl7njdZ+8ScONqWdjca5dCNVw4E+fMDIVV+yK0hHbcY
         J7+OdPaGIM42pMQJxD0VVh26leM3+BjTZWC/aIf13V7kKEYw1QRjGdavarLXpglY0QY7
         i4IQ==
X-Gm-Message-State: ACrzQf0bTawmXe0Jt5nw8FbBsrJcfKW8Tv0HxTlvFW9A39aigM/WPB+n
        TvkILdrbW/MTUmPJYyY9ImyQDcjIkvCdGrBK
X-Google-Smtp-Source: AMsMyM4pIQNVuSbU04VVjTWveQEYOx+UaRK4beSmwiF9GxPGWEn/2ri3Fe77Q1bnN5KeOFMHYgwgrQ==
X-Received: by 2002:a05:620a:1511:b0:6fa:2605:4582 with SMTP id i17-20020a05620a151100b006fa26054582mr14563373qkk.697.1667417610934;
        Wed, 02 Nov 2022 12:33:30 -0700 (PDT)
Received: from ?IPV6:2607:fb90:9a29:563d:6ca3:50ff:fe5f:eabe? ([2607:fb90:9a29:563d:6ca3:50ff:fe5f:eabe])
        by smtp.gmail.com with ESMTPSA id gb11-20020a05622a598b00b003999d25e772sm7079420qtb.71.2022.11.02.12.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:33:29 -0700 (PDT)
Message-ID: <8398de34-5363-30c4-299b-b5717fc89635@landley.net>
Date:   Wed, 2 Nov 2022 14:43:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Replace timeconst.bc with mktimeconst.c
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        toybox <toybox@lists.landley.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Landley <rob@landley.net>
---

 Kbuild                    |    7 +-
 kernel/time/mktimeconst.c |  110 +++++++++++++++++++++++++++++++++
 kernel/time/timeconst.bc  |  117 ------------------------------------
 3 files changed, 115 insertions(+), 119 deletions(-)

Update for 6.0 of my old patch replacing timeconst.pl with mktimeconst.c,
removing the only user of "bc" from the build. Last posted to this list...
sometime around 2013 I think? I started from the 2015 version at
https://github.com/landley/aboriginal/blob/master/sources/patches/linux-noperl-timeconst.patch
and not much had changed. One extra iteration of the loop for nanoseconds
and different makefile plumbing.

In theory you could use this version to calculate the values at startup in
a small _init function and eliminate the header, perhaps even allowing HZ
to change at runtime. But...

  $ egrep -rl 'HZ_TO_|SEC_TO_HZ_' * | wc -l
  29

Bit more intrusive than I'm up for at the moment.

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..32c89a28e4dc 100644
--- a/Kbuild
+++ b/Kbuild
@@ -18,9 +18,12 @@ $(bounds-file): kernel/bounds.s FORCE
 
 timeconst-file := include/generated/timeconst.h
 
-filechk_gentimeconst = echo $(CONFIG_HZ) | bc -q $<
+hostprogs += mktimeconst
+mktimeconst-objs = kernel/time/mktimeconst.o
 
-$(timeconst-file): kernel/time/timeconst.bc FORCE
+filechk_gentimeconst = $(obj)/mktimeconst $(CONFIG_HZ) -
+
+$(timeconst-file): $(obj)/mktimeconst FORCE
 	$(call filechk,gentimeconst)
 
 #####
--- /dev/null	2022-09-01 11:12:08.823776915 -0500
+++ linux/kernel/time/mktimeconst.c	2022-11-02 11:57:05.279404681 -0500
@@ -0,0 +1,110 @@
+/* Copyright 2010-2022 Rob Landley <rob@landley.net> */
+
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+int main(int argc, char *argv[])
+{
+	uint64_t hz, periods[] = {1000, 1000000, 1000000000};
+	char *names[] = {"MSEC", "USEC", "NSEC"};
+	FILE *file = !strcmp(argv[2], "-") ? stdout : fopen(argv[2], "w");
+	int i, j;
+
+	if (argc != 3 || (hz = atol(argv[1])) < 1 || !file)
+	{
+		fprintf(stderr, "Usage: mktimeconst HZ FILENAME\n\n");
+		fprintf(stderr, "Generate a header file with constants to convert between\n");
+		fprintf(stderr, "decimal HZ timer ticks and milisecond or microsecond delays,\n");
+		fprintf(stderr, "using reciprocal multiplication to avoid 64 bit division.\n");
+		exit(1);
+	}
+
+	fprintf(file,
+		"/* Conversion constants for HZ == %"PRIu64" */\n\n"
+		"/* Automatically generated by kernel/time/mktimeconst.c */\n"
+		"/* This could be generated in __init code but isn't */\n"
+		
+ 		"#ifndef __KERNEL_TIMECONST_H\n"
+ 		"#define __KERNEL_TIMECONST_H\n\n"
+ 		"#include <linux/param.h>\n"
+ 		"#include <linux/types.h>\n\n"
+ 		"#if HZ != %"PRIu64"\n"
+ 		"#error \"include/generated/timeconst.h has the wrong HZ value!\"\n"
+ 		"#endif\n\n", hz, hz);
+
+	/* Repeat for MSEC, USEC, and NSEC */
+
+	for (i = 0; i < 3; i++) {
+		uint64_t gcd, period;
+
+		/* Find greatest common denominator using Euclid's algorithm. */
+
+		gcd = hz;
+		period = periods[i];
+		while (period) {
+			uint64_t temp = gcd % period;
+			gcd = period;
+			period = temp;
+		}
+
+		/* Output both directions (HZ_TO_PERIOD and PERIOD_TO_HZ) */
+
+		for (j = 0; j < 2; j++) {
+			char name[16];
+			uint64_t from = j ? periods[i] : hz;
+			uint64_t to = j ? hz : periods[i];
+			uint64_t mul32 = 0, adj32 = 0, shift = 0;
+
+			sprintf(name, j ? "%s_TO_HZ" : "HZ_TO_%s", names[i]);
+
+			/* Figure out what shift value gives 32 significant
+			   bits of MUL32 data.  (Worst case to=1 from=1000000
+			   uses 52 bits, to<<shift won't overflow 64 bit math.)
+			*/
+
+			for (;;) {
+				mul32 = ((to << shift) + from - 1) / from;
+				if (mul32 >= (1UL<<31))
+					break;
+				shift++;
+			}
+
+			/* ADJ32 is is just (((FROM/GCD)-1)<<SHIFT)/(FROM/GCD)
+			   but this can overflow 64 bit math (examples, HZ=24
+			   or HZ=122).  Worst case scenario uses 32+20+20=72
+			   bits.  Workaround: split off bottom 32 bits and
+			   reassemble after calculation (32+64=96 bits). */
+
+			adj32 = from / gcd;
+
+			if (shift > 32) {
+				uint64_t upper, lower;
+
+				upper = (adj32 - 1) << (shift - 32);
+				lower = (upper % adj32) << 32;
+				adj32 = ((upper/adj32) << 32) + (lower/adj32);
+			} else
+				adj32 = ((adj32 - 1) << shift) / adj32;
+
+			/* Emit the constants into the header file. */
+
+			fprintf(file, "#define %s_MUL32\tU64_C(0x%"PRIx64")\n",
+				name, mul32);
+			fprintf(file, "#define %s_ADJ32\tU64_C(0x%"PRIx64")\n",
+				name, adj32);
+			fprintf(file, "#define %s_SHR32\t%"PRIu64"\n",
+				name, shift);
+			fprintf(file, "#define %s_NUM\t\tU64_C(%"PRIu64")\n",
+				name, to/gcd);
+			fprintf(file, "#define %s_DEN\t\tU64_C(%"PRIu64")\n\n",
+				name, from/gcd);
+		}
+	}
+	fprintf(file, "#endif /* __KERNEL_TIMECONST_H */\n");
+
+	/* Notice if the disk fills up. */
+
+	fflush(file);
+}
--- linux/kernel/time/timeconst.bc	2022-11-02 11:16:37.711491455 -0500
+++ /dev/null	2022-09-01 11:12:08.823776915 -0500
@@ -1,117 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-scale=0
-
-define gcd(a,b) {
-	auto t;
-	while (b) {
-		t = b;
-		b = a % b;
-		a = t;
-	}
-	return a;
-}
-
-/* Division by reciprocal multiplication. */
-define fmul(b,n,d) {
-       return (2^b*n+d-1)/d;
-}
-
-/* Adjustment factor when a ceiling value is used.  Use as:
-   (imul * n) + (fmulxx * n + fadjxx) >> xx) */
-define fadj(b,n,d) {
-	auto v;
-	d = d/gcd(n,d);
-	v = 2^b*(d-1)/d;
-	return v;
-}
-
-/* Compute the appropriate mul/adj values as well as a shift count,
-   which brings the mul value into the range 2^b-1 <= x < 2^b.  Such
-   a shift value will be correct in the signed integer range and off
-   by at most one in the upper half of the unsigned range. */
-define fmuls(b,n,d) {
-	auto s, m;
-	for (s = 0; 1; s++) {
-		m = fmul(s,n,d);
-		if (m >= 2^(b-1))
-			return s;
-	}
-	return 0;
-}
-
-define timeconst(hz) {
-	print "/* Automatically generated by kernel/time/timeconst.bc */\n"
-	print "/* Time conversion constants for HZ == ", hz, " */\n"
-	print "\n"
-
-	print "#ifndef KERNEL_TIMECONST_H\n"
-	print "#define KERNEL_TIMECONST_H\n\n"
-
-	print "#include <linux/param.h>\n"
-	print "#include <linux/types.h>\n\n"
-
-	print "#if HZ != ", hz, "\n"
-	print "#error \qinclude/generated/timeconst.h has the wrong HZ value!\q\n"
-	print "#endif\n\n"
-
-	if (hz < 2) {
-		print "#error Totally bogus HZ value!\n"
-	} else {
-		s=fmuls(32,1000,hz)
-		obase=16
-		print "#define HZ_TO_MSEC_MUL32\tU64_C(0x", fmul(s,1000,hz), ")\n"
-		print "#define HZ_TO_MSEC_ADJ32\tU64_C(0x", fadj(s,1000,hz), ")\n"
-		obase=10
-		print "#define HZ_TO_MSEC_SHR32\t", s, "\n"
-
-		s=fmuls(32,hz,1000)
-		obase=16
-		print "#define MSEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000), ")\n"
-		print "#define MSEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000), ")\n"
-		obase=10
-		print "#define MSEC_TO_HZ_SHR32\t", s, "\n"
-
-		obase=10
-		cd=gcd(hz,1000)
-		print "#define HZ_TO_MSEC_NUM\t\t", 1000/cd, "\n"
-		print "#define HZ_TO_MSEC_DEN\t\t", hz/cd, "\n"
-		print "#define MSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
-		print "#define MSEC_TO_HZ_DEN\t\t", 1000/cd, "\n"
-		print "\n"
-
-		s=fmuls(32,1000000,hz)
-		obase=16
-		print "#define HZ_TO_USEC_MUL32\tU64_C(0x", fmul(s,1000000,hz), ")\n"
-		print "#define HZ_TO_USEC_ADJ32\tU64_C(0x", fadj(s,1000000,hz), ")\n"
-		obase=10
-		print "#define HZ_TO_USEC_SHR32\t", s, "\n"
-
-		s=fmuls(32,hz,1000000)
-		obase=16
-		print "#define USEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000000), ")\n"
-		print "#define USEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000000), ")\n"
-		obase=10
-		print "#define USEC_TO_HZ_SHR32\t", s, "\n"
-
-		obase=10
-		cd=gcd(hz,1000000)
-		print "#define HZ_TO_USEC_NUM\t\t", 1000000/cd, "\n"
-		print "#define HZ_TO_USEC_DEN\t\t", hz/cd, "\n"
-		print "#define USEC_TO_HZ_NUM\t\t", hz/cd, "\n"
-		print "#define USEC_TO_HZ_DEN\t\t", 1000000/cd, "\n"
-
-		cd=gcd(hz,1000000000)
-		print "#define HZ_TO_NSEC_NUM\t\t", 1000000000/cd, "\n"
-		print "#define HZ_TO_NSEC_DEN\t\t", hz/cd, "\n"
-		print "#define NSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
-		print "#define NSEC_TO_HZ_DEN\t\t", 1000000000/cd, "\n"
-		print "\n"
-
-		print "#endif /* KERNEL_TIMECONST_H */\n"
-	}
-	halt
-}
-
-hz = read();
-timeconst(hz)
