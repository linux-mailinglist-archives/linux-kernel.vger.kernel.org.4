Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFB6DDBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjDKNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDKNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:22:08 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F6E4C04;
        Tue, 11 Apr 2023 06:22:07 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-18436e0b673so8895994fac.0;
        Tue, 11 Apr 2023 06:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681219326; x=1683811326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhT76dWlGbZN1saBWhMJ1k3SMLFpUczlzkPHRiA3NAI=;
        b=D73h0CKmfakbmG4DD1zpHHaOCHV8hNn6fZozRLS1fi7v6ue7q8qNfEgFFy7hiDiKX2
         9a7wRW5cXJI1rNeeGKpiQ5HyQiWbXxck7Rnx49/pYzH7J8XT9RpB0aVtY260AtFLVuVG
         nV06PiPkVFpHPNJUjICEe26JN/o+pXZCq00Zg7pI1FJVSle5jvgpEe+ZJG4TfKT5HIR/
         /HDzQZiaD0SSf8jMrpDIFv2GoukDMgtg4bsQ+m42hnVSP+6dB/qDFnM1MByWtTmelP+E
         cfy/Nn+OdAL5AXp+Ho1FdR3DCQg7AijsX3vOkhmYfjjQfebXMyeLd36c1dO9lnGJEwmS
         HwYQ==
X-Gm-Message-State: AAQBX9fXR5etXpX9YEfbqA1DqnclIZKhOdQUfWu0VGaHCaeSyLG+26rr
        bno4+JgCF4SbJ4KwRoF1mJLNrdfv6Q==
X-Google-Smtp-Source: AKy350ZMHvdKF48Cu62dwhIbauF39htYOgUbpv/Vdsk4LwA0SaPq24v7ep3XkOUrjpyJXJ31EkcTDA==
X-Received: by 2002:a05:6870:40d0:b0:184:534f:5e7 with SMTP id l16-20020a05687040d000b00184534f05e7mr2757137oal.35.1681219326217;
        Tue, 11 Apr 2023 06:22:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b0018045663fc5sm5100803oac.48.2023.04.11.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:22:05 -0700 (PDT)
Received: (nullmailer pid 2920199 invoked by uid 1000);
        Tue, 11 Apr 2023 13:22:04 -0000
Date:   Tue, 11 Apr 2023 08:22:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Message-ID: <20230411132204.GA2918042-robh@kernel.org>
References: <20230407102324.42604-1-maarten.zanders@mind.be>
 <20230407102324.42604-2-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407102324.42604-2-maarten.zanders@mind.be>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 12:23:23PM +0200, Maarten Zanders wrote:
> Add a binding to configure the internal charge pump for lp55xx.
> 
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Notes:
>     v1: implement as bool to disable charge pump
>     v2: rewrite to use string configuration, supporting all modes
>     v3: simplification by replacing string option by u8 constant,
>         removing previous Reviewed-by tags as it's a complete
>         rewrite of the patch.
>     v4: added notes
>     v5: dual license, change property type to u32
>     v6: change license type for leds-lp-55xx.h to preferred tag
> 
>  .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
>  include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/leds/leds-lp55xx.h
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> index ae607911f1db..ede9cb9ca175 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> @@ -66,6 +66,12 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  ti,charge-pump-mode:
> +    description:
> +      Set the operating mode of the internal charge pump as defined in
> +      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Needs constraints:

default: 3  # Auto
maximum: 3

> +
>  patternProperties:
>    '^multi-led@[0-8]$':
>      type: object
> @@ -152,6 +158,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/leds/common.h>
> +    #include <dt-bindings/leds/leds-lp55xx.h>
>  
>      i2c {
>          #address-cells = <1>;
> @@ -164,6 +171,7 @@ examples:
>              reg = <0x32>;
>              clock-mode = /bits/ 8 <2>;
>              pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
> +            ti,charge-pump-mode = <LP55XX_CP_BYPASS>;
>  
>              led@0 {
>                  reg = <0>;
> diff --git a/include/dt-bindings/leds/leds-lp55xx.h b/include/dt-bindings/leds/leds-lp55xx.h
> new file mode 100644
> index 000000000000..a4fb4567715d
> --- /dev/null
> +++ b/include/dt-bindings/leds/leds-lp55xx.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +#ifndef _DT_BINDINGS_LEDS_LP55XX_H
> +#define _DT_BINDINGS_LEDS_LP55XX_H
> +
> +#define LP55XX_CP_OFF		0
> +#define LP55XX_CP_BYPASS	1
> +#define LP55XX_CP_BOOST		2
> +#define LP55XX_CP_AUTO		3
> +
> +#endif /* _DT_BINDINGS_LEDS_LP55XX_H */
> -- 
> 2.37.3
> 
