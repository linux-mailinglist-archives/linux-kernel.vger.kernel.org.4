Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307025B3516
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIIKVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIIKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:21:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F7FBF360
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:21:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w8so1865982lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zUB8uWjMZ9Kzi3Xhi5MGjyPEcHDT/J37v121kbTKAs0=;
        b=NjvgFR7Ds/kojRmf+l9yslnoK1X+teEYx5BRECTod7HHiEnmQsk1CjuYpLKlrZRjuL
         a5nQuqtii0QaN1WsKUVZojlJxZkgUT6WMkxzLoH3+JqbFVmq5lK+lNK8R9uHz7Lj0vjR
         TAUUTvj25uIcLq9mjFB2ZqkzY2cujnMzjwroYFC1iJ7DAiNemJMT3MrWXNljoWOHh1Qk
         MdofxSW/JdaoDuE7g/zHcfYvY13oMdhCZekAJBkR5tkRNBxpY+XpWHi096kzwsk6yyhf
         ilM07HFRF5X2vRp6yTma4s2C70FfEr5rQXmxQe/lnKwwqFDQ1LH8iPMgvQ7TRs4UZcsc
         6ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zUB8uWjMZ9Kzi3Xhi5MGjyPEcHDT/J37v121kbTKAs0=;
        b=y44pivo+aRH4GHTeQul6/GnjDU6dbm2/2AktSknAfLNH2c97zdDezwdRMGOj2oAkmh
         BGHmf2BIBaWZ3VTSvzFQYns6766bnb6MwgViiWTMtsK22REMek7+WgvYjpXh5Z2QHnEP
         h/5wN+7CGC6aHjzqdYdgqvLC4bV7yDJ7KJJulKLZ91gS4y2KIglvZwslezjNFoya0AqW
         WCQGksDM1SeiEGlf9iktJ5ot4YaSxVqXCs0DspSKeu3fkWe0XO89n/OKWhhdtGo4BgFW
         QVYh9vuqxGPHbd4zQQvPKjIHlLOy94vPM/K/lJHqJqL6m7Et3tqezHjtRQHLCyxDK5Eh
         8y+w==
X-Gm-Message-State: ACgBeo354xQIaPPlxGIBzHvEpU0UmCwVyQA1JS2E/0Z3ujO41SMoAYbC
        Wui9NH6DolWO3/Zgk26WCaXUHA==
X-Google-Smtp-Source: AA6agR62K4FYaWudkHtGOyLDVc3PgvQAHrh3Xe4BqkRov8z1AWdsKLnFG8SiQfpdRWHIu1AHM8MI9Q==
X-Received: by 2002:a05:6512:3194:b0:494:716d:34e2 with SMTP id i20-20020a056512319400b00494716d34e2mr3929339lfe.147.1662718872877;
        Fri, 09 Sep 2022 03:21:12 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e14-20020ac2546e000000b00494a603953dsm26860lfn.89.2022.09.09.03.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 03:21:12 -0700 (PDT)
Message-ID: <5ed95787-ce10-94e0-eaec-9b7406d0d561@linaro.org>
Date:   Fri, 9 Sep 2022 13:21:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/6] clk: qcom: msm8996-cpu: Cleanup and migrate to
 parent_data
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
 <Ys85+7rYjQOSPvD/@builder.lan>
 <463723ee-f155-3bd9-7180-fb0271a19eb6@linaro.org>
In-Reply-To: <463723ee-f155-3bd9-7180-fb0271a19eb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 13:06, Dmitry Baryshkov wrote:
> On 14/07/2022 00:32, Bjorn Andersson wrote:
>> On Tue 21 Jun 11:06 CDT 2022, Yassine Oudjana wrote:
>>
>>> This series includes some cleanup of the MSM8996 CPU clock driver, as 
>>> well as
>>> migration from parent_names to parent_data for all of its clocks. The 
>>> DT schema
>>> is also fixed in this series to show the actual clocks consumed by 
>>> the clock
>>> controller and pass checks.
>>
>> This series looks almost ready to be merged, could you (or Dmitry?)
>> update the two outstanding items?
> 
> I have acked the patch 2 and sent the slightly updated revision of 
> patch6 (together with the rest of small changes).

Bjorn, could you please pick up patches 1-5?

> 
>>
>> Thanks,
>> Bjorn
>>
>>>
>>> Yassine Oudjana (6):
>>>    clk: qcom: msm8996-cpu: Rename DIV_2_INDEX to SMUX_INDEX
>>>    clk: qcom: msm8996-cpu: Statically define PLL dividers
>>>    clk: qcom: msm8996-cpu: Unify cluster order
>>>    clk: qcom: msm8996-cpu: Convert secondary muxes to clk_regmap_mux
>>>    dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
>>>    clk: qcom: msm8996-cpu: Use parent_data for all clocks
>>>
>>>   .../bindings/clock/qcom,msm8996-apcc.yaml     |  15 +-
>>>   drivers/clk/qcom/clk-cpu-8996.c               | 235 ++++++++++--------
>>>   2 files changed, 140 insertions(+), 110 deletions(-)
>>>
>>> -- 
>>> 2.36.1
>>>
> 
> 

-- 
With best wishes
Dmitry

