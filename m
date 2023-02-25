Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC16A2958
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBYLhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjBYLhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:37:35 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7319F1A;
        Sat, 25 Feb 2023 03:37:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E10B35C00A5;
        Sat, 25 Feb 2023 06:37:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 25 Feb 2023 06:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677325053; x=
        1677411453; bh=E2VDh/W0tP4MMddPoKSn9rSCCncM3aUTd9NN0au++bA=; b=o
        kA2bkrz2+joAVIH7Vzyl584fMWBYl29VIq6m7OZC+Bd31kuFkSlOZthwMaNiidSb
        j54Ur2kJkzHWG1V0eY5PkLfCq0A6oGyVgTROOl34wRXLxPVRlYBGXhkD4kIpc1AA
        l6RL2twd6bjHdqu8qW7xGklgeeEb411JWzJfpiUv9G1g/XcSjUEgf8H7dxotbEz4
        Sic5AMEJjjrO1aD8da8hXFKlBns+hWog+YELH3pR6JYaBr9+8dHDd0vLUGevOAeK
        LTkhvy4Vg5WZhfqFDixHJo4D9VDaJ13YWFe9WUKUThGlZOgI7RDR9Xvu46OPmbsE
        8vNRF/ClzZgQ8zxG+4EUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677325053; x=1677411453; bh=E2VDh/W0tP4MM
        ddPoKSn9rSCCncM3aUTd9NN0au++bA=; b=K0wUt00Osj/VdzpSa1H8em2fuFjm6
        RGldMtWfIeH2XK7zmaJdCvl47EAisoSQpn5ZyES47qaz2rUTOktSFKZzqjJZQFOj
        3DAitCANy75vAdQDcH/zW5YW8ukL0vF2e7g2qtei7TRp7o7gC2DpBvZlZQFeyJJi
        ldCypsAVrUGErZMaMT35jDD2GP/r8OmwroivtazFvctw1DBnfNN8H3lUzVSodfOu
        zp2ynNni0EB4rx3wWHZUVpvz35EmRzBfdTsHCX+Bz9rSdrLvp84MZczBmUU3x4XG
        IZklb5eRu4rxfzl37Dg5f1k9DXEJAFkatwWo9cf6pawH9xPrs3ADUglnQ==
X-ME-Sender: <xms:_fL5YwVfUBJGA91A2WUXcsimF_S11wNtVjOLH02XgCR3bPxG__exIA>
    <xme:_fL5Y0kPKThpi05NgblXUBqR3VIPP9apzZFy8JksLaxmZOuYhGSgGR1m8792WjZqA
    7Zcaj8RRl7tLJAgcw8>
X-ME-Received: <xmr:_fL5Y0Zw4ynMhma6MANKxmYT8ZFAs3JGwTSNhk261bbZDy4i4W0JAYz4QXUfO8ZMFV1MKPjmfqli>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:_fL5Y_UdIaZ6skwpi6a7s-FUDzrbimT-F3R0Q1I-p4UU6VCxBmtpXw>
    <xmx:_fL5Y6mjI81ChGiRD0uYBkpJLyIg4PCTjYTh6FZsS-n4HCNrEiOH1Q>
    <xmx:_fL5Y0ch6UuytcC2d-JtS08B-fv02CbIj9MqnTCKoMnRjvNOCd-j5w>
    <xmx:_fL5YwnDpBrStpj40kkLB47NVIs2BdsG4PnFe8fQOsWjUgjtInTY-w>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Feb 2023 06:37:28 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     arnd@arndb.de, alistair23@gmail.com, kernel@pengutronix.de,
        jernej.skrabec@gmail.com, linux@armlinux.org.uk,
        festevam@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 2/3] ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
Date:   Sat, 25 Feb 2023 21:37:11 +1000
Message-Id: <20230225113712.340612-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230225113712.340612-1-alistair@alistair23.me>
References: <20230225113712.340612-1-alistair@alistair23.me>
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
2.39.1

