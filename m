Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510225F8650
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 19:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJHRr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJHRrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:47:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635338478;
        Sat,  8 Oct 2022 10:47:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q9so7170572pgq.8;
        Sat, 08 Oct 2022 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfBCvaY7E4Ui9gV4HQYigVDmblavzm1in13JD65ycxs=;
        b=YILfXzHeBajXuSWM+M+wZ7ghm5VPjw7/rrDEOhRp/QD+4vQN+cSvs+ZaoUzYUGHmW/
         wfUvT9/HkLN48tjPjiW6eP4ngZVPsNB0lBb2BSBBBRYCgntwXZ98jTdcOVvsoDG3mXV9
         l2NiRdymEEfHdKKfso6NFPRxjpd07zCbK/uzTftv3sucitKRdQ+rC6SCCtCzIQFEmm7K
         0H0+SCN8iR2SzOff8JOopKLkme26HvcQALAyl+sjq9W6+ytEMcAzps5h/uxUyfzuyuC5
         V312dnllgD1z0OGnqfF1NMB0q1uCTIhY+TGSCPRyCLani/0MXKPWHmrMC2aSgAz86SaD
         iozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfBCvaY7E4Ui9gV4HQYigVDmblavzm1in13JD65ycxs=;
        b=YEA1HKGSma43SSfQTvohnizSbDf9N8hM+TwKplAhYIsITbBczIkDOE244PQbscgGSC
         eaPmuFO2xipn7J1DhsNwy9fVcL8363nKdTdDEXlESNDMeTrHESktwf3F47lLY6mfOi2T
         zLgbkCR3ctVXRgHuGnPgZZ1ox766dTesAIo+Pum08pBU/k+bVIlEzG3tYo6dOKzOAHnV
         LYJa4xtQvxqxkdICOnLfjfi3WpT4I40by8oULfHEIYdVT5fQcdyTdOGOFxYhhM93TMpl
         bPxuqj3X/cKZB61YaedtEilIBDAWUoThdwqLDFSoyVPqxfRR4LN/vZzsU+Gng3/No4/2
         WN8A==
X-Gm-Message-State: ACrzQf2OWsDxsljpz7OmTwYqp1tkLLVphMa+lM2QlZfcTs1wRiGrbv+O
        19mOiGG1gr+jhvqhyUa1ae4fmP3AzRuMGw==
X-Google-Smtp-Source: AMsMyM7/1LvjuGU4ZitEwEFrVxhQl5mQVgx6dh3hK0uR6NgJz9v7ir0W+P0t3M8oK30haFjjGHetOA==
X-Received: by 2002:aa7:951c:0:b0:562:ca32:3d3f with SMTP id b28-20020aa7951c000000b00562ca323d3fmr7960372pfp.33.1665251238222;
        Sat, 08 Oct 2022 10:47:18 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id o9-20020a170903210900b0017f7d7e95d3sm3583270ple.167.2022.10.08.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 10:47:17 -0700 (PDT)
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
Subject: [PATCH v3 2/2] dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953
Date:   Sat,  8 Oct 2022 23:16:58 +0530
Message-Id: <20221008174658.336470-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221008174658.336470-1-sireeshkodali1@gmail.com>
References: <20221008174658.336470-1-sireeshkodali1@gmail.com>
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
index 3072af5f9d79..9731ccb336f4 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,msm8226-adsp-pil
+      - qcom,msm8953-adsp-pil
       - qcom,msm8974-adsp-pil
       - qcom,msm8996-adsp-pil
       - qcom,msm8996-slpi-pil
@@ -178,6 +179,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
@@ -297,6 +299,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
@@ -369,6 +372,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
               - qcom,sm8150-adsp-pas
@@ -558,6 +562,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
-- 
2.37.3

