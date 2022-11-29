Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D62663C469
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiK2P5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbiK2P5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796C45A11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o5so13803852wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=pNIiYVVTkwgqOriKU8BYCl0TpK0cv2SjHLsGdkHKq21/VB+1nWmyglj18IvFnnWgNg
         w5WZA7aYnWHzUkKlbFCdb8uGwICFWVM9wHiJGZffqIYLpgj2PAXkd/2gaLG7SyRnbldn
         K12qM3pCgNzfk66RY0/iC1ujwbZSB+eWKdjliMVt1FM7vvfHTa1/6vuQtOw1oHH9KiOn
         RWA2lIXiT6NEmX9mIZp+ac5PxEhXPaeHPGF7rc5+dBGgwMQ3dKD+xna9eH62EhdobIMR
         YZqt+WWhgpINTkGwxqPgEn9MjKTV4pYUcALLbWaX4yFxxuXx1g3gEfIYR5rLtDW1rlNo
         yvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=I3dbf62U8eZgtD++OkbTnGn1oitTjgzIY9s5qOAJu5EapiFGFhmfdVlhLeabSv82xo
         pjMLW1h3VNbiXxBEMY5wjZIvNTcs+XfVy+TiHunfgiYgC1zkTDqyfT+VSgjeQL3Km/nO
         yzKVkqDfQhH7njcPQdhtDUCWqCmG/7ChXtQcKF0dnhyJ7+vePiLCXOOplrPeLSH1uGOK
         Wj/tx6g6FaK8JgChxA2k1lKxJJqZDcRDW7Q8a0rrd35KhR/I9otZPm11+OkM/kmxYSkP
         2IHexErEjEmA04IkDQ9X/mIlCO6SupSvb5/W107K8qTcOyh/NNJngtbxH3c1XiBkcmqw
         AR8A==
X-Gm-Message-State: ANoB5plf93QqaFQ443CpZ+XRgQMyTi/2v4slyjxwQmsBY4TmAb3W0xU8
        kEzepn0/t65UK7jUjNo+XcCkjw==
X-Google-Smtp-Source: AA0mqf51vBPWy4hgZod60Cj/lrx484/uTfg25oQBq9QbebDIhdhfi/oObCpVFPiTh9h923R96L2wJQ==
X-Received: by 2002:a05:6000:1e12:b0:242:1522:249b with SMTP id bj18-20020a0560001e1200b002421522249bmr7747931wrb.326.1669737426121;
        Tue, 29 Nov 2022 07:57:06 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f2-20020a7bc8c2000000b003cfb7c02542sm2601550wml.11.2022.11.29.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:57:05 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 29 Nov 2022 16:57:00 +0100
Subject: [PATCH v7 1/8] dt-bindings: input: mtk-pmic-keys: add binding for MT6357
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v7-1-477e60126749@baylibre.com>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=acIU37N8P1oQiEeAFVfuuIgjK7XT7A/zFtqy1fGJDhM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjhivPA5aom0Zeqyux6rOhFeoKTkzE2Oj5kGE7WYXg
 +gQGHnSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4YrzwAKCRArRkmdfjHURUE4D/
 9BdXsZiju2AGVXgrER3x+Vo78etrdpuEunjrQRsZWcDasGnLOQBbnmPWLYEluoDIs0y4Y9VHJkW6P5
 eDB5OmuSid2mkwvRdaLRD/AkLQei3V4mk9T9tzW+fogVahDpF+tDzQ9iDGWdiM5sJTmODVzqHpFOgj
 BONsywJpJRxBw8BI/VwCHg4vfXUmD94hOCz8SdiFEM4OiDIW1bSAnazBUdai5/zq9wEv0l+G9rA6me
 qOBASTf/8NNBnq7uprjuqGybA89cHeXtQEcWVGNhKH7qEv74NEEp/kk7qvoGhhadY148mwd+9ADliC
 NciYbR3ZSApmC+f7lLx9FUm++OI/1V77hZ8MezoOyEE+EvJXucx4FHk/AFRZR4aSJXZB46mx45NlkX
 m6cVrsYcRjjjByvT0St10+yz01XD30iD9zTYz0CmLr1WcfKqeJrsOc1Nbvj98ltL0UkxSfv6Hc4Xz0
 sMLc658evxboLjfPgiCW4Sg4iU2ATJ1Fas8bmVuFrlEU1j6IeHKYfwqqj1ITrd49UULhf7QBfoWMxb
 6ucBbpCCCAt7Fyz2ahzwRsCcxWZg/HQOQG2YHcfmhJtW1+C9KQ3L0zXwEe4GaRDL5yxpcSmHLVgMia
 BcLWIL0fz0tMH4uaiZevPcqt8HjSM4SZQYfk4rwSV/h5UkJfFsagDaCjsoJQ==
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

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the PMIC keys on MT6357.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 2f72ec418415..037c3ae9f1c3 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - mediatek,mt6323-keys
       - mediatek,mt6331-keys
+      - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6397-keys
 

-- 
b4 0.10.1
