Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472406C1E49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjCTRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjCTRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:40:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E54200
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:36:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so49859519edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679333758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaK1FcRwkMamAspffUihcNnqOOe0rFedFLTh7UEKOP4=;
        b=q2+0GQ4ca+9rxW4ELMVguPlAgyC5BI4CYHivIaVymMM/+m4Ok0xDQO8UJ19SyNcBWq
         10ZQq1kP32zhH9N8MA9T4UMG+Dh91sCFYAdHsjax6WxqhpXE6ejWfyBeqMRbd33xpti7
         vpJTQnwsCzLQIWD7RQSPojO5PLIkBkM06ArztABv9YTVTGYToZ9kvK9MedLE5fyEEXYk
         7foy6P5h2iZMRFUg9VtpIDRITqq5C5me0ADZkT622Mc0v8GPQavi5q0+y85zWLmsZrVg
         bq+zT2zSk6Uk7g8BbZNPvSeRVkoe/RWzy4oAxuYzXP32rLM2ATiA+/YpMc9sHhNu/rAP
         CYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaK1FcRwkMamAspffUihcNnqOOe0rFedFLTh7UEKOP4=;
        b=Hw7l+aRo5RoOUm4pfNRy8RDHi/1PQ7iyDeaGmYueHAtbaEBnlun6CIjAnNI/7CmWp1
         sriRedL8O2c9qtQDshQOnTOB9DwrCqk9z8pWmjltrChDu5SKaWqCVa9Q1YxxotA0US6U
         kVZDFSGPDxlUWRaOENKRv+9RJaSXQRoxHDqKcgAbI0JqdcgLJsrt47mDgt67WhzoQB1h
         rfZxNDpKMHONnnxuHWrtaApmYP8PeBhbn8NFehyMHpAlo/HUO4YhUsADg2RMy8Kr/dJe
         OI6qP9VkNOeA2XR51FJqFJLnqPQUPI0iX4rDssU4jUuT72kETuGGr8j80TOQTimPQgl4
         8OZQ==
X-Gm-Message-State: AO0yUKUNO3hj2gz/cNEb87zKLVmwP39GHVg2jF8kAIRm44cnw593xyLG
        h3R61+oy/zFEtZifA/0YDBUwXIeJrkQHvXzo2OE=
X-Google-Smtp-Source: AK7set9Qw6i6STl9atpvvImsPZbi6y7G4oN8QkTErnRZmai4FnQgeTcK8ajIj7MGNIOK5VLlRA9ThQ==
X-Received: by 2002:a17:907:3f95:b0:935:1565:d661 with SMTP id hr21-20020a1709073f9500b009351565d661mr3929597ejc.66.1679333757942;
        Mon, 20 Mar 2023 10:35:57 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r29-20020a50d69d000000b004c2158e87e6sm5132110edi.97.2023.03.20.10.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:35:57 -0700 (PDT)
Message-ID: <eb23cc13-9738-8e82-6b13-76cc7ccbe280@linaro.org>
Date:   Mon, 20 Mar 2023 17:35:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/5] firmware: qcom_scm: provide a read-modify-write
 function
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
 <1679070482-8391-2-git-send-email-quic_mojha@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1679070482-8391-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2023 16:27, Mukesh Ojha wrote:
> It was released by Srinivas K. that there is a need of
> read-modify-write scm exported function so that it can
> be used by multiple clients.
> 
> Let's introduce qcom_scm_io_update_field() which masks
> out the bits and write the passed value to that
> bit-offset. Subsequent patch will use this function.
> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/firmware/qcom_scm.c            | 15 +++++++++++++++
>   include/linux/firmware/qcom/qcom_scm.h |  2 ++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 3e020d1..aca2556 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -407,6 +407,21 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>   
> +int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, unsigned int val)
> +{
> +	unsigned int old, new;
> +	int ret;
> +
> +	ret = qcom_scm_io_readl(addr, &old);
> +	if (ret)
> +		return ret;
> +
> +	new = (old & ~mask) | val;

thanks for doing this,

With field semantics, val should be shifted within the function, so the 
caller only sets value for field rather than passing a shifted value.
so this should be:

new = (old & ~mask) | (val << ffs(mask) - 1);


--srini



> +
> +	return qcom_scm_io_writel(addr, new);
> +}
> +EXPORT_SYMBOL(qcom_scm_io_update_field);
> +
>   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   {
>   	struct qcom_scm_desc desc = {
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index 1e449a5..203a781 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -84,6 +84,8 @@ extern bool qcom_scm_pas_supported(u32 peripheral);
>   
>   extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>   extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> +extern int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask,
> +				    unsigned int val);
>   
>   extern bool qcom_scm_restore_sec_cfg_available(void);
>   extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
