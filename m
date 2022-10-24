Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5760B477
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiJXRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiJXRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:45:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3E1E0996;
        Mon, 24 Oct 2022 09:21:05 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id g10so11328162oif.10;
        Mon, 24 Oct 2022 09:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmB3s2OqT66rk7MgqqeQlYz/bdEkGy0qgYIJeA+CLy0=;
        b=FnOFaJ798AxvaRulplcwTZJhJ0Buvqy54tQAH+JiCsqQCYisMfdawARe6FxTB/sXPz
         pfM28WLF9zUc6Atl08zL9WaWAYNpvCu/hxRowDXVWqJbRaQzoSumXhqhUkHYw9qDje5f
         D4e0RWdBqYCrzjaxw25HfH/NKBxAlqXX5szyJAq5tk+Vnnamr+MplNDrPeqr0x8zZxp5
         FWT65b5ShPpOSFbcvubbVIWh/pRYGcdMxWVE3/RgrRxtXbgjZEO6Uu9l0BT5eBsup8VS
         g4PNhnqPE8/yq/tmJrCZNew5m6AiETdeMuyoxTqMMWozqUwLWlgDFIBh79eYJ1C3EgAk
         9t8w==
X-Gm-Message-State: ACrzQf0hPbDOEYY86bPBwWeAJysCdzxScObtmk+8cMlI/0wZ7YMqVbls
        IVYobjabJe467ZuzweFz8Vwr8l3SWw==
X-Google-Smtp-Source: AMsMyM5GgVf+Fq2zW0aTr2tqUvK6jEfRogxjv/ZwsWgOlV1NxE7O2hFWOphibJoEQeTRkOA57/pCWg==
X-Received: by 2002:aca:3083:0:b0:355:afb:cdb5 with SMTP id w125-20020aca3083000000b003550afbcdb5mr28020261oiw.110.1666628285473;
        Mon, 24 Oct 2022 09:18:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c23-20020a056808105700b0035486165f4csm3334oih.37.2022.10.24.09.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:18:04 -0700 (PDT)
Received: (nullmailer pid 1869834 invoked by uid 1000);
        Mon, 24 Oct 2022 16:18:06 -0000
Date:   Mon, 24 Oct 2022 11:18:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20221024161806.GA1855651-robh@kernel.org>
References: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
 <20221013094838.1529153-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013094838.1529153-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:48:36AM +0200, Naresh Solanki wrote:
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..224f5013c93f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulses-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  default-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.

So if we unload and reload the driver module, it should go back to the 
default? 

I think it is really, 'target RPM if not already configured' which could 
be keep the setting from a register (e.g. what the bootloader set) or 
perhaps you already have temperature information to use...

> +    $ref: /schemas/types.yaml#/definitions/uint32

> +  pwm-frequency:
> +    description:
> +      PWM frequency for fan in Hertz(Hz).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-polarity-inverse:
> +    description:
> +      Inverse PWM polarity for fan.
> +    type: boolean

As I said before, the PWM binding handles these 2 settings. Use it. Yes, 
it's a bit of an overkill when the child is the consumer of the parent. 
Until some 'clever' h/w engineer decides to use one of the PWMs for 
something else like a backlight.

Rob
