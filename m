Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3930E5FB4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJKOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJKOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:38:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E297EE2;
        Tue, 11 Oct 2022 07:38:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c24so13401475plo.3;
        Tue, 11 Oct 2022 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvityC9bORmPy0KdL5pxTNPzzms/gV5YTGcGv0rJ5jU=;
        b=muCcXqIbOpFqx9v2UQxN+fR02hHqFGN+7ieXYDNA+vRnVFsiAzLxfRAXCud5VQ9Uqw
         995NXbV3LgA9N/1xTN0MmhRraQRY/yrDoHckgJ05d7bH+P6+BjXUXJ2MyMEpiVNBGZFK
         oTFo3X/HswZXXZHCNYr44c0HwC9YDjbPCItMTkV9ULpxjur76VOZFBnpjibSojKY+ooF
         t+nJwl9951C//PulZuVewmKkRCN+dt3vCjIbK2N/xufp8RIZ1WcKRCotUIqaSC6SKhv5
         uOfWW/6Ufax1RUR3ZQGbW0kftIheaTCTo+LV2JA6uBGzwgmfxzl2n6svcoEDi9PqQnOa
         wKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvityC9bORmPy0KdL5pxTNPzzms/gV5YTGcGv0rJ5jU=;
        b=N2uAHKkXLoGBMyeFWv3kNnCuDGKbNGJ7f8k0+nj9MMMHkjEHSPWbzBuDcCoSHhF8tk
         I8RWT/Fm0SDD1UqfLbiBaG/jgFOOSQijVG7e9S/jtsbxJjcNYYr5P9mmc6K2Lf0lOSol
         iEuCrMQXRyye9XAJauwKUKkxQtQMz2QqlpkkCvkvE1Wy6v6IGtm/MoDPiWMuRtx8CXFH
         SopA216AkkXN12PdILPggf7oa3d1wWD3iVetfiulHjOHdhc8q2PXrvHmFiUO6nye/kAy
         5i/d0itYRF3YEMpMDQIq/TnSvK9xoawStucX99yUPSm2avMn5ox6/tMFmuJAk79wEoIJ
         BriA==
X-Gm-Message-State: ACrzQf1Garx3WujQP0q46RzedQmij/I+vrC2BMtgGPuXj63RW9lldOog
        1FOV6DTVEdNdBxNofh4znIo=
X-Google-Smtp-Source: AMsMyM6Y/mzfcChT9fJT+Ry58ZiLUPUYSUipi5EiBxOLq9RMY55bplWw9U82Dy2o7tJn5hCwKQwp4A==
X-Received: by 2002:a17:90a:930b:b0:20b:a5d:35d6 with SMTP id p11-20020a17090a930b00b0020b0a5d35d6mr30874953pjo.146.1665499127595;
        Tue, 11 Oct 2022 07:38:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:bff:9bd3:c2da:5f42])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79831000000b00563ce1905f4sm1529869pfl.5.2022.10.11.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:38:46 -0700 (PDT)
Date:   Tue, 11 Oct 2022 07:38:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <Y0V/82JsRVZh6PlL@google.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
 <Y0UDEtQlN5Y9h7BU@atomide.com>
 <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
 <Y0V4cLGbYe4j+ls6@google.com>
 <Y0V99Agad6Ma+yTC@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0V99Agad6Ma+yTC@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 05:30:12PM +0300, Tony Lindgren wrote:
> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221011 13:57]:
> > Hi Sebastian,
> > 
> > On Tue, Oct 11, 2022 at 02:37:26PM +0200, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Tue, Oct 11, 2022 at 08:45:54AM +0300, Tony Lindgren wrote:
> > > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221004 21:26]:
> > > > > The LCD driver (panel-sony-acx565akm), when probing, starts with line
> > > > > driven low, and then toggles it to high and keeps it there. Also, the
> > > > > line is driven low when powering off the device, and ls released when
> > > > > powering it back on. This means that the reset line should be described
> > > > > as "active low" in DTS. This will be important when the driver is
> > > > > converted to gpiod API which respects the polarity declared in DTS.
> > > > 
> > > > We should ensure these patches get merged together with the driver
> > > > change to avoid breaking LCD for booting. Probably no need to have
> > > > the driver quirk handling for inverted polartity in this case.
> > > > 
> > > > It's probably easiest to have an immutable branch for the driver
> > > > changes I can base the dts changes on. Or I can ack the dts changes
> > > > if they get merged with the driver.
> > > 
> > > Both drivers are already using gpiod API:
> > > 
> > > drivers/gpu/drm/panel/panel-sony-acx565akm.c
> > > drivers/gpu/drm/panel/panel-dsi-cm.c
> > 
> > I was looking at
> > 
> > drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> > drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> 
> Ah OK that explains :)
> 
> > which are not using gpiod. Should they be retired?
> 
> Yes we should just get rid of them with omapdrm working just fine.

Will you be submitting such patches? I'd like to get rid of
of_get_named_gpio() and friends if I can...

> 
> > > So this just breaks things.
> > 
> > I missed the drivers in drivers/gpu/... and I see that they essentially
> > abuse gpiod API as gpiod_set_value() operates on logical level
> > (active/inactive) and not absolute (high/low). They should either use
> > the gpiod_*_raw() variants, or they should be adjusted to do the proper
> > thing together with the accompanying DTS change.
> > 
> > What are your preferences?
> 
> Seems like high/low at the connected device end is what we should use,
> right? Otherwise things will misbehave if the panel is connected to
> some other SoC possibly.

It is exactly because of this case the driver should use active/inactive
and follow polarity described in DTS. If the driver does:

	gpiod_set_value_cansleep(d->reset, 1);

then if DTS is saying that the reset line is active low, under the wraps
the line will be driven to "0", but if DTS is saying that the line is
active high, then the very same call will drive the line to "1".

This allows accommodating different designs without having to change the
driver code.

-- 
Dmitry
