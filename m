Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA26564DAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLOL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiLOL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:57:26 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01F2E689;
        Thu, 15 Dec 2022 03:57:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5280532002D8;
        Thu, 15 Dec 2022 06:57:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Dec 2022 06:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1671105437; x=
        1671191837; bh=CxmYatH53iIqu90D51inx/cW66N9xb9CG/Cv8i8UAz8=; b=c
        ktBC1wKfu5qY6UQ7p7qQJhwRf0aJ+UhNVm1I57T85F4PSS9umIE0wlvGsJ20kbQ9
        LhMoqBz172CFsKnia7eDWa4YVtcdMKGCOIBcBhCcO2YXOmyfJftnKIIVAEDYUQsx
        gm8Ts2Sb+lBmQ/4rbs/H7JvEVrpULLJn5yjOYgnez0k32JwdCavyOMtmzSN+Dax9
        mlOl4O6VGxTRl4R5DHLnRb/8EVJMPA+cnl7DYTcTF8FfRtdygIYlweMRFAZUmBAo
        aNL+cHgYrbv6MrGZ8TwEma6xF8YNM3wuXzz3183+mi2sJ/UnX8egCovMKh3kd4qe
        pHxoBxM/WniSIOck9kJYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671105437; x=1671191837; bh=CxmYatH53iIqu
        90D51inx/cW66N9xb9CG/Cv8i8UAz8=; b=QNLvNkLaZVc8/fLinGwmMXOT0m/Lz
        3OIZ+rcxkcwFfbxIUJ5h17lKNTQzkFhgytuMbLYaYtC3GcEA4LQizqGEEFdfzHyv
        lVy6o2BneUjcNepYFBkXg8jReVkB/OuTsg296ofcCXh3TWlVsGnXaKwYybWz/Oa8
        D/Y2k9Xzn56R6hmY5ExYydJvWO8tDOiQ/D3CuhRLh1jv+5j5xtVA3Yyq/lFLI5hi
        MhwqmUHHLIyldmJWTnCBYjf6RsgedUgaTflBIOt+yM+QR4osi05F05jYI5mgftkv
        s6ubmGthM2593qNPsv+QthfV5hH+CrE6Mix0TJSh8WzC1Fzf3DidxKMkQ==
X-ME-Sender: <xms:nQubYywh0TCtguw5eM7HFOCMor8gdiz_vgej-j7wqdZ1tO49PKK3MQ>
    <xme:nQubY-TDXrEjNPESCGbPYyV8LwU-rpXHxpxVlgLkDIJELpgj8jviX-YFa63TJhmJN
    k-KHlzLeUgNnvjayTM>
X-ME-Received: <xmr:nQubY0WY6O5a6GyZbdi5geF2T6ZodUsVwQSjjKuL4i6XYE7RoGudOR0AV27UlIFFP_SEwnwoqSJL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:nQubY4g_ViyPLw2VKKOctY17HdlOeQZUeSLyJJnso1iYzEUdBCf0Tg>
    <xmx:nQubY0ABcRsN7I91kNFtKCanAOqnMH-J2ZPqR9EGTNQCk3khdBjxvg>
    <xmx:nQubY5KkI14ZvhDBrG6Q5LEoalwX1fxpWPPfuAef6x1hdXVhOMUmgA>
    <xmx:nQubY4wBA8wEAwpcVogcW2laiR6D7OUYplo99tlVhhMxFAxhJub0dw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 06:57:09 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, alistair23@gmail.com, festevam@gmail.com,
        kernel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/3] ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
Date:   Thu, 15 Dec 2022 21:56:43 +1000
Message-Id: <20221215115644.208486-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215115644.208486-1-alistair@alistair23.me>
References: <20221215115644.208486-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reMarkable 2 uses the rohm,bd71815 power controller, so enable it in
the defconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 025eb333dcaa..2b29599193a2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -213,6 +213,7 @@ CONFIG_GPIO_SIOX=m
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
+CONFIG_GPIO_BD71815=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_74X164=y
 CONFIG_POWER_RESET=y
@@ -242,8 +243,10 @@ CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_SY7636A=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
+CONFIG_MFD_ROHM_BD71828=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
+CONFIG_REGULATOR_BD71815=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
 CONFIG_REGULATOR_DA9063=y
@@ -380,6 +383,7 @@ CONFIG_RTC_DRV_ISL1208=y
 CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_M41T80=y
+CONFIG_RTC_DRV_BD70528=y
 CONFIG_RTC_DRV_RC5T619=y
 CONFIG_RTC_DRV_RV3029C2=y
 CONFIG_RTC_DRV_DA9063=y
@@ -396,6 +400,7 @@ CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_BD718XX=y
 CONFIG_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MP=y
-- 
2.38.1

