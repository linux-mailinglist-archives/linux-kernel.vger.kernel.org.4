Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB05FBB97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJKTxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJKTxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:53:41 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3B786EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:53:39 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id mx8so9638142qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkjqyCLcH0N/ljiHl8TEG1M58cCur9eaf7o2DgbfK7M=;
        b=gd/3D6U+MJ4kQ1y3Bo0M/s0QGsYG0uopYB6SRJq+A9qTNcudjHqEUXmNOLPLoNkNou
         nzMD49dZs05kvGec66Dc3/QvAMU4nS9jO4PoFfwqG9dh/9OTw/xHtD+sE6Jccmt+MUnH
         CK+h5BkuHN+7fXG3SFyw86mWKOqF49TFDoITSqJFvaLK4IhR5QYrhtOw1MPdBHFs4RjQ
         Q1VMp+5EBMH5SD+4Dzqgvengo8hMIN6w/p2ghZg/GjSuAat1FvD+iIZ6GG0GOnqGRtrD
         GaGw71qmN2boneC1Zn29B6rOK3NlbdToIq3zkSi8z8gUe2l2v6az4Qmrs8qAFGmWW4kd
         sQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkjqyCLcH0N/ljiHl8TEG1M58cCur9eaf7o2DgbfK7M=;
        b=Y0IgP0T638xdTRN8h5b4prALYimWyGj55YQ6Ht+NpVu31P5YEL/4iHpRT4mS7mc7+X
         yKJQvhIHY2btg/z2mWFiWXBgz7UpRuDMSThGHkgb0y5sEoTWh2+ffO2ilMz+hSMU2WnX
         cyrOT3eYtUhS4CLtHnAgSVcbUGTvFiKJtxwJ5aYr3TcGFAuf6ycC1mLBrRxFGR3fKwig
         SpbMJCqRItr+LQF9vTSE12CA8DwdHfsSZV80hyW33NYRamQ+Cb7K7S9/wKVorX/z+0rj
         NKe3MSiTjEFmUwKAn9y6jfCgNWjtauuCMTgv6SElJs3ftEzigjbs78XlFvC83Qnr/jLE
         UaCg==
X-Gm-Message-State: ACrzQf1+MJ88Ktw3dC4vXOfNmI5YRzFtyJh6LrXJ4mzG5wx8JrGlCjzk
        UthQg7/V4HawfitVrYfxjdFWWw==
X-Google-Smtp-Source: AMsMyM5QPhVTqr2jBGvl4UTdKo9Xp+i5nZ5MT/iSBPIjc/KHYVqT3KmFL7fxAx/V6PCmJasP+7falg==
X-Received: by 2002:a05:6214:20e2:b0:4b4:c0c:96db with SMTP id 2-20020a05621420e200b004b40c0c96dbmr8738006qvk.131.1665518018781;
        Tue, 11 Oct 2022 12:53:38 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05620a179200b006ce2c3c48ebsm13555025qkb.77.2022.10.11.12.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:53:37 -0700 (PDT)
Message-ID: <4b3b4e06-bb02-aa66-eca4-82ee59b0e47d@linaro.org>
Date:   Tue, 11 Oct 2022 15:51:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011185525.94210-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 14:55, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The hpe,gxp-plreg binding provides access to the board i/o through the
> Programmable logic interface. The binding provides information to enable
> use of the same driver across the HPE portfolio.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/soc/hpe/hpe,gxp-plreg.yaml       | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
> new file mode 100644
> index 000000000000..cdc54e66d9a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/hpe/hpe,gxp-plreg.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both lines.

> +
> +title: HPE GXP Programmable Logic Registers Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hpe,gxp-plreg
> +      - const: simple-mfd
> +      - const: syscon

Blank line

> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true

This must be false... and then you will see the errors to fix.

> +
> +examples:
> +  - |
> +    cpld@1e789000 {
> +      compatible = "hpe,gxp-plreg", "simple-mfd", "syscon";
> +      reg = <0x1e789000 0x1000>;
> +      fan1 {

fan (or fan-1)

> +        bit = <0x01>;
> +        inst = <0x27>;
> +        id = <0x2B>;
> +      };
> +      iopled1 {

led or led-1?

> +        on = <0x04 0x01>;
> +      };
> +      pwrbtn {

power-button?

> +        latch = <0xFF 0xFF 0x04>;

Keep lower case hex everywhere.

> +      };
> +    };
> +

Best regards,
Krzysztof

