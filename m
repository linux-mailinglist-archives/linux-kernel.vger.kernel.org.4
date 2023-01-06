Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1B65FDCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAFJXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjAFJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:21:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCA66E0E9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:21:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m7so713219wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAfhATkIYXFpgazLFZ+AK9Lq1o03ZdKMm34LM7SHmEU=;
        b=f1UmUxyILCnWGJP6qQZ7GcSBmaoU7z3kYlpph2vCbELXC7Xz7KHHFFxp+kUamJ+2t9
         dm3GhM0EF/kBYDcV4aolDZWukCmIZLXLm0S/7lOnmYDmfWx2bXT8IAoB5M2ySYkW81R6
         OwqTPM8Mmz+pvtNjtE08dy7FSYk83CiICoZ3T0XbLHiHP2uCmXSJx8dpH5opGReUsrBT
         +ZdwGnyizkf+X3ghhIckgWqo99alISOiAjxja7b54BzRqLLQC08qLJ3JV75Owq/K5Cnu
         KEx8+jwyEyu1XmrqlWoxhgk6SsExL+WZ+xYT05K+Yj5/p26r54DSCHzJFSvFUdQ92zBQ
         dzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAfhATkIYXFpgazLFZ+AK9Lq1o03ZdKMm34LM7SHmEU=;
        b=X6I71GCjKfCgismNZwEn9fZX0HLqWuu9HS6Dhi8ctMI93GsngwvrNg8SUO0uCP7kul
         pqOiwYRPdu4AKWCotk4gRDwVXnMWQdNnebU3XQ4Wjca8r5LF5DS3NkvEMwA39PHyHmXA
         PZrmt/xEmMMPAA7Z0LrhOxN/gVdico+sKfzrYO442K6r0DTb8v6x32oHZxivNyVZS02o
         V0ujO2JrcDxctichhe2hJ5ulDvcGL7iVp5T9snm3RvqnTp82+c7BzDereBImLkdxeqGR
         q7He5eGrj8AtKKGORE1BjlHtmeHvFGU8jZTN9z6TyOtqfFWW0xCnsVWklm50t2FR1kSv
         dJ3g==
X-Gm-Message-State: AFqh2koEBar6lwPmkxm65vAdug/qpN8HKvG3tsWozHn02UrRQDN7iTV3
        ujXnmgMR2LgCqIXRammBezVFDg==
X-Google-Smtp-Source: AMrXdXu9fepmPpgEfQ6cshSmsZ+6857dtpUM6/8+Vafn1HbdY34/Rzfs18skEvxTNG6/20H2UhzJ3Q==
X-Received: by 2002:adf:dec7:0:b0:242:115d:bee4 with SMTP id i7-20020adfdec7000000b00242115dbee4mr32938927wrn.16.1672996867159;
        Fri, 06 Jan 2023 01:21:07 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z8-20020a5d6548000000b0028df2d57204sm689153wrv.81.2023.01.06.01.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 01:21:06 -0800 (PST)
Message-ID: <4d6aec55-c53e-0aba-1168-8a9a80a3b598@linaro.org>
Date:   Fri, 6 Jan 2023 10:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] dt-bindings: arm: sunxi: document MangoPi MQ-R board
 name
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        =?UTF-8?B?QW5kcsOhcyBTemVtesO2?= <szemzo.andras@gmail.com>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230106010155.26868-1-andre.przywara@arm.com>
 <20230106010155.26868-4-andre.przywara@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106010155.26868-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 02:01, Andre Przywara wrote:
> The MangoPi MQ-R board is a close relative to its Allwinner D1/D1s
> siblings, but features two Arm Cortex-A7 cores instead of a RISC-V core.
> 
> Add the board/SoC compatible string pair to the list of known boards.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 3ad1cd50e3fe0..ce445c5ed81c8 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -843,6 +843,11 @@ properties:
>            - const: wexler,tab7200
>            - const: allwinner,sun7i-a20
>  
> +      - description: MangoPi MQ-R board
> +        items:
> +          - const: widora,mangopi-mq-r

Not documented vendor prefix.

Best regards,
Krzysztof

