Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC2719828
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjFAKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjFAKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:01:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C910F8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:01:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso674618f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613659; x=1688205659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhLfMSXbxmp9qPPD3GeAKDBquiRljuGLX+U4KtK6EsU=;
        b=Mi+HYJuzcYx/8PFg6UbPwLzpGhnIcbs57VZPn4tfuqglLwAnOXjZRqH63evRfbO/Ad
         cLEnjdQdVrQr4RXzNcYoXqh2LEwyrDvaMa8tQvDG7q2iqzHS+K/bgUG6RKl28qwZrAk0
         B61/Et3fhRDkBeRDNbm72wZx7L7BLCGbV4RcQA87oksOQdko/xCI6oh4TLYP0AaWLvF3
         zaST+LAjxcb9ORxnHYYJAvPM6PEaN6rbajAF1svABj9UjJMVwuK2kbayLMpt7IZDa8/z
         9GOc9pwB0t4rZe7vXGsh4zyjw7+2cx9jzTdYARo36F2d1E1/iH1L+7o3nAQEeRKfT/N6
         dClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613659; x=1688205659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhLfMSXbxmp9qPPD3GeAKDBquiRljuGLX+U4KtK6EsU=;
        b=V+HjDfM1wiBgcjDwtB/CSxmiFBRUdLRgy1fmdqk2yIjGoLux1njFBQNv51idc0NFOG
         bDHlbkKrKbDuX4u13KWykne2BWRNFu7rNgnMVgr1yWy0cLq9me7BjtnlDgivLEiJqYhu
         mWvPEhfc5zFtBjyyl0uOmo0xxNcDl28kf+X/tgIyErnC2TB1OwAow/DAeHcJDvqUM+zY
         OKNZZbzhx5yzTDmcEtvfVR1AXvKlgsCFClCftNsj0oqzCHkb5leLDh8ox7YVuLcIhyrL
         IeIjnRht1AHK+/Cmq/2uS/nJuqhnGdB+ayW+y4tSLGEwGoLcC+SFcJX2kQT3EYAmEjmM
         LMpA==
X-Gm-Message-State: AC+VfDzbOe5MKhz8JwFXCH+aqwopmWbypO5NvPCrzZMYV6T64wzcoGax
        N1AJG6G72GrSNgYygjALeE8cj786qmZspxBdOBKlKQ==
X-Google-Smtp-Source: ACHHUZ5RMPlVpM0IZRz76W/4T+7IjRRxXwq1tAZXzpRr51W4OOHG1y/iL+12CusMY0dHQ4cVspMixg==
X-Received: by 2002:a5d:58db:0:b0:2f2:4db4:1f5b with SMTP id o27-20020a5d58db000000b002f24db41f5bmr1455131wrf.29.1685613658785;
        Thu, 01 Jun 2023 03:00:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b003064088a94fsm9708543wro.16.2023.06.01.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:00:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 12:00:53 +0200
Subject: [PATCH v3 2/4] arm64: dts: qcom: sm8550-qrd: add notification RGB
 LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-2-8823ee43f3fc@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jI2H0I/73ntY355iZoJ/p4DoFxC9y+9WLIkumJL3rCc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGxW0FjmiGv68lX5bbvl325dMXMq3wbNrGSDV72P
 +JF/ZOiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhsVgAKCRB33NvayMhJ0Yh7D/
 98RG9ainEA4X/o7gy0a8+eyxBnpQWhpbTTJP8KdEXLG1YiP5VbY7VLkhpkTSsCSYWxxKxhn+nxsqp+
 MXx8XCDOeq8k/WR44amZTB9wQLTPEZZOUZ0uHXnsTUD433iLmZC3QUcNIJIGfR6jfIbCn1AL7CZFNp
 RiapwTy1iLLzG9Ulx40Z40EzA191vLG5F3+Ajmr6hveo0nVwZUgHSHTSZSFpL2CZE86MgjB5I1rqed
 +RoN+M5Cytu5O2fQ7m8WKRYZ9HMw7Y7iyFtUeuGYMY+P5P5T7Ufp3dD91RGRp6OQIv+FizwhDisAV2
 CYSRWQesHNjf8GzfTM0cZR0UTqFkzI3Ioy2+fl1HjYfhpFNcsFtU+uQ7e7BLTj5EyxuWbsFUt/JwWO
 cSqQ7UeJ3XKU+xqDB2imdcerh06Ho/9/D+j73uSJzEt38rXZ+S/J+myYtFeXMLPm2wbbZ3amBcErIP
 VeVP55spXWEn5YVFrQGia1PNHyra19H7H37wUjCj2pYqio44GylIqW27IYh3qWDX31ay+KU8/Pw85P
 31j50MMtK40dTdbb0QyF2IPxmmteD3QFyqodRbwxljIx7OoSGMwK/eGUGJ3oWc/pNcgUl+1oCO87xo
 z53EjooVUJg8RCX+JdVSVDseobDJzrFaQjssIMKJjwtq9GXmmEHVNt3PUnSQ==
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

The QRD features a notification LED connected to the pm8550.
Configure the RGB led controlled by the PMIC PWM controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 8669d29144bb..efff15225e67 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -516,6 +516,33 @@ led-1 {
 	};
 };
 
+&pm8550_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &pm8550b_eusb2_repeater {
 	vdd18-supply = <&vreg_l15b_1p8>;
 	vdd3-supply = <&vreg_l5b_3p1>;

-- 
2.34.1

