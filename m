Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4D694A38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjBMPF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBMPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:05:23 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929121E5C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:05:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw12so32651048ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXOmuQpMwFH/B4axgmO48iMJUN2ivWFM2F65C3j3620=;
        b=qQpacBq7NBmt+Iw5lDyJvHs51VgJz/17PpxAB6Q3/U/iDG2w/aOM5OZCk0z3wVrt5k
         14ZiQERQKLmANV6XWMnG0I2M11rBb24uCxBefWVO74rulRwRjyfqUvU5HIPlMRALD772
         IQOwHzVUFmcfXJXeHwM0U0poBSKsHimlbysdHJVQed3ZGOzKLovYqdjXsYORlCex4Asz
         X552vxuQrf5oyam7Ib613WSdxL+awmEgBFSELQvCiaYO3a1VGbDhm9Nsjb7Ye1QZ5m/u
         T8R+ynmX2NTl91mpJfAtObU8OGClVA3ZNVjLlRrLHlZkfBhNaWAakB979ugxw5KVf/qn
         xp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXOmuQpMwFH/B4axgmO48iMJUN2ivWFM2F65C3j3620=;
        b=umFeXTUGo41Pp+cL3zRtLMtz29oTx8/UGg8qKST8hcDQZ/MvxAq7hHkOCii2Y37jsi
         vlBuikWCPlzfzLbMaBZnoxqn+MhdNf3dzxZ6TPWAyNvTB4GCIzyfiFOBn2bSt+1zay+q
         i9k8Lyo5ZlGzzy/CYtYL1k1wzRAN70DqfUyX1kqwVRKkI5KFRZaVcsSUKVeXnPCG1Gk3
         z8lBiQwvj1J1bg+gfaCuPKdmpyVyOdBUlo9hLMgf4z4/hctG2ihJdIzSwbfbsXEugvOI
         U6I1by30//+wASazYS7yr+z9kWT+PY+SMaRS7l2N25DJHOomQ9bfuABdjXZkY0IAdqgU
         vidA==
X-Gm-Message-State: AO0yUKVQd6jsJYYGTIJ4qoJ8LSkX8E+S00PJZAUXD7ZUZ6jKPfx8ZgIg
        yMaG+FOQTWZUo6B5mM4dfkvfQQ==
X-Google-Smtp-Source: AK7set8ak7Vpr70aH/JFGBOVh5vkZ0AWJD04GxE/bkytBdUPhoxoPZHDY7glyBQEfhhxTMVcwyuV5w==
X-Received: by 2002:a17:907:a804:b0:8a6:5720:9101 with SMTP id vo4-20020a170907a80400b008a657209101mr28374752ejc.4.1676300716075;
        Mon, 13 Feb 2023 07:05:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bo13-20020a170906d04d00b008874c903ec5sm6914103ejb.43.2023.02.13.07.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:05:15 -0800 (PST)
Message-ID: <6ad96cff-b91b-a4c7-4573-7bb8de7194f8@linaro.org>
Date:   Mon, 13 Feb 2023 17:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/10] drm/msm/dpu: Allow variable SSPP/INTF_BLK size
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-6-konrad.dybcio@linaro.org>
 <20230213111220.ietr4aro6xu4emtu@SoMainline.org>
 <e6653ceb-bce1-9552-019d-278f455ba8a5@linaro.org>
 <20230213143148.qvyagudd3qm5jgwd@SoMainline.org>
 <e3c1a048-a9e1-53fa-5a19-cba62e8b1580@linaro.org>
 <20230213150226.du27ocydnyrkvuin@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230213150226.du27ocydnyrkvuin@SoMainline.org>
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

On 13/02/2023 17:02, Marijn Suijten wrote:
> On 2023-02-13 16:40:56, Dmitry Baryshkov wrote:
>> On 13/02/2023 16:31, Marijn Suijten wrote:
>>> On 2023-02-13 13:38:33, Dmitry Baryshkov wrote:
>>>> On 13/02/2023 13:12, Marijn Suijten wrote:
>>>>> On 2023-02-11 13:26:51, Konrad Dybcio wrote:
>>>>>> These blocks are of variable length on different SoCs. Set the
>>>>>> correct values where I was able to retrieve it from downstream
>>>>>> DTs and leave the old defaults (0x1c8 for sspp and 0x280 for
>>>>>> intf) otherwise.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>>>     .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 242 +++++++++---------
>>>>>>     1 file changed, 121 insertions(+), 121 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>>>> index 802050118345..d9ef1e133c1e 100644
>>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>>> [..]
>>>>>> @@ -1848,10 +1848,10 @@ static struct dpu_dsc_cfg sm8150_dsc[] = {
>>>>>>     /*************************************************************
>>>>>>      * INTF sub blocks config
>>>>>>      *************************************************************/
>>>>>> -#define INTF_BLK(_name, _id, _base, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
>>>>>> +#define INTF_BLK(_name, _id, _base, _len, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
>>>>>
>>>>> Dmitry and I discussed in #freedreno to instead add the INTF_BLK_DSI_TE
>>>>> macro that accounts for the INTF TE registers using this higher register
>>>>> area, as well as an extended signature to configure extra interrupts.
>>>>
>>>> Yes, that's still the plan. It's slightly painful that we are touching
>>>> this are simultaneously.
>>>
>>> Should we (Konrad) then drop this patch as there's no need to add these
>>> (mostly RAZ/WI) registers to the dump until my INTF TE series starts
>>> using them?  That'll make rebasing easier on everyone too.
>>
>> RAZ/WI is for not present registers (read-as-zero/write-ignore). I think
>> that the growing register space is getting populated with registers
>> (which we have been ignoring up to now).
> 
> They are, but not until my INTF TE series lands; hence again the request
> to drop this patch until that happens?

I see nothing wrong with including them into the snapshots.

Dropping this single patch will still result in the huge amount of 
rejects. So, let's get your INTF TE done, I'll rebase my work on top of it.

-- 
With best wishes
Dmitry

