Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054786C23B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCTVbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCTVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:31:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6144305CE;
        Mon, 20 Mar 2023 14:30:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PgSXd58H8z4whr;
        Tue, 21 Mar 2023 08:28:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679347729;
        bh=/891SqKTihULGqE584S2ffNFUuwiGnvxePH/HRWK3zA=;
        h=Date:From:To:Cc:Subject:From;
        b=DDLANSpHAnflOvMY9ODXLZ3SJnoQ+FofmI3Z3slv1TQ1u3VjB8cRZUihzUDbtRCE4
         XxSD1bgYF0me3P3Se29fhSXXIEYDSUhYqhx0rFXs8EuyIWYk6OYv+LeiQuWQW6seJy
         MWXn64VxRMHD2suGJGaasb7nwIq1YVfjCG/X5aFuKfyIBjOW0UgPqAb74cuW/LEvAl
         19rKKIPywOUkYnP9XJhv0KYGM+c3DsKvr1HLXtDapZVMi79D1KZVQj6VmWT63K6kOa
         qi8Vws2JgAzZx3gCnUGRaufrsriskkG//GSVU5a34Ytm9RyAvNIimGynO1xLPPIE3e
         qYhkzshudoPgg==
Date:   Tue, 21 Mar 2023 08:28:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20230321082848.25cfe9a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YhK9Dp1s3M_lAn5DRYLh5Uy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YhK9Dp1s3M_lAn5DRYLh5Uy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  aa939e415c6c ("blk-mq: remove hybrid polling")

Fixes tags

  Fixes: 9650b453a3d4b1, "block: ignore RWF_HIPRI hint for sync dio"
  Fixes: d729cf9acb93119, "io_uring: don't sleep when polling for I/O"

have these problem(s):

  - missing space between the SHA1 and the subject
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

So:

Fixes: 9650b453a3d4 ("block: ignore RWF_HIPRI hint for sync dio")
Fixes: d729cf9acb93 ("io_uring: don't sleep when polling for I/O")

--=20
Cheers,
Stephen Rothwell

--Sig_/YhK9Dp1s3M_lAn5DRYLh5Uy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQY0BAACgkQAVBC80lX
0GygXAf/Wi59ndcB/sQ5Nw4oaqnzkjCrQeqjY9APFigEtDHNznTLjzEmEUOdUOlu
0UaJKA/CFTbjGIAGWRNJp4TCddLqvyVpn8mruobUNdDALI9opF8bPaRQ/HX93kDF
I719LR75jETMZJIRW6LEIFA+BnbXlM5wYZs2gVARJlb5WJJv4i0HQyaovUPgND0L
sCMuElM4T3W9FVK0ddHc/VJgjO3NEOvH5BykbzY1GzFfiEn/x/zlCr3EpVTDutM5
FSR1eqiiBTkBVNlgdopuggn6ALtoQBrvzld1tLzHBl6EAwa+JqupNKAxyGKiivlS
gqRXEvrY02LZBR/ZXyBDXZ7CSkgaog==
=zfec
-----END PGP SIGNATURE-----

--Sig_/YhK9Dp1s3M_lAn5DRYLh5Uy--
