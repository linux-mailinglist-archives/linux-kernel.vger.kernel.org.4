Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AAE722651
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjFEMt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjFEMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE5DB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A6E623B7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC40C4339E;
        Mon,  5 Jun 2023 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685969321;
        bh=Qyu3UggzGA1YR+k6SEA+ebAB9j7ENCch/bB9WJ5W0sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9kyc8n0XuRdxbMm+wyCIqE3/jmhPXRajQtviFmBwL/NsNiXdwO0eAxKVyr/Cl+dx
         kIMsdED1jZQJHj8uKjWtMwHKe2QoBgfB1MYmoqyORu6DCMMx+Y2q90JLbwVm4l89Y2
         sfkMhx/DGATI2/s/oe0TwcUIhcVRdJsp4ia+JDtMcjUYq9zvGWXoYJlOTMs6n5BYTa
         TjAx5mo06sSewd7VKLk3O1BXkWmfKXuZln5hZK0nlMXXAFeO85SQigYsIu0akgUUuo
         cjoh8ip+OoL5xr5/Mcc8Lxl9AlWGlOYBKGS9+LDu16CgalK2u1vO6yfd1KscXtVOFn
         sdzIQqBfNKMHg==
Date:   Mon, 5 Jun 2023 13:48:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
Message-ID: <3d9657dc-7180-484f-9fef-b50597571db3@sirena.org.uk>
References: <20230605085839.2157268-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X0xc3FjzGMYuJlCL"
Content-Disposition: inline
In-Reply-To: <20230605085839.2157268-1-arnd@kernel.org>
X-Cookie: Biggest security gap -- an open mouth.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X0xc3FjzGMYuJlCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 10:58:29AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The vangogh driver just gained a link time dependency that now causes
> randconfig builds to fail:

Actually git copes fine with applying this on top of v1 so no problem
here.

--X0xc3FjzGMYuJlCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR92aMACgkQJNaLcl1U
h9DWDgf+P/YOsGOt5xQicO9/+srfiaQTDUojnL0mHrEPBbWUabFo5NnA64FHthnL
fAEgu7knokysnWiJfvDIMASYtGcGHKiOsnuCj8Tv7swdMf8g7Q5BnmPVZ7T7gEOz
zF/8NvIH/k6H31lVxtsjbbwL8fKNAVulgdBZFhT8NJJMpNLonpOiG/ddkqmzVbwR
0NkNoc5zS9vfzuTCYnbMIyphbhLJLNK6k4KW9MFt/v6HZA92tS7lrV9sLtzKC2wJ
f/mpybZAoo8k2auRAuTW/MmEa8dHavNCjDXipNpR6klASA+0zDbCyBPaVyqMHNT3
duVIulp+I/GndA3AQcdEfS3yLlruFw==
=HBlX
-----END PGP SIGNATURE-----

--X0xc3FjzGMYuJlCL--
