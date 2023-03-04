Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887B6AAC0F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCDTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:11:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B181B2E8;
        Sat,  4 Mar 2023 11:11:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68A1260A47;
        Sat,  4 Mar 2023 19:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BA3C433EF;
        Sat,  4 Mar 2023 19:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677957076;
        bh=hamBxdkhaTrNN4oQ37l4wrMJvvdKhOrqu9RvysH+w+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o1OA2Yv/9WZvV9FaWSHtwsDvJkCjXUjJjdwzKnsFdnJXbbnvHka1cbLCj2cWWw9DW
         /3yiCf0ermbFTrauNU5d0qoW8l2S2yRxU9uoo/Yyw4S10pOc0xLxMkAqIArLQFPZgv
         BHcFK/6i21FgoBNRX/nO17eCT6QwKuzEU4JJoGIEBUHlnEe3oCEIBnM0Uk7ikc0q/i
         Zmml9pdATJp8DY95WwQJw1CaEVRdHWFZTpNTS8U7OIhsADbvK5jlzDo9phP3J81acV
         NsgR5nQJWogoWgSiZ49/M/ANCH4nYi6l9DNgt3Jfaxcsv5xVllT2Vvy/mVcXtsdoRM
         JjzB5KY1i48dw==
Date:   Sat, 4 Mar 2023 19:11:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230304191111.60791366@jic23-huawei>
In-Reply-To: <103531fc-e7c1-090f-a172-073a399f6380@fi.rohmeurope.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
        <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
        <20230226171329.4ff6ac8b@jic23-huawei>
        <103531fc-e7c1-090f-a172-073a399f6380@fi.rohmeurope.com>
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



> >   
> >> + * need to modify the calculation but I hope this gives a starting point for
> >> + * those working with such devices.  
> > 
> > That will need some dt bindings - though for now I guess we have no idea
> > what they would be unless there are some hints on the datasheet?
> >   
> 
> Yes. That is the problem. And even though we would hope we get the 
> complete bindings from day 1 - I don't see it really a problem to add 
> things like the 'lens-whateveritwillbe' when needed. What should be 
> ensured then is the "property not found" case will default to the open-air.

We have had app notes in the past that suggest particular useful factors
for common filters or indeed the correction factor format that should be used
if the device has some non volatile memory to store it in.  If neither
is true here, it's going to be 'interesting' to support.

> 
> The one thing we could add is sysfs attribute stating the 'open-air' for 
> those who use the raw-values as they will be impacted by lens and won't 
> be compensated by the driver like preprocessed values should be. Not 
> sure if we want to do it yet though as I don't know if there will be any 
> use for it in upstream.

Leave it for now.

> 
> >> + *
> >> + * The first case (D1/D0 < 0.87) can be computed to a form:
> >> + * lx = 0.004521097 * D1 - 0.002663996 * D0 + 0.00012213 * D1 * D1 / D0
> >> + */
> >> +static int bu27034_get_lux(struct bu27034_data *data, int *val)
> >> +{
> >> +	unsigned int gain0, gain1, meastime;
> >> +	unsigned int d1_d0_ratio_scaled;
> >> +	u16 res[3], ch0, ch1;
> >> +	u64 helper64;
> >> +	int ret;
> >> +
> >> +	mutex_lock(&data->mutex);
> >> +	ret = bu27034_get_result_unlocked(data, &res[0]);  
> > 
> > res
> > as it is expecting a point to an array so that is more natural than pointing
> > to the first element even if that's the same result.  
> 
> This is pretty much the only thing I disagree with you :) For me it has 
> always been much clearer to use pointer to first element - as the type 
> of first element is what we are using. Type of an array (in my head) is 
> something less well defined. I think this difference is best visible 
> with the sizeof(arr) Vs. sizeof(&arr[0]).
> 
> I think I didn't change this for v2. I in any case expect to see v3 and 
> probably a few others as well - so I will change this to some of the 
> later versions if I didn't get you convinced that the &res[0] is Ok.

I don't care that strongly. Though to me res is no less clear than
&res[0] when we are intending to access the whole array.

If we had a series of individual element accesses or other partial
writes of the array in the functions then I'd agree with you.

> 
> >   
> >> +	if (ret)
> >> +		goto unlock_out;
> >> +
> >> +	/* Avoid div by zero */
> >> +	if (!res[0])  
> > 
> > res[0] = max(1, res[0]); perhaps?  
> 
> This would have been better, yes. However, I did change the data 
> collection quite a bit for v2 - and there these values may not be in 
> native byte order - so check for !res[0] feels more correct for v2 than 
> comparing to value when the value format is not "correct".

Ok. Maybe... I'll take a look.

> 
> >> +	case IIO_CHAN_INFO_RAW:
> >> +	{
> >> +		u16 res[3];
> >> +
> >> +		if (chan->type != IIO_INTENSITY)
> >> +			return -EINVAL;
> >> +
> >> +		if (chan->channel < BU27034_CHAN_DATA0 ||
> >> +		    chan->channel > BU27034_CHAN_DATA2)
> >> +			return -EINVAL;
> >> +		/*
> >> +		 * Reading one channel at a time is inefficient.
> >> +		 *
> >> +		 * Hence we run the measurement on the background and always
> >> +		 * read all the channels. There are following caveats:
> >> +		 * 1) The VALID bit handling is racy. Valid bit clearing is not
> >> +		 * tied to reading the data in the hardware. We clear the
> >> +		 * valid-bit manually _after_ we have read the data - but this
> >> +		 * means there is a small time-window where new result may
> >> +		 * arrive between read and clear. This means we can miss a
> >> +		 * sample. For normal use this should not be fatal because
> >> +		 * usually the light is changing slowly. There might be
> >> +		 * use-cases for measuring more rapidly changing light but this
> >> +		 * driver is unsuitable for those cases anyways. (Smallest
> >> +		 * measurement time we support is 55 mS.)  
> > 
> > Given there is no general fix for that, not much you can do even if you don't want to
> > miss the data.
> >   
> >> +		 * 2) Data readings more frequent than the meas_time will return
> >> +		 * the same cached values. This should not be a problem for the
> >> +		 * very same reason 1) is not a problem.  
> > 
> > Hmm. I'm never that keen on drivers doing that if we can avoid it but perhaps we
> > can't here.  
> 
> Well, I dropped the caching of values for read_raw. I think it got rid 
> of these particular problems. The issue 1) is still there for buffered 
> mode but I guess we just need to live with it. On the bright side, 
> missing a sample once in a blue moon is not fatal for most of the 
> use-cases I can think of right now. (Besides, there is no general fix as 
> you said so worrying about the unknown use-cases right now does not feel 
> like the sanest thing. I have enough of worrying with the things that 
> really are a problem...)
> 
> >> +	/*
> >> +	 * Delay to allow IC to initialize. We don't care if we delay
> >> +	 * for more than 1 ms so msleep() is Ok. We just don't want to
> >> +	 * block  
> > 
> > The msleep bit is kind of obvious for a reset. I'd not bother documenting that
> > detail.  
> 
> Well, the documentation is to suppress review comments regarding 1mS 
> msleep :) And, I can't blame reviewers as the checkpatch is picking this 
> up too. Hence I think it's Ok to tell that: "Yes, I know the sleep is 
> likely to last longer than the requested 1 mS but it does not matter for 
> our use-case so we still consciously chose to use msleep()."
I understand how you ended up with it, but meh, reviewers have seen those
warnings lots of times already!
:)  
..


> > Fallback compatibles require that on a failure to match ID we still let the driver
> > carry on.  However we can print something in the log to say we don't recognise
> > the device.  The intent is that at future part can be supported by old kernels just
> > be having the dt list multiple compatibles if the device really are backwards
> > compatible with parts already supported.  
> 
> Makes sense. Besides, we should be able to trust the dt has correct 
> compatibles - I'm not sure we should do these runtime checks for part 
> IDs at all. I dropped the error - return and changed the print to warn.

Experience says the checks are useful.  Lots of boards have turned up with the
wrong part, so warning at least is a nice to have!

We had to argue a bit with the DT maintainers to get them to let us have
the warnings ;)

Jonathan
