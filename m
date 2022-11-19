Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0F630F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiKSPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 10:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKSPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 10:37:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72CD68288;
        Sat, 19 Nov 2022 07:37:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 758401F747;
        Sat, 19 Nov 2022 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668872250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5FuVv7ZVIQVzf6omBt/v/EHkFFanwV0mOMaz+dnj+U=;
        b=Y8d80i+4ux8qhzzd3kTDu31wqavk7AnVw3bxcCmd9GhtSy9Pr0eXK5c9wYhG8t1eY95/nO
        BTbbFrar1Ecf8ixVAR+Uq6/8b5MDr3NpiiDuNWryaoDKpsC8T0ILQQ+Zs9G16zqCGO2yID
        1nj4ZHYuDX1y3vl1QmsSZc0ABY6mxG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668872250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5FuVv7ZVIQVzf6omBt/v/EHkFFanwV0mOMaz+dnj+U=;
        b=YtXYxVkfy78m0XIGl7y/QT8KJvAHn1oB8umRUOkgF02KtyieCwUxlm8pIPTc4StZsn/2Kn
        NUjrsRBEqD4WQYDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5172C2C141;
        Sat, 19 Nov 2022 15:37:30 +0000 (UTC)
Date:   Sat, 19 Nov 2022 16:37:29 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: build failure in linux-next: offb missing fb helpers
Message-ID: <20221119153729.GX28810@kitsune.suse.cz>
References: <20221118150351.GV28810@kitsune.suse.cz>
 <b8191c01-4d78-537b-9650-a783e14e5997@infradead.org>
 <CAK7LNASBhTvzkjXuJDH8ePCVXnZ=GUYdNa-OU+QURbBp3oyEBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASBhTvzkjXuJDH8ePCVXnZ=GUYdNa-OU+QURbBp3oyEBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Nov 19, 2022 at 10:27:04PM +0900, Masahiro Yamada wrote:
> On Sat, Nov 19, 2022 at 3:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Hi--
> >
> > [adding Masahiro-san]
> >
> >
> > On 11/18/22 07:03, Michal Suchánek wrote:
> > > Hello,
> > >
> > > I am seeing these errors:
> > >
> > > [ 3825s]   AR      built-in.a
> > > [ 3827s]   AR      vmlinux.a
> > > [ 3835s]   LD      vmlinux.o
> > > [ 3835s]   OBJCOPY modules.builtin.modinfo
> > > [ 3835s]   GEN     modules.builtin
> > > [ 3835s]   GEN     .vmlinux.objs
> > > [ 3848s]   MODPOST Module.symvers
> > > [ 3848s]   CC      .vmlinux.export.o
> > > [ 3849s]   UPD     include/generated/utsversion.h
> > > [ 3849s]   CC      init/version-timestamp.o
> > > [ 3849s]   LD      .tmp_vmlinux.btf
> > > [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x58): undefined
> > > reference to `cfb_fillrect'
> > > [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x60): undefined
> > > reference to `cfb_copyarea'
> > > [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x68): undefined
> > > reference to `cfb_imageblit'
> > >
> > > cfb_fillrect is provided by drivers/video/fbdev/core/cfbfillrect.c
> > >
> > > It is compiled when CONFIG_FB_CFB_FILLRECT
> > > drivers/video/fbdev/core/Makefile:obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
> > >
> > > drivers/video/fbdev/Makefile:obj-$(CONFIG_FB_OF)               += offb.o
> > > is compiled when CONFIG_FB_OF
> > >
> > > It selects CONFIG_FB_CFB_FILLRECT
> > > config FB_OF
> > >         bool "Open Firmware frame buffer device support"
> > >         depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
> > >         select APERTURE_HELPERS
> > >         select FB_CFB_FILLRECT
> > >         select FB_CFB_COPYAREA
> > >         select FB_CFB_IMAGEBLIT
> > >         select FB_MACMODES
> > >
> > > The config has FB_OF built-in and FB_CFB_FILLRECT modular
> > > config/ppc64le/vanilla:CONFIG_FB_CFB_FILLRECT=m
> > > config/ppc64le/vanilla:CONFIG_FB_CFB_COPYAREA=m
> > > config/ppc64le/vanilla:CONFIG_FB_CFB_IMAGEBLIT=m
> > > config/ppc64le/vanilla:CONFIG_FB_OF=y
> > >
> > > It only depends on FB which mut be built-in for FB_OF
> > > config FB_CFB_FILLRECT
> > >         tristate
> > >         depends on FB
> > >
> > > Is select in kconfig broken?
> > >
> > > Attachnig the config in question.
> >
> > The symbol info from xconfig says:
> >
> > Symbol: FB_CFB_FILLRECT [=m]
> > Type : tristate
> > Defined at drivers/video/fbdev/Kconfig:69
> > Depends on: HAS_IOMEM [=y] && FB [=y]
> > Selected by [m]:
> > [deleted]
> > - FB_OF [=y] && HAS_IOMEM [=y] && FB [=y]=y && PPC [=y] && (!PPC_PSERIES [=y] || PCI [=y]) && !DRM_OFDRM [=m]
> >
> > I don't see why the 'select' from (bool) FB_OF would leave FB_CFB_FILLRECT (and the others)
> > as =m instead of =y.
> >
> > Hopefully Masahiro can shed some light on this.
> >
> > --
> > ~Randy
> 
> 
> The reason is shown in your paste of help message:
> 
> "&& !DRM_OFDRM [=m]" downgrades it to "selected by m"
> 
> To aid this particular case, the following will select
> FB_CFB_FILLRECT=y.
> 
> 
> 
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 66f36b69e8f3..2bcf8627819f 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -458,7 +458,7 @@ config FB_ATARI
>  config FB_OF
>         bool "Open Firmware frame buffer device support"
>         depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
> -       depends on !DRM_OFDRM
> +       depends on DRM_OFDRM != y
>         select APERTURE_HELPERS
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA

Thanks for clarification.

This change fixess the config for me.

Michal


> Or, perhaps "depends on DRM_OFDRM = n"
> I do not know the intention of this dependency.
> 
> Recommendation is to use "depends on" instead of "select" though.
> 
> 
> 
> BTW, this is similar to what you asked before.
> 
> https://lore.kernel.org/linux-kbuild/e1a6228d-1341-6264-d97a-e2bd52a65c82@infradead.org/
> 
> 
> I tried to fix it in the past, but the issue was not as shallow as I
> had expected.
> I did not get around to revisiting this topic.
> 
> https://patchwork.kernel.org/project/linux-kbuild/patch/1543216969-2227-1-git-send-email-yamada.masahiro@socionext.com/
> 
