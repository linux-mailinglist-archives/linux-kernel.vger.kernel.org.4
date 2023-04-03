Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132F76D540C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjDCVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjDCVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:55:37 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B2FF;
        Mon,  3 Apr 2023 14:55:36 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id f14so9333847oiw.10;
        Mon, 03 Apr 2023 14:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680558935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjq0KqO+ZCTucOoyX+5QFTzN2oQuHf/UKMiz/wqweFU=;
        b=cPQf1ejk1t0uIUttyKCvHbbkoFto2YATC2JCSbt99rXBJ1EwdEWwI1KTTo4kiZ82wW
         992FNJ8pbLEaNIzUSwOln1Fz2AS63hD6LYFbmM2C98Zg3tL0IlsXkSvpvCCZ7Du8ByAp
         SfdvownnaCZ/R6DB31e9g1EqD6tFZlZWSlj5l8pEEngUcqCM6TDTAVQiB2TRlJQoM9Go
         jHyvWgt+kVa2e3TL4dQCuAveQbLPxaPg8+uOk06zOoBE0Yc/j18Cn1O/4bM+kp1nFamm
         kThzjmUqxkXQ7vuy2yCx8kbFm6nYCwHwwqSE1T/cWNwxiLto5XmCizNWTYJsYh45HN6E
         iNdw==
X-Gm-Message-State: AAQBX9eCTaZLD+Qg9U4ACO5LjaylI/oUsOjgmVOlJpDbLULq7S4B5NBl
        SyKxJ9r68IExf8TPqk0bIw==
X-Google-Smtp-Source: AKy350Z6oL4IFhGhzxX75BQl6RphNE8W4vpP8gNjQhZyac0ZEhG5/XlfipS5XUEhJa/yh2SASWnk9A==
X-Received: by 2002:a05:6808:4247:b0:387:3a60:be06 with SMTP id dp7-20020a056808424700b003873a60be06mr346449oib.21.1680558935526;
        Mon, 03 Apr 2023 14:55:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o14-20020a54478e000000b0037832f60518sm4327025oic.14.2023.04.03.14.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:55:35 -0700 (PDT)
Received: (nullmailer pid 1942293 invoked by uid 1000);
        Mon, 03 Apr 2023 21:55:34 -0000
Date:   Mon, 3 Apr 2023 16:55:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 1/2] dt-bindings: usb: generic-ohci: increase allowed
 clocks
Message-ID: <20230403215534.GA1935153-robh@kernel.org>
References: <20230331163148.5863-1-sebastian.reichel@collabora.com>
 <20230331163148.5863-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331163148.5863-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 06:31:47PM +0200, Sebastian Reichel wrote:
> Increase number of allowed clocks to 4, which is the number
> required on Rockchip RK3588.

It was 3 because that's what crept in until we made a schema. Additions 
should really have a specific compatible and a conditional schema 
limiting that 4 clocks to that compatible.

> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> index a9ba7257b884..c0880d0664f1 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> @@ -69,7 +69,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>      description: |
>        In case the Renesas R-Car Gen3 SoCs:
>          - if a host only channel: first clock should be host.
> -- 
> 2.39.2
> 
