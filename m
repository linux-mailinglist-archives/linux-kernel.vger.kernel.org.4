Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837485E7909
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiIWLEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiIWLEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:04:15 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E91EEE676;
        Fri, 23 Sep 2022 04:04:09 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6857124000B;
        Fri, 23 Sep 2022 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663931048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1pl7m3BcKQFRdvwHdTlpfN1yQan5OWyAa1ah2yZ/5g4=;
        b=aF99+PU+f9hssnGMAtIOpVOdvbkkk+MriT+6WCGnCs9rNHx7C6f66ZYdRA3eyNgZetWSSr
        69u+8OHWDssSgv4PAjayBHT4v4Bjv64JGr+pDB3vpMmz3V1Rl+kxfNwrKwieMzbDN/Fvl4
        Z2m5g1s8dwpuz6PVlcDlFvNwAKGesNkQazPCcl0osPcRfLt3jPKSVdRc4Ij4Y3Sm4lg/1f
        vggsnHOWI0tiE2tCO3h3H2csqYiPNsReDobUnKnp721HMAokJ/ITDkg9nXcb08eywaeWH7
        +RPI3PPUXXvMdddY0dcs8wIDRFj4V0K7MbC2i0rlz8G7O3GVLoTFux5xEm98nw==
Date:   Fri, 23 Sep 2022 13:04:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rtc: maxim: Add Maxim max31329 real time clock
Message-ID: <Yy2SpmCy1ZjC1pMz@mail.local>
References: <20220912190753.10158-1-jagathjog1996@gmail.com>
 <20220912190753.10158-3-jagathjog1996@gmail.com>
 <YyHBKNC/YHbvIn40@mail.local>
 <CAM+2Eu+jCA9yJma2UtD736opw0=_uCz4Zbiem89ehexTEU7mQw@mail.gmail.com>
 <YydoGsEU/UPkXvXn@mail.local>
 <CAM+2EuJsz9NgEskhYapxFg7UrimB3Po97DZGHtBCHTc8+vx_1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM+2EuJsz9NgEskhYapxFg7UrimB3Po97DZGHtBCHTc8+vx_1g@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 01:09:37+0530, Jagath Jog J wrote:
>  Hi Alexandre,
> 
> Before sending v3 I have one comment,
> Please see below.
> 
> On Mon, Sep 19, 2022 at 12:18 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 17/09/2022 16:09:54+0530, Jagath Jog J wrote:
> > > > This doesn't feel right, doesn't that break start-year?
> > > >
> > > > What is the actual time range supported by this RTC? Shouldn't you set
> > > > the century?
> > >
> > > The time range supported by RTC is 2000 to 2199.
> > > The alarm registers don't have a century bit.
> > > I have tested the alarm for
> > > 2122-09-17T01:22:00
> > > 2142-09-17T01:22:00
> > > 2160-02-29T00:00:00
> > > 2196-02-29T00:00:00 etc
> > >
> > > I will add another condition such that if the century bit
> > > from the time register is not set then configuring the
> > > alarm for the next century is not allowed.
> >
> > The actual check should be for the alarm to not exceed 100 years in the
> > future then. Else, this wouldn't work well with datetime offsetting.
> 
> Sure, I will add this check.
> 
> >
> > > > > +static int max31329_set_time(struct device *dev, struct rtc_time *tm)
> > > > > +{
> > > > > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > > > > +     u8 regs[7];
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = max31329_get_osc_status(dev);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > >
> > > > Checking the oscillator is not needed here but resetting the status is.
> > >
> > > Resetting the device will resets the digital block,
> > > I2C-programmable registers and oscillator also,
> > > The oscillator is taking some time around 80 milli sec
> > > to be back as usual.
> > >
> > > Is it required to reset every time during the time setting?
> > >
> >
> > Not but resetting the osc status is.
> 
> Actually, the STATUS register which contains the Oscillator Stop
> Flag (OSF) bit is a read-only register. If the OSF bit is set, then
> reading the status register will not clear the OSF bit.
> 
> Based on the oscillator disable and enable testing, I observed
> that the OSF bit is getting cleared automatically once the clock
> settles, which is taking around 80msec. The manual resetting
> option is not there for the OSC status bit.
> 
> Can I set the time without resetting the OSC status?
> 

Sure but then it is not even useful to ever test OSF because we just
don't care if it fails while we are running, the most important info is
whether it fails when Linux is not running.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
