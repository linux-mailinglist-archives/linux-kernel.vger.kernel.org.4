Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377CE6A8E27
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCCAba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCCAbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:31:03 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F688580EC;
        Thu,  2 Mar 2023 16:30:43 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b10so814937ljr.0;
        Thu, 02 Mar 2023 16:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q22B9e4AqGn4ANGF/h7CdR30XMlPsngwjkL2VZrpA2A=;
        b=iTZYC1pHzt6hop7ZrN+oW7oTwwJQJiF+dFkFpN5vu/3aKsHaWel3EHdLG09y5nphIu
         uRUOnkF4wS5N+88RDJw0cVqLWnetxnh0jGe4wQXYKgsBiiz3KQza3H5s7Q3xZ3Ec5nnd
         Kt5BGDqDxP/hkjOEHEB4YRcHf8VDrU+X0CzUg4NSyZRluZ+0sKgrPZYH3ii1chXUB9An
         j/+mcHqGX8wUBJX9CL12leiAV9jL+ayEMFcPtQDjNfdpp8PqlIdEiuTUwWjiDcPkCpcf
         KCPTRgiEojYcW/N9KRfg175ODAp+7XxTncZsC0kXBSOupFOP93Nwe6Qor6pMW4mAsgOR
         zWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q22B9e4AqGn4ANGF/h7CdR30XMlPsngwjkL2VZrpA2A=;
        b=4BpaF9p+kYFWK6MGI+c5iZl4Gn412X32Ypsav9vXiCxbuqUf/sHEqPpP2KWbE+imXp
         O+mQM2UfwA7UijTK2g2jOOw88M4djuOw3tKMAi46PQleRVhGI/pROnIC96D+0EUvUcex
         04x3U+YeG5Mx9z+vK1MZnArYX5LnVyB1pLDLP7Tj3f+lnOuNi098orre+Qrkwgc3K4aS
         xCzQfv6pBfns+PGwlRxEj7i53/DOjkMRk31ub38ue2A96lW+UJiZLnER2CB/FR2eHMNi
         0pONtqz2bS8CSkteNqsfeuRTL/zyt4zB+19Z1UryvjQ7/AamUwze77W3mh1/MqWpw83+
         rwGQ==
X-Gm-Message-State: AO0yUKX9/ZpL8I91QbBeYVj+sX7RClKod4sdlDK8DY2mmkdqrCaJpile
        iohp319Vt/f52OXTlxgY+zZpvKGXHT3gTO+s
X-Google-Smtp-Source: AK7set+iJs4ye68oj0zjVinNre8fXa8aH/Htsp9voOCx+O/PIEzx/7p22PjVOe1fKlfXS+hLPSg9gQ==
X-Received: by 2002:a2e:a0d4:0:b0:295:a8cc:f15a with SMTP id f20-20020a2ea0d4000000b00295a8ccf15amr3553070ljm.29.1677803442926;
        Thu, 02 Mar 2023 16:30:42 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:42 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 20/20] MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl
Date:   Fri,  3 Mar 2023 03:28:49 +0300
Message-Id: <20230303002850.51858-21-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
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
---
 MAINTAINERS | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a851eb053ca..83fa1e9651ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16541,6 +16541,28 @@ F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
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
@@ -17486,13 +17508,6 @@ L:	linux-mips@vger.kernel.org
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

