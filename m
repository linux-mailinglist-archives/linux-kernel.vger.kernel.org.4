Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEF06ED26D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjDXQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjDXQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C22103;
        Mon, 24 Apr 2023 09:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58ACC626B7;
        Mon, 24 Apr 2023 16:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3476BC433EF;
        Mon, 24 Apr 2023 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682353639;
        bh=fvEq0mh5AUQNzwqp8tKYBSzSOfpXgtSJnYThK3jJ/co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrxTNc0mPXjGr5XtVHzM1S9zf0iUmFMuPC17ws2mi1Bs4gFpZ/hC27u7b+1L7fnbf
         Kv1hjkP+zLnF1sfHw0dMhTqZxRjEz0xHmHDJtjIZN8M5cAjZsPhvo0E3OJpnIznBf/
         FfNUHkJf0ELeugXGpgUF88t6uH5a6VaoTZdzdA8/t/5M582yND5AHlrAJYd8WiRcHx
         Syn1VTKBB21LIO2oRwBlhPLysGKZFWQhihSiHNRO+mxuEF3sggJQAmof9X3kmG221U
         Z2r+WEFJU1R/vAZQIGxFt5UAJ0r/8qtTTUiu31IZwZwgIJT1qCtn9u7Zp1YLGAZAAr
         ON2KjfHmn87gA==
Date:   Mon, 24 Apr 2023 17:27:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: add tdm node and sound card
Message-ID: <20230424-roundness-everybody-659599d44963@spud>
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-5-walker.chen@starfivetech.com>
 <20230421-dropper-upstage-200ae7e47092@spud>
 <607f3604-056c-6f3a-b154-0f298b870811@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j+Ycr2hphDkEqIhB"
Content-Disposition: inline
In-Reply-To: <607f3604-056c-6f3a-b154-0f298b870811@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j+Ycr2hphDkEqIhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 11:21:11AM +0800, Walker Chen wrote:
>=20
>=20
> On 2023/4/22 0:50, Conor Dooley wrote:
> > Hey Walker,
> >=20
> > On Thu, Apr 20, 2023 at 10:41:18AM +0800, Walker Chen wrote:
> >> Add the tdm controller node and sound card for the StarFive JH7110 SoC.
> >=20
> > Is this one of these waveshare things + a visionfive 2?
> > https://www.waveshare.com/wm8960-audio-hat.htm
>=20
> Hey Conor,
> I'm glad to receive your comments.
>=20
> Now we are using this board + VisionFive2 :
> https://wiki.seeedstudio.com/ReSpeaker_2_Mics_Pi_HAT/
>=20
> >=20
> > I'm a bit lost as to why this needs a whole new board, should it not
> > just be an overlay that you can apply to the existing dts?
> >=20
> > Taking this to an extreme, should I expect to see a new devicetree for
> > everything RPi hat that you decide to use with a VisionFive 2?
>=20
> For your response, I did some thinking. Because wm8960 codec is not integ=
rated
>  on the VisionFive2 board, perhaps using overlay is a better way.

Aye. I think so too. From my PoV, if this particular seeed audio board
is something you're bundling with VisionFive 2 boards on your storefront
etc, then I'm fine with taking it as an in-tree overlay.
If it is just a "random" RPi hat (that happens to be exactly what you
need for testing the audio drivers), then I don't know where to draw a
line for what is & what is not acceptable for inclusion.

In both cases, it's Emil's call.

Cheers,
Conor.

> > Also, it'd be nice to provide a Link: to where someone can find more
> > info on this combination of items. Google for "wm8960 visionfive 2"
> > gives me nothing, nor does "starfive audio card" etc.


--j+Ycr2hphDkEqIhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEat3wAKCRB4tDGHoIJi
0jkcAP9PVqqvxUun7YG2AskDTqNN3Vw6Lcltm7vAqHee10z2JQEArKIyMolTkXjQ
rNlamogL71o+AG5sxWxXqc/9qYTm3wU=
=z1wj
-----END PGP SIGNATURE-----

--j+Ycr2hphDkEqIhB--
