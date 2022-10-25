Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2860C2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJYFCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJYFC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:02:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016CE8D0DB;
        Mon, 24 Oct 2022 22:02:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MxKYl013Rz4wgr;
        Tue, 25 Oct 2022 16:02:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666674139;
        bh=a75qkHvPUCMp4OJxn1P2p6w6Viyt4i0XOUjc/KNvZUg=;
        h=Date:From:To:Cc:Subject:From;
        b=gLWwWcSnFCYzPCyU0XeNvBrPnj8EtkQXCGpKWLqdX6vB62+FAJLljlE1mcMpe0FF1
         ETeTdrsecz2HrXF7TohYa/Pld5cVwqOjr8aoKh3jqyPIUhgCIBnaJgHUL2rx6LEMmN
         mfIbFFewsXEukHZM09nS6h9x8nAXFW7dzjts4x5gUqtZT1qBPTKVSa1SiIw3zWGshc
         T1Sax3xUpclwDFalBqVzkozuek2JstmZr5kHG592kXnZkHfGQSLdHeGmc2KT4YSQZi
         cj/0kF33Hml4CvUOOVNKskuev4UAgKLsK3jh80A9GU/enROfph+zX8kbYnX1Vl+eG8
         oTWtPEFDy5G0g==
Date:   Tue, 25 Oct 2022 16:02:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm-hotfixes
 tree
Message-ID: <20221025160217.309405cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZOy1_XmJFbZB5kYR./Q243v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZOy1_XmJFbZB5kYR./Q243v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  93464feb6cd9 ("mm,madvise,hugetlb: fix unexpected data loss with MADV_DON=
TNEED on hugetlbfs")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZOy1_XmJFbZB5kYR./Q243v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNXbdkACgkQAVBC80lX
0GxXWQf/b4Eqws5yGKJ/FYgLI1ZpNVrdTxdKnC5ppwYv+YVeZBYnN3KQai4hIpHf
L8KWQ864ML+gmr0nU9ZXuZ+Lo0Z5wFUm8itOKTb55Fapn/0FciVlsKhd6igkRtQf
uK5WDX8e+iRfHP/iF5avuNGdKdh0ANTVZuqBq9dqJ7NKBldFNUpGz4A7759DTSiE
TdTPunWitLRMOT2Ch7vyez0fTYKOiftsXINf5N8ST5x9siWCWGIl7ARTokHoVdZM
hI3+Z1gl2anzyyWaoL6oNISCunMfkpJByuyHhWAQrntMLT8BulHizHyyI8qtXmBw
au5MtrglMXwoBjjx/75Blgb+DAxN7A==
=gdRF
-----END PGP SIGNATURE-----

--Sig_/ZOy1_XmJFbZB5kYR./Q243v--
