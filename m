Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66764D707
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLOHLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiLOHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:10:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF324096
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:06:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so744083wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfjjP8THPoyFgCibBkqO0thZLZlFewfYPO1zpSWCYew=;
        b=dYwKhXvbyv4dYhoR646FuKyuPpG0WotUkiZBF1Vhaun+U97tDRtcBuIwAoW2n7wio6
         fqX1jeW+rLHR1RLF2kepIPZOnjlIyn/EzPHyfv/ti8q1XN1AU9+MkwrQ2AEUfBImfZI4
         jZ0wC9f69CpeTxhxFhPnV+pjQY9v9n+KXgyKgMn4CLYEoSLLxycwtz1uQIIdJSCEQ4hV
         BrKWHDujEjJHlQhfauRmzAKy77pR5WWQao7eADa3sDBAvqhKOq6NJDahPnR+BuyM/y0V
         B6y9WVm8X6XuI0LYmhLul4DjVFAmSIhyRQnLYKZnc8zOKgMUmirMzQrSgfSzpiZbkgFU
         eYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfjjP8THPoyFgCibBkqO0thZLZlFewfYPO1zpSWCYew=;
        b=72pN4/J0Ie4YnSbHHnk6mZjEU4llT+duLbCiM35EWigCupIgXVbYzEe9gstvTgvs2c
         8lLqVC5gYoTETRiJRj68ry41OyCzZmkyT+4sdV5k9JLkI2z0ZpL2Q2m5YBc3HANimjMb
         J6SjOP9j05McG7ZhvIeNKcWkfyEbdL2ILvneKtsaOL4JtJrSulO3gWv66L0VKUozOBsQ
         IzesAMU2iBCopJSp7DENxmcNEVzKUAX4H4CgSvL4bkDpW+jBk+iYeKm7WDkGmf3TeF4R
         Me2yfug1m/aVxlcsYawzsvrjK7rbZ39xYo0VEoqBX55N1rSfIgbgInA7fbt4ZkT+Fqit
         J/jw==
X-Gm-Message-State: ANoB5plm4XPva9VSYsUiaLiKViWTRv0AwvLFpFSHZ2iGPJm1CKrpkc9S
        jXOi4q3FtO3cN10gTY7y47KRaw==
X-Google-Smtp-Source: AA0mqf5L9xWcoidg/+YgWM0D0dqEkMCFolFMFJ5l9KLYHxcRvtmaqf1hE/FwKrgjIFlni3sR+9UxNg==
X-Received: by 2002:a7b:c017:0:b0:3cf:8e5d:7184 with SMTP id c23-20020a7bc017000000b003cf8e5d7184mr20737074wmb.28.1671087978562;
        Wed, 14 Dec 2022 23:06:18 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003b4868eb71bsm5987273wmq.25.2022.12.14.23.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 23:06:18 -0800 (PST)
Message-ID: <fe761bbe-96f9-75ae-b4be-e94b718abac3@linaro.org>
Date:   Thu, 15 Dec 2022 08:06:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/2] remoteproc: elf_loader: Update resource table name
 check
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        mathieu.poirier@linaro.org, corbet@lwn.net,
        Stephen Boyd <swboyd@chromium.org>
References: <1670924929-26507-1-git-send-email-quic_srivasam@quicinc.com>
 <1670924929-26507-2-git-send-email-quic_srivasam@quicinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1670924929-26507-2-git-send-email-quic_srivasam@quicinc.com>
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

On 13/12/22 10:48, Srinivasa Rao Mandadapu wrote:
> Update the way of checking resource table name with prefix
> substring search instead of complete string search.
> In general Qualcomm DSP binary is prepared by combining different elfs,

Maybe 'ELFs'? (twice).

> hence section header name (e.g. .resource_table), appended with elf name
> to differentiate with same section of different elfs.

Please include here the section info parsed by readelf as an example,
as suggested by Stephen in your v1:
https://lore.kernel.org/linux-remoteproc/CAE-0n52cNite8-4HDoQcsZ+UvZFkJU8c5oUjxPB5ag5WP6E9=g@mail.gmail.com/

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes since v1:
>      -- Update the commit message.
> 	-- Use strstarts instead of strstr.
> 
>   drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 5a412d7..77330d6 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct firmware *fw)
>   		u64 offset = elf_shdr_get_sh_offset(class, shdr);
>   		u32 name = elf_shdr_get_sh_name(class, shdr);
>   
> -		if (strcmp(name_table + name, ".resource_table"))
> +		if (!strstarts(name_table + name, ".resource_table"))
>   			continue;
>   
>   		table = (struct resource_table *)(elf_data + offset);

