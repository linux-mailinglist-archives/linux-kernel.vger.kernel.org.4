Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD9616B78
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiKBSE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiKBSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:04:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB04E636A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:04:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id j14so26052366ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kfl6EFy+1s5bebZ58ocWUAzBJujFa0//d6FDWMOKEcw=;
        b=SaXwCsrB+vSTWBTUlZwxUMaiJCMhuj7VIZED5OXyJOCUlXiQaiDQwJ/MSJayjkKHM/
         vTjQzMXvCMRvo3y0S2fJZzloAi5OLabbagctrDPJSlGpQ1yUX8rKEwL6O4RSOhQZGCKS
         8mMQO2vH7e9lQU0QdsNphPijYAsfVEmIKFAp6lw+TxgJgmiScNXu7Q0IPCSBMDoGWlCt
         1ePymdyFvKf/WqNl188pmuSJbc1PZqiOOtoIg9BjUZs1MF60pVNXpB1/5cYepWmoIySK
         AuRQaBiP1exX4Rt3ILS8sAHY+MEnfzeeCW07mSiaVvOE8Lkaf1aZEB3Ksov72hejpsZB
         tszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfl6EFy+1s5bebZ58ocWUAzBJujFa0//d6FDWMOKEcw=;
        b=qhXSP8P1Ds5h7qh/GdOHmWCWMLdIg+G0TiJDT7VTjlHBblBxWGrQ3xa90rKU5630Yp
         XPaijg7d3OPLuQW14F45n6V6KnJQd9DsnKDzf6NFGAAcZpSq27qLVxAdcW27Evo0G7R2
         dYTkiDrfeqO9eppMNsqZ26+8xDXjmYpS+Ok+d4GotWw3xTmWADJM17/REaEwc7mckLea
         zM1DxgYqRfPiH4YsEoEfR7seWz96aRXo1CkMWqmNGeFPgLc2FxdkGNiiAwvl4BW70IO9
         i4tIp70Qw4O6Fsr7VQjMr1Tntw+y7JiVNL1ewVvzN9/wwDsK8YR2WGX6pQ/5aDsO8XKW
         hsfw==
X-Gm-Message-State: ACrzQf3VZzXRbttV7lfA3fkSNt8glgzu2vJHmMC6UMZWZ4lWM8sIC6J8
        I3sFYQ36X0YVBU4XHDIi/ofbBA==
X-Google-Smtp-Source: AMsMyM58C3ychgVlZPLXgqKxRoKbGoginKLDpoFrcYy25cZZt/ccz2yj7LHG+bD2o/zHBO0g9oxgjQ==
X-Received: by 2002:a2e:870f:0:b0:277:2600:9d05 with SMTP id m15-20020a2e870f000000b0027726009d05mr9463378lji.144.1667412255202;
        Wed, 02 Nov 2022 11:04:15 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bf26-20020a2eaa1a000000b00261ccf566e3sm2200139ljb.65.2022.11.02.11.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:04:14 -0700 (PDT)
Message-ID: <60643572-4148-cea5-e64d-ec6534b0c407@linaro.org>
Date:   Wed, 2 Nov 2022 21:04:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] drm/msm/dp: remove limitation of link rate at 5.4G to
 support HBR3
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <1667237245-24988-1-git-send-email-quic_khsieh@quicinc.com>
 <94b507e8-5b94-12ae-4c81-95f5d36279d5@linaro.org>
 <deb60200-5a37-ec77-9515-0c0c89022174@quicinc.com>
 <CAD=FV=X_fs_4JYcRvAwkU9mAafOten9WdyzPfSVWdAU=ZMo8zg@mail.gmail.com>
 <155e4171-187c-4ecf-5a9b-12f0c2207524@linaro.org>
 <CAD=FV=Wk5rBSq9Mx1GCO0QFYckKV9KUFKL36Ld7dQX1ypHVcYw@mail.gmail.com>
 <CAD=FV=XTOUjVAGFWZ6xTkcNOrCT1p73aU-=KJNYUOxsS-BQsyA@mail.gmail.com>
 <c5aedb31-3881-50e7-f747-e75b18c3f4b8@linaro.org>
 <CAD=FV=WPde5wVOGCKQYGuGwgCwRebox4FF0MgV_2pPCTsfo_UA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=WPde5wVOGCKQYGuGwgCwRebox4FF0MgV_2pPCTsfo_UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 20:28, Doug Anderson wrote:
> Hi,
> 
> On Wed, Nov 2, 2022 at 10:23 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>>> 1. Someone figures out how to model this with the bridge chain and
>>> then we only allow HBR3 if we detect we've got a TCPC that supports
>>> it. This seems like the cleanest / best but feels like a long pole.
>>> Not only have we been trying to get the TCPC-modeled-as-a-bridge stuff
>>> landed for a long time but even when we do it we still don't have a
>>> solution for how to communicate the number of lanes and other stuff
>>> between the TCPC and the DP controller so we have to enrich the bridge
>>> interface.
>>
>> I think we'd need some OOB interface. For example for DSI interfaces we
>> have mipi_dsi_device struct to communicate such OOB data.
>>
>> Also take a note regarding data-lanes from my previous email.
> 
> Right, we can somehow communicate the max link rate through the bridge
> chain to the DP controller in an OOB manner that would work.

I'd note that our dp_panel has some notion of such OOB data. So do AUX 
drivers including the panel-edp. My suggestion would be to consider both 
of them while modelling the OOB data.

> 
> 
>>> 2. We add in a DT property to the display controller node that says
>>> the max link rate for use on this board. This feels like a hack, but
>>> maybe it's not too bad. Certainly it would be incredibly simple to
>>> implement. Actually... ...one could argue that even if we later model
>>> the TCPC as a bridge that this property would still be valid / useful!
>>> You could certainly imagine that the SoC supports HBR3 and the TCPC
>>> supports HBR3 but that the board routing between the SoC and the TCPC
>>> is bad and only supports HBR2. In this case the only way out is
>>> essentially a "board constraint" AKA a DT property in the DP
>>> controller.
>>
>> We have been discussing similar topics with Abhinav. Krzysztof suggested
>> using link-frequencies property to provide max and min values.
> 
> This sounds good to me and seems worth doing even if we eventually do #1.

And the bonus point is that it can be done easily.

-- 
With best wishes
Dmitry

