Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35117668A27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjAMDcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjAMDbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:31:40 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA417DFB5;
        Thu, 12 Jan 2023 19:31:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtRlW2hb7z4xG6;
        Fri, 13 Jan 2023 14:31:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673580663;
        bh=pAmauTQqsxdIlLvFUid2E0gAOaZgwDrPGmOtiTdrqaI=;
        h=Date:From:To:Cc:Subject:From;
        b=QH7moU+hIwlpminqbPjNj/tWtwFJp7hvVc25NhDl/aLRSOnsrTWARtYUTHTiRyNeQ
         TuVP0HoRFYU3/XR38HJNZMtK4Oh0G1aErUxHR7+ZfoUx02lDsuh/EOZc+JhkXZnlZF
         Z0FwDW2zVgE0mOp/0oOa+8C+3W289A8DxLqtSiEuHsqNFAexqcUcuY2e1KfWBI8A7v
         ghMM+WRz13k8JzPC+A47KOR3Sv+Nipy/VwZYcQ8exy/DAVQoHYcfV1Q0Q6f+Xtlvoq
         tISrLXAXFtjVH+16cCdGQxZToxwYiHBU5yJbZuWETsIXj4stTaHhuwRt7ZQ57bY74T
         2epaQBmPRqT5g==
Date:   Fri, 13 Jan 2023 14:31:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the workqueues tree
Message-ID: <20230113143102.2e94d74f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WPtveuuGEtDR7a+N3fqEII6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WPtveuuGEtDR7a+N3fqEII6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the workqueues tree, today's linux-next build (x86_64
allnoconfig and several others) produced this warning:

kernel/workqueue.c:1993:13: warning: 'rebind_worker' defined but not used [=
-Wunused-function]
 1993 | static void rebind_worker(struct worker *worker, struct worker_pool=
 *pool)
      |             ^~~~~~~~~~~~~

Introduced by commit

  793777bc193b ("workqueue: Factorize unbind/rebind_workers() logic")

--=20
Cheers,
Stephen Rothwell

--Sig_/WPtveuuGEtDR7a+N3fqEII6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPA0HYACgkQAVBC80lX
0GxHxQf/YJvFGjZwaCrmYzInzbGkRO+qqZCkQdo3e23TF28nMYcxlhDpi5XbaPn+
IuA3Ww7X3ly9ot3nIjGYILXR1RIQYrym9vj1/bdXhGqZNmS/A6PefiZwgOZ5bkaY
GdIPXI2lPsczYiH209CJWJhV938/YNdDsd8ZBMn8H0igT2EZ5lhLGH71gikVtxTc
8TkkhuHgDpE4YLS0jYFYJjRpEqvvxXmT0hpTVCrjLi8/JgP1PCLWzw0yivQ7Hp/g
GbkKAchlGwTMnHoizucahhB7yNKddnBVxo9+KOtpn2qSRvbjA26lXy/b2xszdHhY
LqENORt88pQk+MO0/x8M7GsxGdtrTQ==
=KiYW
-----END PGP SIGNATURE-----

--Sig_/WPtveuuGEtDR7a+N3fqEII6--
