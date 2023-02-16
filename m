Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9116996F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBPORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBPORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:17:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC83BBBBC;
        Thu, 16 Feb 2023 06:17:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 581C360EC4;
        Thu, 16 Feb 2023 14:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA7FC433EF;
        Thu, 16 Feb 2023 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676557065;
        bh=msau/2K38eSyS0QwdkrUAtAJXdcgOWtGHzcKJ1Q6qLA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YClAdZH0sHW2m6gPD+IhbEqbVY7ZRtsHvQbv0rKFQWSe9yqxlTdylkMHArEEBaGly
         46dojse6vdz3dti93+mXI1V0axFEzRdmdp9bw7h3oCeXsAP0o14SG/uF9M5DliniWW
         rTng24YEdcmORe02wayAef6shn5KWkUxyj4OduDFDqEgNkXjONwgKeSsWFM6hZBcFY
         sQg01jkgYLCW3Svj/HCCtyPqVT5/1fCijyE1LY9aGwSBM+ePMQQO8JCpa537b05mvE
         GdOe/WxfdMioa6kNV1NcPycYIBrUF+ylYmr8QGmjD1KLdJmfaeYoIwlcunw+Om5adx
         94v8odGqc4Y9g==
Message-ID: <3c0ad963-ce69-bd5b-20cd-888e5fbdecaf@kernel.org>
Date:   Thu, 16 Feb 2023 15:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-5-dipenp@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230214115553.10416-5-dipenp@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:55, Dipen Patel wrote:
> Added timestamp provider support for the Tegra234 in devicetree
> bindings.

1. Your commit does much more. You need to explain it why you drop some
property.

2. Bindings go before its usage (in the patchset).

3. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC.  It might happen, that command when run on an
older kernel, gives you outdated entries.  Therefore please be sure you
base your patches on recent Linux kernel.


> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
> v2:
> - Removed nvidia,slices property
> - Added nvidia,gpio-controller based on review comments from Thierry,
>   this will help simplify the  hte provider driver.
> 
>  .../timestamp/nvidia,tegra194-hte.yaml        | 30 ++++++++++++-------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> index c31e207d1652..d0f4ed75baee 100644
> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Tegra194 on chip generic hardware timestamping engine (HTE)
> +title: Tegra on chip generic hardware timestamping engine (HTE) provider
>  
>  maintainers:
>    - Dipen Patel <dipenp@nvidia.com>
> @@ -23,6 +23,8 @@ properties:
>      enum:
>        - nvidia,tegra194-gte-aon
>        - nvidia,tegra194-gte-lic
> +      - nvidia,tegra234-gte-aon
> +      - nvidia,tegra234-gte-lic
>  
>    reg:
>      maxItems: 1
> @@ -38,14 +40,11 @@ properties:
>      minimum: 1
>      maximum: 256
>  
> -  nvidia,slices:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +  nvidia,gpio-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> -      HTE lines are arranged in 32 bit slice where each bit represents different
> -      line/signal that it can enable/configure for the timestamp. It is u32
> -      property and depends on the HTE instance in the chip. The value 3 is for
> -      GPIO GTE and 11 for IRQ GTE.
> -    enum: [3, 11]
> +      The phandle to AON gpio controller instance. This is required to handle
> +      namespace conversion between GPIO and GTE.
>  
>    '#timestamp-cells':
>      description:
> @@ -55,11 +54,21 @@ properties:
>        mentioned in the nvidia GPIO device tree binding document.
>      const: 1
>  
> +if:

Keep it under allOf (so you no need to re-indent it on next if statement
in the future) and put entire allOf after "required:".

> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - nvidia,tegra194-gte-aon

This is an ABI break. Does your driver handle it?

> +          - nvidia,tegra234-gte-aon
> +then:
> +  required:
> +    - nvidia,gpio-controller
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> -  - nvidia,slices
>    - "#timestamp-cells"


Best regards,
Krzysztof

