Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18165BE24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjACKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbjACKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:31:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C1FACB;
        Tue,  3 Jan 2023 02:31:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396BF61225;
        Tue,  3 Jan 2023 10:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74636C4331F;
        Tue,  3 Jan 2023 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672741896;
        bh=+laXW6G2LvHTXlCq2XMEY0hkFcDigz1L1GYdv5f4Et4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDeWAoC0yftgz7ezcUoJPA10wWZTk5TDDSpmCmanngG56uyeqAJKohoZUAGNLCPHC
         9EkYN97U6zXPSnn6rL2HHydZgGRitz3OA3+0ZA6pSGYv0a/ngpfXwq/rnzcOK9tNWj
         AKatkxOPtmiciF46si9LnGAQjgz5dvzMY9fDjL0gq9mXfbcmPgheV1u6Q4z54dOejz
         SoTQuMkIkoLa4V4lcKMAmaqfC9ktVqojtLPI6FbEPrbGuDTmQlv5CckXRvM4ROMLRo
         RgtjMX2b0uXZfgHdnzaFN4aeSf+ceN0O8LS7xpBtUsVbKkGCJW6rVZcHw0rA5QfYgF
         QJZqGNGqadJqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCeaK-00047a-3t; Tue, 03 Jan 2023 11:31:56 +0100
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
Subject: [PATCH v2 6/6] arm64: dts: qcom: sm8250: clean up wcd938x codec node
Date:   Tue,  3 Jan 2023 11:31:41 +0100
Message-Id: <20230103103141.15807-7-johan+linaro@kernel.org>
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

Clean up the wcd938x codec node somewhat by adding newline separators,
reordering properties and renaming it 'audio-codec'.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index b741b7da1afc..0991b34a8e49 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -23,18 +23,16 @@ aliases {
 		serial0 = &uart12;
 	};
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	wcd938x: codec {
+	wcd938x: audio-codec {
 		compatible = "qcom,wcd9380-codec";
-		#sound-dai-cells = <1>;
+
 		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+
 		vdd-buck-supply = <&vreg_s4a_1p8>;
 		vdd-rxtx-supply = <&vreg_s4a_1p8>;
 		vdd-io-supply = <&vreg_s4a_1p8>;
 		vdd-mic-bias-supply = <&vreg_bob>;
+
 		qcom,micbias1-microvolt = <1800000>;
 		qcom,micbias2-microvolt = <1800000>;
 		qcom,micbias3-microvolt = <1800000>;
@@ -44,6 +42,12 @@ wcd938x: codec {
 		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
 		qcom,rx-device = <&wcd_rx>;
 		qcom,tx-device = <&wcd_tx>;
+
+		#sound-dai-cells = <1>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
 	};
 
 	thermal-zones {
-- 
2.37.4

