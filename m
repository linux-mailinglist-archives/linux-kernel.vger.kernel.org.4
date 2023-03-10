Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CEB6B4FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCJSFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:05:32 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1A1308E1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:05:29 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h9so6201231ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678471527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBjBAbRPm56BQ/eTKboqTkN6AUznZBRmPA9kqc4XcyQ=;
        b=cntpW1qI/KsIzpeM76IKOGuCeB73EAc3rug0E3ELKWVQSDgrYXJlSaskG8e1qZG866
         bxHNWvSZFGYfKZ4X/onCRPBdQTpUH7Fpx+BV+be7ZugqTpDO388N4EU7wyvY3vL/7rxj
         kkJzV8JIla7e8mHlL0EAAUi6e0ZaBmOSH/4fvImOyuVsf6JFxCyxppFbcsRGDD44JTx7
         Lu0OwSFfMVUmCt8vJRlNRpaCVZvFspYA+/FgGkaomcFrbXaldVUZFbKDrHbsYYNYXE28
         Krp1qliABahK1U0bMRfZA09803nEVXFiwaEvl68PF+hsD/ygzxPLYsjX993D6MYIiHHl
         BvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678471527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBjBAbRPm56BQ/eTKboqTkN6AUznZBRmPA9kqc4XcyQ=;
        b=e6UsWlcpP8KVim2xLLr2zWtnGWofmMJYJw3G0vDIrrLOwXUsQaAjb4rJfjkpHb4a5H
         HoAy/1hH9ufXTy935DTh3AAlqEc1ebjxUkv9ZzBnsh8YKv78EohwtBjVkTIP6toihvTW
         UKyHe+Fdd/w5Ebg4+FsC6jzvNuYM1sr6oebFxg/n3SfGehsAuiJYpwceJ3JNFNj49L0m
         VQctDP/vZu5NZqUDIkm73xXk0cOzUMnb39wJ9VgNRxW2T19DX4ThnILFou6SnNC4bENU
         CJizA2+E+U7j0Bibg7HgIF3jMoh17AvepPelciehFR8avNfqjHw+TKu3CdWMuMIJE5He
         O8FA==
X-Gm-Message-State: AO0yUKVdDkEYeWuhug4TACGbMh/LjuRAeqlMHcmKZWHQ84HOX/GkQDWl
        7TOJua3z8fudLn989ziuQ+G9yA==
X-Google-Smtp-Source: AK7set+LStnbYuO7wMtSj1sLy7WPF1lvNmLMrshaGf4g4TvXPrrrGTtU2l1r6N3cibjsBRx7qigUPQ==
X-Received: by 2002:a2e:9555:0:b0:28b:6d76:e9ce with SMTP id t21-20020a2e9555000000b0028b6d76e9cemr7702361ljh.23.1678471527328;
        Fri, 10 Mar 2023 10:05:27 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id f13-20020a05651c03cd00b00295a8d1ecc7sm84447ljp.18.2023.03.10.10.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 10:05:21 -0800 (PST)
Message-ID: <858a8925-f11b-652d-3f02-f5ceea7d11fa@linaro.org>
Date:   Fri, 10 Mar 2023 19:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
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
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <67590cd3-5543-59ed-6158-b272103ebd05@linaro.org>
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



On 10.03.2023 17:47, Bryan O'Donoghue wrote:
> On 10/03/2023 14:26, Konrad Dybcio wrote:
>>
>>
>> On 10.03.2023 15:21, Bryan O'Donoghue wrote:
>>> On 08/03/2023 21:40, Konrad Dybcio wrote:
>>>> Some (but not all) providers (or their specific nodes) require
>>>> specific clocks to be turned on before they can be accessed. Failure
>>>> to ensure that results in a seemingly random system crash (which
>>>> would usually happen at boot with the interconnect driver built-in),
>>>> resulting in the platform not booting up properly.
>>>
>>> Can you give an example of which clocks on which SoC's ?
>> See for example 67fb53745e0b
>>
>> This was a clock documented downstream under the node-qos clocks here:
>>
>> https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.5.7.r1/arch/arm/boot/dts/qcom/msm8996-bus.dtsi#L102-L109
>>
>> but there are occasions where such clocks are undocumented and downstream
>> skips them because it relies on them being on by miracle, such as the case
>> of MASTER_IPA and the IPA rpmcc clock on msm8998. Downstream has no
>> sync_state, so they would only set the QoS registers when the relevant
>> hardware was online, so the clocks were on already.
> 
> What switched the clocks on ? Presumably LK.
> 
> Is this a symptom of using a bootloader other than LK ? If you use the same bootloader, then why hasn't the bootloader/LK already set it up on your platform ?
XBL* in this case (qcom fully switched to UEFI with 8998, I'm not
using anything other to what came on the device)

Setting up these dependencies happens all throughout the boot
chain: after the SoC starts up, BIMC/PNoC/CNoC/SNoC(/AnNoC) are
set up by some early firmware so that DDR, USB, UFS/eMMC, crypto
engines etc. can be reachable. It's *that* level of deep..

Then, they are not shut down at all, leaving USB etc. accessible
by default.

> 
>>>
>>> Is the intention of this patch to subsequently go through *.dts *.dtsi and start to remove assigned-clocks ?
>>>
>>> Are we saying that currently there ought to be assigned-clocks for some of these NoC declarations ?
>> Not really, assigned-clocks are used for static ratesetting, see
>> for example dwc3 nodes where we need it to be fast enough for
>> HS/SS operation at all times (though that should have prooobably
>> been handled in the driver but it's a separate topic), I don't
>> think any of them were used to combat what this commit tries to.
> 
> I think you could use assigned-clocks for that ..
> 
> So its not part of your series but then presumably you have a follow-on patch for the 8998 dts that points your ->intf_clks at these then ?
> 
> clocks = <&clock_gcc clk_aggre2_noc_clk>,
>          <&clock_gcc clk_gcc_ufs_axi_clk>,
>          <&clock_gcc clk_gcc_aggre2_ufs_axi_clk>;
> 
> It seems like the right thing to do..
Why so? We're passing all clock references to clocks=<> and we handle
them separately. This is akin to treating the "core" clock differently
to the "iface" clock on some IP block, except on a wider scale.

> 
> Still not clear why these clocks are off.. your bootchain ?
Generally the issue is that icc sync_states goes over *all the possible
interconnect paths on the entire SoC*. For QoS register access, you need
to be able to interface them. Some of the hardware blocks live on a
separate sort of "island". That' part of why clocks such as
GCC_CFG_NOC_USB3_PRIM_AXI_CLK exist. They're responsible for clocking
the CNoC<->USB connection, which in the bigger picture looks more or less
like:


    1     2-3            2-3    3-4            3-4    4-5
USB<->CNoC<->CNoC_to_SNoC<->SNoC<->SNoC_to_BIMC<->BIMC<->APSS

where:

1 = GCC_CFG_NOC_USB3_PRIM_AXI_CLK
2 = RPM CNOC CLK
3 = RPM SNOC CLK
4 = RPM BIMC CLK
5 = (usually internally managed) HMSS / GNOC CLK

or something along these lines, the *NoC names may be in the wrong order
but this is the general picture.

On msm-4.x there is no such thing as sync_state. The votes are only
cast from within the IP-block drivers themselves, using data gathered from
qcom,msmbus-blahblah and msmbus calls from within the driver. That way,
downstream ensures there's never unclocked QoS register access.

After writing this entire email, I got an idea that we could consider not
accessing these QoS registers from within sync_state (e.g. use sth like
if(is_sync_state_done))..

That would lead to this patch being mostly
irrelevant (IF AND ONLY IF all the necessary clocks were handled by the
end device drivers AND clk/icc voting was done in correct order - which
as we can tell from the sad 8996 example, is not always the case).

Not guaranteeing it (like this patch does) would make it worse from the
standpoint of representing the hardware needs properly, but it could
surely save some headaches. To an extent.

Konrad
> 
> ---
> bod
