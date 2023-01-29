Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B8680048
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjA2Qq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjA2Qq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:46:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA95C65D;
        Sun, 29 Jan 2023 08:46:25 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m2so25288620ejb.8;
        Sun, 29 Jan 2023 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EegtgDiZvPxg3XvKag87hiBCFOeNYXfSdU0ZYoRxSBw=;
        b=VdzR+cnOtJTwEvWU6Yiw5IVeGG3eLu4AyT2+ohh1pLLFbxBLHjtHzfbYHzZfYcpb1a
         Pj5FjZ/MYPbbTGZ6Kot1DGB+CiltOWI3pRk3VwkIBz7WNknhqgw7x0dyBZuBXBH5GjrK
         8/aq/tpabkdbL5C3uohhwT5nmnUZtRtgampiOrmYsLNwaFf+HvGowuAhJwziGjx8z1tY
         dxtx28jDhS4rbWSfJZgI1WaIJZnVaYlrs4zYa6i8bgJaLvprd4QhhF9kG+kTgcjHNzVz
         dGokq3nNks+LFdmRDKHuGo/z04twIU0RfpkS9fklE8KM1wollhsxYvfg4rAhjPRpkxTe
         SJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EegtgDiZvPxg3XvKag87hiBCFOeNYXfSdU0ZYoRxSBw=;
        b=poaD0oGcG+r//a04pBO6lL4Tz/YnRCg/47lcjTZk8bVdPVGxH9AnUPqehjPwHiZN4z
         COwMv0XWe8dlSHqj79UF8wo+5xp9rdJ1fDsK9Qtub4dkcMg6UJb8HO9u1rmvYFcXcFbM
         a0Z4MS01gMDlwy2lvsX69ve9lD04HZnQK5SJv8wI/hUl8PvyCJARpjQObCyrwiBtTMDu
         gCDxx0GAmQBZMRPXkFMnBPGvih50BcnC6lJ3mmqMoVI/H+PcnbvA9OYxn01IRT3osPP9
         kKfhqTRql0NbtAcOIdNKbKwZIc0JI/Eqg5eDHml55mzKBTM5CjszbYcCGFr1a0G08tgX
         HnAQ==
X-Gm-Message-State: AO0yUKVcstpOvFzeN/s2EIMfR+X52x5rYUhm/xqBnYof2CkGUCLhTo+U
        rBtOHcaLerY/crgQMH89zZOiypah0cg=
X-Google-Smtp-Source: AK7set/wfa4/YB7Wk9XHH9KYPirORXWPAjxRN5Rp159iBOU50m4fZLx26H/r/3PbjZGo95JqDkqNPg==
X-Received: by 2002:a17:907:9801:b0:888:6294:a1fa with SMTP id ji1-20020a170907980100b008886294a1famr1526677ejc.14.1675010783791;
        Sun, 29 Jan 2023 08:46:23 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906311500b0087045ae5935sm5541795ejx.1.2023.01.29.08.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 08:46:23 -0800 (PST)
Message-ID: <df0594dc-d3d6-2636-49e6-07488ec2b5c9@gmail.com>
Date:   Sun, 29 Jan 2023 17:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v16 1/2] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
Content-Language: en-US
To:     ChiaEn Wu <chiaen@richtek.com>, pavel@ucw.cz, lee@kernel.org,
        matthias.bgg@gmail.com, andriy.shevchenko@linux.intel.com
Cc:     peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>
References: <cover.1673886245.git.chiaen_wu@richtek.com>
 <1c4cf50600bb0334bd03027f49d7511b394c6ced.1673886245.git.chiaen_wu@richtek.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <1c4cf50600bb0334bd03027f49d7511b394c6ced.1673886245.git.chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiaEn,

On 1/17/23 09:53, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
> 
> Add support for the MediaTek MT6370 Current Sink Type LED Indicator
> driver. It can control four channels current-sink RGB LEDs with 3 modes:
> constant current, PWM, and breath mode.
> 
> Co-developed-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> 
> v16
> - Remove blank line in the head text.
> - Move 'pwm_duty' to descrease the size of struct mt6370_pdata.
> - Move the field 'F_RGB_EN' write out from if/else in
>    'mt6370_isnk_brightness_set'.
> - Remove 'dev' in struct mt6370_priv.
> - Remove the proprety reading for 'linux,default-trigger', led core
>    already did it.
> - Change the module license from 'GPL v2' to 'GPL'
>    In the head text, already deslcred SPDX license as 'GPL-2.0-only'.
> ---
>   drivers/leds/rgb/Kconfig           |   13 +
>   drivers/leds/rgb/Makefile          |    1 +
>   drivers/leds/rgb/leds-mt6370-rgb.c | 1009 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 1023 insertions(+)
>   create mode 100644 drivers/leds/rgb/leds-mt6370-rgb.c
[...]
> +static int mt6370_gen_breath_pattern(struct mt6370_priv *priv,
> +				     struct led_pattern *pattern, u32 len,
> +				     u8 *pattern_val, u32 val_len)
> +{
> +	enum mt6370_led_ranges sel_range;
> +	struct led_pattern *curr;
> +	unsigned int sel;
> +	u32 val = 0;
> +	int i;
> +
> +	if (len < P_MAX_PATTERNS && val_len < P_MAX_PATTERNS / 2)
> +		return -EINVAL;
> +
> +	/*
> +	 * Pattern list
> +	 * tr1:	 byte 0, b'[7: 4]
> +	 * tr2:	 byte 0, b'[3: 0]
> +	 * tf1:	 byte 1, b'[7: 4]
> +	 * tf2:	 byte 1, b'[3: 0]
> +	 * ton:	 byte 2, b'[7: 4]
> +	 * toff: byte 2, b'[3: 0]
> +	 */

Please provide documentation for the hardware pattern format.
Compare [0] and [1].

Otherwise looks good to me:

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

[0] Documentation/leds/leds-sc27xx.rst
[1] Documentation/leds/leds-qcom-lpg.rst

-- 
Best regards,
Jacek Anaszewski
