Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738DB6A3A39
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB0Eu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjB0Euz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:50:55 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFFC1C580;
        Sun, 26 Feb 2023 20:50:50 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 34973320051E;
        Sun, 26 Feb 2023 23:50:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 26 Feb 2023 23:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677473448; x=
        1677559848; bh=xfMsGJFjE2dc9rlp56RpYggvOxkwRbFQo4plIYnm1p4=; b=P
        vkMgtpgWdwxw7oa6dWKWthXOII+2fToX3jz6hv66eE6jT7lccVbabbtWrCOtCOGd
        34fRhPpS3EA/k7RVP33IGbmxq9vKBIV9/4/OHWBxnGIUzfteIwkQ81LGooUHTiv7
        8AFquNIgg0qdu24zgb+lbZng5Fd16INZxjTEbZAR/URLKmRJx8W21DL3OTlYyHpK
        0AIMdaZQBFDvF721WDhbvfdxMQ+LGQC1kYhKVZFYBnI9HVxn7oErdU+ooVqVC6Lk
        CX6v4kUOOWgbNBiADe1kd39i9LKuWnmUIcYKe3A0MTqXktqkAnfKlJhCfyav2XV1
        3WkWf0PPtodh9CbF2jgKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677473448; x=1677559848; bh=xfMsGJFjE2dc9
        rlp56RpYggvOxkwRbFQo4plIYnm1p4=; b=UGG0NQJyMueSbmBi6BJCYpyPgBVHg
        uZT1dNP9Glvkdb+Oa6MJLl2f/oRGBg793wyuvuBfdjg2V0mFvvNUBuOG4fJ9e4ol
        lpr3PKB8i2enSUtvsL+Bs5m8jh3iclXzVF8bJLDhcaFg6mCtKeBWVfGi6qcCgfsb
        qJ7n5PaAnycUi8oA8MdWoEFNb435Gii08OOImLrX4iNzbaz2ffu/8oXo1lP0hoDF
        uohxjorHJUNPa8K24ucBurThUXrLR6Gi/yNCkS9c+gc93ro82aVPKWI5w+odnG5p
        TyKsDeiiQGIl5M3UjzsIZSP/0YWGzgVv4NVJNITqrCiOQR3uuDktEjj1g==
X-ME-Sender: <xms:qDb8Y1PgChuQF9Y-n0yXhS7iDf3i_Gws9JtwFgUWv5CWv4odY0Gy_g>
    <xme:qDb8Y38xplcP8OPvrotcEJrewh0NsknJl8qkwWfU6VfX0MFo6YDjLlHUr8W-3ax47
    Lv6PFIhmokDyzuf-08>
X-ME-Received: <xmr:qDb8Y0SFr1zbK6aH3Sk9z75cpJ8VrH5qFAWgu1dcA5egn2417Aw8zrda9AoPi7LvXiism6RNMMms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:qDb8YxtCCkB-BfkNv8l83xAKsJ_321Zu9DOujYvZUiDZ5a3SFtPXRA>
    <xmx:qDb8Y9cr6hJ6FcHtvpHGJ_hyLetd3v2uVghGzIJJvVXgIWlUh6TG8A>
    <xmx:qDb8Y91wMs4ZmXfuqgODIqzNVENj6Bn-NRlFQ_DksSmg5dJincCa9g>
    <xmx:qDb8Yw9xK2sTa5GOdqtbt_bQlnvMyOWiez1-T3CvK643CoWCSRnIHA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Feb 2023 23:50:43 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-imx@nxp.com
Cc:     linux@armlinux.org.uk, arnd@arndb.de, alistair23@gmail.com,
        kernel@pengutronix.de, festevam@gmail.com,
        jernej.skrabec@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 2/3] ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
Date:   Mon, 27 Feb 2023 14:50:22 +1000
Message-Id: <20230227045023.560319-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227045023.560319-1-alistair@alistair23.me>
References: <20230227045023.560319-1-alistair@alistair23.me>
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
index 6dc6fed12af8..02ccc86a8d4a 100644
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
2.39.1

