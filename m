Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2008472A175
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFIRmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFIRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:42:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B93AAC;
        Fri,  9 Jun 2023 10:41:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qd7fs2PVYz6J6ks;
        Sat, 10 Jun 2023 01:41:25 +0800 (CST)
Received: from localhost (10.126.170.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 18:41:52 +0100
Date:   Fri, 9 Jun 2023 18:41:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        <marius.cristea@microchip.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230609184149.00002766@Huawei.com>
In-Reply-To: <20230608193443.GA3261675-robh@kernel.org>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
        <20230519160145.44208-2-marius.cristea@microchip.com>
        <20230519-variably-direction-cfa9a034e844@spud>
        <20230520161753.28a8c128@jic23-huawei>
        <20230608193443.GA3261675-robh@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 13:34:43 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, May 20, 2023 at 04:17:53PM +0100, Jonathan Cameron wrote:
> > On Fri, 19 May 2023 19:29:15 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > Hey Marius,
> > > 
> > > On Fri, May 19, 2023 at 07:01:44PM +0300, marius.cristea@microchip.com wrote:  
> > > > From: Marius Cristea <marius.cristea@microchip.com>
> > > > 
> > > > This is the device tree schema for iio driver for
> > > > Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > > > Delta-Sigma ADCs with an SPI interface.    
> > > 
> > > Just one quick process bit, please try to CC all of the maintainers
> > > listed by get_maintainer.pl - you unfortunately managed to miss 2 of the
> > > 3 dt-binding maintainers :/ Perhaps you ran get_maintainer.pl using our
> > > vendor tree?
> > >   
> > > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > > ---    
> > >   
> > > > +  vref-supply:
> > > > +    description:
> > > > +      Some devices have a specific reference voltage supplied on a different
> > > > +      pin to the other supplies. Needed to be able to establish channel scaling
> > > > +      unless there is also an internal reference available (e.g. mcp3564r)    
> > > 
> > > Should this be marked as a required property for the non-r devices that
> > > do not have an internal reference?
> > >   
> > > > +  microchip,hw-device-address:    
> > > 
> > > Hopefully Rob or Jonathan etc can chime in as to whether a common
> > > property exists for this type of thing...
> > >   
> > Nope. This is a new one for me - there are devices that work on a daisy chain
> > principle but I think this one works by encoding stuff in the actual message
> > which is unusual for SPI.  
> 
> Not something I've seen either.
> 
> >   
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    minimum: 0
> > > > +    maximum: 3
> > > > +    description:
> > > > +      The address is set on a per-device basis by fuses in the factory,
> > > > +      configured on request. If not requested, the fuses are set for 0x1.
> > > > +      The device address is part of the device markings to avoid
> > > > +      potential confusion. This address is coded on two bits, so four possible
> > > > +      addresses are available when multiple devices are present on the same
> > > > +      SPI bus with only one Chip Select line for all devices.    
> 
> What's this going to look like with more than one device? It would need 
> to be incorporated into 'reg' and the unit-address to work. Something 
> like this is 
> 
> spi {
>   device0@0 {
>     reg = <0>;
>     microchip,hw-device-address = <0>;
>   };
> 
>   device1@0 {
>     reg = <0>;
>     microchip,hw-device-address = <1>;
>   };
> };
> 
> That should throw warnings because you have 2 nodes at the same address 
> which is not good practice.
> 
> I think you need a spi mux in here with the mux addresses being the 
> microchip,hw-device-address values.

Something that looked like an spi-mux would be cute I'm not sure how
easy it would be to make it work given need to modify the messages
(rather sending extra ones before and after with a different chip select).

It would be nice if it were somewhat generic - so binding included which
bits would be replaced with the 'chip select' for the spi controller that
represents the mux.

Jonathan


> 
> Rob
> 

