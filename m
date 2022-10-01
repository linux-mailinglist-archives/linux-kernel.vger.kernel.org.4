Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB65F197D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiJADXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiJADWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:22:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B16F555;
        Fri, 30 Sep 2022 20:15:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g130so5178364pfb.8;
        Fri, 30 Sep 2022 20:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=juW9wu13y489Hph7sR+dhrqUMWDs6TD8KFYBRB4JbO4=;
        b=UkOShts6IW9u9T3yFTtjI42gi0TloGaPV7bC/5ddCl9hAmmPunhkNDifa3/wCzAVFW
         6A1IZTMl1PxRXBs/zAPJ2TiwprwX93nBQ8mSS+eqQdc84vnX+zBCswUO0XVr6BhwPY3V
         KpcB40QjlrkAy+0HpYoXWXh8H6ORb0zRQJlHBpXFCHt6kSAKPV+Vnwd7yKOt4MdXXY6Z
         PEvOHoT1od5DKOOGtR9m92YgTgLLfFGx7yTG/z7lMYK4R8VWq6TS1nkj2aJ5HmBYhL4s
         CSLBcLBSaOUeUombfP8ac/a4sOqlxS7+kKKQdo/ZMijWKbFcqgZSrTPQBEkmy3Wx1ZoV
         oD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=juW9wu13y489Hph7sR+dhrqUMWDs6TD8KFYBRB4JbO4=;
        b=e56wSsfiJY62y3oVkQwUkwC0yhMv8A/VsfWkYHAZSzJHo33nSzXLXfFEUb2OjsBaGQ
         gUZ7pYB1amCRNqSkIrKuUs9E/IH4m4pxC1JXi2XpL5vw6sj6Y80CceOhKKioFcT0b5WN
         0lFqKw1tSzC6rQ2ZLqdIXyHzsHD/+7XkSeqO5b5j8X2tIwpiSdoSgwpusNsu9ojV6XOQ
         W/itZNt2dP843PeE2nDvC2K3/CsatSJREG/fbHSZFC6w/CINs5sTcA2hVbFL7j/IQo6Y
         W4WPhxjrFeiUYAqUWvZjyjUQIWhth5Sh9/dLiOlprTsuTKmYAneP+J7wD5qYn352kx6B
         5mYA==
X-Gm-Message-State: ACrzQf1fdGS36M1qxnN0iorc/SrSmIH1rUapOotleKRSywTMLuAU8V6L
        0udHF4EwcZawXwG75SrmJZYFX7ASFoYFLadG
X-Google-Smtp-Source: AMsMyM5D4l9JsGqXgs9A63E6didLWcsPaoFzBxMa/D8qX5FCUImVpo7wKrQKlyj/Z2649h6to7tzFA==
X-Received: by 2002:aa7:880f:0:b0:558:12e9:178e with SMTP id c15-20020aa7880f000000b0055812e9178emr12167552pfo.23.1664594057305;
        Fri, 30 Sep 2022 20:14:17 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id cp1-20020a170902e78100b00172a567d910sm2627371plb.289.2022.09.30.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 20:14:16 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 4/5] dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
Date:   Sat,  1 Oct 2022 08:43:43 +0530
Message-Id: <20221001031345.31293-5-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001031345.31293-1-sireeshkodali1@gmail.com>
References: <20221001031345.31293-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pronto v3 remoteproc is similar to pronto v2. It is found on the
MSM8953 platform, which is used by SDM450, SDM625, SDM626, APQ8053 and
other SoCs. Since the configuration is same on all SoCs, a single
compatible is used.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 0eb2617e3482..2ba2b6cf11fb 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,pronto-v1-pil
               - qcom,pronto-v2-pil
+              - qcom,pronto-v3-pil
           - const: qcom,pronto
       - const: qcom,riva-pil
 
@@ -199,6 +200,21 @@ allOf:
         - power-domains
         - power-domain-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pronto-v3-pil
+    then:
+      properties:
+        vddmx-supply: false
+        vddcx-supply: false
+
+      required:
+        - power-domains
+        - power-domain-names
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.37.3

