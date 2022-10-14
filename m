Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF35FF129
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiJNPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJNPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:20:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F126F272
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:20:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bp11so8063011wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W2yVD4YDWpQ3CdxVHUW7qDBpRLK/GNpv3OQ8xCAesQ=;
        b=wdd/7aN7YhyT8sy0Wn7Mag45qih26IWdRYbT5Iw2wQ0ZJWbWLh1lhND7KddPc9m84b
         AZt82xojAp98dl7fArcn0k3wQxhoqknF8aTX1ZhUH/hv50S00H/MVzafj5z2u34JC3wZ
         +r4Ug1XI1ju772lSNkLc1Xmn0MGDpbwon7IyCu/JEzG/eRCyLnzvz1f0HZZSyMjWuPlr
         S9stoFaXkDAPz30zm12InbQLbXyN8wqGx7fTOCcr3UE15bpkMMJeu6wyvfeonSxz737y
         NL0EbvQeO3NufGmA0jubTXPFpkEhE3XrhSPgj8JqywzHvk45b1HhGqYdjG/D+7/WcJfq
         ZILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W2yVD4YDWpQ3CdxVHUW7qDBpRLK/GNpv3OQ8xCAesQ=;
        b=GrNDFQwCzuAT46y8lvz+RspKPVAI97Y5RFR+O0lr3z9eDf1q9HYyQZieETAVYpXiyO
         Lb8vfrGlD3LSOjJGbc6oQQVuDBYXhVfeK1d6GM0QQRpAbymnaW0t33R7zt+8Pvp9Yj/P
         bgLyOWclTxOYZddFnj1VeXg7BrjGulWwy4V1iGo398eeruwyzprX2TepAfSMV3Es9ruK
         FyC+UBG/JfNx/O7r2B3p3HgaSyDbSpUq5BQCF/H940x/c9yehj3eCSFZjcCY+0HuZQYs
         zVfhu7VLLMdg1ygr+ocpYCeX+Hll0SP/d3YJBuLNkOynpLAqa55ZW791jh49D2cSC3Wd
         kI3g==
X-Gm-Message-State: ACrzQf11p8S5ET5RwpmQ/YxwXnvTlg5mhXLLmGvoCwZrKOIjDbWeM751
        uFsrLDwVoLerlJfa1MtjbwJEaQ==
X-Google-Smtp-Source: AMsMyM57zNuBSZSZskVONFl0D1EsJq67LXu5kElRP3jBck5MkzoVEBxigmx+zHaO7rTqRHHqajVoCQ==
X-Received: by 2002:a5d:47c5:0:b0:22e:6941:81eb with SMTP id o5-20020a5d47c5000000b0022e694181ebmr3733750wrc.408.1665760822143;
        Fri, 14 Oct 2022 08:20:22 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6241-7429-3074-96af-9642-0004.rev.sfr.net. [2a02:8440:6241:7429:3074:96af:9642:4])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003c6bd91caa5sm2818223wmp.17.2022.10.14.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:20:21 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 14 Oct 2022 17:16:04 +0200
Subject: [PATCH v2 11/12] dt-bindings: display: mediatek: dpi: Add compatible for
 MediaTek MT8195
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v2-11-8419dcf4f09d@baylibre.com>
References: <20220919-v2-0-8419dcf4f09d@baylibre.com>
In-Reply-To: <20220919-v2-0-8419dcf4f09d@baylibre.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jitao shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Guillaume Ranquet <granquet@baylibre.com>, stuart.lee@mediatek.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mac.shen@mediatek.com, linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding documentation of dpi for MediaTek MT8195 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 5bb23e97cf33..2c7ecef54986 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -24,6 +24,7 @@ properties:
       - mediatek,mt8183-dpi
       - mediatek,mt8186-dpi
       - mediatek,mt8192-dpi
+      - mediatek,mt8195-dpi
       - mediatek,mt8195-dp-intf
 
   reg:

-- 
b4 0.11.0-dev
