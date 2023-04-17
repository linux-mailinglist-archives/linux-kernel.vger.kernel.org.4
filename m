Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65A6E4F68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDQRja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjDQRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:39:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB5AF15;
        Mon, 17 Apr 2023 10:39:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n43-20020a05600c502b00b003f17466a9c1so1618140wmr.2;
        Mon, 17 Apr 2023 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753152; x=1684345152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9SGKTimWRUdj0QTndofO8nAh6NU/GpxYJaU61wHldI=;
        b=hMqJUFhv26kEEYUAT+5/rDi8dUaz7Ab1xirOqdR6Z+OQWco8jYDIrhNTBVc5aPdAax
         XdhRUGYHw7cLE7oJLcmcXwp9oblAqC1sO3hHGII60Y5SRJk3Pyjk806/fMmi8IZfq7UJ
         Zv+wpYInZenS5EuA0X5VPEogGmTKoliyrq8KHhLQd2LqfI0sjwj4DqztO1+tf8l6deia
         JLKFMoWwaSVOrkoJUVEi9D8tkHZdqze86IcSOZOgbtUNv8yM1KArQ28wSjCMPf/e2wd+
         A3rOAt5K0Jqjt/yASA/FkRrzp6ucuYKt+htsAfWLk4eCs2NjbJf6IMEA2yNL9zjFTBIp
         2tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753152; x=1684345152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9SGKTimWRUdj0QTndofO8nAh6NU/GpxYJaU61wHldI=;
        b=El/A+psKPqKPebUBYnCB0BgufkXlycfW8w+wR7CdORCxhha8g3qJR11x44dsPCXzIq
         C8SOB/BTRuSEKOouFLErLnZwgw3F6CJemxPo/RSqXD3Hzohsg16RJv8f6TWPk5YSBMyK
         kuluTg14aBZcA6Y5P26nDPfNOfg1Pf/oAlt8kyj/vOaQlRdO43BjUgv86ynzihbgyiH0
         yswCNy7N3QZbRefUZtz0fQ5iFVc8xM2qEX1oI+VvlePYRLeAZ6huqSxP0vtq/6925FfY
         ZG9iVGjvP05WqvprFQJf2G0ZwyVuiDU1NW5pzhv0OYKFJet3r9VLrFDrJlv66f51nEjc
         JZkQ==
X-Gm-Message-State: AAQBX9dXiFLn7mJiqyfRtWpYk8XbAfHTQA1LN3UHT7XnqvtNVqI60gLs
        pOs5QBzjrPsA0rwL68aatcZ2eeY8mvMd2w==
X-Google-Smtp-Source: AKy350bd6pQCa71FaLhDIm2hyeIlwbBqoZ/tQ5qPswmFeb2koI4NW8q60iCmGWNdqpbmhvLKf1l+Eg==
X-Received: by 2002:a7b:cc81:0:b0:3f1:72d4:b271 with SMTP id p1-20020a7bcc81000000b003f172d4b271mr4043414wma.3.1681753152375;
        Mon, 17 Apr 2023 10:39:12 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (35.145.195.178.dynamic.wline.res.cust.swisscom.ch. [178.195.145.35])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b003f174cafcdasm2478211wmb.7.2023.04.17.10.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:39:11 -0700 (PDT)
From:   Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Google-Original-From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 2/4] arm64: dts: colibri-imx8x: move pinctrl property from SoM to eval board
Date:   Mon, 17 Apr 2023 19:38:28 +0200
Message-Id: <20230417173830.19401-3-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
References: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Each carrier board device tree except the eval board one already override
iomuxc pinctrl property to configure unused pins as gpio.
So move also the pinctrl property to eval board device tree.
Leave the pin group definition in imx8x-colibri.dtsi to avoid duplication
and simplify configuration of gpio.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi         | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 7264d784ae72..9af769ab8ceb 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -33,6 +33,12 @@ rtc_i2c: rtc@68 {
 	};
 };
 
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>,
+		    <&pinctrl_lpspi2_cs2>;
+};
+
 /* Colibri SPI */
 &lpspi2 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 6f88c11f16e1..b0d6f632622c 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -363,10 +363,6 @@ &usdhc2 {
 /* TODO VPU Encoder/Decoder */
 
 &iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>,
-		    <&pinctrl_lpspi2_cs2>;
-
 	/* On-module touch pen-down interrupt */
 	pinctrl_ad7879_int: ad7879intgrp {
 		fsl,pins = <IMX8QXP_MIPI_CSI0_I2C0_SCL_LSIO_GPIO3_IO05	0x21>;
-- 
2.34.1

