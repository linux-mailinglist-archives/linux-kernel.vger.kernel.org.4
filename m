Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D644561237C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ2OMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2OL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C5F5C348;
        Sat, 29 Oct 2022 07:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD8D4B80D08;
        Sat, 29 Oct 2022 14:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8027AC433C1;
        Sat, 29 Oct 2022 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667052714;
        bh=wz/h6dr+QYw1eRU23/S78W78RXHZrsOEIPGSF2r+IVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AmVhVKmHyezccuRTl0ozfAmIFvKmGy9ORk6HnQoFl7AhIIoySnwomu377aFatvBqI
         NwrsLVcLvsdWa3SguzzqI5VDyCMz8g9Tl9TZMQvlP2q3TxsoktI/TzIi+wCIJGkN11
         BXbpgcG8m5N/6NyN+mMuIfQpjvnfMf1pvG66pNPJ5MOlqd2ifQY47hJbjy2pTo3rv7
         X5I5MSWKKhHeIPbPQMF0NXKXTRLaHWWL03CiOdNuIWnDEEU/B4k1bzmQZqAphMO5Dz
         mMU6Y7nTONfCr5/Qp7uD/A7Dw8ql6qLTT2hd/XmOPHhBeNIadl/mzqA2Z1xy8hcrkI
         +3iOukEdh66PQ==
Date:   Sat, 29 Oct 2022 15:23:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: Support ROHM/Kionix kx022a
Message-ID: <20221029152348.31c36f1b@jic23-huawei>
In-Reply-To: <cover.1666614295.git.mazziesaccount@gmail.com>
References: <cover.1666614295.git.mazziesaccount@gmail.com>
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

On Mon, 24 Oct 2022 15:37:57 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add initial support for ROHM/Kionix kx022a accelerometer

Series applied with minor tweaks as per individual replies +
Andy's RB found and added.

Applied to the togreg branch of iio.git and pushed out initially as
testing to see if 0-day can find anything we missed before I make
a mess of linux-next.

Thanks,

Jonathan

> 
> About the HW:
> KX022A accelerometer is a sensor which:
> 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> 	- can be connected to I2C or SPI
> 	- has internal HW FIFO buffer
> 	- supports various ODRs (output data rates)
> 	- support detecting special events like double tap or motion
> 	- can be configured to wake-up system when events are detected.
> 
> About the series:
> 
> This series adds support for only getting the accelerometer data and
> configuring the G-range / ODR via IIO. Motion detection or double-tap
> detection are not supported by the series. The other quite important but
> still missing piece is the runtime PM. Nevertheless, the driver should be
> usable and brings the basic support for getting accelerometer data.
> 
> Changelog v5:
> 	- KX022A: styling/print fixes.
> 	- KX022A: fix race for requesting IRQ/populating user-space
> 	  entries.
> 	- KX022A: fix few variable types
> 	- KX022A: drop unnecessary udelay()
> 	- MAINTAINERS: Change myself to be a maintainer.
> 
> Changelog v4: (More detailed log in individual patches)
> 	- KX022A: mostly styling/print fixes.
> 	- KX022A: fix return value from IRQ thread handler.
> 
> Changelog v3: (More detailed log in individual patches)
> 	- dt-bindings: fixed as suggested by Krzysztof
> 	- KX022A: multiple fixes as suggested by Andy
> 		- Fair to mention that couple of suggested changes are
> 		  not done (Some styling, boilerplate text in KConfig)
> 		  as there has been no consensus whether the suggested
> 		  changes improve situation. Ultimately the decision
> 		  whether these changes are mandatory lay on the
> 		  shoulders of the maintainers... Sorry for that.
> 	- Enable the FIFO without module param now that the "FIFO stuck"
> 	  issue can be prevented.
> 	- Fix potential race with time-stamp calculation when user-space
> 	  invokes the fifo flush.
> 	- Drop the already merged regulator patches.
> 
> Changelog v2: (More detailed log in individual patches)
> 	- dt-bindings: fixed as suggested by Krzysztof
> 	- dt-bindings: support both INT1 and INT2
> 	- KX022A: multiple fixes as suggested by Jonathan
> 	- fixed SPI driver after some testing
> 
> ---
> 
> Matti Vaittinen (3):
>   dt-bindings: iio: Add KX022A accelerometer
>   iio: accel: Support Kionix/ROHM KX022A accelerometer
>   MAINTAINERS: Add KX022A maintainer entry
> 
>  .../bindings/iio/accel/kionix,kx022a.yaml     |   65 +
>  MAINTAINERS                                   |    5 +
>  drivers/iio/accel/Kconfig                     |   21 +
>  drivers/iio/accel/Makefile                    |    3 +
>  drivers/iio/accel/kionix-kx022a-i2c.c         |   51 +
>  drivers/iio/accel/kionix-kx022a-spi.c         |   58 +
>  drivers/iio/accel/kionix-kx022a.c             | 1142 +++++++++++++++++
>  drivers/iio/accel/kionix-kx022a.h             |   82 ++
>  8 files changed, 1427 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
>  create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.h
> 
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780

