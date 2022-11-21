Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA15A632F91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKUWIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKUWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:08:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA6C4B73;
        Mon, 21 Nov 2022 14:08:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGM2t33nSz4wgv;
        Tue, 22 Nov 2022 09:08:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669068486;
        bh=2cbfU9T8uRJY4fIhXEopIzcxfcJGZJINvfcdC9ySs34=;
        h=Date:From:To:Cc:Subject:From;
        b=mo4AYP/9YOUQBPoDDsYSy/8CZLZm7k5paJj/i48QizIrS7smDc5LyLTnj29DOhtFQ
         MA3lI70xdzqLgnkvZT63cemVEp3g30IiDTPo/Cq7lwlg2bdZd+JiNNDM9m4qTA4gyF
         fjmdACap7VL5WvemRh0xwzx3AbYynFyhsBIq437/WEa3fYoVf0H+DdC7lhUaSxhC7M
         UVMzys4hbN/nfvPMcOhk3hZmBJUxgxHqAZmSheAhLZCYgEQskLFGF9AAOwjJuNX6jT
         Sh8/lnZSYfQGkM+P3bnh+/lq6OKsnsfz2TRlTC6FmsymR6SBSMUT8j3JIR68FwjCWu
         w/FegRvJk+JFg==
Date:   Tue, 22 Nov 2022 09:08:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pwm tree
Message-ID: <20221122090802.66c8597f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_+fOCkHy5IGQ14fy9o2MhYt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_+fOCkHy5IGQ14fy9o2MhYt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  dd1f1da4ada5 ("pwm: tegra: Fix 32 bit build")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_+fOCkHy5IGQ14fy9o2MhYt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN79sIACgkQAVBC80lX
0GzeOAf/U9UPUcr77BMrp8Cb+YhEeb47XOXRA8oHhU21KRrrIof8/yQj4ubPEfT3
qTLRMiGyqGzyZO4hONAAoxCPS/k/mYzVI58W4Dz18Xa2iPLZQPyMDM5E1qpRpTK7
H8epFi1vwqglmgUIltC8lbscjn4D3JwddGkmNKGD4hRN4O6REI8x+GyHGYvl6/HH
lYjE1pmJCDyHDMUl0sGoqKmx5v+PQGbYb3Z2mtzTYUpsCwakze7OO09ByJQ2/ifN
sSiL+OqHEiofnS8UtxVrKEIDnZFIauhuCch/xCAMHNpUJjf63rOL9p2tKOR40CaY
0ixNIt+r0xK/0OQQD1PLuCMRlONzkA==
=hy6C
-----END PGP SIGNATURE-----

--Sig_/_+fOCkHy5IGQ14fy9o2MhYt--
