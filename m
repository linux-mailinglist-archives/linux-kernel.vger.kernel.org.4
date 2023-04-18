Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEED26E6E86
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDRVpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjDRVpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:45:18 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4117C67B;
        Tue, 18 Apr 2023 14:45:09 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5f7341850so897082a34.2;
        Tue, 18 Apr 2023 14:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854309; x=1684446309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKpSiwDvkIJ4Ee0IkVP1leE3m81/FJq1JLmHBimQnb0=;
        b=TKF/oxjFo7VGn1l6+rfU88F0yYz9724S2sED0nqM8XVvr4DEbuOheVkxCoxJgjwIOd
         /tmBd2+Kr4oTBdn3zLef2wjsDRLnn4+hHEJ6kmKYaFgk912hKEjIgdSKY+PkGSEUwx+6
         W36T/ZaBgmbCvV5MLE3VkpbLKM7JGViDxHBefbuqzi4DCD3eNX/KTwx5rS6YHUEG+xqp
         39Nnn9TSmjR+5rpn4G4fzLeP0NgYJDT72jyE+7W5ZbKmO4bE4XW3t0jSqFxqgd4XDYeF
         sxzmkQoUATK4MAlAylUOMD7wnY0ebKy7vo9ylTZQD3NTPbFS4ljwNIG6cFn8oyLQqSjl
         WTrA==
X-Gm-Message-State: AAQBX9ccAJnk3IM+j7fe0DRSZurUz6nQgHveEN+9sSRXP1TuO1Hxa862
        UOWnIUS1XrG2KDUNPWJ8Mw==
X-Google-Smtp-Source: AKy350YOCKZIn8qwH+HZXgrE3U7IfJnx4tOh/Ek/I9oSrTeZ/BLeqYlOwRESU5x2BXf1lvF6X1eWUA==
X-Received: by 2002:a05:6871:8a1:b0:177:b208:af7c with SMTP id r33-20020a05687108a100b00177b208af7cmr1978130oaq.54.1681854309097;
        Tue, 18 Apr 2023 14:45:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020a056870414400b0017ae909afe8sm6086325oad.34.2023.04.18.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:45:08 -0700 (PDT)
Received: (nullmailer pid 2383368 invoked by uid 1000);
        Tue, 18 Apr 2023 21:45:07 -0000
Date:   Tue, 18 Apr 2023 16:45:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/3] dt-bindings: panel: Add Samsung S6D7AA0 LCD
 controller bindings
Message-ID: <20230418214507.GA2380126-robh@kernel.org>
References: <20230416100139.13741-1-aweber.kernel@gmail.com>
 <20230416100139.13741-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416100139.13741-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 12:01:37PM +0200, Artur Weber wrote:
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  .../display/panel/samsung,s6d7aa0.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> new file mode 100644
> index 000000000000..969cef7738b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Artur Weber <aweber.kernel@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6d7aa0-lsl080al02
> +
> +  reg: true
> +  reset-gpios: true
> +  backlight: true
> +
> +  enable-supply:
> +    description: Enable supply

If there's only a single supply, then why not use panel-simple-dsi.yaml?

> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - enable-supply
> +  - backlight
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "samsung,s6d7aa0-lsl080al02";
> +            reg = <0>;
> +            enable-supply = <&lcd_enable_supply>;
> +            reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
> +            backlight = <&backlight>;
> +        };
> +    };
> +
> +...
> -- 
> 2.40.0
> 
