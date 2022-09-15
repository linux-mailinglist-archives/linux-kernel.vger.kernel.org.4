Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716985BA05A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIORXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIORXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE19E88A;
        Thu, 15 Sep 2022 10:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F406258B;
        Thu, 15 Sep 2022 17:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7E8C433C1;
        Thu, 15 Sep 2022 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663262619;
        bh=pBZfZnF367uJzd8ea6waz1hCGji3S73heEJwNc2UmTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSa8lPN+3ZKAfu6aW3ra+49E5CpJZnIyMhgQmOLb3RZF9/uSDtJSI2HDqFbS1dJYP
         2jtVRHb7YalMtbsk7ztOEFMDyN3rJjAdINFBiUOhQ2PSqrXTOXFbTRQkddmb917YMe
         Wvp0BjputE7oaVsgn2dcagxnHrEbxVWbSI4A4CX9ObPkHRGd3utO6Ff3bxj9kg9Q/j
         XJ7QtP5+5BHHNIAfzTe+T+ezmiekda0deA03OOeZUBp5vNGBa0qfgsH1j6s+F4e9Nj
         RNVYoaaOHYnFOF0OqQoLL2pTKyI+s9Zzj3ouGtGuU/8G7TDaPU/BEkSksufFRDCatv
         SgJjFlTEk4A3Q==
Date:   Thu, 15 Sep 2022 12:23:36 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: qcom,sm8250: add compatibles
 for sm8450 and sm8250
Message-ID: <20220915172336.zh3l2kb42uis45ey@builder.lan>
References: <20220915125611.22473-1-srinivas.kandagatla@linaro.org>
 <20220915125611.22473-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915125611.22473-3-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 01:56:09PM +0100, Srinivas Kandagatla wrote:
> Add compatibles for sm8450 and sm8250xp based soundcards.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index a3a4289f713e..58b9c6463364 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -23,6 +23,8 @@ properties:
>        - qcom,sdm845-sndcard
>        - qcom,sm8250-sndcard
>        - qcom,qrb5165-rb5-sndcard
> +      - qcom,sm8450-sndcard
> +      - qcom,sc8280xp-sndcard

It's nice when these are kept sorted...

Regards,
Bjorn

>  
>    audio-routing:
>      $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> -- 
> 2.21.0
> 
