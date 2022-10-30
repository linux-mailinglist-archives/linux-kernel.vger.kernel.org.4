Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADD612CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ3Ukn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ3Ukm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:40:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B586DA444;
        Sun, 30 Oct 2022 13:40:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N0p7n6rWpz4xN0;
        Mon, 31 Oct 2022 07:40:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667162422;
        bh=QeF8MzSFps3YcdBLmfEzHOkl/0wbNk6mzSf4VAkqaMs=;
        h=Date:From:To:Cc:Subject:From;
        b=FDEXVt2BT3UWHdlzEaOEADoCIUnQ65yV/yPU9ag6tbX+KRonEbvBxmodWRLS/NvEL
         eIE/W8rwS4S1dcjrIfihoF5ICqQen9AtVX8ZXHGzXmucw00gXpi34/K5/KdqeySrv1
         Ag+CEk94Y7/DkHLkjhxZa9uBmJf08ixuBg29+GYgJ28KGdl81UcrOo6hsYMr7W86Qx
         kslIIg3rjZ0tr1VfyptrcAKbMc9U3/g+8Es1xhf1KarnGURiLLHGfRe6qPs5uOdeZX
         +3fYVzETMW3Nu23+7oKpNfcQ+avOErALe8tF/ddcmIGiVrfTE/dIGqubbRnhdQXllg
         uz2yBgEtMLIIQ==
Date:   Mon, 31 Oct 2022 07:40:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the iio-fixes tree
Message-ID: <20221031074006.1ca60136@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/18KiEnZIEt8k0RrS2JmcjXo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/18KiEnZIEt8k0RrS2JmcjXo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a589ef35fc62 ("iio: adc: mp2629: fix potential array out of bound access")

Fixes tag

  Fixes: 7abd9fb6468 ("iio: adc: mp2629: Add support for mp2629 ADC driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/18KiEnZIEt8k0RrS2JmcjXo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNe4SYACgkQAVBC80lX
0Gw5/Qf/bUA1NMGCLgubuQwRCx1Ui687jicUr06JDab8KxZ+giAQ7oO7p6jz182e
8Y0y+xiTpK8A+PW4P9RpzQvprErLqcNSJJqiaQn6z1seuIKSxbcuOmtLwNbbII89
I0Fzw9qo5Cypq5R34KSP4NusONI5zokMivl4TCDLmzR9l3KecbRSoMUw8mQ7s4ju
LeSiGSLSUiIkvV/QenNL3KNX5m+SyaLlr/zATzX4+SAsSb4hgQ7FlN9duON/TjZD
8deX+679QJCcpzDaFJgpi2PlYyJdEBMkD6FBrhDxJekFVEkiX5ycFiAniVKuH9zk
naQeZ3WeNbEUHzVidkKvsp/UFsHZ4Q==
=ysxY
-----END PGP SIGNATURE-----

--Sig_/18KiEnZIEt8k0RrS2JmcjXo--
