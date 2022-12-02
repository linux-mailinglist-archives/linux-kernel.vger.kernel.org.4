Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BBE640CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiLBSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiLBSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:19:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23E2C65A;
        Fri,  2 Dec 2022 10:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02A50CE1F50;
        Fri,  2 Dec 2022 18:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7ECBC433D6;
        Fri,  2 Dec 2022 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670005107;
        bh=618QCeGYc1P0CY4DPHXZA0uTvw1dOOkdz6+4oVk0xFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLnk/7ZNIHd/Y+LS+H+p+CpmAiouw2VmGjUQA58jE3LYvHY+bjkLkpfJwgfDeWOx6
         40Yh5dYiOzzK6R7w/sL85DD6MSloEXJeJlvAgmkS4V8C9ARtOhHZzoXxJVauDUc6Jv
         ZXwQVo3FyN5NErssDwGuF6f2fowzXqRBOUdyo4pILXel0Foq/IimHalCERKNdh7BxF
         wj8JJBXJTxAU8xOdKJx3ZRtWPAHkjwzD59tiwFhfzxobxeJyo7B8//S708psPk7xTV
         +GQ7cvl8MDDrcnmUeL6nIuFSMtO1IUFEn2GFnmfvJqoxZhQ6GuodkFw+DnkSo6Wzyh
         ggs9e/JBzAjNA==
Date:   Fri, 2 Dec 2022 18:18:21 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     hal.feng@starfivetech.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ben.dooks@sifive.com, tglx@linutronix.de,
        Marc Zyngier <maz@kernel.org>, sboyd@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, emil.renner.berthing@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
Message-ID: <Y4pBbVQgcTmS7NLa@spud>
References: <Y4o+5ayW0vHcmvo6@spud>
 <mhng-2ff22bb7-a48a-4434-b498-1f928e75cd01@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7L3VJsXTTTjO0p6i"
Content-Disposition: inline
In-Reply-To: <mhng-2ff22bb7-a48a-4434-b498-1f928e75cd01@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7L3VJsXTTTjO0p6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 10:13:40AM -0800, Palmer Dabbelt wrote:
> On Fri, 02 Dec 2022 10:07:33 PST (-0800), Conor Dooley wrote:
> > On Fri, Dec 02, 2022 at 10:00:35AM -0800, Palmer Dabbelt wrote:
> > > On Thu, 17 Nov 2022 17:17:14 PST (-0800), hal.feng@starfivetech.com w=
rote:
> > > > Add CONFIG_SERIAL_8250_DW=3Dy, which is a necessary option for
> > > > StarFive JH7110 and JH7100 SoCs to boot with serial ports.
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > > ---
> > > >  arch/riscv/configs/defconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > > diff --git a/arch/riscv/configs/defconfig
> > > b/arch/riscv/configs/defconfig
> > > > index 05fd5fcf24f9..a23d022974ad 100644
> > > > --- a/arch/riscv/configs/defconfig
> > > > +++ b/arch/riscv/configs/defconfig
> > > > @@ -122,6 +122,7 @@ CONFIG_MICROSEMI_PHY=3Dy
> > > >  CONFIG_INPUT_MOUSEDEV=3Dy
> > > >  CONFIG_SERIAL_8250=3Dy
> > > >  CONFIG_SERIAL_8250_CONSOLE=3Dy
> > > > +CONFIG_SERIAL_8250_DW=3Dy
> > > >  CONFIG_SERIAL_OF_PLATFORM=3Dy
> > > >  CONFIG_VIRTIO_CONSOLE=3Dy
> > > >  CONFIG_HW_RANDOM=3Dy
> > >=20
> > > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >=20
> > Hey Palmer, could you take this as v6.2 material instead of Acking it
> > please? It applies to the jh7100 stuff that's already in-tree.
>=20
> Ya, no problem.  Just this patch, or the whole series?

Just this one defconfig patch please, the rest is not ready.
Sorry that that was not clear,
Conor.


--7L3VJsXTTTjO0p6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4pBbQAKCRB4tDGHoIJi
0okIAP9ezsc7DcLYtKQL0YkiR3kU1YHRvLyrceTr5zvR4AdD/AD+Jakh5oJMOQZs
TT+FQynSHpyucTXuOOlHyDjvaiZKNAM=
=tjcn
-----END PGP SIGNATURE-----

--7L3VJsXTTTjO0p6i--
