Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502656F204F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346624AbjD1V4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjD1V4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:56:43 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719010F3;
        Fri, 28 Apr 2023 14:56:43 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1879e28ab04so458862fac.2;
        Fri, 28 Apr 2023 14:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719002; x=1685311002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nFjavnBxbro/fiUVf4O04xlVdcIJiqIT9b+HFjtLWg=;
        b=WuYzbEZxTSY8pVVDvByCAUDNpAfVnsBF40BuYlKMf1VjrWzPOQGTYgEmdxbGoI9hOU
         Unx1FpDOtuaLA/mNDjow28iWfowLrbv2g8AiJPGf6IBxTTrL2G/j3CUBsA/gGlY3eeAt
         Awq2zfASVtyjubnqfbtOGufj0FF0nYJSssQCqq/oGZmkBQs1PQRiM7py2Jgr+4aQ0aRF
         ZJ+fxpN7jy7GrHAjgetRIx2Sv87iuSMxgRUA2HlerrAuzff6y7QtaRfxnbKkWE3Akb8X
         aC3pMa0d9kIplLezb+cge1w4buP4k4h0fjbGuBOxhUtqVMQrxmKNTjzYyXctaEI5pSU+
         Nq+g==
X-Gm-Message-State: AC+VfDz8jyWWLAqWKm7O9BroGhJWW/1Gm53MRmg3/vilCe7VINPmvVlr
        v/SGImDOk1h6SgT6trLriQ==
X-Google-Smtp-Source: ACHHUZ5OJNT5MsgdOGP6dVEQb4gbp242DVRGaHiNkTBgEHOBX2g6mFXeDDn4UrNam06kfjQ2PIi7Sw==
X-Received: by 2002:a05:6870:d8af:b0:180:3225:b33b with SMTP id dv47-20020a056870d8af00b001803225b33bmr3139192oab.34.1682719002252;
        Fri, 28 Apr 2023 14:56:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i4-20020a056870864400b0018e996a507esm6031489oal.31.2023.04.28.14.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:56:41 -0700 (PDT)
Received: (nullmailer pid 345861 invoked by uid 1000);
        Fri, 28 Apr 2023 21:56:41 -0000
Date:   Fri, 28 Apr 2023 16:56:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: spi: stm32: add stm32h7
 st,spi-slave-underrun property
Message-ID: <20230428215641.GA332435-robh@kernel.org>
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
 <20230428121524.2125832-7-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428121524.2125832-7-valentin.caron@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:15:23PM +0200, Valentin Caron wrote:
> This property is used to enable and configure stm32h7 SPI controller to
> handle underrun that could appear in slave mode.
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  .../devicetree/bindings/spi/st,stm32-spi.yaml     |  8 ++++++++
>  MAINTAINERS                                       |  1 +
>  include/dt-bindings/spi/spi-stm32.h               | 15 +++++++++++++++
>  3 files changed, 24 insertions(+)
>  create mode 100644 include/dt-bindings/spi/spi-stm32.h
> 
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index 1d26fa2658c5..e946ea71a247 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -28,6 +28,7 @@ allOf:
>        properties:
>          st,spi-midi-ns: false
>          spi-slave: false
> +        st,spi-slave-underrun: false
>  
>  properties:
>    "#address-cells": true
> @@ -70,6 +71,13 @@ properties:
>        In case of spi-slave defined, if <0>, indicate that SS should be
>        detected via the dedicated HW pin
>  
> +  st,spi-slave-underrun:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      First parameter enables and selects slave underrun reaction.
> +      Refer to "dt-bindings/spi/spi-stm32.h" for the supported values.
> +      Second parameter is the pattern in case of SPI_SEND_PATTERN mode.

So, max 2 cells? Then:

minItems: 1
maxItems: 2

Though I don't really think this belongs in DT. The driver implementing 
the SPI slave function defines all the rest of the protocol the slave 
implements. Why not this little bit? Perhaps there is no way for a SPI 
slave driver to tell the SPI controller which controller specific mode 
to use, so you abuse DT to configure the SPI controller. Also, with a 
controller specific response, then the slave driver is coupled to that 
SPI controller which isn't great either.

Rob
