Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF785EF046
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiI2IVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiI2IVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:21:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF851B7A6;
        Thu, 29 Sep 2022 01:21:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 3so832906pga.1;
        Thu, 29 Sep 2022 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=44IyFYTlV7SPq/8WObcl0GLatKL7zrsYf18ZG5bJ/Xo=;
        b=U1e5Zog5o8MxtDdfumn1djJUqkyT/K8+ja9R+5CWs4OuZffNPHPAW10bf2Gpe+r7I9
         Cs5zSFAwOhBMF50cbwJINIqq/4tyWQRQWei2DYl/ux8zkEff5rkyfSUhGPYcg89fdiuT
         1yvKrhrzSWA6pucVVkjEK0itepe7Fam6+OyEECeighiFARbF0X+BucC6edu/ioI97q5c
         CfHyP5jGK/GwM1SHZF4c+UlhMyseBbfHZ6qYjDA8At31tyFS4s5AYzWIf2OdqLDiR2aq
         cykWbFVFEuS735ZZHwBqr++8QkRZZNC77tuIr28QHfVySRwrCXNXgbQs5wAeUAV7EPTk
         gzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=44IyFYTlV7SPq/8WObcl0GLatKL7zrsYf18ZG5bJ/Xo=;
        b=6gaEg8vYmFeLsEaaAoLejsNLV3wiBDPRYSHU+vjogQLfjigrj+vLV1mxqpLET4xnCM
         Z8+C0+5884LjP8SffT/cmBAkfV3PM4m4gYEhizeL7dAYwAqz6ocfvTW/J+KKL8BgXCv+
         8xTvu10iYc+mIpFagIWR5M6TvqrmoffWi8QrYNN+2T8HJH2O8N/QuqVGwAPBcFrmBelQ
         0T79pBjXPjKMHXJj+McKU674ny1lnXjIBVkqDe5UvJqM4EAnmwZLytESqPKid4mc/iYy
         iG/LsAmCT6WTauwPBCBF31QNGvCEcdqopCT90s/+J5sraEnBMAFzIFAucoaYZ0wkYkK/
         0NSg==
X-Gm-Message-State: ACrzQf2YNxkjwBKSvHImSZ+H5vju4Q42a+NhqW6xB/noRP83a5WMSsZo
        J6lw8E2evGKaX4xDK8XngEw+nx360UhiM0A5
X-Google-Smtp-Source: AMsMyM6Z+nvXjEoB2x1hbVePRpYWa+WY0h7MKwemfeADkflHGmT6AyO+wNZn8oBqZgiI2kpozNPV0A==
X-Received: by 2002:a05:6a00:1503:b0:546:833c:ed05 with SMTP id q3-20020a056a00150300b00546833ced05mr2273554pfu.44.1664439681563;
        Thu, 29 Sep 2022 01:21:21 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id p16-20020aa79e90000000b005360da6b26bsm5474476pfq.159.2022.09.29.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:21:21 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Input: Remove redundant field elantech_data::y_max
Date:   Thu, 29 Sep 2022 01:21:17 -0700
Message-Id: <20220929082119.22112-2-nyanpasu256@gmail.com>
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
2.37.3

