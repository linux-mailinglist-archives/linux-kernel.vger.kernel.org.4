Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430BF6C02DC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCSPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC671115B;
        Sun, 19 Mar 2023 08:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4642D610A4;
        Sun, 19 Mar 2023 15:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699AEC433D2;
        Sun, 19 Mar 2023 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679240397;
        bh=QT/ENZzeITH/GmdHuf2zyuTiJNVRErIxf7sbSW3a7yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RXvhCL6UV6OpRj/zl9wgTAa5EAgWpViFyDz4XG0RaTY126gnOsXE8pjvUQ7o6aZ6l
         LGPaG8FPl5CjuFkiG9Vh6DEVKtbVd+B8JRp/zxM4l0i4Bgk+uPu45olp4+rQTSAj1H
         EszgSt4OPdAfYqsYJkl/sJdTNQQv/nKO0HJhw2PqrwI6unSNo6uBw1Fewn6LS4sV1l
         7YgM6dxGkNsnyZyhDjuQalpFfh8l/OdIwr5ea8zaZM8kVORCSwHS3MpiL2rgM9mjv3
         zbI+cXzvco+UkvATU3hV3VUfD6lvIvMIXDF+H5rVU9Xps0dCujac/wUKbVaNtYHVBz
         /CtaHRSCG+Kow==
Date:   Sun, 19 Mar 2023 15:54:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: Add KX132 accelerometer
Message-ID: <20230319155451.0207118a@jic23-huawei>
In-Reply-To: <d677b957164930c3d2fee900117795b25b85c3fa.1679009443.git.mehdi.djait.k@gmail.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
        <d677b957164930c3d2fee900117795b25b85c3fa.1679009443.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 00:48:35 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Extend the kionix,kx022a.yaml file to support the
> kx132 device
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Pins and power supplies etc all look the same to me so indeed seems that
you have covered all that is needed.  One small comment inline
and I think Matti's point about more specific compatibles probably
needs to be taken into account if there are known variants.

Kionix has done this for a long time. I remember that fun with the
kxsd9 lots of years back - that had lots of subtle variants.

> ---
>  .../bindings/iio/accel/kionix,kx022a.yaml           | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> index 986df1a6ff0a..ac1e27402d5e 100644
> --- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> @@ -4,19 +4,22 @@
>  $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: ROHM/Kionix KX022A Accelerometer
> +title: ROHM/Kionix KX022A and KX132 Accelerometers
>  
>  maintainers:
>    - Matti Vaittinen <mazziesaccount@gmail.com>
>  
>  description: |
> -  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
> -  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
> -  KX022A can be accessed either via I2C or SPI.
> +  KX022A and KX132 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
> +  16G ranges, output data-rates from 0.78Hz to 1600Hz and a hardware-fifo

This may be one of those 'there are many versions' of the chip issues, but
the random datasheet I got via digikey (kionix website was slow and I'm
impatient) has max as 25600Hz for the KX132-1211.

No particular reason the sampling rates need to be in this description so
if they are different I'd just remove the mention or just say
"variable output data-rates"

> +  buffering.
> +  KX022A and KX132 can be accessed either via I2C or SPI.
>  
>  properties:
>    compatible:
> -    const: kionix,kx022a
> +    enum:
> +      - kionix,kx022a
> +      - kionix,kx132
>  
>    reg:
>      maxItems: 1

