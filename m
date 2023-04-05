Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE106D7F05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjDEORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjDEORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:17:32 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B8D30D4;
        Wed,  5 Apr 2023 07:17:05 -0700 (PDT)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ps6Bz417pz9swV;
        Wed,  5 Apr 2023 16:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1680704219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htf8oY2zN7s7CfrqPK2E7qq9nCDox7EcEQCOC7zPblM=;
        b=oPXG/K/tZgTDFSP/g0ZugToiYl5HYUl3zcKwXKzYU1kfwJbWHZUitMq/vnh9r+IyfUE48J
        7q9JOaHrEy160Wiiq8uS7ISfMYjz0twXnwxWR16oQ0p3xfMXXGHRkq5hFeRGsTBQph30X8
        TKUffrcpIBoGi8VsnO/JhyXYeJEK8sbvRP82DALC7Qjq+QRSTFSI1lEIRLFohQjD5jmJlz
        EULZizrCQXUkkGDhVdEuJdNUv5dHJjFIpVF+9XzFI1VRhGtvLrfKSSM298U+sRJbbTS0kd
        z65gnNeNYc4qoBxDRYlpL+PpCEEF8QOVFXCKqayWZzIBq04s5IJ4J3V2QEznUQ==
Date:   Wed, 5 Apr 2023 16:16:59 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Message-ID: <2126933783.670264.1680704219146@office.mailbox.org>
In-Reply-To: <914630853.739773.1680701145159@office.mailbox.org>
References: <1de9eccd-8570-3b69-4be2-347e862bcc33@mailbox.org>
 <CAK7LNATY8PvkDesOBQxLw11t1-OT9EsrNHekjAeOjLDhwPcP8w@mail.gmail.com>
 <914630853.739773.1680701145159@office.mailbox.org>
Subject: Re: [Question] Restore previous "local tag" behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: b4b5770ff6d9110ed7b
X-MBO-RS-META: 6gdifqewmau31sxkybzje61rp4fscdif
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> torvic9@mailbox.org hat am 05.04.2023 13:25 GMT geschrieben:
>=20
> =20
> > Masahiro Yamada <masahiroy@kernel.org> hat am 01.04.2023 06:22 GMT gesc=
hrieben:
> >=20
> > =20
> > On Tue, Mar 28, 2023 at 2:44=E2=80=AFAM Tor Vic <torvic9@mailbox.org> w=
rote:
> > >
> > > Hi,
> > >
> > > When I'm building my kernels, I used to tag my personal releases with=
 a
> > > similar annotated tag commit as with vanilla kernel, just appending
> > > "-tv" or similar to it, i.e. "v6.3-rc4" becomes "v6.3-rc4-tv".
> >=20
> > I do not understand what you want to achieve.
> >=20
> >=20
> >=20
> > Let's say you wanted to release "v6.0-rc4-tv",
> > which consists of v6.0-rc4 with 331 extra commits.
> >=20
> >=20
> > $ git checkout  v6.0-rc5^
> > HEAD is now at 4ed9c1e971b1 Merge tag 'kbuild-fixes-v6.0-2' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> > $ git describe
> > v6.0-rc4-331-g4ed9c1e971b1
> > $ make kernelrelease
> > 6.0.0-rc4-00331-g4ed9c1e971b1
> >=20
> >=20
> > Then, you released it as "v6.0-rc4-tv".
> >=20
> > $ git tag -a v6.0-rc4-tv -m "Linux v6.0-rc4-tv"
> > $ make kernelrelease
> > 6.0.0-rc4
> >=20
> >=20
> > Then, kernelrelease becomes clean '6.0.0-rc4'.
> > Is this what you want?
> >=20
> > It is apparently wrong since there are
> > 331 commits between v6.0-rc4 and v6.0-rc4-tv.
> >=20
> > That is what 6ab7e1f95e96 _fixed_.
> >=20
> >=20
> > The behavior is now clearer and correct.
> >=20
> > $ git describe
> > v6.3-rc4-174-g2bac7dc169af
> > $ git tag  -a v6.3-rc4-tv  -m "Linux v6.3-rc4-tv"
> > $ make kernelrelease
> > 6.3.0-rc4-00174-g2bac7dc169af
> >=20
> >=20
> > If you wanted to make a "-tv" release,
> > you would want to change the version field in Makefile
> > before tagging.
> >=20
> >=20
> >  diff --git a/Makefile b/Makefile
> >  index da2586d4c728..8639036f5095 100644
> >  --- a/Makefile
> >  +++ b/Makefile
> >  @@ -2,7 +2,7 @@
> >   VERSION =3D 6
> >   PATCHLEVEL =3D 3
> >   SUBLEVEL =3D 0
> >  -EXTRAVERSION =3D -rc4
> >  +EXTRAVERSION =3D -rc4-tv
> >   NAME =3D Hurr durr I'ma ninja sloth
> >=20
> >   # *DOCUMENTATION*
> >=20
> >=20
> >=20
> > Then, kernelrelease shows it is a "-tv" release.
> >=20
> > $ make kernelrelease
> > 6.3.0-rc4-tv
> >=20
>=20
> Hi,
>=20
> sorry for the late reply, and my explanation was not very clear indeed.
> The above suggestion is what I'm looking for, but without modifying the s=
ource.
>=20
> Let me try to give an example:
>=20
> 1. In sourcedir; source is at a tagged release:
>     $ git describe HEAD
>     v6.3-rc5-tv
>=20
> 2. Copy the kernel config which has LOCALVERSION_AUTO=3Dy and LOCALVERSIO=
N=3D"":
>     $ cp /path/to/config ./config
>=20
> 3. Run oldconfig:
>     $ make oldconfig
>=20
> 4. Run kernelrelease:
>     $ make -s kernelrelease
>     6.3.0-rc5-0071-g0f69b90f
>=20
> Expected: 6.3-rc5-tv (or maybe 6.3.0-rc5-tv?).
>=20
> I tried adding the exact tag to the 'localversion' file, but then I get t=
his
> concatenated string:
>     6.3.0-rc5v6.3-rc5-tv
> And only adding "-tv" I at least get something better:
>     6.3.0-rc5-tv-0071-g0f69b90f
>=20
> I do agree that the new behaviour is more correct, I'm just trying to fin=
d a clean way
> to have my tag as kernel version for "releases".
> If there is no other way, then I'm going to use your suggestion of changi=
ng Makefile,
> which I assume can be done with a simple sed command.
>=20
> Sorry I'm confused in a very "noob" way....
>=20
> Cheers,
> Tor Vic
>=20
>

Hi again,

You don't need to reply.

I've decided to change my build script according to your suggestion of usin=
g
EXTRAVERSION in Makefile, which seems to be the easiest and cleanest way of=
 getting
the desired result.

Thanks for your help!
=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > This has worked just fine so far, but...
> > >
> > > Since commit 6ab7e1f95e96f0c688ae132b0e9a16c0f206689d ("setlocalversi=
on:
> > > use only the correct release tag for git-describe"), this is not take=
n
> > > into account anymore, it uses the "git describe" tag instead of using
> > > the actually tagged commit as "kernelrelease".
> > >
> > > Is there a way to restore the previous behaviour without having to
> > > revert this (and preceding) commits?
> > >
> > > I know that we can disable CONFIG_LOCALVERSION_AUTO=3Dy and append
> > > directly to CONFIG_LOCALVERSION, but maybe someone knows how to use t=
he
> > > "old" way of using tags...?
> > >
> > > In other words, when I have a local tag, I want "kernelrelease" to us=
e
> > > just that tag, and when I don't tag anything, it should just use the
> > > standard "git describe" tag.
> >=20
> >=20
> > Again, I do not understand.
> >=20
> > git tag is not stable information.
> >=20
> > If you call it "a release",
> > you would want to work in the same way with/without git
> > even if most kernel developers are working in a git tree.
> >=20
> >=20
> > The mainline kernel, stable-kernel, linux-next are
> > released in https://kernel.org/
> > (and GitHub allows users to download a tarball of
> > a tagged commit.)
> >=20
> >=20
> > A released tarball (of course, there is no tag there),
> > produces the same kernelrelease as the git tree does.
> >=20
> > You are requiring the kernelrelease be different
> > with/without the *-tv tag.
> > That is not what the release would look like.
> >=20
> > The mainline kernel and stable kernel increment
> > the version field in Makefile.
> > linux-next has "localversion-next" at the top of the tree.
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > For the moment I have just reverted the related commits as they don't
> > > serve any purpose for my needs.
> > >
> > > Cheers,
> > >
> > > Tor Vic
> >=20
> >=20
> >=20
> > --=20
> > Best Regards
> > Masahiro Yamada
