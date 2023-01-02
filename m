Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317465AFEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjABKva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjABKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:51:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C376B00;
        Mon,  2 Jan 2023 02:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1CE8B80CD9;
        Mon,  2 Jan 2023 10:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E81AC433EF;
        Mon,  2 Jan 2023 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672656651;
        bh=LAiUsLgBSqchR7MaqJBuNMrNsFYWdX2WB88AiqKTpTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rq3NFFTH8HwkYw23+gCH8qtJgNUpwrKFOPLDFW1NLRu59A4lPzIy8Ae8lP7LIaxiV
         cneXsitEm2O0RcPxJsp3b6bmyDHVAulu1cE2TUKx5rl0LZciVUyeJkMBmGaczoy8x+
         b1OyNLte9MbaXCcyFQ3s40i+e/NMhJSCB01kHLzaZNVsDfWTlnw8w9t4DuhTdmBkSA
         SyVsWVR2cvoMzcKfgwhPsvw3YTSQiqX4pDVzlzyFWvCUd0KjUHwm9b6CStrYiMiXbG
         j8CwJ65EHTaDstgEW8VkaSL1q2hVKQ5p59uk3d4lUhOm4maF23kYdZhMFRpXsKuFs7
         NoJZTsDIOsAzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCIPM-00026q-6n; Mon, 02 Jan 2023 11:51:08 +0100
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
Subject: [PATCH 1/6] arm64: dts: qcom: sc8280xp-x13s: disable soundcard
Date:   Mon,  2 Jan 2023 11:50:33 +0100
Message-Id: <20230102105038.8074-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230102105038.8074-1-johan+linaro@kernel.org>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
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

Driver support for the X13s soundcard is not yet in place so disable it
for now to avoid probe failures such as:

[   11.077727] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
[   11.077926] rx_macro: probe of 3200000.rxmacro failed with error -22
[   21.221104] platform 3210000.soundwire-controller: deferred probe pending

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 0201c6776746..97ff74d5095e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -649,6 +649,8 @@ wcd938x: codec {
 		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
 		qcom,rx-device = <&wcd_rx>;
 		qcom,tx-device = <&wcd_tx>;
+
+		status = "disabled";
 	};
 };
 
@@ -669,6 +671,8 @@ &sound {
 		"TX DMIC2", "MIC BIAS3",
 		"TX SWR_ADC1", "ADC2_OUTPUT";
 
+	status = "disabled";
+
 	wcd-playback-dai-link {
 		link-name = "WCD Playback";
 		cpu {
@@ -731,6 +735,8 @@ codec {
 };
 
 &swr0 {
+	status = "disabled";
+
 	left_spkr: wsa8830-left@0,1 {
 		compatible = "sdw10217020200";
 		reg = <0 1>;
@@ -757,7 +763,7 @@ right_spkr: wsa8830-right@0,2{
 };
 
 &swr1 {
-	status = "okay";
+	status = "disabled";
 
 	wcd_rx: wcd9380-rx@0,4 {
 		compatible = "sdw20217010d00";
@@ -767,7 +773,7 @@ wcd_rx: wcd9380-rx@0,4 {
 };
 
 &swr2 {
-	status = "okay";
+	status = "disabled";
 
 	wcd_tx: wcd9380-tx@0,3 {
 		compatible = "sdw20217010d00";
@@ -781,6 +787,8 @@ &vamacro {
 	pinctrl-names = "default";
 	vdd-micb-supply = <&vreg_s10b>;
 	qcom,dmic-sample-rate = <600000>;
+
+	status = "disabled";
 };
 
 &usb_0 {
-- 
2.37.4

