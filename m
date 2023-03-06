Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546DA6AB855
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCFIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCFIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:31:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E869120D33
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:31:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so4657862wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MygDlz1DFXRl4wEV4mR7HeCJcg4hVIJJT1T9suDxRE=;
        b=G9A1SYreNYy4eiByiWuuX5CPdrrN/7Ood1RVhy9g0/BEdPc7Q9IwV18IddlGqylLFN
         NCRtsTF0OMHf4vZR5HnXCK2ssL5Eus2YeYuZyX0beUoGxBXFhkFzl7Z6En+jVXVTTpwB
         xeo1YE/vnB3U83T2ZcdPQrMRdqpgW53DWeA8VdgFj8xeiMeEjTH+oNPUgwilOidR0zGm
         rAmoL2AlXJslBYCND8xjsKuFkuaK1VIeIB2L3JQdtaJxzRIiD2/3YV08I8K+BtTTWgtn
         r/Nxbfx8yEF9+fkvmT6x63d4I76ffKt0vjbIOav9OkhBWA0dqEhBJ5XLvFcJIkYUrTzq
         D0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MygDlz1DFXRl4wEV4mR7HeCJcg4hVIJJT1T9suDxRE=;
        b=5quim1xnDYAUCQTQJpQasA7nsELRX721JyjYo4akPaQMNuHL2/SMjxT4G5RA3u8lPM
         vXNjFVjlYUMuSLPle/bOmMVi66j68q+A+UvmjY9K0dIynrAzJZhSiBKx7T3uZkrxYgLn
         mD8AIqrzHQ+h4BTA4zxuH7Ff924NWogkgL2zBs8vc3O0U33aPtGu89vDOZWLCJzU7b0w
         xFJUPeMeV6KMETksz7RCBamKYI6oKMeZTlIvi1iJ7+Hy3eDxyifE9Ft846w+Tqv79FXn
         fOdCplwOd1Ojw9EJWAXIWB5+PNxsSTmobf/tR2ONjGAa7WM1cCZ7Dy/W8iW9U7jPCP9/
         lKiQ==
X-Gm-Message-State: AO0yUKXsQeeiPIEegHjJOtBh02DPQsaN9lWs+5ixOGwLtCt4pwZd7kFu
        L9g36GA62yVWlbFNwiKs8d6d3Q==
X-Google-Smtp-Source: AK7set9b27ClSjWfMWvCjFqKOd+RFDZvLySSEwdzTBOZar24zuh/03jmPSbSEIfnwYBs8nuR8qnSGw==
X-Received: by 2002:a05:600c:5127:b0:3ea:f01d:2346 with SMTP id o39-20020a05600c512700b003eaf01d2346mr8717456wms.15.1678091500348;
        Mon, 06 Mar 2023 00:31:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003daf7721bb3sm13529724wmb.12.2023.03.06.00.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:31:40 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Mar 2023 09:31:38 +0100
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: Document the boards with
 the BPI-CM4 connected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-amlogic-upstream-bpi-cm4-v2-1-2ecfde76fc4d@linaro.org>
References: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPI-CM4 module with an Amlogic A311D SoC is a module compatible
with the Raspberry Pi CM4 specifications.

Document the boards using this module, by specifying the BananaPi CM4
compatible in addition to the baseboard compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b634d5b04e15..4e5ae70db4cb 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -158,6 +158,14 @@ properties:
           - const: amlogic,a311d
           - const: amlogic,g12b
 
+      - description: Boards using the BPI-CM4 module with Amlogic Meson G12B A311D SoC
+        items:
+          - enum:
+              - bananapi,bpi-cm4io
+          - const: bananapi,bpi-cm4
+          - const: amlogic,a311d
+          - const: amlogic,g12b
+
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:

-- 
2.34.1

