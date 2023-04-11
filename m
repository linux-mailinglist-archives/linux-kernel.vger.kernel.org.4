Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFED6DDE03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDKOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDKOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:32:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA31981
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:32:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d186so3180032iog.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681223540; x=1683815540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbpEWveBG2I0CTmK902pM8YaMqnSQhgzNkbVkE7Calc=;
        b=j6r0Zi+xfC3kM6Agakf0WfyHZHYaiKgv1qUqype/4ePgVcSQ5mCWjcfnJRa9TtEF21
         BJVaifjL17ZTwLhEKIvdmWrhOK0W7HOwxDbYWD8T71NTA9R5FqhBEdxmRDue10KJCLe/
         URuDJkEGPx398+3lTBQNI9hDImHW2VCSxUUhivnasVz9cyMEKa94LvPnFKOWiB/Eo4vn
         RyNMbcsH+NuZ14Nd1b50bRLALp5u17vxUgVVrDRFpEg3xkS87sSzUspO8G7SliUIU/Go
         VZ3fNwh0p7z5X4Hvl4W546UUsKtZmdysooYL6/GzakjOEb3vWKMCsxvUfZ5KmNQzzHil
         Eotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223540; x=1683815540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbpEWveBG2I0CTmK902pM8YaMqnSQhgzNkbVkE7Calc=;
        b=2/HPaO3VamGlvsTkKBhvQy/5Nd6zyrTk5ItE+YW9ht23eHzBJlxWtuqvJzVoqkb0U+
         Ag4uXGLYnp0LqEx3vw6Is97bxsfZRZNZDH7Q7Ejo2ypyddxqY8a30/7wd3bykBveW7zI
         MHeQx8jN/wI/1mHIuPeZj1P8B0kSiIM5TCEOToCgup6LvQg0CIw7sBTw7vWglVy76vO5
         /wo6g6u0QvLAKzQkKq71o3iawR5D1XCgGGS45rqtMHxpZb8TdFR+FEFOnMiX/88A337t
         Iiflb+qMSFtEYd/3xXStz77+MbmkBf2iNdIrUFPIF3h8q+J8TYo9Ou2FC7tSHtmcRsGd
         PsYg==
X-Gm-Message-State: AAQBX9fkUYHZLmOIn9ICnhiVy01TJVHhE+jCy7APZbDc2cWRsRO5kLsO
        ZbvbVAXQB6GypDgoPHHeQRh+tqZdoQKrA+qWOVJ8Zw==
X-Google-Smtp-Source: AKy350awUjNVkqsbhM5MHcJZvszMnA8NcvaKDYwPRC/3cDU8L1RtfHxOnylxzm23XAZY0MBrn/E8Hc4mmk9YZbdPbwI=
X-Received: by 2002:a5d:8615:0:b0:704:b905:e652 with SMTP id
 f21-20020a5d8615000000b00704b905e652mr2136756iol.11.1681223540018; Tue, 11
 Apr 2023 07:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <87h6tsred7.ffs@tglx> <874jpsqdy1.ffs@tglx> <ZDADdMnY0oW2k5BV@lothringen>
 <87lej3twhv.ffs@tglx> <ZDBin2ZQwc69hGX4@lothringen> <87ile7trv7.ffs@tglx>
In-Reply-To: <87ile7trv7.ffs@tglx>
From:   Marco Elver <elver@google.com>
Date:   Tue, 11 Apr 2023 16:31:41 +0200
Message-ID: <CANpmjNOFxGa6iuVbzVcXPyWO-6Zmd=edhatmDBHPKcZ-au35dg@mail.gmail.com>
Subject: Re: WARNING in timer_wait_running
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 at 21:27, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Apr 07 2023 at 20:36, Frederic Weisbecker wrote:
>
> > On Fri, Apr 07, 2023 at 07:47:40PM +0200, Thomas Gleixner wrote:
> >> On Fri, Apr 07 2023 at 13:50, Frederic Weisbecker wrote:
> >> > On Fri, Apr 07, 2023 at 10:44:22AM +0200, Thomas Gleixner wrote:
> >> >> Now memory came back. The problem with posix CPU timers is that it is
> >> >> not really known to the other side which task is actually doing the
> >> >> expiry. For process wide timers this could be any task in the process.
> >> >>
> >> >> For hrtimers this works because the expiring context is known.
> >> >
> >> > So if posix_cpu_timer_del() were to clear ctmr->pid to NULL and then
> >> > delay put_pid() with RCU, we could retrieve that information without
> >> > holding the timer lock (with appropriate RCU accesses all around).
> >>
> >> No, you can't. This only gives you the process, but the expiry might run
> >> on any task of that. To make that work you need a mutex in sighand.
> >
> > Duh right missed that. Ok will try.
>
> But that's nasty as well as this can race against exec/exit and you can't
> hold sighand lock when acquiring the mutex.
>
> The mutex needs to be per task and held by the task which runs the
> expiry task work.
>
> Something like the completely untested below. You get the idea though.

I threw the existing reproducer at this, and it seems happy enough -
no warnings nor lockdep splats either.

Thanks,
-- Marco
