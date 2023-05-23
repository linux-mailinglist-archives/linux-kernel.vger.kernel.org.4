Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1919F70D317
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjEWFJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjEWFI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:08:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756B10D;
        Mon, 22 May 2023 22:08:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96fb1642b09so406698566b.0;
        Mon, 22 May 2023 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684818535; x=1687410535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccUpSo5CJAHGMjq9I+q+FKG1cRoF/TWQPS+NnY32hvg=;
        b=izycGQWkeUhiWfSgorIn5e1mas9O/zMUpTM17nQ8thg7m7+QuGie0sd4fADKgZcJyn
         525jELK4O6Tj1ve6ppeULuzhi3GtpSrdDWA3Zct1vhrWkw2fuxJKRhu5yXARhv071LFs
         vGN+mC3izAjeZKf0sgRlr5gVU4NKzj3zk5IFGqdE4FHiWuWs0ISB2jgA6wUdSZV+NL9G
         rqELbz/5ly8lzd1UZwhk0rsvmiha7zUOCKefp/UcVHcduQbS4WxGX4uBSGkEOQhhdwIu
         JN9vg1rkxYGTYDhl8HhIRgFELN2hxTl0wcMPph1N77Bwp/AzPiZmlArPEzsq/iz+j+oy
         0Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684818535; x=1687410535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccUpSo5CJAHGMjq9I+q+FKG1cRoF/TWQPS+NnY32hvg=;
        b=BeDx6VshojgO864H6v+I70R2aO4rd90RwzysQ+0qDG65R66tyCighPypAwQ7N4Ibh3
         2u5syGc9UGSw0K+uQqbUfcsiQ6h4VUPYSc+LgTZRL12xOlGyEc/rSLAK+eKWcIu7LczW
         LzPOIm6xMZlyr6s21XUWscbGx9n4XqI8HnlSgdDmWRaQ+SRXk6yx9jtTFXrENc3wKyiL
         +totGdDwJqsf2fB9VqQr36aCxlGFA+/DKWM7f0sMyW0hYYFxUvRbfhjFuufN61NYd1v8
         BJp88hqc7OmzsNp5z+KDQRjhvI+ZqZbD/JD78Kh4Tcr8zRYkFmuGCg+4ZG+aVd7RT9ps
         bDfg==
X-Gm-Message-State: AC+VfDyZiUG5ZCimTM+1RTn41skXkrJHnYZ0nceKtEQyFQIBuTVxOvjW
        ETLoi6X3g6Kzyr9T+v9LzkRjhlBqxLw6PYE3LE8=
X-Google-Smtp-Source: ACHHUZ6XHKU72z3WljTmZesf+gXwAZI4Empvl3Z/a7PiHx/1F5556xWlM9IOvPybp+8vJaXhP69qGhPOZkkhA9q2Eug=
X-Received: by 2002:a17:907:784:b0:96b:4ed5:a1c9 with SMTP id
 xd4-20020a170907078400b0096b4ed5a1c9mr11535364ejb.51.1684818534857; Mon, 22
 May 2023 22:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a589d005fc52ee2d@google.com> <13528f21-0f36-4fa2-d34f-eecee6720bc1@linux.dev>
 <CAD=hENeCo=-Pk9TWnqxOWP9Pg-JXWk6n6J19gvPo9_h7drROGg@mail.gmail.com>
 <CAD=hENdoyBZaRz7aTy4mX5Kq1OYmWabx2vx8vPH0gQfHO1grzw@mail.gmail.com>
 <0d515e17-5386-61ba-8278-500620969497@linux.dev> <CAD=hENcqa0jQvLjuXw9bMtivCkKpQ9=1e0-y-1oxL23OLjutuw@mail.gmail.com>
In-Reply-To: <CAD=hENcqa0jQvLjuXw9bMtivCkKpQ9=1e0-y-1oxL23OLjutuw@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 23 May 2023 13:08:42 +0800
Message-ID: <CAD=hENdXdqfcxjNrNnP8CoaDy6sUJ4g5uxcWE0mj3HtNohDUzw@mail.gmail.com>
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:29=E2=80=AFPM Zhu Yanjun <zyjzyj2000@gmail.com> =
wrote:
>
> On Tue, May 23, 2023 at 12:10=E2=80=AFPM Guoqing Jiang <guoqing.jiang@lin=
ux.dev> wrote:
> >
> >
> >
> > On 5/23/23 12:02, Zhu Yanjun wrote:
> > > On Tue, May 23, 2023 at 11:47=E2=80=AFAM Zhu Yanjun <zyjzyj2000@gmail=
.com> wrote:
> > >> On Tue, May 23, 2023 at 10:26=E2=80=AFAM Guoqing Jiang <guoqing.jian=
g@linux.dev> wrote:
> > >>>
> > >>>
> > >>> On 5/23/23 10:13, syzbot wrote:
> > >>>> Hello,
> > >>>>
> > >>>> syzbot tried to test the proposed patch but the build/boot failed:
> > >>>>
> > >>>> failed to apply patch:
> > >>>> checking file drivers/infiniband/sw/rxe/rxe_qp.c
> > >>>> patch: **** unexpected end of file in patch
> > >> This is not the root cause. The fix is not good.
> > > This problem is about "INFO: trying to register non-static key. The
> > > code is fine but needs lockdep annotation, or maybe"
>
> This warning is from "lock is not initialized". This is a
> use-before-initialized problem.
> The correct fix is to initialize the lock that is complained before it is=
 used.
>
> Zhu Yanjun

Based on the call trace, the followings are the order of this call trace.

291 /* called by the create qp verb */
292 int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
struct rxe_pd *pd,
297 {
            ...
317         rxe_qp_init_misc(rxe, qp, init);
            ...
322
323         err =3D rxe_qp_init_resp(rxe, qp, init, udata, uresp);
324         if (err)
325                 goto err2;   <--- error

            ...

334 err2:
335         rxe_queue_cleanup(qp->sq.queue); <--- Goto here
336         qp->sq.queue =3D NULL;

In rxe_qp_init_resp, the error occurs before skb_queue_head_init.
So this call trace appeared.

Zhu Yanjun

> >
> > Which is caused by  "skb_queue_head_init(&qp->resp_pkts)" is not called
> > given rxe_qp_init_resp returns error, but the cleanup still trigger the
> > chain.
> >
> > rxe_qp_do_cleanup -> rxe_completer -> drain_resp_pkts ->
> > skb_dequeue(&qp->resp_pkts)
> >
> > But I might misunderstood it ...
> >
> > Thanks,
> > Guoqing
