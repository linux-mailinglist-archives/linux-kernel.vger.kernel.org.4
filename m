Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6BE74D4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjGJLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJLnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:43:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050BE1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:43:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9939fbb7191so860996866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688989417; x=1691581417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smQHbwx5BR128+R1iIuZtuIw3CidaCd32FLwwiifKb0=;
        b=OZCKMDkMPDh1pEJGD2NOAsMI1di44E7khLp2DKWJpDK7qNdtiTjG24p7hRhFK3rt3F
         8HBhCRP/z7wypreZ7xLwAuthOUrEwBLzn5pR5tO84o0yUrXMuHv4FPlDrezscRnu8JlM
         9aCH+C+8PAUGnD7w4GamIaNQaS5qp0oPskJbh5v0cRNocOgoNZJomUjSlCAHdug/i3ld
         BxjcP2qG66UU5Gl+r3ZrxEnnmjnpsvtcAUaqVpbXPuMw4hPX7usvqSa06dGWfteQQFON
         OKi3xuN5i1UwWPwp5w1Pck6JGOzlrppL10R2V+e8LIObWbp7v5u18q3WEAblso5AJQtn
         fm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688989417; x=1691581417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smQHbwx5BR128+R1iIuZtuIw3CidaCd32FLwwiifKb0=;
        b=MFpW0nIxZ2l92b8AZ+Zxuq51VrHFXbMYWmEDrnzWk99yfqIIobiKZvIHODNvRklyqk
         X6K7rsBkyyQ1D6Da6XTgA2BbgGKKWDufKNasJUg8g/U2wqc0e1WvBAofMpCCG4CPn1BQ
         qfaCTgzze9KkOMs5n27lpvdbBmzbyjAssrxFDxV7OAFAChVas4QNl7vIf4oPkvl25vXn
         6S1t7Je1ydP+RxkW1VRgNLnVcR0RXnIGZ3xsPIZ/j+06o1n/PUEFDEIC7ZRXWqvexZcl
         S0FTzh7B12AttPLe/qnAdRKxa5Ag7lTuPdH/+4bu/KJF5k/M3dEkUYKCWbdcjGa6j6IZ
         FBuQ==
X-Gm-Message-State: ABy/qLayvPPoLlw+iQ1yHl9GUw4D0cFk+WOwAAPdttJNy8GDUEmrKNOF
        Jslx5zUPd4IZwKGVKDrxHWjfLA==
X-Google-Smtp-Source: APBJJlGeBAT6Y1+aPPZenaqWpyQfNwJWeBQHbQFwb2+FUWvs854efwe8rNoXgq8EauIqAVt50KRtnw==
X-Received: by 2002:a17:906:10a:b0:992:ef60:aadd with SMTP id 10-20020a170906010a00b00992ef60aaddmr14624499eje.13.1688989417752;
        Mon, 10 Jul 2023 04:43:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bn3-20020a170906c0c300b00992a8a54f32sm6029333ejb.139.2023.07.10.04.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:43:37 -0700 (PDT)
Message-ID: <23833669-b9f7-94aa-ea42-56843842cba6@linaro.org>
Date:   Mon, 10 Jul 2023 13:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com
Cc:     krzysztof.kozlowski+dt@linaro.org, afd@ti.com, s-vadapalli@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-2-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230710101705.154119-2-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 12:17, Jayesh Choudhary wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> The system controller node manages the CTRL_MMR0 region.
> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> [j-choudhary@ti.com: Add reg property to fix dtc warning]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 2ea0adae6832..68cc2fa053e7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -5,6 +5,9 @@
>   * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> +#include <dt-bindings/mux/mux.h>
> +#include <dt-bindings/mux/ti-serdes.h>

Why? What do you use from that binding?

Best regards,
Krzysztof

