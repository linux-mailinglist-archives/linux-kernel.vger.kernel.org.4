Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E36FAD03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjEHLaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjEHL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:29:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255937865
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:29:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9e27684b53so3842223276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1683545377; x=1686137377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf9xP+nKNZcWbJUD0fYGLuCSyrgF1CkVpqBfetT/SAU=;
        b=E6dUadmg+Ly4O4sVQh47014bqUNwGP9dxF8kaL5813rMQVWgWpomZo7LK4lgo+hECb
         X8bDFdqTn5yHRbBb3BDv7V/lZtaFQVFcPE2GNrwoKw3TA8VvoE9pZRsdn8QS0c6Ttl0K
         +4gSUqnMiDEb+afvJ3UHrkcmOtGQcI9aXtUiVTH7o0vBDgkQfN2H0qT80TvcAUhrxyvo
         z/AXJYe6goSRSsNoKCNqyyj8YaMBqfJCsGh7lWTOeI/nBUrbVGPKoVk5nw3bTiKnZYGk
         ZDu5+YQZS1/IgGwZCxjZBXSsPb2jOipUVkQavGRMtGGNI0vpWgyeFmI8NgNpc4x+JxUT
         Ry0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545377; x=1686137377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf9xP+nKNZcWbJUD0fYGLuCSyrgF1CkVpqBfetT/SAU=;
        b=TbPYojYUP9oz+gE84zwrmN8XIQU379XX9kfSMOWQaRuqcll6gdDczhCj/au8MM/xbX
         NHPT1XQWhOI3p5ByPBirXtttaW28wLj0WJPQqYEJUvz+1jND4CfVqZf1BB8DRxe0qtbD
         rf84ptR9F31UAsYzU0b1Vmb3Y8sJfPFQKOiVzYRx2NU6fCzqSQ+s366xgBFHH3yiEd9n
         ReHguj06v8ls5LsAAhRoNT4e8VAoX8f8enjGy0iTOZGXH33jilAumqZljcrwke5UpgBm
         sYFld0B+fHcbFwA/1tNCKRqMxZ3tC2KCfr8xyAYk9G+KciYcWOAQgaLwwGzK11fCoNLh
         nc7g==
X-Gm-Message-State: AC+VfDxao1TRvGbM5BEpggPvtnk8akeO7N07X2pQL2hJ4OXW060YitHI
        jiH1TRS9Nv9WSCwxx/fg7CDrYmqk/dzKPUphFpw2Qw==
X-Google-Smtp-Source: ACHHUZ5xyZWRYekPbCi2C7w1p87Zm4tTv/KQ2mAxymaMTwuF8atX1+St0eMFDqFU5z3lqW7m1UNA77qNBooXreMpMA0=
X-Received: by 2002:a25:ab62:0:b0:b94:bbf2:6d9d with SMTP id
 u89-20020a25ab62000000b00b94bbf26d9dmr11309852ybi.48.1683545377452; Mon, 08
 May 2023 04:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683326865.git.peilin.ye@bytedance.com> <1cd15c879d51e38f6b189d41553e67a8a1de0250.1683326865.git.peilin.ye@bytedance.com>
In-Reply-To: <1cd15c879d51e38f6b189d41553e67a8a1de0250.1683326865.git.peilin.ye@bytedance.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 8 May 2023 07:29:26 -0400
Message-ID: <CAM0EoM=o862LdMEwmqpCSOFT=dMM8LhxgY3QUvpAow1rHSe7DA@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/sched: Refactor qdisc_graft() for ingress and
 clsact Qdiscs
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>
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

On Fri, May 5, 2023 at 8:15=E2=80=AFPM Peilin Ye <yepeilin.cs@gmail.com> wr=
ote:
>
> Grafting ingress and clsact Qdiscs does not need a for-loop in
> qdisc_graft().  Refactor it.  No functional changes intended.
>
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Fixed John's email address.

This one i am not so sure;  num_q =3D 1 implies it will run on the for
loop only once. I am not sure it improves readability either. Anyways
for the effort you put into it i am tossing a coin and saying:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal


>  net/sched/sch_api.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 49b9c1bbfdd9..f72a581666a2 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1073,12 +1073,12 @@ static int qdisc_graft(struct net_device *dev, st=
ruct Qdisc *parent,
>
>         if (parent =3D=3D NULL) {
>                 unsigned int i, num_q, ingress;
> +               struct netdev_queue *dev_queue;
>
>                 ingress =3D 0;
>                 num_q =3D dev->num_tx_queues;
>                 if ((q && q->flags & TCQ_F_INGRESS) ||
>                     (new && new->flags & TCQ_F_INGRESS)) {
> -                       num_q =3D 1;
>                         ingress =3D 1;
>                         if (!dev_ingress_queue(dev)) {
>                                 NL_SET_ERR_MSG(extack, "Device does not h=
ave an ingress queue");
> @@ -1094,18 +1094,18 @@ static int qdisc_graft(struct net_device *dev, st=
ruct Qdisc *parent,
>                 if (new && new->ops->attach && !ingress)
>                         goto skip;
>
> -               for (i =3D 0; i < num_q; i++) {
> -                       struct netdev_queue *dev_queue =3D dev_ingress_qu=
eue(dev);
> -
> -                       if (!ingress)
> +               if (!ingress) {
> +                       for (i =3D 0; i < num_q; i++) {
>                                 dev_queue =3D netdev_get_tx_queue(dev, i)=
;
> +                               old =3D dev_graft_qdisc(dev_queue, new);
>
> -                       old =3D dev_graft_qdisc(dev_queue, new);
> -                       if (new && i > 0)
> -                               qdisc_refcount_inc(new);
> -
> -                       if (!ingress)
> +                               if (new && i > 0)
> +                                       qdisc_refcount_inc(new);
>                                 qdisc_put(old);
> +                       }
> +               } else {
> +                       dev_queue =3D dev_ingress_queue(dev);
> +                       old =3D dev_graft_qdisc(dev_queue, new);
>                 }
>
>  skip:
> --
> 2.20.1
>
