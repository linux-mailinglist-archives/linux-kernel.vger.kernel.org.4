Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01897750667
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjGLLkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGLLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290AF1984
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B38796177D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C670DC433C7;
        Wed, 12 Jul 2023 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162017;
        bh=AQKFgFokFJZ0D36WLuYt5xFZyXkBiD6JEbk0Lhmm5io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNYsi7/R58vyE3izPZ+M7HJtjrydR8H4ltCg0EEm1BFxAmEL0Lsbsraqy77rNgI88
         uX1LGUK4vN9I6A20Kseq2/FC9+t0uX8YGAM0KxYsJV6wlD37huBSgX8C1SB76wP3cq
         XUufv8Ae5CiMOV3QHJqXTMRi5zk+Son23cDSMeMnWLEVAn/NWYnqpEu1/9zKQtJ7+A
         JC9ZjjGdhaL8qFD05bvoOx+sGQ5tVXwhYZN1TMhpQydlYOflj8Km8/9wYFS64lG7ja
         HOq7eu2x1pc8QKHqNUwquIu9XTdVT83f7Mbw1mJ2XjgOJkjgnxinXkCuK4ZclBVZve
         YmlqTyNcHPWmA==
Date:   Wed, 12 Jul 2023 12:40:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mastan Katragadda <mastan.katragadda@amd.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        "Reddy, V sujith kumar" <Vsujithkumar.Reddy@amd.com>,
        "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: SOF: amd: refactor PSP smn_read
Message-ID: <fa7e890b-f268-4b32-bb17-46b1e7a5cab5@sirena.org.uk>
References: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
 <20230630070544.2167421-2-Mastan.Katragadda@amd.com>
 <f3b7d7fd-2ce4-a579-0570-d55b04950140@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eU1hy69DHhto7nHm"
Content-Disposition: inline
In-Reply-To: <f3b7d7fd-2ce4-a579-0570-d55b04950140@amd.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eU1hy69DHhto7nHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 04:38:46PM +0530, Mastan Katragadda wrote:
>=20
> On 30/06/23 12:35, Mastan Katragadda wrote:
> > Use the read_poll_timeout marco for PSP smn_read calls.
> This patch has not been merged.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

> > Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--eU1hy69DHhto7nHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSukRYACgkQJNaLcl1U
h9Cngwf/dct2rAH3pitDj4DNfze5HGZm+l4oqJQLMAjQulG2irV1Dd5uJrRh5MN/
leAU5ohLd68XSdmn7LMt5Vmokj4DG7ugVO17pQmKw7RukJSqyYuMn1wTWDq5/MaF
ySY16FHhSJiQqMUsVPu3TIlJMeeqk5gJo+Zad0HSkH6O3bQzoSEQdHxXDn8op73M
cwOJ944vq85V2ZhGSnZ+txZbGBY1TpQLx1ppyabUR9/DT1GDcviTx72yOHqeMM/g
dn/YmFke3OlgQ5gSy5wjPk5nF3X3+65/w95MmOmKiZD5vZsTUz9UusUKRBSqloeC
eLiafzfNZluMy0rEAQqfCeESh4cSlQ==
=yt9v
-----END PGP SIGNATURE-----

--eU1hy69DHhto7nHm--
