Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC04721BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 04:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjFECY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 22:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjFECY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 22:24:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1503B8;
        Sun,  4 Jun 2023 19:24:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZHW24M78z4x3x;
        Mon,  5 Jun 2023 12:24:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685931886;
        bh=vraVzjO8XzelUv/TE8cn2qJyRAPqQPidsYXGlf6d6nM=;
        h=Date:From:To:Cc:Subject:From;
        b=CDfFqS7IXmm+fq/e/hhyEJPZnkFueXAuGgUpmCpkU9C5dCHnhy0Zw7YVhpwHzDTGG
         HjefcdiDass6lEqENVCNFd95VkdawqustnyFKmXamuIZRoWK+PRdePDLmL97vZKWUW
         J8+zIuP2m58minmfcZ4KLMrRNWVWmTrglWUu1fOv/5zPm9bWbKkVntDToLDpEWShLo
         aId6wI9khOg7tjJnpC8PrXCDjv82oJdicfvcIgVFirYOVVHwgFDbuxXOw0dXihUPy4
         3SnHAZ599fJ9X519fFHcxx75mtnjsA9lT9hHI502s6pT0e81y86JQQVsLP9sVOzp8U
         qXKB2W+sLNmVA==
Date:   Mon, 5 Jun 2023 12:24:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vhost tree
Message-ID: <20230605122444.1dfb2abd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ieONAuZ+PDROpMwUBwA23Tp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ieONAuZ+PDROpMwUBwA23Tp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the crypto tree as a different commit
(but the same patch):

  cfc232b3ec9e ("hwrng: virtio - Fix race on data_avail and actual data")

This is commit

  ac52578d6e8d ("hwrng: virtio - Fix race on data_avail and actual data")

in the crypto tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ieONAuZ+PDROpMwUBwA23Tp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9R2wACgkQAVBC80lX
0GyaFgf7BPLV0/0wLXtN9ofKupS4CUkQEbw6cLstI+eN9jjE0N5DSa9lNorNi4oV
NqglEC6MJHnIdMo2LLF0ttHPzxxTWVYM4S9sL+7RIUMv79qNRgLaWQ7SKg7+sj4R
eMKuwdcji5eCep1Z84ZzFVY/Zpxhg7xBsxWwIu9EWZW4efYczecI22KInCP0CpiB
Yp1ov5qiM0b5X4gCghRTAACSFW1KuGzGkqjxQUYA1j5u15Ypn8554yX6ApawshFW
cYidRdrTQGdmiX8BMIVlz942VyXKk9/uU1yPS/ity6duAiWONcWFZbcdjgJbXLog
cDzhTz4dfqRP7ej6Ty0mgSjH0+Dt3Q==
=0IaX
-----END PGP SIGNATURE-----

--Sig_/ieONAuZ+PDROpMwUBwA23Tp--
