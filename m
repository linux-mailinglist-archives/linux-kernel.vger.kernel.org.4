Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A845BB227
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIPSa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPSax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7FB6D68;
        Fri, 16 Sep 2022 11:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E64262D20;
        Fri, 16 Sep 2022 18:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D295EC433D6;
        Fri, 16 Sep 2022 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663353051;
        bh=rTXxekar6BUr3NqL11nr6Y4XlSVqvxsIDBF+BWHm6mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4M9QHdfCMcL1aOVzy5o6NFcDFwMWvfNc4xOSFgoQiYcBngzGSx8u0AN6eaNii6iF
         aLYQXz0MFuW/niUGo3ft4Yedjv2cCci8SX75yN2kx7QJZ8B7GiPXwRvZ/mzypMWXnL
         /cgsaur0rjlyolmIMjGLap6FTR02aUl2Wjk57R1EW7xlppgpnmIs/EGRV2xYca3aCV
         Vc3dGOWseQvo32iPfrf86Wii+tcgdZ90SHVv9lhGfrSFn7wyFlMQAu3d73v1FLaNqq
         H+upXXgfomsTUvw0xzWjFTOkHmjHOlpDV7JDUs3A+70yzZHC19YIbTYcbtqPQyTTki
         +CWXF76Siftzg==
Date:   Fri, 16 Sep 2022 13:30:48 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: spmi: Add qcom,bus-id
Message-ID: <20220916183048.mxsxnk7xli2mwmig@builder.lan>
References: <20220914165212.3705892-1-vkoul@kernel.org>
 <20220914165212.3705892-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914165212.3705892-2-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:22:11PM +0530, Vinod Koul wrote:
> For PMIC arbiter version 7 and beyond we need to define if we are using
> primary or secondary bus, so add a new property of qcom,bus-id
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> index fee4f0eb4665..f983b4af6db9 100644
> --- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> @@ -85,6 +85,14 @@ properties:
>      description: >
>        which of the PMIC Arb provided channels to use for accesses
>  
> +  qcom,bus-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1
> +    description: >
> +      SPMI bus instance. only applicable to PMIC arbiter version 7 and beyond.
> +      Supported values, 0 = primary bus, 1 = secondary bus
> +
>  required:
>    - compatible
>    - reg-names
> @@ -113,5 +121,7 @@ examples:
>  
>          interrupt-controller;
>          #interrupt-cells = <4>;
> +
> +        qcom,bus-id = <0>;
>      };
>  
> -- 
> 2.37.3
> 
