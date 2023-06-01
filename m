Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447797197E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjFAJ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjFAJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:56:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B138E58
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:56:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f122ff663eso683906e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613376; x=1688205376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwUJHKeEbJQY9jFY5vbQNfghI+h3iwgrBK1ENUlMmJg=;
        b=cSwWVr8ESU97aWmBDtyn6d20vplFFeQ4gJupQxt2wjMBKSDAC9fX7chKlO0HQ3pcAt
         F5ZHq43cUaTAZr44P/LNxwoJVXhJjfAbe9KTBeIM6gjDx7gze9eZ073RXMD1+KbHFmCb
         Ake03lGfNcPBE2FNpjbJ5Q+GpSjX67p6OGq0Qt9iXpoGkio05vMSE1Umomm1Y902MH71
         8mNrk2po9bnTNLuwe6NBSVTmUyjrgTeicWwyrCdAYjrVlU+M8DCgpVfWsCzUDNeLOsBv
         0jyACl1S/yQpDl/aCpAiBWc09S1wG2h1Jnwm9cGTSdD1RFAYZ/CIiQb3qsvMXyhzUtzH
         WnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613376; x=1688205376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwUJHKeEbJQY9jFY5vbQNfghI+h3iwgrBK1ENUlMmJg=;
        b=XLeLaECn8f2jG25tVYF1RM7WXpS+z812kVOssMxV8iDH7YNXpxF8mTXh1zFwYHs2Y0
         PpXNXMxqKrYyrbsrBjTFffLOpkyPh8DbocBWX5PfSEGz1l8hbahGM2WhfbV9vgZx/3yy
         LLEQh2MCfLBXS9fYeX/ujexRUVeWf33uNJalF04UEueOXrSysWUIKIa3UEri3CCMI8TO
         drLsZ6WwjMAdPeMcrQL6sYLIHv2GyWOoTQC9s8fv5U6VjtlFmxrPjtNsxNsTMa7ryzFU
         W6EyfUXymrGnbpGHxLJ2BmxfBxpmJWzh6xsF6zdNOK37bd6Cu1mQ7UZsL3L5yYk8KjCm
         5lWw==
X-Gm-Message-State: AC+VfDzB9+YHbc70WsduqyxLpJiphIGx3HGFX4ldR7njFjQGP7n6E0Be
        IcfjpylMdo4tmopHu/antIYA2A==
X-Google-Smtp-Source: ACHHUZ6w2htpFe4QEkjiigWWsRFkFmL8MAAkQ9vCWyLPM6pc2NY8KZP3SU4rVp0rFMvOBWCRf9rKag==
X-Received: by 2002:a05:6512:78:b0:4f3:aa74:2faf with SMTP id i24-20020a056512007800b004f3aa742fafmr1042824lfo.6.1685613375883;
        Thu, 01 Jun 2023 02:56:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25610000000b004d8546456c6sm1027571lfd.195.2023.06.01.02.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:56:15 -0700 (PDT)
Message-ID: <8983fc5f-b75e-3f38-577f-3c588acbe3f7@linaro.org>
Date:   Thu, 1 Jun 2023 12:56:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/20] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-6-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-6-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 13:20, Konrad Dybcio wrote:
> In some very very very very unfortunate cases, the correct offset of
> the QoS registers will be.. negative. One such case is MSM8998, where
> The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
> take into account with the register calculation, making the actual
> BIMC node start at what-would-be-the-BIMC-base+0x300.

Can we turn one of devices into a child of another device? This way we 
won't have to cope with negative offsets.

> 
> In order to keep the calculation code sane, the simplest - however
> ugly it may be - solution is to allow the offset to be negative.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index d2c04c400cad..ba840a436cc0 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -29,10 +29,10 @@ enum qcom_icc_type {
>    * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
>    * @type: the ICC provider type
>    * @regmap: regmap for QoS registers read/write access
> - * @qos_offset: offset to QoS registers
>    * @bus_clk_rate: bus clock rate in Hz
>    * @bus_clks: the clk_bulk_data table of bus clocks
>    * @intf_clks: a clk_bulk_data array of interface clocks
> + * @qos_offset: offset to QoS registers

This can be kept in place.

>    * @keep_alive: whether to always keep a minimum vote on the bus clocks
>    * @is_on: whether the bus is powered on
>    */
> @@ -42,7 +42,7 @@ struct qcom_icc_provider {
>   	int num_intf_clks;
>   	enum qcom_icc_type type;
>   	struct regmap *regmap;
> -	unsigned int qos_offset;
> +	int qos_offset;
>   	u64 bus_clk_rate[NUM_BUS_CLKS];
>   	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
>   	struct clk_bulk_data *intf_clks;
> @@ -108,7 +108,7 @@ struct qcom_icc_desc {
>   	bool no_clk_scaling;
>   	enum qcom_icc_type type;
>   	const struct regmap_config *regmap_cfg;
> -	unsigned int qos_offset;
> +	int qos_offset;
>   };
>   
>   /* Valid for all bus types */
> 

-- 
With best wishes
Dmitry

