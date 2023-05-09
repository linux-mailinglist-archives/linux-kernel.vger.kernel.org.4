Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5476FCDDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjEISfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjEISfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:35:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD61E1725
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:35:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f22908a082so4003654e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683657333; x=1686249333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfgDkN6/vdhK2GFASgIn7d04jTTm9Lyq2tvSareDv5M=;
        b=KpurfS4qJyOfrwFAlVM7HZprLcLWA71H3L54Qea9hZnXbHY6gwnkSp+06wOd3lMs9H
         kxgtHl+tQBmEUqq1vDMZcBUEKiR14UphjE3fi1ksnz9ySqPJ5w4YwgvRwxiRcSPn0Zyt
         KMnmQiaED5pR3uRVLnIqnDv4w+uozqaX/UXBLbJ4A6bPZXs5CTLbq4hCUi4bZ7D2DbYr
         Yl2V9aUj/1i82dsLDhOqdTomJsF/4as57Q3jtpyFnKKzBEY0pbv8oHfj5nVPeUfhRBLw
         w0/x24pM3H0qus9KzNpC8iISFSF+OUKPMg5MLP1irhpVAvj/KCirPPn3SykcHrZobknf
         Dsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683657333; x=1686249333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfgDkN6/vdhK2GFASgIn7d04jTTm9Lyq2tvSareDv5M=;
        b=ITcabwpNveGr2E1r+UX7tAg6GcjYNQXMxV8kFqI1hTMzvHOzPB5P63QN3MiyhcQU8A
         UkKjh1RX4Cy51SW247rsXRObnd40+CoLKL8ThKEYqlpx1tmxmcXWyC7cXuUmqoUCqt/L
         SEB9Is2S/P7cZ5YEG7I1IrhwVTiqd8d2vEWdYsDrBcNC5DhsikrdYltMcS26vX/dAa9w
         fh9wXch3Bd40xJ/eRDSBF6ykF1wfvl3fLXtNeNEOujFwkpN4rTNRTvrwFD4MveTWo3ds
         ahEQ1XFdChMDxAbBa0GHu/frMSHSWUwTUBAmxSDZZc6vsiYgdMVgGgsUn2ommP9DF+2b
         iuTw==
X-Gm-Message-State: AC+VfDw4NMzKMC4lDDtJ9Nsvx9trhhRTUnrzG2EcB9kir8695irKhwV2
        P69a2u97oLDIARsHTLr4JfylXle7N3ihVPl3Rwt5gg==
X-Google-Smtp-Source: ACHHUZ5xWMC38Oh7cIFm++FUUu8wZzSwfuLJnL3vTLI1qxQSqArwnAQrvV9g1jk/9UdaMqvwxY8OP1G8ZtM0cfp9QFg=
X-Received: by 2002:a19:ad48:0:b0:4f1:80cf:6194 with SMTP id
 s8-20020a19ad48000000b004f180cf6194mr882716lfd.64.1683657333000; Tue, 09 May
 2023 11:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230509182504.2997252-1-evan@rivosinc.com> <20230509182504.2997252-2-evan@rivosinc.com>
 <20230509-exclusion-crested-67dad91b7055@spud>
In-Reply-To: <20230509-exclusion-crested-67dad91b7055@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 9 May 2023 11:34:57 -0700
Message-ID: <CALs-HstaQweGaz71GZXeu1gtVQ7Efb=i=Zgt4ETtmf1vJncxEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: Add Zba, Zbs extension probing
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 11:29=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, May 09, 2023 at 11:25:01AM -0700, Evan Green wrote:
> > Add the Zba address bit manipulation extension and Zbs single bit
> > instructions extension into those the kernel is aware of and maintains
> > in its riscv_isa bitmap.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> Given you added the lads, rather than ignoring them due to the Zbs
> change, I think you forgot my R-b from v1?
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Whoops, yes I did. Sorry about that, and thanks for the review!

>
> Cheers,
> Conor.
>
> >
> > ---
> >
> > Changes in v2:
> >  - Add Zbs as well
> >
> >  arch/riscv/include/asm/hwcap.h | 2 ++
> >  arch/riscv/kernel/cpu.c        | 2 ++
> >  arch/riscv/kernel/cpufeature.c | 2 ++
> >  3 files changed, 6 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index e0c40a4c63d5..6b2e8ff4638c 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -46,6 +46,8 @@
> >  #define RISCV_ISA_EXT_ZICBOZ         34
> >  #define RISCV_ISA_EXT_SMAIA          35
> >  #define RISCV_ISA_EXT_SSAIA          36
> > +#define RISCV_ISA_EXT_ZBA            37
> > +#define RISCV_ISA_EXT_ZBS            38
> >
> >  #define RISCV_ISA_EXT_MAX            64
>
> Heh, gonna start getting tight on bits here soonish :)

Yeah they're flying in, I had to update mine since SMAIA swooshed in.
-Evan
