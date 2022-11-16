Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1BF62B773
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiKPKOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKPKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:14:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B00B4B7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:13:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so24370532wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rkHRZPLMXnDDtmeNeo0KQmmMvPEMQ/+5F/WBXa1gt4=;
        b=DotRMWs4p7FKev5sCkvulGty+CU8qE0gMqnQFUyW7bTTfZShyzTeOQcAdOBBV6YMTg
         JpFVW0PM5Xw38HwWBzIwzbxxWstEgPzE3S66P/6zgfb71eEsmZIyv1WxuE1nMLXaLgyn
         usWIqu3Hoy5n67Cl5Pel/XhYTv2wy8gqyn9Ud+HL3nEWs+WgARkvrBV4EXsg0sAMXD/T
         fn64J5GRv9wcGtDqPbick6g0DtwV3c7XvNwNqR7hda6EjgXZmsNJxZZS+92J93RKpxqB
         zfan15Q4WrSQCc4E/cbM/0S7VfOdM3C0eneZ2K6sx7/UU97Ns8n95c8etwWer0my3/Gw
         i6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rkHRZPLMXnDDtmeNeo0KQmmMvPEMQ/+5F/WBXa1gt4=;
        b=UHRQO1xbiUN+zRag3p9Pl7H/tYqVrV05Q55DH3vHNJ+MP6v0IyawHK0ed1/yX2ej1N
         /HWvYDuvn9Or22IJF719WWZJZ3Tl0Kupeu79XjA7wJ2F13yb0QCPqOy6klxm2YPzKtQd
         azHUanNgmeMS5JYAHmvXHN42CJT2roxxICEAZqVJG/PvNrHOsQRFWJbWcxsVizwDbDPr
         PEMrz7aIhZpqwAT9aLgnX/iFg+HJvIKf/mjMOs/c8GGqMHB38m7v0LvkhtI/pEhpacUy
         33XJyLGUxMfvy/3MPGGKMu7TWOfR4D1p3Pzch0xTJPdk26vesQzkp/CJ1xH6W5Rue3tq
         wePg==
X-Gm-Message-State: ANoB5pnmyRBC4/cBh7OnsbyPO2wUNMloMz26CNAzOQCiVLLzmXWq7NuM
        X4HwFmVmzHB5+amu0pCMp0KYaA==
X-Google-Smtp-Source: AA0mqf47YRdnCOsxriuyFnTZ6lAYXb8/75HOCB7obr/rNmN3FZmVvDr3XDA4hoh92Dt086MhlRjvHQ==
X-Received: by 2002:a5d:484f:0:b0:236:e629:adab with SMTP id n15-20020a5d484f000000b00236e629adabmr13896879wrs.621.1668593612727;
        Wed, 16 Nov 2022 02:13:32 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003cff309807esm1426309wmo.23.2022.11.16.02.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:13:32 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:13:27 +0100
Subject: [PATCH] dt-bindings: dma: qcom: gpi: add compatible for sm8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-gpi-v1-0-33b28a227c5d@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8550 uses GPI DMA for its GENI interface. Add a compatible
string for it in the documentation by using the SM6350 as fallback.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index e7ba1c47a88e..99c224836bfd 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
+              - qcom,sm8550-gpi-dma
           - const: qcom,sm6350-gpi-dma
       - items:
           - enum:

---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-gpi-59edc9c3bbef

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
