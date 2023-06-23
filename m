Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE273B419
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjFWJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:49:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC8E48
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:49:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b479d53d48so7676161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687513775; x=1690105775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxUDNtmQR8JwrlnuU0Ur6WjlOeutON60uUnD6jBAYPg=;
        b=drmVYpNNrJi6VclAki+iipR4Vh561Y7dXfaU/l4PfsFiKd0P8xiSmY46+9zB/NneDh
         myY9DtYY26tkbHkjTWfCLEcDHmiOxV9vqjOtDf/U84iRinn8lRuY8gPPS4W8gYZFcIlb
         3V9acKI5siMa8E/5YApiOK5detcrHiLF828joWiR8wuHRhNAoFZJH6A1LMdPLeGIdDG/
         8MTgSAY3M8EGDqrmL/12d9GbR1x1E8kAB/X+TOA11UDK+YPPuJOWpjdRDMAV/NG3RXkB
         iIVCxljOJKwl83fhp4SyqGdn5WWpE6njhp/C6dSlCaw5jue9NcFz1Y5aNLiuI1wwQUYT
         2l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513775; x=1690105775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxUDNtmQR8JwrlnuU0Ur6WjlOeutON60uUnD6jBAYPg=;
        b=LY4JUlQBeHJVF0oxaW2yVNU5mWseDTOx0KGb7AscS9EEOqr1f3+XhAerP2HD5Z+mo1
         Tf0d4FrOOY2nclZ/9gjztxSG2HRCvyL6WuXkEtQ7K13xeark0gWIzXA6BI09Y9ep4fM/
         DERpV6VlkIAfeBeRrFpdJ61+K51aXNF4NlKERCaQtEa1guRC2LVoOotjIgRuxENW+vER
         if88InnYpzYFtHfGsJfV6+CV1wNwH95JEh8MdSwjX2AILYi6khM9LHNBtiA7NKrWNZXy
         +vDtElVu7XxPSX0TmoTpetEsJoyobC8hKt2XKbltx9RCIsy9uCBuixFG/O9YXc6VR1fN
         9bAA==
X-Gm-Message-State: AC+VfDzJGZowSZ23ByhnJQwGJb5FauVv0k6P3qDx6aTrUXDhVFgFUJAb
        HWUNHqq/4Ac0RMbU9ktb5IlwrJf222Sr7FYO6i3wlQ==
X-Google-Smtp-Source: ACHHUZ6igxv4uU2dw/LOnMIEy0seWcw7fzf6D62DorOP05lRSek7qsIFNNV9/Ulj1ybBTnaS2Q5pBFdL1f8igGCwGK4=
X-Received: by 2002:a2e:961a:0:b0:2b5:7a97:d50e with SMTP id
 v26-20020a2e961a000000b002b57a97d50emr7700326ljh.41.1687513774969; Fri, 23
 Jun 2023 02:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-2-eric.lin@sifive.com>
 <20230616-errand-glutton-f64783da058c@spud>
In-Reply-To: <20230616-errand-glutton-f64783da058c@spud>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Fri, 23 Jun 2023 17:49:22 +0800
Message-ID: <CAPqJEFr1FfuHYX=BP3BXAsZ0V4JFDqzu7_jjPVgcijOFQzddmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: sifive: Add SiFive private L2 cache support
To:     Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, maz@kernel.org, chenhuacai@kernel.org,
        baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Nick Hu <nick.hu@sifive.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Sat, Jun 17, 2023 at 5:05=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Eric,
>
> On Fri, Jun 16, 2023 at 02:32:08PM +0800, Eric Lin wrote:
> > This adds SiFive private L2 cache driver which will show
> > cache config information when booting and add cpu hotplug
> > callback functions.
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
>
> Missing a Co-developed-by for Nick?

Yes, I'll add Co-developed-by for Nick in v2. Thanks.

>
>
> > +static void pl2_config_read(void __iomem *pl2_base, int cpu)
> > +{
> > +     u32 regval, bank, way, set, cacheline;
> > +
> > +     regval =3D readl(pl2_base);
> > +     bank =3D regval & 0xff;
> > +     pr_info("in the CPU: %d\n", cpu);
> > +     pr_info("No. of Banks in the cache: %d\n", bank);
> > +     way =3D (regval & 0xff00) >> 8;
> > +     pr_info("No. of ways per bank: %d\n", way);
> > +     set =3D (regval & 0xff0000) >> 16;
> > +     pr_info("Total sets: %llu\n", (uint64_t)1 << set);
> > +     cacheline =3D (regval & 0xff000000) >> 24;
> > +     pr_info("Bytes per cache block: %llu\n", (uint64_t)1 << cacheline=
);
> > +     pr_info("Size: %d\n", way << (set + cacheline));
> > +}
>
> Isn't this basically all information that we get anyway in sysfs based
> on what gets put into the DT, except printed out once per CPU at
> boottime?
> If there's reason to keep it, please do as suggested by Ben and cut down
> the number of lines emitted. Look at the ccache one for comparison:
>         static void ccache_config_read(void)
>         {
>                 u32 cfg;
>
>                 cfg =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
>                 pr_info("%llu banks, %llu ways, sets/bank=3D%llu, bytes/b=
lock=3D%llu\n",
>                         FIELD_GET(SIFIVE_CCACHE_CONFIG_BANK_MASK, cfg),
>                         FIELD_GET(SIFIVE_CCACHE_CONFIG_WAYS_MASK, cfg),
>                         BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_SETS_MASK,=
 cfg)),
>                         BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_BLKS_MASK,=
 cfg)));
>
>                 cfg =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
>                 pr_info("Index of the largest way enabled: %u\n", cfg);
>         }
> It'd also be good to print the same things as the ccache, no?
>

Yes, I'll cut down the number of lines as the ccache in v2. Thanks for
the suggestion.

> > +static int sifive_pl2_cache_dev_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *res;
> > +     int cpu, ret =3D -EINVAL;
> > +     struct device_node *cpu_node, *pl2_node;
> > +     struct sifive_pl2_state *pl2_state =3D NULL;
> > +     void __iomem *pl2_base;
>
> Please pick a sensible ordering for variables. IDC if it is reverse xmas
> tree, or sorting by types, but this just seems quite random..
>

Yes, I'll sort by type in v2.

> > +     /* Traverse all cpu nodes to find the one mapping to its pl2 node=
. */
> > +     for_each_cpu(cpu, cpu_possible_mask) {
> > +             cpu_node =3D of_cpu_device_node_get(cpu);
> > +             pl2_node =3D of_parse_phandle(cpu_node, "next-level-cache=
", 0);
> > +
> > +             /* Found it! */
> > +             if (dev_of_node(&pdev->dev) =3D=3D pl2_node) {
> > +                     /* Use cpu to get its percpu data sifive_pl2_stat=
e. */
> > +                     pl2_state =3D per_cpu_ptr(&sifive_pl2_state, cpu)=
;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!pl2_state) {
> > +             pr_err("Not found the corresponding cpu_node in dts.\n");
>
> I don't think this error message is going to be helpful in figuring out
> where the problem is on a machine with many of the caches. More
> information about *which* cache caused it would be good.
> Also it is not grammatically correct, it should read something like
> "Failed to find CPU node for cache@abc" or something along those lines.
>

OK, I'll rewrite the error message to make it more helpful for the user.
I'll fix it in v2. Thanks for the suggestion.

> > +             goto early_err;
>
> early_err just returns ret. Why not just return the error directly?
>

Yeah, it can just return ret. I'll fix it in v2.

> > +     }
> > +
> > +     /* Set base address of select and counter registers. */
> > +     pl2_base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res=
);
> > +     if (IS_ERR(pl2_base)) {
> > +             ret =3D PTR_ERR(pl2_base);
> > +             goto early_err;
> > +     }
> > +
> > +     /* Print pL2 configs. */
> > +     pl2_config_read(pl2_base, cpu);
> > +     pl2_state->pl2_base =3D pl2_base;
> > +
> > +     return 0;
> > +
> > +early_err:
> > +     return ret;
> > +}
>
> > +static struct platform_driver sifive_pl2_cache_driver =3D {
> > +     .driver =3D {
> > +                .name =3D "SiFive-pL2-cache",
> > +                .of_match_table =3D sifive_pl2_cache_of_ids,
> > +                },
> > +     .probe =3D sifive_pl2_cache_dev_probe,
> > +};
> > +
> > +static int __init sifive_pl2_cache_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D cpuhp_setup_state(CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
> > +                             "soc/sifive/pl2:online",
> > +                                   sifive_pl2_online_cpu,
> > +                                   sifive_pl2_offline_cpu);
>
> Got some weird use of whitespace here & above, please remove the spaces.
>

Yes, I'll remove the whitespace in v2.
Thanks for the review.

Best Regards,
Eric Lin.

> Cheers,
> Conor.
