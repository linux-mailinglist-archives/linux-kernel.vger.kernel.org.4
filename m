Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8D744D5A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGBKrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGBKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:47:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52648E54
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 03:47:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d7f4c1cfeso3887614a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688294832; x=1690886832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doP8CZZyrslCenSYjdf6T/PIt+tCk5F92Ar2E5adtJ0=;
        b=ctacEYA1JK6veFXxDJZFud4r7LN4mBV0X0v7BsVcyc/h8oYdZJGgjQKfYbSclowoaF
         CKs9o5FIk4V/q8HdhxLVMS+Sr42LMHv+2sZCF8mC1KhKgvnJZh+69V4xD+YDMSYvsewV
         WNWMQiagaIhorzQIhS7+M2H2kyDkr2sPp+GZv66P5t8ubtR95qYQhfzLtRQeKW8MHomL
         kxGBUQyE83nuOB1+LLo9XvcMNl6hbj18QP9Xo/33e2Bs36JK0zpsHisRQmtKmyQue+sl
         1pvQidSX7rfr4UOtgA2F6PKiRNJXHbHYojIpxZC8qxgeo+7dS0ixvkqrlbOm2SrYriy4
         k1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688294832; x=1690886832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doP8CZZyrslCenSYjdf6T/PIt+tCk5F92Ar2E5adtJ0=;
        b=j4UjqBen/PNT/Cvfm9TVhkyfhPMMoWnIGnrz9XoDDSiMJqqu90FhGshtQ1c9vL/bZA
         gcRqPKaNjgclO+Tu0chx9VJffZQupFijdNaXuLVQT8Yj+UfjzckwfSmITzFyYuLO3Cqi
         noZdtNrsn5wRQ9KYHzs9MC/R8TZtBIBb67oSZjh385n4teruhH8RaeUmTquqKQ0PPLHK
         puzEl2N3564PzsIPtkuu85YprRc2fKfGEyTafa9xTsHlahf4diG5UDtj1rYX+l5Fq6bp
         YQB5EydU1UVckLSwxBq7sAX+Z/ZAKQWcKaBTGTSh6x7ULh1cisahoXtCrdGN/Yr4Tl15
         YAgg==
X-Gm-Message-State: ABy/qLZrvp5JSsEH9lFCKAL53uviHJtlQU7doRgXJW2Ps2I2FEs51diU
        5MRbj5YXmrreY7CgmiFwIePx4Q==
X-Google-Smtp-Source: APBJJlEUDjmuQNgaEKhIauAAnEoZ97aP9Ydyy4Asa0tJshbXlejAZ3SysQ8kzJrnLsVizDYxGEaxCQ==
X-Received: by 2002:aa7:ca57:0:b0:51d:96de:af6f with SMTP id j23-20020aa7ca57000000b0051d96deaf6fmr5497089edt.0.1688294831756;
        Sun, 02 Jul 2023 03:47:11 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id q14-20020a056402040e00b0051d890b2407sm8550077edv.81.2023.07.02.03.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 03:47:11 -0700 (PDT)
Message-ID: <889bbee2-db9c-c1dd-dc8a-cdc436f1dfd8@linaro.org>
Date:   Sun, 2 Jul 2023 12:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] dt-bindings: media: add mediatek ISP3.0 camsv
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20230628145412.1610260-1-jstephan@baylibre.com>
 <20230628145412.1610260-4-jstephan@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230628145412.1610260-4-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 16:52, Julien Stephan wrote:
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
> 
> This adds the bindings, for the ISP3.0 camsv module embedded in
> some Mediatek SoC, such as the mt8365

Thank you for your patch. There is something to discuss/improve.


> +
> +description:
> +  The CAMSV is a set of DMA engines connected to the SENINF CSI-2
> +  receivers. The number of CAMSVs depend on the SoC model.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8365-camsv
> +
> +  reg:
> +    maxItems: 3

Describe the items (items with description) instead.

> +

...

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +    #include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
> +    #include <dt-bindings/power/mediatek,mt8365-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        camsv1: camsv@15050000 {
> +            compatible = "mediatek,mt8365-camsv";
> +            reg = <0 0x15050000 0 0x0040>,
> +            <0 0x15050208 0 0x0020>,
> +            <0 0x15050400 0 0x0100>;

Fix the alignment.

> +            interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
> +            clocks = <&camsys CLK_CAM>,
> +            <&camsys CLK_CAMTG>,
> +            <&camsys CLK_CAMSV0>;

Everywhere...


Best regards,
Krzysztof

