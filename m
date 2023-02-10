Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63294691548
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBJATp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBJATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:19:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB75EBE1;
        Thu,  9 Feb 2023 16:19:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PCZ9m0PLRz4x2c;
        Fri, 10 Feb 2023 11:19:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675988380;
        bh=RW2QONuQVdpsfXZg/0ZX6TGrjsOqMXZOJfs41NjdL6o=;
        h=Date:From:To:Cc:Subject:From;
        b=RnzNyZHaF431b+d6KiIydtRV9OH508NCsZUCCY6rESiotpUOHaLY6WtQxJap5MAZv
         rOVocBt9B6HdO8J/b/V1FBNraBCHDAbK/tgPcK44a2ptd2i4+bbO2lFQCDSh3qTHYK
         PHKl1EjD5ZNi7HQ94u3n9/EsGNCSY1Jmxml7T7RrJjOflAwaSxcsaiWXoN3qB4SzDR
         cSC+u2k3P8CMHX5QUI3IEpXxpHFEFEyw6SEc1okowbruiA7ppmBRhgGaveWwgm2m+z
         d9mMm/m2pBa4fL+flOoGATqsT2OquIzrxfwsxKEe0Rb3hM/PY3cVA2rt7h24SAL83f
         PxELtkBLPYoiA==
Date:   Fri, 10 Feb 2023 11:19:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230210111939.5501db82@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tUeOmb6jJq.dDTxXonxyYY+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tUeOmb6jJq.dDTxXonxyYY+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  e3de4d370ecc ("btrfs: lock the inode in shared mode before starting fiema=
p")
  0a9c2c0156f2 ("btrfs: free device in btrfs_close_devices for a single dev=
ice filesystem")

These are commits

  519b7e13b5ae ("btrfs: lock the inode in shared mode before starting fiema=
p")
  5f58d783fd78 ("btrfs: free device in btrfs_close_devices for a single dev=
ice filesystem")

in the btrfs-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/tUeOmb6jJq.dDTxXonxyYY+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPljZsACgkQAVBC80lX
0GwncwgAn1rCcMsIPx+JgOwHgYssg3zm901NsuhuWQDoyQyOKvBEjk4ZkfFqDk/Q
8Ki6Gryb9wkwyRFKW1EzdOkl6FiyPAv7IoQxcAppbpYmAg7TnsOcjaZZMj1q1HsL
AFmLVyV+S6gTqte08f03dg3pXh5ofX/M+kLD7gJE2tRF5pXKtaimve/nr8Q2j0LC
N7Vem4HFLTWh2BdZ2W+8/lhMCZTYyUwRKL7VCa2qFEY7Yo/tulpGgJHLpp0DwNnY
tx8DdwM6O2pZpWmswxY1a+KdztM9INi0G3Zdu1S7AbqvgQzgaL5Ws04+9DHXZ6I+
y8mIOxYjnuWUZjMiP/fJ1o9zlwRcPA==
=TVav
-----END PGP SIGNATURE-----

--Sig_/tUeOmb6jJq.dDTxXonxyYY+--
