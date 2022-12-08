Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFBF647191
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLHOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiLHOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:21:19 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9749896D;
        Thu,  8 Dec 2022 06:20:52 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9850AC0013;
        Thu,  8 Dec 2022 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670509250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRu2RP5587P17F9a9XccoML3QtTDv6tjVLS6SFKycnU=;
        b=hip9rGuH4oKSmShxI5ukthyrKzgtOA1aWYaEW+Wm3Xz3PcJd5CY6TiMWnN7Gt+7D6Gcta8
        OIiyx7COVYWmRJp33gBeH5DGDyuD6rtTKJs6/7oQQW1Ydxm1DxVsujpywILdLlIlv24uTB
        dTB6ohC98ggXa1rNh5DeCI3wayt1MXKJmMWl6aWNieTaUsXgQnXA/aPkng6Rnt2PRr+5rQ
        HSzA7EHPQxvttZJfpeYIWP03hGJ77Gh7Azh3W5J742RqqvT1MuTEMCtyRP+mwTMGP/jJgG
        +6xIXx/GVAWmnLtppFJ/mcVrzbslsELwTKYVSbgfJ74mP4qH9ULXyhN6lZPADg==
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
Subject: [PATCH v3 11/12] media: sun6i-isp: params: Fix incorrect indentation
Date:   Thu,  8 Dec 2022 15:20:05 +0100
Message-Id: <20221208142006.425809-12-paul.kocialkowski@bootlin.com>
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

Remove a heading whitespace that results in a smatch warning.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Fixes: e3185e1d7c14 ("media: staging: media: Add support for the Allwinner A31 ISP")
---
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
index 8039e311cb1c..7b41a13162b9 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
@@ -183,8 +183,8 @@ void sun6i_isp_params_configure(struct sun6i_isp_device *isp_dev)
 	if (state->configured)
 		goto complete;
 
-	 sun6i_isp_params_configure_modules(isp_dev,
-					    &sun6i_isp_params_config_default);
+	sun6i_isp_params_configure_modules(isp_dev,
+					   &sun6i_isp_params_config_default);
 
 	state->configured = true;
 
-- 
2.38.1

