Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9766A11CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBWVRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBWVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:17:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E83227B7;
        Thu, 23 Feb 2023 13:17:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PN5Sj2bYXz4x1R;
        Fri, 24 Feb 2023 08:17:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677187029;
        bh=GOIWu4F1ox/SQ0BpKrTG3ZlwFPuONgIGhNvvvaZjcQw=;
        h=Date:From:To:Cc:Subject:From;
        b=ae/98p9/yhKRZENg2HqfhseA8QjoRiTPMJTWpD/rNcn7l69ddGbaMWwEOiyIaK+oL
         +1XcLYz3qr7P9RC25erpL2yjQOXq3y69KZPGjy5GoILgoNsGVl+UqCLDfTLc9K/+6J
         uXRBPIL3dwWRaglOAmB7dXSWx5I8VcI5fZdY6BHBTwXLNRhfESQxoL8BLVPEcIZhVe
         GWIbibO9cv9eJmXXaeQXxNaWHBE9psbyhj8pNt3O0YyNq98nJZYxOiqSGBAZX/eTFF
         ROCUYfzb9u6kmDq4FPdfQdOAfpOwCA6m/w+TitIo6m1qHoqsTxG/nY5HxABBqbR5wF
         c9JMG+slFsyGQ==
Date:   Fri, 24 Feb 2023 08:17:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ktest tree
Message-ID: <20230224081708.383a5e57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+qVirCkQTXy/s_AN0jwVbiK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+qVirCkQTXy/s_AN0jwVbiK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  bbf45b2ab467 ("ktest: Restore stty setting at first in dodie")
  aa9aba938288 ("ktest.pl: Add RUN_TIMEOUT option with default unlimited")
  5aa3b79933de ("ktest.pl: Give back console on Ctrt^C on monitor")
  fa77cb30e4a0 ("ktest.pl: Fix missing "end_monitor" when machine check fai=
ls")

These are commits

  7dc8e24f0e09 ("ktest: Restore stty setting at first in dodie")
  4e7d2a8f0b52 ("ktest.pl: Add RUN_TIMEOUT option with default unlimited")
  83d29d439cd3 ("ktest.pl: Give back console on Ctrt^C on monitor")
  e8bf9b98d40d ("ktest.pl: Fix missing "end_monitor" when machine check fai=
ls")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+qVirCkQTXy/s_AN0jwVbiK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP319QACgkQAVBC80lX
0Gwo+wf9EPAqURsTBNgdtBMstdipLP71F3/t5j+n90XnhT53eMtZ2p1ErCsEHdQO
8F3Cbgb/DpJW98uCLteBSpyNTJJHldnxNeiH/lqI2v2Pc4ixmyYcr3Ra5uLC42cV
pops22ZermpVfRU/H7wY4Vg4ysNgJkzaFKEE4dAitjBIDa2JAkxpYeTo4BGVyfvC
L2TLL1M/w1qFbdNvDgiLgdA1NmPlSsy+KOaLBTOw98fzfCZol/kZlfhz3IDndbpV
cB0uCr1STDkNnpLwLGFsNdlctiYL9G0/R88uO4tC+LnoY1wUnhtL9ctEQI2/+QP7
S2SCao7eHRwWOJq2hk8ypmexAKCmLw==
=Gb2E
-----END PGP SIGNATURE-----

--Sig_/+qVirCkQTXy/s_AN0jwVbiK--
