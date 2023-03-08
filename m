Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C06B0847
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCHNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjCHNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:16:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0383151;
        Wed,  8 Mar 2023 05:13:22 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n6so17586867plf.5;
        Wed, 08 Mar 2023 05:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678281200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXaLa5HmcYzrfq+b8cSAVhY/ivp9VzoFLihZVltD2T8=;
        b=citMaKX9rUUB6bkNu7btENi4OYo8kXuQNRAA345Nf0VuGbpj2KOI5Fz0Pw/nZ/wT27
         lre1F6nS53i4Yo23CPmlXWSO9rcrmMESDKgAhMAyw3DzXS0rHmpy3MU7pGopUogTOI5X
         cEKejl9Soa+Rl+YvwAEkY8Gv9Imlfkj7eVdSdXde7ybsRWL9mQGUwiE2XWz0Cf3wIwCd
         uw4l/aFjbj1VSzFtjKtTVyaV5iLbsxAuWPfKyoqi6sxCz4prvzi5bewpfSYtqbHvmjvO
         3M3hy0lJwr/21gAT6d4vXNllhAdlqMW9ljHgKySF5p6iUGzp4EOrgCA1noHV3PjD9PmH
         eexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXaLa5HmcYzrfq+b8cSAVhY/ivp9VzoFLihZVltD2T8=;
        b=2D/6reNujd9kjzq4uZ58buoiEFjVpWp41qgvk9JgWHYpqKMJo1fH8X4drTcYDMbdS1
         lBqXX4eAkLEGQlh1fhZi7S+xgwX5iILBViiBr1409QbBn3CHDHc1zeAtQY+L8UwAwATn
         ZiMuDadOjoZMXnuFOGi1zMKdMbXf6Ia/sc6gxB22Xjq3CBQ+aEEKBKaaeAL5p9iJDK8v
         Jyxk/vfQvyM8QtVxenB5chO2Dl+7Ymj03L7N2SX89289xxjPx9HtDwSo+0MkCCqu8C9a
         lU/Spc+29oeDOFgnO2TKGY4kNIaHeKslAWp0XkgbTPdEq/9Oetw984GWE2hWSNqam2wF
         snOg==
X-Gm-Message-State: AO0yUKWndfcOef05BrZIq6vvzFke2Nfa5AmHhYKrkYNb+RDu7hofuo23
        CHDEc2R6PQlhPgxB1diW2po=
X-Google-Smtp-Source: AK7set81Lz35AZxpptEEz9n4CnY9lDfLA43k6zSDVd+p5Fe1pJg7q3tOBPcK3V0yVc4bGIZ0cI1RLw==
X-Received: by 2002:a05:6a20:1585:b0:cc:a93:2b81 with SMTP id h5-20020a056a20158500b000cc0a932b81mr19438040pzj.41.1678281200158;
        Wed, 08 Mar 2023 05:13:20 -0800 (PST)
Received: from localhost.localdomain (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id i15-20020aa78b4f000000b0061ddff8c53dsm931038pfd.151.2023.03.08.05.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:13:19 -0800 (PST)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     mkorpershoek@baylibre.com, phoenix@emc.com.tw,
        josh.chen@emc.com.tw, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 RESEND 1/3] Input: elantech - Remove redundant field elantech_data::y_max
Date:   Wed,  8 Mar 2023 05:13:05 -0800
Message-Id: <20230308131307.13832-2-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308131307.13832-1-nyanpasu256@gmail.com>
References: <20230308131307.13832-1-nyanpasu256@gmail.com>
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

elantech_data::y_max is copied from elantech_device_info::y_max, and
neither is mutated after initialization. So remove the redundant
variable to prevent future bugs when updating y_max.

Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/mouse/elantech.c | 17 ++++++++---------
 drivers/input/mouse/elantech.h |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ece97f8c6a3e..79e31611fc6e 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -360,7 +360,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 		input_report_abs(dev, ABS_X,
 			((packet[1] & 0x0c) << 6) | packet[2]);
 		input_report_abs(dev, ABS_Y,
-			etd->y_max - (((packet[1] & 0x03) << 8) | packet[3]));
+			etd->info.y_max - (((packet[1] & 0x03) << 8) | packet[3]));
 	}
 
 	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
@@ -435,7 +435,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 		 * byte 4:  .   .   .   .  y11 y10 y9  y8
 		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
 		 */
-		y1 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
+		y1 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
 
 		pres = (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
 		width = ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
@@ -450,7 +450,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 		 */
 		x1 = (((packet[0] & 0x10) << 4) | packet[1]) << 2;
 		/* byte 2: ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0 */
-		y1 = etd->y_max -
+		y1 = etd->info.y_max -
 			((((packet[0] & 0x20) << 3) | packet[2]) << 2);
 		/*
 		 * byte 3:  .   .  by8 bx8  .   .   .   .
@@ -458,7 +458,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 		 */
 		x2 = (((packet[3] & 0x10) << 4) | packet[4]) << 2;
 		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
-		y2 = etd->y_max -
+		y2 = etd->info.y_max -
 			((((packet[3] & 0x20) << 3) | packet[5]) << 2);
 
 		/* Unknown so just report sensible values */
@@ -579,7 +579,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 		 * byte 4:  .   .   .   .  y11 y10 y9  y8
 		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
 		 */
-		y1 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
+		y1 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
 		break;
 
 	case 2:
@@ -593,7 +593,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 			 * byte 4:   .    .    .    .  ay11 ay10 ay9  ay8
 			 * byte 5: ay7  ay6  ay5  ay4  ay3  ay2  ay1  ay0
 			 */
-			etd->mt[0].y = etd->y_max -
+			etd->mt[0].y = etd->info.y_max -
 				(((packet[4] & 0x0f) << 8) | packet[5]);
 			/*
 			 * wait for next packet
@@ -605,7 +605,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 		x1 = etd->mt[0].x;
 		y1 = etd->mt[0].y;
 		x2 = ((packet[1] & 0x0f) << 8) | packet[2];
-		y2 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
+		y2 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
 		break;
 	}
 
@@ -681,7 +681,7 @@ static void process_packet_head_v4(struct psmouse *psmouse)
 		return;
 
 	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
-	etd->mt[id].y = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
+	etd->mt[id].y = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
 	pres = (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
 	traces = (packet[0] & 0xf0) >> 4;
 
@@ -1253,7 +1253,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
 	}
 
-	etd->y_max = y_max;
 	etd->width = width;
 
 	return 0;
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 571e6ca11d33..1ec004f72d13 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -180,7 +180,6 @@ struct elantech_data {
 	unsigned char reg_25;
 	unsigned char reg_26;
 	unsigned int single_finger_reports;
-	unsigned int y_max;
 	unsigned int width;
 	struct finger_pos mt[ETP_MAX_FINGERS];
 	unsigned char parity[256];
-- 
2.39.2

