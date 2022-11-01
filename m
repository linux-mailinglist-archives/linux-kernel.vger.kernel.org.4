Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38615614505
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 08:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKAH1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 03:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAH06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:26:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0914D26
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 00:26:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so12231248wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3xfIL5UufZ3svhvpUhwBEac/6FrUsdif0wpxoIrOwM=;
        b=EvZ/qdsTm/E8rIx/wllIwMMEB+abRr1/c6cS7DISHZL7Irp/dWUzU5edAVkHbwraMf
         iNUqeWR4NQrrcJNsWtdc5Q0GC2MJjvN3YPwuSodkWXbygK4XRpNgYDNrWWdBXtuQtY8t
         TMbQBStpLkOOF2D06T/1Wm7nnhu0zxg6/U77vN3AIL/rFfu99perToNEpoHXW69wD4/A
         odJ96st8EO6vQkyJe0beRqW03dtk5OtQMKk4Itp0S5N3aWlhGKIqPDJKPpVm9UDH33uL
         uwsROPypjNprK5zAlk3o9eAHdN5EOUq26ITmMPny5j1n8E6VuB5Cv5KHel+PPV0rzv4J
         951g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3xfIL5UufZ3svhvpUhwBEac/6FrUsdif0wpxoIrOwM=;
        b=5g38omSMyxBL0fQsDhawPB1MXVwjSyNZsn7TSVgTVI53dOjEzuFdMPC3AkScBBax2k
         C3I+14nfuDrD7aLqM1HotYyoEd9Q3w5U86DqIHfCxBCS2lIHeveD+5YZkmfbyBdCEj0I
         gbX10dkX6zyj6c78p70x5jEt8D7z8+hyAkUyJ6B1X2DofZ2seCCMOBB0cQA/YSXpuU/Z
         zxWckb9zNA2iODFVooMq3jCSg8K8ZFGuhE29RwFoBqpxZJwQ1+Jy9zK34v28B98Ud1o6
         rziARJwStkx8qzpS3PcZ5kfLUM5wDQqjAHoQUgrqCixweevovA3M46eR94UbJdoTd1WE
         d9Mg==
X-Gm-Message-State: ACrzQf0cBgWT7BGLMERz6U2JhRxWJcWcF9GVlnurJKrc/8v/+vFwxQ3o
        Md263+XS9NOlpZ9UZQvUIACp8g==
X-Google-Smtp-Source: AMsMyM76c2qw9yxD7myrljjuksWobnsfYoD8OyDyDyhBIbhMPIyJLFKjtAkoPAfa/rovEccM7gDomA==
X-Received: by 2002:a1c:c90c:0:b0:3b4:adc7:9766 with SMTP id f12-20020a1cc90c000000b003b4adc79766mr11039498wmb.66.1667287614632;
        Tue, 01 Nov 2022 00:26:54 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id az5-20020a05600c600500b003b435c41103sm10577403wmb.0.2022.11.01.00.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 00:26:53 -0700 (PDT)
Message-ID: <99a8d093-13f3-9ff8-6d87-d4aecaec1566@linaro.org>
Date:   Tue, 1 Nov 2022 07:26:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] nvmem: stm32: add OP-TEE support for STM32MP13x
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
 <20221028165150.3.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221028165150.3.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2022 15:52, Patrick Delaunay wrote:
> For boot with OP-TEE on STM32MP13, the communication with the secure
> world no more use STMicroelectronics SMC but communication with the
> BSEC TA, for data access (read/write) or lock operation:
> - all the request are sent to OP-TEE trusted application,
> - for upper OTP with ECC protection and with word programming only
>    each OTP are permanently locked when programmed to avoid ECC error
>    on the second write operation
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---

For some reason I pushed this patch without a full review, This is now 
reverted from nvmem-next.

Why not add TEE client based new driver instead of ifdefing around this 
driver? Also I see there is not much common across both drivers anyway.


> 
>   drivers/nvmem/stm32-romem.c | 450 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 446 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index 6de565639d5f..dfdedbcca9b9 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -11,6 +11,7 @@
>   #include <linux/module.h>
>   #include <linux/nvmem-provider.h>
>   #include <linux/of_device.h>
> +#include <linux/tee_drv.h>
>   
>   /* BSEC secure service access from non-secure */
>   #define STM32_SMC_BSEC			0x82001003
> @@ -25,14 +26,22 @@
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
> +	struct device *ta;
>   };
>   
> +struct device *stm32_bsec_pta_find(struct device *dev);
> +static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
> +			       size_t bytes);
> +static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
> +				size_t bytes);
> +
>   static int stm32_romem_read(void *context, unsigned int offset, void *buf,
>   			    size_t bytes)
>   {
> @@ -173,15 +182,25 @@ static int stm32_romem_probe(struct platform_device *pdev)
>   	} else {
>   		priv->cfg.size = cfg->size;
>   		priv->lower = cfg->lower;
> -		priv->cfg.reg_read = stm32_bsec_read;
> -		priv->cfg.reg_write = stm32_bsec_write;
> +		if (cfg->ta) {
> +			priv->ta = stm32_bsec_pta_find(dev);
> +			/* wait for OP-TEE client driver to be up and ready */
> +			if (!priv->ta)
> +				return -EPROBE_DEFER;
> +
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
> @@ -191,6 +210,13 @@ static int stm32_romem_probe(struct platform_device *pdev)
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
> @@ -198,6 +224,8 @@ static const struct of_device_id stm32_romem_of_match[] = {
>   		.compatible = "st,stm32mp15-bsec",
>   		.data = (void *)&stm32mp15_bsec_cfg,
>   	}, {
> +		.compatible = "st,stm32mp13-bsec",
> +		.data = (void *)&stm32mp13_bsec_cfg,

missing sentinel, which caused a regression in next.


--srini
>   	},
>   };
>   MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
> @@ -209,7 +237,421 @@ static struct platform_driver stm32_romem_driver = {
>   		.of_match_table = of_match_ptr(stm32_romem_of_match),
>   	},
>   };
> -module_platform_driver(stm32_romem_driver);
> +
> +#if IS_ENABLED(CONFIG_OPTEE)
> +/*************************************************************************
> + * BSEC PTA : OP-TEE client driver to pseudo trusted application
> + *************************************************************************/
> +
> +/*
> + * Read OTP memory
> + *
> + * [in]		value[0].a		OTP start offset in byte
> + * [in]		value[0].b		Access type (0 : shadow,
> + *					1 : fuse, 2 : lock)
> + * [out]	memref[1].buffer	Output buffer to store read values
> + * [out]	memref[1].size		Size of OTP to be read
> + *
> + * Return codes:
> + * TEE_SUCCESS - Invoke command success
> + * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> + */
> +#define PTA_BSEC_READ_MEM		0x0 /* Read OTP */
> +
> +/*
> + * Write OTP memory
> + *
> + * [in]		value[0].a		OTP start offset in byte
> + * [in]		value[0].b		Access type (0 : shadow,
> + *					1 : fuse, 2 : lock)
> + * [in]		memref[1].buffer	Input buffer to read values
> + * [in]		memref[1].size		Size of OTP to be written
> + *
> + * Return codes:
> + * TEE_SUCCESS - Invoke command success
> + * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> + */
> +#define PTA_BSEC_WRITE_MEM		0x1	/* Write OTP */
> +
> +/* value of PTA_BSEC access type = value[in] b */
> +#define SHADOW_ACCESS	0
> +#define FUSE_ACCESS	1
> +#define LOCK_ACCESS	2
> +
> +/* Bitfield definition for LOCK status */
> +#define LOCK_PERM			BIT(30)
> +
> +/**
> + * struct stm32_bsec_pta_priv - OP-TEE BSEC TA private data
> + * @ctx:		OP-TEE context handler.
> + * @session_id:		TA session identifier.
> + */
> +struct stm32_bsec_pta_priv {
> +	struct tee_context *ctx;
> +	u32 session_id;
> +};
> +
> +/*
> + * Check whether this driver supports the BSEC TA in the TEE instance
> + * represented by the params (ver/data) to this function.
> + */
> +static int stm32_bsec_pta_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	/*
> +	 * Currently this driver only supports GP compliant, OP-TEE based TA
> +	 */
> +	if ((ver->impl_id == TEE_IMPL_ID_OPTEE) &&
> +		(ver->gen_caps & TEE_GEN_CAP_GP))
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +/**
> + * stm32_bsec_pta_probe() - initialize the PTA BSEC
> + * @dev: the platform_device description.
> + *
> + * Return:
> + *	On success, 0. On failure, -errno.
> + */
> +static int stm32_bsec_pta_probe(struct device *dev)
> +{
> +	int rc;
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	struct tee_client_device *tee_device = to_tee_client_device(dev);
> +	struct stm32_bsec_pta_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/* Open context with TEE driver */
> +	priv->ctx = tee_client_open_context(NULL, stm32_bsec_pta_match, NULL, NULL);
> +	if (IS_ERR(priv->ctx)) {
> +		if (PTR_ERR(priv->ctx) == -ENOENT)
> +			return -EPROBE_DEFER;
> +		dev_err(dev, "%s: tee_client_open_context failed\n", __func__);
> +		return PTR_ERR(priv->ctx);
> +	}
> +
> +	/* Open a session with BSEC TA */
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &tee_device->id.uuid);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> +	sess_arg.num_params = 0;
> +
> +	rc = tee_client_open_session(priv->ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "%s: tee_client_open_session failed, err=%x\n",
> +			__func__, sess_arg.ret);
> +		rc = -EINVAL;
> +		goto out_tee_session;
> +	}
> +	priv->session_id = sess_arg.session;
> +	dev_set_drvdata(dev, priv);
> +
> +	return 0;
> +
> +out_tee_session:
> +	tee_client_close_context(priv->ctx);
> +	priv->ctx = NULL;
> +
> +	return rc;
> +}
> +
> +/**
> + * stm32_bsec_pta_remove() - remove the BSEC TEE device
> + * @dev: the platform_device description.
> + *
> + * Return:
> + *	0 always.
> + */
> +static int stm32_bsec_pta_remove(struct device *dev)
> +{
> +	struct stm32_bsec_pta_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!IS_ERR_OR_NULL(priv->ctx)) {
> +		tee_client_close_session(priv->ctx, priv->session_id);
> +		tee_client_close_context(priv->ctx);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * stm32_bsec_pta_read() - nvmem read access using PTA client driver
> + * @context: nvmem context => romem privdate data
> + * @offset: nvmem offset
> + * @buf: buffer to fill with nvem values
> + * @bytes: number of bytes to read
> + *
> + * Return:
> + *	On success, 0. On failure, -errno.
> + */
> +static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
> +			       size_t bytes)
> +{
> +	struct stm32_romem_priv *romem_priv = context;
> +	struct device *dev;
> +	struct stm32_bsec_pta_priv *priv;
> +	struct tee_shm *shm;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[2];
> +	u8 *shm_buf;
> +	u32 start, num_bytes;
> +	int ret;
> +
> +	dev = romem_priv->ta;
> +	if (!dev) {
> +		pr_err("TA_BSEC invoke with driver\n");
> +		return -ENXIO;
> +	}
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	memset(&arg, 0, sizeof(arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	arg.func = PTA_BSEC_READ_MEM;
> +	arg.session = priv->session_id;
> +	arg.num_params = 2;
> +
> +	/* align access on 32bits */
> +	start = ALIGN_DOWN(offset, 4);
> +	num_bytes = round_up(offset + bytes - start, 4);
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	param[0].u.value.a = start;
> +	param[0].u.value.b = SHADOW_ACCESS;
> +
> +	shm = tee_shm_alloc_kernel_buf(priv->ctx, num_bytes);
> +	if (IS_ERR(shm))
> +		return PTR_ERR(shm);
> +
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +	param[1].u.memref.shm = shm;
> +	param[1].u.memref.size = num_bytes;
> +
> +	ret = tee_client_invoke_func(priv->ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		dev_err(dev, "TA_BSEC invoke failed TEE err: %x, ret:%x\n",
> +			arg.ret, ret);
> +		if (!ret)
> +			ret = -EIO;
> +	}
> +	if (!ret) {
> +		shm_buf = tee_shm_get_va(shm, 0);
> +		if (IS_ERR(shm_buf)) {
> +			dev_err(dev, "tee_shm_get_va failed for transmit\n");
> +			ret = PTR_ERR(shm_buf);
> +		} else {
> +			ret = 0;
> +			/* read data from 32 bits aligned buffer */
> +			memcpy(buf, &shm_buf[offset % 4], bytes);
> +		}
> +	}
> +
> +	tee_shm_free(shm);
> +
> +	return ret;
> +}
> +
> +/**
> + * stm32_bsec_pta_write() - nvmem write access using PTA client driver
> + * @context: nvmem context => romem privdate data
> + * @offset: nvmem offset
> + * @buf: buffer with nvem values
> + * @bytes: number of bytes to write
> + *
> + * Return:
> + *	On success, 0. On failure, -errno.
> + */
> +static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
> +				size_t bytes)
> +{
> +	struct stm32_romem_priv *romem_priv = context;
> +	struct device *dev;
> +	struct stm32_bsec_pta_priv *priv;
> +	struct tee_shm *shm;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[2];
> +	u8 *shm_buf;
> +	int ret;
> +
> +	dev = romem_priv->ta;
> +	if (!dev) {
> +		pr_err("TA_BSEC invoke with driver\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Allow only writing complete 32-bits aligned words */
> +	if ((bytes % 4) || (offset % 4))
> +		return -EINVAL;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	memset(&arg, 0, sizeof(arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	arg.func = PTA_BSEC_WRITE_MEM;
> +	arg.session = priv->session_id;
> +	arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	param[0].u.value.a = offset;
> +	param[0].u.value.b = FUSE_ACCESS;
> +
> +	shm = tee_shm_alloc_kernel_buf(priv->ctx, bytes);
> +	if (IS_ERR(shm))
> +		return PTR_ERR(shm);
> +
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> +	param[1].u.memref.shm = shm;
> +	param[1].u.memref.size = bytes;
> +
> +	shm_buf = tee_shm_get_va(shm, 0);
> +	if (IS_ERR(shm_buf)) {
> +		dev_err(dev, "tee_shm_get_va failed for transmit\n");
> +		return PTR_ERR(shm_buf);
> +	}
> +
> +	memcpy(shm_buf, buf, bytes);
> +
> +	ret = tee_client_invoke_func(priv->ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		dev_err(dev, "TA_BSEC invoke failed TEE err: %x, ret:%x\n",
> +			arg.ret, ret);
> +		if (!ret)
> +			ret = -EIO;
> +	}
> +	dev_dbg(dev, "Write OTPs %d to %d, ret=%d\n",
> +		offset / 4, (offset + bytes) / 4, ret);
> +
> +	/* Lock the upper OTPs with ECC protection, word programming only */
> +	if (!ret && ((offset + bytes) >= (romem_priv->lower * 4))) {
> +		u32 start, nb_lock;
> +		u32 *lock = (u32 *)shm_buf;
> +		int i;
> +
> +		/*
> +		 * don't lock the lower OTPs, no ECC protection and incremental
> +		 * bit programming, a second write is allowed
> +		 */
> +		start = max_t(u32, offset, romem_priv->lower * 4);
> +		nb_lock = (offset + bytes - start) / 4;
> +
> +		param[0].u.value.a = start;
> +		param[0].u.value.b = LOCK_ACCESS;
> +		param[1].u.memref.size = nb_lock * 4;
> +
> +		for (i = 0; i < nb_lock; i++)
> +			lock[i] = LOCK_PERM;
> +
> +		ret = tee_client_invoke_func(priv->ctx, &arg, param);
> +		if (ret < 0 || arg.ret != 0) {
> +			dev_err(dev, "TA_BSEC invoke failed TEE err: %x, ret:%x\n",
> +				arg.ret, ret);
> +			if (!ret)
> +				ret = -EIO;
> +		}
> +		dev_dbg(dev, "Lock upper OTPs %d to %d, ret=%d\n",
> +			start / 4, start / 4 + nb_lock, ret);
> +	}
> +
> +	tee_shm_free(shm);
> +
> +	return ret;
> +}
> +
> +static const struct tee_client_device_id stm32_bsec_id_table[] = {
> +	{
> +		UUID_INIT(0x94cf71ad, 0x80e6, 0x40b5,
> +			  0xa7, 0xc6, 0x3d, 0xc5, 0x01, 0xeb, 0x28, 0x03)
> +	},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(tee, stm32_bsec_id_table);
> +
> +static struct tee_client_driver stm32_bsec_pta_driver = {
> +	.id_table	= stm32_bsec_id_table,
> +	.driver		= {
> +		.name = "stm32-bsec-pta",
> +		.bus = &tee_bus_type,
> +		.probe = stm32_bsec_pta_probe,
> +		.remove = stm32_bsec_pta_remove,
> +	},
> +};
> +
> +static void stm32_bsec_put_device(void *data)
> +{
> +	put_device(data);
> +}
> +
> +struct device *stm32_bsec_pta_find(struct device *dev)
> +{
> +	struct device *pta_dev;
> +
> +	pta_dev = driver_find_next_device(&stm32_bsec_pta_driver.driver, NULL);
> +
> +	if (pta_dev && devm_add_action_or_reset(dev, stm32_bsec_put_device, pta_dev)) {
> +		dev_err(dev, "unable to register cleanup action\n");
> +
> +		return NULL;
> +	}
> +
> +	return pta_dev;
> +}
> +
> +#else
> +static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
> +			       size_t bytes)
> +{
> +	pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
> +
> +	return -ENXIO;
> +}
> +
> +static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
> +				size_t bytes)
> +{
> +	pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
> +
> +	return -ENXIO;
> +}
> +
> +struct device *stm32_bsec_pta_find(struct device *dev)
> +{
> +	pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
> +
> +	return NULL;
> +}
> +#endif
> +
> +static int __init stm32_romem_init(void)
> +{
> +	int rc;
> +
> +	rc = platform_driver_register(&stm32_romem_driver);
> +	if (rc)
> +		return rc;
> +
> +#if IS_ENABLED(CONFIG_OPTEE)
> +	rc = driver_register(&stm32_bsec_pta_driver.driver);
> +#endif
> +
> +	return rc;
> +}
> +
> +static void __exit stm32_romem_exit(void)
> +{
> +	platform_driver_unregister(&stm32_romem_driver);
> +#if IS_ENABLED(CONFIG_OPTEE)
> +	driver_unregister(&stm32_bsec_pta_driver.driver);
> +#endif
> +}
> +
> +module_init(stm32_romem_init);
> +module_exit(stm32_romem_exit);
>   
>   MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>   MODULE_DESCRIPTION("STMicroelectronics STM32 RO-MEM");
