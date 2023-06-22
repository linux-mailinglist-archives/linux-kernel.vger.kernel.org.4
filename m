Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C27395E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFVDrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFVDrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:47:20 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73941BCA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:47:18 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so138602eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687405638; x=1689997638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrQ4pMlhuN5RPf831t214Aq/9pqMzT3UkPKa92aAjMU=;
        b=k1S9Qlx6DpdFXPkJhL80whZ0sFKSR2kRpj2C0YRXbCrpgmCvy68gybu3it8XW+Ma8y
         L9gHhFAI8GZHevsY89WyeWqnXNBCkhj3P7T+ch8khHLFwNNPs2e/BiesTHlFMTLmoQeY
         gJKOB3NOMxt2N0DKxQE65xiAfTgNDe13KulJrMIA8Zd9nOm4BXqoBqPLujKTU7q6Pao6
         Aow6HoCAJZh1DKiqY+vl98H51GlgR1r92Eg20+8Mm1yeDyKB9GYV/KF5NYWd0fXRM8Lv
         neB19PWKMLihXn5z4RDvgaElXXydyOLQquYnBwNbjRq3j+Ujy3TqV9+GqIIajuV9J0Z/
         rnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687405638; x=1689997638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrQ4pMlhuN5RPf831t214Aq/9pqMzT3UkPKa92aAjMU=;
        b=jAlEt5BXRrgQBZK8MRezrmuGOFeJ2iEBFMjfSPKTUC5nohbVZFyUACko/5K7hJe46c
         0EigNXs1DpvKOG7ziX2OQKznC73GVZNjiAxePGY51C/RANA1b7xqfau12P79F+jKfl5q
         4kA5fDfaiawqvrBhong+DOGzmkyOkSE0LB+cNg5HIVkR3Vce7xVO++pqSlYh2/ahg1or
         khHmpQxX0bJcWk5NU7UIuBfvo3J5FxmtODEczv3rsfjwWjBMpPjULPwl7Q+CEd8vuxoV
         FLbnIbejAD1mQ/NPgTqi37sP/p6X3wsUdMytL1IG7utmE96ZGApaU6smJ7Q9YnbP8qNN
         mZfg==
X-Gm-Message-State: AC+VfDz1G2nS3Jg08JW5bVJ/p9pIo3c8ExCbA0KkOX9KxDGup4Eg0pDn
        W4IkY7ZC+vupNjAFG0a+wPy+cYmo9oQJuOmJUgg=
X-Google-Smtp-Source: ACHHUZ4+K75TjqDX9BQbQ/AyA2GIGg3XeRAXOWQnTvTvtdydKRJACsXbVoYlF/kRsIx7qECQ7weoVTg2PgyDKCOFWCA=
X-Received: by 2002:aca:3288:0:b0:3a0:30c9:8281 with SMTP id
 y130-20020aca3288000000b003a030c98281mr4849897oiy.16.1687405638113; Wed, 21
 Jun 2023 20:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230613092819.GA18487@didi-ThinkCentre-M930t-N000>
 <20230614091923.GA1059@didi-ThinkCentre-M930t-N000> <ZJNizvI-7A2hFDoM@slm.duckdns.org>
In-Reply-To: <ZJNizvI-7A2hFDoM@slm.duckdns.org>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Thu, 22 Jun 2023 11:47:06 +0800
Message-ID: <CAEQmJ=jW7O=EVQC7UxGSX+YDK8aTTcF3gje5HgwuTY9cnE0C2g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/isolation: add a workqueue parameter to
 constrain unbound CPUs
To:     Tejun Heo <tj@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.co,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        fuyuanli@didiglobal.com, zwp10758@gmail.com, zyhtheonly@yeah.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=8822=E6=97=A5=E5=91=
=A8=E5=9B=9B 04:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 14, 2023 at 05:19:45PM +0800, tiozhang wrote:
> ...
> > @@ -181,8 +181,8 @@ static int __init housekeeping_nohz_full_setup(char=
 *str)
> >  {
> >       unsigned long flags;
> >
> > -     flags =3D HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU=
 |
> > -             HK_FLAG_MISC | HK_FLAG_KTHREAD;
> > +     flags =3D HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MI=
SC
> > +             | HK_FLAG_KTHREAD;
>
> Why is WQ being taken out of nohz_full setup? The patch description doesn=
't
> mention anything.

To prevent nohz_full from rewriting workqueue's choice. Add a
description in patch v3.

>
> > @@ -208,6 +208,12 @@ static int __init housekeeping_isolcpus_setup(char=
 *str)
> >                       continue;
> >               }
> >
> > +             if (!strncmp(str, "workqueue,", 10)) {
> > +                     str +=3D 10;
> > +                     flags |=3D HK_FLAG_WQ;
> > +                     continue;
> > +             }
>
> I wonder whether it'd be better to just add a workqueue boot param but if

I also write a patch this way, please see '[PATCH] workqueue: add
cmdline parameter
`unbound_workqueue_cpus` to further constrain wq_unbound_cpumask at boot ti=
me'.
If you think it is better I'm happy to continue on this :)

> this works it's fine too.

It works since we use this cpumask to constrain wq_unbound_cpumask in
workqueue's early init.

>
> Thanks.
>
> --
> tejun

Thank you,
tiozhang
