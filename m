Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75775B345F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiIIJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIIJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:47:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216DFA6A7;
        Fri,  9 Sep 2022 02:47:19 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id f131so1860867ybf.7;
        Fri, 09 Sep 2022 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jfc5PI7vUD4Aq68rXzOdTc1GotoBc8f6RchZ+GS6IIs=;
        b=c704vzTIEE8fD/+/yEejZ7dnnrVdpFgSizdgMZGxd8hZWJzMFgmZ5EdxpBlbOUvAiV
         UQNGbMKvyIxj4+AF6dbyQIpPlzKw+9WRX+pf6AxZusOzuIp904FHwapLxuZWjRvIjeJf
         ptoKp+v53gvE4UhNe8CdSyRhZfVnBoFPuZk88c09lR0b7uM3YomAA+haLBE671ddHqt9
         5O23+VDPTnCnyUQOmnbvzeqZid4M8FkuKKCt1CKRl2K3GVKhLKLAYSATr40xRAU41ihb
         JRU2ZscubQRTTjS6NFsUdEJv8luO2yB46THkdYNHN3FqL6Tgt4ObN2jxmU0iSe6vZW//
         4mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jfc5PI7vUD4Aq68rXzOdTc1GotoBc8f6RchZ+GS6IIs=;
        b=jK5k6/D1IU1Zjm6URqDbSEvoa8L8yRV5A5AcFjdzRNBsrclVsv256A4PdteLC24IaW
         AD7qhpUnvdNcFF++l9EZAZn+5GsS4ac9QptOGhve8ImJVmqgtPsOYD7eAQIAD/Fvc0Mb
         F/vfd8QNtJ0e9Ji2RJ4dRNpHkeZeJoo1LVWgQKy0i20s3HFZS1mlUxKWcCdlQhPKJ/jH
         zekdj1kuqAz6AojX8T/rZweycriT7eQQfJDi76I0QtdGaEYTsdsDQ0ekTANeeupOCf9C
         5c9yhxwvhWcjMoRJEkFMpcrRIizxXMxxw74m1LwibUIUM6MJXcmzaGpEveLj+FtLXZI3
         ccsQ==
X-Gm-Message-State: ACgBeo0mij3n7Xhh1NfzQdojZ9BIVFcqQ9ri8IJFM6Uk7LyNJXUF3yIO
        8E0cbUHqLfquOSr9j24++dV35fPkp8zV+IVyds0=
X-Google-Smtp-Source: AA6agR5iecDvFUTm3i7dnv6+ipXhF18SNJAuAN5Vk4ZI4UmY6mu5QedSKsbgiHyH5fdvRxxAyuv6TJXapYjUleCR1Vk=
X-Received: by 2002:a25:d791:0:b0:6ae:2ee3:710e with SMTP id
 o139-20020a25d791000000b006ae2ee3710emr6161116ybg.389.1662716838695; Fri, 09
 Sep 2022 02:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
 <20220908104337.11940-7-lukas.bulwahn@gmail.com> <ca25a32d-aadb-f0d0-9e24-70fbabc4d377@csgroup.eu>
In-Reply-To: <ca25a32d-aadb-f0d0-9e24-70fbabc4d377@csgroup.eu>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 9 Sep 2022 11:47:07 +0200
Message-ID: <CAKXUXMwo-X+cM9f_K=JpnjAcPr89OKCZ4JRAFMYCaTwt85UJ5Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] init/Kconfig: remove confusing config EMBEDDED
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   init/Kconfig | 8 --------
> >   1 file changed, 8 deletions(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 9e3fd79b089c..d7429e0b8cae 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1818,14 +1818,6 @@ config DEBUG_RSEQ
> >
> >         If unsure, say N.
> >
> > -config EMBEDDED
> > -     bool "Embedded system"
> > -     select EXPERT
> > -     help
> > -       This option should be enabled if compiling the kernel for
> > -       an embedded system so certain expert options are available
> > -       for configuration.
> > -
> >   config HAVE_PERF_EVENTS
> >       bool
> >       help
>
> That's fine, but what happens to existing defconfigs then ?
>
> $ git grep -w CONFIG_EMBEDDED arch/powerpc/
> arch/powerpc/configs/40x/klondike_defconfig:CONFIG_EMBEDDED=y
> arch/powerpc/configs/44x/fsp2_defconfig:CONFIG_EMBEDDED=y
> arch/powerpc/configs/52xx/tqm5200_defconfig:CONFIG_EMBEDDED=y
> arch/powerpc/configs/mgcoge_defconfig:CONFIG_EMBEDDED=y
> arch/powerpc/configs/microwatt_defconfig:CONFIG_EMBEDDED=y
> arch/powerpc/configs/ps3_defconfig:CONFIG_EMBEDDED=y
>
> They need to get converted to selecting CONFIG_EXPERT instead.
>
> And that needs to be done before you remove CONFIG_EMBEDDED.
>

Agree. Let us get the first five patches included. Then adjust the
configs for all architectures and then delete the CONFIG_EMBEDDED.

Lukas
