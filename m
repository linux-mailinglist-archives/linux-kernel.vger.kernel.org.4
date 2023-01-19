Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184A8672DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjASAxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:53:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7159B61
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:53:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d2so322511wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k58ZEL+S8mz78vT8PV4PXV/cIlLiFQgwX+q5YFLao6c=;
        b=Gi9DeB8D1NTkVmLS6CUmmAhcKRK4xt8wL5HtMGrop9IUICW1WswWMhIHYuR3pg09bA
         DYE6EJ71H+yXvtfGmNE1+H5+AIiGBu/vuJW964cOkOurCisULZVQ9NyaGfG49q6Neoqi
         aKOm4pTEcWY0JKufUrd6z5ekgGmfo5X1pM2GHwv7Rfsj+vnEmWcXpn8HGHJX1jMytHWK
         Didv+eMi8gwF2N3lq45nXjdt1A3fkA5Ae6g1Z+JaeFmenTTL/PMoYTp8jfk9hfo2UTeE
         7gJcLRWjTdzT3je2nwFZA+/qmz6WWKaQbVbxcCQkX69rGGmE3Qaa+JkPAUYboiHFvEaH
         HNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k58ZEL+S8mz78vT8PV4PXV/cIlLiFQgwX+q5YFLao6c=;
        b=xd2EMb9as06qF268ByAdOWILsCUjXUB26gUHz0dn2MPJ7AfHT0+8K6dzhx/Lkh29tq
         5tjRUs1C4mWHUIEAd1GUrJQOEBxkYnYnQCQr0OHqaADe8YgRDgiu2RkvvFWWVoXMjWdp
         lTtoTYPS87a3OpZdtkh8K5GAyJXLYhogOVlznMjeKQbViR7eV6pl+ewAnViKfKDdseiK
         u64CS30uaVK+Sf9nb4audCfGHyAIbhUQM6PfX2fzm+nkV4D1BdKU1R72EkFOwfOFzFx8
         uDuG2MB9GBTn4cr4srqy65jReEQtuuzz2Q/IUMqGHjRkhzQNiUGfuSG4YttZMGYYI6mr
         AZCg==
X-Gm-Message-State: AFqh2koyo4Nu8YWATYBjjisLXy8/w11Z3eX6gu0Fknz6A2Bw/g6F9YvQ
        z7e4Z17W9ACGhkZeJmwlZw9IRQ==
X-Google-Smtp-Source: AMrXdXsfhDaPpt4kqlv3m42o+mZhmAofDABZ/oUBHgStEKkopFsJ4T2kTT5x31Vv0Wo5sblqebWWDw==
X-Received: by 2002:a5d:4582:0:b0:2bc:5c5f:cdd0 with SMTP id p2-20020a5d4582000000b002bc5c5fcdd0mr14898640wrq.3.1674089596776;
        Wed, 18 Jan 2023 16:53:16 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe9c5000000b002238ea5750csm17609360wrn.72.2023.01.18.16.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 16:53:16 -0800 (PST)
Message-ID: <6fc8a8e4-2ba4-94b9-b456-09bc8c6be76a@linaro.org>
Date:   Thu, 19 Jan 2023 00:53:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <Y8fC/GCHfENQmBNC@gerhold.net>
 <cf4920e6-c007-20a5-ba3a-5005b22f891b@linaro.org>
 <Y8gtdpDnMLIwfj+3@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y8gtdpDnMLIwfj+3@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 17:33, Stephan Gerhold wrote:
> On Wed, Jan 18, 2023 at 11:50:20AM +0000, Bryan O'Donoghue wrote:
>> On 18/01/2023 09:59, Stephan Gerhold wrote:
>>> On Tue, Jan 17, 2023 at 02:48:43AM +0000, Bryan O'Donoghue wrote:
>> [...]
>>>> +		mdss: display-subsystem@1a00000 {
>>>> +			compatible = "qcom,mdss";
>>>> +			reg = <0x01a00000 0x1000>,
>>>> +			      <0x01ac8000 0x3000>;
>>>> +			reg-names = "mdss_phys", "vbif_phys";
>>>> +
>>>> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			interrupt-controller;
>>>> +
>>>> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
>>>> +				 <&gcc GCC_MDSS_AXI_CLK>,
>>>> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
>>>> +			clock-names = "iface",
>>>> +				      "bus",
>>>> +				      "vsync";
>>>> +
>>>> +			power-domains = <&gcc MDSS_GDSC>;
>>>> +
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +			#interrupt-cells = <1>;
>>>> +			ranges;
>>>> +
>>>> +			mdp: display-controller@1a01000 {
>>>> +				compatible = "qcom,mdp5";
>>>> +				reg = <0x01a01000 0x89000>;
>>>> +				reg-names = "mdp_phys";
>>>> +
>>>> +				interrupt-parent = <&mdss>;
>>>> +				interrupts = <0>;
>>>> +
>>>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>>>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>>>> +					 <&gcc GCC_MDSS_MDP_CLK>,
>>>> +					 <&gcc GCC_MDSS_VSYNC_CLK>,
>>>> +					 <&gcc GCC_MDP_TBU_CLK>,
>>>> +					 <&gcc GCC_MDP_RT_TBU_CLK>;
>>>> +				clock-names = "iface",
>>>> +					      "bus",
>>>> +					      "core",
>>>> +					      "vsync",
>>>> +					      "tbu",
>>>> +					      "tbu_rt";
>>>> +
>>>> +				iommus = <&apps_iommu 4>;
>>>> +
>>>> +				interconnects = <&snoc_mm MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
>>>> +						<&snoc_mm MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>,
>>>> +						<&pcnoc MASTER_SPDM &snoc SLAVE_IMEM>;
>>>> +				interconnect-names = "mdp0-mem", "mdp1-mem", "register-mem";
>>>
>>> As I mentioned a already in a direct email at some point, AFAIU adding
>>> interconnects should be an [almost-] all or nothing step. If you only
>>> add interconnects for MDP then everything else that needs bandwidth will
>>> either break or only continue working as a mere side effect of MDP
>>> voting for permanent high bandwidth.
>>
>> We did discuss that. You'll also recall we concluded we would have to revert
>> this patch to make that happen.
>>
>> commit 76a748e2c1aa976d0c7fef872fa6ff93ce334a8a
>> Author: Leo Yan <leo.yan@linaro.org>
>> Date:   Sat Apr 16 09:26:34 2022 +0800
>>
>>      interconnect: qcom: msm8939: Use icc_sync_state
>>
>> but then why not revert for all of these SoCs too ?
>>
>> drivers/interconnect/qcom/msm8939.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/msm8974.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/msm8996.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/osm-l3.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sc7180.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sc7280.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sc8180x.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sc8280xp.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sdm845.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sdx55.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sdx65.c:		.sync_state = icc_sync_state,
>> drivers/interconnect/qcom/sm6350.c:		.sync_state = icc_sync_state,
>>
>> until such time as we have an all or nothing interconnect setup for each of
>> those SoCs ?
>>
>> Yes I take your point "some peripherals will appear to work only as a result
>> of the AHB vote the MDP casts here" but, that is a bug in the definition of
>> that hypothetical peripheral.
>>
>> The MDP/display won't run without the interconnect here and the only way to
>> pull it is to remove sync_state which begs the question why not pull
>> sync_state for all SoCs without a perfect interconnect description ?
>>
>> I think that would be a retrograde step.
>>
> 
> Most of the SoCs you list do have "interconnects" defined for most
> components, which means the situation for them is quite a different
> level. 

8974 defines two interconnects one for the mdp, one of the gpu. So a 
headless setup as you describe would encounter the same situation 
potentially.

> I simulated this on the BQ Aquaris M5 (MSM8939) that has most
> functionality set up already in postmarketOS. First the results without
> any changes (interconnects enabled like in your patch here):

To me, that is indicative of more work being required to vote 
appropriately for required bandwidth - AHB clocks basically in our 
hypothetical setup.

The display certainly won't work without voting for bandwidth it needs. 
If there's work to be done to _enable_ headless mode - and there is, we 
can do the work to figure out who isn't voting for bandwidth.

Probably the CPU - absent cpufreq, CPR, the operating points. A good - 
probably correct guess is we aren't ramping cpufreq, aren't ramping CCI 
and aren't voting for the inter-chip CCI "front side" so when the system 
boots headless and "does stuff" the cpufrequency stays low, the votes 
aren't cast and everything seems to crawl.

I still think its a contrived example though. CPR will come right after 
the core dtsi and we can put the theory to the test.

;)

---
bod

