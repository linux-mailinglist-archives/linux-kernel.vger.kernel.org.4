Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1749647122
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiLHN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLHNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:55:50 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3125E3F8;
        Thu,  8 Dec 2022 05:55:45 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 949522000E;
        Thu,  8 Dec 2022 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670507743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdXTjxxafj+/fk+QiasYLrtNa8JrGnmuEtrSTN6g0U8=;
        b=g/3gEWaj/cHS+tHgVRCvAn82K44d+3BFTfT9yviY62SC3vRdIdOiXe/KLqehG4OurA+PPY
        /Q5PPh5RJNS+YAb4sgZWKnK9UQz3DVlbbBt67j900034fy+sAeuOKT2uuYaZMgkrYlNoat
        7SRajfUr6A0PF110iCtSY3jnkOxk9izvsi19KS+LqFlkPXP+tOFrUCeGUphMwEkbPDu1Ws
        frOBKv03r/R8Qj/jA/t/8CiksUPj97BDPIiKFm0+aYZEzJ9xnje12gwC/Bn4QlL3M/n9Va
        db1T/ayrjNzsiJtkHp3/XdeJaPW4zz4HiymHuu/APnagEh+A7AWOZNGz8+9thw==
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
Subject: [PATCH v2 03/11] media: sunxi-csi: bridge: Declare subdev ops as static
Date:   Thu,  8 Dec 2022 14:55:04 +0100
Message-Id: <20221208135512.421903-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208135512.421903-1-paul.kocialkowski@bootlin.com>
References: <20221208135512.421903-1-paul.kocialkowski@bootlin.com>
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

