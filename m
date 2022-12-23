Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA97A6552F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiLWQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiLWQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:51:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F610FAF1;
        Fri, 23 Dec 2022 08:51:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB4861921;
        Fri, 23 Dec 2022 16:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A715EC433D2;
        Fri, 23 Dec 2022 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671814275;
        bh=9CkHMIDwQFHnimX2Xht8nG5OE9gvm5YkRNiHZU7xHjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u2QgV3YAS0tp5tdeXgcdOcqtktFFkIovKD+6I/KAkBu+OHDg0Q8cdmTcgjm2ANryU
         uPo48ocRQihe6G9P3DRdj293/LNu/D6yF1Z1CQLfCJLjMhcT+IBGjWD3Sbv3Hee2MV
         LUhWhmtQo8uf9XBxPTxR/KAEQObZrqMkAIqh4iDqvG9cRVw9K+Bvn265Unu/tCKva5
         Bp+yLb4x9/wod16j0fVEtKlJudPvZwbkF/AIYjjfKW07/NvUWSe5G7m296gUgEW/Oh
         p18YzhujinBxaRCrNHE7P6kRwZ0chJ+TzJmErtmVJthBXdQYpEdiUKCUYZzOWTbhq6
         zQ60A+U8O1QXg==
Date:   Fri, 23 Dec 2022 17:04:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: maxim,max1363: fix interface
 typo
Message-ID: <20221223170424.363c50f2@jic23-huawei>
In-Reply-To: <20221223162231.120216-1-krzysztof.kozlowski@linaro.org>
References: <20221223162231.120216-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 17:22:31 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Correct inteface->interface in description.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thanks for tidying this up.
Applied.

> ---
>  Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
> index e04f09f35601..96f3f535fe34 100644
> --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Jonathan Cameron <jic23@kernel.org>
>  
>  description: |
> -   Family of ADCs with i2c inteface, internal references and threshold
> +   Family of ADCs with i2c interface, internal references and threshold
>     monitoring.
>  
>  properties:

