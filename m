Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E66624265
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKJMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKJMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:31:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB66BDD2;
        Thu, 10 Nov 2022 04:31:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29CB761638;
        Thu, 10 Nov 2022 12:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12594C433C1;
        Thu, 10 Nov 2022 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668083489;
        bh=2E5hv2r7AZmXX2yuakf8ltitF0UslUzE1kVGsGiQao4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=th656oem0Dt0plFopWGpua7+J9aYc6xJhWh6AyfWm0f8N+pchEWZ+ritDMtB87ByX
         BTg+R8egYohS3vrbUlqy/Bv90ov22EUr0FinA8tVZ4P78OVSE6zAJurmPbH5n/RzOY
         6D3YhO9aZ2yPAfA/7nCDHzsRmHDDg6O5SWDL6kvDd7ZE+FgTdkLIGtPSZ5M6y5qwBt
         sxk9RosaH6UTDoQm2mLVREw7IAwZzo54/fnIAujXi9qm8da1u9+KPD99Qdt/7blrG1
         Xjfv9Ex6N9Z6R8hD2neWJU5IJhzvVsqhyQRCYMcA9O3VZDnsw0i+IcP1eVKmQmk+2B
         RCh/EUmC6Ry3Q==
Date:   Thu, 10 Nov 2022 12:31:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, patches@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom_smd: Fix PMR735a S3 regulator spec
Message-ID: <Y2zvGxmUyl/kpieu@sirena.org.uk>
References: <20221110121225.9216-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7H6ScoooF8pWRyKa"
Content-Disposition: inline
In-Reply-To: <20221110121225.9216-1-konrad.dybcio@linaro.org>
X-Cookie: Torque is cheap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7H6ScoooF8pWRyKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 01:12:25PM +0100, Konrad Dybcio wrote:
> PMR735a has a wider range than previously defined. Fix it.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> No Fixes tag, as the patch is only in -next, so the hash will change.

No, it won't.

--7H6ScoooF8pWRyKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNs7xoACgkQJNaLcl1U
h9C5dAf+NZWkTN7Hnmen4YrXKFI0KUXn5uPN01YHixe4hTiQ9M4z8z8ZhDXWzum6
MqQB01rohiGeEa2JCDVSWW2I0jtviqKF0NygjZacr3vTPogv5jt390gSSXQjhcfK
tjIl3Ef4hFyAq4+n7RBJxZopkUCbP7oPiQd2vBonRRJ625T5Tf9TE/zdnVdDcNNJ
0qk/V6zU6CUgxJd0M3G64MPCDgNnz1uSVzJMoRmKhe6GUDbzdy7rTr5vLty/BtIJ
HeQpsorUZFOILsfU2+0K5vehR7AZ5mVcbBse0kPrMOrUb7SQ0malLadHISZGpxvo
B6T6vyGxVTsn3mzoIJ4U5ooSOG65wg==
=oiEz
-----END PGP SIGNATURE-----

--7H6ScoooF8pWRyKa--
