Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C86BF41F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCQVcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjCQVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FA2F793;
        Fri, 17 Mar 2023 14:31:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cy23so25349146edb.12;
        Fri, 17 Mar 2023 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=277v3QDHxGQ1e2vDSHNJ1RgrCQUtqjYsBl0P+spQaKY=;
        b=AKZeqzQtnCUfHf+sC2z6FujqATaMDElVe1Kb7asiqi2gApeooDYo+dvNc18Yi1rnaC
         1vzmZ//1f4NHby7q8Imaq7/tO3LMrIp45cKpL2wo466wrDA7wX6rQiPdWNgztj+59QwC
         OgwCOtJfLbmTScN4eySQ0Uu+fGls2BB6afCCIYzyZeqaP1BwFGCe+IVy2NSdZCJnYDwv
         /6Q22L8kwHDYAGEj8fwePcOXZsQqI3Es/o7xX2TB7Y+W+0hgsap8voTvZt4F6vDxNpzO
         iV5XgWUyGF6rs4pf45z5M5Eqfa5PTm+DzXL8alzLyJsJ5pOxdfcVGWvSqa1RfmsgJCg/
         PyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=277v3QDHxGQ1e2vDSHNJ1RgrCQUtqjYsBl0P+spQaKY=;
        b=qbJ4sle2ZCO3qSq2fCRX9gkmFhuEDiTJ2z2SAqmgp4EGPPjAPNpC3eBMg+vhcJWVd6
         ylhAA102hMHdpBbPT02+8roy8WMydURmZYEcw+YVmD+ev8h7kWzGt5FxTRXcP1rdmWWQ
         RGdujb3V0PbHqp3QIA2XSZfi/ffGgVVijEwZAtJ9/9lRRBdZCnsIFh6iUj+us18G9M62
         pXAOL7+Qdujf+FuGTSI0QpqrR8CJUCY0LfX68JMRSKqQcQ9IMRHU4L4iEZcBOUZwcAd6
         8nzuM57CayB2+DzryuxLR7rkN8SpWVcygnvdAUbil52CrUN76MvjULS1fHSyTXXmDZa1
         iZ3A==
X-Gm-Message-State: AO0yUKXDIPoYpRrum6ioYnnK63IB3BfWdcqdnybhJ6rd7FMJcOjg0YZD
        tw39M0niCs5Z0ZEt3nZ82WU=
X-Google-Smtp-Source: AK7set8J5Y0Ip/HTJOArW+lQprOCLQawHAUMxX8XoeiqqznMShgkzJGiK4AMIN4ygknSUFodhayigg==
X-Received: by 2002:aa7:d6c8:0:b0:4fa:785d:121 with SMTP id x8-20020aa7d6c8000000b004fa785d0121mr4391276edr.16.1679088657090;
        Fri, 17 Mar 2023 14:30:57 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:56 -0700 (PDT)
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
Subject: [PATCH v3 16/21] dt-bindings: pinctrl: mediatek: fix pinmux header location
Date:   Sat, 18 Mar 2023 00:30:06 +0300
Message-Id: <20230317213011.13656-17-arinc.unal@arinc9.com>
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

Fix the location of the pinmux header files mentioned on the schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  | 2 +-
 .../devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  | 2 +-
 .../devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index 5e80621800a9..3b3d59140073 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -90,7 +90,7 @@ patternProperties:
             description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in <soc>-pinfunc.h directly.
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 1d038f6f8971..e5e7143674b5 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -131,7 +131,7 @@ patternProperties:
             description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in boot/dts/<soc>-pinfunc.h directly.
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
index 51b3d1247614..028146fb173f 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
@@ -88,8 +88,8 @@ patternProperties:
             description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in dt-bindings/pinctrl/mediatek,<soc>-pinfunc.h
-              directly.
+              defined as macros in dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h
+              directly, for this SoC.
 
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
-- 
2.37.2

