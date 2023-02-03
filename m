Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F1B68A399
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBCUfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBCUfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:35:13 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9540D8F536;
        Fri,  3 Feb 2023 12:35:11 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-142b72a728fso8018295fac.9;
        Fri, 03 Feb 2023 12:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9ERBz4ssqzLzKfbT0hTgsoHU4vAavbohSqKdl8iOO8=;
        b=XVkZIdTlJTX44BwQXo5td+8aQPwNNqs8eVT04j9olUiWXcHg1buZBCboi+LO8pDb2p
         ezTlU7Eaai2WwZGdC7hnDiRTs51ab4ikthjuB2ryk0/gPjBOw21szhJ4yOEjeRnvE5tl
         ubzdphcyCJwbhP4RTPhiIGRyWbnn6pA5IgqnlGWd9c+TEPi/8qJKNZ/JhEz7pEQkZFlr
         pDKXpFL3rLeADKp0wF2e95l9AFWMR0Bh8bdw0plqXnLKfumB9iA36tIj6/7y7tQOwEtZ
         oKeDaz3vRvFe3eEkTHuL61g1eOg4Y+y9BDBxBDkJhDXQeiq6UDQ5L4oapOloBJo0J/OI
         1UtQ==
X-Gm-Message-State: AO0yUKWyzlNMZiRhIFxRjP2Fu93s4iiXfIqTcUf3holRyXJFEcAZhyIT
        ogW0RSYvnYBZJTY8pI62gA==
X-Google-Smtp-Source: AK7set9oqxoeYrd3aWmIQC9WtHQxxY9KfVyuW6tXP+N3qYxM5BuyCw8u/DRFl64vlrHDIX4b8mA9wg==
X-Received: by 2002:a05:6871:411:b0:163:cd07:a5a5 with SMTP id d17-20020a056871041100b00163cd07a5a5mr6163877oag.56.1675456510702;
        Fri, 03 Feb 2023 12:35:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g1-20020a056870a24100b0014fe4867dc7sm1173616oai.56.2023.02.03.12.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 12:35:10 -0800 (PST)
Received: (nullmailer pid 843783 invoked by uid 1000);
        Fri, 03 Feb 2023 20:35:08 -0000
Date:   Fri, 3 Feb 2023 14:35:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCHv2 1/4] dt-bindings: wiegand: add Wiegand controller
 common properties
Message-ID: <20230203203508.GA841469-robh@kernel.org>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-2-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202143305.21789-2-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:33:02PM +0100, Martin Zaťovič wrote:
> Weigand bus is defined by a Wiegand controller node. This node
> can contain one or more device nodes for devices attached to
> the controller(it is advised to only connect one device as Wiegand
> is a point-to-point bus).
> 
> Wiegand controller needs to specify several attributes such as
> the pulse length in order to function properly. These attributes
> are documented here.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-controller.yaml  | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> new file mode 100644
> index 000000000000..fed90e01e56f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiegand Generic Controller Common Properties
> +
> +maintainers:
> +  - Martin Zaťovič <martin.zatovic@tbs-biometrics.com>
> +
> +description:
> +  Wiegand busses can be described with a node for the Wiegand controller device
> +  and a set of child nodes for each SPI slave on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^wiegand(@.*|-[0-9a-f])?$"
> +
> +  pulse-len-us:
> +    description: |
> +      Length of the low pulse in microseconds.
> +
> +  interval-len-us:
> +    description: |
> +      Length of a whole bit (both the pulse and the high phase) in microseconds.
> +
> +  frame-gap-us:
> +    description: |
> +      Length of the last bit of a frame (both the pulse and the high phase) in
> +      microseconds.
> +
> +required:
> +  - compatible
> +  - pulse-len-us
> +  - interval-len-us
> +  - frame-gap-us
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    wiegand@f00 {
> +        compatible = "wiegand-foo";

You've got a real example in the bitbanged schema, just drop the fake 
one here. You can put about anything in here because it is not getting 
validated.

> +        pulse-len-us = <50>;
> +        interval-len-us = <2000>;
> +        frame-gap-us = <2000>;
> +
> +        /* devices */
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
> 2.39.1
> 
