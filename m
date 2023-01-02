Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5765B4BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjABQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbjABQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:06:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DF3B1C0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:06:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y8so26663246wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/qGjMKoEF7UDLliJtrbx4rWqxj8RHaEUJHMJYnhdEk=;
        b=JD0PytvfQKiP0KCgIFa224x/z21Y8Ln1q9WsUA2rBHGWEgP0TNt3fs2VbhzQgZ8Fxx
         zyOFsVobxAqzU9WsW+BHdWvDKBYD+sAtpcev4piUjImBrYd075T0kb8INQJwy//NoeD1
         osRJ9fDvpWDQwSxS4H4TENCC81yXJHvHZzQjoFMTMTlIjkCf5J/xicw7J3nlOXJJ18hV
         op3/yMLpH0twS4G7HcRZp0tLIHiz8WDfcbcKZcxMnh4kusWJK+vndljBwV10jvfKcbRO
         UZlEC4TJI7OyI4eotMMBI61tKbwAvz3X1pLJ3kb+yZzdcLWkmQcadqAar7nWSMPnWMeS
         6Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/qGjMKoEF7UDLliJtrbx4rWqxj8RHaEUJHMJYnhdEk=;
        b=TkpUSOeQtZU49E5GdvfrhSVQdWqSijoao3+045DTrV+JvKq3H95hZkMp0IJf0KsiC5
         7brE5KxnMkAhJKt8aGg3rtL5kANbhWxXRHKU3TcfeoHyVkgFRMUilhblyD+V3zzfdy5u
         u/KMFnJTPP8S18W+GKSzo7+ta+Pbx9b3+ZcEepq7LZbF+ANXDaVgzWQsvB78YtB5mB43
         QmTm53LZFfPk6UdrGH3D96iirX/kp4SNN6yOMoYeiN9lSeDQ1If1MEW6sM0zjGGuu1ZX
         APRhhUQ1eFsCV0lyForhhz2Q9OXWMgNBqTmPA6KzTihFyC8gCRJTfPYibVLTFP7QW3qi
         x6dg==
X-Gm-Message-State: AFqh2kp/78gGLhCLMnH4H/Qtb0v202Kwctbdz1jgG6Zn2SVc2ddQDTj6
        xw51KLE+TDtyDy8v2FKXKdnFJw==
X-Google-Smtp-Source: AMrXdXvjwZmAJ2M2OTzwt74Sep+YZN4mH/ZAN7DYpa5PXSm+x/oy/o866YahUsqVNq3+XMEUF7gMdw==
X-Received: by 2002:adf:fa84:0:b0:28b:ca44:641f with SMTP id h4-20020adffa84000000b0028bca44641fmr8914254wrr.30.1672675588380;
        Mon, 02 Jan 2023 08:06:28 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm11868020wrs.33.2023.01.02.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:06:27 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 02 Jan 2023 17:06:05 +0100
Subject: [PATCH v8 4/6] arm64: dts: mt6358: change node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v8-4-560caaafee53@baylibre.com>
References: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=0w3mp8M+1h003hGCAyGu3KsDIgwbdfb6BOTNA6p/zCk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjswD9dCSutgNMv2SYoxP9C4n46Q+Vf4BRrXmGchHp
 RGXeIyuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY7MA/QAKCRArRkmdfjHURfoQD/
 9d3SIM5wFv7fU5vzlhESrtOnWCDmlEA0vox75QLA78Ow62ca0QtUwYGB+1/h4VZQ5qqC7RqjBdZqY9
 zrZ4kSK6ZvbNVA0if3vaJwVgFYJ8GcnkEhzTpGWaVGCZfO8qpshGL6SgfLdEjuZAGJoHgO/I5vJh5x
 vhVAGwEW5OvjoxODjaWZ9FYEGEbsuQKsQBwAoiH4Yjl5uXOkmagR4v4+HfiXYYNs33fqyCCcvjo+LG
 XRVqvFlg3VpKs9B11+lXSE/XW5lmC6dcHzyqmiUoca54U4CQd8+BOYC8PJ9EwKQRKZOATIBie8zpfN
 ExLlS+K6e5XcmBEbDbLz07GghJ6CvrokSsp3xr75pmfnwq3iRXOkpdzsDHlbjKQYjQP4w9qsFHhEO4
 mIbc/XCdzbIoEZBhl8Gg4Jx/ED0WV5AmoSHQlW8vUv4SQyZ3E9IOFIq/K1Sk3lxo+7ivHX8O3lXDZx
 9kkTylzGYDaD50mnVIlzG00ngfT8RpuIhSVDdOiD5MWtmlAR4euYQp+Q0J8cRpYCpgP0z+7MPVWuTt
 W5mRq2JSywvM7rBpM33v4uBdp9Zn62NCpRbVBp7GwcHgtj2o9NHXFsfY2xkjIN1FAs+HyACL0Atqxe
 mF1/Vx/TWVlLTMcCJRjHe1D1aymw8ey2KDg0gwfo/jcnaQeS/6/uZSZQ17Eg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change the node name from "mt6358" to "pmic", "mt6358rtc" to "rtc" and
"mt6358keys" to "keys" to be consistent with the generic names recommendation.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index 98f3b0e0c9f6..b605313bed99 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -5,7 +5,7 @@
 #include <dt-bindings/input/input.h>
 
 &pwrap {
-	pmic: mt6358 {
+	pmic: pmic {
 		compatible = "mediatek,mt6358";
 		interrupt-controller;
 		interrupt-parent = <&pio>;
@@ -355,11 +355,11 @@ mt6358_vsim2_reg: ldo_vsim2 {
 			};
 		};
 
-		mt6358rtc: mt6358rtc {
+		mt6358rtc: rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
 
-		mt6358keys: mt6358keys {
+		mt6358keys: keys {
 			compatible = "mediatek,mt6358-keys";
 			power {
 				linux,keycodes = <KEY_POWER>;

-- 
b4 0.10.1
