Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6BE6616AA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjAHQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjAHQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:30:22 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E7DEBF;
        Sun,  8 Jan 2023 08:30:19 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id h10so4606327qvq.7;
        Sun, 08 Jan 2023 08:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/FqRsfXO1DjBsMGeJh0QbN/C37X9/vpdavD7uL6LTA=;
        b=krKNXoP/eCKt4wyvMBDoGj08opSWruw1xlgFFd1ymrE+Fyv3qDSbydepGL48bUOTfU
         Xdtilgc9RPqtP1lz+edqt6y4kvZw/tz3qTBE7H8ZwaV4fYApUSLPtbUIZ0qBaVLVsno8
         5H8uHFik1oKhecM3651GCzGhWaw4B+GV8FSFJN6VJtDUsKCNE4NnzcJ3/4pUeeCX3NAo
         jLx8cCCsjhxFPozSc7aBjc7PtYsA8rgkI1MAfoTFEogu51IR4g8i3gDhKM6NPkWT7BUK
         dPVnMdoRSjXQZ11guM+maSOYTuSLOjQu7Q5pHF6IE5tD7GzzvEE3vdvRPf6CIVYRhhze
         2CKg==
X-Gm-Message-State: AFqh2kqYbK70RRn3s5fU5dEHp+RkoNENwCONr7Iki9Rqvt8NQ9JfD7AH
        Uh4HGn+ZImvYcPpnso06q/ZP0xvSUg==
X-Google-Smtp-Source: AMrXdXvqzbL+Y6fMw036sjbDKRf1BazN29cfB9wgYujfdEp4GDX0M9FsHuGcMsj4jhR48a8f9Hwazg==
X-Received: by 2002:ad4:4111:0:b0:532:2f1a:33a with SMTP id i17-20020ad44111000000b005322f1a033amr1289969qvp.46.1673195418713;
        Sun, 08 Jan 2023 08:30:18 -0800 (PST)
Received: from robh_at_kernel.org ([2607:fb90:17d0:d514:35f:cc8b:f0bd:c2eb])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b006bb82221013sm3905783qkb.0.2023.01.08.08.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 08:30:18 -0800 (PST)
Received: (nullmailer pid 29129 invoked by uid 1000);
        Sun, 08 Jan 2023 16:30:11 -0000
Date:   Sun, 8 Jan 2023 10:30:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: add Wiegand controller dt-binding
 documentation
Message-ID: <20230108163011.GA11262-robh@kernel.org>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-2-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104133414.39305-2-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:34:12PM +0100, Martin Zaťovič wrote:
> A Weigand bus is defined by a Wiegand controller node. This node
> can contain one or more device nodes for devices attached to
> the controller(it is advised to only connect one device as Wiegand
> is a point-to-point bus).
> 
> Wiegand controller needs to specify several attributes such as
> the pulse length in order to function properly. These attributes
> are documented here.

For the subject, drop 'dt-binding documentation'. That's already stated 
once.

> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-controller.yaml  | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> new file mode 100644
> index 000000000000..645306c65d43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0 OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiegand Controller Generic Binding

s/Binding/Common Properties/

> +
> +maintainers:
> +  - Martin Zaťovič <martin.zatovic@tbs-biometrics.com>
> +
> +description: |

Don't need '|'.

> +  Wiegand busses can be described with a node for the Wiegand controller device
> +  and a set of child nodes for each SPI slave on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^wiegand(@.*|-[0-9a-f])*$"

'?' instead of '*' for the last '*'.

 
> +
> +  compatible:
> +    maxItems: 1

Drop 'compatible' as the specific controller has to list this anyways. 
Also, a controller can have as many compatible strings as it wants.

> +    description: Compatible of the Wiegand controller.
> +
> +  data-high-gpios:
> +    maxItems: 1
> +    description: GPIO used as Wiegands data-hi line. This line is initially
> +      pulled up to high value. Wiegand write of a bit of value 1 results in
> +      this line being pulled down for pulse length duration.
> +
> +  data-lo-gpios:
> +    maxItems: 1
> +    description: GPIO used as Wiegands data-lo line. This line is initially
> +      pulled up to high value. Wiegand write of a bit of value 0 results in
> +      this line being pulled down for pulse length duration.
> +
> +  pulse-len-us:
> +    maxItems: 1
> +    description: Length of the low pulse in microseconds.
> +
> +  interval-len-us:
> +    maxItems: 1
> +    description: Length of a whole bit (both the pulse and the high phase)
> +      in microseconds.
> +
> +  frame-gap-us:
> +    maxItems: 1
> +    description: Length of the last bit of a frame (both the pulse and the
> +      high phase) in microseconds.
> +
> +  slave-device:

A slave device should be named for the class of device it is, not 
'slave-device'. Just drop all of this as there's no way to match a node 
name.

> +    type: object
> +
> +    properties:
> +      compatible:
> +        description:
> +          Compatible of the Wiegand device.
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - pulse-len-us
> +  - interval-len-us
> +  - frame-gap-us
> +
> +additionalProperties: false

Common bindings should be 'true'.

> +
> +examples:
> +  - |
> +    wiegand@f00 {
> +        compatible = "wiegand-gpio";
> +        data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +        data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +        pulse-len-us = <50>;
> +        interval-len-us = <2000>;
> +        frame-gap-us = <2000>;
> +        status = "okay";

Drop 'status'.

> +
> +        wiegand-foo-device {
> +                compatible = "wiegand-foo";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f86d02cb427..db9624d93af0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22428,6 +22428,11 @@ L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	drivers/hid/hid-wiimote*
>  
> +WIEGAND BUS DRIVER
> +M:	Martin Zaťovič <m.zatovic1@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> +
>  WILOCITY WIL6210 WIRELESS DRIVER
>  L:	linux-wireless@vger.kernel.org
>  S:	Orphan
> -- 
> 2.38.1
> 
> 
