Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0856EDC67
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjDYH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDYH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:26:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCD5A248;
        Tue, 25 Apr 2023 00:26:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f6c285d22so995584266b.2;
        Tue, 25 Apr 2023 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682407567; x=1684999567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=806d9FPWgJ42FvCJCjXsJ9og4tTK/F5jy60vffTHE50=;
        b=YPXY18efMtXTGHEmLAlA5TWCxZX9Tcd4Df3Os3CAm8g4kXEeCtZZ25czqUaA0lMNje
         aTVn7x23I3VVkdtKT53SI5JtpK29yIAFu6Tvfy5VqXHUsShuCmAhNmXGfgKiWp4mD9T1
         HytpgV+p+v/tcs+Y6LVk+UHDV5Cb4wjmKPZ/LPNBF4hsAiowfbUsKObxpI4o4wr8Mwmp
         RWaUyo9biqxg/dKW8gcKVdzrxclUIXNO2qrHPbPL5aJedIPb8xj9X5UdThz2Ek/rdmvd
         S5g/IWaXnCEu+wpsLBNgC19uewxP/KiqjxEvY4dvVRTrixrqcAIIphCuffdmGHaCuT+n
         vaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682407567; x=1684999567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=806d9FPWgJ42FvCJCjXsJ9og4tTK/F5jy60vffTHE50=;
        b=H9AFeRvjvMhLnW7qnvKluVA6dizqk/mSlVTBeFJcxcsPs38fAZQArtCGlvcA53Bh+f
         SX+gkhNuXw2jblsE+ZOfq2K/yMuSsParW3hDRhnLd2rmX5jcJ+hY+4mYWvDIE/ladA4b
         J5jfSglw6X0GokCTAesulWWeDTXvpqvVJxK4Bm0K8MsjDdMt8uFK8TQ+kb4CZuST3m/e
         cyJszuA/gW/jUlS9Osxo1zYGJb8rbjUoT3H2Jf4SFwY+WdfU3803mYDkiEwn27LTEEKT
         NF3xg6Fsij6xPhPYDBXJpZwMAg5eOcnnG5LFRAAG0RfvSEpNwmuwwPAzDcwAHn/wf3MU
         59+Q==
X-Gm-Message-State: AAQBX9diYycbKMI6bVM95rZoV50NWR6K6EQhJ5yBZ9pKXVGvbU1l3iTW
        NJ9RQfI6bj0rlv+/scv5BWA=
X-Google-Smtp-Source: AKy350Y20kuL0GxyFhVnQHCN2gciyVOQgy9ggvM1r7EFwObJTA9NEMael8fAoA9NVJFXgU0Y4MZ+Lg==
X-Received: by 2002:a17:906:5a68:b0:94e:ea07:4b87 with SMTP id my40-20020a1709065a6800b0094eea074b87mr12185936ejc.27.1682407566575;
        Tue, 25 Apr 2023 00:26:06 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::2d16])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906074b00b0094f3c281b34sm6319627ejb.196.2023.04.25.00.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 00:26:06 -0700 (PDT)
Date:   Tue, 25 Apr 2023 09:26:03 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZEeAi/wSpmZXpzg6@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <fc12d40f7c2132c1a9a1b5f83b79231dc8ce539f.1682373451.git.mehdi.djait.k@gmail.com>
 <b0f894fa-a216-aead-a5a4-1844292acad9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f894fa-a216-aead-a5a4-1844292acad9@gmail.com>
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

On Tue, Apr 25, 2023 at 10:07:54AM +0300, Matti Vaittinen wrote:
> On 4/25/23 01:22, Mehdi Djait wrote:
> > Since Kionix accelerometers use various numbers of bits to report data, a
> > device-specific function is required.
> > Implement the function as a callback in the device-specific chip_info structure
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> > v3:
> > - fixed the warning of the kernel test robot in kx132_get_fifo_bytes
> 
> Do you mean kx022a_get_fifo_bytes? (I guess this won't go to commit logs so
> no need to respin for this).
> 
> > 	(invalid assignment: &=, left side has type restricted __le16
> > 	right side has type unsigned short)
> > 
> > v2:
> > - mentioned the kx132-1211 in the Kconfig
> > - added a kx132-specific get_fifo_bytes function
> > - changed the device name from "kx132" to "kx132-1211
> > 
> >   drivers/iio/accel/kionix-kx022a.c | 30 ++++++++++++++++++++----------
> >   drivers/iio/accel/kionix-kx022a.h |  4 ++++
> >   2 files changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index 66da3c8c3fd0..4a31d17c1f22 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -595,11 +595,28 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> >   	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
> >   }
> > +static int kx022a_get_fifo_bytes(struct kx022a_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	int ret, fifo_bytes;
> > +
> > +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> > +	if (ret) {
> > +		dev_err(dev, "Error reading buffer status\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Let's not overflow if we for some reason get bogus value from i2c */
> 
> This comment would need fixing. I guess this is my bad - this comment goes
> back to first internal draft datasheets where the fifo lenght was said to be
> shorter than 255 bytes...
> 
> > +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> > +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> 
> ...Currently the fifo size (KX022A_FIFO_MAX_BYTES) is 258 bytes and
> KX022A_FIFO_FULL_VALUE is 255 (8-bit register) - meaning that no matter what
> noise there is in the I2C line, we won't overflow the buffer. This check is
> here to handle the 'quirk' where full 258 bytes of FIFO data is advertised
> by register max value (255).
> 
> It wouldn't be fair to require fixing this in context of this change - but I
> guess I can ask you to please update the comment if you happen to re-work
> this file ;)

I will take care of the comment if there is a v4

--
Kind Regards
Mehdi Djait
