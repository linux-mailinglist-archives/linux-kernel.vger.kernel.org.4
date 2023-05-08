Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E071C6FAE09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjEHLkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjEHLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:40:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973E3F2D1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:40:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5144043d9d1so2911828a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683545999; x=1686137999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmAYIf46oy/MCRbmsdr/75KTlDluVcR5KB1IRJNuPTE=;
        b=DLhswwcXJUtMfYkQWkUrkyw7G+tNOTzprdPxpN6YrJZ43FC6nNElcPg7rz/1j4rNNY
         ChijJg/BYsrYJr7c50w//eZNmFouHs8k18Qkh/EeO2Eu1xA5shzxrMdDwympLd294yja
         36Kc2bZv4faPtMSdv0rt2h+dAZYaCp5Sk89OGw7GRkVJQWhA/pFIUXM8w23CpVU2Bm0b
         U31YQLKnHBQ2KZXXEMSE79f/VZkpslMCHaVlL0yZvA2aoqmdMY+P8GZumkIb8mYZ0VfV
         bRYFnqT7Tg4FQMTIpzpMybja7bBK6iEhFFv7Zmy8QNxK2/dwsoqmToYGW6tiNYkbCb0f
         bnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545999; x=1686137999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmAYIf46oy/MCRbmsdr/75KTlDluVcR5KB1IRJNuPTE=;
        b=CGDVfz8Re2nOPaEEYzoXTiSrcWs3ahBfE9dTnKBXfjAtG/DG9pCbVP4lpTJNH6rBhm
         7//04f0oVBUjjuz/w3QZ2X9zLL6O1Aydd4FLHTfgste7Wrh5bsWwahLwrXywS8NoMlBQ
         Wo5S37fk4OPZnkBX3KF7LBb9kJ1NXQw2L29KVIopIIiWdYvyDP60Okh+L++esxtj80m3
         2TCKUGEKDk3wt6vXaWMC80Auu9PzIjqU+9F58npMs99RGd8Znzm291eR6W8wOPpgNffe
         kxiRQ7hNKV5vah5BUavTd2fTeldeocQFGL7SV8+6hByfE/YFhtR4H4lg+AdHaxpPJb+i
         xtzQ==
X-Gm-Message-State: AC+VfDzFG8TJmsfUmj6Bp9qR6HJXrSvPGYlx5A4aUWlMRPLs7GEteNMZ
        Pz3v94tqHT17HfoOClpQdC1W1aNwnhVPNPNq7xmDBBnNeidM5YqqBcs=
X-Google-Smtp-Source: ACHHUZ59zLfpKIouF6UsmRef0qI79/2OLMkLOJFCZGj7vb0eEAJTU31HUMiKoCG1IuM5GeB7IjB1Bhck1UsFKDrpnoc=
X-Received: by 2002:a17:90a:6b4e:b0:24e:4dad:d8ab with SMTP id
 x14-20020a17090a6b4e00b0024e4dadd8abmr10184245pjl.0.1683545999370; Mon, 08
 May 2023 04:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230507154615.793942-1-mmyangfl@gmail.com> <ZFinwhFphe71VeLk@matsya>
In-Reply-To: <ZFinwhFphe71VeLk@matsya>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Mon, 8 May 2023 19:39:22 +0800
Message-ID: <CAAXyoMN2CvVkL+=wT=Q4zJZJa-qUiyiVS4SZquVQ1LUfDmoM5Q@mail.gmail.com>
Subject: Re: [PATCH] phy: hisilicon: Adopt phy-hisi-inno-usb2 to Hi3798MV100
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod Koul <vkoul@kernel.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=888=E6=97=A5=E5=
=91=A8=E4=B8=80 15:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On 07-05-23, 23:46, David Yang wrote:
> > Hisilicon also uses phy-hisi-inno-usb2 on Hi3798MV100, with a slightly
> > different register convention.
>
> OK, so what should I expect from this patch, pls document that here...

Hi3798MV100 usb2 phy. Which kind of document should I put here?

>
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  drivers/phy/hisilicon/Kconfig              |  2 +-
> >  drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 67 ++++++++++++++++------
> >  2 files changed, 51 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kcon=
fig
> > index d3b92c288554..6c89136fc8c2 100644
> > --- a/drivers/phy/hisilicon/Kconfig
> > +++ b/drivers/phy/hisilicon/Kconfig
> > @@ -54,7 +54,7 @@ config PHY_HISTB_COMBPHY
> >
> >  config PHY_HISI_INNO_USB2
> >       tristate "HiSilicon INNO USB2 PHY support"
> > -     depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> > +     depends on ARCH_HISI || COMPILE_TEST
>
> why this change?

Hi3798MV100 is a A9 ARM32 only soc.

>
> >       select GENERIC_PHY
> >       select MFD_SYSCON
> >       help
> > diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/h=
isilicon/phy-hisi-inno-usb2.c
> > index b133ae06757a..b5d006f38934 100644
> > --- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> > +++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> > @@ -9,7 +9,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > -#include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/reset.h>
> >
> > @@ -20,12 +20,28 @@
> >  #define PHY_CLK_STABLE_TIME  2       /* unit:ms */
> >  #define UTMI_RST_COMPLETE_TIME       2       /* unit:ms */
> >  #define POR_RST_COMPLETE_TIME        300     /* unit:us */
> > -#define PHY_TEST_DATA                GENMASK(7, 0)
> > -#define PHY_TEST_ADDR                GENMASK(15, 8)
> > -#define PHY_TEST_PORT                GENMASK(18, 16)
> > -#define PHY_TEST_WREN                BIT(21)
> > -#define PHY_TEST_CLK         BIT(22) /* rising edge active */
> > -#define PHY_TEST_RST         BIT(23) /* low active */
> > +
> > +#define PHY_TYPE_0   0
> > +#define PHY_TYPE_1   1
> > +
> > +#define PHY0_TEST_DATA               GENMASK(7, 0)
>
> same as previous what changed??

Register convention for PHY1 below, as mentioned in commit message.
