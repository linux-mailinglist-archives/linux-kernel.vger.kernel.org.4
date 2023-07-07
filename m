Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0587574B849
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGGUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGGUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:46:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC262123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:46:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7659db6339eso117325485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688762767; x=1691354767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aYVMvYe1G1Ct9F0r9UZVqRVY35bvxFcxuMPw9DOHvw=;
        b=lkuqLxF14A/w/d+fV/ttf+K3Ub3mN4dsNqaNLTsP+ZDcGTajiX2EvRqyzkSjnpw90h
         2/kSM88bqsMjXMcVJVwmaRQGqOm4/nSCxcUal0Du0s8hegtUlJy/KdIPSt3tU5D0lEw0
         WN36Zgo/31PlXBRBCDW4zoA6ZdCUY76aH/bC14sD01W8wnDCdG9bYPTUABJxt5CYePd+
         lDwNBBGzo8oQPeOZ7xteUlOayvMdyzlP9mBMsp2tPYiyDWDygUa0ybaVaKei63uKBEih
         5lPTF8ShwuPVLnHlcCIXQLPBhagZJxmmubKJEEIZbSH7Snzkbfqr4uNsd1A2DxzC8zKa
         yTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762767; x=1691354767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aYVMvYe1G1Ct9F0r9UZVqRVY35bvxFcxuMPw9DOHvw=;
        b=QR1GxdQXE/AIQuaVQEm57nbUOVd7alw1c9AOk6gjz1mk7j0MgFj+7Bt9G00yu1yvBg
         9RbLkmR1/IZ+yY4zuuJYdlNuJ7JsSaKtYTUxiGI64cmHPyvoa+Sti41ZzJmcCp71HE8n
         3BzmD7tjFlVaD8s3c5NX9kETvXUuzJs6kWENUXAqIPMtcfjiuRmoEAn34q1YA6uzeNfU
         A6CmTOoo3ZxfzmR2JNIbqXfEJW4edq4F5T5cWsP9r+T+hn27DJi/xjtdR34GllUNl2P3
         jqzqTQj21+eOR28HIpJTsEbh3j8xtO3A0BCz/QZ3xHWpIY2xRlnX7WzpVuomP0jswz+g
         RA5Q==
X-Gm-Message-State: ABy/qLbNYumzzL1netz4ul7zjkCjXIa7QhiBuoC95ZycqotWpA/cfvDc
        cAv5mS1xuYd+G0ks4SMtaf5O6y8ta4N3QUQf5QxO3g==
X-Google-Smtp-Source: APBJJlHUf0rmBIyOI/T2pORO24BydSGObRtEeKTOwPbRW6TmxkjVJRfSahixaV1hd2/4VLJVPsq9WGAU0WIhQb6nXas=
X-Received: by 2002:a05:620a:2687:b0:765:449d:1397 with SMTP id
 c7-20020a05620a268700b00765449d1397mr10632093qkp.13.1688762767012; Fri, 07
 Jul 2023 13:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-11-dhowells@redhat.com>
 <58466.1688074499@warthog.procyon.org.uk> <20230629164318.44f45caf@kernel.org>
 <20230630161043.GA2902645@dev-arch.thelio-3990X> <20230630091442.172ec67f@kernel.org>
 <20230630192825.GA2745548@dev-arch.thelio-3990X>
In-Reply-To: <20230630192825.GA2745548@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Jul 2023 13:45:55 -0700
Message-ID: <CAKwvOd=H3R0sZjFSNs4xyFdw5yGgxSWk2=v+dmR5TrZfjjXaWA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:28=E2=80=AFPM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Fri, Jun 30, 2023 at 09:14:42AM -0700, Jakub Kicinski wrote:
> > On Fri, 30 Jun 2023 09:10:43 -0700 Nathan Chancellor wrote:
> > > > Let me CC llvm@ in case someone's there is willing to make
> > > > the compiler warn about this.
> > >
> > > Turns out clang already has a warning for this, -Wcomma:
> > >
> > >   drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma op=
erator here [-Werror,-Wcomma]
> > >    1017 |                         msg.msg_flags &=3D ~MSG_SPLICE_PAGE=
S,
> > >         |                                                           ^
> > >   drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to si=
lence warning
> > >    1017 |                         msg.msg_flags &=3D ~MSG_SPLICE_PAGE=
S,
> > >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >         |                         (void)(                           )
> > >   1 error generated.
> > >
> > > Let me do some wider build testing to see if it is viable to turn thi=
s
> > > on for the whole kernel because it seems worth it, at least in this
> > > case. There are a lot of cases where a warning won't be emitted (see =
the
> > > original upstream review for a list: https://reviews.llvm.org/D3976) =
but
> > > something is better than nothing, right? :)
>
> Well, that was a pipe dream :/ In ARCH=3Darm multi_v7_defconfig alone,
> there are 289 unique instances of the warning (although a good number
> have multiple instances per line, so it is not quite as bad as it seems,
> but still bad):
>
> $ rg -- -Wcomma arm-multi_v7_defconfig.log | sort | uniq -c | wc -l
> 289
>
> https://gist.github.com/nathanchance/907867e0a7adffc877fd39fd08853801

It's definitely interesting to take a look at some of these cases.
Some are pretty funny IMO.

>
> Probably not a good sign of the signal to noise ratio, I looked through
> a good handful and all the cases I saw were not interesting... Perhaps
> the warning could be tuned further to become useful for the kernel but
> in its current form, it is definitely a no-go :/
>
> > Ah, neat. Misleading indentation is another possible angle, I reckon,
> > but not sure if that's enabled/possible to enable for the entire kernel
>
> Yeah, I was surprised there was no warning for misleading indentation...
> it is a part of -Wall for both clang and GCC, so it is on for the
> kernel, it just appears not to trigger in this case.
>
> > either :( We test-build with W=3D1 in networking, FWIW, so W=3D1 would =
be
> > enough for us.
>
> Unfortunately, even in its current form, it is way too noisy for W=3D1, a=
s
> the qualifier for W=3D1 is "do not occur too often". Probably could be
> placed under W=3D2 but it still has the problem of wading through every
> instance and it is basically a no-op because nobody tests with W=3D2.
>
> Cheers,
> Nathan
>


--=20
Thanks,
~Nick Desaulniers
