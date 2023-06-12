Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FF72C2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjFLLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjFLLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:33:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F038228
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:10:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso4806395e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686568234; x=1689160234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wD+biu0ZIn2TjFvFNPymCrPjn0dWNSM6m/3jx0dQi+c=;
        b=dOAEbhc6ckpLkhFKYR0jUipojb2aoSBd48zFmz978c11p8Ae3R0+5MbI5SM5LubK1M
         BkDuewK3cKhzhm7RTjTn8aAudAU5++XoRuo5t7bujPJCCGwSRNENtGjOc9mdovD/XLPy
         ONtHghwu/jXmgsNiNFzJSvCtUd5kSvJS8soJTycLJJF+rRNJATTHgyfJjJMD0UaN/PCm
         i4jb3d16+zo2BrJMYEW+jnZ6A4zPwsBWxJ35jQAUjkED2gJTjAAtljLESJbj2EZe6iMl
         rABn7K0E1LJ7JXfQL9MjzlvWlSjSCYRGt2rVpAUQvBU1ZDa5I0sadmxwKZekAisQIS6R
         OwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686568234; x=1689160234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD+biu0ZIn2TjFvFNPymCrPjn0dWNSM6m/3jx0dQi+c=;
        b=Z1+gwBRvK8fCwwY3znN3HnaOMYw2lOqN02N5DpLNE2bW3J4lTnrDzIBFY+wHjANP2X
         dWn7aER1JOjSj8E+3wH4X0YjSoarwIvFBMyOcvBhHSLT6HThzyxjDYoj8Rgs4B3ZMBNj
         qu2GW42viLBS6Wh4lkXHWuEE4eZVtFNydmr6B/0HA8+T1h3AkdFL4+VSZDrJtVSygt3+
         zBtgaC75FqXYZdtJm88Xr0V9uz9T8zSxFl6wlnvLBQE+UuN7Kzp/84j66lYG+qKdIcgr
         B0PEDmsZK3RAttCeWafdayD/VLhlaJWIUN7kSHljtsrfCz+qbiJtA8uGDeI02h9NxnhI
         MKSg==
X-Gm-Message-State: AC+VfDyNZOOPfbDWruJM7iemahsaFL3OM/4iLkehwW72TR2rshhfMGQ+
        JqgAXU5YnMXUQyu5d1msAoYdkw==
X-Google-Smtp-Source: ACHHUZ4s0Jzo/H5twPl2OCe+G81QZxwH1pFYWS1cMpaZ76zkhGyTtMgwP3YcEQnNXaw0GvgMgmhfRQ==
X-Received: by 2002:a19:6518:0:b0:4e8:c81b:1a11 with SMTP id z24-20020a196518000000b004e8c81b1a11mr4413822lfb.49.1686568233526;
        Mon, 12 Jun 2023 04:10:33 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m19-20020a7bcb93000000b003f7f4b7f286sm11131846wmi.12.2023.06.12.04.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 04:10:33 -0700 (PDT)
Message-ID: <16d255fc-7186-11a9-58b5-2d3787f69d59@linaro.org>
Date:   Mon, 12 Jun 2023 12:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] misc: fastrpc: Pass proper scm arguments for static
 process init
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
References: <1685972918-30371-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1685972918-30371-1-git-send-email-quic_ekangupt@quicinc.com>
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

Thanks Ekansh for the patch.


On 05/06/2023 14:48, Ekansh Gupta wrote:
> Memory is allocated for dynamic loading when audio daemon is trying
> to attach to audioPD on DSP side. This memory is allocated from
> reserved CMA memory region and needs ownership assignment to
> new VMID in order to use it from audioPD.
> 
> In the current implementation, arguments are not correctly passed
> to the scm call which might result in failure of dynamic loading
> on audioPD. Added changes to pass correct arguments during daemon
> attach request.
> 
> Fixes: 	0871561055e6 ("misc: fastrpc: Add support for audiopd")
> Cc: stable <stable@kernel.org>
> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..b7335dd 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1278,10 +1278,23 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   
>   		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
>   		if (fl->cctx->vmcount) {
> +			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);

This is redundant too, we already have cctx->perms initialized to 
exactly same bit map.

> +			struct qcom_scm_vmperm *dst_perms;
> +			u32 i;
> +
> +			dst_perms = kcalloc(fl->cctx->vmcount,
> +							sizeof(struct qcom_scm_vmperm), GFP_KERNEL);
> +			if (!dst_perms)
> +				return -ENOMEM;
> +			for (i = 0; i < fl->cctx->vmcount; i++) {
> +				dst_perms[i].vmid = fl->cctx->vmperms[i].vmid;
> +				dst_perms[i].perm = fl->cctx->vmperms[i].perm;

why do we need to copy this to another struct when we already have this 
information in fl->cctx->vmperms ?

> +			}
> +
>   			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>   							(u64)fl->cctx->remote_heap->size,
> -							&fl->cctx->perms,
> -							fl->cctx->vmperms, fl->cctx->vmcount);
> +							&src_perms, dst_perms, fl->cctx->vmcount);


> +			kfree(dst_perms);
>   			if (err) {
>   				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
>   					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
> @@ -1322,13 +1335,19 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   	return 0;
>   err_invoke:
>   	if (fl->cctx->vmcount) {
> -		struct qcom_scm_vmperm perm;
> +		u64 src_perms = 0;
> +		struct qcom_scm_vmperm dst_perms;
> +		u32 i;
>   
> -		perm.vmid = QCOM_SCM_VMID_HLOS;
> -		perm.perm = QCOM_SCM_PERM_RWX;
> +		for (i = 0; i < fl->cctx->vmcount; i++) {
> +			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
> +		}
no need for brackets here.
> +
> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
>   		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>   						(u64)fl->cctx->remote_heap->size,
> -						&fl->cctx->perms, &perm, 1);
> +						&src_perms, &dst_perms, 1);
>   		if (err)
>   			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
>   				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
