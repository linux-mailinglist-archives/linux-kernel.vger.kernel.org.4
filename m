Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0164ADE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiLMCpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiLMCpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:45:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB5C25;
        Mon, 12 Dec 2022 18:45:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWNCG57Y1z4xN0;
        Tue, 13 Dec 2022 13:45:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670899531;
        bh=2yGkq3CbNL/FzRLc/HYh0sTdTpkDj8yTJMEI8pEIaQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xmj/o+W789X87ld0NR1Vn84kiM0TBRufpfMuvyEOMf1xUukMEonxF+k62iaiSaQlm
         0frh6+z0FeNINS90Mv1dglIx6gkz1tWBRl0suW/sAoa8gJXoAwggZeZCXLrhDI5d9e
         KAJ1yBtbQuQo5sWHvpe13TfOV8SqCh80xQ2dGMwIWyTphcIebP3mvcrmhoabCTzP80
         cei2/NDKPnq2NBih919aOjmpJPukBdshI/3SR1+BFHq5lusJajDs3haWMps1YnvyiB
         m4aZA+Phpr30+eyvdhPph11L+2Mp/EjBgb5VOr8dHF6R7lBalMTYSKpyMKzXd1oBz3
         Xvb66noQSsdIQ==
Date:   Tue, 13 Dec 2022 13:45:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Message-ID: <20221213134529.451b45a3@canb.auug.org.au>
In-Reply-To: <20221212182304.fc148bf08bc17e58ec4b6674@linux-foundation.org>
References: <20221213093054.5211da74@canb.auug.org.au>
        <e8dfaf60-ff35-66d3-7bc1-f11eaaef642a@huawei.com>
        <20221212182304.fc148bf08bc17e58ec4b6674@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1823e1rK=+hVA3PrWAmmOVb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1823e1rK=+hVA3PrWAmmOVb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 12 Dec 2022 18:23:04 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 13 Dec 2022 09:34:24 +0800 Kefeng Wang <wangkefeng.wang@huawei.co=
m> wrote:
>=20
> > Hi, this patch relays on Tony Luck's Patch series "Copy-on-write poison=
=20
> > recovery".[1]
> > and tested ppc64_defconfig based on next-20221208, it's no build failur=
e =20
>=20
> I reordered these a couple of days ago, not sure how Stephen got a hold
> of this tree - perhaps I wasn't pushy enough.

Probably, its just what I got when I fetched your branches this morning
(my time).

> Stephen, quoting the mm-everything tag would be helpful, but rarely
> useful so only if you're feeling bored ;)

OK, I will try to remember.

Part of the problem (for me) is that you sometimes update all your
branches in the middle of my day (I am not asking you to stop doing
that - I can cope), so the mm-hotifxes that I have merged early on does
not match the new mm-hotfixes-* branches that get merged as part of mm
(mm-everything) later in the day.  This occasionally causes conflicts,
but they are invariably trivial and fixed by using the versions of
files from the new branches.  I am wondering if maybe I should merge
mm-everything early (but after I have merged and tested all the -fixes
branches) to narrow the race condition :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/1823e1rK=+hVA3PrWAmmOVb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOX50kACgkQAVBC80lX
0GzjpQgAkz0xN/fD+oIjtUhSCZWTiw5/qZIZetObd5VuP4yyziYOXtk/IMCYBdOC
klggtrkTkPoo0RLYd6Mqk0uxoh65KMQoQkiBqiRfZNoL/PuSPe5HLl0y8Jiv/1v9
phv2DbhT4Wfuru6uIBc984B4LUWJ9+rA7QVbHQazxO9RtVtstsvN/txO5TW/S05E
K5LuEyvYR7/Wv59ZaVFQBQdxXfGhw7sgjKd3KHmNTjpirty5/yksmdFfa7/9oot4
VPWBnbFpgSm5roDqZfmnbNDtg+F8fsj7CMF7k4Dj3NzXvIMjeOIj0UWrGyLrD5Zl
tHPbZEBEoK0nDVMoV4fmq71QUEvEEw==
=zjVK
-----END PGP SIGNATURE-----

--Sig_/1823e1rK=+hVA3PrWAmmOVb--
