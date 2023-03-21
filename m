Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B409F6C33C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCUOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCUOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:11:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664D4A1D2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:11:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k37so6349732lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679407887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAGB7Aj6eWN9c4AIsJYfnptIIniy9VIg48C8wvaeq9E=;
        b=Afm3AWjUAa2d8BjU70q955PKyyPVHboO1a16UaU67Iuld1g7MYhNxNNBjXdnKmSm/4
         x6gBY64A1McGTG7qYGFH4PiZHRcRL3j8z7kbWRkny/ya847x30QTYK94FGQtYRmr2y9Q
         xPILABGC42YPAaaWpC9F0xKghxKWjpMVQJfI5BXNzNsbf+xIx1zgoxDa8eR2bK2H7Yyu
         GFy3UFIcwc9Mlr3oTWjDth6UjzAwRuuIQSbyAThI5mbQkU4vWBouv/AtYkuxIXhJuF15
         DshsiKdWcARtUc9D08sMxgxWkY2Ry4WYYb1Dg/v8nz9KphsunSx+EplmfNIsIMm3JiDN
         JCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAGB7Aj6eWN9c4AIsJYfnptIIniy9VIg48C8wvaeq9E=;
        b=PTr3lKxIvA2yCK6OVytYf7w2ZnS6yXkDjge7yYCV5G0A+il3kDouXpxERPme9c5P3Y
         kDn8ceyL68saOuXA6RvlD7KUNANjD4gghc4409PieHAIxMNmcYrs2Uw9K4k+AqCUOqH9
         XD7H6T4iTH7CQm8S99aDcpcD5WFl/UqcvPpOJYGmrLAeeqNvwM+pTpwrMgqmnMdY3ZoB
         wr54++r+D7+T04A9r1hCaS4MZwGFWaj+pOiyy64PCHJsr1+4FHh5yGyfBnyxO9lJpl4A
         9Ea0fO3vxwBGI3sMuvHx9x++EQUNj8FcNx1AOadc7A8FELLf9eemK2kwuxyqiCNG6N8S
         3uTw==
X-Gm-Message-State: AO0yUKXj2wqXXS5MKJ2ka8ztQfjmQ97gZS+ZdIKrbWXnkGzr5N21B38X
        3hUZ04EdLHUdOnZ3BIdrlYtTpA==
X-Google-Smtp-Source: AK7set/JmSkv5k/zkT+L5VPfMmgQ3P6A/FmkZFBsiT23pb+hi1sIAmmjqGj8YU6ju8j8HZRBmCO4hw==
X-Received: by 2002:a19:a401:0:b0:4b4:8f01:f8b1 with SMTP id q1-20020a19a401000000b004b48f01f8b1mr870353lfc.31.1679407887246;
        Tue, 21 Mar 2023 07:11:27 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id c5-20020a197605000000b004eaeb0a984csm317916lff.88.2023.03.21.07.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:11:26 -0700 (PDT)
Message-ID: <5459d8d3-4829-01ab-7000-2c1f58ad69e8@linaro.org>
Date:   Tue, 21 Mar 2023 15:11:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <68a5d81a-5de8-798a-c150-d74c8ad38cb7@linaro.org>
 <f848061a-763e-fbf2-860c-758373e953df@linaro.org>
 <CAA8EJpqh+A_YKbhSQB5sWj4EP9eQtNHeohDira9o-jrx3pPRNg@mail.gmail.com>
 <51c41e49-5183-551e-c796-5b3d792b422f@linaro.org>
 <74f154b1-a440-fa83-1a46-a5b9223f5760@linaro.org>
 <0af8ba67-f33c-4861-bea5-e662d19638bf@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0af8ba67-f33c-4861-bea5-e662d19638bf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.03.2023 14:58, Georgi Djakov wrote:
> Hi,
> 
> On 11.03.23 17:26, Dmitry Baryshkov wrote:
>> On 11/03/2023 16:38, Bryan O'Donoghue wrote:
>>> On 11/03/2023 14:35, Dmitry Baryshkov wrote:
>>>>> Its probably worthwhile experimenting to see if the*ufs*_clk can/should
>>>>> be added to the UFS device list of clocks.
>>>> While we were doing this for some of the clocks (PCIe and USB, if I'm
>>>> not mistaken), I think that generally this is not fully correct. In my
>>>> opinion it should be in the interconnect driver, who turns
>>>> corresponding clocks on and off. These clocks correspond to the SoC
>>>> topology, rather than the end-device.
>>>>
>>>
>>> True enough, they are interconnect clocks.
>>>
>>> The question is how to only turn them on when the device that depends on them wants them.
>>
>> I think we can turn them on an off from qcom_icc_set(). Each node can list required clocks.
>>
> 
> Yes, this is a bit weird, but looks like these are the interface clocks
> required for programming the qos box of the respective peripheral and
> nothing else. Maybe we can even configure QoS just once (eg. on the first
> bandwidth request) and not every time we call qcom_icc_set().
Would that persist a full bus reset - if we e.g. shut down MMNoC 
after the display stack is turned off in preparation for a power
collapse, would we have to reprogram it?

Another thing is, do we know "how persistent" the QoS settings are?
What could reset them? Would a bandwidth request for a node that
belongs to the same path do so?

Konrad
> 
> BR,
> Georgi
