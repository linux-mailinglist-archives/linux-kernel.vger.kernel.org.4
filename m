Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE26D26D3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjCaRjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjCaRjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:39:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AC469D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:39:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so23264542wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680284355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRixuKzQvnbMJhgmsgomkYvraWKHEuPUT+zxf2iYamg=;
        b=LmmTQSCxEPrQPiGyjdgaHyD53hiKaMf7FZfv6Gc/r7/NwLERMujkY+9bJiGGGgUEGt
         1coeHYeANxagjh3FOcGAjlRfmd2p/TZ1qAtpBt4Q526yW6G8SOUgfj/U3S4ojfjhxm6Q
         jJ1TggfS5v/lNSlLu+MXHd4ZOHL+KrJqoGF6m3KQ20EILXkdFms8eS18xCojnDrB8q1A
         YpdlwF80uet6YK4Jq/ttxI6EeUbDfkB8D4j5i6EoJo1yHJz+MvyczmDnsRo+52R06Ing
         BKlYgx1lf1p68W2Fsp9W+FQ3naUWo4dAtPuw7fmKQuTZ40M5vslV+10BDz88BYKaKvPu
         2mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRixuKzQvnbMJhgmsgomkYvraWKHEuPUT+zxf2iYamg=;
        b=Jtk8R175csV34qTQYprXBl2BdwcKdoM9t9bI48RTeSctOY5HubmlP75Xa/Tee1QH8m
         Hu8F/90/uUIh46sGFLA6I2oT+kvbOZtT85PWYne8bWFfcmNJKBTInOJu618nZ/NM426a
         pYMhoWlwgNMG7L2fKmQLvAAmRRwxUt/rrahVy+KjIBDk/bBTzzego1oDSRuXFmgsxYfo
         OcgaORPXBcO8dZVG0M+kDYIKdveFUeOkEnhDtoFI4fFSyWaVD3QCWULXM0yJPCjCFBVa
         o/Xpj2/SE7N3WB0Vy+6IGPFkAwipZ30AooG/JGiiMjJzqNfOUQ86twh+VUE6Yw0N/Brs
         n2Uw==
X-Gm-Message-State: AAQBX9c1lfOnfICa2TD3n9Bx1UBpmEz5hJDxkYqKkIYVIyAtox/eyTNe
        WAz4QcO19xPnwp3Xlq7JXktIog==
X-Google-Smtp-Source: AKy350a/Cvyka98UHE/iBASjYLnQV209P2aFcDroXiThDIDA1FYIsCtCyf6fmVkK47FtxJgDuUjY+g==
X-Received: by 2002:adf:f703:0:b0:2cf:ea38:ef29 with SMTP id r3-20020adff703000000b002cfea38ef29mr21791195wrp.44.1680284355608;
        Fri, 31 Mar 2023 10:39:15 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o5-20020adfcf05000000b002c592535839sm2733550wrj.17.2023.03.31.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:39:15 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:38:59 +0200
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: mediatek: deprecate custom
 drive strength property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-cleanup-pinctrl-binding-v2-1-f21fbcc3016e@baylibre.com>
References: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=igiUCMFpCLdMiNckuDwORr1eE6qfItZDAhGIpRb0mNg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJxrBMXQ3aqrosawTCEfZ459CZ6+xtnAFlCCE4IGo
 KGftLluJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcawQAKCRArRkmdfjHURVPjD/
 9zv00Oouq8BQqAEHKHrBsBtsA/dP0r9wgxn+cTQpyhyO13QZc/tA6I/QpXw2Aw/CISlTdgNw1fkhGp
 HXPUMGSRYZo7LU+NiW1WgH6HVlwa+DQUTUNulkpeHs1r1WmIJF25sImMjCvUlEdKKDF61X5fJm4ePO
 rC1sd3ZXnSXqD4mxIfA0FadAXdd9ot+BSDgIpZ21mhAUVvC5mGVh8L9EcudnzN+DpFSS9V8hRB+yRP
 BteUL7koGjs88mxehoh27SasvAeIPBbNMB+NnROvueSy1uVRryh8n4ubTswNo+zspKd5X4ejnQspUv
 34q1ldvf+8D/zYeYcz8CIboA/iAbWsjP5DLL9mtiSkMQK+qWIjfPjZ2Wlw/2VtI8kM91b+qrU2bodW
 5oiM88XXomksrEYv7CeuzLNSgQeIMrexyhCflZNcPg6AefQcuZD+DWgsJWi0lubFjV8sUCDGj9MoRW
 ngyvNW9j70LwYvv8ooGYfZfUBzjDkMPKQhGUt0NI/wzaA723+QFMqo9QhKlsullyU5woJuauJ1VbGj
 Qq/mrMevdPpHe+O80XTPHowUGONmzscoIizvco7GgzaqEZCmZeYyeFP1QKwxX5KjtXj0Gqua0q8plv
 yCM2xDWkyLLpnlTQiKVOfCU6yoZ+nky2c/w91qNhMFCF0aUAGZTdzaE4eXng==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate mediatek,drive-strength-adv which shall not exist, that was an
unnecessary property that leaked upstream from downstream kernels and
there's no reason to use it.

The generic property drive-strength-microamp should be used instead.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml      | 8 ++++++--
 .../devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml      | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index c30cd0d010dd..b82a066b91ec 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -110,8 +110,13 @@ patternProperties:
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
+          drive-strength-microamp:
+            enum: [125, 250, 500, 1000]
+
           mediatek,drive-strength-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use drive-strength-microamp instead.
               Describe the specific driving setup property.
               For I2C pins, the existing generic driving setup can only support
               2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
@@ -215,7 +220,7 @@ examples:
               pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
                 <PINMUX_GPIO49__FUNC_SDA5>;
               mediatek,pull-up-adv = <3>;
-              mediatek,drive-strength-adv = <7>;
+              drive-strength-microamp = <1000>;
             };
           };
 
@@ -224,7 +229,6 @@ examples:
               pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
                 <PINMUX_GPIO51__FUNC_SDA3>;
               mediatek,pull-down-adv = <2>;
-              mediatek,drive-strength-adv = <4>;
             };
           };
         };
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 4b96884a1afc..347f533776ba 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -91,8 +91,13 @@ patternProperties:
 
           input-schmitt-disable: true
 
+          drive-strength-microamp:
+            enum: [125, 250, 500, 1000]
+
           mediatek,drive-strength-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use drive-strength-microamp instead.
               Describe the specific driving setup property.
               For I2C pins, the existing generic driving setup can only support
               2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
@@ -189,7 +194,6 @@ examples:
           pins {
             pinmux = <MT8365_PIN_59_SDA1__FUNC_SDA1_0>, <MT8365_PIN_60_SCL1__FUNC_SCL1_0>;
             mediatek,pull-up-adv = <3>;
-            mediatek,drive-strength-adv = <00>;
             bias-pull-up;
           };
         };

-- 
2.25.1

