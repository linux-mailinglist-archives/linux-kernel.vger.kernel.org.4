Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A045D66032B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjAFP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjAFP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:29:04 -0500
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6BE8B75C;
        Fri,  6 Jan 2023 07:29:00 -0800 (PST)
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
        by mxout4.routing.net (Postfix) with ESMTP id EB07C100464;
        Fri,  6 Jan 2023 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1673018939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXaEWxtn0uFZdcMKR1HVawy7OAcOEaMqyiThbbGx/JQ=;
        b=S/OG9VJu7Jie4XsryCXN+BCsu/4JyG+TriwtuN2mEKRjzjeSTc1W+v0l62yjfb16cdHBhC
        PIajeIelKfTTMeSRr+CblgRXpzhZM4gKT0BCWIJXNf/YtYgGaoKOWVFGI933SndPNT8siJ
        ymfwtp3ZCqVSqcSNuqBUug7dEICig0c=
Received: from frank-G5.. (fttx-pool-217.61.159.6.bambit.de [217.61.159.6])
        by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 46F7212272E;
        Fri,  6 Jan 2023 15:28:58 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v9 1/5] dt-bindings: phy: mediatek,tphy: add support for mt7986
Date:   Fri,  6 Jan 2023 16:28:41 +0100
Message-Id: <20230106152845.88717-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106152845.88717-1-linux@fw-web.de>
References: <20230106152845.88717-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string for mt7986.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 5613cc5106e3..230a17f24966 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -79,6 +79,7 @@ properties:
           - enum:
               - mediatek,mt2712-tphy
               - mediatek,mt7629-tphy
+              - mediatek,mt7986-tphy
               - mediatek,mt8183-tphy
               - mediatek,mt8186-tphy
               - mediatek,mt8192-tphy
-- 
2.34.1

