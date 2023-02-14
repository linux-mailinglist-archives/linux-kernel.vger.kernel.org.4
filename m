Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7F36958E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBNGNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBNGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:12:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62585B771;
        Mon, 13 Feb 2023 22:12:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG9qX5S9Kz4x7w;
        Tue, 14 Feb 2023 17:12:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676355176;
        bh=wWjOzCsGqomhwugnRB9+/uFRB4wXCtiwDrBMDMUTWT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tH6/Erb/bv3eoP8xKOwBu8vTjaMKlxhtQ3Ao/Vzy2ORviLcPlDuiEiGZF9EuxJkYV
         VMqSsGNcZMPggr86yxNTJ0f1zv4yeXU5AzAlh6JTqv760oQD0YOzuqEnyOZuXw9hlk
         0BpmccLJFlpFOmBaHpwQmD+xZ7ONz70K8S5QKaet7KKmZPXJloyyIZjuKyAjYsk9aH
         O+sMncM+akclNXaRux/GLwmWlkMfxdxsUMhEW4B62dcz2uYK80jNoP2tNOLD9KJAd2
         FiGoT1jHfqerv8WtRWyssTvANOUNA2gSoMxKHACS8YOsFD1LCAawAfUDZNcm/fHbLa
         nj5pNVpt3uUYA==
Date:   Tue, 14 Feb 2023 17:12:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: qemu boot log difference today
Message-ID: <20230214171256.556defbb@canb.auug.org.au>
In-Reply-To: <878rh0aknk.fsf@linux.ibm.com>
References: <20230214143150.7c7fdd05@canb.auug.org.au>
        <878rh0aknk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0YtnMci.O9bXV5csRpD7yI6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0YtnMci.O9bXV5csRpD7yI6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 13 Feb 2023 23:19:43 -0600 Nathan Lynch <nathanl@linux.ibm.com> wro=
te:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >
> > Today's qemu boot log shows 256k extra in reserved memory:
> >
> > - Memory: 2046080K/2097152K available (14720K kernel code, 2944K rwdata=
, 18048K rodata, 5184K init, 1431K bss, 51072K reserved, 0K cma-reserved)
> > + Memory: 2045824K/2097152K available (14720K kernel code, 2944K rwdata=
, 18048K rodata, 5184K init, 1439K bss, 51328K reserved, 0K cma-reserved)
> >
> > I don't know what has caused this. =20
>=20
> Assuming it's pseries, it's the RTAS work area allocator reserving the
> memory.
>=20
> 43033bc62d34 powerpc/pseries: add RTAS work area allocator

Yeah, pseries_le_defconfig.  Thanks, I will stop worrying about it.

--=20
Cheers,
Stephen Rothwell

--Sig_/0YtnMci.O9bXV5csRpD7yI6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPrJmgACgkQAVBC80lX
0GxxFQf6A7pXQn80RvrHINP1N5fdDkJtGfgLJZcQodnwkrUFZkPBpFxVw83PAyWj
DDSIHLRd7DCVs32qs2l2wQvy43o/3G/tMBlUmKxjdBcQGEdj2N10qICfLxHhZGkt
7r/YiSDC1AUVV78099tuVJuCrS+LM112YWEsWizVDYT/zUdOK8SEFyF2GGxm6dtl
eRYqqSnrdzaUACY+ACJlNX8qubYHwayX579/sr8+5iG0mxlSY7qonZ3FGA+ED6Kl
Y1YbYC3Bgt3aJe0wJC+MxvOyfcFQEow6uC2RYkMVZ3xS9JKechRAUqD5YoDSe4WW
HLyjQuTGGcti3Wpm0DKHeL/5v7b5RQ==
=UyxE
-----END PGP SIGNATURE-----

--Sig_/0YtnMci.O9bXV5csRpD7yI6--
