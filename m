Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD663BD05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiK2JeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiK2JeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:34:19 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DC82AE2B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:34:17 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AT9Xvnv018526
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:33:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AT9Xvnv018526
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669714438;
        bh=W7/cBOhC6ZWzKLNByGDtoOjb1UE7rlpyI0vm5uWvnSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xVQmEFZ1CE9o3mHpfyU7Q+Ga+U8knXckkKGGpOLb/IMTb3Pq5j40cX2JZGWtePMtv
         LJ/6uv1ZyZtlYT4A1tLP2TQi7vUr/Mh7yJTQVrTZ9QQmsYK2JjqabOpHK++rNGXIy8
         fQWTIqVvpGcPthYl9m7iucm5qqFiSi9466FoCNZod759lFHpJU/AFK3sP52RjlvXmJ
         V2GTEvMwhP7tOhhyZG1Ilcr9XnqOvPQTyfvZ6L/lIWu3ZHKHoNhmsgM3J+tr0yJpeJ
         hR2PB0sEYSTfg8qGivjnm1T/kNjwQsIx87ChVX3I1jolT35Xho+tvi8/+4yfg288O4
         DhlErQTSCiVgw==
X-Nifty-SrcIP: [209.85.167.171]
Received: by mail-oi1-f171.google.com with SMTP id s206so14552921oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:33:58 -0800 (PST)
X-Gm-Message-State: ANoB5pmnYmvgV0lB4JnMCWtF6usQpnzhQ0KLoB85z/qF0PSuUX6LQVJI
        klyi4/azWieyJVu8jWHRfRQvLrm73GUW0gVxUTg=
X-Google-Smtp-Source: AA0mqf7vHeDdYzAXYz0tuXeexOFIFTJiCn/xCThNETAbcH1WOB0n2+wXfFWCa2ytnJNfBnXFSmMWIjoKu/QkpHjK1B8=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr17933150oib.194.1669714437267; Tue, 29
 Nov 2022 01:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20221126051002.123199-1-linux@weissschuh.net> <20221126051002.123199-3-linux@weissschuh.net>
 <CAK7LNAREVSp_5d1SaFOLyBHJJrJ6zE_qxSYWAFFnfoz3d0w3-Q@mail.gmail.com>
In-Reply-To: <CAK7LNAREVSp_5d1SaFOLyBHJJrJ6zE_qxSYWAFFnfoz3d0w3-Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Nov 2022 18:33:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmk3_L3_QwpsBR_uKN+3kE8F5h-QdOGLz8WOSx05CFRg@mail.gmail.com>
Message-ID: <CAK7LNAQmk3_L3_QwpsBR_uKN+3kE8F5h-QdOGLz8WOSx05CFRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] init/version.c: remove #include <generated/utsversion.h>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 7:18 AM Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
>
> On Sat, Nov 26, 2022 at 2:10 PM Thomas Wei=C3=9Fschuh <linux@weissschuh.n=
et> wrote:
> >
> > Commit 2df8220cc511 ("kbuild: build init/built-in.a just once") moved
> > the usage of the define UTS_VERSION to the file version-timestamp.c.
>
> With s/UTS_VERSION/UTS_RELEASE/,
>
>
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
>
> >
> > version-timestamp.c in turn is included from version.c but already
> > includes utsversion.h itself properly.
> >
> > The unneeded include of utsversion.h from version.c can be dropped.
> >
> > Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> >  init/version.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/init/version.c b/init/version.c
> > index 01d4ab05f0ba..f117921811b4 100644
> > --- a/init/version.c
> > +++ b/init/version.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/printk.h>
> >  #include <linux/uts.h>
> >  #include <linux/utsname.h>
> > -#include <generated/utsrelease.h>
> >  #include <linux/proc_ns.h>
> >
> >  static int __init early_hostname(char *arg)
> > --
> > 2.38.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



This patch is so confusing because the subject is also wrong.



I fixed up the commit description:



    init/version.c: remove #include <generated/utsrelease.h>

    Commit 2df8220cc511 ("kbuild: build init/built-in.a just once") moved
    the usage of the define UTS_RELEASE to the file version-timestamp.c.

    version-timestamp.c in turn is included from version.c but already
    includes utsrelease.h itself properly.

    The unneeded include of utsrelease.h from version.c can be dropped.

    Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
    Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



Applied to linux-kbuild.
Thanks.






--=20
Best Regards
Masahiro Yamada
