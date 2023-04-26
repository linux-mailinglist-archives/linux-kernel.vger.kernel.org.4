Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17386EF8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjDZQqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjDZQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:46:15 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFACC7D9B;
        Wed, 26 Apr 2023 09:46:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 3ab12c2c96f2f176; Wed, 26 Apr 2023 18:46:06 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 05D5269D34E;
        Wed, 26 Apr 2023 18:46:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH v1] thermal: intel: menlow: Get rid of this driver
Date:   Wed, 26 Apr 2023 18:46:05 +0200
Message-ID: <2704255.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeelveehhfettdefuedvfeefteefjeejudffudfhtdegjeduvdeugfetveehieffieenucffohhmrghinheprghtthhrrdhnrghmvgenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhn
 thgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to my information, there are no active users of this driver in
the field.

Moreover, it does some really questionable things and gets in the way of
thermal core improvements, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/Kconfig        |    9 
 drivers/thermal/intel/Makefile       |    1 
 drivers/thermal/intel/intel_menlow.c |  521 -----------------------------------
 3 files changed, 531 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_menlow.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_menlow.c
+++ /dev/null
@@ -1,521 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Intel menlow Driver for thermal management extension
- *
- *  Copyright (C) 2008 Intel Corp
- *  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
- *  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
- *
- *  This driver creates the sys I/F for programming the sensors.
- *  It also implements the driver for intel menlow memory controller (hardware
- *  id is INT0002) which makes use of the platform specific ACPI methods
- *  to get/set bandwidth.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/acpi.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/pm.h>
-#include <linux/slab.h>
-#include <linux/thermal.h>
-#include <linux/types.h>
-#include <linux/units.h>
-
-MODULE_AUTHOR("Thomas Sujith");
-MODULE_AUTHOR("Zhang Rui");
-MODULE_DESCRIPTION("Intel Menlow platform specific driver");
-MODULE_LICENSE("GPL v2");
-
-/*
- * Memory controller device control
- */
-
-#define MEMORY_GET_BANDWIDTH "GTHS"
-#define MEMORY_SET_BANDWIDTH "STHS"
-#define MEMORY_ARG_CUR_BANDWIDTH 1
-#define MEMORY_ARG_MAX_BANDWIDTH 0
-
-static void intel_menlow_unregister_sensor(void);
-
-/*
- * GTHS returning 'n' would mean that [0,n-1] states are supported
- * In that case max_cstate would be n-1
- * GTHS returning '0' would mean that no bandwidth control states are supported
- */
-static int memory_get_max_bandwidth(struct thermal_cooling_device *cdev,
-				    unsigned long *max_state)
-{
-	struct acpi_device *device = cdev->devdata;
-	acpi_handle handle = device->handle;
-	unsigned long long value;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-	acpi_status status = AE_OK;
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = MEMORY_ARG_MAX_BANDWIDTH;
-	status = acpi_evaluate_integer(handle, MEMORY_GET_BANDWIDTH,
-				       &arg_list, &value);
-	if (ACPI_FAILURE(status))
-		return -EFAULT;
-
-	if (!value)
-		return -EINVAL;
-
-	*max_state = value - 1;
-	return 0;
-}
-
-static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
-				    unsigned long *value)
-{
-	struct acpi_device *device = cdev->devdata;
-	acpi_handle handle = device->handle;
-	unsigned long long result;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-	acpi_status status = AE_OK;
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = MEMORY_ARG_CUR_BANDWIDTH;
-	status = acpi_evaluate_integer(handle, MEMORY_GET_BANDWIDTH,
-				       &arg_list, &result);
-	if (ACPI_FAILURE(status))
-		return -EFAULT;
-
-	*value = result;
-	return 0;
-}
-
-static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
-				    unsigned long state)
-{
-	struct acpi_device *device = cdev->devdata;
-	acpi_handle handle = device->handle;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-	acpi_status status;
-	unsigned long long temp;
-	unsigned long max_state;
-
-	if (memory_get_max_bandwidth(cdev, &max_state))
-		return -EFAULT;
-
-	if (state > max_state)
-		return -EINVAL;
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = state;
-
-	status =
-	    acpi_evaluate_integer(handle, MEMORY_SET_BANDWIDTH, &arg_list,
-				  &temp);
-
-	pr_info("Bandwidth value was %ld: status is %d\n", state, status);
-	if (ACPI_FAILURE(status))
-		return -EFAULT;
-
-	return 0;
-}
-
-static const struct thermal_cooling_device_ops memory_cooling_ops = {
-	.get_max_state = memory_get_max_bandwidth,
-	.get_cur_state = memory_get_cur_bandwidth,
-	.set_cur_state = memory_set_cur_bandwidth,
-};
-
-/*
- * Memory Device Management
- */
-static int intel_menlow_memory_add(struct acpi_device *device)
-{
-	int result = -ENODEV;
-	struct thermal_cooling_device *cdev;
-
-	if (!device)
-		return -EINVAL;
-
-	if (!acpi_has_method(device->handle, MEMORY_GET_BANDWIDTH))
-		goto end;
-
-	if (!acpi_has_method(device->handle, MEMORY_SET_BANDWIDTH))
-		goto end;
-
-	cdev = thermal_cooling_device_register("Memory controller", device,
-					       &memory_cooling_ops);
-	if (IS_ERR(cdev)) {
-		result = PTR_ERR(cdev);
-		goto end;
-	}
-
-	device->driver_data = cdev;
-	result = sysfs_create_link(&device->dev.kobj,
-				&cdev->device.kobj, "thermal_cooling");
-	if (result)
-		goto unregister;
-
-	result = sysfs_create_link(&cdev->device.kobj,
-				&device->dev.kobj, "device");
-	if (result) {
-		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-		goto unregister;
-	}
-
- end:
-	return result;
-
- unregister:
-	thermal_cooling_device_unregister(cdev);
-	return result;
-
-}
-
-static void intel_menlow_memory_remove(struct acpi_device *device)
-{
-	struct thermal_cooling_device *cdev;
-
-	if (!device)
-		return;
-
-	cdev = acpi_driver_data(device);
-	if (!cdev)
-		return;
-
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-	sysfs_remove_link(&cdev->device.kobj, "device");
-	thermal_cooling_device_unregister(cdev);
-}
-
-static const struct acpi_device_id intel_menlow_memory_ids[] = {
-	{"INT0002", 0},
-	{"", 0},
-};
-
-static struct acpi_driver intel_menlow_memory_driver = {
-	.name = "intel_menlow_thermal_control",
-	.ids = intel_menlow_memory_ids,
-	.ops = {
-		.add = intel_menlow_memory_add,
-		.remove = intel_menlow_memory_remove,
-		},
-};
-
-/*
- * Sensor control on menlow platform
- */
-
-#define THERMAL_AUX0 0
-#define THERMAL_AUX1 1
-#define GET_AUX0 "GAX0"
-#define GET_AUX1 "GAX1"
-#define SET_AUX0 "SAX0"
-#define SET_AUX1 "SAX1"
-
-struct intel_menlow_attribute {
-	struct device_attribute attr;
-	struct device *device;
-	acpi_handle handle;
-	struct list_head node;
-};
-
-static LIST_HEAD(intel_menlow_attr_list);
-static DEFINE_MUTEX(intel_menlow_attr_lock);
-
-/*
- * sensor_get_auxtrip - get the current auxtrip value from sensor
- * @handle: Object handle
- * @index : GET_AUX1/GET_AUX0
- * @value : The address will be fill by the value
- */
-static int sensor_get_auxtrip(acpi_handle handle, int index,
-							unsigned long long *value)
-{
-	acpi_status status;
-
-	if ((index != 0 && index != 1) || !value)
-		return -EINVAL;
-
-	status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
-				       NULL, value);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	return 0;
-}
-
-/*
- * sensor_set_auxtrip - set the new auxtrip value to sensor
- * @handle: Object handle
- * @index : GET_AUX1/GET_AUX0
- * @value : The value will be set
- */
-static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
-{
-	acpi_status status;
-	union acpi_object arg = {
-		ACPI_TYPE_INTEGER
-	};
-	struct acpi_object_list args = {
-		1, &arg
-	};
-	unsigned long long temp;
-
-	if (index != 0 && index != 1)
-		return -EINVAL;
-
-	status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
-				       NULL, &temp);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-	if ((index && value < temp) || (!index && value > temp))
-		return -EINVAL;
-
-	arg.integer.value = value;
-	status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
-				       &args, &temp);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	/* do we need to check the return value of SAX0/SAX1 ? */
-
-	return 0;
-}
-
-#define to_intel_menlow_attr(_attr)	\
-	container_of(_attr, struct intel_menlow_attribute, attr)
-
-static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
-			char *buf, int idx)
-{
-	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	unsigned long long value;
-	int result;
-
-	result = sensor_get_auxtrip(attr->handle, idx, &value);
-	if (result)
-		return result;
-
-	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
-}
-
-static ssize_t aux0_show(struct device *dev,
-			 struct device_attribute *dev_attr, char *buf)
-{
-	return aux_show(dev, dev_attr, buf, 0);
-}
-
-static ssize_t aux1_show(struct device *dev,
-			 struct device_attribute *dev_attr, char *buf)
-{
-	return aux_show(dev, dev_attr, buf, 1);
-}
-
-static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
-			 const char *buf, size_t count, int idx)
-{
-	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	int value;
-	int result;
-
-	/*Sanity check; should be a positive integer */
-	if (!sscanf(buf, "%d", &value))
-		return -EINVAL;
-
-	if (value < 0)
-		return -EINVAL;
-
-	result = sensor_set_auxtrip(attr->handle, idx,
-				    celsius_to_deci_kelvin(value));
-	return result ? result : count;
-}
-
-static ssize_t aux0_store(struct device *dev,
-			  struct device_attribute *dev_attr,
-			  const char *buf, size_t count)
-{
-	return aux_store(dev, dev_attr, buf, count, 0);
-}
-
-static ssize_t aux1_store(struct device *dev,
-			  struct device_attribute *dev_attr,
-			  const char *buf, size_t count)
-{
-	return aux_store(dev, dev_attr, buf, count, 1);
-}
-
-/* BIOS can enable/disable the thermal user application in dabney platform */
-#define BIOS_ENABLED "\\_TZ.GSTS"
-static ssize_t bios_enabled_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	acpi_status status;
-	unsigned long long bios_enabled;
-
-	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
-}
-
-static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
-					  void *store, struct device *dev,
-					  acpi_handle handle)
-{
-	struct intel_menlow_attribute *attr;
-	int result;
-
-	attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
-	if (!attr)
-		return -ENOMEM;
-
-	sysfs_attr_init(&attr->attr.attr); /* That is consistent naming :D */
-	attr->attr.attr.name = name;
-	attr->attr.attr.mode = mode;
-	attr->attr.show = show;
-	attr->attr.store = store;
-	attr->device = dev;
-	attr->handle = handle;
-
-	result = device_create_file(dev, &attr->attr);
-	if (result) {
-		kfree(attr);
-		return result;
-	}
-
-	mutex_lock(&intel_menlow_attr_lock);
-	list_add_tail(&attr->node, &intel_menlow_attr_list);
-	mutex_unlock(&intel_menlow_attr_lock);
-
-	return 0;
-}
-
-static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
-						void *context, void **rv)
-{
-	acpi_status status;
-	acpi_handle dummy;
-	struct thermal_zone_device *thermal;
-	int result;
-
-	result = acpi_bus_get_private_data(handle, (void **)&thermal);
-	if (result)
-		return 0;
-
-	/* _TZ must have the AUX0/1 methods */
-	status = acpi_get_handle(handle, GET_AUX0, &dummy);
-	if (ACPI_FAILURE(status))
-		return (status == AE_NOT_FOUND) ? AE_OK : status;
-
-	status = acpi_get_handle(handle, SET_AUX0, &dummy);
-	if (ACPI_FAILURE(status))
-		return (status == AE_NOT_FOUND) ? AE_OK : status;
-
-	result = intel_menlow_add_one_attribute("aux0", 0644,
-						aux0_show, aux0_store,
-						&thermal->device, handle);
-	if (result)
-		return AE_ERROR;
-
-	status = acpi_get_handle(handle, GET_AUX1, &dummy);
-	if (ACPI_FAILURE(status))
-		goto aux1_not_found;
-
-	status = acpi_get_handle(handle, SET_AUX1, &dummy);
-	if (ACPI_FAILURE(status))
-		goto aux1_not_found;
-
-	result = intel_menlow_add_one_attribute("aux1", 0644,
-						aux1_show, aux1_store,
-						&thermal->device, handle);
-	if (result) {
-		intel_menlow_unregister_sensor();
-		return AE_ERROR;
-	}
-
-	/*
-	 * create the "dabney_enabled" attribute which means the user app
-	 * should be loaded or not
-	 */
-
-	result = intel_menlow_add_one_attribute("bios_enabled", 0444,
-						bios_enabled_show, NULL,
-						&thermal->device, handle);
-	if (result) {
-		intel_menlow_unregister_sensor();
-		return AE_ERROR;
-	}
-
-	return AE_OK;
-
- aux1_not_found:
-	if (status == AE_NOT_FOUND)
-		return AE_OK;
-
-	intel_menlow_unregister_sensor();
-	return status;
-}
-
-static void intel_menlow_unregister_sensor(void)
-{
-	struct intel_menlow_attribute *pos, *next;
-
-	mutex_lock(&intel_menlow_attr_lock);
-	list_for_each_entry_safe(pos, next, &intel_menlow_attr_list, node) {
-		list_del(&pos->node);
-		device_remove_file(pos->device, &pos->attr);
-		kfree(pos);
-	}
-	mutex_unlock(&intel_menlow_attr_lock);
-
-	return;
-}
-
-static int __init intel_menlow_module_init(void)
-{
-	int result = -ENODEV;
-	acpi_status status;
-	unsigned long long enable;
-
-	if (acpi_disabled)
-		return result;
-
-	/* Looking for the \_TZ.GSTS method */
-	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &enable);
-	if (ACPI_FAILURE(status) || !enable)
-		return -ENODEV;
-
-	/* Looking for ACPI device MEM0 with hardware id INT0002 */
-	result = acpi_bus_register_driver(&intel_menlow_memory_driver);
-	if (result)
-		return result;
-
-	/* Looking for sensors in each ACPI thermal zone */
-	status = acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX,
-				     intel_menlow_register_sensor, NULL, NULL, NULL);
-	if (ACPI_FAILURE(status)) {
-		acpi_bus_unregister_driver(&intel_menlow_memory_driver);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static void __exit intel_menlow_module_exit(void)
-{
-	acpi_bus_unregister_driver(&intel_menlow_memory_driver);
-	intel_menlow_unregister_sensor();
-}
-
-module_init(intel_menlow_module_init);
-module_exit(intel_menlow_module_exit);
Index: linux-pm/drivers/thermal/intel/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/intel/Kconfig
+++ linux-pm/drivers/thermal/intel/Kconfig
@@ -103,15 +103,6 @@ config INTEL_TCC_COOLING
 	  on how fast the setting takes effect, and how much the CPU frequency
 	  is reduced.
 
-config INTEL_MENLOW
-	tristate "Thermal Management driver for Intel menlow platform"
-	depends on ACPI_THERMAL
-	help
-	  ACPI thermal management enhancement driver on
-	  Intel Menlow platform.
-
-	  If unsure, say N.
-
 config INTEL_HFI_THERMAL
 	bool "Intel Hardware Feedback Interface"
 	depends on NET
Index: linux-pm/drivers/thermal/intel/Makefile
===================================================================
--- linux-pm.orig/drivers/thermal/intel/Makefile
+++ linux-pm/drivers/thermal/intel/Makefile
@@ -13,5 +13,4 @@ obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) +=
 obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
 obj-$(CONFIG_INTEL_TCC_COOLING)	+= intel_tcc_cooling.o
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
-obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
 obj-$(CONFIG_INTEL_HFI_THERMAL) += intel_hfi.o



