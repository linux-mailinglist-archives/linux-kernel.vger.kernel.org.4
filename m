Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79C372EB38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjFMSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjFMSpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773C106;
        Tue, 13 Jun 2023 11:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CEFE6399A;
        Tue, 13 Jun 2023 18:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40008C433D9;
        Tue, 13 Jun 2023 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686681903;
        bh=quDK8Gy8ZIEfbXIMZtbRCTRyQ5wKmjUdjbmpX3LlFbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vw8qnk7QFSrbWqOde5TQi30Kl7u6Q7E+9nxitIY8pSoGJXV237pSpUmTkva+Jpn83
         ak1TvyWwIF9lKS73/VxS/2JoBNd4CV59YkjJhULr51vDUd+xU+qE9Z3eLYp+Kyv/1i
         DS+6eZ9DbEj4KXshOoFkVTwV46Iv6lSLRo7YX8Fj8hEcB9mBE5rmDNx0Rc9L+eRYJH
         pYAp7wKPdJQKcC2j5zxpTXtUOhjOq//P/VCX930H0OTnKgnO+MDQ0w/yIShqn2h2tZ
         SiT41vQhT2yIF3z9OPRBfQDUQmAggLcfipQeRYIw5I2c4ZP9bNRyGfQOUtIBmfscBj
         JtuO5OeHwsdZw==
Date:   Tue, 13 Jun 2023 19:44:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Rob Herring <robh@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230613-library-enigmatic-267396f84d78@spud>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
 <20230524-blizzard-hunting-4da815e634e2@spud>
 <20230607204351.GA3984668-robh@kernel.org>
 <20230607-refute-acrobat-3b3f645da71b@spud>
 <CAL_JsqLyLs3Vfsd8LRd5_dUbzjE9LgMNnWa+8uP88Ab+E1oLfw@mail.gmail.com>
 <20230608-tiptop-unfold-66c4b8f4e620@spud>
 <82f1d66a-b8cf-69bd-4783-e2c867c11828@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V+uDGWC8cxX7bfEn"
Content-Disposition: inline
In-Reply-To: <82f1d66a-b8cf-69bd-4783-e2c867c11828@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V+uDGWC8cxX7bfEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 12:09:24PM +0200, Nicolas Ferre wrote:
> On 08/06/2023 at 18:49, Conor Dooley wrote:
> >=20
> > On Thu, Jun 08, 2023 at 08:38:10AM -0600, Rob Herring wrote:
> >=20
> > > For reference, anything done by Arm, Linaro or NVIDIA employees is
> > > okay to relicense to dual license.
> > Ah cool, that's good to know, thanks.
> > Perhaps I should try to get a similar edict issued for Microchip ones.
> > @Nicolas, does that sound reasonable?
>=20
> Well, we can work it out internally, indeed. But is there a public statem=
ent
> about this somewhere?

You mean, is there a public statement about Arm/Linaro/Nvidia being okay
with relicensing bindings as dual license?


--V+uDGWC8cxX7bfEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIi5KgAKCRB4tDGHoIJi
0sSEAP0Xu0Wae82AKpJQOqCyRJPQzoqqDRSY/SYQOjb+oj9ArAD+IUwPSdfjYl54
Fy5wytGN094nNRWdBOP4khrNxvoW0wU=
=9ZuW
-----END PGP SIGNATURE-----

--V+uDGWC8cxX7bfEn--
