Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BF66404C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjAJMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAJMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:18:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB98512AE2;
        Tue, 10 Jan 2023 04:17:58 -0800 (PST)
Received: from mercury (dyndsl-091-096-058-120.ewe-ip-backbone.de [91.96.58.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D6F96602D70;
        Tue, 10 Jan 2023 12:17:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673353077;
        bh=HeioJvW2EDpDXIEq1ksZSMdC1zFkMJZkIFamkQAcslU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtCCfocD0LKLyMXne6qKIrIuBAfiv/V08/5iZtF3DxLxpY3DvU+r8Owim4t0FHfGo
         aN83JeeYKZj5CCpXCbiGtNdS9hXbFa7lPR9ZkwmPSJK8Un5cYIZQeZt+uf6sGSKcOv
         b+DI2wsqsgfv1gR7rrA8e0FUnWEtRlWRqOt7BdbfY8aI3S8yOiZ2lP9/iSYVvtbnhr
         NJaoMg7oz2oSMWJqZwC+ucHdZJcO4VuhxvZAkZcMO/+p4/ir3+oms09hsMR/2+Ag/y
         zAWCxqfXARKv17bDWLdZW0v+26d0o+nkyfL8nlHqdbORUznoibbOgfBlWPuPijFY44
         pZj7rEVHEISOQ==
Received: by mercury (Postfix, from userid 1000)
        id 0F11C1060774; Tue, 10 Jan 2023 13:17:54 +0100 (CET)
Date:   Tue, 10 Jan 2023 13:17:54 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCHv8 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
Message-ID: <20230110121754.2olqdzbe7wst3u4n@mercury.elektranox.org>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com>
 <20230109155801.51642-4-sebastian.reichel@collabora.com>
 <2865022.7s5MMGUR32@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="etl67xvjo66sk2qd"
Content-Disposition: inline
In-Reply-To: <2865022.7s5MMGUR32@diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--etl67xvjo66sk2qd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 10, 2023 at 12:47:23PM +0100, Heiko St=FCbner wrote:
> Hi Sebastian,
>=20
> Am Montag, 9. Januar 2023, 16:57:57 CET schrieb Sebastian Reichel:
> > From: Kever Yang <kever.yang@rock-chips.com>
> >=20
> > This initial version supports CPU, dma, interrupts, timers, UART and
> > SDHCI (everything necessary to boot Linux on this system on chip) as
> > well as Ethernet, I2C, PWM and SPI.
> >=20
> > The DT is split into rk3588 and rk3588s, which is a reduced version
> > (i.e. with less peripherals) of the former.
> >=20
> > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > [rebase, squash and reword commit message]
>=20
> I guess that means the list of Rockchip Signed-off-by lines above come
> from the squashed patches?
>=20
> If so, I guess I should add Co-Developed-by lines for them, as right now
> the list is incorrect (author should be first, then everyone through
> whose hands a patch went)
>=20
> Meaning I can add those Co-Developed-by lines, so no need to resend,
> I'm just verifying what I assume about the lines :-)

Yes, those are SoB lines from squashed downstream commits.

Thanks,

-- Sebastian

--etl67xvjo66sk2qd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmO9V24ACgkQ2O7X88g7
+poilA/+MN4W+QsHbvMNbtuiZsAWUBT6+TraHXOrSpji98es5iHLVjjGxCQakYTU
XMQfXzNsrzhK4KEgJrAYnO2amzDgmTngdsJo1c2PsxthXsOVSb9G95dpGwJt0iSv
+YD+cZyvdY5YkIQabTfOOIOLcnk2Lz4ViXa8r2r2+dVkA+GXmq0/l4jTwsC2LK3Z
4iQ3N9EOn82RW/b+K/GYBHHQHz6FjXcxCDnctq6qhLbzIBTtmG6ToESzLl3SQbUI
Up872Q/QirRm3/96QfeeFI2TedRPkDgjFLiJ8tH6lVSKhCFcrQ/R8mijyFSRDVFM
myAIj1joNhmQEWBiqd6uSSuEptgwQd2vckTpbs+t3+0aSUZ3WEGeCTkenQepiGvG
SC3RdX8T2YEwhmknXG8eMhg+GtJlavc/LzNUfxFtYW7w5WNWapDsDspxgUxU3O0y
gIj6tCk/EqeCQ4u9Prb6XyQVebEbN+nM/qdbeJlnBYQ65p/EqKDK6hAoyQCnoxa9
vKsVgl7VLZeJUPiwCRz4SanQF6rfHuTyKkaUAiIahZV+jO+9GuP2155XxjL9tEPE
WXiot7wtu3CML7kD0RRXc4UZFy1U+6GaSr4bzD3v9gCGtSZGx+a1YuXQKP+j6asF
6y2tPoTS5hqygztq1DOGrNOTb0ceADzdgmOgygjBKTtT74yKvMM=
=AHuN
-----END PGP SIGNATURE-----

--etl67xvjo66sk2qd--
