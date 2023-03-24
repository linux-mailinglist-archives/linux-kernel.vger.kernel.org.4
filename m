Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F323E6C7F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCXOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjCXOGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:06:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD2A1BAC8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:05:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so3230755wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679666755;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WG6gphWl27lAGqIb66Yn+gMHDN2FKDd0CjkaAmh1aqs=;
        b=hx9HF8DLfkyh4bxrj1FkrTEKV2pEkXm+b+DeeofWFl8I9fo5obHKFa5TXVoKr8v22O
         uBz4NaeiaOu/3+CruH2yfScKi8TZV5HEezj4T2Y0zyVH3Lq5I/Cf0T8YMcmEVbrk5rYr
         kvJDgFJ59O7Fh0dWR/Ac38WfqYsSrZ5lJ3pEy/gWaP5ukPJPFGX+OngIdtOcKa53GJa3
         sPVP8Enc0e7eqvC5asKWtqxIGBcX/v0Zpkfize9JzmAKkZBUSsurHejXZQcmVHfDEHu9
         FtvnHisaIIKk+7kt1jOF5DpPs9WDmUqfMH0q9saOqr766l/7gu82aQqJ2f1P4H4YJqNP
         Jacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666755;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WG6gphWl27lAGqIb66Yn+gMHDN2FKDd0CjkaAmh1aqs=;
        b=eA/gFdTqi+PYNKvJDUJ2NlcD0OhnI4jrBBlLmjIs2Duwsi3peJQXO6cMOTs8x55ISk
         RgadInEUphU6TFunGPnnce6xjrVXjc9F1K/K8s78f7tvr7CIEONsPPQTC0iId6ClWHSN
         TY3vC/ZlTHlKojivhZpWcfyJQBC4o7/lyvVRBKp78y5A+bMM57E7raU4qUnJEQoRZ8YR
         V4mFqTQYDX+Fes40MAds6GY18RdI/qPT+S+5S5lF0WqsljMuq9BM6TPRu8EToKPDoevw
         NV3F7eJ20KmHYx+I7t9oZongFE5ikfMTDMiqudJGJ8UEUZD5cuGlEC6xzOFJAobbkj2X
         gnfQ==
X-Gm-Message-State: AO0yUKWGS9Q8BJ5+or3YwKXfZcr3UyvUFcTCzxRo8DPhYjx3fbqkko96
        YL+PZMtSvMfRyWI5iTkcLGDTSg==
X-Google-Smtp-Source: AK7set/uKpNVbtBBd4lUVSBuF+3iaCY52KMHAaXgmlQVPGEuXOp9zixUhtUEm4rvwQ9j3FbsKvcREg==
X-Received: by 2002:a05:600c:209:b0:3ee:282d:1016 with SMTP id 9-20020a05600c020900b003ee282d1016mr2422277wmi.25.1679666755220;
        Fri, 24 Mar 2023 07:05:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:213f:a579:70af:e4a0? ([2a01:e0a:982:cbb0:213f:a579:70af:e4a0])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003eddf20ed5bsm5195872wmq.18.2023.03.24.07.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:05:54 -0700 (PDT)
Message-ID: <f1088121-02c7-86da-d603-7c2015030b0e@linaro.org>
Date:   Fri, 24 Mar 2023 15:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] firmware: meson_sm: populate platform devices from sm
 device tree data
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        krzysztof.kozlowski@linaro.org, robh@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, jianxin.pan@amlogic.com
Cc:     kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        rockosov@gmail.com
References: <20230324140141.6743-1-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230324140141.6743-1-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 15:01, Dmitry Rokosov wrote:
> In some meson boards, secure monitor device has children, for example,
> power secure controller. By default, secure monitor isn't the bus in terms
> of device tree subsystem, so the of_platform initialization code doesn't
> populate its device tree data. As a result, secure monitor's children
> aren't probed at all.
> 
> Run the 'of_platform_populate()' routine manually to resolve such issues.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/firmware/meson/meson_sm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 77aa5c6398aa..b79d0e316cb1 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -316,7 +316,7 @@ static int __init meson_sm_probe(struct platform_device *pdev)
>   	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
>   		goto out_in_base;
>   
> -	return 0;
> +	return devm_of_platform_populate(dev);

You should check return and jump to out_in_base on error instead.

Neil

>   
>   out_in_base:
>   	iounmap(fw->sm_shmem_in_base);

