Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB46B83AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCMVCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCMVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:02:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60C8C955;
        Mon, 13 Mar 2023 14:00:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j11so54046627edq.4;
        Mon, 13 Mar 2023 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA3EusZCOhK627Wk0FirSH/GwKNGmUqwf4ijzEsCNuk=;
        b=DiOQ7LpQ9BueYA5S5WwnImfMJeB+W428SPYWHW2VPcXaBWdV53EPgkhu8Uunn2HLDX
         H3l+hmiEN6HwBhf+Bk80dRnMkuOp2Dd+bZwsDGFGfZiYxBqzAIpJf7yPEQHIsA+yoSNp
         Mj6SHaJJs4wlgjhEdiWuol833lJWGTgED9Nri7CGIr1cYgeicyOw/FDN+oYemLy52Zhj
         WGTVC2Td3pK4CBvNPuXlNv+7rbvTM8kAP/pJufiN6g4LQ2Y63kzC/A2V3IX1DIqkvrM/
         KWoG/vb/GelWeH5k1uP5n60zzE8pPCe8SQQgyKAGOQFjwkhG7KLB3GZM6yYfHW9Tc8NI
         gS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA3EusZCOhK627Wk0FirSH/GwKNGmUqwf4ijzEsCNuk=;
        b=ZeQrmvDYd6OvSSweVU+6FsxB8gvlr54m2DXuhh5OXB9T6lTv7ONgxgsd0+hup2PwqQ
         jWTssI373U++h7BlZU6hNT7w5aGEEZNUXuMcBx3lZs65UtSrJtWGS4GbxvaZanNc6DRa
         wgLBh9FpWWuih9Xis7pUcq2F1OgkPxING3EHSqL6NECqjv5yChbruAcEES6pCc5x/ceV
         mOKNMFoihDEMNIWUcZYjhJrut6lmpoqVi9ikV61/MVBIsEbCNlrAVYmABCFhyjIZWfKm
         D5BXPIIWWM4fd0z4rXvA0a/Hg5hD5o+vTTRklCdSvAzneNyRS/0a45s40u2WYcDwjvT+
         1r7w==
X-Gm-Message-State: AO0yUKVALl31+aAUE2s1DAbqEkk+TjFa2sy4WtAp6F2YWsKhjhaI50OF
        b0cNOVehpakYpZD08Z6RSCA=
X-Google-Smtp-Source: AK7set+xc/A2AUsEpnkeSAPo/NefGhegXt8FflrkGyYZI98MGsPQwOInyI7rwtArMe68neAJkvQ48A==
X-Received: by 2002:a17:907:7241:b0:884:fd73:8053 with SMTP id ds1-20020a170907724100b00884fd738053mr46136247ejc.9.1678741244643;
        Mon, 13 Mar 2023 14:00:44 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:44 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
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
Subject: [PATCH v2 21/21] MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl
Date:   Mon, 13 Mar 2023 23:59:21 +0300
Message-Id: <20230313205921.35342-22-arinc.unal@arinc9.com>
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

The Ralink pinctrl driver is now under the name of MediaTek MIPS pin
controller. Move the maintainer information accordingly. Add dt-binding
schema files. Add linux-mediatek@lists.infradead.org as an associated
mailing list.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6048bbe0e672..f4ee11dab1ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16521,6 +16521,28 @@ F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
 F:	drivers/pinctrl/mediatek/
 
+PIN CONTROLLER - MEDIATEK MIPS
+M:	Arınç ÜNAL <arinc.unal@arinc9.com>
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
+F:	drivers/pinctrl/mediatek/pinctrl-mt7620.c
+F:	drivers/pinctrl/mediatek/pinctrl-mt7621.c
+F:	drivers/pinctrl/mediatek/pinctrl-mt76x8.c
+F:	drivers/pinctrl/mediatek/pinctrl-mtmips.*
+F:	drivers/pinctrl/mediatek/pinctrl-rt2880.c
+F:	drivers/pinctrl/mediatek/pinctrl-rt305x.c
+F:	drivers/pinctrl/mediatek/pinctrl-rt3883.c
+
 PIN CONTROLLER - MICROCHIP AT91
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -17496,13 +17518,6 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/boot/dts/ralink/mt7621*
 
-RALINK PINCTRL DRIVER
-M:	Arınç ÜNAL <arinc.unal@arinc9.com>
-M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
-L:	linux-mips@vger.kernel.org
-S:	Maintained
-F:	drivers/pinctrl/ralink/
-
 RALINK RT2X00 WIRELESS LAN DRIVER
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
-- 
2.37.2

