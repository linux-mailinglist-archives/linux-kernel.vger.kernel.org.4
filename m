Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B31638D29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKYPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKYPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB13932043
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5so3687754wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtaodGVpC5RT6XYiK+eOY0rwcK2uWhEYktwBYDm+D3U=;
        b=cHgcsWDMIqHdG9vIOjx3pGbnzji09i6C/57tbtdajxuwQin3LJIy/otdn9HakMSAaV
         BAYil3kI7Zkw5G2sDuV5fky92NeDeMOafch2EtwF0XalxCBbIDTBMslaHe9myzp3z/CM
         27neY6DmjCGt/vh0gIYAHW84hOO/ut96SIAvr1bLt2Xk76/zN4kUcxt8XUdBq8oB4q/q
         TRguZd4h84BRFgfBqGed8tubSQjD1Ud4avL0tZ+TJIGkyTWWV77GS+LTimU6OKI+xmON
         NJhwyJBlKgh7bVhy4kYjPWiCc6GcWkZT1aJExOWuVfQmHiX2NYI5P6JlZgLcaXmF6bIt
         Bbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtaodGVpC5RT6XYiK+eOY0rwcK2uWhEYktwBYDm+D3U=;
        b=64fT5y8x7u9HicNE+91t7Aepbsld7zuV0tNEhGs4o+E2Dh6XwBc/FvpZUCb+yD0lTv
         RPuvipUIsBhew6lIgsXQ5Jaako0mRQWNFgcXlz7gVl1UIB7ztSL/CDeCswc8+HK4it8w
         ctGwIHhQY8USM0HbepVT44Deu+uGjX6IPqQMvLwHiVWnvROnuNQinA2D79kstlf/jrm+
         7tBasMc8k0+19S8IL0TGN0Q8rMXG1hRFt9E3B6JslD7Lldud/NW3Vf7f2KmSHH5s6PGR
         DUCTglT+sy5e0jdN97Io1LmoUtO/CJ+zfVX36MW4/qJtI/sXxik84ywFr6LxYP3g5tFR
         ROJg==
X-Gm-Message-State: ANoB5pmk9THQDHB2ZjrD3RkDgdJhGK+Ot76sX0ys6wqPabxXfz11bpX2
        3xuntXeVKhPVfY8sSFrxoMZ7RA==
X-Google-Smtp-Source: AA0mqf7kS6Tz5quZlQxyKibRuFvfNP/J7F+sa3rlIYYznVcbfnJ73G8BTJTH5t51EQwIS0NI1o/fXw==
X-Received: by 2002:a05:600c:3543:b0:3cf:74bb:feb1 with SMTP id i3-20020a05600c354300b003cf74bbfeb1mr27647631wmq.102.1669389082982;
        Fri, 25 Nov 2022 07:11:22 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:22 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:13 +0100
Subject: [PATCH v6 02/10] dt-bindings: rtc: mediatek: convert MT6397 rtc documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v6-2-4f589756befa@baylibre.com>
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=CtchvNUNYKQ+sRRXF+yBXQCgDbmvYDamNuPU/DlwH4k=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsWBup/boE8Lq7PLq5YmKC0aWKnYNDwZdf/JlDr
 xt36kAKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFgAKCRArRkmdfjHURddkD/
 9zvzIvPq1+3Cpu/j5+tk7ih7fpJnVPzD77DkXewOg33pWoCx6R801Pll71H/M4kA4aTOdJTwP3Tf30
 gi1HMRFOWbXgt3b7sKwh20Dxtze5EsaVItBwcintwufuPqBft5aaGTgtYLTEXDYvNZvRJqqBr3NzBv
 oP6DbwOwshLRTnkd7CiHOcldrQHmlKlV0jGijF90IQI+6x9//I3FuNdsPrkp0rh7pIkqhWjWKSMQ2l
 Z3k8Tw8SR2hjnNRdeah4BineZFlFzAU8nPWP/XlmDMf8aWQbQZ3mIvsmFqKzlHGd1kSmvFLjw58F6R
 HAcvn4sEZOukScbDhpYFZMftpXtNT2VIx74E1PtkdglxKtwkDu/D6p6T6tKa/o+ZBMmF4mcXxGc22W
 gI9xc9bGkZEg7kjQHMkA2fuOqecibRV/+PhrxZDa3mt9qr2baES47gbc46qeOqD/7RtASyVgCyMmqP
 TB7wLMkzNAQwv8G5Nnt1pfomjnY+BIeeD2F7w6sK5YH0OwXFSDGmTbimBVkilFTgqZCt9rOuFugP8K
 ToCmVX3L1X1jw17Zar/CPYAP9FtVbLJ/krIpi6Wa+EavsSXap92KI+bcyvT6cHhAC4sFfmP8FQkATJ
 K1eb7AikJbJV6VW5FuwdKgN2Axk5uhQjfawxo6vwERasEbDQt1dqdmZAeqGQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert rtc/rtc-mt6397.txt to rtc/mt6397-rtc.yaml
- Add maintainer
- Remove the .txt binding file

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
 .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 35 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 -------------------
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0088442efca1..79aaf21af8e9 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -33,7 +33,7 @@ Optional subnodes:
 		- compatible: "mediatek,mt6331-rtc"
 		- compatible: "mediatek,mt6358-rtc"
 		- compatible: "mediatek,mt6397-rtc"
-	For details, see ../rtc/rtc-mt6397.txt
+	For details, see ../rtc/mediatek,mt6397-rtc.yaml
 - regulators
 	Required properties:
 		- compatible: "mediatek,mt6323-regulator"
diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
new file mode 100644
index 000000000000..97b09c81e548
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
@@ -0,0 +1,35 @@
+ # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/mediatek,mt6397-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6397/MT6366/MT6358/MT6323 RTC
+
+maintainers:
+  - Tianping Fang <tianping.fang@mediatek.com>
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+description:
+  MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
+  as a type of multi-function device (MFD). The RTC can be configured and set up
+  with PMIC wrapper bus which is a common resource shared with the other
+  functions found on the same PMIC.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6323-rtc
+      - mediatek,mt6358-rtc
+      - mediatek,mt6366-rtc
+      - mediatek,mt6397-rtc
+
+  start-year: true
+
+additionalProperties: false
+
+required:
+  - compatible
diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
deleted file mode 100644
index 7212076a8f1b..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Device-Tree bindings for MediaTek PMIC based RTC
-
-MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
-as a type of multi-function device (MFD). The RTC can be configured and set up
-with PMIC wrapper bus which is a common resource shared with the other
-functions found on the same PMIC.
-
-For MediaTek PMIC MFD bindings, see:
-../mfd/mt6397.txt
-
-For MediaTek PMIC wrapper bus bindings, see:
-../soc/mediatek/pwrap.txt
-
-Required properties:
-- compatible: Should be one of follows
-       "mediatek,mt6323-rtc": for MT6323 PMIC
-       "mediatek,mt6358-rtc": for MT6358 PMIC
-       "mediatek,mt6366-rtc", "mediatek,mt6358-rtc": for MT6366 PMIC
-       "mediatek,mt6397-rtc": for MT6397 PMIC
-
-Example:
-
-       pmic {
-               compatible = "mediatek,mt6323";
-
-               ...
-
-               rtc {
-                       compatible = "mediatek,mt6323-rtc";
-               };
-       };

-- 
b4 0.10.1
