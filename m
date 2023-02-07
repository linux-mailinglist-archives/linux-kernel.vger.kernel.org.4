Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78E68D253
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjBGJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjBGJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:14:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED82B084;
        Tue,  7 Feb 2023 01:14:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r2so12836248wrv.7;
        Tue, 07 Feb 2023 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnOMeG0z+YCevJjETbIYGt07S+IbdApmVaDUDwVjN8U=;
        b=iqlAf7IGMyIOrcKjo+GQMhHPJG6L6QvHww9wyGLEFS56jdFszjRj15dzxrUf6AMNBC
         RDsxjqagk1CLTr8CwmHto2Fz6sq+pgCqj640Km2/vSTeqO4frnXLFWq6wgtHyteVFM0d
         95HOJ1JP26R16VXiWvMb2xQFoHzePRnjO85XemX8yWzYTweqk0xr/0xkmT/aUsdaoic5
         VF8x0bmepJSwpe6y9rwpC3m61PYM04SunqcFQvUbAc4stRekVH6AQynVJki6LRemKp6L
         uDrHlxrGnHEQ74VibFi2GYvH8ycHsMHnITQNKPxapKQPLLSlUUIFpEzsoYeSpBx0GC5N
         yHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnOMeG0z+YCevJjETbIYGt07S+IbdApmVaDUDwVjN8U=;
        b=3RwIWsb75wtvTpz8SVAfE2Zp29VHAYk1bsYrWSpPmqg5gG/PBwoF694kOjA88gQtKt
         0WScMVdUxwH0+HfieHtNP84WFlDOWpErWYRHJEGBkYLWTKCxH6Rj85mR1y0n44PYhMxY
         UrMSiO1TTfbnDIHkeZFw6kO3/0agVe4fC79UU7FLTHiewYjhyE0E8EC6NQgbLRmrxf5b
         OEsjJxG5YLiRX2lZPv4gts4GhLNzTi0XCqW5ni74+d+qWqkn1e17+v/9FXGZjZnkboxD
         tU+xtDpQJdv+8HDSxwXE8c/faBz7yfE7c9L4HZBBQXZwbCl7Vy3+B9OweQ+NpbT9gBqq
         JhNQ==
X-Gm-Message-State: AO0yUKW3cKT9w8PLGdKA0BxgjJCPtz1ZEaSF+SjdVa/EazKfigaNbH+4
        EMB3cg3XMxcoTa5HgBQvNfqpU0NGVB7WPYfk
X-Google-Smtp-Source: AK7set95oC0Zx1vGd8VPUnITmIN++zR08TCoUYDCujeSmKMmRwYBoI5qC0HZN3YdOhaYkVNR6b9BcA==
X-Received: by 2002:a5d:6447:0:b0:2be:57a6:8161 with SMTP id d7-20020a5d6447000000b002be57a68161mr1879784wrw.46.1675761285516;
        Tue, 07 Feb 2023 01:14:45 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d53d1000000b002c3ebbc9248sm3704990wrw.66.2023.02.07.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:14:44 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/chrome: Fix spelling mistake "Attenetion" -> "attention"
Date:   Tue,  7 Feb 2023 09:14:43 +0000
Message-Id: <20230207091443.143995-1-colin.i.king@gmail.com>
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

There is a spelling mistake in a dev_warn message, make it lower case
and fix the spelling.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 71f5d7d8e055..a673c3342470 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1020,7 +1020,7 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 		cros_typec_handle_vdm_attention(typec, port_num);
 		ret = cros_typec_send_clear_event(typec, port_num, PD_STATUS_EVENT_VDM_ATTENTION);
 		if (ret < 0)
-			dev_warn(typec->dev, "Failed VDM Attenetion event clear, port: %d\n",
+			dev_warn(typec->dev, "Failed VDM attention event clear, port: %d\n",
 				 port_num);
 	}
 }
-- 
2.30.2

