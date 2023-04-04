Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD286D67A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjDDPkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjDDPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:40:11 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37B359E;
        Tue,  4 Apr 2023 08:39:49 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id w133so24516910oib.1;
        Tue, 04 Apr 2023 08:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2O+0AGvBEdzeTS5JN4tGFGz92A4xFSMh9AjZcNoJIw=;
        b=Y1c2QmodRxXXKc0Rq4piI3/hp43E2O2QvxFEqfufdo51JJkwGl/lC75ZK5Qn3gAR4w
         fTSd3WVjM2y5lDxSXQOhpTrpO2wEKaCwawLEc03Nwqu0UcCWW+sIOgPbPOMypbQWchev
         j1rdgh7+8tzyp4sWz6e8CaffnxKsFn6oCievDHWlAqHMPRhyde4UbkX7VYFvayC99pk5
         Z1g7lfkz5jLCffNIa2Bn/XnCV9UTpDtE+z2XRFDB/2l4bUfxINhQwcKqDJ+WansdTwsN
         2A2xFylybwWTtfcToijpimpwjA0aplGrzKkmMe/sRkw3doirbU0hd8OJtqjsAnGOX6td
         5ezA==
X-Gm-Message-State: AAQBX9dVtQ3Zab/gK2zmX55R7Wh8B/cwea+mdb2QVCksBBq+XjxAcaxS
        weTzzLpSqGaS6Nmv+C3BLTirm6aFZA==
X-Google-Smtp-Source: AKy350bDQydgyv/j+HyVtVq0pxr7h2sYmXDwLX4OquRt8l1QjupxiXSuJyqlwtBUghCsa7+uTjb3vA==
X-Received: by 2002:a05:6808:2a05:b0:387:53ce:4eb3 with SMTP id ez5-20020a0568082a0500b0038753ce4eb3mr1523464oib.48.1680622788523;
        Tue, 04 Apr 2023 08:39:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h38-20020a4a9429000000b0051a6cb524b6sm5522176ooi.2.2023.04.04.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:39:48 -0700 (PDT)
Received: (nullmailer pid 4036268 invoked by uid 1000);
        Tue, 04 Apr 2023 15:39:47 -0000
Date:   Tue, 4 Apr 2023 10:39:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 1/2] dt-bindings: Document TI OPT4001 light sensor
 bindings
Message-ID: <20230404153947.GA4034118-robh@kernel.org>
References: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
 <20230323-add-opt4001-driver-v1-1-1451dcc1bc8a@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323-add-opt4001-driver-v1-1-1451dcc1bc8a@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:07:42AM +0200, Stefan Windfeldt-Prytz wrote:
> Add devicetree bindings for opt4001 ambient light sensor.
> 
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> ---
>  .../devicetree/bindings/iio/light/ti,opt4001.yaml  | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> new file mode 100644
> index 000000000000..cfd6b8b92c17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OPT4001 Ambient Light Sensor
> +
> +maintainers:
> +  - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> +
> +description: |
> +  Ambient light sensor with an i2c interface.
> +  https://www.ti.com/lit/gpn/opt4001
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,opt4001-picostar
> +      - ti,opt4001-sot-5x3

Please explain in the commit message or description of the device what 
picostar and sot-5x3 mean.

> +
> +  reg:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@44 {
> +            compatible = "ti,opt4001-picostar";
> +            reg = <0x44>;
> +        };
> +    };
> +...
> 
> -- 
> 2.30.2
> 
