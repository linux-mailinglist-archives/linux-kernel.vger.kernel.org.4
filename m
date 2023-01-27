Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5456867EBA0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjA0Qxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjA0Qxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:53:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D921ADE9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 917C2CE2944
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68950C4339B;
        Fri, 27 Jan 2023 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674838383;
        bh=tX6Hu2TaAusytQSjE9p1hDzaGLxbM3u1risW+gCEWhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swI08zdG+0/kur7LG6CY3Rcsn79X4Nug/bqiOuig/8wcci3/ALH7I2WeO5MoyNj0Y
         9R7FrVBAgon8EHoYIbZScA1hDaFvkPNepG2mCc6599D2pTJHqTEdkI51DSV1I8pVYa
         bA8fdwZBpOy90OOytiX1RSVdMFknY1fK/HJq1o5UI4Xo/NXy63dLvzfpY9QR5V2vFc
         M6M1eYnAUt/vnAhjxtRpEaBDq1+dsGXWm/0+s3olQ6EtXu/pPUB0gPRlIPjItciYMr
         soecef+3uEFOJ0eB0ANoSZcLNoC1Gp/L2AUSZbygRu8Ti2VDDk869OaT0R4phkR7D4
         MQEhVW4+2O6AA==
Date:   Fri, 27 Jan 2023 16:53:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        linux-kernel@vger.kernel.org,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Message-ID: <Y9QBbPtopFD1DGsD@sirena.org.uk>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
 <20230127160134.2658-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiJUccDQT0wf+nib"
Content-Disposition: inline
In-Reply-To: <20230127160134.2658-2-mario.limonciello@amd.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiJUccDQT0wf+nib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 10:01:28AM -0600, Mario Limonciello wrote:
> A number of users for Lenovo Rembrandt based laptops are
> reporting that the microphone is too quiet relative to
> Windows with a dual boot.
>=20
> Increase the PDM gain to overcome this problem.

Why not just make this a regular control that can be adjusted as
users see fit?

--yiJUccDQT0wf+nib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPUAWsACgkQJNaLcl1U
h9AMGQf/WLxAXs66o2bKsf8C/AxaOD4g6vZ+YhuhVh8hplnc4JSJfUoOtKcS8HQD
wMDx8GGGNTyIKmZJgMA64ROOyzP6s5Bu1nHv2b7Jbls8Pd0AI3tG/zinHLkGofsW
8RWrpaJHeeCycV9ODZbDylukad1sImsJE5qhkRJ1dwqqb4ies2ceSVZ76rXtzwb5
3J7+RNRedHBoZ2iYPbv2CSJRz4v7pypxG6p8Fc3AzUYapMs1zQWtG0z36tRti+i1
LZahat22UVWs2fzCh8u+6cvpdf1LtzVu15stej7Jy7Nse5JMuGrRKWhzeVOn8he0
CbrL4j2mvbRGW+NTVUSaK8QOeQX74Q==
=Uen9
-----END PGP SIGNATURE-----

--yiJUccDQT0wf+nib--
