Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C4706B29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjEQOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjEQOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC715ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 414ED60FBD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C3EC433D2;
        Wed, 17 May 2023 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684334008;
        bh=lZlozox2TKd3Pi5uB7YU/mPz21ri7N1Rt/7jWjUQzv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiIZYJ817uW4PLCcd7yFMqmJfwX74+UHeGVwDFVcWE1vlEcBb5fFx/snNM5JqRM6z
         RJnNeOngRjjz0iYsGmyPZsMQp01YLq1RZxDRZRXDgQ3FxKP6f8occTIyiehm39dkkN
         9OqmgFMGXRKs4wKRKVWBDr3CP/U1z8V/ENSuPiSi7jngSYkAHIU2kxJSCuxOS/yBjs
         gSCNvEUUsCa9JD29BUAHiGuAa0PvMKECodNuuHP/+kcLumXumTsR1/pXgWdVPyM5dh
         66u/usNk+nCNkBh8509NtEA5xTQA7CmIaiKhxATcBi2vxUfnmxi/uKjWw86OhVh1Z2
         Z5UeefiLSYKhw==
Date:   Wed, 17 May 2023 23:33:25 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ti: Use pcm_for_each_format() macro for PCM format
 iteration
Message-ID: <ZGTltcv6hSlJWLnh@finisterre.sirena.org.uk>
References: <20230517130124.26033-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G35u4VcyFhkbCsYq"
Content-Disposition: inline
In-Reply-To: <20230517130124.26033-1-minhuadotchen@gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G35u4VcyFhkbCsYq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 17, 2023 at 09:01:22PM +0800, Min-Hua Chen wrote:
> Use pcm_for_each_format for the PCM format iteration and fix the
> following sparse warnings.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--G35u4VcyFhkbCsYq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRk5bUACgkQJNaLcl1U
h9DiEwf+PGLlxQD5Edw3Vrf62gqgoqEjF17o2fW0TdtmVylZm44Sc+PpdL4NWq4D
A4AykbttTA8qOGZv9FHU+Ye9w0N5V+arjTfnUyjYjO1D46jmJchSyybXs6UCijtH
aivFbChteCm4nr5bz7iZzutwJqJhKVSJbosNQA4fMfQCOkTeL4/3mGhX8iAT0jDI
wUB7x8JnNI9M+Q0OJqhP995zM+vSBsxzIENa8Tf/Jinxd7PZJNzpF6ErNCIocufQ
FwUc7e9dHYrqs+6NHQkED+8TbrbVmv9ik3BN/StZY17JlRLIoGAjIPl8uwrhzD3C
ua0DMQEe3/YFrPoKPHD2kfpdsMHizA==
=Yb+h
-----END PGP SIGNATURE-----

--G35u4VcyFhkbCsYq--
