Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC465D3FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbjADNSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbjADNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:18:24 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB93BA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:18:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m18so82301623eji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 05:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84fez/ucWTww6NSVV6G0atDkJcgY0oGG1v+FAR1TxNY=;
        b=JAgCx2eqLgGc08EMjQPLJLJdM45V4H24UGXWCqCVcWPnLC4RuTaC39AX5sQnrkz2Ok
         /ukjXXhCKa1m3/Co+aDvmf7nqhkWG8e0qbvF3ec77Sq3udTiqU5A7TuQeb7nWxZxqrK/
         Kh+8jlqycp7H1ONgeowiSQSMImrMRKnWZELw3GHUqKswDca3xGcU7HOvLOg74zT8RoJo
         YqrH7o9715DW21d928mrvGgGanh50mhKM4rqZbcRA+W8vrExPYly+InUk4Q05GgH91zh
         psQFK3XZyCbanbMLOiU+7CkjwDVJrV9FB43AD/MymRnBr/iZ8VmW0sw2XhElkb/EbKvx
         7hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84fez/ucWTww6NSVV6G0atDkJcgY0oGG1v+FAR1TxNY=;
        b=rfUQfrcGwbjEivKnqMXqnc7UVzycbEeMBVeZ51wjq7ar33RiRKSGDX9a8yAQQkQ7Vo
         8PC4Kxh5EZxA1ui09N+24vXVqBgNmRGt2hVQRhrqoOennAyBW5GoCWWHI1EcjUMq3TUh
         WqWDT9q3ohZ1P0vHNlGiasV5i+1VnYrpS2oZzCQUao1OBMnyIbkzA6cJPsG9ZfZB4JfB
         RsCySR5g2JQhKbvppfcNzI/1DBO1MWrn68kRjDZ3qjeCWNFG+nT9NGoQWnGU62bfVWwV
         t+z/txJGFJ/KgySmJNk0BZirvCgNVZAETm7XNvCK/gZn0kWx5RD52z2P50kPvSkqnCZu
         L/SA==
X-Gm-Message-State: AFqh2krN6WHzCzuzddI1gL8XeP3+UCVY0asfUcNfs75jXa7jCxSChJua
        HCz5NLPogcqJ/Gp3zDVGtL4=
X-Google-Smtp-Source: AMrXdXvPIrhB2XSa5IXQh0PW2kHoCxgIGUZ5fln0nOiQ8734erNw+n5Ikqlf7f9g9MESnAEjB0wIYA==
X-Received: by 2002:a17:907:a485:b0:7c0:e23f:17ca with SMTP id vp5-20020a170907a48500b007c0e23f17camr38689262ejc.34.1672838302310;
        Wed, 04 Jan 2023 05:18:22 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b0084c70c27407sm9767146ejh.84.2023.01.04.05.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 05:18:21 -0800 (PST)
Message-ID: <61ed5d45-c79c-0c5e-ae18-b51d8925386f@gmail.com>
Date:   Wed, 4 Jan 2023 14:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 27/27] drm/amd: Optimize SRIOV switch/case for PSP
 microcode load
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Lazar Lijo <Lijo.Lazar@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        David Airlie <airlied@gmail.com>, christian.koenig@amd.com
References: <20230103221852.22813-1-mario.limonciello@amd.com>
 <20230103221852.22813-28-mario.limonciello@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230103221852.22813-28-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.01.23 um 23:18 schrieb Mario Limonciello:
> Now that IP version decoding is used, a number of case statements
> can be combined.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This patch can probably be pushed as small cleanup independent of the 
previous patches.

In general I usually suggest to push those separately to make the patch 
set concentrate on the real changes at hand.

Anyway this patch here is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> ---
> v3->v4:
>   * New patch
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index f45362dd8228..83e253b5d928 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -132,14 +132,8 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
>   
>   	switch (adev->ip_versions[MP0_HWIP][0]) {
>   	case IP_VERSION(9, 0, 0):
> -		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MEC2;
> -		ret = psp_init_cap_microcode(psp, ucode_prefix);
> -		break;
> -	case IP_VERSION(11, 0, 9):
> -		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MEC2;
> -		ret = psp_init_cap_microcode(psp, ucode_prefix);
> -		break;
>   	case IP_VERSION(11, 0, 7):
> +	case IP_VERSION(11, 0, 9):
>   		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MEC2;
>   		ret = psp_init_cap_microcode(psp, ucode_prefix);
>   		break;

