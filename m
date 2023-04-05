Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC66D74CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjDEG5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbjDEG5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:57:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB634224;
        Tue,  4 Apr 2023 23:57:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrwRV2nQSz4x1d;
        Wed,  5 Apr 2023 16:57:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680677830;
        bh=ZYE4FSoL01GL/b1FxXpvB3WN1JHzBLRQ8oHkl6EBENA=;
        h=Date:From:To:Cc:Subject:From;
        b=RjK2+P+nt4DxmCp5W7wO8jweEN6FjSQBRIRcM9zCPMmVWRgz2y8uka4RNYtrTRO/F
         ejAA4iwur7DUhfpB2vT7MYnKlvBomDvlfm8MZFou9WIoHv0aG+UTCxvuzd0wONoZ3n
         SpqMmOcXFatXPyFDa1iN5ai5bHOTsdvWazuKuBDryPqLHeU8vEsEYl/xpjEe6sUlNS
         DMWOQ3a0RkngmygkbwAG+Eiv0T+Mbl8ClTFb03obhQyfMZ2TP1TYYiMqJsDiRWKvCy
         Ez1LgpurVA9Fw8SBPcz0Bf1Zks6RuoYKC7/rJvFpvoM/XWmcirSPwF9BEywMPya+26
         FSvrFgWOBS9Ew==
Date:   Wed, 5 Apr 2023 16:57:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: a couple of breaks
Message-ID: <20230405165707.189c1a99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_Da=ETof2xoOLUdxWJQ41HK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_Da=ETof2xoOLUdxWJQ41HK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There will be no linux-next releases over the coming Easter long
weekend i.e. no release on Friday or Monday.

After that, I will be on vacation from April 13 to May 7 inclusive.  So
Wednesday April 12 will be the last release I do until May 8.
Unfortunately, that means I will miss the whole next merge window.

--=20
Cheers,
Stephen Rothwell

--Sig_/_Da=ETof2xoOLUdxWJQ41HK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQtG8MACgkQAVBC80lX
0GyPvwf+PkCFkU+yQebriBYjrhdlwlxo1DUrhQh2hNF2t37bT2HXhjRNvgyk+7BF
8QzOEmO86Qj2cIDjzpvRVbWQR6bI9JRsSyQX+8/M9QRJBzSOyWkyn3jmwSXwT/49
CCGIQJ6iY7RPxH9DMhHTsrdaMrl6lKMbHiOmxb1aDOeb1hr+bXwce4lhCDiEPXrr
kvsVdIKD1c0cU2WomUGa54hiwJlnl9c18Fpvoye3uAKo3zqHE1H07QkR7ImrrddV
C4/YiIqRG/9XwIoA3daVQpSQfaL85gza5VqQ+rUMl34jk2MiPMKlYjpEUrIbE71T
6dvKsWDhtwQs/bfMQX/7vkFxRf+LNQ==
=0IVH
-----END PGP SIGNATURE-----

--Sig_/_Da=ETof2xoOLUdxWJQ41HK--
