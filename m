Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D95669C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAMP1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAMP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:27:13 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DF81D51
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:20:10 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id o7so22421047ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSgTXFHyKy3EKW5amzFNddURi7wwL3JPtHEB4W2PJIQ=;
        b=E+Ko3HoaAn/SbNq2+BoHjVxHOcFXzxcMw5eAnMS7INVdgfQwkd47z0/mJOV5XoH498
         scTjG3apXZotcgyYBbdTB1cUhowgMekHOy1hfNWvlASySy0yRd7gG4cWcB5FR7gy/508
         BxaNCdVHU/hZlmXCX11/vmpk7b3qlV3Mom9au2tVJ36szclEsWxoaKG1SrKU1+5r6TmC
         phFiurVXNenluvCVRtvFrmBL5DAxUUj/0PoGhJp1toeZdMGZkQujloCxNS+e1QNClM3X
         HsvM8DnHrtWSbIkFQrovljY1C8ndbwfkHRDo85zbuIaZCICMW2Dr1oAdkQ2yKx7O2mff
         64mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSgTXFHyKy3EKW5amzFNddURi7wwL3JPtHEB4W2PJIQ=;
        b=FoP0dz/pDS0mjgF4+JO5S5HvtWo13WWM0uuDD8ldZwvATggPb21YNLBlnNGC0cMZoF
         Ghy57E06zuJyZUzOUrikzZ2K4DowBGrnt9P//3H7h7LXpK9Tea0O+QjhE9O8M1Ia8Syy
         +u7jCzss3hr5jCZwOzs7cM0NFWtT7Kkc9cn3HHNjBXc0ZJV/iZfgxhLTLR0GlK1P0vWL
         dcUhtF9tOHOCDzJbHgS94dEOVDWxEzFlA3+RdNPXBSRCCJp38Lv7vCAxoU6kqJlVJTZx
         PQ+HRYqjqekPjAdtDGbcQ4wf43KSBQ9pYPG3D4AJJyG5J7dOfvLuML3UvLs2uuyNEh9v
         /nYQ==
X-Gm-Message-State: AFqh2kp47m6EBEW/evY/d90r9957satgUhrDp1QULw8JvUDnrojjJBI4
        71AOnVLIMfeGEmtXSoCrBJLcxA==
X-Google-Smtp-Source: AMrXdXtlAwax9wzqDnNUzguINen9TYLIV91ebf6KZx6f+zkSZhQ803ZvgPpY7xs8wCz4XL7zPvUNXw==
X-Received: by 2002:a2e:a48a:0:b0:281:e762:35aa with SMTP id h10-20020a2ea48a000000b00281e76235aamr62619lji.3.1673623208570;
        Fri, 13 Jan 2023 07:20:08 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p6-20020a2ea406000000b00289cfd2088csm693673ljn.73.2023.01.13.07.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:20:08 -0800 (PST)
Message-ID: <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
Date:   Fri, 13 Jan 2023 16:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-7-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113143647.14961-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 15:36, devi priya wrote:
> Included CLK_IS_CRITICAL flag which helps to properly enable
> the APSS PLL during bootup.
Please describe the issue and not only the user-visible impact it
makes. Does the PLL get shut down by clk_ignore_unused? Maybe you
would be interested in the sync_state changes that landed in recent
-next that may solve it for you?

I don't think it should be always-on, as you have an alternate source
for low power modes, adding CLK_IS_CRITICAL will keep the PLL enabled
even if you're not using it.

> clk_rcg2_ops should be used for APSS clock RCG, as other ops
> will not configure the RCG register
RCG register meaning RCG register*s*, meaning in this case M/N/D
which would be required for proper rate setting and not only input
switching (which arguably doesn't seem to be of much concern on a
single-parent clock)? This all is not obvious..

Konrad
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 1 +
>  drivers/clk/qcom/apss-ipq6018.c | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index dd0c01bf5a98..75486a124fcd 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -33,6 +33,7 @@ static struct clk_alpha_pll ipq_pll = {
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_alpha_pll_huayra_ops,
> +			.flags = CLK_IS_CRITICAL,
>  		},
>  	},
>  };
> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> index f2f502e2d5a4..0d0e7196a4dc 100644
> --- a/drivers/clk/qcom/apss-ipq6018.c
> +++ b/drivers/clk/qcom/apss-ipq6018.c
> @@ -33,15 +33,21 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
>  	{ P_APSS_PLL_EARLY, 5 },
>  };
>  
> +static const struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
> +	{ .src = P_APSS_PLL_EARLY, .pre_div = 1 },
> +	{ }
> +};
> +
>  static struct clk_rcg2 apcs_alias0_clk_src = {
>  	.cmd_rcgr = 0x0050,
> +	.freq_tbl = ftbl_apcs_alias0_clk_src,
>  	.hid_width = 5,
>  	.parent_map = parents_apcs_alias0_clk_src_map,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "apcs_alias0_clk_src",
>  		.parent_data = parents_apcs_alias0_clk_src,
>  		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
> -		.ops = &clk_rcg2_mux_closest_ops,
> +		.ops = &clk_rcg2_ops,
>  		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
