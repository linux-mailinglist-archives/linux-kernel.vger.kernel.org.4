Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB673AC98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFVWgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:35:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F0E9;
        Thu, 22 Jun 2023 15:35:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnFZc35zFz4x0L;
        Fri, 23 Jun 2023 08:35:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687473352;
        bh=JN1kcms81111psMFkfQWo50V4WOF+/7/R3pQAVnK1Ok=;
        h=Date:From:To:Cc:Subject:From;
        b=JzXrXT+UeBIjbEjROJ2ricFQ0CpgMQDJpUPt7vHoE0SK89cAX/ppgjvW8Q5+oyK3C
         cl3HGSOJBktXxC23SB08m3YqfUNaaDsOAZIOJYDPrh4195oJ9DNVFmn+rW/vnmHfV8
         bVaTF874sqnsRveu6Hy6Opx2yoPuZaVhoCO/IaZ1d5nTrN1K1ssmLu2hMRY719i6uc
         CO5BHvYCmoltwpl9odqADhaL0RW01+EhY637SpDXcYBoGgS8tg720YqTQlzUi9+k0F
         Q5g1cLeJMIJqWnOV5TC8vtKFCSYZV0VRjydpXeFlefjmBUz5QdGqWd5poCA3NHqhoM
         8FDBpWkrbqclw==
Date:   Fri, 23 Jun 2023 08:35:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ftrace tree
Message-ID: <20230623083456.1aa36194@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RLzkGyTBt13x6TzbtdexWgd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RLzkGyTBt13x6TzbtdexWgd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e46ad59233cf ("selftests/ftrace: Add new test case which checks for optim=
ized probes")
  bd2cdc432190 ("selftests/ftrace: Add new test case which adds multiple co=
nsecutive probes in a function")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/RLzkGyTBt13x6TzbtdexWgd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSUzMYACgkQAVBC80lX
0Gzc5gf/b01UAJQ7FArcNTICNAd9PJKPhLxY6+A6wj/IGe6fm4qIILR+o2rYFqrg
tgHcVuXUAHuVk0rwtlxSxSVETjTY+Xk1n1MU0VfyZ6uLQ5y6IeSd1U4r0D7cQF+q
o/p2zmHK5evOxjyi1o5ofTqF2TnY6NSYXlimRNiPyPahe+HT1jG1hBLLJ/qmX0FN
a5XLQnxFFcIYBamHLn2HERMaNYpC4tv+iMbW3yBzcPBfr1EiKQXugoaWomC56zEH
D98nlmUVvfxhQTk5evQgNzkKo+iMNHwlp2SuSsZ0jB1ki9KmT8uCepsUo7ASqy3h
uQJdF96ChAFqU2J1UrOFV/U+5ZT/gA==
=v15o
-----END PGP SIGNATURE-----

--Sig_/RLzkGyTBt13x6TzbtdexWgd--
