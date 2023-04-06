Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726BF6D94F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbjDFLTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbjDFLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:19:26 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703A9EEC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:18:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by14so21161708ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680779929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29AbynB58RVlX/Xz1Q9jFnCqOXLNJLI87dC4ahFGT5g=;
        b=Tqx7UzvoO8Ou91Ca2xVpetXNKojH5ZvfBeD3KOjlbWcf39TYN2299jnoIOzz+cRWda
         cYYlEMq/j592C9BwIfoeqFbsAhuZx9nod8+UKzx3xqfcwAFTqKa4lZ7wxtax0q3JQczk
         AHMqDcT+7V5dwtRJFdM2TeGCcxLm39gOBDlI8664WkH8HX4KFfrxNQEas05ItdBTsdI6
         rZQykuurcGBKUiX6LJIFON6CUJygAyEN65HcgX4xMW77YCPPV16TyDhKyHt/dlMdelrU
         QWsGt6L/W0yB4oHorlVl8zKOChQ04qIUAV2wKbe0aUBDGDg6hsu7RhkJffmUkmLIzJoj
         fYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29AbynB58RVlX/Xz1Q9jFnCqOXLNJLI87dC4ahFGT5g=;
        b=tilcXyympY0Kx/LZfaf8JC0moYtDRMuz4nUZFcIi+1LgEucBflgHzRfqv9fXzwmG61
         gl0TTt1PZmpGaCENj8rafq645zgLD/KwPU8d8oHbp7K5sEmi+egFG75XfsXM/bw5Ian2
         /YtMzRVr+mv4HURJHBh28nsK1/oNnaW5NLFqmSeyFhBfcoCZWCIhhHG5EPq1F7jJ2frU
         2+eMbcGQi7Py4k11w/OJsZm/vD1cSajNykEcs5RgV72uGIb5vv86POfe4R001MU8Ucfh
         6qvKOb690xJ0k0vTlFmSHoRO/HL3QQeFTzXNkP1jZ25yysbqVitDGctaScu3tcNF6X+v
         bn8A==
X-Gm-Message-State: AAQBX9cMXDkjP3xXraSvk9XzEYCprPeP6DTLT9NBq/3skVYC5VKqmbtw
        wzjWBznFzuJvT3wo/tDn+VlCgQ==
X-Google-Smtp-Source: AKy350ZZ/mdKzLOROTb14VD+pQI9sOND2sbyG4rYNZS76ZzhwUihaN1flXr8mmESkfryB9xoIE3sxA==
X-Received: by 2002:a05:651c:1028:b0:2a1:2cb4:5f81 with SMTP id w8-20020a05651c102800b002a12cb45f81mr2804274ljm.36.1680779926280;
        Thu, 06 Apr 2023 04:18:46 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id p4-20020a2e9ac4000000b002a12f54df41sm243229ljj.38.2023.04.06.04.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 04:18:45 -0700 (PDT)
Message-ID: <bb3cdcfa-943e-074d-04f6-bfd8b2cd378d@linaro.org>
Date:   Thu, 6 Apr 2023 13:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: qcom: gcc-qcm2290: Mark RCGs shared where applicable
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230403174807.345185-1-konrad.dybcio@linaro.org>
 <20230406040433.GA111746@dragon>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230406040433.GA111746@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 06:04, Shawn Guo wrote:
> On Mon, Apr 03, 2023 at 07:48:07PM +0200, Konrad Dybcio wrote:
>> The vast majority of shared RCGs were not marked as such. Fix it.
> 
> It seems we completely missed this shared RCG thing, as vendor drivers
> do not use it.  Could you help me understand a couple of things?
> 
> - How does vendor driver handle shared RCGs?
See paths with enable_safe_config in e.g. 

https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blob/66f3180d36f49f9bf6c1a6712acbb0c75f6ff516/drivers/clk/qcom/clk-rcg2.c


> - How did you find out these shared RCGs?
I was debugging another issue and noticed (by eye) this was missing.

Konrad
> 
> Shawn
> 
>>
>> Fixes: 496d1a13d405 ("clk: qcom: Add Global Clock Controller driver for QCM2290")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/clk/qcom/gcc-qcm2290.c | 62 +++++++++++++++++-----------------
>>  1 file changed, 31 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
>> index 096deff2ba25..48995e50c6bd 100644
>> --- a/drivers/clk/qcom/gcc-qcm2290.c
>> +++ b/drivers/clk/qcom/gcc-qcm2290.c
>> @@ -650,7 +650,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
>>  		.name = "gcc_usb30_prim_mock_utmi_clk_src",
>>  		.parent_data = gcc_parents_0,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -686,7 +686,7 @@ static struct clk_rcg2 gcc_camss_axi_clk_src = {
>>  		.name = "gcc_camss_axi_clk_src",
>>  		.parent_data = gcc_parents_4,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_4),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -706,7 +706,7 @@ static struct clk_rcg2 gcc_camss_cci_clk_src = {
>>  		.name = "gcc_camss_cci_clk_src",
>>  		.parent_data = gcc_parents_9,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_9),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -728,7 +728,7 @@ static struct clk_rcg2 gcc_camss_csi0phytimer_clk_src = {
>>  		.name = "gcc_camss_csi0phytimer_clk_src",
>>  		.parent_data = gcc_parents_5,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_5),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -742,7 +742,7 @@ static struct clk_rcg2 gcc_camss_csi1phytimer_clk_src = {
>>  		.name = "gcc_camss_csi1phytimer_clk_src",
>>  		.parent_data = gcc_parents_5,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_5),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -764,7 +764,7 @@ static struct clk_rcg2 gcc_camss_mclk0_clk_src = {
>>  		.parent_data = gcc_parents_3,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>>  		.flags = CLK_OPS_PARENT_ENABLE,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -779,7 +779,7 @@ static struct clk_rcg2 gcc_camss_mclk1_clk_src = {
>>  		.parent_data = gcc_parents_3,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>>  		.flags = CLK_OPS_PARENT_ENABLE,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -794,7 +794,7 @@ static struct clk_rcg2 gcc_camss_mclk2_clk_src = {
>>  		.parent_data = gcc_parents_3,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>>  		.flags = CLK_OPS_PARENT_ENABLE,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -809,7 +809,7 @@ static struct clk_rcg2 gcc_camss_mclk3_clk_src = {
>>  		.parent_data = gcc_parents_3,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>>  		.flags = CLK_OPS_PARENT_ENABLE,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -830,7 +830,7 @@ static struct clk_rcg2 gcc_camss_ope_ahb_clk_src = {
>>  		.name = "gcc_camss_ope_ahb_clk_src",
>>  		.parent_data = gcc_parents_6,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_6),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -854,7 +854,7 @@ static struct clk_rcg2 gcc_camss_ope_clk_src = {
>>  		.parent_data = gcc_parents_6,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_6),
>>  		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -888,7 +888,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_clk_src = {
>>  		.name = "gcc_camss_tfe_0_clk_src",
>>  		.parent_data = gcc_parents_7,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_7),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -912,7 +912,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_csid_clk_src = {
>>  		.name = "gcc_camss_tfe_0_csid_clk_src",
>>  		.parent_data = gcc_parents_8,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_8),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -926,7 +926,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_clk_src = {
>>  		.name = "gcc_camss_tfe_1_clk_src",
>>  		.parent_data = gcc_parents_7,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_7),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -940,7 +940,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_csid_clk_src = {
>>  		.name = "gcc_camss_tfe_1_csid_clk_src",
>>  		.parent_data = gcc_parents_8,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_8),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -963,7 +963,7 @@ static struct clk_rcg2 gcc_camss_tfe_cphy_rx_clk_src = {
>>  		.parent_data = gcc_parents_10,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_10),
>>  		.flags = CLK_OPS_PARENT_ENABLE,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -984,7 +984,7 @@ static struct clk_rcg2 gcc_camss_top_ahb_clk_src = {
>>  		.name = "gcc_camss_top_ahb_clk_src",
>>  		.parent_data = gcc_parents_4,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_4),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1006,7 +1006,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
>>  		.name = "gcc_gp1_clk_src",
>>  		.parent_data = gcc_parents_2,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_2),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1020,7 +1020,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
>>  		.name = "gcc_gp2_clk_src",
>>  		.parent_data = gcc_parents_2,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_2),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1034,7 +1034,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
>>  		.name = "gcc_gp3_clk_src",
>>  		.parent_data = gcc_parents_2,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_2),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1054,7 +1054,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
>>  		.name = "gcc_pdm2_clk_src",
>>  		.parent_data = gcc_parents_0,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1082,7 +1082,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
>>  	.name = "gcc_qupv3_wrap0_s0_clk_src",
>>  	.parent_data = gcc_parents_1,
>>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
>> -	.ops = &clk_rcg2_ops,
>> +	.ops = &clk_rcg2_shared_ops,
>>  };
>>  
>>  static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
>> @@ -1098,7 +1098,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
>>  	.name = "gcc_qupv3_wrap0_s1_clk_src",
>>  	.parent_data = gcc_parents_1,
>>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
>> -	.ops = &clk_rcg2_ops,
>> +	.ops = &clk_rcg2_shared_ops,
>>  };
>>  
>>  static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
>> @@ -1114,7 +1114,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
>>  	.name = "gcc_qupv3_wrap0_s2_clk_src",
>>  	.parent_data = gcc_parents_1,
>>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
>> -	.ops = &clk_rcg2_ops,
>> +	.ops = &clk_rcg2_shared_ops,
>>  };
>>  
>>  static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
>> @@ -1130,7 +1130,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
>>  	.name = "gcc_qupv3_wrap0_s3_clk_src",
>>  	.parent_data = gcc_parents_1,
>>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
>> -	.ops = &clk_rcg2_ops,
>> +	.ops = &clk_rcg2_shared_ops,
>>  };
>>  
>>  static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
>> @@ -1146,7 +1146,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
>>  	.name = "gcc_qupv3_wrap0_s4_clk_src",
>>  	.parent_data = gcc_parents_1,
>>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
>> -	.ops = &clk_rcg2_ops,
>> +	.ops = &clk_rcg2_shared_ops,
>>  };
>>  
>>  static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
>> @@ -1162,7 +1162,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
>>  	.name = "gcc_qupv3_wrap0_s5_clk_src",
>>  	.parent_data = gcc_parents_1,
>>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
>> -	.ops = &clk_rcg2_ops,
>> +	.ops = &clk_rcg2_shared_ops,
>>  };
>>  
>>  static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
>> @@ -1219,7 +1219,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
>>  		.name = "gcc_sdcc1_ice_core_clk_src",
>>  		.parent_data = gcc_parents_0,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1266,7 +1266,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
>>  		.name = "gcc_usb30_prim_master_clk_src",
>>  		.parent_data = gcc_parents_0,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1280,7 +1280,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
>>  		.name = "gcc_usb3_prim_phy_aux_clk_src",
>>  		.parent_data = gcc_parents_13,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_13),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> @@ -1303,7 +1303,7 @@ static struct clk_rcg2 gcc_video_venus_clk_src = {
>>  		.parent_data = gcc_parents_14,
>>  		.num_parents = ARRAY_SIZE(gcc_parents_14),
>>  		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>  	},
>>  };
>>  
>> -- 
>> 2.40.0
>>
