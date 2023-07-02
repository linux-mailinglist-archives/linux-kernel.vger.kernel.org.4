Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E0744E1C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGBOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:34:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B362E5E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 07:34:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6e7d7952eso2837011fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688308480; x=1690900480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNOyK3uM1VI6m2ZBZf4zg7COB6mHtjci4Ve6p9MOV60=;
        b=g/GsphzvegeJC4AemXYWP9s3yr4w9GkEeRuKCi4vE3l/psaKijNJ0MDScU4xx1saxj
         e4QGMP564C5HAxBmJll0bwNjrdn+dE5+5yIiivejJ0N0N5hf9LeCVkPRkhGHwqmSveLw
         cuR1GQLyqR7HztxiLZ6+j1chHeC+fN0Krzfh/uMDw6+jYr/f5SyNjm8oWEmnRx2PiR9y
         pEv+4FqjktlbThuDzrPljDlNYY4ybiPEjE5rNjfxRpn+qs/2/xTH1lHGc4T4VFotN03C
         iSXI/0mLadWPa8pvRzbeHI9e/Um81Gt66vLQOT8kGscYQ7EjzrB9IzoVdpWK8/vzuy9s
         LP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688308480; x=1690900480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNOyK3uM1VI6m2ZBZf4zg7COB6mHtjci4Ve6p9MOV60=;
        b=I1IXsGNrhAuD2VrsnIzaU5VNH53Fz/IYghyMQOHVZ11F4NFB0MOEjOTt9oItVEKtM4
         8mvnq9Ddb87tCJeAHTYWzT2AiHDts9IgqE5vh+sEy/SwJ6HokSkzNvWSa93nAdBOQCMN
         V8iOE062Nl9LUOOC5w3rkxlkpMbX+1A1Ovb0Gn7Q5fCgowTkUP0NL/p8QNbAqwPhtcxt
         ++g4y7ch6UgNJkjAS9ICWGsx17v69GCWvN8fT30U+nEzTiFFm1OV5wdc8mkwVvneUtaX
         hQjQsVxUcoz5hIfmCpf+iQSTvdipQIthWPtLAsZE4nxI1T7ywGbDZZqbrjiZ+/LPU6IR
         ujDw==
X-Gm-Message-State: ABy/qLaKuuEQ3r4+bgXDi14DRyRnfk/phYsGk3o+du+lhIT/sQjFtaF4
        WlWQV0W6JEbYPCJxvwUpeG0XwQ==
X-Google-Smtp-Source: APBJJlGCJgtGGjGH6KfxT38DxNOGKhtam0EoBWCqB/nQwtQ5gwJD9P3AfcHcH3Ig9iOIS6UPQTmU6Q==
X-Received: by 2002:a2e:7c0f:0:b0:2b6:d7a0:c27d with SMTP id x15-20020a2e7c0f000000b002b6d7a0c27dmr3000281ljc.37.1688308480371;
        Sun, 02 Jul 2023 07:34:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i23-20020a2e9417000000b002b6cba03427sm2059267ljh.79.2023.07.02.07.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 07:34:39 -0700 (PDT)
Message-ID: <5e70cb31-61a7-55d7-b3a5-5051e6d338e9@linaro.org>
Date:   Sun, 2 Jul 2023 17:34:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] drm/msm/adreno: Assign revn to A635
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>
References: <20230628-topic-a635-v2-1-5494c881b8be@linaro.org>
 <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com>
 <CAA8EJpripp+Hf=GvCit75naGQqK8owHzPb+VuYHin393HcFPwA@mail.gmail.com>
 <CAF6AEGsdPhWO+hw3FHiqtMfiF34_RtrvvS4apykHNBbtmdj7fQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAF6AEGsdPhWO+hw3FHiqtMfiF34_RtrvvS4apykHNBbtmdj7fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2023 17:31, Rob Clark wrote:
> On Sat, Jul 1, 2023 at 5:24 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Sat, 1 Jul 2023 at 18:50, Rob Clark <robdclark@gmail.com> wrote:
>>>
>>> On Fri, Jun 30, 2023 at 4:12 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> Recently, a WARN_ON() was introduced to ensure that revn is filled before
>>>> adreno_is_aXYZ is called. This however doesn't work very well when revn is
>>>> 0 by design (such as for A635). Fill it in as a stopgap solution for
>>>> -fixes.
>>>>
>>>> Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified before being set")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> Changes in v2:
>>>> - add fixes
>>>> - Link to v1: https://lore.kernel.org/r/20230628-topic-a635-v1-1-5056e09c08fb@linaro.org
>>>> ---
>>>>   drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> index cb94cfd137a8..8ea7eae9fc52 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] = {
>>>>                  .address_space_size = SZ_16G,
>>>>          }, {
>>>>                  .rev = ADRENO_REV(6, 3, 5, ANY_ID),
>>>> +               .revn = 635,
>>>>                  .fw = {
>>>>                          [ADRENO_FW_SQE] = "a660_sqe.fw",
>>>>                          [ADRENO_FW_GMU] = "a660_gmu.bin",
>>>>
>>>
>>> hmm, I realized a problem with this, it would change what
>>> MSM_PARAM_GPU_ID and more importantly MSM_PARAM_CHIP_ID return..  The
>>> former should be "harmless", although it isn't a good idea for uabi
>>> changes to be a side effect of a fix.  The latter is more problematic.
>>
>> I'd say MSM_PARAM_GPU_ID is broken for 635 anyway (won't it return 0
>> in this case)?
>> So the new value should be correct.
> 
> no, it is very much intentional that GPU_ID returns 0 for newer GPUs,
> userspace should be matching on CHIP_ID.  (Also, we should be moving
> away from trying to infer generation/etc from CHIP_ID.. userspace is
> farther ahead of the kernel on this.)

Thanks for the explanation. So in theory we can change this to always 
return 0? Or must we keep it to keep UABI / compatibility?

I'm trying to understand if we can drop revn at all.


> 
>> But more importantly, why are we exporting speedbin in
>> MSM_PARAM_CHIP_ID only if there is no revn? And why are we exporting
>> the speedbin at all as a part of CHIP_ID?
> 
> Basically just being paranoid about not changing uabi.  It probably
> would be ok to export the speedbin for all, but I'd have to double
> check mesa version history.

Thanks!

> 
> BR,
> -R
> 
>>>
>>> I think I'm leaning more towards reverting commit cc943f43ece7
>>> ("drm/msm/adreno: warn if chip revn is verified before being set") for
>>> -fixes.  I'm still thinking about options for a longer term fix.
>>>
>>> BR,
>>> -R
>>>
>>>
>>>> ---
>>>> base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
>>>> change-id: 20230628-topic-a635-1b3c2c987417
>>>>
>>>> Best regards,
>>>> --
>>>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>
>>
>>
>>
>> --
>> With best wishes
>> Dmitry

-- 
With best wishes
Dmitry

