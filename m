Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C66516E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiLTAAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLTAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:00:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF932705;
        Mon, 19 Dec 2022 16:00:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NbcC12TYSz4xZj;
        Tue, 20 Dec 2022 10:59:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671494397;
        bh=Ttw1kQxChRi9BQD9lKE1OGCXL5hy6lYosIPZ19dlILE=;
        h=Date:From:To:Cc:Subject:From;
        b=ggyp9Wstep1tFUcBQS+jzUTzXXvuq4jcsg2sckQf/CRuJ6+6HooA+LkugsnH6Rf3t
         2KuXv16TXvfo1A3kauecwp7AH2J4Yb5kMrqGkC7Nc8OgKnCfVzwCu/IGvniXVWcS21
         Zox9DviZGOisjpOG5KN2VM5416T9kkx0ETk8gd4iKyR74FmW2Rjobkmv5Yz8Aw2y2R
         OHVQUNZgmw5osA2TNsfZy4ifPPPcjK/+lkZ7Q5lVNCoqs9qXWhcuznh0fKO6EKqyHl
         IBE0KTQkPLmwri8e+wr4UOs1ph1SzXZB55VuXKwJTBHcSaaxh4hOjiDR+bOGTAyQhe
         pL1A28I5yLjxg==
Date:   Tue, 20 Dec 2022 10:59:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ricardo =?UTF-8?B?Q2HDsXVlbG8=?= <ricardo.canuelo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vhost tree
Message-ID: <20221220105956.4786852d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZfxT=oGrkvqhENWgfkKgk9Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZfxT=oGrkvqhENWgfkKgk9Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/virtio_config.h:74: warning: duplicate section name 'Note'
include/linux/virtio_config.h:94: warning: expecting prototype for virtio_c=
onfig_ops(). Prototype was for vq_callback_t() instead

Revelealed by commit

  333723e8bc39 ("docs: driver-api: virtio: virtio on Linux")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZfxT=oGrkvqhENWgfkKgk9Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOg+vwACgkQAVBC80lX
0Gy26QgAoyWQoAkRf/REnsMQFoThcInoVFmRwBg4wD+LDeaJarLv++aJSLrK9tOO
/6+cEiwpXBADIFu2TN4b6P4iN01Yc9DFNsoDusBU4M/xYic4b/bKV9bzM+y3x6Rn
TBfl04RkX58AW9P/ywiXUbWhGklLIX1AYnBucQET15RxARke/s+pdd5y7IM476Jx
td+oh6XudIAdhjZMA25nRUrAcqFWc0nQhrBOeCLXX88EIKx1+LiQ7PURFwIH5LLt
24h0WaJuEPt3gsnNMVgeQdObu1pY9rh80XIZAQzPng63mPPWCfC9e4NM88F//pft
s4pG4YAU/NLeV/Vf63RNqj+D7/NbgA==
=hMCn
-----END PGP SIGNATURE-----

--Sig_/ZfxT=oGrkvqhENWgfkKgk9Z--
