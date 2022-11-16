Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FAA62CBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiKPU77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiKPU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:59:43 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E574B69DD1;
        Wed, 16 Nov 2022 12:56:43 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r76so19911050oie.13;
        Wed, 16 Nov 2022 12:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aYRQELqghd3olCWrn6RVp8hDiY21bGgrNc5ikJRp1Y=;
        b=S+vPzl7mPI8HDq0vvNQmn7opqag67D0UI4d6B1aQ5CpQ8vYZe7wd+zYgOfnqurhW19
         UcOYO56BHK1T6QD+BOzb+olyYbAxJKXdi1fWxGIY+MsPfYLaaDOzw/D8lGvIF+ONZPUw
         azfiojtO5FSpsL+7tagnUk/T42JW+GSc6jcEDOCvg3lQ4wTHOZH3qJPAgb8u5YwqCd73
         UrPaCXfcRprplvfYjF3N+cjxXOPP4xAT5OmVatJ/bz6ABgHUVuyXNzo5XSOrJaINueza
         3zY+hZZeLykcFwpvgK6AFQ9b4JjbUcJ6yPolHK9NSlt5vh5mBAsfkH2U0uXZEPc+I56v
         GXDg==
X-Gm-Message-State: ANoB5plsA8FVSolhn/5GNiw2UOBiYb2XqSgcjlkie3R49VTYn6j3AxZ+
        P1Xg/dRs4eWsIGTQBEIgl2/g3aGVVQ==
X-Google-Smtp-Source: AA0mqf4QUudAXVd8BEXK9yUDRkBWJk4n/c3YPupaLw41GSxMen3W9MWBN7DVlKtuHc0/u7QNydq/8A==
X-Received: by 2002:aca:1208:0:b0:355:8873:40b2 with SMTP id 8-20020aca1208000000b00355887340b2mr2587774ois.50.1668632203193;
        Wed, 16 Nov 2022 12:56:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683011cd00b00661b5e95173sm6989940otq.35.2022.11.16.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:56:42 -0800 (PST)
Received: (nullmailer pid 867646 invoked by uid 1000);
        Wed, 16 Nov 2022 20:56:44 -0000
Date:   Wed, 16 Nov 2022 14:56:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 13/17] dt-bindings: mtd: nvmem-cells: Drop range
 property from example
Message-ID: <166863220434.867607.9322853555110461989.robh@kernel.org>
References: <20221114090315.848208-1-miquel.raynal@bootlin.com>
 <20221114090315.848208-14-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114090315.848208-14-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Nov 2022 10:03:11 +0100, Miquel Raynal wrote:
> Memory mapped devices such as parallel NOR flash could make use of the
> 'ranges' property to translate a nvmem 'reg' cell address to a CPU
> address but in practice there is no upstream user nor any declaration of
> this property being valid in this case yet, leading to a warning when
> constraining a bit more the schema:
> 
> 	.../mtd/partitions/nvmem-cells.example.dtb: calibration@f00000:
> 	Unevaluated properties are not allowed ('ranges' was unexpected)
> 
> So let's drop the property from the example, knowing that someone might
> actually properly define it some day.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml          | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
