Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD367040A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjEOWDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245686AbjEOWCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:02:42 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B51E120B1;
        Mon, 15 May 2023 15:01:26 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-55293697882so510123eaf.0;
        Mon, 15 May 2023 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188071; x=1686780071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmVgBuO5M/8Vy64GGuga+zf65QwAYhwQrC2gzLxvBiw=;
        b=Mho8yqUvC2+IxFOZlmOX8QYb2MGypnQI9JPEhVDrq2bGJokjrOKtMXEDq3RBH2/upC
         yZoqdeKWKIzkKNklYINKSKtoDVPlP9OWdf+GCn/OSJkUGHh0cvDz5KuixpWBYNSI9E4v
         1Kv3YBOqHwEYhO3y8LkabSdqsfZR1VPqwkxUHdrSHK4e4PqUOx72vThJUCS9CJWCNId/
         L21wI7EaYi07uuPsHv2E28iMu+MBV08IzHaC5L2DRUDW2TrzZQpvKH+LPeocaqGVcjN5
         kpwL0GDuoz5nEwhdyx2XbmAFRhF8NHzKuKB2oFtDdgupGnxon1fx9bkaqbLQ2zU88Umr
         gHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188071; x=1686780071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmVgBuO5M/8Vy64GGuga+zf65QwAYhwQrC2gzLxvBiw=;
        b=ERtjRrPMQ435ytQ9RWQHI9x0MF+1qL+g2DCBmZIoEwzKaZmjuK07S9H8qvlpmJpgTl
         l5mzc0ViT+TJjhiGuLQi2pE5s5Kcdsc7Cx7DX7fL55FWXrUG2kZKREj53VseSB/uJk6r
         0bhNbaLEcQ7O4jDvDyaE+S7CE9kSVBW9ZtlcZeuZGDM/cEfvqiBgyaWRS2mpdWnPhQu5
         yTZIU/2RUbzndhTPwODJHmLspMwtd/gmMYg4Py4i2r9F4wqZRkjxJa4LmHrgjSW0obig
         UKITP6kGZio7tuqjvybD1gbPMXyqfWJ5luOuRK7KK1MH0SXJHTJkLjgPNu/dOJGpRJT5
         5DUA==
X-Gm-Message-State: AC+VfDw+aKFHY0DOdaa0432lxxsOUTGFgliwx5PFqLflimVqe1CHP3l2
        vAbOgJyMVEHs+WeNGciz/VE=
X-Google-Smtp-Source: ACHHUZ6UFDiShzIEUsD/vflLwTRcFQd1RmmHs9W9cAwqkVCdAnB7ZUAvkasP+Nzu4PqAMnxDF7jTcQ==
X-Received: by 2002:a54:4091:0:b0:394:67a1:3e29 with SMTP id i17-20020a544091000000b0039467a13e29mr5836398oii.8.1684188070389;
        Mon, 15 May 2023 15:01:10 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:5391:4539:59c2:4092])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b0038e07fe2c97sm5265148oiy.42.2023.05.15.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:01:10 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v13 06/13] hp-bioscfg: int-attributes
Date:   Mon, 15 May 2023 17:00:54 -0500
Message-Id: <20230515220101.39794-7-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515220101.39794-1-jorge.lopez2@hp.com>
References: <20230515220101.39794-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/int-attributes.c        | 440 ++++++++++++++++++
 1 file changed, 440 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
new file mode 100644
index 000000000000..8a3836bd2430
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to integer type attributes under
+ * BIOS Enumeration GUID for use with hp-bioscfg driver.
+ *
+ * Copyright (c) 2022 Hewlett-Packard Inc.
+ */
+
+#include "bioscfg.h"
+
+GET_INSTANCE_ID(integer);
+
+static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int instance_id = get_integer_instance_id(kobj);
+
+	if (instance_id < 0)
+		return -EIO;
+
+	return sysfs_emit(buf, "%d\n",
+			  bioscfg_drv.integer_data[instance_id].current_value);
+}
+
+/**
+ * validate_integer_input() -
+ * Validate input of current_value against lower and upper bound
+ *
+ * @instance_id: The instance on which input is validated
+ * @buf: Input value
+ */
+static int validate_integer_input(int instance_id, char *buf)
+{
+	int in_val;
+	int ret;
+	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
+
+	/* BIOS treats it as a read only attribute */
+	if (integer_data->common.is_readonly)
+		return -EIO;
+
+	ret = kstrtoint(buf, 10, &in_val);
+	if (ret < 0)
+		return ret;
+
+	if (in_val < integer_data->lower_bound ||
+	    in_val > integer_data->upper_bound)
+		return -ERANGE;
+
+	return 0;
+}
+
+static void update_integer_value(int instance_id, char *attr_value)
+{
+	int in_val;
+	int ret;
+	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
+
+	ret = kstrtoint(attr_value, 10, &in_val);
+	if (ret == 0)
+		integer_data->current_value = in_val;
+	else
+		pr_warn("Invalid integer value found: %s\n", attr_value);
+}
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, integer);
+static struct kobj_attribute integer_display_name =
+	__ATTR_RO(display_name);
+
+ATTRIBUTE_PROPERTY_STORE(current_value, integer);
+static struct kobj_attribute integer_current_val =
+	__ATTR_RW_MODE(current_value, 0644);
+
+ATTRIBUTE_N_PROPERTY_SHOW(lower_bound, integer);
+static struct kobj_attribute integer_lower_bound =
+	__ATTR_RO(lower_bound);
+
+ATTRIBUTE_N_PROPERTY_SHOW(upper_bound, integer);
+static struct kobj_attribute integer_upper_bound =
+	__ATTR_RO(upper_bound);
+
+ATTRIBUTE_N_PROPERTY_SHOW(scalar_increment, integer);
+static struct kobj_attribute integer_scalar_increment =
+	__ATTR_RO(scalar_increment);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "integer\n");
+}
+
+static struct kobj_attribute integer_type =
+	__ATTR_RO(type);
+
+static struct kobj_attribute common_display_langcode =
+	__ATTR_RO(display_name_language_code);
+
+static struct attribute *integer_attrs[] = {
+	&common_display_langcode.attr,
+	&integer_display_name.attr,
+	&integer_current_val.attr,
+	&integer_lower_bound.attr,
+	&integer_upper_bound.attr,
+	&integer_scalar_increment.attr,
+	&integer_type.attr,
+	NULL
+};
+
+static const struct attribute_group integer_attr_group = {
+	.attrs = integer_attrs,
+};
+
+int hp_alloc_integer_data(void)
+{
+	bioscfg_drv.integer_instances_count = hp_get_instance_count(HP_WMI_BIOS_INTEGER_GUID);
+	bioscfg_drv.integer_data = kcalloc(bioscfg_drv.integer_instances_count,
+					   sizeof(*bioscfg_drv.integer_data), GFP_KERNEL);
+
+	if (!bioscfg_drv.integer_data) {
+		bioscfg_drv.integer_instances_count = 0;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* Expected Values types associated with each element */
+static const acpi_object_type expected_integer_types[] = {
+	[NAME] = ACPI_TYPE_STRING,
+	[VALUE] = ACPI_TYPE_STRING,
+	[PATH] = ACPI_TYPE_STRING,
+	[IS_READONLY] = ACPI_TYPE_INTEGER,
+	[DISPLAY_IN_UI] = ACPI_TYPE_INTEGER,
+	[REQUIRES_PHYSICAL_PRESENCE] = ACPI_TYPE_INTEGER,
+	[SEQUENCE] = ACPI_TYPE_INTEGER,
+	[PREREQUISITES_SIZE] = ACPI_TYPE_INTEGER,
+	[PREREQUISITES] = ACPI_TYPE_STRING,
+	[SECURITY_LEVEL] = ACPI_TYPE_INTEGER,
+	[INT_LOWER_BOUND] = ACPI_TYPE_INTEGER,
+	[INT_UPPER_BOUND] = ACPI_TYPE_INTEGER,
+	[INT_SCALAR_INCREMENT] = ACPI_TYPE_INTEGER,
+};
+
+static int hp_populate_integer_elements_from_package(union acpi_object *integer_obj,
+						     int integer_obj_count,
+						     int instance_id)
+{
+	char *str_value = NULL;
+	int value_len;
+	int ret;
+	u32 int_value;
+	int elem;
+	int reqs;
+	int eloc;
+	int size;
+	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
+
+	if (!integer_obj)
+		return -EINVAL;
+
+	for (elem = 1, eloc = 1; elem < integer_obj_count; elem++, eloc++) {
+		/* ONLY look at the first INTEGER_ELEM_CNT elements */
+		if (eloc == INT_ELEM_CNT)
+			goto exit_integer_package;
+
+		switch (integer_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+			if (elem != PREREQUISITES) {
+				ret = hp_convert_hexstr_to_str(integer_obj[elem].string.pointer,
+							       integer_obj[elem].string.length,
+							       &str_value, &value_len);
+				if (ret)
+					continue;
+			}
+			break;
+		case ACPI_TYPE_INTEGER:
+			int_value = (u32)integer_obj[elem].integer.value;
+			break;
+		default:
+			pr_warn("Unsupported object type [%d]\n", integer_obj[elem].type);
+			continue;
+		}
+		/* Check that both expected and read object type match */
+		if (expected_integer_types[eloc] != integer_obj[elem].type) {
+			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
+			       expected_integer_types[eloc], elem, integer_obj[elem].type);
+			return -EIO;
+		}
+		/* Assign appropriate element value to corresponding field*/
+		switch (eloc) {
+		case VALUE:
+			ret = kstrtoint(str_value, 10, &int_value);
+			if (ret)
+				continue;
+
+			integer_data->current_value = int_value;
+			break;
+		case PATH:
+			strscpy(integer_data->common.path, str_value,
+				sizeof(integer_data->common.path));
+			break;
+		case IS_READONLY:
+			integer_data->common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			integer_data->common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			integer_data->common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			integer_data->common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+			/*
+			 * This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero. PREREQUISITES
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (integer_data->common.prerequisites_size == 0)
+				eloc++;
+			break;
+		case PREREQUISITES:
+			size = min_t(u32, integer_data->common.prerequisites_size, MAX_PREREQUISITES_SIZE);
+
+			for (reqs = 0; reqs < size; reqs++) {
+				if (elem >= integer_obj_count) {
+					pr_err("Error elem-objects package is too small\n");
+					return -EINVAL;
+				}
+
+				ret = hp_convert_hexstr_to_str(integer_obj[elem + reqs].string.pointer,
+							       integer_obj[elem + reqs].string.length,
+							       &str_value, &value_len);
+
+				if (ret)
+					continue;
+
+				strscpy(integer_data->common.prerequisites[reqs],
+					str_value,
+					sizeof(integer_data->common.prerequisites[reqs]));
+				kfree(str_value);
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			integer_data->common.security_level = int_value;
+			break;
+		case INT_LOWER_BOUND:
+			integer_data->lower_bound = int_value;
+			break;
+		case INT_UPPER_BOUND:
+			integer_data->upper_bound = int_value;
+			break;
+		case INT_SCALAR_INCREMENT:
+			integer_data->scalar_increment = int_value;
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+exit_integer_package:
+	kfree(str_value);
+	return 0;
+}
+
+/**
+ * hp_populate_integer_package_data() -
+ * Populate all properties of an instance under integer attribute
+ *
+ * @integer_obj: ACPI object with integer data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_integer_package_data(union acpi_object *integer_obj,
+				     int instance_id,
+				     struct kobject *attr_name_kobj)
+{
+	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
+
+	integer_data->attr_name_kobj = attr_name_kobj;
+	hp_populate_integer_elements_from_package(integer_obj,
+						  integer_obj->package.count,
+						  instance_id);
+	hp_update_attribute_permissions(integer_data->common.is_readonly,
+					&integer_current_val);
+	hp_friendly_user_name_update(integer_data->common.path,
+				     attr_name_kobj->name,
+				     integer_data->common.display_name,
+				     sizeof(integer_data->common.display_name));
+	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
+}
+
+static int hp_populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+						    int instance_id)
+{
+	char *dst = NULL;
+	int reqs;
+	int ret;
+	int dst_size = *buffer_size / sizeof(u16);
+	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
+
+	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+
+	/*
+	 * Only data relevant to this driver and its functionality is
+	 * read. BIOS defines the order in which each * element is
+	 * read. Element 0 data is not relevant to this
+	 * driver hence it is ignored. For clarity, all element names
+	 * (DISPLAY_IN_UI) which defines the order in which is read
+	 * and the name matches the variable where the data is stored.
+	 */
+
+	/*
+	 * In earlier implementation, reported errors were ignored
+	 * causing the data to remain uninitialized. It is for this
+	 * reason functions may return an error and no validation
+	 * takes place.
+	 */
+
+	// VALUE:
+	integer_data->current_value = 0;
+
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+	ret = kstrtoint(dst, 10, &integer_data->current_value);
+	if (ret)
+		pr_warn("Unable to convert string to integer: %s\n", dst);
+	kfree(dst);
+
+	// PATH:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, integer_data->common.path,
+				  sizeof(integer_data->common.path));
+
+	// IS_READONLY:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->common.is_readonly);
+
+	//DISPLAY_IN_UI:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->common.display_in_ui);
+
+	// REQUIRES_PHYSICAL_PRESENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->common.requires_physical_presence);
+
+	// SEQUENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->common.sequence);
+
+	// PREREQUISITES_SIZE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->common.prerequisites_size);
+
+	if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
+		/* Report a message and limit prerequisite size to maximum value */
+		pr_warn("Integer Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+		integer_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
+	}
+
+	// PREREQUISITES:
+	for (reqs = 0; reqs < integer_data->common.prerequisites_size; reqs++)
+		hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+					  integer_data->common.prerequisites[reqs],
+					  sizeof(integer_data->common.prerequisites[reqs]));
+
+	// SECURITY_LEVEL:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->common.security_level);
+
+	// INT_LOWER_BOUND:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->lower_bound);
+
+	// INT_UPPER_BOUND:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->upper_bound);
+
+	// INT_SCALAR_INCREMENT:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &integer_data->scalar_increment);
+
+	return 0;
+}
+
+/**
+ * hp_populate_integer_buffer_data() -
+ * Populate all properties of an instance under integer attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
+				    struct kobject *attr_name_kobj)
+{
+	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
+
+	integer_data->attr_name_kobj = attr_name_kobj;
+
+	/* Populate integer elements */
+	hp_populate_integer_elements_from_buffer(buffer_ptr, buffer_size,
+						 instance_id);
+	hp_update_attribute_permissions(integer_data->common.is_readonly,
+					&integer_current_val);
+	hp_friendly_user_name_update(integer_data->common.path,
+				     attr_name_kobj->name,
+				     integer_data->common.display_name,
+				     sizeof(integer_data->common.display_name));
+
+	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
+}
+
+/**
+ * hp_exit_integer_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void hp_exit_integer_attributes(void)
+{
+	int instance_id;
+
+	for (instance_id = 0; instance_id < bioscfg_drv.integer_instances_count;
+	     instance_id++) {
+		struct kobject *attr_name_kobj =
+			bioscfg_drv.integer_data[instance_id].attr_name_kobj;
+
+		if (attr_name_kobj)
+			sysfs_remove_group(attr_name_kobj, &integer_attr_group);
+	}
+	bioscfg_drv.integer_instances_count = 0;
+
+	kfree(bioscfg_drv.integer_data);
+	bioscfg_drv.integer_data = NULL;
+}
-- 
2.34.1

