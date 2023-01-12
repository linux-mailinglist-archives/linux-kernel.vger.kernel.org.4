Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25476687C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjALXNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjALXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:13:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E5116497;
        Thu, 12 Jan 2023 15:13:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtL2H6Y73z4xFv;
        Fri, 13 Jan 2023 10:13:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673565208;
        bh=ZpCTLXLyZCGUdMemrRwjTF4MJrRYP48nksGqZMKW3qw=;
        h=Date:From:To:Cc:Subject:From;
        b=T4rr4iZh3QiBfPRS6e+xP381UO1j0QiHfZwRGbeApEh0dvbmvyYE+I14zXVLqX+pc
         KFywY3zGUe3qadJp80lZfBoerFnexvf4tzgdGoa9weZxNp7CIlpFnZ5FKiDYsl/PeD
         f3Gxgym/IHj4SsIkehK7GSdCucRB3z+RPO83JDAALKssh5/IE2zt15tgi8c1jT6z11
         rDbUwefLh5E88+/OMAOd8/HzLvTgHxPQrBuzX4rXP3NdMEIPNUSKz3GpDz01bhXGaG
         trOiKEGo3hQYnhls65jdInE/GtXJtTAkG2YO/70GVTjof7K4xA/gmg2x0xPCrfHuC8
         k682sKAabEshA==
Date:   Fri, 13 Jan 2023 10:13:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the nfsd tree
Message-ID: <20230113101326.09b1250e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TzyfR7q=f01ZLmIuEDuPCvM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TzyfR7q=f01ZLmIuEDuPCvM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in cel-fixes tree as a different
commit (but the same patch):

  3927ac397479 ("NFSD: register/unregister of nfsd-client shrinker at nfsd =
startup/shutdown time")

(commit f385f7d24413 in the cel-fixes tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/TzyfR7q=f01ZLmIuEDuPCvM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAlBYACgkQAVBC80lX
0GylKgf+MU0tHxgJZlBol/tRRFnZy0eKTBXFG/phQoFJ0astz+QCvGhdZIYGGQW8
/wyK7WfhXSNtorR1miKsUZZC/HZQMAzpzROtuoypleEIBDa7V0Qc10NEknFMC1if
EMBVWzlzcKfNM5z/2H6Bdj99aZP/cCBANHAoouMH4Ie52tMVTDr/oZ/e40YJl6up
Wn9zE5+KRjEjFutISm03cAAqTU+p1ZFDeP0I7PjzOQrq8OFCYuHLVbeG1otl1WAh
9CJ6Hdz4ttg90lVZS2JlsQvaCdGVb+VYShD7Sh9Y1tlPhlDpqeAwXnnNQmIPaI9J
mFnimIw4MjuHxL0xE6MxnzkdeAUabA==
=9EmQ
-----END PGP SIGNATURE-----

--Sig_/TzyfR7q=f01ZLmIuEDuPCvM--
