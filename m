Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3075D6E4299
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDQI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDQI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:29:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE398
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:29:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u3so9975947ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681720181; x=1684312181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRZ2tcvqDj6aA5FUk+mT9yobZjv/gI2nC0wcdO8PDjQ=;
        b=ikboJsxqosDpwuwxYfCOrfjOkg0PmSF0kOs5T9BGRAWMRjJJpHRi0SL9ChyQ8V2cL4
         1WVSQ2Ng7zbBmG4MlxKyAA4oqulY+vi1Z0mO/wNfOK5x9YICgv9sQB3h+MqfX765PsjZ
         jbN5yLuyBgX34rF5hE6HUNk9a0NmJtSySTIy/1qtTB4sQuHmdHbOOcp6C48N/m6LHjS6
         a9sQUNFp4po9LRTWqrDa+IGCsNtO11TWBAwsF2tDP5/3Z/DGR0wWM+XERF+CTJytWlpz
         BufYdP4rJcgrUCYAjKR4RrC6gAcuPvoamP5/YDcK0Q0Nkabkbob0tuPTgKChAp3B5TkD
         MyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681720181; x=1684312181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRZ2tcvqDj6aA5FUk+mT9yobZjv/gI2nC0wcdO8PDjQ=;
        b=iLt2Y5QZmrz+ASrzcKwlY0iiKa0c0KkTlr15vFN3qvMExwwbodFNuevHavCVFbw6AY
         WjWv56oLbyqtKy/6B6cnelCoS0MwSqBeeQhuReFW6ZNaDkx/1Yniq5l3uW7E2wVl0jfG
         Zu8u26ukNXgPKipTGVWW6NNHCp+NAIj1aiH0ygkNlvnwk0nweyQXE0/7EFMi5VBDvFkT
         dgrLTw0wlLw3MrUWGT+k/yPHtKzNS5MOFUyFlXc+OdIQRag5SczsmwzS8ylJb2MP7uQ7
         Mrbu8XlVnoSmOHdLZ07W2xdJIZZ/yS/fkTcRckblJSCz3ZmsiEb1BQEF3BMxonVxReXq
         WwmQ==
X-Gm-Message-State: AAQBX9fyOiaRnFCccGBo3KFIoOHylwOAeKDV6DmRSQtX8AL9jQB8mBEO
        REATawrofGPoJnZgGup2Hd9ODIFPPXy5v83Z07734w==
X-Google-Smtp-Source: AKy350Y88p1LEPIPcIBXXOw9rnSwIaYgMBGvCTzdmL/dFeAwUtYtbEzWCXawg/hXbe8eFrlAGw7uT/H5Byb020Cht/E=
X-Received: by 2002:a17:906:ecb6:b0:94f:552:809f with SMTP id
 qh22-20020a170906ecb600b0094f0552809fmr2585524ejb.15.1681720180675; Mon, 17
 Apr 2023 01:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com> <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
 <20230417024446.GL25053@google.com> <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
 <20230417035232.GM25053@google.com>
In-Reply-To: <20230417035232.GM25053@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 01:29:03 -0700
Message-ID: <CAJD7tkZFufCacfu-EeqwhQBYXt8dpea1DYhyDgponjFjdLt5Sw@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Sun, Apr 16, 2023 at 8:52=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/16 20:55), Yu Zhao wrote:
> > > Do you run some specific test?
> >
> > E.g.,
> >   tools/testing/selftests/kvm/max_guest_memory_test -c 112 -m 800 -s 80=
0
> > with 112 CPUs and ~770GB DRAM + 32GB zram.
>
> Hmm ...
>
> Something like this maybe?
>
> The src zspage pointer is not NULL-ed after non-empty zspage is
> put back to corresponding fullness list.
>
> ---
>
> @@ -2239,8 +2241,8 @@ static unsigned long __zs_compact(struct zs_pool *p=
ool,
>                 if (fg =3D=3D ZS_INUSE_RATIO_0) {
>                         free_zspage(pool, class, src_zspage);
>                         pages_freed +=3D class->pages_per_zspage;
> -                       src_zspage =3D NULL;
>                 }
> +               src_zspage =3D NULL;
>
>                 if (get_fullness_group(class, dst_zspage) =3D=3D ZS_INUSE=
_RATIO_100
>                     || spin_is_contended(&pool->lock)) {

For my own education, how can this result in the "next is NULL" debug
error Yu Zhao is seeing?

IIUC if we do not set src_zspage to NULL properly after putback, then
we will attempt to putback again after the main loop in some cases.
This can result in a zspage being present more than once in the
per-class fullness list, right?

I am not sure how this can lead to "next is NULL", which sounds like a
corrupted list_head, because the next ptr should never be NULL as far
as I can tell. I feel like I am missing something.
