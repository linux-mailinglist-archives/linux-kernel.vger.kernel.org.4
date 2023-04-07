Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A2C6DAD10
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbjDGNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjDGM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2185CA24A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y14so42279545wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872386; x=1683464386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GH9QAwye48bejYcJsmUVDgnU+lbK1EZ9+5kkrqikkcY=;
        b=dJoEXYLUUXARddvkn4UfLqbOwHRdNGJHrM1fmI8IhuUHJypyLiHAYTq41XQVd9PBtO
         9s0tteHgDXMzDeZWtmU8sA55XqmB2LmjIfKJSsygy47Mve55843Mfijid7vtBtGi8SWl
         +43iiIXTBw8XjKt2dcYCK3Eo2jzFD8A06NYZiPZ794aYowkL07h79g2qlb5+QkcOSNr+
         Aa5otkaRr0ohaTPkwKk2F2gJDFj+aEx3LlS1moeXa2y9UAZoqX9r0Pw2/Fe19+19LaBQ
         dJBTn6YsCiXxRKs6hM9CTZePLKySJQKhvi4wQTxc5o6M+QPGBPO/JEvTp290edVTNt71
         VcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872386; x=1683464386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH9QAwye48bejYcJsmUVDgnU+lbK1EZ9+5kkrqikkcY=;
        b=Ri/ahTUKSuXyp92wFnoOvCmU5MNl31W6fSwP+0JOhZwGyssfD2YqfwAAQAwD6bZW2/
         OzC7ER7ntAzUMmZ0EykXwDg1vijDHs2j7jELrjrcUIO5T0PjLcfp7hNd/S6cTxvcmZeH
         sAqyh7GLvpGy4HEfETmdJU5snYbaTCCUQ3j8Jl6zL0C/H1EgtINp2rKuXNx3BhwbgMTs
         Bk/8MFBm99iI4brhPAAUMHKWVL9W5JBGonEJt3LNiSQ4F59M3Q6YIqRC+qlzNwOgDson
         JDd3DlRwvrR6TuHjOe+gLTe482Sh2K1Li0IQpN8nG8xjkDFW+gqrslhoYPuYLrmhVqAC
         m04w==
X-Gm-Message-State: AAQBX9d4V1ZWaMOBZWBmdO+O7rerQuV8oHtd3SkVf6gRJmOMyUDpk+GR
        xb6dwp0JZtIfhWs3+Xv10GFwRQ==
X-Google-Smtp-Source: AKy350btLadsciP/gSaGWtPYLwPPb9Fq1p+JbXZoIAtbDFd3nxVyKLZJhwC5EPrOuQrdfqLvex6ySg==
X-Received: by 2002:a5d:50c1:0:b0:2ef:b5a0:35e8 with SMTP id f1-20020a5d50c1000000b002efb5a035e8mr196350wrt.20.1680872386639;
        Fri, 07 Apr 2023 05:59:46 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:46 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 14:59:24 +0200
Subject: [PATCH v5 05/12] arm64: dts: mediatek: add mt6357 PMIC support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-5-1883c1b405ad@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=O8w7thwfT5MR8VFkiJw3MJIje+8Rl/nHai1vgZPIVV8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO6NUK3q6T+uECyCgPL65LBXrFxIh/qJ7KH4IgE
 RP3l742JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATugAKCRArRkmdfjHURd7rD/
 40k2d9gb/Y/bWntaEH/+BuC7xgqfUmd0aunIoMmg56TqxmZ/f/tOKhKqAxhMyQV5gYodCPb+7YX04Y
 XEx3CX2A3b383gpA6VTUjIk5hxr6jpWaEVbJ+vo197+UlAOTcak0WiCSzKHhk8bKUIr/363rDGpGbi
 IKaphgMh/GsxsEtdAZaGol9V7r1xH+vi6RZjGZnnRqKlhVebw/JbuGKRW3ARp8SoYnG068EYxUFNQg
 7JDX2KaQ0Qz6uYgNSGFTUm7EOWkfC5k3tzYJzYEG07PWORL6fvLHnaffo/VNRnMCwqRrONaAam9fLR
 GyjHRavUuinx4lCFJURCWo+HKGbuNB5QacT7QBOFc/g0Ncx9L4tfKjBHf0T09Jlzux8j7g0Uo6OIof
 glkd9ysMTBFAGL67XvjeEo8L0eNXy6oc5fPvcVxJnRYIMEb4ujxcZ/gfUVxHZB3WHDWm/Owps0IPNv
 ngHPLv9OMXdSv1BDw6PpvRwwvCuxxNcq6wdrFg2kBH4QO+p91Ka1yfRNXjS9jR4Xxr/USYs0Nj4Ai6
 xO7Cmvv6LAiU5hNPySOPUQl44wce6jt7wupJRhUyV30I5QKPzOmWYduHy1M+wZ+5+AsgRp9NFB4o+1
 XQ/QEF98IK6R6RFItrLo2Dfap5MS1E2il6WaeFew2OwN88SGZZXmVPNujvfQ==
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

This power management system chip integration helps to manage regulators
and keys.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index dd7da86420cf..a238bd0092d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
 #include "mt8365.dtsi"
+#include "mt6357.dtsi"
 
 / {
 	model = "MediaTek MT8365 Open Platform EVK";
@@ -94,6 +95,12 @@ &i2c0 {
 	status = "okay";
 };
 
+&mt6357_pmic {
+	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {

-- 
2.25.1

