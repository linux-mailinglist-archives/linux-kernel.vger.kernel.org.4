Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64D5B69EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIMIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiIMIyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:54:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFBB65BD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:54:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z13so2539153edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JtKN6ivnTt8W41kiJ6PrZBXUONgEHmL/cRSauODg8t0=;
        b=PjNzMWmAi3uDLHnuivA8de8hNVFpFjIxM49Cik3JWLYBD8vMIOBHz1OrFijZiTZ4YH
         M25mkINOPpJEVN2a+EuS3WkOdbfIvFSm07pkq99soW6U8D/PbDY8xnDCaU3UWZaxbgxT
         3nVJalDrfwnp4aUf3l4sdraoOPRPfw9eCg4+ZE0mPgFRfRktAlV+zWkjzWRyBeFaP1E5
         hd8XplAdkJwiJ/V0X55Hi/J8h7V06iBgVzGvU8KnYXd4GOtiMjvNj3CPkQAmyzo8uiNG
         Yka2odDfsoYxSJ3C1GO8j6bUiuEXlF4NUulApcCt01nAT3HTHIOCdMucc52Epsolu/9v
         /zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JtKN6ivnTt8W41kiJ6PrZBXUONgEHmL/cRSauODg8t0=;
        b=DDgJKa2VC/JIKcQ7P0YPZyZUKC2z8+ulbo7zIuRQsEW/oyNBkAghQDFIti5X0RLM5n
         Zao7xG3PTW+yk9VmLayDCjECe4nQkb5sTuuRgVIwKP+2EYiV2EQJN3w4jKWVVMIodIVM
         2LjWnEIGIN8ClG3wS0j8evPMSWBqiST20QUjQQp1Gf+u1HyKd1vMY3ZjM5p0OfXRne+x
         N+fc6U3g05y/sE4/YCXM+Y+UlAmsT0z0nNH33IVvjECFarcxclRmrtt4WhOzgfd06iaX
         GFfQj0zO+udRRDmdFcD+svvhysY17V3zldxyPgPlQiBrU4F+X5hHvD1C4g2MUKVLKmUy
         kZLw==
X-Gm-Message-State: ACgBeo2qfVcZoEN9PUZD6fm73L+vBXNJSGvHGrwzhOpU54nh7h95O1sv
        xWG6e7g6EJAeqo/em07TO1a9xqnIiuaPJCKdmg9d3g==
X-Google-Smtp-Source: AA6agR4AF3yPp0P/SALlgk71eZu0DKygIWC/xmT4VMDlbJ/HyjpSsVqfLfwtl3GtFtZWNIL4A9L3PLCgtvtHFWjgHh0=
X-Received: by 2002:a05:6402:34cc:b0:451:62bf:c816 with SMTP id
 w12-20020a05640234cc00b0045162bfc816mr11520688edc.213.1663059277510; Tue, 13
 Sep 2022 01:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220909121329.42004-1-brgl@bgdev.pl> <20220909121329.42004-3-brgl@bgdev.pl>
 <YxykorLetCjAls/Z@sol> <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol> <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol>
In-Reply-To: <Yx/nG5YsyCa+VXoj@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Sep 2022 10:54:26 +0200
Message-ID: <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 4:12 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 11:56:17AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 12, 2022 at 11:53 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> >
> > [snip]
> >
> > > >
> > > > Using -1 sounds good but I've just realized there's a different
> > > > problem. A process holding a file descriptor may fork and both the
> > > > parent and the child will keep the same file descriptors open. Now
> > > > we'll have two processes (with different PIDs) holding the same GPIO
> > > > lines (specifically holding a file descriptor to the same anonymous
> > > > inode).
> > > >
> > > > This already poses a problem for this patch as we'd need to return an
> > > > array of PIDs which we don't have the space for but also is a
> > > > situation which we haven't discussed previously IIRC - two processes
> > > > keeping the same GPIO lines requested.
> > > >
> > > > I don't have any good idea on how to address this yet. One thing off
> > > > the top of my head is: close the parent's file descriptor from kernel
> > > > space (is it even possible?) on fork() (kind of like the close() on
> > > > exec flag).
> > > >
> > > > I need to think about it more.
> > > >
> > >
> > > I thought the O_CLOEXEC was set on the request fds exactly to prevent this
> > > case - only one process can hold the request fd.
> > >
> >
> > O_CLOEXEC means "close on exec" not "close on fork". When you fork,
> > you inherit all file descriptors from your parent. Only once you call
> > execve() are the fds with this flag closed *in the child*.
> >
>
> Ah, ok.
> You want to pass request fd ownership from parent to child??
> Why not lock ownership to the parent, so O_CLOFORK, were that
> available?
>

Because what if we want to request a line and then daemonize i.e. fork
and exit in parent? It makes much more sense to keep the lines
requested in the child IMO.

During the BoF at Linux Plumbers it was suggested to use
/proc/$PID/fdinfo to expose the information about which lines are
requested but I can't figure out a way to do it elegantly.

Bart
