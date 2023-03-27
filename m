Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95986C9DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjC0IeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjC0Id5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:33:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA54A7D8B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:29:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l12so7735803wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679905688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXySEw6VHHY4T8YUjW6WkiV2MVpH/15AZY9UsR+ehZA=;
        b=PbdSxxfQSvfmaNR7ESQq4AVpCFq0z3EGuqRUt3geaqXZOFOFXUOZZzFLW5n8xnavtD
         Mh1diY4TEudKvid5kklpGG3yIRWbYS+s5zDaZbi2aNaDDvoR5YApIy+pCrOIokNLFirm
         PCIL8lrhFucIMvan7yh8S7XTYbp8zlk54oLfTmiZi+Fjxy9Wqx/FvaE7pBn8UIMWzExN
         EkUAJlTY1nbw+IIUrnPthHgaLGNLnV/X0b6670ApH12mF7eAsnT97WZEdm4dGnqT86em
         TA2pM/k8WaY4OjTtBDie0wneYvJxktADEZR2AX6LO16VjgLtkb3BTbr1zdx8O4rT6xie
         t7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679905688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXySEw6VHHY4T8YUjW6WkiV2MVpH/15AZY9UsR+ehZA=;
        b=Cvsa9zsupcJ/McUrJndIipJgAPXGOLM2Ahqgvc8YOqLNDNzGsA9hcUchIYJG7YKcgo
         /06S5QLfKdA1qL30ru/QRItFsFPqj3YmRtSf6ww+erhQ+kOsLu4bQbYcxaDvIjumAY6r
         DARnr8ZGuyIfFfD1fqgxbEdOw87jj5KUDTTvqQjvzcsDVZNEOlvgXrktUz4drYwOQOmX
         W0cCPc3wAGfKZd+ROgMorq3JTmidPZ6QLHvPH9zkb74x9Ah6tXYqnJla8ZYBKHAjQV+x
         PQxiKRSWK/DVj4gKLSXK0xYEoyZDNiBn9eaO2NSEOwTayk2/jdNEZcuQfs6uAFmCrWQ9
         yWcA==
X-Gm-Message-State: AAQBX9fl0WKHtd++IYuSo++5BxJV9YNoLcxAONxOCcd2BS9n33B5EnUR
        gcPj1ICgQyi+R8P9lzwCb1a7CA==
X-Google-Smtp-Source: AKy350ZPTGuHLzmCMgOTOYYL6zs44rzYzlU2HkPczYjzD9B7PvW6Z5Y1kyB+NTTXcTXgglVUth5Dhg==
X-Received: by 2002:a5d:4e90:0:b0:2ce:a85d:5319 with SMTP id e16-20020a5d4e90000000b002cea85d5319mr9830086wru.39.1679905688659;
        Mon, 27 Mar 2023 01:28:08 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id p5-20020adfce05000000b002d64fcb362dsm19192398wrn.111.2023.03.27.01.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:28:08 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 27 Mar 2023 10:27:58 +0200
Subject: [PATCH v5 2/2] arm64: dts: mediatek: enable i2c0 for mt8365-evk
 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221122-mt8365-i2c-support-v5-2-6e4f3b54937f@baylibre.com>
References: <20221122-mt8365-i2c-support-v5-0-6e4f3b54937f@baylibre.com>
In-Reply-To: <20221122-mt8365-i2c-support-v5-0-6e4f3b54937f@baylibre.com>
To:     Qii Wang <qii.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vLQRmdlf8w5DsX+xgQD+R1WqZbSZSTtE1/ylilkoFi8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkIVOV650DOqclHY8dCbK7OCEAXd7LbFA4eAKp8KZJ
 HXoB5c2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCFTlQAKCRArRkmdfjHURZ2iD/
 92hVpCiu0r88n6RohOPfuJYD4yr16TvX7ZAA3Vs6/nH427wt0ZbJjhWa8tPhBNWDQmb2pXcFKMpJE6
 ZajYoJwnnT1gG32M0RQ+PY29O4nVhoGIoMJjvXB55zb0ywt6ZqUSkMPwKRTNd0xG9OQ/Mhi9HKn+6Z
 OaATkPoVOovlf50O7rzZZRoY/v6phi2R1uCvVqh76M/7zTVUHBvXKXS6wy+3Wznlo8IymQj7a85J7H
 0rGNNLaRO5xWoICjtYcCXz+3dhIWGHHFtyNeTHkr65uHnG2u4sk4kpDbg38o1tZ01WVO/ht2it5A/H
 LM/MuM0SLaiewdI79eO3bU/dvRjROm6ceQ037QN3tM+YOULWL+cIzSHahiPGunvTEZQa7Y65NFnv9k
 ZvyDAa0yZ6ANuZuViPeJazPwM1F0lNnNjeuy6MUwhSQbh2sJ/LFbHl1IzGuMJTjNkbhKey/EaIL6Xa
 f2Bf+bxsGjA3dsJScYIydGuDub+synek7xflQWdimmtl+yJjU75cRit/Xu3Ya0E4NtZJy74sKDSoC9
 YnE6sD09o6fT/lfERGbHAXOVWSMzoHz/TL5Xfs8a4pAfZ+HNoBLV9oaqOhYUbxWNT6UsB/twxfwcyq
 MkyCm9UYc75RoCQoDhnr4P6MCVFBhI9Y3okd162qrDlakKLHeJUZLhOpPp4g==
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

Enable the I2C0 bus provides communication with:
- The integrated RT9466 Switching Battery Charger.
- The integrated MT6691 LP4X buck for VDDQ.
- The integrated MT6691 LP4X buck for VDD2.
- The pin header, to plug external I2C devices.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 4683704ea235..35cb142004a4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -87,6 +87,13 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&i2c0 {
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {
@@ -96,6 +103,15 @@ pins {
 		};
 	};
 
+	i2c0_pins: i2c0-pins {
+		pins {
+			bias-pull-up;
+			mediatek,pull-up-adv = <3>;
+			pinmux = <MT8365_PIN_57_SDA0__FUNC_SDA0_0>,
+				 <MT8365_PIN_58_SCL0__FUNC_SCL0_0>;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins {
 			pinmux = <MT8365_PIN_35_URXD0__FUNC_URXD0>,

-- 
2.25.1

