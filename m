Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B999A72ED89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjFMVCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44E1199B;
        Tue, 13 Jun 2023 14:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587146104B;
        Tue, 13 Jun 2023 21:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E720AC433C8;
        Tue, 13 Jun 2023 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690146;
        bh=jyw8frzPoCYARfrEDCQDW+9wm0qWESJzWlGdSUEQ4vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/52i+n0lFJdCwXaDLrEEo8Sr+kIVC40XOIu6Qj9sBJSRRMawRPZrnHGySsMZmDnB
         rDanIwfX+gcEnZ3fHJiUKDKbxoPfnICb0SPKi6ew+vJX1KuLJtV511U5sJ/SWzpXoj
         oVUnp5aUG9UIfn9KKFJtKn2G8GEEnDOyUw6ssia00UOE9xkw7FXNMb/ALGqzvZOwAx
         IdGcYYXW6fWHuJPP4rMI3YVnCCUeYxocePySqqqP7v/rJjyyLr8Luohw3Epjtm5mt6
         HoD+QcXuq9flJgIrL3gYwpGvPrZYNQOqLVOeJJnfTWd3tGpW63DS5jvDua95RQWDi6
         Jd7gr+kXTjORA==
Date:   Tue, 13 Jun 2023 22:02:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: partition: Add missing type for
 "linux,rootfs"
Message-ID: <20230613-massive-varmint-7c3b33cf1d02@spud>
References: <20230613201014.2823185-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qpOSysnE7Jq8zno5"
Content-Disposition: inline
In-Reply-To: <20230613201014.2823185-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qpOSysnE7Jq8zno5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:10:14PM -0600, Rob Herring wrote:
> "linux,rootfs" is missing a type, add it.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--qpOSysnE7Jq8zno5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjZXgAKCRB4tDGHoIJi
0i0aAQDFRm9BBtjFLcppPVZdx5ZJLT/LY2z8dhtUjvOrme3xKAEAj0vflj1emuNf
XYUKJeIlIsGDh8WQuJKgJvN5Fxm6uAU=
=5DDt
-----END PGP SIGNATURE-----

--qpOSysnE7Jq8zno5--
