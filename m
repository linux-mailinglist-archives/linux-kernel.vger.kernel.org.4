Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EE572E058
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbjFMLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbjFMLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F110DA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12689634C3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C541C433D2;
        Tue, 13 Jun 2023 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686654369;
        bh=ccj8jNFezKCmu/e5Ds3io8gqa4d3MXMEADREjdcCBFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxOzM81TOHmSKHRFncxulkEnJsRFpWF54FBnmjjh6dXVN5+ADP2JRGdzwdJYMnA5k
         e77k9Mf/yPntdOrfh49ZeS34IaERf/w5J8xPRaOL8dKv+zHaEfWYD2dn4DFB8wBBTa
         8NBICeevbEZPk5mxo8Vu4htY50FUJOsYROgxBaLsgA1j6Ln0MGo6vuuXhnqbW0xN8y
         ddf2YK10vTU+Sfx7OQ8MPfflI/g5ZQ+yoHu54rqjCzTE5hT9oGu7ez72KObFTFswam
         H7ET4boG2zd8qYrNdZUYAx1lq2wyXEVzncPMv8OM+29tuGLmzHnByiTWU6ajiCT3OE
         kOzbc7Awk1YrQ==
Date:   Tue, 13 Jun 2023 12:06:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] regmap: Add debugfs file for forcing field writes
Message-ID: <384ff7cd-4042-4e6e-89e6-356e9b37aee4@sirena.org.uk>
References: <pndttvcu3ut.fsf@axis.com>
 <443d4c43-080e-48b2-80ee-13e2df10c6eb@sirena.org.uk>
 <pnd5y7rabll.fsf@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xTlrbbYOS2tg0jpc"
Content-Disposition: inline
In-Reply-To: <pnd5y7rabll.fsf@axis.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xTlrbbYOS2tg0jpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 12:24:28PM +0200, Waqar Hameed wrote:
> On Mon, Jun 12, 2023 at 16:00 +0100 Mark Brown <broonie@kernel.org> wrote:
>=20
> > If we're going to do something like this which could interfere with
> > driver operation then it should be guarded like the write support is so
> > that people using it have to modify the kernel to get the feature, or at
> > the very least taint the kernel.  This is less invasive but still might
> > cause issues if someone is relying on read/modify/write behaviour.

> I understand your point. Should we introduce a new macro like
> `REGMAP_ALLOW_WRITE_DEBUGFS` (which requires direct code modification to
> enable it) to guard this or introduce a new kernel configuration?

I'd add a macro.

--xTlrbbYOS2tg0jpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSITZoACgkQJNaLcl1U
h9AmUgf/ZGMIA2uD8QPNWum1rG5vSOVtp+Y1BI5KL4E+p09bYQQ7NRhBSFzJxyP0
W++odn40EgSSnnmcji8fjX7xFGmMgB2UW+ZE/fpe55Uy7eaQAhGX6y/ktNqVhApQ
FZ6trhDQm6HgVcWcsKFnv+SculQkIOJMm5u0kik4RWHqdKMbp3oQjxFGDEcWtbjS
KouztL9p44K4c0dukyiAVt7zNRsxYL3dL7f69up44Z0ZV/I/8boTq5VTbsPTOh/r
vsUFSz1RPLbJY6TNCB5u4Qmc7OJ+fOdhvwF3k8FrfGnqbWzMDOMASoORnAu5AEi2
ijVRQvmVF99fRaeyfeGEI/0c6NFycw==
=SLnp
-----END PGP SIGNATURE-----

--xTlrbbYOS2tg0jpc--
