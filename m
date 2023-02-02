Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A820687EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBBNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:42:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8122F88CEA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:42:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D604B825EB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC44C433D2;
        Thu,  2 Feb 2023 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675345353;
        bh=i8BRzmo7rKq3SCWLhFnsh4JSQbcn3OLgn2i+Gc45CEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/Bmy1HZJd/X2YLiPd+dgtTOA/iLWb0z8MJUjzIg81lO9/HwU8KkkyDov8KGuW+J9
         60gpI+TVBSZ3vARUhmPP4ZnN5pN//d0EYTUP+EsBKO1v4/gXbkWDTiHET+uN+ihToR
         Z7wPlMbYUAr0pM3wTDBC9DHGWrDAokZRUnvvuY3rjSOXN2MiWsWxfyCyb6TDqoct3N
         lFZsvNDGudBx3BXedGq069Cptr1OKDe8Z2VG1NAfnjfvxhRUtnNUi2JYsmCNDoHINC
         oRFDFxDk0N6cQV85WsdPZ8qIm+E9lml5i3MrZhY+zaiNuJBVuB/HJ2jkQ6fcPVoL9S
         qDlpJTtMtyChA==
Date:   Thu, 2 Feb 2023 13:42:28 +0000
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
Subject: Re: [PATCH v3 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Message-ID: <Y9u9xCNDd8R0Zi08@sirena.org.uk>
References: <20230131184653.10216-1-mario.limonciello@amd.com>
 <20230131184653.10216-2-mario.limonciello@amd.com>
 <Y9uhkEo9INU0IPEr@sirena.org.uk>
 <270a6bf0-8774-2f0d-9b0e-4f1eb9a986e6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aOpaOU/CtarS4P7a"
Content-Disposition: inline
In-Reply-To: <270a6bf0-8774-2f0d-9b0e-4f1eb9a986e6@amd.com>
X-Cookie: Swim at your own risk.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aOpaOU/CtarS4P7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2023 at 07:38:55AM -0600, Mario Limonciello wrote:

> Would you like me to resend the series?

No, it's fine.

--aOpaOU/CtarS4P7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPbvcMACgkQJNaLcl1U
h9CUCwf/YvVnhHeYEvCRNPh1UbuYnjux0Y11lFqAP1198xtWvbTa300lLCtTU0bS
oVLTLL8RF+azgp/HwwsKMysnfjV5a/MfXqXw9ejBIxKKrBpBb15D5VGjCOqS5jMI
gl3uPkNqWklijRHDH/5QCWEx3s8NC8xa8ZoaRvGe0KYv7rmYbAbsdTMWH9uYR1L2
KWLW4+ONnyOJoviS4y4Lf22bHtlj5kaMPbw0wabkCWd1081Ys6xAsXCFDikuBJX9
XHbpVcosCfrA602DtdbAB8JBpb+48FmJjt4Wl5wFadw8dGmOpsa/XuA+OBvY04fR
4foffdzHrTGlFlt9Q2JnMsTma+SPmw==
=JpDD
-----END PGP SIGNATURE-----

--aOpaOU/CtarS4P7a--
