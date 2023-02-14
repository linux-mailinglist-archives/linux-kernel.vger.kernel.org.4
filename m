Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3A6965C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjBNOGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjBNOGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:06:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718B1B57D;
        Tue, 14 Feb 2023 06:06:06 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:37c0:9b2b:ec16:1f37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C98A96602169;
        Tue, 14 Feb 2023 14:06:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676383565;
        bh=bhnO24On4r3VyKtUOKpWBYh2OEyQQ5x6bFUZv59MOAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pg6OBVJyaQHluVAsZrbWTHr74qoKpTLpqDz4PGiCAzfgEGGzPzupN9PDr9ZSt9kHM
         QbqJaGlSb6UNjuOZuCsFhv0vRcb7SZslGMNQqKP1qK5viqRwpNiAIWXM4TXW/U5mq4
         4tk0yDXaeZfPd16elZtbrzBAcCnURe4nK0zXn5qFcfE8sCXsuaeK7avr8VtE28/2QH
         GPaqL4HP+mI241EFbeuHXuaxZs1VA+q4MbHYlLskq6CaQ8Rzq8QrhnMuik8agjTbGh
         VTvYCvBZ8QE6rhcroroHUMiyzG4yB7HC9uuVpPd6oqcVRjEEE5kC3e+f+WD+L4nsEa
         0ATn2bMOAhKGw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil@xs4all.nl, nicolas.dufresne@collabora.com,
        jernej.skrabec@gmail.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 01/12] dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
Date:   Tue, 14 Feb 2023 15:05:46 +0100
Message-Id: <20230214140557.537984-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214140557.537984-1-benjamin.gaignard@collabora.com>
References: <20230214140557.537984-1-benjamin.gaignard@collabora.com>
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

Add compatible for rk3588 AV1 vpu decoder.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index 6cc4d3e5a61d..8454df53f5cb 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -24,6 +24,7 @@ properties:
           - rockchip,rk3399-vpu
           - rockchip,px30-vpu
           - rockchip,rk3568-vpu
+          - rockchip,rk3588-av1-vpu
       - items:
           - const: rockchip,rk3188-vpu
           - const: rockchip,rk3066-vpu
-- 
2.34.1

