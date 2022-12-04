Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD3641BFA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLDJNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLDJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:12:59 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E9DF88
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 01:12:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b21so8304788plc.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hui00Mj8uKKJ+WTs3g6JhPVJxBX0HMQzpdep00kyYeQ=;
        b=5L3ip8lLkiAI3+kBwZmC5gCDyWxIuN/BDbk0BlPLh5o07vwOwKACNN713WXKMsAphv
         h6TLRaoEpLhD6wf/GbGGFI0pa9DwtmW+BKTQGF28i8V2AP6j+FYLN19ldEhJUh0TQHbS
         nNqK+0/w06rkKndjVIWPxxHZcDn/TkyGuS+WIjB9jOwwAu/2yqKBMt+79FgSxN2A1TzQ
         i/FUGmYxBtatZi06ZOQ7I6kIGrMfD1bnWkEfLbXOBPnFbBEJmeWeo1Hf8kv4qG0vREDL
         tK0IMtqEc13ippyuHRvTGyHKvFoSPrNZe0R3WidLpnCx98JhG7XAObZaZ3YeGXbweY7O
         E1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hui00Mj8uKKJ+WTs3g6JhPVJxBX0HMQzpdep00kyYeQ=;
        b=jriZZ2uv/6Yq9/fa19rlpupujVoGXbMe2GuExko1A8wroRjbWV0fXYbncau/PIeWU4
         X2FlzL3yRfiXUpSm1LXTakAT3x4Gt6LnbbArFBm3Fw56/NnMBFFG2EtxyEGZBWp1cp6q
         QGerXwJvR+NvquyRgsFsBfaEiIg7WZLL1UzqaUDWijvVlApOA7e3gTBZlV0NllYVLM71
         8zSvSyuWbZOln/eWRAlxjYL5Yq8f7zktxAogHwv3cWGJnGzzhALHU+cgs+BkkILo256a
         taDohZEaqe5WHmHZgrBazVz2JhrNAf71553UD2UlujqhYksz1JkLNhRJKJu2s/5pxG3t
         jXCw==
X-Gm-Message-State: ANoB5pkailK4v8iREdnlCQvqgaaDzd7+XE8uSVT7pYI1oqrWq3mm1mpm
        tBdrJJs4wmptVXhuScrwmZyudHXJl/SHvYiWY8I=
X-Google-Smtp-Source: AA0mqf5EQUhTd08ei/9Uu7L5vopugmhAcoKrrDKzclnTdJgle6V4FnLg8Sduy1me5uJw8y9P0xo6FA==
X-Received: by 2002:a17:902:aa83:b0:189:754b:9d9c with SMTP id d3-20020a170902aa8300b00189754b9d9cmr40787537plr.120.1670145171819;
        Sun, 04 Dec 2022 01:12:51 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id px13-20020a17090b270d00b00218fb3bec27sm7303881pjb.56.2022.12.04.01.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:12:51 -0800 (PST)
Date:   Sun, 4 Dec 2022 22:12:47 +1300
From:   Daniel Beer <daniel.beer@igorinstitute.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Christina Quast <contact@christina-quast.de>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] hid-ft260: add UART support.
Message-ID: <20221204091247.GA11195@nyquist.nev>
References: <638c51a2.170a0220.3af16.18f8@mx.google.com>
 <Y4xX7ILXMFHZtJkv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4xX7ILXMFHZtJkv@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 09:18:52AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Oct 22, 2022 at 11:19:20AM +1300, Daniel Beer wrote:
> > Based on an earlier patch submitted by Christina Quast:
> > 
> >     https://patches.linaro.org/project/linux-serial/patch/20220928192421.11908-1-contact@christina-quast.de/
> 
> Please link to lore.kernel.org, we have no idea what will happen over
> time to other domains/links.
> 
> > Simplified and reworked to use the UART API rather than the TTY layer
> > directly. Transmit, receive and baud rate changes are supported.
> 
> Why use the uart layer?  Did you just change how the existing driver
> works?

Hi Greg,

Thanks for reviewing. This device is quite strange -- it presents itself
as a USB HID, but it provides both an I2C master and a UART. The
existing driver supports only the I2C functionality currently.

> > +struct ft260_configure_uart_request {
> > +	u8 report;		/* FT260_SYSTEM_SETTINGS */
> > +	u8 request;		/* FT260_SET_UART_CONFIG */
> > +	u8 flow_ctrl;		/* 0: OFF, 1: RTS_CTS, 2: DTR_DSR */
> > +				/* 3: XON_XOFF, 4: No flow ctrl */
> > +	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
> 
> The data structure in the device really looks like this?  Unaligned
> accesses are odd.

Yes, that really is the data structure. Is there a better way to do
this?

> > --- a/include/uapi/linux/major.h
> > +++ b/include/uapi/linux/major.h
> > @@ -175,4 +175,6 @@
> >  #define BLOCK_EXT_MAJOR		259
> >  #define SCSI_OSD_MAJOR		260	/* open-osd's OSD scsi device */
> >  
> > +#define FT260_MAJOR		261
> 
> A whole new major for just a single tty port?  Please no, use dynamic
> majors if you have to, or better yet, tie into the usb-serial
> implementation (this is a USB device, right?) and then you don't have to
> mess with this at all.

As far as I understand it, I don't think usb-serial is usable, due to
the fact that this is already an HID driver.

I'll change to use dynamic majors, unless there's a better option.

> > +
> >  #endif
> > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> > index 3ba34d8378bd..d9a7025f467e 100644
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -276,4 +276,7 @@
> >  /* Sunplus UART */
> >  #define PORT_SUNPLUS	123
> >  
> > +/* FT260 HID UART */
> > +#define PORT_FT260	124
> 
> Why is this required?  What userspace code needs this new id?  I want to
> remove all of these ids, not add new ones.

It probably isn't. I'd taken another driver as an example when
implementing this, and that's what it did. Should I instead set the port
field to PORT_UNKNOWN and return NULL from uart_type?

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
