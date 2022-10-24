Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2311609FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJXLBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJXLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:00:47 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67122638A;
        Mon, 24 Oct 2022 03:59:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E0DFA320092A;
        Mon, 24 Oct 2022 06:59:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 06:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666609166; x=
        1666695566; bh=HioUTKH/gMS5qyttlzjqQsvRU9RhAydG5MP0WHmr/Lg=; b=q
        Xu52qz8YzWkXlaYCrdfwwIBrXy8rLcyhJv5a5lJwf7ANsagTvthus4zEN2/tQPzU
        G0kts4Q/tUnyPWPMflt1SVhg361XQzMIgXzmWJFMX6GrWEVyM72UvKUk6e9LS3bp
        AUz5DN1aKqxzfmCuq/dcaxxu0TuGqMFg/b3zKGeJFtNe2ODvsmMzcpMDhQCjsQwy
        fMhYcBJNQftVDuuT1KZUWKGF51Xd4ObnuVy9GlZIoGq1ySEWtgWySLymybkdf0vx
        oZcFbayIpLSPMh2rZ2DHuZnwyRwhCpDCeUeVCYUeq2wwoW5q9Gd4qFat8q6dsxpo
        RPt46C1gR1BIVSKnZkaIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666609166; x=1666695566; bh=HioUTKH/gMS5q
        yttlzjqQsvRU9RhAydG5MP0WHmr/Lg=; b=F0CtKzAqDaF9dgaaQiVHDHfJeCIM7
        J9KtRv5IlaoMaGFsJxs9ueJNtJMmHtCeKjvMdtoZxe56rCLVzz9nZChY7PlG48RJ
        cQ+10tmx+PHmI5wwAvGHKT4ndLxURImvNWKOnAfeGGbUfFMnLqYiW26QyK24Li18
        dlgOmraJGEjVakrhHSG4nxlWuqUp018PmZ1kCwrIhKqWx+GoD3wI141U+mOBZNMF
        XRG+2wDuPS9snkbYXuMPhEbPyJhX6gaOfdaxUF71B78oJr0qgClbn+OPueX2BgF2
        4GTTmfw3XLobwIB9Zis1gwMHjPtkxxdIQk0Dtu8F94cPPB0QZANqJeLhA==
X-ME-Sender: <xms:DnBWYxD0lBDJroEkZEUmnM64_bTc6MhX2vV6fq6bgMuGqP2gKI6bcA>
    <xme:DnBWY_hmaAlipAFyevubs778DI1p5LwpGpkLTfuWFsgzkrf4-uqJsdfQX6HvM-zXO
    DNQzc-OO2XR8sebbNU>
X-ME-Received: <xmr:DnBWY8n_9sHT7NjZavwiTsDjrgSGhkNlU37PLxJwQ8OgsbK00O92dR45khzi3lVVCI4Pr6Vf8ii6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:DnBWY7zqKOBPRQVCDftagdOOHg_klCk-KEJl-kFjk3ogaXdaRK6fNg>
    <xmx:DnBWY2Se5N2numWgRfI-mc2SwIJAq7T-9qdPRE7zdEMSl-cFP8ZG3A>
    <xmx:DnBWY-bkux385fD8eJnEB4k31MgDh-hn4wiJhhN21xO3e__1kD5fnw>
    <xmx:DnBWY3JH7m4gFBa5i3I1fZqvffA-qj2Bp454H_m6HYMLF5PghwZcOw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 06:59:15 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        alistair@alistair23.me, geert@linux-m68k.org,
        linux-pm@vger.kernel.org, andreas@kemnade.info, amitk@kernel.org,
        linux-hwmon@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, devicetree@vger.kernel.org,
        linux@roeck-us.net, linux-imx@nxp.com
Subject: [PATCH v22 1/2] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Mon, 24 Oct 2022 20:58:52 +1000
Message-Id: <20221024105853.42029-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024105853.42029-1-alistair@alistair23.me>
References: <20221024105853.42029-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
2.37.3

