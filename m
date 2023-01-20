Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCF674932
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjATCJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjATCJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:09:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CA1A0;
        Thu, 19 Jan 2023 18:09:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nyjc8529xz4xHV;
        Fri, 20 Jan 2023 13:09:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674180568;
        bh=5v66ofCrkJZhwu8nWLQSSFBEbMU/Ef/xua4Jd/IYozU=;
        h=Date:From:To:Cc:Subject:From;
        b=GUlnd2i0/UDXOKkvMic9LJSxurdPNnj6woxMoy1vYh9kTU42wL9zabD14EEiBWsd9
         6l/mJyui9s+zpLPUGQ7iQgpp4uDx8S0Aywqhqy3y7jJsuFK6i/9CykMpqA2/wLp8Ga
         A7HAQBpgMd5QoVePUmMckxEULjZhi1pFq6s9G+darZSfITfLe9x7ypUardyOZrRrpT
         Am0diNuHOI8uCvVg1GQaGik1PYjAZcMfJzaN/ma2DhWg8qfrmdXiU0xgQgkv2xe8G8
         4Nvh8jY1NK6S9fMdyLel/Tue/xekjFJ3wfvZD/y4L12Rv2DD4uUM2Dc/Vln0tyuKF0
         3HGVJ8p1/kH/Q==
Date:   Fri, 20 Jan 2023 13:09:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kvm-x86 tree
Message-ID: <20230120130927.3100f935@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YV=vQxprrYLgPCGt08wsGHK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YV=vQxprrYLgPCGt08wsGHK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm-x86 tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/virt/kvm/api.rst:5070: ERROR: Unexpected indentation.

Introduced by commit

  651daa44b11c ("kvm: x86/pmu: Introduce masked events to the pmu event fil=
ter")

--=20
Cheers,
Stephen Rothwell

--Sig_/YV=vQxprrYLgPCGt08wsGHK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJ99cACgkQAVBC80lX
0Gx50wf+LdJPiMjod6rmkLzOIVM4tYSgp13RXJnEs2OT58qEC8IWyekiGk4Udh5c
XQlXbK0nzeRoQNLzj43ZKENGBUsepwKvSr2M4Q26905nv6GnpkyB+nXI732XCfkH
GMDHkhJG4G6Awb8bIPsaALAoc3D0C8w//zfmXkEW9kP1UZhb7uo7SCmvdMAaob5m
GRiS63Q+FsHDgpzBY2D75Bc06lxmcnMIivvv6a97sJAm+0Oqzjmc0P1/lJT1MWdl
H+//hMKjs9PautjEBtSJl9mKr1miGU/m+mGiKRE1JPJtOTPGLjZSy20RQl3/o1Al
HIG9uiQBe+WQXL6oBXqA71tccXnrzw==
=Gkut
-----END PGP SIGNATURE-----

--Sig_/YV=vQxprrYLgPCGt08wsGHK--
