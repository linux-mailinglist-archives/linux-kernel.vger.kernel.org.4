Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8237B6944B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBMLiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBMLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:38:43 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB55DBF4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id c26so26303175ejz.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Uam+EfbMJvYSMYj1PNEm4eMKYS9JSHriCql+8aR0/Y=;
        b=KyqOQ0df6FEgf9gICiV885GCDpndXa+lmmXMH+DHBPy7eqxKtfXKKn9XGwj5dOCd6h
         U600WT99CJeIqv9SN6dPkfq0n4AdBZyCCft8S0+uSYUvsTfSXOh1dM3Gmm1KRCvwTaOg
         vHZg+EZMweMGUw8maNeCHSMmQoFyn9CQ884ySoEmqQ071FtHiOwavfrDcwDJKYcbKwYg
         T2/Tg+Cyzs0EVPv6bU6wvrI5RjxXX7t5e8HJg8sfAMcBUoHqTnQd+XA5LQzjBDiwo/cR
         3PK/NvdcMiUScimQVDwhE09vdgZdPEj3XHUAc0ErMJZ/7qPSXtzOFuJ/szdkX7SG5cJD
         pByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uam+EfbMJvYSMYj1PNEm4eMKYS9JSHriCql+8aR0/Y=;
        b=LaaJWtvLCqrb+t9JwBWnJ8oJroT2yc9+6TmVXBIMIb032D2GNTV/UMwNuZyglJ3OyU
         /QG5sjkdmizyk/uCUQTnpP/6Qqf76Yy0kuHKfsEDdMoEd3g1LCAOjKJRIHovHmBXxgGF
         T4AVCoWx5JfvJJ7FOmX5qC55+9SAvzDX4xKa5DeqFns4wFBks4eQArwMic1/j4BD6d4x
         O8efg/P8yBQH5JFyC5zoqkAGZU2WlhLuVk+bwij0VAgyYDW0S0CrBSrKOY0gIY/KOMTn
         E5I/1m0ZR7yuMdbZC3skaHkhKkyImJWF03j2PfaVMnYW+rpioeIyTPV2DrDEAmoJoRin
         mI5Q==
X-Gm-Message-State: AO0yUKWTY2dART2tKkzA9do4UAl8ZlrWSX3AIyZycCbUeOfl6o8HeP7Z
        cZm1u19yGgkj/HS4fC8RzDd2rw==
X-Google-Smtp-Source: AK7set/M9xakFWvqD0VD285d3nonWBNhQ4te0JGTGn3C/66m1GVrSXBBXD8MX5r0tcSBxSBOBeAiBQ==
X-Received: by 2002:a17:907:75d4:b0:872:14ea:1a7b with SMTP id jl20-20020a17090775d400b0087214ea1a7bmr21115151ejc.13.1676288321224;
        Mon, 13 Feb 2023 03:38:41 -0800 (PST)
Received: from [127.0.0.1] (2a02-8440-d206-ae05-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:d206:ae05:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906061400b0088ba2de323csm6638792ejb.181.2023.02.13.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:38:40 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 13 Feb 2023 12:33:32 +0100
Subject: [PATCH v7 1/3] dt-bindings: phy: mediatek: hdmi-phy: Add mt8195
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220919-v7-1-b5b58c5ccc07@baylibre.com>
References: <20220919-v7-0-b5b58c5ccc07@baylibre.com>
In-Reply-To: <20220919-v7-0-b5b58c5ccc07@baylibre.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com, Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.13-dev
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
index 6cfdaadec085..f3a8b0b745d1 100644
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
2.39.0

