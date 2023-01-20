Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44879675BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjATRmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:42:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B951416
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:42:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso6354543wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6j2/IrgY+3egafMiX6NSxl6RdZ4et8VM5IaxtOoEQs=;
        b=C/ul6c3ABxYBf2JlEZ2EH95YM/LrB5mao6oTD0BW0/LXUXmhibyN8bJLVJ02Wlv5u+
         IRg1mBpjUdy2PYzF4Cr+Ikx9xD25ACI01JvUiu5D5EQKjyrC73K1c2vCnWS5vvOhn8yw
         baZpFlOy4kADzdLDq/JE/S76tgq5Bq2wZ4U5CxQrvnXxKWRDrH8WM+K0PRe152TtImoj
         5BzDQej72v2MHjFvj/pcQvOpEZUWjVDTdsTmk5WkOGbkPc688xpUjdMVr58kFpLdwrzs
         ihYi/65zCGyZw0Mn4G4ewZ7gIn0sGpE1ZeP0IFCUe/06AY65ClqBKSR6HtocOzh9083j
         9FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6j2/IrgY+3egafMiX6NSxl6RdZ4et8VM5IaxtOoEQs=;
        b=IjUmAwRCv9tT4wDBVpH0gEz4ZflSEK+7/XWbtzGYSj0lHr0Y4g1aj15xlM1oG+Xqbo
         tR0I7hHrHK5tWyU1tywrqg56OmgKlMDYA9RKVn2K5+nMqWOJt0nn1P7BpSBRButpawb3
         46ZFuweH72av3dg4fmd80JxMa/v0vB7t9QViMsEk2oAFb9bnSmUmXXhVeB9MqnQwpc3b
         kD+NSPClp+d1pMQA8C5/VeJEaegsGl6rcB7xEtBv3GqaaTAgxVnTTsMmdTxE9TVNu+TM
         7CluaoSY2CedJt4B2W3Qy2iySVo2tuxecmutGE7rskajBQSHvSvDAzY+Lkk0JzyfbMHV
         +UEQ==
X-Gm-Message-State: AFqh2koP0kYIr/pz1mWecXz9cS3TNqn8PslPq1fTGG/8OnBZd/t2+zGW
        JrgzfDKxp46j6OCucpQPe7WOcmf5SG5EAsP3GsM=
X-Google-Smtp-Source: AMrXdXuuliVHv55LauEoVacOgrbmAJow1wOsakFqYXOLV5HdjOSss6RI41+WWmh21klusuVryTUZrQ==
X-Received: by 2002:a05:600c:c16:b0:3da:26e5:10b6 with SMTP id fm22-20020a05600c0c1600b003da26e510b6mr15330718wmb.30.1674236526018;
        Fri, 20 Jan 2023 09:42:06 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b11-20020a05600018ab00b002be2279f100sm11363341wri.96.2023.01.20.09.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:42:05 -0800 (PST)
Message-ID: <388acc2b-e205-6fd1-4d25-d5ec3a99086b@linaro.org>
Date:   Fri, 20 Jan 2023 17:42:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 2/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230118172940.841094-1-patrick.delaunay@foss.st.com>
 <20230118182856.v6.2.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230118182856.v6.2.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 17:29, Patrick Delaunay wrote:
> For boot with OP-TEE on STM32MP13, the communication with the secure
> world no more use STMicroelectronics SMC but communication with the
> STM32MP BSEC TA, for data access (read/write) or lock operation:
> - all the request are sent to OP-TEE trusted application,
> - for upper OTP with ECC protection and with word programming only
>    each OTP are permanently locked when programmed to avoid ECC error
>    on the second write operation
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---

Applied thanks,

--srini
> 
> Changes in v6:
> - Add reviewed by  Etienne Carierre review
> 
> Changes in v5:
> - minor changes after Etienne Carierre review (comments,
>    change %x to %#x, remove goto to out_tee_session)
> 
> Changes in v4:
> - fixe warning reported by kernel test robot for 64 bits support in
>    drivers/nvmem/stm32-bsec-optee-ta.c:260:18:
>    warning: format '%d' expects argument of type 'int',
>    but argument 4 has type 'size_t'
> 
> Changes in v3:
> - add a separate file stm32-bsec-optee-ta.c with STM32MP BSEC TA
>    communication functions to avoid #if in romem driver.
> 
> Changes in v2:
> - rebase series on linux-next/master
> - minor update after V1 revue
> - add missing sentinel in stm32_romem_of_match()
> - reorder function and remove prototypes for stm32_bsec_pta... functions
> - change stm32_bsec_pta_find to static
> - add return value in dev_err()
> - cleanups some comments, which can be on one line
> - remove test on priv->ctx in stm32_bsec_pta_remove
> - add missing tee_shm_free(shm) in stm32_bsec_pta_write() when
>    tee_shm_get_va failed
> - return error in stm32_bsec_pta_find when devm_add_action_or_reset failed
> - handle driver_register error in stm32_romem_init
> 
>   drivers/nvmem/Kconfig               |  11 +
>   drivers/nvmem/Makefile              |   1 +
>   drivers/nvmem/stm32-bsec-optee-ta.c | 298 ++++++++++++++++++++++++++++
>   drivers/nvmem/stm32-bsec-optee-ta.h |  80 ++++++++
>   drivers/nvmem/stm32-romem.c         |  54 ++++-
>   5 files changed, 441 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.c
>   create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.h
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 755f551426b5..4d262f69a073 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -290,9 +290,20 @@ config NVMEM_SPRD_EFUSE
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-sprd-efuse.
>   
> +config NVMEM_STM32_BSEC_OPTEE_TA
> +	bool "STM32MP BSEC OP-TEE TA support for nvmem-stm32-romem driver"
> +	depends on OPTEE
> +	help
> +	  Say y here to enable the accesses to STM32MP SoC OTPs by the OP-TEE
> +	  trusted application STM32MP BSEC.
> +
> +	  This library is a used by stm32-romem driver or included in the module
> +	  called nvmem-stm32-romem.
> +
>   config NVMEM_STM32_ROMEM
>   	tristate "STMicroelectronics STM32 factory-programmed memory support"
>   	depends on ARCH_STM32 || COMPILE_TEST
> +	imply NVMEM_STM32_BSEC_OPTEE_TA
>   	help
>   	  Say y here to enable read-only access for STMicroelectronics STM32
>   	  factory-programmed memory area.
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index fa80fe17e567..6a1efffa88f0 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_NVMEM_SPRD_EFUSE)		+= nvmem_sprd_efuse.o
>   nvmem_sprd_efuse-y			:= sprd-efuse.o
>   obj-$(CONFIG_NVMEM_STM32_ROMEM)		+= nvmem_stm32_romem.o
>   nvmem_stm32_romem-y 			:= stm32-romem.o
> +nvmem_stm32_romem-$(CONFIG_NVMEM_STM32_BSEC_OPTEE_TA) += stm32-bsec-optee-ta.o
>   obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
>   nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
>   obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
> diff --git a/drivers/nvmem/stm32-bsec-optee-ta.c b/drivers/nvmem/stm32-bsec-optee-ta.c
> new file mode 100644
> index 000000000000..f89ce791dd12
> --- /dev/null
> +++ b/drivers/nvmem/stm32-bsec-optee-ta.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * OP-TEE STM32MP BSEC PTA interface, used by STM32 ROMEM driver
> + *
> + * Copyright (C) 2022, STMicroelectronics - All Rights Reserved
> + */
> +
> +#include <linux/tee_drv.h>
> +
> +#include "stm32-bsec-optee-ta.h"
> +
> +/*
> + * Read OTP memory
> + *
> + * [in]		value[0].a		OTP start offset in byte
> + * [in]		value[0].b		Access type (0:shadow, 1:fuse, 2:lock)
> + * [out]	memref[1].buffer	Output buffer to store read values
> + * [out]	memref[1].size		Size of OTP to be read
> + *
> + * Return codes:
> + * TEE_SUCCESS - Invoke command success
> + * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> + * TEE_ERROR_ACCESS_DENIED - OTP not accessible by caller
> + */
> +#define PTA_BSEC_READ_MEM		0x0
> +
> +/*
> + * Write OTP memory
> + *
> + * [in]		value[0].a		OTP start offset in byte
> + * [in]		value[0].b		Access type (0:shadow, 1:fuse, 2:lock)
> + * [in]		memref[1].buffer	Input buffer to read values
> + * [in]		memref[1].size		Size of OTP to be written
> + *
> + * Return codes:
> + * TEE_SUCCESS - Invoke command success
> + * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> + * TEE_ERROR_ACCESS_DENIED - OTP not accessible by caller
> + */
> +#define PTA_BSEC_WRITE_MEM		0x1
> +
> +/* value of PTA_BSEC access type = value[in] b */
> +#define SHADOW_ACCESS	0
> +#define FUSE_ACCESS	1
> +#define LOCK_ACCESS	2
> +
> +/* Bitfield definition for LOCK status */
> +#define LOCK_PERM			BIT(30)
> +
> +/* OP-TEE STM32MP BSEC TA UUID */
> +static const uuid_t stm32mp_bsec_ta_uuid =
> +	UUID_INIT(0x94cf71ad, 0x80e6, 0x40b5,
> +		  0xa7, 0xc6, 0x3d, 0xc5, 0x01, 0xeb, 0x28, 0x03);
> +
> +/*
> + * Check whether this driver supports the BSEC TA in the TEE instance
> + * represented by the params (ver/data) to this function.
> + */
> +static int stm32_bsec_optee_ta_match(struct tee_ioctl_version_data *ver,
> +				     const void *data)
> +{
> +	/* Currently this driver only supports GP compliant, OP-TEE based TA */
> +	if ((ver->impl_id == TEE_IMPL_ID_OPTEE) &&
> +		(ver->gen_caps & TEE_GEN_CAP_GP))
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +/* Open a session to OP-TEE for STM32MP BSEC TA */
> +static int stm32_bsec_ta_open_session(struct tee_context *ctx, u32 *id)
> +{
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	int rc;
> +
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &stm32mp_bsec_ta_uuid);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> +	sess_arg.num_params = 0;
> +
> +	rc = tee_client_open_session(ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret != 0)) {
> +		pr_err("%s: tee_client_open_session failed err:%#x, ret:%#x\n",
> +		       __func__, sess_arg.ret, rc);
> +		if (!rc)
> +			rc = -EINVAL;
> +	} else {
> +		*id = sess_arg.session;
> +	}
> +
> +	return rc;
> +}
> +
> +/* close a session to OP-TEE for STM32MP BSEC TA */
> +static void stm32_bsec_ta_close_session(void *ctx, u32 id)
> +{
> +	tee_client_close_session(ctx, id);
> +}
> +
> +/* stm32_bsec_optee_ta_open() - initialize the STM32MP BSEC TA */
> +int stm32_bsec_optee_ta_open(struct tee_context **ctx)
> +{
> +	struct tee_context *tee_ctx;
> +	u32 session_id;
> +	int rc;
> +
> +	/* Open context with TEE driver */
> +	tee_ctx = tee_client_open_context(NULL, stm32_bsec_optee_ta_match, NULL, NULL);
> +	if (IS_ERR(tee_ctx)) {
> +		rc = PTR_ERR(tee_ctx);
> +		if (rc == -ENOENT)
> +			return -EPROBE_DEFER;
> +		pr_err("%s: tee_client_open_context failed (%d)\n", __func__, rc);
> +
> +		return rc;
> +	}
> +
> +	/* Check STM32MP BSEC TA presence */
> +	rc = stm32_bsec_ta_open_session(tee_ctx, &session_id);
> +	if (rc) {
> +		tee_client_close_context(tee_ctx);
> +		return rc;
> +	}
> +
> +	stm32_bsec_ta_close_session(tee_ctx, session_id);
> +
> +	*ctx = tee_ctx;
> +
> +	return 0;
> +}
> +
> +/* stm32_bsec_optee_ta_open() - release the PTA STM32MP BSEC TA */
> +void stm32_bsec_optee_ta_close(void *ctx)
> +{
> +	tee_client_close_context(ctx);
> +}
> +
> +/* stm32_bsec_optee_ta_read() - nvmem read access using PTA client driver */
> +int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
> +			     void *buf, size_t bytes)
> +{
> +	struct tee_shm *shm;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[2];
> +	u8 *shm_buf;
> +	u32 start, num_bytes;
> +	int ret;
> +	u32 session_id;
> +
> +	ret = stm32_bsec_ta_open_session(ctx, &session_id);
> +	if (ret)
> +		return ret;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	arg.func = PTA_BSEC_READ_MEM;
> +	arg.session = session_id;
> +	arg.num_params = 2;
> +
> +	/* align access on 32bits */
> +	start = ALIGN_DOWN(offset, 4);
> +	num_bytes = round_up(offset + bytes - start, 4);
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	param[0].u.value.a = start;
> +	param[0].u.value.b = SHADOW_ACCESS;
> +
> +	shm = tee_shm_alloc_kernel_buf(ctx, num_bytes);
> +	if (IS_ERR(shm)) {
> +		ret = PTR_ERR(shm);
> +		goto out_tee_session;
> +	}
> +
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +	param[1].u.memref.shm = shm;
> +	param[1].u.memref.size = num_bytes;
> +
> +	ret = tee_client_invoke_func(ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		pr_err("TA_BSEC invoke failed TEE err:%#x, ret:%#x\n",
> +			arg.ret, ret);
> +		if (!ret)
> +			ret = -EIO;
> +	}
> +	if (!ret) {
> +		shm_buf = tee_shm_get_va(shm, 0);
> +		if (IS_ERR(shm_buf)) {
> +			ret = PTR_ERR(shm_buf);
> +			pr_err("tee_shm_get_va failed for transmit (%d)\n", ret);
> +		} else {
> +			/* read data from 32 bits aligned buffer */
> +			memcpy(buf, &shm_buf[offset % 4], bytes);
> +		}
> +	}
> +
> +	tee_shm_free(shm);
> +
> +out_tee_session:
> +	stm32_bsec_ta_close_session(ctx, session_id);
> +
> +	return ret;
> +}
> +
> +/* stm32_bsec_optee_ta_write() - nvmem write access using PTA client driver */
> +int stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
> +			      unsigned int offset, void *buf, size_t bytes)
> +{	struct tee_shm *shm;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[2];
> +	u8 *shm_buf;
> +	int ret;
> +	u32 session_id;
> +
> +	ret = stm32_bsec_ta_open_session(ctx, &session_id);
> +	if (ret)
> +		return ret;
> +
> +	/* Allow only writing complete 32-bits aligned words */
> +	if ((bytes % 4) || (offset % 4))
> +		return -EINVAL;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	arg.func = PTA_BSEC_WRITE_MEM;
> +	arg.session = session_id;
> +	arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	param[0].u.value.a = offset;
> +	param[0].u.value.b = FUSE_ACCESS;
> +
> +	shm = tee_shm_alloc_kernel_buf(ctx, bytes);
> +	if (IS_ERR(shm)) {
> +		ret = PTR_ERR(shm);
> +		goto out_tee_session;
> +	}
> +
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> +	param[1].u.memref.shm = shm;
> +	param[1].u.memref.size = bytes;
> +
> +	shm_buf = tee_shm_get_va(shm, 0);
> +	if (IS_ERR(shm_buf)) {
> +		ret = PTR_ERR(shm_buf);
> +		pr_err("tee_shm_get_va failed for transmit (%d)\n", ret);
> +		tee_shm_free(shm);
> +
> +		goto out_tee_session;
> +	}
> +
> +	memcpy(shm_buf, buf, bytes);
> +
> +	ret = tee_client_invoke_func(ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		pr_err("TA_BSEC invoke failed TEE err:%#x, ret:%#x\n", arg.ret, ret);
> +		if (!ret)
> +			ret = -EIO;
> +	}
> +	pr_debug("Write OTPs %d to %zu, ret=%d\n", offset / 4, (offset + bytes) / 4, ret);
> +
> +	/* Lock the upper OTPs with ECC protection, word programming only */
> +	if (!ret && ((offset + bytes) >= (lower * 4))) {
> +		u32 start, nb_lock;
> +		u32 *lock = (u32 *)shm_buf;
> +		int i;
> +
> +		/*
> +		 * don't lock the lower OTPs, no ECC protection and incremental
> +		 * bit programming, a second write is allowed
> +		 */
> +		start = max_t(u32, offset, lower * 4);
> +		nb_lock = (offset + bytes - start) / 4;
> +
> +		param[0].u.value.a = start;
> +		param[0].u.value.b = LOCK_ACCESS;
> +		param[1].u.memref.size = nb_lock * 4;
> +
> +		for (i = 0; i < nb_lock; i++)
> +			lock[i] = LOCK_PERM;
> +
> +		ret = tee_client_invoke_func(ctx, &arg, param);
> +		if (ret < 0 || arg.ret != 0) {
> +			pr_err("TA_BSEC invoke failed TEE err:%#x, ret:%#x\n", arg.ret, ret);
> +			if (!ret)
> +				ret = -EIO;
> +		}
> +		pr_debug("Lock upper OTPs %d to %d, ret=%d\n",
> +			 start / 4, start / 4 + nb_lock, ret);
> +	}
> +
> +	tee_shm_free(shm);
> +
> +out_tee_session:
> +	stm32_bsec_ta_close_session(ctx, session_id);
> +
> +	return ret;
> +}
> diff --git a/drivers/nvmem/stm32-bsec-optee-ta.h b/drivers/nvmem/stm32-bsec-optee-ta.h
> new file mode 100644
> index 000000000000..3966a0535179
> --- /dev/null
> +++ b/drivers/nvmem/stm32-bsec-optee-ta.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * OP-TEE STM32MP BSEC PTA interface, used by STM32 ROMEM driver
> + *
> + * Copyright (C) 2022, STMicroelectronics - All Rights Reserved
> + */
> +
> +#if IS_ENABLED(CONFIG_NVMEM_STM32_BSEC_OPTEE_TA)
> +/**
> + * stm32_bsec_optee_ta_open() - initialize the STM32 BSEC TA
> + * @ctx: the OP-TEE context on success
> + *
> + * Return:
> + *	On success, 0. On failure, -errno.
> + */
> +int stm32_bsec_optee_ta_open(struct tee_context **ctx);
> +
> +/**
> + * stm32_bsec_optee_ta_close() - release the STM32 BSEC TA
> + * @ctx: the OP-TEE context
> + *
> + * This function used to clean the OP-TEE resources initialized in
> + * stm32_bsec_optee_ta_open(); it can be used as callback to
> + * devm_add_action_or_reset()
> + */
> +void stm32_bsec_optee_ta_close(void *ctx);
> +
> +/**
> + * stm32_bsec_optee_ta_read() - nvmem read access using TA client driver
> + * @ctx: the OP-TEE context provided by stm32_bsec_optee_ta_open
> + * @offset: nvmem offset
> + * @buf: buffer to fill with nvem values
> + * @bytes: number of bytes to read
> + *
> + * Return:
> + *	On success, 0. On failure, -errno.
> + */
> +int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
> +			     void *buf, size_t bytes);
> +
> +/**
> + * stm32_bsec_optee_ta_write() - nvmem write access using TA client driver
> + * @ctx: the OP-TEE context provided by stm32_bsec_optee_ta_open
> + * @lower: number of lower OTP, not protected by ECC
> + * @offset: nvmem offset
> + * @buf: buffer with nvem values
> + * @bytes: number of bytes to write
> + *
> + * Return:
> + *	On success, 0. On failure, -errno.
> + */
> +int stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
> +			      unsigned int offset, void *buf, size_t bytes);
> +
> +#else
> +
> +static inline int stm32_bsec_optee_ta_open(struct tee_context **ctx)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void stm32_bsec_optee_ta_close(void *ctx)
> +{
> +}
> +
> +static inline int stm32_bsec_optee_ta_read(struct tee_context *ctx,
> +					   unsigned int offset, void *buf,
> +					   size_t bytes)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int stm32_bsec_optee_ta_write(struct tee_context *ctx,
> +					    unsigned int lower,
> +					    unsigned int offset, void *buf,
> +					    size_t bytes)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_NVMEM_STM32_BSEC_OPTEE_TA */
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index d1d03c2ad081..978a63edf297 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -11,6 +11,9 @@
>   #include <linux/module.h>
>   #include <linux/nvmem-provider.h>
>   #include <linux/of_device.h>
> +#include <linux/tee_drv.h>
> +
> +#include "stm32-bsec-optee-ta.h"
>   
>   /* BSEC secure service access from non-secure */
>   #define STM32_SMC_BSEC			0x82001003
> @@ -25,12 +28,14 @@
>   struct stm32_romem_cfg {
>   	int size;
>   	u8 lower;
> +	bool ta;
>   };
>   
>   struct stm32_romem_priv {
>   	void __iomem *base;
>   	struct nvmem_config cfg;
>   	u8 lower;
> +	struct tee_context *ctx;
>   };
>   
>   static int stm32_romem_read(void *context, unsigned int offset, void *buf,
> @@ -138,12 +143,29 @@ static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
>   	return 0;
>   }
>   
> +static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
> +			       size_t bytes)
> +{
> +	struct stm32_romem_priv *priv = context;
> +
> +	return stm32_bsec_optee_ta_read(priv->ctx, offset, buf, bytes);
> +}
> +
> +static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
> +				size_t bytes)
> +{
> +	struct stm32_romem_priv *priv = context;
> +
> +	return stm32_bsec_optee_ta_write(priv->ctx, priv->lower, offset, buf, bytes);
> +}
> +
>   static int stm32_romem_probe(struct platform_device *pdev)
>   {
>   	const struct stm32_romem_cfg *cfg;
>   	struct device *dev = &pdev->dev;
>   	struct stm32_romem_priv *priv;
>   	struct resource *res;
> +	int rc;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -173,15 +195,31 @@ static int stm32_romem_probe(struct platform_device *pdev)
>   	} else {
>   		priv->cfg.size = cfg->size;
>   		priv->lower = cfg->lower;
> -		priv->cfg.reg_read = stm32_bsec_read;
> -		priv->cfg.reg_write = stm32_bsec_write;
> +		if (cfg->ta) {
> +			rc = stm32_bsec_optee_ta_open(&priv->ctx);
> +			/* wait for OP-TEE client driver to be up and ready */
> +			if (rc)
> +				return rc;
> +		}
> +		if (priv->ctx) {
> +			rc = devm_add_action_or_reset(dev, stm32_bsec_optee_ta_close, priv->ctx);
> +			if (rc) {
> +				dev_err(dev, "devm_add_action_or_reset() failed (%d)\n", rc);
> +				return rc;
> +			}
> +			priv->cfg.reg_read = stm32_bsec_pta_read;
> +			priv->cfg.reg_write = stm32_bsec_pta_write;
> +		} else {
> +			priv->cfg.reg_read = stm32_bsec_read;
> +			priv->cfg.reg_write = stm32_bsec_write;
> +		}
>   	}
>   
>   	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
>   }
>   
>   /*
> - * STM32MP15 BSEC OTP regions: 4096 OTP bits (with 3072 effective bits)
> + * STM32MP15/13 BSEC OTP regions: 4096 OTP bits (with 3072 effective bits)
>    * => 96 x 32-bits data words
>    * - Lower: 1K bits, 2:1 redundancy, incremental bit programming
>    *   => 32 (x 32-bits) lower shadow registers = words 0 to 31
> @@ -191,6 +229,13 @@ static int stm32_romem_probe(struct platform_device *pdev)
>   static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
>   	.size = 384,
>   	.lower = 32,
> +	.ta = false,
> +};
> +
> +static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
> +	.size = 384,
> +	.lower = 32,
> +	.ta = true,
>   };
>   
>   static const struct of_device_id stm32_romem_of_match[] = {
> @@ -198,7 +243,10 @@ static const struct of_device_id stm32_romem_of_match[] = {
>   		.compatible = "st,stm32mp15-bsec",
>   		.data = (void *)&stm32mp15_bsec_cfg,
>   	}, {
> +		.compatible = "st,stm32mp13-bsec",
> +		.data = (void *)&stm32mp13_bsec_cfg,
>   	},
> +	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
>   
