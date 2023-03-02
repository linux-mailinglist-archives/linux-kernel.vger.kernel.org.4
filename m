Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4396A87DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCBR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCBR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:27:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598D1144A5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:27:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E976E61607
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84F8C433D2;
        Thu,  2 Mar 2023 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677778068;
        bh=iilU92fnhVkjswDzFSRq9gc9hVZYATbY55ueOQu1GxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMfIx0K78J3pzDSDmxKqRKBpqAlExyLj9g/oTCz+YNOVMQViOSImdurWPYoxw1134
         XIoMKr/HCrQuBnEkclLZ/BW16rgj8+gwsjSBngGa9Ro+TeZaQJmsp6S52NXAO/4OnZ
         FzpSdU3nqjkYNIRJTAydtZ1lQ/XF32zv6m1BoCgn7PCoVD7jcn/S3q+dY3XCiOAvkl
         rDGrUen3h0Uvp6gKR3GlhF+lHImAnCE6pfZGpkAN6qg7JrR6yTYorspYDcfOHMP1/9
         ut/EFMtY06nf7dfOjMouMYfL6JXFBqckHPdujCpeu/xrrP1zcS02fnPptuz7zmSgGz
         Hq20jqvlMCY4g==
Date:   Thu, 2 Mar 2023 17:27:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: cs35l45: Hibernation support
Message-ID: <e25417af-e524-4462-9d78-c66cf994eb1e@sirena.org.uk>
References: <20230302172636.2344058-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+XSwFAWCKUTMt1r3"
Content-Disposition: inline
In-Reply-To: <20230302172636.2344058-1-vkarpovi@opensource.cirrus.com>
X-Cookie: Who messed with my anti-paranoia shot?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+XSwFAWCKUTMt1r3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 11:26:36AM -0600, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
>=20
> Adds support for the amplifier hibernation controlled by
> DSP firmware.

I've now got three copies of this patch (just this one, the first four
only came once).

--+XSwFAWCKUTMt1r3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQA3I4ACgkQJNaLcl1U
h9BxTwf8CqFx8xiI5xarOP7OEAY77GoBP2ovOFBb2GlIQB2nkvZ/QnmIaVkLtPi/
G+CLiA/LI45Z3ZXAUOjCKG28yB0LdZqisw+PfkLuv6Ei4CseO3a5uZtByDxHXjg2
+iQ2oeMd+laVmVlSe7U4Ee8OA8OC3AZvSerMtfZKQNck+ort8T5Aq/CGPMBJpvMY
eFVToM2V7HtI/UricmyQav8gDQ4jMDBi4x8oF8ge65hK/3xszfvTSDLrAh7kmqNW
qRbrz3TLlrhAkIi+Oyjps7udEGG5gLEoAqC2z/4B5a+Oikk8PE5RWNG4p7cH3CoB
Ix5yHl9JCErMJxuU3D2GOUBpNd12uA==
=Jlgw
-----END PGP SIGNATURE-----

--+XSwFAWCKUTMt1r3--
