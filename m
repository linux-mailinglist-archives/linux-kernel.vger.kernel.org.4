Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B128860D164
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiJYQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiJYQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:13:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30A8FAE60;
        Tue, 25 Oct 2022 09:13:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y14so13815944ejd.9;
        Tue, 25 Oct 2022 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8k5UyCJg2NMPP4g60YtwffYqOC0aHgrkKd8pUxsWhgY=;
        b=owRTX5/ShqCDoM8DYtFu07eYMwO7yrFql7qZ690fVlPcCRqqcGQAJXFI3ewpdN3F/e
         n7rU+r3Lt0GIXJ1nacsBmjYp+fiZv5KD2U3M/hCJ1qCHu3FOYfodErRQv3JJfwmZtgC3
         oMMNX7BGcndu5E1gXP6U6nPojUZo2FhkaNeIXuazK3oyKKnarISJ/5mPrfaUPYtVrCEN
         5G0ujzTL6j7tNKHfM3yNKn49i7p5gk+yV0Kr9PTAdFFJd2mLLVgadtKKdE5+ra7I20z1
         ctP++yM9vlyiu9v4C8dqnTc6Ov6RZQKvVF6oG1vndty9jsIXU3jj3hPwo5ARAwN9M2X9
         zlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k5UyCJg2NMPP4g60YtwffYqOC0aHgrkKd8pUxsWhgY=;
        b=TQsGOApctohyApIsRfGfEXphpPdVvUBSKuqDPuULWB6Xhso4CVUXGDsyVumcv+efMP
         IaDDWaOKWGRfor/JBAaTHZZP8qSg0X/m+qz2fG6ahqKMjT8/Fe2kizYqQzBVRvRAOo9l
         ydIBRhofvRtxDVhQlqY3MGit9/9nWdv2eWM8xWTmHrCFrIKEob/KXbQGKqrV+ktwGjyB
         H62q38noi2wJbymihkcabg7047VdEdQJ0GUaGAqW40Telptu7ay7J12c1hZjc2FyDVNV
         X0+q7lduI98HS6ptdIGrdvP5oZKlA5S93aaZL8Ke81iACgyiv68ike4/8cIvMvbt65u5
         Pf/w==
X-Gm-Message-State: ACrzQf3lifxU6aUTASOACSiHXZureaVQKB55wzRn/lR9G3+eaGF2KDuE
        fAEvT/3BOGIp+s4UvNU2Uqcvf5cIXan6ZyTB3No=
X-Google-Smtp-Source: AMsMyM7emL6MbHVHmI1HuBgGTnzWTCjyKfPkCHMUYmk40cRiSKsI1GbMCGWs0NZiBfecUTAMefnzbVLT4+u2uByPAGk=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr32981078ejb.80.1666714427234; Tue, 25
 Oct 2022 09:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221017091201.199457-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXuiCne2NvCzu8x9LeM_W8rxwLX-0w=kHnGa30bdzFaDQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXuiCne2NvCzu8x9LeM_W8rxwLX-0w=kHnGa30bdzFaDQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 25 Oct 2022 17:13:20 +0100
Message-ID: <CA+V-a8tm18pckkbquK+HHxV2tHAUTwdKZjwWOAiGS-GKKtbQsg@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 2/2] arm64: dts: renesas: r9a07g043: Split out
 RZ/G2UL SoC specific parts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Tue, Oct 25, 2022 at 1:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Oct 17, 2022 at 11:12 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move RZ/G2UL SoC specific parts to r9a07g043u.dtsi so that r9a07g043.dtsi
> > can be shared with RZ/Five (RISC-V SoC).
> >
> > Below are the changes due to which SoC specific parts are moved to
> > r9a07g043u.dtsi:
> > - RZ/G2UL has Cortex-A55 (ARM64) whereas the RZ/Five has AX45MP (RISC-V)
> > - RZ/G2UL has GICv3 as interrupt controller whereas the RZ/Five has PLIC
> > - RZ/G2UL has interrupts for SYSC block whereas interrupts are missing
> >   for SYSC block on RZ/Five
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> This assumes the operating points tables are the same for both variants?
> I guess that's OK.
>
Ive asked the HW team to confirm this. For the v2 I'll keep it as is
and later move it if required.

> Overall, LGTM.
>
\o/

Cheers,
Prabhakar
