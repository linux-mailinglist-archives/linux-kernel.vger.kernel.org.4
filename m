Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552D4695EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjBNJY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjBNJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:24:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C3234C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:24:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m2so16431613plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WyGz4drYxBOqHu4SSNz+B7tGEGQwEMtEjzc4Jc2DXs=;
        b=KA8KCwF1f0mqz+2rs2pn9wU+FxvXyC0saLeDc1sM0rzXa99gl0I15eeDVL+33Z6el+
         JaUywitl7XKOCJXBU+BcuGYA5us/U7o5hnpwKaRmb97IcAaFtLqchmF39SjMC2L4fqnt
         s42isJyn/O1VdKMf2dfHHjSloJnCVG7yBTgiW/jMCQELG0UE49wp32mpD2w4X3Osy4My
         xH4NNpLMbH9ELJzYxLu5pmxBBB8ccAYfHe3yGMBWsjHIK9DrJ9ZSTlhIKY9DzPzHIyjx
         //iOMooOxucdmO/Rm8D002HuWtA4KtPPDK/Pkr+d/HXfCO3IJCfTJrpvblHvbyGOLggL
         x8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WyGz4drYxBOqHu4SSNz+B7tGEGQwEMtEjzc4Jc2DXs=;
        b=7DYxm/fFkhgx/sSzgmEFd0cIiHEzzP7v4xAH/DvVobb1gzLa+gIsBAWLrniImbqHpJ
         LwZr07thQNTrXKlC8/w9u71SNYjR4/qwhvO1TnzmfHNGzEX1z6eoX1KJAX2GcRxThQNM
         o8KThzW0PjkZR2mo5Y9t6dTBGBYrYki3w3zaC/UjXY0PJ+qn3MQN1V9Keg3C9g2nD4dq
         4P9G3hx3AvJIhSEUsp0DPpV7FENqFI5FXWERM643klv7kxwfziYhrLAedFkm2shTTzNB
         UMpVNqqO27qnj3GnFk1FcJ+hEPlxTgKl1pyMCYkD422u6JZdjsdfggqt+4LxJ2vf9KO9
         fe+g==
X-Gm-Message-State: AO0yUKXmXHgtCWbtQj96qEqwsbQNimCFYI74pZrmqFsyr/GTFaJ2LAPl
        Dj6uZ788PLlwuQ6ZrnVTc8E=
X-Google-Smtp-Source: AK7set/ZshPAyv0gb3KzILqQ3tYbPhugCGNHOVcmKx8/Z7QmRaIUQKp9vbnsXE4pKHARKjs3jev4BA==
X-Received: by 2002:a17:902:e1d2:b0:198:f1c4:dd59 with SMTP id t18-20020a170902e1d200b00198f1c4dd59mr1347848pla.14.1676366682315;
        Tue, 14 Feb 2023 01:24:42 -0800 (PST)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id iy1-20020a170903130100b0019a9436d2a0sm4764401plb.89.2023.02.14.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:24:41 -0800 (PST)
Date:   Tue, 14 Feb 2023 20:24:36 +1100
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        error27@gmail.com
Subject: Re: [PATCH] staging: pi433: change (struct pi433_tx_cfg)->bit_rate
 to be a u32
Message-ID: <Y+tTVKWqiIZnySUz@jacob-Ubuntu>
References: <Y+srSuTdGmzmXG1I@jacob-Ubuntu>
 <Y+s/HP+v7lx2SKRj@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+s/HP+v7lx2SKRj@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:28:20PM +0530, Deepak R Varma wrote:
> On Tue, Feb 14, 2023 at 05:33:46PM +1100, Jacob Bai wrote:
> > Based on the TODO file and datasheet of pi433, the maximum bit rate for
> > transmitter is 300kbps when modulation been set to FSK. Hence, the size
> > should be u32 rather than u16.
> 
> Hi Jacob,
> This change was already discussed recently. Please check the following link and
> all the responses to this thread:
> 
> https://lore.kernel.org/all/Y9h42l%2F8EcPqn63x@combine-ThinkPad-S1-Yoga/
> 
> Thanks,
> ./drv
Thanks Deepak and Dan!

Regards,
Jacob
> 
> > 
> > Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
> > ---
> >  drivers/staging/pi433/Documentation/pi433.txt | 3 ++-
> >  drivers/staging/pi433/pi433_if.h              | 2 +-
> >  drivers/staging/pi433/rf69.c                  | 4 ++--
> >  drivers/staging/pi433/rf69.h                  | 2 +-
> >  4 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
> > index 4a0d34b4ad37..b34d8e9f6d53 100644
> > --- a/drivers/staging/pi433/Documentation/pi433.txt
> > +++ b/drivers/staging/pi433/Documentation/pi433.txt
> > @@ -78,7 +78,8 @@ rf params:
> >  		Allowed values: 433050000...434790000
> >  	bit_rate
> >  		bit rate used for transmission.
> > -		Allowed values: #####
> > +		Allowed values when FSK: 1200...300000
> > +		Allowed values when OOK: 1200...32768
> >  	dev_frequency
> >  		frequency deviation in case of FSK.
> >  		Allowed values: 600...500000
> > diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> > index 25ee0b77a32c..1f8ffaf02d99 100644
> > --- a/drivers/staging/pi433/pi433_if.h
> > +++ b/drivers/staging/pi433/pi433_if.h
> > @@ -51,7 +51,7 @@ enum option_on_off {
> >  #define PI433_TX_CFG_IOCTL_NR	0
> >  struct pi433_tx_cfg {
> >  	__u32			frequency;
> > -	__u16			bit_rate;
> > +	__u32			bit_rate;
> >  	__u32			dev_frequency;
> >  	enum modulation		modulation;
> >  	enum mod_shaping	mod_shaping;
> > diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> > index 8c7fab6a46bb..0b90ca004dd6 100644
> > --- a/drivers/staging/pi433/rf69.c
> > +++ b/drivers/staging/pi433/rf69.c
> > @@ -185,7 +185,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
> >  	}
> >  }
> >  
> > -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
> > +int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate)
> >  {
> >  	int retval;
> >  	u32 bit_rate_reg;
> > @@ -201,7 +201,7 @@ int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
> >  	}
> >  
> >  	// check input value
> > -	if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
> > +	if (bit_rate < 1200 || bit_rate > 300000 || (mod == OOK && bit_rate > 32768)) {
> >  		dev_dbg(&spi->dev, "setBitRate: illegal input param\n");
> >  		return -EINVAL;
> >  	}
> > diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
> > index 78fa0b8bab8b..46a1fb2d5329 100644
> > --- a/drivers/staging/pi433/rf69.h
> > +++ b/drivers/staging/pi433/rf69.h
> > @@ -24,7 +24,7 @@ int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
> >  int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
> >  int rf69_set_modulation_shaping(struct spi_device *spi,
> >  				enum mod_shaping mod_shaping);
> > -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
> > +int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate);
> >  int rf69_set_deviation(struct spi_device *spi, u32 deviation);
> >  int rf69_set_frequency(struct spi_device *spi, u32 frequency);
> >  int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
> > -- 
> > 2.34.1
> > 
> > 
> 
> 
