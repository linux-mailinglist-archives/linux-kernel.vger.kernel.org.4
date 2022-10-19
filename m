Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20E60519A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiJSUvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJSUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:51:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671202DA82;
        Wed, 19 Oct 2022 13:51:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mt2vb63NCz4xG5;
        Thu, 20 Oct 2022 07:51:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666212685;
        bh=DfjPzWicNjLn7IeXGHWc5EQy2WPvk5V1GFJNgfL16nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T20JP/bdiiCFc1JwJQZDjEkmauDfhUalDaPwPU8E/qptp3NhHfdPENx/QNpQuZ1fX
         vJrL5c5/0T6Lzp1f94HcVPE1S/y68r0aFq/U7D7GPjQnSzQHOyH7B/zcksY44SJn3a
         P6TUsR6vbXpNLEVX0KKPQo8bYcIZ0UrygHShThHepOuGbC1pWl4/R3aUXiK+3pfkem
         UhoTpLpLHVOgZAotIQHCxdpS9dDg5pjaOHw+hy3m5nB7ls/jn1V9gTEHrixZWdRd+4
         rPRHNFjCM5cwSyKMNh44TUjba1cyL2TV1jDWGwUTE96KFTtr0l210gJBEACVimy6WD
         8pz3sPup3jAnw==
Date:   Thu, 20 Oct 2022 01:06:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the mtd-fixes
 tree
Message-ID: <20221020010629.3e6e3d03@oak.ozlabs.ibm.com>
In-Reply-To: <20221019154907.33bbcb52@xps-13>
References: <20221019092812.7d370b06@canb.auug.org.au>
        <23d311953ef13608be2283a05b2e853d@milecki.pl>
        <20221019180807.6dac24a0@canb.auug.org.au>
        <20221019154907.33bbcb52@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_ePlymXBJzozCLXe_+Y74t8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_ePlymXBJzozCLXe_+Y74t8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Wed, 19 Oct 2022 15:49:07 +0200 Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
>
> Thanks Rafa=C5=82 for the right resolution and Stephen for carrying the f=
ix.
> I'll send the fixes PR soon and rebase on top of an -rc containing it
> to avoid this conflict resolution to be needed when sending the final
> PR to Linus during the next MW.

Why not just merge your mtd/fixes branch into your mtd/branch (rather
than rebasing)?

--=20
Cheers,
Stephen Rothwell

--Sig_/_ePlymXBJzozCLXe_+Y74t8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNQBHcACgkQAVBC80lX
0GxPkgf/ZUc7GqxpjycX9ZcL6Zx1tpTRkSj9RPYPcgv+08hcIkDlgHBhAfu6pFg2
nzrCma3qRZxZ1AyZzHd+62/l5EQ+3xTB7gXPx4UjxrH2ZoUVWYdmeDmU5Im6F3ZC
Q+lnGWC1E2KTtDf3xWr29UDSAejEXOgAYg2hKEK6Y4puvkxkLuSK0Gr4r7QVMowi
ah+/F2gob8Vr4SMdSTQlDXsCXfHNiAMoCWLkQ1xbRAFemfZC/jlgoMnNiIOFDXxu
O7g3/0cw8KBUMWdB9yT5bO0TmVkhjnkT/1ZjzeE/UrhScAAITbsIoN80BNlNVbsK
ZkEWghOlshiIcI1DCiq+1ChdmG9vVQ==
=uKVO
-----END PGP SIGNATURE-----

--Sig_/_ePlymXBJzozCLXe_+Y74t8--
