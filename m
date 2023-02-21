Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B1969E91B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBUUr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBUUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:47:27 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3B2E811
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:47:25 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z3so2421283ilm.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf0g4olu2xig7H0ri3aToWO9GEhRK/5oEG6kOHqHj/Y=;
        b=XS/ubnS5zKQD08kJ3z/EGfFnkrgBt3IZR2H9lnj9GPbDHPh6lTtJdiYfA1Az3ZTP+V
         v7ONqnuVzN/thsi3+pkart7m0Ez+/nQq5A+oZUM6iYBD6shkHjhvnW4rshe2tjHw5Wnh
         F9bgbJBNMoykBwSC+6EkYfmcl37cl1gPs/IUMX4Xf/w4pp3hNQGDFkYE027d6RVwZAbq
         8KK6qJ6fbQD7BY0tHfBHvaRDg44bVVkaxoN/pBI7c5HD0rBP5PI/AX///ldjzieQC3N8
         PJTyc/U+GNJnqZlBtQ9ei8Y/CKcaj4+lPljsPv8rRpCT0iGq+wXNZRfesG+kfVgJdtMW
         MkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf0g4olu2xig7H0ri3aToWO9GEhRK/5oEG6kOHqHj/Y=;
        b=HgVoYykam95EJfs1KgmIsvManigJuvpDu40EIDoc1ye6Ac2sodysDV0Jhp/uCL6btz
         YYt8xL8RMUmrFff67N/OCTqowy8SanIXUGJjGxg9F1YqkvlplYFWGud/3qw3otCSoi9x
         BFu8NZkLjJQD/zXYg04Tau9GvsNKjlVWoGJVxz0SfE9jT1LJR4SD/RPkraXIThvwyKSr
         i8AUANWsn4cvW3JycZNF9nLUSMzM0mtmYUt6sC7AidvMFqNu37Y8L9FoEJhc9e3QgD8x
         wwh5WRGBOLD4FEaNiS+KSz2/SUeo2qjgEySdfsysr96GTSWV59kf4cqvm8xG9nkOyMTi
         kYtA==
X-Gm-Message-State: AO0yUKUjEUIdxRB9ltrPr8CnglQH2oMNmaFdPZXV1wAslIq6hvjt7u3d
        2agUY7kViIKSndVuXvN59k2sW6gP3HdIorzN
X-Google-Smtp-Source: AK7set+f2Yq0/yqaozjtP9CV0xJv1LSmfCK6bOBNaNs2oi77h3COo91kiFDKMFqLuVTcR7lMm8WEbQ==
X-Received: by 2002:a05:6e02:1c21:b0:315:48df:ecde with SMTP id m1-20020a056e021c2100b0031548dfecdemr3289324ilh.8.1677012444799;
        Tue, 21 Feb 2023 12:47:24 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id f13-20020a056e0204cd00b00315d1153ffcsm1488477ils.65.2023.02.21.12.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:47:24 -0800 (PST)
Message-ID: <9b8ce4db-9e1b-32b6-f749-94e4decc032e@landley.net>
Date:   Tue, 21 Feb 2023 15:00:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH 4/5] Replace timeconst.bc with mktimeconst.c
Content-Language: en-US
From:   Rob Landley <rob@landley.net>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
In-Reply-To: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update of my decade-old patch replacing timeconst.pl with mktimeconst.c,
still removing the only user of "bc" from the build.

All that's changed since the 2015 version at:
https://github.com/landley/aboriginal/blob/master/sources/patches/linux-noperl-timeconst.patch

Is one extra iteration of the loop for nanoseconds and different
makefile plumbing calling it. In theory this could calculate the values
at runtime in a small _init function and eliminate the header or even
allow HZ to change at runtime.

See https://lkml.iu.edu/hypermail/linux/kernel/2211.0/02589.html

Signed-off-by: Rob Landley <rob@landley.net>
---
 Kbuild                    |   7 ++-
 kernel/time/mktimeconst.c | 111 ++++++++++++++++++++++++++++++++++++
 kernel/time/timeconst.bc  | 117 --------------------------------------
 3 files changed, 116 insertions(+), 119 deletions(-)
 create mode 100644 kernel/time/mktimeconst.c
 delete mode 100644 kernel/time/timeconst.bc

diff --git a/Kbuild b/Kbuild
index 464b34a08f51..8c12f6ef58c6 100644
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
 
 # Generate asm-offsets.h
diff --git a/kernel/time/mktimeconst.c b/kernel/time/mktimeconst.c
new file mode 100644
index 000000000000..c4c0df289472
--- /dev/null
+++ b/kernel/time/mktimeconst.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: 0BSD
+// Copyright 2010-2023 Rob Landley <rob@landley.net>
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
+	FILE *file;
+	int i, j;
+
+	if (argc != 3 || (hz = atol(argv[1])) < 1
+	    || !(file = !strcmp(argv[2], "-") ? stdout : fopen(argv[2], "w"))) {
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
+		"#ifndef __KERNEL_TIMECONST_H\n"
+		"#define __KERNEL_TIMECONST_H\n\n"
+		"#include <linux/param.h>\n"
+		"#include <linux/types.h>\n\n"
+		"#if HZ != %"PRIu64"\n"
+		"#error \"include/generated/timeconst.h has the wrong HZ value!\"\n"
+		"#endif\n\n", hz, hz);
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
+
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
+			 * bits of MUL32 data.  (Worst case to=1 from=1000000
+			 * uses 52 bits, to<<shift won't overflow 64 bit math.)
+			 */
+
+			for (;;) {
+				mul32 = ((to << shift) + from - 1) / from;
+				if (mul32 >= (1UL<<31))
+					break;
+				shift++;
+			}
+
+			/* ADJ32 is just (((FROM/GCD)-1)<<SHIFT)/(FROM/GCD)
+			 * but this can overflow 64 bit math (examples, HZ=24
+			 * or HZ=122).  Worst case scenario uses 32+20+20=72
+			 * bits.  Workaround: split off bottom 32 bits and
+			 * reassemble after calculation (32+64=96 bits).
+			 */
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
diff --git a/kernel/time/timeconst.bc b/kernel/time/timeconst.bc
deleted file mode 100644
index 7ed0e0fb5831..000000000000
--- a/kernel/time/timeconst.bc
+++ /dev/null
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
