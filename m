Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3E5BCEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiISOeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiISOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:34:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8BC326D6;
        Mon, 19 Sep 2022 07:34:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az6so21021538wmb.4;
        Mon, 19 Sep 2022 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dZiIiAfOPGu7FQskh2sYiHuLa/x/uoKuqCxc5Z4sn5Q=;
        b=MDEfSKyu6WlEJztaja/r/2/ny3jg3TnbXff7RUVI/Z0dLJuLwzuTqZfNTJOU3BX196
         UsJlPGBPFZ+QSIhqM8KNCCT4OOCFio21E6w7gvoobnFtCp+6hWgaAPnEcWq7nfdPyWNb
         tAES2ElFKX4U0m+4UMkBAJ99WvAU2zxfU8all6SglXrpS8GWUn9m88HQZDhZijsv9stK
         86ECyNqKjB7b1FKrA0AErydIwW6xkg/SayAfXkxi74vr34rAFWZ11/8Q+n2RYMxMtfg5
         VTfH8rgDrQ3D+RXdwviPm6SOFm+2QdfoalkOOJZTCmFhkuChoLI9jgXZ63kIsg7NZS6W
         IDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dZiIiAfOPGu7FQskh2sYiHuLa/x/uoKuqCxc5Z4sn5Q=;
        b=cMok6qyERos7UpP0vwE2N9ZGS4qBRYgTcuvxOGN43wCXmrAONSFYeYHuQfRA8RYcxq
         rW6DrSmr6Pz+aIdYfNvMEBm8wgBOdvldU/s7/KahS9mNelZGox1Ctowr4KHFItupx6OF
         61Dsu7NPn3sqRBbpW438Rz9h5KOOECPTCczibiT72bdyLLJr+Be2hoyLg+iNEdIJ31Al
         S41tjfRbCxh6LgJkLmj7/yGAbQaZh9U0+xG01mdfFdoeDdrpVWsZQpUHZ4X1UYiU2OJc
         k9uQS0B8i5JvGs6yN8D+DkW/cWqWZZnoc9ZroiuHwaJdGMwAoxfb+m+qy0jeydcWd56l
         wgmg==
X-Gm-Message-State: ACgBeo043DUDPqoZ0f6qrQByXB6PFGbb0vhEbiXrqXd1odVxW5UwtLhn
        hm1AZovgDlxZ0Ik0bY/oRzo=
X-Google-Smtp-Source: AA6agR4+WfJL3p4keXjm1GwjYRkV5EoiOgKxQl+SXX+8+ky8X3jMrmHoAlyXpCzh+r6P0hbHVEllog==
X-Received: by 2002:a7b:cb41:0:b0:3b3:34d6:189f with SMTP id v1-20020a7bcb41000000b003b334d6189fmr19380948wmj.6.1663598047271;
        Mon, 19 Sep 2022 07:34:07 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003b47e75b401sm15030934wmq.37.2022.09.19.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:34:06 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: i2c: ov5645: Drop fetching the clk reference by name
Date:   Mon, 19 Sep 2022 15:33:50 +0100
Message-Id: <20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The OV5645 sensor has a single clock source, so just drop fetching the
clk reference by name.

This is in preparation to drop the "clock-names" property from the DT
binding.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 81e4e87e1821..47451238ca05 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1090,7 +1090,7 @@ static int ov5645_probe(struct i2c_client *client)
 	}
 
 	/* get system clock (xclk) */
-	ov5645->xclk = devm_clk_get(dev, "xclk");
+	ov5645->xclk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ov5645->xclk)) {
 		dev_err(dev, "could not get xclk");
 		return PTR_ERR(ov5645->xclk);
-- 
2.25.1

