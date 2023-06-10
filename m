Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988B772AB6D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFJMWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:22:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2598A30D0;
        Sat, 10 Jun 2023 05:22:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04D486606EB4;
        Sat, 10 Jun 2023 13:22:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686399738;
        bh=aOlIGXvrIXsEwyA7cJuJAjyJJNiBEdnDaaOrXAikU34=;
        h=From:To:Cc:Subject:Date:From;
        b=EVRx8kEF7+KXet3WFC4qQ1wwywt0YV3J9P3Hqjfoi/7qaxHduSOnwB9mySWPtfPDO
         5vsBnd9ot/wjiwT1Tsb2H0XkRWYvC/10VyN8G6zGBJl0XWSWwae8kyn9jIeatxnSkq
         3LahgJ4wTCmESUeBlGueACQU8rqWEHegSZk+yvARNHvUFSnKdoLUKihgxm63IqmO4A
         nq0iX4dHr1yKkcjsMLLhAoQqftnWT1uIaEJLyiPm3Cy7+Rc5o7/RAkmpdkLGobgxuv
         e/4oGPRLZveEYbRCE4Xhw+EFmMe7KATOQprMfZ2ADyie5W99+LCnV4y3izQcvCzhy7
         py11SKh/dDGpQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] dt-bindings: iio: rockchip: Fix 'oneOf' condition failed warning
Date:   Sat, 10 Jun 2023 17:52:00 +0530
Message-Id: <20230610122200.161741-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
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

Fix the dtbs_check warning for 'oneOf' condition failure.

DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb
/home/shreeya/linux/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb:
	saradc@fec10000: compatible: 'oneOf' conditional failed,
	one must be fixed:
	['rockchip,rk3588-saradc'] is too short
	'rockchip,saradc' was expected
	'rockchip,rk3066-tsadc' was expected
	'rockchip,rk3399-saradc' was expected

Fixes: 2daf2ae9793d ("dt-bindings: iio: adc: Add rockchip,rk3588-saradc string")
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 11c27ea451c8..aa24b841393c 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -15,13 +15,13 @@ properties:
       - const: rockchip,saradc
       - const: rockchip,rk3066-tsadc
       - const: rockchip,rk3399-saradc
+      - const: rockchip,rk3588-saradc
       - items:
           - enum:
               - rockchip,px30-saradc
               - rockchip,rk3308-saradc
               - rockchip,rk3328-saradc
               - rockchip,rk3568-saradc
-              - rockchip,rk3588-saradc
               - rockchip,rv1108-saradc
               - rockchip,rv1126-saradc
           - const: rockchip,rk3399-saradc
-- 
2.30.2

