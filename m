Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A2690AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjBINmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjBINl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:41:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238BF2705
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:41:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so3881609wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwVQYGDJxIHxSzhFFyXo6DVH/Gg58TP+SeHZlEpYtaE=;
        b=G8dQmklTOh+/FvxQUB0Gk5udClxwmsyEKDn7Rp2hrIpRgrY/EeEEmKKoam3xtYneHC
         wfJPDL5CBU87tibavUNzoPSTcJ2Qk9IegXRWalEqNxsXdz33oTSKFA5qiQYh9SJVmGFQ
         gsDwoumaVa2S543zVbMQcsIOwaB6bwsHXYRUvyH3rhjRepG4FYbRmRnPAT71wJKyH0WV
         qV7LBhGK5ouyZUTngAaoXEruf/qZgT+m+YACGoBzOj4im80IXnMvY3AojsAlF3ErNqVA
         culMEdkUa4YT9uGHDzZ111BX2gho2+jhjJbkJyZTN6m2gJS7BuSUwnSDQCvUf/VWQgyf
         WrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwVQYGDJxIHxSzhFFyXo6DVH/Gg58TP+SeHZlEpYtaE=;
        b=ndZwu6+aJ3LAOushDJgOAE7FnfoxyI205OUt0pz3ePF1wvqMmoGOkMQPSWUCsRr470
         RJve+vS2msSbTCOWiZ7jitp4Wt7A7TFxeO4/2OQMwyrQWfjd3zHHjg2D3hDdiI3Ms2UQ
         qmG0pLIVCuxM0I9iZvlvbfTW742IzGUDWyZK+KJqVv+vxrjvHxpErGRbHvbSG+CiHm+O
         yETeLz/GyZhSJcqK1ujQdUUyeSEqRWZjpLFkVRtfrCdYTCA3Tdh7CFmPQnYAvFwNrgzX
         h7PercHSXbyqZWDs5IiRtyq2bwMatSYQmPs2FJYsBq73AXwOvnoDQOUcxdpTc0UolsPN
         dhOA==
X-Gm-Message-State: AO0yUKVTLywbhc49z1al4ghJ5/qdAwnjE1mo1egFg8N9k5+43UVPpbjS
        GfUG0VrCS4qEUDWwZ9QirdVQog==
X-Google-Smtp-Source: AK7set+E0AI0A+CBa5LewIRNFwdZw77cSx29mVZd6Uam4cfv7UMTtK6R4/ZdsEbQkl5Go57ylXr77g==
X-Received: by 2002:a05:600c:4b1d:b0:3de:3ee3:4f6f with SMTP id i29-20020a05600c4b1d00b003de3ee34f6fmr10371624wmp.8.1675950105625;
        Thu, 09 Feb 2023 05:41:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm4946991wmi.18.2023.02.09.05.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:41:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Feb 2023 14:41:42 +0100
Subject: [PATCH 6/6] dt-bindings: soc: amlogic: update sysctrl
 clock-controller subnode type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230209-b4-amlogic-bindings-convert-take2-v1-6-c4fe9049def9@linaro.org>
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the clock controllers are now documented define the right ref
for the clock-controller subnodes and fill up the example node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml         | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index 672eabd90c09..57eae355f1b9 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -43,6 +43,10 @@ allOf:
             - amlogic,meson-gx-hhi-sysctrl
             - amlogic,meson-axg-hhi-sysctrl
     then:
+      properties:
+        clock-controller:
+          $ref: /schemas/clock/amlogic,gxbb-clkc.yaml#
+
       required:
         - power-controller
 
@@ -53,6 +57,10 @@ allOf:
             - amlogic,meson-gx-ao-sysctrl
             - amlogic,meson-axg-ao-sysctrl
     then:
+      properties:
+        clock-controller:
+          $ref: /schemas/clock/amlogic,gxbb-aoclkc.yaml#
+
       required:
         - pinctrl
 
@@ -81,7 +89,12 @@ examples:
         compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
         reg = <0 0x400>;
 
-        clock-controller { };
+        clock-controller {
+            compatible = "amlogic,gxbb-clkc";
+            #clock-cells = <1>;
+            clocks = <&xtal>;
+            clock-names = "xtal";
+        };
 
         power-controller {
             compatible = "amlogic,meson-gxbb-pwrc";

-- 
2.34.1

