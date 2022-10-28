Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0633611611
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ1PgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJ1Pfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9898C467;
        Fri, 28 Oct 2022 08:35:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 13so13836582ejn.3;
        Fri, 28 Oct 2022 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBnZz2bwg+asXyhpEwhxnZxZItsSvwXg6AVLhzxjJ/I=;
        b=I9s0jCE8baVJL5Fi1BA2sAhKWfMPYYqdgnPV9FQQwAHy2lkzCej7xDuUJv2GueKpWN
         SuHWVNfQBIyiJtfGGAjSr/+Uv8/B0Qcdz2AV8OyZDuFjnoXu5kUM5sqqu/DbL2G60Ygc
         Z2yU5U1Y7cJHWOspeCaGH4RQ+7soh3QMj2owp2tY55xvRsr+69fQ/cBsFL3JuCVJbCET
         O0cjjqbW1rd0k3MVDqPUw0/fLbUS1kCJeCC8YRoJ+gcyY/2DqTM1Hj95fuZxtcx5K8PW
         1lCetdu933POsP4oTtC3+441W+2dNKtB5EcBNm1GnqyvzeTWlNldxcFXZ9O1x7an/NkL
         ZzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBnZz2bwg+asXyhpEwhxnZxZItsSvwXg6AVLhzxjJ/I=;
        b=qPZHop/bOhZeLluO6NP6ZDhDRg+x/PQk/yL6Ii9qKz/0QRDLHv4qSiFKQhwNxKy4qo
         DPiYTUzvmdW8gq2pb50NQwsUKswnyccgF3feKbLdBXQThXdHgVBc8ChV2un/mvUgJCNV
         fGTufmHcGC0RuWuGYb+euKtjjcoUFZT5orEXBEBtcqVLtsPnS2G2YJM11BTMH4nUJbFM
         /qo2+9TSlJENlDkLE6IUv01jl7XT2weeS79jv2m2/4cOPv4p7iGj9B9eD3LTHZxbzXbm
         EdHPYfr2odbhdsGwFagp3P6Cw8x42FnRDmOAKOC8kQhXqqOCjCRbQEQeo9ot+Kdz6ODd
         LU3w==
X-Gm-Message-State: ACrzQf1fhrty0p8QazI28KhUx+mi8Ub1fJ96VCxmbEhq5MmWnwoWheer
        2mDd/vW4iTm774+krCtyG6w=
X-Google-Smtp-Source: AMsMyM4zINbvxH4EzrFuFH5QwAmU/dl4Nr1EcM8MeNvx8f0kYk4BTBifUSWklitKa4XvfnixH+T8cQ==
X-Received: by 2002:a17:907:7f25:b0:7aa:acf9:c07e with SMTP id qf37-20020a1709077f2500b007aaacf9c07emr21151819ejc.280.1666971335002;
        Fri, 28 Oct 2022 08:35:35 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:34 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Pull pinctrl node changes from MT6795 document
Date:   Fri, 28 Oct 2022 18:34:59 +0300
Message-Id: <20221028153505.23741-8-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

mediatek,pinctrl-mt6795.yaml has different node name patterns which match
bindings of other MediaTek pin controllers, ref for pinmux-node.yaml which
has a description of the pinmux property, as well as some additional
descriptions for some pin configuration properties. Pull those changes
into mediatek,mt6779-pinctrl.yaml in preparation to combine the MT6795
document into it.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index a2141eb0854e..23b1f7867afb 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -111,19 +111,21 @@ allOf:
         - "#interrupt-cells"
 
 patternProperties:
-  '-[0-9]*$':
+  '-pins$':
     type: object
     additionalProperties: false
 
     patternProperties:
-      '-pins*$':
+      '^pins':
         type: object
         description: |
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
           configuration, pullups, drive strength, input enable/disable and input schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        allOf:
+          - $ref: pinmux-node.yaml
+          - $ref: pincfg-node.yaml
 
         properties:
           pinmux:
@@ -134,9 +136,25 @@ patternProperties:
 
           bias-disable: true
 
-          bias-pull-up: true
-
-          bias-pull-down: true
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull up PUPD/R0/R1 type define value.
+            description: |
+              For normal pull up type, it is not necessary to specify R1R0
+              values; When pull up type is PUPD/R0/R1, adding R1R0 defines
+              will set different resistance values.
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull down PUPD/R0/R1 type define value.
+            description: |
+              For normal pull down type, it is not necessary to specify R1R0
+              values; When pull down type is PUPD/R0/R1, adding R1R0 defines
+              will set different resistance values.
 
           input-enable: true
 
-- 
2.38.1

