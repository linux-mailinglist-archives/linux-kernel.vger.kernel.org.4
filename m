Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273A5BB273
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiIPSuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:50:53 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257159F1A3;
        Fri, 16 Sep 2022 11:50:50 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id n83so7202271oif.11;
        Fri, 16 Sep 2022 11:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3UB7ATwI4jkvN5dfzXoHTLYFFznwA2fYTP5Sp8m3D6A=;
        b=OQ8O5lkpEKmOWYYgc3nYKFBFtxvpveFS/h5fXf1Zg9iAEzHJJJKXA4G6KbQFijtTT0
         ZnRpX1UTTqvHM5H1plrAxhmoY6XGk9PpHb7xmGYrLVnS7eSDrCGDszPR7uiPHOVXByiu
         +b62jVC6/7DCYx1nGzp8f+L4m6m82tLeLaodZFsLMofP1MDh5SnRk7E+matKUyQzGqI/
         hyocPuaNrkaAwQI5yYGerfboPtCvceBVJowGkIL93X5tnkJVUqvZcp8U5WFv34oPHn6n
         D38aUR/trCWRYNXYyyyKC7wuRvgCj17Zqy3ge1vHF73j1Tqoh23JHaaXV6/yDyKbkgK0
         86ew==
X-Gm-Message-State: ACgBeo1IoDlqdZuvAaA3m5Cs+UBmk3vwCAiUmLnfm/HKXIwn5HYrBTFP
        PnrtPb2xHCpn1aVfalbAKg==
X-Google-Smtp-Source: AA6agR710WjH2qECtnOYp/b/ibt2BmM7PlV30E4FBE3nldt1uSx9BidvH6yyuvSYQNT0OEBJvdRZbw==
X-Received: by 2002:a05:6808:1148:b0:344:e58d:7449 with SMTP id u8-20020a056808114800b00344e58d7449mr7495734oiu.209.1663354249346;
        Fri, 16 Sep 2022 11:50:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k26-20020a056808069a00b0033a11fcb23bsm9346668oig.27.2022.09.16.11.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:50:48 -0700 (PDT)
Received: (nullmailer pid 1065156 invoked by uid 1000);
        Fri, 16 Sep 2022 18:50:48 -0000
Date:   Fri, 16 Sep 2022 13:50:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        shengjiu.wang@nxp.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: fsl_rpmsg: Add a property to
 assign the rpmsg channel
Message-ID: <20220916185048.GA1061412-robh@kernel.org>
References: <20220914105145.2543646-1-chancel.liu@nxp.com>
 <20220914105145.2543646-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914105145.2543646-2-chancel.liu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:51:39PM +0800, Chancel Liu wrote:
> Add a string property to assign the rpmsg channel this sound card sits
> on. It also represents the name of ASoC platform driver. This property
> can be omitted if there is only one sound card and it sits on
> "rpmsg-audio-channel".
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 37 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> index d370c98a62c7..3744ae794c00 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> @@ -11,8 +11,11 @@ maintainers:
>  
>  description: |
>    fsl_rpmsg is a virtual audio device. Mapping to real hardware devices
> -  are SAI, DMA controlled by Cortex M core. What we see from Linux
> -  side is a device which provides audio service by rpmsg channel.
> +  are SAI, MICFIL, DMA controlled by Cortex M core. What we see from
> +  Linux side is a device which provides audio service by rpmsg channel.
> +  We can create different sound cards which access different hardwares
> +  such as SAI, MICFIL, .etc through building rpmsg channels between
> +  Cortex-A and Cortex-M.
>  
>  properties:
>    compatible:
> @@ -85,6 +88,17 @@ properties:
>        This is a boolean property. If present, the receiving function
>        will be enabled.
>  
> +  fsl,rpmsg-channel-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      A string property to assign rpmsg channel this sound card sits on.
> +      It also represents the name of ASoC platform driver. This property

That's a Linux detail which doesn't belong in DT.

> +      can be omitted if there is only one sound card and it sits on
> +      "rpmsg-audio-channel".
> +    enum:
> +      - rpmsg-audio-channel
> +      - rpmsg-micfil-channel
> +
>  required:
>    - compatible
>    - model
> @@ -107,3 +121,22 @@ examples:
>                   <&clk IMX8MN_AUDIO_PLL2_OUT>;
>          clock-names = "ipg", "mclk", "dma", "pll8k", "pll11k";
>      };
> +
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +
> +    rpmsg_micfil: audio-controller {
> +        compatible = "fsl,imx8mm-rpmsg-audio";
> +        model = "micfil-audio";
> +        fsl,rpmsg-channel-name = "rpmsg-micfil-channel";
> +        fsl,enable-lpa;
> +        fsl,rpmsg-in;
> +        clocks = <&clk IMX8MM_CLK_PDM_IPG>,
> +                 <&clk IMX8MM_CLK_PDM_ROOT>,
> +                 <&clk IMX8MM_CLK_SDMA3_ROOT>,
> +                 <&clk IMX8MM_AUDIO_PLL1_OUT>,
> +                 <&clk IMX8MM_AUDIO_PLL2_OUT>;
> +        clock-names = "ipg", "mclk", "dma", "pll8k", "pll11k";
> +    };
> +
> +...
> -- 
> 2.25.1
> 
> 
