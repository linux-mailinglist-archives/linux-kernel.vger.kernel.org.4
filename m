Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7574A7E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGFXlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:41:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B61BE8;
        Thu,  6 Jul 2023 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688686869;
        bh=+DVSaSUi5APaXwzw07vQzluUGo109C77HYV67pR+4E8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nFM9kTLOQ88vZSo8rFMkcFGMt0izYxBZH2kpODy0UyJ9Qw0amJ3zK/9cEMHoDAPyF
         f6CoYJpL7fXjOi4O2ioaGiiS1yR+ql3u2xCGQNY8np8z3X4rcIgBvH5447uJSbiuI0
         dXhYjw8aCrYMOJD/2NIBIh782DOQws2Zgmt3xcIjeiNCPUNMcqmTyPZGIiol//tu6N
         iKjFEEj8SDHdCATZs77A31F0utp/mMP/wD2oW3n5HpJP+M1jgJM2afc9Nxvj9WE9J9
         DAWI+wKMtLs2oe0J/RXN+ZsK1z1yYZnppr5Bj5pSUgyYr3rv5jpTf43pXf2wrM/0iA
         8Ew3JS5q3WSNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxtMS6W4Kz4wZs;
        Fri,  7 Jul 2023 09:41:08 +1000 (AEST)
Date:   Fri, 7 Jul 2023 09:41:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230707094107.4964f91f@canb.auug.org.au>
In-Reply-To: <20230616083237.421dff9d@canb.auug.org.au>
References: <20230613130258.73be7f1b@canb.auug.org.au>
        <20230616083237.421dff9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=QcSNFvGjY/Vs0OrMlznfMh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=QcSNFvGjY/Vs0OrMlznfMh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 16 Jun 2023 08:32:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Tue, 13 Jun 2023 13:02:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> > =20
>  After merging the bluetooth tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >=20
> > ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefined!
> >=20
> > Caused by commit
> >=20
> >   817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
> >=20
> > I have reverted that commit for today. =20
>=20
> I am still reverting that commit.

Ditto

--=20
Cheers,
Stephen Rothwell

--Sig_/=QcSNFvGjY/Vs0OrMlznfMh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSnURMACgkQAVBC80lX
0GwNuggAn0YP9h2AaXGQFN/iKx+y4/PZz8YvBKrm1lf3G6UWuww1OtC5XSw1CQ+h
S0JJPzcmZI1cNgfPHs9hvCSiqh+3oT9ITpfm80PUahvnJLxM4xVEKpyaSiYwADQx
ajhI2kkLgEux2qezOjUalD3OnahWvGw9ukEorLnS6rAbSZOu+0HVFk6rUMLDl2Si
OougKKbZN3fi6DO1oXDuFcoU5ncfai19YMR87tbNEwmVCE6vZxNzxSj3ZLURSBsL
qnc+QyswA+iiIY9MaZ54n7LhS+nc4ZYox7Vsush33+GtT5/u1rOKIUjUSiUqzmzi
sZg3J7bY5SSXtT2hGTVpLpXfMYqKpQ==
=dX1G
-----END PGP SIGNATURE-----

--Sig_/=QcSNFvGjY/Vs0OrMlznfMh--
