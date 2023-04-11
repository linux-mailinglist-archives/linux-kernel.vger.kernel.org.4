Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800466DDBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDKNMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDKNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:12:45 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F10040C5;
        Tue, 11 Apr 2023 06:12:39 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id c2-20020a056830348200b006a3ab0ba8a2so8187651otu.1;
        Tue, 11 Apr 2023 06:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218758; x=1683810758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GW02L6nIApJNIdMW8NqTVwVWjewpMvs4/3n/QOH2X4=;
        b=ZB+gNtTGLti9h/NJNIbitXOwbvqJS00FAQET94oPNO1eNlSS5KZyG/wrqB7N0LtHwn
         tU//O4EDIennlVyYQULRsiOjcJ9OF2rw1CEOZhn/aUcL/JfhSK2rUQ7JSpx1bw7R+kdx
         R/MeiZD7QvM6akxTk6kmhQMwiYDOe6zVIW5fakwUJQwqWgMOWNrLttEz2T0b7/jOIfxs
         M6HE7gElx1IZZrTFa7xh6pnTJws7gwFe5H0osfxlUP4dHjIj4tyvJmsTLura7DzdVFhw
         YoXZSuif3eaEbOf9mv2xFPnMxg2mgtRX+bXsKStkfemdnprhmq22FUt6dt1jDDlfSll6
         bc6A==
X-Gm-Message-State: AAQBX9ebOZyOIyzB3t20Crs9hOiz9NcSLtFFHibbz1EARCEnqkoOuhDt
        c6o+LWrT9KZzWv617v+j4A==
X-Google-Smtp-Source: AKy350YaRPQKn8t2rWkmO5BUPXazyXS/ThqJAn+M4vfd2ePh48L8+Fz+BWDh+3gbBbfgfTZluNGWlw==
X-Received: by 2002:a05:6830:2016:b0:69b:cdd9:5216 with SMTP id e22-20020a056830201600b0069bcdd95216mr1267515otp.21.1681218758432;
        Tue, 11 Apr 2023 06:12:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056830104e00b0069457b86060sm5479564otp.47.2023.04.11.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:12:37 -0700 (PDT)
Received: (nullmailer pid 2908359 invoked by uid 1000);
        Tue, 11 Apr 2023 13:12:37 -0000
Date:   Tue, 11 Apr 2023 08:12:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 1/3] dt-bindings: usb: Add RK3588 OHCI
Message-ID: <20230411131237.GA2837061-robh@kernel.org>
References: <20230406135552.23980-1-sebastian.reichel@collabora.com>
 <20230406135552.23980-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406135552.23980-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 03:55:50PM +0200, Sebastian Reichel wrote:
> Add compatible for RK3588 OHCI. As far as I know it's fully
> compatible with generic-ohci.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/usb/generic-ohci.yaml  | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> index a9ba7257b884..e116ed90471e 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> @@ -44,6 +44,7 @@ properties:
>                - hpe,gxp-ohci
>                - ibm,476gtr-ohci
>                - ingenic,jz4740-ohci
> +              - rockchip,rk3588-ohci
>                - snps,hsdk-v1.0-ohci
>            - const: generic-ohci
>        - enum:
> @@ -69,7 +70,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>      description: |
>        In case the Renesas R-Car Gen3 SoCs:
>          - if a host only channel: first clock should be host.
> @@ -147,6 +148,21 @@ allOf:
>      then:
>        properties:
>          transceiver: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-ohci
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4

Only need minItems here.

> +    else:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 3

Only need maxItems here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
