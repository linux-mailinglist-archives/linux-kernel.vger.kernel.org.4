Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FBC68ED24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjBHKh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjBHKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:37:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4D47EC7;
        Wed,  8 Feb 2023 02:37:33 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B91B96602096;
        Wed,  8 Feb 2023 10:37:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675852652;
        bh=LMwqpEoSTBoag1iPNbLWuJ7k3BNQAL+D9DLjE7DnY9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfCFb6dE/tVp+UCzTu0P7PveAPy3W365WlwuAqZ9TGV+jT1tt7LsqhLAx20mFF4uk
         OHFJhvmFLqBtIeMGsaRDS7wFRaJUOrNdHkKsnR2zYW+QLFlHTwtGMZGhSgbroTouon
         aFEThvfjhIUh002uNwUDhdEJVwIhnIOwCbrEN8CEl4qch5Se0jZK7mGgEjctPAbVQn
         zY9vRJuIYusMAp6Cozze/Cc/OqbC8G/zBBnQGyDWM+fASe9rH+DHc0XXpCfBMtGJln
         fB5AeySmDcjR2WENSv4FOSLOv6WBjlNm44DsTNC/NRhAik6cbIAfrBnohc4WaiUjbg
         rq3mTg8ONrJnw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tomeu.vizoso@collabora.com,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        matthias.bgg@gmail.com, robh@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 8/9] drm/panfrost: Add mediatek,mt8192-mali compatible
Date:   Wed,  8 Feb 2023 11:37:08 +0100
Message-Id: <20230208103709.116896-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
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
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index abb0dadd8f63..5d25e77e1037 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -663,6 +663,16 @@ static const struct panfrost_compatible mediatek_mt8183_data = {
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
@@ -681,6 +691,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
 	{ .compatible = "arm,mali-valhall-jm", .data = &default_data, },
 	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
+	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.39.1

