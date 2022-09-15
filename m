Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3540A5B9ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIOPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIOPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:32:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F64CA16
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:32:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so31437305wrp.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dWVNE8WMO4DQqfERbcgjNIYel9+RFTdZZw0u/caF1L0=;
        b=ioJ633/KBgnop2BnnwL2wGfZWFT0cPkU27OCdw2x/kpbeVqFvxdLQZtA/28ao8Puez
         1A7rc8OfXjWkuoAPv5mAxqGxzUbKiAe6+B/JP8sw0PyhwCe20f/n0IRfwKhmi2B13uZI
         r1VRFf16AgrEPllr79nX+y183jAWfqGVQRUWbTCqoiToZFv+8F8gj6CCFRLL/2CO4f6v
         lYBok2mk3VL3HC3XoC0IGBMq9BKTOPdw455QsqL0TsBsyq4qhRzQVeQXPCoiqljDKVKF
         hsDmS904QeSyblrUj7QPr/aMQFGF0LjVn0mo+j1js3l14JQ3+OCssFe6uCGW0PbQ+l0x
         SXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dWVNE8WMO4DQqfERbcgjNIYel9+RFTdZZw0u/caF1L0=;
        b=R89hcus+0RIYa5ghfGQWMOUJBGq8DM04QP1cbwCjewDg6Llnz+x/wr3lcbYdk82jfo
         mopfWy1NNdu5aI9XUB01l0vXM4f9T24wYFbRRHmi07w2Qa0nBYROiNHSYyDas+Zd7oeY
         xXWXBUJrEbjk89oBV8vR8KyNCurlqPAve4mMCcW2AQlzJhvMTGc+losqF7DAR6WqHVE7
         80RZqOlkXDgk6aQae0E6ekDsvxM3mgMtJ3YGpjx9WJaaYluzCDjo6anY39Amq8Sh/nQM
         gmNMhzPF56pICNvHovxTWhWd/RLyMwTCn7TTdl5BtXp7emKvLZcTcDR/rV88iwaSpAGO
         BoEQ==
X-Gm-Message-State: ACrzQf0jV87J35bman66GPm4leMA7fjeA+kR2QSbU3qYBpaMuDeNOPLV
        Uev45nqpr0oTaROqYHpIWiutZ4NDW92JmB5G
X-Google-Smtp-Source: AMsMyM5WPsTF+xE1Fh/CLkesZ4AtQEQp1lOsTQvWJrmnU05XbWz0X7V6uYflQ/apjDcdOUUsut+LBw==
X-Received: by 2002:a5d:5963:0:b0:22a:47ed:f98f with SMTP id e35-20020a5d5963000000b0022a47edf98fmr143435wri.155.1663255959050;
        Thu, 15 Sep 2022 08:32:39 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.72])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b003a8418ee646sm3886579wmq.12.2022.09.15.08.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:32:38 -0700 (PDT)
Message-ID: <522952a9-e413-a042-5e76-54329758712b@linaro.org>
Date:   Thu, 15 Sep 2022 16:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v8 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        lee@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>
References: <20220915094453.1872798-1-kavyasree.kotagiri@microchip.com>
 <20220915094453.1872798-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915094453.1872798-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 10:44, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>


> +
> +patternProperties:
> +  "^serial@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Child node describing USART. See atmel-usart.txt for details
> +      of USART bindings.
> +
> +  "^spi@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Child node describing SPI. See ../spi/spi_atmel.txt for details
> +      of SPI bindings.
> +
> +  "^i2c@[0-9a-f]+$":
> +    $ref: ../i2c/atmel,at91sam-i2c.yaml

No improvements here.



Best regards,
Krzysztof
