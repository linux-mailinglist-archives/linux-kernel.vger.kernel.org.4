Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015A36CD559
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjC2IzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjC2Iy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:54:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8DE1734
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:54:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y14so14859408wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igjjn7nnejMTz1eixMcGI3oknnIp1cLnv8QilS7wOFs=;
        b=1pckWm5lqVJim18m13Jqwrrt5hZmCx8O5deDD4Fd3ovp7hrrVULpjYqNWzFYKkkghn
         tJTMtgH7Yya2Xq7DoaTfMpLdQmHuesJXMLMSYxi95IL+R4ZKARuKAHhWY76HAbtoe6F/
         txjRmArhe26LoFJ/TN30UTbNHFA552As7Bn/nPTNz6GlKWzbbIjJJ5wVUdaaPSCJXDPA
         HIOvyqDifBE7u5lZw9nbdT9rZQxgoZsQYlua99lT9TFBVGIg4XLRUbjTPycwS9ZnQC+x
         ZjmU7IWK1PwHNb/2xRBJLA8cl9yS4cYswyaP8rfNQg40x5sZab2LTWCBeWf10E8umT4o
         rMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igjjn7nnejMTz1eixMcGI3oknnIp1cLnv8QilS7wOFs=;
        b=HdpfE8A4YMXg3NRwTbnR5sj+sm5QNiMRDu/y2dyuJNz9+jkIx3bG2vpWLOZZ3TRA+o
         JyZmEOA/mwdbwCKEgd62vx7sz6PMDMJyxoIPelcFEA9e0S7T3FAK6SQjRbDPcPULTUCT
         qyPIIYCnaf/vnEZvWFQ1/Cy73ROUR8Fnldb4U6wVXT9Dc3b4SCYtwqnI591T0iP/Ft51
         Ur7spMW6vAbJM8LwPBzimtk/Pt3oChgLk0R9xi7mxAmMScw6xxHvq9VOPfAFhhwIQcYK
         XbnXAYGEAdXxECucs6p6+AsdXvBTdmj8D+6ppuOnb1Gfnew1akGYitTBbe1O6BF1XOjv
         tu1Q==
X-Gm-Message-State: AAQBX9cHp9UPmIUPoE4rBlnkZcjC9KJepQBhY5Ihw9x6WVkeyYYOfyi4
        OdDeRfNjnl/vB31a2AjAOfaJBA==
X-Google-Smtp-Source: AKy350ZoMcAOyKvTBVaeDbCCQd6MvOOZavs5uIwd62wSfVmNOv4g7SBuoNg9n+CdyQ8Y79xV/XFLhg==
X-Received: by 2002:a5d:6647:0:b0:2cf:ed44:693c with SMTP id f7-20020a5d6647000000b002cfed44693cmr1251632wrw.31.1680080094702;
        Wed, 29 Mar 2023 01:54:54 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:54:54 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 10:54:22 +0200
Subject: [PATCH v3 01/17] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-1-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=GtS6oI/KN5oVnvp16fjoQNYsWiITnEz8YK0eFeooLks=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zbJXFbmFNHEMPjqJ2mO2eYE9irHz0jp12ggc5d
 YIXQH6SJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP82wAKCRArRkmdfjHURSSVD/
 0QZO7k+NJY8iRztOVHNHy4/lEF0q+OXUaNYoaPGTBhP/QoBNgf48B0/DPRmbmbaNhzJQ7Qh7vTeDHg
 H1DrLD3618Llgh40XJrc3lQ26UsFSJK4+UW5ljiIfsgG6ePXG7RmXwBi/TS+dzTBBZSe4yGHrxKhhP
 bTPqXZ/jBYu3VyE0KLqBAGWKmSSGz+zF5Ik0Fe6WKaazUd8thAnLVwE9lxejHCFU5RWNcFfWBONM9Y
 lhGtnaM+6WsZgCMokP4JUtO1t9WRvYlhKCNSJKpya7j5nTXtUPhOtEJyiBbwdrUN5INa7DX0Hf0y5K
 cqQY//Z37HjaIF5nric4YNpY2IMrvmYBxoSbZrdYI++wfvn/TxVAoGdtNUi/NmBdqtR87Ga8a83C6t
 S0fQ4/xrVRdddriRQpCOoQ69erEoaiT4BzLfhHw665qyaanDtzf0uqh0XM/Wj2wmB2OMRvZdrxsEpI
 LykMMYcR5/8JJd0zbu8zVZM9Igf3tMdwPzqt8yk/RQDR1iZkyJkJvXmHze8EaEc+0qnk/znYKmvw7S
 eELX1dFzEprTqDFsDmbT/s6C02LlFDZQAl8XB1+z+BV0q30SnbQgcSumXDwj0CyMVAcV0xMRvTwtxL
 UMDde/CHH4YNBoImWJWPRryAN1eOM7886kIZD1RYFlWBEt5/Hm4JHOmQSn9A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt8365-wdt

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 55b34461df1b..66cacea8e47f 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -38,6 +38,7 @@ properties:
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt
               - mediatek,mt8173-wdt
+              - mediatek,mt8365-wdt
               - mediatek,mt8516-wdt
           - const: mediatek,mt6589-wdt
 

-- 
2.25.1

