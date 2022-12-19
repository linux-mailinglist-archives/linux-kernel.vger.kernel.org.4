Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4401650F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiLSPxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiLSPwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:52:39 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43798E00A;
        Mon, 19 Dec 2022 07:49:50 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id e12-20020a4ab98c000000b004a081e811beso1464856oop.2;
        Mon, 19 Dec 2022 07:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtpKKtIDT0wu0L0RuUxg/9TFW0XNw8+9Gg9cF/VjLLE=;
        b=eioMztVVnXywNfq8RIm2K7wff6dbZRnSZhVCo9JgHjZVtoDjC0m2yJXz+kh7eMtss8
         1UYEMVXX+60Sam/GUfj5YNV5mA1b/TqbCmt5380QYyi1N+yDzpsQVT0cRY7VjqpXnC1K
         BXmFheTmEkgVAvSJ2CGfEwAo8JvoPZtbbXAUqTg0ZiRu+QkVvgqhLqNoHrzlkKd9QtbM
         J27CYq7Ccx1V1j/1VJjODFDsWNiIA6nKzRJ3tEGOQkjjIba01Z6A8PDEU+o3H8xf5oJF
         dxl+lJAVkgJitung2e5zhFOlgR+fIYQ7mX4cKdxDiO2Wcj+Ef8zugn1UeBTyUqH1YDA4
         Zm6A==
X-Gm-Message-State: ANoB5pme1mHf8AaZBaaZYzGdIo1VEK27cu53Wa0VEJXXrszY3j9a0jKs
        Azm6rbDXrKyGAkcDWuEI23qC5siO0Q==
X-Google-Smtp-Source: AA0mqf7IjPg4muxSCN2Qt3qxFnZ19qiEyp4eFf6ZehhyfdSNFY+GlSxtPeeW6TGXhuc3LQaSp077LQ==
X-Received: by 2002:a4a:e205:0:b0:49f:b2be:1865 with SMTP id b5-20020a4ae205000000b0049fb2be1865mr18158083oot.7.1671464989515;
        Mon, 19 Dec 2022 07:49:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a056820016d00b00499527def25sm4034953ood.47.2022.12.19.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:49:49 -0800 (PST)
Received: (nullmailer pid 1447283 invoked by uid 1000);
        Mon, 19 Dec 2022 15:49:48 -0000
Date:   Mon, 19 Dec 2022 09:49:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/17] dt-bindings: soc: Introduce UniPhier
 miscellaneous register blocks and fix examples
Message-ID: <20221219154948.GA1439405-robh@kernel.org>
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:24:32PM +0900, Kunihiko Hayashi wrote:
> This series introduces dt-bindings documents for miscellaneous register
> blocks implemented in Socionext UniPhier SoCs.
> 
> These are previously defined in the devicetree and used in the examples
> of subnodes' dt-bindings, however, not documented.
> 
> These include two types of the blocks
> 
> * independent block including miscellaneous registers and functions for
>   the whole SoC (system controller and SoC-glue logic)
> 
> * sideband logic including control registers in the component (others)
> 
> And prior to adding these dt-bindings, fix examples in the existing
> dt-bindings.
> 
> This series is part of the previous series shown below:
> https://lore.kernel.org/linux-arm-kernel/20221107103410.3443-2-hayashi.kunihiko@socionext.com
> 
> Changes since v2:
> - Drop redundant nodes in examples (clock, reset, soc-glue-debug)
> - Drop parent node in examples
> - Add more properties to examples for pinctrl
> - Add a patch for regulator change
> - Use consistent quotes
> - Drop unit address patterns of patternProperties
> - Mandatory unit address pattern for efuse (soc-glue-debug)
> - Fix additionalProperties (ahci-glue)
> 
> Changes since v1:
> - Fix examples in the existing dt-bindings (Add PATCH 1-7)
> - Add dt-bindings for SoC-glue logic debug part (Add PATCH 10)
> - Drop generic and ld6b compatible strings
> - Change "usb-controller" node in soc-glue to "usb-hub"
> - Change "usb-controller" node in USB glue layer example to "usb"
> - Add negation of child properties by compatible string
> 
> Kunihiko Hayashi (17):
>   dt-bindings: clock: Fix node descriptions in uniphier-clock example
>   dt-bindings: reset: Fix node descriptions in uniphier-reset example
>   dt-bindings: pinctrl: Fix node descriptions in uniphier-pinctrl
>     example
>   dt-bindings: regulator: Fix node descriptions in uniphier-regulator
>     example
>   dt-bindings: watchdog: Fix node descriptions in uniphier-wdt example
>   dt-bindings: thermal: Fix node descriptions in uniphier-thermal
>     example
>   dt-bindings: phy: Fix node descriptions in uniphier-phy example
>   dt-bindings: nvmem: Fix node descriptions in uniphier-efuse example
>   dt-bindings: soc: socionext: Add UniPhier system controller
>   dt-bindings: soc: socionext: Add UniPhier SoC-glue logic
>   dt-bindings: soc: socionext: Add UniPhier SoC-glue logic debug part
>   dt-bindings: soc: socionext: Add UniPhier peripheral block
>   dt-bindings: soc: socionext: Add UniPhier media I/O block
>   dt-bindings: soc: socionext: Add UniPhier SD interface block
>   dt-bindings: soc: socionext: Add UniPhier ADAMV block
>   dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
>   dt-bindings: soc: socionext: Add UniPhier AHCI glue layer

You sent this To me, so I'm assuming you want me to apply it?
Otherwise, it can go via the Socionext tree. Let me know and I can fix 
up Krzysztof's comments and apply the series.

Rob
