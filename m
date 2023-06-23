Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386CD73BCB2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjFWQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253341A1;
        Fri, 23 Jun 2023 09:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A992E61AAC;
        Fri, 23 Jun 2023 16:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26187C433C0;
        Fri, 23 Jun 2023 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687538223;
        bh=NW9XvLakpQogH6mvEUZjIPGlSUTnzBNwrUFynYh3o/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJzPAhwkm+AcemuxlWYzYNhEY915FCp6SvIYJjbYPN1rAXPDA4LxUOYjcGfmADv72
         Ip7oTc4Nm7ZcDzUUAnQ5jQ+4NgpoQ0T+wHJyznAea88z3EYDPP0UNxqRqQIql3BylG
         ZoAo+dlUtwTOaPJZ5auJas4OxHG2fZKc6MPbEQBFIteaCweVul8tvWDwWK34GzpVYh
         DoRIY77wyvDTJ7r7IiyuLd9yK4YPmD2SpxkS8T197DwwFY/hRYCxit0KolM2z1DkzY
         J7BfSOYe56FBkpXYsrX5MAgIPnyDXEjcdoswG67kyFSLNGI3rfcL8KDzDEOp5BgxAz
         ZQH/52Zw6xVPQ==
Date:   Fri, 23 Jun 2023 17:36:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mka@chromium.org, linux.amoon@gmail.com,
        alexander.stein@ew.tq-group.com, ravisadineni@chromium.org,
        uwu@icenowy.me, fabrice.gasnier@foss.st.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for Genesys Logic
 GL3523 hub
Message-ID: <20230623-lumber-purveyor-e917c1f046eb@spud>
References: <20230623142228.4069084-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jquN0jxas2Nk8JSE"
Content-Disposition: inline
In-Reply-To: <20230623142228.4069084-1-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jquN0jxas2Nk8JSE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 04:22:27PM +0200, Marco Felsch wrote:
> Add the binding for the USB3.1 Genesys Logic GL3523 hub.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--jquN0jxas2Nk8JSE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJXKKQAKCRB4tDGHoIJi
0riUAP43FcDTxm7H2W0bF9q3amiwwvGtNT9O2cZpJD+fBgX+5QEA3nSbli5gRG3N
FjUebV2KZ7TbVrIKFWWwYFsMrUkYZgU=
=hmiE
-----END PGP SIGNATURE-----

--jquN0jxas2Nk8JSE--
