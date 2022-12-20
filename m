Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DDD651F39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiLTKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLTKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:50:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D622612
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:50:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so18000061lfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gfcuA14rqPUTUjjsVp9VcIwRZasaVKQdRygjZ2irTU=;
        b=anpeRiNM7FlnxT5gtmKwEo9mEc9aOuR5M4DaPXbt9wiIelhZdcKyYLsH612lT0gdbn
         k4QJetrOLBEGyAF5BB/xzz09GIr8IYoOPuni7OuY50H3Je9KBocnD21s1cDJLacRSOCt
         HxEoPB81hUQCY/IhV7rb28/FHCgqP+9h7g/RY8Zb2N0fXTc8w+Dk6Oiro79nAhSNsI2R
         5vQPplpMQBhj2Run4kIKddQzon2gMb8F20JP4rR3ynDsUph9i5Gkx5DrGM9bR658Flqu
         2oOVfMSYawPY18055kSFOQ//Q6uFcPFnScZlUFTeHHAKEPW6nNpR3GzDUMIRWWa5MAjU
         JWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gfcuA14rqPUTUjjsVp9VcIwRZasaVKQdRygjZ2irTU=;
        b=3EZ8SK6T0yNh6nvJwDh5nv1uiKplr5WplHEmishgU+nrrNzNpwP3F6XTtoNg1I4l4w
         OEZSWlGQMA8At490KlfU6NeHjt6fZ1TjGZ0qgXQr7ir+6CrNPdZG2uqyAfLk60nNDFvl
         /bcEpEi+oqumxXaPe5n0PSJH/sF4NzVQyMrZo8KzaCbx8F5L7/BKcT0cmHGLMDHXhS6a
         fF4GXaVzGXoybKnBqWSAXv2GN/m6NvFb0fqW9pTM0c3FQOam0DL/UqL/78ZNE5j6LfP7
         ZDTm/cThZcqPl9KQguDeUH+KQhonzk/5GNzPQ+4QjVG8QlWTimMTvwtiqm+clmFYsu4H
         WdrQ==
X-Gm-Message-State: AFqh2kpYqiMi953kc/36BIKjxXUevmFKgAZziCQrUo8Ye53Y5DnS0Y74
        gCTbjCnh3pPhgRfDbuFbiAp07g==
X-Google-Smtp-Source: AMrXdXuW0FVi+JBWXdCwrMCPwlIJkB9K57igjb8vvaYBBu5oPOgHP59tcGGEBi0Ow1zr3U4zP9sWhQ==
X-Received: by 2002:a05:6512:308a:b0:4c0:91d0:e7bc with SMTP id z10-20020a056512308a00b004c091d0e7bcmr5642377lfd.26.1671533407452;
        Tue, 20 Dec 2022 02:50:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m8-20020a056512358800b004b5284a92f9sm1404763lfr.208.2022.12.20.02.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:50:06 -0800 (PST)
Message-ID: <ff5b09db-4900-0b5b-e821-fa05b8d907a4@linaro.org>
Date:   Tue, 20 Dec 2022 11:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        kristo@kernel.org, nm@ti.com
References: <20221220101249.46450-1-b-kapoor@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220101249.46450-1-b-kapoor@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 11:12, Bhavya Kapoor wrote:
> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
> for 8 channel ADCs for J721s2 SoC.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index a7aa6cf08acd..67593aa69327 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>  	pinctrl-0 = <&mcu_mcan1_pins_default>;
>  	phys = <&transceiver2>;
>  };
> +
> +&tscadc0 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&tscadc1 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> \ No newline at end of file

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

