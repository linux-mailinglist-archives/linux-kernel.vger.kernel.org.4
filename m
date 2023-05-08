Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB66FAC53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjEHLXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjEHLXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:23:11 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C6A394BC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:23:07 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9d881ad689so5828516276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1683544987; x=1686136987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbLxNx5ZTLFtJfBmyYGqFUyF5NENfzsiaOtRcsrhjlE=;
        b=o3OQkgZgD/WY9opGNlHlsV4/NU2A5cemEhoLcU5WNR34kHgn4MxycFAJPhUApExswE
         3VDdWdDGvrt5exhYc5OGjXow3Y2ZpU3yFwMQO8qTXy7/1S0d3BeBTdaqTR2lRrbIx4bf
         TuxY7QBMEKRieP1e1phESc7x4WFJdJUoW5HqYmEvvrDAlRT7/g3Hly4GylD+hhov4H3S
         BdShWv0LIK/1A5gplQk/7H+sWoTj59hMLNpPUzTUx6kddAb1iLGWKpD0Zg4uKKPcFOGl
         rEPoIwKvx5HVHOpfSEiEsqLaXAROGTjBVz58Hc8M8gNvakjiyk47Yfh5RPen0HjwJZni
         /QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683544987; x=1686136987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbLxNx5ZTLFtJfBmyYGqFUyF5NENfzsiaOtRcsrhjlE=;
        b=JS+xVSBkBpCAIgmIorMa+OcNJCD0O7EqjqMjp0R8jRf/XZJPKDsvv9uMT7ClK4gQRS
         yKC3uk46Bckbl2XquuHr5vFKKtBwiVtCNPTh/g95o8U5pTw+HALWUo3JPGXtIk0hVw/N
         jFwHLOWjKSkiHQBflBWqu9dOT3qQ4IOdXN+aQCXH7WJDiKY4wjnYmJKd6rJDjAeut2ar
         KqSRx7fyM2KSlenSr0GxOax836xKS9crI+bZ8Tu+48uJk+8rZRZWaUH72Sc5XWSG+Iia
         t6bkUw2xtuWUuZY2X/uP8M6fEJ8sGV+dKtz8f6FDL7mIhHB966ptKWTf6jYjkl4ejy9R
         HbMA==
X-Gm-Message-State: AC+VfDwiocc9LWinWMTpjE8y9f5K1NefYhCckcym0RtaHAT57jAAXiWd
        vmmuEPcOWJwDcqkRiaXB908+Xnga10/23ngUugFTpQ==
X-Google-Smtp-Source: ACHHUZ585X6xeUyd9o8OyxwKy1fYbCc5vS4z3frP5dtvkLrTIl3xed33FgpAb5R050oyQcWU9Hq4kC+0DRGJgAl8xko=
X-Received: by 2002:a25:4284:0:b0:b8f:490c:a0db with SMTP id
 p126-20020a254284000000b00b8f490ca0dbmr11124953yba.59.1683544985454; Mon, 08
 May 2023 04:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683326865.git.peilin.ye@bytedance.com> <d24b49826204dbdd1aa1a209e79bbfe384a96b67.1683326865.git.peilin.ye@bytedance.com>
In-Reply-To: <d24b49826204dbdd1aa1a209e79bbfe384a96b67.1683326865.git.peilin.ye@bytedance.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 8 May 2023 07:22:54 -0400
Message-ID: <CAM0EoMng6Au3SfHkBuaXu1c1o6U3+iSR_csH7DsZRpGBvZn_TQ@mail.gmail.com>
Subject: Re: [PATCH net 1/6] net/sched: sch_ingress: Only create under TC_H_INGRESS
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.r.fastabend@intel.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 8:12=E2=80=AFPM Peilin Ye <yepeilin.cs@gmail.com> wr=
ote:
>
> ingress Qdiscs are only supposed to be created under TC_H_INGRESS.
> Similar to mq_init(), return -EOPNOTSUPP if 'parent' is not
> TC_H_INGRESS.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/netdev/0000000000006cf87705f79acf1a@google.=
com
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/sch_ingress.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> index 84838128b9c5..3d71f7a3b4ad 100644
> --- a/net/sched/sch_ingress.c
> +++ b/net/sched/sch_ingress.c
> @@ -80,6 +80,9 @@ static int ingress_init(struct Qdisc *sch, struct nlatt=
r *opt,
>         struct net_device *dev =3D qdisc_dev(sch);
>         int err;
>
> +       if (sch->parent !=3D TC_H_INGRESS)
> +               return -EOPNOTSUPP;
> +
>         net_inc_ingress_queue();
>
>         mini_qdisc_pair_init(&q->miniqp, sch, &dev->miniq_ingress);
> --
> 2.20.1
>
