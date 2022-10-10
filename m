Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD25F98B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiJJGy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJJGyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:54:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFA7F013;
        Sun,  9 Oct 2022 23:54:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACBDBB80E4F;
        Mon, 10 Oct 2022 06:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0641AC433C1;
        Mon, 10 Oct 2022 06:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665384880;
        bh=nwfZp5lLUlIya2iUpWA+lsysJjyEOIVKDJEmYaPE2cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9xfswY24+6gS89vI/hsVClIloanDjyb0TulySkZGaupDab3XbotfO1KY3Oyvdjb5
         d0QO6nC11vk65VcccIS6xHTtaAUKJr2rQknfxT6UaE4AizJialLo1z/DPvkiWCIBbh
         PbjfGJ70cB6bhcRZrN/s035Z6AaUPDlCm7dOjfNnif09Skmyzg236w+mQ9LtfnTHIu
         hfoHtVP6Bd3Oe341l5buQMHLzKtyO0caYP/uFsFBLSxP474VxjNcuutW/vF4VjyozN
         cYUVtlk7VOOQk6YjfU4S1sRWJKi1HNLPjr+kz6oUuMe4FMKhAvSmWlCkCCk9tN9mU2
         KS3ZYHJ7180Xw==
Date:   Mon, 10 Oct 2022 08:54:37 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: r9a07g043: Drop WDT2 node
Message-ID: <Y0PBrQjNHwZk2d42@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UF1vVMq6ge6UezlV"
Content-Disposition: inline
In-Reply-To: <20221009230044.10961-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UF1vVMq6ge6UezlV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 12:00:44AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 node from RZ/G2UL SoC DTSI.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--UF1vVMq6ge6UezlV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDwa0ACgkQFA3kzBSg
KbYZLQ/7BDetJO40pwnpfU/MNrc7DAz7dtMtB3VjXNqDNHT+9XLmGr3s7xbFpa/P
xVVLkc7s1F8K6kGYYMOQDRg9iaIGCJBYyvKcws7arA9ewIhuxl/dNDl1rhbjk6yW
Uo6j8uNwtsuBcMjZisdBuAAE1UQOAmelYORtZlkIVwuNCZDZmWdvGU1Bzqr6IgrY
rtzHFNE8zTcXSJDgLU1r1WFCmhzIWTWKt/HTOLFVioCq/fq9EG4W4h9MQOb7AgDs
RVWSZrAJ9Xgk9/BQbsYLwtLinWrBHx65dO4YqW9nZU34b6Z+D/E/1aeHx1gL4MRi
gNzEI8+agQLhgH2lWzW7E/IsuCH9VwwgUVkC4OxIyOUClOqIcHIIz8clcXr//2Sq
Ngw9koJBncVpgbArCCTICYIig25V2beafIUH39LwX2cJBF5UlMl2dRz/dXq0/NC7
A6xpNGjxljuw29WT7vXzrITPqE21vxNcMtRhHSYd2MkYadEzNdb8QGUM6I5A4PB5
RPk7RES+LqsnZHBO45DKmsFtMQn4OVStojXup3KeZZmBm7SHfd5RuN1BqhUm731I
3dU9F0kNWN92WmTic/s9nGTbHdJrM8BrF9OOrhCselOG6pFf+EtLRJ4zY+S4qcal
Qfwk3w83VqfzCMD063UTXFGagVGOXJ4a+gye/10EIdrPZgbr9+U=
=IF/6
-----END PGP SIGNATURE-----

--UF1vVMq6ge6UezlV--
