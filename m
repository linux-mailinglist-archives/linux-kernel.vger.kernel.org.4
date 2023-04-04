Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401F56D6AEA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjDDRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbjDDRwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:52:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F82D61
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:52:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h11so36405253lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680630730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrQ9Nk/ZqyT6PCBf5HyzrcvGRnNXSx6wEgKVrWsu1Ww=;
        b=gryqHmNGVwdHcrupS+brUu78qIBxYUYs6tcxtpAJ5KJhB465EyC79ukjwZGMdR0uv3
         wDE+owTqx8cu/iO1u/E9scdJAVcy26TBfYuXdeqPXJo23dXfPXXUBNqRD08bODIk2pF6
         xsSHZW+kxwoiRRefP7TySqeEKmF/BYFyU1iTj7KRo5slDUAySfC0SjSxAO2vC08xwe/t
         qjZ8RJi7L93v3rFgkxK4xCMDt641++armwBXRQoV6FAtVPhuFOu0G0NhBKv8s6FOsmEv
         7GRnfLSR3xQLqIdTZCofvFSh3LrBeFDZE2v65KP5y8ocpP1J7RwAKrZBICdLlY9UFAsn
         b/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680630730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrQ9Nk/ZqyT6PCBf5HyzrcvGRnNXSx6wEgKVrWsu1Ww=;
        b=TlrpdAYbF7DkiVGCs9IAcRW04qoItPQNamB8qtClKQIwNhzeJKZx9Of2brD/AHxuSV
         Vi9NGT/+a4fP2HDW8Soy4vA8m2Dosl22G90LT94rc6j0cvdCAuKD7vkdp8YLJRlLzOAr
         sMF0DpOtywrT2lnS9XuGoo5Om0Xx7YwAUPjU4w18a/hI5w81emlXqLu9F9706fM2YAEF
         K0eDTJv7PK1bdvObSHx+utdLtXyi9v3SvJVx9v1DAQ8GBxvUpoyonBkadLN8XMzBaLj9
         HwZ9Z0iA9hEiB6zyM+acNwEgmSljsEY1hUBBWUxZaJm33dcd0WhEkbRPT1wOsPclb4eX
         C/7A==
X-Gm-Message-State: AAQBX9e4/d+1+lbQKdcVeYXBKHOWEWUnbKaHnTdgONhnzJTlp2UrSE2g
        uI1GNvoC23yXtI6gYen+7tzjhBbJMYnmK0GRVBU=
X-Google-Smtp-Source: AKy350bPKGXIlcrnZI/qixYG1byf7Rly7InMsFsRfB8gb/+aPlSEzEY2IBTwrqlfQ7Yiny/IOPBszQ==
X-Received: by 2002:ac2:4e49:0:b0:4db:19fb:6a7 with SMTP id f9-20020ac24e49000000b004db19fb06a7mr858515lfr.60.1680630730335;
        Tue, 04 Apr 2023 10:52:10 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512040e00b004dc83d04840sm2417541lfk.79.2023.04.04.10.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 10:52:09 -0700 (PDT)
Message-ID: <955cd520-3881-0c22-d818-13fe9a47e124@linaro.org>
Date:   Tue, 4 Apr 2023 19:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
 <99eeebc6-69aa-c6ba-139b-92672c299747@linaro.org>
 <893851c9-c8be-ed7f-ebde-5d90b9313f6d@linaro.org>
 <48ac4272-0e11-d943-e950-0be8d93fb036@linaro.org>
 <b7f0c568-72b7-3342-decc-784cd5f68b1a@linaro.org>
 <1091d8b4-3dd3-427b-2fcb-c3e0d32b0a3b@linaro.org>
 <aa8db9a1-ac11-acbe-1a05-b60c39989bc1@nexus-software.ie>
 <28b0eed5-6e80-e424-70bb-ba984fdbc1ac@quicinc.com>
 <909746ad-a6b9-18d8-cb43-b2460c7181d0@linaro.org>
 <e93ba74a-ccde-c6bd-4302-8884144d615d@quicinc.com>
 <bf5e30fa-5014-5585-3b8e-b1a8d2f95549@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <bf5e30fa-5014-5585-3b8e-b1a8d2f95549@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 12:44, Vikash Garodia wrote:
> On 3/24/2023 2:46 PM, Dikshita Agarwal wrote:
>>
>>
>> On 3/20/2023 8:24 PM, Konrad Dybcio wrote:
>>> On 2.03.2023 07:39, Dikshita Agarwal wrote:
>>>> On 2/28/2023 10:23 PM, Bryan O'Donoghue wrote:
>>>>> On 28/02/2023 15:41, Konrad Dybcio wrote:
>>>>>>> Can you test it and make sure ?
>>>>>> As I mentioned in the cover letter, 8250 still seems to work with this
>>>>>> patchset. I have no idea how one would go about validating the
>>>>>> functionality enabled through this call.
>>>>> We offlined about this.
>>>>>
>>>>> I think it is correct to say you don't have access to a display to test this on sm8250.
>>>>>
>>>>> I do so, I will try this out for you, though I'll wait for your V2 for this series.
>>>>>
>>>>> ---
>>>>> bod
>>>> Hi Konrad,
>>>>
>>>> I understand from your commit text, setting this indicator for AR50L is causing issue with suspend.
>>>>
>>>> Ideally it shouldn't cause any such issue. I checked with FW team and got to know that this property is not supported on AR50LT so if you set it there should be some property not supported error.
>>>>
>>>> In my opinion it would be good to replace these versions checks with VPU version check you have introduced in your other patch and keep this setting for current targets and not set wherever not needed eg AR50LT.
>>> So.. I did *something* and I'm no longer getting a jump to EDL.
>>>
>>> The *something* being knocking off hfi_core_suspend().
>>>
>>> If I send a sys_idle_indicator = true, I get (reformatted for
>>> better legibility):
>>>
>>>
>>> [    0.576543] qcom-venus 5a00000.video-codec: VenusFW  :
>>> <VFW_H:HostDr:unkn:--------:-> IMAGE_VARIANT_STRING=PROD
>>>
>>> [    0.603818] qcom-venus 5a00000.video-codec: VenusFW  :
>>> <VFW_H:HostDr:unkn:--------:-> OEM_IMAGE_VERSION_STRING=CRM
>>>
>>> [    0.608633] qcom-venus 5a00000.video-codec: VenusFW  :
>>> <VFW_H:HostDr:unkn:--------:-> BUILD_TIME: Mar 15 2021 04:24:58
>>>
>>> [    0.608644] qcom-venus 5a00000.video-codec: VenusFW  :
>>> <VFW_L:HostDr:unkn:--------:-> Host cmd 0x10005
>>>
>>> [    0.608655] qcom-venus 5a00000.video-codec: VenusFW  :
>>> <VFW_E:HostDr:unkn:--------:-> VenusHostDriver_SetSysProperty(1019): HostDriver:  VenusHostDriver_SetSysProperty unsupport property!
>>>
>>> [    0.608667] qcom-venus 5a00000.video-codec: VenusFW  :
>>> <VFW_E:HostDr:unkn:--------:-> WaitForHWidle(408): VENUS is idle, no HW is running
>>>
>>> [    0.650759] qcom-venus 5a00000.video-codec: VenusFW  :
>>> <VFW_E:HostDr:unkn:--------:-> assert_loop(433):
>>> FW Assertion - Z:/b/venus_proc/venus/drivers/src/VenusHostDriver.c:1020:5ab9a
>>
>> this "unsupported property" error and then the assert from FW is expected on AR50LT if driver sets HFI_PROPERTY_SYS_IDLE_INDICATOR to FW.
>>
>> As I mentioned in my other reply, this property doesn't need to be set by driver now, FW internally always enables it.
>>
>>> Which then crashes Venus for good (perhaps we're missing a
>>> handler for such errors that would hard reset the hw), meaning
>>> trying to access it through ffmpeg will result in it never firing
>>> any IRQs, so no submitted commands ever complete.
>>>
>>> With this information, after uncommenting the hfi_core_suspend
>>> call and changing:
>>>
>>> [1]
>>> --- hfi_venus.c : venus_suspend_3xx() --
>>>
>>> - venus_prepare_power_collapse(hdev, true);
>>> + venus_prepare_power_collapse(hdev, false);
>>>
>>> ----------------------------------------
>>>
>>> I was able to test further. Turning the ARM9 core off messes
>>> with the sys_idle things. Perhaps some power sequencing is
>>> wrong. The diff I just mentioned comes from the fact that
>>> AR50L will never ever ever send a PC_PREP_DONE ack, or at
>>> least downstream never expects it (or any other HFI6XX
>>> target FWIW) to do so.
>>>
>>>
>>> Now, I also realized the adjacent set_power_control doesn't seem to be used at
>>> all on msm-4.19 techpack/video. Testing all the possible combinations, I get
>>> (to make it extra clear, with all the powerdown stuff in place and only diff
>>> [1] in place atop what I already had before):
>>>
>>>
>>> [set_idle_message] [set_power_control] [result]
>>> 0 0 - no crash at boot, venus doesn't work ->
>>>     "Too many packets buffered for output stream 0:1."
>>>
>>> 0 1 - no crash at boot, ffmpeg hangs near vdec session init ->
>>>     jump to EDL shortly after
>>>
>>> 1 0 - hang at boot, even before display subsys initializes ->
>>>     platform totally hangs
>>>
>>> 1 1 - same as (1, 0), probably due to sys_idle_indicator being on ->
>>>     platform totally hangs as well
>>>
>>> Perhaps (0, 0) is "good" and things can be worked up from there?
>>> Can you recheck with the firmware team if this is expected?
>>
>> I will check regarding set_power_control(HFI_PROPERTY_SYS_CODEC_POWER_PLANE_CTRL) with FW team and get back.
>>
> HFI_PROPERTY_SYS_IDLE_INDICATOR is not supported beyond 8916 (which is versioned as V1 in video driver). This can be dropped.
> 
> Since the property is not functionally active, it is upto firmware when they might decide to start error out as unsupported property.
> 
> SYS_CODEC_POWER_PLANE_CTRL is supported for AR50/AR50L/IRIS1/2. It is a mandatory HFI to get the required power benefits.
> 
> vcodec0 GDSC should be also configured as HW_CTRL while setting POWER_PLANE_CTRL to firmware.
> 
Okay that's very good to know. To sum it up, the outcome you would
expect is (more or less):

- static bool venus_sys_idle_indicator = true;

[...]

- if(IS_V4(hdev->core) || IS_V6(hdev->core))
-	venus_sys_idle_indicator = true;

+ venus_sys_idle_indicator = IS_V1(hdev->core);


?

Konrad
>> Thanks,
>>
>> Dikshita
>>
>>> Konrad
>>>> Thanks,
>>>>
>>>> Dikshita
>>>>
