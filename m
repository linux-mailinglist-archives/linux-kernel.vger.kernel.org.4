Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC546C3654
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCUP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjCUP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:56:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5274850FAD;
        Tue, 21 Mar 2023 08:56:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so61592133edd.5;
        Tue, 21 Mar 2023 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679414205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Avxg+wqBheAZBOFL4DRSDNWUNaL22DnyGnVWnYTFkUc=;
        b=BGFUA/vTAoKrvp1XiMnjzwiBRikzw9EI3kIEyJid3gpdbWhJRhGr8REYMcKymQRBHE
         KLh2K1Fz4WD0tVcav03cxcGTRDeVWiMTnS1WpjSDFC4HB3ggG16ZvAE8ft4lF0rv8tTL
         +0K5mrsowODR+zXpgxUioti3txwEAdlQey0r2d5mg23pJJWP2lih4wLKdTJtGH/Cb+II
         al19FGOxCWuyNr0Ije0g+eZOrzlvU8jvemgLHd4ILOW1j4oO9JdQhWyEVZwGly8G46o4
         V5p/glr2MJuQBJYS0a2S132z8O600YZHTVcJvAtFsEUnFt7bfG8OWIQ1UetpCLEZiNL2
         t7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679414205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avxg+wqBheAZBOFL4DRSDNWUNaL22DnyGnVWnYTFkUc=;
        b=f2F5iMo42EHwedzNhV9QeQ8KdmXOoLiOWStirPPQiV7Ueg3bJgYcStXcop1TSsqdp2
         zKc64oeXT80Wp2p/47NSciT0RXOTwEvFVoLtZGBil/O1ynWaetVYrP52dqlSykM1CcL4
         ZRmxLmZ29P8hJFcWZ/xPGDw4MTJO82LSP4x2BIz27Bf4QzmKYYOGHlCTCW4kjF3jdQDz
         2PMxN7PFbReOQjM62X+PonIUKc7xScZXIUnvfxsn6UXigNlvNS/mzMDONLzuJkW4u2NJ
         20fC6LyDqFhe/Tzg3z8klAuMC/igGQX7UVZ5Ia1B5PyWZbOsFUkbPCM9o9VDUSMnwyaC
         IOfA==
X-Gm-Message-State: AO0yUKVZI0rjxjcHN4BGPsyP8XrNr8iYT/+rks6NirjX5ffWcIkASJ0x
        U4+bsJ7iLBi80jtNUF2KzF8=
X-Google-Smtp-Source: AK7set9zJtJATgBFmUbEPELSo4KADQnNTfcPzJvVliB52XwsopA65iCr2MFLwxuxd6dIJYMvmu6KLw==
X-Received: by 2002:a17:906:180c:b0:92c:8e4a:1a42 with SMTP id v12-20020a170906180c00b0092c8e4a1a42mr3309080eje.32.1679414205533;
        Tue, 21 Mar 2023 08:56:45 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::a9c0])
        by smtp.gmail.com with ESMTPSA id ot9-20020a170906ccc900b009331450d04esm4824055ejb.178.2023.03.21.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:56:45 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:56:43 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <ZBnTuykAqse5vBhO@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
 <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matti,

> > +static int kx022a_get_fifo_bytes(struct kx022a_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	__le16 buf_status;
> > +	int ret, fifo_bytes;
> > +
> > +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1, &buf_status, sizeof(buf_status));
> > +	if (ret) {
> > +		dev_err(dev, "Error reading buffer status\n");
> > +		return ret;
> > +	}
> > +
> > +	buf_status &= data->chip_info->buf_smp_lvl_mask;
> > +	fifo_bytes = le16_to_cpu(buf_status);
> > +
> > +	/*
> > +	 * The KX022A has FIFO which can store 43 samples of HiRes data from 2
> > +	 * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
> > +	 * 258 bytes of sample data. The quirk to know is that the amount of bytes in
> > +	 * the FIFO is advertised via 8 bit register (max value 255). The thing to note
> > +	 * is that full 258 bytes of data is indicated using the max value 255.
> > +	 */
> > +	if (data->chip_info->type == KX022A && fifo_bytes == KX022A_FIFO_FULL_VALUE)
> > +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> > +
> > +	if (fifo_bytes % KX_FIFO_SAMPLES_SIZE_BYTES)
> > +		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> > +
> > +	return fifo_bytes;
> > +}
> 
> I like adding this function. Here I agree with Jonathan - having a device
> specific functions would clarify this a bit. The KX022A "quirk" is a bit
> confusing. You could then get rid of the buf_smp_lvl_mask.

my bad here, I should have made a separate patch and explained more ...
buf_smp_lvl_mask is essential because kionix products use different
number of bits to report "the number of data bytes that have been stored in the 
sample buffer" using the registers BUF_STATUS_1 and BUF_STATUS_2

kx022a: 8bits
kx132: 10bits
kx12x: 11bits
kx126: 12bits

I think this function is quite generic and can be used for different
kionix devices: 

- It reads BUF_STATUS_1 and BUF_STATUS_2 and then uses a chip specific
mask 
- It takes care of the quirk of kx022a which is just a simple if statement 

> 
> > +
> >   static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> >   {
> >   	/*
> > @@ -593,35 +588,22 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> >   	 */
> >   	data->timestamp = 0;
> > -	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
> > +	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
> >   }
> >   static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >   			       bool irq)
> >   {
> >   	struct kx022a_data *data = iio_priv(idev);
> > -	struct device *dev = regmap_get_device(data->regmap);
> > -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> > +	__le16 buffer[data->chip_info->fifo_length * 3];
> 
> I don't like this. Having the length of an array decided at run-time is not
> something I appreciate. Maybe you could just always reserve the memory so
> that the largest FIFO gets supported. I am just wondering how large arrays
> we can safely allocate from the stack?

I was stupid enough to ignore the warnings... 
I will take care of it in the v2

> 
> 
> > @@ -812,14 +792,14 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
> >   		goto unlock_out;
> >   	/* Enable buffer */
> > -	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> > -			      KX022A_MASK_BUF_EN);
> > +	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
> > +			      KX_MASK_BUF_EN);
> >   	if (ret)
> >   		goto unlock_out;
> > -	data->state |= KX022A_STATE_FIFO;
> > +	data->state |= KX_STATE_FIFO;
> >   	ret = regmap_set_bits(data->regmap, data->ien_reg,
> > -			      KX022A_MASK_WMI);
> > +			      KX_MASK_WMI);
> 
> I think this fits to one line now. (even on my screen)
> 
> >   	if (ret)
> >   		goto unlock_out;
> 
> > -int kx022a_probe_internal(struct device *dev)
> > +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
> 
> As mentioned elsewhere, this might also work if the chip-type enum was
> passed here as parameter. That way the bus specific part would not need to
> know about the struct chip_info...
> 
> >   {
> >   	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> >   	struct iio_trigger *indio_trig;
> > @@ -1023,6 +1003,7 @@ int kx022a_probe_internal(struct device *dev)
> >   		return -ENOMEM;
> >   	data = iio_priv(idev);
> > +	data->chip_info = chip_info;
> 
> ...Here you could then pick the correct chip_info based on the chip-type
> enum. In that case I'd like to get the regmap_config(s) in own file. Not
> sure how that would look like though.
> 
> All in all, I like how this looks like. Nice job!

Thank you for the feedback :)

--
Kind Regards 
Mehdi Djait
