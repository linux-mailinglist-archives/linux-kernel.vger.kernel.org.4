Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB04466BD31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjAPLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAPLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:49:19 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3159D4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:49:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a37so3843999ljq.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUAbrSURx8Khf0HlL/kZdlVXE9xkryXsu1r8+broRMI=;
        b=FVAuEg1czWMlllnkYULrHRLt5WFiUjAdRAoXjk4i1AuAffQCF8lKeu9vTg1gYEqwO+
         KfbRjJilZKrlPpZCwqJTDCsLSxqrtQ4DUOUSLi4kvvUZ0dl8tFJhjiK1zdoiMXJCBQnW
         MDc1FA100zW9mzrylsNe2DI5ONQoHQ8Uu8EpQkG5lYGASHbR57qBftKba2f/XQSlb9lG
         Kqopf2jAuU+JzfN9KZH3iWqrPeo7zpWCjy8yG6kF5kI1byEf5+MOLuIz0d/p908OrBc6
         jgCx33GFWp2zxuXyxtOFwJh+qfjy1NCP+8lumePQoWEv5A/SO2CgkHGdSwo+vK9MfYGZ
         Lg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUAbrSURx8Khf0HlL/kZdlVXE9xkryXsu1r8+broRMI=;
        b=HcJKAZYf1PGQeei3UPqToCxYsQltxB5wbER6JFPjZxx7BAukDSSf0axUaWQE/iqWdu
         WFolhsTAIG0/Gy/TKaNSozBEG7ZDpaLsdWqGwOf97S182RhaBbl3oJFHm/YgGQ/h2ecz
         DeUMgOOPe1En5k6jnTv40T1Sy0kjQRY+79oDKkZ64Ci3i7Z59KKUGZTgInp1s1CufLlE
         3BkT7Quo48ubr0ensqZ9ZMJXfEdNIMBaCflqrMjL81YZlWdNJzAwMnBvHoEOy7p1f7Jz
         cgPZdZ22n9JFe2lc0dfCOGkna2e9sutP9ASR64MJQq+XCyUetL9c53fsr1d3tV+mdOFv
         M2Kw==
X-Gm-Message-State: AFqh2kpdXuntRHqpCW/kaPc0OrqZGXo6pW4QGLaxb10Jyfos0LfuTfDi
        BxdWHXbRHgar3WU9UXbifP5mOA==
X-Google-Smtp-Source: AMrXdXtWDitnC0VttiztQIbhNA5dQhacWb0uAo5oHslocyRjaKDSlcpjVeu8MYt8GFLJ5XVIM4Uu1Q==
X-Received: by 2002:a2e:9a97:0:b0:287:801e:4424 with SMTP id p23-20020a2e9a97000000b00287801e4424mr7321168lji.37.1673869755472;
        Mon, 16 Jan 2023 03:49:15 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e8e6c000000b0028b64c7bd75sm1273078ljk.139.2023.01.16.03.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 03:49:15 -0800 (PST)
Message-ID: <0df556d3-b478-d8e6-fa85-8696ff2377d0@linaro.org>
Date:   Mon, 16 Jan 2023 12:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] drm/msm/dsi: Add phy configuration for SM6375
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        sunliming <sunliming@kylinos.cn>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>
References: <20230116114059.346327-1-konrad.dybcio@linaro.org>
 <20230116114059.346327-2-konrad.dybcio@linaro.org>
 <3b4e5183-25c4-ab04-6b0c-74a57540d00e@linaro.org>
 <CAA8EJprgFA-vod9vnt+uzptzgbvbrMSe+zOpd2ftsz0pS9jb8w@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJprgFA-vod9vnt+uzptzgbvbrMSe+zOpd2ftsz0pS9jb8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 12:47, Dmitry Baryshkov wrote:
> On Mon, 16 Jan 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 16.01.2023 12:40, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>
>>> SM6375 uses a boring standard 7nm PHY. Add a configuration entry for it.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Sorry, bit messy revisiting old patches before the email change..
>>
>> Konrad
>>> Depends on [1] to work properly, but won't hurt for it to land
>>> separately..
>>>
>>> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1642586079-12472-1-git-send-email-loic.poulain@linaro.org/
>>>
>>>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
>>>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
>>>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 20 ++++++++++++++++++++
>>>  3 files changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>>> index cbe669fca26d..57445a5dc816 100644
>>> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>>> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>>> @@ -569,6 +569,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
>>>         .data = &dsi_phy_7nm_8150_cfgs },
>>>       { .compatible = "qcom,sc7280-dsi-phy-7nm",
>>>         .data = &dsi_phy_7nm_7280_cfgs },
>>> +     { .compatible = "qcom,sm6375-dsi-phy-7nm",
>>> +       .data = &dsi_phy_7nm_6375_cfgs },
>>>       { .compatible = "qcom,sm8350-dsi-phy-5nm",
>>>         .data = &dsi_phy_5nm_8350_cfgs },
>>>       { .compatible = "qcom,sm8450-dsi-phy-5nm",
>>> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
>>> index 5f0b1c9b09ef..c849bfd7494e 100644
>>> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
>>> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
>>> @@ -55,6 +55,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs;
>>> +extern const struct msm_dsi_phy_cfg dsi_phy_7nm_6375_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
>>>  extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
>>> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
>>> index af5c952c6ad0..3b1ed02f644d 100644
>>> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
>>> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
>>> @@ -1152,6 +1152,26 @@ const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs = {
>>>       .quirks = DSI_PHY_7NM_QUIRK_V4_1,
>>>  };
>>>
>>> +const struct msm_dsi_phy_cfg dsi_phy_7nm_6375_cfgs = {
>>> +     .has_phy_lane = true,
> 
> Any regulators here?
Nope, looks like 7nm also deserves a "don't require vdds-supply"
patch, gonna send it right away..

Konrad
> 
>>> +     .ops = {
>>> +             .enable = dsi_7nm_phy_enable,
>>> +             .disable = dsi_7nm_phy_disable,
>>> +             .pll_init = dsi_pll_7nm_init,
>>> +             .save_pll_state = dsi_7nm_pll_save_state,
>>> +             .restore_pll_state = dsi_7nm_pll_restore_state,
>>> +     },
>>> +     .min_pll_rate = 600000000UL,
>>> +#ifdef CONFIG_64BIT
>>> +     .max_pll_rate = 5000000000ULL,
>>> +#else
>>> +     .max_pll_rate = ULONG_MAX,
>>> +#endif
>>> +     .io_start = { 0x5e94400 },
>>> +     .num_dsi_phy = 1,
>>> +     .quirks = DSI_PHY_7NM_QUIRK_V4_1,
>>> +};
>>> +
>>>  const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs = {
>>>       .has_phy_lane = true,
>>>       .regulator_data = dsi_phy_7nm_36mA_regulators,
> 
> 
> 
