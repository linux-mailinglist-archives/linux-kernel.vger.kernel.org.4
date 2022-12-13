Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4DE64B16A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiLMIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiLMIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:46:06 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3531A06E;
        Tue, 13 Dec 2022 00:46:05 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d2so9985633qvp.12;
        Tue, 13 Dec 2022 00:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bnlx3J7xj4b2S36Pvv50tzjirC/v9wG+U3CGc8VZa1Y=;
        b=UIhRDTnSW0GbwMASEqcZ1rdGSZKcd26Fz5/YFbfpkU4IT3QjZddHE3gauJAiasA3JO
         PyfUYve9EfL0cSLGc7nqlyNDpcTGi6DC7HzeFCeC9nFE/Jmas5zo0yZVX9lEol6M3Kou
         9rh7AZmpEpVhjA6udSJHAha+S5MqhLkmIaJdlrdlU6LVcsO6TeyXUED8cXJSjEdj0u+G
         V+PdEOKrUAzKxcF52WRt4Lm2txx9XEjav+bZboiYYG8MI2a2zkPZKEuV6Y/dBFoZGGnF
         b0x8TAC/ONkKX07kXGrMoCRsgDdIoVl/QU5bRMQUrBTGCdjMGqKPqPnY33pyLgaHD58G
         8zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bnlx3J7xj4b2S36Pvv50tzjirC/v9wG+U3CGc8VZa1Y=;
        b=N6+Wfw/TDeg4kgrey+j+M7dRFIs4hN9kgnNzlKm2bYToqbV502vMdTAvjW4nWYxU8+
         RyJzbxoEzcpmLnxyO58CwM4eZt8x/isyzmhfJLvsRAnHWS7+3BuDICisY3IElq/KOQ5X
         SG9fmQY7kJrUAolcMVpudUDEjwFlHGqkmIcsm96ZD5KQgbnhtx3ZJYMPgpFD4dFC6dR2
         qUqWs1CUIvCkrsmIYKfgoTtEnp2EdXNoMkeJxLpQnb1w0OFE0AjwtrkDsC9wfPF5YFDm
         WMTsLjzOogV5KT9E/RSUQVeP6ZzaM4XvcW5OIA9ER3rellTyhYthXfDNaVVCq09hsBg8
         SseA==
X-Gm-Message-State: ANoB5pkNkXKV6gcBPxkwOADxr5cw6ktyJOY6J3Y75KE5tJt3GWrPfNts
        ELGM/FS/2k6tzofYK4diELNA1+SuOZ8/6lHM6vU=
X-Google-Smtp-Source: AA0mqf4GvS2zb/8MATAoImorkE/SP2zHRgtYCF/3xB7bUc7ELqjxzs+KoKew+wL5Bxsky+eWYJouTyF0PrzmXBDS7hg=
X-Received: by 2002:a05:6214:2e90:b0:4e3:3041:6b91 with SMTP id
 oc16-20020a0562142e9000b004e330416b91mr268136qvb.82.1670921164511; Tue, 13
 Dec 2022 00:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-12-victor.shih@genesyslogic.com.tw> <feab70af-0255-e7b2-9ff7-f26ee852ee00@intel.com>
In-Reply-To: <feab70af-0255-e7b2-9ff7-f26ee852ee00@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:45:51 +0800
Message-ID: <CAK00qKAH+gdkeq2JNMit2MrtWCmyQzckrWVXBs=So8cQsZ_=xQ@mail.gmail.com>
Subject: Re: [PATCH V5 11/26] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
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

On Wed, Nov 2, 2022 at 1:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-core.c |  1 +
> >  drivers/mmc/host/sdhci-pci-gli.c  |  1 +
> >  drivers/mmc/host/sdhci-uhs2.c     | 68 +++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     |  3 ++
> >  drivers/mmc/host/sdhci.c          |  3 +-
> >  drivers/mmc/host/sdhci.h          | 14 +++++++
> >  6 files changed, 89 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 34ea1acbb3cc..cba5bba994b8 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -1955,6 +1955,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
> >       .reset          = sdhci_reset,
> >       .set_uhs_signaling = sdhci_set_uhs_signaling,
> >       .hw_reset               = sdhci_pci_hw_reset,
> > +     .uhs2_reset             = sdhci_uhs2_reset,
>
> AFAICT this isn't needed
>

I will update it in the patch#10 of the new [PATCH V6].

> >  };
> >
> >  /*****************************************************************************\
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index 4d509f656188..607cf69f45d0 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -1097,6 +1097,7 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
> >       .reset                  = sdhci_reset,
> >       .set_uhs_signaling      = sdhci_set_uhs_signaling,
> >       .voltage_switch         = sdhci_gli_voltage_switch,
> > +     .uhs2_reset             = sdhci_uhs2_reset,
> >  };
> >
> >  const struct sdhci_pci_fixes sdhci_gl9755 = {
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 08905ed081fb..0e82f98d1967 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -10,6 +10,7 @@
> >   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/module.h>
> >
> >  #include "sdhci.h"
> > @@ -49,6 +50,73 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >
> > +/*****************************************************************************\
> > + *                                                                           *
> > + * Low level functions                                                       *
> > + *                                                                           *
> > +\*****************************************************************************/
> > +
> > +bool sdhci_uhs2_mode(struct sdhci_host *host)
> > +{
> > +     if ((host->mmc->caps2 & MMC_CAP2_SD_UHS2) &&
> > +         (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +             (host->version >= SDHCI_SPEC_400) &&
> > +             (host->mmc->flags & MMC_UHS2_SUPPORT)))
> > +             return true;
> > +     else
> > +             return false;
>
> For now, let's just make this:
>
>         return host->mmc->flags & MMC_UHS2_SUPPORT;
>

I will update it in the patch#10 of the new [PATCH V6].

> > +}
> > +
> > +/**
> > + * sdhci_uhs2_reset - invoke SW reset
> > + * @host: SDHCI host
> > + * @mask: Control mask
> > + *
> > + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> > + */
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> > +{
> > +     unsigned long timeout;
> > +     u32 val;
> > +
> > +     if (!(sdhci_uhs2_mode(host))) {
>
> That isn't possible.
>

I will update it in the patch#10 of the new [PATCH V6].

> > +             /**
> > +              * u8  mask for legacy.
> > +              * u16 mask for uhs-2.
> > +              */
> > +             u8 u8_mask;
> > +
> > +             u8_mask = (mask & 0xFF);
> > +             sdhci_reset(host, u8_mask);
>
> Probably should call host->ops->reset() but !sdhci_uhs2_mode(host)
> isn't possible
>

I will update it in the patch#10 of the new [PATCH V6].

> > +
> > +             return;
> > +     }
> > +
> > +     sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> > +
> > +     if (mask & SDHCI_UHS2_SW_RESET_FULL) {
> > +             host->clock = 0;
> > +             /* Reset-all turns off SD Bus Power */
> > +             if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> > +                     sdhci_runtime_pm_bus_off(host);
>
> We don't know what other drivers will opt for UHS-II
> support, but I doubt this quirk will be used, so  let's
> not support SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for UHS-II
>

I will update it in the patch#10 of the new [PATCH V6].

> > +     }
> > +
> > +     /* Wait max 100 ms */
> > +     timeout = 10000;
>
> Isn't that 10ms
>

I will update it in the patch#10 of the new [PATCH V6].

> > +
> > +     /* hw clears the bit when it's done */
> > +     if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> > +                                  timeout, true, host, SDHCI_UHS2_SW_RESET)) {
> > +             pr_err("%s: %s: Reset 0x%x never completed.\n",
> > +                                            __func__, mmc_hostname(host->mmc), (int)mask);
> > +             pr_err("%s: clean reset bit\n",
> > +                                            mmc_hostname(host->mmc));
> > +             sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> > +             return;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index afdb05d6056b..31776dcca5cf 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -11,6 +11,7 @@
> >  #define __SDHCI_UHS2_H
> >
> >  #include <linux/bits.h>
> > +#include <linux/iopoll.h>
>
> Not needed in header.  Can just be in .c
>

I will update it in the patch#10 of the new [PATCH V6].

> >
> >  /*
> >   * UHS-II Controller registers
> > @@ -210,5 +211,7 @@
> >  struct sdhci_host;
> >
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> > +bool sdhci_uhs2_mode(struct sdhci_host *host);
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 2cdd183c8ada..bd017c59a020 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -194,13 +194,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> >       pm_runtime_get_noresume(mmc_dev(host->mmc));
> >  }
> >
> > -static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> > +void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> >  {
> >       if (!host->bus_on)
> >               return;
> >       host->bus_on = false;
> >       pm_runtime_put_noidle(mmc_dev(host->mmc));
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
>
> Let's not support SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for UHS-II
>

I will update it in the patch#10 of the new [PATCH V6].

> >
> >  void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index bbed850241d4..28716105da61 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -715,6 +715,19 @@ struct sdhci_ops {
> >                                            u8 power_mode);
> >       unsigned int    (*get_ro)(struct sdhci_host *host);
> >       void            (*reset)(struct sdhci_host *host, u8 mask);
> > +     /**
> > +      * The sdhci_uhs2_reset callback is to implement for reset
> > +      * @host: SDHCI host
> > +      * @mask: Control mask
> > +      *
> > +      * Invoke reset, depending on a bit in @mask and wait for completion.
> > +      * SD mode                              UHS-II mode
> > +      * SDHCI_RESET_ALL              SDHCI_UHS2_SW_RESET_FULL
> > +      * SDHCI_RESET_CMD              SDHCI_RESET_CMD
> > +      * SDHCI_RESET_DATA             SDHCI_UHS2_SW_RESET_SD
> > +      *
> > +      **/
> > +     void (*uhs2_reset)(struct sdhci_host *host, u16 mask);
>
> This is only being called from sdhci_uhs2.c so let's just call it
> directly for now, instead of using a callback.
>

I will update it in the patch#10 of the new [PATCH V6].

> >       int     (*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
> >       void    (*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
> >       void    (*hw_reset)(struct sdhci_host *host);
> > @@ -837,6 +850,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
> >       __sdhci_read_caps(host, NULL, NULL, NULL);
> >  }
> >
> > +void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
>
> Let's not support SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for UHS-II
>

I will update it in the patch#10 of the new [PATCH V6].

> >  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >                  unsigned int *actual_clock);
> >  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
>

Thanks, Victor Shih
