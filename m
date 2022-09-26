Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41D35E9957
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiIZGOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIZGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:14:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7382CFC;
        Sun, 25 Sep 2022 23:14:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so11384185pjm.1;
        Sun, 25 Sep 2022 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=u3nLpVSXowX3rY5mvFDQyFHEVz4RbjCN/EeC9CxVEXM=;
        b=O9Zb6TVedGugUuBPEOt6OtmTc70TTgWKuLyN/hBmRD+4cipFAJbJvhD4CdAf16lbqt
         PqwSJ9dCutiUj9JxDPyPVEGcul+PTFXxiHgP5jo+z6SHqrAbHjy40ioZZnJTwOu+55TP
         AEX/NCiynyE3sTkzBVzJOuPlNZ7+nLIyB8CA/m+acq6FApFFq6dd5NkWiJZjr5dUKyYT
         L4LxLEYabc+llQb3IP+d7fTO67WxOpoaQ84ctYWzRGIlcw1JwwuUAOqFhO03zcJ5pBM3
         tO3F03eMztS3Pu7E1oLEhq3GGMSQ0ERB/Z6bdCMR5xV5eh/ccZI8VLbpH8fSJXyNU3zK
         x21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=u3nLpVSXowX3rY5mvFDQyFHEVz4RbjCN/EeC9CxVEXM=;
        b=KFYYlBM3GxwqpEy+FPh+asQzcFVBcLtU5PhwKac1ibMDxuKb1nz+s/l7iixSMHZsLq
         LzDYf5kaT24oH/OnEMvoJaJG/HP7gJGCemvf8hncg0OGXkbrDWclqT/4y8GQjRwMM7Rx
         ewhB/PB/8YUd+LBcUwNiaktjsHADwUzOh3Bp1M/YivhWRjznWaw1H+OHIkhYFcyF6MBS
         rnvQ2wvpgZ5IyB8hKbE0PX8OymddUIgcsnsQM6sleLEvKWZZTKcF7orwtxN04KU6oUHz
         L9WGfi7sBj2X/kPX0+qhQcWxWKjuMwxrleHbfuVz4X/PHesW4jHfNoBgdjy12VX4Trgp
         uHVw==
X-Gm-Message-State: ACrzQf2cHu7MvGI/nALGHQsTHctLrHodvMw9SrPBfkxYxAhqVPZkSx8z
        UXAZ5Q8P1QAv+ujBw/GJD8s=
X-Google-Smtp-Source: AMsMyM7EF5wCkipmmB9Gze2hm8udmEMzaxKg4BnwW746W1XwJL3Y3DSUNK2yI4uKAjKtS2ZcjeBF4Q==
X-Received: by 2002:a17:90a:a09:b0:202:ab93:2afb with SMTP id o9-20020a17090a0a0900b00202ab932afbmr34175863pjo.60.1664172873343;
        Sun, 25 Sep 2022 23:14:33 -0700 (PDT)
Received: from archl-hc1t.. ([103.51.72.15])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903120a00b0016f196209c9sm10479191plh.123.2022.09.25.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 23:14:32 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe controller on rock3a
Date:   Mon, 26 Sep 2022 06:14:18 +0000
Message-Id: <20220926061420.1248-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes to enable the NVM Express PCIe controller on the
Radxa ROCK3 Model A board.

Cc: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
alarm@rock-3a:~$ lspci
0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3568 Remote Signal Processor (rev 01)
0002:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3568 Remote Signal Processor (rev 01)
0002:01:00.0 Non-Volatile memory controller: Micron/Crucial Technology P2 NVMe PCIe SSD (rev 01)
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index fb87a168fe96..44d85ee1631e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -79,6 +79,26 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	/* pi6c pcie clock generator feeds both ports */
+	vcc3v3_pi6c_03: vcc3v3-pi6c-03-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pi6c_03";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <200000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	pcie30_3v3: gpio-regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "pcie30_3v3";
+		regulator-min-microvolt = <100000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0x1>;
+		states = <100000 0x0>, <3300000 0x1>;
+	};
+
 	vcc3v3_sys: vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
@@ -546,6 +566,22 @@ &pcie2x1 {
 	status = "okay";
 };
 
+&pcie30phy {
+	data-lanes = <0 1 2 3>;
+	phy-supply = <&vcc3v3_pi6c_03>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	/* mPCIe slot */
+	num-lanes = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x2m1_pins>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&pcie30_3v3>;
+	status = "okay";
+};
+
 &pinctrl {
 	cam {
 		vcc_cam_en: vcc_cam_en {
-- 
2.37.3

