Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10D45BD331
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiISRFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiISREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:04:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C2C3F31E;
        Mon, 19 Sep 2022 10:04:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so43737wrp.11;
        Mon, 19 Sep 2022 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nf15LCZ41yR567CGTs0jMggqT7vYr6v+1mrdNYdAXhQ=;
        b=ZD7fUgjkjYzdOIIjM9zCtOWu0KO9Oqs+9aPPDSxRJnr3CkysmFY28DA7mrGb+FgQ52
         NIjL9M4y7L/sRuT3sydISnddHXH5t1i9Gr95bsLKpN8FUiSpVhIcp1l90rCsVHx1GQip
         iq/QFkFzPbA3fpGONXHaR/ZZ1F3tJzptQoikCr5ve2m1xD0ygJMfOth9YSdhPFuI4LhL
         OsE+AhYuiIaHH3p9kgjBG1a7LGUAnRym1/1hM492aAiKf7r+UqAzTaZI661f7HffRNzq
         Id5DvHjym973ECP6cCOfptOvovV/LFxEdlNkDmF0NTf5RG0Fy+p9Bywr+Fx//a7sLp7V
         Rddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nf15LCZ41yR567CGTs0jMggqT7vYr6v+1mrdNYdAXhQ=;
        b=EHWhS6cKg/0GOrnvnVcyWI5+c/bhh0ouhUhzy6Jn6X099xp0d/zEd30rs8NtdKqwoG
         Pq0JqM8jacZH6vCJEoBGBQEs68powmHyz5UipCm5Jjm8oiVwwWUCGYCyr6Jt9fZx9Zw4
         oLIiiPEvzgs5nvAKRMfPnk84VnFhm5i0MWNxNRS529CdQmsTHd7Qa0Vmkiqr1xFegC7T
         OBoS4O439HgsMcw14oGhzyOh6359dxtRGO3auVlubwAq6ceSSF/qhH0cDLVBW0MXo6or
         XrBGJ0/jcsJjI1lyRoJ1wj4fJ8Njn52njA+emMmFeQZyEyCuyLTOhxNWsbf6Kj+Air1t
         7Rrg==
X-Gm-Message-State: ACrzQf3w/5WL8k3gbASM7FkwNUth/MEmCLUk6m9n0bLm2Ygw//eKRMl3
        TDliIixuwoVBPC4MMfxtWLM=
X-Google-Smtp-Source: AMsMyM6M0vy0t3hvu4FfyUeWGYGzqDWgTfwOMONAZA8HhrxKeFV5auXVZWRGb1fmJ3aJC+9eAZxhHw==
X-Received: by 2002:a5d:59a9:0:b0:22b:e6a:4796 with SMTP id p9-20020a5d59a9000000b0022b0e6a4796mr569883wrr.47.1663607039408;
        Mon, 19 Sep 2022 10:03:59 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ci10-20020a5d5d8a000000b0021e6c52c921sm17562487wrb.54.2022.09.19.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:03:59 -0700 (PDT)
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
Subject: [PATCH 3/4] dt-bindings: pinctrl: mediatek,mt67xx-pinctrl: Document MT6735 pin controller bindings
Date:   Mon, 19 Sep 2022 20:01:14 +0300
Message-Id: <20220919170115.94873-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919170115.94873-1-y.oudjana@protonmail.com>
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
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

Add bindings for the pin controller found on MediaTek MT6735 and
MT6735M SoCs, including describing a method to manually specify
a pin and function in the pinmux property making defining bindings
for each pin/function combination unnecessary. The pin controllers
on those SoCs are generally identical, with the only difference
being the lack of MSDC2 pins (198-203) on MT6735M.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt67xx-pinctrl.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml
index 1a1a03cede3c..c5b4972caa77 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml
@@ -20,6 +20,8 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - mediatek,mt6735-pinctrl
+          - mediatek,mt6735m-pinctrl
           - mediatek,mt6765-pinctrl
           - mediatek,mt6795-pinctrl
           - mediatek,mt6797-pinctrl
@@ -63,6 +65,29 @@ required:
 
 allOf:
   - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt6735-pinctrl
+              - mediatek,mt6735m-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 8
+          maxItems: 8
+
+        reg-names:
+          items:
+            - const: gpio
+            - const: iocfg0
+            - const: iocfg1
+            - const: iocfg2
+            - const: iocfg3
+            - const: iocfg4
+            - const: iocfg5
+            - const: eint
   - if:
       properties:
         compatible:
@@ -180,6 +205,22 @@ patternProperties:
               };
             };
           };
+          The MTK_PIN_NO macro can also be used to select a pin and specify
+          a function index:
+          pincontroller {
+            /* Pin 19 set to function 0 (multifunction GPIO) */
+            gpio-pins {
+              pins {
+                pinmux = <(MTK_PIN_NO(19) | 0)>;
+              };
+            };
+            /* Pin 172 set to function 1 (primary function) */
+            msdc1-pins {
+              pins-cmd {
+                pinmux = <(MTK_PIN_NO(172) | 1)>;
+              };
+            };
+          };
         $ref: "pinmux-node.yaml"
 
         properties:
-- 
2.37.3

