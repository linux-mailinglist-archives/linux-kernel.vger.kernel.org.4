Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DB61A08C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKDTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKDTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:08:47 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935BD43AD7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:08:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k4so3651894qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6aRuMljk76PLmaPUgSmNl0DWQMBncipv8w24p/Vz98=;
        b=AZsJZY3P15AmRtIMozyqGQDKQtw7pnydVarxTZ4KPe5lRfm09R4eh2v34awbBDmMNx
         1dYFohICv5PLMxoL4D6AMTHkeivxZcWfdsZxCYBdnitUOfIcGHHWHA9GNTDJcSc9EHsF
         o+OXHKBE+e6PYOCNYBA+0isicSaLCVluI3dkC6esFDc0JjRxw09dUeRgSSCNXnhozw76
         8loQcZ/Vz6hSKSJcSLv/h6c90Basldtlgd2V0ctrxv8McWOyIn/pbm40NAnaEBIVZu83
         vS/lKZfhxqR2fyzyEzmG9F77DGxqzUB5ukD5MJrpZY/cfSuvQuT76Th+JTxMm35WdCug
         Y+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6aRuMljk76PLmaPUgSmNl0DWQMBncipv8w24p/Vz98=;
        b=S/O+uD9u5psMQ4yPBo9lX0NwDli4HsWiucEJOQXcJr/zYakmXABwGZgEv4zdXrB7ve
         M6MF2KZcTvrwMGPdTqy5O2vRl29vKcpcbwyRJCgQceitPW139IoYku0GhYaOICQj8XLd
         xoUN8OOImwlmEcmwk+uxfSkrgqbwrAIi+LtjfJoV/XEQkEvVmDo4NVIeAta4ECDIt/DA
         w2OPYIoydAOrZskxHrUem4vvVs/xMDuNeCvpDCb8HLuo6zSbeQYvH7+aqURk/e0Zs9S+
         3stCEdHWUTsl7ZIVJSbafYnfnxrGRN4BJl2Lh5XF2vuu2KT4gqdzcU4gBe1z1A76A5Zc
         TYNQ==
X-Gm-Message-State: ACrzQf2VzUFUl1BWsvijXEn4ilLRRLatKyJXzKU6ricW/GidwgLoaI3X
        w2bHwORY8q9aucWGKhxiQi8aYQ==
X-Google-Smtp-Source: AMsMyM77J0LfhqWME91FhS1PXGMQy8GZy2C7zSPPQal5aNfubgIeWWr0djzJfJSBNRcSeDkKdoJjYw==
X-Received: by 2002:a05:620a:166d:b0:6fa:35db:653 with SMTP id d13-20020a05620a166d00b006fa35db0653mr19529438qko.328.1667588924744;
        Fri, 04 Nov 2022 12:08:44 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id d14-20020ac851ce000000b0035d08c1da35sm63834qtn.45.2022.11.04.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:08:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: sram: qcom,imem: document SDX65
Date:   Fri,  4 Nov 2022 15:08:39 -0400
Message-Id: <20221104190840.134733-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add compatible for SDX65 IMEM.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index e9199190198d..665c06e14f79 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,sdm630-imem
           - qcom,sdm845-imem
           - qcom,sdx55-imem
+          - qcom,sdx65-imem
       - const: syscon
       - const: simple-mfd
 
-- 
2.34.1

