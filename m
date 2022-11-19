Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11000630EF9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 14:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiKSN2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 08:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKSN2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 08:28:12 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC847AF62;
        Sat, 19 Nov 2022 05:28:08 -0800 (PST)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2AJDRf1q010269;
        Sat, 19 Nov 2022 22:27:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2AJDRf1q010269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668864462;
        bh=wAXMhSJey5VSvKgw6HCvXuj93I1hlQIEOyp+rwYZByg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=udta5oV2rfhZKcR2MtcR38KBFh6/uqX+F7iisjMW5+10jtF6UQI9uqWOx60nPP9Mz
         K+vEUzCDrnwuEVKr7Lo9dEA0jgHSYT22bPfKaS7BfEO/23V5Yn7AgV008K7tdPF1Fv
         w28yD+ssOpkClD18PJdYmNRCXduFpIiIy6yeaekZwZXd2XAXa/1M8HckNQlKknQKUV
         nL2KwZV/cLs4W+wTsm21I2p+Fq0nsE+K/UnmKniKVCztNZRP2zYABiqEV/eAiV/f8W
         83mM06F+ZXYzmpBxh4nydkwfE9aUCbHCxljg0trij2+92PP98tF+KEXjivj5KyCxkz
         Z0r6ulOHZ3P6w==
X-Nifty-SrcIP: [209.85.161.41]
Received: by mail-oo1-f41.google.com with SMTP id o140-20020a4a2c92000000b0049effb01130so1176245ooo.9;
        Sat, 19 Nov 2022 05:27:41 -0800 (PST)
X-Gm-Message-State: ANoB5pn38CIk+q0S0Gx6Bt7OGF3qLfHkKaZupAzr17PrUYPVKXLT/z5i
        cDZPRMHArdN5wyi2kJmjATsbmgJuI5w0wA90Hwo=
X-Google-Smtp-Source: AA0mqf6XzWLHsPIdmgP8chub/cRX8/Fvp3IqeLVQ+n1Vo/B1UPAu+IZq+JU5ZzzXJJHhnxFBp6Y5zZaukuR/pAQrwFU=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr5352439ooo.93.1668864460545; Sat, 19 Nov
 2022 05:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20221118150351.GV28810@kitsune.suse.cz> <b8191c01-4d78-537b-9650-a783e14e5997@infradead.org>
In-Reply-To: <b8191c01-4d78-537b-9650-a783e14e5997@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 19 Nov 2022 22:27:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBhTvzkjXuJDH8ePCVXnZ=GUYdNa-OU+QURbBp3oyEBQ@mail.gmail.com>
Message-ID: <CAK7LNASBhTvzkjXuJDH8ePCVXnZ=GUYdNa-OU+QURbBp3oyEBQ@mail.gmail.com>
Subject: Re: build failure in linux-next: offb missing fb helpers
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fbdev@vger.kernel.org, linux-kbuild@vger.kernel.org
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

On Sat, Nov 19, 2022 at 3:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> [adding Masahiro-san]
>
>
> On 11/18/22 07:03, Michal Such=C3=A1nek wrote:
> > Hello,
> >
> > I am seeing these errors:
> >
> > [ 3825s]   AR      built-in.a
> > [ 3827s]   AR      vmlinux.a
> > [ 3835s]   LD      vmlinux.o
> > [ 3835s]   OBJCOPY modules.builtin.modinfo
> > [ 3835s]   GEN     modules.builtin
> > [ 3835s]   GEN     .vmlinux.objs
> > [ 3848s]   MODPOST Module.symvers
> > [ 3848s]   CC      .vmlinux.export.o
> > [ 3849s]   UPD     include/generated/utsversion.h
> > [ 3849s]   CC      init/version-timestamp.o
> > [ 3849s]   LD      .tmp_vmlinux.btf
> > [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x58): undefined
> > reference to `cfb_fillrect'
> > [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x60): undefined
> > reference to `cfb_copyarea'
> > [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x68): undefined
> > reference to `cfb_imageblit'
> >
> > cfb_fillrect is provided by drivers/video/fbdev/core/cfbfillrect.c
> >
> > It is compiled when CONFIG_FB_CFB_FILLRECT
> > drivers/video/fbdev/core/Makefile:obj-$(CONFIG_FB_CFB_FILLRECT)  +=3D c=
fbfillrect.o
> >
> > drivers/video/fbdev/Makefile:obj-$(CONFIG_FB_OF)               +=3D off=
b.o
> > is compiled when CONFIG_FB_OF
> >
> > It selects CONFIG_FB_CFB_FILLRECT
> > config FB_OF
> >         bool "Open Firmware frame buffer device support"
> >         depends on (FB =3D y) && PPC && (!PPC_PSERIES || PCI)
> >         select APERTURE_HELPERS
> >         select FB_CFB_FILLRECT
> >         select FB_CFB_COPYAREA
> >         select FB_CFB_IMAGEBLIT
> >         select FB_MACMODES
> >
> > The config has FB_OF built-in and FB_CFB_FILLRECT modular
> > config/ppc64le/vanilla:CONFIG_FB_CFB_FILLRECT=3Dm
> > config/ppc64le/vanilla:CONFIG_FB_CFB_COPYAREA=3Dm
> > config/ppc64le/vanilla:CONFIG_FB_CFB_IMAGEBLIT=3Dm
> > config/ppc64le/vanilla:CONFIG_FB_OF=3Dy
> >
> > It only depends on FB which mut be built-in for FB_OF
> > config FB_CFB_FILLRECT
> >         tristate
> >         depends on FB
> >
> > Is select in kconfig broken?
> >
> > Attachnig the config in question.
>
> The symbol info from xconfig says:
>
> Symbol: FB_CFB_FILLRECT [=3Dm]
> Type : tristate
> Defined at drivers/video/fbdev/Kconfig:69
> Depends on: HAS_IOMEM [=3Dy] && FB [=3Dy]
> Selected by [m]:
> [deleted]
> - FB_OF [=3Dy] && HAS_IOMEM [=3Dy] && FB [=3Dy]=3Dy && PPC [=3Dy] && (!PP=
C_PSERIES [=3Dy] || PCI [=3Dy]) && !DRM_OFDRM [=3Dm]
>
> I don't see why the 'select' from (bool) FB_OF would leave FB_CFB_FILLREC=
T (and the others)
> as =3Dm instead of =3Dy.
>
> Hopefully Masahiro can shed some light on this.
>
> --
> ~Randy


The reason is shown in your paste of help message:

"&& !DRM_OFDRM [=3Dm]" downgrades it to "selected by m"

To aid this particular case, the following will select
FB_CFB_FILLRECT=3Dy.




diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 66f36b69e8f3..2bcf8627819f 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -458,7 +458,7 @@ config FB_ATARI
 config FB_OF
        bool "Open Firmware frame buffer device support"
        depends on (FB =3D y) && PPC && (!PPC_PSERIES || PCI)
-       depends on !DRM_OFDRM
+       depends on DRM_OFDRM !=3D y
        select APERTURE_HELPERS
        select FB_CFB_FILLRECT
        select FB_CFB_COPYAREA




Or, perhaps "depends on DRM_OFDRM =3D n"
I do not know the intention of this dependency.

Recommendation is to use "depends on" instead of "select" though.



BTW, this is similar to what you asked before.

https://lore.kernel.org/linux-kbuild/e1a6228d-1341-6264-d97a-e2bd52a65c82@i=
nfradead.org/


I tried to fix it in the past, but the issue was not as shallow as I
had expected.
I did not get around to revisiting this topic.

https://patchwork.kernel.org/project/linux-kbuild/patch/1543216969-2227-1-g=
it-send-email-yamada.masahiro@socionext.com/










--
Best Regards
Masahiro Yamada
