Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4946C36FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCUQeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:34:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725DC32520;
        Tue, 21 Mar 2023 09:34:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so62122345edo.2;
        Tue, 21 Mar 2023 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679416458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNGolYpDrXdQ4yw85TNBwydhoA3Qk61HxNkRR+pIP84=;
        b=YJR8N4eQya8afKsJpfIgoPzvkwi62Zcu8UGAUtvod1XEqiXg6gAtvpEGuJ7hweuTyx
         R7tHzH0kj5NyWJmFx6huhVHExcxEM7u+4ha3QNOzvayCZ1snmL4CkY5EP7msaSiaPcGy
         WXi10NWg24LzHg69KqcqOakcTWfENixFfBDgBV7vf6O2T9LKCTTJuruTNiTu95LY60PD
         7vSOftSuV3G6xDmHO5wDge3y3oqT7H9kBiUNJVPjSaMMA5liPBTVg8gHa/O8wwZGo7F/
         AzUTgJhyaF+tqZzFR0J480/Nh+foVd0GM2tv2Y2bx7p4LDg8XrY67u3u10v+8Ib4zG3/
         rO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679416458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNGolYpDrXdQ4yw85TNBwydhoA3Qk61HxNkRR+pIP84=;
        b=FQmA0wWzypNu60y6YpEAc41pCDzY+KAiZseK5DrNgAwPZgiXKNcYSASpc+LNLFhPyo
         iZs8PnrjhGUbSgalQEkWD0xFIAnfj1jG4Duh4bn8LeB5YOahQp/5nFiqtZd/VB6uG4/v
         UMcocNS8YpNWZGD+s09+vlpzn7o36dy4PbECKHzuIAzmd9lQvaGPhexVIBexFgiBzIJf
         QZUyg1mKOeycWNTWsTpHbSqOW2msns2fcobJwHKaPMw3oHa4UnI/fEKXlueTCdchmO9Y
         x4iZS/Sn+8ljJmF1rQvfQQx7Cjp4kadKr6Xzai7v1wRAsWicrrIbk8duxKCYg64ztXFL
         BDjA==
X-Gm-Message-State: AO0yUKWP8xyVGamf0WBOJKh93nbFPVTLiOrQjQF99pRsl02YkAoWVRpa
        6tiin289gAsrmXgbQqUbLP8=
X-Google-Smtp-Source: AK7set83D/mgQ4qoK/5/etmILfDSp8t6HFjpc7DEZSv2/LTC4BFOA5pGFplW5Si7c2xzArvJCGkeQg==
X-Received: by 2002:a17:906:b185:b0:939:90ee:e086 with SMTP id w5-20020a170906b18500b0093990eee086mr3698059ejy.28.1679416458000;
        Tue, 21 Mar 2023 09:34:18 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::a9c0])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm5977632ejc.197.2023.03.21.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:34:17 -0700 (PDT)
Date:   Tue, 21 Mar 2023 17:34:15 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
Message-ID: <ZBnch1tSKyR4fA7H@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <6f31fe7dbd142c01315891f6868ff75f7d7cde32.1679009443.git.mehdi.djait.k@gmail.com>
 <20230319162207.77ef0686@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319162207.77ef0686@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Sun, Mar 19, 2023 at 04:22:07PM +0000, Jonathan Cameron wrote:
> On Fri, 17 Mar 2023 00:48:37 +0100
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Add support for the basic accelerometer features such as getting the
> > acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> > using the WMI IRQ).
> > 
> > Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> 
> Nothing much specific to this patch, most changes will be as a result
> of bringing this inline with the changes suggested for patch 2.
> 
> thanks,
> 
> Jonathan
> >  
> > diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> > index 3bb40e9f5613..7e43bdb37156 100644
> > --- a/drivers/iio/accel/kionix-kx022a.h
> > +++ b/drivers/iio/accel/kionix-kx022a.h
> > @@ -90,8 +90,61 @@
> >  #define KX022A_REG_SELF_TEST	0x60
> >  #define KX022A_MAX_REGISTER	0x60
> >  
> > +
> 
> Push these down into the c file.

Do you mean all REG and MASK defines ? 
Even kx022a defines them in the h file, or am I misunderstanding your
comment ?

> 
> > +#define KX132_REG_WHO		0x13
> > +#define KX132_ID		0x3d
> > +
> > +#define KX132_FIFO_LENGTH	86
> > +
> > +#define KX132_REG_CNTL2		0x1c
> > +#define KX132_REG_CNTL		0x1b
> > +#define KX132_MASK_RES		BIT(6)
> > +#define KX132_GSEL_2		0x0
> > +#define KX132_GSEL_4		BIT(3)
> > +#define KX132_GSEL_8		BIT(4)
> > +#define KX132_GSEL_16		GENMASK(4, 3)
> > +
> > +#define KX132_REG_INS2		0x17
> > +#define KX132_MASK_INS2_WMI	BIT(5)
> > +
> > +#define KX132_REG_XADP_L	0x02
> > +#define KX132_REG_XOUT_L	0x08
> > +#define KX132_REG_YOUT_L	0x0a
> > +#define KX132_REG_ZOUT_L	0x0c
> > +#define KX132_REG_COTR		0x12
> > +#define KX132_REG_TSCP		0x14
> > +#define KX132_REG_INT_REL	0x1a
> > +
> > +#define KX132_REG_ODCNTL	0x21
> > +
> > +#define KX132_REG_BTS_WUF_TH	0x4a
> > +#define KX132_REG_MAN_WAKE	0x4d
> > +
> > +#define KX132_REG_BUF_CNTL1	0x5e
> > +#define KX132_REG_BUF_CNTL2	0x5f
> > +#define KX132_REG_BUF_STATUS_1	0x60
> > +#define KX132_REG_BUF_STATUS_2	0x61
> > +#define KX132_MASK_BUF_SMP_LVL	GENMASK(9, 0)
> > +#define KX132_REG_BUF_CLEAR	0x62
> > +#define KX132_REG_BUF_READ	0x63
> > +#define KX132_ODR_SHIFT		3
> > +#define KX132_FIFO_MAX_WMI_TH	86
> > +
> > +#define KX132_REG_INC1		0x22
> > +#define KX132_REG_INC5		0x26
> > +#define KX132_REG_INC6		0x27
> > +#define KX132_IPOL_LOW		0
> > +#define KX132_IPOL_HIGH		KX_MASK_IPOL
> > +#define KX132_ITYP_PULSE	KX_MASK_ITYP
> > +
> > +#define KX132_REG_INC4		0x25
> > +
> > +#define KX132_REG_SELF_TEST	0x5d
> > +#define KX132_MAX_REGISTER	0x76
> > +
> >  enum kx022a_device_type {
> >  	KX022A,
> > +	KX132,
> As mentioned in previous review, I think this would be neater
> done by just exporting the chip_info structures directly rather than
> putting them in an array.

I gave the reason in a response to the previous review.

--
Kind Regards
Mehdi Djait
