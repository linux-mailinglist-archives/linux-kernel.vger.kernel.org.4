Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4B70F4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjEXLRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:17:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3707C5;
        Wed, 24 May 2023 04:17:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so1615761a12.1;
        Wed, 24 May 2023 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684927068; x=1687519068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1aqK7Ud0k9NZcXoizSkxgHpUDinNYt7aEGaaazv/Z8=;
        b=M64Z8XD90NwQvjtSENRZLkYlvy3y0h4xXTeCMpaFe3Nvg7W+2i+x6uzNnrOxOpT9cC
         I4FuijR/msNkzgjIh4JqMRWmxNvfjp0e1cErAl9eIax4U0pSa+jlozPO9dV9JJ5pH5lZ
         a63cl6WnjP4k7MZKymPo9p73MP19YPZmy1WXkguGx3M9dB5mTp9Mdtw9DOtHVwkVtEdl
         cRuRCw8aToFYwPEYJu318peRGvyzNY4jPQ7l2ZByZgm/catuEzNKFu5rAv/6hbrxVviK
         8z9mAQ+zKhyYqHdihcWlxRuSz7Vq+77BbVCK7K1TjZbNpcrBVOLgOITiDVX3hshc++eG
         r85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684927068; x=1687519068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1aqK7Ud0k9NZcXoizSkxgHpUDinNYt7aEGaaazv/Z8=;
        b=ViaQ0jABN9h0Ui+ZI4M83FCkeDCdba4VvTxGaQyLoZOlE+kLlca2tZ2OVXhMy2yRsD
         Jn0AFDiKOcyNibxvcB37yPXdZEf0mN651sZFJmRG8O9xcKpPKOLSq5xtTC5ClYymF51S
         FVKGTAfD8K67mqdaJ1zK94izkn0M5KB004APolnbju5kyFomQkqSzgiZ6zIK6mF1UeoI
         VX7h3s/SyN18iW0WH/Ppb/ytUMKZ2xGRDH/ED6gBzV0zNeVupctRliW1yPmlFeR+Xrzj
         AItoeM+IwTRgAONhf8qlBUyz/kWyyOuvfAXEXgPqJGuTjTnyFm5wvjkCEVhXEIOdc3Gt
         qTdg==
X-Gm-Message-State: AC+VfDwt0z6vr4is93bl9KL8fFzhwoVEr3YHAHgrfm6Lyu1JtXEzP1wo
        MTM3s10PUjFMdvKdp4PO2YQ=
X-Google-Smtp-Source: ACHHUZ5E+uzRTP/jxOVJKqtttOPDyek7yNaAEC3dr/1xLcSEeoVvv4hI6zSfl4xIC+s8uMB4UwtZXg==
X-Received: by 2002:a17:907:3f27:b0:96f:bf78:c380 with SMTP id hq39-20020a1709073f2700b0096fbf78c380mr12197141ejc.55.1684927068200;
        Wed, 24 May 2023 04:17:48 -0700 (PDT)
Received: from [192.168.3.32] ([213.149.38.146])
        by smtp.gmail.com with ESMTPSA id kg1-20020a17090776e100b009664e25c425sm5637404ejc.95.2023.05.24.04.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 04:17:47 -0700 (PDT)
Message-ID: <248ebc1b-d077-e424-8f36-6c143b0ed697@gmail.com>
Date:   Wed, 24 May 2023 13:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/13] firmware: qcom: scm: Introduce pas_metadata context
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
 <20220128025513.97188-2-bjorn.andersson@linaro.org>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20220128025513.97188-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28. 01. 2022. 03:55, Bjorn Andersson wrote:
> Starting with Qualcomm SM8450, some new security enhancements has been
> done in the secure world, which results in the requirement to keep the
> metadata segment accessible by the secure world from init_image() until
> auth_and_reset().
>
> Introduce a "PAS metadata context" object that can be passed to
> init_image() for tracking the mapped memory and a related release
> function for client drivers to release the mapping once either
> auth_and_reset() has been invoked or in error handling paths on the way
> there.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Hi Bjorn,
I know a lot of time has passed since this patch, but this patch breaks 
qcom_scm_pas_auth_and_reset SCM call.
I have had MDT loader and SCM changes from this series reverted for a 
long time but was unable to
find the exact culprit nor how to fix it.
I even ported the TZ log driver to see if anything is obvious there but 
nope, calling qcom_scm_pas_auth_and_reset
after this patch is just failling which is then causing Q6 WCSS on 
IPQ8074 to fail probing so WLAN doesnt work.

Since I am out of ideas, I was hoping that you maybe have an idea what 
could be the issue, I can provide the TZ log
with all of the SCM calls when it works and when not if required.

Regards,
Robert

> ---
>   drivers/firmware/qcom_scm.c   | 39 ++++++++++++++++++++++++++++++-----
>   drivers/soc/qcom/mdt_loader.c |  2 +-
>   include/linux/qcom_scm.h      | 10 ++++++++-
>   3 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 7db8066b19fd..3218d13cbf83 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -435,10 +435,16 @@ static void qcom_scm_set_download_mode(bool enable)
>    *		and optional blob of data used for authenticating the metadata
>    *		and the rest of the firmware
>    * @size:	size of the metadata
> + * @ctx:	optional metadata context
>    *
> - * Returns 0 on success.
> + * Return: 0 on success.
> + *
> + * Upon successful return, the PAS metadata context (@ctx) will be used to
> + * track the metadata allocation, this needs to be released by invoking
> + * qcom_scm_pas_metadata_release() by the caller.
>    */
> -int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
> +int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
> +			    struct qcom_scm_pas_metadata *ctx)
>   {
>   	dma_addr_t mdata_phys;
>   	void *mdata_buf;
> @@ -467,7 +473,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
>   
>   	ret = qcom_scm_clk_enable();
>   	if (ret)
> -		goto free_metadata;
> +		goto out;
>   
>   	desc.args[1] = mdata_phys;
>   
> @@ -475,13 +481,36 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
>   
>   	qcom_scm_clk_disable();
>   
> -free_metadata:
> -	dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
> +out:
> +	if (ret < 0 || !ctx) {
> +		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
> +	} else if (ctx) {
> +		ctx->ptr = mdata_buf;
> +		ctx->phys = mdata_phys;
> +		ctx->size = size;
> +	}
>   
>   	return ret ? : res.result[0];
>   }
>   EXPORT_SYMBOL(qcom_scm_pas_init_image);
>   
> +/**
> + * qcom_scm_pas_metadata_release() - release metadata context
> + * @ctx:	metadata context
> + */
> +void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
> +{
> +	if (!ctx->ptr)
> +		return;
> +
> +	dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
> +
> +	ctx->ptr = NULL;
> +	ctx->phys = 0;
> +	ctx->size = 0;
> +}
> +EXPORT_SYMBOL(qcom_scm_pas_metadata_release);
> +
>   /**
>    * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
>    *			      for firmware loading
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 72fc2b539213..b00586db5391 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -171,7 +171,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>   			goto out;
>   		}
>   
> -		ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len);
> +		ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len, NULL);
>   
>   		kfree(metadata);
>   		if (ret) {
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 81cad9e1e412..4d8371410b05 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -68,8 +68,16 @@ extern int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus);
>   extern void qcom_scm_cpu_power_down(u32 flags);
>   extern int qcom_scm_set_remote_state(u32 state, u32 id);
>   
> +struct qcom_scm_pas_metadata {
> +	void *ptr;
> +	dma_addr_t phys;
> +	ssize_t size;
> +};
> +
>   extern int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
> -				   size_t size);
> +				   size_t size,
> +				   struct qcom_scm_pas_metadata *ctx);
> +void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
>   extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
>   				  phys_addr_t size);
>   extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
