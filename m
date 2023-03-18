Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0C6BFB97
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCRQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:39:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B8F729E;
        Sat, 18 Mar 2023 09:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 463F6B806A1;
        Sat, 18 Mar 2023 16:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF0BC433D2;
        Sat, 18 Mar 2023 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679157583;
        bh=tKPG9dHPLQB/k1SGdONx3xhAxtV67PvL9B18fnSQG8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a42tKpPrwuLbY42ggu74fUTg8DFcY0VjOdmDYag6NB0cBZEyxf5nopMiO8A2zkI1M
         kZIl9oib4vZ/1Umstfc1N8JR+PKJLHyTU07owkl/wovuT1hNK6qKQwdYx/H9DynKF1
         FTYqiRuP4Hi6UrinwNhdVOlRSQ3R5IJ/GQzOKyL++pCn93HaEQu48/oNZl5WyUKzq0
         y+3XOPGoFpmtGzfHDQUoehwKunPLVfS4ed7xkrDb9sDnVooVGzxC/pOawJEMW2BH2b
         WxgY2GrM94vcplY6/TiREaNB4vGNwlbgTW41VJbR7YhltrNG6gv/tJ37o8poRAd6I+
         0ktUf7HvMmpaQ==
Date:   Sat, 18 Mar 2023 16:54:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230318165436.480f1a9a@jic23-huawei>
In-Reply-To: <1b55adf6-32ce-1fd3-78cf-b2011f023eac@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
        <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
        <20230304201720.2d554f07@jic23-huawei>
        <c16d372f-a122-16d6-ad08-1fbffb01d9ff@gmail.com>
        <20230312153655.052d5730@jic23-huawei>
        <1b55adf6-32ce-1fd3-78cf-b2011f023eac@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 11:39:06 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/12/23 17:36, Jonathan Cameron wrote:
> > On Sun, 5 Mar 2023 14:22:51 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 3/4/23 22:17, Jonathan Cameron wrote:  
> >>> On Thu, 2 Mar 2023 12:58:59 +0200
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>>      
> 
> // snip
> 
> >>>> +static const struct iio_chan_spec bu27034_channels[] = {
> >>>> +	{
> >>>> +		.type = IIO_LIGHT,
> >>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >>>> +				      BIT(IIO_CHAN_INFO_SCALE),  
> >>>
> >>> What is this scale for?  
> >>
> >> The scale is to inform users that we return data using milli lux.
> >>  
> >>> Given the channel is computed from various different inputs, is there a
> >>> clear definition of how it is scaled?  What does a write to it mean?  
> >>
> >> Nothing. writing anything else but milli lux scale fails with -EINVAL.
> >>
> >> I guess I am doing something in an unusual way here :) Do you have a
> >> suggestion for me?  
> > 
> > Return data in lux?  
> 
> That's what I did originally have. But then I noticed we can get 
> slightly better accuracy than that. Hence I switched to mLux and added 
> the scale.
> 
> >  Or return it as INFO_RAW - thus making it clear
> > that the reading is not in expected units and a conversion must be
> > applied by userspace.  SCALE is not applied to PROCESSED by userspace.  
> 
> Ah. This makes sense then. Maybe it would be worth adding a warning to 
> IIO-core if drivers set both the SCALE and PROCESSED info bits?

Hmm. I'm not sure that we don't have valid users of it even if they
are unusual.  We also have some historical messes that do RAW + SCALE +
PROCESSED so we can't really have a warning on it.

Warning generally is that the test tools that come with the kernel
will give you the wrong reading. :)

> 
> So, I need to select between the simplicity or better accuracy here? :/ 
> I really hate ending up making choices like this without knowing all the 
> real use-cases :( And it happens a lot for me. Well, I guess I'll drop 
> the scale, use luxes and go with the PROCESSED data. My understanding is 
> that the "thing" with the sensor is a wide-range for wavelengths, not 
> the accuracy. So, maybe luxes are just good enough - and again, users 
> needing something more accurate can utilize the raw intensity channels.

Hmm. For the sysfs case you could use VAL_INT_PLUS_MICRO but that doesn't
then work well with the buffered path.

It is perfectly valid to just have this as _RAW and keep your _SCALE so
that's probably the best option
_RAW doesn't have to mean totally raw, it just means userspace is expected
to applying a linear conversion to get a reading in the 'base' units for the channel.


> 
> > 
> > In the rare case where you do get SCALE and PROCESSED it's there to allow
> > for changes in the underlying signal measurement that are eaten up in the
> > computation needed to get to PROCESSED - that is they have no visible
> > affect (beyond range changes etc).  
> 
> Oh, Ok. So there is a valid case for setting both SCALE and PROCESSED. 
> Then we can't add teh warning I assume :(

They are obscure but IIRC there are some.

Jonathan

> 
> 
> Yours,
> 	-- Matti
> 

