Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B907662AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjAIP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjAIP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:58:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695AC3724E;
        Mon,  9 Jan 2023 07:58:07 -0800 (PST)
Received: from jupiter.universe (dyndsl-037-138-188-006.ewe-ip-backbone.de [37.138.188.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5BD66602D66;
        Mon,  9 Jan 2023 15:58:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673279885;
        bh=km48d5+uuKrtU+jKn1qKtyEltR/pLoMVSjioNlT7fVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nf0xFuko5zzi4eZUcjfYrUhiPe2+GuTSWoK3DTHfniIqB/75qVjkp3V87wC/PT0gv
         NDnoiLJt4W21IQ7U1Ci7FHqcegoiODCt6l1g2N+DHC0BlmXb1oTuHqp0d86JyXIYTP
         ctIG0Eja54e5ZfzVFgm7oiRBrRAGitXJtLO7Aey4kpSWHM0Ny9rYh0/v7RSxOXsiPZ
         jBmYTRewuiB9l5AlKzYSJoUAABa7crnoqrA4lA0EixRfaWo8NL5apVjH9P6mtrp1co
         FsBHO7OWD/R2IhValq643efCojzNzyirgHFs14Lb2FVlKaWZPV65+jhY52d7gWpKxv
         j2Fchz4vQJAzQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 804BE480119; Mon,  9 Jan 2023 16:58:03 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCHv8 1/7] dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
Date:   Mon,  9 Jan 2023 16:57:55 +0100
Message-Id: <20230109155801.51642-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109155801.51642-1-sebastian.reichel@collabora.com>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com>
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

Add IOC and PHP GRF syscon compatibles for RK3588.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 2ed8cca79b59..e682b407a383 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -20,6 +20,11 @@ properties:
               - rockchip,rk3568-pipe-grf
               - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
+              - rockchip,rk3588-bigcore0-grf
+              - rockchip,rk3588-bigcore1-grf
+              - rockchip,rk3588-ioc
+              - rockchip,rk3588-php-grf
+              - rockchip,rk3588-sys-grf
               - rockchip,rk3588-pcie3-phy-grf
               - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rv1108-usbgrf
-- 
2.39.0

