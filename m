Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1467FA16
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjA1Rtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjA1Rtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:49:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CCD222E2;
        Sat, 28 Jan 2023 09:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 378E3B80B84;
        Sat, 28 Jan 2023 17:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C1C433D2;
        Sat, 28 Jan 2023 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674928171;
        bh=8/SXHapVGxNXSE5DLgHD93D+IWGE00UMyYXEVCQ2ZbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMKRK0tl5+DdixmtVJ4tkjbNXZv3DFFaTC6GpQyjSl/6CXPDWoBU1EHI0wT8ox5Ow
         SvUUW91FRQPUSU837Dukbaeqh+VgcKF0wrd2f75/azG8UY2PlTWrLAKSm3C2ZnHvEG
         ds+g9Z6IM0pTsQmQYWR2v7APKu60mGoe/S/TKYZOm/PzTl0GetFhDIxnfTwfP1f+jL
         XIhdtPkNGzDV5Z3MM65rHzabHdps/c7BMDntqUFt6ToLSuc9VUGFedO7Vs5AH9qLdI
         B3RiOYEgl8STSwqDPqhxQS9+Fa9zTOjRrSmEqXhDRh4ggCEgO30OUC5cRuUe4M5nGK
         u/gmucSduI6Mg==
Date:   Sat, 28 Jan 2023 18:03:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: dac: ad5592r: add gpio_chip names
Message-ID: <20230128180325.0d7bd0b7@jic23-huawei>
In-Reply-To: <20221123204832.3e514378@jic23-huawei>
References: <20221117090130.51702-1-antoniu.miclaus@analog.com>
        <20221123204832.3e514378@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Wed, 23 Nov 2022 20:48:32 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 17 Nov 2022 11:01:30 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add array of explicit gpio names for the `gpiochip` structure of
> > ad5592r, mainly for debug purposes.  
> Can you give an example of when this is more useful than the offset?
> (which I'm assuming is also available when debugging?)
> 
> Jonathan

This one is still outstanding in patchwork.

Antoniu, if you want this to be applied please address the question above.

Thanks,

Jonathan

> 
> > 
> > Since the gpios are configurable via the dts, generic names are
> > used.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  drivers/iio/dac/ad5592r-base.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> > index 7a9b5fc1e579..076bc9ecfb49 100644
> > --- a/drivers/iio/dac/ad5592r-base.c
> > +++ b/drivers/iio/dac/ad5592r-base.c
> > @@ -124,6 +124,10 @@ static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned offset)
> >  	return 0;
> >  }
> >  
> > +static const char * const ad5592r_gpio_names[] = {
> > +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6", "GPIO7",
> > +};
> > +
> >  static int ad5592r_gpio_init(struct ad5592r_state *st)
> >  {
> >  	if (!st->gpio_map)
> > @@ -140,6 +144,7 @@ static int ad5592r_gpio_init(struct ad5592r_state *st)
> >  	st->gpiochip.set = ad5592r_gpio_set;
> >  	st->gpiochip.request = ad5592r_gpio_request;
> >  	st->gpiochip.owner = THIS_MODULE;
> > +	st->gpiochip.names = ad5592r_gpio_names;
> >  
> >  	mutex_init(&st->gpio_lock);
> >    
> 

