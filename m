Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1972B5EBFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiI0K1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiI0K1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:27:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3B9AFE2;
        Tue, 27 Sep 2022 03:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 863F1B81A0D;
        Tue, 27 Sep 2022 10:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADC0C433C1;
        Tue, 27 Sep 2022 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664274434;
        bh=sHy1niP5mWeKiI5hNQSfEcl+Pb8zcROHMZX9U2cp76M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3zWl5Vfxe0vj+iHX9oOS9CyMVJ7LMndKtydoCsHhDU8xfxypu6brL/DRMyHxlSMT
         Wt86tC/HeRhQ1mfSr9sgh7fsNgbmOS1l25QJqAZevCgkzhVfbLmINXV/vobpzAKZX1
         tGaHvQE+V4/+uj/gHN5NtPO9XxwqE9QUvx0bfdr0ThL27rA486CjcAfGEAOdwo7ZuG
         Mh6imPq0S6ODt8nORXZe2Nk+2nxEY2DKTqsJ4yjU76b1auGq4HSbiBfa0nux5EJkub
         hbiarybQFAjh+ljV3MFojhdRXun0f/G9MFqkg4h+KKJuB5ni/TjocDzmnfdX2lXU0b
         QClUcrNnphbmQ==
Date:   Tue, 27 Sep 2022 11:27:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <YzLP+wH5UjKmkgEJ@sirena.org.uk>
References: <YzIcZ11k8RiQtS2T@work>
 <YzIj6tdtDe9YrX+I@sirena.org.uk>
 <81af0106-a732-ce45-bb1c-c45db9e1aeb9@embeddedor.com>
 <YzIqNqhTIuaWZrOl@sirena.org.uk>
 <202209262009.D1377D0C3@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W1mEP/YeLmI8MbXS"
Content-Disposition: inline
In-Reply-To: <202209262009.D1377D0C3@keescook>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W1mEP/YeLmI8MbXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 26, 2022 at 08:16:16PM -0700, Kees Cook wrote:

> Seems like it's worth getting the MAINTAINERS regex updated? Is this
> right?

Yes, looks about right.

--W1mEP/YeLmI8MbXS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMyz/oACgkQJNaLcl1U
h9Cofgf/c1psLUiMDxR0MRIUMEeS+1ev/8ITyrbroJ1mCXJul5ZSsVuZaluhhXNb
rpHnfwWgZwYvzXeCuOI/MQ2gzZHBYkcKUhrn+dbeomhRtSmHSA7G0Xb3zdEc7xhL
fevVzsb5rXXiNVO4xVZ+IBSy3I8sN4sip6BXTrAOE9Ltk4uuPdqPncRh0uucnDI7
3R46mIU9xk6mRkWMH8ugJ4qZPpaLk32mkfr/qb0ztj1HlBC+F1PQPCdLuHtjW4VX
j99wXosQMvqOfAbxo8UpmX/IfIUWBk9i0HEV5/+xV24uSNI/bgR8hBRAlb/SjiMH
mvB6kGk6wuKa+FCm9d0tAhLV60tShA==
=ie0Q
-----END PGP SIGNATURE-----

--W1mEP/YeLmI8MbXS--
