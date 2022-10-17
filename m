Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E23600B55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiJQJpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiJQJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE8349B53
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso9092294wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEMkL9tW27qh7qB7z1dOyn6IVj+P4lSJ9BRc/xcD6yA=;
        b=tqpUPQzZ6y8RLfddNydP2ob3DrzdrSbmDv89JQJSkxJO/gDShXFCEasTlq3oLRFaRa
         q2C/qMD+2wxOT/m41kvg0DnUt/693bhJCt8SMyoHqnJlXdBrOjOotBFNls98RryeWyjX
         JLHlS5Tos1VeKN0MHtH9km/49RX0tporxGs77DhXBTok9DnHZ4XjdyLk6WdF6+w3xmZG
         PcG5SBUT0zrtLcj58vsc/afS0wZy73sPvaRTTrY92o+ZFOSbKJwc+1Zw+JlLwTKSCQxx
         pQcuxj6VfvPqjwUxLx+zybOLr6ndlUk1TRFicMLT6Em2P1lgIRYma3/AbxMHACFw3YUN
         amBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEMkL9tW27qh7qB7z1dOyn6IVj+P4lSJ9BRc/xcD6yA=;
        b=YAtS3FqFQl3Xhi0qAYy09kq9AMfNKZjDxBEMIt8uJ7k1I72zzAhj9dMExdQsnSS2kc
         kOHRPu4Ms3+p38PmSh4iKUiK8+oHHK5+GACPOR2ytD6Qrc6ShByBsaXya009HeaQOiqR
         hL8e6itlUUBRKHEoCT3FqBYR1q7g3/PLhmIBI6Skhq3LonM/TFisEp7Uzxtoz8oUuV85
         dbwhXCLaOxQUBUjL5h+2Cn8ls2Db79IPneQ9su9VpVjVW3xwJCnAI0euZveHMLpduRh3
         2LeRK1QCJ8iEiBCJLyFWeT8rapLLdMHr0X0/7ma2784D9ZAWSZsfNqRzF4GwmyvfPuRX
         u0JA==
X-Gm-Message-State: ACrzQf3K80e0/AIYVPUyTR5jrE5m3brt/5vH1prUN7gO32do9HEV8RwV
        pFgFS9uhoLBTnwcPy558bEwD4IYsq8TKYYwG
X-Google-Smtp-Source: AMsMyM69qLfR2ZhwvgPH3kDdbwNowjpruwjJ6flGsEfdQYt5ewAAQepIkFD1MUI0oYxC/2T0XYMjNg==
X-Received: by 2002:a05:600c:1546:b0:3c6:be44:d3d2 with SMTP id f6-20020a05600c154600b003c6be44d3d2mr6783887wmg.63.1665999930104;
        Mon, 17 Oct 2022 02:45:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm7824305wra.88.2022.10.17.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:45:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 11:45:26 +0200
Subject: [PATCH v3 01/11] dt-bindings: arm: qcom: move swir,mangoh-green-wp8548 board
 documentation to qcom.yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v3-1-531da552c354@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-rtc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml |  6 ++++++
 Documentation/devicetree/bindings/arm/swir.txt  | 12 ------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..0a9a1dc68c1b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -265,6 +265,12 @@ properties:
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
b4 0.10.1
