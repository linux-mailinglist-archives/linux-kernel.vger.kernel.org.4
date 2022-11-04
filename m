Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D36198FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKDOOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiKDOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:14:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3075C27172
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:14:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5so3123704wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=li+ooNBePGxuv5adSrcu60bPx2IUcKrfzonF2RWQwto=;
        b=zR9PNCqP6LnfsGUVgC20l61o2e/4yuW58vmlf/xo2BRYL3BoOJKLInNIhJkmLVrhoF
         Xzc3czOjrEs/5KzBYRKyaCGBvVIvWdtvVOhMCRqmOhgglalyAAbVHmwG8O0aLu+UMX7u
         cvtKHzUKILM4SSPLJUng6/LOpay5HFoMOWVoN9MGSJacVudS83/y27LoVZiuyYU+J1Ny
         vHLmR4iCRMqREQzAuRLSHFQ5TeTNnyf//ScHESkxGLdiPDS1UFs1jv5oDMAe11/0wZS5
         O/wFpOwUiAFdYMRrlew+JFvUDYMv56eHxOV1xK73rgAWXHrvPMx0lI6RS7wOe9LqCVa7
         hGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li+ooNBePGxuv5adSrcu60bPx2IUcKrfzonF2RWQwto=;
        b=iTkpuW8B+ljEl2aBhZyzdnxjCa5ObxRg9TsvczyosSExat2BCzfpPVa9NENNyXuREi
         yUwpRQJAP9GUBN39Ee5Yc+o/i0aJZiSYeYH9C6lLs+0DjJTXF/qHWNIlNCxx7Fzrz8f7
         iotgtVRcZ/M8A8ArU7X7xr+rOsXS3Hs28iWLnRztGu9bJg79uKx2+smR83cgI6M9iWj3
         GuPiWZHuc0PDJs6fK6KruCxCDc0i5ZTdrW+Qnyaqbg8jTsrbXKtLodnjhOLWZYXyoo62
         DnzJslkiFc+7gPfgaB2SMsoV2RDjZnD0R0yb7lQUl9uNkcH9rtDgLVNE3zFgRDPhTYyE
         c2+g==
X-Gm-Message-State: ACrzQf32ZobPfAzpYnpkHLSdo2B7ANXVGAGcYsKGJuib/aplwf5Bkj/w
        ZcTSn9PJC8n4UG0qse7pdsO7Jg==
X-Google-Smtp-Source: AMsMyM63r3C5u1drFWJNKOHbN490iUTdHFjO5ZeWcbLnzzuK//cTCIVyTn05wzs5W6KfxlqKz7l7MA==
X-Received: by 2002:a05:600c:4394:b0:3cf:75a8:ecc6 with SMTP id e20-20020a05600c439400b003cf75a8ecc6mr17784154wmn.74.1667571248761;
        Fri, 04 Nov 2022 07:14:08 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6440-7fff-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6440:7fff:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id bj9-20020a0560001e0900b002365cd93d05sm3594512wrb.102.2022.11.04.07.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:14:08 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 04 Nov 2022 15:09:47 +0100
Subject: [PATCH v3 01/12] dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v3-1-a803f2660127@baylibre.com>
References: <20220919-v3-0-a803f2660127@baylibre.com>
In-Reply-To: <20220919-v3-0-a803f2660127@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
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
b4 0.11.0-dev
