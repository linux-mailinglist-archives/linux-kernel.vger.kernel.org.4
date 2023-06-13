Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7DD72ED6F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjFMU63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A971730;
        Tue, 13 Jun 2023 13:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA81D63AF0;
        Tue, 13 Jun 2023 20:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B630C433C0;
        Tue, 13 Jun 2023 20:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686689904;
        bh=+MPBvnhjOYB8US9eKD+PDWZ7Nb61K2hcSbKX4PkjofY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0C84dnU/z+WJpnQ1ujhLFf8ha6+fe+Adw9e/sRbSc82E8Aw60V/qhxcEVovG1L8S
         tDFtatcIi9rYfbu+/fChzJxh8UduFX9rOLZ3di7J2ri2ayyucV3il6DJgKEPIyMrxR
         nQs2UJLm/9zzbdwJUDTinlLiCXhHvNaOHGdXT1qub2SP/S3TE4D00tJeWLSWp2Vc7Y
         jFLjEW2qh3UfDMm79Shf+L3eGqwH5eHlaOR1PYWBeqcsX0F5o4ZUGEb7mHsLtyEu+x
         j+iJdpSKun3MjdPBtr0O1B/+aKoEAbq04vd+rvlsPN35cjRCH+QMFcvlALeK86v2q5
         kBByWe05oL0lw==
Date:   Tue, 13 Jun 2023 21:58:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Lee Jones <lee@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: dt-bindings: pwm-regulator: Add missing type
 for "pwm-dutycycle-unit"
Message-ID: <20230613-blustery-granny-f6c40b2fbbd3@spud>
References: <20230613200956.2822740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0/VSTaqhwMdK1KNy"
Content-Disposition: inline
In-Reply-To: <20230613200956.2822740-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0/VSTaqhwMdK1KNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:09:56PM -0600, Rob Herring wrote:
> "pwm-dutycycle-unit" is missing a type, add it.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--0/VSTaqhwMdK1KNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjYawAKCRB4tDGHoIJi
0jwuAP9oDB/MpZD5C/WHFxgupbHiZaSWuWncmkxicItqbsqOZQD/RAXv+3C1cxlB
wjwiB7DbhgMJXtf0CSmLw7hAZ2dpBww=
=IgNX
-----END PGP SIGNATURE-----

--0/VSTaqhwMdK1KNy--
