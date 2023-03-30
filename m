Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546E46D0078
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjC3KAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjC3J7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:59:52 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DE5B0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:59:51 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 471AB20755;
        Thu, 30 Mar 2023 11:59:49 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] drm/bridge: tc358768: Add TC9594
Date:   Thu, 30 Mar 2023 11:59:39 +0200
Message-Id: <20230330095941.428122-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330095941.428122-1-francesco@dolcini.it>
References: <20230330095941.428122-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add TC9594 ids, from the software point of view this is fully compatible
with tc358768, the only difference is the automotive qualification.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 7c0cbe84611b..f4499ae7bee6 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -991,6 +991,7 @@ static const struct regmap_config tc358768_regmap_config = {
 static const struct i2c_device_id tc358768_i2c_ids[] = {
 	{ "tc358768", 0 },
 	{ "tc358778", 0 },
+	{ "tc9594", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tc358768_i2c_ids);
@@ -998,6 +999,7 @@ MODULE_DEVICE_TABLE(i2c, tc358768_i2c_ids);
 static const struct of_device_id tc358768_of_ids[] = {
 	{ .compatible = "toshiba,tc358768", },
 	{ .compatible = "toshiba,tc358778", },
+	{ .compatible = "toshiba,tc9594", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tc358768_of_ids);
-- 
2.25.1

