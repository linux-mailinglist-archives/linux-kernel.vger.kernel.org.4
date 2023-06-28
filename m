Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024B17407B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjF1BiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF1BiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:38:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10B10D2;
        Tue, 27 Jun 2023 18:37:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QrPNG0VtMz4wZr;
        Wed, 28 Jun 2023 11:37:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687916271;
        bh=F2jbhWHZu1zHmf5CrAVBIXw1Itku4vZ3CAmsgn0kn3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T4w+1dpE4OJFCKMTUetjZtVlq3aTgx5ZGlEc0JvNArBrSjJqBWbXXrG3uOKtVczmf
         ip/Z4rtGNlE6uL5FCcm4w+Qh8nBQbq6JmSSaSzACisZJhJsMxHhgphWFEQFFmAXskt
         aLYmVW4Gf0tM3PeED1UTbxinLpAP3qAgbu1w+944MfvOzKBU27/DoaUmWOki+52t2r
         /nGNH9u4FS1MBbCWLF088410iTypuP7WPAPKU8ppyVM98Hjdz1FiIfczg9FhX2KC/V
         9DRIY3eXH/jEbgCNjXvdJy1Uz5bDPSZCetzvoeNu49dBIFDeLBfXMCZ1D0fBrztCOq
         RSavNXxP2RpfA==
Date:   Wed, 28 Jun 2023 11:37:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: linux-next: manual merge of the tip tree with the perf tree
Message-ID: <20230628113748.071d8d80@canb.auug.org.au>
In-Reply-To: <20230516103413.21e34bb6@canb.auug.org.au>
References: <20230516103413.21e34bb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8gYG00IpxB6JdvIkzsRvLRq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8gYG00IpxB6JdvIkzsRvLRq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 16 May 2023 10:34:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the tip tree got conflicts in:
>=20
>   tools/perf/arch/x86/include/arch-tests.h
>   tools/perf/arch/x86/tests/arch-tests.c
>=20
> between commit:
>=20
>   ae4aa00a1a93 ("perf test: Move x86 hybrid tests to arch/x86")
>=20
> from the perf tree and commit:
>=20
>   78075d947534 ("perf test: Add selftest to test IBS invocation via core =
pmu events")
>=20
> from the tip tree.
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
> diff --cc tools/perf/arch/x86/include/arch-tests.h
> index 33d39c1d3e64,93d3b8877baa..000000000000
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@@ -11,7 -11,7 +11,8 @@@ int test__intel_pt_pkt_decoder(struct t
>   int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
>   int test__bp_modify(struct test_suite *test, int subtest);
>   int test__x86_sample_parsing(struct test_suite *test, int subtest);
>  +int test__hybrid(struct test_suite *test, int subtest);
> + int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
>  =20
>   extern struct test_suite *arch_tests[];
>  =20
> diff --cc tools/perf/arch/x86/tests/arch-tests.c
> index 147ad0638bbb,b5c85ab8d92e..000000000000
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@@ -22,15 -22,7 +22,16 @@@ struct test_suite suite__intel_pt =3D=20
>   DEFINE_SUITE("x86 bp modify", bp_modify);
>   #endif
>   DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
>  +static struct test_case hybrid_tests[] =3D {
>  +	TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
>  +	{ .name =3D NULL, }
>  +};
>  +
>  +struct test_suite suite__hybrid =3D {
>  +	.desc =3D "x86 hybrid",
>  +	.test_cases =3D hybrid_tests,
>  +};
> + DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
>  =20
>   struct test_suite *arch_tests[] =3D {
>   #ifdef HAVE_DWARF_UNWIND_SUPPORT
> @@@ -44,6 -36,6 +45,7 @@@
>   	&suite__bp_modify,
>   #endif
>   	&suite__x86_sample_parsing,
>  +	&suite__hybrid,
> + 	&suite__amd_ibs_via_core_pmu,
>   	NULL,
>   };

This is now a conflict between the perf tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8gYG00IpxB6JdvIkzsRvLRq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSbjuwACgkQAVBC80lX
0Gxmugf+P554wovd4Tm1A/gwphoP5Hr0ZU9uV5VbMqKT96+90FpUM0ikDI6NXHE/
o+hpSwZ3s+p4NtNx+Tq32FALbsC2iPQnfAfgffBRcuVxDW8qkz3qqfCFaceh0ltG
w7LSLgBtVS2u7Oo1iACi8ZlBLw2ZeKvZ6QG3/EjB4UiMHrDdCue+2/pkeERBmyPp
3ltzsDZxQtefgJ8+uYXdFrCp+uUHGIZPEOFlQNORB8feBj8/jNV+Ka51NiCRtoSM
caNlwkOrhx6n9kXbG904jpJZji9LhPHOQpAXDftKHhww3VDrs++ngsytUl9RHUv7
KMPZvyduuD3Oyu21x+RprK41AuEwFw==
=mtIU
-----END PGP SIGNATURE-----

--Sig_/8gYG00IpxB6JdvIkzsRvLRq--
