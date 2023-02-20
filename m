Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3469D720
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjBTXeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjBTXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:34:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA974A5E9;
        Mon, 20 Feb 2023 15:34:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLJfX2c7Zz4x1h;
        Tue, 21 Feb 2023 10:34:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676936068;
        bh=PZ+QHxDFdbxKxNJEpTxiivJARGFLCGlmcuBS0i+RWZE=;
        h=Date:From:To:Cc:Subject:From;
        b=ZzYhV+Oi+IIP7tknCcuMomwXr2PxqXR0SngnZrBj7PgqbwvJjzH7Muc4I7Nft7o2y
         mClDcEiSIxlhcyrg+vhchJpp9zgj94Uvqy9jeX5gy1yOBP5q+NlZ0VVuJpBkZye/pG
         XYODg4kGFyN3i/0Mg5BRdRFI85RXRWE+33T04kfArTUVDzVG+or1V6B3UWD97j/g4h
         tb6rpIgQPLqK26Oqh6hG3dLu1rP/jpiUYDAgZY7Ai3hQmjjHFa16WczRyRMOZCA+TM
         +kvogT25ds19vcEH930vdTGzv2lkslyNybYT2GqigOtxjcyrVFzvTIKE2hB+17O171
         W/kxUKokPPl/w==
Date:   Tue, 21 Feb 2023 10:34:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the cifs tree
Message-ID: <20230221103427.2aba1c37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Tm=1v/2bKj0CpDGqP1y6uQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Tm=1v/2bKj0CpDGqP1y6uQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  87788bad1133 ("cifs: DIO to/from KVEC-type iterators should now work")
  043e4d17b6b4 ("cifs: Remove unused code")
  3eb2bd2275e1 ("cifs: Build the RDMA SGE list directly from an iterator")
  6b188cd64831 ("cifs: Change the I/O paths to use an iterator rather than =
a page list")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/.Tm=1v/2bKj0CpDGqP1y6uQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0A4MACgkQAVBC80lX
0GyqDAf/cojNQ3Fhk994BtCW/PtJ0EIpWYoes8E1y8RdTQlgWtfEbYvXAMQI2oD3
FYp+I79cvrPlRtXLmdIeXZS0AZIslKqWMCZwfrCKJWKj+WLBWIe2nMS7sorTJyIM
wRVDoQwZnOgTOrSaR7biVunLLvdOAuNrjoFRXSJO8upRmciYW60jvI7MGmq/krbQ
yWdMPGD0USOtBwInPSl9fXpr0C1VDPPQlDRbnlOt1FtI4bjevlQBzO0hay4/muG7
HJb4A/igkoFLBrZmUEXc4LN+s20bWhXpdme6CNIAU8ZDbmXNnGZHD1mf7fhu6wwe
4UDyoTNdKFFXZTprLFdUcycOW+fUMg==
=ToTd
-----END PGP SIGNATURE-----

--Sig_/.Tm=1v/2bKj0CpDGqP1y6uQ--
