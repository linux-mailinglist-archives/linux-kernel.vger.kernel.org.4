Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05AA6299C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiKONNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiKONNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:13:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41442AC77
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:13:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j16so24290952lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTB4xFkuSqDJkguPgbNRXgSTiSjC5T2+Eayiy8u0drU=;
        b=qkr1mPq/Iaq6jH68zz8NMaNhWjw1jXQNLTUA5ro/GwxRqLhvYOZZJggPfjJLkD/sDC
         OybF5JEtdGoOcSJxev4oDb3DAV/yywXLFJre0xAjokkiNWsg3uVG9YHJdmit0j0MpjIC
         eapXuzqulT4CYxV4+AsCscwvDmRIK+62394ng8bV4CSuxQL3wmriKBpy+2TApOKbthG3
         hA09F9owNUYO9l4rc+W0cwptaDo2BnaUgPk8XFlfhZwYF2sJRUzYymXKaAbwFsQc5dKc
         crN8yNqhipyN9V2aV7rBaJjk6g2aC+z9RyAwL4+U0e3b4bDXGENEaJ4Ri57Kv/Gf4fyR
         Hapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTB4xFkuSqDJkguPgbNRXgSTiSjC5T2+Eayiy8u0drU=;
        b=8QyesTAwwLYmTj8EjhMhzM1KIs+5IMRgBfnHH6pFRpkkVTbOsXjnm5AoLZeXOToNL8
         oSNlJAt1NKZXww+4rHSRL75rCiChF+4XS57f0hoRr94iRTxCAMu4HL/C+gT3gLRMVJjt
         spu4naGHKab/8VoZqCClOHT2OjTsM5a8ZdQ6e+0TiZ5T74onwlf6hsc7b0SGvhpzKJRJ
         J87d09qKbJlDRi9UmPQFsXFMPQCoq3ZxlBorkwZB9GgOl+UFLg9qAlGWO2CW5GY3XjoS
         tVLAz4vHwxv/ZxHlPPnFJ639zHLjQe2j1tfwCcDgbp8b45armRAlD74NRECzNRYcJR6T
         wFxw==
X-Gm-Message-State: ANoB5pnLhq6p5RP1cNZypHSFURBxN2N2z3Fcs9nliBDdbHzykgo5bdTS
        +iUJW/aWZWbm2M6YjbMTIfxQPbteeopKKfdS
X-Google-Smtp-Source: AA0mqf6bmDAkHFG20vnLLPsWE6BGuUChzkPAn4GcFmO719fkh9AATz5foTHq2aVxbcn4IGkfFeB/cQ==
X-Received: by 2002:a19:645e:0:b0:4a9:e27a:1cfa with SMTP id b30-20020a19645e000000b004a9e27a1cfamr5452473lfj.147.1668517982163;
        Tue, 15 Nov 2022 05:13:02 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bd24-20020a05651c169800b0026e04cc88cfsm2501210ljb.124.2022.11.15.05.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:13:01 -0800 (PST)
Message-ID: <a5d53378-51dc-a024-bbda-5dd03bbf37b3@linaro.org>
Date:   Tue, 15 Nov 2022 14:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/7] dt-bindings: usb: add the Renesas RZ/N1 USBF
 controller binding
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-5-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114111513.1436165-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 12:15, Herve Codina wrote:
> The Renesas RZ/N1 USBF controller is an USB2.0 device controller
> (UDC) available in the Renesas r9a06g032 SoC (RZ/N1 family).

Subject: drop redundant, second "binding".

> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/usb/renesas,rzn1-usbf.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
> new file mode 100644
> index 000000000000..b67e9cea2522
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/renesas,rzn1-usbf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/N1 SoCs USBF (USB Function) controller binding

Drop "binding"

With two above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

