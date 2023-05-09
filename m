Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D06FC67D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjEIMek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjEIMeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:34:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF221721;
        Tue,  9 May 2023 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683635675; x=1715171675;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0aO5bV9ylcU886976RIFQBLxHZ1LxgqAbp/xKVSxSsM=;
  b=awicepDM8lR0bSSikI5Vy9D9p/jkpPpGLv8MCWbTDTlwxyNKdVrBmBeJ
   S0W4P5KoW4HPtxPyBkRFPyqUxhTrQbCaXb+zyZ3moiM/8IKtvrOOK7AgZ
   XvvqiCvjipMsQ1Blb09AzySUjlN0oMHAt0ThW3HvGwv7zA617OHQWycBP
   j7GJzkQYHvpeJNG1I58DsAJKft4VuotbpGzsF2JcxmS/aXh5jdkCgkIMx
   Qv8sE/0Vag/WZf94REw4Bxss0/MqRk8wMVj8ke1RDmt52bNQydVOxEvu4
   4AJKR5DLHiyWACgHMmIaUyYeSllit5qT+uvKAuMNowEv3xw0C1YULCLP1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="415479300"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="415479300"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="649304803"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="649304803"
Received: from mbrdon-mobl.ger.corp.intel.com ([10.251.219.121])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:34:32 -0700
Date:   Tue, 9 May 2023 15:34:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v12 06/13] HP BIOSCFG driver  - passwdobj-attributes
In-Reply-To: <20230505220043.39036-7-jorge.lopez2@hp.com>
Message-ID: <ff831b68-58ca-947e-1e1-b9461b781bc0@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-7-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-288836710-1683632980=:2036"
Content-ID: <e481445c-9d4-a0ad-7f6-d9279146695@linux.intel.com>
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

--8323329-288836710-1683632980=:2036
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <81c1c151-f8ed-a54b-8152-67a97da2d361@linux.intel.com>

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

FYI, for me you don't need to reply into the comments where you'll be 
following the review suggestion. It saves us both time if we focus on 
points where there's more to discuss.

> ---
>  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 584 ++++++++++++++++++
>  1 file changed, 584 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> new file mode 100644
> index 000000000000..7f3bd58ab3fd
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -0,0 +1,584 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to password object type attributes under
> + * BIOS PASSWORD for use with hp-bioscfg driver.
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#include "bioscfg.h"
> +#include <asm-generic/posix_types.h>
> +
> +GET_INSTANCE_ID(password);
> +/*
> + * Clear all passwords copied to memory for a particular
> + * authentication instance
> + */
> +int clear_passwords(const int instance)
> +{
> +	struct password_data *password_data = &bioscfg_drv.password_data[instance];
> +
> +	if (!password_data->is_enabled)
> +		return 0;
> +
> +	memset(password_data->current_password,
> +	       0, sizeof(password_data->current_password));
> +	memset(password_data->new_password,
> +	       0, sizeof(password_data->new_password));
> +
> +	return 0;
> +}
> +
> +/*
> + * Clear all credentials copied to memory for both Power-ON and Setup
> + * BIOS instances
> + */
> +int clear_all_credentials(void)
> +{
> +	int instance;
> +
> +	/* clear all passwords */
> +	for (instance = 0; instance < bioscfg_drv.password_instances_count; instance++)
> +		clear_passwords(instance);
> +
> +	/* clear auth_token */
> +	kfree(bioscfg_drv.spm_data.auth_token);
> +	bioscfg_drv.spm_data.auth_token = NULL;
> +
> +	return 0;
> +}
> +
> +int get_password_instance_for_type(const char *name)
> +{
> +	int count = bioscfg_drv.password_instances_count;
> +	int instance;
> +
> +	for (instance = 0; instance < count; instance++) {

Perhaps the loops could have the same form, either this or the one in the 
prev function.

> +		if (strcmp(bioscfg_drv.password_data[instance].common.display_name, name) == 0)

!strcmp(...)

> +			return instance;
> +	}
> +	return -EINVAL;
> +}
> +
> +int validate_password_input(int instance_id, const char *buf)
> +{
> +	int length;
> +	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
> +
> +	length = strlen(buf);
> +	if (buf[length - 1] == '\n')
> +		length--;
> +
> +	if (length > MAX_PASSWD_SIZE)
> +		return INVALID_BIOS_AUTH;
> +
> +	if (password_data->min_password_length > length ||
> +	    password_data->max_password_length < length)
> +		return INVALID_BIOS_AUTH;
> +	return SUCCESS;
> +}
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(is_enabled, password);
> +static struct kobj_attribute password_is_password_set = __ATTR_RO(is_enabled);
> +
> +static ssize_t current_password_store(struct kobject *kobj,
> +				      struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	char *buf_cp;
> +	int id, ret = 0;
> +
> +	buf_cp = kstrdup(buf, GFP_KERNEL);
> +	if (!buf_cp) {
> +		ret = -ENOMEM;
> +		goto exit_password;

return -ENOMEM; directly.

> +	}
> +
> +	ret = enforce_single_line_input(buf_cp, count);
> +	if (!ret) {
> +		id = get_password_instance_id(kobj);
> +		if (id >= 0)
> +			ret = validate_password_input(id, buf_cp);
> +	}
> +
> +	if (!ret) {

Convert the error handling above to < 0 + goto pairs instead.

Should this function really return 0 when get_password_instance_id() 
returns error?

It can also write to -EIO index here when get_poassword_instance_id() 
fails:

> +		strscpy(bioscfg_drv.password_data[id].current_password,
> +			buf_cp,
> +			sizeof(bioscfg_drv.password_data[id].current_password));
> +		/*
> +		 * set pending reboot flag depending on
> +		 * "RequiresPhysicalPresence" value
> +		 */
> +		if (bioscfg_drv.password_data[id].common.requires_physical_presence)
> +			set_reboot_and_signal_event();
> +	}

> +
> +exit_password:
> +	kfree(buf_cp);
> +	return ret ? ret : count;
> +}
> +
> +static struct kobj_attribute password_current_password = __ATTR_WO(current_password);
> +
> +static ssize_t new_password_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	char *buf_cp = NULL;
> +	int id = 0;
> +	int ret = -EIO;
> +
> +	buf_cp = kstrdup(buf, GFP_KERNEL);
> +	if (!buf_cp) {
> +		ret = -ENOMEM;
> +		goto exit_password;

return -ENOMEM;


> +	}
> +
> +	ret = enforce_single_line_input(buf_cp, count);
> +	if (!ret) {
> +		id = get_password_instance_id(kobj);
> +
> +		if (id >= 0)
> +			ret = validate_password_input(id, buf_cp);
> +	}
> +
> +	if (!ret)
> +		strscpy(bioscfg_drv.password_data[id].new_password,
> +			buf_cp,
> +			sizeof(bioscfg_drv.password_data[id].new_password));
> +

Duplicated code with the previous function? If so, add a helper.

> +	if (!ret)
> +		ret = hp_set_attribute(kobj->name, buf_cp);
> +
> +exit_password:
> +	/*
> +	 * Regardless of the results both new and current passwords
> +	 * will be set to zero and avoid security issues
> +	 */
> +	clear_passwords(id);
> +
> +	kfree(buf_cp);
> +	return ret ? ret : count;
> +}
> +
> +static struct kobj_attribute password_new_password = __ATTR_WO(new_password);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(min_password_length, password);
> +static struct kobj_attribute password_min_password_length = __ATTR_RO(min_password_length);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(max_password_length, password);
> +static struct kobj_attribute password_max_password_length = __ATTR_RO(max_password_length);
> +
> +static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	if (strcmp(kobj->name, SETUP_PASSWD) == 0)

Use !strcmp() instead, please check the rest yourself, I won't mark them 
all.

> +		return sysfs_emit(buf, "%s\n", BIOS_ADMIN);
> +
> +	if (strcmp(kobj->name, POWER_ON_PASSWD) == 0)
> +		return sysfs_emit(buf,  "%s\n", POWER_ON);
> +
> +	return -EIO;
> +}
> +
> +static struct kobj_attribute password_role = __ATTR_RO(role);
> +
> +static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			      char *buf)
> +{
> +	int i = get_password_instance_id(kobj);
> +
> +	if (i < 0)
> +		return i;
> +
> +	if (bioscfg_drv.password_data[i].mechanism != PASSWORD)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%s\n", PASSWD_MECHANISM_TYPES);
> +}
> +
> +static struct kobj_attribute password_mechanism = __ATTR_RO(mechanism);
> +
> +ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password, SEMICOLON_SEP);
> +static struct kobj_attribute  password_encodings_val =
> +		__ATTR_RO(encodings);
> +
> +static struct attribute *password_attrs[] = {
> +	&password_is_password_set.attr,
> +	&password_min_password_length.attr,
> +	&password_max_password_length.attr,
> +	&password_current_password.attr,
> +	&password_new_password.attr,
> +	&password_role.attr,
> +	&password_mechanism.attr,
> +	&password_encodings_val.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group password_attr_group = {
> +	.attrs = password_attrs
> +};
> +
> +int alloc_password_data(void)
> +{
> +	int ret = 0;
> +
> +	bioscfg_drv.password_instances_count = get_instance_count(HP_WMI_BIOS_PASSWORD_GUID);
> +	bioscfg_drv.password_data = kcalloc(bioscfg_drv.password_instances_count,
> +					    sizeof(struct password_data), GFP_KERNEL);
> +	if (!bioscfg_drv.password_data) {
> +		bioscfg_drv.password_instances_count = 0;
> +		ret = -ENOMEM;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * populate_password_package_data -
> + *	Populate all properties for an instance under password attribute
> + *
> + * @password_obj: ACPI object with password data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object

Is kerneldoc happy with the extra line between func and its parameters, 
IIRC it might not like that?

> + */
> +int populate_password_package_data(union acpi_object *password_obj, int instance_id,
> +				   struct kobject *attr_name_kobj)
> +{
> +	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
> +
> +	password_data->attr_name_kobj = attr_name_kobj;
> +
> +	populate_password_elements_from_package(password_obj,
> +						password_obj->package.count,
> +						instance_id);
> +
> +	if (strcmp(attr_name_kobj->name, SETUP_PASSWD) == 0) {
> +		/* Save  system authentication instance for easy access */

Extra space.

> +		return sysfs_create_group(attr_name_kobj, &password_attr_group);
> +	}
> +
> +	return sysfs_create_group(attr_name_kobj, &password_attr_group);
> +}
> +
> +/* Expected Values types associated with each element */
> +static const acpi_object_type expected_password_types[] = {
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
> +	[PSWD_MIN_LENGTH] = ACPI_TYPE_INTEGER,
> +	[PSWD_MAX_LENGTH] = ACPI_TYPE_INTEGER,
> +	[PSWD_SIZE] = ACPI_TYPE_INTEGER,
> +	[PSWD_ENCODINGS] = ACPI_TYPE_STRING,
> +	[PSWD_IS_SET] = ACPI_TYPE_INTEGER,
> +};
> +
> +int populate_password_elements_from_package(union acpi_object *password_obj,
> +					    int password_obj_count,
> +					    int instance_id)
> +{
> +	char *str_value = NULL;
> +	int value_len;
> +	int ret;
> +	u32 size;
> +	u32 int_value;
> +	int elem;
> +	int reqs;
> +	int eloc;
> +	int pos_values;
> +	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
> +
> +	if (!password_obj)
> +		return -EINVAL;
> +
> +	for (elem = 1, eloc = 1; elem < password_obj_count; elem++, eloc++) {
> +		/* ONLY look at the first PASSWORD_ELEM_CNT elements */
> +		if (eloc == PSWD_ELEM_CNT)
> +			goto exit_package;
> +
> +		switch (password_obj[elem].type) {
> +		case ACPI_TYPE_STRING:
> +

Extra newline.

> +			if (PREREQUISITES != elem && PSWD_ENCODINGS != elem) {
> +				ret = convert_hexstr_to_str(password_obj[elem].string.pointer,
> +							    password_obj[elem].string.length,
> +							    &str_value, &value_len);
> +				if (ret)
> +					continue;
> +			}
> +			break;
> +		case ACPI_TYPE_INTEGER:
> +			int_value = (u32)password_obj[elem].integer.value;
> +			break;
> +		default:
> +			pr_warn("Unsupported object type [%d]\n", password_obj[elem].type);
> +			continue;
> +		}
> +
> +		/* Check that both expected and read object type match */
> +		if (expected_password_types[eloc] != password_obj[elem].type) {
> +			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
> +			       expected_password_types[eloc], elem, password_obj[elem].type);
> +			return -EIO;
> +		}
> +
> +		/* Assign appropriate element value to corresponding field*/
> +		switch (eloc) {
> +		case VALUE:
> +			break;
> +		case PATH:
> +			strscpy(password_data->common.path, str_value,
> +				sizeof(password_data->common.path));
> +			break;
> +		case IS_READONLY:
> +			password_data->common.is_readonly = int_value;
> +			break;
> +		case DISPLAY_IN_UI:
> +			password_data->common.display_in_ui = int_value;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			password_data->common.requires_physical_presence = int_value;
> +			break;
> +		case SEQUENCE:
> +			password_data->common.sequence = int_value;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			password_data->common.prerequisites_size = int_value;
> +			if (int_value > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero.  PREREQUISITES

Please remove all these double space from your patches (should be easy 
to find them with grep). Please check if your editor adds them e.g., when 
reflowing text.

> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (int_value == 0)
> +				eloc++;
> +			break;
> +		case PREREQUISITES:
> +			size = password_data->common.prerequisites_size;
> +
> +			for (reqs = 0; reqs < size; reqs++) {
> +				ret = convert_hexstr_to_str(password_obj[elem + reqs].string.pointer,
> +							    password_obj[elem + reqs].string.length,
> +							    &str_value, &value_len);
> +

Extra newline

> +				if (ret)
> +					break;
> +
> +				strscpy(password_data->common.prerequisites[reqs],
> +					str_value,
> +					sizeof(password_data->common.prerequisites[reqs]));
> +
> +				kfree(str_value);
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			password_data->common.security_level = int_value;
> +			break;
> +
> +		case PSWD_MIN_LENGTH:
> +			password_data->min_password_length = int_value;
> +			break;
> +		case PSWD_MAX_LENGTH:
> +			password_data->max_password_length = int_value;
> +			break;
> +		case PSWD_SIZE:
> +			password_data->encodings_size = int_value;
> +			if (int_value > MAX_ENCODINGS_SIZE)
> +				pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
> +
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero. PSWD_ENCODINGS
> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (int_value == 0)
> +				eloc++;
> +			break;
> +
> +		case PSWD_ENCODINGS:
> +			size = password_data->encodings_size;
> +
> +			for (pos_values = 0; pos_values < size && pos_values < MAX_ENCODINGS_SIZE;

Do
	size = min(password_data->encodings_size, MAX_ENCODINGS_SIZE); 
instead of &&. Then put the for () into single line.

> +			     pos_values++) {
> +				ret = convert_hexstr_to_str(password_obj[elem + pos_values].string.pointer,
> +							    password_obj[elem + pos_values].string.length,
> +							    &str_value, &value_len);
> +				if (ret)
> +					break;
> +
> +				strscpy(password_data->encodings[pos_values],
> +					str_value,
> +					sizeof(password_data->encodings[pos_values]));
> +				kfree(str_value);
> +			}
> +			break;
> +		case PSWD_IS_SET:
> +			password_data->is_enabled = int_value;
> +			break;
> +
> +		default:
> +			pr_warn("Invalid element: %d found in Password attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +		kfree(str_value);
> +	}
> +
> +exit_package:
> +	kfree(str_value);

I suspect there are double frees paths in this function.

> +	return 0;
> +}
> +
> +/**
> + * populate_password_buffer_data -
> + * Populate all properties for an instance under password object attribute
> + *
> + * @buffer_ptr: Buffer pointer
> + * @buffer_size: Buffer size
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
> +				  struct kobject *attr_name_kobj)
> +{
> +	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
> +
> +	password_data->attr_name_kobj = attr_name_kobj;
> +
> +	/* Populate Password attributes */
> +	populate_password_elements_from_buffer(buffer_ptr, buffer_size,
> +					       instance_id);
> +	friendly_user_name_update(password_data->common.path,
> +				  attr_name_kobj->name,
> +				  password_data->common.display_name,
> +				  sizeof(password_data->common.display_name));
> +	if (strcmp(attr_name_kobj->name, "Setup Password") == 0)
> +		return sysfs_create_group(attr_name_kobj, &password_attr_group);
> +
> +	return sysfs_create_group(attr_name_kobj, &password_attr_group);
> +}
> +
> +int populate_password_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					   int instance_id)
> +{
> +	int reqs;
> +	int values;
> +	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
> +
> +	// VALUE:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, password_data->current_password,
> +			       sizeof(password_data->current_password));
> +
> +	// PATH:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, password_data->common.path,
> +			       sizeof(password_data->common.path));
> +
> +	// IS_READONLY:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->common.is_readonly);
> +
> +	//DISPLAY_IN_UI:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->common.display_in_ui);
> +
> +	// REQUIRES_PHYSICAL_PRESENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->common.requires_physical_presence);
> +
> +	// SEQUENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->common.sequence);
> +
> +	// PREREQUISITES_SIZE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->common.prerequisites_size);
> +
> +	if (password_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
> +		/* Report a message and limit prerequisite size to maximum value */
> +		pr_warn("Password Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		password_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
> +	}
> +
> +	// PREREQUISITES:
> +	for (reqs = 0;
> +	     reqs < password_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;

MAX_... enforced above.

> +	     reqs++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       password_data->common.prerequisites[reqs],
> +				       sizeof(password_data->common.prerequisites[reqs]));
> +
> +	// SECURITY_LEVEL:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->common.security_level);
> +
> +	// PSWD_MIN_LENGTH:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->min_password_length);
> +
> +	// PSWD_MAX_LENGTH:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->max_password_length);
> +
> +	// PSWD_SIZE:
> +	if (password_data->encodings_size > MAX_ENCODINGS_SIZE) {
> +		/* Report a message and limit possible values size to maximum value */
> +		pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		password_data->encodings_size = MAX_ENCODINGS_SIZE;
> +	}
> +
> +	// PSWD_ENCODINGS:
> +

Extra newline.

> +	for (values = 0;
> +	     values < password_data->encodings_size && values < MAX_VALUES_SIZE;

Hmm... Is the variation here from MAX_ENCODINGS_SIZE (above) -> 
MAX_VALUES_SIZE intentional? They're both 16 anyway.

> +	     values++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       password_data->encodings[values],
> +				       sizeof(password_data->encodings[values]));
> +
> +	// PSWD_IS_SET:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&password_data->is_enabled);
> +
> +	return 0;
> +}
> +
> +/*
> + * exit_password_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + */
> +void exit_password_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < bioscfg_drv.password_instances_count;
> +	     instance_id++) {
> +		struct kobject *attr_name_kobj =
> +			bioscfg_drv.password_data[instance_id].attr_name_kobj;
> +
> +		if (attr_name_kobj) {
> +			if (strcmp(attr_name_kobj->name, SETUP_PASSWD) == 0)
> +				sysfs_remove_group(attr_name_kobj,
> +						   &password_attr_group);
> +			else
> +				sysfs_remove_group(attr_name_kobj,
> +						   &password_attr_group);

Eh, same content in both if and else blocks???? :-)

> +		}
> +	}
> +	bioscfg_drv.password_instances_count = 0;
> +	kfree(bioscfg_drv.password_data);
> +	bioscfg_drv.password_data = NULL;
> +}
> 

-- 
 i.
--8323329-288836710-1683632980=:2036--
