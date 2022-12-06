Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA6B644F27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiLFXBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLFXBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:01:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F884A07D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:01:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v8so22547082edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waK5wVs7Hxj63T++mcTd6rjgYYGu6Rza9RGnKsblQEs=;
        b=ufQh0/mWaHsYxBXJCDwfMBulsKQuXCMPLS3WDIl8W0Ildbwexuf9F4cZtN7yCAzT2z
         RKjcx2uPlNoncma1YGj9FQy4QZAZS1568bVX9DmcC+WGdCaivpFBL1Q5aSec82ihBRdM
         vmHEpg+P5H+MtL6butSvqzFVR8rVqQaaiywu5TpHsgJdlDokhCD4CLOd+q20oCrznr5R
         tJjRQKWqpzPPAkNAZPmVMC3YayY+IybKBAprjbpl40+DW5uaXTVF2TrK2sqmorLyDaeK
         Pc7n+QpsWQqp/7YK7yGp4D+UOOaDTEXhvn/AAblA00iPseFTAxE3eqdbdIlvDUMr1xkX
         3smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waK5wVs7Hxj63T++mcTd6rjgYYGu6Rza9RGnKsblQEs=;
        b=rb98ykeEW+oYBofD1imV1KX7VJGnw+FjoGZ04jM11ICi/lk1qJa+y3YaQYYS0fgUQ7
         w0poa5ClpY4KIjLZUBi1CL6cde3b+4pxvL4nP+/S5WRuizrCPQI1ycuWVUyCVRsKyV3f
         G0F9sEsSnZiqMwsomTwK30UHu6834zKEpcM04dJfiKSqQ+OwR6TmGjx0HAPIBCGB6rJH
         lrO3XVvxaQSbE2Gl8agXOXvXblbtmCFgGPz/UVQu3Jyr44qO/RWsg+L+CDvVRhmbrPR8
         1ZcFGyNfATLc93jrPtKXB3vGKA5vWpaNdIbX6QsWWx3Tu8kkrzSi6VbIm/PeP+q+USHO
         JW4g==
X-Gm-Message-State: ANoB5pk76/QcAh+X2SMjxj3OXaJE42Q0Udktp66TvGGARbtumanATZyc
        97rmKyCXAn3ZZZB7QzVGxNgyGw==
X-Google-Smtp-Source: AA0mqf5R9i6ENdFv1Ioh56/i62ePYfVdnBW+kU19DGH2ISKGhfdDErP+akV9DB6j8vUZr0GqDevk0A==
X-Received: by 2002:aa7:c94a:0:b0:46b:74e1:872c with SMTP id h10-20020aa7c94a000000b0046b74e1872cmr31454706edt.301.1670367666724;
        Tue, 06 Dec 2022 15:01:06 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906838a00b007c0dacbe00bsm4239320ejx.115.2022.12.06.15.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:01:06 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 01/10] dt-bindings: arm: qcom: Document SM8550 SoC and boards
Date:   Wed,  7 Dec 2022 01:00:53 +0200
Message-Id: <20221206230102.1521053-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206230102.1521053-1-abel.vesa@linaro.org>
References: <20221206230102.1521053-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8550 SoC binding and the MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..4f0aa06402bf 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -68,6 +68,7 @@ description: |
         sm8250
         sm8350
         sm8450
+        sm8550
 
   The 'board' element must be one of the following strings:
 
@@ -819,6 +820,11 @@ properties:
               - sony,pdx223
           - const: qcom,sm8450
 
+      - items:
+          - enum:
+              - qcom,sm8550-mtp
+          - const: qcom,sm8550
+
   # Board compatibles go above
 
   qcom,msm-id:
-- 
2.34.1

