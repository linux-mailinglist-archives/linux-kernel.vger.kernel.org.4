Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8FB671196
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjARDNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjARDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:13:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E021F4FC23;
        Tue, 17 Jan 2023 19:13:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxW6r5s0Bz4xyB;
        Wed, 18 Jan 2023 14:13:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674011605;
        bh=JijFHq4ZcfL3oD8HQYgS1TNLdubTWtW15SkQ8pe6VGA=;
        h=Date:From:To:Cc:Subject:From;
        b=KNxMjn5NLvpFWmTQBzplWr0Mz6KOrz+7yEs6yOklIH5yOdtNCpn4PqruuEdSsnPMY
         0EkMdIqYD4mPZYvKXDs5yMUJXcri1ozkXcufOOn7v3R84Qqss2Qm1wsMRQMt3pH5nG
         Ek/pHM+ctumWoyBtr3xqcl48IV37G/2vPOkrTD2YEHoZlGDgYX0BpyhCteG57r+95P
         zuIvLeAJ8tpStB9gYMboJrMJx+rAgmFfroJvjTyHz/+bJZEpZusTYxy6Wyx/s9unRG
         +EYZa63DmBz9diIFXmN2RcBLfamWiWCflgAmX4lngVPGKEpn19M2K3Nwx0bbY4+HNA
         31NI/uGSP6CAA==
Date:   Wed, 18 Jan 2023 14:13:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Charlene Liu <Charlene.Liu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20230118141323.7ba5f443@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GzQ6qnIssW0SB+RCcIY+T6+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GzQ6qnIssW0SB+RCcIY+T6+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:877: warning: Function parameter or mem=
ber 'dig_fifo_off_in_blank' not described in 'dc_debug_options'

Introduced by commit

  40774ad1c460 ("drm/amd/display: contional remove disable dig_fifo when bl=
ank")

--=20
Cheers,
Stephen Rothwell

--Sig_/GzQ6qnIssW0SB+RCcIY+T6+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHY9QACgkQAVBC80lX
0GyktwgAmBESHq38Cidr9/95xRH2i22OLgjplDYwrXfUFrSYlaZE7XV1op2ukK/m
Xn4UjvERvwrthnpOriejZFi94VLPNfT68RF925A6yijUJVt+4ZBazghaC1i3cTOg
gZHRx9oT14TvGeYWw7Iz1TvF4rB9YqdPM4bqLotaIwX2r+A/SedvaHO9pJvDHkXb
+HR5TdVgBnkocTdXumcJECm7QDCtxcQSxOKZ7BkaA/PZfHeYsq5EsCnSu8wCvXmc
elqz78TReCPL0qoiAagF7mse7nIVMj4u+oTARnwHl1wC2yafKnnEp+o29/sG48IL
Udk+MbXaQth60X1PTqtdSHq84vC8OA==
=L6bI
-----END PGP SIGNATURE-----

--Sig_/GzQ6qnIssW0SB+RCcIY+T6+--
