Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C66BCEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCPLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCPLwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:52:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180AB6B338
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8D74B81F9B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CECC433D2;
        Thu, 16 Mar 2023 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678967526;
        bh=b90WYRFDl4yqL9nLZZCJ0KpbaBzqf/uopEj8P5nwVbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrIz3rb+7x6c4MnH65XpITx3fijve2aIfQ/NrunNYpqghVWRCakhKXDQ4ifSyVGyq
         tiqVlmGC0/YxVbA0PvLPO7OotJOXRArPQ11lbJMSL95ZqByEYAhl8yjdrxd1ffetuA
         Kt78NFwo0BHuj7Y19RUfSUdfP545NUp3PKntiPwurXGMbnydz47oQnDR7bxeOBwADU
         9/mN+1MDRcQbbwm0pmI8pno+0EAW6S7k5LseVwZ/s3NCOBzdfQDXWGFhxxaEnEK6xi
         1ml16CMgLVbr1ye9HSxtCl4+jduigZ2ZaGt9tA6zNVoPBKDtXnwDl4n1mEtdqH6bFM
         DHsB41hJWIwdw==
Date:   Thu, 16 Mar 2023 11:52:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ge-org Brohammer <gbrohammer@outlook.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI entries to support Victus by HP
 Laptop 16-e1xxx (8A22)
Message-ID: <386ec839-e10d-4a5a-b3ff-d8772ab73675@sirena.org.uk>
References: <PAVP195MB22610BD3A98379E740C93C08DABF9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFq5NANQBWER6Dx/"
Content-Disposition: inline
In-Reply-To: <PAVP195MB22610BD3A98379E740C93C08DABF9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM>
X-Cookie: With your bare hands?!?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UFq5NANQBWER6Dx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2023 at 09:26:00PM +0000, Ge-org Brohammer wrote:
> This model requires an additional detection quirk to
> enable the internal microphone.

This doesn't apply against current code, please check and resend:

Applying: ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)
error: patch failed: sound/soc/amd/yc/acp6x-mach.c:269
error: sound/soc/amd/yc/acp6x-mach.c: patch does not apply
Patch failed at 0001 ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)

--UFq5NANQBWER6Dx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQTAuEACgkQJNaLcl1U
h9CzFQf9GxRerC4Gg1SYLw8KrxkYASqqOcH4Jy2XS3TtOYVoPDgrl0njYGZTQHjK
+gABwC+kp2j6NuknmgkIzKgYvVygj3SCEETG35pL9Wc8NtWfRX+00ZhxdWoYC/Mi
1jsDPtSMYOnFQq2RIT68Ds7rruSGRwpp4r391o1rwTtnGvuBChiYhJkyQIgwY+e+
fpHFo4PhgkPO5e72IvcaeJuQY/ui6KNSEEMwBpK3R8qek8PFzjt2zZniLJgDYYoN
xvsbF2ahhUtT2V1v7Vbh8WCILGT9FQSmI+EMiG7suV56AxddP/evnwlDp7BjDawb
HAArmM+mnPBID37aHyvkg2wnybvARQ==
=yw4c
-----END PGP SIGNATURE-----

--UFq5NANQBWER6Dx/--
