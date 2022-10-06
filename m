Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB85F693D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiJFOJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiJFOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A80BB0B0F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r14so2903179lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=blLQTq9+j5uZEra8Ae2S+s/ZwBy3OJUhQEovum2+Jvs=;
        b=YNRusYNjnZEAuX/4uiqgIY37FwQlxOqEteeE//bDeiyVlSot4ItQDqv3NUx1CV19ej
         wSNuFr/PxbnV51NLFvDwEhlayVE+AZR0Ye3ewVq92HRcBg+T+zSKiRIdHXD2KMkfQL8+
         uCwA4Ve99kXlqoP1UKa2Fz4L2hxRdKMf2CwDmCMh8l3KVUAxARJKulpI3DteSFo4X8wK
         ad86xBm8All//xPX/ZuhxyKpcr2Q9XoLNnKOUB43l2r3y5Bg6NMB0a4yAnEhqsSlU+uF
         ikzMGtsXvUhlQ5NBX0pdj0RQeN6ATQpW7J9aYL8T38Df4qrbd8apowwNFwTShKKOFzoi
         E0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=blLQTq9+j5uZEra8Ae2S+s/ZwBy3OJUhQEovum2+Jvs=;
        b=mHOCHARSpbHidKXjMQzZzl6pheKdFMEGFUejb5zJh2KrrXqr7MHZoczYPjRW1Rf++e
         Y9TPIyIbS664BPxN0QubhD7H4m0fxIj6bRngyq24kqYSAo4Bht9MTg6MTdy62wg0enXq
         fOxXb0digdC6TniVEHMjNxAkXtIboiNME++VGKx0Jef/CIi0cAOR6ESAydCF1pH2Blre
         BbUN7lCaP6V68BPtGn0Rh5xsv6UFMq88TdeTPikZP7goyreG6BNn8gfRX0+ugYe7WAkO
         Nk7iojX+ZnYE/L9Z7AunnD1vIYKmJDVTe8SaIZSINfMj4/3Xrg1POlAzmf6YNw7oNFbB
         0D3w==
X-Gm-Message-State: ACrzQf27b4xBa01uIuE/p8XBoJCmhdGSZ90RaLMIIzUwAAE2+Z93XGai
        gKsbIFUxVZzCkVKHbPiCStLbmQ==
X-Google-Smtp-Source: AMsMyM7bdRXNWW0fAI+5WtMnIi4d25Zq5+oJOA3VBjSRwCmmdxg87/wyiHJz55CMsrD+9NJJIejFYw==
X-Received: by 2002:a05:6512:1694:b0:48a:9d45:763f with SMTP id bu20-20020a056512169400b0048a9d45763fmr48967lfb.662.1665065243518;
        Thu, 06 Oct 2022 07:07:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 31/34] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:34 +0200
Message-Id: <20221006140637.246665-32-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), drop redundant minItems, use double quotes
consistently and drop redundant quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml   | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
index 290ba2375e92..bd45faa3f078 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
@@ -4,22 +4,20 @@
 $id: http://devicetree.org/schemas/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
-  Low Power Island (LPI) TLMM block
+title: Qualcomm SM8250 SoC LPASS LPI TLMM
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  LPASS LPI IP on most Qualcomm SoCs
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SM8250 SoC.
 
 properties:
   compatible:
     const: qcom,sm8250-lpass-lpi-pinctrl
 
   reg:
-    minItems: 2
     maxItems: 2
 
   clocks:
@@ -34,7 +32,7 @@ properties:
 
   gpio-controller: true
 
-  '#gpio-cells':
+  "#gpio-cells":
     description: Specifying the pin number and flags, as defined in
       include/dt-bindings/gpio/gpio.h
     const: 2
@@ -110,7 +108,7 @@ $defs:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
@@ -118,7 +116,7 @@ required:
   - clocks
   - clock-names
   - gpio-controller
-  - '#gpio-cells'
+  - "#gpio-cells"
   - gpio-ranges
 
 additionalProperties: false
-- 
2.34.1

