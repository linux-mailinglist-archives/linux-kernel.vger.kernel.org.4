Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5F629E89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiKOQK6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 11:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKOQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:10:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165A1C119;
        Tue, 15 Nov 2022 08:10:55 -0800 (PST)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBWLk5JNFz67T9q;
        Wed, 16 Nov 2022 00:08:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:10:54 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 16:10:53 +0000
Date:   Tue, 15 Nov 2022 16:10:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Message-ID: <20221115161052.00002633@Huawei.com>
In-Reply-To: <0d6b3e4047df9f560079a562bc167bd7a0bf2d28.camel@gmail.com>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-6-linux@rasmusvillemoes.dk>
        <20221112170705.7efe1673@jic23-huawei>
        <095a454b55cf497392a621649f24e067@analog.com>
        <20221114194447.2528f699@jic23-huawei>
        <0d6b3e4047df9f560079a562bc167bd7a0bf2d28.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Tue, 15 Nov 2022 15:49:46 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Mon, 2022-11-14 at 19:44 +0000, Jonathan Cameron wrote:
> > On Mon, 14 Nov 2022 13:52:26 +0000
> > "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Saturday, November 12, 2022 7:07 PM
> > > > To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > > Cc: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>; Lars-Peter
> > > > Clausen
> > > > <lars@metafoo.de>; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>;
> > > > devicetree@vger.kernel.org; Rob Herring <robh+dt@kernel.org>;
> > > > linux-
> > > > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for
> > > > reset-gpio
> > > > 
> > > > [External]
> > > > 
> > > > On Fri, 11 Nov 2022 15:39:21 +0100
> > > > Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > > >     
> > > > > We have a board where the reset pin of the ad74412 is connected
> > > > > to a
> > > > > gpio, but also pulled low by default. Hence to get the chip out
> > > > > of
> > > > > reset, the driver needs to know about that gpio and set it high
> > > > > before
> > > > > attempting to communicate with it.    
> > > > 
> > > > I'm a little confused on polarity here.  The pin is a !reset so
> > > > we need to drive it low briefly to trigger a reset.
> > > > I'm guessing for your board the pin is set to active low? (an
> > > > example
> > > > in the dt would have made that clearer) Hence the pulse
> > > > in here to 1 is actually briefly driving it low before restoring
> > > > to high?
> > > > 
> > > > For a pin documented as !reset that seems backwards though you
> > > > have
> > > > called it reset so that is fine, but this description doesn't
> > > > make that
> > > > celar.    
> > > 
> > > My opinion is that the driver shouldn't exactly know the polarity
> > > of the reset,
> > > and just assume that setting the reset GPIO to 1 means putting it
> > > in reset,
> > > and setting it to 0 means bringing out of reset.  
> > 
> > Agreed. I'd just like a comment + example in the dt-binding to make
> > the point
> > that the pin is !reset.
> > 
> > Preferably with an example in the dt binding of the common case of it
> > being wired
> > up to an active low pin.
> > 
> > The main oddity here is the need to pulse it rather than request it
> > directly as
> > in the reset state and then just set that to off.
> > 
> >   
> 
> Agreed... In theory we should be able to request the gpio with
> GPIOD_OUT_HIGH and then just bring the device out of reset

If I recall correctly the datasheet specifically calls out that a pulse
should be used.  No idea if that's actually true, or if it was meant
to be there just to say it needs to be set for X nsecs.

Jonathan

> 
> - Nuno Sá
> 

