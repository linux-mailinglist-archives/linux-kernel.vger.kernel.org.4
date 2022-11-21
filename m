Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B319632BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiKUR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiKUR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:58:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E294C10544;
        Mon, 21 Nov 2022 09:58:28 -0800 (PST)
Received: from jupiter.universe (dyndsl-037-138-187-016.ewe-ip-backbone.de [37.138.187.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADCF06602A8F;
        Mon, 21 Nov 2022 17:58:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669053507;
        bh=71vz1dJK9c6n63dYwAsfDrn+l5+x0pdh8gpbYZj8WaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXLzBLt5fOdOBotmgEjvdSI+5OSvI3s49e0SxvUT0DXIS4DMhFUmRP5oA8D8Vj3IR
         oLE+6aEyybPjWaV8ImqnZSRbf6mPDGeLp1UJSXmR+zVia0px91i8qYZjmva9RQKIUn
         8F7eLbpcKRc/9qJymRjCnloYLWi4eczHeBhYeu1tbJwXfCS1JE+nYvTalcmb6+A8Dj
         FOzxmO9szoTkb/kgJThZ5+vjZEtvJZ3rnmOhjaZowhwdk0PQ+U/GEZwUDpp4TpENJx
         CTVYIO6sHgesQSj/OTn8gSwnd0GjJCcktBEucC3FJIC5zKfV+A9dVRYEyiW9appEA9
         YRk0Suzmayq/w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 18E5E48011E; Mon, 21 Nov 2022 18:58:23 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv3 6/9] dt-bindings: arm: rockchip: add Rock 5 Model B
Date:   Mon, 21 Nov 2022 18:58:11 +0100
Message-Id: <20221121175814.68927-7-sebastian.reichel@collabora.com>
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

From: Christopher Obbard <chris.obbard@collabora.com>

Add DT binding documentation for the Radxa Rock 5 Model B.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 70aff0851ae2..49d442afe67f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -625,6 +625,11 @@ properties:
           - const: radxa,rock-5a
           - const: rockchip,rk3588s
 
+      - description: Radxa Rock 5 Model B
+        items:
+          - const: radxa,rock-5b
+          - const: rockchip,rk3588
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
-- 
2.35.1

