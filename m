Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD44F5BB2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiIPT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIPT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:26:49 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EBCB2CC2;
        Fri, 16 Sep 2022 12:26:48 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127ba06d03fso53545878fac.3;
        Fri, 16 Sep 2022 12:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ke1TOcq52Y6OwDXCGQ05OBtNCNaVL02BAxNe0NDeJo8=;
        b=ivsTUMBF4hEy35G9D5SsrE9Ut7UTssSCWMUjP/q/2uFdUDmMc6aTj3sY8Jlf/ODyZQ
         2enJgMZtrYgTLBfjrHlfH1bkn7Nw5Qpd6DDFGTDunzMSXqyNAKuodYZi6Z8JKoGfALxF
         enZky/JTjng8Ss4T+mzzAeDbGQiU5QJcsaor2mvLrtrmvuKIi0wtu6oG+2i7THHXoLe1
         92dmcIcF68fdBushFcZN11SkFrUi+NywOvxYOjldGjaDvYdWDn4U/rVRzCd34hNOW8sh
         AVyPyrSB9ld8dNRC95Y2w/hUcZhZn0u4EoV+Z3OltXVZWmIKyuWz5f36P7nCAw1FQue+
         B32Q==
X-Gm-Message-State: ACrzQf30iVz5JXhcyvRTagy6dZ6yYfOVFRpcEJBfENFjKNH4zjNv0xTF
        3ZqQuAbUCge7paikiw0StQ==
X-Google-Smtp-Source: AMsMyM4U9+tZj3zH2CTItuqDwEA1iIjQf8jTkrlZO11xz26CMMNWw0vnqIxdHMIbX2j/QzAsrO99Kw==
X-Received: by 2002:a05:6871:212:b0:122:6ce2:16a2 with SMTP id t18-20020a056871021200b001226ce216a2mr3810217oad.227.1663356407809;
        Fri, 16 Sep 2022 12:26:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u35-20020a4a8c26000000b004729c1d519csm9310216ooj.27.2022.09.16.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:26:47 -0700 (PDT)
Received: (nullmailer pid 1125112 invoked by uid 1000);
        Fri, 16 Sep 2022 19:26:46 -0000
Date:   Fri, 16 Sep 2022 14:26:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, mb@lightnvm.io,
        ckeepax@opensource.cirrus.com, arnd@arndb.d, mst@redhat.com,
        javier@javigon.com, mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: uwb: Device tree information for Nxp
 SR1XX SOCs
Message-ID: <20220916192646.GA1112472-robh@kernel.org>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-2-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914142944.576482-2-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:59:43PM +0530, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Link: https://lore.kernel.org/r/20220527184351.3829543-2-manjunatha.venkatesh@nxp.com
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
> Changes since v4:
>   - Devicetree documentation updated as per the review comments
>   - Text Aligment related issues are addressed
> 
>  .../bindings/uwb/nxp,uwb-sr1xx.yaml           | 63 +++++++++++++++++++

Use compatible string for filename.

>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> new file mode 100644
> index 000000000000..0f8c774b8306
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

Why 3 clause? Everywhere else for bindings is using BSD-2-Clause

> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/uwb/nxp,uwb-sr1xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ultra Wide Band(UWB)driver support for NXP SR1XX SOCs family

Bindings describe h/w devices, not drivers.

> +
> +description: The nxp-sr1xx driver works for the NXP SR1XX series of Ultra Wide
> +    Band devices namely, SR150 and SR100T devices, and uses UWB Controller Interface (UCI).
> +    The corresponding details are available in the FiRa Consortium Website.
> +    (https://www.firaconsortium.org/). More details on the SR1XX Family can be
> +    found at https://www.nxp.com/products/:UWB-TRIMENSION

Blank line.

> +maintainers:
> +  - Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,sr1xx
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 45000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* for Raspberry Pi with pin control stuff for GPIO irq */
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    fragment@1 {
> +        target = <&spi0>;
> +        __overlay__ {

Remove overlay details from example. This should be just 'spi {'.

The schemas ignore '__' nodes so your example is not getting tested (and 
has errors).

> +            /* needed to avoid dtc warning */
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            status = "disabled";

Examples should be enabled. Drop.

> +
> +            sr1xx: sr1xx@0 {
> +                compatible = "nxp,sr1xx";
> +                reg = <0>;    /* CE0 */
> +                /* GPIO_24 (PIN 18) Host Irq*/
> +                nxp,sr1xx-irq-gpio = <&gpio 24 0>;

Use 'interrupts'. Also, not documented.

> +                /* GPIO_18(PIN 12) Chip Enable*/
> +                nxp,sr1xx-ce-gpio = <&gpio 18 0>;

-gpios is the preferred form.

> +                /* GPIO_23(PIN 16) Read Indication from Host to SR1xx*/
> +                nxp,sr1xx-ri-gpio = <&gpio 23 0>;
> +                /*max supported frequency */
> +                spi-max-frequency = <20000000>;
> +            };
> +        };
> +    };
> --
> 2.37.2
> 
> 
