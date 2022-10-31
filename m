Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94775613EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJaUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:14:48 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750575FF8;
        Mon, 31 Oct 2022 13:14:47 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s206so13943822oie.3;
        Mon, 31 Oct 2022 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VLAemObWTantp1OhH/KpYouhVRu0VK5KWQ1wH473Po=;
        b=eqGMffpKBI6TLdFp8W46wDX6hIQ/o9QSSefXouBWsKSuOzL20/n4AS6iZ/TymjVZkV
         fR+FV8cLPAC4/oJENuhSuyjBRjNahX1nDI3d3ILgRTYo8wCZX7NpKbmtsJVvmpkIny8W
         Gao3C3gjQI7IpA2QbA3GWtWdF7yz2Ou/0yspX6BomYxRzcjV1AYTjkKTT//oTjt/HLel
         SHbfvVsWdyFDdTyhKG1ZqpBfw0eR6gwU2b9tjwfugVpVsCS1vLudFhfyWZLTL3JU1c3E
         bnnL1IPbDZGFY3x5rNva2kMCgVtfgoaTHaiG6YrRXRz3tEhui0tS8K2cSuIpKu07Q8Fz
         BMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VLAemObWTantp1OhH/KpYouhVRu0VK5KWQ1wH473Po=;
        b=qhNmN4wf17Ux7YUO4hVEaxVCAONZEVgGKgKZjX8nfstiOEYq8NvZpNcUXzMAw0CiIH
         /jZSKZOv7KbthWuk06nMzuvsO8DEcRP4e4cOcfIlhqKKpIO9CiKM7QyCsHwaZxftzfoJ
         lEZA8y/H7PUUGJ0eReQ7uQpock83UT0cY3uGtbJ9tqi+2zyqSfiXOrAQhC4JFlll75QG
         0ENeCHDNT5mf3NXJ/xWH57qvXO6Z7PBsBKiDx1syzqqU1lWsJIbP4LkA/E/BmebAj7Vy
         rI6V0RTDkb2BKqKMA2R5wXsDzqjNjg9aQ5cvN7hLrZjZ7wFu2qUNQeUXzN+1CMxLEr2Y
         SQyg==
X-Gm-Message-State: ACrzQf35Knmb7SV/VTnxAgZb5wh0cOXGDGkkRF4Gt4GZJ3vyLPSfyVeO
        J7Gj8e6tRQRLMGbQIMaHsmU=
X-Google-Smtp-Source: AMsMyM7t0BuoDEhluoZ1b1qgno79jzOLIFwCMd9f1AJDh3XbfI5hpIhp/gIcCSF8p22pHvtoMpsRzA==
X-Received: by 2002:aca:3e56:0:b0:355:afb:cdb1 with SMTP id l83-20020aca3e56000000b003550afbcdb1mr7508817oia.81.1667247286771;
        Mon, 31 Oct 2022 13:14:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j29-20020a056870169d00b00127fbb7afffsm3538374oae.5.2022.10.31.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:14:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Oct 2022 13:14:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221031201445.GA2977400@roeck-us.net>
References: <20221027150928.983388020@goodmis.org>
 <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
 <20221028140129.040d9acc@gandalf.local.home>
 <20221028141007.05f5c490@gandalf.local.home>
 <20221028195959.GA1073367@roeck-us.net>
 <20221029145241.GA3296895@roeck-us.net>
 <20221029151952.076821f2@gandalf.local.home>
 <5ee0b72c-3942-8981-573f-73d97ea7ef08@roeck-us.net>
 <20221030114828.58fdd5d0@gandalf.local.home>
 <20221031155056.GB2462187@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031155056.GB2462187@roeck-us.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 08:50:58AM -0700, Guenter Roeck wrote:
> On Sun, Oct 30, 2022 at 11:48:28AM -0400, Steven Rostedt wrote:
> > On Sat, 29 Oct 2022 15:56:25 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > > >> WARNING: CPU: 0 PID: 9 at lib/debugobjects.c:502 debug_print_object+0xd0/0x100
> > > >> ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x480
> > > >>
> > > >> That happens with almost every test, so I may have missed some others
> > > >> in the noise.  
> > > > 
> > > > Can you add this?
> > > >   
> > > 
> > > It doesn't make a difference.
> > 
> > Ah, it also requires this (I have other debugging in that file, so it may
> > only apply with some fuzzing):
> > 
> 
> Almost good, except for the attached backtrace. That seems to happen
> on shutdown after bootting from a usb drive, but not on all platforms.
> 
> The warning is in __mod_timer():
> 
>         if (WARN_ON_ONCE(!timer->function))
>                 return -EINVAL;
> 
> This may be due to the change in blk_sync_queue() which I suspect may
> be called prior to the last mod_timer() call. I'll add some debug code
> to verify.
> 

I see that additional requests are sent to the scsi device after the call
to blk_sync_queue(). The description of this function suggests that this
may happen. Overall it does not seem to be appropriate to call
del_timer_shutdown() from blk_sync_queue(). I'll change my test code
accordingly.

Guenter
