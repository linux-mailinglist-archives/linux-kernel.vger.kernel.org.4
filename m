Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C06C8FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 19:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCYSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 14:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 14:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE014C0C;
        Sat, 25 Mar 2023 11:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20DF960C88;
        Sat, 25 Mar 2023 18:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38F5C433EF;
        Sat, 25 Mar 2023 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679767372;
        bh=qGnFSMgK4wtGx+uHwd6Vg5FVaygMBut9NMr2BRuntgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3LYU8YE2flgUNxbEWJMvFRvYn4ZIv7eAMsrH0PmGi6au+2KdF+FXHxRBAHqV+HV1
         9pfKVP+cYP/Sk9+7joZC+krh2qfGGBa90d63oicDcKW5NX362q7HazY4fiNfK+IuFD
         fdp+pEZjnJx32g65Ql1qb690aYJN9t9I0KZ9FlA7wrcZ73JrRg6vJwd1FF1+UqTS8C
         be84N/puyueHt11l0a1U4egyAaTwTUwm2WBOvv2iAKzyR5wjNXsO8vckhqox773x3a
         gujJ3y9/rLqihwKB0OUwYmGO4aXvTJC8AglbbTumRjaTfr/oZhMMaFdrMzatV+ti4v
         acNj0LOlIONrg==
Date:   Sat, 25 Mar 2023 18:02:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Expose ALSA control for jack
Message-ID: <ZB83SZo44kiloMrX@sirena.org.uk>
References: <20230325142142.24337-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/mdumUZgSzjwqsJd"
Content-Disposition: inline
In-Reply-To: <20230325142142.24337-1-me@dylanvanassche.be>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/mdumUZgSzjwqsJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 25, 2023 at 03:21:41PM +0100, Dylan Van Assche wrote:
> Qualcomm SDM845 features a headphone jack via a Qualcomm WCD9340
> codec which has jack detection through the wcd-mbhc-v2 driver.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--/mdumUZgSzjwqsJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQfN0QACgkQJNaLcl1U
h9D4pAf9HqtRrn0E7n6E622qQv0sfrnUOVp9U3FT7tvjC1ivuQ7Tu0gE5vKtBpxg
oWs2eMXBZeP+KjQVxiYRfghcPWcc71cQ7cd+cmgfwsexLmSCUswlD9JPibpOeRN6
+NMn0qLfAlhijGX/hOV6Tqaid7KGMyPBFq9GR9+TEmxWZCvrrwv1sywqCOOTLWE7
SevV4Di+OHTEHtLPWzRCWqIqL1kHDAVROsJ5Jwk5rn9ZwyiCtlTuCn/K676CisU1
YBmJXRu9XYiuPP1eG8H7Exa7aW0iyYPOVvV7Rv1oCieKUZsJFPMSGo7wy3TDweFV
PMCc7KxGZGGwnkveEouHnyzvozirNQ==
=Df2L
-----END PGP SIGNATURE-----

--/mdumUZgSzjwqsJd--
