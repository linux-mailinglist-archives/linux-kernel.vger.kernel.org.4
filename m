Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2D69E915
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBUUnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBUUnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:43:04 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34982902C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:43:01 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9so2442922ile.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vm75klYCEzEbHDHndrCCa53U4DXnX5iMoTt+cEU3S0k=;
        b=2NS3OR2pHewL7snzecmtNkKql2ldQjPzSlRQ492qlYpP3HVihZQxhtknTitHhGpSPp
         Vg52n9qaS1s1VyIPF0N2gMGATTKkUf23t6apX4QaDB+hHfuu2dEomMXJ9mNJaOEc/lFD
         f6JAunLj3KSPRrUt9bzYImyTqJjpRfuZtGWQasHgrTRYamZukniq7Klfm0PpgdBt9r3M
         vI2usPLjKsuGahkHtKG0aRwx26YHOfQ3j3reWufaWNN2MGRJVbgOlcZjt9CCRsEeFEsv
         53B6Pw/hW53Gk/SQegxqTDYON/vjCatV7lIlWDkRYWqCc6dvtTWtcWLA70hQBEMDzr5k
         TiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vm75klYCEzEbHDHndrCCa53U4DXnX5iMoTt+cEU3S0k=;
        b=jCDHuxLU/srplZeL0Bd1uVKE1IHJgi4SorSnlFBTSlCjrRugp4Mu4AdsXntobOHvNT
         7Knd1mRkICKSjSvGz7QmjDSqxV9IWiB1ws/hvc4qQDkFaqyS/jbkuCqvN8Krh1KZELJ3
         PDeva0ABalhPFQ8ZxJPXhQHfkB4Vnbmb3ZXuk9mkE6lAxGUqb8xd9Oil7LW0nVlodJly
         MDxlq4OmXka+rT1AQJwkHSQoFQ0Xhh4VnUXtmz8L7CoQB9BNsTq55uDqDNWZInsjb2DD
         8JV2o4L26FozVE4rTB4k/Loz4hztXf1gojK73j2o5OgmB8RVrlMmvpb8cKRjijULSo+w
         WqVQ==
X-Gm-Message-State: AO0yUKXv1cB3PhcIn5s5Po9ckz/pSINI8xvFT8C/UEaMlYt0w++yfM7t
        Pt+j3sxMcw1HstCCoXpTcfZ2Dy7WeGlnULBQTv0=
X-Google-Smtp-Source: AK7set+BqKb0dyITxhq41Bf+MYdoMIx/gS0nyjZyZhhRsbJhI5wpuapmkXX+TqHUjrCcT/ayrzxnsw==
X-Received: by 2002:a05:6e02:8aa:b0:315:9a7e:fb03 with SMTP id a10-20020a056e0208aa00b003159a7efb03mr3718684ilt.29.1677012180442;
        Tue, 21 Feb 2023 12:43:00 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id s11-20020a02ad0b000000b003c5144d10b1sm35125jan.83.2023.02.21.12.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:43:00 -0800 (PST)
Message-ID: <e184ece9-2779-675e-0c84-f0a62413c7fd@landley.net>
Date:   Tue, 21 Feb 2023 14:56:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH 2/5] X86-64 should not uniquely require a third ELF package to
 build.
Content-Language: en-US
From:   Rob Landley <rob@landley.net>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
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

x86-64 is the only architecture that can't compile without an extra
ELF library installed on the host. (The kernel already has multiple ELF
parse implementations built-in, so requiring another one is questionable
at best.) You can switch it back on in menuconfig if you want to, this
just stops it being mandatory.

See https://lkml.iu.edu/hypermail/linux/kernel/2110.3/00402.html
and https://lkml.iu.edu/hypermail/linux/kernel/2110.3/00278.html

Signed-off-by: Rob Landley <rob@landley.net>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..b63510d79baf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -243,7 +243,6 @@ config X86
 	select HAVE_NOINSTR_HACK		if HAVE_OBJTOOL
 	select HAVE_NMI
 	select HAVE_NOINSTR_VALIDATION		if HAVE_OBJTOOL
-	select HAVE_OBJTOOL			if X86_64
 	select HAVE_OPTPROBES
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
