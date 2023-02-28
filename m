Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFEA6A63B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjB1XNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB1XNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:13:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174707DAC;
        Tue, 28 Feb 2023 15:13:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PRCp86559z4x7x;
        Wed,  1 Mar 2023 10:13:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677625985;
        bh=0+laPdOYcc037NqVOAd/LAR9BTIYDIohensY42Dxvvo=;
        h=Date:From:To:Cc:Subject:From;
        b=eb9TRUh2q0CW13Cxb9spftI0SddmnwFykcx4Y6iX5LVYNhWGvAftgmFJ0dRZJISh8
         FbfXzKrc+lE6pqYojUK48/2ptZDGd26PgwN1pwZb/8sfUel4ZXgnkPq/KU2a0qcDyT
         afMxxZGamtKg7AMoVuG2nZ/CvXfgJWKCZiim+zJteQyNzasC18/5DoUCXuNsDIMxcp
         FT1h1uIGn/upxsEIuBap3tSHro84zmrLByYQV58FOQlnN0ihBfQjgoZeQOR1vSpfPv
         /c+aliMH+9FXKGNVJOJGLNPCxtyjcHbEGrRL9+C8+iakkuVjNOMMRMInCNvhGosQgj
         F4+LKy20j6Jig==
Date:   Wed, 1 Mar 2023 10:13:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the input tree
Message-ID: <20230301101303.2223f88e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F2.+VUjmh4HTtoVA0Dac5n=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F2.+VUjmh4HTtoVA0Dac5n=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the parisc-hd tree as a different commit
(but the same patch):

  586dc36226dd ("Input: hp_sdc_rtc - mark an unused function as __maybe_unu=
sed")

This is commit

  ab898955932e ("input/misc: hp_sdc_rtc: mark an unused function as __maybe=
_unused")

in the parisc-hd tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/F2.+VUjmh4HTtoVA0Dac5n=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP+in8ACgkQAVBC80lX
0Gy6tAf/XQ3GFVHd3/CEGVKFP6I0uOuRg7nnNYEryHQ6pNwg+FO4H1Zmz4YVNa2n
HnaSS7jIWSj1P2oOCExmkR/a69UX46piEEhGr4y8dSA39f/rtRnS/Q9VmqYqwZFe
QTU2cvQbPj5KlFAiHfrrLbJEHaGtlwswgjrMifQ/urqTuzdbVkjTimAn/dPb0yQO
2jZbrLEW2Zsx+7G8ETwr6DdK2zXRZvX6yOP2wzmmuwf9ypO4rvxuA/FvCtBwB0dV
X+rsXB7Wyiil5jEGQ8r9qdCLVsH91tVQJ0YLFfQmrNfOHxem3PxT9kD7eF1gMVHg
l/n2+2zkWtc5IMwJ0pJej/TX6od6iw==
=Xq7f
-----END PGP SIGNATURE-----

--Sig_/F2.+VUjmh4HTtoVA0Dac5n=--
