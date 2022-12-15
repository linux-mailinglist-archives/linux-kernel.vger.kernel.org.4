Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFF064D4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLOAy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLOAy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:54:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0130F72;
        Wed, 14 Dec 2022 16:54:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NXYfg1HG3z4xFy;
        Thu, 15 Dec 2022 11:54:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671065692;
        bh=ia8Ymw3ROH5HiR4u67oEvyWecnEiZN7k81GIdr7sbss=;
        h=Date:From:To:Cc:Subject:From;
        b=XD0r6z5rN3GyavNrF90Is7fzySKqcp98Durvze9tBes+kNyLUtnbmPEGdv1XBjDOP
         b0Gvj5KgYRNqaTtgSaScsUd9D8fcAc7gDAqwhD4uANUbsioU82DoO/4yEw+RAQgrZ6
         d/jCLhl0vDdX2vrS2BDCy43LUhZnm2kG2u51l2BYaHPKZCdurZNXWPlQUj6kXE2VMv
         3mAWuqwQu0bbwyBRhD0NHkUVO5UQyu+8aYZlAIsGk0CLmZEKjQzl7T2biuxvN7IdrP
         gUys+EexhhMgvTgLQ6o4X6evhzMyKRZbvu+qhWlomgsZ2yz1i2ge3snx7OHjxZAqMn
         xtFCK3peDaq3g==
Date:   Thu, 15 Dec 2022 11:54:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     minoura makoto <minoura@valinux.co.jp>,
        Hiroshi Shimamoto <h-shimamoto@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nfs tree
Message-ID: <20221215115449.71fa7b95@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VpRRwdYiJ5cqKWlaMRHphmm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VpRRwdYiJ5cqKWlaMRHphmm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  405ab45b5afa ("SUNRPC: ensure the matching upcall is in-flight upon downc=
all")

Fixes tag

  Fixes: Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same uid

has these problem(s):

  - leading word 'Commit' unexpected
  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/VpRRwdYiJ5cqKWlaMRHphmm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOacFkACgkQAVBC80lX
0GyXbgf/WHfLfSa8nTJcGdEn/Bwxm/szK5EORJuzCMZ+tUwlmBYvJE7HbtcfapX5
O8V3pmScdNPYtxkX5emWmF2EksI5C6qMks2PMUTg7y+ExFdz9x9MmywddCN32wEz
eIS9MAN3CyUxq7cEkX6wlfLuJmleUILrWAFBNXCfJ6saQv1wPjpg1smOeFdTXP7W
DD9bn/sAAbR1MVmCbOeGVmdPLpsEuDF4P22SGTkD2B9WIwiUtZE3i4PFbGM19U4z
n8R1AEuZoQEGKQi/pNDM8PArJ6PEfqkcM4gyU8sx9yTCcbm94pCRJVetz88Pq73/
SwenAjnXB/CMXoAP1R3pRNf+T4uYQA==
=iK+E
-----END PGP SIGNATURE-----

--Sig_/VpRRwdYiJ5cqKWlaMRHphmm--
