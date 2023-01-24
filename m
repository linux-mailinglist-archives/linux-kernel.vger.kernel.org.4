Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB80678CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjAXAQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAXAQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:16:28 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 16:16:27 PST
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EA33469;
        Mon, 23 Jan 2023 16:16:27 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4P16jv4C2JzywR;
        Tue, 24 Jan 2023 11:07:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1674518869;
        bh=xC8k8pOE20QRWA6pPxReHv2uJ4xU94/Sp26MY5/WqB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kCEUYJLZ+zX6sF6CIHDBw534K6xAqxCEExi3nDAObXszuD+ko+F6mmqYUt2Q4IzXg
         QUo4+Cl13nCK01cWnQwWjdTUWnDP2jv9AOoHUzJ/MC+lBDiIxAy1vW+7FQ/2VU16Cl
         QrNPjqC+/wOhXogKzDHV9geU2GXJ3qN5rVb/1YNhq2nTN5pbfmNIr1NdAaJV6MJYR4
         XnOdc1t7PjFOfn7qHJafQOZzkZlydXH2dxwnGA+B6pTld6BDXwE1sugrdaelE5zVpo
         sGndCNTNIGnkqiI8H3QSrKqSeMdXeDY35DNqHn8XV5fOLOp2iB7TGumlkFcFP8voyb
         +Pdtoa+/AWepg==
Date:   Tue, 24 Jan 2023 11:07:45 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the zonefs tree with the
 vfs-idmapping tree
Message-ID: <20230124110745.5c9b78b0@oak.ozlabs.ibm.com>
In-Reply-To: <87958074-baa4-b6c9-da0c-d654e4009611@opensource.wdc.com>
References: <20230124085951.59eb8da3@canb.auug.org.au>
        <1631b427-9efd-cd26-5dbc-0143097f859b@opensource.wdc.com>
        <20230124102535.1e21a533@canb.auug.org.au>
        <87958074-baa4-b6c9-da0c-d654e4009611@opensource.wdc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YPDvbG7j3xU=w=361754An1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YPDvbG7j3xU=w=361754An1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Damien,

On Tue, 24 Jan 2023 08:30:29 +0900 Damien Le Moal <damien.lemoal@opensource=
.wdc.com> wrote:
>
> OK. I think I will merge the 3 patches that create the conflict and rebase
> the patches. I need that for retesting at least. But given the size of the
> conflict resolution, I may push that as an update to my for-6.3/for-next
> branch. Let me see...
>=20
> > Alternatively, just leave the fix up to Linus (but mention it to him
> > when you send your pull requests). =20
>=20
> Understood. Let me retest first :)

When I said "merge", I meant literally "git merge <some stable branch
from the vfs-mapping tree that contains the conflicting commit>" not
cherry pick the commits i.e. you would need to coordinate with
Christian about having a common branch (or making sure that the part of
his tree you pull in is immutable).

--=20
Cheers,
Stephen Rothwell

--Sig_/YPDvbG7j3xU=w=361754An1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPIVIACgkQAVBC80lX
0GxRDwf/fxiCI0xw9MtLUFRDGNETz1EvYNG8l1uF+wEnUoICM4TVd473Siuh01WL
qXNbGIRY1unql7e4nmmshEq8lON3cdOYy0kE0yhcvIOJ2qY6Pqg3AOM/sp6FyCev
2rprIKjVzEeMLqRgh69nFNCrBIJexSboTnhQbqsLmNxrR+lomE0zWOF9H5Ycib46
2VGlWgDEfxFOrHYCuTIcPm0iyqYsYUeXB4Ejnvu+YdmmLXP0mTbPsLugS4FsSaA+
zcNtggcbn/m4OB/nURLwhMf3BELUl10YTIsk660auBBs+DWwQyODYNK7hDBfT2rA
ErfBzndFmIYJpiNC87OLkKJ8cGrJVQ==
=YZlu
-----END PGP SIGNATURE-----

--Sig_/YPDvbG7j3xU=w=361754An1--
