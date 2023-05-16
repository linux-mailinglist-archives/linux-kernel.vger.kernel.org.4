Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34EA705AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjEPXDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjEPXDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:03:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF727EEC;
        Tue, 16 May 2023 16:03:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65656660322D;
        Wed, 17 May 2023 00:03:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684278214;
        bh=FVMe/5NMLn43mP7albuxLlvogh9o3Yme9lezj9TaBTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCCDEMjrrn0YouSvTb0b0EFIbk81oW3SvEAMRgraJ72fqcOIZAQoXHYYGtk9kiibk
         g5lkwzQ/qOyZHv6l/1Ak/BRZvp0SZUHKOYiuwCSw5ZFlUruDk2dtKcWlPu9giDeXC0
         gLWWyFyU3dL2i0i4TqZ5r+Ly42Op3pWYgYK94kr7rFgf8BfLk0mWRWbUGy/gdKUtgu
         DS45rl1rR7LI/YurnE/P4y/34tEq6K4thixMhMnwB9sc4AhPQaEjupBqcmAAQjPgyl
         LkMK3FffbZzqp8y5AX5MEfq21UEBYRqXdxOluqT1Gz8BcNKXq8x4F1BcmYNG3YUsGn
         SFzJvdS0fQNHQ==
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
Subject: [PATCH 4/7] iio: adc: rockchip_saradc: Match alignment with open parenthesis
Date:   Wed, 17 May 2023 04:30:48 +0530
Message-Id: <20230516230051.14846-5-shreeya.patel@collabora.com>
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

Match alignment with open parenthesis for improving the code
readability.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/adc/rockchip_saradc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 05ea823a8f16..5e1e8575bc76 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -144,7 +144,7 @@ static void rockchip_saradc_power_down(struct rockchip_saradc *info)
 }
 
 static int rockchip_saradc_conversion(struct rockchip_saradc *info,
-				   struct iio_chan_spec const *chan)
+				      struct iio_chan_spec const *chan)
 {
 	reinit_completion(&info->completion);
 
@@ -387,8 +387,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 }
 
 static int rockchip_saradc_volt_notify(struct notifier_block *nb,
-						   unsigned long event,
-						   void *data)
+				       unsigned long event, void *data)
 {
 	struct rockchip_saradc *info =
 			container_of(nb, struct rockchip_saradc, nb);
-- 
2.30.2

