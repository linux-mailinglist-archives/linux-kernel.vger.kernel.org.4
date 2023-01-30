Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D094680A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjA3Jzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjA3JzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:55:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C512DE57
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:55:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o18so991047wrj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6tXivOycAR46BboOZwUImctP3fWSo9t2fCAHiXxtD4=;
        b=zBU36uQlaBUD9O8IjqKEc3xjCQn6hVSzmBRQ0Klk3pQb6lIGqLhIs2QVdzbSftvaZ1
         16xgX8oYVxe2YLbml8oGABj9XxlHrhliuuc0zha6qShhc+VHIeVjzP76LSMHA88phhZP
         qxZiCRw0gRAWtWn48UTeInK4CUoObX449MrByvLA8h6U3HuFv8W8iWDtbicOmBY1HWXK
         0tYIuIZddKtBcw3siP3AgF7ObWrXMXgyCYXK/Wo87x9pvCpm02sb4Ng+mRvwiXOmf64s
         W6cwTs6vkYCtnALq63Td5FsTkZAA/Do8lkhgS8uS07ecR/hqk2kLdu46Csd2+lC1NIta
         u6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6tXivOycAR46BboOZwUImctP3fWSo9t2fCAHiXxtD4=;
        b=3sDxoox7+DrXH3yb8tc1z3FPeceAkMa7Uq0T+LzVKAHobJBUY20fPO+GydY9B0wRpy
         +gsevtymk3JUdL9UAJNdKBDbO961vmVoykjRDrsoqVOTS4h2sDrChYamGqdb+zdrm0R6
         QqHQjs0Wpg813Ra9nqIy5StuEKkoB5/uiej67TDyVpkOjg4GPbS0+i8uo5/aWPwrQHIS
         kahg9wRTirzhS05HrvAHEfbTuxdfCJEFzVJm2PqDQkPSzrJE+5CttlHVzXVnGj3Knd1z
         rl/PiVfmiK2E0S1zGNeaL197OX+vwXcAmYPb3DFH6D2PH5FZfKBUx/we8cwSSvXsCDWx
         PD0w==
X-Gm-Message-State: AO0yUKV5pt7/Djy9z6cDvbWM4yucFqN9z+B41Dcxb2zGMdNeeEKkOPXV
        soovZpVF+rKJRsX+SVxN6PwsTg==
X-Google-Smtp-Source: AK7set8PGYqkMFJa6IFKH+M9yhDpbzCTSa6FR+18RVkjgfqNYGPED+Mmllg7jNIF1e1UHUm0+E51iA==
X-Received: by 2002:a5d:664f:0:b0:2bf:be0f:b016 with SMTP id f15-20020a5d664f000000b002bfbe0fb016mr16724270wrw.23.1675072481026;
        Mon, 30 Jan 2023 01:54:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b00241fde8fe04sm11453537wrq.7.2023.01.30.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:54:40 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Jan 2023 10:54:37 +0100
Subject: [PATCH 6/7] arm64: dts: qcom: sm8550-mtp: add pmic glink node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v1-6-0b0acfad301e@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pmic glink node linked with the DWC3 USB controller
switched to OTG mode and tagged with usb-role-switch.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 34 ++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 725d3bc3ee72..f054c11fe1f6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -27,6 +27,31 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	pmic-glink {
+		compatible = "qcom,sm8450-pmic-glink", "qcom,pmic-glink";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					pmic_glink_dwc3_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_out>;
+					};
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -546,7 +571,14 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	usb-role-switch;
+
+	port {
+		usb_1_dwc3_out: endpoint {
+		      remote-endpoint = <&pmic_glink_dwc3_in>;
+	      };
+	};
 };
 
 &usb_1_hsphy {

-- 
2.34.1

