Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA702659B15
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiL3Rt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiL3Rty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:49:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0121A380;
        Fri, 30 Dec 2022 09:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45DF361B00;
        Fri, 30 Dec 2022 17:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F995C433D2;
        Fri, 30 Dec 2022 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672422592;
        bh=mCQwh+M4v4BqKHGPRo63aRCGwtmNGYo5iHzaQi1VwBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cyG9qoJRrp0kZa+RNIanWDpaFXXsqnQ3E3AXCJEOvWuYofdX/HcutnreO0RPxqxIm
         ama/vpsFeQ4LvdXHGXY2tlpgX7qNIUwDWP3jPiP7XmXo8ayS65m3uojr5Zd9aq+SKB
         Kohl7sp0YXqyasGKIMCY9iYTB8f81kVz0vwg7eIeeUFy4BUnLeX98KLwKv2CAXcT4n
         ytCGkgVCj4MAZrZR9lu4aXKrT8ORMMWF3CM5dloGiR/oE96P3wzY9wXbZm5l2/6YSY
         H/5wclT2taOM4R1qKW8/NqJ0YJGMbbx7/TvUO9UuPkkuWMkRkXcBW/dFNuokX7vJqV
         3GmM1AfkvUEMQ==
Date:   Fri, 30 Dec 2022 18:03:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] iio: adc: Kconfig: add SPI interface mention to
 AD7924 description
Message-ID: <20221230180310.5978f5b6@jic23-huawei>
In-Reply-To: <20221223135209.f46617b6f23ff9b60a85ebe7@hugovil.com>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-2-hugo@hugovil.com>
        <20221223141232.0f570f33@jic23-huawei>
        <20221223135209.f46617b6f23ff9b60a85ebe7@hugovil.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Fri, 23 Dec 2022 13:52:09 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Fri, 23 Dec 2022 14:12:32 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 22 Dec 2022 15:36:08 -0500
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> >   
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > The Analog Devices AD7924 uses an SPI interface. There is also a Texas
> > > Instruments ADS7924 which uses an I2C interface.
> > > 
> > > Adding the SPI mention to the AD7924 will help to avoid confusion
> > > between the two chips.  
> > Hi Hugo,
> > 
> > Welcome to IIO.
> > 
> > I don't really mind this, but given they have different part numbers
> > and the similarly named TI part could just have easily been SPI
> > I'm not sure the clarification is really useful.
> > 
> > Also, under all the circumstances I can think of, if you can see the
> > help text you can also see the SPI dependence clearly listed.
> > 
> > Hence I think is just noise, though I'm guessing it reflects a
> > confusion you ran into!
> > 
> > Jonathan  
> 
> Hi Jonathan,
> yes, I initially tought that the TI ADS7924 was already supported because of the AD7924 entry. I wrongly assumed that the parts were similar and TI just renamed it because they bought Analog Devices. I am pretty sure that I am not the only one having made a similar error :)
> 

Yikes.  If TI bought ADI that would definitely be big news (my uninformed
guess it it would never get past competition authorities :)

I do vaguely wonder if long term we'll have to start naming drivers
with vendor prefixes as we will eventually get significant naming clashes.
Still I'm not keen to do it until we have a real problem.


> Of course, both chips differ not only because of their interface (SPI vs I2C), but also in their modes of operation and registers, interrupt pin presence (ADS7924), etc.
> 
> But I can drop this patch if you want.

Will do,

Thanks,

Jonathan

> 
> Hugo V.
> 
> 
> 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  drivers/iio/adc/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 46c4fc2fc534..235319546974 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -243,7 +243,7 @@ config AD7923
> > >  	select IIO_TRIGGERED_BUFFER
> > >  	help
> > >  	  Say yes here to build support for Analog Devices
> > > -	  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
> > > +	  AD7904, AD7914, AD7923, AD7924 4 Channel SPI ADCs.
> > >  
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called ad7923.  
> > 
> >   
> 
> 

