Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2016F98D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEGOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEGOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453443C11;
        Sun,  7 May 2023 07:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC2B60DD7;
        Sun,  7 May 2023 14:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DDEC433EF;
        Sun,  7 May 2023 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683468531;
        bh=6z5OMoN9ZshInnWUN76w7jYclwTAVi4KO80Uk7v1VG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sTsbLIqSVJ2kAXQpUSXfVHkC8VIH/RhBouL8MsHHKK4DQU+IBYysq3l9GROISmXay
         mTIok64kQcx3Gc/XBaoZu1b1iitnlBoE8I1nRRVY0K3fXvTDIBd2M4W8On6ywg8C/+
         myOyekrxCMMFqWnyNhRyu0upJbOZ5ccmXEWN5UARklUVJkGFpE33Ez4OaMFV6H9r3p
         ayipZiW041pDcS+8hitd+5KD+aLQU3hYsAdTW2k3TlIYf9R3H3NRDJUfd+XGUh8C/Y
         Yh/lG6lVgFW3vEWvnb8QOzWt2ayeVzKBzdxibHLaFmJZs7EaWf0/Stl3Fx0kNUCHPf
         XQvieqbvmkqGQ==
Date:   Sun, 7 May 2023 15:24:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230507152443.754f2fab@jic23-huawei>
In-Reply-To: <307cc8ce-6178-7a86-2c90-eaf0ac8c122d@fi.rohmeurope.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
        <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
        <ZFF1NMaR1RYThcSB@smile.fi.intel.com>
        <307cc8ce-6178-7a86-2c90-eaf0ac8c122d@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023 05:11:53 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> Hi Andy
> 
> Thanks for the review.
> 
> On 5/2/23 23:40, Andy Shevchenko wrote:
> > On Wed, Apr 26, 2023 at 11:08:17AM +0300, Matti Vaittinen wrote:  
> >> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> >> and IR) with four configurable channels. Red and green being always
> >> available and two out of the rest three (blue, clear, IR) can be
> >> selected to be simultaneously measured. Typical application is adjusting
> >> LCD backlight of TVs, mobile phones and tablet PCs.
> >>
> >> Add initial support for the ROHM BU27008 color sensor.
> >>   - raw_read() of RGB and clear channels
> >>   - triggered buffer w/ DRDY interrtupt  
> > 
> > ...
> >   
> >> +enum {
> >> +	BU27008_RED,	/* Always data0 */
> >> +	BU27008_GREEN,	/* Always data1 */
> >> +	BU27008_BLUE,	/* data2, configurable (blue / clear) */
> >> +	BU27008_CLEAR,	/* data2 or data3 */
> >> +	BU27008_IR,	/* data3 */
> >> +	BU27008_NUM_CHANS  
> > 
> > Why not converting comments to a kernel-doc?
> >   
> >> +};
> >> +
> >> +enum {
> >> +	BU27008_DATA0, /* Always RED */
> >> +	BU27008_DATA1, /* Always GREEN */
> >> +	BU27008_DATA2, /* Blue or Clear */
> >> +	BU27008_DATA3, /* IR or Clear */
> >> +	BU27008_NUM_HW_CHANS
> >> +};  
> > 
> > Ditto.  
> 
> I see no value having entities which are not intended to be used outside 
> this file documented in any "global" documentation. One who is ever 
> going to use these or wonder what these are - will most likely be 
> watching this file. My personal view is that the generated docs should 
> be kept lean. In my opinion the problem of the day is the time we spend 
> looking for a needle hidden in a haystack. In my opinion adding this to 
> kernel-doc just adds hay :)

> 
> I still can do this if no-one else objects. I almost never look at the 
> generated docs myself. Usually I just look the docs from code files - 
> and kernel-doc format is not any worse for me to read. Still, I can 
> imagine including this type of stuff to generic doc just bloats them and 
> my not serve well those who use them.


Unless someone specifically adds this doc to the main docs build, the
kernel-doc won't end up in the docs anyway. It just provides a nice
bit of consistent formatting. Even if they do add this for some reason,
there are controls on internal vs external (exported stuff) being added
to the docs.

> 
> > 
> > ...
> >   
> >> +	if (int_time < 0)
> >> +		int_time = 400000;  
> > 
> > Adding 3 0:s to drop them below with a heavy division operation? Well done!
> > Or did I miss anything?  
> 
> No. You did not miss anything. This can be improved.
> 
> >   
> >> +	msleep(int_time / 1000);  
> > 
> > USEC_PER_MSEC ?  
> 
> Ok.
> 
> > ...
> >   
> >> +	ret = devm_iio_device_register(dev, idev);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret,
> >> +				     "Unable to register iio device\n");
> >> +
> >> +	return ret;  
> > 
> > return 0 will suffice.  
> 
> Ok.
> 
> Thanks,
> 	-- Matti
> 

