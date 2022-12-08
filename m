Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6322164712B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiLHN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiLHN4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:56:12 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4594926;
        Thu,  8 Dec 2022 05:55:57 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D5D9020012;
        Thu,  8 Dec 2022 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670507756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ez+xaGXRX17SiCVJoDh8t8wWoiu7lx7UzmAXmqGgMuE=;
        b=NNRxjaAUVStw8vOCJt2SvUiSvRS88BOkRQ8Z/wcWoiW3pwo9rtRFGjLRoUq8AeKWtf59gq
        F8EhazONxd1IzHMblQ/8tjBHBisg6eexFhfFMN3MFlAm+QsKr3JKz5cyBHoMDNYu53kRmS
        NJo+anYNlckuKOQEhE1WEh0FCWCTB/HJdITEkgZS4IDm/IwTH399h6PrLyQmDfi4C9Rq/A
        /MSGgd+9Uja1AbeZTfHQ5jogZjQljkycl7iOwmm5OYsXI+pEgHkkGk9HzJ2wjjSJcM6NnX
        YMLHsXA+C7oIg7uAPZSNdViicOsle0mV4O9wk9kzOQtn5M1gYg4h8Kl3WtYeqA==
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
Subject: [PATCH v2 09/11] media: sunxi-isp: proc: Declare subdev ops as static
Date:   Thu,  8 Dec 2022 14:55:10 +0100
Message-Id: <20221208135512.421903-10-paul.kocialkowski@bootlin.com>
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

The static keyword is missing in the v4l2 subdev ops definition for the proc.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
index 4f34c1bc8be9..1ca4673df2b3 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
@@ -342,7 +342,7 @@ static const struct v4l2_subdev_pad_ops sun6i_isp_proc_pad_ops = {
 	.set_fmt	= sun6i_isp_proc_set_fmt,
 };
 
-const struct v4l2_subdev_ops sun6i_isp_proc_subdev_ops = {
+static const struct v4l2_subdev_ops sun6i_isp_proc_subdev_ops = {
 	.video	= &sun6i_isp_proc_video_ops,
 	.pad	= &sun6i_isp_proc_pad_ops,
 };
-- 
2.38.1

