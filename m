Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C046A50A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjB1BYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjB1BYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:24:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F11632A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:24:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f41so11053871lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcrqrMKYHlTbwqvBZH5ZNssesiULNdaHzpxnh4fJ5Rc=;
        b=Z87/gWbPjVw05P38iuzO1z4TzK1DYOILnNc+4eFra/elbdJBtd2McBcw47eDPi7DQA
         YQEdCMZ1lCVkdo5agu+ThXn5jdRpGQjFj14OB3NVzcA8EU6QfId5I8lFG9l+PvwFQBwD
         UlDsIcBQhBqBx39604zw7E4H0MWLT4m/xnU2ytitWiJlG43gU38vvrdQiw70MGxVqgB6
         mebFWxHGppFxQqdhxGFt29e9Hs5fLK641gGhjpMFOtx95I5tXGi62xO3R4uGXo4KBNVO
         jMeKLLU9GNxglCSfUmg7bUv74e63Kk9HX7TQxlZLfYJDHO038KuPcqHfBK7dcquiCFG8
         HmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcrqrMKYHlTbwqvBZH5ZNssesiULNdaHzpxnh4fJ5Rc=;
        b=M6GAGNuguexMeeUXQjsoa2ykqzGWHvT0UJrB9EtoWSUSW1ljnoX0wYScohuGeSIcep
         K66XbmRIg7Dsdo3j18Gp/83kBPglUAO3yQdt77E2O4VC/Cgof8wS2/gx+G9ZIV8Rfth6
         1aHMzsnZ/lLwMEXNO3cWI8OzYsH04pIqS9cMnED1tNot/oD5jiMhHSuRV8tZ79lOb6q0
         LeKKQIMhEAjwthhY+BxF8T4/mjVVKCbT0Dvd9FgDm5Q1LGEfmvyHeSbvVZFMjKk/T9Qz
         npaaC3/PE92wwnzdyZxfFjUhtqBwiedzQT2dxhKDlrd3ldkjO+RJtX4/ulUP+PbiKM5N
         gecw==
X-Gm-Message-State: AO0yUKV/ZeMaJBJaqKpmFlngOoJ5XnUf9XH5vXFlVNWW0BezvWufFhac
        ZMGeGhaWmW/nqtj2WxKx8IDSOA==
X-Google-Smtp-Source: AK7set/Kx6HE5jmVscWS6bhEWHw+skaMn4w3s9H/dmiSzjuqCvY+voJX/YRNgLPCWJFWajytYp4weQ==
X-Received: by 2002:ac2:4437:0:b0:4dd:a66d:b6de with SMTP id w23-20020ac24437000000b004dda66db6demr198602lfl.65.1677547478645;
        Mon, 27 Feb 2023 17:24:38 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d8-20020ac24c88000000b004ceb053c3ebsm1113101lfl.179.2023.02.27.17.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 17:24:38 -0800 (PST)
Message-ID: <e077d60d-5881-1ccc-a17a-fbe64392e29d@linaro.org>
Date:   Tue, 28 Feb 2023 03:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFT PATCH v2 1/3] drm/bridge: tc358762: Set
 pre_enable_prev_first
To:     Doug Anderson <dianders@chromium.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
References: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
 <CAPY8ntAUhVB6UtQTeHAcxNW950Ou+NcEoGwk3JnVWLay89_0Nw@mail.gmail.com>
 <CAD=FV=UNx7ivymvpGKcuyvvepvo-T2B2aREJy2GyawTHCnazsw@mail.gmail.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=UNx7ivymvpGKcuyvvepvo-T2B2aREJy2GyawTHCnazsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 02:26, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 1, 2023 at 1:51 AM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
>>
>> On Tue, 31 Jan 2023 at 22:22, Douglas Anderson <dianders@chromium.org> wrote:
>>>
>>> Set the "pre_enable_prev_first" as provided by commit 4fb912e5e190
>>> ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init
>>> order"). This should allow us to revert commit ec7981e6c614
>>> ("drm/msm/dsi: don't powerup at modeset time for parade-ps8640") and
>>> commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
>>> time").
>>
>> I see no reference in the TC358762 datasheet to requiring the DSI
>> interface to be in any particular state.
>> However, setting this flag does mean that the DSI host doesn't need to
>> power up and down for each host_transfer request from
>> tc358762_pre_enable/tc358762_init, so on that basis I'm good with it.
>>
>> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>>> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   drivers/gpu/drm/bridge/tc358762.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
>>> index 0b6a28436885..77f7f7f54757 100644
>>> --- a/drivers/gpu/drm/bridge/tc358762.c
>>> +++ b/drivers/gpu/drm/bridge/tc358762.c
>>> @@ -229,6 +229,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
>>>          ctx->bridge.funcs = &tc358762_bridge_funcs;
>>>          ctx->bridge.type = DRM_MODE_CONNECTOR_DPI;
>>>          ctx->bridge.of_node = dev->of_node;
>>> +       ctx->bridge.pre_enable_prev_first = true;
>>>
>>>          drm_bridge_add(&ctx->bridge);
> 
> Abhinav asked what the plan was for landing this [1]. Since this isn't
> urgent, I guess the plan is to land patch #1 in drm-misc-next. Then we
> sit and wait until it percolates into mainline and, once it does, then
> patch #2 and #3 can land.
> 
> Since I have Dave's review I can commit this to drm-misc-next myself.
> My plan will be to wait until Thursday or Friday of this week (to give
> people a bit of time to object) and then land patch #1. Then I'll
> snooze things for a while and poke Abhinav and Dmitry to land patch #2
> / #3 when I notice it in mainline. If, at any point, someone comes out
> of the woodwork and yells that this is breaking them then, worst case,
> we can revert.

This plan sounds good to me.

> 
> [1] https://lore.kernel.org/r/1f204585-88e2-abae-1216-92f739ac9e91@quicinc.com/

-- 
With best wishes
Dmitry

