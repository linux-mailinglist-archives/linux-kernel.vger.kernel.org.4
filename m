Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA7661E2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 06:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjAIFJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 00:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjAIFJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:09:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D049FCE
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 21:09:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so17362102ejo.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 21:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQH0IE3u0wkmAklVZoiydI5Mo0drKV3a8FmyHE+njlo=;
        b=PD4Cr6RmtBmVMqQ+6894VSyIbUZbeFHLeFo9RwkN1TMCAJG24tQV5DCcZgfGbqzo5i
         nORiS6uAg/fxkPBTPz6C3iw1AThEjVSzkcmKxAZcdHGEvO/ekWN+H0w7w6KnYbiK0Wax
         KdpReo4M+zKY8/v575NE68sHQT8u4rMK2ev8eJcfkIKoUcf7ghnHu2Krok7sv45fpNo8
         d3gBK72Vrmj7ozt7KiXXcpz9SHeprPtkHpJDc4qMdgYWZsKXSHp+Ak9he/nmLSUUi9wJ
         yVF/ro9+aJ/+81zYpM73RHvR6O1Ddgnn3xM6uejyK0DYhgeD5Z1SFHYv7K+vTfdEMHxp
         hOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQH0IE3u0wkmAklVZoiydI5Mo0drKV3a8FmyHE+njlo=;
        b=vUun8V+Ed5MhwKO6nxRYDRuP887zdbmUac+aabn08Dmyew86Z55U2HlAiHsTDVQO1M
         MJrPpCRCvOQBu8CFXzDK/+fHchYCUHIR5yK8iMD5dg6yjpmP3tDT1FjZ6BUHzgtdCqcu
         70y0L5fQzuq25ErzvoguK6U0buEgY/s9rqitiCoDIu+GzBDzei8cDCcQJSgMp8vXfomj
         1zqAT3GQIya7xkYzJYtlIk8D5u281c6UzlrtoZhYzqby3klLBEVB7WdZP/4xfMPiQCp3
         o6kmjjFL3WoA9cdOwioOzfapdC5IEu0fvpDqNtksDnaSJDYTfhwdFVtzfOuS43J5AP43
         HhYw==
X-Gm-Message-State: AFqh2kpA3vjgFescnelynpipC0a5nB4WKIM3ae7YSvNOuiWBE8Vg5ZeV
        lX+HsiBJJxBcBfUZeeY5SPKC/oV77rkoTHGQiMc53A==
X-Google-Smtp-Source: AMrXdXsIzihfLVNWVPuUxl3yoyz/+ffKETiVEHV/Bli8Z7zApZlruzh0VgzvBFCjhfBLend9SoSdgJNERtSySPdLfD0=
X-Received: by 2002:a17:906:1481:b0:84d:1760:3981 with SMTP id
 x1-20020a170906148100b0084d17603981mr1189905ejc.705.1673240960233; Sun, 08
 Jan 2023 21:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-2-apatel@ventanamicro.com> <Y7YGp/7ufyRPhkwg@spud>
In-Reply-To: <Y7YGp/7ufyRPhkwg@spud>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Jan 2023 10:39:08 +0530
Message-ID: <CAAhSdy2YKJfuxhBmsx9v-OMyxKQjys+J-z_ZqoPJF7q=YrE4Zw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] RISC-V: Add AIA related CSR defines
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 4:37 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Anup!
>
> On Tue, Jan 03, 2023 at 07:44:01PM +0530, Anup Patel wrote:
> > The RISC-V AIA specification improves handling per-HART local interrupts
> > in a backward compatible manner. This patch adds defines for new RISC-V
> > AIA CSRs.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/csr.h | 92 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > index 0e571f6483d9..4e1356bad7b2 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -73,7 +73,10 @@
> >  #define IRQ_S_EXT            9
> >  #define IRQ_VS_EXT           10
> >  #define IRQ_M_EXT            11
> > +#define IRQ_S_GEXT           12
> >  #define IRQ_PMU_OVF          13
> > +#define IRQ_LOCAL_MAX                (IRQ_PMU_OVF + 1)
> > +#define IRQ_LOCAL_MASK               ((_AC(1, UL) << IRQ_LOCAL_MAX) - 1)
> >
> >  /* Exception causes */
> >  #define EXC_INST_MISALIGNED  0
> > @@ -156,6 +159,26 @@
> >                                (_AC(1, UL) << IRQ_S_TIMER) | \
> >                                (_AC(1, UL) << IRQ_S_EXT))
> >
> > +/* AIA CSR bits */
> > +#define TOPI_IID_SHIFT               16
> > +#define TOPI_IID_MASK                0xfff
> > +#define TOPI_IPRIO_MASK              0xff
> > +#define TOPI_IPRIO_BITS              8
> > +
> > +#define TOPEI_ID_SHIFT               16
> > +#define TOPEI_ID_MASK                0x7ff
> > +#define TOPEI_PRIO_MASK              0x7ff
> > +
> > +#define ISELECT_IPRIO0               0x30
> > +#define ISELECT_IPRIO15              0x3f
> > +#define ISELECT_MASK         0x1ff
> > +
> > +#define HVICTL_VTI           0x40000000
> > +#define HVICTL_IID           0x0fff0000
> > +#define HVICTL_IID_SHIFT     16
> > +#define HVICTL_IPRIOM                0x00000100
> > +#define HVICTL_IPRIO         0x000000ff
>
> Why not name these as masks, like you did for the other masks?
> Also, the mask/shift defines appear inconsistent. TOPI_IID_MASK is
> intended to be used post-shift AFAICT, but HVICTL_IID_SHIFT is intended
> to be used *pre*-shift.
> Some consistency in naming and function would be great.

The following convention is being followed in asm/csr.h for defining
MASK of any XYZ field in ABC CSR:
1. ABC_XYZ : This name is used for MASK which is intended
   to be used before SHIFT
2. ABC_XYZ_MASK: This name is used for MASK which is
   intended to be used after SHIFT

The existing defines for [M|S]STATUS, HSTATUS, SATP, and xENVCFG
follows the above convention. The only outlier is HGATPx_VMID_MASK
define which I will fix in my next KVM RISC-V series.

I don't see how any of the AIA CSR defines are violating the above
convention.

The choice of ABC_XYZ versus ABC_XYZ_MASK name is upto
the developer as long as the above convention is not violated.

>
>
> > +/* Machine-Level High-Half CSRs (AIA) */
> > +#define CSR_MIDELEGH         0x313
>
> I feel like I could find Midelegh in an Irish dictionary lol
> Anyways, I went through the CSRs and they do all seem correct.
>
> Thanks,
> Conor.
>
>

Regards,
Anup
