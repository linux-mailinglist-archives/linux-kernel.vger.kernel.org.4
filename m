Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E2647188
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLHOUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLHOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:20:35 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97883EBC;
        Thu,  8 Dec 2022 06:20:34 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4BF7C0008;
        Thu,  8 Dec 2022 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670509233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7Bq1jaABPqnvcdD20frWPwa1ZDzg3R23L+HGhf2pEY=;
        b=dsGSXrzij4d5S1T4L635XDwIWwMSrZsfUJHtTCTXR20N82Gh8+cQjVwmvHLUKeFGzTx8be
        Ta3MgnNVoUyd4JyGL1caOFxiLW7mMcHTznQhTUqKSm/TI7a7OrGNPiQvV3H88bgqrjcyxK
        bf0f3+gEnAzeVN+8RFrs70wxZm2aH5MVwP3Mg9Ok0AqJsJ/Lbat3qtMhObopIvEN4v9Hp0
        RHA++MXD7sYagbu6iAnpV1gklbUOy7Ocf1a57TAcIu31hc0V+yAiKsYDQOdXkq42lFPjCQ
        x0OxieCbWG58PDx9Ws+u4grmFQQghMT/BMhkKBhduUxNpU75h1RhMlb9EoMARA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Conor Dooley <conor@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 03/12] media: sunxi-csi: bridge: Declare subdev ops as static
Date:   Thu,  8 Dec 2022 15:19:57 +0100
Message-Id: <20221208142006.425809-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
References: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static keyword is missing in the v4l2 subdev ops definition for the bridge.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Fixes: 0d2b746b1bef ("media: sun6i-csi: Add bridge v4l2 subdev with port management")
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index 4517c0346eef..7fcb0815cb42 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -587,7 +587,7 @@ static const struct v4l2_subdev_pad_ops sun6i_csi_bridge_pad_ops = {
 	.set_fmt	= sun6i_csi_bridge_set_fmt,
 };
 
-const struct v4l2_subdev_ops sun6i_csi_bridge_subdev_ops = {
+static const struct v4l2_subdev_ops sun6i_csi_bridge_subdev_ops = {
 	.video	= &sun6i_csi_bridge_video_ops,
 	.pad	= &sun6i_csi_bridge_pad_ops,
 };
-- 
2.38.1

