Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2B5F36E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJCUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJCUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:13:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FEB2A739;
        Mon,  3 Oct 2022 13:13:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhBqV30mgz4x1F;
        Tue,  4 Oct 2022 07:13:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664828022;
        bh=f07u+VMaFz1cjE2k6MuU26CyLCcS7pBObxAtKMKWbrg=;
        h=Date:From:To:Cc:Subject:From;
        b=Ad0MNFxFVv+HZdr42XKHXCpoopgR1STDuOLo2p5iol+/5AK71kZJ2Izgho8iaigE9
         GnacqX+g0Iu72tvO94jhpSO4SYpGEh35qHNj5+7C+9KwAmTwbfQIenQNckXDWppP32
         2Ado3txO5YtlYDs74TRtQ4cAZFuiM9mh3P2DZdUbWqXOpslcj5eqIEgmyjNJ7rQrv/
         4R7z3E6z7n6Ur48v9bJboT//dARQ3MYTWMeg7AXpbsCoZon0coE5TfDQfGxgpibITe
         reU0SAxNlnZVsd9/3JhoaW3KFVdlQjWOFR5o4I8Smw3W1XQr+yKI7R0bt97kkjRxjV
         PoWnpIIp2UlLg==
Date:   Tue, 4 Oct 2022 07:13:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Satya Priya <quic_c_skakit@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20221004071324.68a7ae58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fkExni8eQIUPUmhS86MkrA3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fkExni8eQIUPUmhS86MkrA3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  31e4fcf97130 ("clk: qcom: lpass: Fix lpass audiocc probe")

Fixes tag

  Fixes: 7c6a6641c2 ("clk: qcom: lpass: Add support for resets & external m=
clk for SC7280")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/fkExni8eQIUPUmhS86MkrA3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7QmQACgkQAVBC80lX
0GxZOQf/ZLhXr7PQiaRJ+aK88+l4LeWklPQ3dxx9TEysh2ZUzIpmASnNBLnRjL1K
0WJ9+2qeCjF3p3nE8zSmMuu/eJEZQex6KMZnIUW68avU0SXIFXHegf3m4TbgFj0D
52tmkhlHVcycQSS4N+PzxdNAZMflpHYVS5Zz/6VXPA6N7WzGaozFBC7kQVZqDMpJ
Xv0GEJ8akAL2ztCvJ3gYMb7Biuef7mka9CZQoRlHxvBu8qqIsFZ6S8RhSLVe340/
uGpB6zay5Pj3RRMtSxkU02dvwJsJkSVoogIrJIJKwzBL1xCoDuDNdlUnokuHxwfr
Cej1aUAFFVmaIUyc8V+1gOsSuKuTTg==
=QBMx
-----END PGP SIGNATURE-----

--Sig_/fkExni8eQIUPUmhS86MkrA3--
