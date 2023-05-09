Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC76FC737
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjEIM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjEIM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:56:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871473593
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:56:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so58523911a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683637012; x=1686229012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltT5WDqiHiXa+NlkCKHkzYX00tTDEJOTIESsg/PtJ6o=;
        b=EZDWvgphpMnWIcHidfGZPOUdFj/EMT/jCbQb52rDcuWsAXGYE12zI+/55y5T6U7NQl
         khxq1aa+dClqAhoDFySM+gxMUPH+RboiJ+mJDw6f3fijZF5kmVsRuUxLjjhDAgyewscW
         Q0JJ2Qht84buCC9LpfAtAG9NSDnD6X+3VQ53UgsqlJDEqLtnFrHGdavUSdVCK+gtOFxm
         dBJ92NZYenSPNeDRqc37D0O0W8JZoj9NbJ5YSAxaduFMw4rGQ7r5BPvMSXMPFTevrbBg
         H3fvzkCRxuaD/kMm4C8NjuElDNn4JZJYLG5Qyis3CXqu3/zxpvXvHe23M1UNYUWNo5pH
         aFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637012; x=1686229012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltT5WDqiHiXa+NlkCKHkzYX00tTDEJOTIESsg/PtJ6o=;
        b=BBJDDf47E5k7ignSbVJGm0LIHnEZy8prxZq22STAhu4NGeXHcTpglAdzCHhI+8HfCI
         zDIovQf2dkPw1S967Iw57jkfiv0EK4B6Pq9BH6MhDebrfU8/Pe/Yn77h2xGNfFQHlbQX
         R5HoO+SBLB4UbdSHJGJPuBR3zvkQ+6v2lDWyKPVVDhOHbUOL1rN3Fa+6gOoovDkou0vg
         ZsmiAmj9R0DWH3/fVxb7K6NQIEfowH6wJsEzlqCeSjO+Hqd0UYj68y8Dav0MxijYx9N9
         v9GuOtjmu0yIF1a0jrjaKwe7yOQPr31sBJWFHMtmZ/KgVdl8Do0ZtFXQi95V790B8mVs
         VNYA==
X-Gm-Message-State: AC+VfDxOA3nizuNuLKP7tnqlBp5bn9Ds3LD6n5kpYW0OlTnOUAch5DD1
        9AZTNlquQ1wb1CWoyEkEGje9LQ==
X-Google-Smtp-Source: ACHHUZ63Vqvry1Z/FkOv8giv7vej96ODATuiAvBBUQHzv+ZImnCe07rgHPNEDcenU8O4+2nJZTSMKQ==
X-Received: by 2002:a17:906:ee8b:b0:953:834d:899b with SMTP id wt11-20020a170906ee8b00b00953834d899bmr11345252ejb.29.1683637012045;
        Tue, 09 May 2023 05:56:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id i24-20020a1709067a5800b00965aee5be9asm1315957ejo.170.2023.05.09.05.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 05:56:51 -0700 (PDT)
Message-ID: <003b11e2-362d-fb32-0a3a-bebae6a3c8e6@linaro.org>
Date:   Tue, 9 May 2023 14:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: Add device tree for the Emtop SOM IMX8MM
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230509111754.3301369-1-himanshu.bhavani@siliconsignals.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509111754.3301369-1-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 13:17, Himanshu Bhavani wrote:
> Add a device tree file describing the Emtop SOM IMX8MM
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

I am pretty sure I saw this patch, so you miss proper versioning and
changelog. And since we talked about this, I feel like repeating...

> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 198fff3731ae..36590515fbc1 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> new file mode 100644
> index 000000000000..461e1ef5dcb4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Emtop
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "Emtop SOM i.MX8MM";
> +	compatible = "emtop,imx8mm-emtop", "fsl,imx8mm";

Missing bindings.

Best regards,
Krzysztof

