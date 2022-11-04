Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC9619918
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiKDOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiKDOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:14:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F192F66A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:14:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y16so7206667wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W2yVD4YDWpQ3CdxVHUW7qDBpRLK/GNpv3OQ8xCAesQ=;
        b=ZH2Ico95zCvYIhFHVP6NHK4O/87cVBVR6I9hbo3P/sVcFSUVcKKppKz+maSYGYhi/D
         NpWIm0t4PyoLdvM/bAya2RMTCsQjh6R6c4Cjh5iAX7AqelzO7RmfgrbbO4RPVAVa2tLJ
         jZXhQukTuY9Rt8GMWWEbmF706RL02veZ71ZVo6MaEMeUTUXpBedIdFTivAIRSJ2s4zFp
         4RdZPY/12nY/Ezf+WkzWCrcSR/n/J/gf34saIWlVTQkuIwNvronXLtYil6Uj0fCmtaK7
         7Fq4nsJoJFqqaloQGy2CBzCrYwLCoJWdRlm94Clm+S2A/n7/ZOj7+mtuj2MKfs5XUDQ9
         MQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W2yVD4YDWpQ3CdxVHUW7qDBpRLK/GNpv3OQ8xCAesQ=;
        b=iAAecQDen2Lx90lF06uf/QdUbuJhQC4xE70LO5yNCxcMrzYl7DPYEsKtdPCp2M5dHh
         BLfnnV10bXU9udNdERQ8r3yjQ4pSWCgVi44qnti6wcWqJMCF106RXxhsYUoGP/9lbCAe
         6NdziQBj//34zOOsFa9Osr8eIhNJDQ/3UvFvdviHABxQxYqFb3vkyO8Z06gPn4wfDEEW
         jN65pW/5YZbzvMgJv0q3wTZOGkgVIySc3jscLMvm0THvWRIM7XtT+7Hl+63Dykd4t8pv
         Ai8bMqdunESFqwxhi0ehyJVYno5GSmtJpaVR2izUWlDiPc1jhC3QUOKr9YNDdXumO5rO
         57tw==
X-Gm-Message-State: ACrzQf1CrNRlJQS4bNf3CRZXh9aqLG+X7kENJybLTozSJacxolvUcvvy
        h/mCZmL2Y0UTI9WJs6ymxe+h5A==
X-Google-Smtp-Source: AMsMyM5UgSNrJdjJbaWkNmPYq6dn0dMCmkzxuRJCJIVsuSJ/GH354TzUrpT1mXY6Xoiz6vRA08LnyQ==
X-Received: by 2002:a5d:59c5:0:b0:236:cc8a:59fd with SMTP id v5-20020a5d59c5000000b00236cc8a59fdmr17239311wry.426.1667571267873;
        Fri, 04 Nov 2022 07:14:27 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6440-7fff-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6440:7fff:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id bj9-20020a0560001e0900b002365cd93d05sm3594512wrb.102.2022.11.04.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:14:27 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 04 Nov 2022 15:09:57 +0100
Subject: [PATCH v3 11/12] dt-bindings: display: mediatek: dpi: Add compatible for
 MediaTek MT8195
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v3-11-a803f2660127@baylibre.com>
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
