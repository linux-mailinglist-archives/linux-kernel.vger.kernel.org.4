Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31356F9D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjEHAx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:53:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01F86BF;
        Sun,  7 May 2023 17:53:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF2q05z8sz4x44;
        Mon,  8 May 2023 10:53:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683507228;
        bh=L1k7OwBjx0C3uEGz4kyCR89Cq5ffm4eC2cL6nh2rydk=;
        h=Date:From:To:Cc:Subject:From;
        b=UuR4SBAy7/scCBW21Vuzn3YpgDif+WZkA/pxmuRgV2UdMSS2mmJKPtO8nOsuXqjV+
         3tZunsl9cOCqD4ecnp790I7NhYwblThJGDJSTV8oT/M1obQyQCBbMV9vrOl9SySf6P
         DTY0b1ycOt+tGubsywcrtmB+Paenr0lkC/ajmRrwhf8jXzyTE6rRw3DQgWXaXtIaVt
         6MaSZgGVOeRTM5byKW/YchuHzl6Y3TVqESvvSnYopITpyOhUu23OpJUHhxzaA07ZC5
         PgW9fpzWdxQ25gkYmTZzNIPs6w60O1KOwIFG8dAayzwsHHrh++36kkTvH3QaUKgHqE
         eiggR1hPflqrg==
Date:   Mon, 8 May 2023 10:53:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the perf tree
Message-ID: <20230508105346.24d4dc39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cuvbzRnl6Jqr2JJyQ3GexLV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cuvbzRnl6Jqr2JJyQ3GexLV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  1f30bd499605 ("perf symbols: Fix return incorrect build_id size in elf_re=
ad_build_id()")
  419bd54a3875 ("perf list: Fix memory leaks in print_tracepoint_events()")
  4692917156b2 ("perf script: Print raw ip instead of binary offset for cal=
lchain")
  494fc963a281 ("perf lock contention: Fix struct rq lock access")
  4e05971903f0 ("perf unwind: Suppress massive unsupported target platform =
errors")
  5d27a645f609 ("perf tracepoint: Fix memory leak in is_valid_tracepoint()")
  7e5fd3db2371 ("perf lock contention: Rework offset calculation with BPF C=
O-RE")
  aec1164e09cc ("perf script: Add new parameter in kfree_skb tracepoint to =
the python scripts using it")
  db483eee8670 ("perf build: Fix unescaped # in perf build-test")
  e7767ec67a10 ("perf cs-etm: Add fix for coresight trace for any range of =
CPUs")
  e7cac3fd8ca6 ("perf list: Modify the warning message about scandirat(3)")

--=20
Cheers,
Stephen Rothwell

--Sig_/cuvbzRnl6Jqr2JJyQ3GexLV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYSBoACgkQAVBC80lX
0GzS0wgAhoO6nWWyThmweWEThcjdzI9gIczDSALkGipmuIBeOwusQmUzgQ+uVx9V
dQgQuifxCL+PLuvNa6XqXtxepFQS114uRzMDjua1GSpyBtRDRqq62wT0R1DpWJhK
PrTeUX7UD7PvFluSXEIEZm0t5sfC9OOvZy4/Bn2Ki0CelfTh2Pq9gBAgwS2u1+9n
S2IlH5c1F0ZjQdz7NPo6XAdstx4Zrm/pys6GXNyo1b8tMSPqDN6PCwWIejJZb5TU
0E4QsxCVazbech4vWAcp/IUifzzN0HJQaNt1+qmEEF+GusTW9KbmH1J7IifBq6Jp
C3wx6d3xMbtfLEpCnuL5VsJHM7bzDA==
=S2MJ
-----END PGP SIGNATURE-----

--Sig_/cuvbzRnl6Jqr2JJyQ3GexLV--
