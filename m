Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475E63B433
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiK1V1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiK1V1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:27:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939822611C;
        Mon, 28 Nov 2022 13:27:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLdpY0wQxz4x2c;
        Tue, 29 Nov 2022 08:27:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669670837;
        bh=MWziLs6nPPhw3ZyePQKffCNuS8no1eTujDFnHVUc6lU=;
        h=Date:From:To:Cc:Subject:From;
        b=a3agnTwLzFi0fhwgMzr+GkY/E/L87TSRP5R3hzN399YVO4dBqTgHZHTUYtGC410yH
         ykMkHmOoeVZI29LnyGYLKfL0U9+eZWo/muwLXu9kFVnQC45aqqQQ12l3PES0SWhvFW
         Mcb+RcN1LSKj/zFDfe4Dox8g7vD3G+nycIfVO3lKjSis1fFH7bBBMJu0zKd37F4Wzu
         D1UvZFncgLC5DEVF3agiOpRV+0+M9QLZUUHbiIew8xfRDrOlD1HZT8563y258Jicwt
         CajNVdgxZxZX/s2VP1wY34kNxw3qh65eXewy4FyiUiQ98yuITmE5cIq7ozpjXwr1Ju
         +JgSdXxFN3fLg==
Date:   Tue, 29 Nov 2022 08:27:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20221129082715.78e44566@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uIVkaxbK_TscEmA+D6_pZmV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uIVkaxbK_TscEmA+D6_pZmV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4b49197f9fbd ("block: mq-deadline: Rename deadline_is_seq_writes()")

Fixes tag

  Fixes: 015d02f4853 ("block: mq-deadline: Do not break sequential write st=
reams to zoned HDDs")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/uIVkaxbK_TscEmA+D6_pZmV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOFJ7QACgkQAVBC80lX
0GzwAQf/Wn36GO3PV5QoKzZXeqQlv5lx2Tyk7AcrU3JeUddUDY7UK+9OKPPYTf3q
89XNlGwZXMVhpwM2EOrBrZnM1SIyBdaTF/yQzTXLNAwBNVu3+4kpUBing1qSM9Jc
ZRQIbloJTLA33GQMPv6E+uKX5PhS8nYcp/4zlg6XX4/gcg1CYYdqKsC0a7du8dRe
rrUn4LOexpcQymj88PdPeA+gQ9CWtPqTJXachmpYXuJqTTJaZl8QQrc8+8hNBK3J
XX4PHu5G02rloYSMOKrAyZyM8bqPeaD50oAgUFowANsHW3eP/e8pXbuAaGcsXSPJ
mX4HDMbSb/AzKjPUMsrYNWDoL473mw==
=ljWT
-----END PGP SIGNATURE-----

--Sig_/uIVkaxbK_TscEmA+D6_pZmV--
