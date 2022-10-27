Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D467460F61E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiJ0LXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiJ0LXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:23:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0180510048A;
        Thu, 27 Oct 2022 04:23:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n14so734098wmq.3;
        Thu, 27 Oct 2022 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uY6K96MvM8kdidoT3f2vQiQI2jlMcMD1VqsRhi02ZgA=;
        b=IBMhQKDnmWWHKnrtpmHImTZwcyPcNSMtUPJ4Vju90frunWYRMVlPWZg5KrARFf1VF7
         j7rr0KQDlHKadvTO1M6Li84OCjI1zlbHaZ5CKWtOTLP1roDcsGau/emb6/y/PwLe7ngV
         /L3Rdn2AoFWUnidrUiCmtkAT/Yv628XMCZMCzvrO8ig175BGSC2ZM9iUkuAiCmi6eaSc
         4wUug+8AbGa8yKLx2dLFnoqptQ4+cBzLjIuzrwpAjo7JVZqMRUl18xbZ9VGcW3Z2zeZ9
         DYUFXvALZSl5RnEwURYOHT0rNHKdUYl1WYwBc5Y7rIODPgxF70GiAWFT4egAnFTb4IO6
         54ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY6K96MvM8kdidoT3f2vQiQI2jlMcMD1VqsRhi02ZgA=;
        b=si4EcgHiyIo4CUcEU4aGTi0Z0wis7fyxDczdCW+AA1+WOH8y+Da0WtufrYcjCO4SkF
         E5BVpt2swHfWINd0ouFEzSelypwnqNT2GbZMddzPj3LH4+AlnFN4WwdEj6gaPgfo0vnr
         z0JSF19q4vwjfss5Y82azLze+VOrOyTKhY5lwBuTcg36nSygIR8RidkO0pZpZwjrLBqV
         vVq2JRkGKNbM6vULbye/GjAaXAoH9FPH27UDEeHe4tPsVgiOKE7Dj+4a8Yo8p2eSd/ae
         nm1l2YLw+kuVJIJondZubO/bFTzXQm7UR2D8a4l8ARJY7cP1fH4Bdc0L1ZgClHW2YfJd
         czWQ==
X-Gm-Message-State: ACrzQf1J5LO3+b1a60t4ODxXQPcFPPsEASbjF6WVNCK+0yQB1UlHEqu+
        pJmqL//mE7S04b3Jh2bVaWCSWencgcoFKg==
X-Google-Smtp-Source: AMsMyM70rYvZIh4wwAn6qw20hdyrHftQAv8lftd68cBp3ndir8OAFF1VEMc5hrZZkozJR+z8C/xMSg==
X-Received: by 2002:a1c:4454:0:b0:3cf:4792:d3ad with SMTP id r81-20020a1c4454000000b003cf4792d3admr5654130wma.5.1666869799536;
        Thu, 27 Oct 2022 04:23:19 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:66:ff81:b0d3:60a0])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b003b4c979e6bcsm4800634wmq.10.2022.10.27.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:23:18 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ARM: shmobile: Drop selecting GPIOLIB and PINCTRL
Date:   Thu, 27 Oct 2022 12:23:00 +0100
Message-Id: <20221027112300.77184-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Don't automatically select the GPIOLIB and PINCTRL config options as we
already have automatically selected it as part of the SOC_RENESAS config
option [0].

[0] drivers/soc/renesas/Kconfig

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 37f862f13c8d..8d64cc7edccd 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -3,7 +3,5 @@ menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
-	select GPIOLIB
 	select NO_IOPORT_MAP
-	select PINCTRL
 	select ZONE_DMA if ARM_LPAE
-- 
2.17.1

