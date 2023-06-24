Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9EA73C611
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjFXBtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjFXBtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:49:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB972729
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:49:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so1629717e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687571368; x=1690163368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfro2Z7t9cpTSkdETXGdcSnHCdkerPzBWRSGF3KNDQQ=;
        b=E711irWY9xbUdqCcACzkiknYFKiJC21DydvbOwg8e+nNeBP2ptQ+BDe9rifzUC1mEV
         qpLjB1n9M2vT9pfcd1htykBghjEw/LEVhiLiusXd+NojiMZxcLm8IzBXgOjslL3YIblG
         7DTzy6hHTy9aJtyOld5JYh5vQ0+ZQ7H/m/uf8B1JjzzDsIGjxGeoJbyt5FWMMhV7D7Fr
         7IkmYrEvQblTmzGUP6HjyUGNFPHYczoysxzQBqc6dHxssSWeHEbVKKqxCtWxlOiAL7wd
         9u/2J3Jyc0z+cSKDLESVsHbJEf0g2NGykxC0cNT0vIS2p8jbjvXW3tW/fwDRvZ5Ll4d6
         6qRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687571368; x=1690163368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfro2Z7t9cpTSkdETXGdcSnHCdkerPzBWRSGF3KNDQQ=;
        b=aIAvnLI1LtmMX+E+AV7xCQrSPQRSHmPWdPvsZsDAt7tZbt06Biyg9T9PGpFGgejB+s
         PQWJo9vPYYJMk2cZ+dyUA8i+OPlKgs4yZLTK7LSekdoA5BbUlAwldsmVwaifih+XeN+i
         kUNa2ufuqFCieCsa2L8Zo2CVXULJXX79qlD27oN62wcdlwW5hyhSqhlhMgpqh8QuA2cP
         3ygdBrhqfRSfvWu/1SnXYVqeF/QuYm0a4UBGckvrCtSfHxljIQaOejAIYZaq0sxDaTna
         Xb8zoonwyvhqDQfcTRI8JtivMy5t/CoUe670TNttKR/gIEPZUPC6QVGaS9CqeoY3QX2A
         o5hg==
X-Gm-Message-State: AC+VfDwau73fE2ELtPo0WmHbenVfS9q8dU0VA5EdNAZby5h4MWVR+a8P
        PWVt83BREVDLY4deKtMRfcEz7Q==
X-Google-Smtp-Source: ACHHUZ7lkBMDt6hQqNSL6eUx+zSLBCaelrzQ4f+uB82xB4QPavcR2tmkz9cOmbgTOgaJew8XT0385w==
X-Received: by 2002:ac2:5d28:0:b0:4f8:4255:16ca with SMTP id i8-20020ac25d28000000b004f8425516camr13553209lfb.38.1687571368069;
        Fri, 23 Jun 2023 18:49:28 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004f85885cff1sm94649lfe.134.2023.06.23.18.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 18:49:27 -0700 (PDT)
Message-ID: <18d969bb-69b5-0d42-1518-e8a3b92859b7@linaro.org>
Date:   Sat, 24 Jun 2023 03:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/15] drm/msm/dsi: Add 14nm phy configuration for SM6125
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-11-1d5a638cebf2@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230624-sm6125-dpu-v1-11-1d5a638cebf2@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2023 02:41, Marijn Suijten wrote:
> SM6125 features only a single PHY (despite a secondary PHY PLL source
> being available to the disp_cc_mdss_pclk0_clk_src clock), and downstream
> sources for this "trinket" SoC do not define the typical "vcca"
> regulator to be available nor used.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
The introduced ops are identical to 2290, modulo regulator..

But the regulator is absent on both (VDD_MX powers it instead), so
feel free to clean that up and reuse it ;)

Konrad
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c      |  2 ++
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h      |  1 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 15 +++++++++++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index 9d5795c58a98..8688ed502dcf 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -559,6 +559,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
>  	  .data = &dsi_phy_14nm_2290_cfgs },
>  	{ .compatible = "qcom,dsi-phy-14nm-660",
>  	  .data = &dsi_phy_14nm_660_cfgs },
> +	{ .compatible = "qcom,dsi-phy-14nm-6125",
> +	  .data = &dsi_phy_14nm_6125_cfgs },
>  	{ .compatible = "qcom,dsi-phy-14nm-8953",
>  	  .data = &dsi_phy_14nm_8953_cfgs },
>  #endif
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> index 8b640d174785..ebf915f5e6c6 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> @@ -52,6 +52,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_20nm_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_660_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_2290_cfgs;
> +extern const struct msm_dsi_phy_cfg dsi_phy_14nm_6125_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs;
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> index 3ce45b023e63..5d43c9ec69ae 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> @@ -1068,6 +1068,21 @@ const struct msm_dsi_phy_cfg dsi_phy_14nm_660_cfgs = {
>  	.num_dsi_phy = 2,
>  };
>  
> +const struct msm_dsi_phy_cfg dsi_phy_14nm_6125_cfgs = {
> +	.has_phy_lane = true,
> +	.ops = {
> +		.enable = dsi_14nm_phy_enable,
> +		.disable = dsi_14nm_phy_disable,
> +		.pll_init = dsi_pll_14nm_init,
> +		.save_pll_state = dsi_14nm_pll_save_state,
> +		.restore_pll_state = dsi_14nm_pll_restore_state,
> +	},
> +	.min_pll_rate = VCO_MIN_RATE,
> +	.max_pll_rate = VCO_MAX_RATE,
> +	.io_start = { 0x5e94400 },
> +	.num_dsi_phy = 1,
> +};
> +
>  const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs = {
>  	.has_phy_lane = true,
>  	.regulator_data = dsi_phy_14nm_17mA_regulators,
> 
