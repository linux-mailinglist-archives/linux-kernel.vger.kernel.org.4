Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6394D682841
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjAaJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjAaJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:09:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7AE11E95
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:05:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bk15so39544564ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJnpjzUKe3sWjBlHXxdOlTEMQguX92YQ9FxcS1c4TVM=;
        b=UQfEMeTXyr8Ksbhq1ly+TzcTIhsGhEWlFdHdQEJZeovCLS5diQsxZE7LyzgOmm+3Q+
         Tm2Px1bItltgkyUpuTCJ0N68nQh2gBoXtYFzomzEKvEhYWuxOB5lO+8o8f4ZKjzUzT2R
         /NNZW0Ij5IE3NFh4nbWWI0kABuxzYAturlqgrW/e0qwIfngHe0WYF3Tnqw7Vg7eCRbFc
         sgtbdfr41ubtCEPZjw7t4qO6rIqTt9JH/A8L09GfS4VPT1lQuhHgi1IHq2C5uC4gUpVT
         0JXK0IvHDi8kMTOziP0BnrZ7ZkVe33i7uRJ19fToMcQTG1+4QybTYVZn5cRYUg0Rcn+1
         Jxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJnpjzUKe3sWjBlHXxdOlTEMQguX92YQ9FxcS1c4TVM=;
        b=2w/edFC+YfGmTvj6IjV3+j1v3+BW+frwaHxGtdOx26PWVaf11Gut1zF/EVr291kt5M
         2/Av+m9EyD6vvxgybi11AIHnrtn/xyz+hPuPnIntxoBJ4ZujqP4TST+dv8JcXW1PKTu5
         Fn9LsOtuLUluYf5FpfiAP3RVkyiw4OtFvZ/9BzNoFvP9DUdWBfuwd8+/y7IPvPVeLsXZ
         /ikIqEIS7/xFTdWZ5xfUMzA9MW/kuC5A4GElIt3Q74Y915xNsYq23uXrn3V9PZ722r20
         Z5YhkR5Zv+09ntM8h2cbbJww3aO9Zk12a7ycaNGW6WFOUEr8wP9OqnNuOqiZgJbb9aJ8
         5BUw==
X-Gm-Message-State: AFqh2koVUFXgJsURprPJKPABwrCUzBf4n6eLNuPZmQ5q+zpSaEATrq34
        ynNHerm6gUDX1nccGmKVdWGcMA==
X-Google-Smtp-Source: AMrXdXuwAGoMADNDlU4goYtlmZZtuJE/jLHORmjb2vGrQyj7ldiaKDno30VVQ7kQmBN90vekse3mqg==
X-Received: by 2002:a17:906:87cb:b0:86f:d0c9:4bdd with SMTP id zb11-20020a17090687cb00b0086fd0c94bddmr52869271ejb.27.1675155926735;
        Tue, 31 Jan 2023 01:05:26 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906c21200b0084ce5d5d21bsm8023220ejz.22.2023.01.31.01.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:05:26 -0800 (PST)
Message-ID: <4148b98c-8cee-83c5-7212-06326f086f2a@linaro.org>
Date:   Tue, 31 Jan 2023 11:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/8] clk: qcom: branch: Add helper functions for
 setting retain bits
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230130235926.2419776-1-konrad.dybcio@linaro.org>
 <20230130235926.2419776-2-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230130235926.2419776-2-konrad.dybcio@linaro.org>
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

On 31/01/2023 01:59, Konrad Dybcio wrote:
> Most Qualcomm branch clocks come with a pretty usual set of bits that
> can enable memory retention by means of not turning off parts of the
> memory logic. Add them to the common header file and introduce helper
> functions for setting them instead of using magic writes.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/clk-branch.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 17a58119165e..d8fc7b93ef6d 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -37,6 +37,29 @@ struct clk_branch {
>   	struct clk_regmap clkr;
>   };
>   
> +/* Branch clock common bits for HLOS-owned clocks */
> +#define CBCR_FORCE_MEM_CORE_ON		BIT(14)
> +#define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
> +#define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)

It might be a slight bit of pain, but I'd suggest moving these 
definitions next to BRANCH_CLK_OFF since they are using the same reg. 
(And while you are at it also reworking BRANCH_NOC_FSM_STATUS into a 
proper mask and FIELD_* macros.)

> +
> +static inline void qcom_branch_set_force_mem_core(struct regmap *regmap, u32 reg, bool on)

These functions can be more descriptive if they receive struct 
clk_branch as an argument instead of just a register.

> +{
> +	regmap_update_bits(regmap, reg, CBCR_FORCE_MEM_CORE_ON,
> +			   on ? CBCR_FORCE_MEM_CORE_ON : 0);
> +}
> +
> +static inline void qcom_branch_set_force_periph_on(struct regmap *regmap, u32 reg, bool on)
> +{
> +	regmap_update_bits(regmap, reg, CBCR_FORCE_MEM_PERIPH_ON,
> +			   on ? CBCR_FORCE_MEM_PERIPH_ON : 0);
> +}
> +
> +static inline void qcom_branch_set_force_periph_off(struct regmap *regmap, u32 reg, bool on)
> +{
> +	regmap_update_bits(regmap, reg, CBCR_FORCE_MEM_PERIPH_OFF,
> +			   on ? CBCR_FORCE_MEM_PERIPH_OFF : 0);
> +}
> +
>   extern const struct clk_ops clk_branch_ops;
>   extern const struct clk_ops clk_branch2_ops;
>   extern const struct clk_ops clk_branch_simple_ops;

-- 
With best wishes
Dmitry

