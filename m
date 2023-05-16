Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A7705B04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjEPXEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjEPXEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:04:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A777AA9;
        Tue, 16 May 2023 16:04:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AA25660322D;
        Wed, 17 May 2023 00:03:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684278248;
        bh=q7DeK2S2OQkUm9aAia29KELl6k5xzi/Rod0mLsIEALU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkvF1OSgSOmsRxfiohHOFcn+geDm17i5fZFWtOQoQF15BxfzDL10xxKK6QJqI02bD
         hVOps6siX71uu3cI4pa3nr3JNntxP4riYnpF2tDAbGeH392IO3oVhWlq+0lGGfq7YL
         6pNS2Dr7F6TvJ1RfqJR51xBWBk12ENkXt0SHLMZrrA9BwjkReWvmwXPl6+opa0bk23
         LZxHQqJm3iUI3OaNr/Bv1V9tuCdZwanID8ciLRe62p32nYLn4KBJavIGNxqth3v5tN
         GpJCTtjgO9j6cCoQ8vzuAmiyU0UCL4sm9vZYrQQ+O0lG+owKPLxWEjF7P3nh5bmswg
         WISvHFU/BaD8Q==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 7/7] dt-bindings: iio: adc: Add rockchip,rk3588-saradc string
Date:   Wed, 17 May 2023 04:30:51 +0530
Message-Id: <20230516230051.14846-8-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516230051.14846-1-shreeya.patel@collabora.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
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

Add rockchip,rk3588-saradc compatible string.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index da50b529c157..11c27ea451c8 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -21,6 +21,7 @@ properties:
               - rockchip,rk3308-saradc
               - rockchip,rk3328-saradc
               - rockchip,rk3568-saradc
+              - rockchip,rk3588-saradc
               - rockchip,rv1108-saradc
               - rockchip,rv1126-saradc
           - const: rockchip,rk3399-saradc
-- 
2.30.2

