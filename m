Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9346FAD59
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjEHLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjEHLd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:33:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018EE3C488
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:32:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso4902488e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683545547; x=1686137547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biNcUc6skKfEbdVuV/u6w3vEoW3OrmOcIzAgHDfIjm8=;
        b=gyBVaN4M//EKnmRj0bNXVPVBPJVTDjZnw1UHY4C3jbqN9/18jjJi/G5TWdh6XyhMyR
         v1dGu4f1j03LCqZqne+qlKtYeYAuhq+i8IYjrP1yCb98G/ecsHe258SHAIgElk49kU6A
         tRTL6YDY7bnDgg9HRxN8xfX/C/u+vck9fTKUYzpRRBv1TwhIilX3cHGuL1bVH6vXUvPV
         RmUArPHhwIlE2zNhDolCmDuv2prmQNOqYQOGPfx6Md6J6mJc93of1Nmz8/YfxOzyviFM
         Vmmdqnvoj3zYrr8PjWJQ2Z1oyQWStsgZE35HEJs9X4lb+f8wxttrw80g9vshAs+Ni/+1
         iioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545547; x=1686137547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biNcUc6skKfEbdVuV/u6w3vEoW3OrmOcIzAgHDfIjm8=;
        b=FHRMUppfWy4LQQcbojPCoWQIB0BLzQ3XzBaNB4Uzpzr/9Lj/B6FJq7g05vJE/+o8me
         o9haMeW6Vj14Rf+QLIsQzEZ5cWLfYoFh3D/b3XV3fi9XGlw1Dz91DYYyzwUWXen1JI1w
         wsjI9eOgvSmtMR8iUkowrFCxrMNHr5xKYaBmzAimMzwGE0MbcyfvOjbB5H/acH+7r5jA
         Vvjbvm9jkGia3Na2fKBXRUtV/ln4BfZ+TpXYumS0dcVKuk2JzBQeWsYDQ5GEGlBvOtrj
         J5pdESC/VZBwdhqEcFY856McvAZfVLBaSTtZeUpwiHk1/V+fguwdv988r3JvSGHjCo5t
         PkQA==
X-Gm-Message-State: AC+VfDyDPEnunYssLL5zwbidz0p2QUSkN151GcoOo0P6GpPfW0bLIKXS
        fPiNVAof2IO24SS6y6MHxa/pOQ==
X-Google-Smtp-Source: ACHHUZ4XvzAD13OcuImAjQPBg1FlQ5kID3RDyKhf20gIUPKXUIbWW95cCNZZv0A3kCiMjqm0kjw9SQ==
X-Received: by 2002:a19:f519:0:b0:4f1:4cdc:ec03 with SMTP id j25-20020a19f519000000b004f14cdcec03mr2356828lfb.18.1683545547106;
        Mon, 08 May 2023 04:32:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w6-20020ac25986000000b004f160559d4asm851538lfn.183.2023.05.08.04.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:32:26 -0700 (PDT)
Message-ID: <fdb76743-de20-91c5-2edc-19dd5ead33e3@linaro.org>
Date:   Mon, 8 May 2023 14:32:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz>
 <cef7b823-451f-e98a-65d3-3e396124071a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <cef7b823-451f-e98a-65d3-3e396124071a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 10:23, Konrad Dybcio wrote:
> 
> 
> On 6.05.2023 23:20, Luca Weiss wrote:
>> On msm8226 we also have OXILICX_GDSC but we need a slighly different
>> config, with a .cxcs defined for clock but with no parent.
> Hm, on newer (a5xx+) GPUs, CX needs to be turned on first and
> to achieve that, we sometimes define it to be the GX's (also
> implicitly known as "oxili-non-CX" in before-a6xx-times) parent..
> 
> Roughly speaking CX powers the "GPU hardware owned by the broader
> SoC that may not need the GPU core clock to be up" and GX powers
> the "GPU hardware owned strictly by the GPU that needs at least some
> GPU clocks to be enabled"
> 
> Maybe 8974 simply has a bug in the driver that would do the reverse?
> Could you (and perhaps Dmitry on his shiny new 13yo board) test that
> theory, preferably on both SoCs?
> 
> --- a/drivers/clk/qcom/mmcc-msm8974.c
> +++ b/drivers/clk/qcom/mmcc-msm8974.c
> @@ -2431,6 +2431,7 @@ static struct gdsc oxili_gdsc = {
>          .pd = {
>                  .name = "oxili",
>          },
> +       .parent = &oxili_gdsc.pd,
>          .pwrsts = PWRSTS_OFF_ON,
>   };

Are you declaring oxili_gdsc to be a parent of itself?

>   
> @@ -2439,7 +2440,6 @@ static struct gdsc oxilicx_gdsc = {
>          .pd = {
>                  .name = "oxilicx",
>          },
> -       .parent = &oxili_gdsc.pd,
>          .pwrsts = PWRSTS_OFF_ON,
>   };
> 
> Konrad
>>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
>>   drivers/clk/qcom/mmcc-msm8974.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
>> index 4273fce9a4a4..39ee3953567c 100644
>> --- a/drivers/clk/qcom/mmcc-msm8974.c
>> +++ b/drivers/clk/qcom/mmcc-msm8974.c
>> @@ -2443,6 +2443,16 @@ static struct gdsc oxilicx_gdsc = {
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   };
>>   
>> +static struct gdsc oxilicx_gdsc_msm8226 = {
>> +	.gdscr = 0x4034,
>> +	.cxcs = (unsigned int []){ 0x4028 },
>> +	.cxc_count = 1,
>> +	.pd = {
>> +		.name = "oxilicx",
>> +	},
>> +	.pwrsts = PWRSTS_OFF_ON,
>> +};
>> +
>>   static struct clk_regmap *mmcc_msm8226_clocks[] = {
>>   	[MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
>>   	[MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
>> @@ -2533,6 +2543,7 @@ static struct gdsc *mmcc_msm8226_gdscs[] = {
>>   	[MDSS_GDSC] = &mdss_gdsc,
>>   	[CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
>>   	[CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
>> +	[OXILICX_GDSC] = &oxilicx_gdsc_msm8226,
>>   };
>>   
>>   static const struct regmap_config mmcc_msm8226_regmap_config = {
>>
>> ---
>> base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
>> change-id: 20230506-msm8226-oxilicx-7f3f0f8e491d
>>
>> Best regards,

-- 
With best wishes
Dmitry

