Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F56BCC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCPKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCPKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:21:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF843BD4E1;
        Thu, 16 Mar 2023 03:20:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3278466030A5;
        Thu, 16 Mar 2023 10:20:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678962054;
        bh=zaVPC8a/zjPKkMkKy2u0SknVPayDnrlxaZ88LGSOuPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+ebgBXr59zxnfFqZTRha1fbz/sXBfiDuR3wz4sIfqE/TQ4J9AbE3/XQpH2LGrDjk
         I7OA2HII3H2o9DkwjN98y5HpFsScHJli/w165lcNfVJdfo6E0caSfhbfdSCmCaW7x4
         ZsN9by9bR+7sqhKL8hZKStk2J/tnqF0cm9hbBelMEYFTFNzgmfikxiHvhXW3SRx/1H
         McZoEAyZvv7bwEzcScDFwZHRQsZzz8/t7KbdnhYncpQPPwJfelsXm0zJRfPn4nb4TY
         zWcejFyTAo0xah/I2OXNetcw+Io8wvB2VWxW+ONsCOKbhOantTDqr5ZidQI5raWz9k
         fkxEFQntyhYVA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 10/12] drm/panfrost: Add mediatek,mt8192-mali compatible
Date:   Thu, 16 Mar 2023 11:20:39 +0100
Message-Id: <20230316102041.210269-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
References: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
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

From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Required for Mali-G57 on the Mediatek MT8192 and MT8195, which
uses even more power domains than the MT8183 before it.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
[Angelo: Removed unneeded "sram" supply, added mt8195 to commit description]
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index f49096f53141..45c4accb6a1e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -656,6 +656,16 @@ static const struct panfrost_compatible mediatek_mt8183_data = {
 	.pm_domain_names = mediatek_mt8183_pm_domains,
 };
 
+static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
+static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
+							   "core3", "core4" };
+static const struct panfrost_compatible mediatek_mt8192_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8192_supplies) - 1,
+	.supply_names = mediatek_mt8192_supplies,
+	.num_pm_domains = ARRAY_SIZE(mediatek_mt8192_pm_domains),
+	.pm_domain_names = mediatek_mt8192_pm_domains,
+};
+
 static const struct of_device_id dt_match[] = {
 	/* Set first to probe before the generic compatibles */
 	{ .compatible = "amlogic,meson-gxm-mali",
@@ -674,6 +684,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
 	{ .compatible = "arm,mali-valhall-jm", .data = &default_data, },
 	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
+	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.39.2

