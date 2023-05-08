Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3B6F9FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjEHGbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjEHGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:31:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40B1A11D
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:31:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so6277134a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683527468; x=1686119468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OQ1Y1Dy1DcmXDOkFF4+nxsd0s1CfphsQW74olTDqGw=;
        b=K/w0jKgME2AOUJJRKDKulpIP5BE7fu316yYG2yR5ZiMAlp063cVXzESZRRRAMDM1GG
         GsP793uiIpYFthczfdKDGo8K4AzLs+UMJ0/NtCP5/4cfK+Q7tpBMXzjtYqid0BtySlbB
         q5FhM31BQTeEHEcA/IWnJL/ftQf6AGcNisNQNbwrIqZf2pqJCnEjKi1vhnhfQGniItZg
         s6s0WWp7NBfzwrocMErcUaHYuFfdJfBx82k3rOxlmNwE8MULZhmJ0jEoMG05Po/p4rrZ
         7C5CLCKbI34fRRtp5ddxW6ye0pmDaCoJ7xrcDNKoxqJigU+6I9EjmxhV2U0w8q2jBCYV
         o+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527468; x=1686119468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OQ1Y1Dy1DcmXDOkFF4+nxsd0s1CfphsQW74olTDqGw=;
        b=WOMI3Ase08BMxwS3DfO0c449FGrQRedZrObj9E5YbwG8SPG4CKPktp4rL6dGf7lkoy
         vZ6WTOglxBIugH4huqb+l6E0+Y/gHLaesGxpqKBAYaGqogTYTpBLJCT2PRrDqiLZq9wd
         /riv2/otPF3KP3z7MFD7ltKtKtk9uEuQ/wwYpyhjr4p4voIQdoEASA1EXPy4QZdbYxwS
         W6dQgJfe3h3ocqLIxeNQ/6OX4nr/OzuuEclVbePeGoQzC74sunqeXnHP8cQFHWtB5a7H
         c47T5staMbElk488+XjK/GcKRllM4BT3WmngokEjquzi5lRJdHbAft+YDTogznJ1wBz/
         Asqg==
X-Gm-Message-State: AC+VfDzBpXC+xijh/g6rbXB6hp5/R2g27//yZ8DNksXspS/i6L60LKJw
        cPb/N4ryz4BYAQs9G5RrJs9u+w==
X-Google-Smtp-Source: ACHHUZ5Ej9KOXTs2EAx/CHeY+tmJXILRqG31KllqiRtW3HMLq46+8Gb6Tsjesrbj2kRrYN64WAhpRQ==
X-Received: by 2002:aa7:c991:0:b0:50d:88f3:2e30 with SMTP id c17-20020aa7c991000000b0050d88f32e30mr5953819edt.13.1683527467870;
        Sun, 07 May 2023 23:31:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id i5-20020aa7c705000000b0050673b13b58sm5690029edq.56.2023.05.07.23.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:31:07 -0700 (PDT)
Message-ID: <65914d45-95fb-9b44-daf2-5885ba62a180@linaro.org>
Date:   Mon, 8 May 2023 08:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 06/10] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Jacky Huang <ychuang570808@gmail.com>
Cc:     p.zabel@pengutronix.de, arnd@arndb.de, jirislaby@kernel.org,
        schung@nuvoton.com, tmaimon77@gmail.com,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, will@kernel.org,
        Jacky Huang <ychuang3@nuvoton.com>, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        mjchen@nuvoton.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-7-ychuang570808@gmail.com>
 <168351638748.4154745.16515916544783600377.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168351638748.4154745.16515916544783600377.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 05:26, Rob Herring wrote:
> 
> On Mon, 08 May 2023 02:59:32 +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation that describes the nuvoton ma35d1 UART driver bindings.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../serial/nuvoton,ma35d1-serial.yaml         | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dts:25:18: fatal error: dt-bindings/clock/nuvoton,ma35d1-clk.h: No such file or directory
>    25 |         #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dtb] Error 1

This however is related, although might be coming from earlier failure.
I assume you run the check and you do not see any errors?

Best regards,
Krzysztof

