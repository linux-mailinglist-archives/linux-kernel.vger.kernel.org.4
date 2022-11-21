Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964FD63259D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiKUOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKUOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:23:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028713EA8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:23:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n3so3538495wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLTLi7Z7FiKWId+bi8fZkLc6EVgRkKs3skyHC5sG8CY=;
        b=D5V9EF0OejBZwuqpXWui3ZalpJ94bdEGZUloCx4GdvNpwOu9DnvwMeBnDCPDI1vp46
         AGFcpmiIvx+gkVhyBOQnmNadzLjlkAaJd40zYPC7juQ7zSpWS8V024Im1PK6bd3RzqiX
         s7wxVLjufCv/PrmyEFEvNG0y31n8d9ZTC+LQeKmJqeV7LETKBBo1Yy5cd0hUhqFSGIVF
         Djdl1Im3wRsOrQCpl08PJVOEe5hQvCd3aEmJYgsXVaw1mhZ5bOEVNf8AUKU0lYOAhbAy
         E/U6awm3Pe3WLXI4jtWCv4avCJhKROA1HO6lb/tJYpFaBfNAkReYvX/lilAdSpcIwTKg
         EDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLTLi7Z7FiKWId+bi8fZkLc6EVgRkKs3skyHC5sG8CY=;
        b=nVmlwvjbFR39vJX0qGdFAY/bV68ol1GINriWXonbWeRbJKXZI95DegQJPyK51SvX61
         q+rL7a7qU4YlxsxBFIRwvjrLVmKfOlup1VDL9o9xK2leS2md5VdRo5soB2esRiAhmYIp
         JNbUOVOAsTZxHdkIqB7wBWoWwNSoWfBaw2nRWwRFZF/161r7iUEEaemg48QiQuO8x/a5
         iWG8VB+pv/Cct7xWvhp59SwohJmySmFrooe6OIOBi9eEGONgFff1uXtlU42FXcPomb8A
         UmzGzY7mAnOa7qLluhwXOBoT3MRBL+wo6aZiz4k/Vq0QdqoOFJ1k/3+a9E8ygnnv7HM3
         pp/A==
X-Gm-Message-State: ANoB5pk99sQjxZ5jcEX0A/nqMtO/QF+10+fFZXTlrlN4UI/uUVwAb2Fy
        M4clhAs9rWxnQFOIMmsXTCze7Q==
X-Google-Smtp-Source: AA0mqf4in6pPCN0j2CQX8M6zf6umy322ySdxWk1PP56QJInbjwv4ZjaMUm16qPsll5SjfuP4QxNrwg==
X-Received: by 2002:a05:6000:983:b0:236:aacc:ea07 with SMTP id by3-20020a056000098300b00236aaccea07mr11745338wrb.36.1669040593275;
        Mon, 21 Nov 2022 06:23:13 -0800 (PST)
Received: from [127.0.0.1] (2a02-8440-6441-244f-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6441:244f:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b003b4fe03c881sm20206468wmq.48.2022.11.21.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:23:12 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 21 Nov 2022 15:19:11 +0100
Subject: [PATCH v4 1/3] dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v4-1-bdc21e1307e9@baylibre.com>
References: <20220919-v4-0-bdc21e1307e9@baylibre.com>
In-Reply-To: <20220919-v4-0-bdc21e1307e9@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Guillaume Ranquet <granquet@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stuart.lee@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the HDMI PHY on MT8195

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
