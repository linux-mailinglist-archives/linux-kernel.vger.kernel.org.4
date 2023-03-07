Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F236ADA1F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCGJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCGJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:19:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B287A02
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:19:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k37so7330039wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678180792;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvf3J0opIvDUcxf9EVO52WF3b9vkBrT7WnUb6TfxtQw=;
        b=qlSONsvqCrRJCiKnQemhSWVzmW8IkLxHGjVLW+q3uPKfZB74eSAgFyNGsjVpOIppKR
         N7WvqjftsfK69mezO3QyBdmQeRB48X/cA/zRMbjS401KI8VVZa/VpmnM0rgvi3WW/iAs
         4+JqUn3vf8CiUvM10mRD8HJgsZnRr9AzQJVu6K7xatmQF67cDI7+i98GC3FZV6qvsmzX
         PSastNPqf1afvY4XteO+Y/ooO5tuuF/UIREF1YpZtfJ8cVrv8BwN+Q04csKll7eO7mUi
         JKAvh8MKLkhF/bzJDgIzbLl3fLg4kwPJVEFLYRoiiT5N+zx2PpBCDVEdhWDYANtCSfNd
         McmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180792;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xvf3J0opIvDUcxf9EVO52WF3b9vkBrT7WnUb6TfxtQw=;
        b=VWFe+YBNzbtiNRJdy4oeucMQjUyewxPxsMBIfL8IWIlFopS0xeIeUGT98xQSU7eLbW
         MVnfk/lTz7tzKwqK11iy0AcWWnB7Zp9xo1zt3VtDgnSTZSb3DfgjHU64LSeasPmCb6KJ
         4VissNPN7FXxdFlSw+JC24QoY85dacOhCbFuvOjtGuKusAPFRfaF/7vVAEJatx6x+Q5v
         7nXTXPX13QnkifTnZP1HvScJlc7vfuFVPe94WDb9I3L+P2f+3Rz9vsi6A+WbSQYVOGYh
         4EkyD5OKUnCLXBaDFd0/yRdHNwS/HhMe2Wx7QJITcmVwqlGymE1D15w986KHsWmFUE8T
         AjgQ==
X-Gm-Message-State: AO0yUKWdRwZPWlOmIKQ7e4Qsc64Gvyob3DP0VnEMATzpJi7cYPlC6nFp
        2Aua0X4B2WoqI3d0joGSuXFCrw==
X-Google-Smtp-Source: AK7set/k5WpOi8Sz3yDYvf2/fNpy2N6KzP1JdktA73cysUhzQQJhzb0GXWO8S+TNxvAb6p0yyfaazA==
X-Received: by 2002:a05:600c:4448:b0:3ea:82a9:3644 with SMTP id v8-20020a05600c444800b003ea82a93644mr11655011wmn.34.1678180791874;
        Tue, 07 Mar 2023 01:19:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6faa:6d13:586e:871d? ([2a01:e0a:982:cbb0:6faa:6d13:586e:871d])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d63cc000000b002c5801aa9b0sm12141821wrw.40.2023.03.07.01.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:19:51 -0800 (PST)
Message-ID: <6c58497d-47c4-002f-4f39-977706f9df87@linaro.org>
Date:   Tue, 7 Mar 2023 10:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] gpu/drm/panel: Add Lenovo NT36523W BOE panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230217-topic-lenovo-panel-v1-0-9d7ee1602089@linaro.org>
 <20230217-topic-lenovo-panel-v1-2-9d7ee1602089@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230217-topic-lenovo-panel-v1-2-9d7ee1602089@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/02/2023 12:29, Konrad Dybcio wrote:
> Introduce support for the BOE panel with a NT36523W touch/driver IC
> found on some Lenovo Tab P11 devices. It's a 2000x1200, 24bit RGB
> MIPI DSI panel with integrated DCS-controlled backlight (that expects
> big-endian communication).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                     |  12 +
>   drivers/gpu/drm/panel/Makefile                    |   1 +
>   drivers/gpu/drm/panel/panel-lenovo-nt36523w-boe.c | 751 ++++++++++++++++++++++
>   3 files changed, 764 insertions(+)
> 

<snip>

> diff --git a/drivers/gpu/drm/panel/panel-lenovo-nt36523w-boe.c b/drivers/gpu/drm/panel/panel-lenovo-nt36523w-boe.c
> new file mode 100644
> index 000000000000..83478e471493
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lenovo-nt36523w-boe.c
> @@ -0,0 +1,751 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Linaro Limited
> + *
> + * Generated with linux-mdss-dsi-panel-driver-generator with
> + * some manual adjustments.
> + */

<snip>

> +static int nt36523w_boe_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +	int ret;
> +
> +	brightness = cpu_to_be16(brightness);
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	if (ret < 0)
> +		return ret;

It's not wrong as is, but could you switch to mipi_dsi_dcs_set_display_brightness_large() ?

> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
> +
> +static int nt36523w_boe_bl_get_brightness(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness;
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);

And here to  mipi_dsi_dcs_get_display_brightness_large() ?
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	brightness = be16_to_cpu(brightness);
> +
> +	return brightness;
> +}
> +
Please send a v2 with those changes and keep my reviewed-by

Thanks!
Neil
