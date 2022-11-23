Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003C76363E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiKWPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiKWPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:36:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2661754
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:36:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3179360wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgJnlXA/WQvDoRbBq0+m+j+f2DhODOPC9nPotgIbx1U=;
        b=Es1bgfzu412Kx60PeTZcrp1bmjukKo7/RDWkNjXkIxFnTwyS79CFMHKSq3vUqaG1eq
         lH4RmLmwBV9SiEZGbn25SH/jn26PhtFZIzpJNrhmNCv0XgVN6dTNZVl3dnAbtvUjpiLm
         VHr1IPAOlfE0L28YHHQkcWuxJnS5dBcvd+kWVP+fjIbkE0f09J63W3baLeVJ4xGJz9Q+
         oj/N0pb8uJyHtwxQMA7Xvm1RQrrpZfmJdsb8GFtoe8gfuiaXGbaeZG++k+xTnjTxafV4
         w1jtviAbCO72DNCTgje6k+Wk5hqNclf/4aigk5relTSXOls3NICIV9P9FMsSyP1e6Ja7
         qzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgJnlXA/WQvDoRbBq0+m+j+f2DhODOPC9nPotgIbx1U=;
        b=RUke+Hwa6vA3iNeIf+hXlft6EQPGIcUO9Fra24eLHXhyvd8xgds63Lux19XYvziFud
         3gEoVNmlOc5o+hW0AuDuHFqVqTTIvNFkh9sP9z90pWDspQHmTZdrQ9eAzIanq8DAObjp
         3crUGPxEz9GrnE0FKpCxKkKnMV3THgejWHWkX0fNtrNYKAPLwaXSQAqKMen4lfKJgt/B
         RjzvVCLz+pIxU8EhYvU7aixEX+fbldfwYl4YdLEbgpOxBPY89S69ajrColM7E2xkghua
         r+j1gFDkGwo7a3/pSYPfIpxFJ5eKtqDytsoJyIBvGKzybYg/3m1XOtWQztwY6nHm+2Y6
         5xXA==
X-Gm-Message-State: ANoB5pl95pb3MCUz26yoq/DB2eWrEIjXFWMfYhS74vT6AYyCSOmtm83f
        FOGdGou/s77ebCFNXY5bhTUnXw==
X-Google-Smtp-Source: AA0mqf42OTN0ak2fomSu+Cv4KnSKJMzjfpa8qISdE7HnBOnCADBFj/eHKxSj9cKSpTJqvUcHn4VJgg==
X-Received: by 2002:a05:600c:548b:b0:3cf:b0e4:30d9 with SMTP id iv11-20020a05600c548b00b003cfb0e430d9mr13918414wmb.66.1669217811237;
        Wed, 23 Nov 2022 07:36:51 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b00228cbac7a25sm17169833wra.64.2022.11.23.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:36:50 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] regulator: dt-bindings: qcom,rpmh: Add compatible for PM8550
Date:   Wed, 23 Nov 2022 17:36:37 +0200
Message-Id: <20221123153638.721254-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123153638.721254-1-abel.vesa@linaro.org>
References: <20221123153638.721254-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for PM8550 used in SM8550 boards.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * changed subject line according to Krzysztof's suggestion
 * dropped unrelated changes reported by Krzysztof

 .../regulator/qcom,rpmh-regulator.yaml        | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 7ff51b558702..297a75069f60 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -47,6 +47,7 @@ description: |
       For PM8350, smps1 - smps12, ldo1 - ldo10
       For PM8350C, smps1 - smps10, ldo1 - ldo13, bob
       For PM8450, smps1 - smps6, ldo1 - ldo4
+      For PM8550, smps1 - smps6, ldo1 - ldo17, bob1 - bob2
       For PM8998, smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
       For PMI8998, bob
       For PMR735A, smps1 - smps3, ldo1 - ldo7
@@ -70,6 +71,9 @@ properties:
       - qcom,pm8350-rpmh-regulators
       - qcom,pm8350c-rpmh-regulators
       - qcom,pm8450-rpmh-regulators
+      - qcom,pm8550-rpmh-regulators
+      - qcom,pm8550ve-rpmh-regulators
+      - qcom,pm8550vs-rpmh-regulators
       - qcom,pm8998-rpmh-regulators
       - qcom,pmg1110-rpmh-regulators
       - qcom,pmi8998-rpmh-regulators
@@ -83,7 +87,7 @@ properties:
         RPMh resource name suffix used for the regulators found
         on this PMIC.
     $ref: /schemas/types.yaml#/definitions/string
-    enum: [a, b, c, d, e, f, h, k]
+    enum: [a, b, c, d, e, f, g, h, k]
 
   qcom,always-wait-for-ack:
     description: |
@@ -107,7 +111,7 @@ properties:
       regulator-allow-set-load: ["regulator-allowed-modes"]
 
 patternProperties:
-  "^(smps|ldo|lvs)[0-9]+$":
+  "^(smps|ldo|lvs|bob)[0-9]+$":
     type: object
     $ref: "regulator.yaml#"
     description: smps/ldo regulator nodes(s).
@@ -299,6 +303,24 @@ allOf:
         "^vdd-l[1-4]-supply$": true
         "^vdd-s[1-6]-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8550-rpmh-regulators
+            - qcom,pm8550ve-rpmh-regulators
+            - qcom,pm8550vs-rpmh-regulators
+    then:
+      properties:
+        vdd-l2-l13-l14-supply: true
+        vdd-l5-l16-supply: true
+        vdd-l6-l7-supply: true
+        vdd-l8-l9-supply: true
+      patternProperties:
+        "^vdd-l([1-4]|1[0-7])-supply$": true
+        "^vdd-s[1-6]-supply$": true
+        "^vdd-bob[1-2]-supply$": true
+
   - if:
       properties:
         compatible:
-- 
2.34.1

