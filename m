Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE2B7328B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbjFPHUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbjFPHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:20:25 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36444296B;
        Fri, 16 Jun 2023 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686900014; x=1718436014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2aUGCvIvBNIT726Ho3oFmlgg+5AMla8o28pb8QXwalQ=;
  b=QPpt+QPHqg+b4CHLrMJIiaOTUc4MaUX48s1B6jVU9wuxnPMc83PHfeiM
   K66KLj+uQEecf9QcnO9wANe9MUNY8Md6gnhJ/230/e5nuagYKN3/i5IiL
   CPjz8Zj9uQrToD1U8kVY7g8GVIyYBg4qhBWiIrfrbbNZ1yT0k0M43MoFN
   ql1etQ7yuthLnKxJ+5YQsl63Tur0DRbp67YS19pE0mHpRIfuRU2LWkES8
   Mf8OKXgcL+U3rNIulIuKpiVLYyQ2IOpLYgYMTbOiHqYoIC8U2CqGdMdbp
   3B63icxb7skm958C50kTEAN41QbjUstWoxN0pniAiwquZoYOz4SDqDzat
   A==;
X-IronPort-AV: E=Sophos;i="6.00,246,1681164000"; 
   d="scan'208";a="31460053"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Jun 2023 09:20:08 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 06D98280088;
        Fri, 16 Jun 2023 09:20:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH v2 3/3] arm64: defconfig: Enable i.MX93 devices
Date:   Fri, 16 Jun 2023 09:20:05 +0200
Message-Id: <20230616072005.1781043-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616072005.1781043-1-alexander.stein@ew.tq-group.com>
References: <20230616072005.1781043-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These drivers are used on i.MX93 based devices.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57c6b7bb88d44..81ce5c4b6020a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_TOUCHSCREEN_GOODIX=m
 CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_BBNSM_PWRKEY=m
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
 CONFIG_INPUT_TPS65219_PWRBUTTON=m
@@ -676,6 +677,7 @@ CONFIG_SUNXI_WATCHDOG=m
 CONFIG_NPCM7XX_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_IMX_SC_WDT=m
+CONFIG_IMX7ULP_WDT=m
 CONFIG_QCOM_WDT=m
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
@@ -1091,6 +1093,7 @@ CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_RTC_DRV_PM8XXX=m
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_SNVS=m
+CONFIG_RTC_DRV_BBNSM=m
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_MT6397=m
 CONFIG_RTC_DRV_XGENE=y
@@ -1406,6 +1409,7 @@ CONFIG_ARM_SPE_PMU=m
 CONFIG_ARM_DMC620_PMU=m
 CONFIG_HISI_PMU=y
 CONFIG_NVMEM_IMX_OCOTP=y
+CONFIG_NVMEM_IMX_OCOTP_ELE=m
 CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_NVMEM_LAYERSCAPE_SFP=m
 CONFIG_NVMEM_MESON_EFUSE=m
-- 
2.34.1

