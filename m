Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D32678D12
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjAXBBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjAXBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:01:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020730297;
        Mon, 23 Jan 2023 17:01:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P17vS5ZFlz4xN4;
        Tue, 24 Jan 2023 12:01:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674522069;
        bh=vHhV13AxVrn7eo/l4eXMZIQudeZ+xwQPLhyYquoqO9k=;
        h=Date:From:To:Cc:Subject:From;
        b=Ico6h8kd0eWx/6vVe8uFFAtKnpuFgjWOEGiKhwkrev7Ji/GkRGtbb06cP9a0Eyp8B
         VXi0rt/vPP5At5L4pZ25haAIDZESHvcN4OQ01wZKlKZj4Qt/mmfzDI6xNYY2JQ68Dk
         1jvcKuNm3AkPnK+Kee9D/9A+U7njitu9anRjOtH2LQZmu917/SiIXgky1kPQqXquPj
         p1VqVT8NF5zpZ9MZtbFD9DmNVyIDDSAXkHUPfh6IjW8gyOPUsXSIk1aHXBnQTPb+qQ
         ECpP6zMrUoBR8IWRSnYhvknNWcuNWyH+Phz+wJj0xNnmwN/F1bKckYwvKLWIWTfcFq
         CW9iSDyf/bVXA==
Date:   Tue, 24 Jan 2023 12:01:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the rcu tree
Message-ID: <20230124120107.205ca8ae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EmpXFFYzya1nBRe0bSv+ra_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EmpXFFYzya1nBRe0bSv+ra_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the pm tree as different commits
(but the same patches):

  ba66764b5e43 ("kernel/power: Remove "select SRCU"")
  e5ded8e65e70 ("drivers/cpufreq: Remove "select SRCU"")

Thesea are also commits

  52e0452b413d ("PM: sleep: Remove "select SRCU"")
  38a29e5834eb ("drivers/cpufreq: Remove "select SRCU"")

in the pm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/EmpXFFYzya1nBRe0bSv+ra_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPLdMACgkQAVBC80lX
0Gym3gf/V+aCa4V09boEeqja5EE4m26SBt9IIcdXOn1gxb5r9qrJv9qfm5LKami4
dEK3z9tB9l23lA5IITntymI9ONkhkQcKsDWdQOJjtls0BusD8NmAsIfo2N4+yHDy
SAttg5AVw31qHXQdUbQD+p7MWuO97oFLD38n9yKemHAH4a8T3LICoNy/mcnmaiju
31fjc8nvTu82/73WirSBPVIv1BExSYxPLTBCxtJvO/qftpwV+zYtrSUBo9Au48D9
jMy2//ZvjAk0E9nIXPkcBqfkWOHy0nzAxEMi6SKu2NqCk+Jp2sYTGKjVMCrPh+i0
urkGIyacIU2cp1o/0zxSpFDNtgIzzQ==
=drnp
-----END PGP SIGNATURE-----

--Sig_/EmpXFFYzya1nBRe0bSv+ra_--
