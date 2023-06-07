Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1851A726150
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbjFGNbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjFGNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:31:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4596919BF;
        Wed,  7 Jun 2023 06:31:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25691a1b2b8so3108722a91.1;
        Wed, 07 Jun 2023 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686144701; x=1688736701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0lMNuEbXOOcWGfHtGlJsdDwFKP9YumhUcl+P6RDGn4=;
        b=Y4TRVi/zBzYTgwHSBjrv/UBECrHxL0YS5U1fbNvrt9G/XWdydeS2CIUrFOWtiDQT2E
         HvxyrF7R2ExSH5a/HbyzyLbDO5U66tnOh45aVr4N0ZvF8yGhSKRohrMfiBBqFSsI+Zm0
         4DrCTKeOY+miL237Q5aso/eJiVgjheRehAA8cS9TnssvQGGimKaCQG3tUTxmfreLITIi
         2b3l+8oudik8rZksFhPOvH+mpz1JNX2MSxfMu1X72KC0w86TIkD9aUxq0dNAgX/GZGc3
         a9+DnDbQhE8uLLSs1vHiIDg+Oagzs7eKJ834Y1XGnnhcsrv9dR64YvuXLMwchXqfg+NW
         gVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144701; x=1688736701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0lMNuEbXOOcWGfHtGlJsdDwFKP9YumhUcl+P6RDGn4=;
        b=TYmk+iiwgzK3DCCr0U3qQqiMpxze8FR77obKuAaiM6tZs6en1wblll9frF7pMGB0dc
         A0AerNCMyQwh6hR+1lb9HWZaO/UbxdiEMCvqwLyKe0mROmE1Vbt9uNcZwJsYwwhWKYIu
         cdgqgU88EBwn5trs/gjtd4e7wT22VcX6iiL1z3WsL/aHtZ9r+jifX9gUO4e3ADmq3aG6
         Nn8lY2rJxogzPcnr1j+/8cuZrBizGWpTRY6x4w4VsHqcb+fjiPus4KIZbEFpnhdzF6N2
         FJ8WktrFlUbMfO/I+NDmPqv6eTvxMDd2NX1ktbackVL8rvaC0jEsniSNSlOdlXEzAMMt
         A00Q==
X-Gm-Message-State: AC+VfDxTQc5M1uFiC/PWQSWAYX7HNXwdYJ8erLVq6JibJQB2s5P6A8B/
        KR5PR1YfPSrbMpOjGXkCHSzBartCWF6iQjNpWbjKO4E6
X-Google-Smtp-Source: ACHHUZ6t8r1I7+AsOx4AC+q6Tn9eyYuc2j7dLPVzQGIuTRwkVdvVLply4JXh/XKZWiF1nCUeDVM9FLwuRdlGbth57Ak=
X-Received: by 2002:a17:90a:1db:b0:259:cafc:4e08 with SMTP id
 27-20020a17090a01db00b00259cafc4e08mr321667pjd.29.1686144701405; Wed, 07 Jun
 2023 06:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230530112050.5635-1-aford173@gmail.com> <20230530112050.5635-3-aford173@gmail.com>
 <CAMuHMdXJaZCSN18aB1yBvhuTk=DQoe4B6aVHgoZvyLsZcRfrDA@mail.gmail.com>
In-Reply-To: <CAMuHMdXJaZCSN18aB1yBvhuTk=DQoe4B6aVHgoZvyLsZcRfrDA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 7 Jun 2023 08:31:30 -0500
Message-ID: <CAHCN7xJbi4ej2s6SOvC7o7aMcjv2awztKkNoAZTiVFn4GJRVXw@mail.gmail.com>
Subject: Re: [RFC 3/3] arm64: dts: renesas: r8a774a1: Add GPU Node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        marek.vasut+renesas@gmail.com, cstevens@beaconembedded.com,
        aford@beaconembedded.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 8:21=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Adam,
>
> On Tue, May 30, 2023 at 1:21=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> > With the 3dge and ZG clocks now available, the generic GPU node can
> > be added.  Until proper firmware is made, it is not usable.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > This is based on the assumption that the Rogue 6250 could use
> > generic driver [1] and firmware [2] being implemebted by the Mesa group
> > and others.  In practice, the firmware isn't really compatible since
> > the 6250 in the RZ/G2M appears to be a different variant.
> >
> > [1] - https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/powervr-=
next
> > [2] - https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/p=
owervr/powervr
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > @@ -226,6 +226,27 @@ extalr_clk: extalr {
> >                 clock-frequency =3D <0>;
> >         };
> >
> > +       gpu_opp_table: opp-table {
> > +               compatible =3D "operating-points-v2";
> > +
> > +               opp-200000000 {
> > +                       opp-hz =3D /bits/ 64 <200000000>;
> > +                       opp-microvolt =3D <830000>;
> > +               };
> > +               opp-300000000 {
> > +                       opp-hz =3D /bits/ 64 <300000000>;
> > +                       opp-microvolt =3D <830000>;
> > +               };
> > +               opp-400000000 {
> > +                       opp-hz =3D /bits/ 64 <400000000>;
> > +                       opp-microvolt =3D <830000>;
> > +               };
> > +               opp-600000000 {
> > +                       opp-hz =3D /bits/ 64 <600000000>;
> > +                       opp-microvolt =3D <830000>;
> > +               };
> > +       };
> > +
> >         /* External PCIe clock - can be overridden by the board */
> >         pcie_bus_clk: pcie_bus {
> >                 compatible =3D "fixed-clock";
> > @@ -2347,6 +2368,18 @@ gic: interrupt-controller@f1010000 {
> >                         resets =3D <&cpg 408>;
> >                 };
> >
> > +               gpu@fd000000 {
> > +                       compatible =3D "img,powervr-series6xt";
> > +                       reg =3D <0 0xfd000000 0 0x40000>;
> > +                       interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH=
>;
> > +                       clocks =3D <&cpg CPG_MOD 112>, <&cpg CPG_MOD 11=
2>,<&cpg CPG_MOD 112>;
> > +                       clock-names =3D "core", "mem", "sys";
> > +                       interrupt-names =3D "gpu";
> > +                       operating-points-v2 =3D <&gpu_opp_table>;
> > +                       power-domains =3D <&sysc R8A774A1_PD_3DG_B>;
> > +                       resets =3D <&cpg 112>;
> > +               };
> > +
> >                 pciec0: pcie@fe000000 {
> >                         compatible =3D "renesas,pcie-r8a774a1",
> >                                      "renesas,pcie-rcar-gen3";
>
> LGTM.  But obviously I cannot take this as-is, as there are no DT binding=
s
> for this device, and it didn't work for you...

It was mostly to follow up to the previous ones with links for the
mainline Rogue video driver in the hopes that someone from Renesas
might have some input on whether or not Renesas might be able to
support this and have a discussion.  I knew when I submitted it that
it wouldn't be accepted which is why I posted it as an RFC.
If I address concerns you have in the previous patches, would you be
OK with me submitting then as a formal patch to at least get the rest
of the system ready in the event the GPU driver/firmware becomes
available?  It seems harmless, but I also see the argument that it's
dead code without the GPU node.

If not, I'll shelve this for now, and hope to get some responses from Renes=
as.

adam
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
