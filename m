Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6151172984C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjFILlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjFILlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:41:01 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C130ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:40:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso4000447276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686310858; x=1688902858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJt3feXs6SxyQtoTGkEhwKTgAeqCp1KzPotYyZ8bIc4=;
        b=Y1My6pemRG3jJeTY2XZLEGCaA4W6dI+/ilaXi1H7/t5ar1Xt08MRq8dPmkoDStDMXm
         kT2xMT9WUoCFhPjjVnNLR8FpVjjfLYljLuWfy8+gOcf4qMNF/4Tck3DfURhGh74b+61z
         5GXCx94pwXORCfv023PbhMTxYlyvhBya7BIUcVnWvxxeGZcEgH5TX6NbHW18bpW1nuGw
         Zu7ssPlBukM6546UMTV8PcfcFD6llsNDuNBHHzOZtqi1Ok3QZgWECjoiRzVFRgFzyVHD
         DMbQV34S2wEd4j9azFOrRar6xAS/7Ve1/EQCLv7a1Gpoq0xRaDBwip/8ZWJP5a1jFG/J
         z5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310858; x=1688902858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJt3feXs6SxyQtoTGkEhwKTgAeqCp1KzPotYyZ8bIc4=;
        b=UodhOEcHpTGwBnclItFxl5+MbF8vcAzTJktWRlqKx+jSLG1fUUc9/tqyVaq256DMBO
         dQHqOyXejLHgT37+WlayfzibPe+aazxyKtIoKrHyg0kOGKV2hymfj3W9Z2RKvLh09KYr
         94dpjjZUURn+Gr1WipJeGCk900dTf2t30PZOT+Kb4+tlkhKBHGx55Xn4hrzpd+Lqa/Z+
         Tq3Iqer5ApQaM1pLVIvE6lMv1oG1sEiaianBoMvn/lKWtVR9ocBlTbWYxTzRCbfRFZut
         R+sWZeJhUx1N3dNy0OIdVnBm3RzkPX3rzH/k7TlF1P1ejSETZvZ+7Dzc97goU+/L3GfE
         0F+g==
X-Gm-Message-State: AC+VfDw1b7OPbiCnNILUbt4k4mYQoOwXRhDmiw6E/mGizTjVZ7cEM+lb
        E4Pq0sZlwlltgDGC9RSHdFf/pIU0C0DiKIviTIcPAQ==
X-Google-Smtp-Source: ACHHUZ6tcnye369zFXBV2bBHJWRzfVKRU8NYtwA27HSSc5WJJxk9tivdQDX48v29djspGuooSVUxeE1q+GAIw2Q6QXE=
X-Received: by 2002:a81:4e4e:0:b0:568:ed48:21bb with SMTP id
 c75-20020a814e4e000000b00568ed4821bbmr1746710ywb.13.1686310857937; Fri, 09
 Jun 2023 04:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-3-apatel@ventanamicro.com> <20230608182828.GA3183987-robh@kernel.org>
 <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com>
In-Reply-To: <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 9 Jun 2023 17:10:45 +0530
Message-ID: <CAK9=C2V1LH0739Nq5Ji7gGbgbyFtNAtBYR43fU7vr9omD5tKSA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the
 interrupt controller DT nodes
To:     Saravana Kannan <saravanak@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 1:35=E2=80=AFAM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Thu, Jun 8, 2023 at 11:28=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > +Saravana
> >
> > On Mon, May 08, 2023 at 07:58:33PM +0530, Anup Patel wrote:
> > > The RISC-V APLIC interrupt controller driver is a regular platform
> > > driver so we need to ensure that it is probed as soon as possible.
> > > To achieve this, we mark the interrupt controller device nodes with
> > > FWNODE_FLAG_BEST_EFFORT (just like console DT node).
> > >
> > > Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to mark=
 devices as best effort")
> >
> > It is good practice to Cc the commit author of what you are fixing.
> >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  drivers/of/irq.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > > index 174900072c18..94e1d9245cff 100644
> > > --- a/drivers/of/irq.c
> > > +++ b/drivers/of/irq.c
> > > @@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device_i=
d *matches)
> > >       INIT_LIST_HEAD(&intc_desc_list);
> > >       INIT_LIST_HEAD(&intc_parent_list);
> > >
> > > +     /*
> > > +      * We need interrupt controller platform drivers to work as soo=
n
> >
> > If it's platform drivers/devices you care about, then perhaps this
> > should be done when platform devices are created.
> >
> > > +      * as possible so mark the interrupt controller device nodes wi=
th
> > > +      * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> > > +      * the probe of the interrupt controller device for suppliers
> > > +      * without drivers.
> > > +      */
> > > +     for_each_node_with_property(np, "interrupt-controller")
> >
> > This function only operates on nodes matching 'matches', but this
> > operates on everything.
> >
> > It does make sense that if we init an interrupt controller here, then w=
e
> > will surely want to probe its driver later on. So maybe just move
> > setting FWNODE_FLAG_BEST_EFFORT within
> > for_each_matching_node_and_match() below.
> >
> > > +             np->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > > +
>
> Definite Nack. You are pretty much disabling fw_devlink for all
> interrupt controllers. There are plenty of examples of the IRQ drivers
> being needed very early on and still probing properly without the need
> for this flag. Please fix your driver/DT.

Okay, I will try to set FWNODE_FLAG_BEST_EFFORT only for
APLIC device_node via IRQCHIP_DECLARE().

Regards,
Anup


>
> -Saravana
>
>
> > >       for_each_matching_node_and_match(np, matches, &match) {
> > >               if (!of_property_read_bool(np, "interrupt-controller") =
||
> > >                               !of_device_is_available(np))
> > > --
> > > 2.34.1
> > >
