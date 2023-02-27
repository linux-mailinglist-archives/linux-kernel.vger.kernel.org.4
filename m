Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20576A494D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjB0SLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjB0SLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE1C234E0;
        Mon, 27 Feb 2023 10:11:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B7CDB80D9B;
        Mon, 27 Feb 2023 18:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFC2C433D2;
        Mon, 27 Feb 2023 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521459;
        bh=DOHUe/rKd4Y5se+LG1sBl0aEKX8kJIlO/WrMBCDbdHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqfwDOSlaSp5BGPrGTKvNyP1z/82q2jPCl9GCkK0TE/mwKVwg4OVRMb5mqpmnKe1y
         T1boAN57lDvG1V7nmVpu14zrcNZqR9gBvGGzs/hGRxeltb3R6QiXpFftkn4JTH4CqZ
         W6g+0dCzNFx2giXVyVAxyvYxgUHUHHZcnY730nmic7gG1aRPXzYTwwU2Wm40cKoVmj
         jPH6NNOg2gELeCg+Pb+uk/fOLFYyZSomCkD0zXUJ01nv/+DSzXUm9hJ61KRoIDmhmJ
         k+jMyqF9dan2/HyBoAzPNhnB0FLYVJaLSf3HLra11CBnBq1cH5SGq5R6vcCecpWe8n
         cF5PNLOJx93mQ==
Date:   Mon, 27 Feb 2023 18:10:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/19] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
Message-ID: <Y/zyLLdpf4zTXISh@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-18-hal.feng@starfivetech.com>
 <Y/T5eL4s8FSlbgQh@spud>
 <af029196-6ebe-aae1-af7e-fdb327c14c82@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jchMPtDjeYaZT9S4"
Content-Disposition: inline
In-Reply-To: <af029196-6ebe-aae1-af7e-fdb327c14c82@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jchMPtDjeYaZT9S4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2023 at 03:16:51PM +0800, Hal Feng wrote:
> On Tue, 21 Feb 2023 17:03:52 +0000, Conor Dooley wrote:
> > On Tue, Feb 21, 2023 at 10:46:43AM +0800, Hal Feng wrote:
> >=20
> >> +		S7_0: cpu@0 {
> >> +			compatible =3D "sifive,s7", "riscv";
> >> +			reg =3D <0>;
> >> +			d-cache-block-size =3D <64>;
> >> +			d-cache-sets =3D <64>;
> >> +			d-cache-size =3D <8192>;
> >> +			d-tlb-sets =3D <1>;
> >> +			d-tlb-size =3D <40>;
> >> +			device_type =3D "cpu";
> >> +			i-cache-block-size =3D <64>;
> >> +			i-cache-sets =3D <64>;
> >> +			i-cache-size =3D <16384>;
> >> +			i-tlb-sets =3D <1>;
> >> +			i-tlb-size =3D <40>;
> >> +			mmu-type =3D "riscv,sv39";
> >> +			next-level-cache =3D <&ccache>;
> >> +			riscv,isa =3D "rv64imac_zicsr_zba_zbb";
> >=20
> > I still think that adding just zicsr here is pointless. If you're going
> > to be specific, why not also mention that you have zifencei too?
>=20
> I would like to remove "_zicsr" in the next version. Thanks.
>=20
> >=20
> >> +			tlb-split;
> >> +			status =3D "disabled";
> >> +
> >> +			cpu0_intc: interrupt-controller {
> >> +				compatible =3D "riscv,cpu-intc";
> >> +				interrupt-controller;
> >> +				#interrupt-cells =3D <1>;
> >> +			};
> >> +		};
> >=20
> > Rest of this looks fine to me though, thanks for adding the s7
> > compatible and zba/zbb :)
>=20
> Thanks for your review. :)

I hadn't actually given you one yet ;)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--jchMPtDjeYaZT9S4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/zyFQAKCRB4tDGHoIJi
0uCOAP0RG8BuWjiHLKsk9Ta/tG1NUylVpgAZoi/pMyqsZdEj3AEA6Oh4RV2oBS2o
sASwV0YiwNzQ/L/MsZJwES9WoODoXQ4=
=WQDI
-----END PGP SIGNATURE-----

--jchMPtDjeYaZT9S4--
