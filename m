Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA36B838C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCMVBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCMVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:01:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885836FFE6;
        Mon, 13 Mar 2023 14:00:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn21so23867737edb.0;
        Mon, 13 Mar 2023 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1EO681NLLyGQFHGfJf2gv1cVQUWKJ2bHIXepwv2glw=;
        b=p+Ht8kEwWQVBWrm7LbVKZZP1kAizcIUyIo0vjcuRnquV3lDbYV2dVfhZaeR0PYG+dl
         aOTM3J1qVO6QVjKAQv9yRE5OwQoKzrneZmL2gl8dgGIrKwJV3VkeyP80//StuFRKkJel
         LJNbbaHUXg15eKrSRqiXtV4xtCnMOwpO/1tFBFqVp7G6DkDESTodgxC7E5ABl2KYnJOd
         66fauggi47slQOAZLeaL9gRcVbgF30l8GuP/3gMOVbJHSQGCpY+4+62nZ0LLeCUTKH4L
         euM86uk5LXRM0oVNA5tAEUQ7cRw5d+hyAEwNK09F8g5TLNriU/DpiLZ9cCJSGnMlpFI1
         bo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1EO681NLLyGQFHGfJf2gv1cVQUWKJ2bHIXepwv2glw=;
        b=BvtTDg92nwgZlWqj7wVKvQ8Vcvo69Wumj/W9xd3OpPAv4oDUhnnHF2ohAEkaUiDggL
         mL5QDlAek37qLieglXgtctJmvZNQSrm+DHffEOseXgwui2gY4C/US+E0LENvJ0Cper/g
         s4cxAgJq3zyja945Zz87zrfqkHa6u8cwZ2sCxGVWBxWw0/mUe1qirmnHrYslM7eIBTKW
         3hZXFGMuJ8ek88PaGOiSyyajlw5QW67PVY6aZlWIkVvqnfjI+4OSx3ME05WMsF030+0Q
         tqdaJX3i6xg/VTte1k4EGrVNRpJRxk1EgX1YU0yRBzUoKRnAKuhrJti0aLzG6YO/A26r
         Fr4w==
X-Gm-Message-State: AO0yUKWPELIaraohSdDVLSLEA9IF6K4mZEKKiLPtTSM4dB6UZ+QOMgQ9
        XM5Ruf48G465uVRBlXlWW0Q=
X-Google-Smtp-Source: AK7set/NwnCMVaKCHebK0llGSJTd79DjIqPgRgqeEVRZgG2AZ6tsRTFCH9D4B9Nd/al8H2T0Fvi8LQ==
X-Received: by 2002:a17:906:7c0b:b0:92a:b78a:8fb8 with SMTP id t11-20020a1709067c0b00b0092ab78a8fb8mr4426489ejo.37.1678741224361;
        Mon, 13 Mar 2023 14:00:24 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:24 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Subject: [PATCH v2 13/21] dt-bindings: pinctrl: mediatek: mt8195: rename to mediatek,mt8195-pinctrl
Date:   Mon, 13 Mar 2023 23:59:13 +0300
Message-Id: <20230313205921.35342-14-arinc.unal@arinc9.com>
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

Rename pinctrl-mt8195.yaml to mediatek,mt8195-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../{pinctrl-mt8195.yaml => mediatek,mt8195-pinctrl.yaml}       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8195.yaml => mediatek,mt8195-pinctrl.yaml} (99%)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
index 66fe17e9e4d3..7b3dfc14eedc 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8195.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8195-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT8195 Pin Controller
-- 
2.37.2

