Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1165BE22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjACKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjACKbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:31:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA760FADC;
        Tue,  3 Jan 2023 02:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DCCBB80E93;
        Tue,  3 Jan 2023 10:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FBAC433EF;
        Tue,  3 Jan 2023 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672741896;
        bh=graVB///psDn1oRsCpA22LhRBM1JsZjpZzIHi9wCaeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzMqjBUap4HTNzGDqNvUDdujNf6jwSu8yj1GMsRvctN1CgT3vCZIDr2acyJ8eUPDD
         pzh0op+z0CmBsxYSHUgD6My62EdVZuHH3tdwxRfWkPQrOSEgqqH4VrxW6sjcaEJ1HV
         rRn3dHrxe46YVpWl7QQ1IfmL+xexdZ6gEbzfVlvSQkNruKJgBi6jn+p/JuRBcDHY2B
         qcmdbiJZBjt2ji6haHt2VGq1D/56X7XzlZ01m0JGJQ4solOfjRs5w3xG3qrB5I8OXB
         XTPFkGSmtqyUZnuQXm0WxmJtUSmUd3wjp/YCcCUZh4DjoGN1TtqXYtdl3sYfMdjmn2
         P3c6pNw2Tcwpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCeaJ-00047Q-Na; Tue, 03 Jan 2023 11:31:55 +0100
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
Subject: [PATCH v2 2/6] arm64: dts: qcom: sc8280xp-x13s: move vamacro node
Date:   Tue,  3 Jan 2023 11:31:37 +0100
Message-Id: <20230103103141.15807-3-johan+linaro@kernel.org>
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

Move the vamacro node to restore the alphabetical sort order.

While at it, add some newline separators to improve readability.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f30ede5839b2..cc67a80758af 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -786,15 +786,6 @@ &txmacro {
 	status = "okay";
 };
 
-&vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
-	pinctrl-names = "default";
-	vdd-micb-supply = <&vreg_s10b>;
-	qcom,dmic-sample-rate = <600000>;
-
-	status = "okay";
-};
-
 &usb_0 {
 	status = "okay";
 };
@@ -843,6 +834,17 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-names = "default";
+
+	vdd-micb-supply = <&vreg_s10b>;
+
+	qcom,dmic-sample-rate = <600000>;
+
+	status = "okay";
+};
+
 &wsamacro {
 	status = "okay";
 };
-- 
2.37.4

