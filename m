Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB66C15B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCTO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjCTO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:56:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959830D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:54:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o4so710000ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679324051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Spp529PzCZgqhAAdlPnFv6OIEZrrIKgp/RWvJ8WolNg=;
        b=Bnf40LzQk0w775WdvYdPmAMTmhOjbWxNw+2yFjhkL7Fano+915afbnLRX5RFjw3+f/
         1Xph3gDde11HSLtOIyKNmu9RSJy6WS0cuLxnyeSxH9iCK5BUtaRU1cmxWFJ3OhnTgguU
         vTzFY7tlndVGGQe+gcGNsQYLzrTQTaepext9eBAF2ro8n5exu0In+DAWpR6lD2m/cUy9
         bhNO2lViuxSHKpLs6gel7u/J8Myrfl4E5bkgEBJmMQLtnrhM2w1nxBTxHgfoMHKlnlVG
         BeiWSO4/qNwT6VD0yW9L1Zqb2YA7InQNYpJacy+XpLs5zoUt7dFeCfV0bjblQBFIz4OF
         WLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679324051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Spp529PzCZgqhAAdlPnFv6OIEZrrIKgp/RWvJ8WolNg=;
        b=Hur33evAGiqQixZjcwFJuL1FJjSFxYOrlYcHXO+XwePMpui7Xv87bEWQBUtitQocSe
         VDisd+JxW2qcjI1xVn55koapqz9TDtHIdk4uI0lOInXJxpId73QwRRzQrYm0tCzNnLYl
         hgijahldk5uBNn9MP0pMfY+PeT+92lJhQha+0U/qg6YS+ZgHIpZIjKQNd5B2ukERpHxL
         kPc6uOolanhFVQP0e/LIspPcRgPlYP2eOIrZ8AaTtoam14v2Nw+6QdQ5B7aLFqLXM7bL
         sMwxjY5y53NBBQtVYCN20EmNfCUl4paw+wotNf+VkvJJ1y9m9DIjOr5Q4JO+QOW7aeXY
         avgA==
X-Gm-Message-State: AO0yUKW7U5GDU9WgIY2tGptBH0xP2IGDgIotM0EE0xyCWJ/SpIHXMF1X
        PUnpx6hgZCUHlkaYF5SXtTR66A==
X-Google-Smtp-Source: AK7set9UYHJ/Xq6ZI+7zEKJw+l9/by83tYwPGdo3BTSPPzwIWoekfXNftqMx/5eZFnN/3zGJF1JIfQ==
X-Received: by 2002:a2e:980e:0:b0:29a:96f0:54ed with SMTP id a14-20020a2e980e000000b0029a96f054edmr73588ljj.30.1679324051447;
        Mon, 20 Mar 2023 07:54:11 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e98c9000000b00293534d9757sm1783102ljj.81.2023.03.20.07.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:54:11 -0700 (PDT)
Message-ID: <909746ad-a6b9-18d8-cb43-b2460c7181d0@linaro.org>
Date:   Mon, 20 Mar 2023 15:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
 <99eeebc6-69aa-c6ba-139b-92672c299747@linaro.org>
 <893851c9-c8be-ed7f-ebde-5d90b9313f6d@linaro.org>
 <48ac4272-0e11-d943-e950-0be8d93fb036@linaro.org>
 <b7f0c568-72b7-3342-decc-784cd5f68b1a@linaro.org>
 <1091d8b4-3dd3-427b-2fcb-c3e0d32b0a3b@linaro.org>
 <aa8db9a1-ac11-acbe-1a05-b60c39989bc1@nexus-software.ie>
 <28b0eed5-6e80-e424-70bb-ba984fdbc1ac@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <28b0eed5-6e80-e424-70bb-ba984fdbc1ac@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.03.2023 07:39, Dikshita Agarwal wrote:
> 
> On 2/28/2023 10:23 PM, Bryan O'Donoghue wrote:
>> On 28/02/2023 15:41, Konrad Dybcio wrote:
>>>> Can you test it and make sure ?
>>> As I mentioned in the cover letter, 8250 still seems to work with this
>>> patchset. I have no idea how one would go about validating the
>>> functionality enabled through this call.
>>
>> We offlined about this.
>>
>> I think it is correct to say you don't have access to a display to test this on sm8250.
>>
>> I do so, I will try this out for you, though I'll wait for your V2 for this series.
>>
>> ---
>> bod
> 
> Hi Konrad,
> 
> I understand from your commit text, setting this indicator for AR50L is causing issue with suspend.
> 
> Ideally it shouldn't cause any such issue. I checked with FW team and got to know that this property is not supported on AR50LT so if you set it there should be some property not supported error.
> 
> In my opinion it would be good to replace these versions checks with VPU version check you have introduced in your other patch and keep this setting for current targets and not set wherever not needed eg AR50LT.
So.. I did *something* and I'm no longer getting a jump to EDL.

The *something* being knocking off hfi_core_suspend().

If I send a sys_idle_indicator = true, I get (reformatted for
better legibility):


[    0.576543] qcom-venus 5a00000.video-codec: VenusFW  :
<VFW_H:HostDr:unkn:--------:-> IMAGE_VARIANT_STRING=PROD

[    0.603818] qcom-venus 5a00000.video-codec: VenusFW  :
<VFW_H:HostDr:unkn:--------:-> OEM_IMAGE_VERSION_STRING=CRM

[    0.608633] qcom-venus 5a00000.video-codec: VenusFW  :
<VFW_H:HostDr:unkn:--------:-> BUILD_TIME: Mar 15 2021 04:24:58

[    0.608644] qcom-venus 5a00000.video-codec: VenusFW  :
<VFW_L:HostDr:unkn:--------:-> Host cmd 0x10005

[    0.608655] qcom-venus 5a00000.video-codec: VenusFW  :
<VFW_E:HostDr:unkn:--------:-> VenusHostDriver_SetSysProperty(1019): HostDriver:  VenusHostDriver_SetSysProperty unsupport property!

[    0.608667] qcom-venus 5a00000.video-codec: VenusFW  :
<VFW_E:HostDr:unkn:--------:-> WaitForHWidle(408): VENUS is idle, no HW is running 

[    0.650759] qcom-venus 5a00000.video-codec: VenusFW  :
<VFW_E:HostDr:unkn:--------:-> assert_loop(433):
FW Assertion - Z:/b/venus_proc/venus/drivers/src/VenusHostDriver.c:1020:5ab9a


Which then crashes Venus for good (perhaps we're missing a
handler for such errors that would hard reset the hw), meaning
trying to access it through ffmpeg will result in it never firing
any IRQs, so no submitted commands ever complete.

With this information, after uncommenting the hfi_core_suspend
call and changing:

[1]
--- hfi_venus.c : venus_suspend_3xx() --

- venus_prepare_power_collapse(hdev, true);
+ venus_prepare_power_collapse(hdev, false);

----------------------------------------

I was able to test further. Turning the ARM9 core off messes
with the sys_idle things. Perhaps some power sequencing is
wrong. The diff I just mentioned comes from the fact that
AR50L will never ever ever send a PC_PREP_DONE ack, or at
least downstream never expects it (or any other HFI6XX
target FWIW) to do so.


Now, I also realized the adjacent set_power_control doesn't seem to be used at
all on msm-4.19 techpack/video. Testing all the possible combinations, I get
(to make it extra clear, with all the powerdown stuff in place and only diff
[1] in place atop what I already had before):


[set_idle_message] [set_power_control] [result]
0 0 - no crash at boot, venus doesn't work ->
	"Too many packets buffered for output stream 0:1."

0 1 - no crash at boot, ffmpeg hangs near vdec session init ->
	jump to EDL shortly after

1 0 - hang at boot, even before display subsys initializes ->
	platform totally hangs

1 1 - same as (1, 0), probably due to sys_idle_indicator being on ->
	platform totally hangs as well

Perhaps (0, 0) is "good" and things can be worked up from there?
Can you recheck with the firmware team if this is expected?

Konrad
> 
> Thanks,
> 
> Dikshita
> 
