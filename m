Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390A1616FEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKBVf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiKBVfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:35:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011DDFD16
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A75F5B82523
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50966C433C1;
        Wed,  2 Nov 2022 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667424903;
        bh=KkHVYSW1F44h9rN5Th1LdlEVJxWvgh+M5SfuLM1JhGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VChDxMMpS0LI6ZX5BSeZbM3r69CXd5UGinNgBvWctBl3+9XaC8++HRVNKWgij7XZe
         7K0plG95OVBjn+MYqMfmfeVEtDS+F7/ghOFFBWR719ZHhPiQXqTyqWNuLhINkEQZ+L
         +58RIwwGmNNJlNCau8BvWEZHKN8u0K6bf+WzXamMr2cMUHF7ZogQ+kSxwoFjb5uPMd
         Q/l9E8cRyXIaL3AgeHQ1oqk+AJFPJsyqI20xbTVz+WiYjWuk1HeD1hQNIMoFQFGZLg
         ealV4bJdS94l53D1JWvJ5UUbngo/nq7AD9bniyiRdD2eOknBuocR+kOcQj3HvNAcjV
         t0qujmjlAhuvg==
Date:   Wed, 2 Nov 2022 21:34:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: FAILED: load BTF from vmlinux: No such file or directory
Message-ID: <Y2Lig+5ak3zKuPa1@sirena.org.uk>
References: <202211030542.t5oB7Bw6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yM9YvB8hVrh2lksH"
Content-Disposition: inline
In-Reply-To: <202211030542.t5oB7Bw6-lkp@intel.com>
X-Cookie: Now, let's SEND OUT for QUICHE!!
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yM9YvB8hVrh2lksH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 05:27:38AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a
> commit: 4e8ff35878685291978b93543d6b9e9290be770a ASoC: codecs: tlv320adc3=
xxx: Wrap adc3xxx_i2c_remove() in __exit_p()
> date:   2 weeks ago
> config: arc-buildonly-randconfig-r004-20221103
> compiler: arceb-elf-gcc (GCC) 12.1.0

=2E..

> All errors (new ones prefixed by >>):
>=20
>    Complex, interval and imaginary float types are not supported
>    Encountered error while encoding BTF.
> >> FAILED: load BTF from vmlinux: No such file or directory

This looks very much like a false positive, it is difficult to
understand how a change such as the one identified could trigger such an
issue.

--yM9YvB8hVrh2lksH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNi4oIACgkQJNaLcl1U
h9Bmggf+KlkIc1ZnliihzY6tYZo0ANxoW7xYrHRMyZpcCgPjvmWKf7kU2CYZp77Q
4pDg+PTnhvahfufjS7GSAb0JmXfw5yPDKH9VU8q2UIRqvmrcyvHDJLbfwqmVpmrz
Zbif2RI8ZTwDrw6TjULToqXeOr469sTRnGTxZ7FCKL8k+hvkdXxqVz5pjPqmDF8Q
iw/iHNOPVOHwhCeEPmjuznzEwYjUVrGDAyx+39sEhqJcjVuSlTavGlT9Ezn/iIhw
IDqI0/JDlcfbjb1kuudgVTIOZ9NaaqB5aHi94rCEb6kCuPjSTE+W4lhnar+9o6Ri
OkdSlbY3lXv+Whe7h54oESKfuUbIaQ==
=j6A7
-----END PGP SIGNATURE-----

--yM9YvB8hVrh2lksH--
