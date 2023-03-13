Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211806B8376
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCMVBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCMVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CC5C9ED;
        Mon, 13 Mar 2023 14:00:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so53975449edb.10;
        Mon, 13 Mar 2023 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWbAxCbex5z2bVfqGQhXVB3nkKDf2dyOixZg0iRnhQo=;
        b=D2gUZEwIzCy0DMDjShGn6TBeIJZfxrpO1rrrh4oX+fuusTnUBTtpghh0wMl7wHEQbP
         cXBxJnaFXN9k8Q/XcQd+R8QQDetoGQ1Apja3u5ZIoGhLCY6FBvPoNWq7xHq0N6ZunbDO
         IfguKH/TdoO+Frud3ZZ6S6PJJ0pE3BhaRUkSm41EvTg499O2HsZgNEoQwCXNVo7V7GSf
         515FKLVcm8wxHWt1k4DSc0dlm6t++l74y3DcRLao0riG4a+ogcXIZpjOaPsHyXo7U+RV
         hpv6QroGzPPrhWJ9YYnack/8BHLayvKyrAvbnkxbhhtiJW0rti798hxll7XJe0CgCal2
         f44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWbAxCbex5z2bVfqGQhXVB3nkKDf2dyOixZg0iRnhQo=;
        b=dCboAac7xgNpAJ7st9F8elN7lBMsrTe8HBWLaZRrynEQWuuqE33fvVOaQwo6YPl7VY
         J003vxyhBwtMug2KXt8mXcfABy/b1YZvsy9nBHOdlFv7MC9uMV7BMpawuj2TmNLQm0dt
         QGE3beQ1L5ehVAIs7QwBXcs5Z+tEt14Z/Mf1V3PJ0ToFXLayu3gW2wULxCwNjg+HwC0v
         4tk/JmD2rGvbP0H4Ae7yq/IJSM5GtYtIFbAIoR42dGg6J6frQMLfwIXy7S92R1E8Mmvl
         39yJyofdoDpk+ASuvdve8MmzpfchaJkgewnpZujYYugt1jK/u2X4EhbT/BZtVTa6pLqj
         y1EA==
X-Gm-Message-State: AO0yUKUDGp0RA/7ub+6SQSWbCnfY2CmvYHmrthRSdnZTzfuiEG+DAS5L
        AMB7hH9sVM0M3dqAFdWgIy8=
X-Google-Smtp-Source: AK7set+8xZ5sltZJ6fup+N1VDhON+CdUCYZS7saVqQTVK1a3z/QxT1hxiTWgdwGBVogpP5woWK+4GQ==
X-Received: by 2002:a17:906:1713:b0:8b1:806b:7dbb with SMTP id c19-20020a170906171300b008b1806b7dbbmr34642943eje.51.1678741214482;
        Mon, 13 Mar 2023 14:00:14 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:14 -0700 (PDT)
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
Subject: [PATCH v2 09/21] dt-bindings: pinctrl: ralink: {mt7620,mt7621}: rename to mediatek
Date:   Mon, 13 Mar 2023 23:59:09 +0300
Message-Id: <20230313205921.35342-10-arinc.unal@arinc9.com>
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

Rename schemas of pin controllers for MediaTek MT7620 and MT7621 SoCs to be
on par with other pin controllers for MediaTek SoCs.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---

I'm not changing the compatible string. I asked if it's accepted to do this
whilst keeping the compatible string but haven't received a response.

https://lore.kernel.org/linux-devicetree/deca532a-bdf5-c49e-1422-ce6124b61882@arinc9.com/

Arınç

---
 ...ink,mt7620-pinctrl.yaml => mediatek,mt7620-pinctrl.yaml} | 6 +++---
 ...ink,mt7621-pinctrl.yaml => mediatek,mt7621-pinctrl.yaml} | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,mt7620-pinctrl.yaml => mediatek,mt7620-pinctrl.yaml} (98%)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,mt7621-pinctrl.yaml => mediatek,mt7621-pinctrl.yaml} (97%)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
index 09ebb8ac22ac..0dcdc3788e66 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,mt7620-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt7620-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink MT7620 Pin Controller
+title: MediaTek MT7620 Pin Controller
 
 maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  Ralink MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
+  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
index fb8c5459ea93..32506c538459 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,mt7621-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt7621-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink MT7621 Pin Controller
+title: MediaTek MT7621 Pin Controller
 
 maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  Ralink MT7621 pin controller for MT7621 SoC.
+  MediaTek MT7621 pin controller for MT7621 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
-- 
2.37.2

