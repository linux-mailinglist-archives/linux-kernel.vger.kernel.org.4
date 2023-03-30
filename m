Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D56D08BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjC3Owo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjC3Owl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:52:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A654976D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:52:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h25so24858678lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680187952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFDNA5O4BRFjY00+Z1LJW119elAYOYVUw4CBAie71cg=;
        b=eJWBU//eJrHG5mc3MWkqYZSyeiQVk3i4eaOJaS41ZDWBEDAUymCfUZpzw4Pa3onpqz
         fxSBz4CVxHV4C26hz68gTIB7+KPV6LMDDuTcrf9WHS6GBTTtSBLyNjrobEakV77CPSXb
         hnCSvLwk9tDgMA1LICJA9RS1zI5gShpEJev6LHd3x+QMwBgh1IwH2mkaxalD7ekwD6rG
         94FcZ9oMOdJEF4173i0w4lthkEKj+E7ny6cjXPk5/NYfW0Kp6A6rdQLXII9w43spK3Lg
         3px+6MCY3Ev88K6PUL95C1q2ctf/xYudq4ASG49tVVzgCEzMygzgtNL7cL0Ri1WwABfV
         jhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFDNA5O4BRFjY00+Z1LJW119elAYOYVUw4CBAie71cg=;
        b=ckYos/32IqUT265Kr+NBN6UuuNt3tl5CobXF0K7Pyeen09YElS1yBLK6sbKVpM6HGz
         +hb3o1lG08SYFsdehsVgA5mqGBj5iumUaqBamJZkG1gg9WkDem+SBmOu/GfSRJdBjCOr
         vXExWLiv3NGAVbdqQj7ekKRKPG8se52ibESTAHKPH5FYmwpk4Hdpq5XW+irdgNmn73qf
         UWWU1Gd04mnfAsqB8ZjGc/4t381F/satS56NrDuIUynNx4Eg0NZqoL7DzWrb2e5iuSgj
         /M6sCz4pyCm+Ez1wRrLGfaDjTefog7UOfL6suoqH12ap3MTZRiYh9ZkbL+XjV3FdUH2N
         ZPcw==
X-Gm-Message-State: AAQBX9e5e5J7kepQL6lWvEHJUmpLYlzgjew4xuVHYVWOS4JmP6l4gKA8
        ZkF2iO9nSj6RHZmIQgjZuqDE/g==
X-Google-Smtp-Source: AKy350bV2TIdi9zQe23PfA/0zCWQl3PFtYMIVplNdHrQIPV+NXfL02RAP+7MfBDh5lc4xKsVFwO3VQ==
X-Received: by 2002:a19:7919:0:b0:4e8:3cfe:98c7 with SMTP id u25-20020a197919000000b004e83cfe98c7mr1915967lfc.4.1680187952252;
        Thu, 30 Mar 2023 07:52:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q29-20020ac2511d000000b004eb09820adbsm2385504lfb.105.2023.03.30.07.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 07:52:31 -0700 (PDT)
Message-ID: <2eff49b1-f0ad-8d44-5902-93937867178b@linaro.org>
Date:   Thu, 30 Mar 2023 17:52:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/adreno: adreno_gpu: Use suspend() instead of
 idle() on load error
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230329140445.2180662-1-konrad.dybcio@linaro.org>
 <ZCRNFitcrAeH27Pn@hovoldconsulting.com>
 <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
 <CAA8EJpohEo+kMw7fx5112m+z7JHSLDmsqOL4T7hmyvr2fPP8vQ@mail.gmail.com>
 <b985e536-227d-df86-0f23-b58882e9654b@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <b985e536-227d-df86-0f23-b58882e9654b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 17:34, Konrad Dybcio wrote:
> 
> 
> On 29.03.2023 21:45, Dmitry Baryshkov wrote:
>> On Wed, 29 Mar 2023 at 18:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>>
>>>
>>> On 29.03.2023 16:37, Johan Hovold wrote:
>>>> On Wed, Mar 29, 2023 at 04:04:44PM +0200, Konrad Dybcio wrote:
>>>>> If we fail to initialize the GPU for whatever reason (say we don't
>>>>> embed the GPU firmware files in the initrd), the error path involves
>>>>> pm_runtime_put_sync() which then calls idle() instead of suspend().
>>>>>
>>>>> This is suboptimal, as it means that we're not going through the
>>>>> clean shutdown sequence. With at least A619_holi, this makes the GPU
>>>>> not wake up until it goes through at least one more start-fail-stop
>>>>> cycle. Fix that by using pm_runtime_put_sync_suspend to force a clean
>>>>> shutdown.
>>>>
>>>> This does not sound right. If pm_runtime_put_sync() fails to suspend the
>>>> device when the usage count drops to zero, then you have a bug somewhere
>>>> else.
>>> I was surprised to see that it was not called as well, but I wasn't able
>>> to track it down before..
>>
>> Could you please check that it's autosuspend who kicks in? In other
>> words, if we disable autosuspend, the pm_runtime_put_sync is enough()?
>>
>> That would probably mean that we lack some kind of reset in the hw_init path.
>>
>> On the other hand, I do not know how the device will react to the
>> error-in-the-middle state. Modems for example, can enter the state
>> where you can not properly turn it off once it starts the boot
>> process.
>>
>> And if we remember the efforts that Akhil has put into making sure
>> that the GPU is properly reset in case of an _error_, it might be
>> nearly impossible to shut it down in a proper way.
>>
>> Thus said, I think that unless there is an obvious way to restart the
>> init process, Korad's pm_runtime_put_sync_suspend() looks like a
>> correct fix to me.
> On the GPU side, when you cut GX and CX GDSCs, the hardware is off.
> Some clock / gdsc logic may be retained, but the GPU itself gets
> cut off. Parking the clocks and shuttting down VDD_GX (if exists)
> only makes that stronger.

If I remember correctly, GX and CX GPU GDSCs might be voted by other 
users. Again, I'd direct you here to the series at [1]

[1]: https://patchwork.freedesktop.org/series/111966/

-- 
With best wishes
Dmitry

