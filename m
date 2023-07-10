Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E674DD41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGJSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjGJSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED9D7;
        Mon, 10 Jul 2023 11:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04EF76118E;
        Mon, 10 Jul 2023 18:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A35C433C7;
        Mon, 10 Jul 2023 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689013330;
        bh=DwcO+o1R/a+Nt11F/Q0QjUAVGt2AFDVhptU2LgCMxXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hc5I5dE/g0HP68D/v/e1stZsGfwtImR7MDxceRcvfTdWld9g4vQoaGIBM5OOoB1cR
         5daWfnLXpAFb474s6+jEeDGfIvex1vVxx2sBtDyMx40AGumVhmxHx9SyNnRc7LrON0
         x4VvbMgTlR+8C7jan+PXYjH9NJx6CyrJ5FDhEA/aX4RFE5tf/t6KSnEnSmT2v9Ypqe
         9SPZHjNONzc1CG1XQswn/EtqhzPBQPGmF2/YvRbT5XE+BEkONs61UkLak+mdVC9VIJ
         VVGv+FqrgE800kRf/2Qn+tVfOitEd2pQkYRWNvG4T6gFcFv/pS9qja+TwUFwPBBNBg
         1oS4KB5lApM8g==
Date:   Mon, 10 Jul 2023 19:22:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Remove obsolete nxp,lpc1850-uart.txt
Message-ID: <20230710-ladybug-floral-a5c51a7bd97f@spud>
References: <20230707221607.1064888-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cym97/vo2kOTosYm"
Content-Disposition: inline
In-Reply-To: <20230707221607.1064888-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cym97/vo2kOTosYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 04:16:06PM -0600, Rob Herring wrote:
> nxp,lpc1850-uart.txt binding is already covered by 8250.yaml, so remove
> it.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Cym97/vo2kOTosYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKxMTgAKCRB4tDGHoIJi
0oUaAQCGLVZ9mPDkEzjAABmyDv0H/Xa573HgVjZkJj+dNKaoTAEApKgGem1VPjk6
NhbOa0G1XvGusevOs+Z1ku8BolcVRww=
=ZEY3
-----END PGP SIGNATURE-----

--Cym97/vo2kOTosYm--
