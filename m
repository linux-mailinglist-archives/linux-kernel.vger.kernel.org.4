Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29636A9269
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCCI2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCCI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:28:48 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD40193F3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:28:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d30so7246780eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677832105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNoh7Y1eCqw1vILTrX20qgBsgHaoKEZRgMQ7Y2gIJPo=;
        b=TFZ/47LHMyE5A2PfNGsk2pMHpoLlfD+CLOyn7J57fS5+aqQBd8LdoKsTUkmufj55dZ
         5JG74u7zawpRBTIXLULjRMfc3ZLmuMtsA3Lu9I+fj5yLdMTt2Dpob2UzqK/vQ4fRF3Be
         Ohwpi7u2xVkLvopc0D0HwFEuR59z9yfiGUIxD6aNf4XRgOJTWbTRBMOcaM4bWtwP/Fxr
         IoX9rsGvL9/5IB0EDLyoDYeoAR7Tc/PL2YEVbfJUXOP9yFUIs6iFOANuDWqf6+XCOR/S
         gT4ggcGE+o+o7gvPLKH5+VXfkJkn+JVc29OEFdhZsVfRbO1//IknXAKmihP+kpjhxEt6
         /JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNoh7Y1eCqw1vILTrX20qgBsgHaoKEZRgMQ7Y2gIJPo=;
        b=4GVOlZ2icyU2JUKc0vXCNEoGApUh7vrmUKy0+1+Q7gvQ/bBw+NAgbR/Zzh8H2FIfc2
         OVx5RfCud6FApFCUqThT3x3rITLIH6eY2EioIwn3MREx2POCH/aOqSslkEwq6cWKg8fp
         +O8sDJdH5WPUXESJtrtLhx7Vccu72Ft72nsKvmydEDu3mxLrCieOAZDbFI1iiTFcd2k0
         nyer9HknhIWDBuurnKFnMCdxTZXRDSVyzeRzVnxM9MvAaju9re2L2Gn4lFhtbobRrqz1
         pxyuyVZwFx/wDr83OVQJxC2tFKmfp1nmEENtPl20swxTsjFMHEvsO3VhrNzrW6mz3yVW
         s1zw==
X-Gm-Message-State: AO0yUKXMJBYZ7r9ErFwpQg2f8p32FIoGChDSfH/2ZqcxcnWB9MFzHbgc
        ZlSLd7GXcetVgTSaOFqaEhqGUg==
X-Google-Smtp-Source: AK7set8JDCyuD/jVEdIdZMzgRpBie4AkpO5CKfVjB2ToMCxzT2bGHuZqG7hjF2gthEYJRlfjPM0geg==
X-Received: by 2002:a17:906:ee8d:b0:86f:d0c9:4bdd with SMTP id wt13-20020a170906ee8d00b0086fd0c94bddmr1115380ejb.27.1677832105526;
        Fri, 03 Mar 2023 00:28:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f21-20020a50d555000000b004c059535b43sm883895edj.31.2023.03.03.00.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:28:25 -0800 (PST)
Message-ID: <6a950a51-fe90-9163-b73d-0a396d7187ee@linaro.org>
Date:   Fri, 3 Mar 2023 09:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 3/5] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-4-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301183759.16163-4-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 19:37, Dmitry Rokosov wrote:
> Add the documentation for Amlogic A1 PLL clock driver, and A1 PLL
> clock controller bindings.
> Also include new A1 clock controller dt bindings to MAINTAINERS.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  include/dt-bindings/clock/a1-pll-clkc.h       | 20 +++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> new file mode 100644
> index 000000000000..8bd2c948df86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson A/C serials PLL Clock Control Unit
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a1-pll-clkc
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: input fixpll_in
> +      - description: input hifipll_in
> +
> +  clock-names:
> +    items:
> +      - const: fixpll_in
> +      - const: hifipll_in
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/a1-clkc.h>

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@7c80 {
> +            compatible = "amlogic,a1-pll-clkc";
> +            reg = <0 0x7c80 0 0x18c>;
> +            #clock-cells = <1>;
> +            clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
> +                     <&clkc_periphs CLKID_HIFIPLL_IN>;
> +            clock-names = "fixpll_in", "hifipll_in";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39ff1a717625..8438bc9bd636 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1895,6 +1895,7 @@ L:	linux-amlogic@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/amlogic*
>  F:	drivers/clk/meson/
> +F:	include/dt-bindings/clock/a1*
>  F:	include/dt-bindings/clock/gxbb*
>  F:	include/dt-bindings/clock/meson*
>  
> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h

Filename matching bindings, so amlogic,a1-pll-clkc.h

> new file mode 100644
> index 000000000000..3a559518c6e6
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-pll-clkc.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */

Any particular reason for using license other than in binding? Was it
intentional (e.g. because it is derivative work)?

> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>


Best regards,
Krzysztof

