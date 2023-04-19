Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8B6E80D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjDSSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDSSEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:04:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82161AB;
        Wed, 19 Apr 2023 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681927460; i=w_armin@gmx.de;
        bh=s31tlhn+adOeQNX5rlS1NmG7Ecz5eQ9xfoT5GvVdCVM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JIqozK9pXNAydhjEglPPzSTfkgqeWN0qFadZ/rgDyRK6DJ+tnkHjJThVW9dja4ndB
         BUQLe9cmqM5kCm7Hzfm3dJxZ41m38mzH2aW+IN9qd6EnxP7t1IuhU3+9K2Y4RwoFXE
         lVpw6506ZXe5JX4TSRzJmQRECiTJB6z7QV8ZBdPl3hKsQJ+i1xND+9BjVSH6z+0oMO
         jsHtqRRciVnuo+PzMFo/TiKgxR6sTsvMoSOUjiT+z5Bm9MntzNC55t6zKXaV441fpj
         RX+avksbr1HMn87ThiE15Wpey1R7rhmjbumuUc+iI5KDlS0UKDXmlF4we4G2n0Rehm
         9VnwuDAuMuo4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1pqZ4j1mU9-001V8U; Wed, 19
 Apr 2023 20:04:20 +0200
Subject: Re: [PATCH v10 03/14] HP BIOSCFG driver - bioscfg
To:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
 <20230419151321.6167-4-jorge.lopez2@hp.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <38929a45-79de-964b-5d6f-cfa44099b35e@gmx.de>
Date:   Wed, 19 Apr 2023 20:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230419151321.6167-4-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:EYzgO9qNrffImKnajcVvt2cWuhqN/oImzhJHLF+R7hEprG6XhCX
 +2X4pHMAb6osLHScmSuq2e7dt8AlZh/FQ5H5ltIXGaBYUCsRAXnsNFBdSBCNHByAmJ2z6QQ
 Zukxd70csxfIqC91ysApKPGKype9LVw59teIk+eOlvl4tkMhWuJm5CuH9P3yESK2v1UZxWB
 vw8LpTKDK8AsAGmICQsMA==
UI-OutboundReport: notjunk:1;M01:P0:8rYJwMdF3kk=;IiCgdxBSmir4f+xLbQvrIfzInP+
 owuoiFNdKCvoR1EF4+oYtfluAqQS7LjsQPUvgliR03AOzYUEaTIUJ5OrAGwlemmNWWCSAsNWr
 xr4C5o16hvh/3c4m+sv7AAwk7SWsy7JcV2gnTOUeHrW14Z1kaB0ePQHbWNn6z8LI5V93FG+JB
 TFjluYasDsaNY2Bfo3TJcYMpUJkTaulb0SnVQ9flD8KjF+sgfrawFIFIl9Pp4PmyA90yStiF5
 IxRyP7SBLIEIrdTIjfnsIg6AoUq8TJhwSr1MfvDhElNmrq4bR/CRdh9nv0ZORMwQU6Qu7Qktd
 +lZCg1p1odW97wkl4F4ZdaBxFNBBxvcv5IRqfssDZ8/FHmPPXZw1PrJgnyH2OXXuTxkhrWuwx
 fyyujBefSOuNPg2WcBKFnU6FrA/wG7OBHXdVJx9TkKBYw4wdiuHgXXoVOPOJ3BWs7zlrmTAnb
 M8oVPZ4rRs2TZHoC9yii0SZU/n/dUyqs1djWBtHgqBqkE0WCKIC7DZo01V4gnDnmxJLuj+dTN
 gND32vN9W0MZa4FI3ZBkX+Kyo4c7+dFfBo3Jqk4+KCnub4TCvMA4X78lN/OmPqCdOFNLuU/Ma
 PAIrcFRcgHPcT7ubp2uCxfTGqAosp0EzWUlZj4wY1o1oh3XDkbj4MBnUzJph8F8RoJklrk6qu
 S6sw/V3OUmnaGjidF4h3SVI+ZOxkX5xBX1O7KMZP00BgtsxAttVjC7hy6eQad9KINWeLc2JiZ
 m/RvN9l541eNOCjc7dyZEyoF3dNrFUztNyBldMP0KAi+CQzImZs+bdruSkDNE1eJwlzG+9Oxc
 eWLVTRKYEiWO/gBX/HDBPmSCHOkLOgIGCsT1dwX9+y8/AkqRd/g3PbOeY5wB1tl1wL9hVxQEa
 JCJQ6juMDErFE0xb1sAKpH9R6icVKGSXoPTk11C8qj6lQQzdWGyLyVAnSRSWlXh2LfEzxpI4m
 qTKHwES6MP+3Ab8bKUD+eCSRheQ=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.04.23 um 17:13 schrieb Jorge Lopez:

> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.=E2=80=99s comm=
ercial
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
>   drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 961 +++++++++++++++++++
>   1 file changed, 961 insertions(+)
>   create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/plat=
form/x86/hp/hp-bioscfg/bioscfg.c
> new file mode 100644
> index 000000000000..4b0d4f56e65f
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -0,0 +1,961 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common methods for use with hp-bioscfg driver
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/wmi.h>
> +#include "bioscfg.h"
> +#include "../../firmware_attributes_class.h"
> +#include <linux/nls.h>
> +#include <linux/errno.h>
> +
> +MODULE_AUTHOR("Jorge Lopez <jorge.lopez2@hp.com>");
> +MODULE_DESCRIPTION("HP BIOS Configuration Driver");
> +MODULE_LICENSE("GPL");
> +
> +struct bioscfg_priv bioscfg_drv =3D {
> +	.mutex =3D __MUTEX_INITIALIZER(bioscfg_drv.mutex),
> +};
> +
> +static struct class *fw_attr_class;
> +
> +int get_integer_from_buffer(int **buffer, u32 *buffer_size, int *intege=
r)
> +{
> +	int *ptr =3D PTR_ALIGN(*buffer, 4);
> +
> +	/* Ensure there is enough space remaining to read the integer */
> +	if (*buffer_size < sizeof(int))
> +		return -EINVAL;
> +
> +	*integer =3D *(ptr++);
> +	*buffer =3D ptr;
> +	*buffer_size -=3D sizeof(int);
> +
> +	return 0;
> +}
> +
> +
> +int get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u3=
2 dst_size)
> +{
> +	u16 *src =3D (u16 *)*buffer;
> +	u16 src_size;
> +
> +	u16 size;
> +	int i;
> +	int escape =3D 0;
> +	int conv_dst_size;
> +
> +	if (*buffer_size < sizeof(u16))
> +		return -EINVAL;
> +
> +	src_size =3D *(src++);
> +	/* size value in u16 chars */
> +	size =3D src_size / sizeof(u16);
> +
> +	/* Ensure there is enough space remaining to read and convert
> +	 * the string
> +	 */
> +	if (*buffer_size < src_size)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < size; i++)
> +		if (src[i] =3D=3D '\\' ||
> +		    src[i] =3D=3D '\r' ||
> +		    src[i] =3D=3D '\n' ||
> +		    src[i] =3D=3D '\t')
> +			escape++;
> +
> +	size +=3D escape;
> +
> +	/*
> +	 * Conversion is limited to destination string max number of
> +	 * bytes.
> +	 */
> +	conv_dst_size =3D size;
> +	if (size > dst_size)
> +		conv_dst_size =3D dst_size - 1;
> +
> +	/*
> +	 * convert from UTF-16 unicode to ASCII
> +	 */
> +	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
> +	dst[conv_dst_size] =3D 0;
> +
> +	for (i =3D 0; i < size && i < conv_dst_size; i++) {
> +		if (*src =3D=3D '\\' ||
> +		    *src =3D=3D '\r' ||
> +		    *src =3D=3D '\n' ||
> +		    *src =3D=3D '\t')
> +			dst[i++] =3D '\\';
> +
> +		if (*src =3D=3D '\r')
> +			dst[i] =3D 'r';
> +		else if (*src =3D=3D '\n')
> +			dst[i] =3D 'n';
> +		else if (*src =3D=3D '\t')
> +			dst[i] =3D 't';
> +		else if (*src =3D=3D '"')
> +			dst[i] =3D '\'';
> +		else
> +			dst[i] =3D *src;
> +		src++;
> +	}
> +
> +	*buffer =3D (u8 *)src;
> +	*buffer_size -=3D size * sizeof(u16);
> +
> +	return size;
> +}
> +
> +
> +/*
> + * calculate_string_buffer() - determines size of string buffer for use=
 with BIOS communication
> + * @str: the string to calculate based upon
> + */
> +size_t bioscfg_calculate_string_buffer(const char *str)
> +{
> +	int length =3D strlen(str);
> +	int size;
> +
> +	/* BIOS expects 4 bytes when an empty string is found */
> +	if (!length)
> +		length =3D 1;
> +
> +	/* u16 length field + one UTF16 char for each input char */
> +	size =3D sizeof(u16) + length * sizeof(u16);
> +
> +	return size;
> +}
> +
> +int bioscfg_wmi_error_and_message(int error_code)
> +{
> +	char *error_msg =3D NULL;
> +	int ret;
> +
> +	switch (error_code) {
> +	case SUCCESS:
> +		error_msg =3D "Success";
> +		ret =3D 0;
> +		break;
> +	case CMD_FAILED:
> +		error_msg =3D "Command failed";
> +		ret =3D -EINVAL;
> +		break;
> +	case INVALID_SIGN:
> +		error_msg =3D "Invalid signature";
> +		ret =3D -EINVAL;
> +		break;
> +	case INVALID_CMD_VALUE:
> +		error_msg =3D "Invalid command value/Feature not supported";
> +		ret =3D -EOPNOTSUPP;
> +		break;
> +	case INVALID_CMD_TYPE:
> +		error_msg =3D "Invalid command type";
> +		ret =3D -EINVAL;
> +		break;
> +	case INVALID_DATA_SIZE:
> +		error_msg =3D "Invalid data size";
> +		ret =3D -EINVAL;
> +		break;
> +	case INVALID_CMD_PARAM:
> +		error_msg =3D "Invalid command parameter";
> +		ret =3D -EINVAL;
> +		break;
> +	case ENCRYP_CMD_REQUIRED:
> +		error_msg =3D "Secure/encrypted command required";
> +		ret =3D -EACCES;
> +		break;
> +	case NO_SECURE_SESSION:
> +		error_msg =3D "No secure session established";
> +		ret =3D -EACCES;
> +		break;
> +	case SECURE_SESSION_FOUND:
> +		error_msg =3D "Secure session already established";
> +		ret =3D -EACCES;
> +		break;
> +	case SECURE_SESSION_FAILED:
> +		error_msg =3D "Secure session failed";
> +		ret =3D -EIO;
> +		break;
> +	case AUTH_FAILED:
> +		error_msg =3D "Other permission/Authentication failed";
> +		ret =3D -EACCES;
> +		break;
> +	case INVALID_BIOS_AUTH:
> +		error_msg =3D "Invalid BIOS administrator password";
> +		ret =3D -EINVAL;
> +		break;
> +	case NONCE_DID_NOT_MATCH:
> +		error_msg =3D "Nonce did not match";
> +		ret =3D -EINVAL;
> +		break;
> +	case GENERIC_ERROR:
> +		error_msg =3D "Generic/Other error";
> +		ret =3D -EIO;
> +		break;
> +	case BIOS_ADMIN_POLICY_NOT_MET:
> +		error_msg =3D "BIOS Admin password does not meet password policy requ=
irements";
> +		ret =3D -EINVAL;
> +		break;
> +	case BIOS_ADMIN_NOT_SET:
> +		error_msg =3D "BIOS Setup password is not set.";
> +		ret =3D -EPERM;
> +		break;
> +	case P21_NO_PROVISIONED:
> +		error_msg =3D "P21 is not provisioned";
> +		ret =3D -EPERM;
> +		break;
> +	case P21_PROVISION_IN_PROGRESS:
> +		error_msg =3D "P21 is already provisioned or provisioning is in progr=
ess and a signing key has already been sent.";
> +		ret =3D -EINPROGRESS;
> +		break;
> +	case P21_IN_USE:
> +		error_msg =3D "P21 in use (cannot deprovision)";
> +		ret =3D -EPERM;
> +		break;
> +	case HEP_NOT_ACTIVE:
> +		error_msg =3D "HEP not activated";
> +		ret =3D -EPERM;
> +		break;
> +	case HEP_ALREADY_SET:
> +		error_msg =3D "HEP Transport already set";
> +		ret =3D -EINVAL;
> +		break;
> +	case HEP_CHECK_STATE:
> +		error_msg =3D "Check the current HEP state";
> +		ret =3D -EINVAL;
> +		break;
> +	default:
> +		error_msg =3D "Generic/Other error";
> +		ret =3D -EIO;
> +		break;
> +	}
> +
> +	if (error_code)
> +		pr_warn_ratelimited("Returned error 0x%x, \"%s\"\n", error_code, erro=
r_msg);
> +
> +	return ret;
> +}
> +
> +
> +/*
> + * pending_reboot_show() - sysfs implementaton for read pending_reboot
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer to display to userspace
> + *
> + * Stores default value as 0
> + * When current_value is changed this attribute is set to 1 to notify r=
eboot may be required
> + */
> +static ssize_t pending_reboot_show(struct kobject *kobj,
> +				   struct kobj_attribute *attr,
> +				   char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bioscfg_drv.pending_reboot);
> +}
> +static struct kobj_attribute pending_reboot =3D __ATTR_RO(pending_reboo=
t);
> +
> +/*
> + * create_attributes_level_sysfs_files() - Creates pending_reboot attri=
butes
> + */
> +static int create_attributes_level_sysfs_files(void)
> +{
> +	int ret;
> +
> +	ret =3D sysfs_create_file(&bioscfg_drv.main_dir_kset->kobj, &pending_r=
eboot.attr);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +
> +static void attr_name_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
> +static const struct kobj_type attr_name_ktype =3D {
> +	.release	=3D attr_name_release,
> +	.sysfs_ops	=3D &kobj_sysfs_ops,
> +};
> +
> +/*
> + * get_wmiobj_pointer() - Get Content of WMI block for particular insta=
nce
> + *
> + * @instance_id: WMI instance ID
> + * @guid_string: WMI GUID (in str form)
> + *
> + * Fetches the content for WMI block (instance_id) under GUID (guid_str=
ing)
> + * Caller must kfree the return
> + */
> +union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid=
_string)
> +{
> +	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +
> +	status =3D wmi_query_block(guid_string, instance_id, &out);
> +	return ACPI_SUCCESS(status) ? (union acpi_object *)out.pointer : NULL;
> +}
> +
> +/*
> + * get_instance_count() - Compute total number of instances under guid_=
string
> + *
> + * @guid_string: WMI GUID (in string form)
> + */
> +int get_instance_count(const char *guid_string)
> +{
> +	union acpi_object *wmi_obj =3D NULL;
> +	int i =3D 0;
> +
> +	do {
> +		kfree(wmi_obj);
> +		wmi_obj =3D get_wmiobj_pointer(i, guid_string);
> +		i++;
> +	} while (wmi_obj);
> +

Hi,

the instance count of a WMI object is already known to the WMI driver core=
,
see drivers/platform/x86/wmi.c (struct guid_block). Unfortunately, there i=
s currently
no way for WMI drivers to access this information.
Maybe you can implement such a function instead?

> +	return i-1;
> +}
> +
> +/*
> + * alloc_attributes_data() - Allocate attributes data for a particular =
type
> + *
> + * @attr_type: Attribute type to allocate
> + */
> +static int alloc_attributes_data(int attr_type)
> +{
> +	int retval =3D 0;
> +
> +	switch (attr_type) {
> +	case HPWMI_STRING_TYPE:
> +		retval =3D alloc_string_data();
> +		break;
> +	case HPWMI_INTEGER_TYPE:
> +		retval =3D alloc_integer_data();
> +		break;
> +	case HPWMI_ENUMERATION_TYPE:
> +		retval =3D alloc_enumeration_data();
> +		break;
> +	case HPWMI_ORDERED_LIST_TYPE:
> +		retval =3D alloc_ordered_list_data();
> +		break;
> +	case HPWMI_PASSWORD_TYPE:
> +		retval =3D alloc_password_data();
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return retval;
> +}
> +
> +int convert_hexstr_to_str(const char *input, u32 input_len, char **str,=
 int *len)
> +{
> +	int ret =3D 0;
> +	int new_len =3D 0;
> +	char tmp[] =3D "0x00";
> +	char *new_str =3D NULL;
> +	long  ch;
> +	int i;
> +
> +	if (input_len <=3D 0 || input =3D=3D NULL || str =3D=3D NULL || len =
=3D=3D NULL)
> +		return -EINVAL;
> +
> +	*len =3D 0;
> +	*str =3D NULL;
> +
> +	new_str =3D kmalloc(input_len, GFP_KERNEL);
> +	if (!new_str)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < input_len; i +=3D 5) {
> +		strncpy(tmp, input + i, strlen(tmp));
> +		if (kstrtol(tmp, 16, &ch) =3D=3D 0) {
> +			// escape char
> +			if (ch =3D=3D '\\' || ch =3D=3D '\r' || ch =3D=3D '\n' || ch =3D=3D =
'\t') {
> +				if (ch =3D=3D '\r')
> +					ch =3D 'r';
> +				else if (ch =3D=3D '\n')
> +					ch =3D 'n';
> +				else if (ch =3D=3D '\t')
> +					ch =3D 't';
> +				new_str[new_len++] =3D '\\';
> +			}
> +			new_str[new_len++] =3D ch;
> +			if (ch =3D=3D '\0')
> +				break;
> +		}
> +	}
> +
> +	if (new_len) {
> +		new_str[new_len] =3D '\0';
> +		*str =3D krealloc(new_str, (new_len + 1) * sizeof(char), GFP_KERNEL);
> +		if (*str)
> +			*len =3D new_len;
> +		else
> +			ret =3D -ENOMEM;
> +	} else {
> +		ret =3D -EFAULT;
> +	}
> +
> +	if (ret)
> +		kfree(new_str);
> +	return ret;
> +}
> +
> +/* map output size to the corresponding WMI method id */
> +int encode_outsize_for_pvsz(int outsize)
> +{
> +	if (outsize > 4096)
> +		return -EINVAL;
> +	if (outsize > 1024)
> +		return 5;
> +	if (outsize > 128)
> +		return 4;
> +	if (outsize > 4)
> +		return 3;
> +	if (outsize > 0)
> +		return 2;
> +	return 1;
> +}
> +
> +/*
> + * Update friendly display name for several attributes associated to
> + * 'Schedule Power-On'
> + */
> +void friendly_user_name_update(char *path, const char *attr_name,
> +			       char *attr_display, int attr_size)
> +{
> +	char *found =3D NULL;
> +
> +	found =3D strstr(path, SCHEDULE_POWER_ON);
> +	if (found)
> +		snprintf(attr_display,
> +			 attr_size,
> +			 "%s - %s",
> +			 SCHEDULE_POWER_ON,
> +			 attr_name);
> +	else
> +		strscpy(attr_display, attr_name, attr_size);
> +}
> +
> +/*
> + * update_attribute_permissions() - Update attributes permissions when
> + * isReadOnly value is 1
> + *
> + * @isReadOnly:  ReadOnly value
> + * @current_val: kobj_attribute corresponding to attribute.
> + *
> + */
> +void update_attribute_permissions(u32 isReadOnly, struct kobj_attribute=
 *current_val)
> +{
> +	if (isReadOnly)
> +		current_val->attr.mode =3D (umode_t)0444;
> +	else
> +		current_val->attr.mode =3D (umode_t)0644;
> +}
> +
> +
> +/**
> + * destroy_attribute_objs() - Free a kset of kobjects
> + * @kset: The kset to destroy
> + *
> + * Fress kobjects created for each attribute_name under attribute type =
kset
> + */
> +static void destroy_attribute_objs(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	list_for_each_entry_safe(pos, next, &kset->list, entry)
> +		kobject_put(pos);
> +}
> +
> +/**
> + * release_attributes_data() - Clean-up all sysfs directories and files=
 created
> + */
> +static void release_attributes_data(void)
> +{
> +	mutex_lock(&bioscfg_drv.mutex);
> +
> +	exit_string_attributes();
> +	exit_integer_attributes();
> +	exit_enumeration_attributes();
> +	exit_ordered_list_attributes();
> +	exit_password_attributes();
> +	exit_sure_start_attributes();
> +	exit_secure_platform_attributes();
> +
> +	if (bioscfg_drv.authentication_dir_kset) {
> +		destroy_attribute_objs(bioscfg_drv.authentication_dir_kset);
> +		kset_unregister(bioscfg_drv.authentication_dir_kset);
> +		bioscfg_drv.authentication_dir_kset =3D NULL;
> +	}
> +	if (bioscfg_drv.main_dir_kset) {
> +		sysfs_remove_file(&bioscfg_drv.main_dir_kset->kobj, &pending_reboot.a=
ttr);
> +		destroy_attribute_objs(bioscfg_drv.main_dir_kset);
> +		kset_unregister(bioscfg_drv.main_dir_kset);
> +		bioscfg_drv.main_dir_kset =3D NULL;
> +	}
> +	mutex_unlock(&bioscfg_drv.mutex);
> +}
> +
> +
> +/*
> + * hp_add_other_attributes - Initialize HP custom attributes not report=
ed by
> + * BIOS and required to support Secure Platform, Sure Start, and Sure
> + * Admin.
> + * @attr_type: Custom HP attribute not reported by BIOS
> + *
> + * Initialiaze all 3 types of attributes: Platform, Sure Start, and Sur=
e
> + * Admin object.  Populates each attrbute types respective properties
> + * under sysfs files.
> + *
> + * Returns zero(0) if successful.  Otherwise, a negative value.
> + */
> +static int hp_add_other_attributes(int attr_type)
> +{
> +	struct kobject *attr_name_kobj;
> +	union acpi_object *obj =3D NULL;
> +	int retval =3D 0;
> +	u8 *attr_name;
> +
> +	mutex_lock(&bioscfg_drv.mutex);
> +
> +	attr_name_kobj =3D kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> +	if (!attr_name_kobj) {
> +		retval =3D -ENOMEM;
> +		goto err_other_attr_init;
> +	}
> +
> +	/* Check if attribute type is supported */
> +	switch (attr_type) {
> +	case HPWMI_SECURE_PLATFORM_TYPE:
> +		attr_name_kobj->kset =3D bioscfg_drv.authentication_dir_kset;
> +		attr_name =3D SPM_STR;
> +		break;
> +
> +	case HPWMI_SURE_START_TYPE:
> +		attr_name_kobj->kset =3D bioscfg_drv.main_dir_kset;
> +		attr_name =3D SURE_START_STR;
> +		break;
> +
> +	default:
> +		pr_err("Error: Unknown attr_type: %d\n", attr_type);
> +		retval =3D -EINVAL;
> +		goto err_other_attr_init;
> +	}
> +
> +	retval =3D kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
> +				      NULL, "%s", attr_name);
> +	if (retval) {
> +		pr_err("Error encountered [%d]\n", retval);
> +		kobject_put(attr_name_kobj);
> +		goto err_other_attr_init;
> +	}
> +
> +	/* Populate attribute data */
> +	switch (attr_type) {
> +	case HPWMI_SECURE_PLATFORM_TYPE:
> +		retval =3D populate_secure_platform_data(attr_name_kobj);
> +		break;
> +
> +	case HPWMI_SURE_START_TYPE:
> +		retval =3D populate_sure_start_data(attr_name_kobj);
> +		break;
> +
> +	default:
> +		goto err_other_attr_init;
> +	}
> +
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	return 0;
> +
> +err_other_attr_init:
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	kfree(obj);
> +	return retval;
> +}
> +
> +/*
> + * hp_init_bios_attributes - Initialize all attributes for a type
> + * @attr_type: The attribute type to initialize
> + * @guid: The WMI GUID associated with this type to initialize
> + *
> + * Initialiaze all 5 types of attributes: enumeration, integer,
> + * string, password, ordered list  object.  Populates each attrbute typ=
es
> + * respective properties under sysfs files
> + */
> +static int hp_init_bios_attributes(int attr_type, const char *guid)
> +{
> +	struct kobject *attr_name_kobj;
> +	union acpi_object *obj =3D NULL;
> +	union acpi_object *elements;
> +	struct kset *tmp_set;
> +	int min_elements;
> +	char str[MAX_BUFF];
> +
> +	char *temp_str =3D NULL;
> +	char *str_value =3D NULL;
> +	int str_len;
> +	int ret =3D 0;
> +
> +	u8 *buffer_ptr =3D NULL;
> +	int buffer_size;
> +
> +
> +	/* instance_id needs to be reset for each type GUID
> +	 * also, instance IDs are unique within GUID but not across
> +	 */
> +	int instance_id =3D 0;
> +	int retval =3D 0;
> +
> +	retval =3D alloc_attributes_data(attr_type);
> +	if (retval)
> +		return retval;
> +
> +	switch (attr_type) {
> +	case HPWMI_STRING_TYPE:
> +		min_elements =3D 12;
> +		break;
> +	case HPWMI_INTEGER_TYPE:
> +		min_elements =3D 13;
> +		break;
> +	case HPWMI_ENUMERATION_TYPE:
> +		min_elements =3D 13;
> +		break;
> +	case HPWMI_ORDERED_LIST_TYPE:
> +		min_elements =3D 12;
> +		break;
> +	case HPWMI_PASSWORD_TYPE:
> +		min_elements =3D 15;
> +		break;
> +	default:
> +		pr_err("Error: Unknown attr_type: %d\n", attr_type);
> +		return -EINVAL;
> +	}
> +
> +	/* need to use specific instance_id and guid combination to get right =
data */
> +	obj =3D get_wmiobj_pointer(instance_id, guid);
> +	if (!obj)
> +		return -ENODEV;
> +
> +	mutex_lock(&bioscfg_drv.mutex);
> +	while (obj) {
> +		if (obj->type !=3D ACPI_TYPE_PACKAGE && obj->type !=3D ACPI_TYPE_BUFF=
ER) {
> +			pr_err("Error: Expected ACPI-package or buffer type, got: %d\n", obj=
->type);
> +			retval =3D -EIO;
> +			goto err_attr_init;
> +		}
> +
> +		/* Take action appropriate to each ACPI TYPE */
> +		if (obj->type =3D=3D ACPI_TYPE_PACKAGE) {
> +			if (obj->package.count < min_elements) {
> +				pr_err("ACPI-package does not have enough elements: %d < %d\n",
> +				       obj->package.count, min_elements);
> +				goto nextobj;
> +			}
> +
> +			elements =3D obj->package.elements;
> +
> +			/* sanity checking */
> +			if (elements[NAME].type !=3D ACPI_TYPE_STRING) {
> +				pr_debug("incorrect element type\n");
> +				goto nextobj;
> +			}
> +			if (strlen(elements[NAME].string.pointer) =3D=3D 0) {
> +				pr_debug("empty attribute found\n");
> +				goto nextobj;
> +			}
> +
> +			if (attr_type =3D=3D HPWMI_PASSWORD_TYPE)
> +				tmp_set =3D bioscfg_drv.authentication_dir_kset;
> +			else
> +				tmp_set =3D bioscfg_drv.main_dir_kset;
> +
> +			/* convert attribute name to string */
> +			retval =3D convert_hexstr_to_str(elements[NAME].string.pointer,
> +						       elements[NAME].string.length,
> +						       &str_value, &str_len);
> +
> +			if (retval) {
> +				pr_debug("Failed to populate integer package data. Error [0%0x]\n",=
 ret);
> +				kfree(str_value);
> +				return ret;
> +			}
> +
> +			if (kset_find_obj(tmp_set, str_value)) {
> +				pr_debug("Duplicate attribute name found - %s\n",
> +					 str_value);
> +				goto nextobj;
> +			}
> +
> +			/* build attribute */
> +			attr_name_kobj =3D kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> +			if (!attr_name_kobj) {
> +				retval =3D -ENOMEM;
> +				goto err_attr_init;
> +			}
> +
> +			attr_name_kobj->kset =3D tmp_set;
> +
> +			retval =3D kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
> +						      NULL, "%s", str_value);
> +
> +			if (retval) {
> +				kobject_put(attr_name_kobj);
> +				goto err_attr_init;
> +			}
> +
> +			/* enumerate all of these attributes */
> +			switch (attr_type) {
> +			case HPWMI_STRING_TYPE:
> +				retval =3D populate_string_package_data(elements,
> +								      instance_id,
> +								      attr_name_kobj);
> +				break;
> +			case HPWMI_INTEGER_TYPE:
> +				retval =3D populate_integer_package_data(elements,
> +								       instance_id,
> +								       attr_name_kobj);
> +				break;
> +			case HPWMI_ENUMERATION_TYPE:
> +				retval =3D populate_enumeration_package_data(elements,
> +									   instance_id,
> +									   attr_name_kobj);
> +				break;
> +			case HPWMI_ORDERED_LIST_TYPE:
> +				retval =3D populate_ordered_list_package_data(elements,
> +									    instance_id,
> +									    attr_name_kobj);
> +				break;
> +			case HPWMI_PASSWORD_TYPE:
> +				retval =3D populate_password_package_data(elements,
> +									instance_id,
> +									attr_name_kobj);
> +				break;
> +			default:
> +				break;
> +			}
> +
> +			kfree(str_value);
> +		}
> +
> +		if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
> +
> +			buffer_size =3D obj->buffer.length;
> +			buffer_ptr =3D obj->buffer.pointer;
> +
> +			retval =3D get_string_from_buffer(&buffer_ptr, &buffer_size, str, MA=
X_BUFF);
> +			if (retval < 0)
> +				goto err_attr_init;
> +
> +			if (attr_type =3D=3D HPWMI_PASSWORD_TYPE || attr_type =3D=3D HPWMI_S=
ECURE_PLATFORM_TYPE)
> +				tmp_set =3D bioscfg_drv.authentication_dir_kset;
> +			else
> +				tmp_set =3D bioscfg_drv.main_dir_kset;
> +
> +			if (kset_find_obj(tmp_set, str)) {
> +				pr_warn("Duplicate attribute name found - %s\n", str);
> +				goto nextobj;
> +			}
> +
> +			/* build attribute */
> +			attr_name_kobj =3D kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> +			if (!attr_name_kobj) {
> +				retval =3D -ENOMEM;
> +				goto err_attr_init;
> +			}
> +
> +			attr_name_kobj->kset =3D tmp_set;
> +
> +			temp_str =3D str;
> +			if (attr_type =3D=3D HPWMI_SECURE_PLATFORM_TYPE)
> +				temp_str =3D "SPM";
> +
> +			retval =3D kobject_init_and_add(attr_name_kobj,
> +						      &attr_name_ktype, NULL, "%s",
> +						      temp_str);
> +			if (retval) {
> +				kobject_put(attr_name_kobj);
> +				goto err_attr_init;
> +			}
> +
> +			/* enumerate all of these attributes */
> +			switch (attr_type) {
> +			case HPWMI_STRING_TYPE:
> +				retval =3D populate_string_buffer_data(buffer_ptr,
> +								     &buffer_size,
> +								     instance_id,
> +								     attr_name_kobj);
> +				break;
> +			case HPWMI_INTEGER_TYPE:
> +				retval =3D populate_integer_buffer_data(buffer_ptr,
> +								      &buffer_size,
> +								      instance_id,
> +								      attr_name_kobj);
> +				break;
> +			case HPWMI_ENUMERATION_TYPE:
> +				retval =3D populate_enumeration_buffer_data(buffer_ptr,
> +									  &buffer_size,
> +									  instance_id,
> +									  attr_name_kobj);
> +				break;
> +			case HPWMI_ORDERED_LIST_TYPE:
> +				retval =3D populate_ordered_list_buffer_data(buffer_ptr,
> +									   &buffer_size,
> +									   instance_id,
> +									   attr_name_kobj);
> +				break;
> +			case HPWMI_PASSWORD_TYPE:
> +				retval =3D populate_password_buffer_data(buffer_ptr,
> +								       &buffer_size,
> +								       instance_id,
> +								       attr_name_kobj);
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +nextobj:
> +		kfree(str_value);
> +		kfree(obj);
> +		instance_id++;
> +		obj =3D get_wmiobj_pointer(instance_id, guid);
> +	}
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	return 0;
> +
> +err_attr_init:
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	kfree(obj);
> +	return retval;
> +}
> +
> +static int __init bioscfg_init(void)
> +{
> +	int ret =3D 0;
> +	int bios_capable =3D wmi_has_guid(HP_WMI_BIOS_GUID);
> +
> +	if (!bios_capable) {
> +		pr_err("Unable to run on non-HP system\n");
> +		return -ENODEV;
> +	}
> +

Currently, this driver will no get automatically loaded on supported hardw=
are,
something which would be quite beneficial for users to have.
Since the HP_WMI_BIOS_GUID is already handled by the hp-wmi driver, maybe =
this
driver (which also already implements a function similar to hp_wmi_perform=
_query())
could register a platform device which is then used by this driver? This t=
ogether
with MODULE_DEVICE_TABLE() would allow for automatically loading the modul=
e on supported hardware.

Armin Wolf

> +	ret =3D init_bios_attr_set_interface();
> +	if (ret)
> +		return ret;
> +
> +	ret =3D init_bios_attr_pass_interface();
> +	if (ret)
> +		goto err_exit_bios_attr_set_interface;
> +
> +	if (!bioscfg_drv.bios_attr_wdev || !bioscfg_drv.password_attr_wdev) {
> +		pr_debug("Failed to find set or pass interface\n");
> +		ret =3D -ENODEV;
> +		goto err_exit_bios_attr_pass_interface;
> +	}
> +
> +	ret =3D fw_attributes_class_get(&fw_attr_class);
> +	if (ret)
> +		goto err_exit_bios_attr_pass_interface;
> +
> +	bioscfg_drv.class_dev =3D device_create(fw_attr_class, NULL, MKDEV(0, =
0),
> +					      NULL, "%s", DRIVER_NAME);
> +	if (IS_ERR(bioscfg_drv.class_dev)) {
> +		ret =3D PTR_ERR(bioscfg_drv.class_dev);
> +		goto err_unregister_class;
> +	}
> +
> +	bioscfg_drv.main_dir_kset =3D kset_create_and_add("attributes", NULL,
> +							&bioscfg_drv.class_dev->kobj);
> +	if (!bioscfg_drv.main_dir_kset) {
> +		ret =3D -ENOMEM;
> +		pr_debug("Failed to create and add attributes\n");
> +		goto err_destroy_classdev;
> +	}
> +
> +	bioscfg_drv.authentication_dir_kset =3D kset_create_and_add("authentic=
ation", NULL,
> +								  &bioscfg_drv.class_dev->kobj);
> +	if (!bioscfg_drv.authentication_dir_kset) {
> +		ret =3D -ENOMEM;
> +		pr_debug("Failed to create and add authentication\n");
> +		goto err_release_attributes_data;
> +	}
> +
> +	/*
> +	 * sysfs level attributes.
> +	 * - pending_reboot
> +	 */
> +	ret =3D create_attributes_level_sysfs_files();
> +	if (ret)
> +		pr_debug("Failed to create sysfs level attributes\n");
> +
> +	ret =3D hp_init_bios_attributes(HPWMI_STRING_TYPE, HP_WMI_BIOS_STRING_=
GUID);
> +	if (ret)
> +		pr_debug("Failed to populate string type attributes\n");
> +
> +	ret =3D hp_init_bios_attributes(HPWMI_INTEGER_TYPE, HP_WMI_BIOS_INTEGE=
R_GUID);
> +	if (ret)
> +		pr_debug("Failed to populate integer type attributes\n");
> +
> +	ret =3D hp_init_bios_attributes(HPWMI_ENUMERATION_TYPE, HP_WMI_BIOS_EN=
UMERATION_GUID);
> +	if (ret)
> +		pr_debug("Failed to populate enumeration type attributes\n");
> +
> +	ret =3D hp_init_bios_attributes(HPWMI_ORDERED_LIST_TYPE, HP_WMI_BIOS_O=
RDERED_LIST_GUID);
> +	if (ret)
> +		pr_debug("Failed to populate ordered list object type attributes\n");
> +
> +	ret =3D hp_init_bios_attributes(HPWMI_PASSWORD_TYPE, HP_WMI_BIOS_PASSW=
ORD_GUID);
> +	if (ret)
> +		pr_debug("Failed to populate password object type attributes\n");
> +
> +	bioscfg_drv.spm_data.attr_name_kobj =3D NULL;
> +	ret =3D hp_add_other_attributes(HPWMI_SECURE_PLATFORM_TYPE);
> +	if (ret)
> +		pr_debug("Failed to populate secure platform object type attribute\n"=
);
> +
> +	bioscfg_drv.sure_start_attr_kobj =3D NULL;
> +	ret =3D hp_add_other_attributes(HPWMI_SURE_START_TYPE);
> +	if (ret)
> +		pr_debug("Failed to populate sure start object type attribute\n");
> +
> +	return 0;
> +
> +err_release_attributes_data:
> +	release_attributes_data();
> +
> +err_destroy_classdev:
> +	device_destroy(fw_attr_class, MKDEV(0, 0));
> +
> +err_unregister_class:
> +	fw_attributes_class_put();
> +
> +err_exit_bios_attr_pass_interface:
> +	exit_bios_attr_pass_interface();
> +
> +err_exit_bios_attr_set_interface:
> +	exit_bios_attr_set_interface();
> +
> +	return ret;
> +}
> +
> +static void __exit bioscfg_exit(void)
> +{
> +	release_attributes_data();
> +	device_destroy(fw_attr_class, MKDEV(0, 0));
> +
> +	fw_attributes_class_put();
> +	exit_bios_attr_set_interface();
> +	exit_bios_attr_pass_interface();
> +}
> +
> +module_init(bioscfg_init);
> +module_exit(bioscfg_exit);
