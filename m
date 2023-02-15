Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15D698524
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBOUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBOUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:02:16 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341686B5;
        Wed, 15 Feb 2023 12:02:15 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id bh15so16832317oib.4;
        Wed, 15 Feb 2023 12:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnYwpFSiJkxoqAenwxBT3P5OhTg1ARQ8fjLNlY4RHZo=;
        b=WaWqFpDWZmZYfsB0Zc/FLcA6YKYqPTlaPhkuU6yHjMSG7ZRYOQMGC1k4WIQEcpYGnC
         cokZ8pNOVfmTuarAQuB0F+glZU3Y5hcd2OOTiXexkISmY90gDcUzQYC7KpWwa/aDrpPh
         RZ3UEWyzvWK4HGuDNohuvvA0tYXRNgIYm7PLYbeTt9q8b6D8q/1bFRTXoyyvM0BIANDM
         /uzSvromxtuqwvh65KiRyHaaH7qhf9Fy1+7QRyHOYyJ0YOMWXDV7RoR7cOCXi6FETF5Y
         Cks40ah7L8/dSaqDNV8vlmnfXdELi06DEspDM28qJwpc1WeGGNa1aSLjO7fPe3vSVBmU
         6ehQ==
X-Gm-Message-State: AO0yUKW6UX6Yy6501H568Vr0PoOo0WiCM2G+Nh2ezYeIfRn8myc6W2D6
        rlxn86wVpe+cm0W2+bh7cg==
X-Google-Smtp-Source: AK7set8fP7f98bfSC9h4Mu+gzjVfDfd39Q/pkCbq9lmO3NEodl2mRI8121AZZ5n0n5Hy0GqB22i4LQ==
X-Received: by 2002:a05:6808:1d0:b0:364:ca56:dd47 with SMTP id x16-20020a05680801d000b00364ca56dd47mr1586600oic.0.1676491334902;
        Wed, 15 Feb 2023 12:02:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020a05683004b200b0068d59d15a93sm8060848otd.40.2023.02.15.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:02:14 -0800 (PST)
Received: (nullmailer pid 477812 invoked by uid 1000);
        Wed, 15 Feb 2023 20:02:13 -0000
Date:   Wed, 15 Feb 2023 14:02:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
Subject: Re: [PATCH 1/6] dt-bindings: regulator: pca9450: Document new usage
 of sd-vsel-gpios
Message-ID: <20230215200213.GA467386-robh@kernel.org>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-2-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213155833.1644366-2-frieder@fris.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 04:58:19PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The sd-vsel-gpios property is abandoned in its current meaning as an
> output. We now use it to specify an optional signal that can be
> evaluated by the driver in order to retrieve the current status
> of the SD_VSEL signal that is used to select the control register
> of LDO5.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../regulator/nxp,pca9450-regulator.yaml      | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> index 835b53302db8..c86534538a4e 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> @@ -40,8 +40,24 @@ properties:
>      description: |
>        list of regulators provided by this controller
>  
> +    properties:
> +      LDO5:
> +        type: object
> +        $ref: regulator.yaml#
> +        description:
> +          Properties for single LDO5 regulator.
> +
> +        properties:
> +          sd-vsel-gpios:

It is a pin on the device, right? Then it belongs in the device node as 
it was.

Can't the direction of the signal tell you how it is used? Assuming the 
pin is bidirectional?

The binding should support any possible way the device is wired, not 
just what's been seen so far on some boards.

Rob
