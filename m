Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCDD6CD59F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjC2I4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjC2Izj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:55:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04914EDC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so14857773wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dNu/yHcKe6XE6P0BXTDhxax+BTFAlj51fPshovNp84=;
        b=dKS1xTQikBkAUWbUbeweB1ty6gQOw+SeO0EHFM5IRhAHfnBlSFyqc66JDBGwE8rpeU
         DBQUZ5svqAPbxxsNgJfUPBeBlaeI2DbgH7OPmBEVgozVYxKhhBpP/+HeWNdQdObBmBrp
         YC+jBA7THSDU55qqaU3NsuTqmdBPVj3N7DZtmd77woHo8fqQtNJvKB/gtEyS4HsQ50aI
         WgPBQHVeEcRX0lQl4uFLsJ3G4EDUEu8g4Hi4etlghnqGBUOd9ElfZ3f5i5uJ4xFPyPDM
         aXZofS+s8/9jFRv7Zt4VViWfyEpQROVWcPEGE84SUaFTHvJzogQLCg81jmREgjL/O6Z5
         Z1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dNu/yHcKe6XE6P0BXTDhxax+BTFAlj51fPshovNp84=;
        b=6fSNj/O0++QRIuPk1/MbQ/0RwTXpA9rpfVs55DLcJkmbNXPZrj81DjCqUIsrBvMIfw
         wD44OBSCSzWBASyahexrpF3AnuCuzI726upOP0T9Xry43N9849b2CSIB9naAgOkORNem
         wPBJlBxob9YPIx74m8zosIergQNRNvvRNTL586wQV08/JKLJ3Qn0LO6UC4YKvSqdRmXw
         3JZebxT9FCCBG6q5WupmtLMTtJ2KsQCRW1A4V1tmld3a1YWNG9Kf3AgpRIwExKcoqu4s
         BPOSwnO3/v1UIHBQbW24njRwJSWZNjQzMpNJDQ1SFgsJIjO0NVPrGlYNexvhKBpA//W0
         sWUQ==
X-Gm-Message-State: AAQBX9e+iDtIPO26nBIGUOc4QjXqWwcNapzbPQGgCiRCYZBvUjgg4rit
        iTv25bYB4g+IiZV7oK/UPMEEjw==
X-Google-Smtp-Source: AKy350Yop67dGlqTahEGHCkmUG4PMP+3YKBPdodkLoUj/Dtd3ftOlu+EiCPbc8oNU3rF7KipQ1oUYA==
X-Received: by 2002:a5d:564c:0:b0:2de:bb7c:ea16 with SMTP id j12-20020a5d564c000000b002debb7cea16mr10684242wrw.37.1680080111205;
        Wed, 29 Mar 2023 01:55:11 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:55:10 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Wed, 29 Mar 2023 10:54:37 +0200
Subject: [PATCH v3 16/17] arm64: dts: mediatek: fix systimer properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-16-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=+UMf7BGwqr9S9F2Y6i650CVFdcd7ChQf7ofZelsC0lc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zciyXZEJx+wDiM8bVq7sw6ESNQTgEPnH/YfxhD
 O322rreJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP83AAKCRArRkmdfjHURU6/D/
 9aZIBu2JCMOBy1o0zsHejPIphVYBMwQyultm5Hz7EUY5aqRCcMsPjLTgjwExXP7LqGp6q6eZi518r2
 IRZjNcwS6Ennm0ctF1xXhqQWFStjNwqEe6qsbpFZqoB3jkHCbw0/QhHkZeRW43MKNx5+ySCSQame6p
 VQDrKptAb9A4COVHwjYpHP/z+D/cAxTzvy8+Hrej/d9MiEZOk+f3JqY4beERhDAVU5WzkMwgZmd7g6
 ziBaFMNjKlkyB2n6B4JK9/h4nClQUhwsGzi5MXgZSVslxHJBeB3BiIaJ5K0tAfp6JSZdIGzij6Jk6/
 yL18+39TBTWoVOm8DPnTkvYloe+Jf+BWyuEZv4UKulDrb2hYkdd3JFi/rqgBe2YQo+Vl3W+Rhuq0O8
 hO1BkGfYni/WPNReiYhFqVcABjl3K+NNxzTnH246MF8bkOWHJ9FDectOPsKS9YfWWRlzUUuB2TGK3S
 AqPCtlo29qQHaS0QShPX0USmK0ZsphSKHwaI9AHxAVKyDOL75tap1PYNGd2RFTdJODINyWmQy5P73B
 S5TjGjqeGZrT2K0onCku7GzwPSbMDpLdnMnhK1rXFxw+ZP5FLsvUobOxzsORyGKzN6zjwiT5V6j259
 0dkDiDnJBmMID2uO74ESIVA2nQG+k22SuzuD9lzGzZMCsdX2ncuwQc494KxQ==
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

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

MT8365 has a SYST timer (System Timer), therefore the compatible node
should be "mediatek,mt6765-timer" instead of "mediatek,mt6795-systimer"
(which corresponds to ARM/ARM64 System Timer).

Plus, register range should be 0x100 instead of 0x10.

Finally, interrupt polarity of systimer is LEVEL_HIGH.

Fix the above properties accordingly.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index c3ea3cc97a47..959d8533c24c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -575,9 +575,9 @@ system_clk: dummy13m {
 	};
 
 	systimer: timer@10017000 {
-		compatible = "mediatek,mt8365-systimer", "mediatek,mt6795-systimer";
-		reg = <0 0x10017000 0 0x10>;
-		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_LOW>;
+		compatible = "mediatek,mt8365-systimer", "mediatek,mt6765-timer";
+		reg = <0 0x10017000 0 0x100>;
+		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&system_clk>;
 		clock-names = "clk13m";
 	};

-- 
2.25.1

