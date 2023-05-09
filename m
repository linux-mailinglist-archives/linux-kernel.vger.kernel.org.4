Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17B06FC7A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjEINPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEINP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:15:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1071BC9;
        Tue,  9 May 2023 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683638127; x=1715174127;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3SRRAeuSb15jQxV7H7GHKIPrtDLZj1jb8zmUuRbZ8hY=;
  b=hAj6H3G742HcERBhqhwGSMj3NUX76YBnY1dCBZi3mqkdFPIFcQx5ZiRf
   HhGlrb0QrhnBbf8v0e29wgjlX+63UJ+nFIJL1Rn2gup3DxdUr5XxfsLXV
   v6qK4ca6Hu+KFTHdkfopuZxkkgRWmSbM32QgNmW9vmCCABTCXiAqFnd9H
   yamv3It0M5dmWqBlEa7GV+CDc8TzdMdz3WEIG0UH2lFEcpeblB94pZVi4
   UJRNfHJL+nOGvPKvbFNhZsd++K3P53atx49Zp7fCa3TWYKeGKRrZYFKDL
   ts/7XYMIVIUD7gZZlru2UKMFuPNbYG/IA6Qr+/IUXuSnOo4qBEmBNwaug
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="415489889"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="415489889"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 06:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="698897380"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="698897380"
Received: from mbrdon-mobl.ger.corp.intel.com ([10.251.219.121])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 06:15:24 -0700
Date:   Tue, 9 May 2023 16:15:22 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v12 05/13] HP BIOSCFG driver  - ordered-attributes
In-Reply-To: <20230505220043.39036-6-jorge.lopez2@hp.com>
Message-ID: <266e7ffc-ee84-56d9-51c5-61f2600d4c4@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-6-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-335599627-1683635802=:2036"
Content-ID: <a0c97653-c9c-c18b-98af-fef8860b4e9@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-335599627-1683635802=:2036
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <5314e927-d953-8f33-5f4-f2129c5b793c@linux.intel.com>

On Fri, 5 May 2023, Jorge Lopez wrote:

> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.¢s commercial
> notebooks.
> 
> Many features of HP Commercial notebooks can be managed using Windows
> Management Instrumentation (WMI). WMI is an implementation of Web-Based
> Enterprise Management (WBEM) that provides a standards-based interface
> for changing and monitoring system settings. HP BIOSCFG driver provides
> a native Linux solution and the exposed features facilitates the
> migration to Linux environments.
> 
> The Linux security features to be provided in hp-bioscfg driver enables
> managing the BIOS settings and security solutions via sysfs, a virtual
> filesystem that can be used by user-mode applications. The new
> documentation cover HP-specific firmware sysfs attributes such Secure
> Platform Management and Sure Start. Each section provides security
> feature description and identifies sysfs directories and files exposed
> by the driver.
> 
> Many HP Commercial notebooks include a feature called Secure Platform
> Management (SPM), which replaces older password-based BIOS settings
> management with public key cryptography. PC secure product management
> begins when a target system is provisioned with cryptographic keys
> that are used to ensure the integrity of communications between system
> management utilities and the BIOS.
> 
> HP Commercial notebooks have several BIOS settings that control its
> behaviour and capabilities, many of which are related to security.
> To prevent unauthorized changes to these settings, the system can
> be configured to use a cryptographic signature-based authorization
> string that the BIOS will use to verify authorization to modify the
> setting.
> 
> Linux Security components are under development and not published yet.
> The only linux component is the driver (hp bioscfg) at this time.
> Other published security components are under Windows.
> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++++++++++++
>  1 file changed, 443 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> new file mode 100644
> index 000000000000..1d06fbefceca
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> @@ -0,0 +1,443 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to ordered list type attributes under
> + * BIOS ORDERED LIST GUID for use with hp-bioscfg driver.
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#include "bioscfg.h"
> +
> +GET_INSTANCE_ID(ordered_list);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id = get_ordered_list_instance_id(kobj);
> +
> +	if (instance_id < 0)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "%s\n",
> +			 bioscfg_drv.ordered_list_data[instance_id].current_value);
> +}
> +
> +/**
> + * validate_ordered_list_input() -
> + * Validate input of current_value against possible values
> + *
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + */
> +static int validate_ordered_list_input(int instance_id, const char *buf)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	if (ordered_list_data->common.requires_physical_presence)
> +		set_reboot_and_signal_event();
> +
> +	return 0;
> +}
> +
> +static void update_ordered_list_value(int instance_id, char *attr_value)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	strscpy(ordered_list_data->current_value,
> +		attr_value,
> +		sizeof(ordered_list_data->current_value));
> +}
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, ordered_list);
> +static struct kobj_attribute ordered_list_display_langcode =
> +	__ATTR_RO(display_name_language_code);
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, ordered_list);
> +static struct kobj_attribute ordered_list_display_name =
> +	__ATTR_RO(display_name);
> +
> +ATTRIBUTE_PROPERTY_STORE(current_value, ordered_list);
> +static struct kobj_attribute ordered_list_current_val =
> +	__ATTR_RW_MODE(current_value, 0644);
> +
> +ATTRIBUTE_VALUES_PROPERTY_SHOW(elements, ordered_list, COMMA_SEP);
> +static struct kobj_attribute  ordered_list_elements_val =
> +	__ATTR_RO(elements);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "ordered-list\n");
> +}
> +
> +static struct kobj_attribute ordered_list_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *ordered_list_attrs[] = {
> +	&ordered_list_display_langcode.attr,
> +	&ordered_list_display_name.attr,
> +	&ordered_list_current_val.attr,
> +	&ordered_list_elements_val.attr,
> +	&ordered_list_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ordered_list_attr_group = {
> +	.attrs = ordered_list_attrs,
> +};
> +
> +int alloc_ordered_list_data(void)
> +{
> +	bioscfg_drv.ordered_list_instances_count =
> +		get_instance_count(HP_WMI_BIOS_ORDERED_LIST_GUID);
> +	bioscfg_drv.ordered_list_data = kcalloc(bioscfg_drv.ordered_list_instances_count,
> +						sizeof(struct ordered_list_data), GFP_KERNEL);
> +	if (!bioscfg_drv.ordered_list_data) {
> +		bioscfg_drv.ordered_list_instances_count = 0;
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * populate_ordered_list_package_data() -
> + * Populate all properties of an instance under ordered_list attribute
> + *
> + * @order_obj: ACPI object with ordered_list data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_ordered_list_package_data(union acpi_object *order_obj, int instance_id,
> +				       struct kobject *attr_name_kobj)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	ordered_list_data->attr_name_kobj = attr_name_kobj;
> +
> +	populate_ordered_list_elements_from_package(order_obj,
> +						    order_obj->package.count,
> +						    instance_id);
> +	update_attribute_permissions(ordered_list_data->common.is_readonly,
> +				     &ordered_list_current_val);
> +	friendly_user_name_update(ordered_list_data->common.path,
> +				  attr_name_kobj->name,
> +				  ordered_list_data->common.display_name,
> +				  sizeof(ordered_list_data->common.display_name));
> +	return sysfs_create_group(attr_name_kobj, &ordered_list_attr_group);
> +}
> +
> +/* Expected Values types associated with each element */
> +static const acpi_object_type expected_order_types[] = {
> +	[NAME]	= ACPI_TYPE_STRING,
> +	[VALUE] = ACPI_TYPE_STRING,
> +	[PATH] = ACPI_TYPE_STRING,
> +	[IS_READONLY] = ACPI_TYPE_INTEGER,
> +	[DISPLAY_IN_UI] = ACPI_TYPE_INTEGER,
> +	[REQUIRES_PHYSICAL_PRESENCE] = ACPI_TYPE_INTEGER,
> +	[SEQUENCE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES_SIZE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES] = ACPI_TYPE_STRING,
> +	[SECURITY_LEVEL] = ACPI_TYPE_INTEGER,
> +	[ORD_LIST_SIZE] = ACPI_TYPE_INTEGER,
> +	[ORD_LIST_ELEMENTS] = ACPI_TYPE_STRING,
> +};
> +
> +int populate_ordered_list_elements_from_package(union acpi_object *order_obj,
> +						int order_obj_count,
> +						int instance_id)
> +{
> +	char *str_value = NULL;
> +	int value_len;
> +	int ret;
> +	u32 size;
> +	u32 int_value;
> +	int elem;
> +	int reqs;
> +	int eloc;
> +	char *tmpstr = NULL;
> +	char *part_tmp = NULL;
> +	int tmp_len = 0;
> +	char *part = NULL;
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	if (!order_obj)
> +		return -EINVAL;
> +
> +	strscpy(ordered_list_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(ordered_list_data->common.display_name_language_code));
> +
> +	for (elem = 1, eloc = 1; elem < order_obj_count; elem++, eloc++) {
> +		/* ONLY look at the first ORDERED_ELEM_CNT elements */
> +		if (eloc == ORD_ELEM_CNT)
> +			goto exit_list_package;
> +
> +		switch (order_obj[elem].type) {
> +		case ACPI_TYPE_STRING:
> +

Extra newline.

> +			if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
> +				ret = convert_hexstr_to_str(order_obj[elem].string.pointer,
> +							    order_obj[elem].string.length,
> +							    &str_value, &value_len);
> +				if (ret)
> +					continue;
> +			}
> +			break;
> +		case ACPI_TYPE_INTEGER:
> +			int_value = (u32)order_obj[elem].integer.value;
> +			break;
> +		default:
> +			pr_warn("Unsupported object type [%d]\n", order_obj[elem].type);
> +			continue;
> +		}
> +
> +		/* Check that both expected and read object type match */
> +		if (expected_order_types[eloc] != order_obj[elem].type) {
> +			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",

Extra space before %d.

> +			       expected_order_types[eloc], elem, order_obj[elem].type);
> +			return -EIO;
> +		}
> +
> +		/* Assign appropriate element value to corresponding field*/
> +		switch (eloc) {
> +		case VALUE:
> +			strscpy(ordered_list_data->current_value,
> +				str_value, sizeof(ordered_list_data->current_value));
> +			break;
> +		case PATH:
> +			strscpy(ordered_list_data->common.path, str_value,
> +				sizeof(ordered_list_data->common.path));
> +			break;
> +		case IS_READONLY:
> +			ordered_list_data->common.is_readonly = int_value;
> +			break;
> +		case DISPLAY_IN_UI:
> +			ordered_list_data->common.display_in_ui = int_value;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			ordered_list_data->common.requires_physical_presence = int_value;
> +			break;
> +		case SEQUENCE:
> +			ordered_list_data->common.sequence = int_value;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			ordered_list_data->common.prerequisites_size = int_value;
> +			if (int_value > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero.  PREREQUISITES
> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (int_value == 0)
> +				eloc++;
> +			break;
> +		case PREREQUISITES:
> +			size = ordered_list_data->common.prerequisites_size;
> +
> +			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
> +				ret = convert_hexstr_to_str(order_obj[elem + reqs].string.pointer,
> +							    order_obj[elem + reqs].string.length,
> +							    &str_value, &value_len);
> +
> +				if (ret)
> +					continue;
> +
> +				strscpy(ordered_list_data->common.prerequisites[reqs],
> +					str_value,
> +					sizeof(ordered_list_data->common.prerequisites[reqs]));
> +
> +				kfree(str_value);
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			ordered_list_data->common.security_level = int_value;
> +			break;
> +
> +		case ORD_LIST_SIZE:
> +			ordered_list_data->elements_size = int_value;
> +			if (int_value > MAX_ELEMENTS_SIZE)
> +				pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero.  ORD_LIST_ELEMENTS
> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (int_value == 0)
> +				eloc++;
> +			break;
> +		case ORD_LIST_ELEMENTS:
> +			size = ordered_list_data->elements_size;
> +
> +			/*
> +			 * Ordered list data is stored in hex and comma separated format
> +			 * Convert the data and split it to show each element
> +			 */
> +			ret = convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
> +			if (ret)
> +				goto exit_list_package;
> +
> +			part_tmp = tmpstr;
> +			part = strsep(&part_tmp, ",");
> +			if (!part)
> +				strscpy(ordered_list_data->elements[0],
> +					tmpstr,
> +					sizeof(ordered_list_data->elements[0]));
> +
> +			for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {
> +				strscpy(ordered_list_data->elements[elem],
> +					part,
> +					sizeof(ordered_list_data->elements[elem]));
> +				part = strsep(&part_tmp, ",");
> +			}
> +
> +			kfree(tmpstr);
> +			break;
> +		default:
> +			pr_warn("Invalid element: %d found in Ordered_List attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +		kfree(tmpstr);
> +		kfree(str_value);
> +	}
> +
> +exit_list_package:
> +	kfree(tmpstr);
> +	kfree(str_value);
> +	return 0;
> +}

Looks double and triple frees in this function.

After reading the about same things once again, I started to wonder if 
some of that switch content could be moved into a common helper (which 
takes e.g. the xx->common pointer as parameter and perhaps some other 
carefully selected pointers). There's a lots of duplication.

> +/**
> + * populate_ordered_list_buffer_data() - Populate all properties of an
> + * instance under ordered list attribute
> + *
> + * @buffer_ptr: Buffer pointer
> + * @buffer_size: Buffer size
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_ordered_list_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
> +				      struct kobject *attr_name_kobj)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	ordered_list_data->attr_name_kobj = attr_name_kobj;
> +
> +	/* Populate ordered list elements */
> +	populate_ordered_list_elements_from_buffer(buffer_ptr, buffer_size,
> +						   instance_id);
> +	update_attribute_permissions(ordered_list_data->common.is_readonly,
> +				     &ordered_list_current_val);
> +	friendly_user_name_update(ordered_list_data->common.path,
> +				  attr_name_kobj->name,
> +				  ordered_list_data->common.display_name,
> +				  sizeof(ordered_list_data->common.display_name));
> +
> +	return sysfs_create_group(attr_name_kobj, &ordered_list_attr_group);
> +}
> +
> +int populate_ordered_list_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					       int instance_id)
> +{
> +	int reqs;
> +	int values;
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	strscpy(ordered_list_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(ordered_list_data->common.display_name_language_code));
> +
> +	// VALUE:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_data->current_value,
> +			       sizeof(ordered_list_data->current_value));
> +
> +	// PATH:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_data->common.path,
> +			       sizeof(ordered_list_data->common.path));
> +
> +	// IS_READONLY:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.is_readonly);
> +
> +	//DISPLAY_IN_UI:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.display_in_ui);
> +
> +	// REQUIRES_PHYSICAL_PRESENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.requires_physical_presence);
> +
> +	// SEQUENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.sequence);
> +
> +	// PREREQUISITES_SIZE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.prerequisites_size);
> +
> +	if (ordered_list_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
> +		/* Report a message and limit prerequisite size to maximum value */
> +		pr_warn("String Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		ordered_list_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
> +	}
> +
> +	// PREREQUISITES:
> +	for (reqs = 0;
> +	     reqs < ordered_list_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;
> +	     reqs++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       ordered_list_data->common.prerequisites[reqs],
> +				       sizeof(ordered_list_data->common.prerequisites[reqs]));
> +
> +	// SECURITY_LEVEL:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.security_level);
> +
> +	// ORD_LIST_SIZE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->elements_size);
> +
> +	if (ordered_list_data->elements_size > MAX_ELEMENTS_SIZE) {
> +		/* Report a message and limit elements size to maximum value */
> +		pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		ordered_list_data->elements_size = MAX_ELEMENTS_SIZE;
> +	}
> +
> +	// ORD_LIST_ELEMENTS:
> +	for (values = 0; values < ordered_list_data->elements_size && values < MAX_ELEMENTS_SIZE;
> +	     values++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       ordered_list_data->elements[values],
> +				       sizeof(ordered_list_data->elements[values]));
> +
> +	return 0;
> +}

Same here. Pass buffer, buffer_size and common into a helper? Maybe some 
other parameters too to cover many/all of the cases?

> +
> +/**
> + * exit_ordered_list_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + */
> +void exit_ordered_list_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < bioscfg_drv.ordered_list_instances_count;
> +	     instance_id++) {
> +		struct kobject *attr_name_kobj =
> +			bioscfg_drv.ordered_list_data[instance_id].attr_name_kobj;
> +
> +		if (attr_name_kobj)
> +			sysfs_remove_group(attr_name_kobj,
> +					   &ordered_list_attr_group);
> +	}
> +	bioscfg_drv.ordered_list_instances_count = 0;
> +
> +	kfree(bioscfg_drv.ordered_list_data);
> +	bioscfg_drv.ordered_list_data = NULL;
> +}
> 

-- 
 i.
--8323329-335599627-1683635802=:2036--
