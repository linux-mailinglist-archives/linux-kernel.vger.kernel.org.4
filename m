Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5ED707728
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjERBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:10:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEEFDC;
        Wed, 17 May 2023 18:10:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QMBhz1Lltz4x3q;
        Thu, 18 May 2023 11:09:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684372196;
        bh=bpLR1JG+REMPmB/I15ynrXTsfn9WEHkjNl9gymUgNdE=;
        h=Date:From:To:Cc:Subject:From;
        b=Ryhs3eHU60LuLT9WNA235EQiGtsWI1YXgt8wmsirm4yoKNnt/aQO5PgiRAkbrwNTw
         emjlQYK5buFUPiil7IW4kFuQb4qrNAsq64mdwKeWDQghUaeGsQeqAJzdGk31CH0DdG
         vOwQ2p4yGC+yr0/EOMOUI/PTJxBxwqLXDIxSPoeF/DoPgFR9/W2+AEpeduLCpFh1Nx
         73aLF+y3Ve8clT3JjyWfjNNpF868U1TziorjlHJzbH7zIwMduZhmYBGgp63J8yJwE/
         J46FQEwjBof7hbSPVMwxA1cIG35hsLKl45wRngfTnLQ5ntCqVZYYYo0VNe9BCKAa/k
         oHoi3nUyr9aTA==
Date:   Thu, 18 May 2023 11:09:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230518110951.275fd5b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iZiXqwm3mni8nNT1MWilVuh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iZiXqwm3mni8nNT1MWilVuh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  192c01142492 ("btrfs: handle memory allocation failure in btrfs_csum_one_=
bio")
  7ebc3af5dcc0 ("btrfs: handle memory allocation failure in btrfs_csum_one_=
bio")
  458e1ab626a5 ("btrfs: use nofs when cleaning up aborted transactions")
  5e66bf75ae50 ("btrfs: use nofs when cleaning up aborted transactions")

also (as you can see) they are duplicated within the btrfs tree as well.

These are commits

  806570c0bb7b ("btrfs: handle memory allocation failure in btrfs_csum_one_=
bio")
  597441b3436a ("btrfs: use nofs when cleaning up aborted transactions")

in the btrfs-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/iZiXqwm3mni8nNT1MWilVuh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRlet8ACgkQAVBC80lX
0GzeRQgAiZKPFmR5rc7ph8zmXyz7M579mzJNZjhV0I3DjsbAMduV6J3xGF8vdHQl
E2pZ2FpStEP+cAO5xZ+wpatcCfBNJ7Cj5gq7aA1Jsh12hTqfvItUwGYYFis/fCMg
abwJCKMWBcIjAEGoh+OC+1LFxsHETYKTbh2w1FIHbKofhKoLpsVtqWCbUFefJ2GD
LEv7vf5yXqr8NRC1DPhkMWhM2Vq08YKMHtNa4As6CeJSPOHQsr0fjlBrrKlIrhjM
MEgPZSYJOJ9zZuL2kcX/h5FbFumrZbXsluCRPHKZeh9Qfq0qb8ak9janQ3F2q+UX
6ppOh/zbm9j5ItPmlwcNTaAYvP2JIg==
=uYNY
-----END PGP SIGNATURE-----

--Sig_/iZiXqwm3mni8nNT1MWilVuh--
