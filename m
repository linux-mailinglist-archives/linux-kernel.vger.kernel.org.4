Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D16B563C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCKAQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCKAQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:16:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB4134AEA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:16:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so7264510wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678493780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+6glvn0oJh5BPh1DQwKMOx46e4Z6t8/bsFpmCRkgOk=;
        b=wIjvTlJEo7bnc5/CP7lw89pFLbqEARl2/dv8qTQBhoNaKzgIqKT1Ntcee8SZ3K/GSn
         RP2OCL8rraqnAq973wv0KglYSK+vV5fBAyG4xwLWia7QSSw70dYiLt/pTOAJHL9RlQKy
         /NTsymtRtToleH0Jf4PhQFTMcnrzWQ2prYqto5851cVnCxXcaigoriGVpSYJxg9xc+0n
         cMRdPswGQ+bo1i6uJ0Ce9bYYqhzhEbeQW50DX6H5u5K883ghkN06bVD9VM3TTLX/jKIQ
         XQd2+mqD0bwCS7Sh8MoWTbIW8+JyA6FFwty/ho7q83YU1AnTbX10WZO2isyhaAK9LMUE
         mGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678493780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+6glvn0oJh5BPh1DQwKMOx46e4Z6t8/bsFpmCRkgOk=;
        b=0cz11irCDp7rbn6BviuXJ58U0BNf1/t+c/qjXaO41pJtYNI+eHHEjDpHuoBo/fFjhy
         NzakCZX3sx9pHeoxiOA04WA/bPPV0+WuXMRnV26TBJFKFrzVJO79FKXQV5hTVJbcht0r
         l5z9VsIR0swhaeIVXLRa0WzIckQ6+Zgh6vDE17HPmubNXSDp8z1cJkOH3ewfcUMOYQns
         ync/GnOwctMbAUOYMSMTDU8ACF66gjozs7Nj/czOkrHe7bGk9nr+lkAsG2Kw/qBn/7Ug
         MMvfcngiZj/zoBwfDCxtIAdF+QNYVDzMbAKtxLPZYsgnfl+1L8NoF0BOBqU7wJ0013hy
         fEEA==
X-Gm-Message-State: AO0yUKWiuYpK+5EI4SawKjNH0O52oRqt+Hbv6/+n10SY7tMwrY9BPpBW
        O9STVU5INn6IBBEjfTvX03SUUw==
X-Google-Smtp-Source: AK7set8WyvvgAJ5WORz6GGVm6pLqeX/0gIzJi2MD4aMTLM+bp2TZNdbHNW2ewaGBdYKghckMWDG5kQ==
X-Received: by 2002:a05:600c:601b:b0:3e2:153e:6940 with SMTP id az27-20020a05600c601b00b003e2153e6940mr4536935wmb.3.1678493780302;
        Fri, 10 Mar 2023 16:16:20 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c4f0400b003dc4a47605fsm1404324wmq.8.2023.03.10.16.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 16:16:19 -0800 (PST)
Message-ID: <74c0c724-b6a9-3755-7f56-9f421cece1a3@linaro.org>
Date:   Sat, 11 Mar 2023 00:16:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <858a8925-f11b-652d-3f02-f5ceea7d11fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/03/2023 18:05, Konrad Dybcio wrote:
>> I think you could use assigned-clocks for that ..
>>
>> So its not part of your series but then presumably you have a follow-on patch for the 8998 dts that points your ->intf_clks at these then ?
>>
>> clocks = <&clock_gcc clk_aggre2_noc_clk>,
>>           <&clock_gcc clk_gcc_ufs_axi_clk>,
>>           <&clock_gcc clk_gcc_aggre2_ufs_axi_clk>;
>>
>> It seems like the right thing to do..
> Why so? We're passing all clock references to clocks=<> and we handle
> them separately. This is akin to treating the "core" clock differently
> to the "iface" clock on some IP block, except on a wider scale.

Eh, that was a question, not a statement. I mean to ask if your 
intf_clks are intended to be populated with some/all of the above 
additional gcc references ?

>> Still not clear why these clocks are off.. your bootchain ?
> Generally the issue is that icc sync_states goes over *all the possible
> interconnect paths on the entire SoC*. For QoS register access, you need
> to be able to interface them. Some of the hardware blocks live on a
> separate sort of "island". That' part of why clocks such as
> GCC_CFG_NOC_USB3_PRIM_AXI_CLK exist. They're responsible for clocking
> the CNoC<->USB connection, which in the bigger picture looks more or less
> like:
> 
> 
>      1     2-3            2-3    3-4            3-4    4-5
> USB<->CNoC<->CNoC_to_SNoC<->SNoC<->SNoC_to_BIMC<->BIMC<->APSS
> 
> where:
> 
> 1 = GCC_CFG_NOC_USB3_PRIM_AXI_CLK
> 2 = RPM CNOC CLK
> 3 = RPM SNOC CLK
> 4 = RPM BIMC CLK
> 5 = (usually internally managed) HMSS / GNOC CLK
> 
> or something along these lines, the *NoC names may be in the wrong order
> but this is the general picture.
> 
> On msm-4.x there is no such thing as sync_state. The votes are only
> cast from within the IP-block drivers themselves, using data gathered from
> qcom,msmbus-blahblah and msmbus calls from within the driver. That way,
> downstream ensures there's never unclocked QoS register access.
> 
> After writing this entire email, I got an idea that we could consider not
> accessing these QoS registers from within sync_state (e.g. use sth like
> if(is_sync_state_done))..
> 
> That would lead to this patch being mostly
> irrelevant (IF AND ONLY IF all the necessary clocks were handled by the
> end device drivers AND clk/icc voting was done in correct order - which
> as we can tell from the sad 8996 example, is not always the case).
> 
> Not guaranteeing it (like this patch does) would make it worse from the
> standpoint of representing the hardware needs properly, but it could
> surely save some headaches. To an extent.

Hmm.

If I have understood you correctly above, then for some of the NoC QoS 
entries we basically need additional clocks, which is separate to the 
clocks the controller bus and bus_a clocks.

We don't see the problem all the time because of sync_state, so your 
question is should we push the clocks to the devices. Based on the dtsi 
you gave as an example, my €0.02 would say no, those are clearly 
additional clock dependencies for NoC.

Going by the name, you'd expect the UFS controller could own these two 
clocks

"clk-gcc-ufs-axi-clk",
"clk-aggre2-ufs-axi-clk-no-rate"

but even then by the same logic the NoC should own 
"clk-aggre2-noc-clk-no-rate" I wouldn't much fancy splitting them apart.

So - I'd say the commit log doesn't really explain to me what we have 
discussed here.

Suggest rewording it a little bit "non-scaling clock" is accurate but 
for me on the first read doesn't really tell me that these are 
node-specific clock dependencies or that there is an expectation that 
the intf_clks should be tied to node-specific clocks.

So two asks

- Update the commit log and potentially the structure comments
- Can you split the devm_kzalloc() into a seperate patch ?
   I don't see why this needs to be done but if it does need to be
   done it could as far as I read it be done before this patch

---
bod
