Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F172514A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjFGA5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjFGA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:57:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B761728;
        Tue,  6 Jun 2023 17:57:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbTSn3mlLz4x2c;
        Wed,  7 Jun 2023 10:56:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686099422;
        bh=k56jEU2ViEAn2/eGC8DhZ9t/fIq2mRoRRD7wYVTLs68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FGl+omh82Vv4jaVNMc+afltpnJ1JUx45tyoPHvWMYcjdt/LlDYElF5ZRuwC2KLZHX
         t+x8uElM34LTJEQi0obzdLoTOkN8+in6RN6vxkNFtfLAQ9yNfNLMT5PKT+MQFDIjpq
         MbRyiMkQdolx7g4SPeb41LrlltsrkM7sVyN3UzBxi0cJjMiDGJIFbPxWu+MOQ/bmTs
         0q+r7K3tlAKA395fM0KJPDf5NJD4t5yJhq7OMl6N/SNr/DZ320Wm9pjxtg/M3I+3qw
         W5DsGN6BNPKIPin5xyk/XTRCb/2eMrScoJ7vkHGLWQqIyPG4Tng+eal+GbYeutNFJV
         UDPj8QNi1H7tg==
Date:   Wed, 7 Jun 2023 10:56:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, irogers@google.com,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, kjain@linux.ibm.com,
        renyu.zj@linux.alibaba.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, wangming01@loongson.cn,
        chenhuacai@kernel.org, sandipan.das@amd.com, 9erthalion6@gmail.com,
        seanjc@google.com, robh@kernel.org, tmricht@linux.ibm.com,
        tegongkang@gmail.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf test amd: Fix build failure with
 amd-ibs-via-core-pmu.c
Message-ID: <20230607105656.1f2f8b89@canb.auug.org.au>
In-Reply-To: <20230606142436.153750d9@canb.auug.org.au>
References: <CAP-5=fUPZ7+nAcxBp5sFBfxzkOH8kzWkLV0uziHqxYC0cDbbDw@mail.gmail.com>
        <20230603044650.286-1-ravi.bangoria@amd.com>
        <ZH3w7TWRQZsPqhB2@kernel.org>
        <20230606142436.153750d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZpeoibezJ3cg31_biwxtWat";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZpeoibezJ3cg31_biwxtWat
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Jun 2023 14:24:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Mon, 5 Jun 2023 11:27:57 -0300 Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
> >
> > How are things like this resolved in linux-next? =20
>=20
> Well, if it produces a conflict (or a build failure due to a semantic
> conflict) I will fix it up (maybe using a separate patch such as this)
> and report it so that the maintainers know that they need to let Linus
> know about this when he merges their trees.
>=20
> But since neither of those things has happened (it seems that an
> allmodconfig build does not build the tests), I can still take this
> patch and use it to fix up the tip tree merge (since that happens after
> the perf tree merge) starting tomorrow and report it as above.  I will
> then keep applying this patch to the merge until it is no longer needed.
>=20
> Please send me the actual patch. (I am assuming that the patch applies
> on top of a recent linux-next release?)

I fetched the patch from lore and have applied it to the tip tree merge
from today.  So the tip and perf folks need to remember to tell Linus
about this fix up patch when they send their pull requests during the
merge window.  I have included the patch here just to be sure.

From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <irogers@google.com>, <acme@kernel.org>, <sfr@canb.auug.org.au>
CC:     <ravi.bangoria@amd.com>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <will@kernel.org>,
        <james.clark@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kjain@linux.ibm.com>,
        <renyu.zj@linux.alibaba.com>, <kan.liang@linux.intel.com>,
        <zhengjun.xing@linux.intel.com>, <maddy@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <wangming01@loongson.cn>,
        <chenhuacai@kernel.org>, <sandipan.das@amd.com>,
        <9erthalion6@gmail.com>, <seanjc@google.com>, <robh@kernel.org>,
        <tmricht@linux.ibm.com>, <tegongkang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2] perf test amd: Fix build failure with amd-ibs-via-core-=
pmu.c
Date:   Sat, 3 Jun 2023 10:16:50 +0530
Message-ID: <20230603044650.286-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"UTF-8"
Content-Transfer-Encoding: 8bit

Since amd-ibs-via-core-pmu.c was applied via Peter's tree, some of
the changes came via Arnaldo's tree did not reflect in this file,
which is causing build failures.

  arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: =E2=80=98pmus=E2=80=
=99 undeclared
  (first use in this function)
     47 |         if (list_empty(&pmus))
        |                         ^~~~
  arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit declaration
  of function =E2=80=98perf_pmu__scan=E2=80=99; did you mean
  perf_pmus__scan=E2=80=99? [-Werror=3Dimplicit-function-declaration]
     48 |                 perf_pmu__scan(NULL);
        |                 ^~~~~~~~~~~~~~
        |                 perf_pmus__scan
  arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit declaration
  of function =E2=80=98perf_pmu__find=E2=80=99; did you mean
  perf_pmus__find=E2=80=99? [-Werror=3Dimplicit-function-declaration]
     50 |         ibs_pmu =3D perf_pmu__find("ibs_op");
        |                   ^~~~~~~~~~~~~~
        |                   perf_pmus__find

Fix those.

Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v1->v2:
  - Remove unnecessary perf_pmus__scan(NULL) as suggested by Ian.

 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/perf/=
arch/x86/tests/amd-ibs-via-core-pmu.c
index 2902798ca5c1..78b1902f6f59 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
@@ -44,10 +44,7 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test _=
_maybe_unused,
 	int ret =3D TEST_OK;
 	int fd, i;
=20
-	if (list_empty(&pmus))
-		perf_pmu__scan(NULL);
-
-	ibs_pmu =3D perf_pmu__find("ibs_op");
+	ibs_pmu =3D perf_pmus__find("ibs_op");
 	if (!ibs_pmu)
 		return TEST_SKIP;
=20
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ZpeoibezJ3cg31_biwxtWat
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR/1dgACgkQAVBC80lX
0GwEqQgApkQtYT6BEX7UvGVKbn52sWwZYKrdQ1DWsGofGs+4lLUpn1xaSUlKzgti
kToeuGImVORge1pkFEHQmqZdiAOgw3++JnysEXuqwDgENj6Ryqhxu+18ES+FESuN
YKddRznS9/lDG/V2iO7VFRIYzTY1XJVkjmcmhJWFt/NnP3hjdXw63cvPaanb+3oj
xShRuVdMifVYY9ApLM7gU4mCQhBWHp6n5VcihdSkI9+MevC63FJnDv+v6Bssq7oi
qS3VoNouc/rZ7ZMxYDqRUVadH9f2O3PR74DZ7fx1c4hHQR3ee6x2wDLDjOURa0xl
MS/l4I74SWG2fedTtFaY/l7wH+hFgA==
=9mrs
-----END PGP SIGNATURE-----

--Sig_/ZpeoibezJ3cg31_biwxtWat--
