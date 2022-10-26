Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2860DD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiJZIrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:47:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33107696D;
        Wed, 26 Oct 2022 01:47:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sc25so19303379ejc.12;
        Wed, 26 Oct 2022 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dHciPpZ1UgXbXRvGPu7x5GbGmWOSivcZ/5MPRV1/Ons=;
        b=HBPuNLiaf8LEoGHt9vdgvBgH+wID/hJDgyUmFN/i+CrvJANhSJKYN+sb7Izc/w4+sk
         /WfcGVJFkOxLUC/ykQV/1YAV659IcfSeTt9JqJcL9CuPdClwVGWD/w1zR92g79O/vR2R
         mcEShBP+h+mW5LSuEkWsMqlW8ud1IvPo86sm2UMEvwajuTlxza3iHb8rSUdyeDmTsr2P
         c/mezJVXUzW9CHb/2jn+dmHa2gzqI0prXGlljJRzM+IbKl5CeHdF3V+UgFizqkMZkRBD
         eteUctnBLmGvvur5uxHo+MiEVcrz3y9siQ4flTfn5WyjItSRXNalJmV6D2XSD8PQQOpO
         Nxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHciPpZ1UgXbXRvGPu7x5GbGmWOSivcZ/5MPRV1/Ons=;
        b=nPLlWY3R0PFp0z25B4bwcQT/MTOT1AyANSZuSAlaAjBHyGWfykuMJgGDMeE7ncFp3x
         frikMlNe1mcyttER3SN9AiV1aggqcvjoUp2ZAdJ52v7nIXqj45bB4RaplA1CDsfNgn0s
         yQ1wWBjFlQpsSTiuCYIZ257R9QaspXQh0MhQn8KPlZfHArxQQ8wHRCCMTv+4EOhtSK63
         9r9B3F10h/ZCWcnf/+lp1rWTWM6vO80BD9Zo/upFCYgGNfaOC7h2uAilWy/Y+lWpdK9q
         Ijw6taWMzEP3Bf6IIRG+qBuRzwAYyWRUuCaPDf1GJRFBljea09CWxHQpffBVl+5AtCGg
         hsgg==
X-Gm-Message-State: ACrzQf30nvQotWqyKAWdjsQuo8+shaMBjiTKqYmLeExEREcrBlN6sML0
        xRteCSsV9gb2GJhDWQquRqlfHlSPwQzTK+WqIzg=
X-Google-Smtp-Source: AMsMyM4xEIf06naDNkYmEl1zQz9IpL3fkrDGCsIddCLnKN0gZpHjaEDxcmdQKlbVGQLLjrPJ3Ykmdoo3ESPtHE0uPPQ=
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id
 dp15-20020a170906c14f00b0079330e196bemr31466869ejc.447.1666774030318; Wed, 26
 Oct 2022 01:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915165256.352843-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVJ4gp=kT2S+5bhjdZACSbEX=3pP7mmmi_GEbeAOxtHGw@mail.gmail.com>
 <CA+V-a8sidwGQVSb7UV56opqE9ViS_y7nVPWx8Krx7t6P1BExCg@mail.gmail.com> <CAMuHMdWkg-k2efZoy=U+j-xji0Agp38qRy-8cjb7K7QiJrL-ZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWkg-k2efZoy=U+j-xji0Agp38qRy-8cjb7K7QiJrL-ZQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 09:46:43 +0100
Message-ID: <CA+V-a8t3D0wFQhjm51hoduDqy2K93O5dUB=7aU0UjzhGYEowgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzg2ul-smarc: Add
 /omit-if-no-ref/ to pinmux
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Wed, Oct 26, 2022 at 8:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Oct 26, 2022 at 12:39 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Oct 25, 2022 at 9:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Sep 15, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > In preparation to re-use the RZ/G2UL SMARC SoM and carrier DTS/I with the
> > > > RZ/Five add /omit-if-no-ref/ keyword to pinmux entries as the support for
> > > > RZ/Five SMARC EVK will be gradually added.
> > > >
> > > > Once we have full blown support for RZ/Five SMARC EVK we can get rid of
> > > > the /omit-if-no-ref/ keyword.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > I finally had a deeper look at this...
> > >
> > > Why do you want to disable these nodes? While they are indeed not
> > > used yet on RZ/Five, they are valid hardware descriptions for the
> > > RZ/Five SMARC EVK, and their presence doesn't harm anything.
> > >
> > > I do see a valid use case for marking pin control subnodes with
> > > /omit-if-no-ref/: you can provide all possible configurations as a
> > > convenience for the user, so the user no longer has to look up the
> > > numeric parameters of the RZG2L_PORT_PINMUX() macros.
> > > But IMHO those would belong in the SoC-specific .dtsi, not in a
> > > board .dtsi.  See e.g. the massive use of /omit-if-no-ref/ in sunxi
> > > and rockchip .dtsi files.
> > >
> > > Am I missing something?
> > >
> > My intention was to keep the DTB as minimal as possible so that it
> > includes just the required pinmuxes which were enabled on the RZ/Five.
> > For example [0], [1] we do delete the pinctrl for the nodes which are
> > marked as disabled. Do you think we should drop it?
>
> You mean
>
>     /delete-property/ pinctrl-0;
>     /delete-property/ pinctrl-names;
>
> ?
> These do not delete pinctrl subnodes, but pinctrl properties in disabled
> device nodes pointing to pinctrl subnodes.  The actual pinctrl subnodes
> are still present.
>
Ahh right the pinctrl subnodes will still remain.

Cheers,
Prabhakar
