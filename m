Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A39D6A3310
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBZRG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBZRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:06:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA797BDDC;
        Sun, 26 Feb 2023 09:06:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EB98B80BA7;
        Sun, 26 Feb 2023 17:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249BDC433EF;
        Sun, 26 Feb 2023 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677431182;
        bh=XYTVqeqXMse7gxfEZdWHM/uvvBPtdqd7jED9z+UGbVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h53m8mL2vX/1fmmMFCqwl7BeiexVuBNQMtzD2VFCWRzueXHJPfAeKAruJMwYyp/jt
         qL6G6k9shMKI+1+rrYLkgWfQM+rzpdtZmlqs6kGxSazb0OJWPX6sQnmbG035XjbZhl
         mBBJf7Mhy9uVB/0BPvVaeAfB3Ayk5HaKqs9/q4XCtSq9qImDbYzq8RqgzPwNlCMYBe
         hgEO/Serm7Xh/gwF2IYtnrUE9h/WY3VETteqfLxMiw/HDRAWhOOZ6MzlZDD9YEMPP5
         WP0VTsFv9r8g5FZGzQK3U5DN/JJCfoZj4q/X6DVz2uzyHowTu6kzqnqW58prBu5JQH
         w4JgBMimYHSfA==
Date:   Sun, 26 Feb 2023 17:20:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH] iio: Add some kerneldoc for channel types
Message-ID: <20230226172045.524a38e8@jic23-huawei>
In-Reply-To: <af3971e7-0b1c-60dc-64e2-d6f057c25382@fi.rohmeurope.com>
References: <10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com>
        <20230224143638.00003515@Huawei.com>
        <20230224171630.00007d50@Huawei.com>
        <af3971e7-0b1c-60dc-64e2-d6f057c25382@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 07:56:52 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 2/24/23 19:16, Jonathan Cameron wrote:
> > On Fri, 24 Feb 2023 14:36:38 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> >> On Fri, 24 Feb 2023 15:02:32 +0200
> >> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>  
> >>> For occasional contributor like me navigating the IIO channel types and
> >>> modifiers may be a daunting task. One may have hard time finding out
> >>> what type of channel should be used for device data and what units the
> >>> data should be converted.
> >>>
> >>> There is a great documentation for the sysfs interfaces though. What is
> >>> missing is mapping of the channel types and modifiers to the sysfs
> >>> documentation (and entries in documentation).
> >>>
> >>> Give a hand to a driver writer by providing some documentation and by
> >>> pointing to the sysfs document from the kerneldocs of respective enums.
> >>>
> >>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> >> +CC linux-iio
> >>  
> > 
> > A few quick notes. I'll want to read this a lot more carefully.  
> No problem - I am not in a hurry. Besides, I guess it's in the middle of 
> a merge window so I did not really expect this to go anywhere right away :)

Merge windows are quiet for me (touch wood) as I've long since sent pull requests
to Greg KH.  Mind you getting close to end of Qemu cycle and CXL emulation
is keeping me busy these days.

> 
> > I'm not that keen on information in two places but this does have
> > a lot of references.  
> Yep. We talked about this shortly. I understand the problem of keeping 
> information consistent and that is exactly why there is so little 
> documentation here and more just a pointer(s) to the correct place in 
> the sysfs doc. Still, I also see a problem of not having documentation 
> in the enum definitions because this is the place where (in my 
> experience) an average developer expects it to be. Please, let me use 
> myself as an example when I started drafting an IIO driver for a device 
> for first time... The process was roughly as follows:
> 
> 1. I took the device data-sheet and gained some kind of an understanding 
> what it did.
> 2. I searched for existing in-tree drivers for same category devices.
> 3. I did read the other driver's code in order to understand how it used 
> the IIO to push the data to users.
> 4. I started drafting my driver.
> 5. I had plenty of questions about the meaning of the channel info 
> defines - and I did try to look for the enums for documentation.
> 6. As there was no docs in enums, I tried to "guess" suitable enum 
> values by enum names.
> 7. I ran git grep for good enum candidates in the kernel sources
> 8. I tried to find IIO docs from the net
> ...
> 
> I am pretty sure it would have saved me quite a bit of time if I hit 
> some good information at step 5. And I can only assume that I am not an 
> exception here. Quite a lot of the "black magic" in IIO lies upon 
> understanding the values to the iio_chan_spec. And at least for me it 
> was quite intuitive to hit the "ctrl + altGR + ]" when cursor was 
> located on the enum value in an existing driver ;) (Don't everyone do 
> just that?). [Well, just in case not everyone does that - with my editor 
> setup it jumps to the definition of the value under the cursor - which 
> is where this patch suggests adding the docs).

All fair enough - I'm being talked around to adding docs here.

> 
> >>> ---
> >>> Please note that this RFC patch should not be applied as is. The docs
> >>> have TODO comments regarding units for IIO_ELECTRICALCONDUCTIVITY,
> >>> IIO_PHASE and IIO_RESISTANCE. I'll fix these TODOs, remove RFC and respin
> >>> if anyone familiar with the values provided via sysfs could provide me the
> >>> corret units for these channels. I am also open to any suggestions how
> >>> to better link from enum documentation to specific entry at the IIO sysfs
> >>> documetation.
> >>>
> >>> Initial discussion about these docs can be found from:
> >>> https://lore.kernel.org/all/0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com/
> >>> ---
> >>>   include/uapi/linux/iio/types.h | 140 ++++++++++++++++++++++++++++++++-
> >>>   1 file changed, 139 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> >>> index c79f2f046a0b..e6329d3cc055 100644
> >>> --- a/include/uapi/linux/iio/types.h
> >>> +++ b/include/uapi/linux/iio/types.h
> >>> @@ -10,7 +10,129 @@
> >>>   
> >>>   #ifndef _UAPI_IIO_TYPES_H_
> >>>   #define _UAPI_IIO_TYPES_H_
> >>> -
> >>> +/**
> >>> + * iio_chan_type - Type of data transferred via IIO channel.
> >>> + *
> >>> + * The 'main' type of data transferred via channel. Please note that most
> >>> + * devices need to specify also a more accurate 'sub category'. See the
> >>> + * enum iio_modifier for this. (For example, IIO_ACCEL channel often needs to
> >>> + * specify the direction. IIO_CONCENTRATION specifies the type of substance
> >>> + * it measures etc).
> >>> + *
> >>> + * Use of correct units is required but scale and offset that user must apply
> >>> + * to channel values can be advertised.  
> > That's a little vague:.
> > 
> > These reflect the units of the measurement via processed or unit after application
> > of scale and offset.  
> 
> I like the clarity of your sentence. Thanks. However, from the 
> perspective of a developer who has just landed in the IIO-corner of 
> kernel - it may not be obvious there is a scale and offset to be 
> advertised to users. Hence I'd like to add some small hint about what 
> the mentioned scale and offset are - and that the driver can tell user 
> that "the data I give to you - or expect from you - must have this scale 
> and offset".
> 
> How about:
> "These reflect the units of the measurement via processed or unit after 
> application of scale and offset configured/advertised using the 
> IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET". 
Needs more to say where those are set.  "bits in ...."

> Well, to tell my opinion 
> - I think also the iio_chan_info_enum could really be easier to 
> understand if it had few lines of explanations appended ;) Maybe I 
> should add something there as well, and then just use your suggestion 
> with the "see IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET" for scale 
> and offset.

That one is more of a can of worms than this one as some of the definitions
are complex (see the fun around hardwaregain)  I guess some entries can
be 'this one is complex, see the ABI docs'.


> 
> >>> + * Please find the detailed documentation for reported values from the
> >>> + * Documentation/ABI/testing/sysfs-bus-iio.
> >>> + *
> >>> + * IIO_ACCEL:		Acceleration, m/s^2
> >>> + *			Doc keyword: in_accel_x_raw
> >>> + *
> >>> + * IIO_ACTIVITY:	Activity state. For example a pedometer signaling
> >>> + *			jogging, walking or staying still.
> >>> + *			Doc keyword: in_activity_still_thresh_rising_en
> >>> + *
> >>> + * IIO_ALTVOLTAGE:  
> > IIRC Peak to peak voltage.. So same units as voltage.  
> Thanks!
> 
> >>> + *
> >>> + * IIO_ANGL:		Angle of rotation, radians.
> >>> + *			Doc keyword: in_angl_raw
> >>> + *
> >>> + * IIO_ANGL_VEL:	Angular velocity, rad/s
> >>> + *			Doc keyword: in_anglvel_x_raw
> >>> + *
> >>> + * IIO_CAPACITANCE:	Capacitance, nanofarads.
> >>> + *			Doc keyword: in_capacitanceY_raw
> >>> + *
> >>> + * IIO_CCT:  
> > 
> > I had to got look at original patch of this one.  It's correlated color temperature.
> > Base unit Kelvin, though we currently have no users...  
> 
> Hm. I think this should still be added in the sysfs doc. I bet this is 
> used somewhere downstream. And - thanks for the explanation - I will add 
> this in the doc. At least I would not have guessed the meaning just by 
> the member name CCT.

Nor could I.  Git blame to the rescue and some wrangling to deal with a move of
this enum :)

> 
> >>> + *
> >>> + * IIO_CURRENT:		Current, milliamps
> >>> + *			Doc keyword: in_currentY_raw
> >>> + *
> >>> + * IIO_CONCENTRATION:	Reading of a substance, percents. Used for example by
> >>> + *			deviced measuring amount of CO2, O2, ethanol...
> >>> + *			Doc keyword: in_concentration_raw
> >>> + *
> >>> + * IIO_COUNT:		Deprecated, please use counter subsystem.
> >>> + *
> >>> + * IIO_DISTANCE:	Distance in meters. Typically used to report measured
> >>> + *			distance to an object or the distance covered by the
> >>> + *			user
> >>> + *			Doc keyword: in_distance_input
> >>> + *
> >>> + * IIO_ELECTRICALCONDUCTIVITY: electric conductivity, siemens per meter
> >>> + *			Doc keyword: in_electricalconductivity_raw
> >>> + *			TODO: What does "can be processed to siemens per meter"
> >>> + *			mean? Do we have unit requirement?  
> > 
> > Hmm. I'd read that as meaning the unit is seimens per meter - after you've
> > applied offset and scale to the raw value.  
> 
> Ok. Maybe I'll send another patch which changes these "can be processed 
> to..." unit descriptions to same format that is used for other types. I 
> don't think the "can be processed to" is too definitive as pretty much 
> any numbers can be "processed" to represent something when we select 
> suitable fitting algorithm ;)
> 
> Thanks Jonathan. It has been very nice working with you and the IIO :) I 
> think belong to the group of the most open and responsive subsystem 
> maintainers I've been working with!
No problem.  You are are improving things so would be stupid to not help
you with that where time allows!

Jonathan

> 
> Yours,
> 	-- Matti
> 

