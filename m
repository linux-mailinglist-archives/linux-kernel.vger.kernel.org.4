Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D897305D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbjFNRRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjFNRRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF5132;
        Wed, 14 Jun 2023 10:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61822644E1;
        Wed, 14 Jun 2023 17:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF752C433C0;
        Wed, 14 Jun 2023 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686763041;
        bh=Zbb5hoog/Puebf5TpE0Zp/30wehyw5cRswSRzy0cnzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMAgsPU2w/Os3tuheNEwgrsYVzF0KDntSZDWhpoaIkJvdKEfreq7VkqNhB8klzELL
         fUAty8wopY432ZG3xnDQwR7kAhMYJsfUVZbz6lJgv9AvcgtJHikfplJzltZor4P6xC
         sf9n4FaIJe2SC0T1DOdDP8keigWyFsz/v8tTzBAMvl1F6Ov8f/dsL5uLHBYA372lx4
         6qNiKj+BfbeMyjCqnGNszlZArKH6r8oowoDEwXW4rYoc+Z7eWW/2X3t5ef5aIAocrd
         16AEQflZJgU7RONo4Nwi0bfbNxLNIM9R14ZipnssKpOCBoSTTLDiZCz1t01HhPZM78
         CfGBJpzkgUBmQ==
Date:   Wed, 14 Jun 2023 18:17:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Woojung Huh <woojung.huh@microchip.com>,
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
Subject: Re: [PATCH v2 5/8] dt-bindings: net: dsa: microchip: add interrupts
 property for ksz switches
Message-ID: <20230614-pessimism-celibate-bcd0a624b1c4@spud>
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
 <20230614123222.4167460-6-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pdz20o4oV1AIZJKV"
Content-Disposition: inline
In-Reply-To: <20230614123222.4167460-6-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pdz20o4oV1AIZJKV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 02:32:19PM +0200, Leonard G=F6hrs wrote:
> The ksz switch driver allows specifying an interrupt line to prevent
> having to periodically poll the switch for link ups/downs and other
> asynchronous events.
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Pdz20o4oV1AIZJKV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIn2GwAKCRB4tDGHoIJi
0nSKAQCaRAF7G/E8L+4Tdad/M48ZtCCFwHTCF2KLVFSi85SwCAD/eEV8HMRTM4ez
KGL/OAwHa27KLQ06AeWPKj1QNwQMCAc=
=DQ6b
-----END PGP SIGNATURE-----

--Pdz20o4oV1AIZJKV--
