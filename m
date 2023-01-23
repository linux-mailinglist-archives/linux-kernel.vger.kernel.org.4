Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3F678141
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjAWQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:21:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288EFEB56
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:21:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h24so14733105lfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txdh371/Ub+W12M3IRsoEXByVUgkmKPUORaUx/UnSOw=;
        b=MMFqhrFgeRVABOgb1w3u1aEsOPVLgjtORkkpV80IrOnLCkFsSJQctcZve4pV63h9W7
         HI0XCh0LGipTC0bL5liXxoqJstr70DOK4T3PEpaHr7fdltSFx66B5bE4FbRPZLbhRUuA
         gVKjNFJSjejKuBAklyKn+QmCcSlCuShkqgex2u1nxXQr9MHIeMaPRT92V9Je5HbxQMbL
         q+lpFPZATUhgZYoNGMVJhA9CY/HjHcEIrrO0CWU++RsknYvGmPK/IPzSBuYr6Omf4Be7
         pGby3rHRzSVfY79aL9XfvQewyKgGjhbDrDwPYnjHnKoPTJqtrVhcC8KQjVLE76HCQ7h4
         wPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txdh371/Ub+W12M3IRsoEXByVUgkmKPUORaUx/UnSOw=;
        b=qxPLsfDu+x66laxwPtE+cYhOsFXiQUlVtug4cl315l6IVEXARzD9lwhKFhD5gEOu+a
         SX6SZn4xkt/sCdjW56hHDEqdaMTjLx4ewBkwWGIdL/l9lTYP6Vimnh6npIb+1MZZSrpp
         BaGoNDg9ZKUEpfPaOR8KzO3tpba6TmRMgxEtcYA3BZJ0cKr0Si+0H5ZrQ/gyb0DjlmKc
         06nxknwPpET0RYhBj/QNRkFttvP4I22vaC6gtywa5q6W352gUa5O+fZvZI8B7hHdJWnQ
         ZCKiYSKVvG2OXVFxOdQW7WioX1OIABFI4NFCxALX3Vulzv+lqymbRaBwvkzBbEDjvRg2
         V7cQ==
X-Gm-Message-State: AFqh2kop5+1WAQ0eGsDUBs9cKEpjwrNQFYVVK5umFS3g1NzNeMPKkcom
        cLsoNuJchYRL+Zq3hgziA+GPxIr0wPhoshGO
X-Google-Smtp-Source: AMrXdXuX0TFGk1zyt0JSxPTkZJVkcQqaaSyUKzfvHIeCKbO8/SwTMcTHIguAIMxVSIPUP9q8Vki6aw==
X-Received: by 2002:a17:906:60d0:b0:877:612e:516e with SMTP id f16-20020a17090660d000b00877612e516emr65529550ejk.61.1674490878265;
        Mon, 23 Jan 2023 08:21:18 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906219100b008536ff0bb44sm18660955eju.109.2023.01.23.08.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:21:17 -0800 (PST)
Message-ID: <133139cd-b8e4-3865-ddbf-9fa7d244ddef@linaro.org>
Date:   Mon, 23 Jan 2023 17:21:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y86CPmgvAi+kChQI@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 13:49, Stephan Gerhold wrote:
> On Mon, Jan 23, 2023 at 11:08:28AM +0000, Bryan O'Donoghue wrote:
>> V4:
>> - Left _AO for wcnss as downstream reference uses this - Bjorn/Bryan
> 
> Downstream is just an implementation and contains plenty of misleading
> or even wrong information. IMO Bjorn is right here that VDDMX_AO is not
> a logical choice.
> 
> The _AO (active-only) suffix means that the votes are only applied when
> the processor making the vote is "active", that is when the Linux CPUs
> are not in deep cpuidle mode.
> 
> For WCNSS the goal is to keep the necessary power domains active while
> WCNSS is booting up, until it is able to make its own votes (handover).
> The WCNSS firmware might then vote for VDDMX_AO internally because VDDMX
> is not needed when the WCNSS CPU is suspended.
> 
> However, I would expect that the meaning is totally different when the
> same vote is made from Linux. When Linux votes for _AO the "active"
> state likely refers to the Linux CPUs, instead of the WCNSS CPU when
> made from the WCNSS firmware.
> 
> Why does it work in downstream then? I would just assume "side effects":
>   - Something else votes for VDDMX without _AO while WCNSS is booting
>   - The Linux CPUs don't go into deep cpuidle state during startup
>     - In particular, note how downstream often has "lpm_levels.sleep_disabled=1"
>       on the kernel command line. This disables all cpuidle states until
>       late after boot-up when userspace changes this setting. Without
>       cpuidle, VDDMX_AO is identical to VDDMX.
> 
> Please change it to VDDMX (without _AO). It will most likely not make
> any difference
Wouldn't it make wake-on-wifi-with-cpus-off possible?
(obviously given the wlan chip supports it and can ping
the cpu etc etc)

Konrad

 but IMO it is logcially more correct and less
> confusing/misleading. :)
> 
>> - Leaves dummy power-domain reference in cpu defintion as this is a
>>   required property and the dt checker complains - Stephan/Bryan
> 
> It's only required though because you forgot to drop the DT schema patch
> (3/4) when I suggested half a year ago that you make the MSM8939
> cpufreq-qcom-nvmem changes together with the CPR stack [1]. :/
> 
> Anyway, it looks like qcom-cpufreq-nvmem.yaml requiring "cpr" power
> domain unconditionally is a mistake anyway for multiple platforms.
> [2] was recently submitted to fix this so that patch should allow you to
> drop the dummy nodes. :)
> 
> [1]: https://lore.kernel.org/linux-arm-msm/Ysf8VRaXdGg+8Ev3@gerhold.net/
> [2]: https://lore.kernel.org/linux-arm-msm/20230122174548.13758-1-ansuelsmth@gmail.com/
> 
>> - Left MDSS interconnects. I don't see a bug to fix here - Stephan/Bryan
> 
> Fair enough, if you would like to keep it I will likely send a revert
> for the MSM8939 icc_sync_state() though. Because clearly it breaks
> setups without a display and I don't see how one would fix that from the
> device tree.
> 
> Also: The undocumented "register-mem" interconnect is still there. :)
> 
>> - power-domain in MDSS - dropped its not longer required after
>>   commit a6f033938beb ("dt-bindings: msm: dsi-controller-main: Fix
>> power-domain constraint") - Stephan
> 
> Thanks!
> 
>> - Adds gcc dsi1pll and dsi1pllbyte to gcc clock list.
>>   Reviewing the silicon documentation we see dsi0_phy_pll is used to clock
>>   GCC_BYTE1_CFG_RCGR : SRC_SEL
>>   Root Source Select
>>   000 : cxo
>>   001 : dsi0_phy_pll_out_byteclk
>>   010 : GPLL0_OUT_AUX
>>   011 : gnd
>>   100 : gnd
>>   101 : gnd
>>   110 : gnd
>>   111 : reserved - Stephan/Bryan
>>
> 
> I'm confused. Are you not contradicting yourself here? You say that
> dsi0_phy_pll (dsi ZERO) is used to clock GCC_BYTE1_CFG_RCGR. Then why
> do you add dsi1_phy_pll (dsi ONE) to the gcc clock list?
> 
> To me this looks like a confirmation of what downstream does, that both
> DSI byte clocks are actually sourced from the dsi0_phy and the PLL of
> dsi1_phy is not used.
> 
> Thanks,
> Stephan
