Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650066A0BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjBWOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjBWOR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:17:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E87E58B73
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:17:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so14007645lfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjpWiXyFsyCrtS44Y9ufyYtxzc3mAZyPt7gCiq2NI9k=;
        b=sKA2HujbGoWIh+Q49GzD0s61o6Ytvqd2ecyf8Ls5Trm4SY+xAe52q9WN8c/NnX0dfR
         XQLlZqBcN4Pe7GCeZ0PUnCxNR5iWcJxq/6Kt8TSEXB73FQMjTUxzMU8NZSLnOxwtqDHG
         TfvMyioKVGwohJc4eUTp3ypAHBFaKsPWbBvXBbG+tiUAVpjzqrMjXpo1SXHyDPiZ101k
         Ynaw/p8oYVug8S+KAKmIyjWG4PBcJqXnrQ9ss2NoSUhCkiBURP6XhJ4DPwRhos/gu0EG
         finE1yPU87kZ+nbJe0xRCR2o2n3NPvpv61ZQmMYxBC7jf5DPUDJE8HmQ8CmqqW7/U+Bj
         iHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjpWiXyFsyCrtS44Y9ufyYtxzc3mAZyPt7gCiq2NI9k=;
        b=0Fu/Xyc3Wrcb8mz2aSW8q3Iqu2Pmu3MYVUQGRgru2r8yB3VsbQDouldM5TEdbFub35
         5JtKBo4u4jiCabuPcqMLv3lwykN+w9TmVUaQP4oeMxeoG8in0Xc1olqOOAPizB7/uY+E
         2e6goa8BZOEXjpPfcTGDd3HY2eshqt/Tg8aXgxA2nkDDug+/AOdm2fbWFQdSruRWptOj
         epWaaALf53hSGhpCIp4/wWm7lpI9yThXE0lNpgWX35+uDLg/mhNhxkEhWeorhK2d6eCr
         G+rZc8GNWVlwszoh1CRBBKXBMaPEf3T1QKtqqq8R6mxU9qWmddb1Apx9IKLK1V3otyDO
         DToQ==
X-Gm-Message-State: AO0yUKVKwhxw66BDPHMVXDNQSgaMX95IT9b+k4BYiDnddW0Dxw8xjrUR
        c+3GRafvFJUv8YSWaB2kMjxjHEPVOhx5fnmZ
X-Google-Smtp-Source: AK7set+nQT9T7mX6awdiWAmd0xuCbbHlb7DjuH8yId5tYvhS+CJcA2ETt4LLmE8AZPPqARFzhWsQ8Q==
X-Received: by 2002:a19:c502:0:b0:4d8:684e:c94c with SMTP id w2-20020a19c502000000b004d8684ec94cmr5330426lfe.13.1677161863240;
        Thu, 23 Feb 2023 06:17:43 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id u8-20020ac25188000000b004d86808fd33sm273904lfi.15.2023.02.23.06.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:17:42 -0800 (PST)
Message-ID: <45156f6a-6f18-6d7c-5d4a-e66ea9cca724@linaro.org>
Date:   Thu, 23 Feb 2023 15:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 08/10] interconnect: qcom: msm8996: Specify no bus
 clock scaling on A0NoC
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
 <20230217-topic-icc-fixes-v5-v5-8-c9a550f9fdb9@linaro.org>
 <8c4f1cc8-c1f8-06b6-53fe-7507d74ca958@linaro.org>
 <3c205131-632a-6592-5dc0-82313b26e5f6@linaro.org>
 <CAA8EJprJYPAsFZgu-DwjOHm6FsUEJ309zDo=Muh04L4B4oWhmw@mail.gmail.com>
 <5a2f502a-6530-dc8c-a81e-3d2a33964366@linaro.org>
 <20230223140710.72qcxcvyme5npf2v@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230223140710.72qcxcvyme5npf2v@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.02.2023 15:07, Bjorn Andersson wrote:
> On Fri, Feb 17, 2023 at 09:28:54PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 17.02.2023 21:26, Dmitry Baryshkov wrote:
>>> On Fri, 17 Feb 2023 at 21:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 17.02.2023 20:27, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 17.02.2023 11:46, Konrad Dybcio wrote:
>>>>>> A0NoC only does bus scaling through RPM votes and does not have any
>>>>>> ICC clocks. Describe this.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>> This is bad, as devm_clk_get_bulk{"", _optional} doesn't
>>>>> check if num_clocks makes sense and passes "-1" down the
>>>>> devres alloc chain..
>>>>>
>>>>> I'll rework this for the next revision by simply assigning
>>>>> the common "bus", "bus_a" set everywhere instead of relying
>>>>> on it being there by default..
>>>> Or maybe I shouldn't, as that will require redefining the array
>>>> over and over again.. Perhaps just passing <&xo_board>, <&xo_board>
>>>> to a0noc's "bus", "bus_a", similar to what's been done on SDM630's
>>>> GNoC would be less messy?
>>>
>>> What about simply skipping a call to devm_clk_get if num_bus_clocks is negative?
>> I tested that locally before reporting the mistake on my side and
>> while it works, I just consider it.. ugly, because:
>>
>> num_clocks =
>>> 0 => use the externally specified num_/clocks (logical)
>> =0 => use the default 2
> 
> Why not let go of this "convenience" and have num_clocks actually mean
> number of clocks?
Sounds good.. Should I keep the default "bus", "bus_a" on absence of
.bus_clocks still, to avoid duplicating objects?

Konrad

> 
> Regards,
> Bjorn
> 
>> <0 => consider there's zero
>>
>> ..but maybe that's just me.. if you don't find it ugly, I may just
>> go with that.
>>
>> Konrad
>>>
>>>>
>>>> Konrad
>>>>>
>>>>> Konrad
>>>>>>  drivers/interconnect/qcom/msm8996.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
>>>>>> index 1a5e0ad36cc4..45eb8675fb11 100644
>>>>>> --- a/drivers/interconnect/qcom/msm8996.c
>>>>>> +++ b/drivers/interconnect/qcom/msm8996.c
>>>>>> @@ -1817,6 +1817,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
>>>>>>      .type = QCOM_ICC_NOC,
>>>>>>      .nodes = a0noc_nodes,
>>>>>>      .num_nodes = ARRAY_SIZE(a0noc_nodes),
>>>>>> +    .num_bus_clocks = -1, /* No bus clock scaling */
>>>>>>      .intf_clocks = a0noc_intf_clocks,
>>>>>>      .num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
>>>>>>      .has_bus_pd = true,
>>>>>>
>>>
>>>
>>>
