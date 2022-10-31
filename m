Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA64614032
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJaVyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaVyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8E140B2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0A9614B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFD4C433C1;
        Mon, 31 Oct 2022 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667253288;
        bh=FFGfPDLkVcZktYz3pbO3mrkBD87ZdMPNLu3yTzjFccQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eC9YoqyK9Z2EZNl8+LOIP2tPNeif2YkEHO582v1NBPTulTQ39gL4j+++ChjpL5+fd
         7A634MKLAiNtOFyZ1M11DPfpG12e2srIabQjIeDwSs7+BryxISsYKxzd9Oa6GVLo9R
         nMn3Er8nIIaLKLoqSTd4vsgkq1o0p4OcbfzYr+VIMz+dw+RUSdCkvV6cZT3L+WygqC
         Dpoq6UlhPal/EHREY0tPPxIODSQ0GVg80JNuQDG4dMAABNh9dVZyrgi050JrnzuZKs
         7faXojMJZQsTjeSU5bBy5jWRfHIm4oDQkQOLlGqA3SkLdqykNRkVo5QE/D/O32VfCQ
         vezhYyhZiIngA==
Date:   Mon, 31 Oct 2022 21:54:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Message-ID: <Y2BEIpTIQKuvMPJ9@sirena.org.uk>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-7-nfraprado@collabora.com>
 <Y1/JCN+mtlT0r/rw@sirena.org.uk>
 <20221031163140.h63kjpivwg7xpvs3@notapiano>
 <20221031190938.GA3264845-robh@kernel.org>
 <20221031193810.vdsdndr4ltvhrfel@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxMlgxtl57zbllW0"
Content-Disposition: inline
In-Reply-To: <20221031193810.vdsdndr4ltvhrfel@notapiano>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxMlgxtl57zbllW0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 03:38:10PM -0400, N=EDcolas F. R. A. Prado wrote:

> We could have both if we converted the existing ones to lowercase first, =
but as
> I mentioned in [1] this requires using devm_regulator_get_optional() befo=
re
> falling back, which seemed like an abuse of that API and to unnecessarily
> complicate the code.

Yeah, it's definitely not what the ABI is for and probably more trouble
than it's worth.  We *could* probably write some helpers that handle
legacy supply names to the regulator core code if someone really wanted
to retire old names, that way the complication would be shared between
users which seems more managable but someone would still need the time
and enthusiasm to write the code.

--pxMlgxtl57zbllW0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNgRCEACgkQJNaLcl1U
h9ClYQf9FsCx0G+N6VTpjGeY5nkPr29CUIIugDCl4wTHz+wFi7U/VdaIbjstqF9y
2laVvOENRoq28dcIG1adZWcTZtDflCRfS72W1e7x/p/6eg5Syl1S96YZqYAmh+H+
DuZ6it8zFCiTO3emtcLI8ZxK89TFdBebgo5R3g63lvmcfIhvk3A6u/vYxCJCvRVo
oDk5tB/cWSTC3qX+dU9a4aFpqjsecHmhnmE0nqLLYpyMxDQtTvmsyvWh2dcqbQi6
kJkRByMxqmsbgYCjUec0FDkuIvbeb0Up1apSK4Ui+lb+wtYqExcfcEcuA7LgbtpG
gTSTYSGcZLpFBepWyyoyqYODwJssDA==
=DG1t
-----END PGP SIGNATURE-----

--pxMlgxtl57zbllW0--
