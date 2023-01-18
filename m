Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E50670FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjARBYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjARBYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:24:38 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405E10D2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:24:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw16so67817433ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCw2/tRfMHxdziYE7u5XMHonH7hwIjkmwIJuVfBRNWc=;
        b=nkdE03+Z0aIn/+n7c1/I2F3pJkSHHVfoKP7G8X9gUuTEkxpuUwMEtVoc0Q+WUvSkvd
         A2H/THg65gzR0hZgMbt2oPoKf4nCe5i/l6BjLfuin4U01myYpCXjWorb+1mTTzkDuhk+
         mCiQUtSbLtdcOWtWJ+KRejJGi/NmzqWORt/S7l/3k66JUoNrsREYogsLyLY9EldEHZAd
         PsL1wjKb7nQ9OgsnYZGOBNaPZy9TIY5EbGcsIFJCz2t8kQSQcm9Uxy1IesuXV/QInnfa
         1rUiZs41LNJEYzESPz3fByvOWWq3gxSP9vx82MfGgPxkgTfoUoXvKS+9zNGRrN+o9uHZ
         YGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCw2/tRfMHxdziYE7u5XMHonH7hwIjkmwIJuVfBRNWc=;
        b=MSZGMqW8MH4j2EaKYWTzMg84FdKhNiGaL1Dg//D5wqABQ5z93Q7eKCEWfdxxWy3imc
         sZk/ti0gW8Jzh9QvxD8jc1HEJxW1lPEok7wHNohYHDunqZqYyXlqXG6CCKjGbvoFNbRZ
         ZKWlgaseV6qE/4zVvZVkVxJnE9Tez9zKqtH9FMgr+6AKTVsNElXxBC0j2j/npA2CZJZr
         7U3BJCT0Tatgh6g7Q9SsMk/jwd4fma7URRIiFLJj28Nq1ldpUrK2EtWTr5kIrgS74fzz
         EAxoL1FO8QAdq2ww8PU05+EBJCq6GBAr44aDSS/BvfL5m7u0QBP47YArO4ojdugopS3y
         Om4Q==
X-Gm-Message-State: AFqh2krNoIoH2OWATEnQWlIqc3ZmQIA/5G36PG386c32+HniZ9U2GRZY
        S7ffXMoiej5soyuMHWyhpeXdQA==
X-Google-Smtp-Source: AMrXdXsas82xe4F5cGHedGjetCtbabIxMQUCoeuWsYdgrdP89CeJeAfXys09rvlr0gPpyI7oo6dygw==
X-Received: by 2002:a17:907:6294:b0:86a:1afa:6dd8 with SMTP id nd20-20020a170907629400b0086a1afa6dd8mr26337861ejc.69.1674005075726;
        Tue, 17 Jan 2023 17:24:35 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id fn4-20020a1709069d0400b0084d4b907ff8sm10941430ejc.120.2023.01.17.17.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 17:24:35 -0800 (PST)
Message-ID: <b9fa44e8-3387-df90-7997-cac74312cb3b@linaro.org>
Date:   Wed, 18 Jan 2023 03:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] drm/msm: Add missing check and destroy for
 alloc_ordered_workqueue
Content-Language: en-GB
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, freedreno@lists.freedesktop.org
References: <20230109022038.2163-1-jiasheng@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230109022038.2163-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 04:20, Jiasheng Jiang wrote:
> Add check for the return value of alloc_ordered_workqueue as it may return
> NULL pointer.
> Moreover, use the destroy_workqueue in the later fails in order to avoid
> memory leak.
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Convert "goto err_destroy_workqueue" into "goto err_msm_unit" and
> remove "err_destroy_workqueue" label.
> ---
>   drivers/gpu/drm/msm/msm_drv.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

