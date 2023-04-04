Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2986D6A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjDDRYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbjDDRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445D5BAE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i5so133795654eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH+IwbdMeiK6l0tr4Mgf/hkCwwTlXl2IJ4KAuxQWnfU=;
        b=i3IBjuYHfo2XZaNohQQUqRmBp1wDGl9irS+0Dhv55ZFmuQie5qz3RNY9oHdH0rBqEW
         2ZX+ELO9qhV6ANn9dtN3PMzqINch1B37MWn5dNghVB1l98gkWLDqCIlqpt8V0yd/zH4y
         LPHLiCMAAchGvmPO8w55eL2OM7Sa/PXzrfHqPK0wI2ii6/1wtfJpDa1GtQEokSX45ADh
         ETxZR74jOMm/DCPehP5gTZvfSWn+Ass1bo/3xHkjuAF/mykOHF06oY/HEsYkxhQRBbNH
         DARtKO+9vUIyEOO+Inl6Lc1+f6TjeYJICHs4aE765/QqHG9w24BdI05YLqhiZNYQ3wo8
         4qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH+IwbdMeiK6l0tr4Mgf/hkCwwTlXl2IJ4KAuxQWnfU=;
        b=jZ/KrvsHXVUq1pQtprlBLqCxIw9IHP+JvJq7XSGxnjL2hoQCNFA/sXz4CzIveJa7eX
         +0bjJMP+M8XUkIdUXBOO+W7pmdZ6jw4H3xDovDuHAuh/RaRZeICJ4V6RMEBZMYr/XW1d
         VhFwkkOGndWBix3AmQizIVtxO2ec0QQWArQxnTHY/kUp61LDovOgGw4vBdR1YMHOmZR1
         mSW/fktZqpPfyhi+VIXlYDZ3TzyiJ45tLNAxAM1Tkpi+bpxM3b+ozv7Uvywg4GmObe72
         oro57C4kqHcUNXZPXE0gvZZhTOWwmaurAXiW7CquIVLik6uspqvbdUM2kSzxcvOoYUSz
         nvRw==
X-Gm-Message-State: AAQBX9cS9OYq/gou1WHPq5InWnRMKzO9m7O4Fl3enwZgbqKQeGXWAsKA
        v3jX4/VzRQy/4DqDAgy+7p5SVg==
X-Google-Smtp-Source: AKy350YTqAZFwLaxRAxkHcZIpncnWCXM5q16ZHwRS34Gvr3e2bUZxTU5aJmlrYDJqfrV67nofoYNQQ==
X-Received: by 2002:a17:906:a846:b0:922:cb10:ad06 with SMTP id dx6-20020a170906a84600b00922cb10ad06mr350530ejb.43.1680628983452;
        Tue, 04 Apr 2023 10:23:03 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 29/40] dt-bindings: nvmem: Add compatible for SM6375
Date:   Tue,  4 Apr 2023 18:21:37 +0100
Message-Id: <20230404172148.82422-30-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index c20bd9bdcea4..8d8503dd934b 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -33,6 +33,7 @@ properties:
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
           - qcom,sm6350-qfprom
+          - qcom,sm6375-qfprom
           - qcom,sm8150-qfprom
           - qcom,sm8250-qfprom
       - const: qcom,qfprom
-- 
2.25.1

