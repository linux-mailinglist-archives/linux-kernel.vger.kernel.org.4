Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A969C46A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBTDPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBTDPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:15:42 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F3C14B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:15:41 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id i24so875054vkk.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDEo7h14JCqjFZhX9T9o37K1/31fniHrrScLeZaTu44=;
        b=iwTYhHPzEmsEYTsJ38WY7NZ9WL0o7hbRKDkv+cgmSVaE2uoSciZmW70L9fmjw26p2C
         yyfWgWPclCkgM71Ho2+n4ptR08pLTqmCt7l5oHWekRShFF3rLK++OK/XVyUbYcHK+0c3
         J299bPGl/FHqFdgLeIaI8HU+g6iwzvbnNgWQ8boH6WsxgpWBrHNiTy+nJlTsKOk3zICf
         7upg4roVGRkbgul1SOTb/JScpnpO299x9rEeH3yGRQZJAi7e5+uHmcYl1nX2WJPLkwG+
         dzydwyc8fonnWyAEP4apnXaMI/DQcMkyyHI6XNl7wVRxlr90ufygyWTW1QViqThTlewh
         sy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDEo7h14JCqjFZhX9T9o37K1/31fniHrrScLeZaTu44=;
        b=emLHjS3489UivQTqmvC5c4FIKj4snp1qXK7WiFVwDrUkYysTGoIe1XRZg2jUMdCSm5
         huYU0vN52sH5Uz9ghakQYlYWOppwTmR1/FhsbQXlI+qjdykR7ns5FqmoHOfVU49bB3T8
         CJ1wrmUcuanVH8VVYjZjtH3y2IKVSyOf1Oe8dfeZ19/zzCtP/oJ05hpbK11xOEFswD1O
         ZIC8aQ1Lzt9lyYI+oxxD7I+OyjCu6KPf5niUOwEQ2JqEHtAShGnQxnNvy1lqk2BwtmUN
         j5z/+/0AqkVMX3WwdCiv6HYXUXGcXDrK+zJyLAVU60VlSjrQex3e6TSOmWRdTaLclP6J
         1NhA==
X-Gm-Message-State: AO0yUKVDHALDs86H95pdR/wRMalgOHd7l2vBe+8cesuIPc4CSJcoDqX8
        PxFx3/RgSLpg7v2k5ur8Co+ZSkCyFpKuAKGDKJgghQ==
X-Google-Smtp-Source: AK7set+NMrUhJmp47RKiMI0WwF/B4IjKr/OM5C9J0CG4b84WmRB/0szDBNaOmRhNMMUCW/p8YcNtiRuVpTm12Pn2BHQ=
X-Received: by 2002:a1f:a682:0:b0:3d5:9b32:7ba4 with SMTP id
 p124-20020a1fa682000000b003d59b327ba4mr85115vke.15.1676862939933; Sun, 19 Feb
 2023 19:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-5-apatel@ventanamicro.com> <Y7YJ9j9a+DQVF/dp@spud>
In-Reply-To: <Y7YJ9j9a+DQVF/dp@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 20 Feb 2023 08:45:28 +0530
Message-ID: <CAK9=C2WZ-RGQNK2p6AJwRKZ5mknh2A7DGN_GvTPtu1k2BuahmQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 4:51 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Anup,
>
> On Tue, Jan 03, 2023 at 07:44:04PM +0530, Anup Patel wrote:
> > We add DT bindings document for the RISC-V incoming MSI controller
> > (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> > specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
> > +  for each privilege level (machine or supervisor).
>
> > +  The device tree of a RISC-V platform will have one IMSIC device tree node
> > +  for each privilege level (machine or supervisor) which collectively describe
> > +  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
>
> > +examples:
> > +  - |
> > +    // Example 1 (Machine-level IMSIC files with just one group):
> > +
> > +    imsic_mlevel: interrupt-controller@24000000 {
> > +      compatible = "riscv,qemu-imsics", "riscv,imsics";
> > +      interrupts-extended = <&cpu1_intc 11>,
> > +                            <&cpu2_intc 11>,
> > +                            <&cpu3_intc 11>,
> > +                            <&cpu4_intc 11>;
> > +      reg = <0x28000000 0x4000>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <0>;
> > +      msi-controller;
> > +      riscv,num-ids = <127>;
> > +    };
> > +
> > +  - |
> > +    // Example 2 (Supervisor-level IMSIC files with two groups):
> > +
> > +    imsic_slevel: interrupt-controller@28000000 {
> > +      compatible = "riscv,qemu-imsics", "riscv,imsics";
> > +      interrupts-extended = <&cpu1_intc 9>,
> > +                            <&cpu2_intc 9>,
> > +                            <&cpu3_intc 9>,
> > +                            <&cpu4_intc 9>;
> > +      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
> > +            <0x29000000 0x2000>; /* Group1 IMSICs */
> > +      interrupt-controller;
> > +      #interrupt-cells = <0>;
> > +      msi-controller;
> > +      riscv,num-ids = <127>;
> > +      riscv,group-index-bits = <1>;
> > +      riscv,group-index-shift = <24>;
> > +    };
>
> How is, say linux, meant to know which of the per-level imsic DT nodes
> applies to it?
> I had a quick look in the driver, but could see no mechanism for it.
> Apologies if I missed something obvious!

This is very straightforward. We simply look at the local interrupt number
in the "interrupts-extended" DT property.

Currently, we use the same technique in PLIC driver to distinguish
M-mode PLIC context from S-mode PLIC context.

Regards,
Anup
