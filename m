Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C56687D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjALX13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjALX1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:27:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E3625F9;
        Thu, 12 Jan 2023 15:27:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtLL55PsMz4xGM;
        Fri, 13 Jan 2023 10:27:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673566029;
        bh=BVd52yLrn16khkBwIsfEIF/zKuvt6cvgJVNhs4NQSwI=;
        h=Date:From:To:Cc:Subject:From;
        b=goarOPjhscYlxIGJ1iN1mBm/gK6rFT81Je+Vlvuh1dMAHviGptlc9YVyDYbcns3KC
         nqB5V0xCxUIvJ1/+eXnK28YaaR5Y4erWOZYdijIUNNa5zaEQ7V31x4UBeOS7LhDAxu
         +4lDUOkDjpUCwTw2hxY88TSI+WvGMRo7YWcLlRfvPt2mKI4YCmPtYdv+PssIJw1L+q
         jHQOovy/DljI7dJgP9n890lyhsV9tapKEBmpaUBTVNV9ajalF/OwdXkD4bAtkLjiIB
         cRlqFmeFUp1fEioYv3bq+T5HGffMkqq6qXGoEmYo2cpDSCsmCn2A42887VMH5pAT8o
         Nvx5xXo/pCdmA==
Date:   Fri, 13 Jan 2023 10:27:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230113102707.649f0938@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=/IeH0cltQ23kE9yT3.aJ3p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=/IeH0cltQ23kE9yT3.aJ3p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are duplicated in the btrfs tre and also in the
btrfs-fixes tree as different commits (but the same patches):

  6d3d970b2735 ("btrfs: fix missing error handling when logging directory i=
tems")
  8bb6898da627 ("btrfs: fix directory logging due to race with concurrent i=
ndex key deletion")
  94cd63ae6799 ("btrfs: add missing setup of log for full commit at add_con=
flicting_inode()")
  16199ad9eb6d ("btrfs: do not abort transaction on failure to write log tr=
ee when syncing log")
  09e44868f1e0 ("btrfs: do not abort transaction on failure to update log r=
oot")

and

  18c166730923 ("btrfs: fix missing error handling when logging directory i=
tems")
  5c7eafa405c4 ("btrfs: fix directory logging due to race with concurrent i=
ndex key deletion")
  db260d6a0abb ("btrfs: add missing setup of log for full commit at add_con=
flicting_inode()")
  ab6e0ba0377d ("btrfs: do not abort transaction on failure to write log tr=
ee when syncing log")
  40c7d0525fcd ("btrfs: do not abort transaction on failure to update log r=
oot")

in the btrfs tree and

  8ba46a395c7f ("btrfs: fix missing error handling when logging directory i=
tems")
  46fc636870f4 ("btrfs: fix directory logging due to race with concurrent i=
ndex key deletion")
  52bd17801bcb ("btrfs: add missing setup of log for full commit at add_con=
flicting_inode()")
  3d223cb5a2f7 ("btrfs: do not abort transaction on failure to write log tr=
ee when syncing log")
  b8a4b882f62c ("btrfs: do not abort transaction on failure to update log r=
oot")

in the btrfs-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=/IeH0cltQ23kE9yT3.aJ3p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAl0sACgkQAVBC80lX
0GxMHQf/SSIuWpVpm3aOAVFEFkrVknESXUCcuY0rObI0ABp42+3XonokWn0+ruMf
BiaIZrcxBS4r4GXfgC7fxcLZOUaU67B5yFqV9uxE4GpVqjyJ3eSbH73fkHioVnNf
Ogz/br6QmUq7EBqB7PDUJCMmY33nrPSjd1J9w+OOiSveIuVLf5ui3BxAAp1Dg+KE
7DXFnK2eiSNbHFpMbdlP2MF6vTtt8b8/XpQBHppNTi84LqTezGhSd2tSZv2hOrsP
R38vVeuVWWIEXJGOJWHWuiRb3TZghsn95FjzhjK0kq1NRApKj/HOpX32gEiqEKQU
tS1YAcEb2qGN/F3tkXON39KlzvUyMg==
=jZ+J
-----END PGP SIGNATURE-----

--Sig_/=/IeH0cltQ23kE9yT3.aJ3p--
