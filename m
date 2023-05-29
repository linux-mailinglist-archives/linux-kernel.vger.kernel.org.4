Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2997151F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjE2WjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2WjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:39:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39074AB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:39:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af2696fd1cso39397121fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685399951; x=1687991951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Xub4E75y8Nyr5XajoijONWb7PnUiTj5szgyWiuoPJQ=;
        b=MneeusNPF5NlydCsdbfh/dap+ohfCB4fgHdqa2BiNfYpPkKSUL6R7YM/Y4tXnpktFG
         e9Dwm0RCk1+uJPcmzdXjzFsAa6CK4T2GYqX35VNV5Xs2qMkOyOIPQUoHY7Umj9oSIkda
         LpcsZQEAcC0OQBp3IoT0ssriIOY9SiQu7X2dFxsNWFMpf68LONBDstH9WlY7rnGHWPiM
         IQJ4vUgwdOqc+VPpm9CY4yol+rr4G1PmDpG6sXCCdvyCNG0O0U/qo3qIUsM7BsTqExdl
         lCDBUDOFvlOZKHfkoupjfALiOTsHqOxHMU2m5g3jsKaPxmL50s7B8MRrFT7gJ57n3cKf
         w2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685399951; x=1687991951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xub4E75y8Nyr5XajoijONWb7PnUiTj5szgyWiuoPJQ=;
        b=Voa4gygQlsYkSxaCzg1AbpTlHMjXEScmvp9xqu4hjQgx1TSB+vA8vgLtMR82BCJefM
         8+ViYp+pGzq5SIaICZVnmfJcXGIPv84VncevU2iID5SbuAHzZmAD6iaTuiLIODrEQGhG
         vKgg9A+GfZBvEleZHVt3hEmurEQGHgk1i2uzp1B3/pGspFHML3H7g6yA0CsJffofdfrq
         1+NjK6TuW2RmIlJaUGM21RwudSliEVrfTmz4umzlImHuWSJR6rQSHUq5CknPmeiR3rNp
         yCeP+wakS/la5hZ3PqiQz+ER2MTF+7bUQMHvPp+Sh2zHAbAroWR0wpo9sfjbs6PUI4wM
         Odmg==
X-Gm-Message-State: AC+VfDxjfZdHWa/yw5fQLmRfTbbD0a7gyC/xTfm3zpIgcb66fi0OutyC
        PL5c9TLJfLTAklOUHTLzQ5KS9Q==
X-Google-Smtp-Source: ACHHUZ4An8N93KNttIkDEg95kOa0os1fM8bISo57wWgd27lbpv8dT/gg0gviUKDQnepBfNN1PxN0cQ==
X-Received: by 2002:a05:6512:247:b0:4e9:9e45:3470 with SMTP id b7-20020a056512024700b004e99e453470mr36318lfo.3.1685399951314;
        Mon, 29 May 2023 15:39:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j28-20020ac2551c000000b004f27cf63a03sm128312lfk.299.2023.05.29.15.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 15:39:10 -0700 (PDT)
Message-ID: <d52b384f-9853-3921-d4f2-5aedb7ef4c61@linaro.org>
Date:   Tue, 30 May 2023 01:39:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony Xperia
 XZ3
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     neil.armstrong@linaro.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <71675a02-0801-62dc-2673-4a0907636b21@linaro.org>
 <CAA8EJpq=HZqiBZ6bpUNH47VmASuH+Mi5OD5BHmg0TPwtsKHf8w@mail.gmail.com>
 <oxgtbj7qmsdvz5gl4bud64jedmhdmvphjfge7uy6uwulefqfsa@pleslv2zgwbp>
 <ebc3ff33-6e4f-b107-33c6-f35b03307058@linaro.org>
 <v3ac2ihqjce7vxcsjnm7ett2vc6wb4hb3bb6x4widd55eintw7@fgkyipbbl2ei>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <v3ac2ihqjce7vxcsjnm7ett2vc6wb4hb3bb6x4widd55eintw7@fgkyipbbl2ei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 01:37, Marijn Suijten wrote:
> On 2023-05-30 01:18:40, Dmitry Baryshkov wrote:
> <snip>
>>>>>>> +    ret = mipi_dsi_dcs_set_display_on(dsi);
>>>>>>> +    if (ret < 0) {
>>>>>>> +        dev_err(dev, "Failed to turn display on: %d\n", ret);
>>>>>>> +        return ret;
>>>>>>> +    }
>>>>>>
>>>>>> My usual question: should the mipi_dsi_dcs_exit_sleep_mode() / mipi_dsi_dcs_set_display_on() be moved from prepare() to enable() part?
>>>>>
>>>>>
>>>>> No, prepare is called before the video stream is started and when display is still in LPM mode and the mode hasn't been set.
>>>>>
>>>>
>>>> Yes, that's my point. Shouldn't we enable the panel _after_ starting the stream?
>>>
>>> I have never investigated what it takes to split these functions, but
>>> some of these panels do show some corruption at startup which may be
>>> circumvented by powering the panel on after starting the video stream?
>>>
>>> I'm just not sure where to make the split: downstream does describe a
>>> qcom,mdss-dsi-on-command and qcom,mdss-dsi-post-panel-on-command, where
>>> the latter only contains set_display_on() (not exit_sleep_mode()).
>>> It is documented like:
>>>
>>>       same as "qcom,mdss-dsi-on-command" except commands are sent after
>>>       displaying an image."
>>>
>>> So this seems like the right way to split them up, I'll test this out on
>>> all submitted panel drivers.
>>
>> Interesting enough, Neil suggested that sending all the commands during
>> pre_enable() is the correct sequence (especially for VIDEO mode panels),
>> since not all DSI hosts can send commands after switching to the VIDEO mode.
> 
> Note that all these panels and Driver-ICs are command-mode, and/or
> programmed to run in command-mode, so there shouldn't be any notion of a
> VIDEO stream (any command-mode frame is just an "arbitrary command" as
> far as I understood).

Yes, from the data stream point of view. I was talking about the DSI 
host being able to send arbitrary commands or not after enabling the 
video/cmd stream.

> 
> - Marijn

-- 
With best wishes
Dmitry

