Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1D70FAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbjEXP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbjEXP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:58:10 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB80FE5B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:57:41 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565014fc2faso15337047b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684943858; x=1687535858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJiMWuDa/DxlBPF1DUDfxqZn3kh1sZxnRyYMTBJ/oLI=;
        b=aByDRh1HcNbPhakCSpYG5gxvilodKlUAyE6Gz164POBR6EMez0lUzcYKxMKhI/iXOH
         l6hP1copodEB+P3hJRUnBITkYkYAUCXuaDpkMmFPNj2hQbYAzGxq6SUWhMTeCq8Ie/kO
         zzwm+C1TwzbjSf59hDMnGe42NDXJhYMlguNpbQFvky123/EjXKwJDFs1NdQ/2pdb2GAb
         madzh5HpcSec8vE9dUJE5MtrkKFfKO9JyIBR6AeW6A9VbK8wHBCrv4seF8eWQvBZ5Ka4
         9z7enp8BC4+X32DjvFHHKKAQ27alezJfqbd0nDkI3u+W2XFlQw7p/JzQCjYKPjAUqJuL
         Dq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684943858; x=1687535858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJiMWuDa/DxlBPF1DUDfxqZn3kh1sZxnRyYMTBJ/oLI=;
        b=AIIe6jTdCMrRVCHMAnXi09HXkjWiXapGiONzI+PepjsijGFuI9GcCEm/xJAordoX8A
         UVIviXCYbKSHwvKzyAacxC/GVykNXswlNCXxP5SbPUfnbVdThkDyWY9UKiDoXbHYp9de
         UyszBCYmrVMwo/EP8SHZRzX+hCfmh3XVkdxuF3xzIWiwnHiY2NN3LbM/b3GCEUSF9fJN
         thiLnDa+zG3pW/4rpa18jz9UK3fEvZs0leILymx8a7Zr6Fd0muula6ZgL2jTGrbB/DLX
         cqu6KzLiEFCVvNpjaP6DYiMhevdP/SLZDHkENZyt/1t91qF7PodHPsLG0lV10D4Eddex
         +F/A==
X-Gm-Message-State: AC+VfDxoELoJxH6otaFCf4Em6rdWxIgXyLU45NhOspvp/HMM05bWGsBr
        5xa8dshEBdRbGzk0VdNIsoeRMJvHFIujaMi0NNZjkg==
X-Google-Smtp-Source: ACHHUZ537ndFuIxP/FBndgBgTkyor6Xtz5icmfDcHzO3+uizN8pTXYA3KB4wflWNyUpcmKKq/NmgVrTpHF9aHyWAcRA=
X-Received: by 2002:a81:7bd7:0:b0:565:5e75:6fb9 with SMTP id
 w206-20020a817bd7000000b005655e756fb9mr4336776ywc.32.1684943858705; Wed, 24
 May 2023 08:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684887977.git.peilin.ye@bytedance.com> <b0dcc6677248210348f08d9cb4e93013e7c95262.1684887977.git.peilin.ye@bytedance.com>
In-Reply-To: <b0dcc6677248210348f08d9cb4e93013e7c95262.1684887977.git.peilin.ye@bytedance.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 24 May 2023 11:57:27 -0400
Message-ID: <CAM0EoMm4KfeLEhDm3Zz6KW48vaJ-LqdWDBt6Yszmom-ue1dpSg@mail.gmail.com>
Subject: Re: [PATCH v5 net 1/6] net/sched: sch_ingress: Only create under TC_H_INGRESS
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
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

On Tue, May 23, 2023 at 9:18=E2=80=AFPM Peilin Ye <yepeilin.cs@gmail.com> w=
rote:
>
> From: Peilin Ye <peilin.ye@bytedance.com>
>
> ingress Qdiscs are only supposed to be created under TC_H_INGRESS.
> Return -EOPNOTSUPP if 'parent' is not TC_H_INGRESS, similar to
> mq_init().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/0000000000006cf87705f79acf1a@google.com=
/
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
> change in v5:
>   - avoid underflowing @ingress_needed_key in ->destroy(), reported by
>     Pedro
>
> change in v3, v4:
>   - add in-body From: tag
>
>  net/sched/sch_ingress.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> index 84838128b9c5..f9ef6deb2770 100644
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
> @@ -101,6 +104,9 @@ static void ingress_destroy(struct Qdisc *sch)
>  {
>         struct ingress_sched_data *q =3D qdisc_priv(sch);
>
> +       if (sch->parent !=3D TC_H_INGRESS)
> +               return;
> +
>         tcf_block_put_ext(q->block, sch, &q->block_info);
>         net_dec_ingress_queue();
>  }
> --
> 2.20.1
>
