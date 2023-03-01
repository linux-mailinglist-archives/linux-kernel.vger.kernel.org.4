Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437346A71E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCARQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCARQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:16:21 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E278457E2;
        Wed,  1 Mar 2023 09:16:16 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-53916ab0c6bso376512797b3.7;
        Wed, 01 Mar 2023 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677690976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9WCdUIynZ4l/0p6xkKRE27CBUPF6O/p7oDS6Ydskqs=;
        b=QAOiPW4Tx9jiOhskdbxc9/Wk7jhIjiaQ4xsYg1WaxmWfyAi+MDPWClKrzO4FMVvqYS
         nchu5oTZWAwchbnvusaIXfuZAlMR4U4OxYnTQAcoC5m07KA1IVFmKu17UnyPn+pM3Gvg
         w2DL4uzeZTFlW9vgVCVUzmqll/4kj2AwbhhVQHDYvrWDFn9bH0h9FyhBYKFfs3KYDMNb
         0Jccrut42oLyS0+5O+VzH0s9YpXr9PBYmW9qyQy0x4ueebqMA7sAp5md7/G2EWnUaWk7
         63cjkZWqyHDNXmaCBrHCojEMSIyYoS4GpgxtvzvpsMe60UVZw9nYmLKqD89t5luZKa33
         CpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677690976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9WCdUIynZ4l/0p6xkKRE27CBUPF6O/p7oDS6Ydskqs=;
        b=oRXm3QG4Wi2m+YkmKepsj3gvnBQ9oYUgJvmGdfbHLoyFzk7jX5R1scMQFigUJYQxCH
         h4D983Oil0vonJ5zm4MOFd8dRAXHavaWTdcg3H5HF9CkWArIv39MrJY0DPoeT6v2djUy
         vH6v6+8vgscORXRvN8im/vIyOv9VhrWJQykcXkFxwAFzS4Ol1PUwdBpnXmWE5EnuudrF
         yAD9eGvdJ3KVVHRzEr83OnjMgCCWqzr1xqMfwRC5Ys08uHjXvrzAdL39NfPSmR4U8R9K
         nvYldQv4m9UQvXHSYxCYgJwTsxTbpW6QX2eyrH0dpJcjW6h9tT1pLnBcEiteJIRXkZOS
         LC8g==
X-Gm-Message-State: AO0yUKX2eRSCeGb+cx6C7XNUv+K3PFGtrjJdMWUNiXGMVROTo/b83YRd
        MFWLhSPrD7WFVxZW58YTH/0k7+SQEZPEhXmJ+7GWOq0vfO4=
X-Google-Smtp-Source: AK7set+Sqp+i5/hG8OnD205P7z0YlHz4qtx5XQKd7s41oZQUY0Tjt2jWOwRqmR7+rnsWOM8VRpK0iLPS3++fq1xMK5o=
X-Received: by 2002:a05:690c:681:b0:533:a15a:d33e with SMTP id
 bp1-20020a05690c068100b00533a15ad33emr15189923ywb.5.1677690975578; Wed, 01
 Mar 2023 09:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-4-ubizjak@gmail.com>
 <20230228164346.0691bb11@gandalf.local.home> <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
 <20230301111850.768f8526@gandalf.local.home>
In-Reply-To: <20230301111850.768f8526@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 18:16:04 +0100
Message-ID: <CAFULd4YePGAqxpq0kJMnNHkqqkL9HEnEz1ud9kNrae5wqpRVbA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:18=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 1 Mar 2023 10:37:28 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > > No, val should not be updated.
> >
> > Please see the definition of try_cmpxchg. The definition is written in
> > such a way that benefits loops as well as linear code and in the later
> > case depends on the compiler to eliminate assignment to val as a dead
> > assignment.
>
> I did read it ;-)
>
> >
> > The above change was done under the assumption that val is unused
> > after try_cmpxchg, and can be considered as a temporary
> > [Alternatively, the value could be copied to a local temporary and a
> > pointer to this local temporary could be passed to try_cmpxchg
> > instead. Compiler is smart enough to eliminate the assignment in any
> > case.]
> >
> > Even in the linear code, the change has considerable effect.
> > rb_head_page_replace is inlined in rb_get_reader_page and gcc-10.3.1
> > improves code from:
> >
> >      ef8:    48 8b 0e                 mov    (%rsi),%rcx
> >      efb:    48 83 e1 fc              and    $0xfffffffffffffffc,%rcx
> >      eff:    48 83 c9 01              or     $0x1,%rcx
> >      f03:    48 89 c8                 mov    %rcx,%rax
> >      f06:    f0 48 0f b1 3e           lock cmpxchg %rdi,(%rsi)
> >      f0b:    48 39 c1                 cmp    %rax,%rcx
> >      f0e:    74 3b                    je     f4b <rb_get_reader_page+0x=
13b>
> >
> > to:
> >
> >      ed8:    48 8b 01                 mov    (%rcx),%rax
> >      edb:    48 83 e0 fc              and    $0xfffffffffffffffc,%rax
> >      edf:    48 83 c8 01              or     $0x1,%rax
> >      ee3:    f0 48 0f b1 31           lock cmpxchg %rsi,(%rcx)
> >      ee8:    74 3b                    je     f25 <rb_get_reader_page+0x=
135>
>
> I'm using gcc 12.2.0 and have this;
>
> cmpxchg:
>
> 0000000000000e50 <rb_get_reader_page>:
>      e50:       41 55                   push   %r13
>      e52:       41 54                   push   %r12
>      e54:       55                      push   %rbp
>      e55:       53                      push   %rbx
>      e56:       48 89 fb                mov    %rdi,%rbx
>      e59:       9c                      pushf
>      e5a:       5d                      pop    %rbp
>      e5b:       fa                      cli
>      e5c:       81 e5 00 02 00 00       and    $0x200,%ebp
>      e62:       0f 85 e6 01 00 00       jne    104e <rb_get_reader_page+0=
x1fe>
>      e68:       48 8d 7b 1c             lea    0x1c(%rbx),%rdi
>      e6c:       31 c0                   xor    %eax,%eax
>      e6e:       ba 01 00 00 00          mov    $0x1,%edx
>      e73:       f0 0f b1 53 1c          lock cmpxchg %edx,0x1c(%rbx)
>      e78:       0f 85 e5 01 00 00       jne    1063 <rb_get_reader_page+0=
x213>
>      e7e:       41 bc 03 00 00 00       mov    $0x3,%r12d
>      e84:       4c 8b 6b 58             mov    0x58(%rbx),%r13
>      e88:       49 8b 55 30             mov    0x30(%r13),%rdx
>      e8c:       41 8b 45 18             mov    0x18(%r13),%eax
>      e90:       48 8b 4a 08             mov    0x8(%rdx),%rcx
>      e94:       39 c8                   cmp    %ecx,%eax
>      e96:       0f 82 61 01 00 00       jb     ffd <rb_get_reader_page+0x=
1ad>
>      e9c:       48 8b 52 08             mov    0x8(%rdx),%rdx
>
>
> try_cmpxchg:
>
> 0000000000000e70 <rb_get_reader_page>:
>      e70:       41 55                   push   %r13
>      e72:       41 54                   push   %r12
>      e74:       55                      push   %rbp
>      e75:       53                      push   %rbx
>      e76:       48 89 fb                mov    %rdi,%rbx
>      e79:       9c                      pushf
>      e7a:       5d                      pop    %rbp
>      e7b:       fa                      cli
>      e7c:       81 e5 00 02 00 00       and    $0x200,%ebp
>      e82:       0f 85 e0 01 00 00       jne    1068 <rb_get_reader_page+0=
x1f8>
>      e88:       48 8d 7b 1c             lea    0x1c(%rbx),%rdi
>      e8c:       31 c0                   xor    %eax,%eax
>      e8e:       ba 01 00 00 00          mov    $0x1,%edx
>      e93:       f0 0f b1 53 1c          lock cmpxchg %edx,0x1c(%rbx)
>      e98:       0f 85 df 01 00 00       jne    107d <rb_get_reader_page+0=
x20d>
>      e9e:       41 bc 03 00 00 00       mov    $0x3,%r12d
>      ea4:       4c 8b 6b 58             mov    0x58(%rbx),%r13
>      ea8:       49 8b 55 30             mov    0x30(%r13),%rdx
>      eac:       41 8b 45 18             mov    0x18(%r13),%eax
>      eb0:       48 8b 4a 08             mov    0x8(%rdx),%rcx
>      eb4:       39 c8                   cmp    %ecx,%eax
>      eb6:       0f 82 5b 01 00 00       jb     1017 <rb_get_reader_page+0=
x1a7>
>      ebc:       48 8b 52 08             mov    0x8(%rdx),%rdx
>
> Which has no difference :-/

This lock cmpxchg belongs to some other locking primitive that were
already converted en masse to try_cmpxchg some time in the past. The
place we are looking for has a compare insn between lock cmpxchg and a
follow-up conditional jump in the original assembly code.

> > Again, even in linear code the change is able to eliminate the
> > assignment to a temporary reg and the compare. Please note that there
> > is no move *from* %rax register after cmpxchg, so the compiler
> > correctly eliminated unused assignment.
> >
> > >
> > > >  }
> > > >
> > > >  /*
> > > > @@ -2055,7 +2052,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *c=
pu_buffer)
> > > >       retries =3D 10;
> > > >       success =3D false;
> > > >       while (retries--) {
> > > > -             struct list_head *head_page, *prev_page, *r;
> > > > +             struct list_head *head_page, *prev_page;
> > > >               struct list_head *last_page, *first_page;
> > > >               struct list_head *head_page_with_bit;
> > > >
> > > > @@ -2073,9 +2070,8 @@ rb_insert_pages(struct ring_buffer_per_cpu *c=
pu_buffer)
> > > >               last_page->next =3D head_page_with_bit;
> > > >               first_page->prev =3D prev_page;
> > > >
> > > > -             r =3D cmpxchg(&prev_page->next, head_page_with_bit, f=
irst_page);
> > > > -
> > > > -             if (r =3D=3D head_page_with_bit) {
> > > > +             if (try_cmpxchg(&prev_page->next,
> > > > +                             &head_page_with_bit, first_page)) {
> > >
> > > No. head_page_with_bit should not be updated.
> >
> > As above, head_page_with_bit should be considered as a temporary, it
> > is initialized a couple of lines above cmpxchg and unused after. The
> > gcc-10.3.1 compiler even found some more optimization opportunities
> > and reordered the code from:
> >
> >     1364:    4d 8b 86 38 01 00 00     mov    0x138(%r14),%r8
> >     136b:    48 83 ce 01              or     $0x1,%rsi
> >     136f:    48 89 f0                 mov    %rsi,%rax
> >     1372:    49 89 30                 mov    %rsi,(%r8)
> >     1375:    48 89 4f 08              mov    %rcx,0x8(%rdi)
> >     1379:    f0 48 0f b1 39           lock cmpxchg %rdi,(%rcx)
> >     137e:    48 39 c6                 cmp    %rax,%rsi
> >     1381:    74 78                    je     13fb <rb_insert_pages+0xdb=
>
> >
> > to:
> >
> >     1343:    48 83 c8 01              or     $0x1,%rax
> >     1347:    48 8b bb 38 01 00 00     mov    0x138(%rbx),%rdi
> >     134e:    48 89 07                 mov    %rax,(%rdi)
> >     1351:    48 89 4e 08              mov    %rcx,0x8(%rsi)
> >     1355:    f0 48 0f b1 31           lock cmpxchg %rsi,(%rcx)
> >     135a:    41 0f 94 c7              sete   %r15b
> >     135e:    75 2f                    jne    138f <rb_insert_pages+0x8f=
>
> >
> > Please also note SETE insn in the above code, this is how the
> > "success" variable is handled in the loop. So, besides code size
> > improvement, other secondary improvements can be expected from the
> > change, too.
>
> For this gcc 12.2.0 did have a different result:
>
> cmpxchg:
>
>     1436:       49 89 c5                mov    %rax,%r13
>     1439:       eb 41                   jmp    147c <rb_update_pages+0x7c=
>
>     143b:       48 89 df                mov    %rbx,%rdi
>     143e:       e8 bd ed ff ff          call   200 <rb_set_head_page>
>     1443:       48 89 c2                mov    %rax,%rdx
>     1446:       48 85 c0                test   %rax,%rax
>     1449:       74 37                   je     1482 <rb_update_pages+0x82=
>
>     144b:       48 8b 48 08             mov    0x8(%rax),%rcx
>     144f:       48 8b bb 30 01 00 00    mov    0x130(%rbx),%rdi
>     1456:       48 89 c6                mov    %rax,%rsi
>     1459:       4c 8b 83 38 01 00 00    mov    0x138(%rbx),%r8
>     1460:       48 83 ce 01             or     $0x1,%rsi
>     1464:       48 89 f0                mov    %rsi,%rax
>     1467:       49 89 30                mov    %rsi,(%r8)
>     146a:       48 89 4f 08             mov    %rcx,0x8(%rdi)
>     146e:       f0 48 0f b1 39          lock cmpxchg %rdi,(%rcx)
>     1473:       48 39 c6                cmp    %rax,%rsi
>     1476:       0f 84 97 01 00 00       je     1613 <rb_update_pages+0x21=
3>
>     147c:       41 83 ee 01             sub    $0x1,%r14d
>     1480:       75 b9                   jne    143b <rb_update_pages+0x3b=
>
>     1482:       48 8b 43 10             mov    0x10(%rbx),%rax
>     1486:       f0 ff 40 08             lock incl 0x8(%rax)
>
> try_cmpxchg:
>
>     1446:       49 89 c4                mov    %rax,%r12
>     1449:       41 83 ee 01             sub    $0x1,%r14d
>     144d:       0f 84 7b 01 00 00       je     15ce <rb_update_pages+0x1b=
e>
>     1453:       48 89 df                mov    %rbx,%rdi
>     1456:       e8 c5 ed ff ff          call   220 <rb_set_head_page>
>     145b:       48 89 c2                mov    %rax,%rdx
>     145e:       48 85 c0                test   %rax,%rax
>     1461:       0f 84 67 01 00 00       je     15ce <rb_update_pages+0x1b=
e>
>     1467:       48 8b 48 08             mov    0x8(%rax),%rcx
>     146b:       48 8b b3 30 01 00 00    mov    0x130(%rbx),%rsi
>     1472:       48 83 c8 01             or     $0x1,%rax
>     1476:       48 8b bb 38 01 00 00    mov    0x138(%rbx),%rdi
>     147d:       48 89 07                mov    %rax,(%rdi)
>     1480:       48 89 4e 08             mov    %rcx,0x8(%rsi)
>     1484:       f0 48 0f b1 31          lock cmpxchg %rsi,(%rcx)
>     1489:       75 be                   jne    1449 <rb_update_pages+0x39=
>
>     148b:       48 89 7a 08             mov    %rdi,0x8(%rdx)
>     148f:       4c 89 e6                mov    %r12,%rsi
>     1492:       48 89 ef                mov    %rbp,%rdi
>     1495:       4c 89 ab 30 01 00 00    mov    %r13,0x130(%rbx)
>     149c:       4c 89 ab 38 01 00 00    mov    %r13,0x138(%rbx)
>     14a3:       e8 00 00 00 00          call   14a8 <rb_update_pages+0x98=
>
>
> It's different, but I'm not so sure it's beneficial.

This is the place we are looking for. Please see that a move at $1464
and a compare at $1473 is missing in the assembly from the patched
code. If it is beneficial ... well, we achieved the same result with
two instructions less in a loopy code.

Uros.

> >
> > I think that the above examples demonstrate various improvements that
> > can be achieved with effectively a one-line, almost mechanical change
> > to the code, even in linear code. It would be unfortunate to not
> > consider them.
>
> But with gcc 12.2.0 I don't really see the benefit. And I'm worried that
> the side effect of modifying the old variable could cause a bug in the
> future, if it is used after the try_cmpxchg(). At least for the second ca=
se.
>
> -- Steve
>
