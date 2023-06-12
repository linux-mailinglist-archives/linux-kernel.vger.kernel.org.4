Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA472BD19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjFLJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjFLJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:51:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EED9667
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:36:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso46957291fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562584; x=1689154584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1srm/YkM/y1rMhl0wSOo4B6NI6ClKwyZp1c2RYH4wjQ=;
        b=A/dd5Oxx90QcXyywj0fYzHEeoVLIByVxrCDYYXtW3teID234UwIXFuW+le3fFj+uj+
         SOPVQ4TN0rdzV5DTxHOcheBXC8xcx2/6vCh7OqiMpVjuPNGBiZn+NtvbpvIgMJr4UFZ6
         sRG34ZgHY2QrRpi1edKHmtd+aqbkxL9oQ+oAUBO98TJP5tGm0C7oA6fTAtyywPiuAAle
         orWlixZ8KhcTyhkjftoTLu03WWUHmIOUj+cD9TVUQIJlCNKyJ8JBchP2NsNOtbTEQKok
         Uc4G3CiA2nWVkGycCgDPHGT06HUBG/tjb0HJEt+Fvt1a01ZdtMKeI+mcM7t2da+KTPq2
         TiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562584; x=1689154584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1srm/YkM/y1rMhl0wSOo4B6NI6ClKwyZp1c2RYH4wjQ=;
        b=PdBZe9TkAQsfKm+DSI5IRH454+qDYPQSyvhYsh98R0CfqImpI6fofbnIdywXo6pqDp
         5j6LVHmI31m0ta9d1MCGh5+ayN5SlUI2W54adhJix5WhIZJ77pBe+2lmrDMItHaZP9KJ
         JQ6xxciz4YYRp6plP4loToa3CmcrLjHl/qacUSI1+nFt2/aCKIOgKSAYE3/nBYVI8bgm
         D4l8+ov3UVldnv/rYxrSawdDlEKwBNpK9pQnOZS6Y3biOdQSJwoFmFiECxFYJ0DybNld
         skOaMqgcSgZz2RxBbTg7H8Opn6dtdhbRIUxlzX2AQumhWs3fwRazWDbwZUxGBWMeaKk+
         D3AQ==
X-Gm-Message-State: AC+VfDzeBMPwRgh97NRkvJDoD6R9T0b5ef8qkH84MAGtB9rKywFx5xIr
        Pl5urwBpyJNdNNJ9gltOb8Nu3OOuODDC0GNGqac=
X-Google-Smtp-Source: ACHHUZ48ioROrY2/C6eDLwiwCkzE47MsMeBSpqjJqJmV9QPCAicvVHhfu8Sxn6AsTypryUPQenm1hZHzMLs1B//yzz4=
X-Received: by 2002:a2e:b050:0:b0:2b1:a4c2:70b4 with SMTP id
 d16-20020a2eb050000000b002b1a4c270b4mr2706732ljl.30.1686562583736; Mon, 12
 Jun 2023 02:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20230609153519.ff01046ef0faff00a74bd5b0@linux-foundation.org> <a562bae0-d779-620a-98bc-6102468aecae@redhat.com>
In-Reply-To: <a562bae0-d779-620a-98bc-6102468aecae@redhat.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 12 Jun 2023 17:35:59 +0800
Message-ID: <CAGWkznFv=LjrjdqvepYtMP-e5JRp2wuWakd=CGLQQZ7aBx36Hg@mail.gmail.com>
Subject: Re: [PATCHv5] mm: skip CMA pages when they are not available
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
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

On Mon, Jun 12, 2023 at 5:29=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 10.06.23 00:35, Andrew Morton wrote:
> > On Wed, 31 May 2023 10:51:01 +0800 "zhaoyang.huang" <zhaoyang.huang@uni=
soc.com> wrote:
> >
> >> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>
> >> This patch fixes unproductive reclaiming of CMA pages by skipping them=
 when they
> >> are not available for current context. It is arise from bellowing OOM =
issue, which
> >> caused by large proportion of MIGRATE_CMA pages among free pages.
> >>
> >> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation f=
ailure: order:0, mode:0xc00(GFP_NOIO), nodemask=3D(null),cpuset=3Dforegroun=
d,mems_allowed=3D0
> >> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB =
(C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024k=
B 0*2048kB 0*4096kB =3D 35848kB
> >> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH=
) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024=
kB 0*2048kB 0*4096kB =3D 3236kB
> >> ...
> >> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on=
 node -1, gfp=3D0xa20(GFP_ATOMIC)
> >> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 6=
4, buffer size: 64, default order: 0, min order: 0
> >> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free=
: 0
> >>
> >
> > We saw plenty of feedback for earlier versions, but now silence.  Does
> > this mean we're all OK with v5?
>
> The logic kind-of makes sense to me (but the kswapd special-casing
> already shows that it might be a bit fragile for future use), but I did
> not yet figure out if this actually fixes something or is a pure
> performance improvement.
>
> As we phrased it in the comment "It is waste of effort", but in the
> patch description "This patch fixes unproductive reclaiming" + a scary
> dmesg.
>
> Am I correct that this is a pure performance optimization (and the issue
> revealed itself in that OOM report), or does this actually *fix* somethin=
g?
>
> If it's a performance improvement, it would be good to show that it is
> an actual improvement worth the churn ...
Sorry for the confusion. As for the OOM issue, the previous
commit(https://lkml.kernel.org/r/1683782550-25799-1-git-send-email-zhaoyang=
.huang@unisoc.com)
helps to decrease the fail rate from 12/20 to 2/20, which it turn to
be 0 when applying this patch.
>
> --
> Cheers,
>
> David / dhildenb
>
