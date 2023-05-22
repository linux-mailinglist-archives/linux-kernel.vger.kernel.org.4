Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80470BFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjEVNrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEVNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:47:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD7AF1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:47:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3af4295ddso3622622e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684763238; x=1687355238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEm06L/7RszwTIxy7pZPEut/9V9YOp9nD/0czZj6vfg=;
        b=qspBx3gPki+B/6OIlBL+/7rh81kgid9ZjuEPUTdGBfHWkhsgiYeag/dvITBGiPSh1e
         CtHpklW80UGUb+vB9V86s3hKhhoJNxDxud2VmrA5IE88VG8UnnwzAX3kgoF7kkWBv9Jz
         8pLxhBA0imSQOkFB+FaM28GXUAqHo1KN9YY2C+fFsyJagKWtyU6uC/t1oPLjdyldwN3+
         h2WnRYyuExTMMhRhbmqMYkAORscjl6KXw0N5yaT+gDb2Lzx8NKVFeFv39ofDf7MaH//a
         zIHPG/1YnrNz1cz1QYsKp0PvTZ+hXwlJ+VGmmm6mFzIdmHQ75tNWr/8FQXKHGEeMWl0E
         gszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684763238; x=1687355238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEm06L/7RszwTIxy7pZPEut/9V9YOp9nD/0czZj6vfg=;
        b=hUdTdUSGRIoeECdw9fX/mRZXrh97rW9x1tidJB6hwcUnn4c/DKrJpZZqjmeua0XKtm
         r+faz1TSj4Z5em+GZkelhptnuobcTs8+scTEPx8OWr4OiQmmlyNp+eV2i/Tqf97OB2lB
         k0WWe7uOeKeeVreggYW5Mhb5u/ryngXJShWodf6OXM7+9FLbx723yXRhDtbMT73Vq097
         Ir0+xpMOUjbCTVw8rBPW9xe4Viq5MWV5WfumG+6BaYg0Q8FMDJKmJlnEmJ++d0aSS1Lr
         luedgFFSA36u0SR38qpZpnH/YGwHdUpr/xnvcLcJzqk4DQLiHOtv3Hl+lsH78/uaoa4S
         f4IA==
X-Gm-Message-State: AC+VfDwAPgeYP/RUqQHBImKgNsBz1ajr/kADzg+jhkRzniUnrN9NMHfz
        Vjncp6Q9ba0zvupbFMYhoAos9A==
X-Google-Smtp-Source: ACHHUZ554G38stoHAuoE6L5jFwpgLt44bq7oflbiqDD8iP07EyugQUr3QL7/ePqCIUhz7TIxfRodCA==
X-Received: by 2002:ac2:539a:0:b0:4cc:96f8:f9c6 with SMTP id g26-20020ac2539a000000b004cc96f8f9c6mr3451737lfh.5.1684763238295;
        Mon, 22 May 2023 06:47:18 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x14-20020ac259ce000000b004f13bd73419sm996412lfn.38.2023.05.22.06.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 06:47:17 -0700 (PDT)
Message-ID: <2e17e84d-aced-1f28-990f-689c8c56ce45@linaro.org>
Date:   Mon, 22 May 2023 16:47:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Visionox r66451 panel
Content-Language: en-GB
To:     neil.armstrong@linaro.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516-b4-r66451-panel-driver-v1-0-4210bcbb1649@quicinc.com>
 <20230516-b4-r66451-panel-driver-v1-2-4210bcbb1649@quicinc.com>
 <3cca2809-fa26-f0cf-2ccc-6737d150b43d@linaro.org>
 <69c6f4fe-4610-8301-b90b-03bcea7587b9@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <69c6f4fe-4610-8301-b90b-03bcea7587b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 12:10, Neil Armstrong wrote:
> On 18/05/2023 02:19, Dmitry Baryshkov wrote:
>> On 16/05/2023 23:20, Jessica Zhang wrote:
>>> Add support for the 1080x2340 Visionox R66451 AMOLED DSI panel that
>>> comes with the Qualcomm HDK8350 display expansion pack.
>>>
>>> The panel enables display compression (DSC v1.2) by default.
>>>
>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/panel/Kconfig                 |   8 +
>>>   drivers/gpu/drm/panel/Makefile                |   1 +
>>>   drivers/gpu/drm/panel/panel-visionox-r66451.c | 395 
>>> ++++++++++++++++++++++++++
>>>   3 files changed, 404 insertions(+)

[skipped]

>>> +
>>> +    ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>>> +    if (ret < 0) {
>>> +        dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +    msleep(120);
>>> +
>>> +    ret = mipi_dsi_dcs_set_display_on(dsi);
>>
>> Should the mipi_dsi_dcs_set_display_on() (and maybe exit sleep mode) 
>> be a a part of _enable()? Correspondingly _off should IMO be a part of 
>> _disable callback().
> 
> Nop, mipi_dsi_dcs_set_display_on() should be part of prepare, to be 
> called *before* the video stream starts, enable is called after in the 
> atomic modeset chain,

To summarize our discussion: some controllers do not support sending 
commands in non-LPM mode. Thus the panel driver should send all commands 
before the DSI host switches from LPM to VIDEO mode.

Is this corret?

> 
>>
>>> +    if (ret < 0) {
>>> +        dev_err(dev, "Failed on set display on: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +    msleep(20);
>>
>>
>> Do we need to add here the following line?
>>
>> dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>>
> 
> No, it will be changed by the DSI core.

Hmm, where?

> 
>>
>>> +
>>> +    return 0;
>>> +}

[skipped]

>>> +static int visionox_r66451_bl_update_status(struct backlight_device 
>>> *bl)
>>> +{
>>> +    struct mipi_dsi_device *dsi = bl_get_data(bl);
>>> +    u16 brightness = backlight_get_brightness(bl);
>>> +
>>> +    return mipi_dsi_dcs_set_display_brightness(dsi, 
>>> cpu_to_le16(brightness));
>>
>> mipi_dsi_dcs_set_display_brightness() already converts the brightness, 
>> so you don't need cpu_to_le16 here.
> 
> 
> The _large variant must be used instead.

But cpu_to_le16 is NOP, isn't it?

-- 
With best wishes
Dmitry

