Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287FE6736FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjASLeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjASLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:34:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E2EC65
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:33:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3362507wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fl+mZE0bzcHSG7RJ3fjFnUtUZhQ6+Zdss6o32rRiNi8=;
        b=kme6Q5uu+9jfciuTWgvoy5Okl+8i7gXFBfjnmqrc51HE3R2c4KNpeVRg9F5o23jX3I
         D25qitLLkEaAfD/CJYIhfbLjbicryA6y9PepjB8cDmZ9AOh2wcZSgFt1FvvOLRQl64sz
         BGq2PxgFt0Ey1qGaoXttVktf3zlA9fRs1MTPEvs18VDGw8Tan+4IhvatDNo3XYGqglR3
         xWEhJKiAr2v8G6B3AXkRtHzavJO69tuEoBPfoJKm/FSx6PrIWygy+q1lQRrcg6ieYpu9
         uhqu9JEkHRPysI9gctSV38iVJ6egB++PlvUlHS1LkQRz5OC5B6tXdJdljQC7a4VUVFT5
         mF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl+mZE0bzcHSG7RJ3fjFnUtUZhQ6+Zdss6o32rRiNi8=;
        b=sVd1Kz6C1xH/JD+n6DgFqdTvjEg7F3brXEnh9BdTtYn1Gq0T+0Mih/pDy6ZZKadEq/
         o9T9R2Q68mHTqjB6FoVj4fCToN+uUQ5xxgZWY8MA9LfDVPtaukA4tB8ZzOTAXiqs3GAj
         401bcShQI83Js+fNmVmcQAVM1/u2WlgsMv1ZzJnF4yCF673Mn53PBxXQpyVF9WPiWjG+
         nOmw14ssFpbHHYagIJ9enuGuhe6Pk/qzB+gZ90pNywFLaOFQ3XZqzaAAZQetqH50V7Cj
         P+GTrK5k3xwwCj0jgUVzdVqyRde28eoNow8D8Qgp5RHZ+kVJbyRrjxaAMmSGyEPUqE4w
         SAuQ==
X-Gm-Message-State: AFqh2kpLbxQMKEXUwUqu9xfRWtNYahjGKbMt34x6sS1M+Rmu3lrqktVK
        1/shiHJ13WPH4xIMXQcIziCn/w==
X-Google-Smtp-Source: AMrXdXt3JnAI8NaxR3aCD+iy4yUN0eTtuOdknbjGr/KseeMccHT+0ESuESX+f0IeULtjJskJEz3oBQ==
X-Received: by 2002:a05:600c:214f:b0:3da:68e1:5d45 with SMTP id v15-20020a05600c214f00b003da68e15d45mr10031208wml.23.1674128022801;
        Thu, 19 Jan 2023 03:33:42 -0800 (PST)
Received: from [192.168.0.159] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm7025228wms.2.2023.01.19.03.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:33:42 -0800 (PST)
Message-ID: <f18bbf82-8555-7645-abd7-71610060b10c@linaro.org>
Date:   Thu, 19 Jan 2023 11:33:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: drop operating-points-v2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, fabien.parent@linaro.org
References: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
 <e73ad320fafa1365e3506bbd4cc77d8d.sboyd@kernel.org>
 <063c5516-417d-7c21-b58f-a6552779a621@linaro.org>
 <705c78c1d0da18089419b064832d5fed.sboyd@kernel.org>
 <20230119031136.27vson2awemt3nkt@builder.lan>
 <776b67b2-2405-36f5-f072-78f33ae59fcc@linaro.org>
 <b6dae46b-7dd4-f731-aa26-f4ea3e4f3118@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b6dae46b-7dd4-f731-aa26-f4ea3e4f3118@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 19/01/2023 11:04, Krzysztof Kozlowski wrote:
> On 19/01/2023 11:55, Bryan O'Donoghue wrote:
>> On 19/01/2023 03:11, Bjorn Andersson wrote:
>>> On Wed, Jan 18, 2023 at 11:11:00AM -0800, Stephen Boyd wrote:
>>>> Quoting Krzysztof Kozlowski (2023-01-15 06:35:23)
>>>>> On 13/01/2023 21:28, Stephen Boyd wrote:
>>>>>> Quoting Krzysztof Kozlowski (2023-01-13 06:58:59)
>>>>>>> The CPU PLL clock node does not use OPP tables (neither driver).
>>>>>>
>>>>>> What device is qcom_a53pll_get_freq_tbl() operating on?
>>>>>
>>>>> On its own, internal table. While of course driver could be converted to
>>>>> operating-points-v2, no one did it within last 5 years, so why it should
>>>>> happen now?
>>>>>
>>>>
>>>> The property was added mid 2021 by Shawn[1], that's not 5 years ago. I
>>>> guess there were plans to add an OPP table that never happened[2]? Is
>>>> Shawn still working on this? If not, we should revert the OPP code out
>>>> of the driver.
>>>>
>>>
>>> @Bryan, what do you think about this?
>>
>> I'd be in favour of starting the CPR patchset instead, which depends on
>> the opps.
>>
>> I think @Fabien has been waiting on the core 8939 dtsi, I also think the
>> dtsi is close enough to merge that we could reasonably initiate the CPR
>> stuff.
> 
> So you would make use of operating-points-v2 property? Then probably we
> also miss opp-table, but anyway this patch can be dropped then.
> 
> Best regards,
> Krzysztof
> 


Yep.

Looks something like this.

CPU2: cpu@102 {
     device_type = "cpu";
     compatible = "arm,cortex-a53", "arm,armv8";
     reg = <0x102>;
     next-level-cache = <&L2_1>;
     enable-method = "qcom,kpss-acc-v2";
     qcom,acc = <&acc2>;
     qcom,saw = <&saw2>;
     clocks = <&apcs1>;
     operating-points-v2 = <&cluster1_opp_table>;
     power-domains = <&cpr>;
     power-domain-names = "cpr";
     #cooling-cells = <2>;
     capacity-dmips-mhz = <1024>;
};

cluster1_opp_table: cluster1-opp-table {
     compatible = "operating-points-v2-qcom-cpu";
     opp-shared;

     /* Used by qcom-cpufreq-nvmem.c */
     nvmem-cells = <&cpr_efuse_speedbin_pvs>;
     nvmem-cell-names = "cpr_efuse_speedbin_pvs";

     opp-200000000 {
         opp-hz = /bits/ 64 <200000000>;
         opp-supported-hw = <0x3f>;
         required-opps = <&cpr_opp3>;
     };

     opp-345600000 {
         opp-hz = /bits/ 64 <345600000>;
         opp-supported-hw = <0x3f>;
         required-opps = <&cpr_opp3>;
     };
};

cpr_opp_table: cpr-opp-table {
     compatible = "operating-points-v2-qcom-level";

     cpr_opp1: opp1 {
         opp-hz = /bits/ 64 <200000000>;
             opp-level = <1>;
             qcom,opp-fuse-level = <1>;
         };
     cpr_opp2: opp2 {
         opp-hz = /bits/ 64 <345600000>;
             opp-level = <2>;
             qcom,opp-fuse-level = <1>;
          };
          cpr_opp3: opp3 {
             opp-hz = /bits/ 64 <400000000>;
             opp-level = <3>;
             qcom,opp-fuse-level = <1>;
          };
     };
     /* etc */
};

---
bod
