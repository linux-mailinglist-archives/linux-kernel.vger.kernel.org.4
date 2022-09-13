Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0E5B77F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiIMR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiIMR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:29:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354C6A48C;
        Tue, 13 Sep 2022 09:17:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso16174194pjk.0;
        Tue, 13 Sep 2022 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=N4sdAZTc2JnJriGvlkpHCviXUeb1FZPAHfbZC9uWtTk=;
        b=c1BZEISuJPDdX/GYQHz49mNHNLiGadROSKpRFpw30we4lbx93IwXK5yQcaYDGUpONP
         RvwKcp/vcMVCtlQKzZTDzo7wjWQ74NUK2uV/6iMwXoZWIe6WOb0TT/jeTxj+iR4ug0ov
         VIwsMcnmSP2jQsNvHfev/d3pt1HS67hc4uBLSZrExCr7PAEZNyTItnLVSk5o5W0k2sYv
         uhID2ENq/iCG5g3p5sufAgAO0hzT6/MseYXKURi2GIQnpJJx9p6fAW9//xZR5CaElqtn
         USZPLKmkEfYZ/y4i4Znc1x835T+GErrSIYTGTENM6vE+j9sqbQF7b/fMGgFwxLLxNbRd
         bJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=N4sdAZTc2JnJriGvlkpHCviXUeb1FZPAHfbZC9uWtTk=;
        b=s538QEnSKgZ8Sk6L+BrZsbensidTh6p854aTRJlsjPybI2xytFjzF2Sne2bUHiNghQ
         YTH2ERJJj8xFgawh/tZ4QbJGDu5VzZjTax2olMEGPhFP6aJoid9iLIsnNDiEjnSH/IYq
         DEFqYWS+hKLM9WPn3CC4K44lB6M5ZuwiJ1Br9b80vov7VHl4Sg2YAjnKDEdy/xAj2XdP
         rWuuO9SzQ49tKUpXpXy6uihwBRaR/bjtW40+fs3A6JExyn4huYNzT29ZmtqKZ0r/CCtr
         ZEVQiLVqgKMjmbU4vibfjb+mguHWhwF3BxVOzLTfdPdKBm8OzNvWiJ7K/G4xNu+1UJRM
         Gv2A==
X-Gm-Message-State: ACrzQf1G6rFBAvje8LcGj5IsGbwzen0chDUWyJafxAJZ6IjACiAe7KBM
        0Yg/JZ9Iv67KSRs0M31zqSQ=
X-Google-Smtp-Source: AMsMyM47T8VhQm2jGj/Kbi1Zf/WAqg7EDocI12xz6jT9FdzjBpcC5PFp4DCNdg/uEBhTbKj9khRJsQ==
X-Received: by 2002:a17:90b:b06:b0:200:aff0:2e68 with SMTP id bf6-20020a17090b0b0600b00200aff02e68mr46051pjb.159.1663085864520;
        Tue, 13 Sep 2022 09:17:44 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b001641b2d61d4sm8727193pln.30.2022.09.13.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:17:44 -0700 (PDT)
Date:   Wed, 14 Sep 2022 00:17:39 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YyCtI/WPngP9InsD@sol>
References: <YxykorLetCjAls/Z@sol>
 <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol>
 <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol>
 <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
 <YyCTmZocN/CY4Pg6@sol>
 <CAMRc=MdBRGW0skXOgPbZy=w4EiWcyKmKwKSZuAj+k4EtbPmvdg@mail.gmail.com>
 <YyCZ7TN8fyVyuWXY@sol>
 <CAMRc=MfyD5iyfB5f5hx_Kq4p7NZv+0o8HVOysiy6DaKANpGNKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfyD5iyfB5f5hx_Kq4p7NZv+0o8HVOysiy6DaKANpGNKQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 05:58:32PM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 13, 2022 at 4:55 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Tue, Sep 13, 2022 at 04:35:08PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Sep 13, 2022 at 4:28 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > On Tue, Sep 13, 2022 at 10:54:26AM +0200, Bartosz Golaszewski wrote:
> > > > > On Tue, Sep 13, 2022 at 4:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Sep 12, 2022 at 11:56:17AM +0200, Bartosz Golaszewski wrote:
> > > > > > > On Mon, Sep 12, 2022 at 11:53 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > > > >
> > > > > > >
> > > > > > > [snip]
> > > > > > >
> > > > > > > > >
> > > > > > > > > Using -1 sounds good but I've just realized there's a different
> > > > > > > > > problem. A process holding a file descriptor may fork and both the
> > > > > > > > > parent and the child will keep the same file descriptors open. Now
> > > > > > > > > we'll have two processes (with different PIDs) holding the same GPIO
> > > > > > > > > lines (specifically holding a file descriptor to the same anonymous
> > > > > > > > > inode).
> > > > > > > > >
> > > > > > > > > This already poses a problem for this patch as we'd need to return an
> > > > > > > > > array of PIDs which we don't have the space for but also is a
> > > > > > > > > situation which we haven't discussed previously IIRC - two processes
> > > > > > > > > keeping the same GPIO lines requested.
> > > > > > > > >
> > > > > > > > > I don't have any good idea on how to address this yet. One thing off
> > > > > > > > > the top of my head is: close the parent's file descriptor from kernel
> > > > > > > > > space (is it even possible?) on fork() (kind of like the close() on
> > > > > > > > > exec flag).
> > > > > > > > >
> > > > > > > > > I need to think about it more.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I thought the O_CLOEXEC was set on the request fds exactly to prevent this
> > > > > > > > case - only one process can hold the request fd.
> > > > > > > >
> > > > > > >
> > > > > > > O_CLOEXEC means "close on exec" not "close on fork". When you fork,
> > > > > > > you inherit all file descriptors from your parent. Only once you call
> > > > > > > execve() are the fds with this flag closed *in the child*.
> > > > > > >
> > > > > >
> > > > > > Ah, ok.
> > > > > > You want to pass request fd ownership from parent to child??
> > > > > > Why not lock ownership to the parent, so O_CLOFORK, were that
> > > > > > available?
> > > > > >
> > > > >
> > > > > Because what if we want to request a line and then daemonize i.e. fork
> > > > > and exit in parent? It makes much more sense to keep the lines
> > > > > requested in the child IMO.
> > > > >
> > > >
> > > > Then you are doing it backwards - daemonize first ;-).
> > > >
> > > > Generally speaking, doesn't transfer of resource ownership to the forked
> > > > child create havoc in multi-threaded apps? i.e. one thread requests a
> > > > resource, another forks.  The parent thread unknowingly loses ownership,
> > > > and the forked child process only starts with a replica of the forking
> > > > thread.
> > > >
> > >
> > > Yeah, sounds like a bad idea.
> > >
> > > > > During the BoF at Linux Plumbers it was suggested to use
> > > > > /proc/$PID/fdinfo to expose the information about which lines are
> > > > > requested but I can't figure out a way to do it elegantly.
> > > > >
> > > >
> > > > Yeah, missed that :-(.
> > > >
> > > > Makes sense.
> > > >
> > > > As each request fd can contain multiple lines on a particular chip,
> > > > you would need to identify the gpiochip and the offsets for that request.
> > > > So two fields - the gpiochip path, and the list of offsets.
> > > >
> > > > Is that already too clunky or am I missing something?
> > > >
> > >
> > > It's worse than that - we don't know the character device's filesystem
> > > path in gpiolib. Nor should we, as we can be in a different fs
> > > namespace when checking it than in which we were when we opened the
> > > device (which is also another concern for storing the path to the
> > > character device in struct gpiod_chip - unless we specify explicitly
> > > that it's the path that was used to open it). Since we don't know it -
> > > we can only get it from the file descriptor that the requesting
> > > process got after calling open() on the GPIO device. But this fd may
> > > have been closed in the meantime. I think I opened a can of worms with
> > > this one. :)
> > >
> >
> > Forgot that we don't have the path readily available in the kernel -
> > would device name suffice?
> 
> Maybe. I'm looking at what fdinfo shows in my vm and see things like:
> 
> $ cat /proc/2353/fdinfo/10
> pos: 0
> flags: 02004000
> mnt_id: 15
> ino: 1052
> inotify wd:1 ino:1 sdev:3c mask:fce ignored_mask:0 fhandle-bytes:c
> fhandle-type:1 f_handle:7f0dd9400100000000000000
> 

For a gpio fd (reported as gpio-line by lsof) I only get the basics:

pos:	0
flags:	02000000
mnt_id:	14
ino:	7661

> I don't see any tools/libs readily available for parsing these. In
> libgpiod, if the user wanted to read the PID of the owner of the line,
> we'd need to manually go through the list of all fdinfo entries we
> have permissions to access and compare those against the line w'ere
> checking.
> 
> We'd need of course first expose that info like:
> 
> gpio chip:gpiochip2 lines:0,3,4,7
> 
> Does that make sense?
> 

Makes sense to me, though I don't claim to know anything about fdinfo
field formatting.

e.g. I also see fdinfo fields like this:

eventfd-count:                0
eventfd-id: 1

so

gpio-chip:  gpiochip2
gpio-lines: 0,3,4,7

might be ok too.

Cheers,
Kent.
