Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A55BC054
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIRWNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIRWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:13:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A3517ABD;
        Sun, 18 Sep 2022 15:13:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MW2B46Lltz4xG5;
        Mon, 19 Sep 2022 08:13:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663539181;
        bh=BZX022bh+nPw/hwDWob48F2NZDzNbTSK9yDNkN0pEYw=;
        h=Date:From:To:Cc:Subject:From;
        b=MWvsaGSqKQ/cwQvGuGwRguUNMOrslR7g1goWIu2sns7wIAYe5HQAeIQ1FDYPq2m8N
         dnRgp3RV6BPj+/rZ7plQJiQ3tbZ0YMR16KFR+J6fgEot8yV1HdcGYF1Fq8Gyyz0h0D
         AQicC8uwenMk7xXURuBmW2nQMTbavg8RmxvVoal7vXEL7AAq4LNkAGgNyAhyWa6vDq
         0NpWzcjq45vEu7nm94utPbx8neJyL4NqmZ46uZV3vtp2yPCmhRLZvhEo5I5UwRapw1
         8e+JmE0LWf678BHa2nsc4S2vpnFKUjciIPvHNmbDo4tFiOJPxjgmoF5QW0avaq6uMq
         9oqDoTm6zbHYg==
Date:   Mon, 19 Sep 2022 08:12:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Damian Muszynski <damian.muszynski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <20220919081259.714b81f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bu+ro+KfrWd+.tE29xPJY5g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bu+ro+KfrWd+.tE29xPJY5g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  cf5bb835b7c8 ("crypto: qat - fix DMA transfer direction")

Fixes tag

  Fixes: d370cec ("crypto: qat - Intel(R) QAT crypto interface")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Bu+ro+KfrWd+.tE29xPJY5g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMnl+sACgkQAVBC80lX
0GwFPgf9FVAwfShK+/u6ZLHQ/NrqlNng6CHgdfvsRzwfuWeIWEvEeVT+T83s43Nr
/SSoiU0nYWVjd0L2ayKhNoGNaPebMt2ecgTQZqHj2deuylm+1mfTTjhXRiAmqPL6
XDxTF3ePg4GJprfV0ObyZEHiiQnInsO/GtKtCGffYqdtpWH8biYbQuCEacO/Ig7z
hEyO6k74V6kYyB/hrDbV4kUVzpRTIyD92NvKM2I3kbneRHvHld8ho8+CoX692W8l
su8Tnt2beT7NJAlJxUzrrX6qOeKZq/aRTUy0HqGLPconXohk0BG+kMgsssrqW7ih
xcmJVQ5UBUWm17CU2XWHEGnsopC3qg==
=5YEk
-----END PGP SIGNATURE-----

--Sig_/Bu+ro+KfrWd+.tE29xPJY5g--
