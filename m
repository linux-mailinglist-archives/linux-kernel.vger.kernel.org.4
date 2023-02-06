Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80E68B86D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBFJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:17:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE4EA5D4;
        Mon,  6 Feb 2023 01:17:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13so8137568wmr.4;
        Mon, 06 Feb 2023 01:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRDtIh0HaJd8mkQWqVCqpf70WtwM51nZwFrJJwrV4dA=;
        b=ndUdeiB+O6ZdDHjxtMacWQ8HHMLPWnds8zHZW8AVMv4ZCLG1Tob68VIjg1XqIx44fR
         shtT/RIcXwwITOkQRePplPdO7Bwus4sK104Vm+QTyX3l2z7nq1hvaT0CYS2uim0X73tf
         bpB8DunUz8re3MSbnb0uu998IPRNH/W1GxN5gahsipogoy5EiBeWGEMt5xifMHku2e6L
         8oGrvUoQ7IE5tp3RSBusWC5LS71QUTBNnyfn4pwsOSXquCfGa36vONXrnb1DHPeYi1EN
         39V2aPqcu97HUCZbcRvn2FLH6x/tbp++BC8jLZeYYd/vfO0jkxrjQ/JEyQtKneNUQoSj
         Dz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRDtIh0HaJd8mkQWqVCqpf70WtwM51nZwFrJJwrV4dA=;
        b=eddkYw/crDijBOPLbNcU4AECf+0QM5w1WnpmLucVeZNu3XVTUchgNvzOTigT6+5xbf
         dVCa9QSYZaSk8dlLnJU9JhJ7b6Q919HA5vlGKakdlDX5ZWsQgvwpuUFZHG7zj8ttX3Nx
         8/iux1pG2154O7gY63Hu+3SEkrMp/xreAIkyYoYG8/OVBTtvh1DaEg6FKfTnjQNch+Ii
         xhKLb9WLyCeTWrzLUGWByPRHYRTRHoCvdjc/4L3Twvrmw0kWbhwtMr9TwT37O3SpCp/h
         Sl/B2pwA+LvIZC6lz3YQLZb+Z3YScIFkvrn2noTmttifdIiQVsJvK7bkVJoHMUgdpuuc
         YALQ==
X-Gm-Message-State: AO0yUKViYDF37QtvmRvhyWDa5euyIPFCwcEuHOIT4xYtUmNxFng9WPAN
        y2GpciMWrMlCC305MVgdsRmE3uOTeXzDbQ==
X-Google-Smtp-Source: AK7set/INpsz162ODGiy6hJRXrbsruBrgGjW9CjtIusO0qvRff/uLWpJYdt1uGMZ2UeLUlLa6k7+ig==
X-Received: by 2002:a1c:7c0e:0:b0:3dc:561a:79d8 with SMTP id x14-20020a1c7c0e000000b003dc561a79d8mr28845wmc.35.1675675063184;
        Mon, 06 Feb 2023 01:17:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003dc4480df80sm15566539wmj.34.2023.02.06.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:17:42 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     ChiaEn Wu <chiaen_wu@richtek.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: rt9467: Fix spelling mistake "attache" -> "attach"
Date:   Mon,  6 Feb 2023 09:17:42 +0000
Message-Id: <20230206091742.45977-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
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

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/rt9467-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index 96ad0d7d3af4..73f744a3155d 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -970,7 +970,7 @@ static irqreturn_t rt9467_usb_state_handler(int irq, void *priv)
 
 	ret = rt9467_report_usb_state(data);
 	if (ret) {
-		dev_err(data->dev, "Failed to report attache type (%d)\n", ret);
+		dev_err(data->dev, "Failed to report attach type (%d)\n", ret);
 		return IRQ_NONE;
 	}
 
-- 
2.30.2

