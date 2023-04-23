Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D86EC2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDWWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDWWFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 18:05:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5B18C;
        Sun, 23 Apr 2023 15:05:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso528661166b.2;
        Sun, 23 Apr 2023 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682287512; x=1684879512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ2u0l2zpqNJaAk+JMWtJhYax1piahdKpA+iB7ZT9RA=;
        b=dF9KoAqK7GtV//hej4Ydz1Av0n4hZWSgtktbAd1jogaWW4/Eber2iIeQwTzJ5S+/5Y
         ZE6SPwrJMIX67uttPofdKKZudgw8Hzbg+MbRK30akBpQMfXjVvNcgMD31COTcD2vOFZr
         SIIi/temDkgfjgIRCNWsiV1byHoB44DuyUJaXHKGXg3KO5eL2O7YgDDcCEiMEnQHFV6n
         3039z3OfTI3kFmthM0fY67cBRMFLUadFoOkyzuS+6vY623tgt77sZH7pxmV3KK38WCw3
         jZPOtoUPCYVpsjESLAkj9GjE8JtCjL9SqdNNgwjAbXP4odzieCvXLh75maHNo2+UC8MP
         VBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682287512; x=1684879512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ2u0l2zpqNJaAk+JMWtJhYax1piahdKpA+iB7ZT9RA=;
        b=ELgizPGCc8jRDWLNDdCAgWD0gmrGDg+jPOxotpMDxnj1huhSEljvcZz2slG1OG+hvR
         qxgI94tIJLJf3HFODtFuSd0snCgmLdFyEzYIAZmx1U4R8PpU12hq+ofjQcs+O1u9Awgb
         zEGxdPAK6tuUqt8UwgohBfkRalSy89Yj4XCULX1eFVWJwuTW5eHNpEmlXKWk6owjc/Hq
         cwp/2RVLWVB/K6g5HiWrtpWi1BCVWcJ0++DVTOJCNvZTdZQH0LM6HdM7v8csnoPqr32R
         eL2lv0IVmBriShv2/pxUBjg38dt0VCZFDEob2Pz34M3pdajE4Y70kSEq2u9X2cm8wZkS
         PGhw==
X-Gm-Message-State: AAQBX9eD+tT061W3xnvIXXtG6ltdYGmmV8CGkWuolYfwexVj7bRdcv81
        8Age0Tuu0xJ9LMrPkzb4FDE=
X-Google-Smtp-Source: AKy350ZK3GTMOFx6IkMPPBsEIiOXnP1uYZXdKzQ3PWCNubdqCTOdEsAK98fA8XgyrATAA8lfjZ5bGw==
X-Received: by 2002:a17:907:3ac3:b0:94e:70bb:5f8a with SMTP id fi3-20020a1709073ac300b0094e70bb5f8amr7029385ejc.66.1682287512119;
        Sun, 23 Apr 2023 15:05:12 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906338f00b0094c3ac3c2bbsm4813852eja.212.2023.04.23.15.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 15:05:11 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:05:09 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZEWrleoBekBYkhYy@carbian>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
 <20230422184653.7ae28d5a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422184653.7ae28d5a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Sat, Apr 22, 2023 at 06:46:53PM +0100, Jonathan Cameron wrote:
> On Thu, 20 Apr 2023 22:22:04 +0200
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Since Kionix accelerometers use various numbers of bits to report data, a
> > device-specific function is required.
> > Move the driver's private data to the header file to support the new function.
> > Make the allocation of the "buffer" array in the fifo_flush function dynamic
> > and more generic.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> 
> This results in some fifo_length changes in here and some in the previous patch.
> Either keep it fixed for first patch, then make those changes and the ones you have
> here in a single patch, or if that's hard maybe a single patch is cleaner.
> 
> I'd only expect the stuff about bytes in buffer to be in this patch.
> 
> Jonathan

I will come up with a better solution in the v3

> 
> 
> 
> > ---
> > v2:
> > - separated this change from the chip_info introduction and made it a patch in v2 
> > - changed the function from generic implementation for to device-specific one
> > - removed blank lines pointed out by checkpatch
> > - changed the allocation of the "buffer" array in __kx022a_fifo_flush
> > 
> >  drivers/iio/accel/kionix-kx022a.c | 72 +++++++++++++------------------
> >  drivers/iio/accel/kionix-kx022a.h | 37 ++++++++++++++++
> >  2 files changed, 66 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index 7f9a2c29790b..1c81ea1657b9 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -150,36 +150,6 @@ static const struct regmap_config kx022a_regmap_config = {
> >  	.cache_type = REGCACHE_RBTREE,
> >  };
> >  
> > -struct kx022a_data {
> > -	struct regmap *regmap;
> > -	struct iio_trigger *trig;
> > -	struct device *dev;
> > -	struct iio_mount_matrix orientation;
> > -	int64_t timestamp, old_timestamp;
> > -
> > -	int irq;
> > -	int inc_reg;
> > -	int ien_reg;
> > -
> > -	unsigned int state;
> > -	unsigned int odr_ns;
> > -
> > -	bool trigger_enabled;
> > -	/*
> > -	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
> > -	 * middle of a configuration, or when the fifo is enabled. Also,
> > -	 * protect the data stored/retrieved from this structure from
> > -	 * concurrent accesses.
> > -	 */
> > -	struct mutex mutex;
> > -	u8 watermark;
> > -
> > -	/* 3 x 16bit accel data + timestamp */
> > -	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> > -	struct {
> > -		__le16 channels[3];
> > -		s64 ts __aligned(8);
> > -	} scan;
> >  };
> >  
> >  static const struct iio_mount_matrix *
> > @@ -340,7 +310,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
> >  		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
> >  
> >  	return ret;
> > -
> 
> Grumpy maintainer hat on:  I don't want to see white space changes in unrelated code
> in a patch doing anything other than white space cleanup.

I will make a separate patch.

> 
> >  }
> >  
> >  static int kx022a_turn_off_lock(struct kx022a_data *data)
> > @@ -595,34 +564,50 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> >  	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
> >  }
> > 
> 
> 
> >  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >  			       bool irq)
> >  {
> >  	struct kx022a_data *data = iio_priv(idev);
> > -	struct device *dev = regmap_get_device(data->regmap);
> > -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> > +	__le16 *buffer;
> >  	uint64_t sample_period;
> >  	int count, fifo_bytes;
> >  	bool renable = false;
> >  	int64_t tstamp;
> >  	int ret, i;
> >  
> > -	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> > -	if (ret) {
> > -		dev_err(dev, "Error reading buffer status\n");
> > -		return ret;
> > -	}
> > +	/* 3 axis, 2 bytes of data for each of the axis */
> > +	buffer = kmalloc(data->chip_info->fifo_length * 6, GFP_KERNEL);
> 
> Split that 6 up into sizeof(*buffer) * 3 
> Then just comment on 3 axis.  Or use a define for number of axis and drop the
> comment entirely.
> 
> Also, this feels like it fitst better in previous patch.

I will add this change to the previous patch

> 
> 
> > +	if (!buffer)
> > +		return -ENOMEM;
> >  
> > -	/* Let's not overflow if we for some reason get bogus value from i2c */
> > -	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> > -		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> > +	fifo_bytes = data->chip_info->get_fifo_bytes(data);
> 
> Only this small part is what this patch claims to do.. (+ the callback of course).
> 
> 
> >  
> >  	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
> >  		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> >  
> >  	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> > -	if (!count)
> > +	if (!count) {
> > +		kfree(buffer);
> >  		return 0;
> > +	}
> >  
> >  	/*
> >  	 * If we are being called from IRQ handler we know the stored timestamp
> > @@ -704,6 +689,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >  	if (renable)
> >  		enable_irq(data->irq);
> >  
> > +	kfree(buffer);
> >  	return ret;
> >  }
> >  
> > @@ -1016,6 +1002,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
> >  	.inc5		  = KX022A_REG_INC5,
> >  	.inc6		  = KX022A_REG_INC6,
> >  	.xout_l		  = KX022A_REG_XOUT_L,
> > +	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
> >  };
> >  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> >  
> > @@ -1143,7 +1130,6 @@ int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chi
> >  	if (ret)
> >  		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> >  
> > -
> 
> Another one.  If those predate your series, feel free to clean them up either
> at the start or end of this series.

I will

--
Kind Regards
Mehdi Djait
