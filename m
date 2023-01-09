Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F566339B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbjAIV7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjAIV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:59:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5910D5;
        Mon,  9 Jan 2023 13:59:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrSWl2066z4xP3;
        Tue, 10 Jan 2023 08:58:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673301539;
        bh=TBC32WZOnAuu3QNK/MOFwnrDRP0rSxyDp3h0K60zOxE=;
        h=Date:From:To:Cc:Subject:From;
        b=rQF3hWkL5sN8xjt3M/B7HdqLFiPIR/G3UcXznFYc3GqH4jwrXAaiHU/ZjBXB3qIMe
         fr7wFTDh1NBf3wWwQg7OmlQrBaY0zBG0unpionrYGuCIBfqfnuR8uqvRTcNMHZXu08
         1COQlHBlGHjVACL8Jby7cw8lbjSJ3s7+Yo2PfqH9RomLJD/epLgMSBR/VigmGxvlDt
         HJ3ZnxLz5d5fjIncWKZD1YHFTOazD5sR7iONMP/hsNFzdDo9SLiYqHOs4f3a6/e6BP
         iF+2zXRvLndSaImGcgpCq260/uf1q5KEIqVJ3n6sioTzhP87sCYOTsb0Ib0VnqxkX7
         pk+498VNnr5KA==
Date:   Tue, 10 Jan 2023 08:58:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20230110085858.7667eef9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ifhtkWg_Ik_VVygs0eu6iX0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ifhtkWg_Ik_VVygs0eu6iX0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d6baa536dd7c ("drm/amd: Use `amdgpu_ucode_request` helper for SDMA")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ifhtkWg_Ik_VVygs0eu6iX0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO8jiIACgkQAVBC80lX
0GxGQgf/X3kz1p4vMNBZuDVTBYEeeQg10ybHK4wM0vKnW46KRdpJVTayZa2AaXyv
PsAYJChTKdLC1rJ4TNz9kDooJbBAcL80JVo+jFL6PtYlSRQ40PsGe1jiFHySW+C8
hWtI0TOkSgnDP1aWGHfWjzB+gwLgPAZFeylGp6G1hpPywPZECDNK4En8m0LfJcFf
A/W5H86agMrIIR6Qu5dEaBMGQbqDWGLb+oBrFL0jyUKkqfQ1KC1yoR3I8Ksrhlva
m/0WZLo5f9qVfS1AlM+M/gy8olUazlTh+q7Kv9Rey00DiyPEvcxnkqRuyGB0PKIO
y6rmwD5yvq0JnC3FuFJMTx0lAVTT5g==
=47mx
-----END PGP SIGNATURE-----

--Sig_/ifhtkWg_Ik_VVygs0eu6iX0--
