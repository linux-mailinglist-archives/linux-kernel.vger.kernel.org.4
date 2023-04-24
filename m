Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143D6ECB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjDXLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjDXLyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70383E45;
        Mon, 24 Apr 2023 04:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B9461268;
        Mon, 24 Apr 2023 11:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDFCC433EF;
        Mon, 24 Apr 2023 11:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682337293;
        bh=CaWpXAtgfx+CPGyFGx7gzw+vOneOZlGJoqFS0co6xVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmEi/Dl5NeCDYA7IyZm16uyN8QDpyk5zJjIrZ3CFzKCPJ7vjOVUq8Nt/hvfo+cyDX
         ahLh6R/xe7y587kiNnJKp43xM+aGxleP7xlZ8y9mln871FxMh52eEuDJ1BUe9DXwyg
         VcI45VMw/XpJUvUzgXKYEj2X048uNSNo3iQ/lH8h5BWeyJbFC47q6mYn238OWXdXaB
         zpopPwKOX3nQpp6fhPsbCjmKo/CSV92zKQ4CfEi67Rlp/9UhPcSE4NCBJICj/vCnMn
         gi9WewF97o9MmUpw3WDHU0xrRDmdclrcPpQomEYBt0zpAfnfgtGuPzQ+CJlDZfn6lh
         N0fMUBF9kUJ7A==
Date:   Mon, 24 Apr 2023 12:54:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yingsha Xu <ysxu@hust.edu.cn>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        hust-os-kernel-patches@googlegroups.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vvx6pjyUAG9u5a+8"
Content-Disposition: inline
In-Reply-To: <20230423061155.2540-1-ysxu@hust.edu.cn>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vvx6pjyUAG9u5a+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2023 at 02:11:54PM +0800, Yingsha Xu wrote:
> Smatch complains that:
> dw_spi_debugfs_init() warn: 'dws->debugfs' is an error pointer
>  or valid
>=20
> Debugfs checks are generally not supposed to be checked for errors
> and it is not necessary here.
>=20
> Just delete the dead code.

This is very much a question of taste with a range of use cases
available.

--vvx6pjyUAG9u5a+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGbggACgkQJNaLcl1U
h9B6Ugf/b159bWCAqJBwfw5277rkoMI9WDLRnmgIo3Vxh3dP0+K8N9LdFjsSsKiD
HxQbnaIFTfMq/t9lzF0scd4xu/hGS/S/4QiljaA7xki1ZRVQ1/RPxU1GJb+eJd5c
vMrP2ldgqWKTU4k6SEnzUx4UgyQJvPwx9doFyq1hGdfbClJl8I3gw6SROP/bIt1I
3lXhpNMr2OHofwiWSwsa7La2SHrnvb29sl+me0xyw3hpg5YF5KEVc7EIDyvfCOPb
N/PV8QHCz9gGdiFp9qTTD+19FAHVe7iLbqkQ9luKWh0yFMMZpVKdSQbq6XjO96Ac
Pc46PT48sZnKk3Ciiy6JLytfTonFIw==
=dz1r
-----END PGP SIGNATURE-----

--vvx6pjyUAG9u5a+8--
