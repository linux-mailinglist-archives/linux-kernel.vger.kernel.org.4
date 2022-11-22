Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238B5633C63
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiKVMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiKVMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:24:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65599326CE;
        Tue, 22 Nov 2022 04:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15FA5B81A4A;
        Tue, 22 Nov 2022 12:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BF7C433C1;
        Tue, 22 Nov 2022 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669119881;
        bh=QcV/aHr1DpTzfVs0uQ2lgdfZ7zL1+NRJnZMTFZV6jEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXvItkZFSOWkRF4Tm0GkTxAAL7XfJ6Y18zpdMTYlxDU/3XXL7LUfOoyCJmIVNiH1w
         v2jIdOCxji/L2HKG+Qn31D6SQW/1U9kHb6+XJxJHFDwa08LoyN0ATijH1DH85YM2sR
         zd6wQ6HSk/gbh5QEcYahWeNhBxKpQYfyGIunD+Ku0wIc6BunS0zSJmIN/XX29kAv0Z
         ihrEbBiTbIyB3xBow6bsVSsW4DTQUhNpJHA6ZyeqCLkEQv+1Cbq786yZJhu8uvULJA
         HSuvhDmd0r3iglR8seWXXX87JofFPIszXNQ9hKBIbHTlyI9vwgHEbAJx4aUEUFwMko
         6/0sif4ZVLrFg==
Date:   Tue, 22 Nov 2022 12:24:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "ye.xingchen@zte.com.cn" <ye.xingchen@zte.com.cn>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH] spi: use devm_platform_get_and_ioremap_resource()
Message-ID: <Y3y/hPKHnvO/efpJ@sirena.org.uk>
References: <202211220944121776425@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dZI8t1pVJ3nkhVeK"
Content-Disposition: inline
In-Reply-To: <202211220944121776425@zte.com.cn>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dZI8t1pVJ3nkhVeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2022 at 09:44:12AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

This doesn't apply against current code, please check and resend:

Applying: spi: use devm_platform_get_and_ioremap_resource()
error: corrupt patch at line 19
error: could not build fake ancestor
Patch failed at 0001 spi: use devm_platform_get_and_ioremap_resource()

--dZI8t1pVJ3nkhVeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN8v4MACgkQJNaLcl1U
h9AOSAf+OE2aD1DWtb9CReX10ia225E/ulS1ibHYMCHiNDhvNqN2QUjnhFEy6PFs
3ZZZFSO0s49O9JB9TUXDQDZVMSEJu5Q4g2+7jE5oi+vyIIN7ETbIHuzLTChjWxns
dDNZEfBj/+UNcL0d4LrBkdiLbOGs/DEv4fbddztSNVkQmWEJ+Sye1wB+oOB7ZCDG
JCr0qk7Ws9LRcHDWxAZqKyAogL24ajSUDqRQ53h03bYyYTKwMG+FlPTQlNfEcu5B
ZGmnHYDbyu/zRgO4q6FCJv+Qn012DrgdkmIVGLf++7OyK4EDVfGMstOSEjAFYOlO
ArEvPh4MELz1cEhw1Q2JVfPlEN1vBg==
=L/DU
-----END PGP SIGNATURE-----

--dZI8t1pVJ3nkhVeK--
