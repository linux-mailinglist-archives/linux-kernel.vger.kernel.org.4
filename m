Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C26E5B71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjDRIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjDRICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:02:35 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A046EB1;
        Tue, 18 Apr 2023 01:02:03 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 7E430240019;
        Tue, 18 Apr 2023 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681804897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89LKE84J28tS17t2LdvykdrtMycfjqjpFsn9fqF7WMA=;
        b=cR/vLn9OfPIFbn5rnGwm6tVQg2V4B2GZV4leUnT4A7/YjQ8kZ5r2GXEunwfwQw0ucjVRWU
        tHzsV4rFsIrBb9oeVXAHXmHA5PXF/rF/8g/cqweqMg7JUBUDeyVH9UZjUijJcmDORJ/PhN
        LvHGr8Krxrn5c468h94c50UnxEsvR2+MXp3wKUrWdWWhfXJI07bLFonZCs5AcSua6yn4Zs
        EEentkxlW/9oHPx1pdRCkYGyGPvTsIkHiYihTEru81CQQ9T7hzEhzamF+7PY/aXYDsl0IT
        bIe8VaVsihthCGJ/WhAEFYesUyHFBxspIPth+V+hikEcxG2d80QY4ptMXLYNyA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v6 09/20] staging: media: tegra-video: move tegra210_csi_soc to C file
Date:   Tue, 18 Apr 2023 10:00:43 +0200
Message-Id: <20230418080054.452955-10-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
References: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This declaration is used only in csi.c, no need to export it elsewhere.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v6
No changes in v5

Changed in v4:
 - Added review tags

This patch was added in v3.
---
 drivers/staging/media/tegra-video/csi.c | 4 ++++
 drivers/staging/media/tegra-video/csi.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/staging/media/tegra-video/csi.c
index 426e653bd55d..9a03d5ccdf3c 100644
--- a/drivers/staging/media/tegra-video/csi.c
+++ b/drivers/staging/media/tegra-video/csi.c
@@ -792,6 +792,10 @@ static int tegra_csi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_ARCH_TEGRA_210_SOC)
+extern const struct tegra_csi_soc tegra210_csi_soc;
+#endif
+
 static const struct of_device_id tegra_csi_of_id_table[] = {
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-csi", .data = &tegra210_csi_soc },
diff --git a/drivers/staging/media/tegra-video/csi.h b/drivers/staging/media/tegra-video/csi.h
index 6960ea2e3d36..3e6e5ee1bb1e 100644
--- a/drivers/staging/media/tegra-video/csi.h
+++ b/drivers/staging/media/tegra-video/csi.h
@@ -151,10 +151,6 @@ struct tegra_csi {
 	struct list_head csi_chans;
 };
 
-#if defined(CONFIG_ARCH_TEGRA_210_SOC)
-extern const struct tegra_csi_soc tegra210_csi_soc;
-#endif
-
 void tegra_csi_error_recover(struct v4l2_subdev *subdev);
 void tegra_csi_calc_settle_time(struct tegra_csi_channel *csi_chan,
 				u8 csi_port_num,
-- 
2.34.1

