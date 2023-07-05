Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D3748873
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjGEPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGEPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:53:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AEF1730
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:53:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992b27e1c55so799350466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688572395; x=1691164395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh477yDSd+xSa/Mg5e8k0mjyTlNnNDL3Odj1uMreL9w=;
        b=FyE+JH8rQS/3AwHo2bDBieRlA0uAn7fhn54l+1mD2m1KmtyrGneCNZpeF/gaEvTOFQ
         qulUr+gqI6H1vBbOOjzVf/kWCOpMLY6Mely4jQ04rvNp9OovZVaQwpjDRM2A4tyOof90
         0hqy15xEiM5iZ08gk60+G1mCnVFB+vRVfJAIFt/XDf3NfXVmbA++mkm9KjDtozo8lyQj
         dwM6SeQ1NiWgoJw9sekEgZDNhNdn/tsAvYE7Q03rflmt2vZ8C+wwESAGZxyINNoUyppW
         EkyZn8LIhMkkgoCpcbzrBWiwYh2pBJ3mqLFau3fQoPjGH8tm7WX3cAnz2QY3NtaW3xF/
         f8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572395; x=1691164395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vh477yDSd+xSa/Mg5e8k0mjyTlNnNDL3Odj1uMreL9w=;
        b=dnsGmtZpcKQY9f1BMg/uWw+CT9V0m0rNE1sMUK3CPNfGKeBcYBGOTUQkP7BDj9FUd8
         YLMHd9qtz+u3HdiwHlZNRuO1BV57jsarn6tPRKWER05cYbMnoTtuYkbdtYpVsgdaboiW
         rpDqyOYI9MXEdBPiZA9wuPtKEdnUuOSW+N4E/1GL4zFu0B2Y92T5ORr/UuW/x2R1WETj
         /CHlr+L8RkBwuaBeZz2piSntcfTN1PttBKjocKAqZjecamtNIskl1S4PJ/vd0lc6POtL
         9NdugJ485jrq2K3jex8vkNxWLDRvBBGgXI2Q03HCQnk84QLP2Ukzz4ks+or26/2WvaCo
         RGfA==
X-Gm-Message-State: ABy/qLZILpwEPu6BALR/TA2XLL6P+X3EDhlHOw1N6PP+6jaivEV3EbHJ
        w7ncrifUQErODnmdeYdFzGXMGQ==
X-Google-Smtp-Source: APBJJlE4PgcJ7V29VNYZD2/t4XcW0wr66Eo22nZ/3iI3L9HTkt5yMStE/CU7ZF2DnujfWvJy+dxuUA==
X-Received: by 2002:a17:906:1914:b0:98e:2b01:ab97 with SMTP id a20-20020a170906191400b0098e2b01ab97mr11790132eje.68.1688572395674;
        Wed, 05 Jul 2023 08:53:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b009886aaeb722sm14726472ejx.137.2023.07.05.08.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:53:15 -0700 (PDT)
Message-ID: <b573535b-25f8-8986-3d5d-2e8d4b4c5ca1@linaro.org>
Date:   Wed, 5 Jul 2023 17:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/3] arm64: dts: rockchip: Add Radxa ROCK 4SE
Content-Language: en-US
To:     Christopher Obbard <chris.obbard@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230705141011.111568-1-chris.obbard@collabora.com>
 <20230705141011.111568-4-chris.obbard@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705141011.111568-4-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 16:10, Christopher Obbard wrote:
> Add board-specific devicetree file for the RK3399T-based Radxa ROCK 4SE
> board. This board offers similar peripherals in a similar form-factor to
> the existing ROCK Pi 4B but uses the cost-optimised RK3399T processor
> (which has different OPP table than the RK3399) and other minimal hardware
> changes.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
> 


> +
> +&sdio0 {
> +	status = "okay";
> +
> +	brcmf: wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;

I just send a patch to fix this in some files, so let's try keep it
good. Use proper interrupt type, not none.

Best regards,
Krzysztof

