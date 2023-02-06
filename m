Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66668BA37
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBFKa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjBFK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769C6222F9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:29:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bh13-20020a05600c3d0d00b003dff6cd8b7eso3137742wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEBwyInNQj4T9UrPWpH8IzyU0lvHzwvDqekdsT+4wvM=;
        b=L4L6AS/M4laX73nMhmFbcGz0oUWXulfn89UoSfPUSR0y/tS+ETQavNihnHj2+OZugq
         xn/NzTcdwQ/C24dHwWNYqPhxDIUpzIDAO5H6gxhSZBZL/+kd/G5ke7OE9DS56Xgukxmm
         PqFpl/7eCTvBsUcqftw7toIIffx1MtfI2BHrpbOtha89VpIUXEnuCUZxFhKvc7tyYWqt
         tQhtG/3PilfYNfJD0Pqr6ixqptWcVgq51fLrgPtlRBP6EfL/rV5sxXz31tBJ9YYRDqLO
         Kd/dN6MQaHnd/+wSniiwljGZUvnQH5bynronIQFYztziK8iLioBgoVHBNl7CbZj3kgoF
         sOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEBwyInNQj4T9UrPWpH8IzyU0lvHzwvDqekdsT+4wvM=;
        b=6k8JuH47ncW4//9fFra++bYT101/lYGq7GBzJd46sOv4YJZLSN3cesN2NCdX2NCvXt
         98IrfUiyd4AEmIYIiv0SLuX6XrAUGtGaRuD15ff6whRJTbT1zy3fF1FHRo3CfbZIHbQa
         6YuIp2Kwv7Euo40zxNhg/DXcIbsl92LWFCP3xH/SycYsIjP10JdYmCIV/P7j1ZAVw7bW
         xi4VjFaI1xMx+DBR1PX4kHSKGFIw+pteq7CTv8loWrUJTUsTOu/YpUD/UPprLSTd19pX
         EXEafNKyB0qAeWdmfaPofWVLnwJjuEaC0a0MJrJci9sf98oMlkssWTQjtoc9Cq19ggxx
         MrKg==
X-Gm-Message-State: AO0yUKWHOOo436WIivR76YdRjFlOwQqZ0bQWXBtULFkvNQDQZ4xwmqRW
        SxlvKNHZ1KYf2qigzDHL1u/7eDDw92DFiI1B
X-Google-Smtp-Source: AK7set9QrHp2C0rv9Oav2sxb8xHO66PetiI74vqx9rzLr1s8rvkPXEfwFRrWd39AJ0pqzT8rTXuqHw==
X-Received: by 2002:a7b:ce94:0:b0:3dc:43a0:83bb with SMTP id q20-20020a7bce94000000b003dc43a083bbmr19335112wmj.3.1675679338410;
        Mon, 06 Feb 2023 02:28:58 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 36/37] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Date:   Mon,  6 Feb 2023 10:27:58 +0000
Message-Id: <20230206102759.669838-37-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

From: Robert Marko <robimarko@gmail.com>

Document IPQ8074 compatible for QFPROM, its compatible with the generic
QFPROM fallback.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 9ddf3cef9e84..2173fe82317d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq8064-qfprom
+          - qcom,ipq8074-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
-- 
2.25.1

