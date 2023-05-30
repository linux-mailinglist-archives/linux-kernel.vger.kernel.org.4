Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426FF71717A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjE3XRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjE3XRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:17:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FC10E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:16:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3b9755961so5719534e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685488612; x=1688080612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHug+pro+MudY8ybS89ytrVKoFyLIO/xxLOjL/J5B4s=;
        b=fgn3hn4lkIINQIXKMizqRgo170331xYzH2+DVvgmQGdwBas6TztlaAQuDCEhuF+D8f
         5Z98EekG+maUBzB65LKaK43z/9oEORo5Iksu5Fwypow/Ss/wsUnZZC+xjM187ojn5mWp
         89t4Etr2oXJ+Vx5+KZhJ49iya5SkYq2aPs60kl730tFjt+cLafG5gcLaJ6b6aHszXev7
         cdVUPHMdY3swZiff0Mt/neMyVcwbHVO0RVkNYYNHKJGm4cy2fxrHsDHKpXWM6ey3aBz8
         pTV8qe/bBNE1MC4kdXSsMi7JBIfDbmHiC4gyJ7epIb/AoMTolIrOEHd7d7gV34CJQeT+
         aGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488612; x=1688080612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHug+pro+MudY8ybS89ytrVKoFyLIO/xxLOjL/J5B4s=;
        b=Be7R3s7Vl6msJArVcMOLAaYM+A2cfg6eS8vubjq7Ufq6C2hW7V0ei87XTRBFb07Kao
         fZU3PJxgJ66pQguGKE/n2OnL5SOJ69W/DGoFJ5fzorCM/qcuLbgf3JJ5ZOMxSerk7Mtx
         9Xw7rKPoiylwX+KpqvUURUoF4AQ5ARbWOHhpLScc2ehDrqUc4BAgKE7UVrOTxjjJDgY+
         94kfQCRnBR6qu+zW4JjGas+gcaPdVo3Tkzi38pk2fOnmnh4VR4i9qFgLOP+LM9f0ubTh
         iezTs1hK6g4aAekJWFZeU7CJhRId8214UU6aZPZlCLp8zkTCeNuS9rYr8R9V1dsjOJib
         zExA==
X-Gm-Message-State: AC+VfDwTK0U814FWXu6Mh6A7QqfLXDfFrsLNHRH/8zPyGdcEmX3IjwR6
        idfD/MSnlWsrXPt5QczZGTvszQ==
X-Google-Smtp-Source: ACHHUZ5xyrcXeeDP9jMscfXBEp/Zc/l5dNv5cR6pkFdXzTeUTTZdd0KKzKASP8m6HURxobv2ZQyP4Q==
X-Received: by 2002:ac2:4c8c:0:b0:4f2:5338:d0a8 with SMTP id d12-20020ac24c8c000000b004f25338d0a8mr1786464lfl.56.1685488612235;
        Tue, 30 May 2023 16:16:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w13-20020ac254ad000000b004eeec1261ecsm482940lfk.31.2023.05.30.16.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 16:16:51 -0700 (PDT)
Message-ID: <1160ec55-2ce3-cc0e-3b59-5fec1f1e5809@linaro.org>
Date:   Wed, 31 May 2023 02:16:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony Xperia
 XZ3
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <71675a02-0801-62dc-2673-4a0907636b21@linaro.org>
 <CAA8EJpq=HZqiBZ6bpUNH47VmASuH+Mi5OD5BHmg0TPwtsKHf8w@mail.gmail.com>
 <oxgtbj7qmsdvz5gl4bud64jedmhdmvphjfge7uy6uwulefqfsa@pleslv2zgwbp>
 <ebc3ff33-6e4f-b107-33c6-f35b03307058@linaro.org>
 <00d30c09-d622-11c1-2e07-44a798659982@quicinc.com>
 <2zwamlkhtcuu3c7lithcipb3h46gjg7zsefnhdinmsjwkjxrcc@jbj7ak2mdgeu>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2zwamlkhtcuu3c7lithcipb3h46gjg7zsefnhdinmsjwkjxrcc@jbj7ak2mdgeu>
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

On 30/05/2023 21:13, Marijn Suijten wrote:
> On 2023-05-30 10:54:17, Abhinav Kumar wrote:
>>> On 30/05/2023 00:07, Marijn Suijten wrote:
>>>> On 2023-05-22 15:58:56, Dmitry Baryshkov wrote:
>>>>> On Mon, 22 May 2023 at 12:04, Neil Armstrong
>>>>> <neil.armstrong@linaro.org> wrote:
>>>>>>
>>>>>> On 22/05/2023 03:16, Dmitry Baryshkov wrote:
>>>>>>> On 22/05/2023 00:23, Marijn Suijten wrote:
>>>>>>>> Sony provides an unlabeled LGD + Atmel maXTouch assembly in its
>>>>>>>> Xperia
>>>>>>>> XZ3 (tama akatsuki) phone, with custom DCS commands to match.
>>>>>>>>
>>>>>>>> This panel features Display Stream Compression 1.1.
>>>>>>>>
>>>>>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/panel/Kconfig                   |  11 +
>>>>>>>>     drivers/gpu/drm/panel/Makefile                  |   1 +
>>>>>>>>     drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c | 362
>>>>>>>> ++++++++++++++++++++++++
>>>>>>>>     3 files changed, 374 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/panel/Kconfig
>>>>>>>> b/drivers/gpu/drm/panel/Kconfig
>>>>>>>> index 67ef898d133f2..18bd116e78a71 100644
>>>>>>>> --- a/drivers/gpu/drm/panel/Kconfig
>>>>>>>> +++ b/drivers/gpu/drm/panel/Kconfig
>>>>>>>> @@ -706,6 +706,17 @@ config DRM_PANEL_SONY_ACX565AKM
>>>>>>>>           Say Y here if you want to enable support for the Sony
>>>>>>>> ACX565AKM
>>>>>>>>           800x600 3.5" panel (found on the Nokia N900).
>>>>>>>> +config DRM_PANEL_SONY_AKATSUKI_LGD
>>>>>>>> +    tristate "Sony Xperia XZ3 LGD panel"
>>>>>>>> +    depends on GPIOLIB && OF
>>>>>>>> +    depends on DRM_MIPI_DSI
>>>>>>>> +    depends on BACKLIGHT_CLASS_DEVICE
>>>>>>>> +    help
>>>>>>>> +      Say Y here if you want to enable support for the Sony
>>>>>>>> Xperia XZ3
>>>>>>>> +      1440x2880@60 6.0" OLED DSI cmd mode panel produced by LG
>>>>>>>> Display.
>>>>>>>> +
>>>>>>>> +      This panel uses Display Stream Compression 1.1.
>>>>>>>> +
>>>>>>>>     config DRM_PANEL_SONY_TD4353_JDI
>>>>>>>>         tristate "Sony TD4353 JDI panel"
>>>>>>>>         depends on GPIOLIB && OF
>>>>>>>> diff --git a/drivers/gpu/drm/panel/Makefile
>>>>>>>> b/drivers/gpu/drm/panel/Makefile
>>>>>>>> index ff169781e82d7..85133f73558f3 100644
>>>>>>>> --- a/drivers/gpu/drm/panel/Makefile
>>>>>>>> +++ b/drivers/gpu/drm/panel/Makefile
>>>>>>>> @@ -71,6 +71,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) +=
>>>>>>>> panel-sitronix-st7701.o
>>>>>>>>     obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
>>>>>>>>     obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) +=
>>>>>>>> panel-sitronix-st7789v.o
>>>>>>>>     obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
>>>>>>>> +obj-$(CONFIG_DRM_PANEL_SONY_AKATSUKI_LGD) +=
>>>>>>>> panel-sony-akatsuki-lgd.o
>>>>>>>>     obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) += panel-sony-td4353-jdi.o
>>>>>>>>     obj-$(CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521) +=
>>>>>>>> panel-sony-tulip-truly-nt35521.o
>>>>>>>>     obj-$(CONFIG_DRM_PANEL_TDO_TL070WSH30) += panel-tdo-tl070wsh30.o
>>>>>>>> diff --git a/drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c
>>>>>>>> b/drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000000000..f55788f963dab
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c
>>>>>>>> @@ -0,0 +1,362 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>>>> +/*
>>>>>>>> + * Copyright (c) 2023 Marijn Suijten <marijn.suijten@somainline.org>
>>>>>>>> + *
>>>>>>>> + * Based on Sony Downstream's "Atmel LGD ID5" Akatsuki panel dtsi.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <linux/backlight.h>
>>>>>>>> +#include <linux/delay.h>
>>>>>>>> +#include <linux/gpio/consumer.h>
>>>>>>>> +#include <linux/module.h>
>>>>>>>> +#include <linux/of.h>
>>>>>>>> +#include <linux/of_device.h>
>>>>>>>> +#include <linux/regulator/consumer.h>
>>>>>>>> +
>>>>>>>> +#include <video/mipi_display.h>
>>>>>>>> +
>>>>>>>> +#include <drm/drm_mipi_dsi.h>
>>>>>>>> +#include <drm/drm_modes.h>
>>>>>>>> +#include <drm/drm_panel.h>
>>>>>>>> +#include <drm/drm_probe_helper.h>
>>>>>>>> +#include <drm/display/drm_dsc.h>
>>>>>>>> +#include <drm/display/drm_dsc_helper.h>
>>>>>>>> +
>>>>>>>> +struct sony_akatsuki_lgd {
>>>>>>>> +    struct drm_panel panel;
>>>>>>>> +    struct mipi_dsi_device *dsi;
>>>>>>>> +    struct regulator *vddio;
>>>>>>>> +    struct gpio_desc *reset_gpio;
>>>>>>>> +    bool prepared;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static inline struct sony_akatsuki_lgd
>>>>>>>> *to_sony_akatsuki_lgd(struct drm_panel *panel)
>>>>>>>> +{
>>>>>>>> +    return container_of(panel, struct sony_akatsuki_lgd, panel);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int sony_akatsuki_lgd_on(struct sony_akatsuki_lgd *ctx)
>>>>>>>> +{
>>>>>>>> +    struct mipi_dsi_device *dsi = ctx->dsi;
>>>>>>>> +    struct device *dev = &dsi->dev;
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>>>>>>>> +
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0x7f, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf1, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf2, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0x02, 0x01);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0x59, 0x01);
>>>>>>>> +    /* Enable backlight control */
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
>>>>>>>> BIT(5));
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0x57, 0x20, 0x80, 0xde, 0x60, 0x00);
>>>>>>>> +
>>>>>>>> +    ret = mipi_dsi_dcs_set_column_address(dsi, 0, 1440 - 1);
>>>>>>>> +    if (ret < 0) {
>>>>>>>> +        dev_err(dev, "Failed to set column address: %d\n", ret);
>>>>>>>> +        return ret;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ret = mipi_dsi_dcs_set_page_address(dsi, 0, 2880 - 1);
>>>>>>>> +    if (ret < 0) {
>>>>>>>> +        dev_err(dev, "Failed to set page address: %d\n", ret);
>>>>>>>> +        return ret;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
>>>>>>>> +
>>>>>>>> +    ret = mipi_dsi_dcs_set_tear_on(dsi,
>>>>>>>> MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>>>>>>>> +    if (ret < 0) {
>>>>>>>> +        dev_err(dev, "Failed to set tear on: %d\n", ret);
>>>>>>>> +        return ret;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0x7f, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf1, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf2, 0x5a, 0x5a);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x03);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf6, 0x04);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x05);
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xf6, 0x01, 0x7f, 0x00);
>>>>>>>> +
>>>>>>>> +    ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>>>>>>>> +    if (ret < 0) {
>>>>>>>> +        dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
>>>>>>>> +        return ret;
>>>>>>>> +    }
>>>>>>>> +    msleep(120);
>>>>>>>> +
>>>>>>>> +    mipi_dsi_dcs_write_seq(dsi, 0xe3, 0xac, 0x19, 0x34, 0x14, 0x7d);
>>>>>>>> +
>>>>>>>> +    ret = mipi_dsi_dcs_set_display_on(dsi);
>>>>>>>> +    if (ret < 0) {
>>>>>>>> +        dev_err(dev, "Failed to turn display on: %d\n", ret);
>>>>>>>> +        return ret;
>>>>>>>> +    }
>>>>>>>
>>>>>>> My usual question: should the mipi_dsi_dcs_exit_sleep_mode() /
>>>>>>> mipi_dsi_dcs_set_display_on() be moved from prepare() to enable()
>>>>>>> part?
>>>>>>
>>>>>>
>>>>>> No, prepare is called before the video stream is started and when
>>>>>> display is still in LPM mode and the mode hasn't been set.
>>>>>>
>>>>>
>>>>> Yes, that's my point. Shouldn't we enable the panel _after_ starting
>>>>> the stream?
>>>>
>>>> I have never investigated what it takes to split these functions, but
>>>> some of these panels do show some corruption at startup which may be
>>>> circumvented by powering the panel on after starting the video stream?
>>>>
>>>> I'm just not sure where to make the split: downstream does describe a
>>>> qcom,mdss-dsi-on-command and qcom,mdss-dsi-post-panel-on-command, where
>>>> the latter only contains set_display_on() (not exit_sleep_mode()).
>>>> It is documented like:
>>>>
>>>>       same as "qcom,mdss-dsi-on-command" except commands are sent after
>>>>       displaying an image."
>>>>
>>>> So this seems like the right way to split them up, I'll test this out on
>>>> all submitted panel drivers.
>>>
>>> Interesting enough, Neil suggested that sending all the commands during
>>> pre_enable() is the correct sequence (especially for VIDEO mode panels),
>>> since not all DSI hosts can send commands after switching to the VIDEO
>>> mode.
>>>
>>
>> I agree with Neil here.
>>
>> Yes, it does seem natural to think that sending the video stream before
>> sending the on commands would avoid any potential corruption / garbage
>> screen issues.
>>
>> But even from panel side should allow that. I have seen panel ON
>> sequences where some explicitly ask for ON commands before the video stream.
>>
>> So, we cannot really generalize it and needs to be treated on a
>> host-to-host and panel-to-panel basis.
> 
> All four panel drivers in this series have a `post-panel-on` separation
> (containing _just_ the panel_on DCS) and should be implemented with a
> separate .enable callback.
> 
> More importantly: is the API to enable/disable, and separately
> prepare/unprepare the panel exposed to userspace?  And is there an app
> (maybe as part of mesa/drm where modetest lives) that is able to trigger
> these calls to test adequate behaviour?  In the past I've seen panels
> working, until my userspace suspends and turn the panel off, where it
> never comes back up properly after.

No. The prepare/enable (and disable/unrepare) translate to the bridge's 
pre_enable/enable and disable/post_disable callbacks, which are a part 
of modesetting. One can not call them separately.


-- 
With best wishes
Dmitry

