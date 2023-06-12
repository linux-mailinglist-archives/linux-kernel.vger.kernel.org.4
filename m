Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0257B72CA05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjFLP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbjFLP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:26:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F611701
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:26:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f735259fa0so45537785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686583608; x=1689175608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWxp0A9f2AiWgsptaHzRYn+xtrjX1untDQt897ukbeo=;
        b=N9gaZs3GOrtMfoObvoHXAIZYbDkqzj43EiMUg1n+ZSC7S7wTMeoVX3vY+xMue/lK0U
         +4W5YGbVwZW/YSJbachvLaQWJhMgqfDzKklacB7ElGpOsil3wAeclrpuhq8/rLtgBsiM
         98gRAkV5ZNmgkSRnmAyCQ0mXvVwsiSsrNF/FP5BOp0rnuMQujqrCyvEa6eZBoU7aR8Ck
         AeKxtIneDTASmN5xWbdBU+j/qS5ccbIAgwDxsN0v45cevSDyqlWizPRKaIThIIkqD3Xa
         OwM2VlDnVAh5l/lmA2ogaerIq2ao0hhWIY+ctmL+3moYPWaybmCX06GjzuzJ3BxKf24z
         Wxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583608; x=1689175608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWxp0A9f2AiWgsptaHzRYn+xtrjX1untDQt897ukbeo=;
        b=c3aRr09UgWAbiYFMTAuf8mJZD7Lxt6d0VR5zy/AV5R2hadIREXHNtPfhNr7CukSV6H
         lb6y9fymWgw/zVSxuSl/LjhK/I7PlkDrYeLe2FlpxxuHQ3+SMTAb/uQnSmA5b+5my0LY
         i9UvC4UoTwCKfXbjqCt8Y+oFzKJqCWNiVvslr6oIVVKLan6r0sXe+VDQvLN14iR/Df/t
         FdC2jU18ECuJwUrpd1LZ6juDfueRG3vDqxgXOOVwByAh4y1uHa3/1nkbsAOJi3gtzyVp
         qlwkPdrchXW0VOyHgD6RzqoFiaDlK1qH0tg+6tETn1MmX/yu8khDFR3ahddS5ZpzY5KE
         IepQ==
X-Gm-Message-State: AC+VfDyXGqI5fV/2vZ/PaclYp6T0IUrq/bnEDD/dTMkk/ncq5LzeKpC9
        ePwqRbaTxveAuBEqTFEkdf2Imw==
X-Google-Smtp-Source: ACHHUZ6cxLwpV2DDPgY96MVULz4xXUcm/ukdR+f9kNyYlHBOiaPSx6vdMauIEiHJ/hr3Ws0OlctSlg==
X-Received: by 2002:a7b:c458:0:b0:3f8:6d6:d4a4 with SMTP id l24-20020a7bc458000000b003f806d6d4a4mr7390462wmi.10.1686583607669;
        Mon, 12 Jun 2023 08:26:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm11816344wmd.27.2023.06.12.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:26:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 17:26:41 +0200
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8550: add display port nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-dp-v3-2-5f9ffdcb8369@linaro.org>
References: <20230601-topic-sm8550-upstream-dp-v3-0-5f9ffdcb8369@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v3-0-5f9ffdcb8369@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3472;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OT9fRI9abb+RycwRAR3WBnAhUBfEPjR/71I2pAue+x4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhzkzNMCe8HsWmMOH3B20DVFcSIBhFzdJrkQ+SEgW
 5AkwBfCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIc5MwAKCRB33NvayMhJ0eDwD/
 9zdODZUvqdgFl9NF0db1A4Ghx6Zfx0diVgO3rjcprByoxdgIz0LqJhT5ySkTNQneTWr/Uz5gm6+DhM
 5i7Nw+ORnQhKYqT5FMPlRE13yuS4VBb7I0GKqBkKQ3BZMhZqhzTEYtc6pU98oTAH5GTiYl1aymCxoA
 u1VycC8eWP4EJj4ib6/X2MjOdNmrhvixPn+bvXkiMvxI6qI5xisrYZPLUdtvQbsGaMQtHcVTKtnNuC
 iajYn2WthnCHgOiANjlRcB8B+O4PwavyRg0oAgNC3IiFXNQeXOVNW3C7q8CCL/9Edhzunva84e+Pa+
 IqiJlPY7M3jACH3V50NQVusNAT3k0GVROyHagYMcZ5AQjVLr6hVVySnmsiv7z5qTIqtCIBQhz1RqL6
 JF4yg7EfUKp7KaTWtnsPlfhZLnnivm89iVYWwE9YrGyrUJAAm8dvnJRDn/UKwWNmbvUn1l51QqYPwE
 XRjJQrjJzH88co0Fs0hdb2fmae9mALK7im+iSAGl7urR7c9X8MVGRJm1xRoJY5m1w0x+/oeFS/oS/G
 WieLzgdd46wMz5ZkbBKU4ZooFhBtcGDWUUSk8RqgIv/mGtdBpRoLi8unp5vTILXtU+oIu/SSxd/og1
 UwD/H90N5uzEWAVA6BZVKVr88kQbaBhCMw3+KjTeYA7EmjR8tyyMZ4QSsn2Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Display Port controller subnode to the MDSS node.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 89 +++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 972df1ef86ee..b41b3981b3ce 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2495,6 +2495,13 @@ dpu_intf2_out: endpoint {
 							remote-endpoint = <&mdss_dsi1_in>;
 						};
 					};
+
+					port@2 {
+						reg = <2>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&mdss_dp0_in>;
+						};
+					};
 				};
 
 				mdp_opp_table: opp-table {
@@ -2522,6 +2529,84 @@ opp-514000000 {
 				};
 			};
 
+			mdss_dp0: displayport-controller@ae90000 {
+				compatible = "qcom,sm8550-dp", "qcom,sm8350-dp";
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
+					      "ctrl_link_iface",
+					      "stream_pixel";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
+				phy-names = "dp";
+
+				#sound-dai-cells = <0>;
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd SM8550_MMCX>;
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
+
+					port@1 {
+						reg = <1>;
+						mdss_dp0_out: endpoint {
+						};
+					};
+				};
+
+				dp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
+						required-opps = <&rpmhpd_opp_low_svs_d1>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
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
 				compatible = "qcom,sm8550-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
@@ -2705,8 +2790,8 @@ dispcc: clock-controller@af00000 {
 				 <&mdss_dsi0_phy 1>,
 				 <&mdss_dsi1_phy 0>,
 				 <&mdss_dsi1_phy 1>,
-				 <0>, /* dp0 */
-				 <0>,
+				 <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 				 <0>, /* dp1 */
 				 <0>,
 				 <0>, /* dp2 */

-- 
2.34.1

