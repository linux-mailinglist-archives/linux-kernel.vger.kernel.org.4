Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17376BF434
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjCQVcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCQVbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0319BE1939;
        Fri, 17 Mar 2023 14:31:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so25370210edb.10;
        Fri, 17 Mar 2023 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA3EusZCOhK627Wk0FirSH/GwKNGmUqwf4ijzEsCNuk=;
        b=SzjAbA2qsawtxmUxI1XuRk4mZffC5q2hSDgqbFtLfE49cZ3+PZdeenZnNp7Y0SBOll
         gYrqyca7M465hBdEXzA2swDdCSxwjoQGx16kwpodEGCMXhItidBxbQIdeDd+m68DL6IN
         KY413kGA430d3GTBArcfyP+B84Ar+FhdVcHpujv5QISjot37GImrKvG+B5RDPFYTtIXh
         TSPaSyo6kcV+TfMngTjm4bL6p/nbNf+Gb0ihJiz/nUqReMQG03I+/2myV/yfVspGEls+
         8fCOtkdytqKI0nxCMFe34xpIO+Sx/kwa3OAL1sUBGA3AHy/259Um2vaW/ny9E4AzeyCI
         OvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA3EusZCOhK627Wk0FirSH/GwKNGmUqwf4ijzEsCNuk=;
        b=u7wjs6O3SMBFmI7TH3Fo72X9Ees3AtKp5njAPqBgmheyL0E+oDyMAFV9iZi/Se/Aow
         u3ztwJcnkQQkRele4OEIT8URxL/8zj28DCuibwk7YXirT2E1ULqPgnVJSjO/OH5U2jDw
         s9cUkBh6r9sy/WMS2EnfqG8i7PZkHxPPZMKGKHJavuoZ98/fuc+PgfHDLDj3lNbbnbhb
         hlb26yld4RFawLPwSfHhL5ePJpNfFsyvFh4mH7Ql4xVeI0ptOypd34mVwNbNXpvY+eJi
         jhi7zEZnhtDq/iR5+2Q3C5xZzJ1mvv3ZMFMaPE+QWs8XJs5+M0FgD7MB7Y274jT4Vi6q
         4gWg==
X-Gm-Message-State: AO0yUKWzfErOeWsgV/aV2ryVkAyzioRdWDRYA7iM7AzeSJFl7kTfcdih
        rR+Mhxr+twxy19/3puNhy7c=
X-Google-Smtp-Source: AK7set/PsH37vV26HFz0DUNVPwUSw8kToM24rwlbs1ygRWWocDwys742MwLTFeeRwnWp9Vpfbez3bA==
X-Received: by 2002:a17:906:5017:b0:92a:3709:e872 with SMTP id s23-20020a170906501700b0092a3709e872mr859654ejj.19.1679088669349;
        Fri, 17 Mar 2023 14:31:09 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:31:09 -0700 (PDT)
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
Subject: [PATCH v3 21/21] MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl
Date:   Sat, 18 Mar 2023 00:30:11 +0300
Message-Id: <20230317213011.13656-22-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
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

