Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCDF60BEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJXXqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJXXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:46:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F02FBDC0;
        Mon, 24 Oct 2022 15:04:10 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mx1390JN2z6H6jV;
        Tue, 25 Oct 2022 00:38:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 18:41:41 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 17:41:40 +0100
Date:   Mon, 24 Oct 2022 17:41:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221024174139.000070c8@huawei.com>
In-Reply-To: <e34d8586-a471-81d6-d09c-f2e0d9884628@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
        <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
        <98b59ad5-8c29-be41-4da1-a961db67827c@gmail.com>
        <Y0QIzf2cAH9ehSeO@smile.fi.intel.com>
        <19a6db0f-40a8-dacf-4583-cdb9d74e1243@fi.rohmeurope.com>
        <b1700ea7-4a7a-263c-595c-0f7a56763c10@gmail.com>
        <20221014144247.00001eb1@huawei.com>
        <e34d8586-a471-81d6-d09c-f2e0d9884628@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 14:10:59 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/14/22 16:42, Jonathan Cameron wrote:
> > On Wed, 12 Oct 2022 10:40:38 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 10/10/22 16:20, Vaittinen, Matti wrote:  
> >>> On 10/10/22 14:58, Andy Shevchenko wrote:  
> >>>> On Mon, Oct 10, 2022 at 12:12:34PM +0300, Matti Vaittinen wrote:
> >>>> ...
> >>>>     
> >>>>>>> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
> >>>>>>> +			       sizeof(s16));  
> >>>>     
> >>>>>> No endianess awareness (sizeof __le16 / __be16)  
> >>>>     
> >>>>>>> +	if (ret)
> >>>>>>> +		return ret;
> >>>>>>> +
> >>>>>>> +	*val = data->buffer[0];  
> >>>>>>
> >>>>>> Ditto (get_unaligned_be16/le16 / le16/be16_to_cpup()).  
> >>>>>
> >>>>> I have probably misunderstood something but I don't see why we should use
> >>>>> 'endianess awareness' in drivers? I thought the IIO framework code takes
> >>>>> care of the endianes conversions based on scan_type so each individual
> >>>>> driver does not need to do that. That however has been just my assumption. I
> >>>>> will need to check this. Thanks for pointing it out.  
> >>>>
> >>>> The IIO core uses endianness field only once in iio_show_fixed_type() AFAICS.  
> >>
> >> Following is some hand waving and speculation after my quick code read.
> >> So, I may be utterly wrong in which case please do correct me...
> >>
> >> Anyways, it seems to me that you're correct. The endianness field is
> >> only used by the IIO to build the channel information for user-space so
> >> that applications reading data can parse it. As far as I understand, the
> >> driver does not need to do the conversions for user-space, but the
> >> user-space tools should inspect the type information and do the
> >> conversion. I think it makes sense as user-space applications may be
> >> better equipped to do some maths. It also may be some applications do
> >> not want to spend cycles doing the conversion but the conversions can be
> >> done later "offline" for the captured raw data. So omitting conversion
> >> in the IIO driver kind of makes sense to me.  
> > 
> > That was indeed the original reasonining for buffered data path
> > (note the endian marker is for scans only which only apply in buffered
> >   / chardev case).  
> 
> So, in a case where we "push_to_buffers" the data, we can leave the data 
> to use the endianess we advertise via endianess info field?

Exactly.

> 
> > It's less obvious for the sysfs path as that's inherently slow.
> > We could have made this a problem for the IIO core, but we didn't :)  
> 
> But again, as far as I understood, the user-space is still expected to 
> read the sysfs field for "scan_elements/in_accel_<channel>_type"? I 
> guess it would be confusing to say "le:s16/16>>0" there while returning 
> CPU native endianess values from sysfs files?

Agreed that it is probably less than ideal but that's what the interface
is.  scan_elements refers to the "scan elements"  channels read via sysfs
files are not scan elements - scan's are only relevant to buffered readback.

> 
> >> I haven't thoroughly looked (and I have never used) the in-kernel IIO
> >> APIs for getting the data. A quick look at the
> >> include/linux/iio/consumer.h allows me to assume the iio_chan_spec can
> >> be obtained by the consumer drivers. This should make the endianess
> >> information available for the consumer drivers as well. So, again,
> >> consumer drivers can parse the raw-format data themself.  
> > 
> > yes consumers should be be endian aware if they are using the
> > callback buffer route to get the data.  Now you mention it, we
> > may well have cases where that isn't handled correctly.
> > There are few enough users of that interface that it might well work
> > by coincidence rather than design. oops.
> >   
> >>
> >> I have this far only used the sysfs and iio_generic_buffer on a
> >> little-endian machine so I have had no issues with the little-endian
> >> data and I have only observed the code. Hence I can not really say if my
> >> reasoning is correct - or if it is how IIO has been designed to operate.
> >> But based on my quick study I don't see a need for the IIO driver to do
> >> endianess conversion to any other format but what is indicated by
> >> scan_type. Specifically for KX022A, the data is already 16B LE when read
> >> from the sensor. This is also advertised by scan_type so no conversion
> >> should be needed (unless, of course, I am mistaken :]).  
> > 
> > Ah. I'd missed that. Data storage should reflect the read back endianness
> > and for the read_raw path you need to perform the conversion in driver
> > (but not the high perf push to buffers path).  
> 
> Oh, really? I think it might be confusing to say "le:s16/16>>0" in 
> "scan_elements/in_accel_<channel>_type" but return something else from 
> the in_accel_<channel>_raw. Especially the "raw" word at the end of the 
> file signals the data is in non converted raw format.
> 
> I take your word for that if you say this is what the user-space 
> expects, it just is not what I did expect. Well, I do very little work 
> on the user-space these days ;) Still just to be on safe side - do you 
> mean I should convert the data returned from read_raw to the CPU endianess?

yes.

> 
> > Sure we could probably have handled read_raw in tree as well but we didn't
> > and probably too late to sensibly fix that now.  One of many things we'd
> > probably do differently if we were starting again.  
> 
> Well, this is pretty usual story :) Predicting the future is hard. My 
> crystal ball ran out of batteries a long ago ;)

:)

> 
> Best Regards
> 	-- Matti
> 

