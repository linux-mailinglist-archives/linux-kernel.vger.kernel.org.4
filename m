Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370025F22D4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJBLLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJBLLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:11:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D5F1CFC3;
        Sun,  2 Oct 2022 04:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17427B80D25;
        Sun,  2 Oct 2022 11:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A61C433D6;
        Sun,  2 Oct 2022 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664709090;
        bh=Gp0KsnOF87VlDtZEnR0GfLcrEetxe3Jr0dtUBU/amgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fv5ha7s4wd000oT+K4TykN241DjB4Sb8w5MLzvWi5GywVxkZWNWh7OZWGeviHzyBi
         aXAPlD2+CokxB++/l/undzclaJhPpgXS4pblNGL8xWL77OSEZ4wSqhtlnzv6D+y4dk
         E6LWh1tfkNm3kbYWvNTJjThKQRBmZuAhxlVLnaeZXw63iLGhYElAx0o7/j5mqwU74Y
         oZsMwUDb/DDxoYGQDYuYWqdN0JIW2Sl35kpMJeiepcAHA7dvw3d7qU7cissPUtUfly
         dFHNQuLOf7V6Ha4tMbOXX3VDr0TXAdPNfOazsMgXXgJFoXOeBI/c5qauq3hJ6C1KkW
         /Evr7uP1S+KRw==
Date:   Sun, 2 Oct 2022 12:11:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221002121145.2e3500ba@jic23-huawei>
In-Reply-To: <eb4e7420-a4f9-1ddb-3394-c478a3e1f32f@fi.rohmeurope.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
        <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
        <20220922180339.30138141@jic23-huawei>
        <f0ef546a-0ec2-2a52-8f12-8f218960f177@gmail.com>
        <20220924161722.6d3e165c@jic23-huawei>
        <eb4e7420-a4f9-1ddb-3394-c478a3e1f32f@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 26 Sep 2022 05:02:44 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 9/24/22 18:17, Jonathan Cameron wrote:
> > On Fri, 23 Sep 2022 09:31:12 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 9/22/22 20:03, Jonathan Cameron wrote:  
> >>> On Wed, 21 Sep 2022 14:45:35 +0300
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>>      
> >>>> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
> >>>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> >>>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> >>>> ranges (2, 4, 8 and 16g) and probably some other cool fatures.
> >>>>
> >>>> Add support for the basic accelerometer features such as getting the
> >>>> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> >>>> using the WMI IRQ).
> >>>>
> >>>> Important things to be added include the double-tap, motion
> >>>> detection and wake-up as well as the runtime power management.
> >>>>
> >>>> NOTE: Filling-up the hardware FIFO should be avoided. During my testing
> >>>> I noticed that filling up the hardware FIFO might mess-up the sample
> >>>> count. My sensor ended up in a state where amount of data in FIFO was
> >>>> reported to be 0xff bytes, which equals to 42,5 samples. Specification
> >>>> says the FIFO can hold maximum of 41 samples in HiRes mode. Also, at
> >>>> least once the FIFO was stuck in a state where reading data from
> >>>> hwardware FIFO did not decrease the amount of data reported to be in the  
> >>> spell check this.
> >>>      
> >>>> FIFO - eg. FIFO was "stuck". The code has now an error count and 10
> >>>> reads with invalid FIFO data count will cause the fifo contents to be
> >>>> dropped.  
> >>> Ouch - that's nasty.  
> >>
> >> Indeed it is. As this commit states, this is pretty initial support for
> >> the accelerometer. I want to enable people to do basic experimenting and
> >> also use the component to some slow ODR solutions. Besides, having even
> >> a basic support in-tree enable people to add further improvements :) So,
> >> I am hoping / expecting to see improvements added also by other people
> >> using this. I think that after this initial support many people still
> >> _need_ for example the runtime PM. Maybe we will also end up with some
> >> nicer solution to the FIFO issues.  
> > 
> > My initial gut feeling is that, if that fifo issue doesn't have a clean
> > solution, we don't don't support the fifo (by default anyway -
> > could have a module parameter or something to turn it on).  Late handling
> > of interrupts is something that can happen for lots of reasons. It should
> > never be fatal!  
> 
> Tell me about it... More than 10-years ago I "inherited" maintenance of 
> a timing code which was built on periodic 10msec IRQ which incremented a 
> counter. (And after that there were many new generations of Linux based 
> devices with various "rt"-requirements). Missing an IRQ was fatal as 
> there were no hardware where we could read the correct timestamp and 
> other units in the system were no longer in sync if the counter was 
> wrong. Only recovery was complete system restart for all units - which 
> in that use case was really bad. I learned to absolutely hate the serial 
> prints over slow UART - and I learned to love irqsoff tracer. I don't 
> work for that company anymore and I believe the product has already 
> retired. Yet, I still get *shrugs* when I see hard time limits for 
> serving IRQs on Linux. (Other than that I kind of like pondering the 
> rt-challenges).
> 
> Anyways, I don't see a real risk for example when using the ODRs < 2 Hz 
> and setting the watermark to somewhere near 20 samples.
> 
> It's really unfortunate the HW has these "hickups" - but I think it is 
> still perfectly usable for many cases - we just really need to document 
> the corner cases somewhere.

I'd rather we gated it - so by default the fifo mode isn't there and
people who are really confident they want it set a module parameter or
similar.  Cuts down on the bug reports.

> 
> > Simple first.   Different matter if you add the other triggers later in
> > the same patch series, but history says half the interesting features
> > we plan to add never get added.  
> 
> ack.
> 
> >>> Must either handle both pins or at least know if it is irq2 and
> >>> treat that as no irq for now.  
> >>
> >> I don't want to try supporting both pins for now. It makes this somewhat
> >> more complex - especially if we want to support using two IRQs. That
> >> will require some thorough thinking which I don't have time to do right
> >> now :(
> >>
> >> I can add the irq-names to the bindings and add check to the probe so
> >> that if the irq2 is used we error out with nice 'not supported' message.
> >>  
> > 
> > A slightly nicer thing to do is support one irq, but let it be either irq1 or
> > irq2. If both are supplied just ignore the second one.  People have
> > an 'amusing' habit of only wiring up irq2 on boards.
> >   
> 
> Ok. It shouldn't be such a big change for the code. I'll see what it 
> will look like.
> 
> >>>> +
> >>>> +static int kx022a_chip_init(struct kx022a_data *data)
> >>>> +{
> >>>> +	int ret, dummy;
> >>>> +
> >>>> +	/*
> >>>> +	 * Disable IRQs because if the IRQs are left on (for example by
> >>>> +	 * a shutdown which did not deactivate the accelerometer) we do
> >>>> +	 * most probably end up flooding the system with unhandled IRQs
> >>>> +	 * and get the line disabled from SOC side.
> >>>> +	 */
> >>>> +	ret = regmap_write(data->regmap, KX022A_REG_INC4, 0);  
> >>>
> >>> Unusual to do this rather than a reset.  Quick look suggests there is
> >>> a suitable software reset (CNTL2)  
> >>
> >> Same thing was just told me by a colleague of mine yesterday. Reset
> >> simplifies this quite a bit. (I just wonder if we can trust the reset
> >> always initializes the IC to same defaults or if there may be OTP
> >> differencies. I am new to these sensors).
> >>  
> > 
> > I really hope we can rely on any documented reset values!  
> 
> That is a sane assumption to do - but in my experience we don't live in 
> a sane world ;) I've seen way too many cases where the defaults are 
> changed for ICs for example by changing OTP. And sometimes the OTP 
> change has not been visible to the drivers from any revision registers 
> or such.
> 
> I'm not talking about Kionix sensors though as I've never worked with 
> Kionix sensors before - so let's just try out the reset and fix things 
> if problems emerge. I am probably just a bit paranoid :)

Entirely reasonable!

Jonathan

> 
> Thanks for all the help!
> 
> Yours,
> 	-- Matti
> 

