Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0285732112
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjFOUqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOUqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:46:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39F271E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:46:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9a81da5d7so78521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686861991; x=1689453991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXkt2ZBGU5jZyQ4WPhoCS7lB4yMdQci0tXI9tZaRrDU=;
        b=VPDs1chprSogpzpFP36IMnSxKMQrt703kO5bMV14QmFX+mMfQWvD6k1MQe9SpXt8JN
         5YltQ9sjq3koyeq+fBA66GSKE7XMlhWNL+JL3RpiE7c4I22f28WhlakVexRJFVME5vM0
         tH95JmlXiERSIWwRGsh5TG3aoAZ0KWRqRcZMjNbj2MKzAilmKL9Ao/wFgQKIWWrcMp8o
         3l9iH6gd4j2gro6IWsBZkixJ9eAl+xG8fbD5hYXfNQoXBRfW8AYYMCljCft5rKqp971P
         59kkTeIwjyg2Vh/PwXI4YjqaPHmwKadAH3OBCn+HyxdfkVc8q2DF2Zbrgtur+LqwbU3r
         kdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686861991; x=1689453991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXkt2ZBGU5jZyQ4WPhoCS7lB4yMdQci0tXI9tZaRrDU=;
        b=E3FExCwh4zmhOdr/aWa+EYdhq+mIDWPGs4VXD9Wj3oYJeEF9AGGToraRM4RrwFyyeN
         oD9IkoEwCGzQdVs4O18HsjOsad+h1XzA9RP5hkAS5NbHmbxQf0RHk2npwiIvG5V63mQz
         Xl5ofGPIxIudEqhYx1QRB6+wVlCkF6rdBMdGBGsI5fMG2FxonXreDKr6Kx9v+xMyEXrU
         NArbsKUJHAv/7Q8f0/rnvaXqZhPN7vznNhoccpfhRGxl7lQsIizGw9ZYgUm2/Z46gHV4
         ctipXHuGShzPcKykqDlO6eOjMFch1/YsDVODRr+hKYP20s/J1v7MkAIifjltE42Q2gia
         MQKA==
X-Gm-Message-State: AC+VfDyojHjQdRjnSdNuJPOIoZUQBzzOV19Kf5Z3EvyhEyvWjR6vhm+0
        7cWD4uAJeM4Nga4pVLxPzpASmkXirJ/0lrqVHsDuJA==
X-Google-Smtp-Source: ACHHUZ4N/OwMTET2iljPnw6bbFSnqZMbHyS/G+s/58wtd3yW9j+pXrcF30ZUaVJErUv1ftafp7Gv3leEoaxgWev+1RE=
X-Received: by 2002:a05:622a:44:b0:3f9:f877:1129 with SMTP id
 y4-20020a05622a004400b003f9f8771129mr320926qtw.29.1686861991150; Thu, 15 Jun
 2023 13:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-9-apatel@ventanamicro.com> <CAGETcx-hoPNanAwe4++6roqBXwSdc7z6Ei=-r9z6qFG1U7xVXg@mail.gmail.com>
 <20230615-thyself-doornail-f0545ada9176@spud>
In-Reply-To: <20230615-thyself-doornail-f0545ada9176@spud>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 15 Jun 2023 13:45:55 -0700
Message-ID: <CAGETcx__Qt868abh-F_fu7ijMSWXciLjdjWiWf60e4_p78xb8w@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] irqchip: Add RISC-V advanced PLIC driver
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:31=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey Saravana,
>
> On Thu, Jun 15, 2023 at 12:17:08PM -0700, Saravana Kannan wrote:
> > On Tue, Jun 13, 2023 at 8:35=E2=80=AFAM Anup Patel <apatel@ventanamicro=
.com> wrote:
>
> btw, please try to delete the 100s of lines of unrelated context when
> replying

I always feel like some people like me to do this and others don't.
Also, at times, people might want to reference the other lines of code
when replying to my point. That's why I generally leave them in.

>
> > > +static int __init aplic_dt_init(struct device_node *node,
> > > +                               struct device_node *parent)
> > > +{
> > > +       /*
> > > +        * The APLIC platform driver needs to be probed early
> > > +        * so for device tree:
> > > +        *
> > > +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode which
> > > +        *    provides a hint to the device driver core to probe the
> > > +        *    platform driver early.
> > > +        * 2) Clear the OF_POPULATED flag in device_node because
> > > +        *    of_irq_init() sets it which prevents creation of
> > > +        *    platform device.
> > > +        */
> > > +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> >
> > NACK. You are blindly plastering flags without trying to understand
> > the real issue and fixing this correctly.
> >
> > > +       of_node_clear_flag(node, OF_POPULATED);

Also, this part is not needed if the macros I mentioned below are used.

> > > +       return 0;
> > > +}
> > > +IRQCHIP_DECLARE(riscv_aplic, "riscv,aplic", aplic_dt_init);
> >
> > This macro pretty much skips the entire driver core framework to probe
> > and calls init and you are supposed to initialize the device when the
> > init function is called.
> >
> > If you want your device/driver to follow the proper platform driver
> > path (which is recommended), then you need to use the
> > IRQCHIP_PLATFORM_DRIVER_BEGIN() and related macros. Grep for plenty of =
examples.
> >
> > I offered to help you debug this issue and I asked for a dts file that
> > corresponds to a board you are testing this on and seeing an issue.
>
> There isn't a dts file for this because there's no publicly available
> hardware that actually has an APLIC. Maybe Ventana have pre-production
> silicon that has it, but otherwise it's a QEMU job.

1. QEMU example is fine too if it can be reproduced. I just asked for
a dts file because I need the full global view of the dependencies. At
a minimum, I'd at least expect to see some example DT and explanation
of what dependency is causing the IRQ device to not be initialized on
time, etc. Instead I just see random uses of flags with no description
of the actual issue.

2. If it's not a dts available upstream, why should these drivers be
accepted? I thought the norm was to only accept drivers that can
actually be used.

-Saravana

>
> Cheers,
> Conor.
>
> > But you haven't answered my question [1] and are pointing to some
> > random commit and blaming it. That commit has no impact on any
> > existing devices/drivers.
> >
> > Hi Marc,
> >
> > Please consider this patch Nacked as long as FWNODE_FLAG_BEST_EFFORT
> > is used or until Anup actually works with us to debug the real issue.
> >
> > -Saravana
> > [1] - https://lore.kernel.org/lkml/CAAhSdy2p6K70fc2yZLPdVGqEq61Y8F7WVT2=
J8st5mQrzBi4WHg@mail.gmail.com/
