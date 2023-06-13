Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10F72DBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbjFMIGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjFMIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:06:09 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F35EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:06:06 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-561b7729a12so91655417b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686643565; x=1689235565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k/4HquP2HeWTu3gqyEqAfIouxpypkLo7uElSrv6hWc=;
        b=awkBk+howhXC9J91GGN+gEhLJqzy4lI2+Nm2ME0HsBbRSUGNzB9llZL0mmuInqWVYv
         goSHwsqToUzZst/eUhuADOvGa79vijbWRbT4TcdQ2JmJleqsoTRcCvxuusNEuv6phnbg
         RcFVy5pFpePMCFA0meViSbb2mb42Bx5rqvMemzvomS6qHphXqCA6RmLGATsD2HzrkCA1
         BkLuRJCoQE77Ziur1z4yQgYkJD1IJuA9j7kkcYm63Qc/WQZ672nsx8jaG3lyN5ld0Qc/
         D3GNmDLwiLZE+jQJmHUTQzfaOhAFnuIcRdTgLn9/Ia/jM4+weREaTvv8hYftc1NWFSLr
         EJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686643565; x=1689235565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k/4HquP2HeWTu3gqyEqAfIouxpypkLo7uElSrv6hWc=;
        b=fPP84P3gw66Azhy3Et2FpDSrcf/G5/M5Lujz0hOk5Ey4CUTGbbEUrHuVfgTlBQ4gVF
         jn9OLeV1zumWW7XTK7KLMC8M8HY75vq5kpJnqolt9AqeXDh5F59lS4RPfX3O/I4Z4vD6
         QuUNA/0jRcnYXgZFjm0eESpZ9tZE0DowW9PB1v4AvFvNKiG/I8kB4QM+oPcjcx9K7X8+
         UKaRbQo1pDA2SVPvoAcRnsp5X+sM7TG4qX5OsOXRafF7r4a9361D1Tt30LWwztRuAdEJ
         2P87M0PDZvk0f6k0PmRKMl8kEEO6Eqo2uVxpT3cMhXNHiooXQfUDFHy0nLIexDAtlxBK
         q1aQ==
X-Gm-Message-State: AC+VfDx7a2fDkT21Sttt5OEWEX7lRfQAJux2HnmdCHXwfgXRzNByFhcf
        cwZzOQPikw2BQiB6dxOyhYdsPPxQHU/eOmTBtxv6Zw==
X-Google-Smtp-Source: ACHHUZ6duDMZEOxgSlCrtpBwenRyzgNSxW6ESMhkrTlkPUSo6LUwj8CSY7DYsQmwkus4eMXqhFWEsLczZTipIuenZig=
X-Received: by 2002:a25:a423:0:b0:bc4:77a:22a0 with SMTP id
 f32-20020a25a423000000b00bc4077a22a0mr878350ybi.15.1686643565505; Tue, 13 Jun
 2023 01:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-2-apatel@ventanamicro.com> <20230510-squealing-pruning-2c94b85785b0@wendy>
In-Reply-To: <20230510-squealing-pruning-2c94b85785b0@wendy>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 13 Jun 2023 13:35:54 +0530
Message-ID: <CAK9=C2VqAX+xGH0oPhda1ygMu4umhNAXbPAQ+Z4q+fGR0R54ug@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] RISC-V: Add riscv_fw_parent_hartid() function
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 6:15=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, May 08, 2023 at 07:58:32PM +0530, Anup Patel wrote:
> > We add common riscv_fw_parent_hartid() which help device drivers
> > to get parent hartid of the INTC (i.e. local interrupt controller)
> > fwnode. Currently, this new function only supports device tree
> > but it can be extended to support ACPI as well.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/processor.h |  3 +++
> >  arch/riscv/kernel/cpu.c            | 12 ++++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index 94a0590c6971..6fb8bbec8459 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -77,6 +77,9 @@ struct device_node;
> >  int riscv_of_processor_hartid(struct device_node *node, unsigned long =
*hartid);
> >  int riscv_of_parent_hartid(struct device_node *node, unsigned long *ha=
rtid);
> >
> > +struct fwnode_handle;
> > +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *=
hartid);
> > +
> >  extern void riscv_fill_hwcap(void);
> >  extern int arch_dup_task_struct(struct task_struct *dst, struct task_s=
truct *src);
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 5de6fb703cc2..1adbe48b2b58 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -73,6 +73,18 @@ int riscv_of_parent_hartid(struct device_node *node,=
 unsigned long *hartid)
> >       return -1;
> >  }
> >
> > +/* Find hart ID of the CPU fwnode under which given fwnode falls. */
> > +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *=
hartid)
> > +{
> > +     /*
> > +      * Currently, this function only supports DT but it can be
> > +      * extended to support ACPI as well.
> > +      */
>
> Statement of the obvious here, no?
> Although, it seems a little odd to read this comment & the corresponding
> statement in the commit message, when the series appears to have been
> based on the ACPI?
>
> Perhaps by the time v4 comes around, ACPI support will have been merged
> & that'll be moot.

Yes, I was anyway going to update this in v4 to support both DT and ACPI.

>
> > +     if (!is_of_node(node))
> > +             return -EINVAL;
> > +     return riscv_of_parent_hartid(to_of_node(node), hartid);
>
> nit: blank line before the return here please.

Okay, I will update.

>
> Thanks,
> Conor.

Regards,
Anup
