Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF32E5BE85F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiITOPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiITONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38E5A2FF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:12:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a26so6513558ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=rTTcURimEO479Zq8BtFI/b3k8L+1FN9m2Ti+ZDmw5qk=;
        b=dJaq632I3TZnnIQNeqoySDg324gx7OH6VSklj15A83DacZvUrORBF4ttOIfOF/UOMR
         fg4qYhtSFVg0bzP0XEXipU+oF62MPMqDRLdk5Uld4ZXU8EmUgA6eY4RQMzJ2hM0NON78
         4QkUl7EmoaMnBGFGJuQWGgsHalQlYYQEfsDUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rTTcURimEO479Zq8BtFI/b3k8L+1FN9m2Ti+ZDmw5qk=;
        b=iwc880aOpUKqR9skmI1o0iGmvnzX8DVFwBPeJEy7UdRHnZXfOGr8WkNVf95DH4i2tL
         WU6CG9VJfQ9hhYWpMAojGzlYsRDNREfnPJwqwZcFt+I+fMjqRhaAlesZdfJcv/N0uUNE
         OXl6TClr8hIjtkF+gcPXlbR1DuIfLUbZRt01YHfpHo6AwCHOSwmP7VS0pNNxY+nPofvA
         Aup7P+QlmJswDVDUUXDUYh04kBYXPbnpHP/cx7slFJ97zQ4MH8Nxpa5AYTMxtAomjEUL
         lmxqAXtTrnatPZgoYEt+3+XeG27BCYSiP71R7G8/go5N6B5PDb21RTOI95ItpgPRGOKh
         5hGw==
X-Gm-Message-State: ACrzQf1ygvs5z8wHhMaPEsoxqo1U0ZI/8kAe3ZCPakn9bY7JYK5o9nB7
        z056hicNdmpvuOKenIDhKeYgjg==
X-Google-Smtp-Source: AMsMyM71I2ber6MhK+rH/GJdoEzIKcdVi+xM8st0yfSDGwCxfu07olzxW4AaOmVW+kRYaru9zErBHA==
X-Received: by 2002:a17:907:8689:b0:781:c8e8:eba9 with SMTP id qa9-20020a170907868900b00781c8e8eba9mr2372599ejc.667.1663683124108;
        Tue, 20 Sep 2022 07:12:04 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id v13-20020a50c40d000000b0044e8ecb9d25sm86535edf.52.2022.09.20.07.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:12:03 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:55 +0200
Subject: [PATCH v1 2/2] media: uvcvideo: Use standard names for menus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-standard-menues-v1-2-839799192e9d@chromium.org>
References: <20220920-standard-menues-v1-0-839799192e9d@chromium.org>
In-Reply-To: <20220920-standard-menues-v1-0-839799192e9d@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12219; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=QPr+SBOjnmqJPutEdyWA/a41YpdGMFnzDpe2kC4JK4E=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcowdqJHKPIm72rXVWDPJxI5EWhjpwJx/4Ih9MVK
 fj7+oH6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynKMAAKCRDRN9E+zzrEiAIaEA
 CWzzQ3qqv/kxWMc0FAZ0rztInaHDgnrHBE100leM/9ZYx4AXy3GA9onkLn+gUo9cnTF6KyGnTtA9aw
 lu7FMozIBPYyIyjiG3MVnHThLZhr6mUrTIACh09IYUDGYUbhQQI1X7wTqMJUKv66VxXCaIWYrKSorL
 wLPtL1L+yo2APqll2Sf2FyG+kOdlrkxHb1iBSQqcKPkkJScBldJwNSGeNzCWUZPnm+FERCtDsnkFq2
 lSpQPEoMaAPKVlbLkYxBKZRfULJl5RkECYtsHIB6ghVbkNv9w3MrUnlCaf3SyZSBlCJdjtBNdgi9Wk
 TZYmEzbBU/4eIW+sS9eX1zvv58cAo3Xj6eMbRAbV5LuVXugpWfCWMVSspcCPoh/YOoIT66F06MYjuj
 R1GKtfOd2x5ExqfB1PdNSNyBuyRkMEVec0rL6g2ecfmF/P7pDwal/aw9nMUFVwt1VirK/BU8HCmCu+
 h4KYSW76aShmfBh0NGWDvh6iEzrblH8pMx/BXtydHMVxC7ZKwxg9IphXEuGPwhcf3hAk3l1w2mdyAq
 7tiU1LGjko+RnoEHu0NrjoyFtYZ9J2yitfhIE227ea5xlqepYNBqpC27Q03R/sjFsxl/OOU15QyrfD
 Me+99IpLxZFZ+U5E+VbfZQfuEjfOlvdxKg4yMAsgs/ZxIBVU4GYnsXAJMTUg==
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

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 13bc57e2a08d..3bb1c97c7e11 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -362,19 +362,31 @@ static const u32 uvc_control_classes[] = {
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
+static u32 uvc_mapping_get_menu_value(struct uvc_control_mapping *mapping,
+				      u32 idx)
+{
+	if (!test_bit(idx, &mapping->menu_mask))
+		return 0;
+
+	if (mapping->menu_mapping)
+		return mapping->menu_mapping[idx];
+
+	return idx;
+}
+
+static const char
+*uvc_mapping_get_menu_name(struct uvc_control_mapping *mapping, u32 idx)
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
@@ -523,9 +535,9 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
-		.menu_info	= exposure_auto_controls,
+		.menu_mapping	= exposure_auto_mapping,
 		.menu_mask	=
-			BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
+			GENMASK(ARRAY_SIZE(exposure_auto_mapping) - 1, 0),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -730,9 +742,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
 		.menu_mask	=
-			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
+			GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0),
 	},
 };
 
@@ -745,9 +756,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
 		.menu_mask	=
-			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
+			GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO, 0),
 	},
 };
 
@@ -974,13 +984,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 	s32 value = mapping->get(mapping, UVC_GET_CUR, data);
 
 	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
-		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
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
@@ -1112,7 +1126,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 {
 	struct uvc_control_mapping *master_map = NULL;
 	struct uvc_control *master_ctrl = NULL;
-	const struct uvc_menu_info *menu;
 	unsigned int i;
 
 	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
@@ -1157,11 +1170,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
 		v4l2_ctrl->step = 1;
 
-		menu = mapping->menu_info;
-		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
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
@@ -1254,11 +1271,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
@@ -1280,11 +1297,10 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	menu_info = &mapping->menu_info[query_menu->index];
-
 	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
 	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
 		s32 bitmap;
+		u32 menu_value;
 
 		if (!ctrl->cached) {
 			ret = uvc_ctrl_populate_cache(chain, ctrl);
@@ -1292,15 +1308,22 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 				goto done;
 		}
 
+		menu_value = uvc_mapping_get_menu_value(mapping,
+							query_menu->index);
+
 		bitmap = mapping->get(mapping, UVC_GET_RES,
 				      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-		if (!(bitmap & menu_info->value)) {
+		if (!(bitmap & menu_value)) {
 			ret = -EINVAL;
 			goto done;
 		}
 	}
 
-	strscpy(query_menu->name, menu_info->name, sizeof(query_menu->name));
+	name = uvc_mapping_get_menu_name(mapping, query_menu->index);
+	if (name)
+		strscpy(query_menu->name, name, sizeof(query_menu->name));
+	else
+		ret = -EINVAL;
 
 done:
 	mutex_unlock(&chain->ctrl_mutex);
@@ -1790,7 +1813,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		if (!test_bit(xctrl->value, &mapping->menu_mask))
 			return -EINVAL;
 
-		value = mapping->menu_info[xctrl->value].value;
+		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
 
 		/*
 		 * Valid menu indices are reported by the GET_RES request for
@@ -2239,12 +2262,28 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
-	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
-	if (map->menu_info == NULL) {
-		kfree(map->name);
-		kfree(map);
-		return -ENOMEM;
+	if (mapping->menu_mapping && mapping->menu_mask) {
+		size = sizeof(mapping->menu_mapping[0]) *
+			      fls(mapping->menu_mask);
+		map->menu_mapping = kmemdup(mapping->menu_mapping, size,
+					    GFP_KERNEL);
+		if (!map->menu_mapping) {
+			kfree(map->name);
+			kfree(map);
+			return -ENOMEM;
+		}
+	}
+	if (mapping->menu_names && mapping->menu_mask) {
+		size = sizeof(mapping->menu_names[0]) *
+			      fls(mapping->menu_mask);
+		map->menu_names = kmemdup(mapping->menu_names, size,
+					  GFP_KERNEL);
+		if (!map->menu_names) {
+			kfree(map->menu_mapping);
+			kfree(map->name);
+			kfree(map);
+			return -ENOMEM;
+		}
 	}
 
 	if (map->get == NULL)
@@ -2589,7 +2628,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
 
 	list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
 		list_del(&mapping->list);
-		kfree(mapping->menu_info);
+		kfree(mapping->menu_names);
+		kfree(mapping->menu_mapping);
 		kfree(mapping->name);
 		kfree(mapping);
 	}
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 09cc459c1253..bd99c9163379 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2674,9 +2674,7 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.offset		= 0,
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls_limited,
-	.menu_mask	=
-		BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 1),
 };
 
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 07c7acce8025..75be164baf4d 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -25,6 +25,64 @@
 
 #include "uvcvideo.h"
 
+static int uvc_control_xu_2_mapping(struct uvc_control_mapping *map,
+				    struct uvc_xu_control_mapping *xmap)
+{
+	char (*names)[UVC_MENU_NAME_LEN];
+	unsigned int i;
+	u32 *mapping;
+	size_t size;
+
+	/* Prevent excessive memory consumption, as well as integer
+	 * overflows.
+	 */
+	if (xmap->menu_count == 0 ||
+	    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES)
+		return -EINVAL;
+
+	map->menu_mask = BIT_MASK(xmap->menu_count);
+
+	size = xmap->menu_count * sizeof(*map->menu_mapping);
+	mapping = kzalloc(size, GFP_KERNEL);
+	if (!mapping)
+		return -ENOMEM;
+
+	for (i = 0; i < xmap->menu_count ; i++)
+		if (copy_from_user(&mapping[i], &xmap->menu_info[i].value,
+				   sizeof(mapping[i]))) {
+			kfree(mapping);
+			return -ENOMEM;
+		}
+
+	map->menu_mapping = mapping;
+
+	/*
+	 * Always use the standard naming if available.
+	 */
+	if (v4l2_ctrl_get_menu(map->id))
+		return 0;
+
+	size = xmap->menu_count * sizeof(map->menu_names[0]);
+	names = kzalloc(size, GFP_KERNEL);
+	if (!names) {
+		kfree(mapping);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < xmap->menu_count ; i++) {
+		/* sizeof(names[i]) - 1: to take care of \0 */
+		if (copy_from_user(&names[i], &xmap->menu_info[i].name,
+				   sizeof(names[i]) - 1)) {
+			kfree(names);
+			kfree(mapping);
+			return -ENOMEM;
+		}
+	}
+	map->menu_names = names;
+
+	return 0;
+}
+
 /* ------------------------------------------------------------------------
  * UVC ioctls
  */
@@ -32,7 +90,6 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 	struct uvc_xu_control_mapping *xmap)
 {
 	struct uvc_control_mapping *map;
-	unsigned int size;
 	int ret;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
@@ -63,24 +120,9 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
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
+		ret = uvc_control_xu_2_mapping(map, xmap);
+		if (ret)
 			goto free_map;
-		}
-
-		map->menu_mask = BIT_MASK(xmap->menu_count);
 		break;
 
 	default:
@@ -92,7 +134,8 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 
 	ret = uvc_ctrl_add_mapping(chain, map);
 
-	kfree(map->menu_info);
+	kfree(map->menu_names);
+	kfree(map->menu_mapping);
 free_map:
 	kfree(map);
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index fde4e975334f..2bb0a5951915 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -254,7 +254,8 @@ struct uvc_control_mapping {
 	enum v4l2_ctrl_type v4l2_type;
 	u32 data_type;
 
-	const struct uvc_menu_info *menu_info;
+	const u32 *menu_mapping;
+	const char (*menu_names)[UVC_MENU_NAME_LEN];
 	unsigned long menu_mask;
 
 	u32 master_id;
diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
index 8288137387c0..1b64b6aa40b5 100644
--- a/include/uapi/linux/uvcvideo.h
+++ b/include/uapi/linux/uvcvideo.h
@@ -36,9 +36,10 @@
 	 UVC_CTRL_FLAG_GET_MAX | UVC_CTRL_FLAG_GET_RES | \
 	 UVC_CTRL_FLAG_GET_DEF)
 
+#define UVC_MENU_NAME_LEN 32
 struct uvc_menu_info {
 	__u32 value;
-	__u8 name[32];
+	__u8 name[UVC_MENU_NAME_LEN];
 };
 
 struct uvc_xu_control_mapping {

-- 
b4 0.11.0-dev-d93f8
