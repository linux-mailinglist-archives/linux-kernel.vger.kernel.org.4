Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C15704D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjEPLyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjEPLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:54:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA54227
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:54:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so16267049e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684238046; x=1686830046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4K3CH/1vJ9KNgYJ9PEN+X95Gm9AuLH2bdq9tCL3unk=;
        b=lLLhHCndIxdAgICsPid/XNk0Z16EchB1a7kXH1ar+Cgqed0jRBoZaT09DEBr7/gYw5
         3QSygt9lSZ2JJS+4tdk/277ryuUME4mDREIy2sPHmboyE4qnnQzvpezPXAqx7M5bLpuJ
         is4FHMyt6KX8w677vx3prUQNNcCNQryjmvAWOY6JeNWkQkZboqVdJQt+TQ4+FYCRrQPw
         TT1Gq7Sd+7F3XOz9EHqV5E4JaR6aZHM3UVRkZ4qhiYr7JnLZ0TDw7o4nucYLTdvt/V/B
         XXLQSNeo8IMEWusWaOpFWTfHYYf3xq2ODzgJJGPOnEyOIDDPW6YPaE+nlMNqVuVrmCmW
         woqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238046; x=1686830046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4K3CH/1vJ9KNgYJ9PEN+X95Gm9AuLH2bdq9tCL3unk=;
        b=VRX+wdUazH+v+bFKaOiymNpH8VnxHjIEWgozSlxGNI7UiRsWA8+uawV44d0lrjdUNR
         2AH56LFfsnb0fmQmgOO7MDcggkCLwltAny45ci/32TWY8zTGOlseoYUqUdBLtc3tEjQt
         76CRsmD0xLq4picgYngJagRheIqkWpjieSZWAx2+9uLiJgZXwF/5dwwgTPZ2n40ym+MX
         DrzkmzffsVyh7lrcYE/C93DhOcUH8bKQ8RNglkfXkd8xYFuNttxzyciUhRgC/LhNhNSd
         /jQ2eo4JYhD+KMQREi51PvpKBZzBFqgrgsQhnhiTHrkwFjRXUwTezh1TgeX86l1D7eA6
         qQBw==
X-Gm-Message-State: AC+VfDxQLLPZe0LvyEShJ8pDzWvn3A+bOgjO4A8+/mKWUqV42XxtVB83
        SpZuXRE1/h94Mg4NuABoru/UWg==
X-Google-Smtp-Source: ACHHUZ54u8l4UZsNP3nCDNhTiMMbhriFzcM4zqEi5xcL57rKQgcTNnjcNVr+fD9GV1Ahxgkbzs0zYA==
X-Received: by 2002:ac2:596d:0:b0:4f2:4d0a:7bde with SMTP id h13-20020ac2596d000000b004f24d0a7bdemr8272982lfp.31.1684238045772;
        Tue, 16 May 2023 04:54:05 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512376d00b004f019d3eab4sm2951410lft.23.2023.05.16.04.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 04:54:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 16 May 2023 13:53:58 +0200
Subject: [PATCH RESEND 1/2] dt-bindings: thermal: tsens: Add QCM2290
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-topic-lost_tsens_bindings-v1-1-99715746ddb1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684238042; l=884;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jPn3FE/8cWbRTHr4Rj1r5JmP5mGi9dmKyVD+7SHddfk=;
 b=Q02RBTPrXnWy76L9CdVyIZ5I+eSmN1hGMHNCZ3Siy1q/OI703NZicBqfGQcX1aSNx/CCIjiLH
 mR8kzzeFu/GAS18L8hV0qAwrlcnqpWC1t19kDCqVMRU0wrHTKv1XBCO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TSENS v2.x controller found on QCM2290.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d1ec963a6834..2739b2bead7b 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
+              - qcom,qcm2290-tsens
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
               - qcom,sc8180x-tsens

-- 
2.40.1

