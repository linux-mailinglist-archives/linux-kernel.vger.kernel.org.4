Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15296FB32F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEHOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjEHOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:45:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CDB2;
        Mon,  8 May 2023 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683557145; x=1715093145;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WDZDMZplovlJZ86EhxJ3O8IDnzNpJtknK/mRAVS7lHA=;
  b=ccINXUHqA8UB0MLS8Idn36vTLcPeH9V3+0vjiGUXSG/AJw2Bi0GsHJYb
   GDo7qB4vz7vv/Tm/LwOE6I1DWAMXBdyNTBWHcN1JVnmM2amknpjuytoDT
   JHAgaMvYKjbaYF3A1ROPQwyykjsblBsl971Z3+jFSPLt7PES06rVwCOVJ
   ZFQGUHkDzdlHbc9H4/XneB3FcKTZLc8EFA02ymhQDqHcTULJ4Z6C0BORz
   kbulHP1YrhDU4NASPAT0e5yp7RTBu/eWsV/mlPeZ0VU4DdRGOtYGaGUgq
   p7oMrMuj08OiNX59UsIhbc8j8/iMrr/zdswYTmV51dmtGjmEMbxzhj5Gd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347129634"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="347129634"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="701438051"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="701438051"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:45:43 -0700
Date:   Mon, 8 May 2023 17:45:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v12 04/13] HP BIOSCFG driver  - int-attributes
In-Reply-To: <20230505220043.39036-5-jorge.lopez2@hp.com>
Message-ID: <51607d2d-2d74-7dd4-e266-cf3ec0235e7a@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-5-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-85799458-1683556510=:1790"
Content-ID: <984cc351-9d23-ceca-5042-472425aef363@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-85799458-1683556510=:1790
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <6e17c1e8-2371-a745-9139-9a1f1bf747b4@linux.intel.com>

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
>  .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++++++++++++
>  1 file changed, 448 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> new file mode 100644
> index 000000000000..1395043d5c9f
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to integer type attributes under
> + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> + *
> + *  Copyright (c) 2022 Hewlett-Packard Inc.
> + */
> +
> +#include "bioscfg.h"
> +
> +GET_INSTANCE_ID(integer);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id = get_integer_instance_id(kobj);
> +
> +	if (instance_id < 0)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "%d\n",
> +			  bioscfg_drv.integer_data[instance_id].current_value);
> +}
> +
> +/*
> + * validate_integer_input() -
> + * Validate input of current_value against lower and upper bound
> + *
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + */
> +static int validate_integer_input(int instance_id, char *buf)
> +{
> +	int in_val;
> +	int ret;
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	/* BIOS treats it as a read only attribute */
> +	if (integer_data->common.is_readonly)
> +		return -EIO;
> +
> +	ret = kstrtoint(buf, 10, &in_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (in_val < integer_data->lower_bound ||
> +	    in_val > integer_data->upper_bound)
> +		return -ERANGE;
> +
> +	/*
> +	 * set pending reboot flag depending on
> +	 * "RequiresPhysicalPresence" value
> +	 */
> +	if (integer_data->common.requires_physical_presence)
> +		set_reboot_and_signal_event();
> +	return 0;
> +}
> +
> +static void update_integer_value(int instance_id, char *attr_value)
> +{
> +	int in_val;
> +	int ret;
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	ret = kstrtoint(attr_value, 10, &in_val);
> +	if (ret == 0)
> +		integer_data->current_value = in_val;
> +	else
> +		pr_warn("Invalid integer value found: %s\n", attr_value);
> +}
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, integer);
> +static struct kobj_attribute integer_display_langcode =
> +	__ATTR_RO(display_name_language_code);
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, integer);
> +static struct kobj_attribute integer_display_name =
> +	__ATTR_RO(display_name);
> +
> +ATTRIBUTE_PROPERTY_STORE(current_value, integer);
> +static struct kobj_attribute integer_current_val =
> +	__ATTR_RW_MODE(current_value, 0644);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(lower_bound, integer);
> +static struct kobj_attribute integer_lower_bound =
> +	__ATTR_RO(lower_bound);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(upper_bound, integer);
> +static struct kobj_attribute integer_upper_bound =
> +	__ATTR_RO(upper_bound);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(scalar_increment, integer);
> +static struct kobj_attribute integer_scalar_increment =
> +	__ATTR_RO(scalar_increment);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "integer\n");
> +}
> +
> +static struct kobj_attribute integer_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *integer_attrs[] = {
> +	&integer_display_langcode.attr,
> +	&integer_display_name.attr,
> +	&integer_current_val.attr,
> +	&integer_lower_bound.attr,
> +	&integer_upper_bound.attr,
> +	&integer_scalar_increment.attr,
> +	&integer_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group integer_attr_group = {
> +	.attrs = integer_attrs,
> +};
> +
> +int alloc_integer_data(void)
> +{
> +	bioscfg_drv.integer_instances_count = get_instance_count(HP_WMI_BIOS_INTEGER_GUID);
> +	bioscfg_drv.integer_data = kcalloc(bioscfg_drv.integer_instances_count,
> +					   sizeof(struct integer_data), GFP_KERNEL);

It would be better to use sizeof(*...) format.

> +
> +	if (!bioscfg_drv.integer_data) {
> +		bioscfg_drv.integer_instances_count = 0;
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +/* Expected Values types associated with each element */
> +static const acpi_object_type expected_integer_types[] = {
> +	[NAME] = ACPI_TYPE_STRING,
> +	[VALUE] = ACPI_TYPE_STRING,
> +	[PATH] = ACPI_TYPE_STRING,
> +	[IS_READONLY] = ACPI_TYPE_INTEGER,
> +	[DISPLAY_IN_UI] = ACPI_TYPE_INTEGER,
> +	[REQUIRES_PHYSICAL_PRESENCE] = ACPI_TYPE_INTEGER,
> +	[SEQUENCE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES_SIZE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES] = ACPI_TYPE_STRING,
> +	[SECURITY_LEVEL] = ACPI_TYPE_INTEGER,
> +	[INT_LOWER_BOUND] = ACPI_TYPE_INTEGER,
> +	[INT_UPPER_BOUND] = ACPI_TYPE_INTEGER,
> +	[INT_SCALAR_INCREMENT] = ACPI_TYPE_INTEGER,
> +};
> +
> +/*
> + * populate_int_data() -
> + * Populate all properties of an instance under integer attribute
> + *
> + * @integer_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_integer_package_data(union acpi_object *integer_obj,
> +				  int instance_id,
> +				  struct kobject *attr_name_kobj)
> +{
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	integer_data->attr_name_kobj = attr_name_kobj;
> +	populate_integer_elements_from_package(integer_obj,
> +					       integer_obj->package.count,
> +					       instance_id);
> +	update_attribute_permissions(integer_data->common.is_readonly,
> +				     &integer_current_val);
> +	friendly_user_name_update(integer_data->common.path,
> +				  attr_name_kobj->name,
> +				  integer_data->common.display_name,
> +				  sizeof(integer_data->common.display_name));
> +	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +}
> +
> +int populate_integer_elements_from_package(union acpi_object *integer_obj,
> +					   int integer_obj_count,
> +					   int instance_id)
> +{
> +	char *str_value = NULL;
> +	int value_len;
> +	int ret;
> +	u32 int_value;
> +	int elem;
> +	int reqs;
> +	int eloc;
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	if (!integer_obj)
> +		return -EINVAL;
> +
> +	strscpy(integer_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(integer_data->common.display_name_language_code));
> +
> +	for (elem = 1, eloc = 1; elem < integer_obj_count; elem++, eloc++) {
> +		/* ONLY look at the first INTEGER_ELEM_CNT elements */
> +		if (eloc == INT_ELEM_CNT)
> +			goto exit_integer_package;
> +
> +		switch (integer_obj[elem].type) {
> +		case ACPI_TYPE_STRING:
> +

Extra newline.

> +			if (elem != PREREQUISITES) {
> +				ret = convert_hexstr_to_str(integer_obj[elem].string.pointer,
> +							    integer_obj[elem].string.length,
> +							    &str_value, &value_len);
> +				if (ret)
> +					continue;
> +			}
> +			break;
> +		case ACPI_TYPE_INTEGER:
> +			int_value = (u32)integer_obj[elem].integer.value;
> +			break;
> +		default:
> +			pr_warn("Unsupported object type [%d]\n", integer_obj[elem].type);
> +			continue;
> +		}
> +		/* Check that both expected and read object type match */
> +		if (expected_integer_types[eloc] != integer_obj[elem].type) {
> +			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
> +			       expected_integer_types[eloc], elem, integer_obj[elem].type);
> +			return -EIO;
> +		}
> +		/* Assign appropriate element value to corresponding field*/
> +		switch (eloc) {
> +		case VALUE:
> +			ret = kstrtoint(str_value, 10, &int_value);
> +			if (ret)
> +				continue;
> +
> +			integer_data->current_value = int_value;
> +			break;
> +		case PATH:
> +			strscpy(integer_data->common.path, str_value,
> +				sizeof(integer_data->common.path));
> +			break;
> +		case IS_READONLY:
> +			integer_data->common.is_readonly = int_value;
> +			break;
> +		case DISPLAY_IN_UI:
> +			integer_data->common.display_in_ui = int_value;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			integer_data->common.requires_physical_presence = int_value;
> +			break;
> +		case SEQUENCE:
> +			integer_data->common.sequence = int_value;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero.  PREREQUISITES
> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (integer_data->common.prerequisites_size == 0)
> +				eloc++;
> +			break;
> +		case PREREQUISITES:
> +			for (reqs = 0;
> +			     reqs < integer_data->common.prerequisites_size &&
> +			     reqs < MAX_PREREQUISITES_SIZE;
> +			     reqs++) {
> +				if (elem >= integer_obj_count) {
> +					pr_err("Error elem-objects package is too small\n");
> +					return -EINVAL;
> +				}
> +
> +				ret = convert_hexstr_to_str(integer_obj[elem + reqs].string.pointer,
> +							    integer_obj[elem + reqs].string.length,
> +							    &str_value, &value_len);
> +
> +				if (ret)
> +					continue;
> +
> +				strscpy(integer_data->common.prerequisites[reqs],
> +					str_value,
> +					sizeof(integer_data->common.prerequisites[reqs]));
> +				kfree(str_value);
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			integer_data->common.security_level = int_value;
> +			break;
> +		case INT_LOWER_BOUND:
> +			integer_data->lower_bound = int_value;
> +			break;
> +		case INT_UPPER_BOUND:
> +			integer_data->upper_bound = int_value;
> +			break;
> +		case INT_SCALAR_INCREMENT:
> +			integer_data->scalar_increment = int_value;
> +			break;
> +		default:
> +			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +	}
> +exit_integer_package:
> +	kfree(str_value);
> +	return 0;
> +}
> +
> +/*
> + * populate_integer_buffer_data() -
> + * Populate all properties of an instance under integer attribute
> + *
> + * @buffer_ptr: Buffer pointer
> + * @buffer_size: Buffer size
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
> +				 struct kobject *attr_name_kobj)
> +{
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	integer_data->attr_name_kobj = attr_name_kobj;
> +
> +	/* Populate integer elements */
> +	populate_integer_elements_from_buffer(buffer_ptr, buffer_size,
> +					      instance_id);
> +	update_attribute_permissions(integer_data->common.is_readonly,
> +				     &integer_current_val);
> +	friendly_user_name_update(integer_data->common.path,
> +				  attr_name_kobj->name,
> +				  integer_data->common.display_name,
> +				  sizeof(integer_data->common.display_name));
> +
> +	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +}
> +
> +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					  int instance_id)
> +{
> +	char *dst = NULL;
> +	int reqs;
> +	int ret;
> +	int dst_size = *buffer_size / sizeof(u16);
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> +	if (!dst)
> +		return -ENOMEM;
> +
> +	strscpy(integer_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(integer_data->common.display_name_language_code));
> +	/*
> +	 * Only data relevant to this driver and its functionality is
> +	 * read. BIOS defines the order in which each * element is
> +	 * read. Element 0 data is not relevant to this
> +	 * driver hence it is ignored.  For clarity, all element names
> +	 * (DISPLAY_IN_UI) which defines the order in which is read
> +	 * and the name matches the variable where the data is stored.
> +	 */
> +
> +	// VALUE:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> +	ret = kstrtoint(dst, 10, &integer_data->current_value);
> +	if (ret)
> +		pr_warn("Unable to convert string to integer: %s\n", dst);
> +
> +	// PATH:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, integer_data->common.path,
> +			       sizeof(integer_data->common.path));
> +
> +	// IS_READONLY:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.is_readonly);
> +
> +	//DISPLAY_IN_UI:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.display_in_ui);
> +
> +	// REQUIRES_PHYSICAL_PRESENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.requires_physical_presence);
> +
> +	// SEQUENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.sequence);
> +
> +	// PREREQUISITES_SIZE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.prerequisites_size);
> +
> +	if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
> +		/* Report a message and limit prerequisite size to maximum value */
> +		pr_warn("Integer Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		integer_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
> +	}
> +
> +	// PREREQUISITES:
> +	for (reqs = 0;
> +	     reqs < integer_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;

Why is the second check necessary, didn't you just above force it 
prerequisites_size to never be larger than that???

After removing it, put the whole for () for a single line.

> +	     reqs++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       integer_data->common.prerequisites[reqs],
> +				       sizeof(integer_data->common.prerequisites[reqs]));
> +
> +	// SECURITY_LEVEL:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.security_level);
> +
> +	// INT_LOWER_BOUND:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->lower_bound);
> +
> +	// INT_UPPER_BOUND:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->upper_bound);
> +
> +	// INT_SCALAR_INCREMENT:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->scalar_increment);
> +
> +	kfree(dst);
> +	return 0;
> +}
> +
> +/*
> + * exit_integer_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + */
> +void exit_integer_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < bioscfg_drv.integer_instances_count;
> +	     instance_id++) {
> +		struct kobject *attr_name_kobj =
> +			bioscfg_drv.integer_data[instance_id].attr_name_kobj;

You could consider shorter variable name for instance_id. IMHO, it add 
very little value in the long form over i or id.

> +
> +		if (attr_name_kobj)
> +			sysfs_remove_group(attr_name_kobj, &integer_attr_group);
> +	}
> +	bioscfg_drv.integer_instances_count = 0;
> +
> +	kfree(bioscfg_drv.integer_data);
> +	bioscfg_drv.integer_data = NULL;
> +}
> 

-- 
 i.
--8323329-85799458-1683556510=:1790--
