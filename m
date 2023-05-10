Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212146FE80E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjEJXVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEJXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:21:06 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA9211C;
        Wed, 10 May 2023 16:21:05 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61a80fcc4c9so36487956d6.2;
        Wed, 10 May 2023 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683760864; x=1686352864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffPJ36adGh8uykiqGm+Ey1/eCjuKTv/sqWzbZCfRdDI=;
        b=S7hOLkYVCWVG5PMBbtuHycDhHI6kEnt0fLdUg3EwKYSCqk5sITaFuUBnhndWwjCCCa
         pLNWcTIvvkJ/2mm81GmcMnLtYqNqh/GJ2hNiBNk89WWf1iKmYTOzDu3FbzuZZ7JcUyAN
         yDdI65FSMjnyuzruMDSPp0QKNlT+/pps1oKcw7hUWwUx8OaYW1eoQaRfCzJXCD12GsAx
         IqJH6XuF9RHpLOiSpuDWASCMnXFtYNcgezk7PzSBpVOrPpdAVt6oPZNMhKjsa5Ng8tTB
         mZWgIXzmwikA87tOQtCfbsCFgmwI3qEA1bPpe+NEtUwu7BxxbSC4khqqn2OMpTpvJG6A
         DGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683760864; x=1686352864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffPJ36adGh8uykiqGm+Ey1/eCjuKTv/sqWzbZCfRdDI=;
        b=DkuM02agDnJYhActst5jXJgpNIiM8RKJ8Ix8Ou+zZm0/LBQCjqm5Nnw/0oOESfKGng
         MBUqWvpl3dUI+CndOVeOmz8MFegGPNQKIL5/C/4yBKVnCqkju3G9sT+inub+2faCtVBj
         GQxKf0Y826GqpCBBHpwqk+VJe1IHRoYH7fDMl25mAV5I+a81j8+3NW7F2XITylpR9Qrd
         V9WHhLT9JZurpWm4RQUi8d2K/z2yHjcdzCUe3KIfer0bGSC2oJDgRcgz754j1voOtzdy
         3UivOT0BFaDEs4IVY5NChHHaYZpO+s1IwopJJSHAYSKoaXt+JOsSYNvHnsfZbTUWOmce
         hQpw==
X-Gm-Message-State: AC+VfDyaVJ3kQDKkHxMZX5Li1Lk2cfTTR5/pUSaRGwcMuDBKyafCEQJr
        /JdVrvWi3jeT4ege58ayfwA0WxocU9i+pUmW2+0=
X-Google-Smtp-Source: ACHHUZ4gHR0jLRERlyyoSMGNLDZmc4Z3jce3P/QKFAGW6LFV3wUi+CM2p/kktGAEkyx3iK1sdOc4WZwCkopCwaXOGOY=
X-Received: by 2002:a05:6214:c46:b0:621:45b2:3370 with SMTP id
 r6-20020a0562140c4600b0062145b23370mr8196366qvj.31.1683760864576; Wed, 10 May
 2023 16:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230503013608.2431726-1-nphamcs@gmail.com> <20230503013608.2431726-3-nphamcs@gmail.com>
 <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
 <20230505133426.d70a6599d9a729496b68a70c@linux-foundation.org> <315e7ec2-169c-4c4b-93df-485380bc0852@app.fastmail.com>
In-Reply-To: <315e7ec2-169c-4c4b-93df-485380bc0852@app.fastmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 10 May 2023 16:20:53 -0700
Message-ID: <CAKEwX=NW=sHAkQQw3TPA5tK9O+MC9AwX05=Wp8DRFbRZ4w-JAg@mail.gmail.com>
Subject: Re: [PATCH v13 2/3] cachestat: implement cachestat syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-api@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 10:35=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, May 5, 2023, at 22:34, Andrew Morton wrote:
> > On Thu, 4 May 2023 19:26:11 +0200 Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >
> >> >  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
> >> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> >>
> >> This should be wired up on each and every architecture.
> >> Currently we're getting
> >>
> >>     <stdin>:1567:2: warning: #warning syscall cachestat not implemente=
d [-Wcpp]
> >>
> >> in linux-next for all the missing architectures.
> >
> > Is that wise?  We risk adding a syscall to an architecture without the
> > arch maintainers and testers even knowing about it.
> >
> > The compile-time nag is there to inform the arch maintainers that a new
> > syscall is available and that they should wire it up, run the selftest
> > and then ship the code if they're happy with the result.
>
> The usual approach is for the author of a new syscall to
> include a patch with all the architecture specific changes
> and Cc the architecture maintainers for that.
>
> Note that half the architectures get the entry from
> include/uapi/asm-generic/unistd.h, so adding it there
> does not necessarily trigger adding each maintainer
> from scripts/get_maintainer.pl.
>
> The only real risk in adding a new syscall is passing __u64
> register arguments that behave differently across
> architectures, or using pointers to data structures that
> require a compat handler on some architectures. I watch out
> for those as they get sent to me or the linux-arch list,
> and this one is fine.
>
>      Arnd

I took a stab at wiring the new syscall in this follow-up patch:

https://lore.kernel.org/lkml/20230510195806.2902878-1-nphamcs@gmail.com/

Let me know if I missed something! Review and/or suggestion
is very much appreciated.
