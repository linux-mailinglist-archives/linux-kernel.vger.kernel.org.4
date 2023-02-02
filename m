Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC556877D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjBBItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjBBIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:48:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4C8397C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:48:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3165263wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFT65b50EEkiLEb2HaxzSzyGNIdf4jjjnZMZ02pNxbc=;
        b=LP0ZUiSsyi4nHzQoQvqdAPlPOzLOSvBFSP0kmazyxzYLGIk75m9Xk3IPbRL8T3rcuR
         GGFcVGodyYDh7va4H9PezI3kk2e2fsTIB/B04QqljXElgfNm8TBn/TczP+T17mhCrtO+
         MXq0f9NBQYTwmUqUV3BcHSaqsUdRoUir3ZHt4mj+9To0UWWc78XauRnojqnLNvSjmkR/
         p1knqfu+Zmb8qL9OvgJthh9o5ZsFKJ5iT/IffPcsMJEOYjj+/7WGG6IX73D1fFywhnmO
         zOSYMdjFcHzuysUJOACYY1NbbtOf8ZgT7xyxleQ8+OHioyY/gmjaVVtIAbbVLXbGOJUJ
         kPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFT65b50EEkiLEb2HaxzSzyGNIdf4jjjnZMZ02pNxbc=;
        b=Q+NEihq4OoZWtmXs7Lvo/Qvdc/lXoF++K4Fwqqml+gznkYw5iOfVWCRRrWE1yrLFYH
         Qz7TJMMc0o95ItYtxueUuXH7R6kRURa6vlIdpVk3Vl+G7jrK47X/hCe19fXaRD3CK7mn
         9fBhiYrdD9pxLh/PsNcJ5l6+ksdW/r/uY57dThmzE/p5QLNfLpRZB6pEERzJdRzl4u88
         kDySt+nElJjD1P/YmJJ+24w/zb+5LvKK8MkIN3bKlSr5EXSCkPQAFsV+0eHR5Ozxp8n3
         DrF6t/TEffjW3WaYy0d/EydV1bSC+VVg3QZn0d54gme5E5hXcybsvwYaoCREKrBM4cJU
         BjFA==
X-Gm-Message-State: AO0yUKWoxcFa+2+Ax1pVDyRQnY2JvZm5eOv6LKGDtcS6T/cI/iYi7XsP
        QMfY+IEb693T+0z9MG8uz0PZUw==
X-Google-Smtp-Source: AK7set9QgHEGWI3XpDTcnKQyVSSTiAZeUr5//8Ru1lLuQLb2MMrZYTyyPXZEUw0AMbZfhxmjbeikYw==
X-Received: by 2002:a05:600c:c12:b0:3df:df24:8f94 with SMTP id fm18-20020a05600c0c1200b003dfdf248f94mr512838wmb.27.1675327728536;
        Thu, 02 Feb 2023 00:48:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k10-20020adff28a000000b002b9b9445149sm11474924wro.54.2023.02.02.00.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:48:48 -0800 (PST)
Message-ID: <24bac8be-c301-8efd-4392-e10db00d17f7@linaro.org>
Date:   Thu, 2 Feb 2023 09:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] arm64: dts: renesas: v2mevk2: Add uSD card and eMMC
 support
Content-Language: en-US
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20230130191152.182826-1-fabrizio.castro.jz@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130191152.182826-1-fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 20:11, Fabrizio Castro wrote:
> The RZ/V2M EVK comes with a slot for a uSD card, and an eMMC.
> Add support for the both of them.
> 
> Please note that the pinctrl driver for RZ/V2M doesn't support
> interrupts yet, therefore the card detect pin has been connected
> to the SDHI IP directly in this patch.
> We'll connect the card detect pin to its corresponding GPIO when
> we'll have driver support for interrupts in the RZ/V2M pinctrl
> driver.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

> +
> +

Just one blank line

>  &extal_clk {
>  	clock-frequency = <48000000>;
>  };
> @@ -69,6 +118,26 @@ &i2c2 {
>  };
>  
>  &pinctrl {
> +	emmc_pins: emmc {
> +		emmc_pins_data {

No underscores in node names.

Best regards,
Krzysztof

