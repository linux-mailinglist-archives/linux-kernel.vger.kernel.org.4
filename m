Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA39F6FAC7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjEHLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjEHLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:24:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D43A5D8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:24:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba1911d60f5so6899604276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1683545076; x=1686137076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIGhf3eRAjihUJXQEWIYc02wnTiI4XPwL0ihUb83Waw=;
        b=OmtuiNHh/0mYopJ2E3ln7anz6SL7k7OlWoQ+Jjv4kFH7ceI9OnXCKkqFmmjd7G2vV+
         PfvuJUD6KWGOgRRzAkYRgLP02ubjYdYebw1QIy7OXai0nGFtS/r+7PxB1x7cdlYbppNt
         CSkebv+h1HWH2679CKhDW12tjbgP/7EysinpQUiDvrsPSWbeg1Qy5f2kr8Z62aeHkwi4
         DXeQL8ZSTHhhuzKAXoYe94sIzYSDgEz1C0tCx00QH7ebBJJpd5HRs2Klfyzso3DZ21bh
         IaOFGCJrcL66d85IwuVBasel48pJpWQ2YY92NRzKgvDJEqAemaA9AF0mZQ7LS31fNRia
         MUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545076; x=1686137076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIGhf3eRAjihUJXQEWIYc02wnTiI4XPwL0ihUb83Waw=;
        b=VntQr2wCJ+4iKCKG4IFLrkTee2v2RHvAqom/rWOUudX1SOiaXwDWCRHqeEBMj2ki/t
         YwLrK0buSh5ZYgDoKiFjUme1Zz760XCQbDHQF1uVqoFTalAOhf4+H2fv2uO98qAoqZMn
         u8DmKiXm1DfHnhJmIdJivKoL74eyak6f2TGIPQ1MRkgBGQm5uBwaACG2v9pChbifGpw2
         jyrdYwN5ZLQwsT30r9ahsXDj5toj2vn/qLKCTz3u7c/cWYYKwYSrHKynDQMDvAS3OQoM
         yaeMh94u6+r0raRnWhbnYjv3+2Skb76PUxgGfYbaX76TUpANfOy3/UuCIYy004ffO1CP
         E7AA==
X-Gm-Message-State: AC+VfDy9saL+PEzGEa8xbxkV9pVpupa2aVfSM2KnU5yTpUNSIGgikQ9F
        OHqnCPDK0nwws3OnSatywWC6e+Z7DkQx8hfJYc1oSg==
X-Google-Smtp-Source: ACHHUZ6Hs0l5aEi7EewTSFlNC+EkBAT54ACkp3N6Zc1EHO8wzU5wK1Z1ej8SuhfI1vY3FSFbF/9TFwF/7FYfGS1eqCc=
X-Received: by 2002:a25:6fc6:0:b0:b9e:6894:289c with SMTP id
 k189-20020a256fc6000000b00b9e6894289cmr9519837ybc.59.1683545076214; Mon, 08
 May 2023 04:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683326865.git.peilin.ye@bytedance.com> <846336873bfba19914397a1656ba1eb42051ed87.1683326865.git.peilin.ye@bytedance.com>
In-Reply-To: <846336873bfba19914397a1656ba1eb42051ed87.1683326865.git.peilin.ye@bytedance.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 8 May 2023 07:24:25 -0400
Message-ID: <CAM0EoMnPL_UcZmBYJk=nUAc9hG26EoKwyUd3gUGeCE_nBtTAFg@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net/sched: Prohibit regrafting ingress or clsact Qdiscs
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 8:14=E2=80=AFPM Peilin Ye <yepeilin.cs@gmail.com> wr=
ote:
>
> Currently, after creating an ingress (or clsact) Qdisc and grafting it
> under TC_H_INGRESS (TC_H_CLSACT), it is possible to graft it again under
> e.g. a TBF Qdisc:
>
>   $ ip link add ifb0 type ifb
>   $ tc qdisc add dev ifb0 handle 1: root tbf rate 20kbit buffer 1600 limi=
t 3000
>   $ tc qdisc add dev ifb0 clsact
>   $ tc qdisc link dev ifb0 handle ffff: parent 1:1
>   $ tc qdisc show dev ifb0
>   qdisc tbf 1: root refcnt 2 rate 20Kbit burst 1600b lat 560.0ms
>   qdisc clsact ffff: parent ffff:fff1 refcnt 2
>                                       ^^^^^^^^
>
> clsact's refcount has increased: it is now grafted under both
> TC_H_CLSACT and 1:1.
>
> ingress and clsact Qdiscs should only be used under TC_H_INGRESS
> (TC_H_CLSACT).  Prohibit regrafting them.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/sch_api.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 383195955b7d..49b9c1bbfdd9 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1596,6 +1596,11 @@ static int tc_modify_qdisc(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>                                         NL_SET_ERR_MSG(extack, "Invalid q=
disc name");
>                                         return -EINVAL;
>                                 }
> +                               if (q->flags & TCQ_F_INGRESS) {
> +                                       NL_SET_ERR_MSG(extack,
> +                                                      "Cannot regraft in=
gress or clsact Qdiscs");
> +                                       return -EINVAL;
> +                               }
>                                 if (q =3D=3D p ||
>                                     (p && check_loop(q, p, 0))) {
>                                         NL_SET_ERR_MSG(extack, "Qdisc par=
ent/child loop detected");
> --
> 2.20.1
>
