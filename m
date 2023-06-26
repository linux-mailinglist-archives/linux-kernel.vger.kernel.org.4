Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223C973DBBF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjFZJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFZJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:50:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108CAF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:50:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f86dbce369so3873928e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687773004; x=1690365004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r48qhWy74bZBBa7bMcUvYWqc1h0+KVW4IUCOHacmlpM=;
        b=qV1mIEwHOGw5gY7390ETBIZaF9GKYobrrLXpVWevs0+byXiuoEJ29jFm+B8QBsbsdS
         je7AB1mQGEjNSC6D1F4+N4MDLnvU4O3A2+1cggsJ9iHtgYJNQtpdyp9iaLVjfl+Ni8kG
         hjMr+lBP0T7MJ9Xd5ZlNRrJR7Be6IwtJcSaCKgy5YggT8aa4LclwAPufocODFHNFJl28
         +pPg90W4dj/VcooFn0qJAuCrfRPKnkJgIwgVh1XAdDhLKOaO/CN1IR2blqHpCi0cTgA4
         ywYwlcltNY6GyxCUt8Fd6HywhS9Ogi7l/RCpndLwfapJdGbd0ABGJ21JlHCBQQaqW1WU
         HL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687773004; x=1690365004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r48qhWy74bZBBa7bMcUvYWqc1h0+KVW4IUCOHacmlpM=;
        b=fdOyfuWnmwvHLB0YbLnYhiItowIAr2vAoSJg1EV4OkH0rg06jauYjLaf16URrxNnP9
         q8aspWEVydsO7WlTyxL/rrwSMM996GnyUKRpsdvtfjUvIfjjog8KCJiX2NV8tD1Y6fnG
         U4i7wRFLig3KN8vTkioZtmn4hoI00f+f6gn55+PNY1P+2ijuaS8ixUswqcbDP89kba1y
         5yE45rXrmWH8u57K0T6vKGRE6QIW8PsbkqejHD0Db9GsAGFPmjveFPAiKUB7rEzBdWha
         dlKQTw54VREPb8BscWlZWowYMc8WdTPRAut+UeLb23YYNovzeAfPOHp/95C5SsWarlhe
         BCBQ==
X-Gm-Message-State: AC+VfDyTFAIiz9234Una6dqtF8f/oacSTI/kO9Wweq1TB4SJY8r6AVtE
        Xurabc31tRkF24rTHMZXrpzGbQ==
X-Google-Smtp-Source: ACHHUZ7hTovAqUp5UnE6VLhes9zqA0lA31zfJhvcxKrA/PaCx+BCGRop8CXI/UCD382peuIof/GzBw==
X-Received: by 2002:a19:3813:0:b0:4f8:7697:5207 with SMTP id f19-20020a193813000000b004f876975207mr11276238lfa.23.1687773003856;
        Mon, 26 Jun 2023 02:50:03 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512024200b004f87726f531sm1033542lfo.174.2023.06.26.02.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 02:50:03 -0700 (PDT)
Message-ID: <72915ade-7bd5-2f82-b294-e96fd1e71569@linaro.org>
Date:   Mon, 26 Jun 2023 11:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/15] drm/msm/dsi: Add 14nm phy configuration for SM6125
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
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
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
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
 <18d969bb-69b5-0d42-1518-e8a3b92859b7@linaro.org>
 <sdz26twflxyew2ejqkpqpe4eaz57hcsphi2so2wjndqxsh3q5c@diksxdwico33>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <sdz26twflxyew2ejqkpqpe4eaz57hcsphi2so2wjndqxsh3q5c@diksxdwico33>
Content-Type: text/plain; charset=UTF-8
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

On 25.06.2023 22:23, Marijn Suijten wrote:
> On 2023-06-24 03:49:25, Konrad Dybcio wrote:
>> On 24.06.2023 02:41, Marijn Suijten wrote:
>>> SM6125 features only a single PHY (despite a secondary PHY PLL source
>>> being available to the disp_cc_mdss_pclk0_clk_src clock), and downstream
>>> sources for this "trinket" SoC do not define the typical "vcca"
>>> regulator to be available nor used.
>>>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>> The introduced ops are identical to 2290, modulo regulator..
> 
> Sure, I can create a "drop unused regulators from 14nm qcm2290 config"
> and a second "reuse qcm2290 14nm dsi phy for sm6125" patch, instead of
> this one.
Please do.

> 
>> But the regulator is absent on both (VDD_MX powers it instead), so
> 
> In the DT patch you requested me to use CX instead of MX... Which one is
> it?
You're confusing DSI host with DSI PHY.

> 
> Also note that I moved it from DSI PHY to DSI0 because that's where the
> rpmpd opps reside.
Both of them need their separate power lines to be active!

Also, OPP is not necessary for genpd activation.

Konrad
> 
> - Marijn
> 
>> feel free to clean that up and reuse it ;)
> 
>>
>> Konrad
>>>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c      |  2 ++
>>>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h      |  1 +
>>>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 15 +++++++++++++++
>>>  3 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>>> index 9d5795c58a98..8688ed502dcf 100644
>>> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>>> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>>> @@ -559,6 +559,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
>>>  	  .data = &dsi_phy_14nm_2290_cfgs },
>>>  	{ .compatible = "qcom,dsi-phy-14nm-660",
>>>  	  .data = &dsi_phy_14nm_660_cfgs },
>>> +	{ .compatible = "qcom,dsi-phy-14nm-6125",
>>> +	  .data = &dsi_phy_14nm_6125_cfgs },
>>>  	{ .compatible = "qcom,dsi-phy-14nm-8953",
>>>  	  .data = &dsi_phy_14nm_8953_cfgs },
>>>  #endif
>>> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
>>> index 8b640d174785..ebf915f5e6c6 100644
>>> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
>>> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
>>> @@ -52,6 +52,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_20nm_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_660_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_2290_cfgs;
>>> +extern const struct msm_dsi_phy_cfg dsi_phy_14nm_6125_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs;
>>> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
>>> index 3ce45b023e63..5d43c9ec69ae 100644
>>> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
>>> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
>>> @@ -1068,6 +1068,21 @@ const struct msm_dsi_phy_cfg dsi_phy_14nm_660_cfgs = {
>>>  	.num_dsi_phy = 2,
>>>  };
>>>  
>>> +const struct msm_dsi_phy_cfg dsi_phy_14nm_6125_cfgs = {
>>> +	.has_phy_lane = true,
>>> +	.ops = {
>>> +		.enable = dsi_14nm_phy_enable,
>>> +		.disable = dsi_14nm_phy_disable,
>>> +		.pll_init = dsi_pll_14nm_init,
>>> +		.save_pll_state = dsi_14nm_pll_save_state,
>>> +		.restore_pll_state = dsi_14nm_pll_restore_state,
>>> +	},
>>> +	.min_pll_rate = VCO_MIN_RATE,
>>> +	.max_pll_rate = VCO_MAX_RATE,
>>> +	.io_start = { 0x5e94400 },
>>> +	.num_dsi_phy = 1,
>>> +};
>>> +
>>>  const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs = {
>>>  	.has_phy_lane = true,
>>>  	.regulator_data = dsi_phy_14nm_17mA_regulators,
>>>
