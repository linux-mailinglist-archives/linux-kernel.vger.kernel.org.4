Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFE6F9CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjEHAKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjEHAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6836EBF;
        Sun,  7 May 2023 17:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D6961D5E;
        Mon,  8 May 2023 00:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E14C433EF;
        Mon,  8 May 2023 00:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683504593;
        bh=A32A0fMavO0Ip81/GDeG/O8Dt1b/AHEN/Q9Ag7VxJ/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzfMivA8lavBpLa0kuam03gytpAKOIxDo3i/gd5rGSh/fBFIhSC2RTH93vddmU8/d
         3Bj8mKzdI4jbG3vWlhJ1Wa0SK16Qpvf2ryv/mxvwWgB9SN45Z1Yc0+U4B+mq0Mgg1n
         U87vTTdAP2X5ed7PeXOrVt3Kvhd5ST2QlTPn8jmAEhYt1zNIhbSIhcnu6Kv7DozjNw
         GbMVLl54RcV3ohYPrabVLFn5WnsvcB4yh8csgfIPnyUb4IalsjnnJJKkg+t0RzW1PH
         ggafPW9wR5hSLPRt7fMK8kl4G+eNZHVxoYphhCT0quHS0Q/WABfFnS/B9lqb+JRL5n
         mkzcg/jceFgrA==
Date:   Mon, 8 May 2023 09:09:50 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] ASoC: starfive: Add JH7110 TDM driver
Message-ID: <ZFg9zpVEpVSQJrfZ@finisterre.sirena.org.uk>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-3-walker.chen@starfivetech.com>
 <TY3P286MB26118DAB0E0E2BF32C91B19F98739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9ci+RuukFZBKZOQn"
Content-Disposition: inline
In-Reply-To: <TY3P286MB26118DAB0E0E2BF32C91B19F98739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9ci+RuukFZBKZOQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 09:47:55PM +0800, Shengyu Qu wrote:
> Hi,
>=20
> > Add tdm driver support for the StarFive JH7110 SoC.
> >=20
> > Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> > ---
> >   MAINTAINERS                     |   6 +
> >   sound/soc/Kconfig               |   1 +
> >   sound/soc/Makefile              |   1 +

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--9ci+RuukFZBKZOQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRYPc0ACgkQJNaLcl1U
h9Dmbwf/Xcbsz/f576Mnx9hVH2Cly67ZCtBddqWB7pV+pDcaXRcceHN3aX2c4LRR
wCAYUrX+SQu5hXybB4KLamAtL9zqrf0wUmZIMsPAwVSMCj4pgvabvXjvQBhCC/JE
yF7GbhvWGOIcmO4P4rCUC3wir3XvaZJUTxd31sfqRQ1QuJQld2K4tVn7GpIn+Yqm
TzwVoWu6phAweem94ZbvQD1LUL8P6jaiFTr+Y7CXhbtjKFyDPWsL//xxzqpzpxeY
C7I3om/FG2R7stwBxmjLERGtXg2b+JDKqRvUl/RCL1nUzyWa9MyoPQgkooMqnI7h
sHiUX1OQyLsOMMf6ruvYLbgC28hu0g==
=Mg6z
-----END PGP SIGNATURE-----

--9ci+RuukFZBKZOQn--
