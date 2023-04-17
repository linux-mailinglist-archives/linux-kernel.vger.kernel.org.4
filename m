Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF526E4FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDQSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:01:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B13C18;
        Mon, 17 Apr 2023 11:01:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ok10so4584488qvb.11;
        Mon, 17 Apr 2023 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681754478; x=1684346478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4rWaDRbIsEYCkJ4JgcLhembW9iS0xspLr0fhQH37Sw=;
        b=La+bbbCoAyu+27ta7XGSfN08k5ypKB78xHNEUTMDDzMGc4t9JuxiLD8bPx1wxqoazh
         2ClgJMoCeRfDpNR+yK0/AeEKv3mIEy3iXXkctN+sfe7WiRo2qV6LaumeL/1JtXIiPOPS
         7BP6cY7jNwQ/Rj+IYjFIJcQOp1G0TfWLlkVK719xaxjue9Hy8nnFIXirEfx6vcewwDUk
         oZwqtHvKqq8urXp41tMRtGe5eBT+o3jPdN9/fAs4ZVrfL+7XRbQNg3EiyyjziX32UA0m
         lL41EfNBFqtiszSzYtWVvGdmg+OczINwa/Kn4tAJwrpT+gghXnVJWWNBZ97vqsABxRiK
         9dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681754478; x=1684346478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4rWaDRbIsEYCkJ4JgcLhembW9iS0xspLr0fhQH37Sw=;
        b=hoOnWwDpfMF7LtauY1KR2sGhYB11HK4svj1bHuuTnHQeP3T8D+FykrnN9N5Gh7OtUI
         i9Rgaw6Li3zjUPttrgagb0c9o/15Nnl/+vazCVYaIHbeJkeqfM1yN+1KbPGfUZfVgLH/
         QtbpAJGZCyiSmrI+wzWmAGue+uEzS0GBD9juYTbH48rtczuCcyFXC27JsdAwFskJS3v4
         F2/9jEcw/EjTZH5ieADnHD1J5GxfulGl/9EBEZBXrnQEQTJtaLP5lHR6bQyMlvaJukN+
         oKc4tZoQUz7bH2x/Z1GSCUFfHaoQP9ufHs/QJRSRnuZY8xPV9wdb+uJLO0LNrq6qJfJa
         DFFw==
X-Gm-Message-State: AAQBX9duFVj2PGlTbolQGwdmd5VLgbJQBMVwl7of0igvVaatLBATtnav
        rNWaLmKWULVs0rGQbuvzyU4=
X-Google-Smtp-Source: AKy350ZOA7j6Z/Q3tebjfx452OZg5qJsoggSPjaIHDa83M8wEqY2gtjujdlJqtfF2jkRJIlihZ2KOw==
X-Received: by 2002:a05:6214:1c86:b0:5ef:4435:f1cd with SMTP id ib6-20020a0562141c8600b005ef4435f1cdmr13827361qvb.27.1681754477735;
        Mon, 17 Apr 2023 11:01:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c204-20020a379ad5000000b0074ced3e0004sm723041qke.63.2023.04.17.11.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 11:01:17 -0700 (PDT)
Message-ID: <02b34c80-f37e-deee-29cd-de7db902797d@gmail.com>
Date:   Mon, 17 Apr 2023 11:01:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameter
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230417174401.19563-1-quic_nkela@quicinc.com>
 <20230417174401.19563-3-quic_nkela@quicinc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230417174401.19563-3-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 10:44, Nikunj Kela wrote:
> This patch add support for passing shmem channel address as parameter
> in smc/hvc call. This patch is useful when multiple scmi instances are
> using same smc-id and firmware needs to distiguish among the instances.

Typo: distinguish.

It really would have been a lot clearer and made a whole lot more sense 
to encode a VM ID/channel number within some of the SMCCC parameters, 
possibly as part of the function ID itself.

> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>   drivers/firmware/arm_scmi/driver.c |  1 +
>   drivers/firmware/arm_scmi/smc.c    | 25 ++++++++++++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index e7d97b59963b..b5957cc12fee 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2914,6 +2914,7 @@ static const struct of_device_id scmi_of_match[] = {
>   #endif
>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>   	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
> +	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
>   #endif
>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>   	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 93272e4bbd12..e28387346d33 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -20,6 +20,9 @@
>   
>   #include "common.h"
>   
> +#define lower32(x)	((u32)((x) & 0xffffffff))
> +#define upper32(x)	((u32)(((u64)(x) >> 32) & 0xffffffff))

Cannot you use the existing lower_32_bits and upper_32_bits macros from 
kernel.h here?

> +
>   /**
>    * struct scmi_smc - Structure representing a SCMI smc transport
>    *
> @@ -30,6 +33,8 @@
>    * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
>    *	      Used when operating in atomic mode.
>    * @func_id: smc/hvc call function id
> + * @is_smc64: smc/hvc calling convention type 64 vs 32
> + * @param: physical address of the shmem channel
>    */
>   
>   struct scmi_smc {
> @@ -40,6 +45,8 @@ struct scmi_smc {
>   #define INFLIGHT_NONE	MSG_TOKEN_MAX
>   	atomic_t inflight;
>   	u32 func_id;
> +	bool is_smc64;
> +	phys_addr_t param;
>   };
>   
>   static irqreturn_t smc_msg_done_isr(int irq, void *data)
> @@ -137,6 +144,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   	if (ret < 0)
>   		return ret;
>   
> +	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
> +		scmi_info->param = res.start;

There is not even a check that this is going to be part of the kernel's 
view of memory, that seems a bit brittle and possibly a security hole, 
too. Your hypervisor presumably needs to have carved out some amount of 
memory in order for the messages to be written to/read from, and so 
would the VM kernel, so eventually we should have a 'reserved-memory' 
entry of some sort, no?

>   	/*
>   	 * If there is an interrupt named "a2p", then the service and
>   	 * completion of a message is signaled by an interrupt rather than by
> @@ -156,6 +165,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   	}
>   
>   	scmi_info->func_id = func_id;
> +	scmi_info->is_smc64 = ARM_SMCCC_IS_64(func_id);
>   	scmi_info->cinfo = cinfo;
>   	smc_channel_lock_init(scmi_info);
>   	cinfo->transport_info = scmi_info;
> @@ -188,7 +198,20 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>   
>   	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>   
> -	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
> +#ifdef CONFIG_ARM64
> +	/*
> +	 * if SMC32 convention is used, pass 64 bit address in
> +	 * two parameters
> +	 */
> +	if (!scmi_info->is_smc64)

There is no need for scmi_info to store is_smc64, just check the func_id 
here and declare is_smc64 as a local variable to the function.

Also, another way to approach this would be to encode the parameters 
region in 4KB units such that event on a 32-bit system with LPAE you are 
guaranteed to fit the region into a 32-bit unsigned long. AFAIR 
virtualization and LPAE are indistinguishable on real CPUs?

> +		arm_smccc_1_1_invoke(scmi_info->func_id,
> +				     lower32(scmi_info->param),
> +				     upper32(scmi_info->param),
> +				     0, 0, 0, 0, 0, &res);
> +	else
> +#endif
> +		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param,
> +				     0, 0, 0, 0, 0, 0, &res);
>   
>   	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
>   	if (res.a0) {

-- 
Florian

