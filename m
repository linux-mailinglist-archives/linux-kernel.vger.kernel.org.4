Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712705EF044
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiI2IVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiI2IVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:21:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F2115A5E;
        Thu, 29 Sep 2022 01:21:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4816494pjq.1;
        Thu, 29 Sep 2022 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JyLToP/vJcFWzI/Afm3UzHXzpCtES00UQuQZzF99234=;
        b=TA8zIhU4jy6r4eAjIHuijTX+/ASLlByqwK4Vf8pyWjxMadQ7JyM9LY0m0N6WwGc5zS
         pAs3qOeknmtlONwcQHoWAdkF33kS6qPNi8BDNyMKchTb69zaRMLFFOk4wzf8qLtcvkHh
         QySiMIchlJmoVytzf4v41W1nd3u9CIveIHb8ihRaqtK+Emv3dmBwD3SlkZRt0mrs+W59
         vl4ubFjKpscw2I9Y0gXdoesgoy/C3vUvDlooAn/D44dhjsAFn9P2ou0Ek4ujSj3xY6NJ
         axQvv3wCtDU7pZYVRkItKpeTMGkydTzQlnkyZqsQ/hcUzYFO2b/zZdU1bk8KVmNKwCp3
         9zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JyLToP/vJcFWzI/Afm3UzHXzpCtES00UQuQZzF99234=;
        b=tFbl0r6pXWqf+EeX+yJTzAlRgftusBPmkSO9OrAMRAHAaP1EgO7zXpYG47sVWBHBoZ
         7n+jhBpSxN8EjXhbNThdxJtFcVHfAlJLzCSTTz3RDF+8M6wKuWi5LyRNcE43Q9SZxywI
         d6MIZHbFX6mFa3W57703PG6wSEdtOHqTLTV+pR9qfXnByx4sA4CZ8F7D4vsGBq2iTR+C
         CVE8pFbxjyvXnXEDw30icK7QLZiN53t2+N7O/GhW+7+PEvtK/MJ9My2bb976K/GmOY3j
         IXaY9PRU2KmNloDv8MPGqWOueQTKkdKIx9B97VgiGIsH7fyZIb0uKw1OTIkOsGsY71BY
         jueg==
X-Gm-Message-State: ACrzQf3WMnRDuqWQjbUJ8Pek8bEPl2oCC1GJUtbxAEfxk7DSbWpWZt40
        4yQ99kIEWQ1VJSrz0leq+b8bBOgw4abp7pHT
X-Google-Smtp-Source: AMsMyM4MqRgxfAruWwL8SwQQIhvthQe0DvFmHq7SUzbGzJXrN4YtKkIXkEy93wcr8NBK/El24ErFtQ==
X-Received: by 2002:a17:903:1245:b0:178:9234:3768 with SMTP id u5-20020a170903124500b0017892343768mr2310443plh.146.1664439682268;
        Thu, 29 Sep 2022 01:21:22 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id p16-20020aa79e90000000b005360da6b26bsm5474476pfq.159.2022.09.29.01.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:21:22 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: Remove redundant field elantech_data::width
Date:   Thu, 29 Sep 2022 01:21:18 -0700
Message-Id: <20220929082119.22112-3-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929082119.22112-1-nyanpasu256@gmail.com>
References: <20220929082119.22112-1-nyanpasu256@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elantech_data::width is copied from elantech_device_info::width, and
neither is mutated after initialization. So remove the redundant
variable to prevent future bugs.

Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
---
 drivers/input/mouse/elantech.c | 4 +---
 drivers/input/mouse/elantech.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 79e31611fc..263779c031 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -691,7 +691,7 @@ static void process_packet_head_v4(struct psmouse *psmouse)
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 	input_report_abs(dev, ABS_MT_PRESSURE, pres);
-	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, traces * etd->width);
+	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, traces * etd->info.width);
 	/* report this for backwards compatibility */
 	input_report_abs(dev, ABS_TOOL_WIDTH, traces);
 
@@ -1253,8 +1253,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
 	}
 
-	etd->width = width;
-
 	return 0;
 }
 
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 1ec004f72d..fb093134ea 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -180,7 +180,6 @@ struct elantech_data {
 	unsigned char reg_25;
 	unsigned char reg_26;
 	unsigned int single_finger_reports;
-	unsigned int width;
 	struct finger_pos mt[ETP_MAX_FINGERS];
 	unsigned char parity[256];
 	struct elantech_device_info info;
-- 
2.37.3

