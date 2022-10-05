Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA45F4DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJECzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJECzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:55:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459B4B0F2;
        Tue,  4 Oct 2022 19:55:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhzgy3d89z4wgv;
        Wed,  5 Oct 2022 13:54:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664938495;
        bh=/dftQjub+WnhGxhKZTf/hwc0P/TVISd3s3y0LT/2H6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aFfZRc+7svIDlKlZmfurJyZNvKIDqQTintw7NAT7hUft7diCESQDcawUbsHILLMn1
         jJeEaHO0FZ+IfW3X6hes0U8+B3PMnzVP03DRfbXsVBvv/3/bCffuKYc2BM3LKjknIj
         H6rv+zYusLFsVvTgqC8QcvSSgC6awrhYhYnvMOVWgbngHY2Iivqv1ugKG5ArMgEV6h
         d3SDjodLIeO9SSbE0hhnXAeFY00G+XVtjB5MhzwMdiKeaDs8+R+W79n/p7Dq24mQ8z
         me/UEyp5Hq1KSMyU45CVTo32dRjpV0k6esA/rnQ+W+mXYXyuQmXSUjocqV+wyqADXy
         aXEbCFeP7OHmw==
Date:   Wed, 5 Oct 2022 13:54:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: linux-next: manual merge of the kspp tree with the tip tree
Message-ID: <20221005135452.2ebb563d@canb.auug.org.au>
In-Reply-To: <20220906174946.61819060@canb.auug.org.au>
References: <20220906174946.61819060@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/frrJnoO7JsebmBB+ihL3H+2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/frrJnoO7JsebmBB+ihL3H+2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Sep 2022 17:49:46 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the kspp tree got a conflict in:
>=20
>   lib/Kconfig.debug
>=20
> between commit:
>=20
>   724c299c6a0e ("perf/hw_breakpoint: Add KUnit test for constraints accou=
nting")
>=20
> from the tip tree and commit:
>=20
>   bb26bbd0a067 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
>=20
> from the kspp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc lib/Kconfig.debug
> index e40550a5bdd3,1f267c0ddffd..000000000000
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@@ -2533,16 -2542,15 +2545,25 @@@ config STACKINIT_KUNIT_TES
>   	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
>   	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
>  =20
>  +config HW_BREAKPOINT_KUNIT_TEST
>  +	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
>  +	depends on HAVE_HW_BREAKPOINT
>  +	depends on KUNIT=3Dy
>  +	default KUNIT_ALL_TESTS
>  +	help
>  +	  Tests for hw_breakpoint constraints accounting.
>  +
>  +	  If unsure, say N.
>  +
> + config FORTIFY_KUNIT_TEST
> + 	tristate "Test fortified str*() and mem*() function internals at runti=
me" if !KUNIT_ALL_TESTS
> + 	depends on KUNIT && FORTIFY_SOURCE
> + 	default KUNIT_ALL_TESTS
> + 	help
> + 	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
> + 	  by the str*() and mem*() family of functions. For testing runtime
> + 	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
> +=20
>   config TEST_UDELAY
>   	tristate "udelay test driver"
>   	help

This is now a conflict between the tip tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/frrJnoO7JsebmBB+ihL3H+2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM88fwACgkQAVBC80lX
0GzAeAf/caICAy0O0D3CylqZf1VpG0M2SOZ8RbbIWdn8ym8nFKRdvgsDnw5UWMQk
Kcop8C/Xv6cTVEVGlOEtG7HO5L1//s2YNkioxtRQY+cIKFUShC5uakkDijVgqSHU
Yvdnwqs17KBmPTzogyvyv64WtnA46bS0I1vzdFWsR8QJSJf25SU42Z8lLeuF/BDu
2koh/bXc+mdOTqMtQ9hiQ6qyGCEBnHBc1Wstu6nY89blKbgiZ57pZLYfpdUggDDQ
J7SFxUUU+ioCjLTuAdDnshMS5OO0qz6XmnFRAAVGo4Vyx5tMzaZqn5vtVZ8iT5yg
e0GFXHSEyHht3jfRz2a5etT/LOu12Q==
=DCPr
-----END PGP SIGNATURE-----

--Sig_/frrJnoO7JsebmBB+ihL3H+2--
