Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3A726E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjFGUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjFGUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0C2707;
        Wed,  7 Jun 2023 13:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C75646D2;
        Wed,  7 Jun 2023 20:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D9AC433A0;
        Wed,  7 Jun 2023 20:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686170887;
        bh=9sKpccaxmX9doTAUeC3c++CWO+L3WAFAUsJBLGfryic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIsvz5WXnc3KC+vrIgKCXPjOp7pVxra0afjmTXtZYxBhAyh0TCjpGrRqqUzM81Fre
         JLpwFUT+JPPCvxrXaDreIYLPCmqmG3UhCqkvUvXhUaaNf7Ns9jQJBcHXMG1uzjBXvY
         s32dTk9EYb2jLd37hl+8xeK+MH9Ysb+BurBcOa/ihAwveSXoXfu9Ta956KwEbsj1Us
         xw1vRfuqetfGySFuKRs2/mmvwjhvr27R/oS5cjCw/1nI2i70c6bP31KNgK8U5Ede8R
         14kdSyDzae/0/M6tPb8NKbW1+feSvwLw2jpIvTxr3Rfou9OPKp0xk5k/SeMesCHBeo
         n20DjSCaaVvFg==
Date:   Wed, 7 Jun 2023 21:48:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230607-refute-acrobat-3b3f645da71b@spud>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
 <20230524-blizzard-hunting-4da815e634e2@spud>
 <20230607204351.GA3984668-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CRbTNylh+HJ+G0nN"
Content-Disposition: inline
In-Reply-To: <20230607204351.GA3984668-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CRbTNylh+HJ+G0nN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 02:43:51PM -0600, Rob Herring wrote:
> On Wed, May 24, 2023 at 08:19:08PM +0100, Conor Dooley wrote:
> > On Wed, May 24, 2023 at 03:35:27PM +0300, Claudiu Beznea wrote:
> > > Convert Atmel SAMA5D2 shutdown controller to YAML. SAMA7G5 SHDWC DT n=
ode
> > > (available in arch/arm/boot/dts/sama7g5.dtsi) has syscon along with i=
ts
> > > compatible. There is no usage of this syscon in the current code but =
it
> > > may be necessary in future as some registers of SHDWC are accessed in
> > > different drivers (at91-sama5d2_shdwc.c and arch/arm/mach-at91/pm.c).
> > > Thus update the YAML with it to make DT checkers happy.
> > >=20
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >=20
> > Modulo the license thing that I mentioned on v1,
>=20
> Should be fine given it's an Microchip employee changing a Microchip=20
> binding.

Aye, that part I figured was fine - it was the when I looked at the
blame for the files & they were filled with your name that I wondered
about the licensing.
If you're okay with it though then clearly there's not an issue :)

Cheers,
Conor.

--CRbTNylh+HJ+G0nN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDtAwAKCRB4tDGHoIJi
0ouDAP4mi4vjAQvARowdJZWeA1v9bVnwZ8/8xHXHfrAuJy+fYgEAqbtuOxnkH91I
6ywA3pjB+Up3KD43T5iS3FJxRRTMnwQ=
=iVKO
-----END PGP SIGNATURE-----

--CRbTNylh+HJ+G0nN--
