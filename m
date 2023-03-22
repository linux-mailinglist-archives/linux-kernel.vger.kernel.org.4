Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86DD6C493A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCVLcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCVLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA35ADE4;
        Wed, 22 Mar 2023 04:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D74CF6204A;
        Wed, 22 Mar 2023 11:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30305C4339E;
        Wed, 22 Mar 2023 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679484768;
        bh=0nrQcvjmi6aFPxOeEU5Ub+hRdZiT2L7Vv1XiseXI/HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5PuWhGDksemcsBGglUJ+HgniWKAXI7v4Ovc9Oo49/Oq0d/MHnvoUiiWM2VdcBF7Y
         YQ8MsCY2TMWYbDTpwlYPLc5AtryxSBnVOCw9T0/DUbRKGaS0dnQJZZ/x9jPg6trlqM
         64G8RXzTh/1U/qdiYS39Tpc2C02K9zteVMsqiI81rGU2zgYQ92qHCGHNjxLIawXdtW
         tsB7Rkr2HGeZDKPnXmGE+Gq1jORMYgy0LjIdr75NLTeyswGejGtZeOHWcJIray7nOY
         CA55gQqlpARmNDjzwsgE8sPr5MNrn8iXgIuNawK4KZVLbnUzn6aIdu+Ttft5FU+ZEk
         KPDuiUgQHgY9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pewjP-0004fV-0n; Wed, 22 Mar 2023 12:34:15 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/6] arm64: dts: qcom: sc8280xp-x13s: add pmic regulator supplies
Date:   Wed, 22 Mar 2023 12:33:17 +0100
Message-Id: <20230322113318.17908-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322113318.17908-1-johan+linaro@kernel.org>
References: <20230322113318.17908-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s11b, s12b, s1c and bob supplies are used by several pmic
regulators. Add the missing description to the devicetree.

Note that there are still some consumers that are not (fully) described
in the devicetree so the supplies must remain marked as always-on for
now.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 44cf93ddc1b9..14e8d0a78b60 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -372,7 +372,11 @@ regulators-0 {
 		compatible = "qcom,pm8350-rpmh-regulators";
 		qcom,pmic-id = "b";
 
+		vdd-l1-l4-supply = <&vreg_s12b>;
+		vdd-l2-l7-supply = <&vreg_bob>;
 		vdd-l3-l5-supply = <&vreg_s11b>;
+		vdd-l6-l9-l10-supply = <&vreg_s12b>;
+		vdd-l8-supply = <&vreg_s12b>;
 
 		vreg_s10b: smps10 {
 			regulator-name = "vreg_s10b";
@@ -425,7 +429,21 @@ vreg_l6b: ldo6 {
 	regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
+
 		vdd-bob-supply = <&vreg_vph_pwr>;
+		vdd-l1-l12-supply = <&vreg_s1c>;
+		vdd-l2-l8-supply = <&vreg_s1c>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
+		vdd-l6-l9-l11-supply = <&vreg_bob>;
+		vdd-l10-supply = <&vreg_s11b>;
+
+		vreg_s1c: smps1 {
+			regulator-name = "vreg_s1c";
+			regulator-min-microvolt = <1880000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
 
 		vreg_l1c: ldo1 {
 			regulator-name = "vreg_l1c";
@@ -462,6 +480,10 @@ regulators-2 {
 		qcom,pmic-id = "d";
 
 		vdd-l1-l4-supply = <&vreg_s11b>;
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_s11b>;
+		vdd-l6-l9-l10-supply = <&vreg_s12b>;
+		vdd-l8-supply = <&vreg_s12b>;
 
 		vreg_l3d: ldo3 {
 			regulator-name = "vreg_l3d";
-- 
2.39.2

