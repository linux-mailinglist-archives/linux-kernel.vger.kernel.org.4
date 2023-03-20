Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2F6C24C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCTWfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCTWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:35:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2326A9;
        Mon, 20 Mar 2023 15:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79BA8B810F5;
        Mon, 20 Mar 2023 22:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05181C4339E;
        Mon, 20 Mar 2023 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679351711;
        bh=RBMxQUNea5ADmYlm3rduLO9ad3auflL6UGsTLRcfw1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J4fXMVgup7kxTLWTnzl9XA5MnmsV87BjsxSH5jNEbfd/qjO2M84oq9CLNaI1BhRXb
         3PqPcf7IAMmN1LN6KwWRGQmmZj6g8GEQMDOXunO2+Qe2oL62LT8iCLa0V+UohXIvIe
         5eu7RBpI5jqxL+VYoh9wVmyQ7wrFYN+bceEA72+eVTmi9RWSdswJjdHi1JT0FenBoZ
         nn4RaDHUl5k4UQfVkUN5z4m3FThDaA4h0A4Ha5IV+V4A0DDJur8WXkuQ0K78I8/uNW
         z0Qxluaybv1Nno2ScnR4nOZsxinfDOAYiU8KbuT6Iw4ILuYtLBuKIrQtoFPdBk+tru
         Bs8VMRkVLGmWA==
Received: by mail-ua1-f41.google.com with SMTP id i22so9035502uat.8;
        Mon, 20 Mar 2023 15:35:10 -0700 (PDT)
X-Gm-Message-State: AO0yUKX/6YauH6Fq+rCCfVTHaZLv9eNqY15xdyQWYHzWSGky8swQ99G8
        sXa06CoWnvzpin+FrmNmzaCWO+9cQtqseMF2hA==
X-Google-Smtp-Source: AK7set+Wm9QO+oJaJxQAG1SY+OV8IfLsWtsF0YID+0dnX7+z4bResGDnLBwDoMhZeLFUCoVZFDCRX+h/6tCYzMq0mh4=
X-Received: by 2002:a1f:aa87:0:b0:432:95d0:abaf with SMTP id
 t129-20020a1faa87000000b0043295d0abafmr146886vke.3.1679351709885; Mon, 20 Mar
 2023 15:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230319150027.66475-1-robh@kernel.org> <CAMuHMdXPOJZJXPKbbTb9rnQ=8e1Tmj2_GCVHwSPJHrE=9+Hqhw@mail.gmail.com>
In-Reply-To: <CAMuHMdXPOJZJXPKbbTb9rnQ=8e1Tmj2_GCVHwSPJHrE=9+Hqhw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Mar 2023 17:34:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKA-voTB1eZq3xG7j6oV-M4Cr-UaZyuQs3Yitxio3K=iw@mail.gmail.com>
Message-ID: <CAL_JsqKA-voTB1eZq3xG7j6oV-M4Cr-UaZyuQs3Yitxio3K=iw@mail.gmail.com>
Subject: Re: [PATCH] ARM: sh-mobile: Use of_cpu_node_to_id() to read CPU node 'reg'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 2:22=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> On Sun, Mar 19, 2023 at 4:00=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > Replace open coded CPU nodes reading of "reg" and translation to logica=
l
> > ID with of_cpu_node_to_id().
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!
>
> > --- a/arch/arm/mach-shmobile/platsmp-apmu.c
> > +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> > +#include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/smp.h>
> >  #include <linux/suspend.h>
> > @@ -210,7 +211,6 @@ static void apmu_parse_dt(void (*fn)(struct resourc=
e *res, int cpu, int bit))
> >         struct device_node *np_apmu, *np_cpu;
> >         struct resource res;
> >         int bit, index;
> > -       u32 id;
> >
> >         for_each_matching_node(np_apmu, apmu_ids) {
> >                 /* only enable the cluster that includes the boot CPU *=
/
> > @@ -218,33 +218,27 @@ static void apmu_parse_dt(void (*fn)(struct resou=
rce *res, int cpu, int bit))
> >
> >                 for (bit =3D 0; bit < CONFIG_NR_CPUS; bit++) {
>
> This loops over all CPUs....
>
> >                         np_cpu =3D of_parse_phandle(np_apmu, "cpus", bi=
t);

Have you looked at what this does? :)

> > -                       if (np_cpu) {
> > -                               if (!of_property_read_u32(np_cpu, "reg"=
, &id)) {
> > -                                       if (id =3D=3D cpu_logical_map(0=
)) {
> > -                                               is_allowed =3D true;
> > -                                               of_node_put(np_cpu);
> > -                                               break;
> > -                                       }
> > -
> > -                               }
> > +                       if (np_cpu && of_cpu_node_to_id(np_cpu) =3D=3D =
0) {
>
> As of_cpu_node_to_id() uses for_each_possible_cpu(), you're
> converting an O(n) operation to O(n=C2=B2).  I'm sure this can be done
> more efficiently, using for_each_possible_cpu() as the outer loop?
>
> Meh, cpu_logical_map() also loops over all CPUs, so it was already
> O(n=C2=B2)... Still, we should do better...

Can you measure the performance impact?

I would assume 'cpus' is less than NR_CPUS or possible cpus. We should
cap the outer loop based on 'cpus' length. The simplest fix is bail
when of_parse_phandle() fails. That will work unless you expect empty
entries in 'cpus':

cpus =3D <&cpu0>, <0>, <&cpu3>;

Otherwise, we'd need to use of_parse_phandle_with_fixed_args() instead
to distinguish empty entry vs. the end of the list. There is a
of_for_each_phandle() iterator which would avoid walking the 'cpus'
entry each time from the beginning, but it's a bit more complicated
since it handles arg cells.

This is the simple fix:

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c
b/arch/arm/mach-shmobile/platsmp-apmu.c
index 27cfe753c467..ec6f421c0f4d 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -218,7 +218,9 @@ static void apmu_parse_dt(void (*fn)(struct
resource *res, int cpu, int bit))

                for (bit =3D 0; bit < CONFIG_NR_CPUS; bit++) {
                        np_cpu =3D of_parse_phandle(np_apmu, "cpus", bit);
-                       if (np_cpu && of_cpu_node_to_id(np_cpu) =3D=3D 0) {
+                       if (!np_cpu)
+                               break;
+                       if (of_cpu_node_to_id(np_cpu) =3D=3D 0) {
                                is_allowed =3D true;
                                of_node_put(np_cpu);
                                break;
@@ -231,7 +233,7 @@ static void apmu_parse_dt(void (*fn)(struct
resource *res, int cpu, int bit))
                for (bit =3D 0; bit < CONFIG_NR_CPUS; bit++) {
                        np_cpu =3D of_parse_phandle(np_apmu, "cpus", bit);
                        if (!np_cpu)
-                               continue;
+                               break;

                        index =3D of_cpu_node_to_id(np_cpu);
                        if ((index >=3D 0) &&
