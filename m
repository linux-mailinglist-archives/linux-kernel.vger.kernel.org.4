Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DB6531F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiLUNn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLUNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:43:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0B6205C5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:43:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ja17so11183994wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PpNtCpDSzPsflwXjljiwDro3Ig3Yd6W5cEBWGQHsHU=;
        b=MUPGmOoWU5FKo3PIgscvq/wlBf9WsS+MzmH1bFytWwftO3cs1RCgYaJF+e8jP15Ub+
         pHneK+AatBhypXqVXohsw9jnnLKjoB378iojd2+Y8XXYS2/L4flDfR9+5Ly6wmpbSjJq
         OgYguaGxnb6Icgw5GEsVNTZFFx2b6vWKS92m+iBuV7B4xZkKFE/aD8zO31PRrGoL19Pd
         7S+BXdpWX9nnzJqzl6MLkeENZ158iJBVRluV4Mo/QIkJkBZW6SGYBJjnhxQn6/aK3PWu
         jb5D3iwoxi5K1ov/PgyiHPALheOjtAueOPox1F8f5NeMDf4+MjUxwnLotQqtB/ryStQ4
         2Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PpNtCpDSzPsflwXjljiwDro3Ig3Yd6W5cEBWGQHsHU=;
        b=G/Tu7ZQOdBi9mn2/B30N/bWwdxpaWbpAv+ki7OmJTFKcg8KGdbE5sftCMNdnKadJVu
         WutAVK/+Z6N+JnaGpAMm1ovxu8M+/2WTDZFCL+Dyi8bVXpT8zenkdzHLwrtzRpGOByYM
         9OkKGNELPEahxAD6OjUAiQ0sp1SXjKk4MpNCfcyJjYVX1qOobA4a6uF/TQTGpkAP8KBc
         l+Qxbw1KuEU2mFlLfMHX5glOcFgMd6yQlLMuefbeAfg0wmVkZ+aGPXGDlmGpoBGG9qYL
         3Iyo10A0JB6RIDytshHMKMCkxER/p1qWACTEEYZdJq4qG28DtAIFIDkvnQTeVKJIpOfc
         9kOQ==
X-Gm-Message-State: AFqh2koUAjpF+ug3WLpZJwHbgvdW0uWv9fimmLxzryVv7K7Fa0Rcz/M4
        FjAnpYgyAdePfcD0N2k3vs8G2XV8nHoopUnW
X-Google-Smtp-Source: AMrXdXtfM8xXfEIX4F72BRhv9jv0H3v+5tDr4GJoGD2yHYECtBSa2XlImRu6/9aMGAcIhgbgRXqh9w==
X-Received: by 2002:a7b:ce89:0:b0:3d2:3239:2fd7 with SMTP id q9-20020a7bce89000000b003d232392fd7mr1655018wmj.41.1671630222970;
        Wed, 21 Dec 2022 05:43:42 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z13-20020a5d640d000000b002365730eae8sm15558523wru.55.2022.12.21.05.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 05:43:42 -0800 (PST)
Message-ID: <5276e5b8-8596-2811-e03f-c4f3f0d3ab5b@linaro.org>
Date:   Wed, 21 Dec 2022 14:43:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC][PATCH] thermal/idle_inject: Support 100% idle injection
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209013640.943210-1-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221209013640.943210-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,


On 09/12/2022 02:36, Srinivas Pandruvada wrote:
> The users of idle injection framework allow 100% idle injection. For
> example: thermal/cpuidle_cooling.c driver. When the ratio set to 100%,
> the runtime_duration becomes zero.
> 
> In the function idle_inject_set_duration() in idle injection framework
> run_duration_us == 0 is silently ignored, without any error (it is a
> void function). So, the caller will assume that everything is fine and
> 100% idle is effective. But in reality the idle inject will be whatever
> set before.

Good catch

> There are two options:
> - The caller change their max state to 99% instead of 100% and
> document that 100% is not supported by idle inject framework
> - Support 100% idle support in idle inject framework

Yes, from my POV a CPU being impossible to cool down for any reason 
should end up by staying off.

> Since there are other protections via RT throttling, this framework can
> allow 100% idle. The RT throttling will be activated at 95% idle by
> default. The caller disabling RT throttling and injecting 100% idle,
> should be aware that CPU can't be used at all.

Would it make sense to write a trace in this case ?

> The idle inject timer is started for (run_duration_us + idle_duration_us)
> duration. Hence replace (run_duration_us && idle_duration_us) with
> (run_duration_us + idle_duration_us) in the function
> idle_inject_set_duration().

Sounds good to me

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/powercap/idle_inject.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index f48e71501429..4a4fe60d2563 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -184,7 +184,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>   			      unsigned int run_duration_us,
>   			      unsigned int idle_duration_us)
>   {
> -	if (run_duration_us && idle_duration_us) {
> +	if (run_duration_us + idle_duration_us) {
>   		WRITE_ONCE(ii_dev->run_duration_us, run_duration_us);
>   		WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
>   	}

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

