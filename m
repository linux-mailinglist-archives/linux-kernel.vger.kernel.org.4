Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978F7288AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjFHTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjFHTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:34:48 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320FA1FEB;
        Thu,  8 Jun 2023 12:34:47 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77abe33790dso48775439f.2;
        Thu, 08 Jun 2023 12:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252886; x=1688844886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/Dn/9w//ldnFJmGHUjdUeSElg5i3vFl3qGg/nc2Jxo=;
        b=ADDcqn0tQa2izY5l+VRDppHXV+ePze/6fD2iSqy9YIv1ewBo98vA+ieqpZvuHh99MI
         fueqUeZScSJz1VeZc8oGccPRwmdGQnMNlIEBvTu7h0Q5fyb717ArXL2iHvopz+JrUnrD
         hc5zhq4A/7psgNzJ0vc/f6xzXucPWQBiQ1OsNUGmSH1goKFrnmHnvXvIVa7cNINm0/Nt
         QEX5vkS1n8LkXhyMKq0zXLAV+deX1/bQGFuDDJhkIZTrGh2m93mP0nN0EYsDOGmlOoNx
         R1rzCQZ79j7m8GPXFmR+nVqTiBAHDdwiyWfJlpv1JhDXXcDel3TpS+Y+MMHGcZiMo0wE
         8fHA==
X-Gm-Message-State: AC+VfDwE2TKx1Niph92ajRjvkMwCBCnwv9rhJnnYGnF55c26vbZ4r87H
        EhWNKkN2H7DrzBL+1rkB0r/mi4X87Q==
X-Google-Smtp-Source: ACHHUZ6iNVMDWj26J2ozDnsxCBhdo+w3DbXacc5k85jb6cr0VrqHuO3JXb6s15YRW3o4BzD24cU+ig==
X-Received: by 2002:a5e:8d0d:0:b0:76c:595a:6b5f with SMTP id m13-20020a5e8d0d000000b0076c595a6b5fmr7700426ioj.20.1686252886418;
        Thu, 08 Jun 2023 12:34:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t25-20020a6b0919000000b0077a1d1029fcsm549664ioi.28.2023.06.08.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:34:45 -0700 (PDT)
Received: (nullmailer pid 3274931 invoked by uid 1000);
        Thu, 08 Jun 2023 19:34:43 -0000
Date:   Thu, 8 Jun 2023 13:34:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, marius.cristea@microchip.com,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230608193443.GA3261675-robh@kernel.org>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
 <20230519160145.44208-2-marius.cristea@microchip.com>
 <20230519-variably-direction-cfa9a034e844@spud>
 <20230520161753.28a8c128@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520161753.28a8c128@jic23-huawei>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 04:17:53PM +0100, Jonathan Cameron wrote:
> On Fri, 19 May 2023 19:29:15 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
> > Hey Marius,
> > 
> > On Fri, May 19, 2023 at 07:01:44PM +0300, marius.cristea@microchip.com wrote:
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > > 
> > > This is the device tree schema for iio driver for
> > > Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > > Delta-Sigma ADCs with an SPI interface.  
> > 
> > Just one quick process bit, please try to CC all of the maintainers
> > listed by get_maintainer.pl - you unfortunately managed to miss 2 of the
> > 3 dt-binding maintainers :/ Perhaps you ran get_maintainer.pl using our
> > vendor tree?
> > 
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > ---  
> > 
> > > +  vref-supply:
> > > +    description:
> > > +      Some devices have a specific reference voltage supplied on a different
> > > +      pin to the other supplies. Needed to be able to establish channel scaling
> > > +      unless there is also an internal reference available (e.g. mcp3564r)  
> > 
> > Should this be marked as a required property for the non-r devices that
> > do not have an internal reference?
> > 
> > > +  microchip,hw-device-address:  
> > 
> > Hopefully Rob or Jonathan etc can chime in as to whether a common
> > property exists for this type of thing...
> > 
> Nope. This is a new one for me - there are devices that work on a daisy chain
> principle but I think this one works by encoding stuff in the actual message
> which is unusual for SPI.

Not something I've seen either.

> 
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 3
> > > +    description:
> > > +      The address is set on a per-device basis by fuses in the factory,
> > > +      configured on request. If not requested, the fuses are set for 0x1.
> > > +      The device address is part of the device markings to avoid
> > > +      potential confusion. This address is coded on two bits, so four possible
> > > +      addresses are available when multiple devices are present on the same
> > > +      SPI bus with only one Chip Select line for all devices.  

What's this going to look like with more than one device? It would need 
to be incorporated into 'reg' and the unit-address to work. Something 
like this is 

spi {
  device0@0 {
    reg = <0>;
    microchip,hw-device-address = <0>;
  };

  device1@0 {
    reg = <0>;
    microchip,hw-device-address = <1>;
  };
};

That should throw warnings because you have 2 nodes at the same address 
which is not good practice.

I think you need a spi mux in here with the mux addresses being the 
microchip,hw-device-address values.

Rob
