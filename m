Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ABC5F4B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJDVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJDVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:50:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50B24BF3;
        Tue,  4 Oct 2022 14:50:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhrx33dWtz4x1D;
        Wed,  5 Oct 2022 08:50:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664920248;
        bh=HN953pU94xEC8/scIinqRGHHD4tIEtXg2hyrS0Rhh6I=;
        h=Date:From:To:Cc:Subject:From;
        b=sP0hne8BlkgvGc4ZWxP8Pgjxf0jPgKd/LTMyiQU/OqZL/e72l8G874U5iYTOtVwsH
         eNEztP2xkNtk0dJ8wMI+eaBJgqapWHiCgcL1nD3oSYLdYO7Y/e3ojyg2gu6wWyVEp8
         svrdVHOd+/ozz/Izi5fNTicQQXRH+xI1+IfVLNlBchqfFS8YZN1CsYRl6b5r7BygCi
         tyCDTvaRlgCYs68PunGrNXXHGqJGJb2SD7xfHSpR3zDXpwm1Ss+CMLqowe3EwVd3JU
         /56WWhMJ07c21SaJ+73Vo5sTVafv2mOrFMxJ8pcpf+8yC/8C2sDyNwukeo7PYtyWKz
         fdtF/7lf4A/NQ==
Date:   Wed, 5 Oct 2022 08:50:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Anuj Gupta <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20221005085046.1adefcfc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4SvURcv27ADnxUpzgNmKe=o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4SvURcv27ADnxUpzgNmKe=o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (when
CONFIG_IO_URING is not set) failed like this:

include/linux/io_uring.h:65:12: error: unused function 'io_uring_cmd_import=
_fixed' [-Werror,-Wunused-function]

Caused by commit

  a9216fac3ed8 ("io_uring: add io_uring_cmd_import_fixed")

"inline" is missing.

--=20
Cheers,
Stephen Rothwell

--Sig_/4SvURcv27ADnxUpzgNmKe=o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM8qrYACgkQAVBC80lX
0GxZhQf+PybKqigT6rwDjdh5P2jT2209luw5NxmpjWZuJLwvcPbBZ+3pVFF02EDT
RBgen8Pv/bH6dS/I1UkgZCfQgqsT5EFWbA6enQq3HOYLG9gzrSZokMKF0lfuCffs
yml7H6WgofhvHRgj3IoDKCV9HveiEqUs8l4VyrYrWh1T33UanaWMUl+WQU1+h1DQ
tzUj84fCjIgPgoqOPxjvQPoraAE3Bd9FRy7FPi1i0MmX+VW24BvG+Uj7wAXgwJky
JmSRKwPdHP5SyiN0PETRF7MQzuLvjW06K1RMCAdcwkvC9eWV4/xBJgVUOB30cqWZ
5JUZMETsTInCtywotOCUaVTFIHa0Wg==
=L8/f
-----END PGP SIGNATURE-----

--Sig_/4SvURcv27ADnxUpzgNmKe=o--
