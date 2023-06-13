Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4672DC32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbjFMISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbjFMISp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:18:45 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E7D10C2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:18:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso1573248276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686644323; x=1689236323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYxWtgxnVnQZT9lz0RWbMniZzWsCGe2zGgB4ImcCjC4=;
        b=GgyUEUJj5KK554oYZvhgbbJrR358zHeS4y5kle8dSCpk/vbud0V99z6i78bSS0+HjB
         wPQuQEsvnimA3yQMOa98H9f/Ah/79VdGiWNjpBFkm259urnCphWmeHoe6HJB3umHuQYg
         wYrBs2AVa4wLSZSm4MDX8k6RX+mRwdmhivyg7icKiEPKvoQ0qIBwn85mhcjPlXazaph/
         TEH5n8j3358u64bZx6a1Ine85RjxRMSGn2N0SP9GYI0hi3xeXeRmqf27/ELwjVhzG9oz
         0/PeGBznoWlnd7+j0FyjVZ6jCZ15eFhQIwMf302ESJ4gxGomVNvWd+c9ycJpDNTc/Ti/
         odSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644323; x=1689236323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYxWtgxnVnQZT9lz0RWbMniZzWsCGe2zGgB4ImcCjC4=;
        b=F2vmhMZnhsCrTuqSHA7lDCTdYhgsc2bggs2UPAzMBnDyFrCWZoFFEmzndUoS6UEKs/
         LCdE9uPP6d9fmVuH0PcJrXZRyy9e2KbMyGGPOhXQsPx0s/JSQZVsEgIXFw1s3OgzKWeE
         z0fAcjkj//66uk51RJSf7pgj6rcuu0aGRa/2y1d8idFZj4MpIUsyqaxM77/HL3s1VTwW
         e/OyKu+9Ro+zj4KUnXCOSwD14n5Ht0v1I51UP6e5UJiIMyDWUprC0mdF95j/XU1uzlio
         rEWEuRIPQE/nV5bR19lKjJi+sRbwznNAA+iYM95QrHgl9+uP1x+EjMU1stHyS7iAC2HT
         KxrQ==
X-Gm-Message-State: AC+VfDwrA1oidAz+Y7t4sq2YmgtkWXDZylc19C9DnB1TzxM/8o9bLPz2
        c56IjArDkTbQW300P6+DdG3GApWxohAFRSRqO1ChBAQ4rGmZ2d3f
X-Google-Smtp-Source: ACHHUZ51qjjDXrZayB2WH1y5kXtJRQFZ9MOkA7yujtKYZ2TlvtYJj6qaB0h189GnS8dsYUZpmgsJKqrU1/zglYmy+zQ=
X-Received: by 2002:a25:f504:0:b0:bac:12e1:1d68 with SMTP id
 a4-20020a25f504000000b00bac12e11d68mr770859ybe.11.1686644323651; Tue, 13 Jun
 2023 01:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-5-apatel@ventanamicro.com> <20230510-untried-duvet-7e3c230fcefd@wendy>
In-Reply-To: <20230510-untried-duvet-7e3c230fcefd@wendy>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 13 Jun 2023 13:48:32 +0530
Message-ID: <CAK9=C2WR+1ZGp+db7axszzthT=G8M0134+frxBNq1YS0FnF7jg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 5:46=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Anup,
>
> On Mon, May 08, 2023 at 07:58:35PM +0530, Anup Patel wrote:
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      This property represents the set of CPUs (or HARTs) for which gi=
ven
> > +      device tree node describes the IMSIC interrupt files. Each node =
pointed
> > +      to should be a riscv,cpu-intc node, which has a riscv node (i.e.=
 RISC-V
> > +      HART) as parent.
>
> One minor nit here about wording - "riscv node" doesn't seem
> particularly clear to me, should it be s/riscv node/cpu node/?

Okay, I will update.

>
> My only thing last time around was my misunderstanding, and you also
> appear to have resolved Rob's complaints, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Just to note, it'd be great if you could CC me on series that I've
> already reviewed when you resubmit them?
> Although in this case, if you ran get_maintainer.pl on v6.4-rc1 it'd have
> told you to CC me anyway ;)
>
> Thanks,
> Conor.

Regards,
Anup
