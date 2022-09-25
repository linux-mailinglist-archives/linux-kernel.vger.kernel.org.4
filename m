Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881C5E935E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIYN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIYN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:29:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CAF2F387;
        Sun, 25 Sep 2022 06:29:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso2328586wms.5;
        Sun, 25 Sep 2022 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8pn/3WABW440xIW3J5samwhDbSxHGwEHvAno8GY94Ac=;
        b=R/FRmbBkf/OFzFa4BsLKAj2wDP23xO7GO2F2qYcahxLr0OMv7J8L+cDjTHID5jm1zF
         6rZlSCOvWppV/KK4A84FzkQPnYQvyapNoHhbAIcQx2LbxM6HDY9OtofpavQ9op0+MRXM
         mDyvXAvPnROognGO1V+k2YlChJGqA3jOAOZ+dSAIdhsWl17NTsRUuuSzNtusVYctF1df
         GZcU7bkoJarFGwC3JXlmB52mLO3I9NzMbKdAd/YiD3QzATDjkbnFYKmgULDAWhyX6Dig
         LrivGKio4oyXBrAgXNLj0P+kbphqOg0hHPPDz9UDLALntxN61ag4Q1B9viAtSGFNqwo+
         LM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8pn/3WABW440xIW3J5samwhDbSxHGwEHvAno8GY94Ac=;
        b=bAmMLjcaXtvnLJW5kj002uDf5Qr2OU1XTcVUbEu47AKS2xn5XshozOxWBzDVhntyWm
         aLr4ibS1/LA4bcgQ1/mVipP7/AAfJ8koy5x3NK3QYihT82Bmyt7V2emcFMKOGaUC9fkc
         uoXZzGNbYXkY0CJrsIM1x8eebbCnrJAxm+zFrJqIvozvefNB1hSBo1HhXZUjHgqnYPjC
         dgg7BtcVnEOIj3M84WHBHFt2nN9cj91Rf13W/2fBZckfDn/+6T9tLpdPSXZc34fnZq/4
         u90inNtofHkoF+Ao77In6TWXqwEchtd5tkkR/JrELKUQocHxgPJvFy61O/2z9IWNg9Z3
         /ZUA==
X-Gm-Message-State: ACrzQf2vfKbNijPGw9zr0Is40p4ZwFexn1AhjhjJn4Owrn8Kl/n0SlR9
        mRQUjg/bVdmTzpnDf/6OPpkNUqJyCJnZy0B7RQE=
X-Google-Smtp-Source: AMsMyM5wjXe6JyPHg2tOdjHBpDgd03x0ajYKMks1Y0YAxoMYbXzxdnT8WuOHyy4N+ICZr3OINiifWiBPQSNBw/boJoo=
X-Received: by 2002:a05:600c:4f53:b0:3b4:9aad:7845 with SMTP id
 m19-20020a05600c4f5300b003b49aad7845mr12004490wmq.159.1664112538630; Sun, 25
 Sep 2022 06:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-15-alexandru.ardelean@analog.com> <aecd6a19-79a8-d9a6-2dc4-73dcd756c92d@fi.rohmeurope.com>
 <87fbfc8e-fb17-444d-22a2-3738ade77cb5@fi.rohmeurope.com> <20220919163214.5b757903@jic23-huawei>
 <20220919181854.01214355@jic23-huawei> <ae28aca3-6834-653c-9d66-1c98b67c7d4d@fi.rohmeurope.com>
 <20220924144946.31898762@jic23-huawei>
In-Reply-To: <20220924144946.31898762@jic23-huawei>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 25 Sep 2022 16:28:47 +0300
Message-ID: <CA+U=Dsq4AL3TeALK=R_xRJ1woDAwLhbnwwTiOMbpWyAozzUebg@mail.gmail.com>
Subject: Re: [RFT] potential bug with IIO_CONST_ATTR usage with triggered buffers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 4:49 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 19 Sep 2022 18:06:37 +0000
> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> > On 9/19/22 20:18, Jonathan Cameron wrote:
> > > On Mon, 19 Sep 2022 16:32:14 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > >> On Mon, 19 Sep 2022 08:52:38 +0000
> > >> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> > >>
> > >>> On 9/9/22 11:12, Vaittinen, Matti wrote:
> > >>>> Hi dee Ho peeps!
> > >>>>
> > >>>> Disclaimer - I have no HW to test this using real in-tree drivers. If
> > >>>> someone has a device with a variant of bmc150 or adxl372 or  - it'd be
> > >>>> nice to see if reading hwfifo_watermark_max or hwfifo_watermark_min
> > >>>> works with the v6.0-rc4. Maybe I am misreading code and have my own
> > >>>> issues - in which case I apologize already now and go to the corner
> > >>>> while being deeply ashamed :)
> > >>>
> > >>> I would like to add at least the at91-sama5d2_adc (conditonally
> > >>> registers the IIO_CONST_ATTR for triggered-buffer) to the list of
> > >>> devices that could be potentially tested. I hope some of these devices
> > >>> had a user who could either make us worried and verify my assumption -
> > >>> or make me ashamed but rest of us relieved :) Eg - I second my request
> > >>> for testing this - and add potential owners of at91-sama5d2_adc to the list.
> > >>>
> > >>>> On 2/15/21 12:40, Alexandru Ardelean wrote:
> > >>>>> This change wraps all buffer attributes into iio_dev_attr objects, and
> > >>>>> assigns a reference to the IIO buffer they belong to.
> > >>>>>
> > >>>>> With the addition of multiple IIO buffers per one IIO device, we need a way
> > >>>>> to know which IIO buffer is being enabled/disabled/controlled.
> > >>>>>
> > >>>>> We know that all buffer attributes are device_attributes.
> > >>>>
> > >>>> I think this assumption is slightly unsafe. I see few drivers adding
> > >>>> IIO_CONST_ATTRs in attribute groups. For example the bmc150 and adxl372
> > >>>> add the hwfifo_watermark_min and hwfifo_watermark_max.


Took me a while to get to this and read in-depth.
Yep.
Apologies.
I omitted the IIO_CONST_ATTRs when I did that change.

> > >>>>
> > >>>
> > >>> and at91-sama5d2_adc
> > >>>
> > >>> //snip
> > >>>
> > >>>> I noticed that using
> > >>>> IIO_CONST_ATTRs for triggered buffers seem to cause access to somewhere
> > >>>> it shouldn't... Oops.
> > >>>>
> > >>>> Reading the code allows me to assume the problem is wrapping the
> > >>>> attributes to IIO_DEV_ATTRs.
> > >>>>
> > >>>> static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
> > >>>> +                                              struct attribute *attr)
> > >>>> +{
> > >>>> +        struct device_attribute *dattr = to_dev_attr(attr);
> > >>>> +        struct iio_dev_attr *iio_attr;
> > >>>> +
> > >>>> +        iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> > >>>> +        if (!iio_attr)
> > >>>> +                return NULL;
> > >>>> +
> > >>>> +        iio_attr->buffer = buffer;
> > >>>> +        memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
> > >>>>
> > >>>> This copy does assume all attributes are device_attrs, and does not take
> > >>>> into account that IIO_CONST_ATTRS have the string stored in a struct
> > >>>> iio_const_attr which is containing the dev_attr. Eg, copying in the
> > >>>> iio_buffer_wrap_attr() does not copy the string - and later invoking the
> > >>>> 'show' callback goes reading something else than the mentioned string
> > >>>> because the pointer is not copied.
> > >>>
> > >>> Yours,
> > >>>   -- Matti
> > >> Hi Matti,
> > >>
> > >> +CC Alexandru on a current email address.
> > >>
> > >> I saw this whilst travelling and completely forgot about when
> > >> I was back to normal - so great you sent a follow up!
> >
> > I was also participating at ELCE last week so didn't do much of emails/code.
> >
> > >>
> > >> Anyhow, your reasoning seems correct and it would be easy enough
> > >> to add such a case to iio/dummy/iio_simple_dummy_buffer.c and
> > >> provide a clear test for the problem.
> > >>
> > >> As to solutions. The quickest is probably to switch these const attrs
> > >> over to a non const form and add a comment to the header to say they are
> > >> unsuitable for use with buffers.
> > >
> > > Thinking a little more on this - all / (most?) of the users pass a null terminated
> > > array of struct device_attribute * to *iio_triggered_buffer_setup_ext()
> > >
> > > That's then assigned to buffer->attrs.
> > > We could add an additional pointer to the struct iio_buffer to take
> > > a null terminated array of struct iio_dev_attr *
> > > and change the signature of that function to take one of those, thus
> > > preventing us using iio_const_attr structures for this.
> >
> > Yes. I would also rather see pointer to array of struct iio_dev_attr *
> > if we continue keeping the assumption that attrs are of type iio_dev_attr.
> >
> > >
> > > Then we can wrap those just fine in the code you highlighted and assign the
> > > result into buffer->attrs.
> > >
> > > We'd need to precede that change with fixes that just switch the
> > > iio_const_attr uses over to iio_dev_attr but changing this would ensure no
> > > accidental reintroductions of the problem in future drivers (typically
> > > as a result of someone forward porting a driver that is out of tree).
> >
> > Again I do agree. Besides change of const_attrs is necessary in any case
> > if we don't change the wrapping.
> >
> > >>
> > >> Would you like to send patches given you identified the problem?
> >
> > I am in any case about to send couple of patches to IIO. The devm-helper
> > usage (v2 - I sent v1 from my other email address (mazziesaccount) - but
> > I am the same person :] ) and a new accelerometer driver. So, I can look
> > also at this change while I am at it if you're busy).
> >
> > >> If not I'm happy to fix these up. My grepping identified the same 3 cases
> > >> you found.
> >
> > Feel free to patch this if you wish. Just please let me know if you take
> > care of this so we don't do double the work :)
>
> I'm never one to turn down a volunteer, so I'll leave these for you :)
>
> Plenty of other things on the todo list that I can be getting on with.
>
> Jonathan
>
> >
> > Yours
> >       -- Matti
> >
> >
>
