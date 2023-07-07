Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDEF74B513
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjGGQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:22:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6072102;
        Fri,  7 Jul 2023 09:22:24 -0700 (PDT)
Received: from localhost (unknown [188.27.60.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D7E96602B7B;
        Fri,  7 Jul 2023 17:22:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688746941;
        bh=HFO7Dhdm49/pt6dzouQ9Y4qcDpFCB2mqQUX9OjiwNOA=;
        h=From:To:Cc:Subject:Date:From;
        b=VjHTFvqmYDc2VuVCrU3chH3hWx26NPbyyyeUBC7h1X+sGzpjTUFASIgr6WTVEmf/a
         8LwStwEAtSUgytPnYoUZU0VXieMKZL7DsC7gzipdxxmuJs+1yW3bwspkxAsCGyTJV6
         0x+dhxW6UhweUaw5RDoF0uD4O1n55zplxZlw3rLO+kRnD5aoeUEEpOcycX6yOeg1U/
         92onVynS9ezgARKho2dVWA28b2SVoQJgLnlRiUU+AYqS47WC2M9hM6dkzkehpZ99K/
         imOCLSxDOQeQXY/ivL/o1HK+npJWSSnMST8of55sVqPetqZRFDHJYOasMbzgK36nYm
         6SFkirqqWQxQA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Furkan Kardame <f.kardame@manjaro.org>,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Wenhao Cui <lasstp5011@gmail.com>, Lev Popov <leo@nabam.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Peter Geis <pgwipeout@gmail.com>,
        Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Alex Riabchenko <d3adme4t@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Tianling Shen <cnsztl@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Andy Yan <andyshrk@163.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Dongjin Kim <tobetter@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Jonas Karlman <jonas@kwiboo.se>,
        Anand Moon <linux.amoon@gmail.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] arm64: dts: rockchip: Drop invalid regulator-init-microvolt property
Date:   Fri,  7 Jul 2023 19:22:17 +0300
Message-ID: <20230707162217.675390-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'regulator-init-microvolt' property is not currently supported by
any driver, it was simply carried on from downstream kernels.

The problem is also indicated by the following dtbs_check warning:

  rk3588-rock-5b.dtb: pmic@0: regulators:dcdc-reg4: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)

Remove the invalid property from all affected DTS files.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts          | 1 -
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts       | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi        | 1 -
 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi | 3 ---
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts      | 3 ---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi       | 2 --
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts      | 2 --
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts      | 2 --
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts          | 2 --
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi       | 3 ---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts      | 3 ---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts        | 3 ---
 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi | 4 ----
 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts      | 3 ---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi     | 3 ---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts       | 3 ---
 arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi     | 3 ---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts         | 3 ---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts         | 1 -
 19 files changed, 46 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index 7ea48167747c..9232357f4fec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -106,7 +106,6 @@ vdd_core: vdd-core {
 		regulator-name = "vdd_core";
 		regulator-min-microvolt = <827000>;
 		regulator-max-microvolt = <1340000>;
-		regulator-init-microvolt = <1015000>;
 		regulator-settling-time-up-us = <250>;
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index a71f249ed384..e9810d2f0407 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -105,7 +105,6 @@ vdd_core: vdd-core {
 		regulator-name = "vdd_core";
 		regulator-min-microvolt = <827000>;
 		regulator-max-microvolt = <1340000>;
-		regulator-init-microvolt = <1015000>;
 		regulator-settling-time-up-us = <250>;
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index b6e082f1f6d9..7c5f441a2219 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -375,7 +375,6 @@ regulator-state-mem {
 			vcc_sdio: LDO_REG4 {
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <3000000>;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc_sdio";
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
index a2c31d53b45b..8cbf3d9a4f22 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
@@ -356,7 +356,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_logic";
@@ -371,7 +370,6 @@ vdd_gpu: DCDC_REG2 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_gpu";
@@ -533,7 +531,6 @@ vdd_cpu: regulator@40 {
 		regulator-boot-on;
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1390000>;
-		regulator-init-microvolt = <900000>;
 		regulator-name = "vdd_cpu";
 		regulator-ramp-delay = <2300>;
 		vin-supply = <&vcc_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
index ff936b713579..1c6d83b47cd2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
@@ -218,7 +218,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
@@ -233,7 +232,6 @@ vdd_gpu: DCDC_REG2 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
@@ -259,7 +257,6 @@ vdd_npu: DCDC_REG4 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index 8d61f824c12d..d899087bf0b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -264,7 +264,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-always-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
@@ -278,7 +277,6 @@ vdd_gpu_npu: DCDC_REG2 {
 				regulator-name = "vdd_gpu_npu";
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 25a8c781f4e7..854d02b46e6f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -366,7 +366,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_logic";
@@ -381,7 +380,6 @@ vdd_gpu: DCDC_REG2 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_gpu";
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index b276eb0810c7..2d92713be2a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -277,7 +277,6 @@ vdd_log: DCDC_REG1 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
@@ -292,7 +291,6 @@ vdd_gpu: DCDC_REG2 {
 				regulator-boot-on;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
index 42889c5900bd..938092fce186 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
@@ -278,7 +278,6 @@ vdd_log: DCDC_REG1 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
@@ -291,7 +290,6 @@ vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 31aa2b8efe39..63bae36b8f7e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -234,7 +234,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 				regulator-state-mem {
@@ -249,7 +248,6 @@ vdd_gpu: DCDC_REG2 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 					regulator-state-mem {
@@ -272,7 +270,6 @@ vdd_npu: DCDC_REG4 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_npu";
 				regulator-state-mem {
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index ff0bf24cc1a2..f9127ddfbb7d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -308,7 +308,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -322,7 +321,6 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -346,7 +344,6 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 674792567fa6..19f8fc369b13 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -293,7 +293,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -307,7 +306,6 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -331,7 +329,6 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
index 25e205632a68..89e84e3a9262 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -173,7 +173,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -187,7 +186,6 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -211,7 +209,6 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -330,7 +327,6 @@ regulator-state-mem {
 
 			vcca1v8_image: LDO_REG9 {
 				regulator-name = "vcca1v8_image";
-				regulator-init-microvolt = <950000>;
 				regulator-min-microvolt = <950000>;
 				regulator-max-microvolt = <1800000>;
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
index e653b067aa5d..a8a4cc190eb3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
@@ -243,7 +243,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
@@ -258,7 +257,6 @@ vdd_gpu: DCDC_REG2 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
@@ -284,7 +282,6 @@ vdd_npu: DCDC_REG4 {
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-init-microvolt = <900000>;
 				regulator-ramp-delay = <6001>;
 				regulator-initial-mode = <0x2>;
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index 58ba328ea782..93189f830640 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -232,7 +232,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -246,7 +245,6 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -270,7 +268,6 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 59ecf868dbd0..a337f547caf5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -291,7 +291,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -305,7 +304,6 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -329,7 +327,6 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
index c50fbdd48680..45b03dcbbad4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
@@ -163,7 +163,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -177,7 +176,6 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -201,7 +199,6 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 917f5b2b8aab..e05ab11981f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -350,7 +350,6 @@ vdd_logic: DCDC_REG1 {
 				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -364,7 +363,6 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
@@ -388,7 +386,6 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
-				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index afda976680bc..51537030f8e3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -337,7 +337,6 @@ vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
 				regulator-boot-on;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
-				regulator-init-microvolt = <750000>;
 				regulator-ramp-delay = <12500>;
 				regulator-name = "vdd_vdenc_s0";
 
-- 
2.41.0

