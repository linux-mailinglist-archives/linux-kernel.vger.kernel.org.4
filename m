Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0196FB307
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjEHOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjEHOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:34:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B913A;
        Mon,  8 May 2023 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683556428; x=1715092428;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=jRsaV+h1gXb+6f+CYJ4aOG8WvjJzFSgAewoTJVCxWI4=;
  b=eyLWf2q2LgSUrQBIzC+6XQ4d2ySPxvHq4UtND/MCtRp4KNNUUsY9s9KP
   b3H7J2rwYTvmtfjmRNxuxv1UzIoTDHiSpwOs1jRDdVL7K49yvENDfKBDz
   aPZsbEDOT0nVV/WJi8AhN9UDCDPUmZG77KbwxtHSwE60XcgYeX4F3TJV8
   RpkLBDGZ5YRJdh9w/m/uwOy0fFTgpHoiA4PNAhVBsZUkP/5PoMH3bNPcl
   U2qPfNa1G4hnTULn1sXdL6KSGMqVfFeRpWhBVDChzbFolyEXHctWEg9Tk
   97PCRbma2I8+AFV1jbeppXQV0ovowt3ruQUn+Y5H3O0Xm907I4nez62TO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="352719544"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="352719544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="676078177"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="676078177"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:31:21 -0700
Date:   Mon, 8 May 2023 17:31:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Subject: Re: [PATCH v12 02/13] HP BIOSCFG driver  - biosattr-interface
In-Reply-To: <20230505220043.39036-3-jorge.lopez2@hp.com>
Message-ID: <6c2999ed-4f0-dff0-b62d-e615d69d79c2@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-3-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1180939315-1683554876=:1790"
Content-ID: <54ed7059-c561-9431-8a2d-1e8e1dfe7ed3@linux.intel.com>
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

--8323329-1180939315-1683554876=:1790
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <2b65e82-261-c4c4-dccd-f750a66ee9fb@linux.intel.com>

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
>  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 319 ++++++++++++++++++
>  1 file changed, 319 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> new file mode 100644
> index 000000000000..8f7039a4416a
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to methods under BIOS interface GUID
> + * for use with hp-bioscfg driver.
> + *
> + *  Copyright (c) 2022 Hewlett-Packard Inc.
> + */
> +
> +#include <linux/wmi.h>
> +#include "bioscfg.h"
> +
> +/*
> + * struct bios_args buffer is dynamically allocated.  New WMI command types
> + * were introduced that exceeds 128-byte data size.  Changes to handle
> + * the data size allocation scheme were kept in hp_wmi_perform_query function.
> + */
> +struct bios_args {
> +	u32 signature;
> +	u32 command;
> +	u32 commandtype;
> +	u32 datasize;
> +	u8 data[];
> +};
> +
> +/**
> + * hp_set_attribute
> + *
> + * @a_name: The attribute name
> + * @a_value: The attribute value
> + *
> + * Sets an attribute to new value
> + *
> + * Returns zero on success
> + *      -ENODEV if device is not found
> + *      -EINVAL if the instance of 'Setup Admin' password is not found.
> + *	-ENOMEM unable to allocate memory

Inconsistent indent.

> + */
> +int hp_set_attribute(const char *a_name, const char *a_value)
> +{
> +	size_t security_area_size;
> +	size_t a_name_size, a_value_size;
> +	u16 *buffer = NULL;
> +	u16 *start;
> +	int  buffer_size, instance, ret;
> +	char *auth_token_choice;
> +	u16 *retbuffer;
> +
> +	mutex_lock(&bioscfg_drv.mutex);
> +	if (!bioscfg_drv.bios_attr_wdev) {
> +		ret = -ENODEV;
> +		goto out_set_attribute;
> +	}
> +
> +	instance = get_password_instance_for_type(SETUP_PASSWD);
> +	if (instance < 0) {
> +		ret = -EINVAL;
> +		goto out_set_attribute;
> +	}
> +
> +	/* Select which auth token to use; password or [auth token] */
> +

Remove newline

> +	if (bioscfg_drv.spm_data.auth_token)
> +		auth_token_choice = bioscfg_drv.spm_data.auth_token;
> +	else
> +		auth_token_choice = bioscfg_drv.password_data[instance].current_password;
> +
> +	a_name_size = hp_calculate_string_buffer(a_name);
> +	a_value_size = hp_calculate_string_buffer(a_value);
> +	security_area_size = calculate_security_buffer(auth_token_choice);
> +	buffer_size = a_name_size + a_value_size + security_area_size;
> +
> +	buffer = kmalloc(buffer_size + 1, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out_set_attribute;
> +	}
> +
> +	/* build variables to set */
> +	start = buffer;
> +	retbuffer = hp_ascii_to_utf16_unicode(start, a_name);
> +	if (!retbuffer) {
> +		ret = -EINVAL;
> +		goto out_set_attribute;
> +	}
> +	start = retbuffer;
> +
> +	retbuffer = hp_ascii_to_utf16_unicode(start, a_value);
> +	if (!retbuffer) {
> +		ret = -EINVAL;
> +		goto out_set_attribute;
> +	}
> +	start = retbuffer;
> +
> +	ret = populate_security_buffer(start, auth_token_choice);
> +	if (ret < 0)
> +		goto out_set_attribute;
> +
> +	ret = hp_wmi_set_bios_setting(buffer, buffer_size);
> +
> +out_set_attribute:
> +	kfree(buffer);
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	return ret;
> +}
> +
> +/**
> + * hp_wmi_perform_query
> + *
> + * @query:	The commandtype (enum hp_wmi_commandtype)
> + * @command:	The command (enum hp_wmi_command)
> + * @buffer:	Buffer used as input and/or output
> + * @insize:	Size of input buffer
> + * @outsize:	Size of output buffer
> + *
> + * returns zero on success
> + *         an HP WMI query specific error code (which is positive)
> + *         -EINVAL if the query was not successful at all
> + *         -EINVAL if the output buffer size exceeds buffersize
> + *
> + * Note: The buffersize must at least be the maximum of the input and output
> + *       size. E.g. Battery info query is defined to have 1 byte input
> + *       and 128 byte output. The caller would do:
> + *       buffer = kzalloc(128, GFP_KERNEL);
> + *       ret = hp_wmi_perform_query(HPWMI_BATTERY_QUERY, HPWMI_READ,
> + *				    buffer, 1, 128)
> + */
> +int hp_wmi_perform_query(int query, enum hp_wmi_command command, void *buffer,
> +			 u32 insize, u32 outsize)
> +{
> +	struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct bios_return *bios_return;
> +	union acpi_object *obj = NULL;
> +	struct bios_args *args = NULL;
> +	u32 mid, actual_outsize, ret;
> +	size_t bios_args_size;
> +
> +	mid = encode_outsize_for_pvsz(outsize);
> +	if (WARN_ON(mid < 0))
> +		return mid;
> +
> +	bios_args_size = struct_size(args, data, insize);
> +	args = kmalloc(bios_args_size, GFP_KERNEL);
> +	if (!args)
> +		return -ENOMEM;
> +
> +	input.length = bios_args_size;
> +	input.pointer = args;
> +
> +	/* BIOS expects 'SECU' in hex as the signature value*/
> +	args->signature = 0x55434553;
> +	args->command = command;
> +	args->commandtype = query;
> +	args->datasize = insize;
> +	memcpy(args->data, buffer, flex_array_size(args, data, insize));
> +
> +	ret = wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &output);
> +	hp_wmi_error_and_message(ret);
> +
> +	if (ret)
> +		goto out_free;
> +
> +	obj = output.pointer;
> +	if (!obj) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	if (obj->type != ACPI_TYPE_BUFFER ||
> +	    obj->buffer.length < sizeof(*bios_return)) {
> +		pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	bios_return = (struct bios_return *)obj->buffer.pointer;
> +	ret = bios_return->return_code;
> +	hp_wmi_error_and_message(ret);
> +
> +	if (ret) {
> +		if (ret != INVALID_CMD_VALUE &&
> +		    ret != INVALID_CMD_TYPE)

To the same line.

> +			pr_warn("query 0x%x returned error 0x%x\n", query, ret);
> +		goto out_free;
> +	}
> +
> +	/* Ignore output data of zero size */
> +	if (!outsize)
> +		goto out_free;
> +
> +	actual_outsize = min(outsize, (u32)(obj->buffer.length - sizeof(*bios_return)));

Use min_t() instead of casting.

> +	memcpy_and_pad(buffer, outsize, obj->buffer.pointer + sizeof(*bios_return),
> +		       actual_outsize, 0);
> +
> +out_free:
> +	kfree(obj);
> +	kfree(args);
> +	return ret;
> +}
> +
> +static void *utf16_empty_string(u16 *p)
> +{
> +	*p++ = 2;
> +	*p++ = (u8)0x00;

Useless and non-sensical cast.

> +	return p;
> +}
> +
> +/**
> + * hp_ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
> + *
> + * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
> + * multi-byte language supported.
> + *
> + * @p:   Unicode buffer address
> + * @str: string to convert to unicode
> + *
> + * Returns a void pointer to the buffer string
> + */
> +void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str)
> +{
> +	int len = strlen(str);
> +	int ret;
> +
> +	/*
> +	 * Add null character when reading an empty string
> +	 * "02 00 00 00"
> +	 */
> +	if (len == 0)
> +		return utf16_empty_string(p);
> +
> +	/* Move pointer len * 2 number of bytes */
> +	*p++ = len * 2;

The comment sounds odd given the code context here.

> +	ret = utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, p, len);

Why is strlen(str) recalculated here?

> +	if (ret < 0) {
> +		dev_err(bioscfg_drv.class_dev, "UTF16 conversion failed\n");
> +		return NULL;
> +	}
> +
> +	if ((ret * sizeof(u16)) > U16_MAX) {

Unnecessary parenthesis.

> +		dev_err(bioscfg_drv.class_dev, "Error string too long\n");
> +		return NULL;
> +	}
> +
> +	p += len;

Is this correct ?

> +	return p;
> +}
> +
> +/**
> + * hp_wmi_set_bios_setting - Set setting's value in BIOS
> + *
> + * @input_buffer: Input buffer address
> + * @input_size:   Input buffer size
> + *
> + * Returns: Count of unicode characters written to BIOS if successful, otherwise
> + *		-ENOMEM unable to allocate memory
> + *		-EINVAL buffer not allocated or too small
> + */
> +int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size)
> +{
> +	union acpi_object *obj;
> +	struct acpi_buffer input = {input_size, input_buffer};
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int ret;
> +
> +	ret = wmi_evaluate_method(HP_WMI_SET_BIOS_SETTING_GUID, 0, 1, &input, &output);
> +
> +	obj = output.pointer;
> +	if (!obj)
> +		return -EINVAL;
> +
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		ret = -EINVAL;

Missing goto?

> +
> +	ret = obj->integer.value;
> +	hp_wmi_error_and_message(ret);
> +
> +	kfree(obj);
> +	return ret;
> +}


-- 
 i.


> +
> +static int hp_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	mutex_lock(&bioscfg_drv.mutex);
> +	bioscfg_drv.bios_attr_wdev = wdev;
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	return 0;
> +}
> +
> +static void hp_attr_set_interface_remove(struct wmi_device *wdev)
> +{
> +	mutex_lock(&bioscfg_drv.mutex);
> +	bioscfg_drv.bios_attr_wdev = NULL;
> +	mutex_unlock(&bioscfg_drv.mutex);
> +}
> +
> +static const struct wmi_device_id hp_attr_set_interface_id_table[] = {
> +	{ .guid_string = HP_WMI_BIOS_GUID},
> +	{ }
> +};
> +
> +static struct wmi_driver hp_attr_set_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +	},
> +	.probe = hp_attr_set_interface_probe,
> +	.remove = hp_attr_set_interface_remove,
> +	.id_table = hp_attr_set_interface_id_table,
> +};
> +
> +int init_hp_attr_set_interface(void)
> +{
> +	return wmi_driver_register(&hp_attr_set_interface_driver);
> +}
> +
> +void exit_hp_attr_set_interface(void)
> +{
> +	wmi_driver_unregister(&hp_attr_set_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, hp_attr_set_interface_id_table);
> 
--8323329-1180939315-1683554876=:1790--
