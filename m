Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC667E4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjA0MG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjA0MFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:05:43 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9980164
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:00:02 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id k6so5080100vsk.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jgmw1h6HumCKIAmiKefvna0Hf/3PseJorCSc8z7I4JU=;
        b=NvTggrZpuQLvzRUb8nXqJDTuvOgJLRHwMC1+NXoMEkGXRbfvcsIgEbqXp2mFf0YAOj
         PVWU/CBCcuXZw/b9tsRyY9o8lgmQ7zWFhSk+LnsRKeDIwp9tnjODUL2lSP+Kn7M48vVv
         QFJZ4gvERv1GXu6PA8kNFNBKvMKkvyJ2S9V0k49/V5qPxQRYYu6/aIU5/c2g8oZKq7J1
         1+Vm6akp9D5LzZzju4RMrCUy07vanmzESnaMVnrk3ne7NtI5pLFmzL6eaFCbzLeU/V/M
         ZC9aUa2L281d4WdmNGSSG6xfT1N2zn3SQF81gHycm/XWgzLvChNS5TUIIC3P7/74co/p
         ioig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgmw1h6HumCKIAmiKefvna0Hf/3PseJorCSc8z7I4JU=;
        b=AHiMdO5KyAaB4IAQG4r/T5o42kFfMEJ2CfO7yYNyTrHr+mOZMUprX6aNK11pd7oLhB
         mtfrduQAJAh1kh/LW8Vs6XH2T3COQN1XD3oMxHg8MginkPpJ/vYxgyumwZHH9QQlxDHO
         sFM9cx9gakYXw1wi4CIdB7unl+i8BNB7pZ+oqpoYS+yOvbETMdbq5OTka5bMVhJzj1AF
         pd176KdUfmqIRF4oq5b07RLLgj+HAwAFODscu9qXMO+vX9QLdRC+h98wZEZWKrmkQd+r
         N+Kr0+zu9l2KDJVvcJsrBwjrL2yRbYtYJrPz5dEC4RNuhGiisJJLUqyxrRAe/w3PwE5+
         f1lg==
X-Gm-Message-State: AFqh2krTH4RNHtFCmbHydZX03Dc7IUGJNtrrIIyCEaeTsNubTcEL5Rwv
        q26AIwYZp+qOhcKbPhJjyEUjC45uaLhaMbQdpH0cAg==
X-Google-Smtp-Source: AMrXdXubHdqlaizKNTj9G102JeOsBYvmfoEFUWQ0mrfMUZ0Li5vk5eK42eJIcEWgqN/BB7YpwIsfbm0SDqDPvJhJlGE=
X-Received: by 2002:a05:6102:3134:b0:3d3:d816:c798 with SMTP id
 f20-20020a056102313400b003d3d816c798mr4957237vsh.59.1674820749156; Fri, 27
 Jan 2023 03:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-2-apatel@ventanamicro.com> <Y7YGp/7ufyRPhkwg@spud>
 <CAAhSdy2YKJfuxhBmsx9v-OMyxKQjys+J-z_ZqoPJF7q=YrE4Zw@mail.gmail.com> <Y8cIG6gKSlkTh5AF@spud>
In-Reply-To: <Y8cIG6gKSlkTh5AF@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 27 Jan 2023 17:28:57 +0530
Message-ID: <CAK9=C2VzJvpQLPedc+ruUnw8xDDDaC6_Vmj6qg1nXv+iqU-AfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] RISC-V: Add AIA related CSR defines
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 2:12 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Anup,
>
> I thought I had already replied here but clearly not, sorry!
>
> On Mon, Jan 09, 2023 at 10:39:08AM +0530, Anup Patel wrote:
> > On Thu, Jan 5, 2023 at 4:37 AM Conor Dooley <conor@kernel.org> wrote:
> > > On Tue, Jan 03, 2023 at 07:44:01PM +0530, Anup Patel wrote:
>
> > > > +/* AIA CSR bits */
> > > > +#define TOPI_IID_SHIFT               16
> > > > +#define TOPI_IID_MASK                0xfff
>
> While I think of it, it'd be worth noting that these are generic across
> all of topi, mtopi etc. Initially I thought that this mask was wrong as
> the topi section says:
>         bits 25:16 Interrupt identity (source number)
>         bits 7:0 Interrupt priority

These defines are for the AIA CSRs and not AIA APLIC IDC registers.

As per the latest frozen spec, the mtopi/stopi/vstopi has following bits:
    bits: 27:16 IID
    bits: 7:0 IPRIO

>
> > > > +#define TOPI_IPRIO_MASK              0xff
> > > > +#define TOPI_IPRIO_BITS              8
> > > > +
> > > > +#define TOPEI_ID_SHIFT               16
> > > > +#define TOPEI_ID_MASK                0x7ff
> > > > +#define TOPEI_PRIO_MASK              0x7ff
> > > > +
> > > > +#define ISELECT_IPRIO0               0x30
> > > > +#define ISELECT_IPRIO15              0x3f
> > > > +#define ISELECT_MASK         0x1ff
> > > > +
> > > > +#define HVICTL_VTI           0x40000000
> > > > +#define HVICTL_IID           0x0fff0000
> > > > +#define HVICTL_IID_SHIFT     16
> > > > +#define HVICTL_IPRIOM                0x00000100
> > > > +#define HVICTL_IPRIO         0x000000ff
> > >
> > > Why not name these as masks, like you did for the other masks?
> > > Also, the mask/shift defines appear inconsistent. TOPI_IID_MASK is
> > > intended to be used post-shift AFAICT, but HVICTL_IID_SHIFT is intended
> > > to be used *pre*-shift.
> > > Some consistency in naming and function would be great.
> >
> > The following convention is being followed in asm/csr.h for defining
> > MASK of any XYZ field in ABC CSR:
> > 1. ABC_XYZ : This name is used for MASK which is intended
> >    to be used before SHIFT
> > 2. ABC_XYZ_MASK: This name is used for MASK which is
> >    intended to be used after SHIFT
>
> Which makes sense in theory.
>
> > The existing defines for [M|S]STATUS, HSTATUS, SATP, and xENVCFG
> > follows the above convention. The only outlier is HGATPx_VMID_MASK
> > define which I will fix in my next KVM RISC-V series.
>
> Yup, it is liable to end up like that.
>
> > I don't see how any of the AIA CSR defines are violating the above
> > convention.
>
> What I was advocating for was picking one style and sticking to it.
> These copy-paste from docs things are tedious and error prone to review,
> and I don't think having multiple styles is helpful.

On the other hand, I think we should let developers choose a style
which is better suited for a particular register field instead enforcing
it here. The best we can do is follow a naming convention for defines.

>
> Tedious as it was, I did check all the numbers though, so in that
> respect:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

BTW, this patch is shared with KVM AIA CSR series so most likely
I will take this patch through that series.

Regards,
Anup
