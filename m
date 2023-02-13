Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3EE6940C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBMJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBMJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:20:38 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824A014E80
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:20:28 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gr7so30167476ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDDFIIaWpsZFTDw2O2h1MSF5xYK1K+uCRehpNOjoeqk=;
        b=FHFpfsiPbhIgCXBr+ScZv5ioWHMLabZ2mqshJoSdHtBmHlTHvuOzh8SX4kMAYjhVdG
         4B7U3Jj9b8/3oBQVdkXTjGDFX8B3dES2oLbNfl64VEUiptP87Qy8vrW9M+XPsD1AiWIL
         VJOE02A6upy4Z0hCu2lbEcr+qRAJTuLhzYRAEwYPIkY+vOhrenoV3c4I6z9DNtyglWrJ
         fbf4DMr56oLQPp8vQ0D6ik+O1Z84xiqSmlBDeH1ouT6bGYy+SJSwbDuXZif5i9/Et8h2
         XT238gi28rPOW3Bvfb2P73pWXHBC1Ns2owY5knelZE9ZrA0WQSfD34sTETnhTJLIqdC3
         mcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDDFIIaWpsZFTDw2O2h1MSF5xYK1K+uCRehpNOjoeqk=;
        b=UdeXjUCEX8sMB7q4K4YtwRLFOjs59U1JHZeUyqJK5RHxApLVAo3SGe84wdIjpSfl6K
         EpUk2ppwJtlJiqOW/2exIEckyroSGeMVsi/gtfWBqmk1Z5GJn0MslvSywwXt6A4KP+jU
         /Ozz036o4kAWff+OGKQ91vH3ZmsuNKzTonA8k979/XFEK+NEBG4M/9bsSdSA1S0wvpfJ
         508H85JQX1LpVMJKsEZGBzN1GWmRXlg0Mclvl/yp5z6/UL8tz9qrrE04hlcgZ1Jwx5lK
         KFU/E4l7eau7LEoku4cccpdiaT/SNAZB9FRi/KPPMrcs6nGl3zXJATut5aSK6UBD6MNi
         Nl6g==
X-Gm-Message-State: AO0yUKVsDZLgQ4WHr2EedIW9jydSiudiOxAt2rTJtyCponF6zBZX4/OY
        tApCQP0FD+zZ8HvOc3m7jorlTg==
X-Google-Smtp-Source: AK7set95W8Ex46Zp9yW4bB2QEUdCsOwQWxTpEQYhsmAxdLhzAedmHI3UnPG28wRmrWObyph1Swvifg==
X-Received: by 2002:a17:907:c21:b0:8af:514f:1078 with SMTP id ga33-20020a1709070c2100b008af514f1078mr13187786ejc.31.1676280027099;
        Mon, 13 Feb 2023 01:20:27 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906b00100b0087862f45a29sm6524747ejy.174.2023.02.13.01.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:20:26 -0800 (PST)
Message-ID: <db1d04ed-1841-5bcc-2611-84aa8fcec682@linaro.org>
Date:   Mon, 13 Feb 2023 10:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/10] drm/msm/dsi: dsi_cfg: Merge SC7180 config into
 SDM845
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
 <20230211115110.1462920-7-konrad.dybcio@linaro.org>
 <d8d13ded-9f37-e96a-e34f-4e885fd15c0d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d8d13ded-9f37-e96a-e34f-4e885fd15c0d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.02.2023 16:52, Dmitry Baryshkov wrote:
> On 11/02/2023 13:51, Konrad Dybcio wrote:
>> The configs are identical, other than the number of *maximum* DSI
>> hosts allowed. This isn't an issue, unless somebody deliberately
>> tries to access the inexistent host by adding a dt node for it.
>>
>> Remove the SC7180 struct and point the hw revision match to the
>> SDM845's one. On a note, this could have been done back when
>> 7180 support was introduced.
>>
>> Fixes: 6125bd327e16 ("drm/msm: add DSI support for sc7180")
> 
> Same comment regarding Fixes
Ack.

Konrad
> 
> Other than that:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 15 ++-------------
>>   1 file changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> index 860681bfc084..142a0f1e2576 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> @@ -169,7 +169,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
>>       .bus_clk_names = dsi_v2_4_clk_names,
>>       .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>       .io_start = {
>> -        { 0xae94000, 0xae96000, 0 },
>> +        { 0xae94000, 0xae96000, 0 }, /* SDM845 / SDM670 / SC7180 */
>>       },
>>   };
>>   @@ -188,17 +188,6 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>>       },
>>   };
>>   -static const struct msm_dsi_config sc7180_dsi_cfg = {
>> -    .io_offset = DSI_6G_REG_SHIFT,
>> -    .regulator_data = dsi_v2_4_regulators,
>> -    .num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
>> -    .bus_clk_names = dsi_v2_4_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>> -    .io_start = {
>> -        { 0xae94000, 0 },
>> -    },
>> -};
>> -
>>   static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
>>       { .supply = "vdda", .init_load_uA = 8350 },    /* 1.2 V */
>>   };
>> @@ -299,7 +288,7 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>>       {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_0,
>>           &sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>>       {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_1,
>> -        &sc7180_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>> +        &sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>>       {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_5_0,
>>           &sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>>       {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_6_0,
> 
