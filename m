Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723256B5728
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCKA4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjCKAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:55:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140ED28E86
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:54:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g17so8905398lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678496089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYtXohR9kO8JKnBbb5S/LlpBpqOKA0WNr1Wqy/ElIdk=;
        b=F1V5/Wn9kgt2mO44rUdEkcx+uQIEouJWL1htc+7dh8YElL6NoOJ5b1M3WOtrj2pDXe
         dlXyL8RlQ0oSRDCtaKQBIazDzfoLgMR2yeHlraR+QjAGdEhhzTrxcDziU5FU2H/9CE/l
         0Z3oD4pVKG7lBSAy/iV9xPUsOaQAIxkn42fCkjfsv03Wfkb/utaDFbLu4Orkn/0eJdbX
         cpQYCXI5QnzZKqAEhrIBhGMU5sIH10t3sGVXRvMFRDFF0GgV+dLuMuW83FVTkUNj8Zo1
         D8YuXtNpdEde9Ma9tVDkOw8DSypOK0uxs0oF+4FVErPGvI8wCc38gIAQtIV96t65/LR8
         12JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678496089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYtXohR9kO8JKnBbb5S/LlpBpqOKA0WNr1Wqy/ElIdk=;
        b=H67aUpoWuk5lDBS1pLeInaWeGyLAB8TjdnMgoHP8NhlLeYxHt0uuOFIwKpg9rx5TTr
         gMIXdbwVaxzeUarV+kfjFscalnv9zAlR3xWSu68cEFFGLmfIO2sFpkn3Fy3Nh9gebSOX
         X7DNPWtsV1Yrlo8ZYNTdgD7ddFdmpipJiJUwj+LXuAEZfdXoaPYwrb1QAuncHPslfThm
         gC5zi2rpEZ6rG05m3FBbuXECsYW+wZ4EZYzpQ5Du27pThViPWaxbF0F16ogOT2pql0DV
         ZhM1ebIoBEL002NJUWp555MknMgZ0vi9zUE47O3AiGNGMyHkUQoTOotXZY9M+VpK2H5D
         rK6A==
X-Gm-Message-State: AO0yUKUFD11BHA22mmkcV7mMIIJwdO7qaBDqpTdBK25LwPczlLUmnBGT
        rVAkcSiO/FeU1FAaHHV1jVYMjzbfRGQN84fObKo=
X-Google-Smtp-Source: AK7set8ChGMwcjyrukIDMtT2ReuMkcAts+DBJM7qrjAjILtZEJFX2hGb3qxq/1p7aWMLfnWUMGpA1g==
X-Received: by 2002:a19:7406:0:b0:4d8:4fd6:418a with SMTP id v6-20020a197406000000b004d84fd6418amr8045484lfe.6.1678496089221;
        Fri, 10 Mar 2023 16:54:49 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id l30-20020ac24a9e000000b004dc83d04840sm136374lfp.79.2023.03.10.16.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 16:54:48 -0800 (PST)
Message-ID: <500c7924-c43c-4233-1688-f8b6fbbad66f@linaro.org>
Date:   Sat, 11 Mar 2023 01:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <50f03895-816f-be8d-d956-d237fb13f5a0@linaro.org>
 <6d10906e-08cd-0380-5f5d-3ac0eec60276@linaro.org>
 <67590cd3-5543-59ed-6158-b272103ebd05@linaro.org>
 <858a8925-f11b-652d-3f02-f5ceea7d11fa@linaro.org>
 <74c0c724-b6a9-3755-7f56-9f421cece1a3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <74c0c724-b6a9-3755-7f56-9f421cece1a3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.03.2023 01:16, Bryan O'Donoghue wrote:
> On 10/03/2023 18:05, Konrad Dybcio wrote:
>>> I think you could use assigned-clocks for that ..
>>>
>>> So its not part of your series but then presumably you have a follow-on patch for the 8998 dts that points your ->intf_clks at these then ?
>>>
>>> clocks = <&clock_gcc clk_aggre2_noc_clk>,
>>>           <&clock_gcc clk_gcc_ufs_axi_clk>,
>>>           <&clock_gcc clk_gcc_aggre2_ufs_axi_clk>;
>>>
>>> It seems like the right thing to do..
>> Why so? We're passing all clock references to clocks=<> and we handle
>> them separately. This is akin to treating the "core" clock differently
>> to the "iface" clock on some IP block, except on a wider scale.
> 
> Eh, that was a question, not a statement. I mean to ask if your intf_clks are intended to be populated with some/all of the above additional gcc references ?
Argh sorry, I'm not great at reading lately..

Yes that would be the plan. All of these ones from downstream plus more
that we discover as we go (if we choose to go this route)

And the discovery process looks like:

1. boot with "disabling clk %s" debug prints added
2. do something that triggers a crash (e.g. wait for an IP block
   to enter its suspend routine)
3. crash horribly
4. try to recover the last disabled clock's name or analyze WCGW
5. try resolving the clock dependency
6. goto 1 until you don't crash anymore

> 
>>> Still not clear why these clocks are off.. your bootchain ?
>> Generally the issue is that icc sync_states goes over *all the possible
>> interconnect paths on the entire SoC*. For QoS register access, you need
>> to be able to interface them. Some of the hardware blocks live on a
>> separate sort of "island". That' part of why clocks such as
>> GCC_CFG_NOC_USB3_PRIM_AXI_CLK exist. They're responsible for clocking
>> the CNoC<->USB connection, which in the bigger picture looks more or less
>> like:
>>
>>
>>      1     2-3            2-3    3-4            3-4    4-5
>> USB<->CNoC<->CNoC_to_SNoC<->SNoC<->SNoC_to_BIMC<->BIMC<->APSS
>>
>> where:
>>
>> 1 = GCC_CFG_NOC_USB3_PRIM_AXI_CLK
>> 2 = RPM CNOC CLK
>> 3 = RPM SNOC CLK
>> 4 = RPM BIMC CLK
>> 5 = (usually internally managed) HMSS / GNOC CLK
>>
>> or something along these lines, the *NoC names may be in the wrong order
>> but this is the general picture.
>>
>> On msm-4.x there is no such thing as sync_state. The votes are only
>> cast from within the IP-block drivers themselves, using data gathered from
>> qcom,msmbus-blahblah and msmbus calls from within the driver. That way,
>> downstream ensures there's never unclocked QoS register access.
>>
>> After writing this entire email, I got an idea that we could consider not
>> accessing these QoS registers from within sync_state (e.g. use sth like
>> if(is_sync_state_done))..
>>
>> That would lead to this patch being mostly
>> irrelevant (IF AND ONLY IF all the necessary clocks were handled by the
>> end device drivers AND clk/icc voting was done in correct order - which
>> as we can tell from the sad 8996 example, is not always the case).
>>
>> Not guaranteeing it (like this patch does) would make it worse from the
>> standpoint of representing the hardware needs properly, but it could
>> surely save some headaches. To an extent.
> 
> Hmm.
> 
> If I have understood you correctly above, then for some of the NoC QoS entries we basically need additional clocks, which is separate to the clocks the controller bus and bus_a clocks.
Yes.

(Technically we need them for all of the nodes, but for example we're not
going to poke at DDR registers when the DDR is shut off)

> 
> We don't see the problem all the time because of sync_state,
No, actually it's sync_state (+ improper sequencing of turning on clocks
and regulators/power domains vs setting ICC BW in device drivers) that
causes this. Downstream piggybacks off of the devices being already
set up and ready to go before setting BW (and by extension QoS).

so your question is should we push the clocks to the devices.
Yes, it's either this patch and blindly finding the required clocks

or skipping QoS on sync_state (I haven't tested whether it'd enough
yet, FWIW) with this patch and less finding required clocks (as we
could partially piggyback off of the clocks being enabled before we
cast ICC votes as part of resume/init sequence of a driver)

or being like downstream and (almost) only relying on the client devices

Based on the dtsi you gave as an example, my €0.02 would say no, those are clearly additional clock dependencies for NoC.
Yes, definitely. The question is how should be go about handling them
that would:

- scale for all the IP blocks and nodes
- not be overly complex
- preferably doesn't just rely on trial-and-error and educated guesses
- be hard to mess up on the programmer's side

> 
> Going by the name, you'd expect the UFS controller could own these two clocks
> 
> "clk-gcc-ufs-axi-clk",
> "clk-aggre2-ufs-axi-clk-no-rate"
> 
> but even then by the same logic the NoC should own "clk-aggre2-noc-clk-no-rate" I wouldn't much fancy splitting them apart.
Yeah, it seems to be a common pattern: whichever on-die block is mentioned
first in the name (or first after the clock controller's prefix), actually
"owns" the clock

> 
> So - I'd say the commit log doesn't really explain to me what we have discussed here.
> 
> Suggest rewording it a little bit "non-scaling clock" is accurate but for me on the first read doesn't really tell me that these are node-specific clock dependencies or that there is an expectation that the intf_clks should be tied to node-specific clocks.
> 
> So two asks
> 
> - Update the commit log and potentially the structure comments
I'm probably just very biased because I authored these commits, but I can't
see which part is not clear.. Could I (and this is not passive-aggressive or
anything) ask for a pointer there?

> - Can you split the devm_kzalloc() into a seperate patch ?
>   I don't see why this needs to be done but if it does need to be
>   done it could as far as I read it be done before this patch
bus_clks[] is no longer a trailing empty array (a.k.a "struct hack"),
so we shouldn't be using struct_size anymore. This sort of needs to
be done together, as e.g. 8996 (without this commit) expects >2 bus
clocks which are in reality these "interface clocks", or "node access
dependencies", so splitting that out would introduce unnecessary churn
or break bisecting.

Konrad
> 
> ---
> bod
