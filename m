Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C515632BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKUR7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKUR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:58:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579210B53;
        Mon, 21 Nov 2022 09:58:28 -0800 (PST)
Received: from jupiter.universe (dyndsl-037-138-187-016.ewe-ip-backbone.de [37.138.187.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3D226602A7D;
        Mon, 21 Nov 2022 17:58:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669053507;
        bh=rmr7jmOc3usxVuB8ZNLkxxWpQr+udADXnGkXF4GvmyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQc3vARhhExM4JDSo8w9Z0lDBtvJ1R6pQRPeRaCeQpjfPzzENF2m8q1SFReblBMLy
         vQwwBCN25zjURFA63Pp/oQuGJRwA1+QWeRJYZJEqF+r6WLZaSNaOwNmG8lvoDlrzqn
         UthJSktsj9L91jkIZGigntOVUQPUpf83Key7wMZ7HdmynevaVSnZiMQYWPQ9J6q45q
         gW9jgw2D7o7vmJZZ4ZzcYk0ORWXPhAEV8qXuYq1hHozmi3gkWA4Dd8AsgYvpztERv3
         f7weJGRAopK/DtjFPzBoWbRm/mfw3VL6Uos3weAfCPSaxKcbY3F8uHMl5JueVTohiu
         VrPhELYlzlPTQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 177FB48011D; Mon, 21 Nov 2022 18:58:23 +0100 (CET)
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
Subject: [PATCHv3 5/9] dt-bindings: arm: rockchip: add Rock 5 Model A
Date:   Mon, 21 Nov 2022 18:58:10 +0100
Message-Id: <20221121175814.68927-6-sebastian.reichel@collabora.com>
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

Add DT binding documentation for the Radxa Rock 5 Model A.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 9b7ac0903262..70aff0851ae2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -620,6 +620,11 @@ properties:
           - const: radxa,rock3a
           - const: rockchip,rk3568
 
+      - description: Radxa Rock 5 Model A
+        items:
+          - const: radxa,rock-5a
+          - const: rockchip,rk3588s
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
-- 
2.35.1

