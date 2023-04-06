Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555726DA3BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbjDFUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbjDFUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:42:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF82C66C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:38:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e9so26609025ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ev5hN9s8w8JulYzATwh7JsfqAzOtHOwmwJARepKyeMw=;
        b=uNfdk0aordhm2U+uez5lxiSDLS/E8esBnea+IgMtiNchJog0+I5Qz1K0nQtDN04f0W
         MvantI/obc5ZeUBW4v0d+LJrObwS/cKin/EJ1uXiRzdu3JcoZ0jYcCPenmIXGDcnEZqA
         PaI+jIV0JhEsBjb6pI1VHbdnkYx+pcmJjozykULCEc4qwzTWsyI85O+rLgLhIMYaPbt2
         NDMJxAJ+Hv6+2/LxAhehu5kEL/eae6SskCFlAZK5RI1BGWjd7OE+fqTjqzerPB8D9kuv
         dF31PDSKQCBGFCpbyQlKkH75wPzmrc7c1bhzng4lxeqDWm4muX6ThgyBmO8tAHi6Le8M
         d/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev5hN9s8w8JulYzATwh7JsfqAzOtHOwmwJARepKyeMw=;
        b=rokuXyAfMtT3qN5JawtioeRZrdkKubNk16n9aY6zs6AwjJwUg0pEC6lKLJeysXMmmL
         lfJ9gOPpOH1o5QsL5PqnN+o2h22GYt2OQshRmvfhS3Y0kNrCjHx9v/KFh/RC0NZ8VA8k
         JZCZ3sYXxfskVKiWKhFNPAOwuxi0t+6wzprJ/mr9dYVGhbWsH4ZUp0P2XX7P0chDbv8v
         8bA3Wx7OCNuwxZTixFYUD88th3bfSCrdyypZbYZprvtyE/9GvRB4Fw3SxRrcORMWVe0V
         ENXpCR8aCWa8CYilqK8WLJzwpnLk7UMb1AYqK5+RK3toDjtavdxA6mdptC/6dBB4YmSE
         KV4Q==
X-Gm-Message-State: AAQBX9cMq4FAgF5AembVzwxZ/6XEeuEaoMQnQDp1L/XWd9TiruV4KDuG
        yv+ae6m5LYt4RxevbvCMhuAbHg==
X-Google-Smtp-Source: AKy350aLZqM5dDvzHdfZEM/juTBxRGBJKWn1U+UKEnBo8v9epMrGGWEy59cQT9Ueb/raFbSaz2xtIg==
X-Received: by 2002:a2e:a408:0:b0:29c:44f1:c1df with SMTP id p8-20020a2ea408000000b0029c44f1c1dfmr2944844ljn.41.1680813536458;
        Thu, 06 Apr 2023 13:38:56 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id z4-20020a2e8404000000b002a483f01d9csm428053ljg.85.2023.04.06.13.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 13:38:56 -0700 (PDT)
Message-ID: <ae04df79-10d6-6a38-715b-8f00e8764d85@linaro.org>
Date:   Thu, 6 Apr 2023 22:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 2/5] clk: qcom: apss-ipq-pll: Add support for IPQ9574
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dmitry.baryshkov@linaro.org, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230406061314.10916-1-quic_devipriy@quicinc.com>
 <20230406061314.10916-3-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230406061314.10916-3-quic_devipriy@quicinc.com>
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



On 6.04.2023 08:13, Devi Priya wrote:
> Add the compatible and configuration values for A73 Huayra PLL found
> on IPQ9574.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Changes in V3:
> 	- Updated the subject and aligned the commit message
> 
>  drivers/clk/qcom/apss-ipq-pll.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index cf4f0d340cbf..ce28d882ee78 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -111,6 +111,18 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>  	.test_ctl_hi_val = 0x4000,
>  };
>  
> +static const struct alpha_pll_config ipq9574_pll_config = {
> +	.l = 0x3b,
> +	.config_ctl_val = 0x200d4828,
> +	.config_ctl_hi_val = 0x6,
> +	.early_output_mask = BIT(3),
> +	.aux2_output_mask = BIT(2),
> +	.aux_output_mask = BIT(1),
> +	.main_output_mask = BIT(0),
> +	.test_ctl_val = 0x0,
> +	.test_ctl_hi_val = 0x4000,
> +};
> +
>  struct apss_pll_data {
>  	int pll_type;
>  	struct clk_alpha_pll *pll;
> @@ -135,6 +147,12 @@ static struct apss_pll_data ipq6018_pll_data = {
>  	.pll_config = &ipq6018_pll_config,
>  };
>  
> +static struct apss_pll_data ipq9574_pll_data = {
> +	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
> +	.pll = &ipq_pll_huayra,
> +	.pll_config = &ipq9574_pll_config,
> +};
> +
>  static const struct regmap_config ipq_pll_regmap_config = {
>  	.reg_bits		= 32,
>  	.reg_stride		= 4,
> @@ -180,6 +198,7 @@ static const struct of_device_id apss_ipq_pll_match_table[] = {
>  	{ .compatible = "qcom,ipq5332-a53pll", .data = &ipq5332_pll_data },
>  	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
>  	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
> +	{ .compatible = "qcom,ipq9574-a73pll", .data = &ipq9574_pll_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
