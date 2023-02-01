Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0D67B7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjAYQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjAYQ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:59:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5313FE3AA;
        Wed, 25 Jan 2023 08:59:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m12so2292072edq.5;
        Wed, 25 Jan 2023 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Aq9xOcHfIHjbGoqGBQK/mtHjTWt1jvzmQ70KiubeQ08=;
        b=h1L402zyr75LqZJea+H/1KYNhcjFdMiQR8ixPLd9VMmMnQQYxPoEChTHbQU76B6L7G
         eN/loO62VoMvgH30B1pC0I1H2YMDn2sEnVTRvsvmmodtbKRA4NMZ8QuguADcS7fGW+NP
         WKpPQMIjaSi+hrnFXCyh6WkvdffynpoGACLVwXeU/WD1tieasO9oA3tAN42HG0qcdW8G
         OvcTEcOhEsyrYDtWhQvkwzj0fGXl55+XxGzty5itC8ndG5h8bT/U/QnlUUicrLgYlwi9
         hYsqIKxmsiUcGhocfzw9P6BTUEMY5e2n8cLcxURNEBtWqL4E7mp01+HBliXoqUtNWl4v
         t1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aq9xOcHfIHjbGoqGBQK/mtHjTWt1jvzmQ70KiubeQ08=;
        b=r0XvskdOHdGKTfHF2FlyK+RRbAzOBEpnLUBHoUl8ypiozxidIaBBEj/F5uRr7m88mQ
         06tci8CNKob2kSSjiHZaGJdpJMuSguS9B0GiOLG1Ry1F3cJqxdhCYujFoivYltl2gzBk
         +Ywjg4HwmkszNcR0Eqe69PVivnnQOen+tYbxKbZZbCqiCuHCrhmZiX61OoTVQGBiArOa
         yTIcUubkZzjH6mt8SQ56TPodPCJYLiYuVzKYUcVivMuPgwq1Rcd2I8g1qpKrLuEghaOM
         Pfcu8JE/25G+8Zk9zjTKXrcVcEnCqfSrIocXexTjVUohCeEc97V9qWO1QYIXepHbFv41
         bbaw==
X-Gm-Message-State: AO0yUKXC5sWnkjTu4n/6mKztzh2R3m4VjDZVCKg51MQF5aSI0KQaBmZj
        ghisF+7qq2t+QZLqhdovLuo2HLFqXwM=
X-Google-Smtp-Source: AK7set828rJWOL9F7OxFWyaUdhH3EqcoYYtCIP2A/hedXZr7HejjqH6EPtD8Kfa/MCAJpUQTo9FBbA==
X-Received: by 2002:a05:6402:31e8:b0:49f:20ee:4519 with SMTP id dy8-20020a05640231e800b0049f20ee4519mr8988460edb.13.1674665950310;
        Wed, 25 Jan 2023 08:59:10 -0800 (PST)
Received: from jo-einhundert ([2a02:908:13d6:2180:36e8:f43a:77c6:b1a2])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906845900b008784ecb2dd5sm119547ejy.104.2023.01.25.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:59:09 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:59:08 +0100
From:   =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v5] usb: gadget:  add WebUSB landing page support
Message-ID: <Y9Ff3Np86AUK4b1k@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y86cy1AM4w5ju5A4@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a custom (non-USB IF) extension to the USB standard:

https://wicg.github.io/webusb/

This specification is published under the W3C Community Contributor
Agreement, which in particular allows to implement the specification
without any royalties.

The specification allows USB gadgets to announce an URL to landing
page and describes a Javascript interface for websites to interact
with the USB gadget, if the user allows it. It is currently
supported by Chromium-based browsers, such as Chrome, Edge and
Opera on all major operating systems including Linux.

This patch adds optional support for Linux-based USB gadgets
wishing to expose such a landing page.

During device enumeration, a host recognizes that the announced
USB version is at least 2.01, which means, that there are BOS
descriptors available. The device than announces WebUSB support
using a platform device capability. This includes a vendor code
under which the landing page URL can be retrieved using a
vendor-specific request.

Previously, the BOS descriptors would unconditionally include an
LPM related descriptor, as BOS descriptors were only ever sent
when the device was LPM capable. As this is no longer the case,
this patch puts this descriptor behind a lpm_capable condition.

Usage is modeled after os_desc descriptors:
echo 1 > webusb/use
echo "https://www.kernel.org" > webusb/landingPage

lsusb will report the device with the following lines:
  Platform Device Capability:
    bLength                24
    bDescriptorType        16
    bDevCapabilityType      5
    bReserved               0
    PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665}
      WebUSB:
        bcdVersion    1.00
        bVendorCode      0
        iLandingPage     1 https://www.kernel.org

Signed-off-by: J� �gila Bitsch <jgilab@gmail.com>
---
V4 -> V5: * Addressed the htmldocs warnings reported by Stephen Rothwell
	  * Fixed GUID/UID usage as pointed out by Andy Shevchenko
	  * Changed locking in configfs as pointed out by Andy Shevchenko
V3 -> V4: Addressed comments by Andrzej Pietrasiewicz and Alan Stern
          * Moved WebUSB specific structs and constants to its own header file
          * added structs for all descriptors sent
          * added the magic numbers to the new header file with links to the specification
          * added length validation to landingPage sysfs interface
V2 -> V3: improved commit message to include additional condition in desc_bos as per comment
          by Alan Stern
V1 -> V2: cleaned up coding style, made URL scheme comparison case insensitive, addressed review
          comments by Alan Stern
V0 -> V1: use sysfs_emit instead of sprintf and use lock in webusb_bcdVersion_store, addressed review
          comments by Christophe JAILLET

Checkpatch currently gives a warning if MAINTAINERS should be updated. I didn't because I feel this patch is too small for adding me here.
Nevertheless, if you think I should, let me know.


 Documentation/ABI/testing/configfs-usb-gadget |  13 ++
 drivers/usb/gadget/composite.c                | 102 +++++++++--
 drivers/usb/gadget/configfs.c                 | 168 ++++++++++++++++++
 include/linux/usb/composite.h                 |  11 ++
 include/linux/usb/webusb.h                    |  80 +++++++++
 include/uapi/linux/usb/ch9.h                  |  16 ++
 6 files changed, 380 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/usb/webusb.h

diff --git a/Documentation/ABI/testing/configfs-usb-gadget b/Documentation/ABI/testing/configfs-usb-gadget
index b7943aa7e997..a8bb896def54 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget
+++ b/Documentation/ABI/testing/configfs-usb-gadget
@@ -143,3 +143,16 @@ Description:
 		qw_sign		an identifier to be reported as "OS String"
 				proper
 		=============	===============================================
+
+What:		/config/usb-gadget/gadget/webusb
+Date:		Dec 2022
+KernelVersion:	6.3
+Description:
+		This group contains "WebUSB" extension handling attributes.
+
+		=============	===============================================
+		use		flag turning "WebUSB" support on/off
+		bcdVersion	bcd WebUSB specification version number
+		bVendorCode	one-byte value used for custom per-device
+		landingPage	UTF-8 encoded URL of the device's landing page
+		=============	===============================================
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 403563c06477..fa7dd6cf014d 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -14,9 +14,11 @@
 #include <linux/device.h>
 #include <linux/utsname.h>
 #include <linux/bitfield.h>
+#include <linux/uuid.h>
 
 #include <linux/usb/composite.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/webusb.h>
 #include <asm/unaligned.h>
 
 #include "u_os_desc.h"
@@ -713,14 +715,16 @@ static int bos_desc(struct usb_composite_dev *cdev)
 	 * A SuperSpeed device shall include the USB2.0 extension descriptor
 	 * and shall support LPM when operating in USB2.0 HS mode.
 	 */
-	usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
-	bos->bNumDeviceCaps++;
-	le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
-	usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
-	usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
-	usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
-	usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
-					    USB_BESL_SUPPORT | besl);
+	if (cdev->gadget->lpm_capable) {
+		usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
+		bos->bNumDeviceCaps++;
+		le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
+		usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
+		usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
+		usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
+		usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
+							USB_BESL_SUPPORT | besl);
+	}
 
 	/*
 	 * The Superspeed USB Capability descriptor shall be implemented by all
@@ -821,6 +825,37 @@ static int bos_desc(struct usb_composite_dev *cdev)
 		}
 	}
 
+	/* The WebUSB Platform Capability descriptor */
+	if (cdev->use_webusb) {
+		struct usb_plat_dev_cap_descriptor *webusb_cap;
+		struct usb_webusb_cap_data *webusb_cap_data;
+		guid_t webusb_uuid = WEBUSB_UUID;
+
+		webusb_cap = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
+		webusb_cap_data = (struct usb_webusb_cap_data *) webusb_cap->CapabilityData;
+		bos->bNumDeviceCaps++;
+		le16_add_cpu(&bos->wTotalLength,
+			USB_DT_USB_PLAT_DEV_CAP_SIZE(USB_WEBUSB_CAP_DATA_SIZE));
+
+		webusb_cap->bLength = USB_DT_USB_PLAT_DEV_CAP_SIZE(USB_WEBUSB_CAP_DATA_SIZE);
+		webusb_cap->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
+		webusb_cap->bDevCapabilityType = USB_PLAT_DEV_CAP_TYPE;
+		webusb_cap->bReserved = 0;
+		export_guid(webusb_cap->UUID, &webusb_uuid);
+
+		if (cdev->bcd_webusb_version != 0)
+			webusb_cap_data->bcdVersion = cpu_to_le16(cdev->bcd_webusb_version);
+		else
+			webusb_cap_data->bcdVersion = WEBUSB_VERSION_1_00;
+
+		webusb_cap_data->bVendorCode = cdev->b_webusb_vendor_code;
+
+		if (strnlen(cdev->landing_page, sizeof(cdev->landing_page)) > 0)
+			webusb_cap_data->iLandingPage = WEBUSB_LANDING_PAGE_PRESENT;
+		else
+			webusb_cap_data->iLandingPage = WEBUSB_LANDING_PAGE_NOT_PRESENT;
+	}
+
 	return le16_to_cpu(bos->wTotalLength);
 }
 
@@ -1744,7 +1779,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 					cdev->desc.bcdUSB = cpu_to_le16(0x0210);
 				}
 			} else {
-				if (gadget->lpm_capable)
+				if (gadget->lpm_capable || cdev->use_webusb)
 					cdev->desc.bcdUSB = cpu_to_le16(0x0201);
 				else
 					cdev->desc.bcdUSB = cpu_to_le16(0x0200);
@@ -1779,7 +1814,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			break;
 		case USB_DT_BOS:
 			if (gadget_is_superspeed(gadget) ||
-			    gadget->lpm_capable) {
+			    gadget->lpm_capable || cdev->use_webusb) {
 				value = bos_desc(cdev);
 				value = min(w_length, (u16) value);
 			}
@@ -2013,6 +2048,53 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			goto check_value;
 		}
 
+		/*
+		 * WebUSB URL descriptor handling, following:
+		 * https://wicg.github.io/webusb/#device-requests
+		 */
+		if (cdev->use_webusb &&
+		    ctrl->bRequestType == (USB_DIR_IN | USB_TYPE_VENDOR) &&
+		    w_index == WEBUSB_GET_URL &&
+		    w_value == WEBUSB_LANDING_PAGE_PRESENT &&
+		    ctrl->bRequest == cdev->b_webusb_vendor_code) {
+			unsigned int	landing_page_length;
+			unsigned int	landing_page_offset;
+			struct webusb_url_descriptor *url_descriptor =
+					(struct webusb_url_descriptor *)cdev->req->buf;
+
+			url_descriptor->bDescriptorType = WEBUSB_URL_DESCRIPTOR_TYPE;
+
+			if (strncasecmp(cdev->landing_page, "https://",  8) == 0) {
+				landing_page_offset = 8;
+				url_descriptor->bScheme = WEBUSB_URL_SCHEME_HTTPS;
+			} else if (strncasecmp(cdev->landing_page, "http://", 7) == 0) {
+				landing_page_offset = 7;
+				url_descriptor->bScheme = WEBUSB_URL_SCHEME_HTTP;
+			} else {
+				landing_page_offset = 0;
+				url_descriptor->bScheme = WEBUSB_URL_SCHEME_NONE;
+			}
+
+			landing_page_length = strnlen(cdev->landing_page,
+				sizeof(url_descriptor->URL)
+				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset);
+
+			if (ctrl->wLength < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH
+					    + landing_page_length)
+				landing_page_length = ctrl->wLength
+					- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
+
+			memcpy(url_descriptor->URL,
+				cdev->landing_page + landing_page_offset,
+				landing_page_length - landing_page_offset);
+			url_descriptor->bLength = landing_page_length
+				- landing_page_offset + WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH;
+
+			value = url_descriptor->bLength;
+
+			goto check_value;
+		}
+
 		VDBG(cdev,
 			"non-core control req%02x.%02x v%04x i%04x l%d\n",
 			ctrl->bRequestType, ctrl->bRequest,
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 96121d1c8df4..497539e1bca4 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -7,6 +7,7 @@
 #include <linux/nls.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/gadget_configfs.h>
+#include <linux/usb/webusb.h>
 #include "configfs.h"
 #include "u_f.h"
 #include "u_os_desc.h"
@@ -39,6 +40,7 @@ struct gadget_info {
 	struct config_group configs_group;
 	struct config_group strings_group;
 	struct config_group os_desc_group;
+	struct config_group webusb_group;
 
 	struct mutex lock;
 	struct usb_gadget_strings *gstrings[MAX_USB_STRING_LANGS + 1];
@@ -50,6 +52,11 @@ struct gadget_info {
 	bool use_os_desc;
 	char b_vendor_code;
 	char qw_sign[OS_STRING_QW_SIGN_LEN];
+	bool use_webusb;
+	u16 bcd_webusb_version;
+	u8 b_webusb_vendor_code;
+	char landing_page[WEBUSB_URL_RAW_MAX_LENGTH];
+
 	spinlock_t spinlock;
 	bool unbind;
 };
@@ -780,6 +787,156 @@ static void gadget_strings_attr_release(struct config_item *item)
 USB_CONFIG_STRING_RW_OPS(gadget_strings);
 USB_CONFIG_STRINGS_LANG(gadget_strings, gadget_info);
 
+static inline struct gadget_info *webusb_item_to_gadget_info(
+		struct config_item *item)
+{
+	return container_of(to_config_group(item),
+			struct gadget_info, webusb_group);
+}
+
+static ssize_t webusb_use_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "%d\n",
+			webusb_item_to_gadget_info(item)->use_webusb);
+}
+
+static ssize_t webusb_use_store(struct config_item *item, const char *page,
+				 size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	int ret;
+	bool use;
+
+	ret = kstrtobool(page, &use);
+	if (ret)
+		return ret;
+
+	mutex_lock(&gi->lock);
+	gi->use_webusb = use;
+	mutex_unlock(&gi->lock);
+
+	return len;
+}
+
+static ssize_t webusb_bcdVersion_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "0x%04x\n",
+					webusb_item_to_gadget_info(item)->bcd_webusb_version);
+}
+
+static ssize_t webusb_bcdVersion_store(struct config_item *item,
+		const char *page, size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	u16 bcdVersion;
+	int ret;
+
+	ret = kstrtou16(page, 0, &bcdVersion);
+	if (ret)
+		return ret;
+
+	mutex_lock(&gi->lock);
+
+	ret = is_valid_bcd(bcdVersion);
+	if (ret)
+		goto out;
+
+	gi->bcd_webusb_version = bcdVersion;
+	ret = len;
+
+out:
+	mutex_unlock(&gi->lock);
+
+	return ret;
+}
+
+static ssize_t webusb_bVendorCode_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "0x%02x\n",
+			webusb_item_to_gadget_info(item)->b_webusb_vendor_code);
+}
+
+static ssize_t webusb_bVendorCode_store(struct config_item *item,
+					   const char *page, size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	int ret;
+	u8 b_vendor_code;
+
+	ret = kstrtou8(page, 0, &b_vendor_code);
+	if (ret)
+		return ret;
+
+	mutex_lock(&gi->lock);
+	gi->b_webusb_vendor_code = b_vendor_code;
+	mutex_unlock(&gi->lock);
+
+	return len;
+}
+
+static ssize_t webusb_landingPage_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "%s\n", webusb_item_to_gadget_info(item)->landing_page);
+}
+
+static ssize_t webusb_landingPage_store(struct config_item *item, const char *page,
+				     size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	unsigned int bytes_to_strip = 0;
+	int l = len;
+
+	if (page[l - 1] == '\n') {
+		--l;
+		++bytes_to_strip;
+	}
+
+	if (l > sizeof(gi->landing_page)) {
+		pr_err("webusb: landingPage URL too long\n");
+		return -EINVAL;
+	}
+
+	// validation
+	if (strncasecmp(page, "https://",  8) == 0)
+		bytes_to_strip = 8;
+	else if (strncasecmp(page, "http://", 7) == 0)
+		bytes_to_strip = 7;
+	else
+		bytes_to_strip = 0;
+
+	if (l > U8_MAX - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + bytes_to_strip) {
+		pr_err("webusb: landingPage URL %d bytes too long for given URL scheme\n",
+			l - U8_MAX + WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH - bytes_to_strip);
+		return -EINVAL;
+	}
+
+	mutex_lock(&gi->lock);
+	// ensure 0 bytes are set, in case the new landing page is shorter then the old one.
+	memset(gi->landing_page, 0, sizeof(gi->landing_page));
+	memcpy(gi->landing_page, page, l);
+	mutex_unlock(&gi->lock);
+
+	return len;
+}
+
+CONFIGFS_ATTR(webusb_, use);
+CONFIGFS_ATTR(webusb_, bVendorCode);
+CONFIGFS_ATTR(webusb_, bcdVersion);
+CONFIGFS_ATTR(webusb_, landingPage);
+
+static struct configfs_attribute *webusb_attrs[] = {
+	&webusb_attr_use,
+	&webusb_attr_bcdVersion,
+	&webusb_attr_bVendorCode,
+	&webusb_attr_landingPage,
+	NULL,
+};
+
+static struct config_item_type webusb_type = {
+	.ct_attrs	= webusb_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
 static inline struct gadget_info *os_desc_item_to_gadget_info(
 		struct config_item *item)
 {
@@ -1341,6 +1498,13 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		gi->cdev.desc.iSerialNumber = s[USB_GADGET_SERIAL_IDX].id;
 	}
 
+	if (gi->use_webusb) {
+		cdev->use_webusb = true;
+		cdev->bcd_webusb_version = gi->bcd_webusb_version;
+		cdev->b_webusb_vendor_code = gi->b_webusb_vendor_code;
+		memcpy(cdev->landing_page, gi->landing_page, WEBUSB_URL_RAW_MAX_LENGTH);
+	}
+
 	if (gi->use_os_desc) {
 		cdev->use_os_string = true;
 		cdev->b_vendor_code = gi->b_vendor_code;
@@ -1605,6 +1769,10 @@ static struct config_group *gadgets_make(
 			&os_desc_type);
 	configfs_add_default_group(&gi->os_desc_group, &gi->group);
 
+	config_group_init_type_name(&gi->webusb_group, "webusb",
+			&webusb_type);
+	configfs_add_default_group(&gi->webusb_group, &gi->group);
+
 	gi->composite.bind = configfs_do_nothing;
 	gi->composite.unbind = configfs_do_nothing;
 	gi->composite.suspend = NULL;
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 43ac3fa760db..7ef8cea67f50 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -25,6 +25,7 @@
 #include <linux/version.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/webusb.h>
 #include <linux/log2.h>
 #include <linux/configfs.h>
 
@@ -431,6 +432,10 @@ static inline struct usb_composite_driver *to_cdriver(
  * @qw_sign: qwSignature part of the OS string
  * @b_vendor_code: bMS_VendorCode part of the OS string
  * @use_os_string: false by default, interested gadgets set it
+ * @bcd_webusb_version: 0x0100 by default, WebUSB specification version
+ * @b_webusb_vendor_code: 0x0 by default, vendor code for WebUSB
+ * @landing_page: empty by default, landing page to announce in WebUSB
+ * @use_webusb:: false by default, interested gadgets set it
  * @os_desc_config: the configuration to be used with OS descriptors
  * @setup_pending: true when setup request is queued but not completed
  * @os_desc_pending: true when os_desc request is queued but not completed
@@ -474,6 +479,12 @@ struct usb_composite_dev {
 	struct usb_configuration	*os_desc_config;
 	unsigned int			use_os_string:1;
 
+	/* WebUSB */
+	u16				bcd_webusb_version;
+	u8				b_webusb_vendor_code;
+	char				landing_page[WEBUSB_URL_RAW_MAX_LENGTH];
+	unsigned int			use_webusb:1;
+
 	/* private: */
 	/* internals */
 	unsigned int			suspended:1;
diff --git a/include/linux/usb/webusb.h b/include/linux/usb/webusb.h
new file mode 100644
index 000000000000..fe43020b4a48
--- /dev/null
+++ b/include/linux/usb/webusb.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * WebUSB descriptors and constants
+ *
+ * Copyright (C) 2023 J� �gila Bitsch <jgilab@gmail.com>
+ */
+
+#ifndef	__LINUX_USB_WEBUSB_H
+#define	__LINUX_USB_WEBUSB_H
+
+#include "uapi/linux/usb/ch9.h"
+
+/*
+ * Little Endian PlatformCapablityUUID for WebUSB
+ * 3408b638-09a9-47a0-8bfd-a0768815b665
+ * to identify Platform Device Capability descriptors as referring to WebUSB.
+ */
+#define WEBUSB_UUID \
+	GUID_INIT(0x3408b638, 0x09a9, 0x47a0, 0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0x65)
+
+/*
+ * WebUSB Platform Capability data
+ *
+ * A device announces support for the
+ * WebUSB command set by including the following Platform Descriptor Data in its
+ * Binary Object Store associated with the WebUSB_UUID above.
+ * See: https://wicg.github.io/webusb/#webusb-platform-capability-descriptor
+ */
+struct usb_webusb_cap_data {
+	__le16 bcdVersion;
+#define WEBUSB_VERSION_1_00	cpu_to_le16(0x0100) /* currently only version 1.00 is defined */
+	u8  bVendorCode;
+	u8  iLandingPage;
+#define WEBUSB_LANDING_PAGE_NOT_PRESENT	0
+#define WEBUSB_LANDING_PAGE_PRESENT	1 /* we chose the fixed index 1 for the URL descriptor */
+} __packed;
+
+#define USB_WEBUSB_CAP_DATA_SIZE	4
+
+/*
+ * Get URL Request
+ *
+ * The request to fetch an URL is defined in https://wicg.github.io/webusb/#get-url as:
+ * bmRequestType: (USB_DIR_IN | USB_TYPE_VENDOR) = 11000000B
+ * bRequest: bVendorCode
+ * wValue: iLandingPage
+ * wIndex: GET_URL = 2
+ * wLength: Descriptor Length (typically U8_MAX = 255)
+ * Data: URL Descriptor
+ */
+#define WEBUSB_GET_URL 2
+
+/*
+ * This descriptor contains a single URL and is returned by the Get URL request.
+ *
+ * See: https://wicg.github.io/webusb/#url-descriptor
+ */
+struct webusb_url_descriptor {
+	u8  bLength;
+#define WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH	3
+	u8  bDescriptorType;
+#define WEBUSB_URL_DESCRIPTOR_TYPE		3
+	u8  bScheme;
+#define WEBUSB_URL_SCHEME_HTTP			0
+#define WEBUSB_URL_SCHEME_HTTPS			1
+#define WEBUSB_URL_SCHEME_NONE			255
+	u8  URL[U8_MAX - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH];
+} __packed;
+
+/*
+ * Buffer size to hold the longest URL that can be in an URL descriptor
+ *
+ * The descriptor can be U8_MAX  bytes long.
+ * WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH bytes are used for a header.
+ * Since the longest prefix that might be stripped is "https://", we may accommodate an additional
+ * 8 bytes.
+ */
+#define WEBUSB_URL_RAW_MAX_LENGTH (U8_MAX - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + 8)
+
+#endif /* __LINUX_USB_USBNET_H */
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 31fcfa084e63..b17e3a21b15f 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -947,6 +947,22 @@ struct usb_ss_container_id_descriptor {
 
 #define USB_DT_USB_SS_CONTN_ID_SIZE	20
 
+/*
+ * Platform Device Capability descriptor: Defines platform specific device
+ * capabilities
+ */
+#define	USB_PLAT_DEV_CAP_TYPE	5
+struct usb_plat_dev_cap_descriptor {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDevCapabilityType;
+	__u8  bReserved;
+	__u8  UUID[16];
+	__u8  CapabilityData[];
+} __attribute__((packed));
+
+#define USB_DT_USB_PLAT_DEV_CAP_SIZE(capability_data_size)	(20 + capability_data_size)
+
 /*
  * SuperSpeed Plus USB Capability descriptor: Defines the set of
  * SuperSpeed Plus USB specific device level capabilities
-- 
2.37.2

