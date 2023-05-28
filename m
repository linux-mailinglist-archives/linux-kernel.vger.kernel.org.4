Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F1713961
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjE1MIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 08:08:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D00AF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:08:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so3952956a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685275688; x=1687867688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCK4pID7AezwcosN8lYup62mksPJs7beND49b/loKoc=;
        b=V9B+QN+h2KyJX2igIuG4de2eBjN5rMsv//t46yFXRPIdkNQJyJCJUQGc2MCs6+bxho
         waj6b39j+TRCyQV17NHg9lGK2x5rt116/+gyktBjwMxo8T7Jy2+ajnGDornF7j5Wp91u
         oS1XK9Ye8jeFtoET+tMOGpnlLhGjQJROIYwC2RJR2iQIYFR3SDyXXNWa1xK6a9p2LNx1
         DdnhXHE/1C2ZrRgjC6vQHFoA4GEduAeJppZzHqtyE4qDtpYzGhvPfOrJJ6T/xt4w+5OH
         qsv2rz7gC7oATe/idKEerYNzTeziT0wct4uF/9YPHiLjKSmGYSzVTsxcLFJ1v/OMANH5
         NUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685275688; x=1687867688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCK4pID7AezwcosN8lYup62mksPJs7beND49b/loKoc=;
        b=QUzQpcLktSSxeaP2Zv1IjIFHTB06CKXr2sjzBPnbQA+VjtxYliaOQIVYG/AkceahlK
         eebFJtYjFVpcBoeh/0xmmdCPTO9t2GxFDgf1CzdNRGgkjvLlTj5yIYe0EAvC+sL/qQnX
         pMRI334jJMEzxSd7zmUflAietDrj9itIMutgzLMx1yNbC37gBTkDUIby6OfO9UcN6Jk6
         +hkZ1x21VuRdedFmvMRzYbRV7GEQL8GVChhslfSPjzgUQ+AJDdNIsW8yAEIIa5w7fetf
         Wke/rZQiXHvjT3THN3/JnC7kIC7uQx5jfoFXqq2/yWFkjZzEOhaWnTUIye2+96Xuy6O6
         s5zQ==
X-Gm-Message-State: AC+VfDwYNeJDXcRygg4YxRin9LvVZqlIp1euevHQT2mNB2PeG/kI8Btz
        j/f3xTFxKJh1vF3v+r7umrJA/h/nIue5IqX2qUrZUmiSJP1CTBUx
X-Google-Smtp-Source: ACHHUZ5iZg5soRN8IdL1vME9Lrd2HTMOY6QdPwqqunAa1BHNoVNnzSwzMr+ZttCWNEBLyzUNS3MRLAF061vbWtlCzTc=
X-Received: by 2002:a17:907:9289:b0:973:8198:bbfb with SMTP id
 bw9-20020a170907928900b009738198bbfbmr8206431ejc.31.1685275688145; Sun, 28
 May 2023 05:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx> <86fs7gdhid.wl-maz@kernel.org>
In-Reply-To: <86fs7gdhid.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 28 May 2023 20:07:56 +0800
Message-ID: <CAAhV-H6KpNhL5VvumvhcAKGOpe-EO0zfzm_xPprP0rTVf18Leg@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of msi_domain_prepare_irqs()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Sun, May 28, 2023 at 3:47=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Sat, 27 May 2023 15:03:29 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sat, May 27 2023 at 13:46, Huacai Chen wrote:
> > > Adjust the return value semanteme of msi_domain_prepare_irqs(), which
> > > allows us to modify the input nvec by overriding the msi_domain_ops::
> > > msi_prepare(). This is necessary for the later patch.
> > >
> > > Before:
> > > 0 on success, others on error.
> > >
> > > After:
> > > =3D 0: Success;
> > >> 0: The modified nvec;
> > > < 0: Error code.
> >
> > This explains what the patch does, but provides zero justification for
> > this nor any analysis why this is correct for the existing use cases.
> >
> > That longsoon MSI domain is a PCI MSI domain. PCI/MSI has already a
> > mechanism to return the actual possible number of vectors if the
> > underlying space is exhausted.
> >
> > Why is that not sufficient for your problem at hand?
>
> I've already made that point, but it seems that the argument is
> falling on deaf ears.
I'm very sorry that I didn't answer your question directly.

>
> Being able to allocate MSIs is not a guarantee, and is always
> opportunistic. If some drivers badly fail because the they don't get
> the number of MSIs they need, then they need fixing.
Yes, I know allocating MSIs is not a guarantee, and most existing
drivers will fallback to use legacy irqs when failed. However, as I
replied in an early mail, we want to do some proactive throttling in
the loongson-pch-msi irqchip driver, rather than consume msi vectors
aggressively. For example, if we have two NICs, we want both of them
to get 32 msi vectors; not one exhaust all available vectors, and the
other fallback to use legacy irq.

I hope I have explained clearly, thanks.

Huacai

>
> I really don't see the point in papering over this at the lowest level
> of the stack.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
