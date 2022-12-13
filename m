Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8F64B17B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiLMIsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiLMIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:47:57 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFC419295;
        Tue, 13 Dec 2022 00:47:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so10017975qvs.2;
        Tue, 13 Dec 2022 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0IkJx54HRS4gC3tlvf+EndDwlHYwUBiKJIT7qZaR0yU=;
        b=OBd77Op7nnNLGdcv9mxdSKPDDuCzcqdUI40Jvqyf0o3P5Z3qN+JPGnbYiRZejrbJh8
         ewB38+lAwxBcSQ5SfxiGr6BnQG0Q/ntLbTYw81KpOmMAj1mUcLYlCuz7d9KT7e75fjHu
         RorivOHjgHQAvvxzhXWDcYsivW6ibBBos0ZXyZWKEy1ZLFyI+inc4I52bGEDekQOMV3v
         iuOjPnIHujZh8ij8H78NxuPcbAtdLBQk70K6Sg5wsq6+r1nZx5DBxVmenQVne/gf+1mb
         jPEISWy1FQJJv/RJuKXv8xHaKuBhIIxpQci0RI4rVxZe8ROVBQ1yIMe3Ln7zgqPALjzo
         mAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IkJx54HRS4gC3tlvf+EndDwlHYwUBiKJIT7qZaR0yU=;
        b=cZTP3FH9Q6aa9po4jGgpKpMHdQDQUgBUjR+UWjntsI5tLRl2TTIepw5OQMwLhN/xV5
         bPHyQ0qFahNybDZ+5ffWOrbl9CEGF+k3e+uJVk8v1d+2d+d8pQWkE68aND01hOeV1aUo
         M/HPbWYlScMikmbrGyoRwQ0oNBxetE7RytWJb4kEk/JU3VxnzjlieLg1xkByy71f6uxv
         djD0pYjT+wZS6pHlU4PoO1irVpJ47NYPIQUzWI421JcpjqbeS0x1mzFYYQJcdxubMFQM
         ruL6tIdAcCdl5roCqZmUxS7zDMF/3CI7mwlQgWWwWVBhBftJiVhKiKW9gEz+Vsqroiro
         ndbw==
X-Gm-Message-State: ANoB5plhwkMojRkXsVmjUz+hVmkPvdIV/hond1rYFBSq2+/Fw7c5W0XR
        NU2v4VkvqFuIh+sIolD/d+6AdrdVHlEf8bccS/YLlxhoCW4=
X-Google-Smtp-Source: AA0mqf6CDzM9Tu8alIrdmXEbgSGfYihUlAE+rQBJq1qx8i28ypjdE91oJpVXS0Jul6GfPHdWeTsf400qmMM8nnu1no0=
X-Received: by 2002:a05:6214:2dc1:b0:4c7:63c0:a357 with SMTP id
 nc1-20020a0562142dc100b004c763c0a357mr16288907qvb.123.1670921273299; Tue, 13
 Dec 2022 00:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-19-victor.shih@genesyslogic.com.tw> <e935fe27-ea94-366f-4fd4-f40b05af30b8@intel.com>
In-Reply-To: <e935fe27-ea94-366f-4fd4-f40b05af30b8@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:47:40 +0800
Message-ID: <CAK00qKC-8GwkQLPnacwBMtuAsG--_t7R65g-tuHbzwmudzYr=A@mail.gmail.com>
Subject: Re: [PATCH V5 18/26] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
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

On Wed, Nov 2, 2022 at 1:15 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > This is a sdhci version of mmc's uhs2_set_reg operation.
> > UHS-II interface (related registers) will be initialised here.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 103 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      |  12 ++++
> >  drivers/mmc/host/sdhci.h      |   1 +
> >  3 files changed, 116 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index afaca5d96938..c9d59b8ac37f 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -350,6 +350,53 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >       spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> > +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> > +{
> > +     u32 value;
> > +     u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> > +     u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
> > +     u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> > +     u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
> > +     u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
> > +
> > +     /* Set Gen Settings */
> > +     sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
> > +             SDHCI_UHS2_GEN_SET_N_LANES_POS, sdhci_uhs2_gen_set_reg);
> > +
> > +     /* Set PHY Settings */
> > +     value = (host->mmc->uhs2_caps.n_lss_dir_set <<
> > +                     SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
> > +             (host->mmc->uhs2_caps.n_lss_sync_set <<
> > +                     SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
> > +     if (host->mmc->flags & MMC_UHS2_SPEED_B)
> > +             value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
> > +     sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> > +
> > +     /* Set LINK-TRAN Settings */
> > +     value = (host->mmc->uhs2_caps.max_retry_set <<
> > +                     SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
> > +             (host->mmc->uhs2_caps.n_fcu_set <<
> > +                     SDHCI_UHS2_TRAN_SET_N_FCU_POS);
> > +     sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> > +     sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
> > +                  sdhci_uhs2_tran_set_1_reg);
> > +}
> > +
> > +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> > +{
> > +     u32 val;
> > +     /* 100ms */
> > +     int timeout = 100000;
> > +
> > +     if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
> > +                                  100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> > +             pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return -EIO;
> > +     }
> > +     return 0;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * MMC callbacks                                                             *
> > @@ -435,6 +482,61 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> >       return 0;
> >  }
> >
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
> > +
> > +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     unsigned long flags;
> > +     int err = 0;
> > +     u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> > +     u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> > +
> > +     DBG("Begin %s, act %d.\n", __func__, op);
>
> DBG already has __func__.  Please also check other DBG that
> have duplicate __func__
>

I will update it in the patch#17 of the new [PATCH V6].

> > +
> > +     spin_lock_irqsave(&host->lock, flags);
>
> This all relates to initialization or reinitialization, so I suspect
> the spinlock is not needed here.  What could it be racing with?
>

I will delete it and update it in the patch#17 of the new [PATCH V6].

> > +
> > +     switch (op) {
> > +     case UHS2_PHY_INIT:
> > +             err = sdhci_uhs2_do_detect_init(mmc);
> > +             break;
> > +     case UHS2_SET_CONFIG:
> > +             sdhci_uhs2_set_config(host);
> > +             break;
> > +     case UHS2_ENABLE_INT:
> > +             sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> > +             break;
> > +     case UHS2_DISABLE_INT:
> > +             sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> > +             break;
> > +     case UHS2_SET_SPEED_B:
> > +             sdhci_writeb(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
> > +                          sdhci_uhs2_phy_set_reg);
> > +             break;
> > +     case UHS2_CHECK_DORMANT:
> > +             err = sdhci_uhs2_check_dormant(host);
> > +             break;
> > +     case UHS2_DISABLE_CLK:
> > +             err = sdhci_uhs2_disable_clk(mmc);
> > +             break;
> > +     case UHS2_ENABLE_CLK:
> > +             err = sdhci_uhs2_enable_clk(mmc);
> > +             break;
> > +     case UHS2_POST_ATTACH_SD:
> > +             host->ops->uhs2_post_attach_sd(host);
> > +             break;
> > +     default:
> > +             pr_err("%s: input sd uhs2 operation %d is wrong!\n",
> > +                    mmc_hostname(host->mmc), op);
> > +             err = -EIO;
> > +             break;
> > +     }
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     return err;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -589,6 +691,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >       host->mmc_host_ops.start_signal_voltage_switch =
> >               sdhci_uhs2_start_signal_voltage_switch;
> >       host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
> > +     host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
> >
> >       if (!host->mmc_host_ops.uhs2_detect_init)
> >               host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index de47c71995fb..b9db2e976010 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -236,6 +236,18 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_reset);
> >
> > +void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> > +{
> > +     u32 ier;
> > +
> > +     ier = sdhci_readl(host, SDHCI_INT_ENABLE);
> > +     ier &= ~clear;
> > +     ier |= set;
> > +     sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> > +     sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_clear_set_irqs);
>
> This might as well be in sdhci-uhs2.c since that is the only
> place that calls it.  Then there is no need to export it.
>

I will update it in the patch#17 of the new [PATCH V6].

> > +
> >  static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> >  {
> >       if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 22d7f47862ae..f049331bd0bc 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -869,6 +869,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> >  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
> >  void sdhci_set_bus_width(struct sdhci_host *host, int width);
> >  void sdhci_reset(struct sdhci_host *host, u8 mask);
> > +void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> >  void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>

Thanks, Victor Shih
