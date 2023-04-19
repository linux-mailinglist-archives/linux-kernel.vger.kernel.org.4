Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37E76E858F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjDSXAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjDSW75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:59:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CD3198
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:59:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8bae45579so1420381fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681945162; x=1684537162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoGl/3B6GfMPb0+OCZT2tTJ+psffw8V5B1IJcxh8vQY=;
        b=UIkgmHulStgxhywgQpRdbGctzvlpKZ3CHU4MnFkS3B0eI9oFMP6jBf3A0W2LWge2Vx
         EChbdb7v6y4RLGMdvrAaGzqCWa53Of4HqXGSZiJqghqvbX7tZ5Siqdsc8YpCNlLMAavy
         SBu1ncrC8UiO3uWuOpqzWmaWX5Sr8+R1WTLEhlAJ5g06rwiBQWKpItA8ii+M7YoZk0hZ
         2qwujXfVP+m1d1RM62OTJXd/4yCiFvljiQ7G4UpzoYCWL3heQ9ytVCf6NgI2ccmap3P0
         ZVlF20XgB5T1lpcYDhl4hvzyhPB4D/IuW7BABUkCfowifuo4A1asXGuSQXyIvBzxXr/J
         k87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945162; x=1684537162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoGl/3B6GfMPb0+OCZT2tTJ+psffw8V5B1IJcxh8vQY=;
        b=ho9BYdYDnVyBq6dLunfH8J6/6Jnp7Ghgb+ALa3UFakcrI1CAqnCUOAcm/1AD6bt88t
         c8BqumyPpSm2rYrq2UCj3f5d6TOqn5imJz/uy1sN5TOFbKSmCLnFp+B9cg+CezeI/jUj
         E4vfrrWonLZ1m0KtQ3wggnrY2uyjC59cU2QLoz/hu2rQedTJQphvkvimn2yrD+3uBy3w
         OIl/IiiopZVHSroUHUrWAabep4p2N5/2y5UWFJCJ34xmyRJshAoDI/6XjdVF1oiY8tFk
         xqIqx9xH2lF4HxzsmxYr8/V4nAhKjd1ZCS7YKordEvAX/efeNh6lRVp5RWlENyaFEJ3A
         XbWg==
X-Gm-Message-State: AAQBX9crWN6MCJK08hszU11D1bmWPjxUm+XbQycR1s7pBGGoCWm9OQot
        WxMD7+4mMCKqxpR8usCQDyWaDQ==
X-Google-Smtp-Source: AKy350Z5bY9EO/mzqIlAunfW05lj83UpZeDqO6JngBwRxkpLMBRbcUuCe7r8UDB4wEBy5tHdDc0VvQ==
X-Received: by 2002:ac2:51b3:0:b0:4ec:a18e:f985 with SMTP id f19-20020ac251b3000000b004eca18ef985mr4584503lfk.13.1681945162548;
        Wed, 19 Apr 2023 15:59:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id r6-20020ac24d06000000b004edc22d27dasm31287lfi.230.2023.04.19.15.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 15:59:22 -0700 (PDT)
Message-ID: <280d6245-8980-10f5-cf2d-05555ca4a332@linaro.org>
Date:   Thu, 20 Apr 2023 01:59:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/11] drm/msm/dpu: set max cursor width to 512x512
Content-Language: en-GB
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-9-d1bac46db075@freebox.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-9-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:41, Arnaud Vrac wrote:
> Override the default max cursor size reported to userspace of 64x64.
> MSM8998 hw cursor planes support 512x512 size, and other chips use DMA
> SSPPs.
> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

