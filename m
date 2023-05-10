Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D676FE4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjEJUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbjEJUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA0E4C12;
        Wed, 10 May 2023 13:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041BB63FD6;
        Wed, 10 May 2023 20:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E19C433D2;
        Wed, 10 May 2023 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683750168;
        bh=K0GUlOR4QFLJUalaWA8czdBLmxA0PE/dUqa1IdlNM58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQSM9Jbdo2MKbuEXEtf8mlc1NHfEJWAenPeiZ6OuxEetwTlENaz1zIaRwYfYm8Ybl
         mFykHJOoMFRz9OcYJXjpEmX9rqgPXAw3sak4bRETTvDhiUaYwVlA3KXUNot/XL1ZM/
         29aQj849FvN6rVYc6+QrSrevIUkvmUgDYXkwwqulhNuuRljN5Zhm8FP6j4u7OdGIlQ
         oho0Pg8DGjdD9ccVsy9tnExQr6FOdhaTCaPZS+OVCnE+n5LzfTDGDiM+AlJ9ZL+nGq
         Yau74pkriEmOH3fDEUkGLRn2Szn8IjR1yj/TCkSDIDk9zPXHGuSMkQyuMt0LnwT+Ut
         zgnqc0soAI51A==
Date:   Wed, 10 May 2023 21:22:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add tdm node and sound card
Message-ID: <20230510-riveter-ridden-3f056251e623@spud>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-4-walker.chen@starfivetech.com>
 <a0932e84-3813-bbbe-762d-948d75fbcd8a@starfivetech.com>
 <20230509-overheat-pliable-00d60523637e@spud>
 <CAJM55Z9AxMVw=ymfFBb=45nODq89O8dMebzRgo-XD0GKduDBYg@mail.gmail.com>
 <f27b7ee7-f23a-35a2-3b82-71f50871dfcc@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R5rGeiM6/5QEp4La"
Content-Disposition: inline
In-Reply-To: <f27b7ee7-f23a-35a2-3b82-71f50871dfcc@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R5rGeiM6/5QEp4La
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 05:21:21PM +0800, Walker Chen wrote:
> On 2023/5/10 16:33, Emil Renner Berthing wrote:
> > On Tue, 9 May 2023 at 20:05, Conor Dooley <conor@kernel.org> wrote:
> >>
> >> On Tue, May 09, 2023 at 08:52:48PM +0800, Walker Chen wrote:
> >> > Hi Conor/Emil,
> >> >
> >> > DT overlay is used to describe combinations of VF2 and hat.
> >> > Do you have any comments on this patch ?
> >>
> >> I seem to recall that he said at the linux-riscv sync-up call that we
> >> have* that he was not in favour of overlays for hats like this.
> >> I'll let him confirm that though, I might very well be misinterpreting=
 or
> >> misremembering what he said.
> >=20
> > What probably meant was that I didn't want a bunch of different device
> > trees for each combination board * hat. An overlay makes a lot more
> > sense. However, looking through the kernel tree there is a surprising
> > lack of overlays for hats committed already, so I suspect there is
> > some sort of policy around overlays already in place.

> About the specific usage of overlay for this board + hat, referenced to t=
he following example in kernel:
> linux/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
> That board is connected with imx219 sensor via mipi_csi interface. That p=
atch was accepted in 2022.

Hmm, so spoke to Emil again today about it. In the interest of being
fair, I did go looking at that particular board & looked through their
documentation for more information on why there are overlays.
They do actually sell the bits required to use the overlays, based on
what I saw in their datasheet for the board & wiki. That said, what is
done for one arm64 platform does not necessarily apply elsewhere ;)

I'm not against allowing in-tree overlays for hats/capes/daughter-boards
that come bundled with a board, but accepting ones for a hat that
someone decided to use theoretically has no limit! The "someone" in this
case might be a StarFive developer, but it could be any random one of
your customers next!
We've got to draw a line somewhere, so my answer to the overlay *in this
case* is a no. Sorry.
When you submit your next version, please drop the overlay from this
patch.
Thanks,
Conor.

--R5rGeiM6/5QEp4La
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFv9EwAKCRB4tDGHoIJi
0pgOAP9eU2ZWh7+ycauV2k2tsHEtiJcGiCvC1lBDQL6aVqzqJQD/St1K7BA7Q9BW
NSqEGApfEX6ctSZmnzWY8/sp72lCmQI=
=JAZI
-----END PGP SIGNATURE-----

--R5rGeiM6/5QEp4La--
