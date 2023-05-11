Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB06FE902
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEKA45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEKA4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:56:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693AD2130;
        Wed, 10 May 2023 17:56:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGtl43Rlfz4x1N;
        Thu, 11 May 2023 10:56:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683766610;
        bh=q36ZmE9sftj4sy6e6gNn4B4r6kchkg86VVL14Q7l91I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GQXJ4zCM+lj0KX7ZkrM6zRrWlWuh28On20Zf8lU4yWYzmDXG2mc47et+E3FU6Jsd8
         uuIOc0Bu1w/4WI8RFtNZpzQkhlQ7BoQNNWutwOVvK9q1DEAZYUlV7odctB5XFdLZsR
         r1cNLydE94UhatEAsUMa2htL2eeivpTj1fibBgjksN6SVA+MWFn7GkkfSPifhhzryh
         7gzkxkIyILfHcpqrZ+K4zQeOjHeI96n9fJRS+ws6uSspEcBmZfRWOXdqc1chu7c9Su
         37cU4Bs+bXTsv2g2UXdt5lNi/zmh7wytpbfzcdsYZ07dTFTaI+dM47nkUoGL7VZzYt
         1iwOZT+dzej1A==
Date:   Thu, 11 May 2023 10:56:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, laoar.shao@gmail.com
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <20230511105646.7412e6cd@canb.auug.org.au>
In-Reply-To: <CAHk-=wh2nmNs98AUpv6+BZ3x_bNh6ps+nuufQO2Sn6LdXCbC9A@mail.gmail.com>
References: <20230509030611.521807993@linuxfoundation.org>
        <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
        <2023051035-monitor-sandy-2a5b@gregkh>
        <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
        <CAEUSe7_ZBW_hPUZYeKkZ6zuckeqYb+O46GdgGx0wE6T0=c5wZg@mail.gmail.com>
        <4d3c5462-1788-426a-a44a-e839b1c4970d@roeck-us.net>
        <2023051154-activator-aside-bc8e@gregkh>
        <CAHk-=wh2nmNs98AUpv6+BZ3x_bNh6ps+nuufQO2Sn6LdXCbC9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iOvNNEGS0EvxcNYioHkoKCh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iOvNNEGS0EvxcNYioHkoKCh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 10 May 2023 18:09:35 -0500 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Wed, May 10, 2023 at 5:58=E2=80=AFPM Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:
> >
> > Thanks!  Turns out someone put the wrong "Fixes:" tag in that commit
> > which is why I missed it. =20
>=20
> Hmm. Presumably the real commit ceeadb83aea2 at some point got
> rebased, and had had that other mentioned SHA1 before that.
>=20
> It might be a good idea in general - not just for stable - if we had
> some automation that said "this refers to a commit ID that doesn't
> exist".

In linux-next, I report various problems with Fixes tags including when
the SHA1 doesn't exist (or is not reachable from the fixing commit.
Sometimes they are corrected, sometimes not (especially if it is a non
rebasing branch).

--=20
Cheers,
Stephen Rothwell

--Sig_/iOvNNEGS0EvxcNYioHkoKCh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRcPU4ACgkQAVBC80lX
0Gzo3Qf8DJv+Hbi1TducEEdydQQwAvKyyRB8Z3R5qLM/wCqf3q3O79+R5mvQ/Ioj
6Vh14XuZRHi/txaJ/ueJlg89IOJxFawU8MK2KTOybEH/nuaDawlpdByeVKebebQ/
g9Oe2YBWfWB9GYInb9tEqTsBYvZcQInX1tm64Tg4pBCvyJ5YgTW3aLVfoFjLZzXh
8sak2R5vpi33Fxa0uYrFBGducgqyYlrjqgnh3ZoOwmMtmcRGuBPVjaBaKB8jvm0o
gBlTzp0S/89jUcfZl7yQfI7WoyV70ar9BrmM2LPQHYocFcW5W4Xqv7IJbIJffb5k
BU2rkscau5AUmphw71JD2TL/3FDVxw==
=PvmK
-----END PGP SIGNATURE-----

--Sig_/iOvNNEGS0EvxcNYioHkoKCh--
