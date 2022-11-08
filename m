Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCE621181
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiKHMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKHMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:54:15 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1038A8;
        Tue,  8 Nov 2022 04:54:15 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-12c8312131fso16116535fac.4;
        Tue, 08 Nov 2022 04:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DE+XyWQiVN5ob054jGunfYyC5EmPdaoUKQ02JS4SQzY=;
        b=DfM7yMF9nzWYjHWSL0u+NAj3D7PgWVKS45C8nwoDqDT8uqEV4KWLNvVsU3cr9cz40x
         zTdmNHvqE3TejxyFZk0BLopLksVk2HaPk4exujP46nvhorjVwfQfwXLxO3KnRf6S1uO6
         t+stJKjSKkEGJbnYKIl22Jm0jtlyZ/j4GsZFdytzQaaj2ikanSfwakJOFhi6iBG7VA5D
         x6RgH9Ptb03g6+RHjd7mV7V9c+LSVz84XyjgPlFoPKN0FUM/wC2ZsUY/l0nAQkGiQEAB
         YfD7i5a7CebFLlK8Ic+ybuCz/iUHD6a33jpWt4ACz325QrTDe96lb91F9zmyrl5d+ZaM
         pjPw==
X-Gm-Message-State: ACrzQf1aOH1c+jxTYdX9bCvkyhJ/gl0Xr4rHKu2wLZe9dYWt6Q7NOSi9
        U5TdMvGhze/mE/2LRC+Nqg==
X-Google-Smtp-Source: AMsMyM7wgArqbuF5lY4XwPob9rxcmWPy8aaAYCeDk+Dhw5/7qAQJlOjnkzlSx1eXSdY3/4ET2jQfyQ==
X-Received: by 2002:a05:6870:6086:b0:132:e9d6:ea36 with SMTP id t6-20020a056870608600b00132e9d6ea36mr44309846oae.116.1667912054075;
        Tue, 08 Nov 2022 04:54:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m8-20020a4aab88000000b00480816a5b8csm3141349oon.18.2022.11.08.04.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:54:13 -0800 (PST)
Received: (nullmailer pid 3254925 invoked by uid 1000);
        Tue, 08 Nov 2022 12:54:14 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, JJLIU0@nuvoton.com,
        devicetree@vger.kernel.org, KWLIU@nuvoton.com,
        linus.walleij@linaro.org, openbmc@lists.ozlabs.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, robh+dt@kernel.org
In-Reply-To: <20221108092840.14945-4-JJLIU0@nuvoton.com>
References: <20221108092840.14945-1-JJLIU0@nuvoton.com>
 <20221108092840.14945-4-JJLIU0@nuvoton.com>
Message-Id: <166791192799.3252677.10703620015363460099.robh@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
Date:   Tue, 08 Nov 2022 06:54:14 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Nov 2022 17:28:40 +0800, Jim Liu wrote:
> NPCM750 include two SGPIO modules.
> Each module supports up to 64 input and 64 output pins.
> the output pin must be serial to parallel device(such as the hc595)
> the input in must be parallel to serial device(such as the hc165)
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v2:
>    - modify description
> ---
>  .../bindings/gpio/nuvoton,sgpio.yaml          | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/gpio/nuvoton,sgpio.example.dts:35.3-36.1 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/gpio/nuvoton,sgpio.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

