Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953567E2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjA0LSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjA0LRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:17:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D3A59CA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m7so4652756wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcQCOTgzaeE74ZCuxo4/3CNeOTAuJvVOxPA2T7IDx74=;
        b=SKvsZzmdaghpxygEouhG8N98RssGxSsu0eDO3I/lv3ON+Of+PsyJ1BHGuF4Y+kk4xk
         qStGLzevngbOatsm2tEzAOyb8FZdB9adz3YZhi6TfVBCDEy1xxL0yVq6gCJBrTKQnN/z
         3+6iYGwNqWd1ttmxLKk/VffzfR7Xtqx5Lj2EEuEkLedlv30P52cVC2QZFG4IBSo6MNd0
         OMZQDouWIuJXcnuus+vElDXWjGD9e0mrF5dso0wYSBNsfC+YVmsC+v6/tChHQ4lYiEcO
         VowcGBwOPkOAM0U/pFt1mzb0lziEDAUK1YORA5/K8Jgv8RH+fmIHkeWrK64yDkcwcE7F
         WKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcQCOTgzaeE74ZCuxo4/3CNeOTAuJvVOxPA2T7IDx74=;
        b=PsKjzgkbmSqS84M0JjempID8lyeF/v/qJNaQX7aZh1Y3gEo0MAVc220ZEjbSlhfiTJ
         kBiWjuYvmhGCi/ibo5yxcGUhDUPXhoSHuumWlAQQ6/sfPEZYF5RCcWQhvUE3O+lX2tM/
         TfG/Ged9j/z6+sipQWmFxCFG1P3KzKCSSTUJLOc8NKlrfDrXlbKEHcOdLLPbYeW8aW2V
         v4VnFeEV43nOgX5NnjVG/tj3Zd0R50Xpd7VdyFfeo9o01iMYpS5QQRkpIQI8DCM4etTI
         xIcw3PMMkptvCDkKH3MER0Pb+cWbiFhOjntZY6PBtl8xhNELC5U9nwhZjLMasZTxdB1i
         15XQ==
X-Gm-Message-State: AO0yUKWNkCenpd/S8h2q85Z+hYV6arDayK7IvcOFVi492qcBUi8+BOvy
        3wdur/M4peP70BIf6uJsSaYARA==
X-Google-Smtp-Source: AK7set+pNN5wERN2lyAO5mm97bqpAECDVNdPpQzfrZCusqSgPfTCVBSarSB7hfcaVpMw9kQ/oUC8xQ==
X-Received: by 2002:adf:a1dc:0:b0:2bf:b4ca:6bac with SMTP id v28-20020adfa1dc000000b002bfb4ca6bacmr9235874wrv.59.1674818269102;
        Fri, 27 Jan 2023 03:17:49 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/37] dt-bindings: nvmem: Add compatible for SM8250
Date:   Fri, 27 Jan 2023 11:15:34 +0000
Message-Id: <20230127111605.25958-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM8250.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index a248033026b1..9ddf3cef9e84 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
           - qcom,sm8150-qfprom
+          - qcom,sm8250-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1

