Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA35694964
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjBMO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjBMO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:58:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EDF17145
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:58:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p26so32470876ejx.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0Ex7E8/vmOGGjqbpJ8kCxNFK5nmMmqwxxY1Vu/9df4=;
        b=hee2ImtXzsBXl0kILmav25lZmZsTObzYVFVKMe+g/lNF6+c0BpUFXcMx9n3LtCFfAS
         fY/UayWHlXuu52LpVgIUwb1cJOXkdoktHBPJtUnTxNjgnVT0CIeak8nft+iTcWcuaf0l
         3IowKe/30r585w16pMnsZzRUc+NaCZ+hpFsQcizjJPMVo25r+2kMBHz3HMsgUhiLdcm/
         c6FzCKd1MyuY00EY7AU2CnedoLJYftFvM0kcjs1+70Pn8w6P/WmoJ7f1IHyALYeNwhyS
         bLTHvinZ4AHJfH/LIo0NWjFSkrNgxsQGgtN8bXsfr1EOGcZqhD8g80mPjGqODTTGN2f1
         rT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0Ex7E8/vmOGGjqbpJ8kCxNFK5nmMmqwxxY1Vu/9df4=;
        b=pFzJ8QKZvl3oq5BH/0HlZ9Hg5WlM1E4VwwQRX7z+yQZDImSxf3rUrvs7sRSjCBI0+L
         S8wdhdEAdsXqZ2Hmod9Iau4b4UBYXgyM0uv/D7a9HTclauVSqNqBYEfBUT0ySdNHvOX+
         PW8Z+od51tgQBpft5hedOIa4/CwbIT45LrL8IYuvbdwAsjog+xO0/Yw31UMKGvor26Oy
         wiOpj9bsrfzsoqbAeR28oXUmsTn0FHQ81Ki4vcYYM172jVJY9V3rm46YWclltbaXNC6r
         /JOOcnhSlc4PkpEBFNrOiYoMblhBGXBlSToyc7fjJzPqvxepvFlyIZ54TpSRusQ2PdDM
         JgyQ==
X-Gm-Message-State: AO0yUKXBdEKCXR3iSD1rQan8aaR/0Ra7hHRVf8v63kzeGig555kVeeuE
        klsH8lUomOPmMCekiVylxNz8LA==
X-Google-Smtp-Source: AK7set8/0u0A9i1O4BrN3E62HOfZ77pOUJdLLuGEIVIOcdxEJSmdM56oSksfFW5QH1OXL2J1oe81zw==
X-Received: by 2002:a17:907:c21:b0:8af:9c84:9412 with SMTP id ga33-20020a1709070c2100b008af9c849412mr12333294ejc.71.1676300282962;
        Mon, 13 Feb 2023 06:58:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x27-20020a170906135b00b007ae32daf4b9sm6883519ejb.106.2023.02.13.06.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:58:02 -0800 (PST)
Message-ID: <28c9ea04-fedb-16cf-f874-f4c965fbc445@linaro.org>
Date:   Mon, 13 Feb 2023 16:58:00 +0200
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230213142831.hbzfp2chekshsqyy@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 16:28, Marijn Suijten wrote:
> On 2023-02-13 13:35:01, Dmitry Baryshkov wrote:
>> On 13/02/2023 13:30, Marijn Suijten wrote:
>>> On 2023-02-13 12:15:19, Konrad Dybcio wrote:
>>> [...]
>>>>>> @@ -1674,6 +1765,15 @@ static struct dpu_pingpong_cfg sc8280xp_pp[] = {
>>>>>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31), -1),
>>>>>>     };
>>>>>>     +static struct dpu_pingpong_cfg sm6350_pp[] = {
>>>>>> +    PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk,
>>>>>
>>>>> No TE support?
>>>> It's.. complicated.. With just this patch, display refreshes, albeit
>>>> not at 60fps. Marijn is working on getting it going, though
>>>>
>>>> https://github.com/SoMainline/linux/commits/marijn/longbois-next/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>
>>> This branch hasn't been updated for the longest time.  I'm preparing v2
>>> of the INTF TE series at:
>>>
>>> https://github.com/SoMainline/linux/commits/marijn/dpu/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>
>>> and it has about ±40% of Dmitry's review applied.  More to come now that
>>> hiatus is over.
>>
>> We should agree on landing order for my rework vs your changes. Can I
>> try persuading you to review that 50-patches beast? With the hope that
>> you'd agree to land your changes on top of it?
> 
> SM6115 unexpectedly landing in advance of SM8[345]0 was already an
> unnecessary headache to deal with, and now we're "changing direction" on
> landing SM6350/75 in advance of INTF TE too...  not to forget about
> SM6125 which I also keep rebasing locally but planned on landing _after_
> INTF TE.  Regardless of the extra effort it will take from me I'd be
> happy to land my patches after everyone else's to have final say over
> which setup gets what bitflags and interrupts, as these typically got
> botched in our trees after rebases leading to broken INTF TE.
> Perhaps I should resubmit the individual Fixes: commits though?

What is the current status of your INTF TE patchset? If it's mostly 
ready, I can rebase my patch-bomb on top of it.

I definitely do not want to merge new platforms before sorting out INTF 
TE and the catalog. Handling sc8280xp, sm8350, sm8450 and sm6115 was a 
nightmare. The restructure targets making addition of new platforms simpler.

> Feel free to propose a merge order listing all the aforementioned SoCs,
> your rework, my INTF TE patches and whatever else is in the pipeline.
> As I've been away for a while, and only have limited hobby time (_and_
> have to split that on various projects), I'm behind on what's currently
> in swing for DPU (need additional time to catch back up) nor will be
> able to rebase/resubmit my patches often (a set-in-stone merge order
> will really help prioritise/plan ahead here).

We have several patchsets in the pipeline (PSR, color-transformation 
rework, wide planes) which do not touch the catalog, so the amount of 
conflicts should be pretty minimal. We are still waiting for DSC 1.2 v2, 
but it definitely will take time to mature even if v2 is posted today.

So, *possible* the merge order is the following:
- fixes from https://patchwork.freedesktop.org/series/113910/ go to 
msm-fixes
- fixes from your intf-te go to msm-fixes
- https://patchwork.freedesktop.org/series/111751/
- the rest of intf-te and catalog (*see below)
- DPU features
- new DPU platforms (might go together with DPU features)

* That really depends on the availability of the patchsets. Most 
probably, as your patchset also contains several fixups, it would be 
easier to land it before catalog split/rework.

So, if you have the available timeslot, could you please finish & send 
intf te on top of msm-next.

> Sure, I will at least start looking at your 50-patch as part of catching
> back up.  Do you want to process that on the mailing list or via
> https://gitlab.freedesktop.org/drm/msm/-/merge_requests/44?

I'd prefer to use email. The MR was open to doublecheck that nothing got 
broken on sc7180.

-- 
With best wishes
Dmitry

