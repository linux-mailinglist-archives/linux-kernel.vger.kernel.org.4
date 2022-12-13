Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31764B2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiLMJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiLMJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:50:34 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E918B1E;
        Tue, 13 Dec 2022 01:50:27 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.245]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Myevl-1oiHwb0CmD-00yviF; Tue, 13 Dec 2022 10:50:00 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 297693C0EE; Tue, 13 Dec 2022 10:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1670924998; bh=j2FuJR2hJ9kTpSOuWg/6tab4lmcts8FkJUw55kxSFJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mABKFXFH6uYeWbohae22XXef3Qg3l1vs8mPyiKa4UbHlImTbZAZ1hZqVR0oN5fY8S
         UDhmO8dk/OjS4RJ7kou5fSoYJO6SfY7uIlpDdhrtEIYAo7unhTM0Twl3zLdT91ipiC
         7EeRdR+7OmTNFhc4WDG+DZHST7NRn6fDH7MIAO+U=
Date:   Tue, 13 Dec 2022 10:49:57 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: do not sort after reading modules.order
Message-ID: <Y5hKxddAEyWU5kIq@fjasle.eu>
References: <20221211094919.2717594-1-masahiroy@kernel.org>
 <Y5f8/BCOpJAqKgcd@bergen.fjasle.eu>
 <CAK7LNASE5rMVXPryqs_VYh2fy47CUeNiV=90dJVCP359p-LWdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAK7LNASE5rMVXPryqs_VYh2fy47CUeNiV=90dJVCP359p-LWdg@mail.gmail.com>
X-Provags-ID: V03:K1:/fBCWN3Lgd+wddg4xF6Nc3JmPmUHQjhszhDRlik3JVnU7ABD/mn
 bOVxAwXyOPrlCcen8PL1dctnC29BoZ/mFf3X+oLwiCAszVDDBjazcalNjOcqlVCHmHQT41r
 jJ5mdXM7b6gF9nc/OlC267DcD4K32ldWAFkFCI2sglVCixRmR87STx33Rnp1gnFPyFyGptl
 u/+Z/Zirbn+i3TRpvrzrw==
UI-OutboundReport: notjunk:1;M01:P0:dsm0u6hJVvs=;HX/VA7sqkp1O4mHMxouK/LXbFMe
 I+jP6uWpAW1b3Oe6RIScauGDmbV3GFxM2o2pruoOQPMOr7HvMSyKkjbHv26hvDRLTQKaGrxA9
 00sG7VFk23OYlzyB+3BVFchSwBNCr+61D5iZq60kmHNm9KCQApQFh89eSN/I2z/7Gasr1p939
 jy73HTWhbV0+Us+aF2s9iCCRkF4ND3lGIad/dF0FGvwwet91Gnzbn5b4/YDYleWnlfJrrM3tO
 Ct1b+CzvJNoVIn/c5HhfCpvd6OBdmorcoPzR4tpYlLdahbDTzb3FWj/Nk6LVTr2P+8HL96XaY
 x/KKDAwlYKeiRl9dI4kySfoss4TUy3SFqDul5W8AJbTlmHDWBs5+YhVS3Nqk7DVrdfKllZ2IP
 fFWb0KgNK9o3dY5uV2xSNd5hYwoWKXuwk6XoOFieCRCX0hijnr5lzaOvJ10bcKx3CH+5ZVflk
 UCM161r/pI37BHRvdT99cf2E8o4MGhDE4Oye8u0PA+Y+/8uSr85CuxsQAfsqXBlwundMqJ0IQ
 QL1ovcxyia4++qzJ83AxrYojfGU1l0qNPcedTQh4ro9wcq8btf6uT/PHgaHeX3q0wX72ibA9+
 2/cqqlCRyON8+xGhOg5Ql5WB6TOzGT0JImYh7omHQHVa81QENqpGtUBa3lsivxaI+JTESjsfq
 lpepDH8hYuTF9wDXj/arMfBoeVwjukATejgDn+q3eA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 03:41:36PM +0900 Masahiro Yamada wrote:
> On Tue, Dec 13, 2022 at 1:18 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Sun 11 Dec 2022 18:49:18 GMT, Masahiro Yamada wrote:
> > > modules.order lists modules in the deterministic order (that is why
> > > "modules order"), and there is no duplication in the list.
> >
> > Isn't a subdirectory's modules.order just created by
> > concatenation of $(obj-m) (w/ respect to mentioned subdirs)?
>=20
> Not $(obj-m) directly.
>=20
> The magic is $^, which is a deduplicated list
> of prerequisites.
>=20
>=20
> > Thus, "no duplication" seems to be true, as long as there is no obj-m
> > containing duplicated entries.  Do we ensure unique entries in obj-m
> > only?
>=20
>=20
> The entries in modules.order must be unique.
> Moreover, the basename of modules must be unique.
>=20
> scripts/modules-check.sh is a stronger check.
>=20
>=20
> You might be interested in these commits:
>=20
> d724b578a1f746db6fc1fd5e4cbba554a855dc8d
> 3a48a91901c516a46a3406ea576798538a8d94d2

ah, thanks!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> > >
> > > $(sort ) is pointless.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/Makefile.modfinal | 2 +-
> > >  scripts/Makefile.modinst  | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > > index 25bedd83644b..4705d32388f3 100644
> > > --- a/scripts/Makefile.modfinal
> > > +++ b/scripts/Makefile.modfinal
> > > @@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
> > >  include $(srctree)/scripts/Makefile.lib
> > >
> > >  # find all modules listed in modules.order
> > > -modules :=3D $(sort $(shell cat $(MODORDER)))
> > > +modules :=3D $(shell cat $(MODORDER))
> > >
> > >  __modfinal: $(modules)
> > >       @:
> > > diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> > > index a4c987c23750..f4cff42069ad 100644
> > > --- a/scripts/Makefile.modinst
> > > +++ b/scripts/Makefile.modinst
> > > @@ -9,7 +9,7 @@ __modinst:
> > >  include include/config/auto.conf
> > >  include $(srctree)/scripts/Kbuild.include
> > >
> > > -modules :=3D $(sort $(shell cat $(MODORDER)))
> > > +modules :=3D $(shell cat $(MODORDER))
> > >
> > >  ifeq ($(KBUILD_EXTMOD),)
> > >  dst :=3D $(MODLIB)/kernel
> > > --
> > > 2.34.1
> >
> > --
> > epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> > =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
> >      -- frykten for herren er opphav til kunnskap --
>=20
>=20
>=20
> --=20
> Best Regards
> Masahiro Yamada

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
