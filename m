Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808ED680F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjA3Nfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjA3Nfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:35:54 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB52B295
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:35:53 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id h5so13965086ybj.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G7bHIsj5CD0I4ilihSfFwyjG5glNyA2Pq4/YoxuvE2c=;
        b=OwZzEt1aOjdubqNG50qkEWrRtN8qHjSzwqzwqxrcBg0nUzXjAGyP23CRc0NyjM+Zyd
         femf4k138UmtbIMf5F55VQbVLL4yW2SXzhH0wDlsu+8CLjAINQXlN0ZY/Ad6FtGWGHpr
         +NRWqUjv9QGE3EMdFYoSlkUKFqu9G3Wp0Sp11tF+GG4eomn1sR4V7J3r0jshrMsk7q0w
         cVrU3RE/y4Nweq4rkP26PB7463qLB5rp7dykqNJCTyf2eHt3eK15kMOBRsAwnDPQg6tt
         XZv9SyHg0fwxbAHlj1VfiskyHhqS2koyIShboxxmvjDWtCOEY7eWZO7JIV/AbkxDzwBb
         9q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7bHIsj5CD0I4ilihSfFwyjG5glNyA2Pq4/YoxuvE2c=;
        b=cRpnSyZjTxeaP3UnNGph3VW7wpjiG5MJVrNFDp9/UdPB9YgyL4Cs5LliMNhL8TxXcN
         Vo9K5MnrXmnmDSx65al3oGJOtBB/tv5MsyvRSj+b0gpK3Hj6g6+t6mbQhqZ93NlSjsz4
         G+ag5mvN0rVOXkOgs+DZBeh9r4nc94pLWL8HAQeFjAaEZ5hRnYscj8oIzavDbInFZqOm
         spL3JhTidngiOxgY0AXnmVB4D1AwtwAFWj+gav1M8f4Gdb31Nii6Iu809Fi2nL2xxzNG
         ds2Mia65Vsc5btgYlsdzmlsmwjNauzZU/vBe9CQnQnxjJ9iuxiUVbLbMqWPAl8MjIshr
         hULQ==
X-Gm-Message-State: AFqh2koiF7v40i1f7cP1Qn9iufATsjruJkplpQa8vcU7OLAMj3VDGkwh
        MBV44dDiIRjB6eOpevdVjJz9OXF5r7UTkiog11cxBlRlhvSrhZ8Hlw4=
X-Google-Smtp-Source: AMrXdXv4IhoNoQyKPn5TvHWkprEWumyW0THrjKxQU5y+tSgAW3MfscEL+cJCYPDlQtUTOnc6y/ttYfP4jg98K7sLZJ0=
X-Received: by 2002:a25:53c2:0:b0:703:e000:287 with SMTP id
 h185-20020a2553c2000000b00703e0000287mr5440320ybb.171.1675085752416; Mon, 30
 Jan 2023 05:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20230127181625.286546-1-andrei.gherzan@canonical.com>
 <CA+FuTSewU6bjYLsyLzZ1Yne=6YBPDJZ=U1mZc+6cJVdr06BhiQ@mail.gmail.com>
 <a762638b06684cd63d212d1ce9f65236a08b78b1.camel@redhat.com> <Y9e9S3ENl0oszAH/@qwirkle>
In-Reply-To: <Y9e9S3ENl0oszAH/@qwirkle>
From:   Willem de Bruijn <willemb@google.com>
Date:   Mon, 30 Jan 2023 08:35:16 -0500
Message-ID: <CA+FuTSe_NMm6goSmCNfKjUWPGYtVnnBMv6W54a_GOeLJ2FqyOQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: udpgso_bench_tx: Introduce exponential
 back-off retries
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 7:51 AM Andrei Gherzan
<andrei.gherzan@canonical.com> wrote:
>
> On 23/01/30 09:26AM, Paolo Abeni wrote:
> > On Fri, 2023-01-27 at 17:03 -0500, Willem de Bruijn wrote:
> > > On Fri, Jan 27, 2023 at 1:16 PM Andrei Gherzan
> > > <andrei.gherzan@canonical.com> wrote:
> > > >
> > > > The tx and rx test programs are used in a couple of test scripts including
> > > > "udpgro_bench.sh". Taking this as an example, when the rx/tx programs
> > > > are invoked subsequently, there is a chance that the rx one is not ready to
> > > > accept socket connections. This racing bug could fail the test with at
> > > > least one of the following:
> > > >
> > > > ./udpgso_bench_tx: connect: Connection refused
> > > > ./udpgso_bench_tx: sendmsg: Connection refused
> > > > ./udpgso_bench_tx: write: Connection refused
> > > >
> > > > This change addresses this by adding routines that retry the socket
> > > > operations with an exponential back off algorithm from 100ms to 2s.
> > > >
> > > > Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> > > > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > >
> > > Synchronizing the two processes is indeed tricky.
> > >
> > > Perhaps more robust is opening an initial TCP connection, with
> > > SO_RCVTIMEO to bound the waiting time. That covers all tests in one
> > > go.
> >
> > Another option would be waiting for the listener(tcp)/receiver(udp)
> > socket to show up in 'ss' output before firing-up the client - quite
> > alike what mptcp self-tests are doing.
>
> I like this idea. I have tested it and it works as expected with the
> exeception of:
>
> ./udpgso_bench_tx: sendmsg: No buffer space available
>
> Any ideas on how to handle this? I could retry and that works.

This happens (also) without the zerocopy flag, right? That

It might mean reaching the sndbuf limit, which can be adjusted with
SO_SNDBUF (or SO_SNDBUFFORCE if CAP_NET_ADMIN). Though I would not
expect this test to bump up against that limit.

A few zerocopy specific reasons are captured in
https://www.kernel.org/doc/html/latest/networking/msg_zerocopy.html#transmission.
