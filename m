Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717AF612420
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJ2PKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJ2PKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:10:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA082FC31;
        Sat, 29 Oct 2022 08:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2715B80939;
        Sat, 29 Oct 2022 15:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9853BC433D6;
        Sat, 29 Oct 2022 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667056210;
        bh=mOHOFPnUIanOt/8CZe7yg7vprJJpkdiXWEot67QgAvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oGdvnYtTW3+D7LUZmwdjXEsD875n5caNW0pefVQhEWNA6ZXTe9aurvQJiL2T/ArP1
         /pVSsL5VU/pVExwZGxYH837fonmsy8nb2y3HxhXBGeOK5wc3vl12ygGH5KXTx4OSf1
         SkKqpysUz1EOw9Olgym2kdwIyCzzVyp+8h6EepCVcGloWHo9Ws5H4fNFHp3NGYELMr
         ec/e/pcuUNQpK2dwkZkJgFUDsUCuHQJrWKo17jhvgrfzvKFmbAkpQSfom5eoPZIofh
         agYXrTDPccx1aqVflKwkg/rN7CVJk4wdKllNYu7z0+3tsvG/6DHp0enYUpz4Kb5rF9
         6PQfHbfZzrwAw==
Date:   Sat, 29 Oct 2022 16:22:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings:iio:accel: Add docs for ADXL359
Message-ID: <20221029162207.76311679@jic23-huawei>
In-Reply-To: <20221028134454.669509-2-ramona.bolboaca@analog.com>
References: <20221028134454.669509-1-ramona.bolboaca@analog.com>
        <20221028134454.669509-2-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 16:44:53 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Update ADXL355 existing documentation with documentation
> for ADXL359 dedvice.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl355.yaml        | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> index 14b487088ab4..93ad7ff6b355 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> @@ -4,20 +4,22 @@
>  $id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
> +title: Analog Devices ADXL355 and ADXL359 3-Axis, Low noise MEMS Accelerometer
trivial: Accelerometers
>  
>  maintainers:
>    - Puranjay Mohan <puranjay12@gmail.com>
>  
>  description: |
> -  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
> -  both I2C & SPI interfaces
> +  Analog Devices ADXL355 and ADXL359 3-Axis, Low noise MEMS Accelerometer that
trivial: Accelerometers

Fix it if we need a v2 for other reasons. If not I can do it whilst applying.

Jonathan

> +  supports both I2C & SPI interfaces
>      https://www.analog.com/en/products/adxl355.html
> +    https://www.analog.com/en/products/adxl359.html
>  
>  properties:
>    compatible:
>      enum:
>        - adi,adxl355
> +      - adi,adxl359
>  
>    reg:
>      maxItems: 1

