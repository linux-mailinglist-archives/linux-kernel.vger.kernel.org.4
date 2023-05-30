Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69948716840
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjE3P6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjE3P6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:58:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86644133
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:57:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso47773655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685462276; x=1688054276;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=soD7KF236fVdv2fwYKiHqpw4d6B1nafnm4/p2DE5I88=;
        b=MTcBKUpy4tR6lLTlD+Y89QSKhzPlk7dnG3Vy8L6fXEAoz64IMHhHdz6VGzsefppXhu
         wmHmT7TJhOpKppFgf6kIyFlJjytexBGylAuRTWDVY8daJwftQYPNs3XkrDkQfNxlC/+u
         Y6p6euSYceST9/gTaWJBg016jaCsSAdDxUeTrfzJHZNROYE1eL+IsMAaFJUQj/lxd15J
         8DLEOuU729hex6HElXm4WGnYk8v93LI8BZNrERU3/aVgBfpIZ5EHntv1rymP3xRQMEi7
         qco5f+9qOToPFLKQA0unDJbYcE/Cbm9iafuRjnXD+wBIpsJiVlJ6JyfHyhidjL9ruWmW
         fLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462276; x=1688054276;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soD7KF236fVdv2fwYKiHqpw4d6B1nafnm4/p2DE5I88=;
        b=jn6xB4SHIp09QQS3EUdum/eLg8h2/QVahVTedgG4B0iEXpwlu70pPckxmYlTJm8VgZ
         JbcY8aeG0zN5hpEYVvvgzZw6JVBcsmOEwW966rRFWuKpN0UfT+RaELNHL3K3UXDalGBE
         J7JqSrW31CdUfGBChBrviRffxtSlPin41g4wu8xJ2uSM8Xt4KIKysumbk3DP9KfZlS2E
         c4VwMy06HbSAESzasPHbhC1341iJxrXnFunk2SlNFcEXvCdsPUk8sCHTHCuKQuUK2vrW
         vfJ7aOOE4+mJbOOWtNjhvE1BgiP1rqx2KseAD50NiYkEs/kp64gPQhdSSnD4lGTwjFqd
         rfiw==
X-Gm-Message-State: AC+VfDzLT5krX5H3MIS+86hVOFn1R65peqizSTbWeLNf7yZlEeSGlHRA
        0coRsYg8SeKkP80M73d3KbMdFhZhcJ8wvWBJPfiJOQ==
X-Google-Smtp-Source: ACHHUZ4PI3+RU/VHtMz95ap8CicMr/pqwOn3JEnKSr6jW7kKz7iW5Xn12uDh1TwBu1EIbWNrHGU/Nw==
X-Received: by 2002:a1c:7708:0:b0:3f6:1377:8b15 with SMTP id t8-20020a1c7708000000b003f613778b15mr1856995wmi.21.1685462275850;
        Tue, 30 May 2023 08:57:55 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id k5-20020a7bc405000000b003f31cb7a203sm17789085wmi.14.2023.05.30.08.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 08:57:55 -0700 (PDT)
Message-ID: <c24502f9-f717-6ff9-211c-1d129ef02f24@linaro.org>
Date:   Tue, 30 May 2023 17:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 05/17] clk: meson: g12a: make VCLK2 and ENCL clock path
 configurable by CCF
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-5-56eb7a4d5b8e@linaro.org>
 <1jv8ga445j.fsf@starbuckisacylon.baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <1jv8ga445j.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:14, Jerome Brunet wrote:
> 
> On Tue 30 May 2023 at 09:38, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> In order to setup the DSI clock, let's make the unused VCLK2 clock path
>> configuration via CCF.
>>
>> The nocache option is removed from following clocks:
>> - vclk2_sel
>> - vclk2_input
>> - vclk2_div
>> - vclk2
>> - vclk_div1
>> - vclk2_div2_en
>> - vclk2_div4_en
>> - vclk2_div6_en
>> - vclk2_div12_en
>> - vclk2_div2
>> - vclk2_div4
>> - vclk2_div6
>> - vclk2_div12
>> - cts_encl_sel
>>
>> The missing vclk2 reset sequence is handled via new clkc notifiers
>> in order to reset the vclk2 after each rate change as done by Amlogic
>> in the vendor implementation.
>>
>> In order to set a rate on cts_encl via the vclk2 clock path,
>> the NO_REPARENT flag is set on cts_encl_sel & vclk2_sel in order
>> to keep CCF from selection a parent.
>> The parents of cts_encl_sel & vclk2_sel are expected to be defined
>> in DT.
>>
>> The following clock scheme is to be used for DSI:
>>
>> xtal
>> \_ gp0_pll_dco
>>     \_ gp0_pll
>>        |- vclk2_sel
>>        |  \_ vclk2_input
>>        |     \_ vclk2_div
>>        |        \_ vclk2
>>        |           \_ vclk2_div1
>>        |              \_ cts_encl_sel
>>        |                 \_ cts_encl	-> to VPU LCD Encoder
>>        |- mipi_dsi_pxclk_sel
>>        \_ mipi_dsi_pxclk_div
>>           \_ mipi_dsi_pxclk		-> to DSI controller
>>
>> The mipi_dsi_pxclk_div is set as RO in order to use the same GP0
>> for mipi_dsi_pxclk and vclk2_input.
> 
> I don't think notifiers is the appropriate approach here.
> Whenever there is clock change the motifiers would trigger an off/on of
> the clock, regardless of the clock usage or state.
> If you have several consummers on this vclk2, this would
> cause glitches and maybe this is not desirable.
> 
> I think it would be better to handle the enable and reset with a
> specific gate driver, in prepare() or enable(), and the give the clock
> CLK_SET_RATE_GATE flag.
> 
> This would require the clock to be properly turn off before changing the
> rate.

Sure, will see how to switch to that, seem Martin did than on Meson8.

Neil

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/clk/meson/g12a.c | 131 +++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 120 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> index 461ebd79497c..e4053f4957d5 100644
>> --- a/drivers/clk/meson/g12a.c
>> +++ b/drivers/clk/meson/g12a.c
>> @@ -3163,7 +3163,7 @@ static struct clk_regmap g12a_vclk2_sel = {
>>   		.ops = &clk_regmap_mux_ops,
>>   		.parent_hws = g12a_vclk_parent_hws,
>>   		.num_parents = ARRAY_SIZE(g12a_vclk_parent_hws),
>> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>>   	},
>>   };
>>   
>> @@ -3191,7 +3191,6 @@ static struct clk_regmap g12a_vclk2_input = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_sel.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>   	},
>>   };
>>   
>> @@ -3212,6 +3211,40 @@ static struct clk_regmap g12a_vclk_div = {
>>   	},
>>   };
>>   
>> +struct g12a_vclk_div_notifier {
>> +	struct clk_regmap *clk;
>> +	unsigned int offset;
>> +	u8 en_bit_idx;
>> +	u8 reset_bit_idx;
>> +	struct notifier_block nb;
>> +};
>> +
>> +static int g12a_vclk_div_notifier_cb(struct notifier_block *nb,
>> +				  unsigned long event, void *data)
>> +{
>> +	struct g12a_vclk_div_notifier *nb_data =
>> +		container_of(nb, struct g12a_vclk_div_notifier, nb);
>> +
>> +	switch (event) {
>> +	case PRE_RATE_CHANGE:
>> +		/* disable and reset vclk2 divider */
>> +		regmap_update_bits(nb_data->clk->map, nb_data->offset,
>> +				   BIT(nb_data->en_bit_idx) |
>> +				   BIT(nb_data->reset_bit_idx),
>> +				   BIT(nb_data->reset_bit_idx));
>> +		return NOTIFY_OK;
>> +	case POST_RATE_CHANGE:
>> +		/* enabled and release reset */
>> +		regmap_update_bits(nb_data->clk->map, nb_data->offset,
>> +				   BIT(nb_data->en_bit_idx) |
>> +				   BIT(nb_data->reset_bit_idx),
>> +				   BIT(nb_data->en_bit_idx));
>> +		return NOTIFY_OK;
>> +	default:
>> +		return NOTIFY_DONE;
>> +	};
>> +};
>> +
>>   static struct clk_regmap g12a_vclk2_div = {
>>   	.data = &(struct clk_regmap_div_data){
>>   		.offset = HHI_VIID_CLK_DIV,
>> @@ -3225,10 +3258,18 @@ static struct clk_regmap g12a_vclk2_div = {
>>   			&g12a_vclk2_input.hw
>>   		},
>>   		.num_parents = 1,
>> -		.flags = CLK_GET_RATE_NOCACHE,
>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>>   	},
>>   };
>>   
>> +static struct g12a_vclk_div_notifier g12a_vclk2_div_data = {
>> +	.clk = &g12a_vclk2_div,
>> +	.offset = HHI_VIID_CLK_DIV,
>> +	.en_bit_idx = 16,
>> +	.reset_bit_idx = 17,
>> +	.nb.notifier_call = g12a_vclk_div_notifier_cb,
>> +};
>> +
>>   static struct clk_regmap g12a_vclk = {
>>   	.data = &(struct clk_regmap_gate_data){
>>   		.offset = HHI_VID_CLK_CNTL,
>> @@ -3243,6 +3284,33 @@ static struct clk_regmap g12a_vclk = {
>>   	},
>>   };
>>   
>> +struct g12a_vclk_reset_notifier {
>> +	struct clk_regmap *clk;
>> +	unsigned int offset;
>> +	u8 bit_idx;
>> +	struct notifier_block nb;
>> +};
>> +
>> +static int g12a_vclk_notifier_cb(struct notifier_block *nb,
>> +				  unsigned long event, void *data)
>> +{
>> +	struct g12a_vclk_reset_notifier *nb_data =
>> +		container_of(nb, struct g12a_vclk_reset_notifier, nb);
>> +
>> +	switch (event) {
>> +	case POST_RATE_CHANGE:
>> +		/* reset vclk2 */
>> +		regmap_update_bits(nb_data->clk->map, nb_data->offset,
>> +				   BIT(nb_data->bit_idx), BIT(nb_data->bit_idx));
>> +		regmap_update_bits(nb_data->clk->map, nb_data->offset,
>> +				   BIT(nb_data->bit_idx), 0);
>> +
>> +		return NOTIFY_OK;
>> +	default:
>> +		return NOTIFY_DONE;
>> +	};
>> +}
>> +
>>   static struct clk_regmap g12a_vclk2 = {
>>   	.data = &(struct clk_regmap_gate_data){
>>   		.offset = HHI_VIID_CLK_CNTL,
>> @@ -3253,10 +3321,17 @@ static struct clk_regmap g12a_vclk2 = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> +static struct g12a_vclk_reset_notifier g12a_vclk2_data = {
>> +	.clk = &g12a_vclk2,
>> +	.offset = HHI_VIID_CLK_CNTL,
>> +	.bit_idx = 15,
>> +	.nb.notifier_call = g12a_vclk_notifier_cb,
>> +};
>> +
>>   static struct clk_regmap g12a_vclk_div1 = {
>>   	.data = &(struct clk_regmap_gate_data){
>>   		.offset = HHI_VID_CLK_CNTL,
>> @@ -3337,7 +3412,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3351,7 +3426,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3365,7 +3440,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3379,7 +3454,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3393,7 +3468,7 @@ static struct clk_regmap g12a_vclk2_div12_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3459,6 +3534,7 @@ static struct clk_fixed_factor g12a_vclk2_div2 = {
>>   			&g12a_vclk2_div2_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3472,6 +3548,7 @@ static struct clk_fixed_factor g12a_vclk2_div4 = {
>>   			&g12a_vclk2_div4_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3485,6 +3562,7 @@ static struct clk_fixed_factor g12a_vclk2_div6 = {
>>   			&g12a_vclk2_div6_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3498,6 +3576,7 @@ static struct clk_fixed_factor g12a_vclk2_div12 = {
>>   			&g12a_vclk2_div12_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3559,7 +3638,7 @@ static struct clk_regmap g12a_cts_encl_sel = {
>>   		.ops = &clk_regmap_mux_ops,
>>   		.parent_hws = g12a_cts_parent_hws,
>>   		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
>> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3727,7 +3806,7 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_div = {
>>   	},
>>   	.hw.init = &(struct clk_init_data){
>>   		.name = "mipi_dsi_pxclk_div",
>> -		.ops = &clk_regmap_divider_ops,
>> +		.ops = &clk_regmap_divider_ro_ops,
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&g12a_mipi_dsi_pxclk_sel.hw
>>   		},
>> @@ -5421,6 +5500,32 @@ static int meson_g12a_dvfs_setup(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> +static int meson_g12a_vclk_setup(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct clk *notifier_clk;
>> +	int ret;
>> +
>> +	/* Setup clock notifier for vclk2 */
>> +	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_vclk2.hw, DVFS_CON_ID);
>> +	ret = devm_clk_notifier_register(dev, notifier_clk, &g12a_vclk2_data.nb);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register the vlkc2 notifier\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Setup clock notifier for vclk2_div */
>> +	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_vclk2_div.hw, DVFS_CON_ID);
>> +	ret = devm_clk_notifier_register(dev, notifier_clk,
>> +					 &g12a_vclk2_div_data.nb);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register the vclk2_div notifier\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   struct meson_g12a_data {
>>   	const struct meson_eeclkc_data eeclkc_data;
>>   	int (*dvfs_setup)(struct platform_device *pdev);
>> @@ -5443,6 +5548,10 @@ static int meson_g12a_probe(struct platform_device *pdev)
>>   	g12a_data = container_of(eeclkc_data, struct meson_g12a_data,
>>   				 eeclkc_data);
>>   
>> +	ret = meson_g12a_vclk_setup(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>>   	if (g12a_data->dvfs_setup)
>>   		return g12a_data->dvfs_setup(pdev);
> 

