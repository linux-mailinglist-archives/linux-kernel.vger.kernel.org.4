Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C056C3588
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCUPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjCUPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:22:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB7113E0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:22:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a11so5383732lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679412117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56s6rLJdjpBDM1hl6x5LvM4qWyj2EYIhrrSbFYI0uDM=;
        b=zqwm8vcih1yhUl8T9pyw3CAI+LBPWgmIxn/gIBf4VHx6uF0/DWXPVGKv5yDU3R3ovK
         BQm8nTeYnFUOhR6DOdYxo7TULlVccnBzadotgYiQ7UA0dp/kVXokvEU3JCeWWTT7SlAh
         GavUCO8Gx/Jrvblt/zg8q7F+2y4nuJGM8itRxRQ9icjjVq5Oi1KZbPONboGTGbmvO35O
         MwW3NpIa/EsVyM14w+v5PmQTeajuMfJERRHZMV2D1yPSkoKs/Ra3VQtkvVkk1esqmrXE
         c5h1NoA4L7IZtXSqjnkPrfnqbfBA/DdMFFgTBlndo0YRxQhm+ZCK11of7jXpaoDMGSfa
         XG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679412117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56s6rLJdjpBDM1hl6x5LvM4qWyj2EYIhrrSbFYI0uDM=;
        b=nMjuCe222j/8xLnAS/dten3W1aWYk/xilBe18o5XJrOSk7QiD+ELl1jmwBfZyNYwib
         eHB72jnlFSxlnVrurYsbRtoG88d15lgRZouLT/0Y+0TQxEzgYkQWqhAcngIIgfXmFdPx
         K8NVTFgfgfWsYaR+L3qkbQgQXv3rLNTMgfljdNo2MGy5vU26iUiJ1Cu1b+aagVSxhpio
         McuW21cyxpqVxPjtq0d327NqzLCPPsB4gmLgQ2/TtQ5iESg08/dtiLUNNuixpcq7tFzQ
         7zfgGbtk9oT9opkIY+sC+3gw6kzZYHpq16kB3cBmkvqPcpjrnSE0c67hgLFwfNwuxlal
         bklg==
X-Gm-Message-State: AO0yUKVWhWwaBS15oLmxv0f9lpWm3Bm7mb9O7FrX+bdjvYHDJBY6eWYj
        cw+ffYViWxFqdcam0dxDB82t4A==
X-Google-Smtp-Source: AK7set8XMA5X4kDNh9wjuk2eLvIAc4k4TD2f3llxCFuB71vUCBzGOc+i1nk0t8977tyEMaoTolG90g==
X-Received: by 2002:a2e:b008:0:b0:29b:d35c:f0a4 with SMTP id y8-20020a2eb008000000b0029bd35cf0a4mr1030021ljk.37.1679412117603;
        Tue, 21 Mar 2023 08:21:57 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p1-20020a2e7401000000b0029353caa593sm2291789ljc.5.2023.03.21.08.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:21:56 -0700 (PDT)
Message-ID: <6b2f4d0d-ba39-dd2b-e41e-b5accb4df1a2@linaro.org>
Date:   Tue, 21 Mar 2023 17:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/10] drm/msm: fix bind error handling
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <ZBmq12uP+TY4EaE3@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ZBmq12uP+TY4EaE3@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 15:02, Johan Hovold wrote:
> On Mon, Mar 06, 2023 at 11:07:12AM +0100, Johan Hovold wrote:
>> I had reasons to look closer at the MSM DRM driver error handling and
>> realised that it had suffered from a fair amount of bit rot over the
>> years.
>>
>> Unfortunately, I started fixing this in my 6.2 branch and failed to
>> notice two partial and, as it turned out, broken attempts to address
>> this that are now in 6.3-rc1.
>>
>> Instead of trying to salvage this incrementally, I'm reverting the two
>> broken commits so that clean and backportable fixes can be added in
>> their place.
>>
>> Included are also two related cleanups.
> 
> Any further comments to these patches (except for 9/10, which should be
> dropped)?
> 
> As the patches being reverted here were first added in 6.3-rc1 there is
> still time to get this into 6.3-rc (e.g. before AUTOSEL starts trying to
> backport them).

I will take a look at the patches. Additional question, as you have been 
looking into this area. We have plenty of code which is only called 
under the `if (kms)` condition. Could you hopefully move these parts to 
separate functions, so that the error handling is also simpler? If not, 
I'll put this to my todo list, but it might take some time before I have 
time for that.

> 
> Johan
> 
>> Johan Hovold (10):
>>    Revert "drm/msm: Add missing check and destroy for
>>      alloc_ordered_workqueue"
>>    Revert "drm/msm: Fix failure paths in msm_drm_init()"
>>    drm/msm: fix NULL-deref on snapshot tear down
>>    drm/msm: fix NULL-deref on irq uninstall
>>    drm/msm: fix drm device leak on bind errors
>>    drm/msm: fix vram leak on bind errors
>>    drm/msm: fix missing wq allocation error handling
>>    drm/msm: fix workqueue leak on bind errors
>>    drm/msm: use drmm_mode_config_init()
>>    drm/msm: move include directive
>>
>>   drivers/gpu/drm/msm/disp/msm_disp_snapshot.c |  3 -
>>   drivers/gpu/drm/msm/msm_drv.c                | 67 +++++++++++++-------
>>   2 files changed, 44 insertions(+), 26 deletions(-)

-- 
With best wishes
Dmitry

