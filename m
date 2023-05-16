Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86B705AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEPWlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPWlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:41:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AD6199;
        Tue, 16 May 2023 15:41:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QLWS76r7Sz4x1R;
        Wed, 17 May 2023 08:41:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684276888;
        bh=gWlEvzXLzpBF9MFux4TfkINKyaL2YbDtBYpWGyZsv14=;
        h=Date:From:To:Cc:Subject:From;
        b=IwRuQw3Ev3O3QhlacdJQxVgkR4/gvP0B3CmdTjBWq4tBpjv/R92nQrbdpCzHUn6t2
         /uGkQngiGf6MJAQU4ulyqKTB4VlHuUX698IS65K4ATfneHLLxqwM4FeFloyRIJ27VZ
         OPt8fQeAYbvgs1jIY1sgFIeMDZXlJHfi9OPkopf8rybZL+7zDAKfymzimLLY61luFn
         f65DNNdlB3DdubxRzbg57CrjCmw+8ce/C7eMl43XjRaU0PRICNIq69XJ/RNYB+izXt
         +8HQdPzS7wvm71Pu1+TkvI+SXyNnRiSN/+Bwstg5fcjJT0AuW6cBdbjUzfcsPyjfvm
         Eg+SHeNAKruCw==
Date:   Wed, 17 May 2023 08:41:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20230517084116.17be78d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6OTSmgYD0xnjKr6XbxImHLA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6OTSmgYD0xnjKr6XbxImHLA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  1d29b558483d ("tools/nolibc: remove LINUX_REBOOT_ constants")
  09efff85e556 ("tools/nolibc: add testcase for fork()/waitpid()")
  d9d16cc80854 ("tools/nolibc: s390: provide custom implementation for sys_=
fork")
  c792624d254d ("tools/nolibc: validate C89 compatibility")
  d7644912ea9c ("tools/nolibc: use C89 comment syntax")
  9cd4e2eb852c ("tools/nolibc: use __inline__ syntax")
  367742887f79 ("tools/nolibc: use standard __asm__ statements")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/6OTSmgYD0xnjKr6XbxImHLA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRkBowACgkQAVBC80lX
0Gy/+wf+JDyDOKREdVclX3IuAxObLvEggRwfJbMrxxj9BZ1cvCl6H9FAjC8Ekh5L
mmjI4fbgXQ5POTu2e1lDnmRE2LFrdVuy6Dg/qAfxC3sxmv8wHlMFU5ykFT8gSlpP
bzl+DkmeYGUwMFVH2CDU1iBgaHtfzJdsYUETEC1XsXUFPYsSbE+bAUgJnzLl2Q7S
AtKXKB4ivMTj4jA8pytSkH5Hn+/swN5lGxLIpX3n1OTR5S7bH2Konvyw4Q6uB4xE
elxssmRHAqVih3unHW/nZWLUPynu9z3r1geEQCp7oRvhySW+6yN9eRKXUd86E1lH
9EMPaNHFbcDSn9woyn50bFwTGhp4eg==
=iQi4
-----END PGP SIGNATURE-----

--Sig_/6OTSmgYD0xnjKr6XbxImHLA--
