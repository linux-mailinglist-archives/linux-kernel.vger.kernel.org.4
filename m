Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2549963A772
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiK1L45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiK1L4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:56:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D49264B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 635C96112E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16ADC433C1;
        Mon, 28 Nov 2022 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636610;
        bh=F01Yqn4oMdrNuhfLlGpAtkic97KUCzV9Ns24kcxYdpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHpjEu8CsEP0iGDVJMRYl0y/3PdBn5zQUX80MgYCik26HWAMmo2wcU5V1EJYiOKyx
         x3V+Sb/k5EHLNIjMwrQ36zbqOcAzY3bcZKOeNx0lgSX+nhIFqQrPRlrLBBD0pmJR//
         EoCNDYXN4iEEBYxxW7xhSKFsdhyK8G3DQDxaoMw6RBCdrKwv5+nynYzHFpgpUZGJhE
         PLI/ym35YkghAZG5hHWRkg2SpC2Fxnol2M8BOk+OH0tevhjt71A/lIv1Mj2cau9ekd
         Hp77jYNq9r7dniQJZLYq9jmhZqY3ozHHFWJL0XRfMJDjq9Nkzk9RWlBKbPVU/2XDxP
         ZFzzgFoi8CY8w==
Date:   Mon, 28 Nov 2022 11:56:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: da9211: Use irq handler when ready
Message-ID: <Y4Sh/uFEgAxIEOs0@sirena.org.uk>
References: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9/aOcK7LjUo8vXJi"
Content-Disposition: inline
In-Reply-To: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9/aOcK7LjUo8vXJi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2022 at 10:06:02PM +0100, Ricardo Ribalda wrote:

> [    1.327829]  irq_thread+0x11c/0x234
> [    1.327833]  kthread+0x13c/0x154
>=20
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> regulator: da9211: Fix crash when irqs are pre-enabled
>=20
> If the system does not come from reset (like when it is kexec()), the
> regulator might have an IRQ waiting for us.

You've included two entire changelogs here.

--9/aOcK7LjUo8vXJi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOEof0ACgkQJNaLcl1U
h9CU1Qf4itFKKQ8a4P83LdPTRpNT2N1QKhudZYFrM3Ozc8v+ZPtTyBxzMqO9Qnia
HSDvhO4FbkzwOPTzVF9MSIh+eN7jTMdkDP3mFXV+bzaR5HBZShLlmE2xgWDhWBJg
i+DqeEU2GqhYifthI21CPxNuKECK47Z6TXYOdxEP9B+oJT21QLU6/er2xbljZjdd
UkOtilh7FgCmTyW6RVm2gCrzsjCBFUWuXOYHVWi1cHJ/fETrc/fBZlmDHOS50PVq
uykQVkykoDu0qCJYb0AVHOb8drkU7E12815390XpXd9rD9T5Tv0Qbr/jItZaydlm
Cj/yAjr5ku0sKZddG4baTcVWFVr/
=uU57
-----END PGP SIGNATURE-----

--9/aOcK7LjUo8vXJi--
