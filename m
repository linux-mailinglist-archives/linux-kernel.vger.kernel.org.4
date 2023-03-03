Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776A46A94D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCCKFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCCKEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:04:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753E5D897
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:04:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id t11so2908014lfr.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bu1XsCiuemEgXLrsyqbVOjx0c5HoiOQ23/TsjbuCBoM=;
        b=sh/z6/R4aUSyJKc7WkEfC84gl355wbnXtzv9pgOWC/nInmAGvm9qM8m/hwYke4e6D2
         OsK6lQbQEETsY02kiiYWajoKO3enetC7iXxWjK+Hk01+yi1h2F/vAedPkclf1woV+485
         L9WVUwlu+XQPFwuYog2IhQ6v+YX8AdKnRzBjEkvEjjOC9RK7vC1v9H9gtnYhcMWHv1O9
         YaIs8tnOLJVbv7lrlC72u5aZXh0vXOEP0jmXoVls+sGEYncp1e845U+MPpN20C+1x2Nr
         qI3O+sppkZJFb3WCz9NThTYEzelmhPYDLhZ9nY4Te0jtxAbNObXAzKBM0OlVnyjkiqbm
         LlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu1XsCiuemEgXLrsyqbVOjx0c5HoiOQ23/TsjbuCBoM=;
        b=UiRm40JC3WYmL+ttA5FGHxu97X2+0TMTamWzlmYKBl+yUqq8spFAT1b7HezIQK/BM8
         KENqB059uMxyM5BJlpqTprOFGZW0bqyRjpnLNgPnUhSXvIFgLepYUls1JnVeyEWyKhFE
         8xuAEYzJ+C86D64WYdENDRLyAEf38C8RWUrNFkTwAP2mNInvC/CkaIqVucoBJxEjpWEH
         d9H12ngCNVyN6aL9NE2/OdqkraU87xI0LBV/3RnhAxgEsCTyuF+3qO40nhcvdGMRnrGG
         Su9KXk3ZbNvutNZ1Um0yhFzAZK8AVuzfN2DcTDCaWQgq8KcPSwCn/fUtgOxipKkbRGc5
         7lrA==
X-Gm-Message-State: AO0yUKU8zG05PkYt8hqdPwRR/F3M2/Nm9QvMqPNukrG3khvc/faQbN16
        EJmwY0AwjhpI68KZ2Yu7NWY27A==
X-Google-Smtp-Source: AK7set9P64Lzkb6Z0OzuupIyugVRsWfQPf/es/+T2UMX0/iSa+2NFSVoLhg7hou7R53lJFPqZXXp0w==
X-Received: by 2002:a19:f610:0:b0:4dd:abb6:8699 with SMTP id x16-20020a19f610000000b004ddabb68699mr388316lfe.40.1677837870086;
        Fri, 03 Mar 2023 02:04:30 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b004dc4c5149dasm324457lff.301.2023.03.03.02.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:04:29 -0800 (PST)
Message-ID: <9a14e543-98b3-8df5-46f6-b890b4d3baaa@linaro.org>
Date:   Fri, 3 Mar 2023 12:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 13/15] drm/msm: Add wait-boost support
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-14-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230302235356.3148279-14-robdclark@gmail.com>
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

On 03/03/2023 01:53, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a way for various userspace waits to signal urgency.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_drv.c | 12 ++++++++----
>   drivers/gpu/drm/msm/msm_gem.c |  5 +++++
>   include/uapi/drm/msm_drm.h    | 14 ++++++++++++--
>   3 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

