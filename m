Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989063A8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiK1MpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiK1Moh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:44:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED22B65A1;
        Mon, 28 Nov 2022 04:44:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLQCJ6VLxz4x1H;
        Mon, 28 Nov 2022 23:44:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669639469;
        bh=k0uUVCZ1nUoWE2jqd424nzIZGKnRyZrs5TKCPdfAisI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tSry0xu8csQVM+mDrj9FSRleAE7NgTGgf6tWxCMSF8wXP7+yNOJ3ccUNcXDGgZlGl
         OGgpmsNupnYBDsHa4sz8cuQFzDifnEikzLQZB7CrgbqXY+whDHXW6bl0GCvtGTgnIj
         PMEH+vUcNRMhRbsi7/KvOHuLzXEUqUvjq5uRDtvPY/TkSucIzn+f3uqgbNOtf57o7e
         egUW3I0IALJibEja+Wj/h3YmD/dKfxFUl+yhmyC2sRHMDa8/UQm+TMlop6oWlNQErf
         LmKMiOOywe8+2M67FTgBM1BqAlyV1g94+vBbQbghNoOrLTk1veFjqW2PXuiEsoDjkx
         X0T8qN4Ki6o0w==
Date:   Mon, 28 Nov 2022 23:44:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <20221128234408.7a4dec34@canb.auug.org.au>
In-Reply-To: <Y4Sga+ONeDe9Q7yz@kroah.com>
References: <20221128133600.14ce44bf@canb.auug.org.au>
        <Y4Sga+ONeDe9Q7yz@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iDLLG2gcqxANPr9VJLmkav/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iDLLG2gcqxANPr9VJLmkav/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 28 Nov 2022 12:50:03 +0100 Greg KH <greg@kroah.com> wrote:
>
> On Mon, Nov 28, 2022 at 01:36:00PM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the driver-core tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >=20
> > arch/powerpc/platforms/book3s/vas-api.c: In function 'vas_register_copr=
oc_api':
> > arch/powerpc/platforms/book3s/vas-api.c:590:38: error: assignment to 'c=
har * (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct =
device *, short unsigned int *)'} from incompatible pointer type 'char * (*=
)(struct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsi=
gned int *)'} [-Werror=3Dincompatible-pointer-types]
> >   590 |         coproc_device.class->devnode =3D coproc_devnode;
> >       |                                      ^
> > drivers/misc/cxl/file.c: In function 'cxl_file_init':
> > drivers/misc/cxl/file.c:687:28: error: assignment to 'char * (*)(const =
struct device *, umode_t *)' {aka 'char * (*)(const struct device *, short =
unsigned int *)'} from incompatible pointer type 'char * (*)(struct device =
*, umode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} [-=
Werror=3Dincompatible-pointer-types]
> >   687 |         cxl_class->devnode =3D cxl_devnode;
> >       |                            ^
> >=20
> > Caused by commit
> >=20
> >   ff62b8e6588f ("driver core: make struct class.devnode() take a const =
*")
> >=20
> > I have used the driver-core tree from next-20221125 for today. =20
>=20
> Hm, how do we resolve problems like this where an api changes in my
> branch but needs to be updated in another branch that is not in Linus's
> tree yet?

That is not the case here:

$ git show ff62b8e6588f:arch/powerpc/platforms/book3s/vas-api.c | grep copr=
oc_devnode
static char *coproc_devnode(struct device *dev, umode_t *mode)
	coproc_device.class->devnode =3D coproc_devnode;
$ git show ff62b8e6588f:drivers/misc/cxl/file.c | grep cxl_devnode
static char *cxl_devnode(struct device *dev, umode_t *mode)
	cxl_class->devnode =3D cxl_devnode;

You just need to add a commit to your tree that updates the missed cases.
--=20
Cheers,
Stephen Rothwell

--Sig_/iDLLG2gcqxANPr9VJLmkav/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOErRgACgkQAVBC80lX
0GyQqQf/UVldQV9PIdQWiqi842assrp39aI1qOW0OwrZuA1lYtaoFD3Deku1+eUJ
h+hFaK3NRuHYN8G+eDAXvfB1qbM/h1oiMNYsJtxGdSrdPurWFyHuFu/TLRUVUzu1
7FeBIwJMAlbb68P0lH5g0OWnjtS+fNEhz0uEsdhDUASrCtp6qiNw5Nar77skrrOb
XsFSOPeAxO/wuFu+wyA3csezISoQ/F8XCBiehumJq1Myb0JyZX720f0vHXiNOucR
/DyPrfjL44BClIz63kH0y/2s2wSqhVjSg/+psndp80ILjWxZB5R8Uc+1O+v95DOH
Qlnhd8oY7D0yUtGiXuXwnS4g0BJbtQ==
=Iwte
-----END PGP SIGNATURE-----

--Sig_/iDLLG2gcqxANPr9VJLmkav/--
