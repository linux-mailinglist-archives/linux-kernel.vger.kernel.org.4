Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9336C593B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCVWC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCVWCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:02:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075BCEC4B;
        Wed, 22 Mar 2023 15:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C87CB81E05;
        Wed, 22 Mar 2023 22:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF116C433D2;
        Wed, 22 Mar 2023 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679522566;
        bh=hcMZNp9Ksh0riZoo4Yt+LZltGdkzddZrrKlsdq6SSFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBeFLN+n+5IqXTMSRZF99iAhYSZN0+Ozu3ryCbzt6WCEDt4I+X1bWCEK/0N548dPQ
         x70PHNbkMmZBHS9Hod1NOld73/3AJcpG4jEN41y1wfIkwYBF0MbM0XLBdpXDdxEkyv
         LIzhWK4RML4OZXokBhd2Dydd3S+qwp2M9QvP/wnZs4XGvvV4tSqkRyij7RiY2fey4N
         y736dbmlQE9Bx8Iv+qSoyI7QDMJIxNxZXQiVZIPV+9d5Dm5+dh+eAqYZcym6yT16A3
         lvou2VM80uY7v66X9hwQt2qOeNua8XA5P6Lht/1sYQXgGpFL5RwQtQiZvukk9IsJkI
         IMSy7dvbzwppw==
Date:   Wed, 22 Mar 2023 22:02:40 +0000
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
Subject: Re: [PATCH v6 19/21] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
Message-ID: <60359574-8bce-40f2-99db-6d81f6e6c5c3@spud>
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
 <20230320103750.60295-20-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LDF26h45g5RnUqDq"
Content-Disposition: inline
In-Reply-To: <20230320103750.60295-20-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LDF26h45g5RnUqDq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 06:37:48PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add initial device tree for the JH7110 RISC-V SoC by StarFive
> Technology Ltd.
>=20
> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---

> +		S7_0: cpu@0 {
> +			compatible =3D "sifive,s7", "riscv";
> +			reg =3D <0>;
> +			d-cache-block-size =3D <64>;
> +			d-cache-sets =3D <64>;
> +			d-cache-size =3D <8192>;
> +			d-tlb-sets =3D <1>;
> +			d-tlb-size =3D <40>;
> +			device_type =3D "cpu";
> +			i-cache-block-size =3D <64>;
> +			i-cache-sets =3D <64>;
> +			i-cache-size =3D <16384>;
> +			i-tlb-sets =3D <1>;
> +			i-tlb-size =3D <40>;
> +			mmu-type =3D "riscv,sv39";
> +			next-level-cache =3D <&ccache>;
> +			riscv,isa =3D "rv64imac_zba_zbb";
> +			tlb-split;
> +			status =3D "disabled";

Jess pointed out on IRC that this S7 entry looks wrong as it is claiming
that the S7 has an mmu. I didn't go looking back in the history of
u74-mc core complex manuals, but the latest version does not show an mmu
for the S7.

--LDF26h45g5RnUqDq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBt7AAAKCRB4tDGHoIJi
0qDMAQCIGeIN/1mCb1Q1snEUZqE//3UatgEEoP8CxHntNWLrTQD/XTmZpvTZFpwX
3ByenbwoM1VkdniTFBdF5mZUoMNZQgY=
=8Oss
-----END PGP SIGNATURE-----

--LDF26h45g5RnUqDq--
