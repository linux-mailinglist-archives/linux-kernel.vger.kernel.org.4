Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793336BEC80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCQPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCQPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:08:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE4399DB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:07:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so4756803wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679065599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cq4IfAT4HXdFTs2SGz35CPcumUuW538AvFYEG0nwFE8=;
        b=wsSlZ+Ghn5Q1V1NGYA8xUjf34NW79AcHF5hFiFfUwUw9ZaAQDvJRhsrJmSQRqD1j05
         weUAaXjg4DizTvzz5dWPdf9g2a0DbHGEGsrJ1XMd71xmRYV30BVv/LHdzm97mQ7EbfIt
         QPeQxrppd0F+xpnV+RLWz4sf0dlh5eZgLVhzzC3zxsBoWnkZEmYX213/BAtiJr2t6Uzl
         62I3mRcXgO0xZQE/tn0VD3VGLyLQTBgvxzm32wHFsGEcAvoQCzXXOI7NIo7dhsnHvACF
         Or4qnjavnHEFgrORrG+eb39AGvrfTkT15piwSy2kpadP4zmUfHrIZuhsuGkhe3ybH3Ed
         2jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679065599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq4IfAT4HXdFTs2SGz35CPcumUuW538AvFYEG0nwFE8=;
        b=Mw/Iafa3v5grrHBC0IILx31f6OfRLQDCP2rm3DojhAA2RUdm4IgeKAXZWB2pWOERKP
         iQ3vS/SS26WqooEXvhwDezK+8sKqGlQdahwDq+ldNsaF12JrLWIMKyKZP9ACBzlrGZXB
         uIJZ9cLOwjqHC/AW5D2+jTfx1mICqP5EvsNF0NrcBIujxhxJuyj0KUZDw5K9S3vrVKS/
         6FyyncDE8D6G3n8q+yFFA9nekiiiyOc80WjwP425YIkULMV3xgUvdu0ZHx0kYBjuFNxU
         DbgWqVOHjSZZlgXrYtPN9jeLkDwmjnXZFAQl/uVP6EEAnvGyhrW7ka6ZyOoXQdEqpaDT
         hagA==
X-Gm-Message-State: AO0yUKUpzZRTtiBT9ieauMwJ62WYxgU8AcIJb519JBEncJ4Bcvc2hxvS
        sdZG3UASJlshELenJXibhFWXbw==
X-Google-Smtp-Source: AK7set/i8klMZ4z66oijEnTItWqUwSpoxj/OkAIN+GiwhBbZO2CXjZmA6F85Mx0xaL0FXrLkROhU3g==
X-Received: by 2002:a5d:4c92:0:b0:2c5:58fb:fa92 with SMTP id z18-20020a5d4c92000000b002c558fbfa92mr7120104wrs.7.1679065599156;
        Fri, 17 Mar 2023 08:06:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d58ed000000b002c5493a17efsm2187902wrd.25.2023.03.17.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:06:38 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 17 Mar 2023 16:06:36 +0100
Subject: [PATCH v6 5/5] arm64: dts: qcom: sm8450: add dp controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v6-5-d78313cbc41d@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Display Port controller subnode to the MDSS node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 79 ++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 97ce5fe0e9b0..da6d1881ef60 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2751,6 +2751,13 @@ dpu_intf2_out: endpoint {
 						};
 					};
 
+					port@2 {
+						reg = <2>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&mdss_dp0_in>;
+						};
+					};
+
 				};
 
 				mdp_opp_table: opp-table {
@@ -2783,6 +2790,78 @@ opp-500000000 {
 				};
 			};
 
+			mdss_dp0: displayport-controller@ae90000 {
+				compatible = "qcom,sm8450-dp", "qcom,sm8350-dp";
+				reg = <0 0xae90000 0 0x200>,
+				      <0 0xae90200 0 0x200>,
+				      <0 0xae90400 0 0xc00>,
+				      <0 0xae91000 0 0x400>,
+				      <0 0xae91400 0 0x400>;
+				interrupt-parent = <&mdss>;
+				interrupts = <12>;
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+				clock-names = "core_iface",
+					      "core_aux",
+					      "ctrl_link",
+			                      "ctrl_link_iface",
+					      "stream_pixel";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
+			        phy-names = "dp";
+
+			        #sound-dai-cells = <0>;
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd SM8450_MMCX>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_dp0_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+				};
+
+				dp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
 			mdss_dsi0: dsi@ae94000 {
 				compatible = "qcom,sm8450-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;

-- 
2.34.1

