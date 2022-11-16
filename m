Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A462BE12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiKPMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiKPMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63472ACE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so24965213wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNAGHgKQfdNYz52YrL6tIozDgteaJnMtrOIqvPNzMhg=;
        b=FV/HSHXNcrRrqBJmHz+FqbLbCK1BkffXtZM77vZX9eDe6p7siNq5B8nQcLLmNDS5w7
         Xn4j656GAMQcICkOZaoB6Dl+gIFBSJeVMgM/VagVTIwiAYTJCCkc+SrtKAwlOmz0RSHi
         wPzMZqpVlejCHYtkv2LVPB1KX8ywyFXORrL/BWqL5DUiTAz+B27hZA+JSNEMG1bbuGLT
         15qMsONxjxVyp3znSvgS9ViDjxL8wHcSRtUzGQ7ghvuvbF1cO1EE3hqhjg4yr51bplur
         EY0YSZDUMA6UhrfMLeKqGJVWyheA0mJxrd0hLYbyHLPHXzPv/mDhtp0sM+25PQxxJxbK
         MsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNAGHgKQfdNYz52YrL6tIozDgteaJnMtrOIqvPNzMhg=;
        b=WObpt2sQtDBmcEjuPL/pyWPwlszmOOdmhfK4a4fYY1G1tsM0ANA70ZqVpV91sHdB8K
         QAUc84Pz5FCQcf/tl10C6t+lTKjY8C9OrVFLBgV9PRqAOtZpswLfwvXCH8aIBwZVVg9d
         cjkPgusDflq2OlTQVShAXN4vW97ZHJbsE93JkhW/TKQWkOVyMBxt/4054MR8o1IRFDWm
         qBcNMajsVerIaqI+bkskvERmUxJdbWF+vIyxwae2TfeluUfm0nXLNkyFlvjkSUguyVom
         SLXfhbDRPOfHp+K3lGV63HlO/+uy0iqh2dqYtyA3zJKDdqsgbotXf8Qv/ppYsFXwPMN/
         ms/A==
X-Gm-Message-State: ANoB5pllzLLx0uUACdQb5bWY0x2ltxAIAVKg7K5FSVvbmJK+B0A1Qy/n
        7+OOn5uCX4NsGnlFODHTO5ffBg==
X-Google-Smtp-Source: AA0mqf5fnCwQJSP0dEEGd0P6GY8cmjlR2j/Lo9/ly8wQoWpPbijkVoom+8SCPVlCzBPLmFgLQ6Nclw==
X-Received: by 2002:a5d:6252:0:b0:235:25b7:5084 with SMTP id m18-20020a5d6252000000b0023525b75084mr13597976wrv.135.1668602018230;
        Wed, 16 Nov 2022 04:33:38 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:37 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:32:56 +0100
Subject: [PATCH v5 02/10] dt-bindings: rtc: mediatek: convert MT6397 rtc documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v5-2-8210d955dd3d@baylibre.com>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
To:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3687; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=bgTXwPzyd6FKEaUqDbIPVK0cW0K3Wt2nexsVI0k4GvA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNie/0nfbIeSBs2767maC3sOK+AOvXWyp3zfFzK8
 aHPdjmyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURXobD/
 4w4dIX0ZyQIB72yfVZW5deAwSwyPwWxUftc8sKFy6nPu+/Pkulo1OPj0Py4nKAnJXp2EJz0l1NMR0A
 L4GEiZqTQ7I82pvPIoGMe6rP2G3KAPSlAs7ftXUg0DiQrO1UDZVptQKl4wKC7TLzQFFdD+41Rv4fwQ
 5QM/d45Z+cPsOBXhQN4ULawAXCJXXc9W73n+lL19eFRr+doETI22gAFQ3IIQKbrtJFg/wZM3TxElOr
 McJ2Fmys7SO+WtNMtUYhJ0bT10ICTFUyD9bcniRZ9oVXG1CKN5KdUvE//cD3lWO6yoiEfcXHmM8yaC
 TX6mWkiaX1tFxkDEpBQ21p9YSKTT8Z36OFtUBrM21rk4WLEDCR4k1QnhSomSmPFibq9JZ63b/GVNf6
 xABd9E2K5meLOCmCLTsT2Y+mTXAIIxVUxkHAR2pAUVF9bF2cGS/HZ4kGc8ev+FPLwsM/CJJcbVLZuN
 eXqMRBDDI5/PcMFPgG166G4RfQM26WNrvzh+5PMAa0Ct91zLt++GVQPHNLDmr6CZAmW02lhpIVrXwv
 r7I5s3ghydWK3uKNPpqeqTEa3KPfv6iJOUY6TL6BQP9wKERlVnTGSBBv4I9owvbBf00YbyMXwvYlHd
 Ocvx9OesU/VfqlhCwDPiiLnRCwnChrq6rRdUqmU7wc69Z7o+xbCPMiJHMo1Q==
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
 .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 43 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 ----------------
 3 files changed, 44 insertions(+), 32 deletions(-)

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
index 000000000000..f5a323597f1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
@@ -0,0 +1,43 @@
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
+description: |
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
+
+examples:
+  - |
+    pmic {
+        rtc {
+            compatible = "mediatek,mt6397-rtc";
+        };
+    };
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
