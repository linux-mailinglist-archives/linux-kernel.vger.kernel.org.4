Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656E561F704
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiKGPCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiKGPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0A1E72E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C27C7B8108F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765BC433C1;
        Mon,  7 Nov 2022 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667833288;
        bh=Gwl817qdWCkyUsypT+mBMX99k8wTF8oxqsN3mD/crgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHijNVUt0qfZl48XvsISPf+Ifk1Yumatus3hQzyZpbyAI3YNHCGgtSd9bruG9GXka
         GSyntLryCBQCgtcsDPLRKHMlDr01rDuaJdMF0LXhdHt+fZUsOwMv21OzS1xJgGPbbc
         IwdlO/7kpJ5IiaNnUzKeEwH4Q639bdtQNsqtRhcOlEaxqvmrA9qPdL5qvaDvhvshuv
         ZFVh4WElKAUq+2yeNWdfPWLhm9JW9H8Aneb+iU5QEune6lrnYbj2cj8kZcLKDKQAfY
         J42Ynul1ZxrntPLOwrkjooUynerPeu2TQ8wrTvKw6J1l/xdmNU4E6XFlRie/Zvh6n+
         XIOGJ80Fb96ww==
Date:   Mon, 7 Nov 2022 15:01:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>,
        alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Message-ID: <Y2kdwms39CQUMQp/@sirena.org.uk>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
 <Y1u1vj0K3m33wCTd@sirena.org.uk>
 <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
 <Y2EttkwUvMReQcqg@sirena.org.uk>
 <ca006546-9b0c-34df-2a33-a4f10b68f815@amd.com>
 <Y2JVWmJsprt0xnKH@sirena.org.uk>
 <7b97682d-5cf1-8be1-9c62-41c9fbd89018@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3jPCXTCofiGGOee"
Content-Disposition: inline
In-Reply-To: <7b97682d-5cf1-8be1-9c62-41c9fbd89018@amd.com>
X-Cookie: Minimum charge for booths.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3jPCXTCofiGGOee
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 04:04:40PM +0530, Venkata Prasad Potturu wrote:
> On 11/2/22 17:02, Mark Brown wrote:

> > Why would the user choose one value or the other, and why would this
> > choice be something that only changes at module load time?  If this is
> > user controllable I'd really expect it to be runtime controllable.
> > You're not explaining why this is a module parameter.

> Different vendors/OEM's use the same hardware as one need I2S mode and ot=
her
> need TDM mode, using common driver=A0 to support=A0 I2S and TDM mode with=
 this
> parameter.

If a given board needs a specific configuration we should be configuring
based on identifying the board, not hoping that the user somehow knows
that this configuration is required and can work out how to do it.  If
this is purely a software setting depending on the software stack
running on the device then it should be selected at runtime by that
software as part of the use case management.

--u3jPCXTCofiGGOee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNpHcEACgkQJNaLcl1U
h9Actwf/XNs2J7Ffddfy8nVY0H6pR5ug6RjoG3sOjBiBm3NonuNjnBmAD1rYCjOW
t6KnGt1Q656Eyz6ycPZz09PDIWT80wv/zYbzGU2fyk3hpyZzG8AhJrU0AybvRSmI
g/mEgzC3X0aOnXRm4eF4oTdBxab6weg+LbwSASDByPOP710bNQtM/0MjKd6Jpz3C
iY7XJj4BrVynqak3IbjwY1hgX94yY/ZeRUbDE8/iC4+z/F0ORoQCM85xJ3UZgC8a
ikYvz4jJcumSQMeSwuOoQF4xLo7dvF0NSnm5V/DiXO0T3eEwJm193lLxTExEjhhG
YW/u9RRJjDiRsLpN2zCJ0TMJk6rvMQ==
=WKwD
-----END PGP SIGNATURE-----

--u3jPCXTCofiGGOee--
