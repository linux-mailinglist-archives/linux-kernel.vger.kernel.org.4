Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E96279D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiKNJ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiKNJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:58:37 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D71EC62
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:12 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z24so12438570ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qVJMx0jHh904c1Sa/s3vNdldS3FdGeyYqak18l1YIrE=;
        b=Vna28Ee/6BC+zVaGErcs0iYP4EFY3bgp0ZkCBWZfYxGtURDBc/iVZFfSKk09TYDIX9
         JR/ArGFEmBFSFoNxYXIMHUnGekIUDWFmr7NwEpy6rNHI5W0yr1oUN3DM0wGvcAZ+UL6Q
         FcwAMxBZG1ldM9YZw2EjCGXj9W8N0u6QeqL+2CKATMYOZpum0fn6sfUas1rxpJKdh6ew
         9ZoutH7ERgbJn6ncVb498J6C43j2/vsE/AjcHGSuMTz5ew7u11pAY9bOxfH3IZvIVbEN
         vJyui6D+pUTOO/2apc0ncevmxOF6Fb/AsvMHX3I5kgXx7DnXVZ9lNy3Yrhs5SqMwsZLM
         hcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVJMx0jHh904c1Sa/s3vNdldS3FdGeyYqak18l1YIrE=;
        b=nkeSIFPXetZBDXN7fiJaqhHHV22NV38llXCHRR3HZgFeU5EXdmvLKvokc18D+1F2y3
         pcq17cq2X5FNcM9Hr9n1s9wHJ0Os5sxyPE0iWaFQkzpipreXH2U2eSBOVYYx3ZNJ3CFt
         tH2UlslaWXO/+6AmOo0d6mUl9PrSNJzIVoGYSpfoSpYTpFbPRLO6QHbF3zL5yE66IxYX
         oxZ9hn/hHTHfYxF0LcWrWVZSlG2A04pLeL3owsueuuQIUGeGytadOFdcRygh0rA+U9or
         Y5+a1ekeSx5kTT8uYrw2KWxNrmFSGXanwYCSVl9GRiMeghFAO2XQM4Dp6BXTWGqYs3jJ
         P3ZQ==
X-Gm-Message-State: ANoB5pmKy18Cy1BLP7Tqr3bMrkYT24fpmA7eXn8zVfqqrzlwpHoZV+HO
        sNHK2BYFLIf2Er5g6OxZlDNs0w==
X-Google-Smtp-Source: AA0mqf4YBb2RQtHfJOXcHS4VC/12ESRMNm0fq8gSw0PM3wysKMVorhAjFJuPRdxCz07fGKU3HEF/6w==
X-Received: by 2002:a05:651c:54c:b0:278:f1a5:a361 with SMTP id q12-20020a05651c054c00b00278f1a5a361mr2739330ljp.124.1668419819368;
        Mon, 14 Nov 2022 01:56:59 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id p12-20020a2eb98c000000b00278e7800715sm1832012ljp.16.2022.11.14.01.56.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 01:56:58 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: arm: qcom: Add Xperia 5 IV (PDX224)
Date:   Mon, 14 Nov 2022 10:56:51 +0100
Message-Id: <20221114095654.34561-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

Add a compatible for Sony Xperia 5 IV.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
- pick up a-b

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 97e1d0f07218..ee79a20c4e77 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -810,6 +810,7 @@ properties:
               - qcom,sm8450-hdk
               - qcom,sm8450-qrd
               - sony,pdx223
+              - sony,pdx224
           - const: qcom,sm8450
 
   # Board compatibles go above
-- 
2.38.1

