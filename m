Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAEA7154D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjE3FS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjE3FSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:18:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5DF1;
        Mon, 29 May 2023 22:18:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVgfV0MK1z4whk;
        Tue, 30 May 2023 15:18:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685423922;
        bh=/xSsDPgKRFnZmreVQx108ZSuejHZYmnG6yH9EIIZE0c=;
        h=Date:From:To:Cc:Subject:From;
        b=NV7/yVyaiuluX0UPH5MAuMtz2J+jb5BijVPaQp0XAAF6rOWsdyte8tABSFuj2HJ6l
         dSD0+hTKoQcj1B0BakVSKmv0WgkYMLbNGRtrj9mlNO/sO4qmI6JmDNZiXrOMJK345U
         d7Fv+aOtJwjMxvcnmxcKbE3jde1GQ2JHw4nOMpc2K6o6AFl2hmPODoWCROQl255Ix7
         U5tsPk/oswz9fGSV9QmJTFOPpH1c8MHa1zAeqEpDRgiUpHWm0TC53ChSXQpmW7sAkN
         3N4t0RqkUpI+93rxkdL98rdmVy3GTyeCORf8Z0n9enHuaPWCQiQU8tMliUoe4R1NTj
         DjwVfhhLy1I9g==
Date:   Tue, 30 May 2023 15:18:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the kunit-next tree
Message-ID: <20230530151840.16a56460@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z97GC0.WVOyDlDTJ.VnkWDY";
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

--Sig_/Z97GC0.WVOyDlDTJ.VnkWDY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kunit-next tree, today's linux-next build (htmldocs)
produced these warnings:

include/kunit/resource.h:413: warning: Function parameter or member 'action=
' not described in 'kunit_add_action'
include/kunit/resource.h:413: warning: Excess function parameter 'func' des=
cription in 'kunit_add_action'
include/kunit/resource.h:439: warning: Function parameter or member 'action=
' not described in 'kunit_add_action_or_reset'
include/kunit/resource.h:439: warning: Excess function parameter 'func' des=
cription in 'kunit_add_action_or_re`set'
include/kunit/resource.h:457: warning: Function parameter or member 'action=
' not described in 'kunit_remove_action'
include/kunit/resource.h:457: warning: Excess function parameter 'func' des=
cription in 'kunit_remove_action'
include/kunit/resource.h:481: warning: Function parameter or member 'action=
' not described in 'kunit_release_action'
include/kunit/resource.h:481: warning: Excess function parameter 'func' des=
cription in 'kunit_release_action'

Introduced by commit

  b9dce8a1ed3e ("kunit: Add kunit_add_action() to defer a call until test e=
xit")

--=20
Cheers,
Stephen Rothwell

--Sig_/Z97GC0.WVOyDlDTJ.VnkWDY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1hzEACgkQAVBC80lX
0GwR1gf+KHyLZqOCE80syhvK8Em5IjMaxIkLhYnA/Ony4XYQQpa4wUaVfwM3LsE8
uynB8bKvZ46hTI3L0NugYi9RcUpBtXC9CPj6bALjUYTUzEt9RQv8tjBW47cRNiMF
+VXKK1Klii2qfttJXBgunia7eplgC8MEKpfc2/TYmJC9v9keABzBCINQKPzwd5t9
jCWh+XrRzzqqDIXXK7eG//eY5A7KuIg1ACSbYhP5aqOjjPbrNd5ZaRAk3QHLJvI2
lK+T+JUJ0wCgOvRH0OkPFc5wfYiltG1cMGh3hxlya/wQ+ax+kay/Gd+/egdMmkJ9
azXKozxgSukwh1FQHNp60d/JG2G3Iw==
=/C3M
-----END PGP SIGNATURE-----

--Sig_/Z97GC0.WVOyDlDTJ.VnkWDY--
