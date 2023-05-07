Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA96F9912
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEGO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEGO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:57:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E53A80;
        Sun,  7 May 2023 07:56:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so6897519a12.3;
        Sun, 07 May 2023 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683471418; x=1686063418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W963wxv9DpcswAJzjNkJzwD3eg9G189aTAyjNcouCSk=;
        b=btxMPhJC7e5MUVebZDt7VLwlknIpicMhLyXV5iwzelFWoKa4UtjFZAPd9sN1UvlHOX
         q4Gr1cArbtqI7dI1nFVCP/AXamwjtayRBdC5cORFPh4ikEgOGw8FlRexSuzENf/llnaq
         42GgWQy/vF3atBgNBMRkSnpT0aePFMsKXFI0ZfRnGBiveW5p57GIrGFsgins+eHIZ0Mn
         RkrhHRdLCkAPOZZX7fnP/KiQJLBmweTBSvyAeEGKACA8T8N9WfoLbjaMr0smMKZQpQvl
         k+AGL3shBcy2uEp6CIdxzLt+DN0biK6v8Sgfj42lPLzVNwVp9ZcV4JxxsID2AsdPFLTo
         tLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683471418; x=1686063418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W963wxv9DpcswAJzjNkJzwD3eg9G189aTAyjNcouCSk=;
        b=DZiKSGEQ7X1SG7UW05SydvXfb+Kifs+izQbbTqycbUGIL9a0ecFeYtFp92DotU1JFf
         3xloRBVzeF3unKWDLXxEnAbvMMK2GeSz4hF0V/JnAd5Gr91eNNcWJlZDk/vXVTelMHU6
         K4iheiShZ4x+PJdR6fhp5FiwftvaYJ+LrxN8yP4o5X2fL0paQQC3VeB59wA/lPNeqSL8
         Zq20Agz7EMG9+GfNs1/+CSVlFgYoJAzMAjvw1BZ3X7mne3lEP8zXmeghDJLqr+Tm43qa
         eSU9xMZuSmATjkPdtlo8ybVH54Yn3EbNWH4aY+wR6uJ/MsnshxlqgyodoYi/xrNcsyXq
         nbaw==
X-Gm-Message-State: AC+VfDzwwzB50xREK17EVvj4Kc5+svbFA+XhML3HcEGVygaMEb+RlSHA
        Cl1+8fapo4R9dAw4Q33Bh5c=
X-Google-Smtp-Source: ACHHUZ6TT4qgGldoB0g81wuj5xfzguUGluprAsQRfPvshBanuMVyPjWNqezbtCQ5J6RXKobrDfdbBQ==
X-Received: by 2002:a17:907:3fa6:b0:966:6035:c81e with SMTP id hr38-20020a1709073fa600b009666035c81emr728831ejc.52.1683471417886;
        Sun, 07 May 2023 07:56:57 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::5908])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7cc14000000b0050c0d651fb1sm3488800edt.75.2023.05.07.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 07:56:57 -0700 (PDT)
Date:   Sun, 7 May 2023 16:56:55 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZFe8N8EhNTOkLO0c@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
 <20230501155645.435242f0@jic23-huawei>
 <ZFVG1cyY/Ge/nXOh@carbian>
 <20230506174651.5c5740d9@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230506174651.5c5740d9@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Sat, May 06, 2023 at 05:46:51PM +0100, Jonathan Cameron wrote:
> On Fri, 5 May 2023 20:11:33 +0200
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Hello Jonathan,
> > 
> > On Mon, May 01, 2023 at 03:56:45PM +0100, Jonathan Cameron wrote:
> > > On Tue, 25 Apr 2023 00:22:27 +0200
> > > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> > >   
> > > > Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> > > > ranges from ±2G to ±16G, digital output through I²C/SPI.
> > > > Add support for basic accelerometer features such as reading acceleration
> > > > via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
> > > > 
> > > > Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> > > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>  
> > > 
> > > Two tiny things inline.  
> > >   
> > > > +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> > > > +{
> > > > +	struct device *dev = regmap_get_device(data->regmap);
> > > > +	__le16 buf_status;
> > > > +	int ret, fifo_bytes;
> > > > +
> > > > +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> > > > +			       &buf_status, sizeof(buf_status));
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Error reading buffer status\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	fifo_bytes = le16_to_cpu(buf_status);
> > > > +	fifo_bytes &= data->chip_info->buf_smp_lvl_mask;  
> > > 
> > > Slight preference for FIELD_GET() as it saves me checking the mask includes
> > > lowest bits.  
> > 
> > This will mean I have the remove the chip_info member buf_smp_lvl_mask
> > and use KX132_MASK_BUF_SMP_LVL directly because otherwise the
> > __builtin_constant_p function will cause an error when building. 
> > Check: https://elixir.bootlin.com/linux/latest/source/include/linux/bitfield.h#L65
> > 
> > I can change it to FIELD_GET() if you want to.
> 
> Good point.  You could use le16_get_bits() though which I'm fairly sure will take
> a variable just fine.
> 

I don't think it will work. 

From the commit log introducing the {type}_get_bits to <linux/bitfield.h>
"    Field specification must be a constant; __builtin_constant_p() doesn't
    have to be true for it, but compiler must be able to evaluate it at
    build time.  If it cannot or if the value does not encode any bitfield,
    the build will fail. "

Actually Geert Uytterhoeven tried to solve excatly this issue, but it
seems that the patch was not accepted. 
Check: https://lore.kernel.org/linux-iio/3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be/


So which solution would be the best:

1. Use directly KX132_MASK_BUF_SMP_LVL, the only reason I was trying to
avoid this was to make this function generic enough for other chip
variants

2. Copy the field_get() definition from drivers/clk/at91 or from the commit
of Geert and use it in this driver

3. leave it as it is ? 

4. another solution ?

> >
> > > 
> > >   
> > > > +
> > > > +	return fifo_bytes;
> > > > +}
> > > > +
> > > >  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> > > >  			       bool irq)
> > > >  {
> > > > @@ -1036,6 +1157,32 @@ const struct kx022a_chip_info kx022a_chip_info = {
> > > >  };
> > > >  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> > > >  
> > > > +const struct kx022a_chip_info kx132_chip_info = {
> > > > +	.name		  = "kx132-1211",
> > > > +	.regmap_config	  = &kx132_regmap_config,
> > > > +	.channels	  = kx132_channels,
> > > > +	.num_channels	  = ARRAY_SIZE(kx132_channels),
> > > > +	.fifo_length	  = KX132_FIFO_LENGTH,
> > > > +	.who		  = KX132_REG_WHO,
> > > > +	.id		  = KX132_ID,
> > > > +	.cntl		  = KX132_REG_CNTL,
> > > > +	.cntl2		  = KX132_REG_CNTL2,
> > > > +	.odcntl		  = KX132_REG_ODCNTL,
> > > > +	.buf_cntl1	  = KX132_REG_BUF_CNTL1,
> > > > +	.buf_cntl2	  = KX132_REG_BUF_CNTL2,
> > > > +	.buf_clear	  = KX132_REG_BUF_CLEAR,
> > > > +	.buf_status1	  = KX132_REG_BUF_STATUS_1,
> > > > +	.buf_smp_lvl_mask = KX132_MASK_BUF_SMP_LVL,  
> > > 
> > > There are some things in here (typically where the define isn't used
> > > anywhere else) where I think it would be easier to follow if the
> > > value was listed here.  Masks and IDs for example. 
> > >   
> > 
> > After removing buf_smp_lvl_mask, which members will be easier to understand (besides id) ? 
> 
> I haven't gone through them.  Length seems an obvious one.  It's a number not a magic value.
> Register addresses might also be simpler if they aren't used elsewhere.
> 
> Not really about understanding just about a define that adds nothing if all we do is
> assign it to a variable of the same name.

Do you have a strong opinion about this ? 

I would really prefer to leave it like this, for the following reasons:

1. If I directly use values here, I have to do it also in the previous
patch where I introduce the chip_info for the kx022a -> this means I
will have defines in the h file which are not used at all -> the defines should
be deleted -> the patch will get unnecessarily bigger. I received
multiple comments about removing unnecessary changes and reducing of the
patch size when possible.

2. Consistency: having all the defines in one place really seems to be
better for understanding IMO. I find the mix of values and defines in 
the chip-info a bit confusing, e.g., I will use the direct value for 
KX132_REG_CNTL but not for KX132_REG_CNTL2 because KX132_REG_CNTL2 is
referenced in a regmap_range. 

--
Kind Regards
Mehdi Djait
