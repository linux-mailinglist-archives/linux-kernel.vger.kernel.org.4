Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDE66E60B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjDRMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjDRMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:08:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6601B758;
        Tue, 18 Apr 2023 05:06:35 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E624660323C;
        Tue, 18 Apr 2023 13:06:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681819594;
        bh=lLoigGWkJxfCsqJmwio7gez8QFEu8vijF5k4UrUjSpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvEeqpus0tcroeu1p8vBBsVDt7A+RRKrD/3inm1Y86xaaeCCPJw1uqx/gbnXG2LrD
         jD2+6qkSe09ErDCfxbPjrlZ6uwUswO7EXZOQ4QYecpYJV4TrfjKXmKGo1vhhhmSMRF
         Vf7pKeKzpg7G3hUdW2qHj4bOhB1HkBT/euuYAyWSAD9KT4wFKN/lydQxy7zk3CEJEw
         ONW2KNAlgVYNH8a7GlIeIqk/QCMm5LvXmkvANBUIkW2o6Sp6FTzYNrlpHi2QFAHneX
         czxNEzac+UnOhYsY7wu5epEbybhPdKHnt6UFqTxh1AT0v2p1giTP8bGUYTPeGo188w
         8h477zrxlB4tg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 2/3] dt-bindings: timer: rockchip: Add rk3588 compatible
Date:   Tue, 18 Apr 2023 15:06:23 +0300
Message-Id: <20230418120624.284551-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418120624.284551-1-cristian.ciocaltea@collabora.com>
References: <20230418120624.284551-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Rockchip RK3588 timer.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index 2bdb6e6bdb21..19e56b7577a0 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -24,6 +24,7 @@ properties:
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
               - rockchip,rk3368-timer
+              - rockchip,rk3588-timer
               - rockchip,px30-timer
           - const: rockchip,rk3288-timer
   reg:
-- 
2.40.0

