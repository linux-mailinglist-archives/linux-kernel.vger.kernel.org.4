Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97B4652452
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiLTQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiLTQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:08:53 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4F1D668;
        Tue, 20 Dec 2022 08:07:24 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1443a16b71cso15838043fac.13;
        Tue, 20 Dec 2022 08:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/u+y5GSLZEEG0FI6JVp5YQvEAR9DtzlzUi4XN5IYYg=;
        b=mt+KXqsEk7bQfD5MVipOX6CdRgPWbe7p/6SdezuFDxN5TU1F8Vh2sj06RUtvR6dojY
         xCGBeMcfj4gwixBF7HsxoSbgjZuhRsq6gUOTN9UKgsctXqw7L2O2Nx2ob+cWbZ8AVP6Q
         P4qbbSNo0CO7SuxVnKuKRlCX/aEGKvPkdjvknCYZ+cnIYEaUkDoV7YUQ28nMdP22rMCg
         u0jMDENMIYyXKb6gJxdDCGvAFNqUrdfougeILwcJo4foVwmReCjCPMUdLpG61QtjQgN/
         mUBAmJO+VAuJrVp0477Z/6scDDsHb5m48yienroc4LoGqjHQBdzgybTykGz/64kugWBg
         +4nA==
X-Gm-Message-State: ANoB5pmItgFGp3TthVL7i3W8GC60bPMHWNyD+9O3+TrgL3K+hgZ6FQtc
        /5AO0Qk27Mu7mfYodUU86g==
X-Google-Smtp-Source: AA0mqf7Vr3fx/nZSVhqd0FR3tqQ0t2069C3rCa0EhIFdtpBAjjoKR5PH1zTpaiGVYRnNzM3trAwTnQ==
X-Received: by 2002:a05:6870:1696:b0:144:7a85:63ea with SMTP id j22-20020a056870169600b001447a8563eamr23948571oae.23.1671552443772;
        Tue, 20 Dec 2022 08:07:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a056870460900b00140d421445bsm6185661oao.11.2022.12.20.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:07:23 -0800 (PST)
Received: (nullmailer pid 647058 invoked by uid 1000);
        Tue, 20 Dec 2022 16:07:22 -0000
Date:   Tue, 20 Dec 2022 10:07:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, vkoul@kernel.org, kishon@kernel.org,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: soc: rockchip: grf: add
 rockchip,lvds.yaml
Message-ID: <20221220160722.GA635186-robh@kernel.org>
References: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
 <0b9bb507-1819-4bfa-593f-8b7e92c2ce3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b9bb507-1819-4bfa-593f-8b7e92c2ce3d@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 05:56:35PM +0100, Johan Jonker wrote:
> Add new converted rockchip,lvds.yaml to grf.yaml file.
> Prepare for more SoCs with lvds output.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/soc/rockchip/grf.yaml          | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 2ed8cca79..d74295e98 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -75,13 +75,17 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: rockchip,px30-grf
> +            enum:
> +              - rockchip,px30-grf
> 
>      then:
>        properties:
>          lvds:
> -          description:
> -            Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> +          type: object
> +
> +          $ref: "/schemas/display/rockchip/rockchip,lvds.yaml#"

You can drop the quotes.

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +          unevaluatedProperties: false
> 
>    - if:
>        properties:
> --
> 2.20.1
> 
> 
