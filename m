Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D4705976
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjEPV2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEPV2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637806A54;
        Tue, 16 May 2023 14:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0098E63F95;
        Tue, 16 May 2023 21:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B337C433D2;
        Tue, 16 May 2023 21:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684272513;
        bh=Ey5gUSi9t1a1IP9c0w+UzkQFrYVXDaDnsgN/sFKjGII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbfkaV+z+GlS+eJJ0v3BcteCWgB1jJAn8xGbb1QZ1gRI7alLNu1Smy2pZdSmvbr5M
         kMoVHI6j4etTpAtqqGGpYnJph98zsolr7xmNA4jNen1H2Bhseb2HZVuPRkliScWe+c
         Wn7SLMjTQuREt085xZNEtZWnkHeJxD5lb09fO1kAceumTJ4ZIodvs2yWhI4FOsuvfv
         DPgnjVzpkfZqRSXj8XdmwW13PmhSWCR+KVcIsv8nxjaVzybGuxJ/NgAVc/B4M2M/Ta
         BnQHeBXb3CR6yT5F/xw9vjYflBUECL12c/97crcOaO68aG4X4OqAf/qbiUwPyN8q2K
         p284Wcu+4dU0w==
Date:   Tue, 16 May 2023 22:28:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 09/10 RESEND] dt-bindings: power: supply:
 rt5033-battery: Apply unevaluatedProperties
Message-ID: <20230516-nursery-thespian-c1555bfae0e1@spud>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <ef86067348f01a3bbf1bd9b4f81716b62ea1f552.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XHyEp9fDNNnMOGLu"
Content-Disposition: inline
In-Reply-To: <ef86067348f01a3bbf1bd9b4f81716b62ea1f552.1684182964.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XHyEp9fDNNnMOGLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 10:57:18PM +0200, Jakob Hauser wrote:
> Additionally to the already available ref "power-supply.yaml", replace
> "additionalProperties: false" by "unevaluatedProperties: false". Otherwis=
e,
> when referencing rt5033-battery in an example, message "'power-supplies' =
does
> not match any of the regexes: 'pinctrl-[0-9]+'" will be returned.
>=20
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--XHyEp9fDNNnMOGLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGP1egAKCRB4tDGHoIJi
0shZAQC/GEQJMZqeVof/CRj6u51s7skMPLITFZJ2QlYgo7U1AAD/TSYyeeLBD9Yp
SkuJv3wbFVOcDZ7TKpuDnA1xHEgMwwY=
=nE0N
-----END PGP SIGNATURE-----

--XHyEp9fDNNnMOGLu--
