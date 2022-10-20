Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA5606A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJTVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJTVHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:07:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235BA21CD55;
        Thu, 20 Oct 2022 14:07:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i9so1429338wrv.5;
        Thu, 20 Oct 2022 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nE9zBK8JzzeTQnO56mRCrEv5ZzW+tKVnujwJo9Sh9lA=;
        b=Rm6hVUuG346MeBs86eW9vmNubpAqPQbYgi96zIMxdSviyQWm7gh6RhIqOQvmaciU+m
         93l8lsuLd2ZS3cuMgWs/NPdpWWY+znm6fiECfWnGDo3/TxVtCZ9xqUqmNrHjJSYoOBt+
         fLQLgOmu6F+z283vZl/xR5jxA+ITlFRwBQAHKYrG0iKxF5EQaeh5PfdE3ay/p0VxDb/+
         10Osfvx//NZ0UIUlokGU6XRHE7nf7bcfcnX+0wgDiC/z67KO7MQywZL5oWmzAnxjymKH
         +BiGQBup5ZVxrd4LMc9muGiuC55j/Y+rFU0q9QpLmnkCGwG/Ws+riTKKnOaGpIHy6Bb2
         xKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE9zBK8JzzeTQnO56mRCrEv5ZzW+tKVnujwJo9Sh9lA=;
        b=VJomjfTsofoOQrG0nZcye0gHo8ZZfSOk5CE2FexcLKGMdzdjsOq2LAXdFPK1QpxI9g
         v/iewJrvwDLp0G0xeBCzhdXVbb8idVH4IKUArv+zqBs19F6bc5PcwdEBlxXeGjuyvHs+
         1EHswnmSNup+F8nkOczpo9FeylDegfpvktRJEb6vkM7kIWtIbKdYwl4k2McoLhOgqR3m
         qez5pNWlBbCBwdiptGtR4GAFIg8hX9ucoyc9ug+CppvYUGZSY6/U0XvXvNwNaTNqGcer
         6qR9YctFlWYfvdHKH/xU+6iCDOjpFdsq9ux6Z/ks0sWbDZOnUzragpZL7BIfVcbjGgBa
         6hKw==
X-Gm-Message-State: ACrzQf09zFRnamAu8Z/DGBpoV+anKxTvE14FNeEpTf7prnpDNiKMYvLa
        lpZlKS5K6bGj+vKQs9/Kw/KWbTgXgNf7v54R
X-Google-Smtp-Source: AMsMyM5ua5LMpiHA2CUFwJhW2MIvfMvOFKxSjnN/+Y30ozTiYY72DHhLzN5FQgOv4WNgNnhg2hQeZw==
X-Received: by 2002:a05:6000:1f04:b0:22e:5e0b:e1fb with SMTP id bv4-20020a0560001f0400b0022e5e0be1fbmr9507625wrb.222.1666300052613;
        Thu, 20 Oct 2022 14:07:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j16-20020adfea50000000b00228d6bc8450sm20576701wrn.108.2022.10.20.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:07:32 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: lp55xx: remove variable j
Date:   Thu, 20 Oct 2022 22:07:31 +0100
Message-Id: <20221020210731.45864-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable j being incremented but it is never referenced,
it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/leds/leds-lp55xx-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index 9fdfc1b9a1a0..ca2e28fb843f 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -166,7 +166,7 @@ static int lp55xx_init_led(struct lp55xx_led *led,
 	struct mc_subled *mc_led_info;
 	struct led_classdev *led_cdev;
 	char name[32];
-	int i, j = 0;
+	int i;
 	int ret;
 
 	if (chan >= max_channel) {
@@ -201,7 +201,6 @@ static int lp55xx_init_led(struct lp55xx_led *led,
 				pdata->led_config[chan].color_id[i];
 			mc_led_info[i].channel =
 					pdata->led_config[chan].output_num[i];
-			j++;
 		}
 
 		led->mc_cdev.subled_info = mc_led_info;
-- 
2.37.3

