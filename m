Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4470F6BCEBA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCPLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCPLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:49:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF55527C;
        Thu, 16 Mar 2023 04:49:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w9so6524680edc.3;
        Thu, 16 Mar 2023 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678967395;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC4X7gyYMX27ih55GNpE0NiMJD+KDeM3ZDEJ0rkCdRU=;
        b=BnVZVkixrG4X8QtUa3sqYoBoJdvoMIiemrrDTnlRGv1vTLoMlKoxafcTDaKPdkJii3
         gTNBIfkFbMy1t0f7Crsu6zIAd6IZD7H2CND2uNOA06vsrV4Oqw4+wya0yZmb+3QGOcYL
         uTSqTP8E4/iCGEDYaCFZtl2cvu/gHN7/AxNTCOSoIl+oDOkXpDdseiupk3PmELIk4vql
         mmJIR76ouW7Ldsdtr/vkbNJs6u/VHXmHUAMaklXrTRo83QDCUME3IuJLuOcXJ2AS9YKn
         tyspUfvY8SPlAEQkhuuQDLSh17VrWPmJMs8A4tyMUNu0s+cxgEmpog6lQRRRnqaX8mju
         J49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967395;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC4X7gyYMX27ih55GNpE0NiMJD+KDeM3ZDEJ0rkCdRU=;
        b=K6IxRJ69xLY+wtVThub0lkwhtVjp+mtKqmdofDKG7Mtfq1ES/s3JksDC3vQK030GyA
         qK+qMBgt4c1lKU1UWchagjEo+0sd71TeHvmXoptxq6wInHVpXkC5xzDnIM9dcjLfiMlV
         tK4eVGMRZH6eqoxa+5Hy6VHE7xfCIzESqu/V/aVqJGLiUcMoUcKWw35BQsQUKX1p0oKd
         70GKS/CGpLgwshixGfj0ukS24xDY95zDLXO1RtEznskcwKJxgOdfTU5W0YrD2x3KzSDa
         Ctg4O2joqFRYIM8vVehNYuuYV3pjnSmQRYOyleOCC8uaVsMgPBLjeOgukyNwwAWJ/OhD
         QxAA==
X-Gm-Message-State: AO0yUKVTvzydEKMomoFzeLY1TULdCuyBniOrsbI0Olwg2tO3RPhuBW6/
        YxIb5t9Q0R179JZVQ5l/P8U=
X-Google-Smtp-Source: AK7set+9frqBtAJD8IC4XNzK5Mu2xwczlVSFBoe+ym6swjbG9Bt1fit7bePBC77hi8Yrv/e5uloFbg==
X-Received: by 2002:aa7:d8c4:0:b0:4fd:298a:fa12 with SMTP id k4-20020aa7d8c4000000b004fd298afa12mr5974053eds.3.1678967394853;
        Thu, 16 Mar 2023 04:49:54 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a05c:be0f:b1e7:779e])
        by smtp.gmail.com with ESMTPSA id i9-20020a50d749000000b004af6163f845sm3718720edj.28.2023.03.16.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:49:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MIPS: ath79: remove obsolete ATH79_DEV_* configs
Date:   Thu, 16 Mar 2023 12:49:52 +0100
Message-Id: <20230316114952.26253-1-lukas.bulwahn@gmail.com>
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

Commit 85b9686dae30 ("MIPS: ath79: drop platform device registration code")
removes all files arch/mips/ath79/dev-*.[ch], adjusts the Makefile, but
misses to adjust the Kconfig file. Hence, since then, the configs
ATH79_DEV_* are really dead.

Commit 3a77e0d75eed ("MIPS: ath79: drop machfiles") already removes all
configs that select ATH79_DEV_* config. So at that point, they was not a
way to enable them with a kernel build configuration.

Remove these obsolete ATH79_DEV_* configs.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/ath79/Kconfig | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 7367416642cb..04154128c4de 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -29,20 +29,4 @@ config SOC_QCA955X
 config PCI_AR724X
 	def_bool n
 
-config ATH79_DEV_GPIO_BUTTONS
-	def_bool n
-
-config ATH79_DEV_LEDS_GPIO
-	def_bool n
-
-config ATH79_DEV_SPI
-	def_bool n
-
-config ATH79_DEV_USB
-	def_bool n
-
-config ATH79_DEV_WMAC
-	depends on (SOC_AR913X || SOC_AR933X || SOC_AR934X || SOC_QCA955X)
-	def_bool n
-
 endif
-- 
2.17.1

