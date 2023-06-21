Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DDA738009
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjFUKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjFUKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:31:31 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8251BE5;
        Wed, 21 Jun 2023 03:30:29 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-791b8525b59so542073241.1;
        Wed, 21 Jun 2023 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343429; x=1689935429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0yIfekPmP5tVkXQe4S+H7a/aBtT+m/UJj6wN/uttiI=;
        b=WuUEza/fDIqegyxXSHLxrZfgFg7nVyu3z5w9Bpt9vCRubynltwE1ikS9sdFzvoGzv8
         Vi9K8Moc53HgvXZX4ptf+a/mU2rNGBeoKf/kmdPUlIbGG3IZBhv/H/Ib23R9LE3zFJVe
         2RwYPs8KjLERbg8t27PUl4g2YYZNqLWnp+HEUb8ETieHanXHhWofu320p1RQE3hQIxoI
         2j+EL7/aZcWZ+YohfiMQnHyatx03zojriDwjDZ/pbmANNGGCuUHqaka/ewdkIv3xgowa
         4sTHPz/A2mb6wuDJu3h35DNWXSwWNewhY/zv2a5d/HO37qFdQWzh9yPE/0kGtUY9OmO/
         Hyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343429; x=1689935429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0yIfekPmP5tVkXQe4S+H7a/aBtT+m/UJj6wN/uttiI=;
        b=MoIqngWUkYLYtaVpxBhzDZGl3TW19rBCJf/3/7BM7M6m21OoscHWrukuq/nQxj5eVz
         RgXhe/fG+nNTjah4IGY6HL2bG/rLHMlOJrZAWDKfGQDrwf3T3LphKfwa7GRe1NcDBtSR
         i4NmCwQlMliTGtqxGkhzgCPr4pAUdf1lNKeuLd1Jk4fg+2DRxJ22eWtQlcK/IvMRRpiv
         vC6OcTli5PlfD1Rq9pFkHn8HcoG3LNwvNs+1Q8Zu+dWG3Kp2FdbD/w/a61Nki37EynQp
         BCikkCqDTcEa/PGFq3Zn0X+4YeL/bSvWqSKh587lnKi1VLzG+CN8VlTYQwWV57SdB8a6
         2hQg==
X-Gm-Message-State: AC+VfDzb7MSKnnZe/AtyzmV3WvwgysEUWhRjtab/fzWgNpnXQZjkDaWi
        nQW3GNp42zHdweqhvsrG45a7tJZNxJuhRDcZ1ns=
X-Google-Smtp-Source: ACHHUZ4LRTWC3EexcF9Wfia1y1u+xNMpKH0NN5jgIOYqM2pGK7La4BL2d7oN6Rb71+X9HTEWXYjUFlx+xDY5NVsu+EA=
X-Received: by 2002:a05:6102:3661:b0:43b:3cf8:bead with SMTP id
 bg1-20020a056102366100b0043b3cf8beadmr6303363vsb.0.1687343428820; Wed, 21 Jun
 2023 03:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-21-victor.shih@genesyslogic.com.tw> <201a16a1-b3bb-8aa9-af42-9683986be417@intel.com>
In-Reply-To: <201a16a1-b3bb-8aa9-af42-9683986be417@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:30:16 +0800
Message-ID: <CAK00qKBtMACp_-HLTB+9h2cbao_BhiMfF6sVDsWXAECDLy=+OQ@mail.gmail.com>
Subject: Re: [PATCH V7 20/23] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
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

Hi, Adrian

On Wed, Apr 12, 2023 at 9:12=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > This is a UHS-II version of sdhci's add_host/remove_host operation.
> > Any sdhci drivers which are capable of handling UHS-II cards must
> > call those functions instead of the corresponding sdhci's.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 119 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   2 +
> >  drivers/mmc/host/sdhci.c      |   7 +-
> >  drivers/mmc/host/sdhci.h      |   3 +
> >  4 files changed, 129 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 63f4bfce70b8..610780d425bc 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/ktime.h>
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/mmc/host.h>
> > +#include <linux/regulator/consumer.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -1004,6 +1005,124 @@ static irqreturn_t sdhci_uhs2_thread_irq(int ir=
q, void *dev_id)
> >       return IRQ_HANDLED;
> >  }
> >
> > +/*********************************************************************=
********\
> > + *
> > + * Device allocation/registration                                     =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static int __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1=
)
>
> Always returns 0, so change return type to 'void'
>

I will update it to the V8 version.

> > +{
> > +     struct mmc_host *mmc;
> > +     u32 max_current_caps2;
> > +
> > +     if (host->version < SDHCI_SPEC_400)
> > +             return 0;
> > +
> > +     mmc =3D host->mmc;
> > +
> > +     /* Support UHS2 */
> > +     if (caps1 & SDHCI_SUPPORT_UHS2)
> > +             mmc->caps2 |=3D MMC_CAP2_SD_UHS2;
> > +
> > +     max_current_caps2 =3D sdhci_readl(host, SDHCI_MAX_CURRENT_1);
> > +
> > +     if ((caps1 & SDHCI_CAN_VDD2_180) &&
> > +         !max_current_caps2 &&
> > +         !IS_ERR(mmc->supply.vmmc2)) {
> > +             /* UHS2 - VDD2 */
> > +             int curr =3D regulator_get_current_limit(mmc->supply.vmmc=
2);
> > +
> > +             if (curr > 0) {
> > +                     /* convert to SDHCI_MAX_CURRENT format */
> > +                     curr =3D curr / 1000;  /* convert to mA */
> > +                     curr =3D curr / SDHCI_MAX_CURRENT_MULTIPLIER;
> > +                     curr =3D min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT=
);
> > +                     max_current_caps2 =3D curr;
> > +             }
> > +     }
> > +
> > +     if (caps1 & SDHCI_CAN_VDD2_180) {
> > +             mmc->ocr_avail_uhs2 |=3D MMC_VDD_165_195;
> > +             /*
> > +              * UHS2 doesn't require this. Only UHS-I bus needs to set
> > +              * max current.
> > +              */
> > +             mmc->max_current_180_vdd2 =3D (max_current_caps2 &
> > +                                     SDHCI_MAX_CURRENT_VDD2_180_MASK) =
*
> > +                                     SDHCI_MAX_CURRENT_MULTIPLIER;
>
> max_current_180_vdd2 is not used.  Does it have a purpose?
>

I will update it to the V8 version.

> > +     } else {
> > +             mmc->caps2 &=3D ~MMC_CAP2_SD_UHS2;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
> > +
> > +static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead=
)
> > +{
> > +     if (!sdhci_uhs2_mode(host))
> > +             return;
> > +
> > +     if (!dead)
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
> > +}
> > +
> > +int sdhci_uhs2_add_host(struct sdhci_host *host)
> > +{
> > +     struct mmc_host *mmc =3D host->mmc;
> > +     int ret;
> > +
> > +     ret =3D sdhci_setup_host(host);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (host->version >=3D SDHCI_SPEC_400) {
> > +             ret =3D __sdhci_uhs2_add_host_v4(host, host->caps1);
> > +             if (ret)
> > +                     goto cleanup;
> > +     }
> > +
> > +     if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
> > +             /* host doesn't want to enable UHS2 support */
> > +             /* FIXME: Do we have to do some cleanup here? */
>
> Please do not leave FIXMEs
>

I will update it to the V8 version.

> > +             mmc->caps2 &=3D ~MMC_CAP2_SD_UHS2;
> > +
> > +     /* overwrite ops */
> > +     if (mmc->caps2 & MMC_CAP2_SD_UHS2)
> > +             sdhci_uhs2_host_ops_init(host);
> > +
> > +     host->complete_work_fn =3D sdhci_uhs2_complete_work;
> > +     host->thread_irq_fn    =3D sdhci_uhs2_thread_irq;
> > +
> > +     /* LED support not implemented for UHS2 */
> > +     host->quirks |=3D SDHCI_QUIRK_NO_LED;
> > +
> > +     ret =3D __sdhci_add_host(host);
> > +     if (ret)
> > +             goto cleanup2;
> > +
> > +     return 0;
> > +
> > +cleanup2:
> > +     if (host->version >=3D SDHCI_SPEC_400)
> > +             __sdhci_uhs2_remove_host(host, 0);
> > +cleanup:
> > +     sdhci_cleanup_host(host);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
> > +
> > +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> > +{
> > +     __sdhci_uhs2_remove_host(host, dead);
> > +
> > +     sdhci_remove_host(host, dead);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
> > +
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> >       struct sdhci_host *host =3D mmc_priv(mmc);
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index f733c733c692..5b5b4a8d4f27 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -185,5 +185,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *h=
ost, u32 clear, u32 set);
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)=
;
> >  int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request=
 *mrq);
> >  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> > +int sdhci_uhs2_add_host(struct sdhci_host *host);
> > +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index b3cf4a26eed5..d976d3a6ff8d 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -4105,6 +4105,9 @@ struct sdhci_host *sdhci_alloc_host(struct device=
 *dev,
> >
> >       host->max_timeout_count =3D 0xE;
> >
> > +     host->complete_work_fn =3D sdhci_complete_work;
> > +     host->thread_irq_fn    =3D sdhci_thread_irq;
> > +
> >       return host;
> >  }
> >
> > @@ -4854,7 +4857,7 @@ int __sdhci_add_host(struct sdhci_host *host)
> >       if (!host->complete_wq)
> >               return -ENOMEM;
> >
> > -     INIT_WORK(&host->complete_work, sdhci_complete_work);
> > +     INIT_WORK(&host->complete_work, host->complete_work_fn);
> >
> >       timer_setup(&host->timer, sdhci_timeout_timer, 0);
> >       timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> > @@ -4863,7 +4866,7 @@ int __sdhci_add_host(struct sdhci_host *host)
> >
> >       sdhci_init(host, 0);
> >
> > -     ret =3D request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_i=
rq,
> > +     ret =3D request_threaded_irq(host->irq, sdhci_irq, host->thread_i=
rq_fn,
> >                                  IRQF_SHARED, mmc_hostname(mmc), host);
> >       if (ret) {
> >               pr_err("%s: Failed to request IRQ %d: %d\n",
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 9e9158f811b1..e16267f5a3c0 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -627,6 +627,9 @@ struct sdhci_host {
> >       struct timer_list timer;        /* Timer for timeouts */
> >       struct timer_list data_timer;   /* Timer for data timeouts */
> >
> > +     void            (*complete_work_fn)(struct work_struct *work);
> > +     irqreturn_t     (*thread_irq_fn)(int irq, void *dev_id);
> > +
> >  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> >       struct dma_chan *rx_chan;
> >       struct dma_chan *tx_chan;
>

Thanks, Victor Shih
