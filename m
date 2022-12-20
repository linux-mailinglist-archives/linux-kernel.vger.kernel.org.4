Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD83651FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiLTLaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiLTL3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:29:53 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A718E33;
        Tue, 20 Dec 2022 03:29:52 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4FFDE3200033;
        Tue, 20 Dec 2022 06:29:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Dec 2022 06:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1671535790; x=
        1671622190; bh=CxmYatH53iIqu90D51inx/cW66N9xb9CG/Cv8i8UAz8=; b=E
        iDleMgthVtcYwAW4HyvIj/WexcmX40NzwrS+6evCtUIfT19AT1dC+xJkTpaWKxDz
        BDCokRNhoOOJN+04DimThL58Klzjbm6VioTXkBvEPYUV+zJnJjKNyu/Ut45mPQCl
        tCuDsW2SN755NrrTvgKlfPm6S2kmsnoCqTvLHH6MvyZOQj0dIYIr6e2A6xQ5tGcz
        M7oLOAXZOvnX/oVOzyMTGItuZfrwAedQdQlyU3ExbqbCNkTNhS5vU3uqq0MphPGg
        AWvob9Nm08DpGmXtqDqHHEZPqKnt1GxS4TjTknDq+JKawIyYsUhIEPgAp7KXzep5
        3G80Cm7ffjGONB1eo0Xyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671535790; x=1671622190; bh=CxmYatH53iIqu
        90D51inx/cW66N9xb9CG/Cv8i8UAz8=; b=kPUkUg40eWEmxR/vgtC7ZT3ZJNKu3
        0CMf8VGFkyLuhPaEuY3MWffGPfTVRKBU9UHEFq57Y9NHPgZQ5GsZ8jVU2pzC4lEJ
        WEkSJCa2egVHJiXNWw4cqsEH7jncbihJV1Kdt3NW5XsRoQZ8jUF50ibJur/rHLL9
        fqvuz2Ch4Qn0DHp0i2y7ZK8itftdHTLkgqkML5PTvteSYl472ns/MXY1rdiudg5M
        8aaV+vzY59W3167uRHJim8OGokGpDJepucDuBuzQW9rxBM+it4POuj+wwKaKpVO5
        JNPXRuFStQIwKJDNZhC/UrfquXaiL/C1FbL57hXVNszsRBAW8GAJJqQyQ==
X-ME-Sender: <xms:rpyhYyleQNj3h_jRlM8ZCSGbNyHkhIfclPZZ0nNhEzpjMWcwmFsv2g>
    <xme:rpyhY50Jw4vLPhbUHCNJW4VmenN4H1TRbsnvND1N54-XeuVTo_CPrJp2FiSZhFrsd
    5wq0okw-_CXmw2_BHk>
X-ME-Received: <xmr:rpyhYwp-yraflgoPk2GNpIJjhvtL-kdYRNk99zKOrBf2a_RpT_WOCqg4K162B2SmAh7LCJY0OR_K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:rpyhY2kSkOOXzPbGL9Hq5vYDMITT78z5k0HiahdtVitXSkxHS30mKg>
    <xmx:rpyhYw3x8ZcPJHkJIAur5qFlJtXi3WrnIWVWSjcGI3XzSbY4Sp1Njw>
    <xmx:rpyhY9vsdw_ZikMkm7IKbPa9Yb5gzsBF_DTR7iFesBuoZk3WkQUN3w>
    <xmx:rpyhY71fG5Vgf3z94xrou8c-ipGXU9MzBfCbr4Grnh0IOYpN9oQ_Ew>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Dec 2022 06:29:44 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux@armlinux.org.uk, festevam@gmail.com, kernel@pengutronix.de,
        arnd@arndb.de, alistair23@gmail.com, jernej.skrabec@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 2/3] ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
Date:   Tue, 20 Dec 2022 21:29:26 +1000
Message-Id: <20221220112927.440506-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220112927.440506-1-alistair@alistair23.me>
References: <20221220112927.440506-1-alistair@alistair23.me>
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

