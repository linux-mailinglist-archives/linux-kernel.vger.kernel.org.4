Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB96D7119
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjDEAFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDEAFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:05:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A912D61;
        Tue,  4 Apr 2023 17:05:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrlJY4Q2jz4x1f;
        Wed,  5 Apr 2023 10:05:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680653133;
        bh=CxeEQoQ1NPQdPcIGTFEuLHuvL9vtKDomzrfTJ6px4ss=;
        h=Date:From:To:Cc:Subject:From;
        b=fIXcMl2ELMrcdoghUi2Mj5reG9VqfzUAy6uY/pOp+mbvTScV+T7GjC1aURKllCJSN
         y1u/TdDDnGNZORWo05pNYSnSw07607/7J9mwRfFj2pvM4K7uExJimprUuFcn8gBdhf
         ouSjmpjkcfhpqiM3pDgkN97YmpmQIOq7OOKGgnoQTVAyoXow1RFs4tVsUfPLMgknIV
         PP3YsQsIaHqxbuCuA3yR6RJQ1M3haRaKf5PPs0KzhSpc16axPvawtJKKvm7jHZJUti
         7LdfxoEPFVg6kL+Aj/AP4oPK+yM2I+E5F8XQfk6VT3c7jE+E5QP9uH6nJygTGyyQfd
         BGhMeQQZPCI/A==
Date:   Wed, 5 Apr 2023 10:05:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error when fetching the csky tree
Message-ID: <20230405100530.0d82fdcd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GUSHen0OtL_TQAW0QN+82aE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GUSHen0OtL_TQAW0QN+82aE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the csky tree (git://github.com/c-sky/csky-linux.git#linux-next)
produces this error:

fatal: couldn't find remote ref refs/heads/linux-next

--=20
Cheers,
Stephen Rothwell

--Sig_/GUSHen0OtL_TQAW0QN+82aE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQsu0oACgkQAVBC80lX
0GxK7wgAkLiKdkp5Goi1q64Zt+Qv8HI/laLU4cVltUof+nYS1H1eTNPboaZqlfc5
H+sO+MlQ5VP+2G2c6M3MCMqWJgTUhDmgx5J5TuPOT4JRQGmMXbWrqZKfnHSmhJY7
Zbhts5q324gIharDFnkNASUFCQaJF3ihs/dnhgDTRFtYPclZ+ETyvsS9eQG1nmmi
st+dNWrnqDZVfbymx6xfKZZQ2P/jlJS7+n2TCKkRGrQYUqGk06ncWIclADCQIk8s
PTY7/YGFZhErC5JKI1sLla77sfM++EhZlt0mNyL3OCAMYguq8wO9oniQInqMUSHL
amsRBn1y1X/dr3WD59SlmuTQqi7YkQ==
=LYBc
-----END PGP SIGNATURE-----

--Sig_/GUSHen0OtL_TQAW0QN+82aE--
