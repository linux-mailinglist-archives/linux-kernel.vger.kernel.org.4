Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BC74C814
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 22:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGIUWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 16:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGIUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 16:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BBC100;
        Sun,  9 Jul 2023 13:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F6E560C3B;
        Sun,  9 Jul 2023 20:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0821EC433C8;
        Sun,  9 Jul 2023 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688934171;
        bh=LhmoKeP/Q7YhTygfz0CKE92dpETdRNAKcAUxcaMgjMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDslomopp7J3My+F/7AKcMq5Sy/asJQYlMA3Wwse96J2EEVO/0rZfeCDxcXzB44JP
         /z4ZmXeQl2z5mPaRfz8N2x3XuPabV0cF1ZnihejsT18EOqsq63rJImzQOrRip84hQ9
         T3c3d5hujGeA5fHoemyJcLO2Sr5cki19m5RssKFs=
Date:   Sun, 9 Jul 2023 22:22:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.3 000/431] 6.3.13-rc1 review
Message-ID: <2023070935-circulate-elves-fa11@gregkh>
References: <20230709111451.101012554@linuxfoundation.org>
 <CAEUSe7_dcPNEMqCbd6r+f_zJypQ196MSxigq6i+5eSh3=vvDOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_dcPNEMqCbd6r+f_zJypQ196MSxigq6i+5eSh3=vvDOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 02:06:05PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Sun, 9 Jul 2023 at 05:18, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > ------------------
> > Note, this is the LAST release for the 6.3.y kernel series.  After this
> > is released, it will be end-of-life.  Please move to the 6.4.y kernel
> > series at this point in time, OR let us know what is preventing that
> > from happening for you.
> > ------------------
> >
> > This is the start of the stable review cycle for the 6.3.13 release.
> > There are 431 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue, 11 Jul 2023 11:14:03 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.13-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> There build regressions on Arm 32-bits, specifically omap1_defconfig:
> 
> -----8<-----
>   /builds/linux/arch/arm/mach-omap1/irq.c: In function 'omap1_init_irq':
>   /builds/linux/arch/arm/mach-omap1/irq.c:221:11: error: implicit
> declaration of function 'irq_domain_add_legacy'
> [-Werror=implicit-function-declaration]
>     domain = irq_domain_add_legacy(NULL, nr_irqs, irq_base, 0,
>              ^~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/arm/mach-omap1/irq.c:222:13: error:
> 'irq_domain_simple_ops' undeclared (first use in this function); did
> you mean 'irq_domain_chip_generic'?
>               &irq_domain_simple_ops, NULL);
>                ^~~~~~~~~~~~~~~~~~~~~
>                irq_domain_chip_generic
>   /builds/linux/arch/arm/mach-omap1/irq.c:222:13: note: each
> undeclared identifier is reported only once for each function it
> appears in
>   /builds/linux/arch/arm/mach-omap1/irq.c:250:23: error: implicit
> declaration of function 'irq_find_mapping'; did you mean
> 'iomem_get_mapping'? [-Werror=implicit-function-declaration]
>     d = irq_get_irq_data(irq_find_mapping(domain, omap_l2_irq));
>                          ^~~~~~~~~~~~~~~~
>                          iomem_get_mapping
>   cc1: some warnings being treated as errors
>   make[3]: *** [/builds/linux/scripts/Makefile.build:252:
> arch/arm/mach-omap1/irq.o] Error 1
> ----->8-----

Ick, sorry, let me go drop some patches and push out a -rc2.

thanks,

greg k-h
