Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0126B8375
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCMVBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCMVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D0282A8C;
        Mon, 13 Mar 2023 14:00:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so2407914edd.5;
        Mon, 13 Mar 2023 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuxxWvZVFUfEaJAG7ExDAsmMHlbWAFLt8LUNtSrlwLA=;
        b=TiwAd0i7trObcgTPCERsP0D7Oo6UU8BEmhgrxSFQ0IsHTMvbvVOc28RelhSr5YtZcn
         11idIAXJLVz2b55TyOS0twaCuBUduRhmcHKyh3TNACXCatiWJwSoldi9TIc/VZ4UPTDV
         f9ZSkHvB/G1iLSXKN7WgKSEAYhi/hYk0QzsALT88OApz4kv5DAHgUSIR51dwdxbvm0K4
         ++GpxjOO6JSMQ59Za11yrfEw1QhU1D9YVQRCEjCrthc0uw1pQx8T1FjWBrRdKqxNxNd2
         oxeq8+zZL3OWqIJ/dPFKA60tZSt+Mjd9R4p2T+J6lxBzXzpchn/yYimaczkp9pBAW33N
         G6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuxxWvZVFUfEaJAG7ExDAsmMHlbWAFLt8LUNtSrlwLA=;
        b=vzXmmig5ViOkAYYW/FjOJYBHrnfvYpUPDONbKUAP0T3idyf73nF9hdEWtKUXLjBICe
         yWM/W+Sa6UB6vkQZnGNPEOBNGa/0fx6RydZYshzfshix176LDuCqGUVvMk7mwvDL5xWa
         W9LnBcSp+GZ4EzkFPbndQxqifURYqbaWBVzlfhnW7xcN+RPNzYKwCXCdp73HPmFg5FMp
         Xv7891BImKjef6jvERJO0Mf85hEaRxLMX6UGONNTJ/m5VtkKvV3hZ7gnx6ttRrCJJruG
         VjF5/4ZMjMQT7P/RbbIfHDl48jtSmVAlZakmFfXPApBdTSPkxmbFv91ER2Gv5p6hBYu8
         sq9Q==
X-Gm-Message-State: AO0yUKXOKxwLQtFl5kHW6uP88uwq8+VrJ2PbNsTgPn57s+4kcxSe0Mz9
        iVwOX2/EPas06Z97GPsdkvI=
X-Google-Smtp-Source: AK7set/V5D2K3JFT4+XsVS1knoZEU48FKRfirToOZ+MhXdc7pPPbll3Zt314m5x6nQI5xClM35Chng==
X-Received: by 2002:aa7:c51a:0:b0:4ac:bd6f:cacc with SMTP id o26-20020aa7c51a000000b004acbd6fcaccmr32274330edq.12.1678741212066;
        Mon, 13 Mar 2023 14:00:12 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:11 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 08/21] dt-bindings: pinctrl: ralink: add new compatible strings
Date:   Mon, 13 Mar 2023 23:59:08 +0300
Message-Id: <20230313205921.35342-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313205921.35342-1-arinc.unal@arinc9.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add the new compatible strings for mt7620, mt76x8, and rt305x to be able to
properly document the pin muxing information of each SoC, or SoCs that use
the same pinmux data.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml   | 4 +++-
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml   | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index cde6de77e228..09ebb8ac22ac 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -17,7 +17,9 @@ description:
 
 properties:
   compatible:
-    const: ralink,mt7620-pinctrl
+    enum:
+      - ralink,mt7620-pinctrl
+      - ralink,mt76x8-pinctrl
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 8b1256af09c3..23fb82f9959c 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -18,7 +18,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,rt305x-pinctrl
+    enum:
+      - ralink,rt305x-pinctrl
+      - ralink,rt3352-pinctrl
+      - ralink,rt5350-pinctrl
 
 patternProperties:
   '-pins$':
-- 
2.37.2

