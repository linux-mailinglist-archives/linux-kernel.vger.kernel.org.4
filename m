Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6466F6DBA06
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjDHKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDHKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29371C15F;
        Sat,  8 Apr 2023 03:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B73CC60A6C;
        Sat,  8 Apr 2023 10:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A752C433D2;
        Sat,  8 Apr 2023 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680948915;
        bh=pzDyD8tzAlAD9Jp5Dut6PZOwqm6w5Ddo7OcNDD0eZCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SAMygo/kshU4hIim9jlXUqAl5D227Cv8aqj5/rvKHz/uEUe2jhCg4hpUlvvqoEch+
         l8WlToW3+8OKsKt+Tozb2EzrUye9K2qU6mr/RUusAJQ9wEfnFD4zPJYjfS6VOTpAZl
         xCvX88xn/8wrMr0EThCItNYiEO98INci+EY3egQ5ZnjUlIq7mrj3whJeaWN+OggxEP
         gzo5gKYXDQsFnJBQgD3iN/H+hq5YNb91AXuOrNwgfL5HlczqvbgATHBS7coPu6PVpa
         w7SV7X1dL9fBJxk1D4r9d8QZDpYu+UhwWywjdjfQ46zRy1j7H46aMkajZrqspje3VN
         EC/CcbCDvoZFg==
Date:   Sat, 8 Apr 2023 11:30:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Message-ID: <20230408113029.35429440@jic23-huawei>
In-Reply-To: <884c8f386541ac572939b8993df7aea6ad99613b.1677331779.git.mazziesaccount@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
        <884c8f386541ac572939b8993df7aea6ad99613b.1677331779.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 15:55:25 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Values in the iio_chan_info_enum are crucial for understanding the
> characteristics of an IIO channel and the data delivered via IIO channel.
> Give a hand to developers who do their first set of IIO drivers.
> 
> Add some documentation to these channel specifiers.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Please note that I did only add documentation for entries I am familiar
> with. I did still add doc placeholders for all of the enum entries to
> ease seeing which entries could still be documented. Hopefully this
> encourages people to add missing pieces of documentation.

Good to hear the optimism :) 

I'll add it to my activities for boring journeys (with good internet
as probably need datasheets).  Note I'm reviewing this on a train
(having ignored it for a few weeks ;)

> ---
>  include/linux/iio/types.h | 46 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 82faa98c719a..c8e3288ca24b 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -35,7 +35,51 @@ enum iio_available_type {
>  	IIO_AVAIL_LIST,
>  	IIO_AVAIL_RANGE,
>  };
> -
> +/**
> + * enum iio_chan_info_enum - Information related to a IIO channel
> + *
> + * Many IIO channels have extra properties. Typically these properties can be
"extra" glosses over the fact that some of these almost always exist.
E.g. raw.

IIO channels have a range of properties that may be read from userspace
(via sysfs attributes) or from other drivers using the in kernel IIO consumer
interfaces.  These properties are read / written using the read_raw...


> + * read / written by user using the read_raw or write_raw callbacks in the
> + * struct iio_info.
> + *
> + * @IIO_CHAN_INFO_RAW:		Raw channel data as provided by device. Scale
> + *				and offset are often required to convert these
> + *				values to meaningful units.

to base units as defined in the IIO ABI (link)

> + * @IIO_CHAN_INFO_PROCESSED:	Processed data. Typically driver performs
> + *				computations to convert device data to more
> + *				meaningfull processed values.

Typically a driver performs computations to convert device data to the 
base units defined in the IIO ABI (link)

> + * @IIO_CHAN_INFO_SCALE:	Scale to be applied to data in order to convert
> + *				it to units mandated by the channel type.
> + * @IIO_CHAN_INFO_OFFSET:	Offset to be applied to data in order to convert
> + *				it to units mandated by the channel type.

Add ordering info.  "Applied before scale."

> + * @IIO_CHAN_INFO_CALIBSCALE:
> + * @IIO_CHAN_INFO_CALIBBIAS:
> + * @IIO_CHAN_INFO_PEAK:		Peak value (TODO: Since measurement start?)

IIRC not that consistent. Some devices have it from device reset (so start), some
do it on a short time scale (thing of a voltage channel measuring a sine wave -
instantaneous reading is the current voltage, peak can be the peak in the cycle).
Others again do it on an 'event detection basis'. 
Sometimes constructive ambiguity can be handy in documentation ;)

> + * @IIO_CHAN_INFO_PEAK_SCALE:	Scale to be applied to the peak value in order
> + *				to convert it to units mandated by the channel
> + *				type.
> + * @IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW:
> + * @IIO_CHAN_INFO_AVERAGE_RAW:	Average of raw values (TODO: Since measurement
> + *				start or just for some undefined time?)

Again, not that tightly defined (IIRC).  Average of raw values over a device specific time period.

> + * @IIO_CHAN_INFO_SAMP_FREQ:	Sampling frequency for device.
> + * @IIO_CHAN_INFO_FREQUENCY:
> + * @IIO_CHAN_INFO_PHASE:
> + * @IIO_CHAN_INFO_HARDWAREGAIN:	Amplification applied by the hardware.
Given how often this is done wrong I'd love to call out something like:
"SCALE should be used for control if the HARDWAREGAIN directly affects the
 channel RAW measurement". Examples of HARDWAREGAIN include amplification of
 the light signal in a time of flight sensor."


> + * @IIO_CHAN_INFO_HYSTERESIS:
> + * @IIO_CHAN_INFO_HYSTERESIS_RELATIVE:
> + * @IIO_CHAN_INFO_INT_TIME:	Integration time. Time during which the data is
> + *				accumulated by the device.

Unit? (seconds I think).

> + * @IIO_CHAN_INFO_ENABLE:
> + * @IIO_CHAN_INFO_CALIBHEIGHT:
> + * @IIO_CHAN_INFO_CALIBWEIGHT:
> + * @IIO_CHAN_INFO_DEBOUNCE_COUNT:
> + * @IIO_CHAN_INFO_DEBOUNCE_TIME:
> + * @IIO_CHAN_INFO_CALIBEMISSIVITY:
> + * @IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> + * @IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> + * @IIO_CHAN_INFO_CALIBAMBIENT:
> + * @IIO_CHAN_INFO_ZEROPOINT:
> + */
>  enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_RAW = 0,
>  	IIO_CHAN_INFO_PROCESSED,

