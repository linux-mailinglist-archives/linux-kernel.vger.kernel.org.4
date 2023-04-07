Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2B6DAD17
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbjDGNAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbjDGM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF69EF9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so42238894wra.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872390; x=1683464390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OS7Sye0IPLu21f+Xi1LC07CtmBlPzToUPrfZNf6CO3E=;
        b=S/fsg8L/mGih4FrM5STj7n1V7lYfXP4QCfGKRFFxTreuNX5zDtf2vexBt4uxIL93TQ
         wdz6cHYAN+WD7dry13Fq8vLPEYplUMavXnV6I0ifQyurJXouApvbrpQRnnEhCeazFHqx
         U+RAszdaE/U+smX4G/1G2qZMhC6ktDzeUb4cdABYWLIFqHYtcwWEGnWnTv8x8lbHY2ID
         dTNyqkCdoZqkS6X/bGYGJCu8Xe0CoHB/s94vlLt0PzFoTfhLEjvU/vmLLqxLMPy1d3cg
         0K1668IJ1rcL7FmhOqTC+D7c9b54YVO6bZywGem1dPuO2xSueEvV9jyCbmVGDY0yS4FP
         of2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872390; x=1683464390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS7Sye0IPLu21f+Xi1LC07CtmBlPzToUPrfZNf6CO3E=;
        b=6k81wbmJJtbq0J892u/ODoizdOCxBXcLfQLOfJs+F5butxrK9YonUA9ogMRuL9kC18
         oS+q+kVXr1K+yfLFRDsIGkuurj2SWbieF1xr6+uwWhXmNJTlfx92pAazPnufZvvjI+wK
         A17onGFKUWagvA9FN34N3oXiU0nkoM6iNpehw09a22ZwVMEuVTeYibYq6lX65o5XHcbM
         btmb7hYgzuRoR+DoFJf/y2UpmKIFd3LbNcuSjXceK6Ls9Q1DrUNJlqIIvO0oHSx+qBff
         CVLNb2bKxHF2/dlubeKMAdymUc0lNEYQKVh0oMQQ3bVqwE3Lpi5ZbikhA4j0CmIQX33H
         cd4Q==
X-Gm-Message-State: AAQBX9c4TmWGCEDhBRjL6J+uh1Qv7q36yQaWcNOBatni5V89uJpefu5Z
        vr9O+Qqn1t5rhr9rukJ/ul0ocg==
X-Google-Smtp-Source: AKy350YSqDbwpqlTeAn/rb2199Ze25ghk9x0ahK7dXbgGhMTjWux8Ostb1nw1+NIhd1Tu54Ml2XSFA==
X-Received: by 2002:a5d:4286:0:b0:2e4:eebe:aee3 with SMTP id k6-20020a5d4286000000b002e4eebeaee3mr1166263wrq.60.1680872390303;
        Fri, 07 Apr 2023 05:59:50 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:49 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 14:59:27 +0200
Subject: [PATCH v5 08/12] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-8-1883c1b405ad@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=fWeFY0N26AVZAJlISCaJeet0l8YjLAinj4NBVfmxvvQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO6B8EEk4RvcvkArYDsSmADxohNcPtVSviSaDT2
 yhxcX0yJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATugAKCRArRkmdfjHURQvhEA
 Cb51lDZgNpI4TXbu6IxWdcuWpTkZLgumOT9wrV2FW9H88XRvaBVERxPKm2tkNi6Mw/S94XbhrLhrMd
 70by7FXzioMFGT3HIy56g5XJouSAHFprJmeM14CyWGeriNd5gszIB0fEgbau6loKNkaWZtt3fp68le
 jKJcPrxaSdlMHRvALub1A4gwkOv1ggLlJOozaY2vkcULu9ZLxKXO1IcXGRYZFTvUy5zEH0vu3UWkDK
 5/i7i6DpcIixaonvF9uYK+xhn9PDKx5DiJDAtMjPrzWgBfP5zRXqILLWF1lszghE4LmKEseTXge8U8
 /mzv/ygHbMLJ0PsP6d4vYMUEzj5ZpG8H/nA/1Nh1oSnLJUQloup5Nz2vgVE4GD/6KhHsip1t64TehC
 ROXgYMpXNfq8/NKsTRTsVYQcW2IgI055jDv8qj+CsLrmXEUPeDAAiStOHZocu2hCGjsQS9cKbXBqCN
 TEO3tuqYqJP9bh61zSPNFW2mGa3er4nawAmjrJgRW16UTf0OAT08cEel92JRh2Qfj3CFtGG5eQlK1G
 VyGBGuMfJlQNbdjx2D9/uTcaOFVxGGfKbtliG2ZEURQtTMO9GN87JgFP4dwkvPEG5hWybVf+t2cFQH
 7CplOmlyx3oAzp0hs0avkNNSW3L0oLgaJavVY7ETIY6IxIJ4JIhzZeT0yDJA==
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

This patch add support for SuperSpeed USB, in OTG mode, on micro connector.
It also add support for the Extensible Host Controller Interface USB.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 1c36d8f19525..9760f181eb34 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -314,6 +314,28 @@ &pwm {
 	status = "okay";
 };
 
+&ssusb {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	pinctrl-0 = <&usb_pins>;
+	pinctrl-names = "default";
+	usb-role-switch;
+	vusb33-supply = <&mt6357_vusb33_reg>;
+	status = "okay";
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		id-gpios = <&pio 17 GPIO_ACTIVE_HIGH>;
+		type = "micro";
+		vbus-supply = <&usb_otg_vbus>;
+	};
+};
+
+&usb_host {
+	vusb33-supply = <&mt6357_vusb33_reg>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	pinctrl-names = "default";

-- 
2.25.1

