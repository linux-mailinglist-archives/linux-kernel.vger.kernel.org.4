Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35173388C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjFPS5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjFPS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893DDC3;
        Fri, 16 Jun 2023 11:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED5E62938;
        Fri, 16 Jun 2023 18:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C397C433C8;
        Fri, 16 Jun 2023 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941831;
        bh=vv/cmdovIkwrhLiTwDyTYR3pLEAnNU7iGqvbKxXb4LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjwtWBQ8DQYPMPpoGd9LEI3YSXNa1CDIjV9EAL4LDAkFKlQOEB/tXjPb8ev9Vyluy
         5cNqBGbbhNpt0hQcQOarx7D2uDbvD90VmwKjFDfYrBwuWl/TtuBJwJO4z0JxYi6hG0
         W+kChJ+xObPABXkazzq/IhEY+PwSpz8oeMh04RmYmhDzja5UfqGXo/Bj2IL+e5KYl7
         IcsUJZtNS929pvmcwsFhBiyFnTyDWViPXlv1+0BSkZRMngMGH+sB5Tho6YoV4Tm+pV
         09Wrey2BxRVZDGJIhr6okUOYHHyps/rd7kzn5t5MZvKDJC0j9erRpKBZAQ3BX1TinK
         IhRXOKWiV4hmQ==
Date:   Fri, 16 Jun 2023 19:57:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= 
        <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20230616-stopped-bunny-619cf684c9cb@spud>
References: <20230615144423.828698-1-privatesub2@gmail.com>
 <20230615144423.828698-2-privatesub2@gmail.com>
 <20230615-display-encounter-9a7a78562ff8@spud>
 <CAF4idNksCzkh0WMhvb7ecqYfJRLw33GrpT1+eL5S9ydS8Uu-BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BTfG3I7wYmbJRwEO"
Content-Disposition: inline
In-Reply-To: <CAF4idNksCzkh0WMhvb7ecqYfJRLw33GrpT1+eL5S9ydS8Uu-BA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BTfG3I7wYmbJRwEO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 11:02:12AM +0300, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=
=B0=D0=BD=D0=B4=D1=80 =D0=A8=D1=83=D0=B1=D0=B8=D0=BD wrote:
> =D1=87=D1=82, 15 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 19:37, C=
onor Dooley <conor@kernel.org>:
> > On Thu, Jun 15, 2023 at 05:43:56PM +0300, Aleksandr Shubin wrote:
> > > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > > controller witch is different from the previous pwm-sun4i.
> > >
> > > D1 and T113s SoCs have one PWM controller with 8 channels.
> > > R329 SoC has two PWM controllers in both power domains, one of
> > > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> >
> > It would be good to note that the D1 and T113 are identical in terms of
> > peripherals, they differ only in the architecture of the CPU core, and
> > even share the majority of their DT. Because of that, using the same
> > compatible makes sense.
> > The R329 is a different SoC though, and should have a different
> > compatible string added, especially as there is a difference in the
> > number of channels. It would be fine to use the current compatible for
> > the D1 as a fallback.
> > The allwinner,pwm-channels property should probably only be allowed on
> > the R329 and only allow the values of 6 & 9.
>=20
>=20
> Maybe would it be better to allow only 8 channels for D1 and only 6 and 9
> channels for R329?

If you're on a D1, you don't need a dt property to tell you the number
of channels, you already know it to be 8. Couple ways driver could
implement that, for example: if the dt-binding requires the property on
the R329, you could set 8 as the default and overwrite it if the
property exists - which would only be permitted on the R329.
Up to you.

--BTfG3I7wYmbJRwEO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIywgQAKCRB4tDGHoIJi
0iUSAQC6ORafqrG5LIGTBeO7kYUGeuQKemVu5IOojEnUDdNgzQD/XD0jXcAx7S8i
OAlzQpXZMNiBbh73ztIgkb5Xk2l1RAU=
=GAvr
-----END PGP SIGNATURE-----

--BTfG3I7wYmbJRwEO--
