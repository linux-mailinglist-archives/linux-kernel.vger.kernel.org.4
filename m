Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A2640CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiLBSHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiLBSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:07:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937EB220DF;
        Fri,  2 Dec 2022 10:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18011B82146;
        Fri,  2 Dec 2022 18:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49153C433D6;
        Fri,  2 Dec 2022 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670004459;
        bh=hmBVhSbPpSMvNZz4kaHDw8/rhmXitCHA11QWlM1A7yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB5t/edar9Z8+CMkvTdc1FFOtMtirl3BE1km8FNy3DVv6aIdjhRLiSLK/F9M28Ego
         9aXg+gY1PlCFpw2UcLeTlFIHPFdxIjSaW5kaBGXyg5jpOQo/+9NWzR50zYEZIOWc7x
         HkbnVPTVO94ec0CeVn4cj2r/56SVw4PGXLLMh3sGsYR8ewcZjFjB5CnvQnZSKVL1eK
         QxPruoypwCt4bBjWwaKSmVWMOlb1dU7QsYyT1vSKfWzpkanunUl41dx/jJedOsK+Bg
         GyDbgO0VJk8oqRuDURBqbHP5mp/L81BDLmXbYQJo+HQAoJp164WS7lm9R7+s3QMn+R
         wIrpflIApgMew==
Date:   Fri, 2 Dec 2022 18:07:33 +0000
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
Message-ID: <Y4o+5ayW0vHcmvo6@spud>
References: <20221118011714.70877-9-hal.feng@starfivetech.com>
 <mhng-cf616c36-e110-4274-9bbf-cc6a22b75ed5@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JhNtFton+bzlOv4O"
Content-Disposition: inline
In-Reply-To: <mhng-cf616c36-e110-4274-9bbf-cc6a22b75ed5@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JhNtFton+bzlOv4O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 10:00:35AM -0800, Palmer Dabbelt wrote:
> On Thu, 17 Nov 2022 17:17:14 PST (-0800), hal.feng@starfivetech.com wrote:
> > Add CONFIG_SERIAL_8250_DW=3Dy, which is a necessary option for
> > StarFive JH7110 and JH7100 SoCs to boot with serial ports.
> >=20
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  arch/riscv/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index 05fd5fcf24f9..a23d022974ad 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -122,6 +122,7 @@ CONFIG_MICROSEMI_PHY=3Dy
> >  CONFIG_INPUT_MOUSEDEV=3Dy
> >  CONFIG_SERIAL_8250=3Dy
> >  CONFIG_SERIAL_8250_CONSOLE=3Dy
> > +CONFIG_SERIAL_8250_DW=3Dy
> >  CONFIG_SERIAL_OF_PLATFORM=3Dy
> >  CONFIG_VIRTIO_CONSOLE=3Dy
> >  CONFIG_HW_RANDOM=3Dy
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Hey Palmer, could you take this as v6.2 material instead of Acking it
please? It applies to the jh7100 stuff that's already in-tree.

Thanks!


--JhNtFton+bzlOv4O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4o+5QAKCRB4tDGHoIJi
0kyvAP96/etRU8MHV+TJop+MIh7YJPGSSh3PcSxER+l04TgwHgEA4hyLBxQuQu2J
bjSGcD9MlcnjCPczYWEZ5JkuvOxhOQQ=
=zgbf
-----END PGP SIGNATURE-----

--JhNtFton+bzlOv4O--
