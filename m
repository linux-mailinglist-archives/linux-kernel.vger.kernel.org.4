Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1787D734B23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFSEkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFSEkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:40:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A22DE49;
        Sun, 18 Jun 2023 21:40:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qkxrr0FL6z4x0B;
        Mon, 19 Jun 2023 14:40:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687149612;
        bh=UedWqHzVwDEeEU3XVUENw1rGNCIT4MDygwvxGOtjV4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=lv6KUU7MzLZsaq57H0W/MCBh9PHDP5zfUu7XkQmKMCUEchLfyw/Bs8cVz9BUbxsRR
         KqY+U2+Y5siXer+fF15/CSDFd9eFvRJqYA5l7PkuDLfZGhxY/FjrkleY3sEO1VcttS
         40zFww7OjAGudIoxxKY0CyrUiZiRxfSIDQIeVkpfv5n4SxACPg5Kfjdkb4gAQLsDik
         k81r1/Oma2OzMYTQWOHe0F7H9uWWqACDP7aLap/5mIgSNdJpwLN8H/SvYzf8oqpRLs
         54iUGZfddV04KhxhyKlFx2XnPEHXrtQpoYuHB0jjgPuQNKS1FSDoKICdx+OtjCd8WE
         3zM+wvCF1aTYQ==
Date:   Mon, 19 Jun 2023 14:40:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Networking <netdev@vger.kernel.org>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shay Agroskin <shayagr@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20230619144010.6a767b46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lDYUkVU35896U5Vv60GJ7Bt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lDYUkVU35896U5Vv60GJ7Bt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/networking/device_drivers/ethernet/amazon/ena.rst:209: WARNIN=
G: Explicit markup ends without a blank line; unexpected unindent.

Introduced by commit

  f7d625adeb7b ("net: ena: Add dynamic recycling mechanism for rx buffers")

--=20
Cheers,
Stephen Rothwell

--Sig_/lDYUkVU35896U5Vv60GJ7Bt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSP3CoACgkQAVBC80lX
0Gwr7Af/aV9NkukPjtGkeDgM8B6F2s1ZLByeaCR0aU1Ae3vOdTLNMwWJgUwVG50a
KY698rjpHwDiQfcxmomX1GDz/OjeSOgUEZEwktGwyAjRcjAgfacbuwdmdw2CZqEx
yKyD8s9AaPgOWhBixFeXauxX3hoQ+5nWcOLt/mZ73+SUJEaQfej9ay6eCbkxhOTk
2bgt7UOx+bA07nB/aVQkus4vvFcpV+IeDXrFy1ndbpL8l9etuWJyr83LoccoeRfz
0RtYztDPC8JjEGszLCa568YxD7SLhxPHaSWylLQKr6FisJTbYM/MeWgXrB7W2mxI
Bkr1XPB2R3/kfKw3vY47Ao4ONdKVjg==
=xEIE
-----END PGP SIGNATURE-----

--Sig_/lDYUkVU35896U5Vv60GJ7Bt--
