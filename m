Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7979A6162B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKBM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:27:43 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053329C96;
        Wed,  2 Nov 2022 05:27:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y13so16261871pfp.7;
        Wed, 02 Nov 2022 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZvGB1ExMcp29WtIMrBo+pEgQiFER5J1+0To0GGikI0=;
        b=TZ5N8vp7LxMUgK1giVGCRI03mSK3u5QitWCDZNcODGHQX6bb5mVZ7Um6nnOCPaIWLp
         k5ava7cWu/CS/AGNfANz0Kn4mAjYhlGXwITIKwQvkjffaDl/06JTtZc8wfr0o6TvwOtA
         rCLEcyVNWxsu7cS4cg0bBLNkJ4xZELwvVWhWC+2+Evnbq0hYgNhAXB3MqI0CFO7hpPl9
         rBuua9ChdWE8Uo/+E/Y4mKeLeq2PJ7yP8OVLh3Xyk4F9nHIZdKm/zH+ikbkhSNo4mK1l
         amlyrqTbNGD8jSPsHZyV0RXmfhRznLW00tt0fYE2Ff7Xwbf5e/7ptppCCWzGnGMuAEsV
         Ieew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZvGB1ExMcp29WtIMrBo+pEgQiFER5J1+0To0GGikI0=;
        b=M6HyN44gXnv0JdQ7oPsd7QNNq8+CgWhiOXyGpi+shXX+2K6ZSG4d0SAi5xBf8CzrAX
         qWtmErS9ZeoI6up32URlsEwZCI0wqbus8iIKMqoCxt99vh9ealOSNG2JKuSkJAMoZukl
         Auno0lT7lfPd0LQHS2K+RDF4LuZ01GO3Ox3vDh8cGlpYf32iDB1L8PIdgif9+opitLdV
         cagWNTQnmvsX8d0fRIEL3zJ4/y+eX35xFS6t1uWMRquvrzsn9ai8nkN9k+Yc7BwxYCrd
         BncElVRiRPGX0am3e+XMViiM8dd0ZUjhx4nvS7oIWeGwxWvjakDnwCqPem4M+XGp9pIr
         9Icw==
X-Gm-Message-State: ACrzQf2Vm0gsyo/5Xm2NwqHQDc5E27uP64ONvPwTxPayJMROFlYt3VZs
        9wIL2dDRPWKM8BzZ7xjDYNQ=
X-Google-Smtp-Source: AMsMyM4oSSfM/dS5vcLfsfK3Hxn8c6M15elG4Jf6+x9YzIdJJ7IS1EjYwIVz3eHO9HVTA2UokzE9SA==
X-Received: by 2002:a63:188:0:b0:43c:22e9:2d10 with SMTP id 130-20020a630188000000b0043c22e92d10mr21549310pgb.12.1667392061827;
        Wed, 02 Nov 2022 05:27:41 -0700 (PDT)
Received: from localhost ([111.196.209.15])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902f64a00b001769cfa5cd4sm8236429plg.49.2022.11.02.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:27:41 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:27:39 +0800
From:   Rongwei Zhang <pudh4418@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maxim Uvarov <muvarov@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Rongwei Zhang <pudh4418@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] MIPS: fix duplicate definitions for exported symbols
Message-ID: <Y2JiO+67E1NyFgca@pudh-loong.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with clang-14 fails with:

AS      arch/mips/kernel/relocate_kernel.o
<unknown>:0: error: symbol 'kexec_args' is already defined
<unknown>:0: error: symbol 'secondary_kexec_args' is already defined
<unknown>:0: error: symbol 'kexec_start_address' is already defined
<unknown>:0: error: symbol 'kexec_indirection_page' is already defined
<unknown>:0: error: symbol 'relocate_new_kernel_size' is already defined

It turns out EXPORT defined in asm/asm.h expands to a symbol definition,
so there is no need to define these symbols again. Remove duplicated
symbol definitions.

Fixes: 7aa1c8f47e7e ("MIPS: kdump: Add support")
Signed-off-by: Rongwei Zhang <pudh4418@gmail.com>
---
 arch/mips/kernel/relocate_kernel.S | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index cfde14b48fd8..f5b2ef979b43 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -145,8 +145,7 @@ LEAF(kexec_smp_wait)
  * kexec_args[0..3] are used to prepare register values.
  */
 
-kexec_args:
-	EXPORT(kexec_args)
+EXPORT(kexec_args)
 arg0:	PTR_WD		0x0
 arg1:	PTR_WD		0x0
 arg2:	PTR_WD		0x0
@@ -159,8 +158,7 @@ arg3:	PTR_WD		0x0
  * their registers a0-a3. secondary_kexec_args[0..3] are used
  * to prepare register values.
  */
-secondary_kexec_args:
-	EXPORT(secondary_kexec_args)
+EXPORT(secondary_kexec_args)
 s_arg0: PTR_WD		0x0
 s_arg1: PTR_WD		0x0
 s_arg2: PTR_WD		0x0
@@ -171,19 +169,16 @@ kexec_flag:
 
 #endif
 
-kexec_start_address:
-	EXPORT(kexec_start_address)
+EXPORT(kexec_start_address)
 	PTR_WD		0x0
 	.size		kexec_start_address, PTRSIZE
 
-kexec_indirection_page:
-	EXPORT(kexec_indirection_page)
+EXPORT(kexec_indirection_page)
 	PTR_WD		0
 	.size		kexec_indirection_page, PTRSIZE
 
 relocate_new_kernel_end:
 
-relocate_new_kernel_size:
-	EXPORT(relocate_new_kernel_size)
+EXPORT(relocate_new_kernel_size)
 	PTR_WD		relocate_new_kernel_end - relocate_new_kernel
 	.size		relocate_new_kernel_size, PTRSIZE
-- 
2.38.1

