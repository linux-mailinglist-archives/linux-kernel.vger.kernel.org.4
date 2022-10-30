Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA56129A3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJ3Jnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJ3JnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:43:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33810BE11;
        Sun, 30 Oct 2022 02:43:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w14so12066090wru.8;
        Sun, 30 Oct 2022 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUpdkVpaImdCke90/hvYwepQ6uJUg8seHB9Am7OQuCE=;
        b=YDoaDcvGm5/74XBRKcUtgPnpzebTfHlZ9NG8NTgrAJ2M1ghiBCDB7AGgPG1pAg81Yl
         YOMTtbPi0eJgKr+Rwkih1doM8lSTYuIQ46Jxxwkxt+GH8LUlJaVmrLtXO+zOiDqkl6bG
         DQpgngULw570soTwcEqpYHV4zk8t35OllQP4rsjoVV7UMOaKLUYL22XmXgTHtnngmMO7
         OumsUKl8O1FxL9SvuX67lsSsLh+5wRYpqYaBWQGdS2D3cAnKJYsYhbseGzxg9O8IpY9C
         0C2XkF8bsPqHwgCPCBMUs96kC8PxxFEpwSlhZYqFVDhnpXKqlKefqCmxWBzl5asTl97U
         aJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUpdkVpaImdCke90/hvYwepQ6uJUg8seHB9Am7OQuCE=;
        b=STIlAHXfbh7FRJuFtOCzUeMSL4yvwfACG/bMBLt9omKprXupcObH1hwFb/43H96pD/
         ekHr/oR0wgn/KIoP8jk5ZTti2NigNInyOKsm9mXihpJSRNL1Hw/WXikU03hdn+iE2oyZ
         ZOLONbfqhGGC6F/NZfOcmEB2JFnX1LiYXJXnvuztSb5vKrASzP3exdd5HXP8ecQcTFvQ
         6dYKxwKP/6GcD3kVrERlgoypD3BhlbGmyxMetij8RiK0GmfYHY5ZEwfjjdC8AsvTkFW2
         c8IADQeDEwvwcY22T8LaX04UlleGSTvb8SZx6mzGnxVq+5p5L76ZC4Y0O+YgxeBpv7n3
         7HTg==
X-Gm-Message-State: ACrzQf1/DdeTst2R7kchHbitrkWfU8wcXnThppAK3EWgkKmIwLSWyGW/
        QumbW2C0JyjBTYGN12Y/nPs=
X-Google-Smtp-Source: AMsMyM7heg9wKmi/oOgWiJ/mRAMCVBFekD7edTZFfwYWgxwAdc4pO/kOVbDCqV13pcsJDN0mRiNgfQ==
X-Received: by 2002:adf:b644:0:b0:236:59c7:c6de with SMTP id i4-20020adfb644000000b0023659c7c6demr4463776wre.186.1667122993833;
        Sun, 30 Oct 2022 02:43:13 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm18453039wms.0.2022.10.30.02.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:12 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
Date:   Sun, 30 Oct 2022 11:42:54 +0200
Message-Id: <20221030094258.486428-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Skladowski <a39.skl@gmail.com>

Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
DeviceTree binding.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..71f8f638a1f8 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -41,6 +41,7 @@ properties:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+              - qcom,sm6115-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8150-smmu-500
-- 
2.38.1

