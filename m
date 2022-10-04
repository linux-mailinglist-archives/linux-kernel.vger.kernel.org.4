Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7E5F3DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJDIIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJDII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:08:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D950A2F3B5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:08:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso295810wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=svWOEDLHBgaEhOKsLw/bRBJHHJKR+93T7NM/Oxjra+Y=;
        b=SRGMd7+XNjAIBYf3IzIRL/dRd8rCqcm+LscUB4F49IcyCdF+zA9J+h+sPsCY2lPO0S
         718sEUlhL1Aw3O5uBhRAdp79/zAni1WnIIDFHPrCDW4brqQRhK5Y+W3+QxoAbozju8kH
         s/4HA9vXiwfSbdWNB5TqR3WQRPYXtSVCMhoveSOBNPvRcz8DdW5Y8oFrPq4nNm/1p8ZF
         8CO2m73EXY+XcCwbz60I2wkwxfkmDslhzhYn/1RU+2LgCnz7vICdvmhqcMDQXVHmJ+WC
         T475sG5PxJqn0nD4cytrOT2hhMRGNmHlCE73SzuLp8LYBlBfU6nwMp/tFi0hrgv+C2os
         S4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=svWOEDLHBgaEhOKsLw/bRBJHHJKR+93T7NM/Oxjra+Y=;
        b=DOxkzJlz9XxgXzAzSJUhAR9vjbZDHQ/Hp7T22m+pYeQzCKPfRgHMqhSbv87uj/YKde
         zwMgqNEhUIQIEIn3FjEtM3VYy8OPLs5ZMSrwQCbANgcoTXaAZcBdw9UveoaHEppK05Xv
         190UCnAoMUnsKAvDxNT5sF1l2NZsQ2FLjgBkvvj82hmMpPQtVDV6WhaEa52Gyd6Pyqt+
         jllXF670fsS+OAW8SOnpiGmzZSumFyaVXYZhv2y4s5PKhY0n0jWS3YVXjCMV/KabMByv
         m3tB3Tf3HBt5deLQlTOb4+twg7o9RL2P8v1kQl9IgPQMGMk1gQZUjJLkuABhNwna3JKI
         C2Uw==
X-Gm-Message-State: ACrzQf1VUtErYjcHYnwv/sDtvHidcSE62yWLrAvsJD9H2doX9GV3cmRb
        +JQjK0xDqt6pUgA7MI667aOoqg==
X-Google-Smtp-Source: AMsMyM4LfdwqPm2Uugv5kwaFojI6IJeP/ROmtesDCfJPCYGDOG2/E7L04KBJMHt3sMDHPPWk8y4HHQ==
X-Received: by 2002:a1c:721a:0:b0:3b4:641c:5d99 with SMTP id n26-20020a1c721a000000b003b4641c5d99mr9552403wmc.71.1664870904931;
        Tue, 04 Oct 2022 01:08:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm20228866wme.32.2022.10.04.01.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:08:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 04 Oct 2022 08:08:17 +0000
Subject: [PATCH v2 01/11] dt-bindings: arm: qcom: move swir,mangoh-green-wp8548 board
 documentation to qcom.yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v2-1-87fbeb4ae053@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document into the main qcom.yaml as conversion from swir.txt to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..e9f38f0cef19 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -262,6 +262,12 @@ properties:
               - qcom,ipq8074-hk10-c2
           - const: qcom,ipq8074
 
+      - description: Sierra Wireless MangOH Green with WP8548 Module
+        items:
+          - const: swir,mangoh-green-wp8548
+          - const: swir,wp8548
+          - const: qcom,mdm9615
+
       - description: Qualcomm Technologies, Inc. SC7180 IDP
         items:
           - enum:
diff --git a/Documentation/devicetree/bindings/arm/swir.txt b/Documentation/devicetree/bindings/arm/swir.txt
deleted file mode 100644
index 042be73a95d3..000000000000
--- a/Documentation/devicetree/bindings/arm/swir.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Sierra Wireless Modules device tree bindings
---------------------------------------------
-
-Supported Modules :
- - WP8548 : Includes MDM9615 and PM8018 in a module
-
-Sierra Wireless modules shall have the following properties :
-  Required root node property
-   - compatible: "swir,wp8548" for the WP8548 CF3 Module
-
-Board compatible values:
-  - "swir,mangoh-green-wp8548" for the mangOH green board with the WP8548 module

-- 
b4 0.10.0
