Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53C66C3408
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCUOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:23:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13ED509B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so19326841lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679408584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiZEB8fdPU2DGcZz1ByqcD9rRs5eC17ASYCR4pbmxqs=;
        b=zDfop1eaMybG8D/bKikGU+6Ff9YVLO4agw2G17+SkOn7TQjHkiC9BknAqMjGrMkz2K
         FhF1IvV02qhQA9+Iucx+IIbJ/9gYgQm1BAFLd7jYpaHKcWCCqzdOG/MXG9BBQXw7YNsI
         5+59rZaWueVBjl90GM6boVWiBx6U1zbEMKGdi/hga4TfO+tqBPPUyCDiKZyI82/83Xil
         UGzHj1tQ92PfBe9xMoEGjMzvx/WP83cmHUEEX3hrcSs6lU5rLQTuUbHRaTIzWU08z+2n
         tSDpM6+D5NY29YfbHO1SOniT2drM8D6VIpzuRIvdCUhtBVX1gTbJlfHOH5Uxd06esrBD
         P6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiZEB8fdPU2DGcZz1ByqcD9rRs5eC17ASYCR4pbmxqs=;
        b=35zfIi8PihHlB0WhesI7yowO7mN1jHy44Va1lNSzGKZB+0o9xqdnygzJUsynUxrRw3
         7a9sHaramxMUoWvRPThaexU29DJqdZmfW7rrw/PPfZ24K9k9dO+/pLFXp8ZhRkL1fMZH
         yYsFJuySzbubhhUgkuaXykvnjrRI8tp8nckvax44GoWWHYEcYLrLZgKCWaQVrTrHZ8j7
         zWucCm6CBk9a6xxO1La70PETMmGFX2IACZNRCl04sP0vPNNh8yxcSB0WENzYmU/9gfFb
         DiJViW/4yEStP7Rt+yWq0CKJFsb4aVfV6xBK1No8bUsoNlmiNgB0+HyQlYxUOArpiBC/
         C6lw==
X-Gm-Message-State: AO0yUKWkjMbO8vRgyaqSECD0giAOD2iGLwalZtElk8VFNuuPELvwXkRx
        5gMns/OxIJQkb+ucwCBLTU4PPA==
X-Google-Smtp-Source: AK7set8eqLkZ1zwLhnfqIrB2MA44JsPJHNCaKY4OHKBlVsZ1SgPFbjR4ojm8Img7h/vT1cCjzGF5gQ==
X-Received: by 2002:ac2:4311:0:b0:4dc:8192:c5e6 with SMTP id l17-20020ac24311000000b004dc8192c5e6mr926363lfh.13.1679408583784;
        Tue, 21 Mar 2023 07:23:03 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id q27-20020ac25a1b000000b004dc4d26c30dsm2194668lfn.63.2023.03.21.07.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:23:03 -0700 (PDT)
Message-ID: <9cd49e80-d13b-6d16-0469-4be3fdbd1762@linaro.org>
Date:   Tue, 21 Mar 2023 15:23:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <32bcb19f-db74-8660-7270-305e81363376@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <32bcb19f-db74-8660-7270-305e81363376@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.03.2023 14:56, Georgi Djakov wrote:
> Hi Konrad,
> 
> Thank you for working on this and sorry about jumping a bit late into
> the discussion.
> 
> On 8.03.23 23:40, Konrad Dybcio wrote:
>> Some (but not all) providers (or their specific nodes) require
>> specific clocks to be turned on before they can be accessed. Failure
>> to ensure that results in a seemingly random system crash (which
>> would usually happen at boot with the interconnect driver built-in),
>> resulting in the platform not booting up properly.
> 
> These "interface" clocks seem to be used only to program QoS for the
> respective ip block (eg ufs). So if we don't program QoS, there should
> be no crashes, right?
Correct.

> 
> I believe that in downstream they defer setting QoS until the first
> non-zero bandwidth request because of drivers that probe asynchronously
> or there is some firmware booting involved (IPA maybe). 
Hmm.. that would make sense.

> And bad stuff
> might happen if we touch the clock while the firmware is still booting.
> So setting the QoS on the first non-zero bandwidth request might not be
> a bad idea.
Sounds like a plan, I don't think setting QoS parameters on buses
that are not in use does anything (citation needed).

Such nodes should probably be also excluded from sync_state
> by implementing get_bw() to return 0 bandwidth.
I agree, setting the QoS parameters in sync_state (so, without
their dependencies fully met) sounds like a recipe for disaster,
while getting rid of QoS in sync_state at all would leave the nodes
that are not explicitly referenced in the device tree unconfigured.


Konrad

> 
> BR,
> Georgi
> 
>>
>> Limit the number of bus_clocks to 2 (which is the maximum that SMD
>> RPM interconnect supports anyway) and handle non-scaling clocks
>> separately. Update MSM8996 and SDM660 drivers to make sure they do
>> not regress with this change.
>>
>> This unfortunately has to be done in one patch to prevent either
>> compile errors or broken bisect.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 52 ++++++++++++++++++++++++++++++-------
>>   drivers/interconnect/qcom/icc-rpm.h | 14 ++++++++--
>>   drivers/interconnect/qcom/msm8996.c | 22 +++++++---------
>>   drivers/interconnect/qcom/sdm660.c  | 16 +++++-------
>>   4 files changed, 70 insertions(+), 34 deletions(-)
>>
> [..]
> 
