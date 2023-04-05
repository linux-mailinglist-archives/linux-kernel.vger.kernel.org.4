Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B36D768A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbjDEIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbjDEILo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:11:44 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD55BA3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:11:18 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 7D3CA2000B;
        Wed,  5 Apr 2023 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680682268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tP0k/1C5X6ti1qmxnTbmSYL5HSPoIihEForxpuzMBe4=;
        b=hQ3xzqCyaRnZ0OtsseS0eWdF+4ztuXXGAV3j7VAL7AfRhIObBiAdTfjfdFNxFyhgQ0FtSL
        r7To5ch1i3621SXwF8X11+yLWRJ8/0cnGw0TL2XN4d/vO/rnf0zglfHT2wjsLg9QL/Evpv
        s0WvWKk4pzSiTZ0Bc3aWev5jUcF6xXnVJ8OWcivGB3QJk7Xv4i/A9yzehya6oTF66tYM1J
        vgOl3xSpgybsbnZRavt7XfGYV+7AObiS38+qJnxroRD3BVcdb1OdvHV0UWz1+sN74EPJjL
        ULw01fZDavyaTx4KJzFC4oFUfOxlDofF34LAWd2xa3lRc59VUy7ajVrFUP+QAA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 1/2] drm: bridge: ldb: add missing \n in dev_warn() string
Date:   Wed,  5 Apr 2023 10:10:56 +0200
Message-Id: <20230405081058.2347130-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_warn() and similar require a training \n.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 6bac160b395b..bb13a9143edd 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -170,7 +170,7 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 
 	configured_link_freq = clk_get_rate(fsl_ldb->clk);
 	if (configured_link_freq != requested_link_freq)
-		dev_warn(fsl_ldb->dev, "Configured LDB clock (%lu Hz) does not match requested LVDS clock: %lu Hz",
+		dev_warn(fsl_ldb->dev, "Configured LDB clock (%lu Hz) does not match requested LVDS clock: %lu Hz\n",
 			 configured_link_freq,
 			 requested_link_freq);
 
-- 
2.34.1

