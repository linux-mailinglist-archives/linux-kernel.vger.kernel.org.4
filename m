Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6874EA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGKJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjGKJSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:18:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A98270B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:16:40 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-579dfae6855so66685877b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689066999; x=1691658999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pas4YXhE9tyV0vWkPBY+CDLqBNjLyZTNoC+4U42dUhg=;
        b=aSj3J0kYl+ZUK4IWnBmQzG32fjD8rRq1hQO8yd5hdn0xoSO4SaIprQRSpWjAGbuT4L
         j4HrGZeG89ENokExPTEpnaFx1AKo2T518QAOLp2gE30huepexy89ondFfiKpjRHsU9rz
         tdst5M73OOskM8vqQmN58qghP7koMOC2FMvk7qJW4RFCq/QOyPsIucYIg3GxB0QBHI81
         4XzgIw80HFQU7RpiVP7DI7w18VCqVaGxieOr+avEv64qf1tEq9cIN88HeadL9JMzgdor
         q+QaTlZJDKgVtvP6JbsVsBFGh2uATMds+PwjgZ57m0tZ1tWqlmEDTlmlNpj71HBeilwD
         fGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066999; x=1691658999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pas4YXhE9tyV0vWkPBY+CDLqBNjLyZTNoC+4U42dUhg=;
        b=RU0yh34LCfDK+ovPbeogZ+LTmQcboF8GGeqH2w682VkziLC/1IBlS9fXW/hhPvu4FD
         0TDzp0qJDs33Z8LPhVABjdfrfzhwH/p2aTXsxopTCtg/l6JXQtk23Oxsm/YQLxclVEKn
         dGrsAkc2d7J9ZpQbW7Ynqn8QiSrV/okbBYWICpW+iUUhBVzRo5RWgM/xtWa7da+v3myg
         S7b6Tb2rrA0IvkeDhrasomPhUJF8gpR1ySVPyal4kmFhdtptB4NDOzdQ6Srd60mkFPQM
         vfo8TFfqkucI7AykhuL3pwFYxMdAS6KxkYTr3oGavHnkOF4hjkqbARJtm89oNih2vgmE
         5twA==
X-Gm-Message-State: ABy/qLasYY/RpGsBwH/Nw+GSRWeir0WEiNjrqYC26qWboZlO6sFcScoD
        WNpudxspEJsl0z0pc1O80+CeZHeYmIXWspu6T7/NK32k1tbtVK5O
X-Google-Smtp-Source: APBJJlFJ4nPhwO9ZTqhum94WuBn2fW/8fJYK7aZ8jIYhnO9NC6z3uLrgIlyEcMprOo7OQRJgLy6wYE4bG/JpUEeCIyc=
X-Received: by 2002:a0d:da43:0:b0:56c:fd03:dba with SMTP id
 c64-20020a0dda43000000b0056cfd030dbamr13287487ywe.35.1689066999749; Tue, 11
 Jul 2023 02:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-16-ulf.hansson@linaro.org> <20230707175048.6yees6d3evcomyux@vacation>
In-Reply-To: <20230707175048.6yees6d3evcomyux@vacation>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Jul 2023 11:16:03 +0200
Message-ID: <CAPDyKFoc0hr=9LEtwwwe3R6rMn0b7TB1MCZN0ArUq+h9Pud08Q@mail.gmail.com>
Subject: Re: [PATCH 15/18] soc: ti: Mover power-domain drivers to the genpd dir
To:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 19:50, Nishanth Menon <nm@ti.com> wrote:
>
> On 16:04-20230707, Ulf Hansson wrote:
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Cc: Tero Kristo <kristo@kernel.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  MAINTAINERS                                   | 3 ++-
> >  drivers/genpd/Makefile                        | 1 +
> >  drivers/genpd/ti/Makefile                     | 3 +++
> >  drivers/{soc => genpd}/ti/omap_prm.c          | 0
> >  drivers/{soc => genpd}/ti/ti_sci_pm_domains.c | 0
> >  drivers/soc/ti/Makefile                       | 2 --
> >  6 files changed, 6 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/genpd/ti/Makefile
> >  rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
> >  rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9e580df3e5db..3cf16ffac892 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21101,7 +21101,7 @@ F:    drivers/irqchip/irq-ti-sci-inta.c
> >  F:   drivers/irqchip/irq-ti-sci-intr.c
> >  F:   drivers/reset/reset-ti-sci.c
> >  F:   drivers/soc/ti/ti_sci_inta_msi.c
> > -F:   drivers/soc/ti/ti_sci_pm_domains.c
> > +F:   drivers/genpd/ti/ti_sci_pm_domains.c
> >  F:   include/dt-bindings/soc/ti,sci_pm_domain.h
> >  F:   include/linux/soc/ti/ti_sci_inta_msi.h
> >  F:   include/linux/soc/ti/ti_sci_protocol.h
> > @@ -21335,6 +21335,7 @@ L:    linux-kernel@vger.kernel.org
> >  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:   Maintained
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
> > +F:   drivers/genpd/ti/omap_prm.c
>
> Probably the wrong place for this as omap_prm is'nt a keystone navigator
> driver set. Maybe Tony has a suggestion?

I guess we could add it to the OMAP2+ section then?

In any case, I suggest we consider that as a separate patch on top, as
I am just obeying to the existing pattern that the get_maintainers
script provides.

Kind regards
Uffe

>
> >  F:   drivers/soc/ti/*
> >
> >  TI LM49xxx FAMILY ASoC CODEC DRIVERS
> > diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> > index e6f34d82e6a8..193892189f0d 100644
> > --- a/drivers/genpd/Makefile
> > +++ b/drivers/genpd/Makefile
> > @@ -11,3 +11,4 @@ obj-y                                       += samsung/
> >  obj-y                                        += starfive/
> >  obj-y                                        += sunxi/
> >  obj-y                                        += tegra/
> > +obj-y                                        += ti/
> > diff --git a/drivers/genpd/ti/Makefile b/drivers/genpd/ti/Makefile
> > new file mode 100644
> > index 000000000000..69580afbb436
> > --- /dev/null
> > +++ b/drivers/genpd/ti/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_ARCH_OMAP2PLUS)         += omap_prm.o
> > +obj-$(CONFIG_TI_SCI_PM_DOMAINS)              += ti_sci_pm_domains.o
> > diff --git a/drivers/soc/ti/omap_prm.c b/drivers/genpd/ti/omap_prm.c
> > similarity index 100%
> > rename from drivers/soc/ti/omap_prm.c
> > rename to drivers/genpd/ti/omap_prm.c
> > diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
> > similarity index 100%
> > rename from drivers/soc/ti/ti_sci_pm_domains.c
> > rename to drivers/genpd/ti/ti_sci_pm_domains.c
> > diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> > index cc3c972fad2e..cb800a745e66 100644
> > --- a/drivers/soc/ti/Makefile
> > +++ b/drivers/soc/ti/Makefile
> > @@ -6,9 +6,7 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS) += knav_qmss.o
> >  knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o
> >  obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA) += knav_dma.o
> >  obj-$(CONFIG_AMX3_PM)                        += pm33xx.o
> > -obj-$(CONFIG_ARCH_OMAP2PLUS)         += omap_prm.o
> >  obj-$(CONFIG_WKUP_M3_IPC)            += wkup_m3_ipc.o
> > -obj-$(CONFIG_TI_SCI_PM_DOMAINS)              += ti_sci_pm_domains.o
> >  obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN) += ti_sci_inta_msi.o
> >  obj-$(CONFIG_TI_K3_RINGACC)          += k3-ringacc.o
> >  obj-$(CONFIG_TI_K3_SOCINFO)          += k3-socinfo.o
> > --
> > 2.34.1
> >
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
