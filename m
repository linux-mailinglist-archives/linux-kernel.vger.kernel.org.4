Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33222674F88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjATIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjATIda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:33:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD539CC5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:33:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y19so5888053edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfAFZxwawR9nlSiREpk0WBvZ5ulHNlk4pVb/n5MJ+MI=;
        b=fUsP+njeacR0fCPhlVB5hifmTKQY88tGzJ16u9spEuoYpxeG/kM4JbKnHuonsvthqL
         NdbHFGiIEJ9p3uw/cJagcKSsg9nC8d5bDZGX/zvCeQCEtCqf761Bl4PZhBOoolaeE6o3
         dBnN6TboZlyXQzouugKgsfboWDetc3NswJvlnSApeWI6Wru64h0WT1A5ASPWFrmrpYui
         x6yaXSOPJKnKtbGJU9nxIjyGbEs1zmpGooWxRT79e9bKfnV5MVxqI+84coW21fGnFH3D
         mUOLzzoUNjfi01W4wNB+m7iQKXVfKCd88jnoPWogFHYTQ/879HIMoRFQvhBJZkzwUtIe
         JVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfAFZxwawR9nlSiREpk0WBvZ5ulHNlk4pVb/n5MJ+MI=;
        b=J4gReqU1msbxa5nWOhWzL9AyWcmBwtqt+7prM2jNMn5Ips2CSPagUJ9rb1zGhMQYNs
         g4LQzKpgADubBnTrwN697GSoIerI/twtiGBMuHqbCCOaiC9U9+kYooUPxRApjo9ffRp1
         efCUfim/DtzA/d/rp9RN+FRNLAfY/n1EyTAwopABJdu3wQZCAtnTG9FFqBQTVzu30wSX
         41f/yPVCtl8Yj27yE8s/IYdg2ObOYnZ6D54jUg6YuwSKX87b95pacojPBVCOM1kDy1Ts
         4nbtzfMu5zGmwf93O6Lq97AFF9mKN8wc+blj62Fyx6CooCjKv07U3i7TCXvyi0kOJmLP
         FgaQ==
X-Gm-Message-State: AFqh2kruZWzCSbNMQTvS68EMSaFCPSVUaFD9igFP6ip3/6i8opLBUw4X
        e9z7GugdznwV56iVqYj/cWQ9MQ==
X-Google-Smtp-Source: AMrXdXtEQfmj9uy6Rj2FRA7N/7iITUVCnhVaOorHapN3Xs4qEVPjtJuqtCwZ3HOiOtIRcf12WO9G8w==
X-Received: by 2002:a05:6402:70d:b0:49d:28b1:5690 with SMTP id w13-20020a056402070d00b0049d28b15690mr13659527edx.41.1674203606387;
        Fri, 20 Jan 2023 00:33:26 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id r28-20020a056402035c00b0049ebbee7134sm247239edw.94.2023.01.20.00.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 00:33:25 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:33:24 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2] optee: add per cpu asynchronous notification
Message-ID: <Y8pR1Bm7TQdtI7x5@jade>
References: <20230118174909.2049638-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118174909.2049638-1-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:49:09PM +0100, Etienne Carriere wrote:
> Implements use of per CPU irq for optee asynchronous notification.
> 
> Existing optee async notif implementation allows OP-TE world to

allows OP-TEE in the secure world to

> raise an interrupt for the Linux optee driver to query pending events
> bound to waiting tasks in Linux world or threaded bottom half tasks
> to be invoked in TEE world. This change allows the signaling interrupt
> to be a per cpu interrupt as with Arm GIC PPIs.
> 
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> 
> Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v1:
> - Fixed missing __percpu attribute reported by kernel test robot.
> - Rephrased commit message and added Cc tags.
> ---
>  drivers/tee/optee/optee_private.h |  22 ++++++
>  drivers/tee/optee/smc_abi.c       | 107 ++++++++++++++++++++++++++++--
>  2 files changed, 124 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 04ae58892608..e5bd3548691f 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -94,11 +94,33 @@ struct optee_supp {
>  	struct completion reqs_c;
>  };
>  
> +/*
> + * struct optee_pcpu - per cpu notif private struct passed to work functions
> + * @optee		optee device reference
> + */
> +struct optee_pcpu {
> +	struct optee *optee;
> +};
> +
> +/*
> + * struct optee_smc - optee smc communication struct
> + * @invoke_fn		handler function to invoke secure monitor
> + * @memremaped_shm	virtual address of memory in shared memory pool
> + * @sec_caps:		secure world capabilities defined by
> + *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
> + * @notif_irq		interrupt used as async notification by OP-TEE or 0
> + * @optee_pcpu		per_cpu optee instance for per cpu work or NULL
> + * @notif_pcpu_wq	workqueue for per cpu aynchronous notification or NULL
> + * @notif_pcpu_work	work for per cpu asynchronous notification
> + */
>  struct optee_smc {
>  	optee_invoke_fn *invoke_fn;
>  	void *memremaped_shm;
>  	u32 sec_caps;
>  	unsigned int notif_irq;
> +	struct optee_pcpu __percpu *optee_pcpu;
> +	struct workqueue_struct *notif_pcpu_wq;
> +	struct work_struct notif_pcpu_work;
>  };
>  
>  /**
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..ffa3f3aa7244 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -993,12 +993,20 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
>  
>  static irqreturn_t notif_irq_handler(int irq, void *dev_id)

Wouldn't it be easier with one handler for shared irqs and one for
per-cpu irqs? The only common part is the do-while loop which I suppose
could go into a helper function.

>  {
> -	struct optee *optee = dev_id;
> +	struct optee *optee;
>  	bool do_bottom_half = false;
>  	bool value_valid;
>  	bool value_pending;
>  	u32 value;
>  
> +	if (irq_is_percpu_devid(irq)) {
> +		struct optee_pcpu __percpu *pcpu = (struct optee_pcpu *)dev_id;
> +
> +		optee = pcpu->optee;
> +	} else {
> +		optee = dev_id;
> +	}
> +
>  	do {
>  		value = get_async_notif_value(optee->smc.invoke_fn,
>  					      &value_valid, &value_pending);
> @@ -1011,8 +1019,13 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
>  			optee_notif_send(optee, value);
>  	} while (value_pending);
>  
> -	if (do_bottom_half)
> -		return IRQ_WAKE_THREAD;
> +	if (do_bottom_half) {
> +		if (irq_is_percpu_devid(irq))
> +			queue_work(optee->smc.notif_pcpu_wq, &optee->smc.notif_pcpu_work);

This line is a bit long, please break it.

> +		else
> +			return IRQ_WAKE_THREAD;
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -1025,7 +1038,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> +static int init_irq(struct optee *optee, u_int irq)
>  {
>  	int rc;
>  
> @@ -1040,12 +1053,96 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
>  	return 0;
>  }
>  
> +static void notif_pcpu_irq_work_fn(struct work_struct *work)
> +{
> +	struct optee_smc *optee_smc = container_of(work, struct optee_smc, notif_pcpu_work);

This line is a bit long, please break it.

> +	struct optee *optee = container_of(optee_smc, struct optee, smc);
> +
> +	optee_smc_do_bottom_half(optee->ctx);
> +}
> +
> +static int init_pcpu_irq(struct optee *optee, u_int irq)
> +{
> +	struct optee_pcpu __percpu *optee_pcpu;
> +	spinlock_t lock;
> +	int cpu;
> +	int rc;
> +
> +	optee_pcpu = alloc_percpu(struct optee_pcpu);
> +	if (!optee_pcpu)
> +		return -ENOMEM;
> +
> +	for_each_present_cpu(cpu) {
> +		struct optee_pcpu __percpu *p = per_cpu_ptr(optee_pcpu, cpu);
> +
> +		p->optee = optee;
> +	}
> +
> +	rc = request_percpu_irq(irq, notif_irq_handler,
> +				"optee_pcpu_notification", optee_pcpu);
> +	if (rc)
> +		goto err_free_pcpu;
> +
> +	spin_lock_init(&lock);
> +
> +	spin_lock(&lock);

What is the point with this spinlock?

> +	enable_percpu_irq(irq, 0);
> +	spin_unlock(&lock);
> +
> +	INIT_WORK(&optee->smc.notif_pcpu_work, notif_pcpu_irq_work_fn);
> +	optee->smc.notif_pcpu_wq = create_workqueue("optee_pcpu_notification");
> +	if (!optee->smc.notif_pcpu_wq) {
> +		rc = -EINVAL;
> +		goto err_free_pcpu_irq;
> +	}
> +
> +	optee->smc.optee_pcpu = optee_pcpu;
> +	optee->smc.notif_irq = irq;
> +
> +	return 0;
> +
> +err_free_pcpu_irq:
> +	spin_lock(&lock);
> +	disable_percpu_irq(irq);
> +	spin_unlock(&lock);
> +	free_percpu_irq(irq, optee_pcpu);
> +err_free_pcpu:
> +	free_percpu(optee_pcpu);
> +
> +	return rc;
> +}
> +
> +static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> +{
> +	if (irq_is_percpu_devid(irq))
> +		return init_pcpu_irq(optee, irq);
> +	else
> +		return init_irq(optee, irq);
> +}
> +
> +static void uninit_pcpu_irq(struct optee *optee)
> +{
> +	spinlock_t lock;
> +
> +	spin_lock_init(&lock);
> +	spin_lock(&lock);

What's the point with this spinlock?


Cheers,
Jens

> +	disable_percpu_irq(optee->smc.notif_irq);
> +	spin_unlock(&lock);
> +
> +	free_percpu_irq(optee->smc.notif_irq, optee->smc.optee_pcpu);
> +	free_percpu(optee->smc.optee_pcpu);
> +}
> +
>  static void optee_smc_notif_uninit_irq(struct optee *optee)
>  {
>  	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
>  		optee_smc_stop_async_notif(optee->ctx);
>  		if (optee->smc.notif_irq) {
> -			free_irq(optee->smc.notif_irq, optee);
> +			if (irq_is_percpu_devid(optee->smc.notif_irq))
> +				uninit_pcpu_irq(optee);
> +			else
> +				free_irq(optee->smc.notif_irq, optee);
> +
>  			irq_dispose_mapping(optee->smc.notif_irq);
>  		}
>  	}
> -- 
> 2.25.1
> 
