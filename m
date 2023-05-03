Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98D6F58AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjECNKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjECNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:10:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FE4EE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:10:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3063208beedso2865560f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683119440; x=1685711440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRRCfBO6zriGG0nKdP8d0t75xCVvsaU1mz5Nyygo3mM=;
        b=is33I0lzOV2ICPraJ/KD3Yp3FRiAGD3WAWupEEYMkppZu2jq3twhkt0Id0GGIBZ1/X
         9yvp49PCEiFuWlyFQ3e2/EEYD4pFbUWRmssVJNcTA4aoqqsOYpwmNg5Ozy9z6TcUrmJ+
         AAvyVo7Qcg79Dpo9BYn0vIrXCSQMETEkyOBk532f71Sl3v6gxOaojAteQ4OePTmc+N5E
         It2K9sag5ObfzDbN5MhCcDHS1wl6tz0i1ADh6HBqedHciPZjxRuNbo9GhTvJn/uDieJw
         RFhHFA6dF/G67o4gm4tprsB6u5LdbjlGML6e94c9aGeWAiP4eLHxhYE0TRlc/l8snFYd
         ffcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683119440; x=1685711440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRRCfBO6zriGG0nKdP8d0t75xCVvsaU1mz5Nyygo3mM=;
        b=Upk7ysz6eda0fvzNmbnG5Hwxat7Pb1AcT/MzE8m426L9xKAP2M3T12e5eNuEk32uso
         RDPhOdy9ot5oBVhVLY9wkvVHCezdsEKjYAdJvuWAMJnTQj72uXE14BLhWuwYA+ALKgwF
         nUTIxxW/VsuOMjO2jnYIWkLyzjR4RomfzPOhIJd6NTmWzIJ6U4Geh7JsLvOrjIqUUpT1
         2GNNymaLx3N8+h68Nm0bG8kN+fMZenw/I3v33tDFJx02byI1Op1m4I0MmvL30TwPcDgG
         V2JhaG1N8HWDFLql+5rrccuARWvLr6BYBsD/d6Jo02VSB0XU4XxK6lbAm7/3dcGtKW90
         I92A==
X-Gm-Message-State: AC+VfDx1bU48JNieS+5cqe4TEo41Lo8rB5OLfsKBX0K2v9HkvOWywge0
        O9Jv57R95IekJEUXS6lDo2APoA==
X-Google-Smtp-Source: ACHHUZ7YmNOQEeoWBoM+1c9TP4UZ3Rx8cmIbiP17RQtewUwL1cusQ6+rLY8NMFOXveXIxheZ36BMIQ==
X-Received: by 2002:adf:fed0:0:b0:306:4162:ebbe with SMTP id q16-20020adffed0000000b003064162ebbemr18177wrs.49.1683119440626;
        Wed, 03 May 2023 06:10:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm5413479wrr.28.2023.05.03.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:10:40 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 03 May 2023 15:10:34 +0200
Subject: [PATCH 2/6] arm64: dts: qcom: sm8450: add ports subnodes in usb1
 qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v1-2-d1ee9397f2a6@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2NeDm2a5PIonvEq6H3mDXLNkkIBuy9fp6P7lG0yr9FI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUl1L7oVPDuhz64aBwhRYqvYFZ/tJifAQJ05Otmdq
 0luezMuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJdSwAKCRB33NvayMhJ0ZOHEA
 CXPa4vVJ/HlRdJPFG7o6Vw7pajeL/SvZ5L5NyQMnXyqjRNSQiqXsOPmod7yKQtcgZe0OwIZK1RgzOI
 ZPkO9lJ24ACNbJuWe1E+ghe3OSXOT5eQJ2YQdU0E1pcTYnPaLpZSvtQ6mSRyHnnB3dax87q4ALJ2hQ
 YYeyv3wmpvNtFuKHflWb4waUDmsqbnC2CRaw+k9XCSmIChycT/XYz5R+ACVK/4iTZLqNFL1U8+uJo6
 +dxZX6Zx6Gt5nHXB9KtIcBr4GvmEqp2FkqZFJX4QlvSCpcHSA856ISgrial9Zlytt/ddF+vmai49m4
 r7Ed+dzOF2fX6sC1YH596PhgJTYaKp7bMspLxITnsnFObPhXpF5rjOKp57MLNsnSLneQay4sNZcQx+
 vHs8s4EDjgfktcXuodEhs3BvlbKKI4830WM6/s7+Iu0HxeT/PIUTQRg6g194LT4yEvRKn3A3d1ppP7
 bpAeA6FsgRTMc0PbVdn+QRQ2BpktYuOsI1RVvz/5EpVthhSLVJRU3zbMhVriv50IJDt3lAAS5Oxycm
 Pop88J8rpy/KVUt0oFA5PpCVonnlMCvmr4x2JjtHxm7AB4ndfPr6A1eb8pLC+if4f9MVHC3VWz2DVJ
 obb/OBzutgisK4+aE4iUZXZBfiJO5m1wGHbnAVhvwNpFtBHs5oARt2uZri0g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3+DP Combo QMP PHY port subnodes in the SM8450 SoC DTSI
to avoid duplication in the devices DTs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 595533aeafc4..207afd48788f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2044,6 +2044,32 @@ usb_1_qmpphy: phy@88e8000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint@0 {
+						reg = <0>;
+					};
+
+					usb_1_qmpphy_dp_in: endpoint@1 {
+						reg = <1>;
+					};
+				};
+			};
 		};
 
 		remoteproc_slpi: remoteproc@2400000 {

-- 
2.34.1

