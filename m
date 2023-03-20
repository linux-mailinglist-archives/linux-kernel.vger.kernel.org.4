Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F56C0C59
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCTIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCTIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:38:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647ABE3BC;
        Mon, 20 Mar 2023 01:38:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so6686735edd.7;
        Mon, 20 Mar 2023 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679301490;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v5B0ZBvmnomgMaZgZ/Lok+0gkMSMRZHESpPHckBKB4=;
        b=XrqrNbGqqVagN2gpYk9X7AhO+Bjv4bEYCWjDkX1IIzzvIj4e1weJz81VSgHjKM5Wt0
         l6V/CEi+7bG79Ya9QHsjPbNh9asSchXa9kcS5u1PZeJO1b/l29AWvUmcat8oMeCDN0h7
         OGQlUsZSMTDfPBp7twlmDWJIdNmUCh5dDRmvmy1Lr0JIKtkYNFDewkFCeas7LIlIteM1
         9fvjioMPngQEOx+z35vr72jsfa7OeVLJgVOKwDjKmpp7SfbI4Vg8gXAobmoXZ60uo8w9
         w0cEDA6HrNBna6xF7fKA6NRfhIx7NxdA1ZSK1a2sX9+CDL7hNbvMgem7jnxNEm9upF8+
         kOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679301490;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4v5B0ZBvmnomgMaZgZ/Lok+0gkMSMRZHESpPHckBKB4=;
        b=SAq5mvxgaUc27KREKdx9Ibq9qu7rW40GUrQhUei4BSfs6+4nG2Wcv4VWcdNSNvkIXn
         JhBSTGYuSH9E56nbVzuaFDGmMA9pcgKnGMyA66roqchOMGdRzWFKJBLCAM2NcbQl93oR
         8fvz7+BiYXcZ7n/BcCuRWxk8HUXuCsaGcJT121DwtTWgfUCilEgGGoNFzibdo1QOkaqV
         AVMjeGfZ+jTSB0alrD9+9SM6Zj3/8lYUaX64DKmOQ2sEMcTmgqyswFxGdfvlpBdXjG+a
         IVd7uLoodZ0Xy9TmcJhRG1jxhk4GeJnQfD4H7kYkM2g5aOdwJqFhN5+DX8gFf1A9Ww/M
         niaw==
X-Gm-Message-State: AO0yUKUeijupNIZOA4zZayMjSei+UOKafyZZcArwCcL5s4Y5415/6t1F
        BHr9wRuAtTysL/HqbGF27bE=
X-Google-Smtp-Source: AK7set+EHnaBvHsOLfvKoB1PfMWKK8OuCVtRGT5mNLYFXpMX7ZwKXvbr0tjV/EkkqXV742saqRef1A==
X-Received: by 2002:aa7:c414:0:b0:4fc:65c7:a991 with SMTP id j20-20020aa7c414000000b004fc65c7a991mr14208943edq.35.1679301489901;
        Mon, 20 Mar 2023 01:38:09 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:149a:8de0:b37a:3ec9])
        by smtp.gmail.com with ESMTPSA id m11-20020a50998b000000b004c13fe8fabfsm4463170edb.84.2023.03.20.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:38:09 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: omap2: remove obsolete config OMAP3_SDRC_AC_TIMING
Date:   Mon, 20 Mar 2023 09:38:06 +0100
Message-Id: <20230320083806.9545-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d42f265a5d7a ("ARM: OMAP3: clock: remove un-used core dpll
re-program code") removes arch/arm/mach-omap2/sram34xx.S, which
implemented the effect of the config OMAP3_SDRC_AC_TIMING. Since then, the
OMAP3_SDRC_AC_TIMING config was hanging around without effect.

Remove this obsolete config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-omap2/Kconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3b53dda9ec79..821727eefd5a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -255,17 +255,6 @@ config MACH_NOKIA_N8X0
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
 
-config OMAP3_SDRC_AC_TIMING
-	bool "Enable SDRC AC timing register changes"
-	depends on ARCH_OMAP3
-	help
-	  If you know that none of your system initiators will attempt to
-	  access SDRAM during CORE DVFS, select Y here.  This should boost
-	  SDRAM performance at lower CORE OPPs.  There are relatively few
-	  users who will wish to say yes at this point - almost everyone will
-	  wish to say no.  Selecting yes without understanding what is
-	  going on could result in system crashes;
-
 endmenu
 
 endif
-- 
2.17.1

