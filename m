Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D248D70E722
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjEWVGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEWVGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:06:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D91B1;
        Tue, 23 May 2023 14:06:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3491609fso204390b3a.3;
        Tue, 23 May 2023 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684875963; x=1687467963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1U7zEAf/yoejwJUOtbms5RWOc+O414V1IAd7Cw1sods=;
        b=mtize0RGz0fIFl51mZNJHHV6hF85Gy1w+bqDfQkjDhM1hk2sHxyPeFyjRZpWzu0+kd
         ZpTFNUvsy/IJkd2UxZqJefP7cQF7tWZOQwVRKKc7GctYybx9bQy7hreD+6Y4kayOc/WK
         p1uZOAlfy4MEAZOwxBmZvZT3OEFqSNnfmLCcAsCO5ZPeejEgdLFXafoO775nKteRiAjf
         XwIymznF5J5keW3CHyPEG/socUKUVIZjHzDr1zdLy6DPi6mMPx+wh1/FcCpcSAtANh1l
         nMy7706jrOnqbAqHhJ/Urvjt2tEYCN+4wXEeleg3QZV+NV4LXffSTjzgFzPB2cIxgSLr
         QjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875963; x=1687467963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U7zEAf/yoejwJUOtbms5RWOc+O414V1IAd7Cw1sods=;
        b=eiJt/f72KytIlwUzHrBbbLPoUpUlL9MATDzVnIIVjo0cNzEDOjxO6CmsD82cgg+L1i
         yldqPFKiUK1820U77G8RTvRgQ1gPMERGgDWr8bdpzoSnVJFplo7iCORyrw3Vm4EtjBE5
         wnCsJrb20vKQTEDMPOm9gkIh53Br9qxWKV3k3PKjqwwGKmfzKUCnoNRRbcljrqV29N20
         qHpdzzDHa9TUXlPgfDINp17TcWR3D/3vTNtW9TIcZxz7JVHmI2scTiBa7w6kRFeSzT6Q
         LFK5ksT9Lt8jShLoRYzySXwIelkmEyPR7ars6IErxRGG1f49/r7UU2cBXuwGT49QkkVa
         FOGw==
X-Gm-Message-State: AC+VfDyYM+SOeaggJBgSZgZ/sF/1GgjnIGiBeQfCcFDKQ5wqBa2joZ2Q
        6x0Uw2Z2kPzYNHERRy96pYA=
X-Google-Smtp-Source: ACHHUZ4KrPPsKNtyQjtawL4TOIc3ljVRY9x2oyvuTYNjHyIr8dqeeqCukpcKzAYVncfJjqlpkgT/fA==
X-Received: by 2002:a05:6a00:b85:b0:645:d02d:9a83 with SMTP id g5-20020a056a000b8500b00645d02d9a83mr436259pfj.17.1684875963247;
        Tue, 23 May 2023 14:06:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id i184-20020a6387c1000000b0053ba104c113sm3658639pge.72.2023.05.23.14.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:06:02 -0700 (PDT)
Date:   Tue, 23 May 2023 14:05:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: ensure timely release of driver-allocated resources
Message-ID: <ZG0qt0ji5dgJiDpT@google.com>
References: <ZFWarGkRAfPOmI6E@google.com>
 <nycvar.YFH.7.76.2305231554250.29760@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2305231554250.29760@cbobk.fhfr.pm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 03:57:03PM +0200, Jiri Kosina wrote:
> On Fri, 5 May 2023, Dmitry Torokhov wrote:
> 
> > More and more drivers rely on devres to manage their resources, however
> > if bus' probe() and release() methods are not trivial and control some
> > of resources as well (for example enable or disable clocks, or attach
> > device to a power domain), we need to make sure that driver-allocated
> > resources are released immediately after driver's remove() method
> > returns, and not postponed until driver core gets around to releasing
> > resources.
> > 
> > In case of HID we should not try to close the report and release
> > associated memory until after all devres callbacks are executed. To fix
> > that we open a new devres group before calling driver's probe() and
> > explicitly release it when we return from driver's remove().
> > 
> > This is similar to what we did for I2C bus in commit 5b5475826c52 ("i2c:
> > ensure timely release of driver-allocated resources"). It is tempting to
> > try and move this into driver core, but actually doing so is challenging,
> > we need to split bus' remove() method into pre- and post-remove methods,
> > which would make the logic even less clear.
> > 
> > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > Link: https://lore.kernel.org/r/20230505232417.1377393-1-swboyd@chromium.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/hid/hid-core.c | 55 ++++++++++++++++++++++++++++--------------
> >  include/linux/hid.h    |  1 +
> >  2 files changed, 38 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index c4ac9081194c..02a43bba9091 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2602,35 +2602,29 @@ static bool hid_device_check_match(struct hid_device *hdev,
> >  	return !hid_ignore_special_drivers;
> >  }
> >  
> > -static int hid_device_probe(struct device *dev)
> > +static int __hid_device_probe(struct hid_device *hdev)
> >  {
> > -	struct hid_driver *hdrv = to_hid_driver(dev->driver);
> > -	struct hid_device *hdev = to_hid_device(dev);
> > +	struct hid_driver *hdrv = to_hid_driver(hdev->dev.driver);
> >  	const struct hid_device_id *id;
> >  	int ret;
> >  
> > -	if (down_interruptible(&hdev->driver_input_lock)) {
> > -		ret = -EINTR;
> > -		goto end;
> > -	}
> >  	hdev->io_started = false;
> > -
> >  	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
> >  
> > -	if (hdev->driver) {
> > -		ret = 0;
> > -		goto unlock;
> > -	}
> > +	if (hdev->driver)
> > +		return 0;
> >  
> > -	if (!hid_device_check_match(hdev, hdrv, &id)) {
> > -		ret = -ENODEV;
> > -		goto unlock;
> > -	}
> 
> Dmitry, which tree is this patch against, please? The code above looks 
> different in current tree (and hasn't been touched for a while).

My bad, I had some patches in my tree that I forgot about. I sent out
a v2.

Thanks.

-- 
Dmitry
