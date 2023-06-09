Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2F72A541
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjFIVSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:18:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48135A3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:17:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9d619103dso8561cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686345477; x=1688937477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRAQr078BUUokwlWeruPfu3tXC8xw/eiJppeWzlI2XY=;
        b=3FYxoqPq77YWBq1uXh5PHe0KR04muNees/64GTBJ3WLOoddlZZJOWQ9cCs1QmEc6jA
         KTKvl5SIxzSAQ84C49Wp9W/PmWEKisRx/aTZ8dxyaVuWokCmQ1f0SXhS3205hWmUBWf0
         JqyvxXyej0s+pxNiPsGjks7W83JbtWcDdw3IH4SEaz52jhKy0GI580f8KAV1JxxACOkT
         YzsthLYJuDlIBxazBhBfwLMYaGXjqEUv2bnrkr4zq2If1RvB7US/VJsAngtbSL9Eh1BB
         RvyfAuEl1sgzdM/YBgIcySSzylAIWRbgfYkwfzdMvPTtxjdqAGFdMvbF7QRJ68pPGD7q
         PjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686345477; x=1688937477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRAQr078BUUokwlWeruPfu3tXC8xw/eiJppeWzlI2XY=;
        b=B6eBIDGTphLCD3L0R85mkaaXw4TCgnm00B34lJtVhedts5bXP9AJPPw1oXDK0s5m3o
         PYNfeqUmSSXLH91J1wUx3En6n87GmMWy4V+lwCQiNnXvZgPMKmr6IOt3AJs7BrSyxrq1
         hMbuKrIWEYH7Zl5wt5kEbXrSBJScbQ2k6gTAWB72lQpWCFMk2rZuMncJdbnlZ4B6OSaO
         4Ms63yotcyTv7m0GfFMIxtFtXhudkZ7FfWapO3aEwZ/TgSJGfTLPBIkPaTk9PH3++bUr
         ORkauBKhYVJhiYfRBFYpbHsdgYda2ZUlcyiQJ3rIbPDJMxjRuIQj0YBCOjnW7XpmCJFB
         HUEA==
X-Gm-Message-State: AC+VfDwsPIcc5Dd6YJFESE2kSWWyP6amFhs7y/1vtMRN8JWkBDSpA9fS
        tK2qoMs25wCE84KUXt86tEHa/R4DOL1ZCp8R5v2M4g==
X-Google-Smtp-Source: ACHHUZ7Mn1+bgpCnLIc/VkQ8WULvWZFq0p8HGTm7OUv0T7eX+3mfTWyw5RHUXrEDbgxLlANAQhZYqvg2Jlya4CHYamc=
X-Received: by 2002:a05:622a:2c6:b0:3ef:2f55:2204 with SMTP id
 a6-20020a05622a02c600b003ef2f552204mr26088qtx.6.1686345477542; Fri, 09 Jun
 2023 14:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-3-apatel@ventanamicro.com> <20230608182828.GA3183987-robh@kernel.org>
 <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com> <CAK9=C2V1LH0739Nq5Ji7gGbgbyFtNAtBYR43fU7vr9omD5tKSA@mail.gmail.com>
In-Reply-To: <CAK9=C2V1LH0739Nq5Ji7gGbgbyFtNAtBYR43fU7vr9omD5tKSA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 9 Jun 2023 14:17:21 -0700
Message-ID: <CAGETcx--aEEB6ag1qGcEeygPyZM9Q-T1NOY+wK911LGJGisN8Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the
 interrupt controller DT nodes
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Rob Herring <robh@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 4:40=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> On Fri, Jun 9, 2023 at 1:35=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > On Thu, Jun 8, 2023 at 11:28=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > +Saravana
> > >
> > > On Mon, May 08, 2023 at 07:58:33PM +0530, Anup Patel wrote:
> > > > The RISC-V APLIC interrupt controller driver is a regular platform
> > > > driver so we need to ensure that it is probed as soon as possible.
> > > > To achieve this, we mark the interrupt controller device nodes with
> > > > FWNODE_FLAG_BEST_EFFORT (just like console DT node).
> > > >
> > > > Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to ma=
rk devices as best effort")
> > >
> > > It is good practice to Cc the commit author of what you are fixing.
> > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  drivers/of/irq.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > > > index 174900072c18..94e1d9245cff 100644
> > > > --- a/drivers/of/irq.c
> > > > +++ b/drivers/of/irq.c
> > > > @@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device=
_id *matches)
> > > >       INIT_LIST_HEAD(&intc_desc_list);
> > > >       INIT_LIST_HEAD(&intc_parent_list);
> > > >
> > > > +     /*
> > > > +      * We need interrupt controller platform drivers to work as s=
oon
> > >
> > > If it's platform drivers/devices you care about, then perhaps this
> > > should be done when platform devices are created.
> > >
> > > > +      * as possible so mark the interrupt controller device nodes =
with
> > > > +      * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to del=
ay
> > > > +      * the probe of the interrupt controller device for suppliers
> > > > +      * without drivers.
> > > > +      */
> > > > +     for_each_node_with_property(np, "interrupt-controller")
> > >
> > > This function only operates on nodes matching 'matches', but this
> > > operates on everything.
> > >
> > > It does make sense that if we init an interrupt controller here, then=
 we
> > > will surely want to probe its driver later on. So maybe just move
> > > setting FWNODE_FLAG_BEST_EFFORT within
> > > for_each_matching_node_and_match() below.
> > >
> > > > +             np->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > > > +
> >
> > Definite Nack. You are pretty much disabling fw_devlink for all
> > interrupt controllers. There are plenty of examples of the IRQ drivers
> > being needed very early on and still probing properly without the need
> > for this flag. Please fix your driver/DT.
>
> Okay, I will try to set FWNODE_FLAG_BEST_EFFORT only for
> APLIC device_node via IRQCHIP_DECLARE().

No, my point is that you very likely don't need to use that flag.

What exactly is the problem you are facing? Point to an example RISC-V
dts (not dtsi) in upstream and give specifics please.

-Saravana
