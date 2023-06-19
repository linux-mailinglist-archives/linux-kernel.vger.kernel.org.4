Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AEB735D93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjFSStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjFSStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:49:11 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC9103;
        Mon, 19 Jun 2023 11:49:10 -0700 (PDT)
From:   Furkan Kardame <f.kardame@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687200548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AdJOrsfn+EjXmTCRjY9atZ1E+lqcObT34k7FSpSTYes=;
        b=FrLVapj15vZ7KBbR15UTnHU+GyBHKLy/UW2lCy6/rPbORi7BU6tcZ+jEW12WGbgRioLP8W
        Gd9UoGvm/thtANfAH2hHXyIAazbdgwbN7ukx8J3lnl378T6qLIDqcp2l/o36mtefLyEtNt
        1TnmNF6xEZR08NsMiBNtxDY5LouG2bk89jmP81z0nsLeC2ZPtX1B6tRRzTiEoin1ZKnnFP
        XY9LmXx4v46t83EK9BWpUGrtjuxK8ej5KCCFG/xX/KJ4k5KiSUMFAN30gqVaJsSdjk73zJ
        K1MB8O7f7x4bjXCVZ6717oCFd8izIf7xHI4XD++EQ5/2N6S6o3MpGCavc1iRPA==
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Furkan Kardame <f.kardame@manjaro.org>
Subject: [PATCHv3 1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
Date:   Mon, 19 Jun 2023 21:48:55 +0300
Message-Id: <20230619184856.23066-2-f.kardame@manjaro.org>
In-Reply-To: <20230619184856.23066-1-f.kardame@manjaro.org>
References: <20230619184856.23066-1-f.kardame@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=f.kardame@manjaro.org smtp.mailfrom=f.kardame@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Station P2 is a single board computer by firefly based
on rk3568 soc

Signed-off-by: Furkan Kardame <f.kardame@manjaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ec141c937..fa21640bc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -185,6 +185,11 @@ properties:
           - const: firefly,rk3566-roc-pc
           - const: rockchip,rk3566
 
+      - description: Firefly Station P2
+        items:
+          - const: firefly,rk3568-roc-pc
+          - const: rockchip,rk3568
+
       - description: FriendlyElec NanoPi R2 series boards
         items:
           - enum:
-- 
2.40.1

