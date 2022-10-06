Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E825F6050
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJFEsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJFEsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:48:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7111380F6E;
        Wed,  5 Oct 2022 21:48:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b2so675206plc.7;
        Wed, 05 Oct 2022 21:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F1j9hUcPRHywt2S2C8KGBCluu0HhtErIKV4h3/xD/eA=;
        b=EUYYRD0RHwcLITnY0M1k+EpPSGYpuiOPdTGMv9hbTxeOGFOFl8+k0Wqzw/BLoEGwIu
         MckKSRSqwhoU0gmXm97YOPnSAyNDUFj2dpLcTH7jdZTPkFxMc3W9yc1+rCuAcYMgV4L0
         b9Sao/hKEAHKoReT9fc+GPACRQYxThF9Xm7Ng4QkkcLBYXb9ns7Ke380dRZ4FiAelwqh
         WuiONLKt4ZDanbm7M5DW35yYuEuoLHMkkDs+w7NxwhYF/nXqQ+wl6BqUKsCYkJkLZVYn
         m41J2t/yUjqyYSRYbcEHSp+IBWxg6k9ODB2sCvO9rSsl3h1ZcJWfOtelTYodR2ZIALGy
         85SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F1j9hUcPRHywt2S2C8KGBCluu0HhtErIKV4h3/xD/eA=;
        b=R2wJqHRTfoSvidV1G4zO48+j8igeWq31cF6wYeF6S9k40xTp6jPkyi4Wdk4X4+gOgZ
         7FJ3Kr5ininWxLkYWhmKp8sVeZDW9k6/L/8qFieu0FwYCXPnTiYpqf9xB3wuUuu5uBRP
         RsgS9H/Fr9shIAFaejfvfxMyd4Rj3K3tnH9pS3jsW/91x7v8O6E6LcSPKYcy/+B3e2ph
         vIQP5HXPHGxrmgVYHMAGA9L/UBFVk9Oy32waUICZvJO3ffRkAzLWA2TZ3lZHAs40/LRl
         Szxv5qxkFKTFomDjFbEcV9HgvbZkQ2r5Uy4Kiv/65wlOhD/F0DGuS6FpaLveuiWxvgsM
         HtNQ==
X-Gm-Message-State: ACrzQf3Ck2SB/rxzbWPPNCCLy4Qo7Jr5+I23Kxxhk440elDol9XtUaGM
        0Qz7dR2UmeEPJiS03Vn/ayqd2hgEOoseSg==
X-Google-Smtp-Source: AMsMyM4aIo5rvKk3852EzG4lMGB+z9v32h5qGfcegR4uO9htsNg4csa845Tha9HSAvGIkBzcF7F/1Q==
X-Received: by 2002:a17:90b:4f91:b0:205:edc8:4ae with SMTP id qe17-20020a17090b4f9100b00205edc804aemr8818277pjb.110.1665031690388;
        Wed, 05 Oct 2022 21:48:10 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:350b:1ad7:ecfb:8fec])
        by smtp.googlemail.com with ESMTPSA id f7-20020aa79d87000000b0056232f5fba0sm2187448pfq.155.2022.10.05.21.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 21:48:09 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953
Date:   Thu,  6 Oct 2022 10:17:45 +0530
Message-Id: <20221006044745.286264-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006044745.286264-1-sireeshkodali1@gmail.com>
References: <20221006044745.286264-1-sireeshkodali1@gmail.com>
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

Add support for booting the Audio DSP on the MSM8953 platform. This is
used by SoCs like SDM450, SDM625, SDM626, APQ8053, etc. Since the
configuration is the same on all SoCs, a single compatible string is
used.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 3072af5f9d79..c9d69f6160a1 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - qcom,msm8226-adsp-pil
       - qcom,msm8974-adsp-pil
+      - qcom,msm8953-adsp-pil
       - qcom,msm8996-adsp-pil
       - qcom,msm8996-slpi-pil
       - qcom,msm8998-adsp-pas
@@ -179,6 +180,7 @@ allOf:
             enum:
               - qcom,msm8226-adsp-pil
               - qcom,msm8974-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
@@ -298,6 +300,7 @@ allOf:
             enum:
               - qcom,msm8226-adsp-pil
               - qcom,msm8974-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
@@ -369,6 +372,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
               - qcom,sm8150-adsp-pas
@@ -559,6 +563,7 @@ allOf:
             enum:
               - qcom,msm8226-adsp-pil
               - qcom,msm8974-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
-- 
2.37.3

