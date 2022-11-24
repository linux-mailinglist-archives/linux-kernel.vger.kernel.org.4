Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856E363771B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKXLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKXLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:05:24 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417B75C0E1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:05:22 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id d3so1619863ljl.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rn8gRLitU2bG8xUrjjRIZNkoRWyZ8WxzPo3QWmnRYPU=;
        b=u8Yf2nhT5P01RksVG/fGGyze9h2f2xrgksiQwhkf3Ah2IaTC02jmSu5JmhHIRz4rGu
         gFz0/Nawz5pSTpdaCFkfN+t7IK3wES1itdY+MXklXKvNJJAV3qhf/gVM1vkZPc6P0/pv
         Qh3ybrOhg+fW2idYfu81USNxr90HGPDmVfUGJROV/dlUHQFq4azr3giM9sn6CBHEvv0f
         t7mxrZuL9uvqPe9yzy2Eoh1tzqPSswtQQ9GdZdWI8Nzf4HqxTiodbrb0Datp3WMl64zT
         IL/xBtaHUDRfyGcofxtbPkBR1VR0zZ+M5mzfcrN3V8zEHPYlYA+UUMLMq7LYnExsww/T
         E/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn8gRLitU2bG8xUrjjRIZNkoRWyZ8WxzPo3QWmnRYPU=;
        b=DoKHq8tG1omxKzxKQfiG757Vh4DVtdAhuexcoY6eiqs+p6SXGQ/U8GkCkFuzOz/zaJ
         ZdURtUHLiZ9Iz6ZFTmFDWjROceOgoEGNb+NDLTqDqvnu3WoRlILlUEOkQSN8qTs4R4NQ
         8DiGubyGsdRHj2mP2DTZ7kBK/yV0eyIrA1jJfyMyd9ZNSWaLrSDQmYtjQg0YwzAe1vAO
         WuIqPQ4pLkHtAANbkWFyBzUzebtE9fNjS1fKmENT4htHNVna6JnXnkq+gf5rqmb95cqR
         pgCAJpgFLuc4Xy/XPZ1B6xlA++tpG0wj9qrUAmXp+dA75Tb2HcJTSve3bmXasLEt5zUM
         1/JA==
X-Gm-Message-State: ANoB5pkSNar3sv1hgVqNHvRKr+eczTAvSj3q35/3PW47N+x/oXXNSAMz
        YppeN4+Q/hkQB6eK6B634c/Z6w==
X-Google-Smtp-Source: AA0mqf6KCtKkTcJv0a7dnVOBWz4yFZ7Dni3PjZVdF2bhA4Fvpn7bpSDWU7lOxYyMprZ4p7eDtkrl6A==
X-Received: by 2002:a05:651c:50b:b0:26c:5db6:cd84 with SMTP id o11-20020a05651c050b00b0026c5db6cd84mr4791835ljp.114.1669287920605;
        Thu, 24 Nov 2022 03:05:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g7-20020a0565123b8700b00494978b0caesm84019lfv.276.2022.11.24.03.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:05:20 -0800 (PST)
Message-ID: <f13be4fb-da09-cd99-6bf4-03da3da4a64b@linaro.org>
Date:   Thu, 24 Nov 2022 12:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] dt-bindings: leds: Document commonly used LED triggers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, thunder.leizhen@huawei.com,
        festevam@gmail.com
References: <20221123081112.97150-1-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123081112.97150-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 09:11, Manivannan Sadhasivam wrote:
> This commit documents the LED triggers used commonly in the SoCs. Not

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> all triggers are documented as some of them are very application specific.
> Most of the triggers documented here are currently used in devicetrees
> of many SoCs.
> 
> While at it, let's also sort the triggers in ascending order.
> 
> Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v3:
> 
> * Rebased on top of v6.1-rc1
> * Added WLAN Rx trigger
> * Added tested tag from Zhen Lei
> 
> Changes in v2:
> 
> * Added more triggers, fixed the regex
> * Sorted triggers in ascending order
> 
>  .../devicetree/bindings/leds/common.yaml      | 79 ++++++++++++++-----
>  1 file changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> index 3c14a98430e1..0ffed6bcbefd 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -80,26 +80,65 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/string
>  
>      oneOf:
> -      - enum:
> -            # LED will act as a back-light, controlled by the framebuffer system
> -          - backlight
> -            # LED will turn on (but for leds-gpio see "default-state" property in
> -            # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
> -          - default-on
> -            # LED "double" flashes at a load average based rate
> -          - heartbeat
> -            # LED indicates disk activity
> -          - disk-activity
> -            # LED indicates IDE disk activity (deprecated), in new implementations
> -            # use "disk-activity"
> -          - ide-disk
> -            # LED flashes at a fixed, configurable rate
> -          - timer
> -            # LED alters the brightness for the specified duration with one software
> -            # timer (requires "led-pattern" property)
> -          - pattern
> -        # LED is triggered by SD/MMC activity
> -      - pattern: "^mmc[0-9]+$"
> +      - items:

Why items appeared everywhere? It's not explained in commit msg and you
do not have multiple items.

> +          - enum:
> +                # LED indicates mic mute state
> +              - audio-micmute
> +                # LED indicates audio mute state
> +              - audio-mute
> +                # LED will act as a back-light, controlled by the framebuffer system
> +              - backlight
> +                # LED indicates bluetooth power state
> +              - bluetooth-power
> +                # LED indicates activity of all CPUs
> +              - cpu
> +                # LED will turn on (but for leds-gpio see "default-state" property in
> +                # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
> +              - default-on
> +                # LED indicates disk activity
> +              - disk-activity
> +                # LED indicates disk read activity
> +              - disk-read
> +                # LED indicates disk write activity
> +              - disk-write
> +                # LED indicates camera flash state
> +              - flash
> +                # LED "double" flashes at a load average based rate
> +              - heartbeat
> +                # LED indicates IDE disk activity (deprecated), in new implementations
> +                # use "disk-activity"
> +              - ide-disk
> +                # LED indicates MTD memory activity
> +              - mtd
> +                # LED indicates NAND memory activity (deprecated),
> +                # in new implementations use "mtd"
> +              - nand-disk
> +                # No trigger assigned to the LED. This is the default mode
> +                # if trigger is absent
> +              - none
> +                # LED alters the brightness for the specified duration with one software
> +                # timer (requires "led-pattern" property)
> +              - pattern
> +                # LED flashes at a fixed, configurable rate
> +              - timer
> +                # LED indicates camera torch state
> +              - torch
> +                # LED indicates USB gadget activity
> +              - usb-gadget
> +                # LED indicates USB host activity
> +              - usb-host

Split sorting from adding new patterns - it's not possible to judge what
was here and what is new.
Best regards,
Krzysztof

