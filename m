Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA96F29B6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjD3RBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjD3RBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:01:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03491BFF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 10:00:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f178da21afso9824845e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682874055; x=1685466055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rEb8H8B/LWBOL3d+EhV6uNZYH73cteqf72q/TSl80H0=;
        b=QiEzqhbEwa6FJbmP2RNnDYuCF/pY4M8eXeG754KPINc1KHoDlO2vl87hmoEtOQWH0b
         /4T5ZBS5wGDW7mXFhjlIZYJWSPAX8GHcq38s4jULvcxG5/ym3gVYn22gw3sP4CDdb6vH
         EFTqm6X9MfYu/9Sv9CBkn0rjN6gQ40DXXys+qtv3EgMDt46xsJjubdDf/CjyGduYAkuv
         f1dm7k1yzECRYZFRQo4gouMkPgFVw27Kf1QczRY0pdZdTthqBYF0hsyKDnPJT5+pPkOW
         98BJhw2A8Y7RXgi739NjoJkWwfR6x8xMcXlQxCuzy3jDzHQQf1CfeVs0/gRfEQN4WKFv
         yi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682874055; x=1685466055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEb8H8B/LWBOL3d+EhV6uNZYH73cteqf72q/TSl80H0=;
        b=YtNbJ5ocxdtYsdKUug45zb47BoUpVq1qy1iRyPFt0c4DXPWwPjZrdsNQtVt3j2yubw
         IkE1AGPJYv/yAPhS5el5J+o+6fRonV1G3AAe0yA145+cw5aj890I8zbye6ZZGMfCt2zY
         nykPJWvEIru2KS4eK8Y3LdZ00JZB/0q9Ps4okoECyNkvHlsVzHhCKu9+dngXOfURTeun
         ig2AtK8V1bHUE35Y79m09Tg++GJU81lvR8HNL1II2XKkza/qcKP7heA1VDQBGF/osD0w
         YM+sxjpQNOckOmCNkUjFXKhZS7MpwAdfUq4hqsd1pEIiB2mYuBiAypS8XcVEDG+sMgGN
         Qllw==
X-Gm-Message-State: AC+VfDzIeokf0Lca0gRqGpnbf0FNmbtx+BCgjq/qnGnbV6ZL/3aCuTe4
        IwWki/vqZV0naP54OeA0LQg=
X-Google-Smtp-Source: ACHHUZ687zXxnglRKN1Ic+eQJSwGZMAIKQkgH1sjziQ9VnUng0SRiPGnBdNUVseX1YPwfe6LuS+zbQ==
X-Received: by 2002:a05:600c:acf:b0:3ed:4b0f:5378 with SMTP id c15-20020a05600c0acf00b003ed4b0f5378mr8698065wmr.27.1682874054383;
        Sun, 30 Apr 2023 10:00:54 -0700 (PDT)
Received: from [192.168.0.65] (80.174.64.118.dyn.user.ono.com. [80.174.64.118])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm33416692wmp.5.2023.04.30.10.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 10:00:54 -0700 (PDT)
Message-ID: <9531fc38cfebb5b4587967f6ec73d983fd9325ce.camel@gmail.com>
Subject: Re: [PATCH v5 2/2] printk: console: Remove sysrq exception
From:   calumlikesapplepie@gmail.com
To:     Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com,
        mj@atrey.karlin.mff.cuni.cz
Date:   Sun, 30 Apr 2023 19:00:42 +0200
In-Reply-To: <ZEp9dXwHCYNPidjC@alley>
References: <cover.1682427812.git.chris@chrisdown.name>
         <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
         <ZEp9dXwHCYNPidjC@alley>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hullo! I'm a random college student; this is my first message to the
LKML, please don't be too mean!

On Thu, 2023-04-27 at 15:49 +0200, Petr Mladek wrote:
> On Tue 2023-04-25 14:06:26, Chris Down wrote:
> > Consoles can have vastly different latencies and throughputs. For
> > example, writing a message to the serial console can take on the order
> > of tens of milliseconds to get the UART to successfully write a message=
.
> > While this might be fine for a single, one-off message, this can cause
> > significant application-level stalls in situations where the kernel
> > writes large amounts of information to the console.
>=20
> > This means that while you might want to send at least INFO level
> > messages to (for example) netconsole, which is relatively fast, you may
> > only want to send at least WARN level messages to the serial console.
> > Such an implementation would permit debugging using the serial console
> > in cases that netconsole doesn't receive messages during particularly
> > bad system issues, while still keeping the noise low enough to avoid
> > inducing latency in userspace applications. This patch adds such an
> > interface, extending the existing console loglevel controls to allow
> > each console to have its own loglevel.

What I'm coming here to say isn't really perfectly relevant to this
goal, but it is related to the work you're doing to accomplish it.=20
Basically: sysrq interaction with the console is terrible, and is
causing problems for no good reasons as a result of being an edge case,
making me sad.  Details on why I am sad are in the next two paragraphs,
but you can just skip them.  In fact, I recommend it.

Yes, this email is the result of about two and a half hours of
dedicated procrastination right at the start of finals week. I blame
Steam for eating up all my RAM and swap to pre-cache Vulkan shaders,
whatever error handler froze my desktop after it did, kdump for
generating a nice crash report revealing that the sysrq's were
processed but that the OOM Killer was never invoked (despite a kworker
allocation failure), atopd for creating a log entry and proving the
system was alive and well after the freeze, and systemd-journald for
consuming 15% cpu in that entry but not actually syncing anything to
disk.

I suppose my decision to get said shaders ready for next week's jubilee
might be partly to blame.  Or my habit of running two browsers with a
few hundred tabs apeice, a CAD program, and a half-dozen other things
at the same time.  My assumption that sysrq headers print
unconditionally on all consoles means that they also probably count as
KERN_CRIT messages (which trigger an immediate journal sync) might not
have helped.  I suppose if I'd been more patient my system might have
either recovered or finally gotten the OOM killer out, and been
responsive.  And maybe if I'd known more sysrq's than 'emergency sync
to disk' and 'crash the kernel', or had chosen to trigger a mass SIGINT
rather than a crash, I wouldn't have embarked on this journey.

But really, I blame 1993 Linus Torvalids for coding up the sysrq
loglevel dance in the first place.

[snip]
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -101,12 +102,26 @@ __setup("sysrq_always_enabled",
> > sysrq_always_enabled_setup);
> > =C2=A0static void sysrq_handle_loglevel(int key)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int cookie;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int warned =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct console *con;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i =3D key - '0';
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0console_loglevel =3D CO=
NSOLE_LOGLEVEL_DEFAULT;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("Loglevel set t=
o %d\n", i);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0console_loglevel =3D i;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cookie =3D console_srcu_read=
_lock();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for_each_console_srcu(con) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!warned && per_console_loglevel_is_set(con)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0warned=
 =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_war=
n("Overriding per-console loglevel
> > from sysrq\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0con->level =3D -1;
>=20
> Please, use WRITE_ONCE(con->level, -1) to make sure that it will be
> atomic.
>=20
> READ_ONCE()/WRITE_ONCE() should always be used when the values
> are read/written using RCU synchronization. Otherwise the compiler
> might do some optimizations and read/write bytes separately.
>=20

I would argue we remove this whole logic, and just go to a nice and
simple printk at KERN_EMERG priority.  Why add interactions with the
SRCU subsystem in code that we need to run even in the event of some
massive SRCU bug?  This code will be both infrequently tested and make
a bad day worse if it's problematic.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0console_srcu_read_unlock(coo=
kie);
> > =C2=A0}
>=20
> Also we should safe/set/restore "ignore_per_console_loglevel"
> in __handle_sysrq(). It already does the same with
> "console_loglevel".
>=20
> __handle_sysrq() increases the loglevel to show all
> messages printed by the sysrq handler on all consoles.
> Many handlers print some information that might be useful
> for debugging.

Actually, it doesn't!  Be kinda cool if it did, but there is a
legitimate reason for it not to: some sysrq messages, like the list of
all processes in the system, are extremely long, and so you might want
to print them to a file but not every console.  Instead, it prints
exactly one message with the increased log level visibility: an info-
priority message that states the "action message" of the sysrq, before
returning to the default log level.

In other words: magic sysrq messages are printed to every console,
because they are deemed to be important emergencies that no user should
miss, even if they told the kernel it better be actively on fire if it
wants to talk.  Cool.  However, they are not marked as emergency
priority.  Instead, they're marked as info priority, but do a dance
with kernel log level to ensure they get printed everywhere.

Why?  See this thread, where they discuss adding the (kind-of vague)
comment that now exists in the code to indicate the reasoning.

https://lore.kernel.org/lkml/20090107123725.GC2520@shadowen.org/

Okay, so that explains why we do the song-and-dance only for the header
message. Still wondering why the printk at low priority?  They
acknowledge it as something weird, but don't talk about why.  So I dove
into git history, only to find that the log-level shifting code was
added with the initial import from bitkeeper.  And then that, while
there was a change to the file in the bitkeeper history, the log level
shifting code predates it.

Uh oh.

So lets go back to May 31st, 1997, when the version of sysrq.c that
makes it into the 2.1.43 kernel is written by Martin Mares.  Fun fact:
the email address he used then probably still works; I've added him to
the CC on this, since it was him who created the code.  And... yup.=20
The log level shifting code is there, complete with the same variable
names.  Sysrq.c does not exist in the previous kernel version.

https://mirrors.edge.kernel.org/pub/linux/kernel/v2.1/linux-2.1.43.tar.gz

No, I could not find the email where this patch was first submitted.=20
It may not exist on the internet; it certainly doesn't in the parts
where Google looks.

Now, printk did support priority levels at this point: without the
emails discussing the patch, therefore, it's impossible to say why
Martin decided all those years ago to use this technique.  It's
probably a moot point anyways.

The fact that sysrq messages behave in this way isn't well documented,
and is definitely harmful.  Users might (rightfully) assume that if
they set the log level to 1, they will not see any messages that are
not of EMERGENCY or ALERT priority.  If they program on that
assumption, however, a sysrq might break their code: it will be shown
on their console, but break whatever boolean they have looking at
priority.  The chance of that occurring will go up with these changes.

sysrq's behaving in this way, as info-level emergencies, is just weird.
No sane system uses a sysrq in normal running: its an awkward
interface, designed for use by a human, with pretty much all of the
keys causing some level of system-level disruption.  The stated reason
doesn't really make sense; why is it important enough to be shown on
every console, but not important enough to be seen as an emergency by
the computer?

If your system experiences a sysrq, either you have some weird backup
software that is using the wrong interface, or someone with extremely
privileged access to your system believes that there is something so
fundamentally wrong with your system that they need to bypass the
entirety of userspace and much of the kernel to get something done.=20
Either of those situations are at least as important as a typo in a
password for sudo; which is given a CRITICAL priority. =20

Lets not add a pile of code in order to maintain a behavior that no
sane userspace will be depending on, and which might even be causing
bugs in sane userspaces.  Like, for instance, systemd-journald deciding
not to write out journals when I instruct my kernel to do an emergency
sync.

>=20
> The following separate patches comes to my mind:
>=20
> 1. Fix printk_delay() call (already done, current 1st patch)
>=20
> 2. Pass @con instead of @is_extended/@may_schedule in
> =C2=A0=C2=A0 in printk_get_next_message().
>=20
> 3. Add con->level and the logic that will use it in printk(),
> =C2=A0=C2=A0 including console_effective_loglevel(). It will be
> =C2=A0=C2=A0 temporary initialized to -1 in register_console().
>=20
> 4. Add ignore_per_console_loglevel parameter, use it
> =C2=A0=C2=A0 in per_console_loglevel_is_set(), do_syslog(),
> =C2=A0=C2=A0 and __handle_sysrq().

In other words: sysrq's use of the printk subsystem in this way is
unique, and thus almost certainly a bad idea.

> 5. Add sysfs interface that would allow to set per-console
> =C2=A0=C2=A0 log level at runtime.
>=20
> 6. Add the command line interface that would allow to define
> =C2=A0=C2=A0 the console loglevel via console=3D parameter.
>=20
> 7. Update the sysctl interface.
>=20
