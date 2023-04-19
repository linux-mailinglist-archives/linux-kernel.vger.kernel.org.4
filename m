Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681216E8105
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjDSSNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDSSNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:13:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E5212A;
        Wed, 19 Apr 2023 11:13:17 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 712CB6603263;
        Wed, 19 Apr 2023 19:13:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681927996;
        bh=8mHiEdYtricQtv90csR7aHt5nQURoxkm/vNcQ2Jjvuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBT1CQEILyBN0EEzhGCls1OHWD15cIh3MfKOIPM0Gh8smhtu7RENdRlnruPiiXctX
         TNXWLGkEneBGxGs/nmjvpLf5qu7pdCWEfy/Qn86NJO68JcEEOC6jYfP+EOayL9RO2O
         hE6J2mobMF72cy9itk/qrb3sEi1Iclw9arYXUukMDC+4h6NX7d4itoiMRK93Waw2hW
         EEDKGIL3J4wx+e4UB+byFFt+08Kb+Pvo67/zmWEtjq+5wM+rQnOAwbFqHyIQ51EFpo
         jCg+BSb9jkpZhFtoRx2E90e0xuN5FIf7KoZepqn37sSFLRmJnaSCpsShSCI7/RPR02
         21XLSQVbeQqIQ==
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
Subject: [PATCH v3 1/3] dt-bindings: timer: rockchip: Drop superfluous rk3288 compatible
Date:   Wed, 19 Apr 2023 21:13:07 +0300
Message-Id: <20230419181309.338354-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
References: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
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

The compatible string for Rockchip RK3288 is wrongly provided in the
'enum' item, in addition to the subsequent 'const', which allows the
usage of an incorrect specification:

  compatible = "rockchip,rk3288-timer", "rockchip,rk3288-timer";

As the rk3288 string is also specified in the top-most 'const' item, the
binding already allows the usage of the correct variant:

  compatible = "rockchip,rk3288-timer";

Drop the unwanted rk3288 entry from the enum.

Fixes: faa186adbd06 ("dt-bindings: timer: convert rockchip,rk-timer.txt to YAML")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index 65e59836a660..2bdb6e6bdb21 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -23,7 +23,6 @@ properties:
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
-              - rockchip,rk3288-timer
               - rockchip,rk3368-timer
               - rockchip,px30-timer
           - const: rockchip,rk3288-timer
-- 
2.40.0

