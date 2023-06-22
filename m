Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B973A447
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjFVPFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjFVPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:05:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553EE7E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:05:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f8467e39cfso9832435e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687446330; x=1690038330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ppBgWBknm380/WbbZgWVPXJGsSlejHE7bJKZ6mCfbY=;
        b=jefA+A4h3C3ONpxJHbHhYqqOp9Dw8AJHVhVQdKoY9boEjaACPuHV+vU1TGadn4NrTm
         jpLIrgg8E/4saY8TV08OwrqYlmpEWKB/zH39xPBnyEcEU+7bCG81G0XQjoYqCHLo7QLr
         WgMNnZCnc36BVBVG5gIrDkuRjuui4C94N2YVG7A5Ko0lm6RTAg6427sDcOLJ0BHMURo1
         X1C1tUEJ1SDmMf2+IEGQyrIkPdsnyPZ+GF/EL8y+OBQclblijI7kGWJXK6cINdQHxZt0
         j/4Wk239o95YCDqlnIdWHZVGv+mBwJf1xwoQ6t8T1/sqUpd8R/MWZ5AdUmriZUnc8pD9
         Wclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446330; x=1690038330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ppBgWBknm380/WbbZgWVPXJGsSlejHE7bJKZ6mCfbY=;
        b=EIwapJPs0SSulP3aYOx9Cc+ft/hHpmmCspXD24D1PYfjtglIEEmAZpSoDD3tuUmII0
         o9Zzey0dBZucZAuiNCIhDJmlKKNMDLi3hxmCBq7OBnRrD2uIwYZHkoI8YLpimglP3QE2
         27GKcz1EsL5Oc5I3kIDyaD0IOrK4udJw4PBkhwcWxCWxeHHe08SXE2F5aZFAmhI8hY2P
         luXBewJjcmA5UrRsxQazdIk+oJCoUH5fpEa4LnY4Jxmp6+k6eQqSPh60y2jt7u/QgpiA
         DPgFYW2xdE7uQFWtsoGxdX3b1MB5xmnZoQOCtqCEopKdTJH4mHi3YDnaJvoukNt/YQ8z
         sEiA==
X-Gm-Message-State: AC+VfDzBWdoJZ+YJDFpzRGIDjKACkSmQbsHFSeoq0tjnjaghIFN0/hAK
        6X9FNOSx4zeuct0D6dAahYIfoA==
X-Google-Smtp-Source: ACHHUZ4lrTEYIvKvQxf8w67Oh+3+SZq+YtD7TDr9HSpK3QqTpm5ZJjx1e4WRxdE1+tElva3hcDb+Hw==
X-Received: by 2002:ac2:5058:0:b0:4f8:67f0:724e with SMTP id a24-20020ac25058000000b004f867f0724emr9449664lfm.33.1687446330142;
        Thu, 22 Jun 2023 08:05:30 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id 17-20020ac24851000000b004f86673a47dsm1161403lfy.75.2023.06.22.08.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:05:29 -0700 (PDT)
Message-ID: <18f508e7-8a7e-162b-4bed-eaef45147a22@linaro.org>
Date:   Thu, 22 Jun 2023 17:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/9] clk: qcom: gcc-msm8998: Control MMSS and GPUSS GPLL0
 outputs properly
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jami Kettunen <jami.kettunen@somainline.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
 <20230622-topic-8998clk-v1-3-5b7a0d6e98b1@linaro.org>
 <e880bad8-4fcb-97c1-ec9c-9122e1b550e6@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e880bad8-4fcb-97c1-ec9c-9122e1b550e6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2023 16:55, Jeffrey Hugo wrote:
> On 6/22/2023 5:57 AM, Konrad Dybcio wrote:
>> Up until now, we've been relying on some non-descript hardware magic
>> to pinkypromise turn the clocks on for us. While new SoCs shine with
>> that feature, MSM8998 can not always be fully trusted.
>>
>> Register the MMSS and GPUSS GPLL0 legs with the CCF to allow for manual
>> enable voting.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/clk/qcom/gcc-msm8998.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
>> index be024f8093c5..cccb19cae481 100644
>> --- a/drivers/clk/qcom/gcc-msm8998.c
>> +++ b/drivers/clk/qcom/gcc-msm8998.c
>> @@ -25,6 +25,9 @@
>>   #include "reset.h"
>>   #include "gdsc.h"
>>   +#define GCC_MMSS_MISC    0x0902C
>> +#define GCC_GPU_MISC    0x71028
>> +
>>   static struct pll_vco fabia_vco[] = {
>>       { 250000000, 2000000000, 0 },
>>       { 125000000, 1000000000, 1 },
>> @@ -1367,6 +1370,22 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
>>       },
>>   };
>>   +static struct clk_branch gcc_mmss_gpll0_div_clk = {
>> +    .halt_check = BRANCH_HALT_DELAY,
>> +    .clkr = {
>> +        .enable_reg = 0x5200c,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_mmss_gpll0_div_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &gpll0_out_main.clkr.hw,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_mmss_gpll0_clk = {
>>       .halt_check = BRANCH_HALT_DELAY,
>>       .clkr = {
>> @@ -1395,6 +1414,38 @@ static struct clk_branch gcc_mss_gpll0_div_clk_src = {
>>       },
>>   };
>>   +static struct clk_branch gcc_gpu_gpll0_div_clk = {
>> +    .halt_check = BRANCH_HALT_DELAY,
>> +    .clkr = {
>> +        .enable_reg = 0x5200c,
>> +        .enable_mask = BIT(3),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_gpu_gpll0_div_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &gpll0_out_main.clkr.hw,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_branch gcc_gpu_gpll0_clk = {
>> +    .halt_check = BRANCH_HALT_DELAY,
>> +    .clkr = {
>> +        .enable_reg = 0x5200c,
>> +        .enable_mask = BIT(4),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_gpu_gpll0_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &gpll0_out_main.clkr.hw,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_blsp1_ahb_clk = {
>>       .halt_reg = 0x17004,
>>       .halt_check = BRANCH_HALT_VOTED,
>> @@ -3080,6 +3131,9 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
>>       [AGGRE2_SNOC_NORTH_AXI] = &aggre2_snoc_north_axi_clk.clkr,
>>       [SSC_XO] = &ssc_xo_clk.clkr,
>>       [SSC_CNOC_AHBS_CLK] = &ssc_cnoc_ahbs_clk.clkr,
>> +    [GCC_MMSS_GPLL0_DIV_CLK] = &gcc_mmss_gpll0_div_clk.clkr,
>> +    [GCC_GPU_GPLL0_DIV_CLK] = &gcc_gpu_gpll0_div_clk.clkr,
>> +    [GCC_GPU_GPLL0_CLK] = &gcc_gpu_gpll0_clk.clkr,
>>   };
>>     static struct gdsc *gcc_msm8998_gdscs[] = {
>> @@ -3235,6 +3289,10 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
>>       if (ret)
>>           return ret;
>>   +    /* Disable the GPLL0 active input to MMSS and GPU via MISC registers */
>> +    regmap_write(regmap, GCC_MMSS_MISC, 0x10003);
>> +    regmap_write(regmap, GCC_GPU_MISC, 0x10003);
> 
> I wonder, does this disrupt a handoff of an active display from the bootloader to Linux?
My phone's bootloader doesn't initialize the display, if you (or Angelo
or Jami, +CC) could test this, it'd be wonderful.

Konrad
