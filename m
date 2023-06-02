Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379271F8C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjFBDMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFBDMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:12:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1470E1A2;
        Thu,  1 Jun 2023 20:12:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QXSjV4QVkz4x41;
        Fri,  2 Jun 2023 13:12:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685675550;
        bh=5r8phFjiOtGQHEVi0Cdk5a51ggJqxoQP5YmU+1M5KKg=;
        h=Date:From:To:Cc:Subject:From;
        b=ddqr14k5tMNIunwJP/z3bMik+dhdHTwU3VOrZqLTctHTz3hLwGwUwXlQRgv4rWJXK
         ONpBdCOalaOaeuPXlaDhwCW9bhiFV5JHuHVPuosSqjexei7U/FHHSOs3NY0OSMlcip
         3PPlsDbLNLnP2r0WSSTdajri5rYlztBt9xWFD2kJAo2X6WVYSrou+QUNsJGfBx48Hv
         CLNFve5NJgxSEzTvJpFomCS6PZMzwOKsxxe8+sXJOBUaK0ioHBwinw4yv1m3ZcOApT
         ZUFwoE1WteexNKLu/YQHacWKPF6A6w0GHfT/m90oRMAVFO6u+wMExVWpGfEa0YvPBV
         jOVmGCd+XGrcw==
Date:   Fri, 2 Jun 2023 13:12:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20230602131229.3589f3bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uuDuslqJRgnKB4nKs8vpRAT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uuDuslqJRgnKB4nKs8vpRAT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced these warnings:

drivers/input/tests/input_test.o: warning: objtool: input_test_init+0x1cb: =
stack state mismatch: cfa1=3D4+64 cfa2=3D4+56
drivers/gpu/drm/tests/drm_buddy_test.o: warning: objtool: drm_test_buddy_al=
loc_optimistic+0x3ab: stack state mismatch: cfa1=3D4+176 cfa2=3D4+184
drivers/gpu/drm/tests/drm_buddy_test.o: warning: objtool: drm_test_buddy_al=
loc_pathological+0x741: stack state mismatch: cfa1=3D4+216 cfa2=3D4+232
drivers/gpu/drm/tests/drm_buddy_test.o: warning: objtool: drm_test_buddy_al=
loc_pessimistic+0x486: stack state mismatch: cfa1=3D4+200 cfa2=3D4+208
drivers/gpu/drm/tests/drm_buddy_test.o: warning: objtool: drm_test_buddy_al=
loc_range+0x46e: stack state mismatch: cfa1=3D4+232 cfa2=3D4+248
drivers/gpu/drm/tests/drm_mm_test.o: warning: objtool: drm_test_mm_debug+0x=
1fa: stack state mismatch: cfa1=3D4+656 cfa2=3D4+640
lib/kunit/kunit-test.o: warning: objtool: kunit_log_newline_test+0xfb: retu=
rn with modified stack frame
lib/strscpy_kunit.o: warning: objtool: tc+0x560: stack state mismatch: cfa1=
=3D4+128 cfa2=3D4+136
lib/memcpy_kunit.o: warning: objtool: inner_loop+0x4fc: stack state mismatc=
h: cfa1=3D4+168 cfa2=3D4+192
lib/memcpy_kunit.o: warning: objtool: copy_large_test+0xfa: stack state mis=
match: cfa1=3D4+128 cfa2=3D4+176
lib/stackinit_kunit.o: warning: objtool: test_packed_assigned_dynamic_all+0=
x2ef: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_assigned_dynami=
c_all+0x31c: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_assigned_dynamic_a=
ll+0x31a: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_dynamic_all+0x2ef: ret=
urn with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_dynamic_all+0x3=
1c: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_dynamic_all+0x31a:=
 return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_assigned_copy+0x2ef: r=
eturn with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_assigned_copy+0=
x31c: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_assigned_copy+0x31=
a: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_switch_2_none+0x282: return w=
ith modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_switch_1_none+0x282: return w=
ith modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_user+0x2ea: return with modif=
ied stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_none+0x2c1: return wit=
h modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_none+0x2ea: ret=
urn with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_none+0x2e8: return=
 with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_char_array_none+0x2d3: return=
 with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u64_none+0x2c1: return with m=
odified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u32_none+0x2c1: return with m=
odified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u16_none+0x2c1: return with m=
odified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u8_none+0x2c1: return with mo=
dified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_runtime_all+0x2=
ea: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_assigned_static=
_all+0x2ea: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_runtime_all+0x2e8:=
 return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_assigned_static_al=
l+0x2e8: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_runtime_partial+0x2c1:=
 return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_runtime_partial=
+0x2ea: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_runtime_partial+0x=
2e8: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_static_all+0x2c1: retu=
rn with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_assigned_static_all+0x=
2c1: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_runtime_all+0x2c1: ret=
urn with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_static_all+0x2e=
a: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_static_all+0x2e8: =
return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_zero+0x2c1: return wit=
h modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_assigned_static_partia=
l+0x2c1: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_static_partial+0x2c1: =
return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_zero+0x2ea: ret=
urn with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_assigned_static=
_partial+0x2ea: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_static_partial+=
0x2ea: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_zero+0x2e8: return=
 with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_assigned_static_pa=
rtial+0x2e8: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_static_partial+0x2=
e8: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_char_array_zero+0x2d3: return=
 with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u64_zero+0x2c1: return with m=
odified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u32_zero+0x2c1: return with m=
odified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u16_zero+0x2c1: return with m=
odified stack frame
lib/stackinit_kunit.o: warning: objtool: test_u8_zero+0x2c1: return with mo=
dified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_assigned_dynamic_parti=
al+0x2c5: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_assigned_dynami=
c_partial+0x323: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_assigned_dynamic_p=
artial+0x321: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_packed_dynamic_partial+0x2c5:=
 return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_trailing_hole_dynamic_partial=
+0x323: return with modified stack frame
lib/stackinit_kunit.o: warning: objtool: test_small_hole_dynamic_partial+0x=
321: return with modified stack frame

Presumably introduced by some change to objtool.

--=20
Cheers,
Stephen Rothwell

--Sig_/uuDuslqJRgnKB4nKs8vpRAT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR5Xh0ACgkQAVBC80lX
0GzHwgf/QBr2G4C/mSFkm7ymPp/AYYCLMEdIhq/Sfsah/MM0INeJLT2SzlS0apmH
mI0AZAsDSUxsxDcghUlDQzcp5Z7LKyEO6JSI0h+keEIfrG+BgB4qxfJjqG6t8wzh
BUvHr1wr/Q609Fql5r7hSxUzDWjPWR7FH6lDHstYiueqmPRk/6kMcpw+zAXWID12
TcaC2rWJ0/LSqgB3vbZxXAuS2tDHral0v82cO6RfDX35pdismVF2aJz0XFUdd29W
tWy1I3F7NeWP4YPoqYFJQvWhzpmhFp86UKJ8aKyAuMRN7nYw6Cw0VMa8PjRTKNTp
rQbcA+k37ejp4PXhqy/uaJS/1epfRA==
=Z03R
-----END PGP SIGNATURE-----

--Sig_/uuDuslqJRgnKB4nKs8vpRAT--
