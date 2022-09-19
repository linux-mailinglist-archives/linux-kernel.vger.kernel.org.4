Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082215BD545
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiISTjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiISTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:39:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66415727;
        Mon, 19 Sep 2022 12:39:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a41so744790edf.4;
        Mon, 19 Sep 2022 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XFv8/s07GWCJPcBdBdWUf3TF+ajCiKTrMdsn8auNwkw=;
        b=f0DIRu0cqDxg5c/CwpkHebVvvJ0PzpsnxQJECBvzLov876B4CbJwMeNmxF5At7uNE5
         zNcmi/nLJljwJMSGY3Q/PyG4HdodW/GJm+tO44bauRTke3EbRSBuG5smK480Fphp7wee
         Jex8inaCvwds8GMO/hZql6j9RkMY0VO3Ds0zDwKk8+KfO/jV4bCrxrUZd0d5p/pjJX/e
         wK3+ijWqiV6atwOrNaDU4LblXv/2Nlybdg/H5OrxtQ7w8ww6UIiF19TEWSCdy1mSlBnn
         08ffeAuGNGOEMF29M9rxRWaj/EuZ5PZH9Wrn+cibHrx7+CHLp8PeGyxuBi6OHj2a8Zgd
         zJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XFv8/s07GWCJPcBdBdWUf3TF+ajCiKTrMdsn8auNwkw=;
        b=zDUJLVvqS8KF45oCLLpUn9FeHCBdS3Zb9mcfyQuAFtSptfj+9RX9c8kMwr0ETKJJz7
         31vJLKIqs7Rl93z0RFf10qxNqlVWjqkwGtptIpRKCa0xYyXyfCfyCBA9Ti2DTeALYxXb
         LpOzrqDw2V7fKJzkJvD8wKQY/krEszVo/0TAuKQ9KnRYGDknbbC2LisBqDDQ9AiXoZIe
         OvuhK2pxBfO++vMeFA3rq080ooQYbW9I3nCOysOFUfAGFR6G2DtdXsVD45mv9/EOYo75
         9CkBiA8yMSyCBGQvkuwJFBbbkQ6S1RAJrr1+TqnIyiyf32QtVXeN8YjnXO+KppCH6t6e
         hVAQ==
X-Gm-Message-State: ACrzQf2lC+XmI9u3/0jdNHJmbYI/wlVPgFIJr5J0/Ip2VmCxVfBp8wRB
        W2rrloUr1q1FKnDrsvAVcdAgTdBqX1NvFVCCULs=
X-Google-Smtp-Source: AMsMyM4L1GIyrF0ae2p/Z4ebbcDAMumtOsb/cmTWhLlp0KuDpgU3Q8HgwUQF78eWvNWWUggwhb1u5vt657lMECzavOw=
X-Received: by 2002:a05:6402:2789:b0:451:a578:74dd with SMTP id
 b9-20020a056402278900b00451a57874ddmr17033392ede.72.1663616389164; Mon, 19
 Sep 2022 12:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220912190753.10158-1-jagathjog1996@gmail.com>
 <20220912190753.10158-3-jagathjog1996@gmail.com> <YyHBKNC/YHbvIn40@mail.local>
 <CAM+2Eu+jCA9yJma2UtD736opw0=_uCz4Zbiem89ehexTEU7mQw@mail.gmail.com> <YydoGsEU/UPkXvXn@mail.local>
In-Reply-To: <YydoGsEU/UPkXvXn@mail.local>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Tue, 20 Sep 2022 01:09:37 +0530
Message-ID: <CAM+2EuJsz9NgEskhYapxFg7UrimB3Po97DZGHtBCHTc8+vx_1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtc: maxim: Add Maxim max31329 real time clock
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Alexandre,

Before sending v3 I have one comment,
Please see below.

On Mon, Sep 19, 2022 at 12:18 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 17/09/2022 16:09:54+0530, Jagath Jog J wrote:
> > > This doesn't feel right, doesn't that break start-year?
> > >
> > > What is the actual time range supported by this RTC? Shouldn't you set
> > > the century?
> >
> > The time range supported by RTC is 2000 to 2199.
> > The alarm registers don't have a century bit.
> > I have tested the alarm for
> > 2122-09-17T01:22:00
> > 2142-09-17T01:22:00
> > 2160-02-29T00:00:00
> > 2196-02-29T00:00:00 etc
> >
> > I will add another condition such that if the century bit
> > from the time register is not set then configuring the
> > alarm for the next century is not allowed.
>
> The actual check should be for the alarm to not exceed 100 years in the
> future then. Else, this wouldn't work well with datetime offsetting.

Sure, I will add this check.

>
> > > > +static int max31329_set_time(struct device *dev, struct rtc_time *tm)
> > > > +{
> > > > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > > > +     u8 regs[7];
> > > > +     int ret;
> > > > +
> > > > +     ret = max31329_get_osc_status(dev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > >
> > > Checking the oscillator is not needed here but resetting the status is.
> >
> > Resetting the device will resets the digital block,
> > I2C-programmable registers and oscillator also,
> > The oscillator is taking some time around 80 milli sec
> > to be back as usual.
> >
> > Is it required to reset every time during the time setting?
> >
>
> Not but resetting the osc status is.

Actually, the STATUS register which contains the Oscillator Stop
Flag (OSF) bit is a read-only register. If the OSF bit is set, then
reading the status register will not clear the OSF bit.

Based on the oscillator disable and enable testing, I observed
that the OSF bit is getting cleared automatically once the clock
settles, which is taking around 80msec. The manual resetting
option is not there for the OSC status bit.

Can I set the time without resetting the OSC status?

Thank you,
Jagath

>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
