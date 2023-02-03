Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E7689713
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjBCKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBCKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:39:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F271713
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:39:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v13so4701481eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnKlKsgSrPeI0T85FnJR8RzaNsUZULHr36yVMXuLps4=;
        b=oIMLnkcS2EnmL3rmeWxsACjhj9XmwSo3JANCcdUqzshi5ejTnvPNVQHJJiNrw0/R6q
         nRkf9/hDwW+bikEvhsLcQk47naNEkcZgNazW9GlsLhn0Fv3rNyGatygeua7aWgy4lvMg
         qQNoC0QmmXrXgSPg+rBcFNIVSwoKL5pzImgJxoTISSVjpWMhu62W1GmLVwZm/t0iU9jV
         fVScY60Tk27VAoIKeAZ3tOUcNhqbedV+BBC+5oBDgCEhXV87LpoarvOTRgqSuMymIFst
         TWO5VcVCoHwqqw6c9UH+jEazmOQjxL2EcppifOjI3Em1jFLBkPtiQCBz383yBJaqh01a
         RLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnKlKsgSrPeI0T85FnJR8RzaNsUZULHr36yVMXuLps4=;
        b=Ic4BMyJjoyikdmT4zfzoijiDA9740GGj2xMGwnRfsGaQ1nDqOp0Y1VX37imgSWLMhP
         gZOVyV9/cMRrG84l/Y6g92P+jRtetPj9odxZ/drIMWHtNK851zQguKQ/G4hGKWYDGRcG
         et/W2uyhgnzgemRwP7lsdXk6Nlmyv9RIw0cJLbP41Hcvv+qx93bz4YGkVhWQRElHs7Bz
         lzN6glffzp8HB2HGKIs8UZ52o136ubJNcLU9IjqgaYhc6EG6KXDctAgEjCD2wuGY3fQ1
         2+DYI2uYmcCqAI8+yPvlieKW9dNQ+cm7Hm/yV0aiklcDRy88sLLRR6v1fJoDJk+NlwTS
         PjuQ==
X-Gm-Message-State: AO0yUKUwFzKOPNpfigYN4RT09hwxhYbuB1vYBWOZvvlztxWpN7lFX/VE
        WHxXUTZfTlPKPH94bVTTMEvGfw==
X-Google-Smtp-Source: AK7set+pHZHKosy8fQ6WSt9ne1WZN3pg03AQNTMpBcXl4fAryoZipX9C4Bb6lN08Jy7SnQ1PJotrag==
X-Received: by 2002:aa7:cb57:0:b0:49e:33ce:144d with SMTP id w23-20020aa7cb57000000b0049e33ce144dmr8822757edt.37.1675420740102;
        Fri, 03 Feb 2023 02:39:00 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id cf13-20020a0564020b8d00b0049df0f91b78sm920395edb.78.2023.02.03.02.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:38:59 -0800 (PST)
Date:   Fri, 3 Feb 2023 11:38:57 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 3/3] optee: add enable/disable/set_wake handlers to
 optee irqs
Message-ID: <Y9zkQTXLzOzYqtV+@jade>
References: <20230124105643.1737250-1-etienne.carriere@linaro.org>
 <20230124105643.1737250-3-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124105643.1737250-3-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:56:43AM +0100, Etienne Carriere wrote:
> Implements OP-TEE's It Notif PTA API to deactivate and activate an
> interrupt notifier and to configure the wakeup capability
> of that interrupt. These controls are useful for efficient power
> management of the device when an interrupt controller resources is
> hosted in OP-TEE world.
> 
> When OP-TEE does not implement the It Notif PTA, the related handlers
> simply return with success. If OP-TEE exposes the PTA services, they
> are invoked on enable, disable and set_wake irqchip operations.
> 
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v1:
> - Patch added in v2 series for power-up/down and wakeup configuration
>   of the irq chip.
> ---
>  drivers/tee/optee/optee_private.h |   2 +
>  drivers/tee/optee/smc_abi.c       | 157 ++++++++++++++++++++++++++++++
>  2 files changed, 159 insertions(+)
> 
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index f467409e02e9..257bb505a1fb 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -166,6 +166,7 @@ struct optee_ops {
>   * @scan_bus_done	flag if device registation was already done.
>   * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
>   * @scan_bus_work	workq to scan optee bus and register optee drivers
> + * @notif_it_pta_ctx    TEE context for invoking interrupt conif services

We already have "ctx" above, why do we need another TEE context?

Thanks,
Jens

>   */
>  struct optee {
>  	struct tee_device *supp_teedev;
> @@ -185,6 +186,7 @@ struct optee {
>  	bool   scan_bus_done;
>  	struct workqueue_struct *scan_bus_wq;
>  	struct work_struct scan_bus_work;
> +	struct tee_context *notif_it_pta_ctx;
>  };
>  
>  struct optee_session {
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 9f4fdd28f04a..95adf8c93c98 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -52,6 +52,43 @@
>   */
>  #define OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */
>  
> +/*
> + * Interrupt notification can be configured using Notif-IT PTA services.
> + * Below are the PTA UUID and its API commands.
> + */
> +#define PTA_IT_NOTIF_UUID \
> +	UUID_INIT(0x4461e5c7, 0xb523, 0x4b73, 0xac, 0xed, 0x75, 0xad, \
> +		  0x2b, 0x9b, 0x59, 0xa1)
> +
> +/*
> + * PTA_IT_NOTIF_ACTIVATE_DETECTION - Enable a interrupt notification
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_IT_NOTIF_ACTIVATE_DETECTION		0
> +
> +/*
> + * PTA_IT_NOTIF_DEACTIVATE_DETECTION - Disable a interrupt notification
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_IT_NOTIF_DEACTIVATE_DETECTION	1
> +
> +/*
> + * PTA_IT_NOTIF_ENABLE_WAKEUP_SOURCE - Enable an interrupt wakeup source
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_IT_NOTIF_ENABLE_WAKEUP_SOURCE	2
> +
> +/*
> + * PTA_IT_NOTIF_ENABLE_WAKEUP_SOURCE - Disable an interrupt wakeup source
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_IT_NOTIF_DISABLE_WAKEUP_SOURCE	3
> +
> +
>  /*
>   * 1. Convert between struct tee_param and struct optee_msg_param
>   *
> @@ -977,6 +1014,92 @@ static int optee_smc_stop_async_notif(struct tee_context *ctx)
>   * 5. Asynchronous notification
>   */
>  
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	return ver->impl_id == TEE_IMPL_ID_OPTEE;
> +}
> +
> +static void init_optee_pta_context(struct optee *optee)
> +{
> +	struct tee_context *ctx = NULL;
> +	const uuid_t pta_uuid = PTA_IT_NOTIF_UUID;
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	int ret;
> +
> +	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
> +	if (IS_ERR(ctx))
> +		return;
> +
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &pta_uuid);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> +
> +	ret = tee_client_open_session(ctx, &sess_arg, NULL);
> +	if ((ret < 0) || (sess_arg.ret != 0)) {
> +		pr_err("Can't open IT_NOTIF PTA session: %#x\n", sess_arg.ret);
> +		tee_client_close_context(ctx);
> +		return;
> +	}
> +
> +	tee_client_close_session(ctx, sess_arg.session);
> +
> +	optee->notif_it_pta_ctx = ctx;
> +}
> +
> +static void release_optee_pta_context(struct optee *optee)
> +{
> +	if (optee->notif_it_pta_ctx) {
> +		tee_client_close_context(optee->notif_it_pta_ctx);
> +		optee->notif_it_pta_ctx = NULL;
> +	}
> +}
> +
> +static int invoke_optee_pta(struct optee *optee, unsigned int command,
> +			    unsigned int irq_id)
> +{
> +	const uuid_t pta_uuid = PTA_IT_NOTIF_UUID;
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	struct tee_ioctl_invoke_arg inv_arg;
> +	struct tee_param param[1];
> +	int ret;
> +
> +	if (!optee->notif_it_pta_ctx)
> +		return -ENOENT;
> +
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &pta_uuid);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> +
> +	ret = tee_client_open_session(optee->notif_it_pta_ctx, &sess_arg, NULL);
> +	if ((ret < 0) || (sess_arg.ret != 0)) {
> +		pr_err("tee_client_open_session failed, err: %#x\n", sess_arg.ret);
> +		if (!ret)
> +			ret = -EINVAL;
> +		return ret;
> +	}
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	inv_arg.session = sess_arg.session;
> +	inv_arg.func = command;
> +	inv_arg.num_params = 1;
> +
> +	memset(&param, 0, sizeof(param));
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	param[0].u.value.a = irq_id;
> +
> +	ret = tee_client_invoke_func(optee->notif_it_pta_ctx, &inv_arg, param);
> +	if ((ret < 0) || (inv_arg.ret != 0)) {
> +		pr_err("tee_client_invoke_func failed, ret: %d, err: %#x\n",
> +		       ret, inv_arg.ret);
> +		if (!ret)
> +			ret = -EINVAL;
> +	}
> +
> +	tee_client_close_session(optee->notif_it_pta_ctx, sess_arg.session);
> +
> +	return ret;
> +}
> +
>  static void config_notif_it(optee_invoke_fn *invoke_fn, u32 it_value,
>  			    u32 op_mask, u32 val_mask)
>  {
> @@ -1001,10 +1124,40 @@ static void optee_it_irq_unmask(struct irq_data *d)
>  	config_notif_it(optee->smc.invoke_fn, d->hwirq, OPTEE_SMC_NOTIF_CONFIG_MASK, 0);
>  }
>  
> +static void optee_it_irq_disable(struct irq_data *d)
> +{
> +	struct optee *optee = d->domain->host_data;
> +
> +	(void)invoke_optee_pta(optee, PTA_IT_NOTIF_DEACTIVATE_DETECTION, d->hwirq);
> +}
> +
> +static void optee_it_irq_enable(struct irq_data *d)
> +{
> +	struct optee *optee = d->domain->host_data;
> +
> +	(void)invoke_optee_pta(optee, PTA_IT_NOTIF_ACTIVATE_DETECTION, d->hwirq);
> +}
> +
> +static int optee_it_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct optee *optee = d->domain->host_data;
> +	u32 command;
> +
> +	if (on)
> +		command = PTA_IT_NOTIF_ENABLE_WAKEUP_SOURCE;
> +	else
> +		command = PTA_IT_NOTIF_DISABLE_WAKEUP_SOURCE;
> +
> +	return invoke_optee_pta(optee, command, d->hwirq);
> +}
> +
>  static struct irq_chip optee_it_irq_chip = {
>  	.name = "optee-it",
>  	.irq_mask = optee_it_irq_mask,
>  	.irq_unmask = optee_it_irq_unmask,
> +	.irq_disable = optee_it_irq_disable,
> +	.irq_enable = optee_it_irq_enable,
> +	.irq_set_wake = optee_it_irq_set_wake,
>  };
>  
>  static int optee_it_alloc(struct irq_domain *d, unsigned int virq,
> @@ -1463,6 +1616,7 @@ static int optee_smc_remove(struct platform_device *pdev)
>  		optee_disable_shm_cache(optee);
>  
>  	optee_smc_notif_uninit_irq(optee);
> +	release_optee_pta_context(optee);
>  
>  	optee_remove_common(optee);
>  
> @@ -1650,6 +1804,8 @@ static int optee_probe(struct platform_device *pdev)
>  				irq_dispose_mapping(irq);
>  				goto err_notif_uninit;
>  			}
> +
> +			init_optee_pta_context(optee);
>  		}
>  
>  		enable_async_notif(optee->smc.invoke_fn);
> @@ -1687,6 +1843,7 @@ static int optee_probe(struct platform_device *pdev)
>  		optee_disable_shm_cache(optee);
>  	optee_smc_notif_uninit_irq(optee);
>  	optee_unregister_devices();
> +	release_optee_pta_context(optee);
>  err_notif_uninit:
>  	optee_notif_uninit(optee);
>  err_close_ctx:
> -- 
> 2.25.1
> 
