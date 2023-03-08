Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01436B0846
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCHNRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCHNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:16:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F91E5FA;
        Wed,  8 Mar 2023 05:13:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so2227019pjg.4;
        Wed, 08 Mar 2023 05:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678281202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9DydYMTRcu+Y1TIha62te3KuLPkmgUGtmnQcwLhqok=;
        b=Tn5RpYYPDAxm4Z7gCKwmkYz586o87KxZws4SUGzdG3r5dY6sqt48NpTvOaTMOe7HCg
         QXGOU96te0rOAKK9l45lxVeOyFFObDCpkkcyrAJl8GIu68LPXeZ/6E/ntIvVXRG0Er3u
         lBRCpkG8M/qN5TIyFQ6UFTOTFRh0BXLNrFPwcMC/RIvJ4hTH5jBxv4ZxiqmeWrioBrLO
         GnO1LEEh5uTAxANXib6aKPZu9hz3g3503wKnkWQx5kw97+ajapIc4AoYKtkJxjAblAYL
         HzWwgBvV8UIdgAd7GCiAIKnosqTAQ8u+MjInJNbDOncMrtS+Pc38M4pXmGGTRXQFe8y9
         LvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9DydYMTRcu+Y1TIha62te3KuLPkmgUGtmnQcwLhqok=;
        b=bdZ2WfajaY9B72j2QYbKye6Ihy8w1L78Hmf5jhHZGzeJ1ezE0wCoAjyIh4JLLMMbkd
         ZDnhCPIaEGLL63knZCbo4PBy+0lNLDt2th0ZI3zrsgQoOOqBvBRPBz124E8FJGRfX1II
         oO4o9vtN7PsN7XLi9aCEIi/FlQ3Lg+Exqq3sSKM6PIRMc8V9GueDU7MZv+zPcFx+bY3B
         UYbgs/ou4fDpAr3HwVZqJ8vAloBu49um0QcgyV1BBnX4/3jmpRf5J1ueocRTFB1/gy5g
         6wIajNeU1+a6hXna8nBfZ+T4UrMjPUCjkDSrh0YY5tUI57cLZhLkoOTJ3H4KUjdp4q5e
         L/Kg==
X-Gm-Message-State: AO0yUKXEp1isvLMkwKqLy1hui6oQry6FAFwNRu6UaQ5oD8IHjNjDy7EO
        frJtel7qfyiTLER1846OFaNcinNt4w8Xqg==
X-Google-Smtp-Source: AK7set/TwA4lxLU+d97/RzlILaZxriqI8LnAscbUByLondBzsqbLuaqyyVNMLWvvA8lFw+quo3Zs+g==
X-Received: by 2002:a05:6a20:ba9e:b0:cc:9f59:4562 with SMTP id fb30-20020a056a20ba9e00b000cc9f594562mr15918278pzb.53.1678281202174;
        Wed, 08 Mar 2023 05:13:22 -0800 (PST)
Received: from localhost.localdomain (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id i15-20020aa78b4f000000b0061ddff8c53dsm931038pfd.151.2023.03.08.05.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:13:21 -0800 (PST)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     mkorpershoek@baylibre.com, phoenix@emc.com.tw,
        josh.chen@emc.com.tw, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 RESEND 3/3] Input: elantech - Fix incorrectly halved touchpad range on ELAN v3 touchpads
Date:   Wed,  8 Mar 2023 05:13:07 -0800
Message-Id: <20230308131307.13832-4-nyanpasu256@gmail.com>
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

On Linux 6.1.15, on my laptop (Dell Inspiron 15R SE 7520) with an Elan
v3 touchpad (dmesg says "with firmware version 0x450f02"), the reported
size of my touchpad (in userspace by calling mtdev_configure() and
libevdev_get_abs_maximum(), in kernel space
elantech_device_info::x_max/y_max, either way 1470 by 700) is half that
of the actual touch range (2940 by 1400), and the upper half of my
touchpad reports negative values. As a result, with the Synaptics or
libinput X11 driver set to edge scrolling mode, the entire right half of
my touchpad has x-values past evdev's reported maximum size, and acts as
a giant scrollbar!

The problem is that elantech_setup_ps2() -> elantech_set_absolute_mode()
sets up absolute mode and doubles the hardware resolution (doubling the
hardware's maximum reported x/y coordinates and its response to
ETP_FW_ID_QUERY), *after* elantech_query_info() fetches the touchpad
coordinate system size using ETP_FW_ID_QUERY, which gets cached and
reported to userspace through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the
touchpad size reported to userspace (and used to subtract vertical
coordinates from) is half the maximum position of actual touches.

This patch splits out a function elantech_query_range_v3() which fetches
*only* ETP_FW_ID_QUERY (touchpad size), and calls it a second time if
elantech_set_absolute_mode() enables double-size mode. This means the
first call is redundant and wasted if a second call occurs, but this
minimizes the need to restructure the driver.

Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/
Link: https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
Fixes: 37548659bb22 ("Input: elantech - query the min/max information beforehand too")
Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/mouse/elantech.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 263779c0313b..a2176f0fd36c 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1006,6 +1006,9 @@ static void elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
 		psmouse_err(psmouse, "restoring reg_07 failed\n");
 }
 
+static int elantech_query_range_v3(struct psmouse *psmouse,
+				   struct elantech_device_info *info);
+
 /*
  * Put the touchpad into absolute mode
  */
@@ -1047,6 +1050,14 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		if (elantech_write_reg(psmouse, 0x10, etd->reg_10))
 			rc = -1;
 
+		/*
+		 * If we boost hardware resolution, we have to re-query
+		 * info->x_max and y_max.
+		 */
+		if (etd->info.set_hw_resolution)
+			if (elantech_query_range_v3(psmouse, &etd->info))
+				rc = -1;
+
 		break;
 
 	case 4:
@@ -1671,6 +1682,20 @@ static int elantech_set_properties(struct elantech_device_info *info)
 	return 0;
 }
 
+static int elantech_query_range_v3(struct psmouse *psmouse,
+				   struct elantech_device_info *info)
+{
+	unsigned char param[3];
+
+	if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		return -EINVAL;
+
+	info->x_max = (0x0f & param[0]) << 8 | param[1];
+	info->y_max = (0xf0 & param[0]) << 4 | param[2];
+
+	return 0;
+}
+
 static int elantech_query_info(struct psmouse *psmouse,
 			       struct elantech_device_info *info)
 {
@@ -1826,11 +1851,8 @@ static int elantech_query_info(struct psmouse *psmouse,
 		break;
 
 	case 3:
-		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		if (elantech_query_range_v3(psmouse, info))
 			return -EINVAL;
-
-		info->x_max = (0x0f & param[0]) << 8 | param[1];
-		info->y_max = (0xf0 & param[0]) << 4 | param[2];
 		break;
 
 	case 4:
-- 
2.39.2

