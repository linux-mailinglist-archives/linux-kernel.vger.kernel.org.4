Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9D661AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjAHXLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjAHXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:11:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F396B4B0;
        Sun,  8 Jan 2023 15:11:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nqt9g28Grz4xwt;
        Mon,  9 Jan 2023 10:11:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673219479;
        bh=Hk9Ij+fFY1uMcI3w+I6uUUc0waV1UtTYt5YlQemWLP4=;
        h=Date:From:To:Cc:Subject:From;
        b=We+tYcoZUdFZzYudaanYobhftkbfuXiZM8zhDhDFb3TQxll6/ejCrjz1O3mPiezRA
         FiDSVFkf8cQZIp6Scg0kANR2/PnV7NM+spuBKjFSLQ6SBiju4+8esLJ6Q0SNvfelOv
         KUACt/3PHgrVuu/sCJutnXHqKMKGG0xyOw+g8DUDgQ1Ol1RDeLzhFMvip6mSKpzAqb
         6wfoBdY/6FttPb1g9Eg+qvVh9nq6/MzW2FnAP1gxT2LnqwF+Q6GZOvAyfKGOcX+zoG
         R11NoFaqOaikStDprquUWbunHjrPMy9ZBt6gUiQmrPZTxG4VVnoraoEZ2pFMTmLBVB
         P4uLia0HKCp4Q==
Date:   Mon, 9 Jan 2023 10:11:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Teigland <teigland@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20230109101117.2a55e070@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KPnWRhFMc8C/egj09LM85i=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KPnWRhFMc8C/egj09LM85i=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the dlm tree as a different commit
(but the same patch):

  2674cc2403f8 ("fs/dlm: Remove "select SRCU"")

--=20
Cheers,
Stephen Rothwell

--Sig_/KPnWRhFMc8C/egj09LM85i=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO7TZUACgkQAVBC80lX
0GwXaQgAnbyCCzKUE5kDLoy3yThjqTHTjS9P2kE81CwkjhiG1OA9W/D943jTEghZ
scgN2RJAVzcOB51CuWPOwrRcX4omypkfo8jqxE5uIRE+qHve1DuggjcsT2xn58OQ
K0EwS4aLmxpi9Knbl4DoTdP8FYPLands4blnMG5ztgJ1crrFt+b+MxdPflX2waMV
irujVSNXfKDBM1pNDGQkamXXOCRVjHWLOFD8mV6G1TBWt24TJWIBw8pj/n3v5gsu
1D8dbtRmg5MjEDQlLk2PRprDyqdSBIsSZcoSnCoNlDTdTQsIuTnNRczm6GRcgwWG
C0S4EQ7WWkrHB+tnw8bcvCiiQN4RGQ==
=XckQ
-----END PGP SIGNATURE-----

--Sig_/KPnWRhFMc8C/egj09LM85i=--
