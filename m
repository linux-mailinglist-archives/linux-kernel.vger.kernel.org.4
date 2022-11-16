Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEE62B733
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKPKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiKPKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:09:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60181FF98
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:09:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l14so29078840wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS4NhixtyW5TeYqdp9/kbVVcuyzIalO1l41VFDtVdNU=;
        b=hAGvJenW4Og2mAreBZMcIFFcI0BIjoFZ4aGOfVRJ5QO/K2ukidMP6ikxXClzBqeciY
         DzNaAxq0ZUy+w4M8sMIw/QH1eHuwUapiftptHXpYLudfJu/s7dnOOUQfJx2h7K2NQlMv
         2QyKJWcTZYgV884sMYySdwt9E007kmh0uq4VviHXRFOSi3qAkOtcB+TQBydG5uQCxdJ2
         xCQYkB7oWGoWG7eN7J2kRx33MRTyrDU+ZdDAfBJPth2ZB96WnLTNHc/wEe+8d9rA5Nvz
         tLVsicWdtM80d8+Ml6UooeTFWWW7/GTMsSAsgkm+jNa6Fs93EMi6HIOuU14i4SnMsJT4
         Vxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS4NhixtyW5TeYqdp9/kbVVcuyzIalO1l41VFDtVdNU=;
        b=CM6LDxG5mur1oQ+JjQRD4Qd4mm6E11pY7lNLpZBJvTVetWbo3iH7oJUuyAksLWS/dd
         cdwIOvN9d2/FrZyv8PrjVK7tu+1qCDQW8b+V0hSbb9De3KbL8FV/XcCPTDSFLkLK5IOa
         F9Mhu4igUEtoK/rix0ZOItbHXPjXmQFlcQ8vjbgSLKnNBFikgj+amknTzZOX+e7LdHF/
         OCrp4SJBEn+44XPsa82DaH1t2NJOisIGodaOBj/shLUcqtCOEgEjeWGJ0J5f9vml8X1I
         u8phqAGhdELodLHXsjnPJ3umHZxzy0gIgGdMV+oCam02oTyVTS4o5eXjkrsC5SDacZ16
         p9OA==
X-Gm-Message-State: ANoB5pmoganfTJslGQ66HSEOam3/1yiqCFZyyqKMznsG9cP/CUryGl1e
        +iOmxHWLEriogWwpN4BUAGwOow==
X-Google-Smtp-Source: AA0mqf4ho7H2ywGylNwvkqJy3pkJcC2giMqrzoSpvKj0x9mRAyZorDJ++ZPQPO+Ldxl7gjyzjvBsqA==
X-Received: by 2002:a5d:526d:0:b0:238:3fcb:31ce with SMTP id l13-20020a5d526d000000b002383fcb31cemr13873164wrc.655.1668593394376;
        Wed, 16 Nov 2022 02:09:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c3b08000000b003cf5ec79bf9sm1504500wma.40.2022.11.16.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:09:53 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:09:50 +0100
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: Add compatible for sm8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8550 platform has three instances of the tsens block,
add a compatible for these instances.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Amit Kucheria <amitk@kernel.org>
To: Thara Gopinath <thara.gopinath@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f0bd4b979e28..09dbd96d380e 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -58,6 +58,7 @@ properties:
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens
               - qcom,sm8450-tsens
+              - qcom,sm8550-tsens
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt

---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-tsens-dfaec218c321

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
