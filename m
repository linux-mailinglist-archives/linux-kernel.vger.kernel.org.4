Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C8671F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjAROTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjAROTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:19:07 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3FF62D3E;
        Wed, 18 Jan 2023 06:00:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k18so12943682pll.5;
        Wed, 18 Jan 2023 06:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X9t7ufkd2EkdshQLKnA3SFrv5rmVPIr/Hi7nOCZDw5c=;
        b=EBzEL7qb0k674EUQUfYhxoHectKIbEkxILdLeZMsthCgCpqziD8YYeh+ISEUK+H0rt
         yBKg4w6JKskKG3aMTV3z48OBmalZW41eI3ToSjmxoFpQ0whb7zsYF9YWGQkN1tXYd+5r
         3WQFY0AFq8KERF8NYtUVrOnjYyU0VhhJfALB99l+6dS1xm3NV+HvawPJiPfZp1Xqgi5T
         FEGZ5aG/7aOHKbUpnFmyj0vKL3IY8j91QYHRYQsGpLGKiFXiP/MZp4A39UwHNGtjVREj
         YE2+vwyFcC2uj+L/dLo8y0j4rDaTtxKtreqinNPoMrred0acZ74OWjTaolWQS9d1vtRy
         +UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9t7ufkd2EkdshQLKnA3SFrv5rmVPIr/Hi7nOCZDw5c=;
        b=Ap/ViVwZUPqgBWEjJlhuiQfdzdkQRgeKbe8EUIFp2p+WJU6uS0rlt5kH1n4qjOxvuM
         nQK0N6nokWl7OV1VidUF/zj1QY5LbMC8EvEiszfZp2Zf3nhFW+VsQk5CEpp4YRirpmyJ
         pP19i+VDmb0HNt3fI6A4IlEpA8zk1D2z2Cn86ftcMkicy5VsJ3kOGZLxXzmdG3t/LpTN
         BQgxOx+hX7ug5l3BkUwvrqn79L7A1b1YY9QoaCOEHw5upt5meSn/fUEKfD9vPekOSsLI
         30/AvwWgxp4n9lBimy89zpsiNQUUp2NVctoqC+nJsPvrcMhzz86Hy+D3Zq1CPcEnEa4U
         zQhA==
X-Gm-Message-State: AFqh2kri9SjDfWeTBJTZLJ48XhvDZTP/h/mlpynGGDb4v00UYr2QZ94s
        jy17Z5roN7B3kj+kwSpOb92HkP8XwwHH8A==
X-Google-Smtp-Source: AMrXdXuhQmSrA8Cqhd01EKQ9K+DXdyRft3dUY4vZYmOODnEXwQbp2dOgQ3iZ3YnS/+ERzdF/gwlF0A==
X-Received: by 2002:a17:90b:3586:b0:229:772c:a00b with SMTP id mm6-20020a17090b358600b00229772ca00bmr7100810pjb.14.1674050438708;
        Wed, 18 Jan 2023 06:00:38 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090a4f4700b002298e0641b6sm1357081pjl.27.2023.01.18.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 06:00:37 -0800 (PST)
Date:   Wed, 18 Jan 2023 22:00:29 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y8f7fbEJ0E6QQ0lZ@Gentoo>
References: <20230118131002.15453-1-lujianhua000@gmail.com>
 <1a8c006d-c9b9-9fd0-147e-7e511cb236fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a8c006d-c9b9-9fd0-147e-7e511cb236fe@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:40:00PM +0100, Krzysztof Kozlowski wrote:
> On 18/01/2023 14:10, Jianhua Lu wrote:
> > Add Kinetic KTZ8866 backlight binding documentation.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Remove "items" between "compatible" and "const: kinetic,ktz8866"
> >   - Change "additionalProperties" to "unevaluatedProperties"
> > 
> > Changes in v3:
> >   - Add Krzysztof's R-b
> > 
> > Changes in v4:
> >   - Drop Krzysztof's R-b
> >   - Add some new properties
> > 
> > Changes in v5:
> >   - Add missing enum under property description.
> >   - Rename uncorrect properties.
> > 
> > Changes in v6:
> >   - Correct wrong property suffix and description.
> > 
> >  .../leds/backlight/kinetic,ktz8866.yaml       | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > new file mode 100644
> > index 000000000000..ca0deba14523
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Kinetic Technologies KTZ8866 backlight
> > +
> > +maintainers:
> > +  - Jianhua Lu <lujianhua000@gmail.com>
> > +
> > +description: |
> > +  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
> > +  with dual lcd bias power.
> > +  https://www.kinet-ic.com/ktz8866/
> > +
> > +allOf:
> > +  - $ref: common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: kinetic,ktz8866
> > +
> > +  current-num-sinks:
> > +    description: Number of LED current sinks.
> > +    enum: [1, 2, 3, 4, 5, 6]
> > +
> > +  current-ramping-time-ms:
> > +    description: LED current ramping time in milliseconds.
> > +    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
> > +
> > +  led-ramping-time-ms:
> > +    description: |
> > +      LED on/off ramping time in milliseconds, note that the case 0 will be mapped
> > +      to 512μs because ktz8866 can't ramp faster than it.
> 
> Aren't you just missing supplies here and their ramp up time?
>
backlight ic supply bias power to panel, but downsteam devicetree adds power supplies node to panel node, 
so I'm not sure if need to add power supplies to backlight node.
> > +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
> > +
> > +  enable-lcd-bias:
> > +    description: Set if we want to output bias power supply for LCD.
> 
> Is it a generic property? I don't see any other users, so this looks
> device specific thus needs vendor prefix.
> 
> This applies to all of the properties. They might be generic or might
> not, I don't know the backlight hardware that much.
It surely is device specific, thanks.
> 
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    backlight {
> > +        compatible = "kinetic,ktz8866";
> > +
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&bl_en_default>;
> > +
> > +        current-num-sinks = <5>;
> > +        current-ramping-time-ms = <128>;
> > +        led-ramping-time-ms = <1>;
> > +        enable-lcd-bias;
> > +    };
> 
> Best regards,
> Krzysztof
> 
