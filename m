Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C98626A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiKLQEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiKLQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:04:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869E1403A;
        Sat, 12 Nov 2022 08:04:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bs21so10178166wrb.4;
        Sat, 12 Nov 2022 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ27VAZylslPL3euOsLLalZQXH6wtWYg2Z/Is/uMUw0=;
        b=HKKk23/nYx4DzhMOBDXtEJ3NKcPfdpwCTM3sBx8NmGDUwGFSQeFAq6goYAq8CgtD2H
         Woq/th/pi/l9XsIFlLg2yV7Z+aDEQ+4OpMx9Z6Tnbu+QrSqubiPGyo7w3IzX9rsCdC4d
         TCssYdAC1rlqCk0+DkL9k7x2tFd2PPo4l0/q8nj8AR8oXUWC4VA4lJxTApV1GIHe6IOj
         /U6oHgDf593VFuHct8gBMk6JoXAeICQSVOLXAM+gu1zOm9BdKPJELZC/hfJ5hHUhTxXO
         wmVBqSKQtmONK4g5+EVlk/hvJ5x7nab4ZZBs3Nt/bWa+x1o0iXJ2X7RF1RPjsElLf6Nr
         m8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ27VAZylslPL3euOsLLalZQXH6wtWYg2Z/Is/uMUw0=;
        b=whPMx7TPDxKOk6RlPVWnew22Ttq7bvTJa05/pgB9/WotJ1AHrCyXUGKieQtXAJefZg
         v4OX1d5101+c89Tvs3wCwtoge9SJPNNO5zozgf+gzqvV4C01Dp43tQPP9UX2vPZyqxpq
         AlFD5dN4OYKfFR0dVHHtkDS9xvTjvrjncE3tzHEFEnYsuIXNyUcCi+WIiRT9dW/pWavz
         DG7a+vTAJogPpFiK/q/iQlAtzPGPqaXaSmDutxcL+GcASDbLp6k0HjdP5QzoD91malbm
         EyxLqS8nUZGYL3iesM5FWg1rWoG76shMfk94qz4DJwRFFFvB+0BoWVhEYFFKvOanrso5
         4PvQ==
X-Gm-Message-State: ANoB5pmMDULEpnuvGCzDHcltWrBgjxae79etOZztxX5rBtSb9AfLrYem
        9qo3Dd5mM6EztyutijQRFWE=
X-Google-Smtp-Source: AA0mqf4LLDY4KIu9pV27y1Mc+ZPFwpD7rdhFe1DVUzoLHJLMxxyOLvmhrL7M3GBqWzoOAhHTrlBGEQ==
X-Received: by 2002:a5d:4f05:0:b0:241:8103:766d with SMTP id c5-20020a5d4f05000000b002418103766dmr911326wru.386.1668269072512;
        Sat, 12 Nov 2022 08:04:32 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003cf87623c16sm14605752wmb.4.2022.11.12.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:04:32 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: rockchip: Enable PCIe 2 on SOQuartz CM4IO
Date:   Sat, 12 Nov 2022 17:04:01 +0100
Message-Id: <20221112160404.70868-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
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

This patch enables the PCIe2 on the CM4IO board when paired with
a SOQuartz CM4 System-on-Module board. combphy2 also needs to be
enabled in this case to make the PHY work for this.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts     | 11 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi | 15 +++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index e00568a6be5c..263ce40770dd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -30,6 +30,12 @@ vcc_5v: vcc-5v-regulator {
 	};
 };
 
+/* phy for pcie */
+&combphy2 {
+	phy-supply = <&vcc3v3_sys>;
+	status = "okay";
+};
+
 &gmac1 {
 	status = "okay";
 };
@@ -105,6 +111,11 @@ &led_work {
 	status = "okay";
 };
 
+&pcie2x1 {
+	vpcie3v3-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &rgmii_phy1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 1b975822effa..ce7165d7f1a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -487,6 +487,12 @@ rgmii_phy1: ethernet-phy@0 {
 	};
 };
 
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -512,6 +518,15 @@ diy_led_enable_h: diy-led-enable-h {
 		};
 	};
 
+	pcie {
+		pcie_clkreq_h: pcie-clkreq-h {
+			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		pcie_reset_h: pcie-reset-h {
+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.38.1

