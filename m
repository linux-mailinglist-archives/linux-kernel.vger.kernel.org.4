Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8A680225
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjA2WKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA2WKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:10:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735CA18142;
        Sun, 29 Jan 2023 14:10:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4lqG1J1Rz4x2c;
        Mon, 30 Jan 2023 09:10:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675030202;
        bh=IUf2HFa58QRUO1XTT2PABThAsG5WcYMxvHZCJ0WgTyY=;
        h=Date:From:To:Cc:Subject:From;
        b=n36lHg2RyHARSSd3O5OQy1AuLX2i+haqXNx3vOeBYqGI8oGp3Ptr/ycoPGncUKaHl
         xRNXpa/5y3OXZnlb1RrGADgpGrKmIyFdvmXSaJX36qO2htlRVrxRUwVmDMxEjabrxo
         z7fSZgVRxmF04E0hk4iMSzRd5ovj648LQH5hBcWwJsOmii5fRhe+Ws5xC0rl9ARWfN
         CNoL4gizmcvfTqduiCttgeyiXD7wAqXmLosJ4ePmUm99aZWIMxwW3tpMKAkpqjR1JB
         SRcKv7u61YFqtRCJJygkW121XwnIEfQDqmqU8Z54vkoR2VyKSwyCccyw/VMtXSpIsN
         5eJMVbuowRLhg==
Date:   Mon, 30 Jan 2023 09:10:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nvmem tree
Message-ID: <20230130091001.6f02053b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B74NUSQeKffmJB7RkPeBJ2T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B74NUSQeKffmJB7RkPeBJ2T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ee0a7b467d3a ("nvmem: stm32: fix OPTEE dependency")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/B74NUSQeKffmJB7RkPeBJ2T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPW7rkACgkQAVBC80lX
0GxYHAf/VhyZny3K5Ducnxsf0hz+P5Q8scUT2eIGLx5vW/Jd6tL5pnOFPj6v+Euu
d1aDiXjXjLaACbdmXj9ynZGSa+y87LlzifVAvolyQRJieRGoXyzlxOyJiRQY+aA1
b6NtVxgmdx4pE+8YyHBZY7Shx4Q5nz7AD874WjNN99tKf+ncbppbImPOn9r0qjdJ
J6srGBURVrN8jpGG8BsBy4CBxhq5UH2No+zru5oG+Iwvy5TLjyOB4boteGRhfjQq
ro73VmQOXycOXu4tx2k4yQ3d2GW3wUB8K4JnZavb4xUqdT6NvUeKVsTdgzjwyo//
w4q4kIyiO5bN3hv9RUGNdbdCsEICsA==
=s3DI
-----END PGP SIGNATURE-----

--Sig_/B74NUSQeKffmJB7RkPeBJ2T--
