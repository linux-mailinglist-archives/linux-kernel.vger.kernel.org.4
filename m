Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7A6E0344
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDMAhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMAho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:37:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0F549D6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:37:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z8so18788351lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681346261; x=1683938261;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mkrhtaW8RsYbUQ5f7IhajN13a1zUBEoHVYcCAD4lt8=;
        b=YAUQK6Uqc8xFn1mrCRoO2XRW2ReAsqji5eNZL0FBpz14vLPT6uViBgrDcVLKB7vCK9
         qzZlBuNR9hs3yTwEdetkHvjy+0ge7awJERq9xpbZJx9asVdjnHEmhlYQpxQLXcV1+VOk
         7U1rzfEl+cf5VuOKQARmoeUL0W3olCbQs/Ln0iJMsOyUyj2glO2REK42MwMrk6dfheOb
         begKYhC0/wIQVs9nVImUHblAxR8c9n4SZS3RrVC+QDtnWmdJzjOqBDn/uYOuMzw8u9EA
         nKV8/TR26Wcslx2+BnRFy66bRrccNZxgQSCcOwb6Cqgbr/IWV2QagXei2xcOXcehByE+
         zPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681346261; x=1683938261;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mkrhtaW8RsYbUQ5f7IhajN13a1zUBEoHVYcCAD4lt8=;
        b=T5OPtI5XUhVrQdePm3T0Mv3iTAPIELloqKDgO7eK4BNpBQ0AXEh49uAkdBzW+lQDiF
         OnOsJK51qzTmJ7Gr+rqzSGqE7oBKp6z/BPnwHn7hC1pQe0g7+Klx9d3eAK0OprtiYfJP
         wmKSskwMkRSbltMvgkp37j4ifdS2F8NTlYV1H4N6hoG+lZm6tf6QF8ylasMg7Xl/lQm7
         /3zPb2qptj4IHtf8KLmSHB3c8MIsbuc9hVDzsKTrK9EMUs2iacqIF71IAdRBIsOLnTEt
         wUjEzVuG8t7eKpgT14/XQ6EA/KtVW1O31YrOPACPXo6ZPbCaIlTRP8BhqWhf2Mh9NPQ8
         ppmQ==
X-Gm-Message-State: AAQBX9ehbUzSurO1iIQDWoaORHCeHcWiiOijdDJ/Jwq4mQ3OGzSkYiA+
        /1YppCuFFovgL8M14dZxHni2Rw==
X-Google-Smtp-Source: AKy350Y3SDVjMmc9PlqIlyeh9f7wZCt13CLFaobUPByq17P4fvjyFCNsXA94jtRMwT1S0VjCVanJ5Q==
X-Received: by 2002:ac2:5228:0:b0:4dc:828f:ef97 with SMTP id i8-20020ac25228000000b004dc828fef97mr236444lfl.60.1681346261169;
        Wed, 12 Apr 2023 17:37:41 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id u6-20020ac243c6000000b004e7fa99f2b5sm48280lfl.186.2023.04.12.17.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:37:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 13 Apr 2023 02:37:36 +0200
Subject: [PATCH] arm64: dts: qcom: msm8996-tone: Enable LPG LEDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-tone_led-v1-1-bc3c73393bfa@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM9ON2QC/x2M0QpAQBBFf0XzbGuXRfkVSWsNprahXaTk300ez
 +3c80DCSJigzR6IeFGijQVMnoFfHS+oaBKGQheltqZUx8Y4BJxUbetqtkYb31Qg+ugSqjE69qs
 c+AxBxj3iTPff7/r3/QCzjKCXbwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681346259; l=1516;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MrJT4mj6R582Z5U+PgPBwlwFZ2TPZnZ9vzzkyNUYHv0=;
 b=cbCGz68G8gQkNon6eTKu+JtLpOInN4sNKXzNSIhMtiBml/aps00bbZ+x/qwArs9VUZJbaz29BwgF
 oXYQXPgUBHP+kppjID6BqfQpOfUtOGKf0q+KO5T81/wxz7DTgTft
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the notification LED(s) wired up to the PMI8994(6) LPG.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/msm8996-sony-xperia-tone.dtsi    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index 7f4d493a55ff..b4b770a9277d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -11,6 +11,7 @@
 #include "pmi8996.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 
@@ -605,6 +606,34 @@ pm8994_s11: s11 {
 	};
 };
 
+&pmi8994_lpg {
+	qcom,power-source = <1>;
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
+			color = <LED_COLOR_ID_BLUE>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_RED>;
+		};
+	};
+};
+
 &pmi8994_spmi_regulators {
 	vdd_gfx:
 	pmi8994_s2: s2 {

---
base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
change-id: 20230413-tone_led-6465f4101c75

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

