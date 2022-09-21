Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1752D5BFA59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiIUJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiIUJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502328E0F4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sb3so12099879ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=IPOvEFbsB3f+Xwz9TxbpevOhlT2MGP0OcSyaH0auNNw=;
        b=Tj200QQJw9+NtFY0Ev0n6R0/HlzFwYxa8T0LVPganI/F4XjAqLOVwq6wihuKBbB4ng
         sn5nxFv6BpgRP4TavkMZTQ8HBoYQ8XSkTnxYF4BQh6eh3L+XFkqgFpbx4ocscPNS5/hO
         s5gJyeZocz+9kDlzrCsy6TMENdhZ1mzli/dBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IPOvEFbsB3f+Xwz9TxbpevOhlT2MGP0OcSyaH0auNNw=;
        b=F6s1spAqFMznpuJlm2Tq7sYpYdATYej+hsEe9HF1jGnAMlApmBFxHw8IX4DWam1YKn
         ckWWbRQGkkJGMeQuZistPgBC3IzglHW8j6dtgq2uzM5C6xVYGncMaDyFQemq7FQDjXBm
         CvjDv/O/TUWr58CNMYyltctCFQzaNt/20yr/8u7ELWshcWeLlPBBZF1raNw2pRPAVV5J
         sJjuTKcMOoFV7Mz1LytsZ4p/p4XtrYQItzYjh4II38/LJhPCJzCWxHV9ayfb438hQgjo
         HRNR4HJRF8f05osnuZcKiuCgrG9V7fPAxlWgPXFH7jWrFXDh6BwmJNjfa/0evlHhCHKA
         t8Dw==
X-Gm-Message-State: ACrzQf2fgPExVk6jK45PzI3uYA1H+r0SdoE7VzF5kt/tCjV5vO05vxiL
        CvPrCtsGyq7+Occ0+/I5UhBvQPIKl9o7vnLq
X-Google-Smtp-Source: AMsMyM4ecOHpR34kdUcnOeywfC/HPo1+hgxqPlHtytpalNmPFiKPof6Pex+OKub0LsgW/CnrjTiUAQ==
X-Received: by 2002:a17:907:9803:b0:782:2d55:f98b with SMTP id ji3-20020a170907980300b007822d55f98bmr193753ejc.338.1663751558634;
        Wed, 21 Sep 2022 02:12:38 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:160b:cee7:2e8b:f72c])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b00771cb506149sm1031913ejw.59.2022.09.21.02.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:12:38 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:12:16 +0200
Subject: [PATCH v2 7/7] media: uvcvideo: Use standard names for menus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v2-7-7c0942040004@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12523; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=GW6t7Dmti9DcWTCthX+5ZUlKrr4OzM2PZwBAycFJFmo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKtV+sIe0xcdE1X8D36H6gQ/ml3TkZInpODZhzCSy
 S0ChjSKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYyrVfgAKCRDRN9E+zzrEiCTpEA
 CYO9HPOgxMHW09z2qfIwn3ZzeFqN1qPcqRYeFxYhpU+r82dTLZfjIVyWIm5wRHdYQeDi4QCAWnHRlt
 /vl41Pkwj1QER9LXpg75PKV6kSlPAodzKomdMu9HtdyAaczBUX+pg5y7QMEIpIJ6hg4DWmHMK0lYGd
 Pz8kFJ9hYSU+8lwpkRwIjVPjlXWqRJ+xBXm4x+LCvPunYoYrNVl9H1boVPERUD0ZS/rwlBNtj00hgb
 Jhsjs5u5kTMkAyCAa8AzlUBWAVteOsnQNM7sscfxnY0WBeru9JbuPy+ZmlSKHx0O+dyfwEQ2M4Ltqa
 630tvHjtQfVE1wFZwZDPlgJOHFotdvibbrJ4eXVXto1oOgxifj1cdE5nDkDZLekYEisg/wg3lPm+e7
 Ig/hOJQegRfRMXMKjDZ5OqCH+Hq9uWBwBhWhbTpzrQt8ALODwDvfyFXAhBpNe4AvaS5kmfEi3t5TWA
 h5K/VoSU/JaTiSHSuToDbkJNWvQFNvZaNZqRgeheZ2CmXgDT2wjAfbneLCdNdlvNbG3YDJ7Ijs/SYS
 7CiX7Rh1gDJ7qRFCU5j4NOIjC2KimIV7OPw3SWN6H8VMxrxoTLT175MpXa7m1OR22z64Okn63I3ATW
 ltc79N/Lo/lnxHeenumJnzgO4/mUUibJZTiOiFNjLvi9whO5lU7CTdE8YrYw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index df273b829961..5c28d8aace37 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -363,19 +363,31 @@ static const u32 uvc_control_classes[] = {
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
@@ -524,8 +536,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
-		.menu_info	= exposure_auto_controls,
-		.menu_mask	= BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
+		.menu_mapping	= exposure_auto_mapping,
+		.menu_mask	= GENMASK(ARRAY_SIZE(exposure_auto_mapping) - 1, 0),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -730,8 +742,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
-		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
+		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0),
 	},
 };
 
@@ -744,8 +755,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
-		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
+		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO, 0),
 	},
 };
 
@@ -972,13 +982,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
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
@@ -1174,7 +1188,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 {
 	struct uvc_control_mapping *master_map = NULL;
 	struct uvc_control *master_ctrl = NULL;
-	const struct uvc_menu_info *menu;
 	unsigned int i;
 
 	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
@@ -1219,11 +1232,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
@@ -1322,11 +1339,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
@@ -1348,22 +1365,28 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	menu_info = &mapping->menu_info[query_menu->index];
-
 	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
+		u32 menu_value;
+
 		if (!ctrl->cached) {
 			ret = uvc_ctrl_populate_cache(chain, ctrl);
 			if (ret < 0)
 				goto done;
 		}
 
-		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_info->value)) {
+		menu_value = uvc_mapping_get_menu_value(mapping,
+							query_menu->index);
+		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_value)) {
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
@@ -1865,7 +1888,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		if (!test_bit(xctrl->value, &mapping->menu_mask))
 			return -EINVAL;
 
-		value = mapping->menu_info[xctrl->value].value;
+		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
 
 		/*
 		 * Valid menu indices are reported by the GET_RES request for
@@ -2311,12 +2334,28 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
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
@@ -2661,7 +2700,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
 
 	list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
 		list_del(&mapping->list);
-		kfree(mapping->menu_info);
+		kfree(mapping->menu_names);
+		kfree(mapping->menu_mapping);
 		kfree(mapping->name);
 		kfree(mapping);
 	}
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index abdb9ca7eed6..97c267e75fa4 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2661,11 +2661,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
-static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
-	{ 1, "50 Hz" },
-	{ 2, "60 Hz" },
-};
-
 static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
 	.entity		= UVC_GUID_UVC_PROCESSING,
@@ -2674,8 +2669,8 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.offset		= 0,
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls_limited,
-	.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
 };
 
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index e6792fd46bf5..89581c1559df 100644
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
index 7e2339fc256e..8ebd7ee2934d 100644
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
