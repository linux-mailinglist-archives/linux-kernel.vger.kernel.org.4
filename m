Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7E60F221
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiJ0IVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiJ0IVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:21:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9954C89;
        Thu, 27 Oct 2022 01:20:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so2383219eja.6;
        Thu, 27 Oct 2022 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLZb0eCEmPbt6XCImQLnWXa0g/D2mdCPENmM5h+0jwE=;
        b=BllIFPs/F79nlMLuFBJOgtM2ZQfMVvi6XS/8ah6Tjyu9Vq+Dm4PguQPqRyc/Cv67a3
         2PgTJZgqqNZbMRSJNVYRyW802BW1hkPwPggbWsOjdfSKUw6cw92OJTKu0R4ifOnoO5DT
         heWxsIXcTPSrE7IKJGumD+szEYrf0qE+hb6dfuzy4/pz8N2AWH3xyYavBOwZFKRXrIsu
         9JNpo1l2rz3KCYxARfdsxCFdbVknGjrAN63uYEWW80RcC17keEhk4P8FEep0OVpORf2e
         mLBbqLZRYY2LBzgfWisFsKHl5B4Tu6jufyHns8YurJrRwicDOOGDqbJv+6CVEt0iGSzJ
         SE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLZb0eCEmPbt6XCImQLnWXa0g/D2mdCPENmM5h+0jwE=;
        b=IAjUD3uCKXFHuLKpvM6fPfzndDm6XnXHxt2E8d88qHEiDYFs6uHFgyzRcO+5XWW0hq
         VExICM+y/OYguP2oX+yC9T3Vi5xIzSxeNGVfcign/d6MkAKUXcz7G11IrTdxKv/XJ1VO
         +WAiVIRKfQKFxWVM4/oVCuVWO4AEfsAzP9vQvGtPm+mbp3xZcRkMS6YIqus7i5jtA/PS
         LZiryr0Q84nIV1i/8phKUA5VaQIZFWcwCtY2q8RFGs9EigWg1o86qoMoz4gZW+AgvIol
         WXOHiiFPmDA/mkod4ElChgP62eM7Mid5WC1Ni4WQCuukwgUcxnafSvX5bZcuUp5cYTiS
         o7hQ==
X-Gm-Message-State: ACrzQf3XKeWCV5XFSc+Mj8S2t79pL7NabHm7KVTPzHe4EyjrCdkKXQyJ
        xIOmljOaLZfhdlApo8agK5mt/PtMP3qnKBOakaI=
X-Google-Smtp-Source: AMsMyM49+SK4g8rI8Gl/M2IN/uHmlHyw2onhRC25Y/4JSKYZfGwLi0DI3dmFQymh9tnjoOsDrWoUXSmVKKL0amALrhI=
X-Received: by 2002:a17:907:b1c:b0:797:983a:7d97 with SMTP id
 h28-20020a1709070b1c00b00797983a7d97mr33693456ejl.267.1666858852484; Thu, 27
 Oct 2022 01:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221017091201.199457-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXuiCne2NvCzu8x9LeM_W8rxwLX-0w=kHnGa30bdzFaDQ@mail.gmail.com> <CA+V-a8tm18pckkbquK+HHxV2tHAUTwdKZjwWOAiGS-GKKtbQsg@mail.gmail.com>
In-Reply-To: <CA+V-a8tm18pckkbquK+HHxV2tHAUTwdKZjwWOAiGS-GKKtbQsg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 27 Oct 2022 09:20:24 +0100
Message-ID: <CA+V-a8tK8qQHNnwgvUiMMHOuBfVmbLyMvT4RZjq055nrda8yPw@mail.gmail.com>
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

On Tue, Oct 25, 2022 at 5:13 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Geert,
>
> Thank you for the review.
>
> On Tue, Oct 25, 2022 at 1:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Mon, Oct 17, 2022 at 11:12 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Move RZ/G2UL SoC specific parts to r9a07g043u.dtsi so that r9a07g043.dtsi
> > > can be shared with RZ/Five (RISC-V SoC).
> > >
> > > Below are the changes due to which SoC specific parts are moved to
> > > r9a07g043u.dtsi:
> > > - RZ/G2UL has Cortex-A55 (ARM64) whereas the RZ/Five has AX45MP (RISC-V)
> > > - RZ/G2UL has GICv3 as interrupt controller whereas the RZ/Five has PLIC
> > > - RZ/G2UL has interrupts for SYSC block whereas interrupts are missing
> > >   for SYSC block on RZ/Five
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > This assumes the operating points tables are the same for both variants?
> > I guess that's OK.
> >
> Ive asked the HW team to confirm this. For the v2 I'll keep it as is
> and later move it if required.
>
Ive confirmed with the HW team the OPP table is the same for both the variants.

Cheers,
Prabhakar
