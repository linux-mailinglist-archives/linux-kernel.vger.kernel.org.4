Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C91737484
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFTSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:48:01 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ABBDC;
        Tue, 20 Jun 2023 11:48:00 -0700 (PDT)
From:   Furkan Kardame <f.kardame@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687286878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AdJOrsfn+EjXmTCRjY9atZ1E+lqcObT34k7FSpSTYes=;
        b=w7uvhxMsi9vPxgDJlB5G2+PebI6fpimR0bZIrarjfbvO/cfqrD0ohrWsZuBrcleRE6PNlB
        PwxdY+FjLW0EIHK+BgBmTcbcPc3WVZbPJ4w22BoRlZqBDn7TyGemydqff37HBnmazsxmUK
        dehUGXWMctu6lll/iauS1u8pUdC1/bADG1ERU2wXkOw82ByxQr33jvOpyF8HL/ZDgEsJbW
        ZkJ7SdpVzeMH8+eJWkNLqH4g7KlaJhJPFM4x8NCoNWSxQ6k7Cwt0RtfnMsYh0j4qDgyhjO
        teWLnYHSXKCg0h+EfUhlnBkdw3GDNm1IR5weUTqZtVQnAmdhln8WC7FLiO+RWQ==
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Furkan Kardame <f.kardame@manjaro.org>
Subject: [PATCHv4 1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
Date:   Tue, 20 Jun 2023 21:47:45 +0300
Message-Id: <20230620184746.55391-2-f.kardame@manjaro.org>
In-Reply-To: <20230620184746.55391-1-f.kardame@manjaro.org>
References: <20230620184746.55391-1-f.kardame@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=f.kardame@manjaro.org smtp.mailfrom=f.kardame@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

