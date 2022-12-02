Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE1640E37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiLBTK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiLBTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:10:54 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F68ED692;
        Fri,  2 Dec 2022 11:10:53 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q79so2649309iod.4;
        Fri, 02 Dec 2022 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LpbR4BJNFL+FnY5sm/YUcXeZkcYNe0cWTXNSMmQaY4=;
        b=AWtns0QBhoENJWbCHlZfqWEQKtbmRHrXdjkVjLyykgbaiflI9oiSoCT+1/mlsSCfuw
         WKsQoV2T8BtUiAGH85r6PESA+XSmtlcK/sIpTCLgef+b7PhJoFtnwK3qHh9KNDuc8IRP
         JKvGzpGSk3i23I7Q6rzE9WvgyUvYnoK/P/gd8SChr/DoBXOxLc1O/5UFMbtP3dnPu61k
         2ZPpYMPn6JnqrZBEunWPiGp6DaVX1xnEgtkmO00Zn48QTVtMRVr4w/88kAAZAmcn5wdO
         c7MuvWKr2+cgOgOzPfXaRIP+SjtquMYwGvbig1wVEw5hiEJRwJA1NNYw0OWFVVZOgWsF
         7WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LpbR4BJNFL+FnY5sm/YUcXeZkcYNe0cWTXNSMmQaY4=;
        b=EEn7BRnAfIfRnWxESO4gxVcB2t7++dec1XWlLIAxjHgWVfrZgu3ZPx66mkkFix0Cs0
         G5fZtXEqEG3GQAibK3sooBOnr0DmZ8gooBRM7BEn8u093UzVnt0zIA5xISOYYDXq1Gdv
         qT2vPtiRfyxz66F1nqJM1SmC9YLJaXpnsbVgPvENts2sq7mRZwegFvS7Ta2JMZseYMyB
         E544yWBjY9IJ/DbKSHMixAoYewpAm0cTYvCJVKKzACAKYtGVgHfdKWi/PkwXUuRbgxWE
         3z3idYjuyhPJVNEdqGpRzi8LNUfu9nS1VOvK2d80XhTLezOaow1qAbLNF5uDBONjdNuf
         3x1A==
X-Gm-Message-State: ANoB5pmhEQ8XBRJJc1ndEN3CtZBCRjOCXW8po+dHdeT4ndHYOZbYdUaJ
        YbqQAbDsIcu3qBJYmQdm7KY=
X-Google-Smtp-Source: AA0mqf4oyMLLvpyOY9JXz8LY12rzDa2cNVQND89+qF/+c4r5b9tuTdah8seJra732ngvOAbQG2iTig==
X-Received: by 2002:a5d:9b14:0:b0:6de:a34a:e93d with SMTP id y20-20020a5d9b14000000b006dea34ae93dmr24666298ion.179.1670008252803;
        Fri, 02 Dec 2022 11:10:52 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id z30-20020a027a5e000000b0037465a1dd3fsm2940271jad.156.2022.12.02.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:10:52 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     cstevens@beaconembedded.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon: Fix ecspi2 pinmux
Date:   Fri,  2 Dec 2022 13:10:37 -0600
Message-Id: <20221202191037.167718-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early hardware did not support hardware handshaking on the UART, but
final production hardware did.  When the hardware was updated the chip
select was changed to facilitate hardware handshaking on UART3.  Fix the
ecspi2 pin mux to eliminate a pin conflict with UART3 and allow the
EEPROM to operate again.

Fixes: 4ce01ce36d77 ("arm64: dts: imx8mm-beacon: Enable RTS-CTS on UART3")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 03266bd90a06..169f047fbca5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -120,7 +120,7 @@ &csi {
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeprom@0 {
@@ -316,7 +316,7 @@ pinctrl_espi2: espi2grp {
 			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
 			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
 			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13              0x41
 		>;
 	};
 
-- 
2.34.1

