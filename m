Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07FF626A99
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiKLQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiKLQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:32:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEC11C1C;
        Sat, 12 Nov 2022 08:32:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A835A60C96;
        Sat, 12 Nov 2022 16:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9F7C433D6;
        Sat, 12 Nov 2022 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668270725;
        bh=+q9hFe8SsT/LG2vRDXuPIe1DAbLuVAEj0I00+4cCu9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ljmGTYIe6pY/STBG/QNEZBs6zXsiJsNyJnB5D1ocAbUJbiOCjE4k/SpRY4Tp1DDlL
         J85X60lUg9geqGmJyb3wbptGbZL7KZ7bKnsdAndnvZmFfvtWKFq0kZfYnXv2NOvRwz
         kykHpdK1A/vCPNFTsviO5rStl05xCT70b2MRCq7tyglLzsRudFvYc8B4sqI1KAnrUK
         spO+34cemtu4m3kEg+9kdEXyO6wJRgNfhrArW2S3mnt1GJOufDkJ0XyUPdQw6WJo0y
         DoLon6vgrNBF9PwE5M8rlHLWjtkqloysj5Ijb+0JmRNfa/720nxdzwlMQws1ynGCtI
         Q9LeKSVTbs3qA==
Date:   Sat, 12 Nov 2022 16:44:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad5758: Drop 'contains' from
 'adi,dc-dc-mode'
Message-ID: <20221112164418.13a446c1@jic23-huawei>
In-Reply-To: <20221111212846.4104059-1-robh@kernel.org>
References: <20221111212846.4104059-1-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 15:28:46 -0600
Rob Herring <robh@kernel.org> wrote:

> 'contains' applies to arrays, but 'adi,dc-dc-mode' is a scalar. So drop
> 'contains' from the 'if' schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> index e49e7556175d..4e508bfcc9d8 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> @@ -102,8 +102,7 @@ allOf:
>    - if:
>        properties:
>          adi,dc-dc-mode:
> -          contains:
> -            enum: [1, 3]
> +          enum: [1, 3]
>      then:
>        properties:
>          adi,range-microvolt: false

