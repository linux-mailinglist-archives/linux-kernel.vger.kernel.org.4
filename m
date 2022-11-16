Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5792962C895
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKPS7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiKPS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:59:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2AAE70;
        Wed, 16 Nov 2022 10:59:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56D1A61F5F;
        Wed, 16 Nov 2022 18:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2510C433C1;
        Wed, 16 Nov 2022 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668625184;
        bh=hiYpkG8v+QNMH4hOCoCwKHW+4L1ZXPesbKbZe8w76rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AiQTGwbPhfqygKn9RMWbLajRoGUv3IvGKQBYx67FReL2NWnjscqr566N3iUqqLvZ4
         Nm0yfVTI1+JT7bxg2jSs1CjQns42+F4IuF50fYb+N+16nkIRRZscbFsdHfjlS/qThK
         8Dt5Q068/cyLVHlbw6Cnq9oh89vrq9qjjV4FMipLGoPSDd/74JIZV+qZLGFmeGHESU
         wzgwpFk8Ibaq9CURIHCCrKBdzXzaIKEvzTU+JfoY26nc8JKUqlqYeWJvmDTsZGXao/
         9OQJc4jCmNVBS5cdZn6kHZXHZjCAPf2rMs5ErQyopQPfPxh2yVgXYS4qHGSm0LJ4do
         6LIJZKskwyuzQ==
Date:   Wed, 16 Nov 2022 19:12:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio/adc: add documentation for adc ad7927
Message-ID: <20221116191208.269e67eb@jic23-huawei>
In-Reply-To: <20221116104453.3207-2-edmund.berenson@emlix.com>
References: <20221116104453.3207-1-edmund.berenson@emlix.com>
        <20221116104453.3207-2-edmund.berenson@emlix.com>
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

On Wed, 16 Nov 2022 11:44:53 +0100
Edmund Berenson <edmund.berenson@emlix.com> wrote:

> Add the ad7927 compatibility string documentation to
> ad7923 driver.
> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>

Given you treat it as an ad7928 in the driver, can we have
a fallback compatible for it to that part?  Would allow people
using older kernels (with newer DT) to get support without needing
to patch the driver.

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> index 07f9d1c09c7d..3e9e9a9c18a4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> @@ -27,6 +27,7 @@ properties:
>        - adi,ad7924
>        - adi,ad7908
>        - adi,ad7918
> +      - adi,ad7927
>        - adi,ad7928
>  
>    reg:

