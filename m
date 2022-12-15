Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FB64DCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLOOBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiLOOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:01:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969229CA5;
        Thu, 15 Dec 2022 06:01:01 -0800 (PST)
Received: from mercury (dyndsl-095-033-168-084.ewe-ip-backbone.de [95.33.168.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DC526602C62;
        Thu, 15 Dec 2022 14:01:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671112860;
        bh=bes/p3oZNVoNWZ83nnaJacGNZpgWf626JfDetsGaY9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kd9Cd27p77TZBaKsqzd13pfEx/dnVhQbItrGXWss6Q1UAYel8SbUSXY9kjjbFYmNT
         vE0mpOCnvOtlQVSVBF2oiFKvzfq830f1GLloxHhehlf5sW3XUN7Ym79EYZlo1gZQ9/
         UMtr+MW0Ej5IvRdl5bUGuTvHmuDhjCQSAfKba7bFFJoP9JaSGU76AfyK2SLaU8m6pt
         TutBiwfG0AYkFUXSvWHZ2jEQKzGeDWkpHDQH8IJaFRrmmNp+356Wg6ZMJwxn6EVbzA
         VW2oGt/RUlZVbeQ38SQ5C1XZ7mAMPj/y5nF/CRoinGgRgGAMGhr4J9pbGEGQ4W+YnU
         SmXIQGeb4NdgA==
Received: by mercury (Postfix, from userid 1000)
        id 786351060F45; Thu, 15 Dec 2022 15:00:58 +0100 (CET)
Date:   Thu, 15 Dec 2022 15:00:58 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCHv6 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
Message-ID: <20221215140058.ef4z5k6bg4tob44k@mercury.elektranox.org>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
 <20221214182247.79824-4-sebastian.reichel@collabora.com>
 <861qp1qawb.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vhghmurxxhva64ws"
Content-Disposition: inline
In-Reply-To: <861qp1qawb.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vhghmurxxhva64ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 15, 2022 at 09:22:28AM +0000, Marc Zyngier wrote:
> On Wed, 14 Dec 2022 18:22:43 +0000,
> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> >=20
> > From: Kever Yang <kever.yang@rock-chips.com>
> >=20
> > This initial version supports (single core) CPU, dma, interrupts, timer=
s,
> > UART and SDHCI. In short - everything necessary to boot Linux on this
> > system on chip.
>=20
> Single core? The DT indicates otherwise.

oops, that's a still from v0 (missing from the changelog since that
was a big rk3588 series also containing the required driver changes).
I will update the commit message in PATCHv7.

>=20
> >=20
> > The DT is split into rk3588 and rk3588s, which is a reduced version
> > (i.e. with less peripherals) of the former.
> >=20
> > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > [rebase, squash and reword commit message]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588.dtsi  |   58 +
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 1703 +++++++++++++++++++++
> >  2 files changed, 1761 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >=20
>=20
> [...]
>=20
> > +	gic: interrupt-controller@fe600000 {
> > +		compatible =3D "arm,gic-v3";
> > +		reg =3D <0x0 0xfe600000 0 0x10000>, /* GICD */
> > +		      <0x0 0xfe680000 0 0x100000>; /* GICR */
> > +		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> > +		interrupt-controller;
> > +		mbi-alias =3D <0x0 0xfe610000>;
> > +		mbi-ranges =3D <424 56>;
> > +		msi-controller;
> > +		#interrupt-cells =3D <4>;
> > +
> > +		ppi-partitions {
> > +			ppi_cluster0: interrupt-partition-0 {
> > +				affinity =3D <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
> > +			};
> > +
> > +			ppi_cluster1: interrupt-partition-1 {
> > +				affinity =3D <&cpu_b0 &cpu_b1 &cpu_b2 &cpu_b3>;
>=20
> The use of the word "cluster" is pretty misleading, specially as the
> actual CPU clusters don't align with this partitioning (you seem to
> have 2 independent A76 clusters). Consider using the word "partition",
> which was chosen exactly to avoid this confusion.

Ack.

Thanks for the review,

-- Sebastian

--vhghmurxxhva64ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmObKJoACgkQ2O7X88g7
+pqSxA/+Ov5W261EUF1etZd1nEUZ+/anwZE1vz8D+tXGrg5/XW4pgWbP+muhaiaf
fr/BGViuMnfg18+ClF1e6JTxI1pXLfKkKF/iZCcizzphDoWsc3wU377mbvsh5ral
rFE/UWgiQO/7eeYqRSW2xDS5OHhb/vln+s/vwJddIkOGVvQyQAbyiJCfZP/bWZbG
f9oP4RlqEFZ8QoGYgrHSprRkMYCb02/94tt6M9LhY26DyvsCggNx45Sq2RzzJG0x
3BN6k5XdQb7mgKfi7tppo9hNsvX62kU5W7lzfYmHTu3MmtGisdcPXbSEO3M0+87Q
jYUcJo1+ZGDe7xEMlfRSnpW3dAWcjmSKRb/8qNKK/PE5NlnuTMlXnmktX8TCZXfm
a1qlaaNjTMOfSbCHP0UUEIZ+kP1EjuB0GlYD+Y0AgbBkNBX72OHoZ+sL9gXRr3N7
fF4R9Q1c8WEd2kzBD8jsyrGG9Tnmm69ws6bm+3JVGyzmsGq/6GpZbEpRUatwQxfy
06U4BBrhfA0wDpsm5Ix2QgCPc+GNRN/wMwfCIo41oyw8obRgrXxG/UJ8u6nDo0cm
ef2tfdAx8luxli5X3U26kLgFJVjpS/qcdfwetK7bhzaTXatQdR3eVC9HOTmID2id
2W19e7FAnuJIJw6MNgyEjQt52i4rHvdC03bszeFDOu31xXVtew0=
=Io72
-----END PGP SIGNATURE-----

--vhghmurxxhva64ws--
