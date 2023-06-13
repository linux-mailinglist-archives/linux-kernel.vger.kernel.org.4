Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB76772ED8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjFMVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMVDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C424199C;
        Tue, 13 Jun 2023 14:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF7563B00;
        Tue, 13 Jun 2023 21:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402ADC433C8;
        Tue, 13 Jun 2023 21:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690194;
        bh=cF+TfzFe0MycEoX9ZmraaTaY2ChOoxWjfNfdgDrwSWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcl0/pDQyZucBLdSG9aXvlUWBa3rJ2NmWw95mqBbfE4mh40KH9Iu0Zlt1JTZDFJcy
         9UKxpqkmT0rfJrs8lyAutKHzFVl8AhMJh3IPkZepSKXXlLESlVaOmpB0UwY2eaaD+g
         m2ZEELut7MoHvlF8nx1xfBsp2yKhmL//hO30+8ggVJljWP4fGwuhEyHbK9eLtT1bxn
         7ZmOx3Z2enmkZWFcbzLdpFV2D8C8POjvhrTGt8qn1cQinQKWC7CFOQMuZwNWcOEDeT
         7wb+mVeOtU65eOON9hevcjdgfJoBh2eo6vBTpBjlh00xEs+tYLG7X3pYTsiKi+UAL2
         oNQqgyLefUimw==
Date:   Tue, 13 Jun 2023 22:03:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jianhua Lu <lujianhua000@gmail.com>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: backlight: kinetic,ktz8866: Add missing
 type for "current-num-sinks"
Message-ID: <20230613-truce-unflawed-e6b091e528d5@spud>
References: <20230613201022.2823392-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T6hh2g3NBkjZXkBj"
Content-Disposition: inline
In-Reply-To: <20230613201022.2823392-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6hh2g3NBkjZXkBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:10:22PM -0600, Rob Herring wrote:
> "current-num-sinks" is missing a type, add it.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--T6hh2g3NBkjZXkBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjZjQAKCRB4tDGHoIJi
0n/wAPwLSgz6x8e47r9gpp+j/WGN2jBUiWYJxYZzARfefe2F5wEAl4k63nzlFTyb
MVdaEHqnsmKnYkDMhQStYypjZ9pCUQU=
=6dKP
-----END PGP SIGNATURE-----

--T6hh2g3NBkjZXkBj--
