Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4870760B4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiJXSGS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiJXSFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:05:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342261C8D5D;
        Mon, 24 Oct 2022 09:46:14 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mx18P3FFdz67xWY;
        Tue, 25 Oct 2022 00:42:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 24 Oct 2022 18:44:37 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 17:44:36 +0100
Date:   Mon, 24 Oct 2022 17:44:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: temperature: ltc2983: refine
Message-ID: <20221024174435.00003489@huawei.com>
In-Reply-To: <5cfc6dbb2a324746ece4f6cc0e633ccedfce2c54.camel@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
        <20221020090257.1717053-4-demonsingur@gmail.com>
        <20221023135124.1fdeab5e@jic23-huawei>
        <5cfc6dbb2a324746ece4f6cc0e633ccedfce2c54.camel@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Sun, 23 Oct 2022 15:46:13 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Sun, 2022-10-23 at 13:51 +0100, Jonathan Cameron wrote:
> > On Thu, 20 Oct 2022 12:02:55 +0300
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >   
> > > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > > 
> > >  * make sure addresses are represented as hex
> > >  * add note about wrong unit value for adi,mux-delay-config-us
> > >  * simplify descriptions
> > >  * add descriptions for the items of custom sensor tables
> > >  * add default property values where applicable
> > >  * use conditionals to extend minimum reg value
> > >    for single ended sensors
> > >  * remove " around phandle schema $ref
> > >  * remove label from example and use generic temperature
> > >    sensor name
> > > 
> > > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>  
> > 
> > Hi Cosmin,
> > 
> > Just one question inline from me (other than the build bot report
> > that I'll
> > assume you'll fix for v3).
> > 
> > Otherwise looks like a nice cleanup to me.
> > 
> > I wonder a bit on whether it is worth splitting up, but that would be
> > rather messy to actually do so will leave that to the dt experts to
> > comment
> > on.
> > 
> > Jonathan
> > 
> >   
> > > ---
> > >  .../bindings/iio/temperature/adi,ltc2983.yaml | 309 +++++++++++---
> > > ----
> > >  1 file changed, 182 insertions(+), 127 deletions(-)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > index 722781aa4697..3e97ec841fd6 100644
> > > ---
> > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > +++
> > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > @@ -26,25 +26,25 @@ properties:
> > >  
> > >    adi,mux-delay-config-us:
> > >      description:
> > > -      The LTC2983 performs 2 or 3 internal conversion cycles per
> > > temperature
> > > -      result. Each conversion cycle is performed with different
> > > excitation and
> > > -      input multiplexer configurations. Prior to each conversion,
> > > these
> > > -      excitation circuits and input switch configurations are
> > > changed and an
> > > -      internal 1ms delay ensures settling prior to the conversion
> > > cycle in most
> > > -      cases. An extra delay can be configured using this property.
> > > The value is
> > > -      rounded to nearest 100us.
> > > +      Extra delay prior to each conversion, in addition to the
> > > internal 1ms
> > > +      delay, for the multiplexer to switch input configurations
> > > and
> > > +      excitation values.
> > > +
> > > +      This property is supposed to be in microseconds, but to
> > > maintain
> > > +      compatibility, this value will be multiplied by 100 before
> > > usage.  
> > 
> > This new text has me a little confused.  Previously we talked
> > rounding, now it
> > is saying the value is multiplied (which would make it definitely not
> > in micro
> > secs!)..  So are we papering over a driver bug here?
> > 
> >   
> 
> Hi Jonathan,
> 
> Let me try to make this one clear as it was my mess...
> 
> The multiplication is done internally by the device. I messed up in
> this one as this value is clearly not in us but it is the raw value.
> So, tecnically, there's nothing wrong in the driver as it just reads
> this property and directly writes it. But of course this is misleading
> and wrong from the bindings point of view.
> 
> That said, me and Cosmin did spoke about just having this property
> 'deprecated' and add a new one (the driver would need to be changed
> accordingly) - no idea also about a new name for it :)
> 
> But for this round, Cosmin decided to have this stated on the
> description and see what you and dt maintainers had to say about it and
> if making it 'deprecated' is the way to go (or something else).

Deprecating and replacing with something right definitely seems like
correct option to me.  Naming always fun though when we already used the
most obvious name ;)

Thanks for the explanation.

Jonathan

> 
> - Nuno Sá
> 

