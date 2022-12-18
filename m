Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF96504A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 21:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiLRUwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 15:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 15:52:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5FB1FF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 12:52:47 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96CD61EC058A;
        Sun, 18 Dec 2022 21:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671396766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p8jNRft3cQpPAEOIVKTerwoAV7P5kvAYt4umdeGtjyA=;
        b=qVLkaV+QcR1isr8kTXSLNpU8xza32yx4vMNw/Hwc1tQ4DO90DUyyVrfpxjSLu2/NoJpk9Y
        YYmYCmHaWPOeVQ6fBIi2ux8KwniTpSpHvpM4QO9xZEKLeaFG+PCUmXqp07DTtyxby0npCM
        GdRPQ55ONDI0neF9MlimTq5qMJ06r/A=
Date:   Sun, 18 Dec 2022 21:52:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -v1.1 1/2] x86/tsc: Make recalibrate_cpu_khz() export GPL only
Message-ID: <Y599miBzWRAuOwhg@zn.tnic>
References: <20221217170511.21872-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221217170511.21872-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1.1 which removes a stray newline  too.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>

A quick search doesn't reveal any use outside of the kernel - which
would be questionable to begin with anyway - so make the export GPL
only.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/tsc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..eaeffef93a12 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -912,8 +912,7 @@ void recalibrate_cpu_khz(void)
 						    cpu_khz_old, cpu_khz);
 #endif
 }
-
-EXPORT_SYMBOL(recalibrate_cpu_khz);
+EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
 
 
 static unsigned long long cyc2ns_suspend;
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
