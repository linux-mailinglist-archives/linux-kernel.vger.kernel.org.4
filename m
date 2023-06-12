Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82C72C3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjFLMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:04:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7F93
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:04:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so30842465e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686571449; x=1689163449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/WwQ7peSickvRK8UbVo3rJqxpw6vCZZCbW1F+Gubv0=;
        b=cWEtlLtdKG8iRdS9x/3Wm4yHpmckwY2Wed37J+iRl/mv8Pfcj/WzRbqwI9l9Ycxb3v
         yIQaNWHQMO/3pEuXQdwOOzwO/mSOfWHT71pBPFPkqXjljCyNyMCEXKokWtarEn4K6UrI
         eBNoThB0aUq+7+DKdBuzQciHcjOQdLBbGvUiYSJijONvD7l0jSs+Q9Xf6Bm2V439wG56
         xjjCNZLneJ48Akn5SIMzS077UGsbegBrZT3xmCBYrwsbZW4L+IGZu362DtzJdY+QzA1q
         iaWRpcerrs3eOj3M7ZE8Ly2ztp7g3a4szWO/Umqv1aSxE8suPeqW52mbwfywnklhqOH4
         WLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686571449; x=1689163449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/WwQ7peSickvRK8UbVo3rJqxpw6vCZZCbW1F+Gubv0=;
        b=I2rZ4dWbY8P9GYH4wVjpp5cwNGGR0/kpfrJvXoUrx8nGmtfGRLpDb/EF7Ngza5U7aV
         wUxWMSABeQ6B2z3m9PxzrYW7FmndNSzxu+O3veiZM42LgTjKyolFK+bIgCbA4zmkaaqu
         6RNlvzDGqeyzlh3vMhf7h4yIl+uwKusVDU5PbYOhWdrlTC4lt2I8vlES9I4oa1H0/UiX
         wJx4jdXDz3h/tP9cvW0l7cEnpxjW5jzKuOvIUoXNwhVOtqQApC66PkX4NdrEzEwzxY3L
         E94uFhg6mFSUGlYmeS+NdjFPX1XFZQgywVE8DSK3Fof4ajjvDpoMf+wd42GGmvasbPBz
         i2sw==
X-Gm-Message-State: AC+VfDwTl3HhBgCHNtsRRFzrYQbvLooGFv5nab48c2c2BggxEaW49sMS
        dHNk6Rdye4uiejUrHs+O4/COhw==
X-Google-Smtp-Source: ACHHUZ46AYNoZiNh+AhcSDAgZyYsFP+XfFtRxyp1QSw4uGzz+2Fa0fgAmefCKNxklFotYJ1m5nTAdg==
X-Received: by 2002:a7b:c410:0:b0:3f8:1d98:15af with SMTP id k16-20020a7bc410000000b003f81d9815afmr1257263wmi.22.1686571449056;
        Mon, 12 Jun 2023 05:04:09 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z20-20020a1c4c14000000b003f80946116dsm9618975wmf.45.2023.06.12.05.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:04:08 -0700 (PDT)
Message-ID: <81343778-6d5c-db85-29e3-8fcba0ec2e8a@linaro.org>
Date:   Mon, 12 Jun 2023 13:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] misc: fastrpc: Fix remote heap allocation request
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
References: <1685974276-23435-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1685974276-23435-1-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2023 15:11, Ekansh Gupta wrote:
> Remote heap is used by DSP audioPD on need basis. This memory is
> allocated from reserved CMA memory region and is then shared with
> audioPD to use it for it's functionality.
> 
> Current implementation of remote heap is not allocating the memory
> from CMA region, instead it is allocating the memory from SMMU
> context bank. The arguments passed to scm call for the reassignment
> of ownership is also not correct. Added changes to allocate CMA
> memory and have a proper ownership reassignment.
> 
> Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
> Cc: stable <stable@kernel.org>
> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..f5fc2de 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1866,7 +1866,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>   		return -EINVAL;
>   	}
>   
> -	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
> +	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
> +		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
> +	else
> +		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
> +
>   	if (err) {
>   		dev_err(dev, "failed to allocate buffer\n");
>   		return err;
> @@ -1905,12 +1909,22 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>   
>   	/* Add memory to static PD pool, protection thru hypervisor */
>   	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
> -		struct qcom_scm_vmperm perm;
> +		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> +		struct qcom_scm_vmperm *dst_perms;
> +		u32 i;
>   
> -		perm.vmid = QCOM_SCM_VMID_HLOS;
> -		perm.perm = QCOM_SCM_PERM_RWX;
> -		err = qcom_scm_assign_mem(buf->phys, buf->size,
> -			&fl->cctx->perms, &perm, 1);
> +		dst_perms = kcalloc(fl->cctx->vmcount,
> +			sizeof(struct qcom_scm_vmperm), GFP_KERNEL);
> +		if (!dst_perms)
> +			return -ENOMEM;
> +		for (i = 0; i < fl->cctx->vmcount; i++) {
> +			dst_perms[i].vmid = fl->cctx->vmperms[i].vmid;
> +			dst_perms[i].perm = fl->cctx->vmperms[i].perm;
> +		}
> +
Why not use fl->cctx->vmperms instead of allocating a new dst_perms?

--srini

> +		err = qcom_scm_assign_mem(buf->phys,(u64)buf->size,
> +			&src_perms, dst_perms, fl->cctx->vmcount);
> +		kfree(dst_perms);
>   		if (err) {
>   			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
>   					buf->phys, buf->size, err);
