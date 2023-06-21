Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337DE7390BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjFUUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFUUZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA719A6;
        Wed, 21 Jun 2023 13:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79257616A1;
        Wed, 21 Jun 2023 20:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C38BC433C0;
        Wed, 21 Jun 2023 20:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687379143;
        bh=71PzaMyKoxBeJXspcxYu8rrOAD0xsdLBvCQ9mgAr55Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QoIEg6yMYVqBkSShPeF1qBqn4KK9Ie9YQApFL4YB34t0ofPfdSwAJwSjE26lCeReJ
         OXUOU7ekp7Rx30rDJ6F/JcUTt6jv3wGsY7bI5GqSNWFR16SgotErKqYzvNztqjotAJ
         6HOjVZGhZP2FHIoGISyT/JkOMrEzLgf0lOmDX1UOI87Jh9ohynOPEwlrKKVaUQ+wtf
         dn5uiyh5wACtsUW+1QOH/o6lSM+ZvGyyXBW0976mpYMB/MrQcjd6UC3eElRqjF18Bq
         VqJ+1R0uYrPl8heVW9FkxNT/S5eceRLs/Tb2xfmrNiqUEyKi/M/xHCzfS9I2lg8fqR
         Wlqa1iGRM4H1A==
Date:   Wed, 21 Jun 2023 21:25:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     a.fatoum@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dantuguf14105@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: arm: stm32: add extra SiP compatible
 for oct,stm32mp157c-osd32-red
Message-ID: <20230621-coastline-dormitory-96aab31edf02@spud>
References: <20230621063339.1361073-1-sean@geanix.com>
 <20230621063339.1361073-7-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eZxzdwibNvFMLjCf"
Content-Disposition: inline
In-Reply-To: <20230621063339.1361073-7-sean@geanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eZxzdwibNvFMLjCf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 08:33:37AM +0200, Sean Nyekjaer wrote:
> Add binding support for the Octavo OSD32MP1-RED development board.
>=20
> General features:
>  - STM32MP157C
>  - 512MB DDR3
>  - CAN-FD
>  - HDMI
>  - USB-C OTG
>  - UART
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--eZxzdwibNvFMLjCf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNcwgAKCRB4tDGHoIJi
0oPSAQD8hyF0F6eEopPXhCPfvzs0TO2g608r7XewBzspF94b+gEAvnOvJPFRkJ3r
lvbQtBPWH5wGdAT0GqwGVk5P0Nj71gI=
=re94
-----END PGP SIGNATURE-----

--eZxzdwibNvFMLjCf--
