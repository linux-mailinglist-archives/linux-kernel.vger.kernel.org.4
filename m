Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29A677EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjAWPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjAWPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:04:57 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A1A3ABA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:04:56 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5063029246dso7558787b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pjfHLMmBjNY6T/mBZSnp+2P1707+ePDiok6c2uTdrk=;
        b=EFcmRXddnK3Uvd27jzqlfFpQB2mja0UqUQDtbRoqd98tvU5/GOw9qX1T8+DKWoEX0/
         aLJ54Sg9xHf6gl4P1x1h4hHNMO66SHMKMh1iFSiR+SpcX17DsP7LY4UDczaY6J4igXed
         tNZ8HCYx+Bs9MUAhwEJcGEBUvWUdPRP94xmA4zN2PAtZJE1yKtrVb8CfXLo3DYWD4slf
         ccFLYRU6qU+TQHbFaTf8jNsoqpkqZil9viWvtvodfdvG/DiCHKqf5+YN09eCtFOVdSwy
         ZKmHTkXDJ30CxiOgWXNQ3VUxcvlyNTa+A9QCu2/Eq25HB+jjAGfCmUVjgPKKiqJVwP9e
         d0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pjfHLMmBjNY6T/mBZSnp+2P1707+ePDiok6c2uTdrk=;
        b=Lm/0O/H22FW4b60DgjayJFW3jwBIDMXML5VLNo3Ry7WoUHLYUsBsoMFy8xPQf8H2z6
         1Dckqru30C87CxYe4RKeRcWE8gaSCiHrjqkhRFB0qjLUnvvIlpBkTw+0Y/mJyYrK6x0I
         kw2fP8U+WGikGHYbrVL5/Q0g/RANTaFTJLlWAhBltCByfjdIlw5ukVaG7+ELi6FJ7TC7
         efKP3uOnr5nIjCB0DX7KN/TeKKKi1+IryRDkgxzqCzYjOA+YOoXuEmH+MxXLEdUEk0Vk
         cZ4ySYtYEWQO2Kq4fH2i7nrJSho60isYwjEJq6ExLD8I6wr9UFIsFqluat3FVPZgFR3f
         koIg==
X-Gm-Message-State: AFqh2kpXQGbAzR7OlAzFlB1vdC0ZoulLNBsQ0y9pnRJsLCGyZUPoRBYJ
        JIS2R+OU6+z8XgpAlKKAeSsPOKc8DQg/e/p0aPU=
X-Google-Smtp-Source: AMrXdXuMkHxZzw+uaVePcjgZjXlHuhOnTkyG7C3h/BaggOkywUOMaV5/i5UlFpDKxOOC0nGgSdSH6C6hvlobFK78kd4=
X-Received: by 2002:a81:690b:0:b0:4fa:906d:b925 with SMTP id
 e11-20020a81690b000000b004fa906db925mr1805642ywc.69.1674486295555; Mon, 23
 Jan 2023 07:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com> <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com>
In-Reply-To: <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 23 Jan 2023 16:04:43 +0100
Message-ID: <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Jan 19, 2023 at 1:47 PM David Laight <David.Laight@aculab.com> wrot=
e:
>
> > BTW: Recently, it was determined [1] that the usage of cpu_relax()
> > inside the cmpxchg loop can be harmful for performance. We actually
> > have the same situation here, so perhaps cpu_relax() should be removed
> > in the same way it was removed from the lockref.
>
> I'm not sure you can ever want a cpu_relax() in a loop that
> is implementing an atomic operation.
> Even the ia64 (die...) issue was with a loop that was waiting
> for another cpu to change the location (eg a spinlock).
>
> For an atomic operation an immediate retry is likely to succeed.
> Any kind of deferral to an another cpu can only make it worse.
>
> Clearly if you have 100s of cpu looping doing atomic operation
> on the same cache line it is likely that some get starved.
> But to fix that you need to increase the time between successful
> operations, not delay on failure.

I would like to point out that the wikipedia article on
compare-and-swap claims [1] that:

Instead of immediately retrying after a CAS operation fails,
researchers have found that total system performance can be improved
in multiprocessor systems=E2=80=94where many threads constantly update some
particular shared variable=E2=80=94if threads that see their CAS fail use
exponential backoff=E2=80=94in other words, wait a little before retrying t=
he
CAS [2].

[1] https://en.wikipedia.org/wiki/Compare-and-swap#Overview
[2] https://arxiv.org/pdf/1305.5800.pdf

Uros.
