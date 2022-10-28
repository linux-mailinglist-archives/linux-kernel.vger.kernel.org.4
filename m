Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEE611B51
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJ1UAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJ1UAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:00:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E7181688
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:00:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n12so15375644eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZiFH0DYxlEsNHskvYIaXjWqH/sLniKamLHMSjoq7eo=;
        b=YXlezLwWzDUg0ovuvpImFTCOi4u+xvViEIK0ZbGqywfK5fKYqpUpKEGgA6izT7YMFg
         eFdLjf8BToJpjDs5AOdJdHa8Zxs/tO7ZdlpCtnalBOvu8WW4I15MQS9KOzg4Ah3Wimyj
         BkrOQrNMFLv0lYET0q042G0EjKLYDujQAd/hwqlWSXF1vCiMmmOHrKe0VPIttbsXHSKL
         zDQdzyC+9Jya9jkn+DFinJ/gqT5Ei9m6N3cyZxq3BmDvL6auwbgI7meinkK/DWbaVzNc
         MIwIDCu4zvKeZnH5/j5NFbKpPNPUnsyAWgeNDok4YsCQaJonLxe5d1etOj62RvtXAn24
         HYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZiFH0DYxlEsNHskvYIaXjWqH/sLniKamLHMSjoq7eo=;
        b=kbF15AzvpLOeMlooXnhixf298E7SL/wrQnFVUVJFB1J/qaw8s4bqTsbElJ+bhkkPUs
         A9gmlUm+ZIkZKfDQKJfEKRjiK14UQdt5W1MMPMz67Qh4ZI4rZYuMghl4nOgn/tBzuLUB
         gmlOgh3vWV+SrzwXnDEIEfCUb+axLqQl9Ic0x54cS2aYpunOPq4PWhhOKq14ckH5n7/I
         daNJoGV9oe16Sz3SxNDFGw4IJNJJuHGmw6YapilTp2a6syI7xMhUtMujycJXrR/w3QJi
         EkZ2dA5WEoGEsIvmJRCq0zdK77044Vyhbho7+BAF+cHBOmzNAjFR03lPr0GZLn5zZ78V
         /uCg==
X-Gm-Message-State: ACrzQf1VMIUUhh1KwGswYwkQjoVr/DS8OCAb3c1ZF8PAV0gadfb7xg/e
        VnDzVrvDNzRi+u4yHkjGZA==
X-Google-Smtp-Source: AMsMyM7YTqVgKSA3PAn5GzG78RedkorzQDl8NSWGWSM7nkRrfS7w/bxpIHOvmbwTQKcvOlS9JZt/DQ==
X-Received: by 2002:a17:907:75c8:b0:78d:b646:e768 with SMTP id jl8-20020a17090775c800b0078db646e768mr907428ejc.432.1666987233242;
        Fri, 28 Oct 2022 13:00:33 -0700 (PDT)
Received: from p183 ([46.53.251.139])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709061b5400b0073d7b876621sm308686ejg.205.2022.10.28.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:00:32 -0700 (PDT)
Date:   Fri, 28 Oct 2022 23:00:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        rafael.j.wysocki@intel.com, masahiroy@kernel.org
Subject: [PATCH] kbuild: drop -Wdeclaration-after-statement
Message-ID: <Y1w031iI6Ld29IVT@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting declarations in the beginning of the block is an afterfact from
single pass compiler era. Compiler would parse all declarations, layout
stack frame and proceed to generate code.

In C initialisers can be arbitrarily complex so there is no fundamental
distinction between initialiser and regular code.
-Wno-declaration-after-statement creates such distinction which is
entirely artificial.

This will save LOC in the long run because people would write code like
this:

	int a = f();

This will make one rare class of bugs even more rare:

	int a;
	...
	f(&a);	// bug, typo, should be f(&x)
	...
	a = g();

If declarations are allowed anywhere, the above would be written as

	f(&a);
	int a = g();

and it would not compile because "a" lives for less LOC window.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile                          |    6 +-----
 arch/arm64/kernel/vdso32/Makefile |    2 --
 tools/power/acpi/Makefile.config  |    1 -
 tools/power/cpupower/Makefile     |    1 -
 tools/scripts/Makefile.include    |    1 -
 5 files changed, 1 insertion(+), 10 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -452,8 +452,7 @@ HOSTRUSTC = rustc
 HOSTPKG_CONFIG	= pkg-config
 
 KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
-			 -O2 -fomit-frame-pointer -std=gnu11 \
-			 -Wdeclaration-after-statement
+			 -O2 -fomit-frame-pointer -std=gnu11
 KBUILD_USERCFLAGS  := $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
 KBUILD_USERLDFLAGS := $(USERLDFLAGS)
 
@@ -1011,9 +1010,6 @@ endif
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc
 
-# warn about C99 declaration after statement
-KBUILD_CFLAGS += -Wdeclaration-after-statement
-
 # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
 KBUILD_CFLAGS += -Wvla
 
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -68,11 +68,9 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -fno-strict-aliasing -fno-common \
                -Werror-implicit-function-declaration \
                -Wno-format-security \
-               -Wdeclaration-after-statement \
                -std=gnu11
 VDSO_CFLAGS  += -O2
 # Some useful compiler-dependent flags from top-level Makefile
-VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
 VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
 VDSO_CFLAGS += -fno-strict-overflow
 VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -63,7 +63,6 @@ OPTIMIZATION := $(call cc-supports,-Os,-O2)
 
 WARNINGS := -Wall
 WARNINGS += $(call cc-supports,-Wstrict-prototypes)
-WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 
 KERNEL_INCLUDE := $(OUTPUT)include
 ACPICA_INCLUDE := $(srctree)/../../../drivers/acpi/acpica
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -118,7 +118,6 @@ OPTIMIZATION := $(call cc-supports,-Os,-O2)
 
 WARNINGS := -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare
 WARNINGS += $(call cc-supports,-Wno-pointer-sign)
-WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 WARNINGS += -Wshadow
 
 override CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -21,7 +21,6 @@ endif
 # Include saner warnings here, which can catch bugs:
 #
 EXTRA_WARNINGS := -Wbad-function-cast
-EXTRA_WARNINGS += -Wdeclaration-after-statement
 EXTRA_WARNINGS += -Wformat-security
 EXTRA_WARNINGS += -Wformat-y2k
 EXTRA_WARNINGS += -Winit-self
