Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A675B775F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiIMRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiIMRKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:10:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7AF923E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:58:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w16so13207249eji.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iZxym95KdGg+6iEgSjAWKJXLnUiQuXDvKPE1FGjFnQQ=;
        b=Txrd4gbQ64FspzIne5wVD+p5116iAFqIXH0MCu+LVKesSzlo8cmp2G0adGp27pIY9p
         05ehWrX5U2KPV1ZB8P58tM2zC7Qd0ekwNaboWuUnZ6BCRLLVZevvc5sd3D8KpwbPzaWn
         f0y0mAYlRmoVRF4IwQ5N9dL0yDqqiwSHwduJRG20GhGvegJ/QufXdHR1CfGR18G+OsZA
         Row2hODVjR/fS7Ze6ULWN9wKsTmGvLuMUSrCfAxx+MbyxGdf9puiMBIMzqwNhRvU/5rh
         a3SPrCJhoRmuVOEMqw449F2oUYkdyejWdnOhAg94Lnzv8kTDAp8XSSDZdA6s+juQBv6D
         H28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iZxym95KdGg+6iEgSjAWKJXLnUiQuXDvKPE1FGjFnQQ=;
        b=LlEEqasL5C9RmvBQgOV5bnZ6W5QxroK4KmD/JmM3L+ukPgjyf29X0eehqeCx2pcsWi
         mR3IEaUjTMPLz/NgfAryzwO6Oxkj0c2+rnxI9UKyeXiRGel9Mtu0EgXxOW5N32N85jzr
         vHUrDaRL06ZfT6wH/9IbJ0oAlvQ8NulnbdzZbk5Mjee9JgwPSkzq4KN+ynBhnLieLZ/b
         9t/1MUirkyNnjty08T9PMCNHY5AGVfU6+uiBAVvSk7TvVn2pMxakCaJ3pFEioonfA45i
         T5QBRSz1z8miFIYarWtPPzAAojOpkRZo7Zzp83wkmSXsiEF1vfL+xGiuD3KrngDpqFdZ
         aIxQ==
X-Gm-Message-State: ACgBeo0zuO6JmCI5NVz9Fls+fUsjwvEYPUxduRLJiP02fBNoLEY7YLud
        1Kiceg6s5y9RFOEGL4Z5/1wFIHpmjbdur4C5whF20A==
X-Google-Smtp-Source: AA6agR5sTFC44yl7xVfN3YGCtspiOuVU7OS/pJGABmPeMSUqaaRrmVQCpNEn1Iu5Q96MQiqmYRcYPVm3/sxonMaD7t0=
X-Received: by 2002:a17:907:1c87:b0:741:8199:a59d with SMTP id
 nb7-20020a1709071c8700b007418199a59dmr22298125ejc.736.1663084722934; Tue, 13
 Sep 2022 08:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220909121329.42004-1-brgl@bgdev.pl> <20220909121329.42004-3-brgl@bgdev.pl>
 <YxykorLetCjAls/Z@sol> <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol> <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol> <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
 <YyCTmZocN/CY4Pg6@sol> <CAMRc=MdBRGW0skXOgPbZy=w4EiWcyKmKwKSZuAj+k4EtbPmvdg@mail.gmail.com>
 <YyCZ7TN8fyVyuWXY@sol>
In-Reply-To: <YyCZ7TN8fyVyuWXY@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Sep 2022 17:58:32 +0200
Message-ID: <CAMRc=MfyD5iyfB5f5hx_Kq4p7NZv+0o8HVOysiy6DaKANpGNKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 4:55 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Tue, Sep 13, 2022 at 04:35:08PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Sep 13, 2022 at 4:28 PM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 10:54:26AM +0200, Bartosz Golaszewski wrote:
> > > > On Tue, Sep 13, 2022 at 4:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > >
> > > > > On Mon, Sep 12, 2022 at 11:56:17AM +0200, Bartosz Golaszewski wrote:
> > > > > > On Mon, Sep 12, 2022 at 11:53 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > > >
> > > > > >
> > > > > > [snip]
> > > > > >
> > > > > > > >
> > > > > > > > Using -1 sounds good but I've just realized there's a different
> > > > > > > > problem. A process holding a file descriptor may fork and both the
> > > > > > > > parent and the child will keep the same file descriptors open. Now
> > > > > > > > we'll have two processes (with different PIDs) holding the same GPIO
> > > > > > > > lines (specifically holding a file descriptor to the same anonymous
> > > > > > > > inode).
> > > > > > > >
> > > > > > > > This already poses a problem for this patch as we'd need to return an
> > > > > > > > array of PIDs which we don't have the space for but also is a
> > > > > > > > situation which we haven't discussed previously IIRC - two processes
> > > > > > > > keeping the same GPIO lines requested.
> > > > > > > >
> > > > > > > > I don't have any good idea on how to address this yet. One thing off
> > > > > > > > the top of my head is: close the parent's file descriptor from kernel
> > > > > > > > space (is it even possible?) on fork() (kind of like the close() on
> > > > > > > > exec flag).
> > > > > > > >
> > > > > > > > I need to think about it more.
> > > > > > > >
> > > > > > >
> > > > > > > I thought the O_CLOEXEC was set on the request fds exactly to prevent this
> > > > > > > case - only one process can hold the request fd.
> > > > > > >
> > > > > >
> > > > > > O_CLOEXEC means "close on exec" not "close on fork". When you fork,
> > > > > > you inherit all file descriptors from your parent. Only once you call
> > > > > > execve() are the fds with this flag closed *in the child*.
> > > > > >
> > > > >
> > > > > Ah, ok.
> > > > > You want to pass request fd ownership from parent to child??
> > > > > Why not lock ownership to the parent, so O_CLOFORK, were that
> > > > > available?
> > > > >
> > > >
> > > > Because what if we want to request a line and then daemonize i.e. fork
> > > > and exit in parent? It makes much more sense to keep the lines
> > > > requested in the child IMO.
> > > >
> > >
> > > Then you are doing it backwards - daemonize first ;-).
> > >
> > > Generally speaking, doesn't transfer of resource ownership to the forked
> > > child create havoc in multi-threaded apps? i.e. one thread requests a
> > > resource, another forks.  The parent thread unknowingly loses ownership,
> > > and the forked child process only starts with a replica of the forking
> > > thread.
> > >
> >
> > Yeah, sounds like a bad idea.
> >
> > > > During the BoF at Linux Plumbers it was suggested to use
> > > > /proc/$PID/fdinfo to expose the information about which lines are
> > > > requested but I can't figure out a way to do it elegantly.
> > > >
> > >
> > > Yeah, missed that :-(.
> > >
> > > Makes sense.
> > >
> > > As each request fd can contain multiple lines on a particular chip,
> > > you would need to identify the gpiochip and the offsets for that request.
> > > So two fields - the gpiochip path, and the list of offsets.
> > >
> > > Is that already too clunky or am I missing something?
> > >
> >
> > It's worse than that - we don't know the character device's filesystem
> > path in gpiolib. Nor should we, as we can be in a different fs
> > namespace when checking it than in which we were when we opened the
> > device (which is also another concern for storing the path to the
> > character device in struct gpiod_chip - unless we specify explicitly
> > that it's the path that was used to open it). Since we don't know it -
> > we can only get it from the file descriptor that the requesting
> > process got after calling open() on the GPIO device. But this fd may
> > have been closed in the meantime. I think I opened a can of worms with
> > this one. :)
> >
>
> Forgot that we don't have the path readily available in the kernel -
> would device name suffice?

Maybe. I'm looking at what fdinfo shows in my vm and see things like:

$ cat /proc/2353/fdinfo/10
pos: 0
flags: 02004000
mnt_id: 15
ino: 1052
inotify wd:1 ino:1 sdev:3c mask:fce ignored_mask:0 fhandle-bytes:c
fhandle-type:1 f_handle:7f0dd9400100000000000000

I don't see any tools/libs readily available for parsing these. In
libgpiod, if the user wanted to read the PID of the owner of the line,
we'd need to manually go through the list of all fdinfo entries we
have permissions to access and compare those against the line w'ere
checking.

We'd need of course first expose that info like:

gpio chip:gpiochip2 lines:0,3,4,7

Does that make sense?

Bart
