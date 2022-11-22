Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9339A633C23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiKVMLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiKVMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:10:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108C12B26F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:10:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98F526150E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46553C433B5;
        Tue, 22 Nov 2022 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669119057;
        bh=DtV2h8FivTfdDUXJoB4SQQni/qpt2dxJOrOYaC014J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9m9k0tteHyhjr85QmDe9m0pfamoOziOXy0m69unuTUROwDERCikkfy3XncMc7j9Y
         /OioOh7BjASqlzkObxEKvlPYzlN6MVViJuf4XEwrTjzKXuH3I98hJGTdpcSoS7jKQv
         9X4r9LrjdY4ij1StBkdG6SzDbBFc6lLvBiuLzJmKmrvOpwK+ZyTclkbU40ogiboqaW
         QqguIG9A2ufHKnWkQDStdMhJhfU7D98rs4LaZG70kKDRDeRSfEg7QYPupbM2n+MuhG
         VtUeMjMhqFgnuGthsUZ5mHstoT1l3JW9y+s31Sl3SXQW++Y8FShrMM3R54bBxSdors
         D+G5Jfk6V4vAA==
Date:   Tue, 22 Nov 2022 12:10:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: da9062: Make the use of IRQ optional
Message-ID: <Y3y8TIolbZPl5sZG@sirena.org.uk>
References: <20221122095833.3957-1-cniedermaier@dh-electronics.com>
 <20221122095833.3957-4-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sN/OunOKhwC/ExgB"
Content-Disposition: inline
In-Reply-To: <20221122095833.3957-4-cniedermaier@dh-electronics.com>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sN/OunOKhwC/ExgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 22, 2022 at 10:58:33AM +0100, Christoph Niedermaier wrote:
> This patch makes the use of IRQ optional to make the DA9061/62 usable
> for designs that don't have the IRQ pin connected, because the regulator
> is usable without IRQ.

Acked-by: Mark Brown <broonie@kernel.org>

--sN/OunOKhwC/ExgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN8vEsACgkQJNaLcl1U
h9BSqgf6AtSVkkYzJsRl3gVphKYwjujkDA8eqX3869S7XK3F+pb19luxGjagpLlc
5vJMJCnCP4/hayNZIaCFAL/t5CBMEUGWfOpS/FqDhygbb+8pinZgorSVzqb4xq59
XcI00rJAtNKXjFddMKeM9xjIAeu7z3BDubWxNcqdR1FpVa4YwM3msMSKNpw23mu8
yUimaldak+n8eDyy2DCLzGeWJ1CshCxZ0yJw3oQyQNoNr2zslcKt6/wHKsi0Drm1
Aac2CN9sN2nObjJV0Z+XJGaqxH5AeN/BC17ew/DLp34BmaSkLXw7wURgsvuTR90P
JpLEIazSwXxzne4/Q28sqK0sH0pFlw==
=fiRX
-----END PGP SIGNATURE-----

--sN/OunOKhwC/ExgB--
