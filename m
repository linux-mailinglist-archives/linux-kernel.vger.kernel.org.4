Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD465EDFC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjAEN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjAENz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753D4BD73
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:53:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m18so90017635eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MeFBvW17iGnsCcj82DHSwKB7XpQUqOmaboAmgVuBOU=;
        b=BLDTadc0WPWJ4z5zc6bsb/Bf/L6gBQCEBjtMPlJ4PReFVLby3HH0HIvmgdk2aNUA7H
         cg11AexWd5pVB5s76HhjR+JhXEcTXruybsLGTSFX/HGN9P9UuTc1tCk9OibtRUF4zSBU
         rJ5BWfzNzu+/RCZDlPrc7SjTEuZsfWmWsPDxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MeFBvW17iGnsCcj82DHSwKB7XpQUqOmaboAmgVuBOU=;
        b=QMNKExyS2OsK9nRtN4tZNjuLcdR/7yGj3opOv05QG1F9l6TdBYxxsMro8u0Sqk0kiH
         gktXvr4W87SmdC0OdV9fSOH4RcNKYdBk7U9rQuHTZkw4GMTAzu3UfV6zdZ3ORRgTFxlB
         bIdEqvZZWV4QLZGy5867UvNOb5CorypgKphFn2Sxyjsqv5Zyl8kn7BbOjs5UtuJXDc1J
         gDPv1s1EcEmBOQI0VadfiDvlHqS7XBOwpxO1+l9BFXxinaNy3tC3JVtGWFPTIGM8TyFi
         1cbwCpD9+RJXashNF+JbytA2QASuDae7CH1tI8DnvNL0A1HhxTmRKvXc1hbT97G/SGJb
         XEQw==
X-Gm-Message-State: AFqh2kpy7d/3Dnva9l1GehvEyYHhiTNnauJUMKivtylI5aTpPamzLE2a
        tTujO6PHElxJdfZkX3I/f4jXjA==
X-Google-Smtp-Source: AMrXdXswahqibIq9zURDhnn/0/0Y3myUpBQjmGHmQ/LRlYIk0P2eK+1E5GQHOX+YyD+IGliC3e0pug==
X-Received: by 2002:a17:906:49cd:b0:7c0:f684:9092 with SMTP id w13-20020a17090649cd00b007c0f6849092mr43243064ejv.37.1672926800820;
        Thu, 05 Jan 2023 05:53:20 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16459084ejy.127.2023.01.05.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:53:20 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 14:52:58 +0100
Subject: [PATCH v2 7/7] media: uvcvideo: Use standard names for menus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v2-7-2ba6c660d6f5@chromium.org>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=13910; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=KAO3wtvchNw9niVHGiqrZkP1Ih5WWG4CeWxKIm4q0cQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjttZH6oQDJfUwz2AVEG7JUwtn7v7/Tk6q3vm99wbj
 BgGdRyKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bWRwAKCRDRN9E+zzrEiHuED/
 9lweyP5TQIvuV1j5we5YcoIIgLS+h6dki3SL7QBoo1I8DzPk6JcYtRmLyYS2MBBcfwzf7KCjaNOuXT
 WgQ8SLLzg6xiQovYa2xthnhTcfvlP5GJeBNqGmnY59ptB+SSDFhbZDPF9Fi3W9jCJ/vlpRB5gEo5Ql
 Of0deFUY4TL/J+qD+0ESHH/E5DPsQSEt7uXdktF7aDP9HhCEFjW6TBcBZxdRtkMbr0NlxW1gxvydtX
 TyghEe5xp0z9KGgmNb5qA89uEKrEUbBXEKVystJIt6e9mZL77mvFUZ08a4mgvLUEaWYDLP3Us3SOv9
 Wzf/YdWjAWlUvrVDOAPAynul28rbjITSrYRSkT68S8SLhZqC9i2FV312zSyf5tD3mCGt2hKZ0pjETs
 HxYeBpF400tPSmYdKypaY51ZkJahlux50erlYb/0RjRr6i3wCTNz0tnJ6t9kuPx7OadSRUtqgm96ip
 pf6n0oaTJV53l+mQPcgFKAvH3ZoOhj0n3qr4F4Zb5EPpeC5/A6bpN//vOESs3EPflpTi7w9MLjEo6O
 KPMj5VJtOFMtgQXNoZObXvMAk0WdSrC6bPY5YeUgXjmZpUwmGxazsrIzTIGVQIkjKSm31id8xvP05w
 /ZfB5uPTXVupkw7K7jg4nHFOv0ruGy6O76cbRraeYyQiWEv7rGkRKWDq1bWw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of duplicating the menu info, use the one from the core.
Also, do not use extra memory for 1:1 mappings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 122 +++++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvc_v4l2.c | 105 ++++++++++++++++++++++++---------
 drivers/media/usb/uvc/uvcvideo.h |   3 +-
 include/uapi/linux/uvcvideo.h    |   4 +-
 4 files changed, 168 insertions(+), 66 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 28ef9b2024a1..f5a9d67e0966 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -364,19 +364,31 @@ static const u32 uvc_control_classes[] = {
 	V4L2_CID_USER_CLASS,
 };
 
-static const struct uvc_menu_info power_line_frequency_controls[] = {
-	{ 0, "Disabled" },
-	{ 1, "50 Hz" },
-	{ 2, "60 Hz" },
-	{ 3, "Auto" },
-};
+static const int exposure_auto_mapping[] = { 2, 1, 4, 8 };
 
-static const struct uvc_menu_info exposure_auto_controls[] = {
-	{ 2, "Auto Mode" },
-	{ 1, "Manual Mode" },
-	{ 4, "Shutter Priority Mode" },
-	{ 8, "Aperture Priority Mode" },
-};
+static int uvc_mapping_get_menu_value(const struct uvc_control_mapping *mapping,
+				      u32 idx)
+{
+	if (!test_bit(idx, &mapping->menu_mask))
+		return -EINVAL;
+
+	if (mapping->menu_mapping)
+		return mapping->menu_mapping[idx];
+
+	return idx;
+}
+
+static const char *
+uvc_mapping_get_menu_name(const struct uvc_control_mapping *mapping, u32 idx)
+{
+	if (!test_bit(idx, &mapping->menu_mask))
+		return NULL;
+
+	if (mapping->menu_names)
+		return mapping->menu_names[idx];
+
+	return v4l2_ctrl_get_menu(mapping->id)[idx];
+}
 
 static s32 uvc_ctrl_get_zoom(struct uvc_control_mapping *mapping,
 	u8 query, const u8 *data)
@@ -525,9 +537,9 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
-		.menu_info	= exposure_auto_controls,
+		.menu_mapping	= exposure_auto_mapping,
 		.menu_mask	=
-			GENMASK(ARRAY_SIZE(exposure_auto_controls) - 1, 0),
+			GENMASK(ARRAY_SIZE(exposure_auto_mapping) - 1, 0),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -731,7 +743,6 @@ const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.offset		= 0,
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls,
 	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
 				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
 };
@@ -744,7 +755,6 @@ const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
 	.offset		= 0,
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls,
 	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
 				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
 };
@@ -762,7 +772,6 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
 	.offset		= 0,
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls,
 	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
 				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
 };
@@ -995,13 +1004,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 	s32 value = mapping->get(mapping, UVC_GET_CUR, data);
 
 	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
-		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
+			u32 menu_value;
+
 			if (!test_bit(i, &mapping->menu_mask))
 				continue;
-			if (menu->value == value) {
+
+			menu_value = uvc_mapping_get_menu_value(mapping, i);
+
+			if (menu_value == value) {
 				value = i;
 				break;
 			}
@@ -1212,7 +1225,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 {
 	struct uvc_control_mapping *master_map = NULL;
 	struct uvc_control *master_ctrl = NULL;
-	const struct uvc_menu_info *menu;
 	unsigned int i;
 
 	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
@@ -1257,11 +1269,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
 		v4l2_ctrl->step = 1;
 
-		menu = mapping->menu_info;
-		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
+			u32 menu_value;
+
 			if (!test_bit(i, &mapping->menu_mask))
 				continue;
-			if (menu->value == v4l2_ctrl->default_value) {
+
+			menu_value = uvc_mapping_get_menu_value(mapping, i);
+
+			if (menu_value == v4l2_ctrl->default_value) {
 				v4l2_ctrl->default_value = i;
 				break;
 			}
@@ -1360,11 +1376,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 	struct v4l2_querymenu *query_menu)
 {
-	const struct uvc_menu_info *menu_info;
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
 	u32 index = query_menu->index;
 	u32 id = query_menu->id;
+	const char *name;
 	int ret;
 
 	memset(query_menu, 0, sizeof(*query_menu));
@@ -1386,22 +1402,39 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	menu_info = &mapping->menu_info[query_menu->index];
-
 	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
+		int menu_value;
+
 		if (!ctrl->cached) {
 			ret = uvc_ctrl_populate_cache(chain, ctrl);
 			if (ret < 0)
 				goto done;
 		}
 
-		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_info->value)) {
+		menu_value = uvc_mapping_get_menu_value(mapping,
+							query_menu->index);
+		if (menu_value < 0) {
+			ret = menu_value;
+			goto done;
+		}
+
+		/*
+		 * So far, only V4L2_CID_EXPOSURE_AUTO falls into this category
+		 * and its mappings (exposure_auto_mapping), are a bitmap.
+		 */
+		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_value)) {
 			ret = -EINVAL;
 			goto done;
 		}
 	}
 
-	strscpy(query_menu->name, menu_info->name, sizeof(query_menu->name));
+	name = uvc_mapping_get_menu_name(mapping, query_menu->index);
+	if (!name) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	strscpy(query_menu->name, name, sizeof(query_menu->name));
 
 done:
 	mutex_unlock(&chain->ctrl_mutex);
@@ -1902,7 +1935,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		if (!test_bit(xctrl->value, &mapping->menu_mask))
 			return -EINVAL;
 
-		value = mapping->menu_info[xctrl->value].value;
+		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
 
 		/*
 		 * Valid menu indices are reported by the GET_RES request for
@@ -2327,7 +2360,8 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 		return -ENOMEM;
 
 	map->name = NULL;
-	map->menu_info = NULL;
+	map->menu_names = NULL;
+	map->menu_mapping = NULL;
 
 	/* For UVCIOC_CTRL_MAP custom control */
 	if (mapping->name) {
@@ -2338,10 +2372,22 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
-	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
-	if (!map->menu_info)
-		goto err_nomem;
+	if (mapping->menu_mapping && mapping->menu_mask) {
+		size = sizeof(mapping->menu_mapping[0])
+		       * fls(mapping->menu_mask);
+		map->menu_mapping = kmemdup(mapping->menu_mapping, size,
+					    GFP_KERNEL);
+		if (!map->menu_mapping)
+			goto err_nomem;
+	}
+	if (mapping->menu_names && mapping->menu_mask) {
+		size = sizeof(mapping->menu_names[0])
+		       * fls(mapping->menu_mask);
+		map->menu_names = kmemdup(mapping->menu_names, size,
+					  GFP_KERNEL);
+		if (!map->menu_names)
+			goto err_nomem;
+	}
 
 	if (map->get == NULL)
 		map->get = uvc_get_le_value;
@@ -2364,7 +2410,8 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 	return 0;
 
 err_nomem:
-	kfree(map->menu_info);
+	kfree(map->menu_names);
+	kfree(map->menu_mapping);
 	kfree(map->name);
 	kfree(map);
 	return -ENOMEM;
@@ -2686,7 +2733,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
 
 	list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
 		list_del(&mapping->list);
-		kfree(mapping->menu_info);
+		kfree(mapping->menu_names);
+		kfree(mapping->menu_mapping);
 		kfree(mapping->name);
 		kfree(mapping);
 	}
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 0774a11360c0..06b4afbbf8b1 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -26,14 +26,84 @@
 
 #include "uvcvideo.h"
 
+static int uvc_control_add_xu_mapping(struct uvc_video_chain *chain,
+				      struct uvc_control_mapping *map,
+				      const struct uvc_xu_control_mapping *xmap)
+{
+	unsigned int i;
+	size_t size;
+	int ret;
+
+	/*
+	 * Prevent excessive memory consumption, as well as integer
+	 * overflows.
+	 */
+	if (xmap->menu_count == 0 ||
+	    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES)
+		return -EINVAL;
+
+	map->menu_names = NULL;
+	map->menu_mapping = NULL;
+
+	map->menu_mask = BIT_MASK(xmap->menu_count);
+
+	size = xmap->menu_count * sizeof(*map->menu_mapping);
+	map->menu_mapping = kzalloc(size, GFP_KERNEL);
+	if (!map->menu_mapping) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	for (i = 0; i < xmap->menu_count ; i++) {
+		if (copy_from_user((u32 *)&map->menu_mapping[i],
+				   &xmap->menu_info[i].value,
+				   sizeof(map->menu_mapping[i]))) {
+			ret = -EACCES;
+			goto done;
+		}
+	}
+
+	/*
+	 * Always use the standard naming if available, otherwise copy the
+	 * names supplied by userspace.
+	 */
+	if (!v4l2_ctrl_get_menu(map->id)) {
+		size = xmap->menu_count * sizeof(map->menu_names[0]);
+		map->menu_names = kzalloc(size, GFP_KERNEL);
+		if (!map->menu_names) {
+			ret = -ENOMEM;
+			goto done;
+		}
+
+		for (i = 0; i < xmap->menu_count ; i++) {
+			/* sizeof(names[i]) - 1: to take care of \0 */
+			if (copy_from_user((char *)map->menu_names[i],
+					xmap->menu_info[i].name,
+					sizeof(map->menu_names[i]) - 1)) {
+				ret = -EACCES;
+				goto done;
+			}
+		}
+	}
+
+	ret = uvc_ctrl_add_mapping(chain, map);
+
+done:
+	kfree(map->menu_names);
+	map->menu_names = NULL;
+	kfree(map->menu_mapping);
+	map->menu_mapping = NULL;
+
+	return ret;
+}
+
 /* ------------------------------------------------------------------------
  * UVC ioctls
  */
-static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
-	struct uvc_xu_control_mapping *xmap)
+static int uvc_ioctl_xu_ctrl_map(struct uvc_video_chain *chain,
+				 struct uvc_xu_control_mapping *xmap)
 {
 	struct uvc_control_mapping *map;
-	unsigned int size;
 	int ret;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
@@ -61,39 +131,20 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 	case V4L2_CTRL_TYPE_INTEGER:
 	case V4L2_CTRL_TYPE_BOOLEAN:
 	case V4L2_CTRL_TYPE_BUTTON:
+		ret = uvc_ctrl_add_mapping(chain, map);
 		break;
 
 	case V4L2_CTRL_TYPE_MENU:
-		/*
-		 * Prevent excessive memory consumption, as well as integer
-		 * overflows.
-		 */
-		if (xmap->menu_count == 0 ||
-		    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES) {
-			ret = -EINVAL;
-			goto free_map;
-		}
-
-		size = xmap->menu_count * sizeof(*map->menu_info);
-		map->menu_info = memdup_user(xmap->menu_info, size);
-		if (IS_ERR(map->menu_info)) {
-			ret = PTR_ERR(map->menu_info);
-			goto free_map;
-		}
-
-		map->menu_mask = GENMASK(xmap->menu_count - 1, 0);
+		ret = uvc_control_add_xu_mapping(chain, map, xmap);
 		break;
 
 	default:
 		uvc_dbg(chain->dev, CONTROL,
 			"Unsupported V4L2 control type %u\n", xmap->v4l2_type);
 		ret = -ENOTTY;
-		goto free_map;
+		break;
 	}
 
-	ret = uvc_ctrl_add_mapping(chain, map);
-
-	kfree(map->menu_info);
 free_map:
 	kfree(map);
 
@@ -1316,7 +1367,7 @@ static long uvc_ioctl_default(struct file *file, void *fh, bool valid_prio,
 	switch (cmd) {
 	/* Dynamic controls. */
 	case UVCIOC_CTRL_MAP:
-		return uvc_ioctl_ctrl_map(chain, arg);
+		return uvc_ioctl_xu_ctrl_map(chain, arg);
 
 	case UVCIOC_CTRL_QUERY:
 		return uvc_xu_ctrl_query(chain, arg);
@@ -1429,7 +1480,7 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
 		ret = uvc_v4l2_get_xu_mapping(&karg.xmap, up);
 		if (ret)
 			return ret;
-		ret = uvc_ioctl_ctrl_map(handle->chain, &karg.xmap);
+		ret = uvc_ioctl_xu_ctrl_map(handle->chain, &karg.xmap);
 		if (ret)
 			return ret;
 		ret = uvc_v4l2_put_xu_mapping(&karg.xmap, up);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 31c33eb0edf5..c5a1c1c9d49e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -114,7 +114,8 @@ struct uvc_control_mapping {
 	enum v4l2_ctrl_type v4l2_type;
 	u32 data_type;
 
-	const struct uvc_menu_info *menu_info;
+	const u32 *menu_mapping;
+	const char (*menu_names)[UVC_MENU_NAME_LEN];
 	unsigned long menu_mask;
 
 	u32 master_id;
diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
index 8288137387c0..d45d0c2ea252 100644
--- a/include/uapi/linux/uvcvideo.h
+++ b/include/uapi/linux/uvcvideo.h
@@ -36,9 +36,11 @@
 	 UVC_CTRL_FLAG_GET_MAX | UVC_CTRL_FLAG_GET_RES | \
 	 UVC_CTRL_FLAG_GET_DEF)
 
+#define UVC_MENU_NAME_LEN 32
+
 struct uvc_menu_info {
 	__u32 value;
-	__u8 name[32];
+	__u8 name[UVC_MENU_NAME_LEN];
 };
 
 struct uvc_xu_control_mapping {

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
