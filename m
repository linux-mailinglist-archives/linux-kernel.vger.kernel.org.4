Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821EB6BCE11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCPLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCPLWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046E5255
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F65D61FB0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73CEC4339B;
        Thu, 16 Mar 2023 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678965720;
        bh=kTOjWBgQtV6BzeDIMmXfIWLA4pjFRdrirT1xT19ZH+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdON6Zarqs+VaQx4XwFGvfq3VpUDxXyS3zy3aFSAAc1eTCY9rlbZVyeV5bbQmmI8h
         1f9/xI/pL6Pqw7/vLl0OBIbCTc/+jdfl9Pb/4jFrZmCI7VPSW9r1LezMCqPJvhLdxK
         B8+KAyhAwl8z4d1qVqbtWs2593hX61YWAoOXfEKgH9JKmwYLE4PuYR3akRMs1ztprJ
         9K27BWcw6jK+c/cEPsiZfSXHZ/3q7HPgfoCVsRfpQd4GFzXHdFshhBX8EYh3MSHJSp
         D2rZ6yS5oYYP4VTXStgYXISusR8PFLmgy0LAm9DuI3JhGTKxYKVaJpECkxPK4hSizN
         udbbY7wE6JMGA==
Date:   Thu, 16 Mar 2023 11:21:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv7 10/11] regulator: expose regulator_find_closest_bigger
Message-ID: <6e64ac1b-ce91-414a-9a39-50480971ceca@sirena.org.uk>
References: <20230307153617.643260-1-sebastian.reichel@collabora.com>
 <20230307153617.643260-11-sebastian.reichel@collabora.com>
 <20230316013453.qtbdfxcfcnvsp43x@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2NGXByQQnuQ+mWR2"
Content-Disposition: inline
In-Reply-To: <20230316013453.qtbdfxcfcnvsp43x@mercury.elektranox.org>
X-Cookie: ... I have read the INSTRUCTIONS ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2NGXByQQnuQ+mWR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 02:34:53AM +0100, Sebastian Reichel wrote:
> On Tue, Mar 07, 2023 at 04:36:16PM +0100, Sebastian Reichel wrote:

> > Expose and document the table lookup logic used by
> > regulator_set_ramp_delay_regmap, so that it can be
> > reused for devices that cannot be configured via
> > regulator_set_ramp_delay_regmap.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> Can you please Ack and the following patch?

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

> (they needs to go through MFD tree)

That seems entirely non-obvious from the subject.

--2NGXByQQnuQ+mWR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQS+9MACgkQJNaLcl1U
h9ByQwf/XfDafZI+v+XU0UoSXjadDgEd/y3onAATcOhE1xFD9wVjoRfCr5rI7KMz
LHsw5Pd58xwOtbZZsWG+dL4zQyiKiB4hDrLNmh6aDjyo//xwEKrk65U/8KRApM5/
/yk3UWnf3SJT3RK3PNqlgVTqVRLvjLnAmiBwyjUKJMxiqkdRmZn6kRtkoLNGShCD
+YatcJl5vn16X3OFbvTv1P9HMCNtcTt8F9tZ8oJIL7BCD71mpZRuvPUQRIS4rj9L
+rtL3t7l1n3fAWOpIuGjf7O9KkWjROzG6VykMsWMcr/TTQfNsXAjQWWjvGp59uBu
hfL4QnVEsSLO2eJIByTn392O6Tb4Eg==
=H3xm
-----END PGP SIGNATURE-----

--2NGXByQQnuQ+mWR2--
