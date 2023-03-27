Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA376CB0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC0Vha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjC0Vh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:37:27 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE022121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:37:25 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p15so12573950ybl.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679953044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xm5gtyuxKZCMPw1HMGOtlJQVZR2OK69GXkaT/vqsKs=;
        b=R4o2J90nGurrfzuTC7+oSjJ+0p6avJotUTIxGrwx/df4xGb8GPkasfcgZSYJp4uprh
         gCT6Qd8kw7ODFj86V5MJX9HgR0r83mO4FuEq1ptDOUlK8Hs0y6TnzI+OL1lt6lpPC2j8
         T79H5vfulR1cyjPMCHMwqtQkTrNTvUrLD17D/GZB298plP07aFJHd3RMcEU4ZXYvEMsQ
         l51NibBQy60nK0sqeEHLjBzh7ZyOtPUkD2clfI2lIQuFkVmo45vF1Rgv1OKxz1fpsofB
         IooB/3iXCkbNvhBnfJjCYc+NkMKtGJSL+hh3Zrq//DspbNDzI/U5pXHMi4jm5cNTQLWb
         Fmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679953044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Xm5gtyuxKZCMPw1HMGOtlJQVZR2OK69GXkaT/vqsKs=;
        b=S8lxQEpd2Q69QMFvyMakLTQGdTmdHqtRFMNlkjSjbIOJzDQ7CK/2RSeFCK7016Qbva
         94+eFYfReq/KXXxE5Qp1P+PGvQ1qFmnjyTlEjNvbRBVDvmhXnqfJKItv/MLP6HzLi7YX
         nyvX3+LuejubWoCfpurRkCaapfh2bY0mvvF6Q/c6hxbPM1paWW4cuMdVkwjE4HnWDSM/
         yqM2vSxGDjdaSHCPUkuW1pRg9q8B4ppnXk6JZveiiSv+fHcfD+H4T3GmRny3leucayFq
         yRgdyhb7ZAQE6gSnsAeELbtnDFg/r3F7BPnboIigyIbStvqTcO0S0YbZae8gbfy9siAg
         9sQA==
X-Gm-Message-State: AAQBX9f4SYiwFtVWIUOWh7Igd6q6TcjIsfoxSz16l6dquUtEXkSdTtmH
        wGy3QhsQ106N8Mat7tZExTHls6Ua9uQIqKymsv+/
X-Google-Smtp-Source: AKy350au2agJQlTOeaLLljcyGiOVu2K70TKj7p6HIc/lxld00if3ck6TEGGSGr+/sjLgXjtOnS36vO4BhC9HB5P2hsY=
X-Received: by 2002:a25:344:0:b0:b27:4632:f651 with SMTP id
 65-20020a250344000000b00b274632f651mr5884577ybd.3.1679953044604; Mon, 27 Mar
 2023 14:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <57a97109-7a67-245b-8072-54aec3b5021d@web.de>
In-Reply-To: <57a97109-7a67-245b-8072-54aec3b5021d@web.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Mar 2023 17:37:13 -0400
Message-ID: <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Adjust implementation of security_get_bools()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Ruiqi Gong <gongruiqi1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>,
        Ruiqi Gong <ruiqi.gong@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 3:00=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> Date: Mon, 27 Mar 2023 08:50:56 +0200
>
> The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check=
 despite of
> the detail in the implementation of the function =E2=80=9Csecurity_get_bo=
ols=E2=80=9D
> that it was determined already that a corresponding variable contained
> a null pointer because of a failed memory allocation.
>
> Thus perform the following adjustments:
>
> 1. Convert the statement =E2=80=9Cpolicydb =3D &policy->policydb;=E2=80=
=9D into
>    a variable initialisation.
>
> 2. Replace the statement =E2=80=9Cgoto out;=E2=80=9D by =E2=80=9Creturn -=
ENOMEM;=E2=80=9D.
>
> 3. Return zero directly at two places.
>
> 4. Omit the variable =E2=80=9Crc=E2=80=9D.
>
> 5. Use more appropriate labels instead.
>
> 6. Reorder the assignment targets for two kcalloc() calls.
>
> 7. Reorder jump targets at the end.
>
> 8. Assign a value element only after a name assignment succeeded.
>
> 9. Delete an extra pointer check which became unnecessary
>    with this refactoring.
>
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/services.c | 52 ++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 30 deletions(-)

Hmm, for some odd reason I don't see this patch in the SELinux mailing
list archive or the patchwork; replying here without comment (that
will come later) to make sure this hits the SELinux list.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index f14d1ffe54c5..702282954bf9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2964,53 +2964,45 @@ int security_fs_use(struct super_block *sb)
>  int security_get_bools(struct selinux_policy *policy,
>                        u32 *len, char ***names, int **values)
>  {
> -       struct policydb *policydb;
> +       struct policydb *policydb =3D &policy->policydb;
>         u32 i;
> -       int rc;
> -
> -       policydb =3D &policy->policydb;
>
>         *names =3D NULL;
>         *values =3D NULL;
> -
> -       rc =3D 0;
>         *len =3D policydb->p_bools.nprim;
>         if (!*len)
> -               goto out;
> -
> -       rc =3D -ENOMEM;
> -       *names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
> -       if (!*names)
> -               goto err;
> +               return 0;
>
> -       rc =3D -ENOMEM;
>         *values =3D kcalloc(*len, sizeof(int), GFP_ATOMIC);
>         if (!*values)
> -               goto err;
> +               goto reset_len;
>
> -       for (i =3D 0; i < *len; i++) {
> -               (*values)[i] =3D policydb->bool_val_to_struct[i]->state;
> +       *names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
> +       if (!*names)
> +               goto free_values;
>
> -               rc =3D -ENOMEM;
> +       for (i =3D 0; i < *len; i++) {
>                 (*names)[i] =3D kstrdup(sym_name(policydb, SYM_BOOLS, i),
>                                       GFP_ATOMIC);
>                 if (!(*names)[i])
> -                       goto err;
> -       }
> -       rc =3D 0;
> -out:
> -       return rc;
> -err:
> -       if (*names) {
> -               for (i =3D 0; i < *len; i++)
> -                       kfree((*names)[i]);
> -               kfree(*names);
> +                       goto free_names;
> +
> +               (*values)[i] =3D policydb->bool_val_to_struct[i]->state;
>         }
> -       kfree(*values);
> -       *len =3D 0;
> +       return 0;
> +
> +free_names:
> +       for (i =3D 0; i < *len; i++)
> +               kfree((*names)[i]);
> +
> +       kfree(*names);
>         *names =3D NULL;
> +free_values:
> +       kfree(*values);
>         *values =3D NULL;
> -       goto out;
> +reset_len:
> +       *len =3D 0;
> +       return -ENOMEM;
>  }
>
>
> --
> 2.40.0

--=20
paul-moore.com
