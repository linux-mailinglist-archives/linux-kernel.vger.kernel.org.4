Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4393B664021
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbjAJMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjAJMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:16:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C524313F8C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:14:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so9727328wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHh8nxWwQ2ER5e32XeVQ7NM4c6vgEsm+fKISUK1svR8=;
        b=nAdCrMZTpc8ErmKoOBUQzc9eEn1ZsanSz9b0scbXVqS6w1nvdwuOIsMMFL0RqecmJ4
         tjC1/VfqFQKhuo463460kBr7WYtc/s27tqxgLALo+EDR7lKHMVlwDUV4Sj7J4aLrqZCp
         dEa3l8ZN3cph9ZeyxG8j5yqOCkEQPB4CS6/V3VCR+tnIY7AtbyBFy0wiixJ+65+03rx9
         LOd3rYzHf+ja8jcpoRrXlK2/zMj0enN7oT7x/3tfWH8UyjIRx9m/ehrC0PCk1ydcNnLl
         LSRTjji2jAoYpjSM5dI+xB1KrGoinLei7HTJt5+EsLT95CELL3zXViZAQjeB0F5uC121
         Wkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHh8nxWwQ2ER5e32XeVQ7NM4c6vgEsm+fKISUK1svR8=;
        b=lvc4tpSBqcUREKzoYmQiaK1B1CDFur95aSBav/mMoVbCpfcLYyHabV01xNJ5yLX89s
         F4Dau+dTl/gzkGTlLxqA06pAm1hftCUNdXoMWUI96F3fYpSWYlIqCVyQUNhHgcBQBPbg
         ROX0nRirRAkDcpnwSoU4phw6R/TXFkjhJcSq16PmPBz3B5urdTgTCv3Y2Y+H16oKSxk5
         pr9zOQNdU8Ftd/RQa0l6op+m9yqe42sFBf228s4ly7Ok40c9u7joxaIgsufjZNip4yFS
         8Dw5kwh99gnsmyrXtQG6G9dNGaeaj05qdZNwMQK3JVMxSM1UOxRW5i1i1GM8sZJhf9Gl
         +aZg==
X-Gm-Message-State: AFqh2kpaEX4zktjvq5Rsgy03RBuUSr+dEAinmGczX9Z5eUInlaedSGoV
        DSdc98dH3a9g3809bUInKyOX/58YJ7oT9CrEPv8=
X-Google-Smtp-Source: AMrXdXs5JSy4z2vrWK484VxlJEr4i6iGPbRMJIGi22snWSxFTnEXwAYJeKZGBhGcWMjwTRGHHsC0TQ==
X-Received: by 2002:a05:600c:154b:b0:3cf:674a:aefe with SMTP id f11-20020a05600c154b00b003cf674aaefemr49135720wmg.22.1673352896283;
        Tue, 10 Jan 2023 04:14:56 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o19-20020a05600c339300b003cff309807esm18011555wmp.23.2023.01.10.04.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:14:55 -0800 (PST)
Message-ID: <b7470966-55f6-fee7-0014-2aae3048612e@linaro.org>
Date:   Tue, 10 Jan 2023 12:14:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V7 2/2] firmware: qcom: scm: Add wait-queue handling logic
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, robimarko@gmail.com,
        quic_gurus@quicinc.com
References: <20230110063745.16739-1-quic_sibis@quicinc.com>
 <20230110063745.16739-3-quic_sibis@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230110063745.16739-3-quic_sibis@quicinc.com>
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

Hi Sibi,

Few minor comments below,

On 10/01/2023 06:37, Sibi Sankar wrote:
> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> When the firmware (FW) supports multiple requests per VM, multiple requests
> from the same/different VM can reach the firmware at the same time. Since
> the firmware currently being used has limited resources, it guards them
> with a resource lock and puts requests on a wait-queue internally and
> signals to HLOS that it is doing so. It does this by returning a new return
> value in addition to success or error: SCM_WAITQ_SLEEP. A sleeping SCM call
> can be woken up by an interrupt that the FW raises.
> 
...

>   drivers/firmware/qcom_scm-smc.c | 90 ++++++++++++++++++++++++++++++---
>   drivers/firmware/qcom_scm.c     | 89 +++++++++++++++++++++++++++++++-
>   drivers/firmware/qcom_scm.h     |  8 +++
>   3 files changed, 179 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
> index d111833364ba..30999f04749c 100644
> --- a/drivers/firmware/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom_scm-smc.c
...
> +static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_args *waitq,
> +					   struct arm_smccc_res *res)
> +{
> +	int ret;
> +	struct arm_smccc_args resume;
> +	u32 wq_ctx, smc_call_ctx, flags;
> +	struct arm_smccc_args *smc = waitq;
> +
> +	do {
> +		__scm_smc_do_quirk(smc, res);
> +
> +		if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
> +			wq_ctx = res->a1;
> +			smc_call_ctx = res->a2;
> +			flags = res->a3;
> +
> +			if (!dev)
> +				return -EPROBE_DEFER;

why are we checking dev pointer in the middle of the call?
A comment here would really help readers.

> +
> +			ret = qcom_scm_lookup_completion(wq_ctx);
> +			if (ret)
> +				return ret;
> +
> +			fill_wq_resume_args(&resume, smc_call_ctx);
> +			smc = &resume;
> +		}
> +	} while (res->a0 == QCOM_SCM_WAITQ_SLEEP);
> +
> +	return 0;
> +}
> +
...
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54c8146..19ac506a9b1f 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -4,6 +4,7 @@
>    */
>   #include <linux/platform_device.h>
>   #include <linux/init.h>
> +#include <linux/interrupt.h>
>   #include <linux/cpumask.h>
>   #include <linux/export.h>
>   #include <linux/dma-mapping.h>
> @@ -13,6 +14,7 @@
>   #include <linux/qcom_scm.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <linux/of_platform.h>
>   #include <linux/clk.h>
>   #include <linux/reset-controller.h>

include <linux/completion.h> ??


> @@ -33,6 +35,7 @@ struct qcom_scm {
>   	struct clk *iface_clk;
>   	struct clk *bus_clk;
>   	struct icc_path *path;
> +	struct completion waitq_comp;
>   	struct reset_controller_dev reset;
>   
>   	/* control access to the interconnect path */
> @@ -63,6 +66,9 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>   	BIT(2), BIT(1), BIT(4), BIT(6)
>   };
>   
> +#define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
> +#define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
> +
>   static const char * const qcom_scm_convention_names[] = {
>   	[SMC_CONVENTION_UNKNOWN] = "unknown",
>   	[SMC_CONVENTION_ARM_32] = "smc arm 32",
> @@ -1325,11 +1331,79 @@ bool qcom_scm_is_available(void)
>   }
>   EXPORT_SYMBOL(qcom_scm_is_available);
>   
> +static struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
> +{
> +	/* assert wq_ctx is zero */ > +	if (wq_ctx != 0) {

Is this correct? looks like zero is the only valid one.

I thought wq_ctx was a unique number (UID).

> +		dev_err(scm->dev, "No waitqueue found for wq_ctx %d\n", wq_ctx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return &scm->waitq_comp;
> +}
> +
> +int qcom_scm_lookup_completion(u32 wq_ctx)
> +{
> +	struct completion *wq = NULL;
> +
> +	wq = qcom_scm_lookup_wq(__scm, wq_ctx);
> +	if (IS_ERR(wq))
> +		return PTR_ERR(wq);
> +
> +	wait_for_completion(wq);

We can potentially block here forever without a timeout.

As you are reusing completion, I have not seen any reinitialization of 
completion, this could potentially return above line without waiting at all.

> +
> +	return 0;
> +}
> +
> +static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx, bool wake_all)
> +{
> +	struct completion *wq_to_wake;
> +
> +	wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
> +	if (IS_ERR(wq_to_wake))
> +		return PTR_ERR(wq_to_wake);
> +
> +	if (wake_all)
> +		complete_all(wq_to_wake);
> +	else
> +		complete(wq_to_wake);

> +
> +	return 0;
> +}
> +
> +static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
> +{
> +	int ret;
> +	struct qcom_scm *scm = data;
> +	u32 wq_ctx, flags, more_pending = 0;
> +
> +	do {
> +		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
> +		if (ret) {
> +			dev_err(scm->dev, "GET_WQ_CTX SMC call failed: %d\n", ret);
> +			goto out;
> +		}
> +
> +		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE &&
> +		    flags != QCOM_SMC_WAITQ_FLAG_WAKE_ALL) {
> +			dev_err(scm->dev, "Invalid flags found for wq_ctx: %u\n", flags);
> +			goto out;
> +		}
> +
> +		ret = qcom_scm_waitq_wakeup(scm, wq_ctx, !!(flags & QCOM_SMC_WAITQ_FLAG_WAKE_ALL));
> +		if (ret)
> +			goto out;
> +	} while (more_pending);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
>   static int qcom_scm_probe(struct platform_device *pdev)
>   {
>   	struct qcom_scm *scm;
>   	unsigned long clks;
> -	int ret;
> +	int irq, ret;
>   
>   	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
>   	if (!scm)
> @@ -1402,6 +1476,19 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	__scm = scm;
>   	__scm->dev = &pdev->dev;
>   
> +	init_completion(&__scm->waitq_comp);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -ENXIO)
> +			return irq;
> +	} else {
> +		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
> +						IRQF_ONESHOT, "qcom-scm", __scm);
> +		if (ret < 0)
> +			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
> +	}
> +
>   	__get_convention();
>   
>   	/*

--srini
