Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229F7728B13
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbjFHW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFHW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:28:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BD326BA;
        Thu,  8 Jun 2023 15:28:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977e7d6945aso210945766b.2;
        Thu, 08 Jun 2023 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686263299; x=1688855299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCS6dst0f7pylGFlcTuSJ9qEy8WAZzA65zdvMlz15JY=;
        b=lC2d2etBYyV9BMDudbYCxaGzGECTLD/39Y7snRMWRLQfKTZQkJ23WRzKPZZ2sdEsXw
         nLggdK7CIoASe7ecQXXuTdJQq50iIHlpm77CAuw8WCnXrBwFqz7USjjqFxEIWKCMn94C
         IQFAzbLVlKAz+Mnac0kQNqq+8O69L9e8FNiycu0xvGkJ+qaMIeelq90sjlktr4QSw1A9
         s/KybHvg4cgb5G2nU+SRxElEMdQcGvQAvkrM6ZejCbtqxB3OdxUhZ5xnQkRX2ucvm04n
         1Bc0OTd7GA6+v/8B7+D0j/6bEE3hGRaJDcE6TRhAH7yipet6SZOglvLkdh/P3IEhoSdE
         vHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686263299; x=1688855299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCS6dst0f7pylGFlcTuSJ9qEy8WAZzA65zdvMlz15JY=;
        b=EPgzvBuUQh2dnKIsLRrSCYbke63DKhvIcYfLVqAY4SQWyOt8qN9X2Gdy4C2PoHTl9x
         RgN0zj09h3nEHSm3KSdi4Q47teyJlzexXVa72aYuki0tjs1RSYj/USil92eNTDi8RXOW
         caGvYsT3DWL8xGQm75/WJvqyhPoArpZAkpT3Lcc+8f6x04CFKKkJR73/+0vedyA++3Qg
         0rdtH84Hm8VvvHEw2qEYtW23GtXhCU3ceYzZwBfyfnVzkRwT/TXewljjlKIKZWSTEdRw
         g6VMZWP7uV2Umq81W4dv/JDz6uhWZ02gqYWz229mBDg+QF+2AhpSLrT+ctODoRl8g1+b
         NmbQ==
X-Gm-Message-State: AC+VfDyFkB/zZlS2YJWGiDZKIgVIpyOH4Kk7MbanObWlfcnnP0nBz1GN
        eiQaSRDAiysUtQkxz/HAv2gxW7XYj3eLLQ==
X-Google-Smtp-Source: ACHHUZ6klHf7Tr4by9XJNaupWMNceTRpJVGshEfGbmbo+9HdySLpd99oQInBGTvOa0J9DAuGQ5T6eQ==
X-Received: by 2002:a17:907:7f23:b0:977:c854:ba3 with SMTP id qf35-20020a1709077f2300b00977c8540ba3mr538256ejc.42.1686263299237;
        Thu, 08 Jun 2023 15:28:19 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906a29400b00977fb2fb44asm429568ejz.28.2023.06.08.15.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 15:28:18 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, linuxfancy@googlegroups.com,
        jacopo.mondi@ideasonboard.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: imx290: drop format param from imx290_ctrl_update
Date:   Fri,  9 Jun 2023 00:28:10 +0200
Message-Id: <20230608222810.574628-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format param actually is not used in imx290_ctrl_update
function, let's drop this

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/imx290.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 5ea25b7acc55..a84b581682a2 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -902,7 +902,6 @@ static const char * const imx290_test_pattern_menu[] = {
 };
 
 static void imx290_ctrl_update(struct imx290 *imx290,
-			       const struct v4l2_mbus_framefmt *format,
 			       const struct imx290_mode *mode)
 {
 	unsigned int hblank_min = mode->hmax_min - mode->width;
@@ -1195,7 +1194,7 @@ static int imx290_set_fmt(struct v4l2_subdev *sd,
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		imx290->current_mode = mode;
 
-		imx290_ctrl_update(imx290, &fmt->format, mode);
+		imx290_ctrl_update(imx290, mode);
 		imx290_exposure_update(imx290, mode);
 	}
 
@@ -1300,7 +1299,6 @@ static const struct media_entity_operations imx290_subdev_entity_ops = {
 static int imx290_subdev_init(struct imx290 *imx290)
 {
 	struct i2c_client *client = to_i2c_client(imx290->dev);
-	const struct v4l2_mbus_framefmt *format;
 	struct v4l2_subdev_state *state;
 	int ret;
 
@@ -1335,8 +1333,7 @@ static int imx290_subdev_init(struct imx290 *imx290)
 	}
 
 	state = v4l2_subdev_lock_and_get_active_state(&imx290->sd);
-	format = v4l2_subdev_get_pad_format(&imx290->sd, state, 0);
-	imx290_ctrl_update(imx290, format, imx290->current_mode);
+	imx290_ctrl_update(imx290, imx290->current_mode);
 	v4l2_subdev_unlock_state(state);
 
 	return 0;
-- 
2.34.1

