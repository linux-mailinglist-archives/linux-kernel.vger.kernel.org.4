Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D66483CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLIOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLIOaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:30:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D5426AE9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:30:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vp12so11886269ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=message-id:cc:to:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ahhIweHST2fVWw+QNEKcMc3YDUt5JUbQsb01fgMnKM=;
        b=MKpLKku0oJT9B2Npz5IZA6cYSnr4/ZP33ndTpDqKEYHYny24sutnHlzL4pWa59heWc
         QvaDZhuvjK+lzaMUw2yiCf2pSApJoGZlNyJTYZ89f+IXOsVH09yJmhzNuz32sJLY7hWZ
         pwE2GI2KSgZ5hCKPQHmXxX7iVUJpibjfs5OdSfQzL8Kp4aUu2MmAu4FHuibFtoZQN39Z
         /O1Yh5kCLlF1C04pyQK8eCKmrKAtHWMzIxPMFUADPduIXN0C4s6VHy566FxiFoWWEBAc
         hYhMhO4qLjr1XJJMxzNnEm/ofqFEimHMmY6Wv1d1bAeR4N1wkKgxu68dG5ysOcgwu7mq
         1rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:cc:to:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ahhIweHST2fVWw+QNEKcMc3YDUt5JUbQsb01fgMnKM=;
        b=PBdLrcOPmd2RaJVwFXHW8daO8XMSBmMXH1NYJVCS4aEs6OFJ8mvOCHrgx//e2RiAp0
         9LcFcw2+gpWpjQ3ugeGj1RspLe4iTQUrEE8X9kKPqlP4nrYAo8F2z5CCPlZ5SnxtTkG/
         ZrfzjaAjlCFff/jOz2/Nd2Rvjaed38MG5zCe69SXcu1mp3n5zv4szOkeupwkNXIqAJjd
         cygBnIgHGrMj0lWwmlkHv44ZOPdKWgll2uv/k4QXVsAzjr88uVxFunMFOx+055jes78D
         kKTRI//47T7g+twdfQvS9iPnCchWMZM670z9Dmtw6mzFvXeGikI2snopQp5fW7M8uOnZ
         n7Rg==
X-Gm-Message-State: ANoB5pnL7jY5dxKzw2wi92ti0Hn6P4Zbm69dwF83+g/lOiwDoVHazPzv
        vEU4mZrjedGmkYHNTNe5X9J7dA==
X-Google-Smtp-Source: AA0mqf7k6k5YG+Dp6ty81YR5OtHUag6/ksIZw1U6zjW68jA+uY5YSPGhIBQk2kcKxxdeh48jIBvYkQ==
X-Received: by 2002:a17:906:fcd8:b0:7c0:b66b:9ec0 with SMTP id qx24-20020a170906fcd800b007c0b66b9ec0mr4884778ejb.16.1670596217069;
        Fri, 09 Dec 2022 06:30:17 -0800 (PST)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kx17-20020a170907775100b007c0d6b34d54sm610520ejc.129.2022.12.09.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:30:16 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 09 Dec 2022 15:29:47 +0100
Subject: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To:     Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Message-Id: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
X-Mailer: b4 0.11.0-dev-64ef0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
in the bindings so the existing dts can validate successfully.

Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
sm8450: add Inline Crypto Engine registers and clock") so move the
compatible to the correct if.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
(no cover subject)

The only remaining validation issues I see is the following on sc8280xp-crd.dtb
and sa8540p-ride.dtb:

  Unevaluated properties are not allowed ('required-opps', 'dma-coherent' were unexpected)

Maybe someone who knows something about this can handle this?

And the patch adding qcom,sm6115-ufshc hasn't been applied yet.
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index f2d6298d926c..58a2fb2c83c3 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -102,7 +102,6 @@ allOf:
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-              - qcom,sm8450-ufshc
     then:
       properties:
         clocks:
@@ -130,6 +129,7 @@ allOf:
               - qcom,sdm845-ufshc
               - qcom,sm6350-ufshc
               - qcom,sm8150-ufshc
+              - qcom,sm8450-ufshc
     then:
       properties:
         clocks:
@@ -149,6 +149,12 @@ allOf:
         reg:
           minItems: 2
           maxItems: 2
+        reg-names:
+          items:
+            - const: std
+            - const: ice
+      required:
+        - reg-names
 
   - if:
       properties:

---
base-commit: f925116b24c0c42dc6d5ab5111c55fd7f74e8dc7
change-id: 20221209-dt-binding-ufs-2d7f64797ff2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>
