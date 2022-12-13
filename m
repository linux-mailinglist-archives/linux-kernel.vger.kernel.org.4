Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9133264B166
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiLMIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiLMIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:45:44 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE219C38;
        Tue, 13 Dec 2022 00:45:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id x18so6229059qki.4;
        Tue, 13 Dec 2022 00:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Bk5BO8mhQb+fsvz9M+5Piwo+AtUhFdtpFocu7SHwZQ=;
        b=YMle2F49XWZqxSDi6qjVBt/kVbZC39YfKxW7S5VrwbdRiX1PRxP8+CEK/T2ok9WdF8
         vdwRm0XLhUbzYV2E4bzTz4rUo5GNMUVk0k8qC+FI9mmASngSN2KV3r0aOjrhHn1Ud8PQ
         Cg8UEdcYGG/i1/ffip4EbmznnY/gpg2wEP9BKKKaqSKv2txgt/c4EW34JDLZGs+/DrBK
         G4zrLoT+oJmcDDVW8XAECgtGs2ZU4ibLYNlDYkOw6KFLOmqIVYkdz2IwQUz22UbHVxGU
         EvJKzAy7IZfb1HK0iO8p8tPAl/6zgQGt33ABvPElw9Rt/w1UFKBBgVGHYDoFPF2juuAb
         iuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Bk5BO8mhQb+fsvz9M+5Piwo+AtUhFdtpFocu7SHwZQ=;
        b=B9YV/Iw6uAmwq7RdTDfx3ThRI9pG+boaQkwCSLXvZcj0qbwTFYVxBl/SFimm3uArPH
         RHy93RybxauAGe3ngQuXie/7eB4RJ0k6Jpoyb0JL+Eo9gj+3w8Y0QzDrbPQezD4XPZAi
         zZabf1WhLxzwP+52jMvcuaHQ6wRtpc91BBnsBr29U6HI6MygqlTESQqwGWGOpuNCfJso
         Uw9Rfrm07t8awYG1n2wrMZKUOVtrnoW6oewyDr3kkGOACMFa+QUdDF2elD7MOVv6jhpU
         lJTc5g2Sez6wVwMBe9YOgBLcxDzBp2gZ5t2dd64kXFL6KquH4aE2Al8PMaqX+/ug8sEH
         Pi1A==
X-Gm-Message-State: ANoB5pnN6iAVOSuyJqF1jde7D8WDy7rZfkwBX0rWfFTbz6/leTgmSczs
        5QoZK4/tmvCatMofp56/pNdO1ohD1sdNkgteSbDW+3RFfMU=
X-Google-Smtp-Source: AA0mqf5Dd907U3uTg8cjZR7DNqfHJSUyQAO7lSd+eMb+KqYs1IM0LzAK0sPFCWXW3lznoIv3VzjuRQb+lDp4t4DdRus=
X-Received: by 2002:a37:8ac2:0:b0:6fa:442d:f4d3 with SMTP id
 m185-20020a378ac2000000b006fa442df4d3mr83183171qkd.665.1670921142542; Tue, 13
 Dec 2022 00:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-10-victor.shih@genesyslogic.com.tw> <a154ee25-e1e7-8709-abad-8064edc3c43f@intel.com>
In-Reply-To: <a154ee25-e1e7-8709-abad-8064edc3c43f@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:45:30 +0800
Message-ID: <CAK00qKBCC5tCtAOW66Dxd8UzYr7N5o-3Fh1PKgb074-fDs3A=Q@mail.gmail.com>
Subject: Re: [PATCH V5 09/26] mmc: sdhci: add UHS-II module
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Nov 2, 2022 at 1:12 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> > This patch adds sdhci-uhs2.c as a module for UHS-II support.
> > This is a skelton for further development in this patch series.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/Makefile     |  1 +
> >  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 4e4ceb32c4b4..c4ae7c6d9c04 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)               += pxamci.o
> >  obj-$(CONFIG_MMC_MXC)                += mxcmmc.o
> >  obj-$(CONFIG_MMC_MXS)                += mxs-mmc.o
> >  obj-$(CONFIG_MMC_SDHCI)              += sdhci.o
> > +obj-$(CONFIG_MMC_SDHCI_UHS2) += sdhci-uhs2.o
> >  obj-$(CONFIG_MMC_SDHCI_PCI)  += sdhci-pci.o
> >  sdhci-pci-y                  += sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
> >                                  sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > new file mode 100644
> > index 000000000000..f29d3a4ed43c
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
> > + *  Interface driver
> > + *
> > + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + *  Copyright (C) 2020 Genesys Logic, Inc.
> > + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > + *  Copyright (C) 2020 Linaro Limited
> > + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#include "sdhci.h"
> > +#include "sdhci-uhs2.h"
> > +
> > +#define DRIVER_NAME "sdhci_uhs2"
> > +#define DBG(f, x...) \
> > +     pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> > +
> > +/*****************************************************************************\
> > + *                                                                           *
> > + * Driver init/exit                                                          *
> > + *                                                                           *
> > +\*****************************************************************************/
> > +
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int __init sdhci_uhs2_mod_init(void)
> > +{
> > +     return 0;
> > +}
> > +module_init(sdhci_uhs2_mod_init);
> > +
> > +static void __exit sdhci_uhs2_exit(void)
>
> It would be better to match the form of the init name
> e.g. sdhci_uhs2_mod_exit
>

I will update it in the patch#8 of the new [PATCH V6].

> > +{
> > +}
> > +module_exit(sdhci_uhs2_exit);
> > +
> > +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> > +MODULE_DESCRIPTION("MMC UHS-II Support");
> > +MODULE_LICENSE("GPL v2");
>

Thanks, Victor Shih
