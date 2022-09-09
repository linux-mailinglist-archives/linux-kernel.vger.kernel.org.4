Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942495B2F03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiIIGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiIIGaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:30:46 -0400
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACEAF16F3;
        Thu,  8 Sep 2022 23:30:43 -0700 (PDT)
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-04.nifty.com with ESMTP id 2896NABh024113;
        Fri, 9 Sep 2022 15:23:10 +0900
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2896Mokw030025;
        Fri, 9 Sep 2022 15:22:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2896Mokw030025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662704571;
        bh=pCvB9G6yeR8kJw81jIzOej+Uwp6mWXS5ZOAc45JxQvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YpKElwj0g3TKFWqfl5JHh+WHWrEd0F/CwCHeRyz1Ahu9EAAZcXE1IuMjkDluJYoth
         t//MxmXtr4EN6Q5pxEQuX5Qwf1PeR2tG6rw4LX+y2qvUZ+xrgi5kkQBgGtU0uczIaj
         5I+pc9Rvwfa78x+pTeQzKp4yjA7LWqMxzaXjMv8vRLRXRkyRKcIg/eeIrS1Zn9FwUl
         qiRqWpZcEMgqEW4CcziwK2tO5j8LIlsV/ezPPHrSWRNI7bdXT3mV2zF80rzJmH90OZ
         gRdFHx1vaneFzc7mwh7cAmRBmI9o2Td3lFe8XIy5E8FIS/b02A0kvGUSFfp/qL9wkT
         JS6sUy2mmv+5g==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1279948d93dso1478503fac.10;
        Thu, 08 Sep 2022 23:22:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo386PcH0HGBOl4/t1WvWd3vyJN8sPn2uWoeRJmCze2kA5xoSHcF
        yxINQANrr5T2pPpgA93GGZ/vggROay4R7eLoFug=
X-Google-Smtp-Source: AA6agR6JhlCvtCQhMAFYXJvEMXqp9TWxkU7aGJYTgIGDGNHX5CbLq4f7HwYyeEmRym3c0wzZsgLiFzEotoORl8hXz+Y=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr3955139oab.194.1662704570329; Thu, 08
 Sep 2022 23:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
 <20220908104337.11940-4-lukas.bulwahn@gmail.com> <20220908131303.1fe813cd@coco.lan>
 <20220908182050.7a1c46cd@coco.lan>
In-Reply-To: <20220908182050.7a1c46cd@coco.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 15:22:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDY-XvbNbiHT8n4ztAv+Wh_ZZ1PLdbZZVBOuLVrmw5cQ@mail.gmail.com>
Message-ID: <CAK7LNARDY-XvbNbiHT8n4ztAv+Wh_ZZ1PLdbZZVBOuLVrmw5cQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] media: remove reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 1:20 AM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> Em Thu, 8 Sep 2022 13:13:03 +0200
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
>
> > Em Thu,  8 Sep 2022 12:43:34 +0200
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> >
> > > The config EMBEDDED selects EXPERT, i.e., when EMBEDDED is enabled, EXPERT
> > > is usually also enabled. Hence, it sufficient to have the option
> > > MEDIA_SUPPORT_FILTER set to y if !EXPERT.
> > >
> > > This way, MEDIA_SUPPORT_FILTER does not refer to CONFIG_EMBEDDED anymore
> > > and allows us to remove CONFIG_EMBEDDED in the close future.
> > >
> > > Remove the reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > >  drivers/media/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
> > > index ba6592b3dab2..283b78b5766e 100644
> > > --- a/drivers/media/Kconfig
> > > +++ b/drivers/media/Kconfig
> > > @@ -24,7 +24,7 @@ if MEDIA_SUPPORT
> > >
> > >  config MEDIA_SUPPORT_FILTER
> > >     bool "Filter media drivers"
> > > -   default y if !EMBEDDED && !EXPERT
> > > +   default y if !EXPERT
> > >     help
> > >        Configuring the media subsystem can be complex, as there are
> > >        hundreds of drivers and other config options.
> >
> > Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>
> As this is independent on the rest of the series, I just went ahead
> and merged it on media tree.
> >
> > Thanks,
> > Mauro
>
>
>
> Thanks,
> Mauro

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

-- 
Best Regards
Masahiro Yamada
