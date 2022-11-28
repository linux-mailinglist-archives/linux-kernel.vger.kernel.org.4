Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EF63A870
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiK1MaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiK1MaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:30:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187E101C6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:29:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35422B80D8B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B8BC433D6;
        Mon, 28 Nov 2022 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669638561;
        bh=UOvpcpaJhKOzG2CUC+aTb48Y44h71L6eCLn7baxJ+Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m35wacBQojkgoPBUu1XIXGA2nDFCkB/zivAQLnjrTY71ILya4XYQfhjER2BGxz0yk
         oF6kNswo5nK+P4gJzM7vsfjMK80zyosxeL9ikTKkK5B4KusH4lV1mADZhrjgpVuadh
         DC4XT9ad7s1Nvlen6iXZsxLo2q+H8HWMcNrrpEjJeTjodGh4gg8VwuV069W6M1fzWY
         TiGLhs3j3e7KNrn1xHUntu/nVZs893a8niVAM25zHQoTi/XeRScQwW7ktTrzBFOSti
         TwNyAnGXAQSk8zMLJDD2auaNtuyMtLgJ36PADwu0NP+qMiHwVkwsEh6dgeB6G2z69b
         XLUH+wh4se05w==
Date:   Mon, 28 Nov 2022 12:29:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: da9211: Use irq handler when ready
Message-ID: <Y4SpnRyYr5pF/LJy@sirena.org.uk>
References: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
 <Y4Sh/uFEgAxIEOs0@sirena.org.uk>
 <CANiDSCu52Qo27XAywZTnr0iUT++oL_B=DAD9A39mY8HapnWRhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mBZfW+uwR7wE4Mt4"
Content-Disposition: inline
In-Reply-To: <CANiDSCu52Qo27XAywZTnr0iUT++oL_B=DAD9A39mY8HapnWRhw@mail.gmail.com>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mBZfW+uwR7wE4Mt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 01:16:17PM +0100, Ricardo Ribalda wrote:

> First time that I used single-message b4 send :S. I think I have fixed it.
>=20
> The extra changelog comes after ---, so it should be ignored by git.
> Do you want me to resend it anyway?

Hopefully git figured it out.

--mBZfW+uwR7wE4Mt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOEqZwACgkQJNaLcl1U
h9A1hgf+IR+G9zid3qVYQ+IYYwBvFXFNitYB3LBxgY+v3908dBi/LAYrtSD65NkR
nr8mkm0WBRgkIgSid6CRBI1D2noOOKUQc8HnNUuapzFbpF4slstAo365JBapTQPT
+e2eSn9e91BO7/t8obDTamXhrLg0IFzZJKdn7vOQrkXeQ/T/LqLqY2E9hujSg6Hx
yOyVX/F0QaTPNeUC6De1wsYjHmJGUlzZr/RCxcLzpHbvvnnLKEJcWNdeGmftW+hn
sE7Aqfe/jKVIRegFmr8lYYAGB4FeKpBLDYbOibN3xHbj5hHh406+jCXxUcHLl/Tn
y7T+6bS+oHeHVy6RqKBGPR/V9Db+vw==
=jFa4
-----END PGP SIGNATURE-----

--mBZfW+uwR7wE4Mt4--
