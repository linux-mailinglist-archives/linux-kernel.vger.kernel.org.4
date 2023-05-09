Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6223F6FC835
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjEINsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjEINso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:48:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6F33AB4;
        Tue,  9 May 2023 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683640122; x=1715176122;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nVKMQ8gQmNncq+0dtpcMhnoKycmecWZYJBjjqNw0ZBo=;
  b=kJUEMN0zWWlQ+JzNWus8TZDZGZCA0+nEItpycl8xCshWZgnZxH32dtFh
   T6wJEGK4U/kly5KBPm0qEORRT4t8m+nNV5lpC+wwTtOZ/mS126I2ntqBR
   Hf4a4GDD8mz0vy1ZdHoVPtbKEce4nFBimmNZrYIHTBfW1R6fjRvr4YRZF
   EX99EktlgWVVQLVxDYMUzoCanGCZ9LLGreaNVlplmkgr3nCVeepOQBbb1
   vPDEIVCfAbpDcVvjqBjMn4txrqC2xW/wTQdOd0bTxvUqvHH/VUSx1pQqA
   VcE62zD+OV0sv1FuUAbjzt6RPLHDF4pAaZvVqIjb55u5LChnocBbu0clU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="348762223"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="348762223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 06:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="729517674"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="729517674"
Received: from mbrdon-mobl.ger.corp.intel.com ([10.251.219.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 06:48:32 -0700
Date:   Tue, 9 May 2023 16:48:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v12 10/13] HP BIOSCFG driver  - spmobj-attributes
In-Reply-To: <20230505220043.39036-11-jorge.lopez2@hp.com>
Message-ID: <4537f210-4a7a-3c11-ecbb-ed4762a1f598@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-11-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1976581923-1683640114=:2036"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1976581923-1683640114=:2036
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 5 May 2023, Jorge Lopez wrote:

> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.’s commercial
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
>  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 381 ++++++++++++++++++
>  1 file changed, 381 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> new file mode 100644
> index 000000000000..f08f7aae9423
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> @@ -0,0 +1,381 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to secure platform management object type
> + * attributes under BIOS PASSWORD for use with hp-bioscfg driver
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#include "bioscfg.h"
> +
> +static const char * const spm_state_types[] = {
> +	"not provisioned",
> +	"provisioned",
> +	"provisioning in progress",
> +};
> +
> +static const char * const spm_mechanism_types[] = {
> +	"not provisioned",
> +	"signing-key",
> +	"endorsement-key",
> +};
> +
> +struct secureplatform_provisioning_data {
> +	u8 state;
> +	u8 version[2];
> +	u8 reserved1;
> +	u32 features;
> +	u32 nonce;
> +	u8 reserved2[28];
> +	u8 sk_mod[MAX_KEY_MOD];
> +	u8 kek_mod[MAX_KEY_MOD];
> +};
> +
> +int check_spm_is_enabled(void)
> +{
> +	/* do we need to check the admin password is also configured */
> +	return bioscfg_drv.spm_data.is_enabled;
> +}
> +
> +/**
> + * calculate_security_buffer() - determines size of security buffer
> + * for authentication scheme
> + *
> + * @authentication: the authentication content
> + *
> + * Currently only supported type is Admin password
> + */
> +size_t calculate_security_buffer(const char *authentication)
> +{
> +	int size;

Why not size_t?

> +
> +	if (authentication && strlen(authentication) > 0) {
> +		size = sizeof(u16) + (strlen(authentication) * sizeof(u16));

Extra parenthesis.

> +		if (!strstarts(authentication, BEAM_PREFIX))
> +			size += strlen(UTF_PREFIX) * sizeof(u16);
> +
> +		return size;
> +	}
> +
> +	size  = sizeof(u16) * 2;

Extra space

> +	return size;

I'd do it this way though:

	size_t size, authlen;

	if (!authentication)
		return sizeof(u16) * 2;

	authlen = strlen(authentication);
	if (!authlen)
		return sizeof(u16) * 2;

	size = sizeof(u16) + authlen * sizeof(u16);
	...


> +}
> +
> +/**
> + * populate_security_buffer() - builds a security buffer for
> + * authentication scheme
> + *
> + * @buffer: the buffer to populate
> + * @authentication: the authentication content
> + *
> + * Currently only supported type is PLAIN TEXT
> + */
> +int populate_security_buffer(u16 *buffer, const char *authentication)
> +{
> +	u16 *auth = buffer;
> +	u16 *retbuffer;
> +	char *strprefix = NULL;
> +	int ret = 0;
> +
> +	if (strstarts(authentication, BEAM_PREFIX)) {
> +		/*
> +		 * BEAM_PREFIX is append to buffer when a signature
> +		 * is provided and Sure Admin is enabled in BIOS
> +		 */
> +		// BEAM_PREFIX found, convert part to unicode
> +		retbuffer = hp_ascii_to_utf16_unicode(auth, authentication);
> +		if (!retbuffer) {
> +			ret = -EINVAL;
> +			goto out_buffer;

return -EINVAL directly.

> +		}
> +		auth = retbuffer;
> +
> +	} else {
> +		/*
> +		 * UTF-16 prefix is append to the * buffer when a BIOS

What is "the * buffer" ?

> +		 * admin password is configured in BIOS
> +		 */
> +
> +		// append UTF_PREFIX to part and then convert it to unicode

Use /* */ comments consistently.

> +		strprefix = kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
> +				      authentication);
> +		if (!strprefix)
> +			goto out_buffer;

Shouldn't you return an error code here? Also, strprefix is NULL so you 
can do return -ENOMEM directly.

> +
> +		retbuffer = hp_ascii_to_utf16_unicode(auth, strprefix);

If you move kfree(strprefix) here, the flow is more obvious.

> +		if (!retbuffer) {
> +			ret = -EINVAL;
> +			goto out_buffer;
> +		}
> +		auth = retbuffer;
> +	}
> +
> +out_buffer:
> +	kfree(strprefix);
> +	return ret;
> +}
> +
> +static ssize_t update_spm_state(void)
> +{
> +	int ret;
> +	struct secureplatform_provisioning_data data;
> +
> +	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> +				   HPWMI_SECUREPLATFORM, &data, 0,
> +				   sizeof(data));
> +	if (ret < 0)
> +		goto state_exit;

return ret; directly.

> +
> +	bioscfg_drv.spm_data.mechanism = data.state;
> +	if (bioscfg_drv.spm_data.mechanism)
> +		bioscfg_drv.spm_data.is_enabled = 1;
> +
> +state_exit:
> +	return ret;

return 0;

> +}
> +
> +static ssize_t statusbin(struct kobject *kobj,
> +			 struct kobj_attribute *attr,
> +			 struct secureplatform_provisioning_data *buf)
> +{
> +	int ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> +				       HPWMI_SECUREPLATFORM, buf, 0,
> +				       sizeof(struct secureplatform_provisioning_data));
> +
> +	return ret < 0 ? ret : sizeof(struct secureplatform_provisioning_data);

Split to:

	int ret;

	ret = hp_...();
	if (ret < 0)
		return ret;

	return sizeof(...);

> +}
> +
> +/*
> + * status_show - Reads SPM status
> + */
> +static ssize_t status_show(struct kobject *kobj, struct kobj_attribute
> +		    *attr, char *buf)
> +{
> +	int ret, i;
> +	struct secureplatform_provisioning_data data;
> +
> +	ret = statusbin(kobj, attr, &data);
> +	if (ret < 0)
> +		goto status_exit;

Can you calculate strnlen() from buf at this point, or is the result 
garbage? Should you return ret instead here?

> +
> +	sysfs_emit(buf, "%s{\n", buf);
> +	sysfs_emit(buf, "%s\t\"State\": \"%s\",\n", buf,
> +		   spm_state_types[data.state]);
> +	sysfs_emit(buf, "%s\t\"Version\": \"%d.%d\",\n", buf, data.version[0],
> +		   data.version[1]);
> +
> +	/*
> +	 * state == 0 means secure platform management
> +	 * feature is not configured in BIOS.
> +	 */
> +	if (data.state == 0)
> +		goto status_exit;
> +
> +	sysfs_emit(buf, "%s\t\"Nonce\": %d,\n", buf, data.nonce);
> +	sysfs_emit(buf, "%s\t\"FeaturesInUse\": %d,\n", buf, data.features);
> +	sysfs_emit(buf, "%s\t\"EndorsementKeyMod\": \"", buf);
> +
> +	for (i = 255; i >= 0; i--)
> +		sysfs_emit(buf, "%s %u", buf, data.kek_mod[i]);
> +
> +	sysfs_emit(buf, "%s \",\n", buf);
> +	sysfs_emit(buf, "%s\t\"SigningKeyMod\": \"", buf);
> +
> +	for (i = 255; i >= 0; i--)
> +		sysfs_emit(buf, "%s %u", buf, data.sk_mod[i]);
> +
> +	/* Return buf contents */
> +
> +	sysfs_emit(buf, "%s \"\n", buf);
> +	sysfs_emit(buf, "%s}\n", buf);
> +
> +status_exit:
> +	return strnlen(buf, PAGE_SIZE);
> +}

Emit buf into buf? There's sysfs_emit_at(), however,

while I'm far from sysfs formatting expert, this feels something that 
tries to expose more than one thing over same sysfs file. Shouldn't they 
be each in their own files?

> +static struct kobj_attribute password_spm_status = __ATTR_RO(status);
> +
> +ATTRIBUTE_SPM_N_PROPERTY_SHOW(is_enabled, spm);
> +static struct kobj_attribute password_spm_is_key_enabled = __ATTR_RO(is_enabled);
> +
> +static ssize_t key_mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n",
> +			  spm_mechanism_types[bioscfg_drv.spm_data.mechanism]);
> +}
> +
> +static struct kobj_attribute password_spm_key_mechanism = __ATTR_RO(key_mechanism);
> +
> +static ssize_t sk_store(struct kobject *kobj,
> +			struct kobj_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	int ret;
> +	int length;
> +
> +	length = count;
> +	if (buf[length - 1] == '\n')
> +		length--;
> +
> +	/* allocate space and copy current signing key */
> +	bioscfg_drv.spm_data.signing_key = kmalloc(length, GFP_KERNEL);
> +	if (!bioscfg_drv.spm_data.signing_key) {
> +		ret = -ENOMEM;
> +		goto exit_sk;
> +	}
> +
> +	strscpy(bioscfg_drv.spm_data.signing_key, buf, length);
> +	bioscfg_drv.spm_data.signing_key[length] = '\0';
> +
> +	/* submit signing key payload */
> +	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_SK,
> +				   HPWMI_SECUREPLATFORM,
> +				   (void *)bioscfg_drv.spm_data.signing_key,
> +				   length, 0);
> +
> +	if (!ret) {
> +		bioscfg_drv.spm_data.mechanism = SIGNING_KEY;
> +		set_reboot_and_signal_event();
> +	}
> +
> +exit_sk:
> +	kfree(bioscfg_drv.spm_data.signing_key);
> +	bioscfg_drv.spm_data.signing_key = NULL;
> +
> +	return ret ? ret : count;
> +}
> +
> +static struct kobj_attribute password_spm_signing_key = __ATTR_WO(sk);
> +
> +static ssize_t kek_store(struct kobject *kobj,
> +			 struct kobj_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	int ret;
> +	int length;
> +
> +	length = count;
> +	if (buf[length - 1] == '\n')
> +		length--;
> +
> +	/* allocate space and copy current signing key */
> +	bioscfg_drv.spm_data.endorsement_key = kmalloc(length, GFP_KERNEL);
> +	if (!bioscfg_drv.spm_data.endorsement_key) {
> +		ret = -ENOMEM;
> +		goto exit_kek;

Return directly.

> +	}
> +
> +	memcpy(bioscfg_drv.spm_data.endorsement_key, buf, length);
> +	bioscfg_drv.spm_data.endorsement_key[length] = '\0';
> +
> +	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_KEK,
> +				   HPWMI_SECUREPLATFORM,
> +				   (void *)bioscfg_drv.spm_data.endorsement_key,

In general, casting to void * (and back) is not required.

> +				   count, 0);
> +
> +	if (!ret) {
> +		bioscfg_drv.spm_data.mechanism = ENDORSEMENT_KEY;
> +		set_reboot_and_signal_event();
> +	}
> +
> +exit_kek:
> +	kfree(bioscfg_drv.spm_data.endorsement_key);
> +	bioscfg_drv.spm_data.endorsement_key = NULL;
> +
> +	return ret ? ret : count;
> +}
> +
> +static struct kobj_attribute password_spm_endorsement_key = __ATTR_WO(kek);
> +
> +static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", BIOS_SPM);
> +}
> +
> +static struct kobj_attribute password_spm_role = __ATTR_RO(role);
> +
> +static ssize_t auth_token_store(struct kobject *kobj,
> +				struct kobj_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int ret = 0;
> +	int length;
> +
> +	length = count;
> +	if (buf[length - 1] == '\n')
> +		length--;
> +
> +	/* allocate space and copy current auth token */
> +	bioscfg_drv.spm_data.auth_token = kmalloc(count, GFP_KERNEL);
> +	if (!bioscfg_drv.spm_data.auth_token) {
> +		ret = -ENOMEM;
> +		goto exit_token;

Return directly.

> +	}
> +
> +	memcpy(bioscfg_drv.spm_data.auth_token, buf, count);
> +	bioscfg_drv.spm_data.auth_token[length] = '\0';
> +	return count;
> +
> +exit_token:
> +	kfree(bioscfg_drv.spm_data.auth_token);
> +	bioscfg_drv.spm_data.auth_token = NULL;
> +
> +	return ret;
> +}
> +
> +static struct kobj_attribute password_spm_auth_token = __ATTR_WO(auth_token);
> +
> +static struct attribute *secure_platform_attrs[] = {
> +	&password_spm_is_key_enabled.attr,
> +	&password_spm_signing_key.attr,
> +	&password_spm_endorsement_key.attr,
> +	&password_spm_key_mechanism.attr,
> +	&password_spm_status.attr,
> +	&password_spm_role.attr,
> +	&password_spm_auth_token.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group secure_platform_attr_group = {
> +	.attrs = secure_platform_attrs,
> +};
> +
> +void exit_secure_platform_attributes(void)
> +{
> +	/* remove secure platform sysfs entry and free key data*/
> +
> +	kfree(bioscfg_drv.spm_data.endorsement_key);
> +	bioscfg_drv.spm_data.endorsement_key = NULL;
> +
> +	kfree(bioscfg_drv.spm_data.signing_key);
> +	bioscfg_drv.spm_data.signing_key = NULL;
> +
> +	kfree(bioscfg_drv.spm_data.auth_token);
> +	bioscfg_drv.spm_data.auth_token = NULL;
> +
> +	if (bioscfg_drv.spm_data.attr_name_kobj)
> +		sysfs_remove_group(bioscfg_drv.spm_data.attr_name_kobj,
> +				   &secure_platform_attr_group);
> +}
> +
> +int populate_secure_platform_data(struct kobject *attr_name_kobj)
> +{
> +	/* Populate data for Secure Platform Management */
> +	bioscfg_drv.spm_data.attr_name_kobj = attr_name_kobj;
> +
> +	strscpy(bioscfg_drv.spm_data.attribute_name, SPM_STR,
> +		sizeof(bioscfg_drv.spm_data.attribute_name));
> +
> +	bioscfg_drv.spm_data.is_enabled = 0;
> +	bioscfg_drv.spm_data.mechanism = 0;
> +	bioscfg_drv.pending_reboot = false;
> +	update_spm_state();
> +
> +	bioscfg_drv.spm_data.endorsement_key = NULL;
> +	bioscfg_drv.spm_data.signing_key = NULL;
> +	bioscfg_drv.spm_data.auth_token = NULL;
> +
> +	return sysfs_create_group(attr_name_kobj, &secure_platform_attr_group);
> +}
> 

-- 
 i.

--8323329-1976581923-1683640114=:2036--
