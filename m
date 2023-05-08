Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C16FA1E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjEHIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjEHIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:05:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C3E43
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:05:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-959a3e2dd27so743273266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683533111; x=1686125111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jK9jA7P9nuvbfnFTT1sbipZIi4ZG7PcSY/gOY0E3X8U=;
        b=zo31bdCt9hKVvYrhD8qShK3Lw+rO+hFzeluZQ1lQ6Aoyz5aFB02aApLpTdmyx6AErQ
         JO9ETfvatGS4fDCH76Kw+z98XqsVMFNTUtq9KHNuieTOXbDvHGgpAsy7ixC9TMqFXPul
         TF/9ZfRBlk6lJcC1B8v9Mujy878LaInK+3qcsxM2rafHHh8QZ1VLm2lXUOd+rUN7XNLi
         Iej5MQdZ/HfRh2wIHjdcAXtmgm/BUp+ymE1lgrM6dPVidbbEgL6g88MNea2hYf5EP/xl
         uQ68t9bPoI0L2C5O9ohoCIZU++pxjZbkZ8GTpFQgCq9nKUoFf1g4u6iFGXuON8GYFsGs
         qGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683533111; x=1686125111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jK9jA7P9nuvbfnFTT1sbipZIi4ZG7PcSY/gOY0E3X8U=;
        b=WnV+ii/7WuKGCsmW8VlXpml5J2hIo6NSsEBp68qEbi22svVmLtDWPK1wVWwKqSf16U
         zRYZiTJYQa9B+U8z9hbj0SXMpxWNq+4sq35IOyOdwwKBJ8m/LEo8kLvcXcim5xmYIg04
         nZOFvg0kh4fbEg20hlnqY4oOrF0e0Le6v1dndjMeovbAiH5dgkunyutrM9WKWtQcBr6k
         MSw8hEmXSnMypQ5t/5fDnnEYBfXeTcu5sWbfXBCF8xhvr+gowVgmehd5P4nzC2qKmhR3
         rtfKwhT/oHZ+s5/TkvCH9WkszsUaB34A85V3O2BvGMeWXQvCbPSsZPsVywPM4Gd4z36/
         1Q1w==
X-Gm-Message-State: AC+VfDwLpt47rrcoXdUJ81T6N8hAbdNH/zFo3zcFOoA8A+/qkblpo9/v
        N3dpOeQ5z2g1lhjnzf062ajMag==
X-Google-Smtp-Source: ACHHUZ499+jnRhsi8orOyuEiHdrYQOfjIxscJA9eTDe9YM3aCfaC2erdJ3tXT0Yuhakul4txwywy9Q==
X-Received: by 2002:a17:907:6287:b0:94f:29f0:edc0 with SMTP id nd7-20020a170907628700b0094f29f0edc0mr8239323ejc.44.1683533111130;
        Mon, 08 May 2023 01:05:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906b31600b00965e9a23f2bsm4235406ejz.134.2023.05.08.01.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 01:05:10 -0700 (PDT)
Message-ID: <25b2fcf6-6ba1-8e51-59e1-2dcf84b856bc@linaro.org>
Date:   Mon, 8 May 2023 10:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 06/10] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>,
        Rob Herring <robh@kernel.org>
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
 <65914d45-95fb-9b44-daf2-5885ba62a180@linaro.org>
 <a62d278c-f47c-fa97-185e-b81ff4b28a4c@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a62d278c-f47c-fa97-185e-b81ff4b28a4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 09:01, Jacky Huang wrote:
> 
> 
> On 2023/5/8 下午 02:31, Krzysztof Kozlowski wrote:
>> On 08/05/2023 05:26, Rob Herring wrote:
>>> On Mon, 08 May 2023 02:59:32 +0000, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add documentation that describes the nuvoton ma35d1 UART driver bindings.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>   .../serial/nuvoton,ma35d1-serial.yaml         | 48 +++++++++++++++++++
>>>>   1 file changed, 48 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>>> Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dts:25:18: fatal error: dt-bindings/clock/nuvoton,ma35d1-clk.h: No such file or directory
>>>     25 |         #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dtb] Error 1
>> This however is related, although might be coming from earlier failure.
>> I assume you run the check and you do not see any errors?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Dear Krzysztof,
> 
> Thank you for your review.
> 
> Of course I have run the check.
> I did not see any errors, because I have 
> "dt-bindings/clock/nuvoton,ma35d1-clk.h".
> This patch 6/10 depends on path 3/10 which include 
> "dt-bindings/clock/nuvoton,ma35d1-clk.h".
> Should I combine this patch 6/10 into patch 3/10?

No, it's fine. If you got the reviews and acks and no reports from
kernel test robot, you can go in few days with Arnd's request and send
everything to soc@.

Best regards,
Krzysztof

