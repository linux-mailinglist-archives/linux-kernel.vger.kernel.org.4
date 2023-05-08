Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84416FA0EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjEHHX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjEHHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:23:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE0459F1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:23:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso947694e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683530584; x=1686122584;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcajkMFg+Ijs1is/I9T3sNOP6ZgzZEyX3QOUPBnk/dc=;
        b=FC6fI1KiPdx+e67WHc+0iGmLtivABnz8MrKkTMaTy8j2fSHT+89HwVPiRw3bAJNrC/
         0j65IwEydYg9NiJdl6qFH6PugeMwIlaXzKrjo1BLAZ+C/pI9LCROGvwJ0lydfoPSfle8
         ovKlA53T47amHxIk7ClUN4x5vmxO2eTTX2q2G53oBDH6wkuj8mmoA44p8YuHjAe3HDNY
         04zKaWmQpSuvlAiybds3j7cC+yVVy+27Jl9TE+mD9ZpYTo7f1r9j8ttYPKpN8mzI4dag
         ZKPLv93zUHVRQc4nDHGDB6B5wE9w/AsjCpzWR2YJk7j8hSNcltTfSFafL040x2RrgHiz
         dlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683530584; x=1686122584;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcajkMFg+Ijs1is/I9T3sNOP6ZgzZEyX3QOUPBnk/dc=;
        b=QO6CSXXDzuZboyAnoKWEz2MXIB45ASlciYgZd04GuqHCG2gK5D/SVl7Yo3aNvp56PU
         SpMtudeDfDmeBBA1B46fhOH1vee75XrpBivtDppQaaeFk9X5Howk84BmXZZb4wUtPqPN
         /9Q6tTM1pA809VUHV1Oim4MvI7O2YnPCRBoYH9Rzq99KGwTbvElcJ32jsMdU0WbeuiHF
         E/Iia22eUaCz8RqnKAnG2fhp6HmTEQQY8QIe5NEB3yzzjEuFLwO7OguxR4TrN1pwOToB
         pbegYVkO9ZDgIOL+41TzWdgP9Khq3F3ZdTs/WDOK4DFNI1lO/u9j6XTcNIKrWZmaUILO
         aJhg==
X-Gm-Message-State: AC+VfDz3t1b1Jx56HQ+6Nc7n5KBZMpHq8ZoltkL+XkvdPXYRC/BLlhl7
        0JF+3okiXW/VyvW33Gfa//4uLA==
X-Google-Smtp-Source: ACHHUZ6ejBx1vKnzKsGGvjQPIgfuX8+QSRfspSO3bKunB3U8xP/D7kfgYBUc8w9TLE7z9shOBp4lOg==
X-Received: by 2002:a19:7016:0:b0:4f2:4d32:9b62 with SMTP id h22-20020a197016000000b004f24d329b62mr995245lfc.20.1683530584507;
        Mon, 08 May 2023 00:23:04 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id b4-20020ac25624000000b004f127652954sm1187107lff.184.2023.05.08.00.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:23:04 -0700 (PDT)
Message-ID: <cef7b823-451f-e98a-65d3-3e396124071a@linaro.org>
Date:   Mon, 8 May 2023 09:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
In-Reply-To: <20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.05.2023 23:20, Luca Weiss wrote:
> On msm8226 we also have OXILICX_GDSC but we need a slighly different
> config, with a .cxcs defined for clock but with no parent.
Hm, on newer (a5xx+) GPUs, CX needs to be turned on first and
to achieve that, we sometimes define it to be the GX's (also
implicitly known as "oxili-non-CX" in before-a6xx-times) parent..

Roughly speaking CX powers the "GPU hardware owned by the broader
SoC that may not need the GPU core clock to be up" and GX powers
the "GPU hardware owned strictly by the GPU that needs at least some
GPU clocks to be enabled"

Maybe 8974 simply has a bug in the driver that would do the reverse?
Could you (and perhaps Dmitry on his shiny new 13yo board) test that
theory, preferably on both SoCs?

--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2431,6 +2431,7 @@ static struct gdsc oxili_gdsc = {
        .pd = {
                .name = "oxili",
        },
+       .parent = &oxili_gdsc.pd,
        .pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -2439,7 +2440,6 @@ static struct gdsc oxilicx_gdsc = {
        .pd = {
                .name = "oxilicx",
        },
-       .parent = &oxili_gdsc.pd,
        .pwrsts = PWRSTS_OFF_ON,
 };

Konrad
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/clk/qcom/mmcc-msm8974.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
> index 4273fce9a4a4..39ee3953567c 100644
> --- a/drivers/clk/qcom/mmcc-msm8974.c
> +++ b/drivers/clk/qcom/mmcc-msm8974.c
> @@ -2443,6 +2443,16 @@ static struct gdsc oxilicx_gdsc = {
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> +static struct gdsc oxilicx_gdsc_msm8226 = {
> +	.gdscr = 0x4034,
> +	.cxcs = (unsigned int []){ 0x4028 },
> +	.cxc_count = 1,
> +	.pd = {
> +		.name = "oxilicx",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
>  static struct clk_regmap *mmcc_msm8226_clocks[] = {
>  	[MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
>  	[MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
> @@ -2533,6 +2543,7 @@ static struct gdsc *mmcc_msm8226_gdscs[] = {
>  	[MDSS_GDSC] = &mdss_gdsc,
>  	[CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
>  	[CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
> +	[OXILICX_GDSC] = &oxilicx_gdsc_msm8226,
>  };
>  
>  static const struct regmap_config mmcc_msm8226_regmap_config = {
> 
> ---
> base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
> change-id: 20230506-msm8226-oxilicx-7f3f0f8e491d
> 
> Best regards,
