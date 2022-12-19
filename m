Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE765154C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiLSWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiLSWFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:05:37 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A0E15A29;
        Mon, 19 Dec 2022 14:03:38 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1443a16b71cso13252749fac.13;
        Mon, 19 Dec 2022 14:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zNRISushP1uPF43nvBSWhUAx98/OjFNEuU2dho5Z9w=;
        b=2pWyxlgYs8qHkzD/2svN0AwUKKUrmFaRCn3ZG5QjyvYUmefFyP624JiYcAuUczt0Dd
         qB6IY4Rdy5JrekAlBzZO4FmHAtcqVyesBj2FpJwcN91ONOOycMS9C/EZCU+35eoa6Txa
         TkdbXGXtzHqxqABjTNXPOBO9ZEH/69k5rCkHlvmOv5puFLbFsT8M8TL8zyn6r282/b67
         HhJkHvlFkrj4IwHqPvEdqo45z+gJgKOUYkvZ8CsoIMgTQkO4eoqmaNl9ULKnNcnmbNCH
         9uZ6L27Rjobc+wPlejUPq6ImJkVdYJRT+rCEhkyfjSDP5pXz0CdAYVB4cG85UThtQ6nd
         cJ5w==
X-Gm-Message-State: ANoB5pl7NGjxHzR7mwhF5DIdfu8SSPqm1Qpv8Vmed9ML2yMPxB5R57XI
        2evIS0x1bAFlIPjADE1keYlcCnAo9Q==
X-Google-Smtp-Source: AA0mqf4ys9pwJ+gHtqOsGOwRvOjjpV0tRqVRI7kSauPbUgOkNYnPhQR5UDcCu1PouMxza+VuOKb2Pw==
X-Received: by 2002:a05:6870:4604:b0:13b:7f03:2a7e with SMTP id z4-20020a056870460400b0013b7f032a7emr19966043oao.16.1671487416162;
        Mon, 19 Dec 2022 14:03:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a4a8e16000000b004982f2d3c03sm4380763ook.25.2022.12.19.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 14:03:35 -0800 (PST)
Received: (nullmailer pid 2409793 invoked by uid 1000);
        Mon, 19 Dec 2022 22:03:35 -0000
Date:   Mon, 19 Dec 2022 16:03:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bruno.thomsen@gmail.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: add missing pcf/pca2129
 entries
Message-ID: <20221219220335.GA2400372-robh@kernel.org>
References: <20221219194241.3817250-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219194241.3817250-1-hugo@hugovil.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:42:40PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The pcf2127_of_match structure in drivers/rtc/rtc-pcf2127.c also
> contains:
>     nxp,pcf2129
>     ncp,pca2129
> 
> Add these missing entries.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> index cde7b1675ead..00dbae7e23c2 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> @@ -14,7 +14,10 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: nxp,pcf2127
> +    enum:
> +      - nxp,pcf2127
> +      - nxp,pcf2129
> +      - ncp,pca2129

Check Documentation/devicetree/bindings/rtc/trivial-rtc.yaml.

Maybe they aren't trivial after all and should be removed? Or 
nxp,pcf2127 is also trivial?

Rob

P.S. 'make dt_compatible_check' will check in the kernel for 
undocumented (by a schema) compatibles.
