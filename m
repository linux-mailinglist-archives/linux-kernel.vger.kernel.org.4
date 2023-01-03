Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AAC65BE1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbjACKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbjACKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:31:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B119FAC9;
        Tue,  3 Jan 2023 02:31:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D86261240;
        Tue,  3 Jan 2023 10:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05280C433F0;
        Tue,  3 Jan 2023 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672741896;
        bh=fBcINO4pbQqHnHN2BMS9j/GMWiUMhxzbCstdsbR92es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrIoUMGfwaofHcudHPLmMKVC5yt+lyFENN2I+CxBJgpEWPUKenS+hYos8LufGyWx/
         Ey90+7psT2Ort9N4lLRvjEHkSWvTVRemP0LRWrR3oNjxjdkQEbzY+vJ/YWEEV6IGJL
         1+o8vqb87gS4krJbgr7CRRFiFzHx/0SHlbB4WWO5W5x2CiSwOA/5pR6JDqu7wuyKcO
         t3vhaWBqgTJJ+a3rl3wG8N8XnuUQEIGxCNG33J/4xueggoYk94K3vBlJrhaqj/gUiH
         ww5sTnfwZatte2Bd0F51Pg7694Q6IMKRhGbYust9QFou0n3fRNdpKxaYtg1LeyOMGM
         SsXAZZzt+WJtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCeaJ-00047O-Ki; Tue, 03 Jan 2023 11:31:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 1/6] arm64: dts: qcom: sc8280xp: disable sound nodes
Date:   Tue,  3 Jan 2023 11:31:36 +0100
Message-Id: <20230103103141.15807-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230103103141.15807-1-johan+linaro@kernel.org>
References: <20230103103141.15807-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sound nodes in the SoC dtsi should be disabled by default.

Note that the lpass-tlmm and macro blocks depend on having the board dts
enable the adsp and specifying an appropriate firmware to enable the
q6prm clock controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 20 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 16 +++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 0201c6776746..f30ede5839b2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -628,6 +628,10 @@ &remoteproc_nsp0 {
 	status = "okay";
 };
 
+&rxmacro {
+	status = "okay";
+};
+
 &soc {
 	wcd938x: codec {
 		compatible = "qcom,wcd9380-codec";
@@ -731,6 +735,8 @@ codec {
 };
 
 &swr0 {
+	status = "okay";
+
 	left_spkr: wsa8830-left@0,1 {
 		compatible = "sdw10217020200";
 		reg = <0 1>;
@@ -776,11 +782,17 @@ wcd_tx: wcd9380-tx@0,3 {
 	};
 };
 
+&txmacro {
+	status = "okay";
+};
+
 &vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
 	pinctrl-names = "default";
 	vdd-micb-supply = <&vreg_s10b>;
 	qcom,dmic-sample-rate = <600000>;
+
+	status = "okay";
 };
 
 &usb_0 {
@@ -831,12 +843,20 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&wsamacro {
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
 
 /* PINCTRL */
 
+&lpass_tlmm {
+	status = "okay";
+};
+
 &pmc8280_1_gpios {
 	edp_bl_en: edp-bl-en-state {
 		pins = "gpio8";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index ed1e2bee86ee..c1ce2d7b3675 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1733,6 +1733,8 @@ rxmacro: rxmacro@3200000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&rx_swr_default>;
+
+			status = "disabled";
 		};
 
 		/* RX */
@@ -1760,6 +1762,8 @@ swr1: soundwire-controller@3210000 {
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <0>;
+
+			status = "disabled";
 		};
 
 		txmacro: txmacro@3220000 {
@@ -1783,6 +1787,8 @@ txmacro: txmacro@3220000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			#sound-dai-cells = <1>;
+
+			status = "disabled";
 		};
 
 		wsamacro: codec@3240000 {
@@ -1804,6 +1810,8 @@ wsamacro: codec@3240000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&wsa_swr_default>;
+
+			status = "disabled";
 		};
 
 		/* WSA */
@@ -1830,6 +1838,8 @@ swr0: soundwire-controller@3250000 {
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <0>;
+
+			status = "disabled";
 		};
 
 		/* TX */
@@ -1858,6 +1868,8 @@ swr2: soundwire-controller@3330000 {
 			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff 0xff>;
 			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
 			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x00>;
+
+			status = "disabled";
 		};
 
 		vamacro: codec@3370000 {
@@ -1874,6 +1886,8 @@ vamacro: codec@3370000 {
 			#clock-cells = <0>;
 			clock-output-names = "fsgen";
 			#sound-dai-cells = <1>;
+
+			status = "disabled";
 		};
 
 		lpass_tlmm: pinctrl@33c0000 {
@@ -1888,6 +1902,8 @@ lpass_tlmm: pinctrl@33c0000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "core", "audio";
 
+			status = "disabled";
+
 			tx_swr_default: tx-swr-default-state {
 				clk-pins {
 					pins = "gpio0";
-- 
2.37.4

