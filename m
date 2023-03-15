Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29F6BAF99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCOLto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjCOLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:49:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B86E85A55;
        Wed, 15 Mar 2023 04:48:38 -0700 (PDT)
Received: from localhost (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 247F5660309E;
        Wed, 15 Mar 2023 11:48:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678880916;
        bh=8ybPDR8xtX9t6uUcpa4UINGux8SedQXEu+GJ7EQBGX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDPrRCZUdG4hj8fpBOvt0eQFDAyrIdw9ujRofF0plHYlE14mJQGnoeA9UjOkXspNZ
         cycgqJmTSZDf/nKyZbA4PNITrx+z18+8OOttvwiJ9ZyJc+bFd3fsOKj8dyyUGU47Ol
         LIFEZlYkTPFEp47ic+/P7N8pSDgmCgW5LVuBtE/5xza9uUFwmWfeaLH3qjK+E93ZEX
         TOoxqaVabUehbrnWBScz9s/6xvYLkfF64R4n+5KHwl/mIbd3LChHFM3R/q+jj/gffo
         sppae26uX+iIgqeD9Mnfkck21bR1cBTKilXWAB1qWdWhHEF33uHJGmr8X//QNxcnb8
         n96f9753RDe/Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 08/11] ASoC: rockchip: i2s: Add compatible for RK3588
Date:   Wed, 15 Mar 2023 13:48:03 +0200
Message-Id: <20230315114806.3819515-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip I2S driver supports the RK3588/RK3588S SoCs, hence add the
corresponding compatible string.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index a8758ad68442..2e24cc0570eb 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -659,6 +659,7 @@ static const struct of_device_id rockchip_i2s_match[] __maybe_unused = {
 	{ .compatible = "rockchip,rk3366-i2s", },
 	{ .compatible = "rockchip,rk3368-i2s", },
 	{ .compatible = "rockchip,rk3399-i2s", .data = &rk3399_i2s_pins },
+	{ .compatible = "rockchip,rk3588-i2s", },
 	{ .compatible = "rockchip,rv1126-i2s", },
 	{},
 };
-- 
2.39.1

