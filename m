Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F16FDE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjEJNAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbjEJM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:59:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C454ED3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:59:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so13234667a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683723596; x=1686315596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkaVsJB+3gB0vdSn554WReC3LerwVDjKqX2vmUcs9lE=;
        b=bhw0JbVLctvCOm/xK9ZGJXj7/9O84ONny9L7kINjvGxnjL89/gTUWO9GdaSRB/dYQP
         5WJjzhFRqQm6AS4Xjhrnni9jf6sCoao/Jsyh2kon79bm2lgRn2Ko2aWdKBi11fqM7G4I
         LEIA+zU12v5TSFsAcLDbxzjc3s8nOGn0GlmTcpP3Uw6DZEL9HaIlkNCWSOor/m2c1muG
         E19nfidlYPXaLlxXYIPIoJO3qS7Js+DH5ACqKJybxjTgWJSM/dv59kcUyIozVE8Q/4Px
         ZzSpCUFOkFcMiQXBuHB5Y3aD1nANigz+S0qJmtPtwYRLgh2y+rC0paMhkws5aWArXbim
         QBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683723596; x=1686315596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkaVsJB+3gB0vdSn554WReC3LerwVDjKqX2vmUcs9lE=;
        b=U7NIaA7oR+U+zbIqdMa0qQOsEZ8jE2fbC3xguszdGcN5UwgcgQ75BN+JPLpuic7W7J
         u84p88AI2c0YjK/d+VUserPdfJCHdvcPd97SU9Ddy1RwV3ly0n1san0auLAxvjoDLpgk
         V2Mc65I2uut1qO8ij5Y+DC5HK9wGvHlHXZu+7U2FsMDknb/usk8LCpW4vPRviMv7rYeK
         jPc3etjP35Fp+/Xcyeh8XHqgvHegSZ92T4FEfuYF3xfL75nQUI9h0NIPjCjQB/j4vJI9
         iAX0EhVh4eV2bi5TTGCM51crVRqcUbiuWxIvertag4lvb0dki9ciwFXkGj2nTy0frwlw
         p7fw==
X-Gm-Message-State: AC+VfDxTMwW/F/NGFRxzIuNcS8eLiO1zmlQ843b24CWKCPD188NjiU7A
        +K6GP02tVy4RR6p4lQubF4T3eQ==
X-Google-Smtp-Source: ACHHUZ7Jt0BpKa9Ci9NKUNzF0aIJCbYo+HUlypJjMchdRWaRsdG7qQZM2I2/Vv1cHmXTEK8oY2K44g==
X-Received: by 2002:a05:6402:793:b0:506:bcd6:b125 with SMTP id d19-20020a056402079300b00506bcd6b125mr13418357edy.40.1683723596458;
        Wed, 10 May 2023 05:59:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c7cb000000b0050bde945c00sm1837469eds.78.2023.05.10.05.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 05:59:55 -0700 (PDT)
Message-ID: <7e402ccc-e01d-cfd6-f9b5-48b313649e92@linaro.org>
Date:   Wed, 10 May 2023 14:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/3] arm64: dts: Add device tree for the Emtop SOM
 IMX8MM
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
 <20230510112347.3766247-2-himanshu.bhavani@siliconsignals.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510112347.3766247-2-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 13:23, Himanshu Bhavani wrote:
> Add a device tree file describing the Emtop SOM IMX8MM
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>


> +&iomuxc {
> +	pinctrl_gpio_led: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16			0x19
> +			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29			0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL				0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA				0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicirq {

No improvements.

Do not send more than one version per 24h and allow others reviewers to
actually review.

Best regards,
Krzysztof

