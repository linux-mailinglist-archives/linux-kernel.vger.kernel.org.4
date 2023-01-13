Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B28668821
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjAMALc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbjAMALN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:13 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6BE5DE50;
        Thu, 12 Jan 2023 16:11:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtMJm1206z4xFv;
        Fri, 13 Jan 2023 11:11:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673568664;
        bh=+2YmlJZdaCngfrReynHEQsvpEbHrVrAfqqyxpJoyi9M=;
        h=Date:From:To:Cc:Subject:From;
        b=FVwH0lxx8Rpf9rVBVGnilJ3LdbKkQUjtc6JPEO/E4LMpYUYup1W4b2SBDt8w02Osz
         FEFmfMfkPmrDPr4T3cR/Fec3poJdNfuaGbzJMKRN/gATDgq5CwehoWwip94qqUtyUX
         Bl9iWizJAv8a4tUqOQDvMjPkuaJT44EgayW5NWby6NwK3hvy8Tigon+nrObGPNLSRu
         1HTcgwknuJkNRzxyR+5nq1SzNx0CymmEWUid96BMAiiD6GE9GfAhdLLa/mCewxgC+S
         7RroiegNL72CENDsDAlZcOS4Fn8T3etGzYx7NbrxIDIJy6ySqsGj7eRRGObrSz5Wiy
         sEtUvKGH+upQg==
Date:   Fri, 13 Jan 2023 11:11:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the jc_docs tree
Message-ID: <20230113111102.22a27ae3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s2t4ltoAs/nNi7wffYyGNHL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s2t4ltoAs/nNi7wffYyGNHL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm-hotfixes tree as a different commit
(but the same patch):

  ded24dfdddd1 ("Docs/admin-guide/mm/zswap: remove zsmalloc's lack of write=
back warning")

(commit 1beb8ae302a0 in the mm-hotfixes tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/s2t4ltoAs/nNi7wffYyGNHL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAoZcACgkQAVBC80lX
0GxrWwgAoLbhUI8y3joMj4GtTx/2nTe8qYWzNflob8+1bPg97sMJGFbWcd0ce9ob
1dQjX8Om88Kif8F14ooNr2cQb5CT+IZyLW5HRcm4WEf8s3j/AArNo6SREs0iYtBz
menYVWjMTc3Hq2rfbRJB9MF21R3mtZ5FPLYsXa8bNQZufzCVDwK/NAtIvSf6cbzW
fMqdBxmk3UyT8iHofvvC1sPDSJlUEcoEva4BUaBv8AHcvyDBTFineMUpTUNfcQk1
3bBRpHPLH1oIcFbN91ikQQPDfqPqL04XvZBe3Fc9OoMo+2VUszlCuXAsSKYAVq3O
omV4nDFwvCNcS1Uev35oI5Q2FLk0ZQ==
=roqZ
-----END PGP SIGNATURE-----

--Sig_/s2t4ltoAs/nNi7wffYyGNHL--
