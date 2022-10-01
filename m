Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC435F1E1F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJARGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJARGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8C52FF0;
        Sat,  1 Oct 2022 10:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34BD760C4A;
        Sat,  1 Oct 2022 17:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA88C433D6;
        Sat,  1 Oct 2022 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664644011;
        bh=MTFgoasZOI2r6PWIfdfJRvXu8XSX6/GwRTvzGgTtMko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rEPNkihZDnMSdkZ5yqin0vDPB9pYAujJMTk3YPx6sHpnI9B1hYif1SnSuN22pxKi/
         pAGGgMw64DhnLqIqRjYwOcwHH8f+iEJZ3i4DMVzvWarfPfj83Hff/WzR1SNp+f1AYF
         SYCKLtqIqul4aKRUHtykPfw58amriVgz+rtQ3kd6zH6vQaRkQB6nM7hq4rBXQQ9d9N
         hyU7Rz6wGMjB/tvrYjvKty291JCguZvMd+1W/YV9qsX7p39GSECSNaX1rvjshFgiQQ
         /QDovvtKAvfESxDUGrWbezQ+2h5vSxYOsTKk4asNp211k5N1xdKzmksD9139qFtDOW
         ig5hX5I7gobrA==
Date:   Sat, 1 Oct 2022 18:07:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <20221001180705.7002796a@jic23-huawei>
In-Reply-To: <YzMisM73yj/APB86@smile.fi.intel.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
        <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
        <YzMisM73yj/APB86@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:20:00 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Sep 27, 2022 at 08:46:11AM -0700, Dmitry Torokhov wrote:
> > The driver is using of_device_id/of_match_ptr() and therefore needs
> > to include of.h header. We used to get this definition indirectly via
> > inclusion of matrix_keypad.h from twl.h, but we are cleaning up
> > matrix_keypad.h from unnecessary includes.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a look.

Note that this is 6.2 material now - if that's an issue for the matrix_keypad.h
cleanup then feel free to take it via the input tree with
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
but shout in reply to this so I know to drop it from the iio tree.

Thanks,

Jonathan

> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > v2: adjusted patch description
> > 
> >  drivers/iio/adc/twl4030-madc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> > index f8f8aea15612..c279c4f2c9b7 100644
> > --- a/drivers/iio/adc/twl4030-madc.c
> > +++ b/drivers/iio/adc/twl4030-madc.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/types.h>
> >  #include <linux/gfp.h>
> >  #include <linux/err.h>
> > +#include <linux/of.h>
> >  #include <linux/regulator/consumer.h>
> >  
> >  #include <linux/iio/iio.h>
> > -- 
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >   
> 

