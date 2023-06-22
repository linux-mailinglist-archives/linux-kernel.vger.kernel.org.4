Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA88A739550
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjFVCNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFVCNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:13:07 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8AAC;
        Wed, 21 Jun 2023 19:13:06 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-34220bb6a80so21522975ab.0;
        Wed, 21 Jun 2023 19:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399986; x=1689991986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j95uarGP35hPSWnjSMr+fwYBKOEPZAg+794kgrinkk4=;
        b=Y/y71k3J4WV+C+rQrX6xzNJaSMdhipCDKYmeDZLxNIUKBGx4cQKfOzyT4krunbn86V
         0cDjC+8T74w4mXRjY64enG99rTHqU3z8+kHBQqfjqqnTMUthzfgWF5YIEfxg9dPJbBYr
         ZWFfOG08b+aWcm2BBBxqsinuVs2rTp1mvsbsIiXmB6NC9CV8NpMGl0aDJ0m01wfbnALN
         P2252teF2AKOaHBp6zDYf2IHIipaWYtPzIQedP8EyCwX5ltNplkTKulHkWROi8rS7yYi
         OMI6JKXhobsnHdG7ygo926qYQUCIIETtXn1JtzjdkQKqipQnbTzG4y0G8U+pRC4AqQc0
         cXqw==
X-Gm-Message-State: AC+VfDzz9kJXTvxwXyNfRSvkIcLj9cFFHJuJkCbG2UMiM726my4RkU6+
        oqLF+S1RVw8UXQEDnDRRoA==
X-Google-Smtp-Source: ACHHUZ60xJYjxvtQhBhgAxqfQ0q0sG6xeGQalleS7tfQti6tA1HN+oiqOyA3+97Ja+MFSuyE+l3jBA==
X-Received: by 2002:a92:cac8:0:b0:340:c382:f6bb with SMTP id m8-20020a92cac8000000b00340c382f6bbmr12037373ilq.26.1687399985736;
        Wed, 21 Jun 2023 19:13:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a92d90b000000b00333b5ae4ab7sm1684468iln.87.2023.06.21.19.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:13:05 -0700 (PDT)
Received: (nullmailer pid 75083 invoked by uid 1000);
        Thu, 22 Jun 2023 02:13:03 -0000
Date:   Wed, 21 Jun 2023 20:13:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: document new property
 default-brightness-level
Message-ID: <20230622021303.GA68330-robh@kernel.org>
References: <20230621215457.11297-1-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621215457.11297-1-alex@shruggie.ro>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:54:56AM +0300, Alexandru Ardelean wrote:
> From: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> Add documentation for new default-brightness-level property.

Why?

> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
> 
> Link to original patch:
>   https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98
> 
> Changelog v1 -> v2:
> * https://lore.kernel.org/dri-devel/20230519200520.10657-2-alex@shruggie.ro/
> * removed 'brightness-levels' reference
> * updated doc-text for 'default-brightness-level'
> * updated doc-text for 'default-on'
> * added 'minimum' & 'maximum' to 'default-brightness-level' property
> * removed 'Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>' as
>   requested
> * patch is first in series of 2 patches (was second patch)
> 
>  .../bindings/leds/backlight/gpio-backlight.yaml    | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> index 584030b6b0b9..2da6552a207c 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> @@ -20,9 +20,21 @@ properties:
>      maxItems: 1
>  
>    default-on:
> -    description: enable the backlight at boot.
> +    description:
> +      The default power state of the backlight at boot.
>      type: boolean
>  
> +  default-brightness-level:
> +    description:
> +      The default brightness level on device init. The value can be 0 or 1.
> +      If omitted, the value is 1. In the context of the "gpio-backlight" driver
> +      the effect of this setting will be that the backlight is on/off.
> +      The difference between this setting and "default-on" is that this handles
> +      brightness, while "default-on" handles the power setting of the device.

What power setting? You only have 1 GPIO to control here which is 2 
states. I fail to see why you need 6 possible states with all the 
combinations of 2 properties.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1
> +
>  required:
>    - compatible
>    - gpios
> -- 
> 2.40.1
> 
