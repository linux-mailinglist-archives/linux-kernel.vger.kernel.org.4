Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753276D5F66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjDDLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDDLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7921D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4554963293
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF27CC433EF;
        Tue,  4 Apr 2023 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680608747;
        bh=VMElRMGjg/6npF87PapX/PUQfyFG+AI8rzIRICGBY0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6bXH1QGmeYEBpRpfipt9PUMd55OOH0WApO/MybTGGIe+t2HjztKomHVvES70BjS1
         IrEufaltWFSZOKMz9LWUmLRQm/KHng7rzVr6vuaNElmvJUYFHPM90VZwY7pglJNAN9
         CFNy7fkgoiinJYvxfm2kSjWQ//LAwvKE3I73QeewzifRTVvYCuZN1+p3Z9B6m+4zTn
         rrZCHKGrD9lPv2MLSSRSQQe9vlpqluzbdclM2u5zigpzmxhGHM5gxcMuKvMnTO19wy
         r7sAi988Cbu5crcMC3bV5Es5zssh0Xxmh8FdGycg0NMXVzAAzcvbZX9/5iGTK9XGHs
         qAyz4TWQBT7oQ==
Date:   Tue, 4 Apr 2023 12:45:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] ASoC: cs35l56: Fix unsigned 'rv' comparison with
 zero in cs35l56_irq()
Message-ID: <f6e99383-4054-4f14-8cf6-8a9cdd792265@sirena.org.uk>
References: <20230323165825.1588629-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2SZ3smf958ksUSJo"
Content-Disposition: inline
In-Reply-To: <20230323165825.1588629-1-harshit.m.mogalapalli@oracle.com>
X-Cookie: Don't get even -- get odd!
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2SZ3smf958ksUSJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 09:58:25AM -0700, Harshit Mogalapalli wrote:
> 'rv' is of type unsigned int, which can never be less than zero.

This doesn't apply against current code, please check and resend.

--2SZ3smf958ksUSJo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsDeQACgkQJNaLcl1U
h9D+VAf/QW9rSPmMvgXDHFAb0ickOpz7arHugaOibeBnQyLyf511JOJCH2NEag3k
lCvj7/K0VFzKQtfV/20leU8BesPa/GILUMMNK4F/8XE6Tj2vsMEBpGxTBalG9XIX
1bR4ixX2d0dt2LWsUBsk1qaw95clJ8bA87hOFJl7c14f8Ikg89fzzzpbrPw1YLP1
gQwNfJ9y/NTViWbPmOuZno1e43xNxUhfa4izJS0wmzDaxwOof/IFwwYsXHRHtD36
w/FClhm+6d8UCWoD2Xg5R/+d6PQZxlozvHJHoKfr6bARgSzhzXRHikDs0r01Gb1G
Jr0IxYdcHpTJ+z6sHVh5Lo01o7dPNg==
=es2X
-----END PGP SIGNATURE-----

--2SZ3smf958ksUSJo--
