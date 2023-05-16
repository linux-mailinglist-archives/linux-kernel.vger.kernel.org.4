Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E872A704D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjEPLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEPLyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:54:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9CB619B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:54:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so16092301e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684238047; x=1686830047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/U9AOMWIVpnC8ZJ/nG62G/TxmeU88Cq42ECjWaNDuc=;
        b=xxzf+tcELx3E0yLhL1kMvPFLIC9HxKkT2Dz6mG5MDFEj/jmjFgawVW19wfGBEFzvLY
         /dtS1p2p80akvBQaXa44MvhYXUpLzqRagcWuWz75tXe0fzZBrBmUyJNM7oRW4k3V3Dg7
         bv33zY88jiVdSGIal1dcSoDLQHxCEpCUy9HXb/2lzjT29N3RrPNLFLyNDmE44vpQFIzR
         M6HTlTdK155eFsjZMoQhe6JY4T5bFqgjIZZ0N1k78clJGdvZRhieBQsCEGaWn2H5+p3L
         p8rE6oSZ1f8+Nun8CTg0+RK2qH0g3NemkWTzlAAiOWWBGBSUI1mcmFcNiLh0lNBum4n7
         /7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238047; x=1686830047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/U9AOMWIVpnC8ZJ/nG62G/TxmeU88Cq42ECjWaNDuc=;
        b=VwjLv1U8qTAEuNkGI4mv4UMHQc8m4Zg4IkqiKhwpe3s64VT3LWXFddiamv0Qkuj6/D
         cb5K2c4aPjjZ+kIuErTJGMCm8SGFfiUYkGKc71ZdqEJ4chpL3ONDD0wLcYBGWjcpCJgi
         q6B+1SzKQweNN+HU3d05oUYrgkFM4rZpMHOWFtXTpTjEVVcKUA4JNKZ5HYDyILbftOy2
         3rL5S8l0mVPYGG9kfZuRufHgYDQU1TxkmkMxA4nfPPAdJWqpINHev3iwsjWZ6fqP/Ys9
         34526l1tyaIuT6z0Lw8MouICZfmiH30u8LaqhrG3qhufhFKLfDkYsQOWHnftP8lkdN9+
         sBRg==
X-Gm-Message-State: AC+VfDwiF9KuFn72L97uSAMGhVN159/Hl+wLnxuaj5k5NLS5RuCzMUc3
        T5gXl70Ymi133IHgzmm0dPTE1Q==
X-Google-Smtp-Source: ACHHUZ7al8ZSgMAfnhYMhVtIW3R1XeM4K9+1jw+RmmTpUlYvv6Iej0HkqaAvyKF4li93f6eg81YRVQ==
X-Received: by 2002:ac2:5d26:0:b0:4dd:afd7:8f1 with SMTP id i6-20020ac25d26000000b004ddafd708f1mr6589759lfb.52.1684238047178;
        Tue, 16 May 2023 04:54:07 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512376d00b004f019d3eab4sm2951410lft.23.2023.05.16.04.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 04:54:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 16 May 2023 13:53:59 +0200
Subject: [PATCH RESEND 2/2] dt-bindings: thermal: tsens: Add compatible for
 SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-topic-lost_tsens_bindings-v1-2-99715746ddb1@linaro.org>
References: <20230516-topic-lost_tsens_bindings-v1-0-99715746ddb1@linaro.org>
In-Reply-To: <20230516-topic-lost_tsens_bindings-v1-0-99715746ddb1@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684238042; l=944;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=I+wiNgFNMuppuk+Q4In4BSan/9TRWGs892V/JtEHGx0=;
 b=wy7N//zkdjcEG/NypauPBu9XBdEQ0ByzG+WNhTP55JUZcGBwa7+tfKQ+/VPfUSeWWzOTiEnvE
 azlPvtSZHC4DAcNvhLJZrf6c8HK5EYBGT2QEVoOJ8Tv9EJVBxgyesgq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM6375 platform has two instances of the tsens v2.8.0 block,
add a compatible for these instances.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 2739b2bead7b..d9aa54c11663 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -57,6 +57,7 @@ properties:
               - qcom,sdm845-tsens
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
+              - qcom,sm6375-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens

-- 
2.40.1

