Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE3713397
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjE0JSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjE0JR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:17:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA04E3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 02:17:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2564ebd8590so213215a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685179077; x=1687771077;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwvqDsA0yK19AN6rNxLoPkXbE7dFfuGJypm+fMnR6Fk=;
        b=sNF4j0qYA+lr/l8SMlzqWuCcB/f6aervd9IYdBGhL83MK1rxwr8jd0VYLLQywNdPxG
         p3u1f8zOieMyQKOv99XVaImzZPIgaujqPhDniFyYxbxaa3OVD+0HxUfz7B7W/71Dvh7S
         R3m7mMzBwqNMYnHOn6xPJhtTUbZlBAhG/RQS+VKYzqTpOfydkLTKwqK6Nu1baPwPBw/M
         aILL0okXmad6IDPLb3OjCiKsoEc69zp1IeoG3CG4F6qoSuo7kicUL0a1LRAMlXtOrZrb
         UmjaA2+DPgR6WdIQxp6xujOHkdz+FJh/I/LXwHikSTzMjlZQtpJE6NBCIFTvm1DRak1f
         ZgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685179077; x=1687771077;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwvqDsA0yK19AN6rNxLoPkXbE7dFfuGJypm+fMnR6Fk=;
        b=kftj/90FWWpZioMRQsL6PeXVLa0jqcxzXwMC40sanceDVn3+El3lxNIjB2rbz7KobN
         /0QsfTGlmkVM6MrtmbR9ecZdMN73ZcmoZNv6ecANPbCiSuoRV4JE3VwMEvdiGw91v1nb
         QljY7e5Rsd3v3EqBRTaKLWZUnrGBFNkYVd0UCLYmvqsbdP7pNo8XBTq96Zvhj2dwYAuo
         X2OMQVJRqad51y+zOc2JlQRxsHd6GC4pN9gfwb535apnYqcoNtZHKlh8f4893QF8h9sV
         NlpS903BbAJsBk1uCUF6TvoPgP5yNzHja/ReidNShBd9LoP92zzaYiJs5yC17/DCcr/M
         xvJw==
X-Gm-Message-State: AC+VfDw1B/T7O1DCw1gT2lvKa4gCrI3TdfGcQ2NtI8TdbathDYym6HYW
        uuLlcUgmCmAdXYevRFNk/FK3Zr6JHO0=
X-Google-Smtp-Source: ACHHUZ5GWl1XWrjQSkfUxvNuZpk0PPwf3//7HXBx/hdCwnt9I3b/0QX6kOf2Ppj1AynWMNW+eXmJmQ==
X-Received: by 2002:a17:90a:7407:b0:256:3f49:a172 with SMTP id a7-20020a17090a740700b002563f49a172mr3060072pjg.14.1685179076778;
        Sat, 27 May 2023 02:17:56 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id jx8-20020a17090b46c800b002501d678cacsm5660351pjb.40.2023.05.27.02.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 02:17:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230527072338.GAZHGv+no2LZASyLWM@nazgul.local>
Date:   Sat, 27 May 2023 02:17:43 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A302EB1-308A-4904-801C-DC70D9908E11@gmail.com>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
 <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
 <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
 <49861038-B8CA-4CDD-BD44-73066FF453F3@gmail.com>
 <20230527072338.GAZHGv+no2LZASyLWM@nazgul.local>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 27, 2023, at 12:23 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Fri, May 26, 2023 at 02:55:21PM -0700, Nadav Amit wrote:
>> So my tool takes a branch trace and then simulates the code =
execution.
>> As a preparatory step I need to disassemble the code, yet as I do not
>> know where the symbol starts and its size, I can only disassemble one
>> instruction at a time. [ I prefer to disassemble the whole symbol at =
once
>=20
> So in this particular case, the exception handling ends up being part =
of
> __get_user_nocheck_8, see the end of this mail.

That=E2=80=99s not according to the symbol table - that=E2=80=99s in =
your mind.

Anyhow, the argument that __get_user_nocheck_8 and bad_get_user_clac are
related makes no sense even conceptually.

__get_user_nocheck_8 jumps in the case of an exception to =
bad_get_user_8_clac,
not to bad_get_user_clac. So even conceptually this notion that these =
two
symbols are connected makes no sense.

>=20
> However, the symbol table says it is of size 19:
>=20
> 123630: ffffffff81b89310    19 FUNC    GLOBAL DEFAULT    1 =
__get_user_nocheck_8
>=20
> which means the trailing exception handling is not part of that symbol
> when looking at the size. And that's where your tool fails.
>=20
> Close?

Some people would even say =E2=80=9Celementary=E2=80=9D. I was sure it =
was already clear.

>=20
> And if so, your tool could simply look at the next symbol's address =
and
> attribute the trailing bytes to the previous symbol.
>=20
> If you look at the disassembly at the end, some other option has added
> INT3 padding to the end of the symbol so that the next one is aligned.
> But you can simply skip over those 0xcc insn bytes.
>=20
> And skipping over those 0xcc bytes is something your tool needs to
> handle anyway because they're not part of the symbol either.

I appreciate your help, but I have reasonable workarounds for my =
use-case
(and for the record, no, I don=E2=80=99t think that this solution that =
you
propose is reasonable).

>=20
>> These are only 2 things that break to one extent or another. I can
>> have workarounds for them (I already do). I just see no reason to
>> treat these two symbols differently.
>=20
> Right, the kernel should not dance just because some tool says so. And
> every time a new tool pops up, there are patches to "fix" the kernel.

It is not =E2=80=9Ca new tool". You screw up every tool that tries to =
understand
the context of an instruction pointer - gdb (that people use to debug
VMs) and probably perf, crash, drgn and many others.

>=20
>> I seriously see no downside
>=20
> The downside is polluting the symbol table unnecessarily. If it =
doesn't
> have to be there then it shouldn't be.

That=E2=80=99s a tautology, not a downside. And it is not =
=E2=80=9Cunnecessarily=E2=80=9D if it
helps debugging and profiling.

>=20
> And yeah yeah, this particular case can be fixed easily but the bigger
> issue remains: we have a lot of local symbols which get discarded =
around
> the tree. Does that mean that because your tool cannot handle that, we
> have to stop using local symbols?

All the other local symbols are irrelevant to the discussion as they =
fall
within some other symbol's range.

>=20
> What happens if we do something else weird in the future and your tool
> breaks again?
>=20
> Also, why can't your tool handle such cases gracefully instead of =
having
> to "fix" the kernel each time?

As I stated multiple times (which are even quoted in this email): I=20
have a workaround.

You are not (not) helping me. I am trying to help you (and other users).
The kernel right now messes up with people's debugging and profiling
tools.

So allow me to rehash, since I thought that we have already agreed on
the details of the problem, but I see again that various arguments are
although they are either incorrect or not relevant for this discussion:

1. It is *not* about global symbols. It is just about exposing symbols.

2. It is *not* about symbols that fall within other symbols. Therefore,
   all the other local symbols you grep=E2=80=99d are irrelevant for =
this
   discussion.

3. There are exactly 2 symbols we discuss (SYM_CODE_START_LOCAL + .L).

4. These 2 cases are the only ones that I know of in which code address
   does not fall into any symbol.

5. It is not about =E2=80=9Cmy tool=E2=80=9D. It is about gdb (think =
about people debug
   their VMs), perf and most likely crash, drgn, and others.


Now, as for your question =E2=80=9Cwhat happens if we do something else =
weird=E2=80=9D:

If a tool relies on internal kernel data structures, it=E2=80=99s its =
own problem.
But if you decide to do =E2=80=9Csomething else weird=E2=80=9D with =
standard executable
data structures - such as DWARF or symbol table - you mess up with=20
debuggers and profilers.

So just don=E2=80=99t do such weird things.=
