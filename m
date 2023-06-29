Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA9D7423C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2KPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjF2KOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14743C14;
        Thu, 29 Jun 2023 03:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0BA61508;
        Thu, 29 Jun 2023 10:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EACC433C8;
        Thu, 29 Jun 2023 10:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688033489;
        bh=7QmvM1Ky6hyRub5lLoveiNRl1PkeunqIVXKu1oYNN5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtZqsGNK+DgvnRm8fscT4hbHI2v/AUqGUlG1cuN2mjP0rZKvE2LrZRmgyv7PlTGuD
         cSZFRWTtytdvIsPSWmaufVFvW+vb3fPgcf6gfxovk08W3zROucmqbUjnSmOaS+5hBg
         TKom+2aMfhRgnePIZAsD2/a+IYIC8KvFX4Ie0naZukKd4mhqY9UFMw67aM6Fwb1ilG
         zOOpi6G8RnTml8MC6dydSr42HoAttiZQp480bbqh7WOD4aE6QoLW4HbtIrlFknujXh
         HMa4LLT2X40B4J/RyyB+RuSW233o9w3RDGoSH9x/VOC7dfmvKkfHSbOWfbq8PXaEoB
         KMlAFB1KVxGnA==
Date:   Thu, 29 Jun 2023 11:11:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Sameer Pujar' <spujar@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkumard@nvidia.com" <mkumard@nvidia.com>,
        "sheetal@nvidia.com" <sheetal@nvidia.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH v2 3/5] ASoC: rt5640: Fix sleep in atomic context
Message-ID: <550e5c8f-0bfb-4ffc-9a43-1ecb153c6a02@sirena.org.uk>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
 <1688015537-31682-4-git-send-email-spujar@nvidia.com>
 <bae9f041867e4625ad293d284566bb4f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+aXQRe9dUQ7rrBkZ"
Content-Disposition: inline
In-Reply-To: <bae9f041867e4625ad293d284566bb4f@AcuMS.aculab.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+aXQRe9dUQ7rrBkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 08:38:09AM +0000, David Laight wrote:
> From: Sameer Pujar

> > Following prints are observed while testing audio on Jetson AGX Orin wh=
ich
> > has onboard RT5640 audio codec:
> >=20
> >   BUG: sleeping function called from invalid context at kernel/workqueu=
e.c:3027
> >   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swa=
pper/0

> My 'gut feel' is that this will just move the problem elsewhere.

> If the ISR is responsible for adding audio buffers (etc) then it is
> also not unlikely that the scheduling delays in running a threaded ISR
> will cause audio glitches if the system is busy.

What makes you think this is anything to do with audio glitches?  The
bug is literally what is described, it is not valid to sleep in atomic
contexts and if we ever actually try things are likely to go badly.

--+aXQRe9dUQ7rrBkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdWMoACgkQJNaLcl1U
h9AtaQf8CxjCsdB1iRGBoRv5utkgYwI0VNyGiPs7GW70GzZc456Z381WvE94jU01
60leed9uBoJP3hs88KzS/G9Tg4StZFdmHQxVkjy78ArKLRUCPl4rMqc2bTODvWSf
aYtTcgMRZZjgoY+mDHpBSFpPFJqB1DQs2CICy8BvoyOJDq05ghN8DU7dGQ+pl415
QaHrjbbOJkj7d+e2PftSuXOHfcF7Y0mj5E8yFjWQn1WwVfMCAhbRJvhYtpbzry6X
UBWlM5GC6Hi1rx8zvMiKx6LemyxK924I92k8HiIa+75Rq5jM8JxldvYj+FuWlgIE
8BDY4GdfkgUBVHTn4ZJYjy2mb3nPEg==
=eZLP
-----END PGP SIGNATURE-----

--+aXQRe9dUQ7rrBkZ--
