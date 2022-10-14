Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B35FED17
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJNLQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJNLQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:16:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675FD105650;
        Fri, 14 Oct 2022 04:16:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f23so4437167plr.6;
        Fri, 14 Oct 2022 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLxzw5+5P9J9R3KO3i/HaA++CGx0Vnt/e4O2kC9C4sY=;
        b=FG+KOruDTgIzTuTp8m9ioJeEVGqdp7cK890uLZClBTnm+jYTSIPQ1ogCsr5npYoWQ7
         aGYvQpJcm+qscQAW+134W75E4i4FIMU4ThzQm+Mz1aWKjBvw31aIf1BHvrmyHdk/pDlr
         YFQ3lO1CnuUEmOLgnsA7J6YVRIAZfFysb+2RdA0erk9bnmRddZ1ubMgDrKz01lUK+mVX
         Q4vsW9l9HUOvxU99HhHfcChm4dJLYlLb+tTG1W4vcPwqJZvrN6EJX4/j8F8BbdnUfYND
         3rThUKaIcCKKCXRihoVPwneY/1+QX3AdKg7mHNEXg+U7iXPB5B/Qesvph3OdVnkMsen9
         H1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLxzw5+5P9J9R3KO3i/HaA++CGx0Vnt/e4O2kC9C4sY=;
        b=Uus+Txa56MyD32Lai+o8BAvu/wVIjdL6rxe+61OSLUBeIZonHHDeFTnaURJQCTIRf7
         yr18YE1uYcZEJtiUat9TdisV8vLEF3TlqZPkZSFPZwZVvt7tx6+nRdUa8btWVKQAXyWA
         auaqBgGFeIlTTZ3JVozSS7jvl0RNZx5f7B7UwNJEskSDHo5kNkv+TMFmxrWBjE8twfSl
         Qc8fCA2Ftx1y0Lb2KANu9D+BnjjhcHkeSfpjc6quR4SQrZt6op0ppAwMD6Gyy5cey0IW
         YgTMgK8i7DUNKe2+OQbxxBnAIW/6cmsI2acMQeC3OPmPM4TS16hpVUXrM5vd59m+WZrM
         EsIQ==
X-Gm-Message-State: ACrzQf3hKQpioiB6cQDWLBGwzcu+Pg7yd1IX9u6y8sja6WCah9HNU8pg
        ngw73ElvY/PtbTXblo6hYIrqGfktYSRynA==
X-Google-Smtp-Source: AMsMyM6BmWr+snx4QhjAtt6CF3I2QPd72fb9udd8UfYSwhx6lZO3ZvMM3O9V+CyxXIHP4yA2aLRkBg==
X-Received: by 2002:a17:903:1d1:b0:17f:6494:f8c3 with SMTP id e17-20020a17090301d100b0017f6494f8c3mr4536833plh.157.1665746182056;
        Fri, 14 Oct 2022 04:16:22 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090aab8900b001fd6066284dsm1304628pjq.6.2022.10.14.04.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:16:21 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 1/3] Input: elantech - Remove redundant field elantech_data::y_max
Date:   Fri, 14 Oct 2022 04:15:31 -0700
Message-Id: <20221014111533.908-2-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014111533.908-1-nyanpasu256@gmail.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
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
---
 drivers/input/mouse/elantech.c | 17 ++++++++---------
 drivers/input/mouse/elantech.h |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ece97f8c6a..79e31611fc 100644
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
index 571e6ca11d..1ec004f72d 100644
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
2.38.0

