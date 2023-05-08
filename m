Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8BC6FAED5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjEHLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjEHLsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F052436A6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C790B63A52
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A040BC433EF;
        Mon,  8 May 2023 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683546475;
        bh=QpWbsF81AEIhM6M2asCt/LL6A53rK0qfm2ZYOa/uUzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9FXdpCCuYT+NuTeW9TK8giBrQdhU3Z6Rzed/hvA/BQQoHibU9BgST9V53uVqQ7OI
         MNx9aiLNaSHBXJLHAe7RGFc2ELr374UhKNjmBBLaZGv/vfqER4UFIP9hI9bbvcfvw0
         A+4FBa5xboDbTf2XKpv0k2IoElPvCAEk76z8g7Vh+weKHAKDRaZleJ3dvKKz/pTo0d
         Hq9coh75EvzLYWE5BeWk+eDtR2FLcg2rq/hRf2B7DB6h7XwcIMTl9q9P9htH23S4pP
         2xvShGpLFwtRq8eJEFqQ13/LXVQ3cs48IowulWcZYQh8TJvJxqvJCbwFguhkAQAkYb
         yMRkA1lTdxnpw==
Date:   Mon, 8 May 2023 17:17:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yangfl <mmyangfl@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: hisilicon: Adopt phy-hisi-inno-usb2 to Hi3798MV100
Message-ID: <ZFjhZt6/K5wNJOrW@matsya>
References: <20230507154615.793942-1-mmyangfl@gmail.com>
 <ZFinwhFphe71VeLk@matsya>
 <CAAXyoMN2CvVkL+=wT=Q4zJZJa-qUiyiVS4SZquVQ1LUfDmoM5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMN2CvVkL+=wT=Q4zJZJa-qUiyiVS4SZquVQ1LUfDmoM5Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-23, 19:39, Yangfl wrote:
> Vinod Koul <vkoul@kernel.org> 于2023年5月8日周一 15:41写道：
> >
> > On 07-05-23, 23:46, David Yang wrote:
> > > Hisilicon also uses phy-hisi-inno-usb2 on Hi3798MV100, with a slightly
> > > different register convention.
> >
> > OK, so what should I expect from this patch, pls document that here...
> 
> Hi3798MV100 usb2 phy. Which kind of document should I put here?

Pls add the details on what is being changed in this patch. this is the
place where patch description is provided, what are all the things that
are getting changed

> 
> >
> > >
> > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > ---
> > >  drivers/phy/hisilicon/Kconfig              |  2 +-
> > >  drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 67 ++++++++++++++++------
> > >  2 files changed, 51 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
> > > index d3b92c288554..6c89136fc8c2 100644
> > > --- a/drivers/phy/hisilicon/Kconfig
> > > +++ b/drivers/phy/hisilicon/Kconfig
> > > @@ -54,7 +54,7 @@ config PHY_HISTB_COMBPHY
> > >
> > >  config PHY_HISI_INNO_USB2
> > >       tristate "HiSilicon INNO USB2 PHY support"
> > > -     depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> > > +     depends on ARCH_HISI || COMPILE_TEST
> >
> > why this change?
> 
> Hi3798MV100 is a A9 ARM32 only soc.

OK pls document that, also suspect that might a separate patch..?

> 
> >
> > >       select GENERIC_PHY
> > >       select MFD_SYSCON
> > >       help
> > > diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> > > index b133ae06757a..b5d006f38934 100644
> > > --- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> > > +++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> > > @@ -9,7 +9,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/io.h>
> > >  #include <linux/module.h>
> > > -#include <linux/platform_device.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/phy/phy.h>
> > >  #include <linux/reset.h>
> > >
> > > @@ -20,12 +20,28 @@
> > >  #define PHY_CLK_STABLE_TIME  2       /* unit:ms */
> > >  #define UTMI_RST_COMPLETE_TIME       2       /* unit:ms */
> > >  #define POR_RST_COMPLETE_TIME        300     /* unit:us */
> > > -#define PHY_TEST_DATA                GENMASK(7, 0)
> > > -#define PHY_TEST_ADDR                GENMASK(15, 8)
> > > -#define PHY_TEST_PORT                GENMASK(18, 16)
> > > -#define PHY_TEST_WREN                BIT(21)
> > > -#define PHY_TEST_CLK         BIT(22) /* rising edge active */
> > > -#define PHY_TEST_RST         BIT(23) /* low active */
> > > +
> > > +#define PHY_TYPE_0   0
> > > +#define PHY_TYPE_1   1
> > > +
> > > +#define PHY0_TEST_DATA               GENMASK(7, 0)
> >
> > same as previous what changed??
> 
> Register convention for PHY1 below, as mentioned in commit message.

It is _exactly_ same as previous, so pls dont introduce unnecessary
changes..

-- 
~Vinod
