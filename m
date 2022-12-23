Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD46553B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiLWSwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiLWSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:52:20 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A011C0;
        Fri, 23 Dec 2022 10:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sq+h7xxwjEN+CM9cjCKnsYhDwQInBq858tzYVswY1uU=; b=iI6VB8Px56eBWKTpPTPXYoIuz+
        2CmFOeVPUfpH2P5EMeuo8yJk7Rz8Ll9ZC0AcASPRiAD3knu+3sCVaj2hzDEGGeuLvSu2hkqf/PgpV
        EyUaddEAZGdyn3DhaJ/swU76l9p4qATy8RZc4gfNaidWlNXNO2U7XP9Oqae1AUpOyRms=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49002 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p8n9N-0003rs-G9; Fri, 23 Dec 2022 13:52:10 -0500
Date:   Fri, 23 Dec 2022 13:52:09 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20221223135209.f46617b6f23ff9b60a85ebe7@hugovil.com>
In-Reply-To: <20221223141232.0f570f33@jic23-huawei>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-2-hugo@hugovil.com>
        <20221223141232.0f570f33@jic23-huawei>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v1 1/3] iio: adc: Kconfig: add SPI interface mention to
 AD7924 description
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 14:12:32 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 22 Dec 2022 15:36:08 -0500
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The Analog Devices AD7924 uses an SPI interface. There is also a Texas
> > Instruments ADS7924 which uses an I2C interface.
> > 
> > Adding the SPI mention to the AD7924 will help to avoid confusion
> > between the two chips.
> Hi Hugo,
> 
> Welcome to IIO.
> 
> I don't really mind this, but given they have different part numbers
> and the similarly named TI part could just have easily been SPI
> I'm not sure the clarification is really useful.
> 
> Also, under all the circumstances I can think of, if you can see the
> help text you can also see the SPI dependence clearly listed.
> 
> Hence I think is just noise, though I'm guessing it reflects a
> confusion you ran into!
> 
> Jonathan

Hi Jonathan,
yes, I initially tought that the TI ADS7924 was already supported because of the AD7924 entry. I wrongly assumed that the parts were similar and TI just renamed it because they bought Analog Devices. I am pretty sure that I am not the only one having made a similar error :)

Of course, both chips differ not only because of their interface (SPI vs I2C), but also in their modes of operation and registers, interrupt pin presence (ADS7924), etc.

But I can drop this patch if you want.

Hugo V.



> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/iio/adc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 46c4fc2fc534..235319546974 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -243,7 +243,7 @@ config AD7923
> >  	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to build support for Analog Devices
> > -	  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
> > +	  AD7904, AD7914, AD7923, AD7924 4 Channel SPI ADCs.
> >  
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad7923.
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
