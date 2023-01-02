Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EFA65AFF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjABKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjABKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:51:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D662EA;
        Mon,  2 Jan 2023 02:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D6A60F24;
        Mon,  2 Jan 2023 10:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B85BC433F0;
        Mon,  2 Jan 2023 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672656651;
        bh=7UX9bOAXVnWRxEDVubLyZtn33Yhbs5rYhhTJqnlC0mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KogeyiMofFYXmCceCHNzJjy1BSXMXV2CtlkhgHhPQU6SFAdRGJoZoGIOmzYbWScrk
         Zz7OFsCOHdBlNJa3mQQM+IVU5vhcqs/sGUzWZ/oWkw1WaEvik3o4ynZBwvWlC3uTvQ
         2NiDpGVLUYiFQjaTX/VjKVBEP8k5bCs8WogfIJVV3+Ft0LMmgt79D/k29aMPq2Q48K
         oB2Dl+6TQ8QEbYYW20XKKiozkG2/QAU/G4YjRx9vi8b/1c0og7brrwTnTVEyfAIHSX
         OGGyTMnrDeCqpVRS04B2lmmmvpl7Iep/5fa11uLjKc8MdYAJE133oOETulAiiZ3eGB
         aev22jqC8q2Fw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCIPM-00026s-9I; Mon, 02 Jan 2023 11:51:08 +0100
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
Subject: [PATCH 2/6] arm64: dts: qcom: sc8280xp: disable sound nodes
Date:   Mon,  2 Jan 2023 11:50:34 +0100
Message-Id: <20230102105038.8074-3-johan+linaro@kernel.org>
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

The sound nodes in the SoC dtsi should be disabled by default.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

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

