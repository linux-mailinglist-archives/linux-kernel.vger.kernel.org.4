Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2E748526
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjGENiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjGENiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:38:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4FBA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:38:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so9769821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688564279; x=1691156279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsrVgZLidtXiSJl+QeeYUBwc0NDQGXHckKC4/BV4xqA=;
        b=bbxpbYFtL8FsxMc3aOYSlPR+clD+JP0/dQYNr7FE7FNyAa0XEk6lAm0fcPvJdx2a6K
         7usRvsPdOvEp1P1dkSfmp3UQNu8zClEgXEVoZBls6q9zi1+PEWf9EadOCiyx0UShVEEB
         9w8LZzSop7seDg2MnfLfy4C9hLvY0L7AemvVJgMESwMMt2hAhwv5HT3lbdjsHfxW76K2
         jl7cv74N1nh0X2ug14rRy+SNWRQ6GlTaOzThwM9d/87OYUIzlpd5fCUxNOU8OHYXNu9O
         a262fMo8A9mQeUcD/5vQ1AhfgCgYFdBcNXkFNHYkPqJq94tZ0kXyF/78KVT51UA6OaaH
         Vw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564279; x=1691156279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsrVgZLidtXiSJl+QeeYUBwc0NDQGXHckKC4/BV4xqA=;
        b=Xj327sIYZc/F0WFl3QTp94m5p0Xn0QrgN5Rumao/WBCNnuM3IxiKp8/NVHx4crZ9MH
         ckgEBoYHRGmrqDHoWGmMZgwiYnptM8VffQavLWMIEKazDLjwrFgdDtA1tJjdUuNTr+RD
         8iK7ipGfToh53nU1GItEVIgn9HbKlkTKwvB0sp0/whMJivhjuC7xqYy0t9N00FMhuDI0
         0YDWT4quODiwh1x5jK1wheoDU/I3+OsI5MuO3tRbSO+iOF3xeoYHBK7/QGuuEETW1a+7
         7qB25xcRTxOrwPPcYJjGSYU4BhSoyvOMOFyzk7UunTVpOZxvRWlwV3WVF8NfPNaUNCq3
         0tAg==
X-Gm-Message-State: ABy/qLZZsqoFMe4iLRmkInpzFeyO8qF4vIGsEgMilW9bfPJjNG7+rRSm
        wY3qjxid2nK44BhNd0o0UrYSjA==
X-Google-Smtp-Source: APBJJlF5U/tPgy7TnTyP8b3T4J2uBhyYdvFNzZkSSUM3078KaGv3mUcvpD9rtCs74AguVdgdpgqMVw==
X-Received: by 2002:a2e:aa13:0:b0:2b6:f942:ad50 with SMTP id bf19-20020a2eaa13000000b002b6f942ad50mr911716ljb.11.1688564278758;
        Wed, 05 Jul 2023 06:37:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e9201000000b002b6ed0067c9sm1434275ljg.116.2023.07.05.06.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 06:37:58 -0700 (PDT)
Message-ID: <6e070141-8c0e-59ed-8a08-58c3fadb17df@linaro.org>
Date:   Wed, 5 Jul 2023 16:37:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: RFC: DSI host capabilities (was: [PATCH RFC 03/10] drm/panel: Add
 LGD panel driver for Sony Xperia XZ3)
Content-Language: en-GB
To:     Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
 <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org>
 <CAA8EJppG=MAVpK1J_8bNnkJ23y9NtgY7a2GVResXJvhEKyNsrw@mail.gmail.com>
 <739a8bd9-9ff0-5072-fdae-b64efdf86842@collabora.com>
 <e927cfcd-bf34-5daf-0e24-4dd828106968@linaro.org>
 <epds77sccy4cc5cdpoc4ir7sfz5sz3biwep6rbks2nuyqncidu@77gb4t2wy6vn>
 <47a5678c-1eb3-dfc2-a9ac-f8e497455d11@linaro.org>
 <unsithzszj7awvsmxwr7reshso5ju7u4nssil5tty6pocictf5@gwoltpgeecer>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <unsithzszj7awvsmxwr7reshso5ju7u4nssil5tty6pocictf5@gwoltpgeecer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 16:29, Maxime Ripard wrote:
> On Wed, Jul 05, 2023 at 03:05:33PM +0200, Neil Armstrong wrote:
>> On 05/07/2023 14:04, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Tue, May 30, 2023 at 03:36:04PM +0300, Dmitry Baryshkov wrote:
>>>> On 30/05/2023 15:15, AngeloGioacchino Del Regno wrote:
>>>>> Il 30/05/23 13:44, Dmitry Baryshkov ha scritto:
>>>>>> On Tue, 30 May 2023 at 10:24, Neil Armstrong
>>>>>> <neil.armstrong@linaro.org> wrote:
>>>>>>>
>>>>>>> Hi Marijn, Dmitry, Caleb, Jessica,
>>>>>>>
>>>>>>> On 29/05/2023 23:11, Marijn Suijten wrote:
>>>>>>>> On 2023-05-22 04:16:20, Dmitry Baryshkov wrote:
>>>>>>>> <snip>
>>>>>>>>>> +   if (ctx->dsi->dsc) {
>>>>>>>>>
>>>>>>>>> dsi->dsc is always set, thus this condition can be dropped.
>>>>>>>>
>>>>>>>> I want to leave room for possibly running the panel without DSC (at a
>>>>>>>> lower resolution/refresh rate, or at higher power consumption if there
>>>>>>>> is enough BW) by not assigning the pointer, if we get access to panel
>>>>>>>> documentation: probably one of the magic commands sent in this driver
>>>>>>>> controls it but we don't know which.
>>>>>>>
>>>>>>> I'd like to investigate if DSC should perhaps only be enabled if we
>>>>>>> run non certain platforms/socs ?
>>>>>>>
>>>>>>> I mean, we don't know if the controller supports DSC and those
>>>>>>> particular
>>>>>>> DSC parameters so we should probably start adding something like :
>>>>>>>
>>>>>>> static drm_dsc_config dsc_params_qcom = {}
>>>>>>>
>>>>>>> static const struct of_device_id panel_of_dsc_params[] = {
>>>>>>>            { .compatible = "qcom,sm8150", , .data = &dsc_params_qcom },
>>>>>>>            { .compatible = "qcom,sm8250", , .data = &dsc_params_qcom },
>>>>>>>            { .compatible = "qcom,sm8350", , .data = &dsc_params_qcom },
>>>>>>>            { .compatible = "qcom,sm8450", , .data = &dsc_params_qcom },
>>>>>>> };
>>>>>>
>>>>>> I think this would damage the reusability of the drivers. The panel
>>>>>> driver does not actually care if the SoC is SM8350, sunxi-something or
>>>>>> RCar.
>>>>>> Instead it cares about host capabilities.
>>>>>>
>>>>>> I think instead we should extend mipi_dsi_host:
>>>>>>
>>>>>> #define MIPI_DSI_HOST_MODE_VIDEO BIT(0)
>>>>>> #define MIPI_DSI_HOST_MODE_CMD  BIT(1)
>>>>>> #define MIPI_DSI_HOST_VIDEO_SUPPORTS_COMMANDS BIT(2)
>>>>>> // FIXME: do we need to provide additional caps here ?
>>>>>>
>>>>>> #define MIPI_DSI_DSC_1_1 BIT(0)
>>>>>> #define MIPI_DSI_DSC_1_2 BIT(1)
>>>>>> #define MIPI_DSI_DSC_NATIVE_422 BIT(2)
>>>>>> #define MIPI_DSI_DSC_NATIVE_420 BIT(3)
>>>>>> #define MIPI_DSI_DSC_FRAC_BPP BIT(4)
>>>>>> // etc.
>>>>>>
>>>>>> struct mipi_dsi_host {
>>>>>>     // new fields only
>>>>>>      unsigned long mode_flags;
>>>>>>      unsigned long dsc_flags;
>>>>>> };
>>>>>>
>>>>>> Then the panel driver can adapt itself to the host capabilities and
>>>>>> (possibly) select one of the internally supported DSC profiles.
>>>>>>
>>>>>
>>>>> I completely agree about extending mipi_dsi_host, other SoCs could reuse
>>>>> that and
>>>>> support for DSC panels would become a lot cleaner.
>>>>
>>>> Sounds good. I will wait for one or two more days (to get the possible
>>>> feedback on fields/flags/etc) and post an RFC patch to dri-devel.
>>>
>>> I just came across that discussion, and couldn't find those patches, did
>>> you ever send them?

No, I got sidetracked by other issues.

>>>
>>> Either way, I'm not really sure it's a good idea to multiply the
>>> capabilities flags of the DSI host, and we should just stick to the
>>> spec. If the spec says that we have to support DSC while video is
>>> output, then that's what the panels should expect.
>>
>> Except some panels supports DSC & non-DSC, Video and Command mode, and
>> all that is runtime configurable. How do you handle that ?
> 
> In this case, most of the constraints are going to be on the encoder
> still so it should be the one driving it. The panel will only care about
> which mode has been selected, but it shouldn't be the one driving it,
> and thus we still don't really need to expose the host capabilities.

This is an interesting perspective. This means that we can and actually 
have to extend the drm_display_mode with the DSI data and compression 
information.

For example, the panel that supports all four types for the 1080p should 
export several modes:

1920x1080-command
1920x1080-command-DSC
1920x1080-video
1920x1080-video-DSC

where video/command and DSC are some kinds of flags and/or information 
in the drm_display_mode? Ideally DSC also has several sub-flags, which 
denote what kind of configuration is supported by the DSC sink (e.g. 
bpp, yuv, etc).

Another option would be to get this handled via the bus format 
negotiation, but that sounds like worse idea to me.

> This is very much like HDMI: the encoder knows what the monitor is
> capable of, will take a decision based on its capabilities and the
> monitor's and will then let the monitor know. But the monitor never
> knows what the encoder is truly capable of, nor will it enforce
> something.
> 
> Maxime

-- 
With best wishes
Dmitry

