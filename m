Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C15FD3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJME2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJME2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:28:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D312D0F;
        Wed, 12 Oct 2022 21:28:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 128so607612pga.1;
        Wed, 12 Oct 2022 21:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4Yrx0WZ/e/LKeJiOOjo3tMuzAFvM4EVo9Qsuuw69mM=;
        b=ODmqkmxC4WZxYbIBOSN4scr5SxuVe0XceZnfeFlEx3cmb2Uk2TmqrpoLlhk1kFusmS
         mr2LT410i66wZqoc3eGcLU8HSl5QkEHFfe815ZMOpt+WSUUyGwppWUtgfwRV1QMe74za
         Ma4KHrLsUqERuvTrpOw5UPWQ6TKk7/WzSJZOp+HZDdA1PBjyVPbYXyY26+9u5hg6Rq2N
         w+LVY2dvNJhe+51XiOTD8Md68DxYgjeATQz1UKL7rSzGFigyEVv4Bd0YZMsi8xTRlMJV
         lE8/Xcs2YocSGtPN6I8NJKsyznS0Br49nq6mVrM40G/pi8yVsc0Jij9fGhe5/T7iKox5
         paNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4Yrx0WZ/e/LKeJiOOjo3tMuzAFvM4EVo9Qsuuw69mM=;
        b=aQeUERt0yfqL3Ut9g3K34iiSeC9d68rWS6ftfo5n6qozjozttlAZNF+botCjxG2FQs
         LLfCpIysHtt8V13zD7Ymbp0s1wbSyinyCqh+9uDrThrftyDDkpEeX+Fb9MlPWN5o10e1
         ktOFHGelqNNKUz4pBOxYH11xjKxI4bN7lOIbMMjh0XDDBxiLTgulwcpmYBFVHoA8eIo6
         nOLw1wyl9F/hCu4n10F3tevZ29gpuRMlBhTAAdtRNyEVcQ0jwFd8qWuVu93Nje3Qt4Ln
         SJNqPjtNr0oeP5vEP8FPi/RQnr8bAYNGtoK+jg6zYM9UbhGpPbocYKufxI7I1/BQsl3O
         MkIA==
X-Gm-Message-State: ACrzQf2ozt667jS3wkzI/UXLcOmMeHD8B/bPF8vxKA8V/LDArBxt7PTs
        6713u670/E9BsIrVY/IIkBDKI7Toz7f04g==
X-Google-Smtp-Source: AMsMyM4Cou++uNck0Zxh91K9FPzK92ptGgjuHViVaxHDwbAVoKXvQ3WQN0vpjcETyIgmGZi+v2s7RA==
X-Received: by 2002:a63:2a86:0:b0:46a:eaba:f1f3 with SMTP id q128-20020a632a86000000b0046aeabaf1f3mr3857474pgq.79.1665635292633;
        Wed, 12 Oct 2022 21:28:12 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:b6fa:b70b:65a4:a699:40c8])
        by smtp.googlemail.com with ESMTPSA id y9-20020a17090aca8900b001faafa42a9esm2192007pjt.26.2022.10.12.21.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:28:12 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953
Date:   Thu, 13 Oct 2022 09:57:49 +0530
Message-Id: <20221013042749.104668-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013042749.104668-1-sireeshkodali1@gmail.com>
References: <20221013042749.104668-1-sireeshkodali1@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index db9e0f0c2bea..b1127bc0f01a 100644
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
@@ -179,6 +180,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
@@ -298,6 +300,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
@@ -370,6 +373,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
               - qcom,sm8150-adsp-pas
@@ -559,6 +563,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8226-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
-- 
2.38.0

