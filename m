Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7182B716002
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjE3Mhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjE3MhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:37:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C06E6F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:36:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso3442440e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685450166; x=1688042166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HI7dbhgmaIMwW4q8f+hPLe/hTimoyZ6ymqMZWiieGkI=;
        b=UqrGq9WKdhCo/HIcRxyzdAw4ZOl4ja0Co5fqE+9gwfkW+zSE5dUNEZ3u18p9XfDCgj
         ZuTfNo+G5obqi3sITJEE58eRMPq0ARSWAKI3BgELGzoiPhBEPsrvCY7JA/YYQod9E6f3
         ja7T9Pp9JwPPLOara6vZBYQO2A3MSSEF46wKcIEa03p59Muajc+IyOsZHYaK6dUfyAm7
         Ffy2FgJFECnRKHSTI/TuvskxdSc8S9bO3BvRIo8oa+3fuxMWz4rgrjVy8Qv6Ii41gm4a
         dcy8lRyolO3rGNxlLJ6QdZU+zCVR5B2PofquG9KWfQkP0805rR3/PbNkRH3U+yRQMfs+
         zQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685450166; x=1688042166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI7dbhgmaIMwW4q8f+hPLe/hTimoyZ6ymqMZWiieGkI=;
        b=UWqf2CnuaRFx8K9iI7VHBBTUK3jarU7U3QvJnAgTzdiwxX3K83hNi8oyZd1mDV6ZO6
         rrfBaLThipxPl25HAwRd0O1Mpcyarxu4KOc6jLuVqKWp9J5+qE30Sb+GM4TzKUumPAO6
         AMFUMoAVkJNdu50t7sWoJMnXRzsxV4RLDCA5riRIpmwFS22g3JGYpvzU/NtZl3HmFbiG
         6oCGHgCluxX0dc4RCgYkqbkqyl0PuBs/xMzBnu/TfFfhIwI07+2gFpgN7YIUrbSBCggo
         mgOgIGylxdi12Kbp3jE2jWEDmIXcgTyw3xVBtARU6FtAJBoaNNicJgiyeI+/LqDhpM0S
         Yk6g==
X-Gm-Message-State: AC+VfDy7fY5gkvGn/JHP66NK2kcf5aPp2JXLtE/+CiXgit0ubl3ChVqo
        xT7/M2vos7GYwWf+9gZl6UZfNQ==
X-Google-Smtp-Source: ACHHUZ6wyWffrbLJXvu1TzBoYTsLShwlS92A6RywQVWSBg/DxQvTW7DGXSWynROQFTS4NcPM3NQLuA==
X-Received: by 2002:ac2:4c27:0:b0:4f2:53f6:d4bf with SMTP id u7-20020ac24c27000000b004f253f6d4bfmr655196lfq.48.1685450165873;
        Tue, 30 May 2023 05:36:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l9-20020ac24309000000b004f3b520e0adsm329680lfh.107.2023.05.30.05.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 05:36:05 -0700 (PDT)
Message-ID: <e927cfcd-bf34-5daf-0e24-4dd828106968@linaro.org>
Date:   Tue, 30 May 2023 15:36:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RFC: DSI host capabilities (was: [PATCH RFC 03/10] drm/panel: Add
 LGD panel driver for Sony Xperia XZ3)
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
 <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org>
 <CAA8EJppG=MAVpK1J_8bNnkJ23y9NtgY7a2GVResXJvhEKyNsrw@mail.gmail.com>
 <739a8bd9-9ff0-5072-fdae-b64efdf86842@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <739a8bd9-9ff0-5072-fdae-b64efdf86842@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 15:15, AngeloGioacchino Del Regno wrote:
> Il 30/05/23 13:44, Dmitry Baryshkov ha scritto:
>> On Tue, 30 May 2023 at 10:24, Neil Armstrong 
>> <neil.armstrong@linaro.org> wrote:
>>>
>>> Hi Marijn, Dmitry, Caleb, Jessica,
>>>
>>> On 29/05/2023 23:11, Marijn Suijten wrote:
>>>> On 2023-05-22 04:16:20, Dmitry Baryshkov wrote:
>>>> <snip>
>>>>>> +   if (ctx->dsi->dsc) {
>>>>>
>>>>> dsi->dsc is always set, thus this condition can be dropped.
>>>>
>>>> I want to leave room for possibly running the panel without DSC (at a
>>>> lower resolution/refresh rate, or at higher power consumption if there
>>>> is enough BW) by not assigning the pointer, if we get access to panel
>>>> documentation: probably one of the magic commands sent in this driver
>>>> controls it but we don't know which.
>>>
>>> I'd like to investigate if DSC should perhaps only be enabled if we
>>> run non certain platforms/socs ?
>>>
>>> I mean, we don't know if the controller supports DSC and those 
>>> particular
>>> DSC parameters so we should probably start adding something like :
>>>
>>> static drm_dsc_config dsc_params_qcom = {}
>>>
>>> static const struct of_device_id panel_of_dsc_params[] = {
>>>          { .compatible = "qcom,sm8150", , .data = &dsc_params_qcom },
>>>          { .compatible = "qcom,sm8250", , .data = &dsc_params_qcom },
>>>          { .compatible = "qcom,sm8350", , .data = &dsc_params_qcom },
>>>          { .compatible = "qcom,sm8450", , .data = &dsc_params_qcom },
>>> };
>>
>> I think this would damage the reusability of the drivers. The panel
>> driver does not actually care if the SoC is SM8350, sunxi-something or
>> RCar.
>> Instead it cares about host capabilities.
>>
>> I think instead we should extend mipi_dsi_host:
>>
>> #define MIPI_DSI_HOST_MODE_VIDEO BIT(0)
>> #define MIPI_DSI_HOST_MODE_CMD  BIT(1)
>> #define MIPI_DSI_HOST_VIDEO_SUPPORTS_COMMANDS BIT(2)
>> // FIXME: do we need to provide additional caps here ?
>>
>> #define MIPI_DSI_DSC_1_1 BIT(0)
>> #define MIPI_DSI_DSC_1_2 BIT(1)
>> #define MIPI_DSI_DSC_NATIVE_422 BIT(2)
>> #define MIPI_DSI_DSC_NATIVE_420 BIT(3)
>> #define MIPI_DSI_DSC_FRAC_BPP BIT(4)
>> // etc.
>>
>> struct mipi_dsi_host {
>>   // new fields only
>>    unsigned long mode_flags;
>>    unsigned long dsc_flags;
>> };
>>
>> Then the panel driver can adapt itself to the host capabilities and
>> (possibly) select one of the internally supported DSC profiles.
>>
> 
> I completely agree about extending mipi_dsi_host, other SoCs could reuse 
> that and
> support for DSC panels would become a lot cleaner.

Sounds good. I will wait for one or two more days (to get the possible 
feedback on fields/flags/etc) and post an RFC patch to dri-devel.

> 
> For example, on MediaTek DRM there's some support for DSC, more or less 
> the same
> for SPRD DRM and some DSI bridge drivers... having a clean 
> infrastructure would
> definitely help.
> 
> I'm sad I cannot offer testing in that case because despite being sure 
> that there
> are MTK smartphones around with DSI panels using DSC, I have none... and 
> all of the
> Chromebooks are not using DSC anyway (but using DisplayPort compression, 
> which is
> obviously an entirely different beast).
> 
>>>
>>> ...
>>> static int sony_akatsuki_lgd_probe(struct mipi_dsi_device *dsi)
>>> ...
>>>          const struct of_device_id *match;
>>>
>>> ...
>>>          match = of_match_node(panel_of_dsc_params, of_root);
>>>          if (match && match->data) {
>>>                  dsi->dsc = devm_kzalloc(&dsi->dev, sizeof(*dsc), 
>>> GFP_KERNEL);
>>>                  memcpy(dsi->dsc, match->data, sizeof(*dsc));
>>>          } else {
>>>                  dev_warn(&dsi->dev, "DSI controller is not marked as 
>>> supporting DSC\n");
>>>          }
>>> ...
>>> }
>>>
>>> and probably bail out if it's a DSC only panel.
>>>
> 
> Usually DDICs support both DSC and non-DSC modes, depending on the initial
> programming (read: init commands)... but the usual issue is that many DDICs
> are not publicly documented for reasons, so yes, bailing out if DSC is not
> supported would be the only option, and would be fine at this point.
> 
> Cheers,
> Angelo
> 
>>> We could alternatively match on the DSI controller's dsi->host->dev 
>>> instead of the SoC root compatible.
>>>
>>> Neil
>>
> 

-- 
With best wishes
Dmitry

