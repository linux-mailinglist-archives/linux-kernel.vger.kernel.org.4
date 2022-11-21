Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29932632B96
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiKUR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKUR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:58:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0310544;
        Mon, 21 Nov 2022 09:58:26 -0800 (PST)
Received: from jupiter.universe (dyndsl-037-138-187-016.ewe-ip-backbone.de [37.138.187.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71F196602A73;
        Mon, 21 Nov 2022 17:58:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669053505;
        bh=BhOzmXV+pjyrO9kOToC4JgQ/3OrwnGhzEgYAPhdFtf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/Y8nCZeJ0ZjDeepTj10ZRHA9fd39+76JjUr+99NgqxpolfC5ZYHckD30VJIJTdE5
         cTm2MoG2zsipl2ZpMCb2e1xUwWzhohD79ZiZj87DmivzYN/lEQ0J5T7eh7Wt0q7Yuh
         whefEnEQYzqkEJIOwUlSDW2RohYyqHJIn+nixWTnA4O6d91kSGwdjhzNHqVItF6U88
         uzYhj7jqgdfdqHWhbG5aLSquauz4sXKWGvgl5FD7gjpntDkmUdxY90tyMXT20pVt+m
         v0JsRhtFcuYPnCxw8nJn8pQUNUVxv8ntusiByQYsTtPydd0shCZy7NhoAqvFYXPLzK
         8yhVmL1SG6nlw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 14E47480117; Mon, 21 Nov 2022 18:58:23 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv3 4/9] dt-bindings: arm: rockchip: add RK3588 EVB1
Date:   Mon, 21 Nov 2022 18:58:09 +0100
Message-Id: <20221121175814.68927-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221121175814.68927-1-sebastian.reichel@collabora.com>
References: <20221121175814.68927-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Rockchip RK3588 EVB1.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index c6c69a4e3777..9b7ac0903262 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -704,6 +704,11 @@ properties:
           - const: rockchip,rk3399-sapphire-excavator
           - const: rockchip,rk3399
 
+      - description: Rockchip RK3588 Evaluation board
+        items:
+          - const: rockchip,rk3588-evb1-v10
+          - const: rockchip,rk3588
+
       - description: Rockchip RV1108 Evaluation board
         items:
           - const: rockchip,rv1108-evb
-- 
2.35.1

