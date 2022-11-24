Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07316637DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKXQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:52:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838E1532D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:52:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 414DEB82896
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 16:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ECBC433D6;
        Thu, 24 Nov 2022 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669308772;
        bh=GDvg+P9DHUEUS9cltsrz3EaAx0IMyJgU30wiB6eV6cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhrJIBqR9yKxJ5yjelbV6+rSv2DJAsJZsIJnQ4DtgEvRFycQl/07UcfrWuHOfYgxi
         vVYfASqHJkuZUghnOWRqvtBl5dYPUZPFTIiGTeZlpY2HgXfaPKYme2wTGbLaZzXvsQ
         xCRSf4h0LYCc82L9ADIQ7/kHitbZPyod6rlxHJXE0wnQivu4UbrthSjlkFlGGFFixK
         cqmvSNE5CpVEGz+eflz5BTQXN2jqpWKmxIxC2be7dai93yjQnw7djn7maQVSQ/9KLI
         6dBSjeI7xY6dxRNkMFezvoRd2Sl9yyzpqMUEPgT7qSiOa9lyFr2QSz47gUfmetu3Oy
         QdLz2WZmjFl6w==
Date:   Thu, 24 Nov 2022 16:52:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] regulator: da9211: Fix crash when irqs are
 pre-enabled
Message-ID: <Y3+hX2c+/rBwZ8VN@sirena.org.uk>
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tP5ToxIypis0BhbU"
Content-Disposition: inline
In-Reply-To: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tP5ToxIypis0BhbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 05:45:30PM +0100, Ricardo Ribalda wrote:
> If the system does not come from reset (like when it is kexec()), the
> regulator might have an IRQ waiting for us.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--tP5ToxIypis0BhbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/oV8ACgkQJNaLcl1U
h9AVVwf+PDk+iYZSeksBW4KuYWpiDVIwVTicSWyVMVj2NP2XRUdDXYQ21ntOaNcN
/2aYJp37aJ+P9yxT0RrlWCxGUMhZuocx9mHMCENNiYYE/LLxKMPG9xYkO7JMAW46
RUgNWHk5OjEjqa6M22xiWL0YbMpMqNyZx2SI7+pB2PQupQpU6J1ueFtCvb/f5kzh
Gj6nW3soBoynRuM4TrnNR38RvUCOkClUkPtULkVSQa8FMlZpHUa6j0tGjll14Erv
xVjoAGQKCdK5OlqEn/dFPHeImwIgWpOB04F1ScN8cNlHMoHOCKEmjEAq5/8RME0o
hkLh0lPRp+Hk6xRHsACq+3Q0450Xdw==
=ghrx
-----END PGP SIGNATURE-----

--tP5ToxIypis0BhbU--
