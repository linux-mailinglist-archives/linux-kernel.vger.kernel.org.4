Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F496A8114
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCBLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCBLeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:34:04 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3266412859
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:34:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id r27so21676831lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677756840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZDsfQO0KOP9e2QgBJd7tKxH91oY8VEkuGT3ALc3Ff0=;
        b=jhbgqD2/hHlfRgNx2Ys9XT1UNGRMB6hTTedjCalfK8C+FNic9SCoLHZ8I5DsnlmC+Q
         +hVdn697Pgu0QZLZ30RZklgSjoMA1UYKld2kOZ02UW+i7BsL/Kp5Y+VPc4MNkauXyUCV
         a47N0iE1eXsuxhjbo3O7+vjXG+ZatBW8BP8s9Y5sAll5xiQHkJzWj0VgAOnMgfMSDS5c
         qJ033WTtPqHMw3WfisrheRxcWeSaYJbSy76MYL4+P38hKszRjcjYAeMX9v747M92STaJ
         VhOPBc6f+OgnH7OFPwsmQwwBxT+8JuI4+t/h61JKyRW9t9eaz156egpfh18dhxXsUTR9
         yX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677756840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZDsfQO0KOP9e2QgBJd7tKxH91oY8VEkuGT3ALc3Ff0=;
        b=3M3l5FmZ60Hu9/ibGrhl7YqitQQXV6a60CkIsd3GKqTrphJE0sWg2L8E9Arc0cpuTW
         U2A76lbXr6EoQvTw8RmYZvV9eqEqU4j3UPUqLfL/IjXO0NiQTw9w1Aj/uyisgpXFgip1
         GrupJzsZxydqaMYNtE/MmB0Dp12a4pe45H875TirWS63qoPDz2NOEvTswIyUxugk8woK
         q1krgQjj10o3XAnzoBDXswtlFQU1MzQsMAykmkALHCVQJ6RNPl1LTFq4UR1+xE7GlMVV
         jDohzaeSdWAvv6QkDVZD1e6ZJVPgYplkp2mRQOgXjLD3/bPn0QhN0JoWl9Aq3V0v8qEX
         TlDQ==
X-Gm-Message-State: AO0yUKUhhfwYq/HWCQuRVe9iSYEUvbCEKM0iJGn42p1wgh25W3acdczQ
        LSY3/9xekc1ENXtSaPPmPRaGTA==
X-Google-Smtp-Source: AK7set9pOk9jfizeWmPRHADiua69XHdPW/S94K/yLsDOdiAMZFIy1qnitzIqoifgDtZwNPJZ7Ffcdg==
X-Received: by 2002:ac2:4c22:0:b0:4d7:2187:e1c8 with SMTP id u2-20020ac24c22000000b004d72187e1c8mr2807344lfq.44.1677756840455;
        Thu, 02 Mar 2023 03:34:00 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id r7-20020ac252a7000000b004dc4d26c324sm2092277lfm.143.2023.03.02.03.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:33:59 -0800 (PST)
Message-ID: <e95ce32e-60cb-f892-804f-686472657376@linaro.org>
Date:   Thu, 2 Mar 2023 12:33:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Okay, I have two questions then:

1. Can the firmware team confirm it shouldn't crash on a fw tag
   that's close to VIDEO.VE.6.0-00042-PROD-1?

2. Are there any other SoCs that SYS_IDLE is not supported on?
   It hasn't been sent to the hardware by the vidc driver for
   any SoC using the downstream vidc (NOT the legacy vidc_3x)
   driver starting with msm-4.14, AFAICS.. check out this link:

https://github.com/sonyxperiadev/kernel/commit/8889a7d26943e96eae2f318f87b15efa4b907f28

Konrad
> 
> Thanks,
> 
> Dikshita
> 
