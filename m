Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C089D6F24BE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjD2M7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 08:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjD2M7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 08:59:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0624B1BFD;
        Sat, 29 Apr 2023 05:59:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-959a626b622so126331366b.0;
        Sat, 29 Apr 2023 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682773154; x=1685365154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MF1sOnd7z2Q3q3zyjfdxsO1FoyTcHn04FgE8LUT5oA=;
        b=TXM+4px41X1r6lbFs1352GvdrLLDBp6+5tri1j91CEJVv+7p2SdGEOsb9C+hJTMtYe
         svb/EFbgFYVrQJ/a+hlMxAAAOVcOqeT0ygdkrABKbq2Z0JR5yROvH73gXdmjHsuG03lO
         eICgRUcz/7DqBLd+tkDXTu2kLyvjvFPJBMTQCxCS+VRIQ19BuExC1dDLVg1TjMJPypPI
         LLyDYFJyNIT9d5NgsBTb43tSk6mHRRFsJWtQu+UdFwABifwfvsu5TqxSdcIyxEKJUzjf
         aC42hvYWK8Edv1ylcrT8KKkSzxEKeSvGzjhh+hgxPXoipwLPW+hZ3YKOf5laLy0vHx0M
         Jsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682773154; x=1685365154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MF1sOnd7z2Q3q3zyjfdxsO1FoyTcHn04FgE8LUT5oA=;
        b=FrSTX6xrdVSRJ3om/Ekm+3NZkH6Cs285ZcY/fMyiVDc5UbSMPNlFkuxMrQ/9NRQGZp
         EChSivZ28NJm+CDCsz3JquZ27n3CmEbv9MP7ocSP66beidabQ5ElCyvdqk39fbKleeKX
         HqxuYxPJG4hBJSL1sQgB3fl2dQPcPMmPd9wI4QxqxeunVC2ozRgg+SZALCXZirSP3P8d
         GxSphsi4r+4hnvv6LRnhSMKc6VJBcU5dPTu338TZtBb+yy8mhiy5BYnR2x5U5hxpbvWy
         ohaVSgjv+Vv/Hmvnq/zhUNDxN4w7NKzFDhlvTSgPDOJ6bE+cF9zvc2EdS7EvDAFu7XBd
         h9cQ==
X-Gm-Message-State: AC+VfDyIxVWBMONORtpx5m21pFyf1CeXkQQYX8tw4ZqTqltLBphnIjEq
        Px+8W4C14K1MLI6c1BupcH4g1oPScss=
X-Google-Smtp-Source: ACHHUZ4UtcMpyOFtBb+PAPr1e0+HG+U5zRS58c5Im2TRIq+EC4ZRXP7/+iieqTXt7aAWC7mgXnzLaA==
X-Received: by 2002:a17:906:4fd6:b0:93f:505b:9742 with SMTP id i22-20020a1709064fd600b0093f505b9742mr8123544ejw.65.1682773154183;
        Sat, 29 Apr 2023 05:59:14 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::2d16])
        by smtp.gmail.com with ESMTPSA id hb8-20020a170906b88800b0094bb4c75695sm12511055ejb.194.2023.04.29.05.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 05:59:13 -0700 (PDT)
Date:   Sat, 29 Apr 2023 14:59:11 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZE0Unz0lxMWY4pRf@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com>
 <ZEeAGN3TBcao3CNA@carbian>
 <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Tue, Apr 25, 2023 at 11:12:11AM +0300, Matti Vaittinen wrote:
> On 4/25/23 10:24, Mehdi Djait wrote:
> > Hi Matti,
> > 
> > On Tue, Apr 25, 2023 at 09:50:11AM +0300, Matti Vaittinen wrote:
> > > On 4/25/23 01:22, Mehdi Djait wrote:
> > > > Add the chip_info structure to the driver's private data to hold all
> > > > the device specific infos.
> > > > Refactor the kx022a driver implementation to make it more generic and
> > > > extensible.
> > > > 
> > > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > > ---
> > > > v3:
> > > > - added the change of the buffer's allocation in the __kx022a_fifo_flush
> > > >     to this patch
> > > > - added the chip_info to the struct kx022a_data
> > > > 
> > > > v2:
> > > > - mentioned the introduction of the i2c_device_id table in the commit
> > > > - get i2c_/spi_get_device_id only when device get match fails
> > > > - removed the generic KX_define
> > > > - removed the kx022a_device_type enum
> > > > - added comments for the chip_info struct elements
> > > > - fixed errors pointed out by the kernel test robot
> > > > 
> > > >    drivers/iio/accel/kionix-kx022a-i2c.c |  15 +++-
> > > >    drivers/iio/accel/kionix-kx022a-spi.c |  15 +++-
> > > >    drivers/iio/accel/kionix-kx022a.c     | 114 +++++++++++++++++---------
> > > >    drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++-
> > > >    4 files changed, 147 insertions(+), 51 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> > > > index 8f23631a1fd3..ce299d0446f7 100644
> > > > --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> > > > +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> > > > @@ -15,6 +15,7 @@
> > > 
> > > ...
> > > 
> > > 
> > > >    static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> > > > @@ -600,13 +600,17 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> > > >    {
> > > >    	struct kx022a_data *data = iio_priv(idev);
> > > >    	struct device *dev = regmap_get_device(data->regmap);
> > > > -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> > > > +	__le16 *buffer;
> > > >    	uint64_t sample_period;
> > > >    	int count, fifo_bytes;
> > > >    	bool renable = false;
> > > >    	int64_t tstamp;
> > > >    	int ret, i;
> > > > +	buffer = kmalloc(data->chip_info->fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
> > > > +	if (!buffer)
> > > > +		return -ENOMEM;
> > > 
> > > Do you think we could get rid of allocating and freeing the buffer for each
> > > flush? I feel it is a bit wasteful, and with high sampling frequencies this
> > > function can be called quite often. Do you think there would be a way to
> > > either use stack (always reserve big enough buffer no matter which chip we
> > > have - or is the buffer too big to be safely taken from the stack?), or a
> > > buffer stored in private data and allocated at probe or buffer enable?
> > 
> > I tried using the same allocation as before but a device like the KX127
> > has a fifo_length of 342 (compared to 86 for kx132, and 43 for kx022a).
> > Allocating this much using the stack will result in a Warning.
> > 
> 
> Right. Maybe you could then have the buffer in private-data and allocate it
> in buffer pre-enable? Do you think that would work?

Do you mean add a new function kx022a_buffer_preenable to iio_buffer_setup_ops ?

Would adding the allocation to kx022a_fifo_enable and the free to
kx022a_fifo_disable be a good option also ?

> > > 
> > > Also, please avoid such long lines. I know many people don't care about the
> > > line length - but for example I tend to have 3 terminal windows open
> > > side-by-side on my laptop screen. Hence long lines tend to be harder to read
> > > for me.
> > 
> > That is the case for me also, but Jonathan asked me to change
> > "fifo_length * 6" and the KX022A_FIFO_SAMPLES_SIZE_BYTES is already
> > defined.
> 
> then please maybe split the line from appropriate point like:
> buffer = kmalloc(data->chip_info->fifo_length *
> 		 KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);

I will split it

> 
> > 
> > > 
> > > > +
> > > >    	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> > > >    	if (ret) {
> > > >    		dev_err(dev, "Error reading buffer status\n");
> > > > @@ -621,8 +625,10 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> > > >    		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> > > >    	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> > > > -	if (!count)
> > > > +	if (!count) {
> > > > +		kfree(buffer);
> > > >    		return 0;
> > > > +	}
> > > >    	/*
> > > >    	 * If we are being called from IRQ handler we know the stored timestamp
> > > > @@ -679,7 +685,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> > > >    	}
> > > >    	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
> > > > -	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
> > > > +	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
> > > >    				&buffer[0], fifo_bytes);
> > > >    	if (ret)
> > > >    		goto renable_out;
> > > > @@ -704,6 +710,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> > > >    	if (renable)
> > > >    		enable_irq(data->irq);
> > > > +	kfree(buffer);
> > > >    	return ret;
> > > >    }
> > > > 
> > > ...
> > > 
> > > > -int kx022a_probe_internal(struct device *dev)
> > > > +const struct kx022a_chip_info kx022a_chip_info = {
> > > > +	.name		  = "kx022-accel",
> > > > +	.regmap_config	  = &kx022a_regmap_config,
> > > > +	.channels	  = kx022a_channels,
> > > > +	.num_channels	  = ARRAY_SIZE(kx022a_channels),
> > > > +	.fifo_length	  = KX022A_FIFO_LENGTH,
> > > > +	.who		  = KX022A_REG_WHO,
> > > > +	.id		  = KX022A_ID,
> > > > +	.cntl		  = KX022A_REG_CNTL,
> > > > +	.cntl2		  = KX022A_REG_CNTL2,
> > > > +	.odcntl		  = KX022A_REG_ODCNTL,
> > > > +	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
> > > > +	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
> > > > +	.buf_clear	  = KX022A_REG_BUF_CLEAR,
> > > > +	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
> > > > +	.buf_read	  = KX022A_REG_BUF_READ,
> > > > +	.inc1		  = KX022A_REG_INC1,
> > > > +	.inc4		  = KX022A_REG_INC4,
> > > > +	.inc5		  = KX022A_REG_INC5,
> > > > +	.inc6		  = KX022A_REG_INC6,
> > > > +	.xout_l		  = KX022A_REG_XOUT_L,
> > > > +};
> > > > +EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> > > 
> > > Do you think the fields (or at least some of them) in this struct could be
> > > named based on the (main) functionality being used, not based on the
> > > register name? Something like "watermark_reg", "buf_en_reg", "reset_reg",
> > > "output_rate_reg", "int1_pinconf_reg", "int1_src_reg", "int2_pinconf_reg",
> > > "int1_src_reg" ...
> > > 
> > > I would not be at all surprized to see for example some IRQ control to be
> > > shifted from INC<X> to INC<Y> or cntl<X> / buf_cntl<X> stuff to be moved to
> > > cntl<Y> or to buf_cntl<Y> for next sensor we want to support. Especially
> > > when new cool feature is added to next sensor, resulting also adding a new
> > > cntl<Z> or buf_cntl<Z> or INC<Z>.
> > > 
> > > I, however, believe the _functionality_ will be there (in some register) -
> > > at least for the ICs for which we can re-use this driver. Hence, it might be
> > > nice - and if you can think of better names for these fields - to rename
> > > them based on the _functionality_ we use.
> > > 
> > > Another benefit would be added clarity to the code. Writing a value to
> > > "buf_en_reg", "watermark_reg" or to "int1_src_reg" is much clearer (to me)
> > > than writing a value to "buf_cntl1", "buf_cntl2" or "INC4". Especially if
> > > you don't have a datasheet at your hands.
> > > 
> > > I am not "demanding" this (at least not for now :]) because it seems these
> > > two Kionix sensors have been pretty consistent what comes to maintaining the
> > > same functionality in the registers with same naming - but I believe this is
> > > something that may in any case be lurking around the corner.
> > 
> > I agree, this seems to be the better solution. I will look into this.
> > 
> 
> Thanks for going the extra mile :)

Thank you for the review

--
Kind Regards
Mehdi Djait
