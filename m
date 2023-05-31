Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A1A7185B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjEaPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjEaPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:07:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21E12F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:07:33 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so10142265276.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685545652; x=1688137652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aQg/XyLc0KoyLOMQC9nxzXd5jehGRavUIxUSIV2naQ=;
        b=1EhPv/FGgUxPG7bhv9pWTsI9oglY2BT+2VHNgu6m+3vORlYefuXvCNDfSavIZlEXuq
         dlSl8rh+SFNbx36nrP/0GkdsrzahtH/Nq7Yla5bLSyD++kFxWXXgEMAGinIjlHsKDOu9
         lIj04xMLqI3xHIZJsMwBaLwOUnLn5vqMNtx5Pfapt8p49CozlpTrJDiYoEi+r5Iqb/rA
         BENjtK3nWgXHC+SASym4IQJIjAU8AJkyJOjpFDsO4YLkcsZjj4rt5eBxxpuGVddFlDPa
         U3Bg8+KJ0+loUmO5o+mnhqV7SEAEXnjFoPcA2kDDDCEk79J8XJ8anTbs1j+dtCtUGqYE
         9jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545652; x=1688137652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aQg/XyLc0KoyLOMQC9nxzXd5jehGRavUIxUSIV2naQ=;
        b=BhZITN+R0Na4OwBOAyOQEl/RzN/pFOe5Ncr74qkrqIbPPqgSSK8vAr/cZE1oIgRoIL
         80czdSrI4+5e0MTs1IVo+3xTDgpPqWEMJgDu3o46bwJ6O7vHgyh3qxvG/oteiZES/bkD
         55RTCoIpw3CHXmaIan+oxg70cVMOqYaPzortfMpp6mPVU2B7Ep3ZqcdCeAL0MZF2Pmve
         KhFC1LbO7Qs+YQJri23cxoefVTZUqFtbfd8nFls/OWK0IqnaD250oou0tmVTA6ck5l5B
         I/GwgGtwdRQDqKWK5IWdn1n7eoK8Cf9J6roXLDAi1u0jRwD+dWygeqwPatFFDAedm6rG
         MeZg==
X-Gm-Message-State: AC+VfDzaP4G8f/Pm4zae9fw5MjTd5Z0BEGHIoVKuSN48E2FObiG0duMM
        8AI1uWhKc1doDqFTl45lvWxcErjhcPafLSf7Qo5/JA==
X-Google-Smtp-Source: ACHHUZ77LJrjRPlRCPaA1cCrFz7N3gR49T4+cjdOnPoFno78wVh8ZdLEgtBGtF1oXcnMf9/wyM5Ti7RrmCAKn4hRS+A=
X-Received: by 2002:a81:6c84:0:b0:565:9fc7:9330 with SMTP id
 h126-20020a816c84000000b005659fc79330mr5984962ywc.17.1685545652645; Wed, 31
 May 2023 08:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230531141556.1637341-1-lee@kernel.org> <CANn89iJw2N9EbF+Fm8KCPMvo-25ONwba+3PUr8L2ktZC1Z3uLw@mail.gmail.com>
In-Reply-To: <CANn89iJw2N9EbF+Fm8KCPMvo-25ONwba+3PUr8L2ktZC1Z3uLw@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 31 May 2023 11:07:21 -0400
Message-ID: <CAM0EoMnUgXsr4UBeZR57vPpc5WRJkbWUFsii90jXJ=stoXCGcg@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
To:     Eric Dumazet <edumazet@google.com>
Cc:     Lee Jones <lee@kernel.org>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stable@kernel.org
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

On Wed, May 31, 2023 at 11:03=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, May 31, 2023 at 4:16=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> >
> > In the event of a failure in tcf_change_indev(), u32_set_parms() will
> > immediately return without decrementing the recently incremented
> > reference counter.  If this happens enough times, the counter will
> > rollover and the reference freed, leading to a double free which can be
> > used to do 'bad things'.
> >
> > Cc: stable@kernel.org # v4.14+
>
> Please add a Fixes: tag.
>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  net/sched/cls_u32.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> > index 4e2e269f121f8..fad61ca5e90bf 100644
> > --- a/net/sched/cls_u32.c
> > +++ b/net/sched/cls_u32.c
> > @@ -762,8 +762,11 @@ static int u32_set_parms(struct net *net, struct t=
cf_proto *tp,
> >         if (tb[TCA_U32_INDEV]) {
> >                 int ret;
> >                 ret =3D tcf_change_indev(net, tb[TCA_U32_INDEV], extack=
);
>
> This call should probably be done earlier in the function, next to
> tcf_exts_validate_ex()
>
> Otherwise we might ask why the tcf_bind_filter() does not need to be undo=
ne.
>
> Something like:
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 4e2e269f121f8a301368b9783753e055f5af6a4e..ac957ff2216ae18bcabdd3af3=
b0e127447ef8f91
> 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -718,13 +718,18 @@ static int u32_set_parms(struct net *net, struct
> tcf_proto *tp,
>                          struct nlattr *est, u32 flags, u32 fl_flags,
>                          struct netlink_ext_ack *extack)
>  {
> -       int err;
> +       int err, ifindex =3D -1;
>
>         err =3D tcf_exts_validate_ex(net, tp, tb, est, &n->exts, flags,
>                                    fl_flags, extack);
>         if (err < 0)
>                 return err;
>
> +       if (tb[TCA_U32_INDEV]) {
> +               ifindex =3D tcf_change_indev(net, tb[TCA_U32_INDEV], exta=
ck);
> +               if (ifindex < 0)
> +                       return -EINVAL;
> +       }
>         if (tb[TCA_U32_LINK]) {
>                 u32 handle =3D nla_get_u32(tb[TCA_U32_LINK]);
>                 struct tc_u_hnode *ht_down =3D NULL, *ht_old;
> @@ -759,13 +764,9 @@ static int u32_set_parms(struct net *net, struct
> tcf_proto *tp,
>                 tcf_bind_filter(tp, &n->res, base);
>         }
>
> -       if (tb[TCA_U32_INDEV]) {
> -               int ret;
> -               ret =3D tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
> -               if (ret < 0)
> -                       return -EINVAL;
> -               n->ifindex =3D ret;
> -       }
> +       if (ifindex >=3D 0)
> +               n->ifindex =3D ifindex;
> +

I guess we crossed paths ;->

Please, add a tdc test as well - it doesnt have to be in this patch,
can be a followup.

cheers,
jamal

>         return 0;
>  }
