Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36306FA35D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjEHJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjEHJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:31:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A758191FD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:31:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so7855060a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683538271; x=1686130271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hF2uep6dIV0wiPIxRVAktVF15/yLiZYHcBHfjVQ7qRY=;
        b=NeOGcrQCBEYBibjYxFXf9mnJDEKtoySDn3a8k9XgjdIjHFSjclKLDNUzXMVXIMlXRa
         4k1fpHQLBmpphWcuOjJI8sN6ybNcynr0vXX0YKKcXA4m14g20R37Nsk8/F+2VXTPmg5l
         qTx84NB7JhW4bdQXgHbjFiZd7h+YXJdUTJomXSSsmXro5FlW8oDpsOP8zSPFflzeRRMr
         YUZap6l82bMj2ctXS/I3gzANXc45JqVhOkJyBnT39WeGFXPVGqexDu6VpVY1l0/IwRH5
         BBntEoUlNSoGbEDtMmvTitiDF/pe0SvOMbohS4vRNwXOp46KmyuXb451sdMiybBs/KF+
         cvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538271; x=1686130271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hF2uep6dIV0wiPIxRVAktVF15/yLiZYHcBHfjVQ7qRY=;
        b=TKai6uL3TEWOTPy332SmlXSUtUQWx97uNWgatZ2DzSFYbw75Jkvg/C0AFXbO4YSMyr
         OaGJ0VzaY6E8xco91brkMhkvckbL3ULnI0rWKl0drFOnRveegOQjzdpS6RgXNPeOtrtL
         9+yi1bzeo0OTe90mdyqwU6EAf88zVH2lqFYgfhIePMx0rT50mDI/hxFPktsEKuNwYrAo
         PzwxKnkpNjtAG+RJiQaR3orm/JsTMlDnFdvXR752s/qQniduE65TFsz7DYMuIMYH9I25
         +D2NOGuf78dhipfb+Weg2zIMh7JDENkfe/kBLMzlHNLljO2Oa0dEbSZy1nFphyJ8PjRA
         dOHw==
X-Gm-Message-State: AC+VfDxYZOb0UPBLGmzoghkm6FDAv6ZnLz68hw2E8nWPcGu245dDatTv
        mZHmXb1GxB24NvqvqT8uoqGG5g==
X-Google-Smtp-Source: ACHHUZ46rA+okatZD5HZ4hExLWuNEd8zt8NtrXi6pjnAL2UTz59YzEHyDnE4wcIzednpq0NWkmAeRA==
X-Received: by 2002:a05:6402:1a48:b0:50c:d5d:c960 with SMTP id bf8-20020a0564021a4800b0050c0d5dc960mr7631786edb.38.1683538271324;
        Mon, 08 May 2023 02:31:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7c74b000000b00508804f3b1dsm5988610eds.57.2023.05.08.02.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:31:10 -0700 (PDT)
Message-ID: <4ab24a55-c50a-394a-f221-83b92f430d2c@linaro.org>
Date:   Mon, 8 May 2023 11:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] dt-bindings: MFD: Convert STMPE to YAML schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, Marek Vasut <marex@denx.de>
References: <20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org>
 <20230426-stmpe-dt-bindings-v3-2-eac1d736e488@linaro.org>
 <168349835671.3623272.12285551237666172256.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168349835671.3623272.12285551237666172256.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 00:25, Rob Herring wrote:
> 
> On Sun, 07 May 2023 23:19:20 +0200, Linus Walleij wrote:
>> This converts the STMPE MFD device tree bindings to the YAML
>> schema.
>>
>> Reference the existing schema for the ADC, just define the
>> other subnode schemas directly in the MFD schema.
>>
>> Add two examples so we have examples covering both the simple
>> GPIO expander and the more complex with ADC and touchscreen.
>>
>> Some in-tree users do not follow the naming conventions for nodes
>> so these DTS files need to be augmented to use proper node names
>> like "adc", "pwm", "gpio", "keyboard-controller" etc before the
>> bindings take effect on them.
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v2->v3:
>> - Drop the required pwm properties already required by the
>>   template pwm schema.
>> - Add the number of PWM cells as const.
>> ChangeLog v1->v2:
>> - Split off the GPIO bindings to their own schema, as the old
>>   bindings didn't even have any GPIO bindings. Put the GPIO
>>   schema before this schema so we can use GPIO in the examples.
>> - Drop nodename and pattern as STMPE is not a generic name.
>> - Add maxItems to the resets.
>> - Make wakeup-source just :true, as it is a generic property.
>> - Move unevaluatedProperties for subnodes right before properties
>>   as requested.
>> - Name devices "port-expander" in the examples.
>> - Use lowercase hex in line init.
>> ---
>>  .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
>>  .../bindings/input/touchscreen/stmpe.txt           | 108 --------
>>  .../devicetree/bindings/mfd/st,stmpe.yaml          | 297 +++++++++++++++++++++
>>  Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
>>  4 files changed, 297 insertions(+), 191 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/mfd/st,stmpe.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: port-expander@43: gpio: False schema does not allow {'compatible': ['st,stmpe-gpio'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'st,norequest-mask': [[15790082]]}
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
> Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: /example-0/i2c/port-expander@43/gpio: failed to match any schema with compatible: ['st,stmpe-gpio']
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: port-expander@41: gpio: False schema does not allow {'compatible': ['st,stmpe-gpio'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]]}
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
> Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: /example-0/i2c/port-expander@41/gpio: failed to match any schema with compatible: ['st,stmpe-gpio']
> 

Failures can be ignored, result of previous patch failure.

Best regards,
Krzysztof

