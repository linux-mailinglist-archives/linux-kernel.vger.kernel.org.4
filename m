Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA920612224
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ2KHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJ2KHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:07:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B665157F70;
        Sat, 29 Oct 2022 03:07:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D9A2A5C017D;
        Sat, 29 Oct 2022 06:07:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 29 Oct 2022 06:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667038037; x=
        1667124437; bh=wUID88ywaENfHCuE/a1VQCI+CY2X7CDgvVIC94l8daE=; b=C
        rmxa+RbBpQDQ+LW9OITU/iP6+S46ku70j0sxR4uga1ov20UBXUGoSzzSdV5LZAjE
        u9h0xAB6ysbENQ85IJgNJdhcRuxglKFB6dehlUkdmz/A1sz3qhS3X7wqRZT7bUzC
        LLY6koxxZmtCwiWFRooV3hN/bzGiuy7XVizFydRyQfqNhFzKRTxEQxezeMSwmhmP
        Et7mhk31f7zSblvnYHjaTiIdRX4+juqu6EDSnfJAzW/550fdtmjyUyEelRS4+jS3
        IqAgj2aFVziNdGa1JQ+T2yb6mBzS4s8+YpXuYZ3XsCv88JvkzQ4r0m4EKCEb5i+I
        i4fkERfTLy262ETwSb0Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667038037; x=1667124437; bh=wUID88ywaENfH
        CuE/a1VQCI+CY2X7CDgvVIC94l8daE=; b=aaONu0qm+RxneOSGTQDQ9kFncKg2J
        UvWFNfsA9QNtlQvBW3SY7w7y1DGjZBkJadRb3WNYulslbgXpMdz22oCwdig0luQ4
        i9AZcVY7XCd+lx8VGxPJLjIVVNr4/E35stS5WkFo7LnqxsvBiR3O9pzmZIlvCvwS
        nFWyoSdf1/PLCTlsi3+PpadGG95MMU992+Ds0Ig49BI2olbeQXH4WyLc0LS7YpB0
        RLQ+IawvZoM0eId2ZfxwIqC06ATAWkF/LSX627BFcu0T35Q7r4ZB9gAUf+UNbC6Z
        qxfeMzrh4rBzvmWoRpMS192oS0bWx5tx28FXWSzpZe8yiq9dZiTCXvGdA==
X-ME-Sender: <xms:VftcYxUO7kyJbrVCPLOyPv8qXpac1Z_rQnLHifyX6cEX8S5B7oqpXw>
    <xme:VftcYxn5VBu2qnvQdhd6BHe3kmXc97LMHYTruUVgQLLv_pI-7sD7MV4YQt0dpoh_C
    Cemi9L6vSQ5yVMQJwU>
X-ME-Received: <xmr:VftcY9bdZkOzj07LHLSDrNjPqNJB5FD4KgKh4Sn6tlI1YyGL4qSE0dEzHdLD72cQhJiPDqfmS0un>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:VftcY0UkRngPBaS_M2yihL0_tb2khiuPGcTRIMEU4TbrHc1A0Ijmsw>
    <xmx:VftcY7kzU7yZWieBWz9OlT8JzBwsDUeOLUls1tnaC0NxL8s25t855Q>
    <xmx:VftcYxfYV40daW265huILPtCF5NFnR7ZhypxDOcYmJL2uhR42FljcA>
    <xmx:VftcY6f51Gf9Kt3PNGkapJF6Xoj8L58Foz1Z3cq62J9Dn-C_YD4TFg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Oct 2022 06:07:05 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
        kernel@pengutronix.de, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-imx@nxp.com, alistair@alistair23.me, amitk@kernel.org,
        s.hauer@pengutronix.de, linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, shawnguo@kernel.org,
        andreas@kemnade.info, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH v23 1/2] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Sat, 29 Oct 2022 20:06:45 +1000
Message-Id: <20221029100646.294583-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221029100646.294583-1-alistair@alistair23.me>
References: <20221029100646.294583-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 078d61b758a9..81b0c674977f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -222,6 +222,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
@@ -237,6 +238,7 @@ CONFIG_MFD_DA9062=y
 CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
+CONFIG_MFD_SY7636A=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -250,6 +252,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.38.1

