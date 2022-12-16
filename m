Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A205564F527
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLPXem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLPXeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:34:24 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BC25C48
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:34:23 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AAFFC3F356;
        Sat, 17 Dec 2022 00:34:21 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm6125: Add pin configs for QUP SPI/I2C Serial Engines
Date:   Sat, 17 Dec 2022 00:34:06 +0100
Message-Id: <20221216233408.1283581-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216233408.1283581-1-marijn.suijten@somainline.org>
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

Add pin setup for SPI/I2C Serial Engines that are supported under the
Qualcomm Universal Peripheral found on SM6125.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
[Un-nest pins, remove duplicate pins= properties, follow new node naming
 conventions, fix qup_14 -> qup14 function typo]
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 224 +++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index abcd634c4f6d..5fc304b2da63 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -426,6 +426,230 @@ data-pins {
 					bias-pull-up;
 				};
 			};
+
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup00";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c0_sleep: qup-i2c0-sleep-state {
+				pins = "gpio0", "gpio1";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio4", "gpio5";
+				function = "qup01";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c1_sleep: qup-i2c1-sleep-state {
+				pins = "gpio4", "gpio5";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio6", "gpio7";
+				function = "qup02";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c2_sleep: qup-i2c2-sleep-state {
+				pins = "gpio6", "gpio7";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio14", "gpio15";
+				function = "qup03";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c3_sleep: qup-i2c3-sleep-state {
+				pins = "gpio14", "gpio15";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio16", "gpio17";
+				function = "qup04";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c4_sleep: qup-i2c4-sleep-state {
+				pins = "gpio16", "gpio17";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio22", "gpio23";
+				function = "qup10";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c5_sleep: qup-i2c5-sleep-state {
+				pins = "gpio22", "gpio23";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c6_default: qup-i2c6-default-state {
+				pins = "gpio30", "gpio31";
+				function = "qup11";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c6_sleep: qup-i2c6-sleep-state {
+				pins = "gpio30", "gpio31";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins = "gpio28", "gpio29";
+				function = "qup12";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c7_sleep: qup-i2c7-sleep-state {
+				pins = "gpio28", "gpio29";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c8_default: qup-i2c8-default-state {
+				pins = "gpio18", "gpio19";
+				function = "qup13";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c8_sleep: qup-i2c8-sleep-state {
+				pins = "gpio18", "gpio19";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c9_default: qup-i2c9-default-state {
+				pins = "gpio10", "gpio11";
+				function = "qup14";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_i2c9_sleep: qup-i2c9-sleep-state {
+				pins = "gpio10", "gpio11";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi0_default: qup-spi0-default-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "qup00";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi0_sleep: qup-spi0-sleep-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "gpio";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_default: qup-spi2-default-state {
+				pins = "gpio6", "gpio7", "gpio8", "gpio9";
+				function = "qup02";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_sleep: qup-spi2-sleep-state {
+				pins = "gpio6", "gpio7", "gpio8", "gpio9";
+				function = "gpio";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_default: qup-spi5-default-state {
+				pins = "gpio22", "gpio23", "gpio24", "gpio25";
+				function = "qup10";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_sleep: qup-spi5-sleep-state {
+				pins = "gpio22", "gpio23", "gpio24", "gpio25";
+				function = "gpio";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_default: qup-spi6-default-state {
+				pins = "gpio30", "gpio31", "gpio32", "gpio33";
+				function = "qup11";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_sleep: qup-spi6-sleep-state {
+				pins = "gpio30", "gpio31", "gpio32", "gpio33";
+				function = "gpio";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi8_default: qup-spi8-default-state {
+				pins = "gpio18", "gpio19", "gpio20", "gpio21";
+				function = "qup13";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi8_sleep: qup-spi8-sleep-state {
+				pins = "gpio18", "gpio19", "gpio20", "gpio21";
+				function = "gpio";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi9_default: qup-spi9-default-state {
+				pins = "gpio10", "gpio11", "gpio12", "gpio13";
+				function = "qup14";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi9_sleep: qup-spi9-sleep-state {
+				pins = "gpio10", "gpio11", "gpio12", "gpio13";
+				function = "gpio";
+				drive-strength = <6>;
+				bias-disable;
+			};
 		};
 
 		gcc: clock-controller@1400000 {
-- 
2.39.0

