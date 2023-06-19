Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF573592B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjFSOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFSOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:08:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DCAB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:08:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so40579631fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687183728; x=1689775728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qxdbmd0dtQii5u90bRB5V0bWnJ9bzdUnyOROyNZnIhw=;
        b=E3mHbkSB27JCa80iuDg8Vr+HPDpn+9g2v80cy0b4U+fdHCR+jd4kcf1ocbg4WgNaYt
         vrmWCsbpqDVHCAkR1SRvsl6ap3KOgtCw0JSPkVc6MP/ngJygwhyMsmcmRgkX5sWlDeja
         qTJWuzfcpL13UNrhKtDV8VcRNoxMpxMkF/KCKV1jmmUmQCrJpwXBa7jKxtj8xN79xgYR
         p6laC0fZfvdKXJGyo2pJQs8jZONjf3M0PNwHpDkGMI5ygX8gfg5mZdnZwduuK85UmUWl
         ponUXKguiyioB0ID9zWl6K+WQ65AcC7zNbe1DbSer4WwfaZl0ivwKtjfkllPBDzt0eVk
         IjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687183728; x=1689775728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qxdbmd0dtQii5u90bRB5V0bWnJ9bzdUnyOROyNZnIhw=;
        b=JF5oQEE4ZGFTkj+yrq8IWLE4nMXH0516vbXNe5y+qe3bTgaTZ1oVHJtwF/R4UUJpis
         gwr2Kn47tLqIJQQcSj4zALm/buKn1S+sFYLE683vS3uRRUA6AiczFTHzu+V4fwI68oIm
         ESRwb7ANhTsaW6rBj0BeyglQTHjSJfc6N9UYMAAG3IiXBAMvHnO8OH8eIezZWpggpCUR
         GK14DCSxGyRBWUefSVjXLJeYKoX7PMy7meuyBoRQVW3iZUQUUj3w1FSa+sJVlmJgqSMX
         +qPMDolUPTFLz1MExGsdvwt/y0XuIGmNLVxAsFLjBFzTZnxpc8k4a/+qBBelHs0Jq2TK
         5NtQ==
X-Gm-Message-State: AC+VfDwfz8HHOeTpbHKwEwcCzsKplA6ysRNd487ScuPDwWJ/98XVzYhz
        et9MjaR4MrUXhWxWtsMtrOs/0CHkUw0TTG2t7dERmw==
X-Google-Smtp-Source: ACHHUZ6sBGquxiFX0iVmiiTRyL/rAw03oe2SEkpL3A2oHs32rfSEJaiZC/HS7yWdWNL8sYG4PLshha23OYZRPARCmMw=
X-Received: by 2002:a2e:7003:0:b0:2b4:70b1:af01 with SMTP id
 l3-20020a2e7003000000b002b470b1af01mr2643840ljc.20.1687183728524; Mon, 19 Jun
 2023 07:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-3-eric.lin@sifive.com>
 <ae77d0ce-9a54-d779-daa2-c429631c8bb7@wanadoo.fr>
In-Reply-To: <ae77d0ce-9a54-d779-daa2-c429631c8bb7@wanadoo.fr>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Mon, 19 Jun 2023 22:08:36 +0800
Message-ID: <CAPqJEFrX=ayJY-S+41Uk4TvEDAta_whSEq-P=Ef1Y4NsTzd8CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, maz@kernel.org, will@kernel.org,
        nnac123@linux.ibm.com, pierre.gondois@arm.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Jun 17, 2023 at 3:05=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 16/06/2023 =C3=A0 08:32, Eric Lin a =C3=A9crit :
> > From: Greentime Hu <greentime.hu@sifive.com>
> >
> > This adds SiFive private L2 cache PMU driver. User
> > can use perf tool to profile by event name and event id.
> >
> > Example:
> > $ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
> >                  -e /sifive_pl2_pmu/inner_acquire_block_ntob/
> >                  -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls
> >
> >   Performance counter stats for 'CPU(s) 0':
> >
> >                 300      sifive_pl2_pmu/inner_acquire_block_btot/
> >               17801      sifive_pl2_pmu/inner_acquire_block_ntob/
> >                5253      sifive_pl2_pmu/inner_acquire_block_ntot/
> >
> >         0.088917326 seconds time elapsed
> >
> > $ perf stat -C 0 -e /sifive_pl2_pmu/event=3D0x10001/
> >                  -e /sifive_pl2_pmu/event=3D0x4001/
> >                  -e /sifive_pl2_pmu/event=3D0x8001/ ls
> >
> >   Performance counter stats for 'CPU(s) 0':
> >
> >                 251      sifive_pl2_pmu/event=3D0x10001/
> >                2620      sifive_pl2_pmu/event=3D0x4001/
> >                 644      sifive_pl2_pmu/event=3D0x8001/
> >
> >         0.092827110 seconds time elapsed
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
> > ---
>
> [...]
>
> > +int sifive_pl2_pmu_probe(struct device_node  *pl2_node,
> > +                      void __iomem *pl2_base, int cpu)
> > +{
> > +     struct sifive_pl2_pmu_event *ptr =3D per_cpu_ptr(&sifive_pl2_pmu_=
event, cpu);
> > +     int ret =3D -EINVAL;
>
> Nit: no need to init
>

OK, I will fix it in v2.

> > +
> > +     /* Get counter numbers. */
> > +     ret =3D of_property_read_u32(pl2_node, "sifive,perfmon-counters",=
 &ptr->counters);
> > +     if (ret) {
> > +             pr_err("Not found sifive,perfmon-counters property\n");
> > +             goto early_err;
> > +     }
> > +     pr_info("perfmon-counters: %d for CPU %d\n", ptr->counters, cpu);
> > +
> > +     /* Allocate perf_event. */
> > +     ptr->events =3D kcalloc(ptr->counters, sizeof(struct perf_event),=
 GFP_KERNEL);
> > +     if (!ptr->events)
> > +             return -ENOMEM;
> > +
> > +     ptr->event_select_base =3D pl2_base + SIFIVE_PL2_SELECT_BASE_OFFS=
ET;
> > +     ptr->event_counter_base =3D pl2_base + SIFIVE_PL2_COUNTER_BASE_OF=
FSET;
> > +
> > +     if (!pl2pmu_init_done) {
> > +             ret =3D perf_pmu_register(sifive_pl2_pmu.pmu, sifive_pl2_=
pmu.pmu->name, -1);
> > +             if (ret) {
> > +                     cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_S=
IFIVE_PL2_PMU_ONLINE,
> > +                                                 &sifive_pl2_pmu.node)=
;
> > +                     pr_err("Failed to register sifive_pl2_pmu.pmu: %d=
\n", ret);
> > +             }
> > +             sifive_pl2_pmu_pm_init();
> > +             pl2pmu_init_done =3D true;
> > +     }
> > +
> > +     return 0;
> > +
> > +early_err:
> > +     return ret;
> > +}
> > +
> > +int sifive_pl2_pmu_init(void)
> > +{
> > +     int ret =3D 0;
>
> Nit: no need to init

OK, I will fix it in v2.

>
> > +
> > +     ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_SIFIVE_PL2_PM=
U_ONLINE,
> > +                                   "perf/sifive/pl2pmu:online",
> > +                                   sifive_pl2_pmu_online_cpu,
> > +                                   sifive_pl2_pmu_offline_cpu);
> > +     if (ret)
> > +             pr_err("Failed to register CPU hotplug notifier %d\n", re=
t);
> > +
> > +     ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_SIFIVE_PL2_P=
MU_ONLINE,
> > +                                    &sifive_pl2_pmu.node);
> > +     if (ret)
> > +             pr_err("Failed to add hotplug instance: %d\n", ret);
> > +
> > +     return ret;
>
> Nit: return 0;

OK, I will fix it in v2.

Thanks for your review.

Best regards,
Eric Lin

>
> > +}
>
> [...]
>
