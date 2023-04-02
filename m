Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DEA6D36F5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDBKId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjDBKIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:08:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1AF265A4
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:07:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 185so4664942pgc.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680430066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScrPtwLifF81mLBCSzco8cbRfT+aGGc+R4ZbxOTPL28=;
        b=xgu8DjvZsG1vIfCnPmIyi1d1f1dEnXwIxVUnJ+R1sAT2Y9/CdCohp8mwakGRuJWxCW
         Pzo3C+382VCOMTsjrqfpyFBEXi0gwVgS63ibE3kM7Ga2OaMGJOZdoZ1y96Pipq0CMCcJ
         PvfGHkfY17g/iQt2p5CfUtKQfSjrYcauqc5hlOmQVeeJ4GHpF7Goxmp0bKEWPE10gF5m
         acHHOhse70AqeKG1te191ex8uSQ93ZPfT+yMXZIXUvIVLEx+4UOhRoqjdWAQlzI+CPkk
         1s7F3aRmeyBRKj5lOgCPVeM0CXnjjlcShABXDw1ENtP94d6d3vBZyOqb40AXMAyMMNuy
         w4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScrPtwLifF81mLBCSzco8cbRfT+aGGc+R4ZbxOTPL28=;
        b=Afjr0aOG6phZrovHRhJLLnOUl9QodNhBZkFEYcjv11TRtQQSuoDw8PwBaseWHwdziY
         TrillJV3QsZE2X041/GsVExrw00yupvoZkRbAVSuV2451y47uSk2oPtevbl1Ro/QTCZa
         iMCDkSAJYsgT5wsdnjOmtKZHNEPPH8StaCy+Igaur48LsdwEp0L5s/cn9c9UtGND/X7g
         bb3M996FL3mvH8R1hRxZ56cqKcPIhpYDjhJ9oqwgm/6wwLzYzAP5tvVqQhxnW2oQu3XM
         HTW3/1dmpyKBZG/ycWtCoVREtk9HaELm5JRwn9+/WfpREi6ZnkbWV8bLvbavFIxXi/ko
         Kaww==
X-Gm-Message-State: AAQBX9cftfGOWVc+qysrgyTbbabHyQVdRe3o+88zGhabERRga6H/nKs/
        8BrkU+CXMoP/dxRjVOqDQXh5Rw==
X-Google-Smtp-Source: AKy350bE8U9vbqH+ow3+PWsevkiaCi1uYp8UZh1ap078kAA+wHtCuycGeEFGfcgAXqx1peBrXMn2oA==
X-Received: by 2002:a62:18d5:0:b0:625:ff85:21ec with SMTP id 204-20020a6218d5000000b00625ff8521ecmr32686433pfy.26.1680430066539;
        Sun, 02 Apr 2023 03:07:46 -0700 (PDT)
Received: from localhost.localdomain ([223.233.66.184])
        by smtp.gmail.com with ESMTPSA id a26-20020a62bd1a000000b0062dba4e4706sm4788739pff.191.2023.04.02.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 03:07:46 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v5 06/11] dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290
Date:   Sun,  2 Apr 2023 15:35:04 +0530
Message-Id: <20230402100509.1154220-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto Engine block on Qualcomm SoCs SM6115 and QCM2290
do not require clocks strictly, so add compatibles for these
SoCs, indicating that they are similar to the flavour
found on SM8150.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 90ddf98a6df9..82ea97568008 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -41,6 +41,8 @@ properties:
 
       - items:
           - enum:
+              - qcom,qcm2290-qce
+              - qcom,sm6115-qce
               - qcom,sm8250-qce
               - qcom,sm8350-qce
               - qcom,sm8450-qce
-- 
2.38.1

