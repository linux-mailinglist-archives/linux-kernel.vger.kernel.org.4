Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4261F60E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiKGOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiKGO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:29:51 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A109201B8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:25:28 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 131so9387131ybl.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oboWyf02L04GWiqbRTZkWaKzcVjcV8xl9eLiAMUj/TI=;
        b=LdnEeXZkxBrQg9Ms96uDBWkmElXhDznOcnELRv2Ey5Qwll0tTlJBePAmkt5+/Bbgqp
         q7gWl5N2Ha+HWWYHMbnqhcUvL9V3lNfkloK5KP2RdfxwmNn8IDDePW8A2e0yAMQ0+00d
         8FAkRtjvCegWhjpi/bd+oMzdEMxLWGT0xG0KM098sa5nadSYtYZ3NC/p4zDg8+eT2eD7
         wZaUu/5z2aHRkzozSD5CIWAOb0PuNPPcP1HU3/04D7VQVHELTnERd4sovNIz1KIEEwGl
         Et0KI5ry9O5LyqrPLnuNo36Cg7rEWhj1L5GUcL6HCr182XnTrdq9vADERKTXKSsMaNsK
         7h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oboWyf02L04GWiqbRTZkWaKzcVjcV8xl9eLiAMUj/TI=;
        b=zR8YHB6RLjDogzWT73VFqadKBdd1fEt0rvZzgASTcdxJUYsswuj2S1RkC483nXIukQ
         WzFqDK4kfJq7tb4miZXrWhfz8StnX0cYL7fvckM+Boo6Yh71Cc/BS1wXNUYIshBqSfYf
         lCaQqciog606fb+ZNj0GDkCql/VmSt7+mkrt8x4nSZS6Fy/QzqiZ2ocuw6x/KoQEf3L+
         ClARZIdJfeyLv2aBSqy0x9xLp8XVNSCeM6QdxNEiaG0Ag9XLvZN6jyKYAT12HbmowmlK
         JhrG4vLC/Crw47Pz8p44hBBkes6pV6LNzpuY1ZhaGIiN+m3Z/9ypcFXQ8q94GvMRbK5E
         QeRw==
X-Gm-Message-State: ACrzQf1B9xMy90ULXC+/b4rwui8Dr+WVaucCDi3bQYiDf7OaObRicBXa
        dEVKjkkK7DqQ3jgt9xQ3isq/0ztUlKlFjX57+alIYA==
X-Google-Smtp-Source: AMsMyM7Mom0FLlg17x5LYT6YE5L4ZOZDJwMsDDGTbFczWdDPz7zdoi3jn/lnW2YZ3cWVNAW1AOW75h9ViiPgOjuZAEk=
X-Received: by 2002:a25:9b43:0:b0:6b3:9cc2:a651 with SMTP id
 u3-20020a259b43000000b006b39cc2a651mr47557091ybo.485.1667831127440; Mon, 07
 Nov 2022 06:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com> <20220905122452.2258262-7-glider@google.com>
 <Yxa6Isgcii+EQWwX@debian.me>
In-Reply-To: <Yxa6Isgcii+EQWwX@debian.me>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 7 Nov 2022 15:24:50 +0100
Message-ID: <CAG_fn=VXR0FGoJZ5BonxiFd7Wr3LX1hfF7PRRfm1=26B5v7vMA@mail.gmail.com>
Subject: Re: [PATCH v6 6/44] kmsan: add ReST documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 5:10 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>

Uh-oh, somehow missed this letter during the review process.

> > +  CPU: 0 PID: 6731 Comm: kunit_try_catch Tainted: G    B       E     5=
.16.0-rc3+ #104
> > +  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2=
 04/01/2014
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Are these table markers in the code block above part of kmsan output?

Correct.

>
> > +A use of uninitialized value ``v`` is reported by KMSAN in the followi=
ng cases:
> > + - in a condition, e.g. ``if (v) { ... }``;
> > + - in an indexing or pointer dereferencing, e.g. ``array[v]`` or ``*v`=
`;
> > + - when it is copied to userspace or hardware, e.g. ``copy_to_user(...=
, &v, ...)``;
> > + - when it is passed as an argument to a function, and
> > +   ``CONFIG_KMSAN_CHECK_PARAM_RETVAL`` is enabled (see below).
>
> The sentence before the list above is rendered as definition list term
> instead, so I add the blank line separator:
>
> ---- >8 ----
>
> diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/=
kmsan.rst
> index 2a53a801198cbf..55fa82212eb255 100644
> --- a/Documentation/dev-tools/kmsan.rst
> +++ b/Documentation/dev-tools/kmsan.rst
> @@ -67,6 +67,7 @@ uninitialized in the local variable, as well as the sta=
ck where the value was
>  copied to another memory location before use.
>
>  A use of uninitialized value ``v`` is reported by KMSAN in the following=
 cases:
> +
>   - in a condition, e.g. ``if (v) { ... }``;
>   - in an indexing or pointer dereferencing, e.g. ``array[v]`` or ``*v``;
>   - when it is copied to userspace or hardware, e.g. ``copy_to_user(..., =
&v, ...)``;

Nice catch, thank you! Sent a patch to fix this.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
