Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D409574FAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGKW0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826419B;
        Tue, 11 Jul 2023 15:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD64F61635;
        Tue, 11 Jul 2023 22:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210A1C433C7;
        Tue, 11 Jul 2023 22:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689114406;
        bh=3nFfKZLryOogKBR6DooMXH3k22BIdMVynqEo8+HbKfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihsecDR6KtXVr8QBK2f1KfqG6q2bogQAhWkDFWXtG7Rr8vr1BAA5WUv8SY6Txeq+y
         8TdZsktXfafx0RN+H710S7oJpL8uRp+YYJ87Xt+8RjqePKpNEQjP+UnoB4jcBz/lfT
         wU5OIlFYFF84G+BJruy+xB+enLB8wC7Fsfq6jMnCFL51+4VfVGD627H6ObqGRtiuG8
         67uCa0O0Vhd5fttPEgDkZ4CwzCvFgkMIQp8OHNUZeoPod/Fz4r20kafOEbycAPhv7J
         bJmhpnZNXI6N2iZ+CgAldFka3JyFV3yPnd4VBzQOrZwORgg460ADevAA7TWdjX6rPN
         1gb5rH967HKLg==
Date:   Tue, 11 Jul 2023 23:26:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: clear loopback bit after loopback test
Message-ID: <32ca3740-901c-47f2-81ab-c51e8751eefe@sirena.org.uk>
References: <CGME20230711082508epcas2p3088d488035e7e2910bf087d640e9c268@epcas2p3.samsung.com>
 <20230711082020.138165-1-jaewon02.kim@samsung.com>
 <20230711221930.2qinef626kxtthsv@intel.intel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="peD5ODrQXAidKv01"
Content-Disposition: inline
In-Reply-To: <20230711221930.2qinef626kxtthsv@intel.intel>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--peD5ODrQXAidKv01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 12:19:30AM +0200, Andi Shyti wrote:

> with the change suggested by Chanho:

> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>=20

> Mark, can you add the
>=20
> Fixes: ffb7bcd3b27e ("spi: s3c64xx: support loopback mode")
>=20
> tag or should Jaewon resend?

It's already in CI with that, b4 picks up fixes tags.

--peD5ODrQXAidKv01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSt1yAACgkQJNaLcl1U
h9AlzAf+OJVElQZvMGz6jXgbBd6FdkGMaVdrHj+NfHKBom4AFb7FKm5rk9cTNY9z
vww/69sErnIihAKpqT7PK1O5D/i2T4lVYgQsKRfh7iisdly5eumMBbTyYKtkvjkv
DkhKixNgszQbcWnq1mzJluFrmK+5c+doXGnXqL4aMrsUD6yLJdpdmI6HaRaQ/wUK
iX00y5DefvYihTr4Rifa+r+S2/m1NUbfpaNiUypQ9qAc4bnjjAwd9seLfHyT4QNg
1M0Wf+N1IDlFhZX2mOoLsWXBqFNbfDDame62S0Wir2mBbFqi4pT0UAouMXDQ/IQH
J6Snv4EQnGDBkfXfEhoM4yYmTftSAw==
=X/a3
-----END PGP SIGNATURE-----

--peD5ODrQXAidKv01--
