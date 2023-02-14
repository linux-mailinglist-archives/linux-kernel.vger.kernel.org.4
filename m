Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB2695EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjBNJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBNJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:14:33 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3423C4F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:12:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so38318151ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpI7lJpz9IKYSko58dc/btZymelWFdQOcnxveP1xg7I=;
        b=dD2jB4Fsd3SIPlFoFZzG7Y0uZBgUHbB3eiCoJslbjVc9DBX313snP6H9+VUyfuPAdh
         DgIIJBQ6iTIwRdnGynm1bNLubaYb1EV98zHn8Ywg5XK1oFG5ASNAXy3FWl1aLGpfSi6H
         lJ0x5GZBga78HX2l7twvr9oMIYPtbqnn4NbFRbuHWuYRTFv9eROSagd70iCAGprWDkfx
         wJ8ydsLdSXuZdgnTu9vfj+dLPZs+UtuEaMAc1t8OoyvoFlVecXrMxaZW/t23Aq1nRmYO
         hIeF2qMqOUuWztPv+noflahkOflT1p+pRj9zI23zGIS24MNGitPxOVklNQY4TbxnKhye
         YgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpI7lJpz9IKYSko58dc/btZymelWFdQOcnxveP1xg7I=;
        b=vHDXWxmEVJrQ0ba9WWLyiixg1A0w/6gecP5pndrUhfuTG9KAFKt2xVaFi6yrSgviJ7
         G7T4qEPCahbP66HtHys77cIAiYjyFeI9epiKjRSYMVWgZm6CDZ2Toq2m7Z7dkgWSsLA8
         HgElHXSddzJgHze/eeTqSUCJ+XofaQ6C8sxDpvGE13SvbZ458ldSxXbQvPjiBafXjoV3
         61Pb95KX+5Cu0oEZp1f2JxlehpwcZbHxyhKAVdxULCVdd8SSzxt6EiiU9+JkPg2YAWza
         gh2kLtFTTlzjWJPY4v7IPKgjCYgZGWOCmYJ2EuXRriO4B7SUGzK8QLzmZUXphceWRMuE
         9v5Q==
X-Gm-Message-State: AO0yUKWlt7XNe3skiWs2xqpj+mRvCgy3zdcrz+br0en0wJZRaOVoJcR9
        PFNXm3Na0S9I5uqF4kaDDP3wPA==
X-Google-Smtp-Source: AK7set+te8laFy8cWhZo7mQQMHGl64Fub1y53xPaJoVyUEJtB9MBk7YBkP8AFinVGRa6+PskmqlovA==
X-Received: by 2002:a17:907:7210:b0:8b1:2998:6474 with SMTP id dr16-20020a170907721000b008b129986474mr3134749ejc.16.1676365925662;
        Tue, 14 Feb 2023 01:12:05 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906c00600b008b0fbcf4b11sm3677282ejz.66.2023.02.14.01.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:12:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: PCI: qcom: Fix msm8998-specific compatible
Date:   Tue, 14 Feb 2023 10:12:02 +0100
Message-Id: <20230214091202.2187321-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit mentioned in the fixes tag, everything went well except
the fallback and the specific compatible got swapped and the 8998 DTSI
began failing the dtbs check. Fix it.

Fixes: f86fe08ef00f ("dt-bindings: PCI: qcom: Add MSM8998 specific compatible")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 - > v2:

- Use the correct commit in fixes

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 872817d6d2bd..fb32c43dd12d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -39,8 +39,8 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
       - items:
-          - const: qcom,pcie-msm8996
           - const: qcom,pcie-msm8998
+          - const: qcom,pcie-msm8996
 
   reg:
     minItems: 4
-- 
2.39.1

