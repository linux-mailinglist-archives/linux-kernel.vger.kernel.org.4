Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9B694C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBMQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjBMQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:25:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B67113E3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:25:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id rp23so33215521ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWFr1CwZvMY5/EN0vu8t/Vj+LDxEJAQErVcpCjqVbII=;
        b=oUUfDS770cSTzQ+Zst5e/kfjkax8DHMQvYXxccdwc0dMN3GliHUDJxG6T2ZaP7YTR8
         jdFWlcGRBlGRccBQNkWLmQtXBGZQTefa6O9eOHp1A1HNW6m12xNuQ9ys6UrhlXeBjvsE
         04kcceD/awx0pgM/VzIyOjbK1yEWzustl7WTzzxA8cJIg79gqqQYeTedR2elW6fI0Xvl
         b+ymiN4Y2YnilSNvSXG9Gz5XbThGIuuOjdDMT9+LUN9C52JxNRq8E3qTZQ9cHz3JJzmu
         NWEJvzNE79Skg1l2HQLM0Qt7R8LWbsDiFOtm+l089E/7pr8GPln12yWnSE8d8D+Eh04p
         Kntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWFr1CwZvMY5/EN0vu8t/Vj+LDxEJAQErVcpCjqVbII=;
        b=nU5yyrBsDPgIHeOdL4t2kxCFYSPjf7JQoY7AWz2z1yIxqX9PzwtRh1+iW4MITPdvN/
         AC+u3OdmLsYUK9SaPkHMijTLYvGu2nWann79ZebvqLec3i7IfMKHEMeHlNX/z27c8g8d
         WfUREy4IyoqEWwJcoVHV3M8cF+aPnkPpFpVerkYhtlhzR9ONym45qZAL8PHVmtJCv5eF
         YRjeCnnNuWJO0i5pBSCdabfLQtXhqE0zOAQfTDUgRbyzAyIK8W9oTqCeTJbRrcCo9vsf
         sAvcstuCDLas72wgvRwXPDOKS0PJGGF8WeKSYNpZli3uSS4yahkf9ymwVr68nU1+YRpM
         bypw==
X-Gm-Message-State: AO0yUKXHeLBLxX9CCKMl4LCHUPpLylhdABbbaQto4hhFd9p/n0fSvsrh
        ZkMxOPQu7SA4w+8M/qFR6PCtKg==
X-Google-Smtp-Source: AK7set/WZntuEziXN2YaI/cS4O20orw4Yw3GpGUOrBGyNYo6PuwOs635uCnb9R3l1O3CyZKM0lIQqQ==
X-Received: by 2002:a17:906:1511:b0:88d:d304:3432 with SMTP id b17-20020a170906151100b0088dd3043432mr25472687ejd.60.1676305524040;
        Mon, 13 Feb 2023 08:25:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id lu19-20020a170906fad300b007a9c3831409sm6915447ejb.137.2023.02.13.08.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 08:25:23 -0800 (PST)
Message-ID: <56281f37-2c7f-5f70-6c9e-87e950f06b0e@linaro.org>
Date:   Mon, 13 Feb 2023 18:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/10] drm/msm/dpu: Add SM6350 support
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Liu Shixin <liushixin2@huawei.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-7-konrad.dybcio@linaro.org>
 <a18cf663-115d-edc8-5e4b-3d19fcd9a02c@linaro.org>
 <cc364658-478a-f239-5d17-5ca2b7f7df8b@linaro.org>
 <20230213113008.ih7ii5m3cz4w3lmz@SoMainline.org>
 <8560b69f-8d42-995d-2f4d-11d6a64afef0@linaro.org>
 <20230213142831.hbzfp2chekshsqyy@SoMainline.org>
 <28c9ea04-fedb-16cf-f874-f4c965fbc445@linaro.org>
 <20230213151413.qhpzzcz4c6m6rynk@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230213151413.qhpzzcz4c6m6rynk@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 17:14, Marijn Suijten wrote:
> On 2023-02-13 16:58:00, Dmitry Baryshkov wrote:
>> So, *possible* the merge order is the following:
>> - fixes from https://patchwork.freedesktop.org/series/113910/ go to
>> msm-fixes
>> - fixes from your intf-te go to msm-fixes
>> - https://patchwork.freedesktop.org/series/111751/
>> - the rest of intf-te and catalog (*see below)
>> - DPU features
>> - new DPU platforms (might go together with DPU features)
>>
>> * That really depends on the availability of the patchsets. Most
>> probably, as your patchset also contains several fixups, it would be
>> easier to land it before catalog split/rework.
>>
>> So, if you have the available timeslot, could you please finish & send
>> intf te on top of msm-next.
> 
> Ack, I'll get to that immediately.  You might even pull in the
> intermediate patches linked above (that touch the catalog) to see how it
> integrates, if I remember correctly (it has been a while) the catalog
> changes should now be independent of driver changes...?

I'll check and if it goes well, I'll just cherry-pick them into my branch.

> 
>>> Sure, I will at least start looking at your 50-patch as part of catching
>>> back up.  Do you want to process that on the mailing list or via
>>> https://gitlab.freedesktop.org/drm/msm/-/merge_requests/44?
>>
>> I'd prefer to use email. The MR was open to doublecheck that nothing got
>> broken on sc7180.
> 
> Ack; will try providing feedback on the 50-patch series via email in
> parallel to getting INTF TE v2 out ASAP.  As discussed before I should
> probably add myself as reviewer to the drm/msm subsystem to have these
> patches in my inbox from the get-go though...

I'd support this.


-- 
With best wishes
Dmitry

