Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1770FB22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbjEXQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbjEXP7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:59:45 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B21723
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:58:50 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-563b1e5f701so11038887b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684943929; x=1687535929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSx7NVpJoVUE0IuFsRNs5zc6b2qmaAfWzUGO43tnlIY=;
        b=W4rnd1RRJz1sQhwjhVZnU2ah2ujkLS+8GpiMGyaepK7Hf7O0AU/dKF3UDVTBOW2MbM
         ljOMaNUr10NQMKWDExoAKBxc4jOYEJW/taW3f+yd1AAXA9DO8SzkFB68svmrfCXzojXl
         1/qEK0Ccucb7BERzDY9sbNq5syJPaX1+yg5bxZt0/qfGVVTTOUV/VKO5UXyfvnxBp4Jk
         PfMwb7GO+CDr+tX0Veko9Jc9Z/F/b3hBJ7cor0XwUjkoYAKabYGGlsvqvjbbq8+/Z30i
         r2cHwE6SqzU9ajSbnfK8ZtA62YUo14P0Vh6LTQulkK8xVuU1uGAv9xWwY1UEyXhL0dSF
         hyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684943929; x=1687535929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSx7NVpJoVUE0IuFsRNs5zc6b2qmaAfWzUGO43tnlIY=;
        b=GR5F24BONbWZ1I0wZMZELlfffAx7YM7TPdcYovJcDZugZNwAmgZ1Wulp6fveWEehJH
         n/lWO4pZ7PAmGRnGUQh0qpE1wS0IDUIhubyZkaQudQ+EopWRDyMc2uu6EpDHW8I4/HdI
         g1mFf4dauT8Imjfqqv4MLW+ZTXJtaqeFObXgG6eJ1Lwm8mhn0lelK1sVBSsdWquyNul0
         Iv9riEy/IoT36taIWZHSLydcAYF7NnNhpDcSndolKk95gOuVBEv70eeLtH4sQZ7CDEI1
         XNoMUqVfXA5irXX8+pc9mToogieH+kTBzfxmks0WJ4MoPIkVhsLxbh28Edd+yDuKlRd5
         ukSA==
X-Gm-Message-State: AC+VfDz2/tEJhN103egqiavcOD1byzEsvcuZ+sFhSBBDJRi5R4LlqlrZ
        dF7NRGOaFnSCEbOhnlxNOxPQc36u+NBfp1kMAXVlrw==
X-Google-Smtp-Source: ACHHUZ6ABZyoauJy1KJLVnDxNIWCHfHopjqyWk3TvLXtoEhC8BKA/jmE2UNecLPkHi2CXrcevbIf5qUodrw5Yd7cBT4=
X-Received: by 2002:a81:6507:0:b0:55a:6dc8:e084 with SMTP id
 z7-20020a816507000000b0055a6dc8e084mr21214734ywb.17.1684943929353; Wed, 24
 May 2023 08:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684887977.git.peilin.ye@bytedance.com> <0c07bd5b72c67a2edf126cd2c6a9daadddb3ca95.1684887977.git.peilin.ye@bytedance.com>
 <5fda8703-9220-4abd-7859-0af973d0d1d7@mojatatu.com>
In-Reply-To: <5fda8703-9220-4abd-7859-0af973d0d1d7@mojatatu.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 24 May 2023 11:58:38 -0400
Message-ID: <CAM0EoMnwEUdjpA55xtK67iWAH=fh-QUvdMW9Ma0nmG_B8N=s+Q@mail.gmail.com>
Subject: Re: [PATCH v5 net 2/6] net/sched: sch_clsact: Only create under TC_H_CLSACT
To:     Pedro Tammela <pctammela@mojatatu.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:38=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> On 23/05/2023 22:18, Peilin Ye wrote:
> > From: Peilin Ye <peilin.ye@bytedance.com>
> >
> > clsact Qdiscs are only supposed to be created under TC_H_CLSACT (which
> > equals TC_H_INGRESS).  Return -EOPNOTSUPP if 'parent' is not
> > TC_H_CLSACT.
> >
> > Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
> > Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
>
> Tested-by: Pedro Tammela <pctammela@mojatatu.com>
>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> > ---
> > change in v5:
> >    - avoid underflowing @egress_needed_key in ->destroy(), reported by
> >      Pedro
> >
> > change in v3, v4:
> >    - add in-body From: tag
> >
> >   net/sched/sch_ingress.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> > index f9ef6deb2770..35963929e117 100644
> > --- a/net/sched/sch_ingress.c
> > +++ b/net/sched/sch_ingress.c
> > @@ -225,6 +225,9 @@ static int clsact_init(struct Qdisc *sch, struct nl=
attr *opt,
> >       struct net_device *dev =3D qdisc_dev(sch);
> >       int err;
> >
> > +     if (sch->parent !=3D TC_H_CLSACT)
> > +             return -EOPNOTSUPP;
> > +
> >       net_inc_ingress_queue();
> >       net_inc_egress_queue();
> >
> > @@ -254,6 +257,9 @@ static void clsact_destroy(struct Qdisc *sch)
> >   {
> >       struct clsact_sched_data *q =3D qdisc_priv(sch);
> >
> > +     if (sch->parent !=3D TC_H_CLSACT)
> > +             return;
> > +
> >       tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
> >       tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
> >
>
