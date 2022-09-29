Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE65EED7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiI2GFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiI2GEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:04:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E981C624B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:04:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a80so554046pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6knmM+Buy29rS1AT6V8hgyb87xZ8MvaVTgXHXkiFVM0=;
        b=yed+LiwzAA7lrOIeUZi+Wc+Y71agNniKS+flzcmgdh/3B8qXjqc46CKju5GSpRD185
         h5DJVx//k1xikxT+Ya2hVF+Lxmwj+/i4xX6BrXPdP61E92OpJwv62oxoa8w2dVuXMla4
         vi/7f9LRrLuz6rd1JlnA/7pR1nEbOemi3fZSzIISQFW/62YouyaLG5o0kSqpZL786hD1
         lg/nqxzhyR3ts1vrROf11JDDePU3jqaQixURQ3r/A5cfOpvzS6/HrPqVo+OsFCOLPU4F
         2kNtBv3hbs9bcizRu0lKwd1mCjL1dmPkGvR598t4NDacAmGVYDampctcdSfJx/f8Ivik
         DT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6knmM+Buy29rS1AT6V8hgyb87xZ8MvaVTgXHXkiFVM0=;
        b=NO9KigOxWoXPEMmt2w3Kjsi+ncORj0oXE9m3T9XuR2SHZESAohRYI9CLc1vyNQITV4
         Y1bIQrVnPEnpwfcQbHwQRTKRTp+XUBIDATXC4/yHTZZs6qwCBz7n51pXTK308wkobURu
         UY96SMICvlHqC3qLRVoYmbqkKOkcipZ2IcBk4hShdO9e77a3U9JxdOXJTBpA1Ku135i0
         zn1XNfmJ6XyU848NiBXcd3xHVxC6c5bRD3iqVzxwUzfWYeNOhLOeBOp/3aoTl6RL1ghg
         RbZ37GGlT/6XqeWlzq0E+SgslcQJA4pdRZ8k1anY0eqC4lbPdX2BqwSQMGnJPjTkjGqK
         B+OA==
X-Gm-Message-State: ACrzQf1LB4fgPcqTBsASJzBgkjMqSKncBhzhU2DAWIUAOeiaFwO5Mdq5
        n/euhYydz7zzR07VS4TOxvXRZQ==
X-Google-Smtp-Source: AMsMyM7GsEATtJtjHkk2nfWhsRlHkTfp9IQdiIIVMegzlTtaq/GS4W1DeBoUEDKj1Ix2qr12IPO+VA==
X-Received: by 2002:a65:604d:0:b0:43c:9d8c:813a with SMTP id a13-20020a65604d000000b0043c9d8c813amr1521105pgp.572.1664431490293;
        Wed, 28 Sep 2022 23:04:50 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:3adb:24f8:ac24:2282:1dc7])
        by smtp.gmail.com with ESMTPSA id i1-20020aa796e1000000b00540c3b6f32fsm5037681pfq.49.2022.09.28.23.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 23:04:49 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: [PATCH v2 1/4] dt-bindings: net: snps,dwmac: Update interrupt-names
Date:   Thu, 29 Sep 2022 11:34:02 +0530
Message-Id: <20220929060405.2445745-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929060405.2445745-1-bhupesh.sharma@linaro.org>
References: <20220929060405.2445745-1-bhupesh.sharma@linaro.org>
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

As commit fc191af1bb0d ("net: stmmac: platform: Fix misleading
interrupt error msg") noted, not every stmmac based platform
makes use of the 'eth_wake_irq' or 'eth_lpi' interrupts.

So, update the 'interrupt-names' inside 'snps,dwmac' YAML
bindings to reflect the same.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2d4e7c7c230a..37f2ed3194de 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -105,8 +105,8 @@ properties:
     minItems: 1
     items:
       - const: macirq
-      - const: eth_wake_irq
-      - const: eth_lpi
+      - enum: [eth_wake_irq, eth_lpi]
+      - enum: [eth_wake_irq, eth_lpi]
 
   clocks:
     minItems: 1
-- 
2.37.1

