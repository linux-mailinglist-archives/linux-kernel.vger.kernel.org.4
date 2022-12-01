Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C663F9B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiLAVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLAVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:16:57 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D30BF66E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:16:55 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id q5-20020a056808200500b0035b8bbaaf0fso1699897oiw.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bTv4pIu1o/U5qv7q4lPDH5ecV+VUxMSseKXe02bQeA=;
        b=VrBm9s3XfURMKtkBe2XlFJORnPY8ZEzwRJ7OLG8f+1uYJg9TXZPlwokvF0B6pHAqJM
         2yMNpNNXBm1kdQyjvK0tXCz7EjRGi7shAsknX27CPRRqr30zqWlfeWLtvg7RzC+bJ/sg
         JwWjBXpwhPk3q4JJjhEKuW8XWJ5PFpi3ArxCW7U6Fxd/UEJhs00iA7G4qMwbBUNjcPcp
         1KngLBwk7O2eQSlmomTWB8QBe3/68vG7MAlVyq9KU2/QX/SI1gC6RiBjoKSpspinC4Gf
         v/QLe+x38+xsvPeppMiTVceK3CgacZRE9Y1Z2nntPxEqb6VQNPbRIw1oFsJYGGV44E05
         +kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bTv4pIu1o/U5qv7q4lPDH5ecV+VUxMSseKXe02bQeA=;
        b=CuFb31l89BMGcI7hbHkrpVDj7un4u/RG/Ro8js7jgy4PEp2cDYb+SqTlgvg6CmQgU4
         xmGCUjNOPEZCJHaiAyulv7YSTQkFEot3tHW3298gHs3e5xGHdRMoSnsTmNWSHNApcFzm
         aZzXLBMwa6TgnFVjLHh3RhDsUqIiPwypHjvjomY/jlomMelzUBnM88SBvcaV98/voejC
         7LFstLztywczPhNMp4qmpk6J8QYaxsT0roh8PI/w9PeeoZdBmgcNx3IvBVBFfwU48SGq
         DA6HvWEUgx1hiPIJ+g/4SYcGtw/wBTUOg6pU6kG4TI2AxR6BaXskjbyeJTjJ/+nlAzBR
         ghog==
X-Gm-Message-State: ANoB5pnBbd8M6JFzbcRLJ0lvIvADhXUnZBkZ+FRrtCLeuW1JS3jsyFTL
        jjwxIM/8ClasMUXjqsPQgL+vvIm1HPP1Ckk=
X-Google-Smtp-Source: AA0mqf7IOtr06oyj2UGLu0akIO7Etk8degpLHHsNFJOnAu5OlcgEC3HTvuv8BZHC0eUATqNWasXO+Kt2j0WtIfU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:aca:1b02:0:b0:359:c377:6f7 with SMTP id
 b2-20020aca1b02000000b00359c37706f7mr23143806oib.271.1669929414961; Thu, 01
 Dec 2022 13:16:54 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:16:30 -0600
In-Reply-To: <CAJzde07w6U83U_63eaF0-6zaq0cOkaymuLb3CBZ++JQi+Y9JdA@mail.gmail.com>
Mime-Version: 1.0
References: <CAJzde07w6U83U_63eaF0-6zaq0cOkaymuLb3CBZ++JQi+Y9JdA@mail.gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201211630.101541-2-allenwebb@google.com>
Subject: [PATCH v5 1/1] modules: add modalias file to sysfs for modules.
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB devices support the authorized attribute which can be used by
user-space to implement trust-based systems for enabling USB devices. It
would be helpful when building these systems to be able to know in
advance which kernel drivers (or modules) are reachable from a
particular USB device.

This information is readily available for external modules in
modules.alias. However, builtin kernel modules are not covered. This
patch adds a sys-fs attribute to both builtin and loaded modules
exposing the matching rules in the modalias format for integration
with tools like USBGuard.

Note that as written CONFIG_MODULES must be enabled.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/base/Makefile          |   2 +-
 drivers/base/base.h            |   8 +
 drivers/base/bus.c             |  42 ++++++
 drivers/base/mod_devicetable.c | 257 +++++++++++++++++++++++++++++++++
 drivers/usb/core/driver.c      |   2 +
 include/linux/device/bus.h     |   8 +
 include/linux/module.h         |   1 +
 kernel/module/internal.h       |   2 +
 kernel/module/sysfs.c          |  88 +++++++++++
 kernel/params.c                |   7 +
 10 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/mod_devicetable.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 83217d243c25b..924d46ae987f4 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -15,7 +15,7 @@ obj-y				+= firmware_loader/
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 ifeq ($(CONFIG_SYSFS),y)
-obj-$(CONFIG_MODULES)	+= module.o
+obj-$(CONFIG_MODULES)	+= mod_devicetable.o module.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
diff --git a/drivers/base/base.h b/drivers/base/base.h
index b902d1ecc247f..fec56271104fa 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -173,6 +173,14 @@ static inline void module_add_driver(struct module *mod,
 static inline void module_remove_driver(struct device_driver *drv) { }
 #endif
 
+#if defined(CONFIG_SYSFS) && defined(CONFIG_MODULES)
+ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+			    size_t count);
+#else
+static inline ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+					  size_t count) { return -EINVAL; }
+#endif
+
 #ifdef CONFIG_DEVTMPFS
 extern int devtmpfs_init(void);
 #else
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 7ca47e5b3c1f4..4e0c5925545e5 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -178,6 +178,48 @@ static const struct kset_uevent_ops bus_uevent_ops = {
 
 static struct kset *bus_kset;
 
+/**
+ * bus_for_each - bus iterator.
+ * @start: bus to start iterating from.
+ * @data: data for the callback.
+ * @fn: function to be called for each device.
+ *
+ * Iterate over list of buses, and call @fn for each,
+ * passing it @data. If @start is not NULL, we use that bus to
+ * begin iterating from.
+ *
+ * We check the return of @fn each time. If it returns anything
+ * other than 0, we break out and return that value.
+ *
+ * NOTE: The bus that returns a non-zero value is not retained
+ * in any way, nor is its refcount incremented. If the caller needs
+ * to retain this data, it should do so, and increment the reference
+ * count in the supplied callback.
+ */
+int bus_for_each(void *data, int (*fn)(struct bus_type *, void *))
+{
+	int error = 0;
+	struct bus_type *bus;
+	struct subsys_private *bus_prv;
+	struct kset *subsys;
+	struct kobject *k;
+
+	spin_lock(&bus_kset->list_lock);
+
+	list_for_each_entry(k, &bus_kset->list, entry) {
+		subsys = container_of(k, struct kset, kobj);
+		bus_prv = container_of(subsys, struct subsys_private, subsys);
+		bus = bus_prv->bus;
+		error = fn(bus, data);
+		if (error)
+			break;
+	}
+
+	spin_unlock(&bus_kset->list_lock);
+	return error;
+}
+EXPORT_SYMBOL_GPL(bus_for_each);
+
 /* Manually detach a device from its associated driver. */
 static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 			    size_t count)
diff --git a/drivers/base/mod_devicetable.c b/drivers/base/mod_devicetable.c
new file mode 100644
index 0000000000000..d7f198aad430f
--- /dev/null
+++ b/drivers/base/mod_devicetable.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mod_devicetable.c - helpers for displaying modaliases through sysfs.
+ *
+ * This borrows a lot from file2alias.c
+ */
+
+#include <linux/device/bus.h>
+#include <linux/device.h>
+#include <linux/usb.h>
+
+#include "base.h"
+#include "../usb/core/usb.h"
+
+/* Helper macro to add a modalias field to the string buffer associated with
+ * a match id.
+ *
+ * Note that:
+ *   + len should be a ssize_t and is modified in the macro
+ *   + sep should be a string literal and is concatenated as part of a format
+ *     string
+ *   + field is the struct field of the match id
+ */
+#define ADD(buf, count, len, sep, cond, field)				\
+do {				                                        \
+	char *buf_ = buf;						\
+	size_t count_ = count;                                          \
+	if (cond)							\
+		(len) += scnprintf(&buf_[len],				\
+			count_ - (len),					\
+			sizeof(field) == 1 ? (sep "%02X") :		\
+			sizeof(field) == 2 ? (sep "%04X") :		\
+			sizeof(field) == 4 ? (sep "%08X") : "",		\
+			(field));					\
+	else								\
+		(len) += scnprintf(&buf_[len], count_ - (len), (sep "*")); \
+} while (0)
+
+#ifdef CONFIG_USB
+/* USB related modaliases can be split because of device number matching, so
+ * this function handles individual modaliases for one segment of the range.
+ */
+static ssize_t usb_id_to_modalias(const struct usb_device_id *id,
+				  unsigned int bcdDevice_initial,
+				  int bcdDevice_initial_digits,
+				  unsigned char range_lo,
+				  unsigned char range_hi,
+				  unsigned char max, const char *mod_name,
+				  char *buf, size_t count)
+{
+	ssize_t len = 0;
+
+	ADD(buf, count, len, "alias usb:v",
+	    id->match_flags & USB_DEVICE_ID_MATCH_VENDOR, id->idVendor);
+	ADD(buf, count, len, "p", id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT,
+	    id->idProduct);
+
+	len += scnprintf(&buf[len], count - len, "d");
+	if (bcdDevice_initial_digits)
+		len += scnprintf(&buf[len], count - len, "%0*X",
+			bcdDevice_initial_digits, bcdDevice_initial);
+	if (range_lo == range_hi) {
+		len += scnprintf(&buf[len], count - len, "%X", range_lo);
+	} else if (range_lo > 0 || range_hi < max) {
+		if (range_lo > 0x9 || range_hi < 0xA) {
+			len += scnprintf(&buf[len], count - len, "[%X-%X]",
+					 range_lo, range_hi);
+		} else {
+			len += scnprintf(&buf[len], count - len,
+				range_lo < 0x9 ? "[%X-9" : "[%X",
+				range_lo);
+			len += scnprintf(&buf[len], count - len,
+				range_hi > 0xA ? "A-%X]" : "%X]",
+				range_hi);
+		}
+	}
+	if (bcdDevice_initial_digits < (sizeof(id->bcdDevice_lo) * 2 - 1))
+		len += scnprintf(&buf[len], count - len, "*");
+
+	ADD(buf, count, len, "dc",
+	    id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS, id->bDeviceClass);
+	ADD(buf, count, len, "dsc",
+	    id->match_flags & USB_DEVICE_ID_MATCH_DEV_SUBCLASS,
+	    id->bDeviceSubClass);
+	ADD(buf, count, len, "dp",
+	    id->match_flags & USB_DEVICE_ID_MATCH_DEV_PROTOCOL,
+	    id->bDeviceProtocol);
+	ADD(buf, count, len, "ic",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_CLASS,
+	    id->bInterfaceClass);
+	ADD(buf, count, len, "isc",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	    id->bInterfaceSubClass);
+	ADD(buf, count, len, "ip",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_PROTOCOL,
+	    id->bInterfaceProtocol);
+	ADD(buf, count, len, "in",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_NUMBER,
+	    id->bInterfaceNumber);
+
+	len += scnprintf(&buf[len], count - len, " %s\n", mod_name);
+	return len;
+}
+
+/* Handles increment/decrement of BCD formatted integers */
+/* Returns the previous value, so it works like i++ or i-- */
+static unsigned int incbcd(unsigned int *bcd,
+			   int inc,
+			   unsigned char max,
+			   size_t chars)
+{
+	unsigned int init = *bcd, i, j;
+	unsigned long long c, dec = 0, div;
+
+	/* If bcd is not in BCD format, just increment */
+	if (max > 0x9) {
+		*bcd += inc;
+		return init;
+	}
+
+	/* Convert BCD to Decimal */
+	for (i = 0 ; i < chars ; i++) {
+		c = (*bcd >> (i << 2)) & 0xf;
+		c = c > 9 ? 9 : c; /* force to bcd just in case */
+		for (j = 0 ; j < i ; j++)
+			c = c * 10;
+		dec += c;
+	}
+
+	/* Do our increment/decrement */
+	dec += inc;
+	*bcd  = 0;
+
+	/* Convert back to BCD */
+	for (i = 0 ; i < chars ; i++) {
+		for (c = 1, j = 0 ; j < i ; j++)
+			c = c * 10;
+		div = dec;
+		(void)do_div(div, c); /* div = div / c */
+		c = do_div(div, 10); /* c = div % 10; div = div / 10 */
+		*bcd += c << (i << 2);
+	}
+	return init;
+}
+
+/* Print the modaliases for the specified struct usb_device_id. */
+static ssize_t usb_id_to_modalias_multi(const struct usb_device_id *id,
+					const char *mod_name, char *buf,
+					size_t count)
+{
+	ssize_t len = 0;
+	unsigned int devlo, devhi;
+	unsigned char chi, clo, max;
+	int ndigits;
+
+	devlo = id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO ?
+		id->bcdDevice_lo : 0x0U;
+	devhi = id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI ?
+		id->bcdDevice_hi : ~0x0U;
+
+	/* Figure out if this entry is in bcd or hex format */
+	max = 0x9; /* Default to decimal format */
+	for (ndigits = 0 ; ndigits < sizeof(id->bcdDevice_lo) * 2 ; ndigits++) {
+		clo = (devlo >> (ndigits << 2)) & 0xf;
+		chi = ((devhi > 0x9999 ? 0x9999 : devhi) >>
+		       (ndigits << 2)) & 0xf;
+		if (clo > max || chi > max) {
+			max = 0xf;
+			break;
+		}
+	}
+
+	/*
+	 * Some modules (visor) have empty slots as placeholder for
+	 * run-time specification that results in catch-all alias
+	 */
+	if (!(id->idVendor || id->idProduct || id->bDeviceClass ||
+	      id->bInterfaceClass))
+		return len;
+
+	/* Convert numeric bcdDevice range into fnmatch-able pattern(s) */
+	for (ndigits = sizeof(id->bcdDevice_lo) * 2 - 1; devlo <= devhi;
+	     ndigits--) {
+		clo = devlo & 0xf;
+		chi = devhi & 0xf;
+		/* If we are in bcd mode, truncate if necessary */
+		if (chi > max)
+			chi = max;
+		devlo >>= 4;
+		devhi >>= 4;
+
+		if (devlo == devhi || !ndigits) {
+			len += usb_id_to_modalias(id, devlo, ndigits, clo, chi,
+						  max, mod_name, buf + len,
+						  count - len);
+			break;
+		}
+
+		if (clo > 0x0)
+			len += usb_id_to_modalias(id,
+				incbcd(&devlo, 1, max,
+				       sizeof(id->bcdDevice_lo) * 2),
+				ndigits, clo, max, max, mod_name, buf + len,
+				count - len);
+
+		if (chi < max)
+			len += usb_id_to_modalias(id,
+				incbcd(&devhi, -1, max,
+				       sizeof(id->bcdDevice_lo) * 2),
+				ndigits, 0x0, chi, max, mod_name, buf + len,
+				count - len);
+	}
+	return len;
+}
+
+/* Print the modaliases for the given driver assumed to be an usb_driver or
+ * usb_device_driver.
+ *
+ * "alias" is prepended and the module name is appended to each modalias to
+ * match the format in modules.aliases.
+ *
+ * The modaliases will be written out to @buf with @count being the maximum
+ * bytes to write. The return value is a negative errno on error or the number
+ * of bytes written to @buf on success.
+ */
+ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+			    size_t count)
+{
+	ssize_t len = 0;
+	const struct usb_device_id *id;
+	const char *mod_name;
+
+	if (drv->bus != &usb_bus_type)
+		return -EINVAL;
+
+	if (drv->owner)
+		mod_name = drv->owner->name;
+	else
+		mod_name = drv->mod_name;
+
+	if (is_usb_device_driver(drv))
+		id = to_usb_device_driver(drv)->id_table;
+	else
+		id = to_usb_driver(drv)->id_table;
+	if (!id)
+		return len;
+
+	for (; id->match_flags; id++) {
+		len += usb_id_to_modalias_multi(id, mod_name, buf + len,
+						count - len);
+	}
+	return len;
+}
+#else
+inline ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+				   size_t count){ return 0; }
+#endif
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 7e7e119c253fb..fdbc197b64c9c 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -32,6 +32,7 @@
 #include <linux/usb/quirks.h>
 #include <linux/usb/hcd.h>
 
+#include "../../base/base.h"
 #include "usb.h"
 
 
@@ -2030,4 +2031,5 @@ struct bus_type usb_bus_type = {
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
 	.need_parent_lock =	true,
+	.drv_to_modalias = usb_drv_to_modalias,
 };
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index d8b29ccd07e56..cce0bedec63d9 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -61,6 +61,10 @@ struct fwnode_handle;
  *			this bus.
  * @dma_cleanup:	Called to cleanup DMA configuration on a device on
  *			this bus.
+ * @drv_to_modalias:    Called to convert the matching IDs in a
+ *                      struct device_driver to their corresponding modaliases.
+ *                      Note that the struct device_driver is expected to belong
+ *                      to this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -107,6 +111,9 @@ struct bus_type {
 	int (*dma_configure)(struct device *dev);
 	void (*dma_cleanup)(struct device *dev);
 
+	ssize_t (*drv_to_modalias)(struct device_driver *drv, char *buf,
+				   size_t count);
+
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;
@@ -161,6 +168,7 @@ void subsys_dev_iter_init(struct subsys_dev_iter *iter,
 struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
 void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
+int bus_for_each(void *data, int (*fn)(struct bus_type *, void *));
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
 struct device *bus_find_device(struct bus_type *bus, struct device *start,
diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a9..0bfa859a21566 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -47,6 +47,7 @@ struct module_kobject {
 	struct kobject *drivers_dir;
 	struct module_param_attrs *mp;
 	struct completion *kobj_completion;
+	struct bin_attribute modalias_attr;
 } __randomize_layout;
 
 struct module_attribute {
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2e2bf236f5582..8d7ae37584868 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -259,11 +259,13 @@ static inline void add_kallsyms(struct module *mod, const struct load_info *info
 #endif /* CONFIG_KALLSYMS */
 
 #ifdef CONFIG_SYSFS
+void add_modalias_attr(struct module_kobject *mk);
 int mod_sysfs_setup(struct module *mod, const struct load_info *info,
 		    struct kernel_param *kparam, unsigned int num_params);
 void mod_sysfs_teardown(struct module *mod);
 void init_param_lock(struct module *mod);
 #else /* !CONFIG_SYSFS */
+static inline void add_modalias_attr(struct module_kobject *mk) {}
 static inline int mod_sysfs_setup(struct module *mod,
 			   	  const struct load_info *info,
 			   	  struct kernel_param *kparam,
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index ce68f821dcd12..651c677c4ab96 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2008 Rusty Russell
  */
 
+#include <linux/device/bus.h>
+#include <linux/device/driver.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -240,6 +242,90 @@ static inline void add_notes_attrs(struct module *mod, const struct load_info *i
 static inline void remove_notes_attrs(struct module *mod) { }
 #endif /* CONFIG_KALLSYMS */
 
+/* Track of the buffer and module identity in callbacks when walking the list of
+ * drivers for each bus.
+ */
+struct modalias_bus_print_state {
+	struct module_kobject *mk;
+	char *buf;
+	size_t count;
+	ssize_t len;
+};
+
+static int print_modalias_for_drv(struct device_driver *drv, void *p)
+{
+	struct modalias_bus_print_state *s = p;
+	struct module_kobject *mk = s->mk;
+	ssize_t len;
+	/* Skip drivers that do not match this module. */
+	if (mk->mod) {
+		if (mk->mod != drv->owner)
+			return 0;
+	} else if (!mk->kobj.name || !drv->mod_name ||
+		   strcmp(mk->kobj.name, drv->mod_name))
+		return 0;
+
+	if (drv->bus && drv->bus->drv_to_modalias) {
+		len = drv->bus->drv_to_modalias(drv, s->buf + s->len,
+						s->count - s->len);
+		if (len < 0)
+			return len;
+		s->len += len;
+	}
+	return 0;
+}
+
+static int print_modalias_for_bus(struct bus_type *type, void *p)
+{
+	return bus_for_each_drv(type, NULL, p, print_modalias_for_drv);
+}
+
+static ssize_t module_modalias_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *bin_attr,
+				    char *buf, loff_t pos, size_t count)
+{
+	struct module_kobject *mk = container_of(kobj, struct module_kobject,
+						 kobj);
+	struct modalias_bus_print_state state = {mk, buf, count, 0};
+	int error = 0;
+
+	if (pos != 0)
+		return -EINVAL;
+
+	error = bus_for_each(&state, print_modalias_for_bus);
+	if (error)
+		return error;
+
+	/*
+	 * The caller checked the pos and count against our size.
+	 */
+	return state.len;
+}
+
+/* Used in kernel/params.c for builtin modules.
+ *
+ * `struct module_kobject` is used instead of `struct module` because for
+ * builtin modules, the `struct module` is not available when this is called.
+ */
+void add_modalias_attr(struct module_kobject *mk)
+{
+	sysfs_bin_attr_init(&mk->modalias_attr);
+	mk->modalias_attr.attr.name = "modalias";
+	mk->modalias_attr.attr.mode = 0444;
+	mk->modalias_attr.read = module_modalias_read;
+	if (sysfs_create_bin_file(&mk->kobj, &mk->modalias_attr)) {
+		/* We shouldn't ignore the return type, but there is nothing to
+		 * do.
+		 */
+		return;
+	}
+}
+
+static void remove_modalias_attr(struct module_kobject *mk)
+{
+	sysfs_remove_bin_file(&mk->kobj, &mk->modalias_attr);
+}
+
 static void del_usage_links(struct module *mod)
 {
 #ifdef CONFIG_MODULE_UNLOAD
@@ -398,6 +484,7 @@ int mod_sysfs_setup(struct module *mod,
 
 	add_sect_attrs(mod, info);
 	add_notes_attrs(mod, info);
+	add_modalias_attr(&mod->mkobj);
 
 	return 0;
 
@@ -415,6 +502,7 @@ int mod_sysfs_setup(struct module *mod,
 
 static void mod_sysfs_fini(struct module *mod)
 {
+	remove_modalias_attr(&mod->mkobj);
 	remove_notes_attrs(mod);
 	remove_sect_attrs(mod);
 	mod_kobject_put(mod);
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c50..b7fd5313a3118 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -14,6 +14,12 @@
 #include <linux/ctype.h>
 #include <linux/security.h>
 
+#ifdef CONFIG_MODULES
+#include "module/internal.h"
+#else
+static inline void add_modalias_attr(struct module_kobject *mk) {}
+#endif /* !CONFIG_MODULES */
+
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
 static DEFINE_MUTEX(param_lock);
@@ -815,6 +821,7 @@ static void __init kernel_add_sysfs_param(const char *name,
 	BUG_ON(err);
 	kobject_uevent(&mk->kobj, KOBJ_ADD);
 	kobject_put(&mk->kobj);
+	add_modalias_attr(mk);
 }
 
 /*
-- 
2.37.3

