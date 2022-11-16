Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9762BE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiKPMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiKPMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3AF6376
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v1so29651212wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByXWD0lCc2CI3sIWiOYpDZxY7pYbUTZWMwJ3VN18Hi0=;
        b=kLtCA6b4Gwx5KFILMSNS+Ogl0kqgvx0G2tZkgvanHcqxG8eSNPKtf+/cvwF5V/bUZi
         E5q/jgrvhlHeTyunIUTJkZL9qSL85zcjqiFp7CRENaHhUK2OF5kEgHqQo75h7ZyB2aT5
         kLUbUHDt025aUm4Adxe9b1l1kyHkDxiMDfn09WhwLk/dw68VCHCC564TP6Xzbz+7mnnm
         +w/PZeWQp7zbuCDOpc4zix4TvVAqmqhbCQ+M/A3BZme9/ESuq8YfrOV2Zlwb0cEQONYq
         F0RNdix0mC+9YRVCuo+kxchZ2SBk1dQO2qFHSkQVL4zfJfI3E+eCn24aD40W3N/CDS4Z
         NjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByXWD0lCc2CI3sIWiOYpDZxY7pYbUTZWMwJ3VN18Hi0=;
        b=0mUzc+Lmn+TsIdP6TJ2tshJQT6FJHRMJb4DjRvvYrQpQD1w7zKRqahzvPVG7rb2OVX
         84CZ6cOIABbPhZZfMvgkabRafIAL01UOLcOgLmOda9ky92MAjMhh98FtpyYUU5yXmUXw
         5kgye5eibm4iLXWeV9zWZWONaqIbQhMQyXfEeqEazZgODsH9x6cOu02SPKPbr4NY6ikP
         /jf0+rkhnvthMX+Jsqw7OlmzTPTQcG0nZ7RAiRpdjBh27vqBjeCHpQ1biAZKoJ4kheVV
         vo4hTiD29TbcgBZRHQfEET769yh/M4sC/mFr/f9Td8MhI/S7LiE1+MOJJg4Os2Psj/ec
         Wbnw==
X-Gm-Message-State: ANoB5pkr+Uw5v7SYNPdgXuXCQNqOPYQb/kUZn3NFJV6AqjR6vMua+V/E
        jLWR8f6OqBPEg7bqCfCtqIWglA==
X-Google-Smtp-Source: AA0mqf7e0C2iFw5u+lBPjnnR0+qOl8YEMf9M6usMvRVDVDUgRnm7mjNz6NQVZUhWvBs3NYxWsoGanw==
X-Received: by 2002:a5d:6909:0:b0:23a:5a31:29eb with SMTP id t9-20020a5d6909000000b0023a5a3129ebmr13417655wru.679.1668602019299;
        Wed, 16 Nov 2022 04:33:39 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:38 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:32:57 +0100
Subject: [PATCH v5 03/10] dt-bindings: rtc: mediatek: add MT6357 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v5-3-8210d955dd3d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=1tXoH1HVwX4fN3Wncu6gs0AgFNOfACwfkAOrtJSJ/W4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNieDlBAVIL+/YAoYamy6vY7S/jXwIimB1VbYYQ8
 bCBYwGSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURQXdD/
 97gSKBpj/3J42WdqW7VkrkKAALxndbe+269SUwn37e6CzavlmF5PYXMN3WT5/xGn7pDOEeAbqC6Alm
 PtjLQ1jIlhkSyIWHpVrDKEIlgIKkwifgLoOLuu0o6R9cD2ydWbdHE8huQoQC8B1ofwB3SCDEqPmWvl
 Dm/s5u5BpCobk3kM7W4ED9NIXxNn4a9mkmTUcoEWT8vwsIXrdZvfGSjWQtW640PU5dqa5TzwbYUnRx
 TZmcTM67PRUeYlSKJOzy5S4hX7hMLIFmI38Jc0Qz+RSQl0aO9XaVTXv6OhezkbaNVDoG2gE+eOy9ql
 MwOdcgSNIJI0MHVh0MpuBvQurwKcMU8g+by7h7ayPrFifWDkW746XzprARQeUtt80FnYf7oBkBwGfe
 mUp9NLFrkz+ALMum0XpH1NSRW7NB0V0M422FlJyMl5I+nC8QerthOcixVRLC/lZKhddKNgLe/dG5ze
 KlKoHYuhW3L3M7ljbjkQBii1Uw1/vA9vR3sfyWUScmvokSQfrcLXgVWtasZasmeuw5dlCt0hbnp5eB
 UfWaVlnsSPr7bKWXx0HEI7inGVgICm5XAHk4xXT+yyEGXnJ3+jTIS15+2iCrpOM1N8DOjxJGlZ587e
 ci/8nWIg0l4udv4NKZu1rfwhtdnork73njIbaGf8uZ8MbXLLvmOtE0Lzraiw==
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

Add binding documentation of mediatek,mt6397-rtc for mt6357 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
index f5a323597f1d..f4e861789d00 100644
--- a/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rtc/mediatek,mt6397-rtc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MediaTek MT6397/MT6366/MT6358/MT6323 RTC
+title: MediaTek MT6397/MT6366/MT6358/MT6357/MT6323 RTC
 
 maintainers:
   - Tianping Fang <tianping.fang@mediatek.com>
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt6323-rtc
+      - mediatek,mt6357-rtc
       - mediatek,mt6358-rtc
       - mediatek,mt6366-rtc
       - mediatek,mt6397-rtc

-- 
b4 0.10.1
