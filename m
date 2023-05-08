Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961326FA05E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjEHG6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjEHG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D271A62E;
        Sun,  7 May 2023 23:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E8BA61F37;
        Mon,  8 May 2023 06:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3668C433EF;
        Mon,  8 May 2023 06:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529095;
        bh=3NvGzGZUDejWf2Tsc/ruVQPX/c2lUYLZP2mcCabAqpE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NXE7z5SvCZ/k3TCIBRogKFdMhzfn0wpJbvPqtyXIAyoSti38t5Ep2rO3WqDfUkUW+
         bwzb6RlFG6+pPCquLjxl0Ch/Rgj699XEnKTCwLKJS3pbRLhiBILtp2ALPR7wYAVcBk
         /Yb7dLOLcZ8qiRavKbYNrnDsGSbCmfalUyBRXHjG671oGchEFI9RNKwR756GnA0VFM
         dq9TWjCJWKAGyo/055cMy1R3rso1RqSSB/hyKdPpyVVnYkpb+lYtPig2u7BlJeTdsu
         lBRCKks+Pz76u1WU5tEb9aM4V6FHEsz8AWjAFKLW/2xDoj9p6czkGMRZUIyF8JkhJN
         s1HsirNbBRpEg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-965d2749e2eso528401566b.1;
        Sun, 07 May 2023 23:58:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDxY9RtB3CjPo8TBBKkEWl1kFPwqnj7+1MKtA5kvXszksNOCMvY9
        x6jCSCnnhqZJeVLhvVeXFmZR1meGNSBrOr3a6lE=
X-Google-Smtp-Source: ACHHUZ4eTiPCDomhQD8cUrrT/3bGwzPZ7F4C644pKdOt1JjzD5ZlEtq5hNlN2UT0wNlBk1g+j/KrEa+J7Swd/5aMHM4=
X-Received: by 2002:a17:906:7304:b0:94c:ea3b:27a with SMTP id
 di4-20020a170906730400b0094cea3b027amr9183323ejc.16.1683529093952; Sun, 07
 May 2023 23:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org> <20230507182304.2934-3-jszhang@kernel.org>
 <20230507-sleeve-tacky-21e817e31fb2@spud> <CAJF2gTTSRQUX8C3C-tgq4o5iGJqKTja7-1Dv8epG_qZizUvSow@mail.gmail.com>
 <20230508-splashed-voicing-bc6e91aeb053@wendy>
In-Reply-To: <20230508-splashed-voicing-bc6e91aeb053@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 8 May 2023 14:58:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSZmjScBERVxxsEJ-q-HdXn+daT5-H-QvGt2iWxPCaT3g@mail.gmail.com>
Message-ID: <CAJF2gTSZmjScBERVxxsEJ-q-HdXn+daT5-H-QvGt2iWxPCaT3g@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: Add the T-HEAD SoC family Kconfig option
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 2:53=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Mon, May 08, 2023 at 02:42:10PM +0800, Guo Ren wrote:
> > On Mon, May 8, 2023 at 5:22=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> > >
> > > On Mon, May 08, 2023 at 02:23:01AM +0800, Jisheng Zhang wrote:
> > > > The first SoC in the T-HEAD series is light(a.k.a th1520), containi=
ng
> > > > quad T-HEAD C910 cores.
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  arch/riscv/Kconfig.socs | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > > index 1cf69f958f10..ce10a38dff37 100644
> > > > --- a/arch/riscv/Kconfig.socs
> > > > +++ b/arch/riscv/Kconfig.socs
> > > > @@ -41,6 +41,12 @@ config ARCH_SUNXI
> > > >         This enables support for Allwinner sun20i platform hardware=
,
> > > >         including boards based on the D1 and D1s SoCs.
> > > >
> > > > +config ARCH_THEAD
> > >
> > > Could you please add a defconfig patch, adding this option, so that w=
e
> > > build support for this platform by default?
>
> > Yes, but it's another patch, see: 'commit eb20e7cb91ba ("riscv:
> > defconfig: Enable the Allwinner D1 platform and drivers")'
>
> But that's ARCH_SUNXI for the Allwinner D1. If the TH1520 is a
> first-party SoC, and not an Allwinner product, it needs a new Kconfig
> entry etc.
> If it is an Allwinner, then the dts etc should be in the Allwinner
> directory too.
Do you mean?
config ARCH_THEAD
        def_bool SOC_THEAD

config SOC_THEAD
        bool "T-HEAD SoCs"

In defconfig:
+CONFIG_SOC_THEAD=3Dy

>
> Cheers,
> Conor.



--=20
Best Regards
 Guo Ren
