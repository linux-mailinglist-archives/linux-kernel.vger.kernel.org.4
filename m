Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40791682305
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAaDup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAaDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:50:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE4FEFBF;
        Mon, 30 Jan 2023 19:50:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5WKs3PSpz4xwq;
        Tue, 31 Jan 2023 14:50:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675137041;
        bh=9YkURXFOQcwLq9+2IUo0E9sIIZXHrN8D/DMU9ffTPC4=;
        h=Date:From:To:Cc:Subject:From;
        b=rolRRZM6Elv8W1hodu2JSXLZPjLo05UA6Voc7CaytnwnqFfwglTyRgX6uu3tsM6Mb
         OfBG4XRow1lbdLmD9vWQA2QC/LPUwWr17i90f9Evw1P9X8dTI/nbtEjUCPv2XMjVKz
         e7YWvWCZ0ba2Hu81edpo182wx2Z9n3qSC00H2AgWpLVqF2NW53IpqN5SSraFAUt/+Q
         Dub6etzIQfH7Ih1RdOfBacFxa2wv5SbuRFoWFJ2gHtfg/zudah9HYW4NSlFHzEAd6B
         xZOVApDsBUXbcjhpFNa6YoaclNKjwX1ppSORcxfRi8sfunkzLlXqd4swoo7XLVlgpL
         iy2CTLeJxLiHQ==
Date:   Tue, 31 Jan 2023 14:50:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rtc tree
Message-ID: <20230131145040.1714e4e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IPYX1RW4iJRm2ayx3pYzCOD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IPYX1RW4iJRm2ayx3pYzCOD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the rtc tree tree as a different commit
(but the same patch):

  bf5c08d3de21 ("rtc: remove v3020 driver")

This is commit

  5128d9183ce8 ("rtc: remove v3020 driver")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/IPYX1RW4iJRm2ayx3pYzCOD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYkBAACgkQAVBC80lX
0GyDOAf7BcrQLxHHL5/ZNmUtqU1LpmmACJKOYLLihQaIAHssM46B5NI0Mnt1/89L
bEKCHu1qCYIyDCtxXeFxHWMJmAfbHzW9naZIlYwuwsUsRTmK/cUM72cEd0If8YQP
8aycolyYKVA9oo/TN/maUqHmR+tzjey1AXg34eOEJryyvgjWFbeIMt0IrUJdMQ2N
04AaKFrLiLl8PfUe/JaFTyT2btQCA9zc2rCdSadFwOA3YBqm+IOC2sDiETKctYk3
fWLGuGOpaclrO0PqJAMuJz9YIaK8f2ah7dAhAhFYw3zPl/Ig8dQw/FLscl0mpjnV
LuqW1BP7wfijP2REL7iSqN7N39rIhg==
=4Lis
-----END PGP SIGNATURE-----

--Sig_/IPYX1RW4iJRm2ayx3pYzCOD--
