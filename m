Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59E712E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbjEZUvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbjEZUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:51:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BFDE57
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:51:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af30a12e84so12183691fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685134267; x=1687726267;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5AatKw6EtxzG9E4dF0UYt5pzjSCEqOZGHssidQMlz4=;
        b=CFWTVoeRCdniU+x2qGDJhodKgGHp1JKCle+Ga8fFPMpQ7B4BhuvPLNIgT2gNcBWdm/
         rmJ7+zhRGA6CfusOOvkE6UET4zEm7HKXXbh+9AR7VUFcS0AeuvvYB0dTERm7ZO1Z9tnc
         Ea39RjrFKznDv7D/pH8AQScSp3cSmSY6qfHGxmiizl+fCTnqfwLwzekBcTLkIXWr8+nk
         TF0zAPIqz8VKE6uVTAYzgP/RSPXJyH6SwKZgXPHq/6/QyY8TEkLNUQC4bN0/lnh3XQs+
         Oui3IOpPCgrKQs5GJUUM2HLW2rjR1OFZQ+3SlBpjkO8AUkNMsVv7gAwxub1v1K0pVseJ
         0Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134267; x=1687726267;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5AatKw6EtxzG9E4dF0UYt5pzjSCEqOZGHssidQMlz4=;
        b=WRamGBCPydSUc+BEKsJ1snmCwg2qAl4kMWdjL3Oga0ap092cz1L3RZ4u1urRGyyJIT
         0Bu4M5jevY1AhiV6ovZbomt62Hb1MJXKDE91Fzvy/VpCkZ/5I3O6MorSPV/y7Eel4uRW
         nb2h5T8DX08pTgeCoZXlnJu1Jqz/poaXLKJLnUQm9rikmSI+hHfoJRzsCXY2dAoThAa5
         iyIsN2T3JDjHSox68R28J48KVBDDOM5dYjQo5PKKiZzgOaoJU8tJPOMKAuZRXMRr3mjk
         /Dz0xDU0+giIVq30Z/nlkGRhkJL334HqI8XwUdwOFz9DpAoRQ2Gcq4c9dJ0+XMs1dqCq
         80fg==
X-Gm-Message-State: AC+VfDx3vvUk+AlizeVDbzNHkTIf4MIfqYbpal52saNrSUOwfFTrISZ/
        hC/8REH1FVVR3lJk7E1++5Tubw==
X-Google-Smtp-Source: ACHHUZ7eoEEQ+WYgy29uaLJ4siKa8UDIyEBc1moLD4g7vHo2xRi2pXCLl62zxT4o/c1z5ryQM/t2NA==
X-Received: by 2002:a2e:9e8e:0:b0:29f:58c6:986e with SMTP id f14-20020a2e9e8e000000b0029f58c6986emr821078ljk.52.1685134267123;
        Fri, 26 May 2023 13:51:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id p19-20020a2e9a93000000b002ad8fc8dda6sm935227lji.17.2023.05.26.13.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:51:06 -0700 (PDT)
Message-ID: <83465b41-3894-3490-e030-a523073e498f@linaro.org>
Date:   Fri, 26 May 2023 22:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] clk: qcom: gcc-ipq6018: update UBI32 PLL
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526190855.2941291-1-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526190855.2941291-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 26.05.2023 21:08, Robert Marko wrote:
> Update the UBI32 alpha PLL config to the latest values from the downstream
> QCA 5.4 kernel.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq6018.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index 350ead66914ca..abd97b939850f 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -4149,15 +4149,20 @@ static struct clk_branch gcc_dcc_clk = {
>  
>  static const struct alpha_pll_config ubi32_pll_config = {
>  	.l = 0x3e,
> -	.alpha = 0x57,
> +	.alpha = 0x6667,
>  	.config_ctl_val = 0x240d6aa8,
>  	.config_ctl_hi_val = 0x3c2,
> +	.config_ctl_val = 0x240d4828,
> +	.config_ctl_hi_val = 0x6,
>  	.main_output_mask = BIT(0),
>  	.aux_output_mask = BIT(1),
>  	.pre_div_val = 0x0,
>  	.pre_div_mask = BIT(12),
>  	.post_div_val = 0x0,
>  	.post_div_mask = GENMASK(9, 8),
> +	.alpha_en_mask = BIT(24),
> +	.test_ctl_val = 0x1C0000C0,
Please use lowercase hex.

Konrad
> +	.test_ctl_hi_val = 0x4000,
>  };
>  
>  static const struct alpha_pll_config nss_crypto_pll_config = {
