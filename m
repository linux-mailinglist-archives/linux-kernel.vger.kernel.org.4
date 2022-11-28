Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6825863AD95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiK1QWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiK1QVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:21:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435D20185
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:21:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d1so17711766wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS8cQQ4bUCIGdTuiAN/aAd8jqSH5EJokFUSJdAjidPI=;
        b=0+jl/jbubFkfZTQZYgBADk0y7xxrO/2O6QnzOVhd0Ay2GZ3bHMfzNgrtNe26Sz8wrW
         x+gpWK/PWX9RuKHQi9Ch0lKr7Fd2CxuKQcJefXlOvLsbdjQbfpN81PLo5z6u6RrKZQ1/
         dY0NeCNnghuCx5+smHJpKR5x43S7aUls/hwRPXFC3u/Z7e49DZ70Ni+XFVOcAUJwZU4U
         LbehBw0bXN9VsXSVv3+SyJrjfLxG47GWP1E1qPhVnl9qHUwRU8OrPseNT2rJvgdixZnD
         tix9Ry5TWNyILcL7MiL4+CyOFJc2kjHhqnjEuH53SjfWTtCwAbhBDmrA64Ain9vGGAl8
         dlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS8cQQ4bUCIGdTuiAN/aAd8jqSH5EJokFUSJdAjidPI=;
        b=71RwpUm/n6Lcfn4DUmDnQWWXhjmqx+6QJNb4YAK0dmbtPfkadakdS2HWPBcanx8aM3
         h78gSd4mtsWlys9wztoMrDn0HDMEzy46OyH+ngD9b0OyLQLgBNlXoU8w/iE1uNvO3QFZ
         Ft9QMdeZZQGEhvYuxG/z1QkhTkHPNq3DWizlkfq/Fcbs0NW+PGu/QNYCK7n78RiRxfaY
         suH2Uencx/eFGsfySnm0I4WGl4QOxjIFiUEailLTk6AFgQYGfVQfxfXPkuG5xbd1N1aI
         eBwl993DYZb/57x255AYJkQi/Nlk9g6ZlGsf2xOUC+To5itVzvJMbdphoCfZCV2AwQZH
         bYZA==
X-Gm-Message-State: ANoB5pk67pLMR9N/N6uh73Vz/f5kmQcTB/gPMRbLvExmNXGuGvzOC/69
        gtxTEBd3x23J1noKomQrH8x5JQ==
X-Google-Smtp-Source: AA0mqf7zILY88KtlDUpp9lKnmVPVFaeVSYmrpe6eWbhZCXd1jcABe1SItKMY2e2rfy2bYoaSKhc5bQ==
X-Received: by 2002:adf:fd01:0:b0:235:83aa:a6ed with SMTP id e1-20020adffd01000000b0023583aaa6edmr30496312wrr.543.1669652505287;
        Mon, 28 Nov 2022 08:21:45 -0800 (PST)
Received: from [127.0.0.1] (2a02-8440-6340-f657-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6340:f657:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003cfe1376f68sm15311450wmc.9.2022.11.28.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:21:44 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 28 Nov 2022 17:17:36 +0100
Subject: [PATCH v5 1/3] dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v5-1-f346444bc459@baylibre.com>
References: <20220919-v5-0-f346444bc459@baylibre.com>
In-Reply-To: <20220919-v5-0-f346444bc459@baylibre.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     mac.shen@mediatek.com, Guillaume Ranquet <granquet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        kernel test robot <lkp@intel.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the HDMI PHY on MT8195

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
index 0d94950b84ca..71c75a11e189 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
@@ -28,6 +28,7 @@ properties:
           - const: mediatek,mt2701-hdmi-phy
       - const: mediatek,mt2701-hdmi-phy
       - const: mediatek,mt8173-hdmi-phy
+      - const: mediatek,mt8195-hdmi-phy
 
   reg:
     maxItems: 1

-- 
2.38.1
