Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2B6BFB9D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCRQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2211F5C0;
        Sat, 18 Mar 2023 09:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6422560EC4;
        Sat, 18 Mar 2023 16:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FFEC433D2;
        Sat, 18 Mar 2023 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679157785;
        bh=b5iF3AIgZpd6SyIonjB7oJ1JXvXNXjX0WP22YTlZhwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UTjHQ5sz0Wbys+UpEp2yaJD5UAYFvGf6GtEltffVVStYbnTG3lLH10Q1UQ2O6dVk2
         pvM9D7ggqHeMEL6RH1VkEDvfLTDFDFiKMGhpjPo/Evf0X3h9xuQEwKA11qYe14WKrH
         5L9vdZIKJY/HwPkfhDRIoT5dBGCHnZWtYSVU5NaOX0NcuHprEfeY3jLkiyRQK94Msi
         21tiz2vr6Q6/EPGsrRADDzcszx4Aai/hs0inLTUpCh/k++ytlar32ZjF/qd8spqW22
         5JnMReIhMSY5VR6RPtbAYMaJA/39kLESqhCgueFdrd9DhnohqnoQvl4NfdYyhA1jUX
         AwHjM0D/LuDjw==
Date:   Sat, 18 Mar 2023 16:57:58 +0000
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
Message-ID: <20230318165758.4daff10a@jic23-huawei>
In-Reply-To: <1161c822-ece3-4654-f11d-c775f8c64f65@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
        <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
        <20230304201720.2d554f07@jic23-huawei>
        <c16d372f-a122-16d6-ad08-1fbffb01d9ff@gmail.com>
        <20230312153655.052d5730@jic23-huawei>
        <1161c822-ece3-4654-f11d-c775f8c64f65@gmail.com>
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

On Tue, 14 Mar 2023 11:39:22 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/12/23 17:36, Jonathan Cameron wrote:
> > On Sun, 5 Mar 2023 14:22:51 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 3/4/23 22:17, Jonathan Cameron wrote:  
> >>> On Thu, 2 Mar 2023 12:58:59 +0200
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> 
> //snip
> 
> >>>      
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
> > Return data in lux?  Or return it as INFO_RAW - thus making it clear
> > that the reading is not in expected units and a conversion must be
> > applied by userspace.  SCALE is not applied to PROCESSED by userspace.
> >   
> 
> I just noticed a thing. I used the iio_generic_buffer to test the 
> changes - and it got the channel values scaled to luxes even for the 
> PROCESSED channel. So, it seems to me the iio_generic_buffer does apply 
> the scale for PROCESSED channels too. I think that is slightly 
> misleading. Oh, and this is not intended to be a complaint - just a 
> report that there might be some room for an improvement :)

Ah. Looks like the code doesn't have any check on whether the sysfs
read is _raw or _processed which is kind of understandable.

This may be the first case where those have both applied on a channel
that is available via buffered route.

Given processed channels are rarely IIO_VAL_INT which is kind of necessary
to poke it in the buffered route, that may well be true.

Jonathan

> 
> Yours,
> 	-- Matti
> 

