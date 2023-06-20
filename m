Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5DC7377AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFTWz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjFTWzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AFB1988;
        Tue, 20 Jun 2023 15:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8904261408;
        Tue, 20 Jun 2023 22:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6428C433C8;
        Tue, 20 Jun 2023 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687301745;
        bh=sL+llKy6MBaR/eUwxdHscc21DlU/nNSX6MzdvmC4oY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVlIZxgXZNEK+cyS+H5mIux7i+ZFZSDB7YnVOooKYOD54Bggg2CzFIOjUGRo/aZdJ
         N7XCkCXp9huYAamUL6hCY4qj9Yy5dMQM7aPM5ru6yhZTLhXYzOyGm4VEY3lHe2/BYV
         FZCslF7LBNHTJQpNhEs7x1oUBBxcCNBL7M0BoFouDotQGROLvj56erdA0zf5iKFIgg
         6Va+nhGx3sr90oh5viVpniYs3peM6xy315cQ7Xi1oJr5LkqQsHQmRAd4TDphbvgId+
         e5TXfD7wwAS1JvCRjLQiwhmu0D2hX6walnWrRWW0JV6mtVaKSMx/KlcTy3rGL0FBYM
         wkGEmHEVQNU3Q==
Date:   Tue, 20 Jun 2023 23:55:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, arnd@arndb.de
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <20230620-google-powdery-640c8d03d864@spud>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <20230617-duress-phantom-3da79e33f204@spud>
 <ZI8wEp52bpqaCHAl@xhacker>
 <20230620-catcher-jaybird-945d26a4f642@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Jk+U6Iaw+rqo4Jv"
Content-Disposition: inline
In-Reply-To: <20230620-catcher-jaybird-945d26a4f642@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Jk+U6Iaw+rqo4Jv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 11:52:46PM +0100, Conor Dooley wrote:
> On Mon, Jun 19, 2023 at 12:25:54AM +0800, Jisheng Zhang wrote:
> > On Sat, Jun 17, 2023 at 07:20:43PM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
>=20
> > > I'll send it to Arnd as a "RISC-V Devicetrees for v6.5 Part 2" once it
> > > has been in linux-next for a day or two.
> >=20
> > Thank you so much for helping the PR this time.
>=20
> Just FYI, since I think only I get the notif emails, Arnd has merged it:
> https://git.kernel.org/soc/soc/c/c9a5aa0e53d0

Bah, wrong link - that's the one that pw bot told me it was, but I guess
it got confused by the fact that I had sent 2 PRs. Correct commit is:
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=3Dsoc=
/dt&id=3Dd8ece8b832276756d32c310fdd76835f8046071a

>=20
> Cheers,
> Conor.



--+Jk+U6Iaw+rqo4Jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJIubAAKCRB4tDGHoIJi
0gs7AQCzsN6FosuWDw5ccsUpVbY/OJRy2E6qhPCpvuQuRxRNoAEA019WavBu8+m2
874m+pwDmhD3vGOrngQrKR/Qhnoy0As=
=RSDy
-----END PGP SIGNATURE-----

--+Jk+U6Iaw+rqo4Jv--
