Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2C5E93F9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiIYPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIYPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:30:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB35113EB0;
        Sun, 25 Sep 2022 08:30:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a10so5076021ljq.0;
        Sun, 25 Sep 2022 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Pr4hdtR9ZMxFsotthP0GIPIDk3AwgpXePU9FjOtd4jM=;
        b=NwbVc70pVdhpbbli3K0HiIBsCFJRRgvep4vrXRWBGawWjY9iIZm1wO0PD9S03RLNLE
         hRD+Gm6UBiK+nh+B0fzuoJ253P7gFHyO0ciRtnjolaMeGXnZuV7xlIgbHTtb3a1SLyzO
         oeSBcqcm8s3oLczejF7tKVDqxbF/tUt8+7k0NXCfEXc6Coz46VEa6an6Sc9IDB6mXEPa
         7y9Lcm4/32US250n9h2CxpQwmXqac4xmY78sXS87AUtJ8ovrZvIFqYPqqiVM92DcXFf5
         CGyRPUGpohyljQ3T42i36DixmOIoIUZ0gjD0aBNgyX44QBVIgeDDK9sF6UOSZKzY1YvD
         XqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Pr4hdtR9ZMxFsotthP0GIPIDk3AwgpXePU9FjOtd4jM=;
        b=QWayc+FTw859D8iJrdZv2Vy2z3m4quAwdJvHkp7gLf/IxEzLZIDNDeCMkkg3lOmh+J
         WXWXMPk8q9kL5LhZMtMCSMhmZdEkstpG/9gweV7gkTnA6CoAud25cGrvZjSOYbaiupxd
         n+sFWSDdqXDSEy2xKel24anzeh5SPHGzoF+zLW8E1xxu4B5w+VYSnpfSxT5Hg+C0Y3cA
         5J5oI99iNE6rloVy/lQVv8aDh/1PPIP66uR3OxsVDH4VvzZRtUx1eTaH1NsjXEXheu7m
         ZYseA4f7lGaaWl63qCw0zAUZuhDWTQoY2bXNvllq6QYqK7yDA1uBQJ+b4w3OkSBvMEhQ
         n38Q==
X-Gm-Message-State: ACrzQf0oTl5YuGC5kIGiTu3Fs5N0W5fq2bh05Afry6eWc3Txor6XNUPu
        xsTnwAjUKLSRycgYeI4+YqvctfMuW6U=
X-Google-Smtp-Source: AMsMyM7plqoO5FQaZpTYc7Bq6EPlvM0QTDT9gTrfhDUkT5/JaJsq3hNrsGEHC8yyWY5ebuGGCiEeYg==
X-Received: by 2002:a05:651c:482:b0:26b:e964:3f00 with SMTP id s2-20020a05651c048200b0026be9643f00mr5858740ljc.464.1664119805003;
        Sun, 25 Sep 2022 08:30:05 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512358500b00499a6ef78a7sm2250391lfr.66.2022.09.25.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 08:30:04 -0700 (PDT)
Date:   Sun, 25 Sep 2022 18:30:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 1/2] gpio: Add gpio latch driver
Message-ID: <20220925153002.makz5eijmwzrgqqs@mobilestation>
References: <20220914071306.3254881-1-s.hauer@pengutronix.de>
 <20220914071306.3254881-2-s.hauer@pengutronix.de>
 <20220914140310.5ffrnsy63piegdyr@mobilestation>
 <20220922133105.GN986@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922133105.GN986@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To += @Rob, @Linus

On Thu, Sep 22, 2022 at 03:31:05PM +0200, Sascha Hauer wrote:
> On Wed, Sep 14, 2022 at 05:03:10PM +0300, Serge Semin wrote:
> > > +				    unsigned int offset, bool val)
> > > +{
> > > +	int latch = offset / priv->n_latched_gpios;
> > > +	int i;
> > > +
> > > +	assign_bit(offset, priv->shadow, val);
> > > +
> > 
> > > +	for (i = 0; i < priv->n_latched_gpios; i++)
> > > +		set(priv->latched_gpios->desc[i],
> > > +		    test_bit(latch * priv->n_latched_gpios + i, priv->shadow));
> > 
> > -> duration?
> > 
> > > +
> > > +	set(priv->clk_gpios->desc[latch], 1);
> > 
> > -> duration?
> > 
> > > +	set(priv->clk_gpios->desc[latch], 0);
> > 
> > I am pretty much sure there must be some duration between the actions
> > above *. See for instance the tw and (tsu + th) timing requirements in
> > the next edge-triggered flip-flops:
> > https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf?ts=1663163389954&ref_url=https%253A%252F%252Fwww.google.com%252F
> > 
> > The durations are normally small (ns or a bit smaller) but still need
> > to be added anyway.
> > 
> > Note since the durations are device-specific an additional DT-property array
> > with durations should be added too.
> 

> Do you think a fixed udelay(1) would be enough for now? Bigger delays
> shouldn't be needed and smaller delays expand to udelay(1) anyway on
> architectures not providing an architecture specific ndelay().

I am sure you shouldn't assume what the particular architecture
provide and what it doesn't. When it comes to the GPIOs the switching
timings can have a critical value in a lot of applications (like i2c
bitbang, or real-time systems). There is no point in waiting for
micro seconds in the fast-path like this when there is only a few
nano seconds delay required.

I couldn't find any generic ready-to-use DT-property for this case.
So IMO instead the next properties would work:
1. "setup-duration-ns" - data input timing after which the clock input
can be asserted (Tsu in the hw-manual above).
2. "clock-duration-ns" - clock input timing for which the CLK signal
must be kept asserted so the device would perceive the input
states, the outputs would be updated and the clock signal could be
driven back to low (Tw including Th in the hw-manual above).

@Rob, @Linus, any suggestion regarding the properties and their naming?

-Serge

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
