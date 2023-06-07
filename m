Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDB7267C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjFGRuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFGRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D601FC8;
        Wed,  7 Jun 2023 10:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ADE063E33;
        Wed,  7 Jun 2023 17:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA0C433D2;
        Wed,  7 Jun 2023 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686160221;
        bh=Lh3GTOntqJQl1g5VNvi2bJaDIfCMRBsPjG63W21D82s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUzpS1NK7A4AtPl2K1f/9bnrmb1nsYllcdKF4pKNX0Wa1OvV7C0NT5vGcMKl2dJvJ
         8xUXnFGNQPgyTt6XkozDLkaO9RgHVUndc7r42icdm3k3btHWyssRoVa+CocO5JqLXf
         MeaEPyymuN106RSjLdNN+7hoRnyr+ZVSvLZn0PBKTVLjRznxRMUCmVVzKg4pckpu4z
         XQqkaXeyCF35K0PTJaB1+yX87Yf6HZ44CpDCwzeb34+7FWuCjehtoBJvX8CTYC4Q8M
         4w9yV6eVOJkp5TQ7k/oTZdNSqHFLWm18XoIlpqTKRypIyn4pjlbntZRWj2HBoyiQHP
         mCbSPQ6nAHZrw==
Date:   Wed, 7 Jun 2023 18:50:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
        kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/8] dt-bindings: net: dsa: microchip: add missing
 spi-{cpha,cpol} properties
Message-ID: <20230607-frostily-unified-793fd484cdaa@spud>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-5-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zBx+C4tB0CVmRgsN"
Content-Disposition: inline
In-Reply-To: <20230607115508.2964574-5-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zBx+C4tB0CVmRgsN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 01:55:04PM +0200, Leonard G=F6hrs wrote:
> This patch allows setting the correct SPI phase and polarity for KSZ
> switches.
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--zBx+C4tB0CVmRgsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDDVwAKCRB4tDGHoIJi
0qf6AQD9nTBq9FNEgljjbdJnW6DT5qPjt5jSADd2JocfChv9sgEA/CA0GCiVODJe
/llmNWDWV6A3uzzwUaOeChjPfemn9Q4=
=+zpf
-----END PGP SIGNATURE-----

--zBx+C4tB0CVmRgsN--
