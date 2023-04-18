Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4656E6F58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjDRW0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDRW0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:26:16 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369D559D7;
        Tue, 18 Apr 2023 15:26:15 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1842c7c2daaso470971fac.0;
        Tue, 18 Apr 2023 15:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681856774; x=1684448774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzkYu2FZFUxwYvdabyHvXaq9bbCUpOwOEj0N+6nTnPE=;
        b=dvhF4A1PpuHaqCHDBeyzvgJrX354fRn2/VrKKNq6bW1R6Q7cMj6vomNpaLq1OpZHe2
         0Guq9r556cWq6AWKzqKsv/+6o/K8q9RsuMFFJkIi6WSFwPa54tZBx2VV8BLJYe+OH5ru
         akJmbMttjOh92iIygodVTsFWdyA+qhm43YCUQVR90kSzUnue5nmfZnL3VDSBdmEEK7x6
         1mBzVROySrecgTKd4ESEAaUaVQEiSX2S4uM0dDRSbkTI0rL3BANTDIrIoh4yTMVAUcCw
         +V74HHc9EOTxDHsnoVz5/80HQ5X94WdYXBWE5qyKBmbuWwskDodAvHq9O7pxHm2q2GJu
         vYVw==
X-Gm-Message-State: AAQBX9fhRcd2BgOh0a1aIG/hI5+Bti9lo9/iU0voPA7wZ/N7yMkbzn0R
        cKjJoG+Rx9LQZvU+VTKr0w==
X-Google-Smtp-Source: AKy350bFvNy0NlWTzt68rhthpi/WPjnoE7xLzVZ9Y3ny/MmMDQ7CWhC385UPZEOO6x3QefiiZ6rpbQ==
X-Received: by 2002:a05:6870:f2a5:b0:184:50ac:2e27 with SMTP id u37-20020a056870f2a500b0018450ac2e27mr1936247oap.50.1681856774469;
        Tue, 18 Apr 2023 15:26:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d63c8000000b006a5f70dd12bsm1374581otl.17.2023.04.18.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:26:13 -0700 (PDT)
Received: (nullmailer pid 2439794 invoked by uid 1000);
        Tue, 18 Apr 2023 22:26:13 -0000
Date:   Tue, 18 Apr 2023 17:26:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: display: panel: add common definition of
 ports
Message-ID: <20230418222613.GA2408838-robh@kernel.org>
References: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 05:39:29PM +0200, Krzysztof Kozlowski wrote:
> Few panel bindings for dual-link connections just type "ports: true",
> which does not enforce any type.  Add common definition of ports, so the
> type will be fixed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/panel/panel-common.yaml     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> index 5b38dc89cb21..ad62d34e6fa3 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -70,6 +70,16 @@ properties:
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
>  
> +  # For dual-link connections
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    patternProperties:
> +      "^port@[0-9a-f]+$":
> +        $ref: /schemas/graph.yaml#/$defs/port-base

This allows any undocumented property.

> +
> +    required:
> +      - port@0
> +

I don't think this should be added here because users must define what 
each port is. With it here, we're going to validate the nodes twice as 
well. Same can be said for 'port' though. It can't be extended though.

I originally wanted to a do a meta-schema to enforce some of this, but 
there's just too many exceptions.

Rob
