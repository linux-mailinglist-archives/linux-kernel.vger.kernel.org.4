Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DE6691F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAMI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjAMI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:57:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9642DDE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:57:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so32177835lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysmHHp/43jCoR62RWa7j7U0fIOfTEzPcP5KkwYW03+Y=;
        b=JSQ9xgftTgc+3wChXekfPAhq633giaFDfteRLlk662EuogEM1yyTybzvAs6JUU/+yC
         eNIF1kkjxwXwhNvUW/gsqLNtNK05X+jWily8sQ+HYu5OdZY7ixMtw1gB1pc4/qvzC3Wn
         VTy6p3Zh3kRQf38km99+OrYx/mu5/hsETlOXWDbJYYKMY2EbE/aOns8YPUtulVjbu17G
         mw/qbhx8aj7KehXUPGMZVTgpsMkg5E3g8714UEE29BALMQ3joIu+r/y5Bx9eknQdZtku
         nnwCirFJ46KtEfZDpGTS7InzMD02NBOk2969DPioKPJE4hZAFbYT8z1JeBb2XQlw934g
         YSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysmHHp/43jCoR62RWa7j7U0fIOfTEzPcP5KkwYW03+Y=;
        b=nWBdAN6GWwrfMLYSCQetMXvSiRrW2hlRW8OtU1NCQlRd95R0xeahxVFtn40qsEgxRm
         4ggP5KXXtr07tlZpsi2uS+eaQY72gvNPtCz7zcIXR+iG9OahTBWIGDARDAz3rTuN3007
         rNZMjfG43BztEqfet+HZ5tRwQfTYyL1dSvWlPGfho1AaPzvUcdDdylz3LcE6WEou/MFX
         ZYVx/9t3Zc7Qv6/UcjFQngjTN5yBu+u1lXrZ8LlVHoiGQjj+TUh3f7gVLT8mU9Q6EW+5
         CBeQE0k/p/wb2R/e+N+joQ9ouUuEzqmK9HT4iohKB5GJaMtc42wWtCrPNyWgHPdTZois
         M5yg==
X-Gm-Message-State: AFqh2krsqGfyqDoSVy1UwnmVGsFuWsEW+4DTXiqFxszSZdRY88gqhAVD
        wJSbzbNMi7KzxMS3Zsm2mE/tVA==
X-Google-Smtp-Source: AMrXdXtBlsg3TCrCR6Yu2JIdPZC5uS8fWSZfkc3geFs8erjGiBE3AGQjYSZ0FPjxIX17l3lKzpd9tQ==
X-Received: by 2002:a05:6512:368a:b0:4b5:b90a:829d with SMTP id d10-20020a056512368a00b004b5b90a829dmr19917438lfs.66.1673600241703;
        Fri, 13 Jan 2023 00:57:21 -0800 (PST)
Received: from [192.168.2.31] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id br11-20020a056512400b00b0048a934168c0sm3758739lfb.35.2023.01.13.00.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:57:21 -0800 (PST)
Message-ID: <9a64c685-9ff0-bc1d-e604-e3773ff9edd7@linaro.org>
Date:   Fri, 13 Jan 2023 10:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/msm: Initialize mode_config earlier
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230113041051.4189063-1-quic_bjorande@quicinc.com>
 <eea1c5dc-6bc5-4246-f0e1-0c790de9f078@linaro.org>
In-Reply-To: <eea1c5dc-6bc5-4246-f0e1-0c790de9f078@linaro.org>
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

On 13/01/2023 06:23, Dmitry Baryshkov wrote:
> On 13/01/2023 06:10, Bjorn Andersson wrote:
>> Invoking drm_bridge_hpd_notify() on a drm_bridge with a HPD-enabled
>> bridge_connector ends up in drm_bridge_connector_hpd_cb() calling
>> drm_kms_helper_hotplug_event(), which assumes that the associated
>> drm_device's mode_config.funcs is a valid pointer.
>>
>> But in the MSM DisplayPort driver the HPD enablement happens at bind
>> time and mode_config.funcs is initialized late in msm_drm_init(). This
>> means that there's a window for hot plug events to dereference a NULL
>> mode_config.funcs.
>>
>> Move the assignment of mode_config.funcs before the bind, to avoid this
>> scenario.
> 
> Cam we make DP driver not to report HPD events until the enable_hpd() 
> was called? I think this is what was fixed by your internal_hpd patchset.

Or to express this in another words: I thought that internal_hpd already 
deferred enabling hpd event reporting till the time when we need it, 
didn't it?


-- 
With best wishes
Dmitry

