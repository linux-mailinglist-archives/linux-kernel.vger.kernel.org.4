Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283ED6730EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjASFFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjASFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:04:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E74DE2D;
        Wed, 18 Jan 2023 20:58:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny9PH1sMMz4xG5;
        Thu, 19 Jan 2023 15:58:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674104291;
        bh=78mZuHN8lfebdX+am20yyCiUWINHe53KM7xnBzY6pfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hg2U9BKCj3pAjUTI/24TJqtpMTLJO2xdYI6snTAvOEniK6PqLvi9xLCvTOXAGJO4D
         btPCKLMG5srU6kVpcl6JLnJXwOSn1Di+DOzUnYQEYLGksFdoACOcQzenctGeIA5QkG
         NDgjedv9Re/OAn/9lJTIzVMjeMknez6dqEIw9YAfHXvKoR1eVXpUNS47b4+5Id24+j
         Ea6mg/X1mBBr7Qke7aN5RnTXAjuhXQWvJB2yJkQntYgTOKpTgMrkRJ5uSifj9zAp13
         CO7A0+iS7LvUZFR8zJdDNcXC24Z86BeEY5uUD55wcqHdvmHKyfXdhXfNqRgHI2iQjX
         S3sP39JNl6acw==
Date:   Thu, 19 Jan 2023 15:58:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with the cgroup tree
Message-ID: <20230119155809.33625b3a@canb.auug.org.au>
In-Reply-To: <20230106125915.60c8b547@canb.auug.org.au>
References: <20230106125915.60c8b547@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YNDi1t5=QTE0J_.xk0Ecumf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YNDi1t5=QTE0J_.xk0Ecumf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 6 Jan 2023 12:59:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the mm tree got a conflict in:
>=20
>   Documentation/admin-guide/cgroup-v1/memory.rst
>=20
> between commit:
>=20
>   da3ad2e14f63 ("docs: cgroup-v1: add internal cross-references")
>=20
> from the cgroup tree and commits:
>=20
>   6cd7ad27c60f ("mm: memcontrol: deprecate charge moving")
>   9bf9f4ba8bd5 ("mm-memcontrol-deprecate-charge-moving-fix")

These have been combined into commit

  da34a8484d16 ("mm: memcontrol: deprecate charge moving")

in the mm-stable tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/YNDi1t5=QTE0J_.xk0Ecumf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIzeEACgkQAVBC80lX
0GxvQwf9EaVuh34vLQHdxOa+RZgMmMex/KAnIt+3tRY5jb9NZyJrohO9mLaNqyYy
x1brq+CCwQ5a/IHpPr88R469RMuSWKC2v+EqxYayCmylhv7vLf3gffn+rlKTSV3g
HArGWUYRvziJpDIsxuPmiO5FZ8PL42SUvRbzaHu6c6Z59K7QP0qLtdAPhDtlLIXm
Ci75FJe1p4bclIqMvCa0tdJamrlLvIg00sO7W5h0bKMWBIeKV8xoLGHh4MRNsXvJ
/6sXIK3aoR9pNfiBEJOfbxGBpj5QVjxz6EfjwETV1IZ629fx3Gq6cv3HVi6P+Dmd
ZYiE8QQlaDUnLSBY+WT4bQT9Y82ddA==
=Dv/6
-----END PGP SIGNATURE-----

--Sig_/YNDi1t5=QTE0J_.xk0Ecumf--
