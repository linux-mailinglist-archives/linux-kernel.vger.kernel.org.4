Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76863AC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiK1P0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiK1P0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:26:11 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70AA25E82;
        Mon, 28 Nov 2022 07:24:58 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id DCC0D100006;
        Mon, 28 Nov 2022 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669649097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgVAaPNMJa89SI0rNjqHrlIDAE7eORtVFsqm8m2Ny+g=;
        b=WUrJKg9yzZ9NkoBqASH+lKBV0cype1yTj8T7j+hkookcsGFW/g/E2W01bYccLE5OVRR6kc
        FnMbKA74Fl+OTsb7Z9E1HHq7NcQZLY+KXfN0kaXo1V/5d8REQGbOIDRM9YOyc3Jo/caoIU
        CitO7VOwYMpKDfuE45PFXe2KjydQBANpYbJXDbjQKj0Dn5hI85GmJ69aqWe4qSf8USMsIj
        f+LQo5ZAW8o3IWBR3zX1xkmHIqofnvrtH45WSC5qMWi4aKnkp6CkHNK5M47J+aPe9dhsh1
        D2pCbaw4aw3A2At9xVe68RNkMj6BoJRUWZiSpiJhPYr3/Gj0zbVghLvc4eVEMQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 09/21] staging: media: tegra-video: move private struct declaration to C file
Date:   Mon, 28 Nov 2022 16:23:24 +0100
Message-Id: <20221128152336.133953-10-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct tegra_vi_graph_entity is an internal implementation detail of the VI
module. Move its declaration from vi.h to vi.c.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 13 +++++++++++++
 drivers/staging/media/tegra-video/vi.h | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 2657207e5b7d..55a135bef1a9 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -31,6 +31,19 @@
 
 #define MAX_CID_CONTROLS		1
 
+/**
+ * struct tegra_vi_graph_entity - Entity in the video graph
+ *
+ * @asd: subdev asynchronous registration information
+ * @entity: media entity from the corresponding V4L2 subdev
+ * @subdev: V4L2 subdev
+ */
+struct tegra_vi_graph_entity {
+	struct v4l2_async_subdev asd;
+	struct media_entity *entity;
+	struct v4l2_subdev *subdev;
+};
+
 static const struct tegra_video_format tegra_default_format = {
 	.img_dt = TEGRA_IMAGE_DT_RAW10,
 	.bit_width = 10,
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index dd35c3ac992b..dfd834a69848 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -98,19 +98,6 @@ struct tegra_vi {
 	struct list_head vi_chans;
 };
 
-/**
- * struct tegra_vi_graph_entity - Entity in the video graph
- *
- * @asd: subdev asynchronous registration information
- * @entity: media entity from the corresponding V4L2 subdev
- * @subdev: V4L2 subdev
- */
-struct tegra_vi_graph_entity {
-	struct v4l2_async_subdev asd;
-	struct media_entity *entity;
-	struct v4l2_subdev *subdev;
-};
-
 /**
  * struct tegra_vi_channel - Tegra video channel
  *
-- 
2.34.1

