Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA797380EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjFUKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjFUKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:31:34 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB8119B5;
        Wed, 21 Jun 2023 03:30:34 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-440b5998e47so1163976137.3;
        Wed, 21 Jun 2023 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343434; x=1689935434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxz1A4WP4cHzqzHFho3q4yzP3sOXcVcc0rGXdtQzrEI=;
        b=MNI0/ubGp87h8eVYrazNIbaw/v1ICin4ZOFOWND8hq+kaIoUbXsp43jMsOyBOzCEvC
         AbOdI7P0S3rbcX6X77XmyfC3YKLpQpFou61AnIUKcm5rsBTtVLxvAKWCy5aAnsc/e2r/
         iAm+JSxo3vlgFhMhJkb9yGO1ugDx/mSUHd+EObsUeUEEbQLRJtO3cVzGmCjnXbko/WfU
         lwPXtS7xZXhXY4BFEcuBuCryAfmmM3anwjYS8N/aEeqz/KreCGsA9NOauvTKGANRtiLg
         MrXgE/cK3QsbboJkigvKfXp06vSAiAXIaQkSUV2VGJI5SKuw6mkJkp5T0e5s3oZSotV7
         etIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343434; x=1689935434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxz1A4WP4cHzqzHFho3q4yzP3sOXcVcc0rGXdtQzrEI=;
        b=M7qGGWxU+Ls8BSGsHr+TNXfZZN+812tRuSAe+heoaVzS1KuD/g4TexsNv+DZYGEJce
         YJoQ1JnrAX848qyvTLiDEmXtiuJXFV8bZPy0hQCMLP4MJakZMfi6hCqzeRMwvpXpa/ov
         Hxd+NWBsaDqCMNFtz3028o390+owcS/2jMknWPya8o0G4ehExGTYu8jj/VC/K/pBR6Iw
         4BWMGwSHYBF9bZbirf4bJ/oREOMWZkNl3pQOO+uVMW1elQjinMgeCWeQ4YgcoBQ5NsAL
         9SE6uj/0q5mNfy0UAySu4jgjM7+kJL3Jq1ZRXkpkyWDbYLVIZSWo1IW23QQzdgvrI0ry
         pnVQ==
X-Gm-Message-State: AC+VfDxiTY1hi65IwDgeXydb8S9SZS4CAZ4w03KzDagzUwrYs1qfRl7r
        GhIeavMYVPT47SdJSxg106UA9el71tFB8Krq8u6CSH5Lxs8=
X-Google-Smtp-Source: ACHHUZ563mLn9CopEMQuTNy6OC0h2XWHy8a4ZNX2lX2ASxqUDFoiW9dWobrokwAqOwWZD7+3N4h9TgafUVZA1c9ArhE=
X-Received: by 2002:a05:6102:1cf:b0:43d:c0d5:ed27 with SMTP id
 s15-20020a05610201cf00b0043dc0d5ed27mr5790780vsq.32.1687343434050; Wed, 21
 Jun 2023 03:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-23-victor.shih@genesyslogic.com.tw> <4ca03e58-b1a7-cd97-17fd-f63d86949990@intel.com>
In-Reply-To: <4ca03e58-b1a7-cd97-17fd-f63d86949990@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:30:21 +0800
Message-ID: <CAK00qKCN0LwruFjGXHPTL17NhTouOSc0s3w=8RKB=LMyP2i93w@mail.gmail.com>
Subject: Re: [PATCH V7 22/23] mmc: sdhci-pci: add UHS-II support framework
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
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> > This patch prepares for adding UHS-II support at a specific UHS-II
> > capable sdhci-pci controller, GL9755 for now.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
> >  drivers/mmc/host/sdhci-pci.h      |  3 +++
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci=
-pci-core.c
> > index 01975d145200..6b5109f7feef 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -40,6 +40,7 @@
> >  #include "sdhci.h"
> >  #include "sdhci-cqhci.h"
> >  #include "sdhci-pci.h"
> > +#include "sdhci-uhs2.h"
> >
> >  static void sdhci_pci_hw_reset(struct sdhci_host *host);
> >
> > @@ -2155,7 +2156,10 @@ static void sdhci_pci_remove_slot(struct sdhci_p=
ci_slot *slot)
> >       if (scratch =3D=3D (u32)-1)
> >               dead =3D 1;
> >
> > -     sdhci_remove_host(slot->host, dead);
> > +     if (slot->chip->fixes && slot->chip->fixes->remove_host)
> > +             slot->chip->fixes->remove_host(slot, dead);
> > +     else
> > +             sdhci_remove_host(slot->host, dead);
> >
> >       if (slot->chip->fixes && slot->chip->fixes->remove_slot)
> >               slot->chip->fixes->remove_slot(slot, dead);
> > @@ -2163,6 +2167,16 @@ static void sdhci_pci_remove_slot(struct sdhci_p=
ci_slot *slot)
> >       sdhci_free_host(slot->host);
> >  }
> >
> > +int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
> > +{
> > +     return sdhci_uhs2_add_host(slot->host);
>
> This patch does not compile because uhs2 functions
> cannot be called yet because config MMC_SDHCI_UHS2
> is not yet selected.
>
> Please ensure all patches compile before submitting.
>

I will fix it in the V8 version.

> > +}
> > +
> > +void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
> > +{
> > +     sdhci_uhs2_remove_host(slot->host, dead);
> > +}
> > +
> >  static void sdhci_pci_runtime_pm_allow(struct device *dev)
> >  {
> >       pm_suspend_ignore_children(dev, 1);
> > diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.=
h
> > index 3661a224fb04..7f4a981c0e63 100644
> > --- a/drivers/mmc/host/sdhci-pci.h
> > +++ b/drivers/mmc/host/sdhci-pci.h
> > @@ -140,6 +140,7 @@ struct sdhci_pci_fixes {
> >       int                     (*probe_slot) (struct sdhci_pci_slot *);
> >       int                     (*add_host) (struct sdhci_pci_slot *);
> >       void                    (*remove_slot) (struct sdhci_pci_slot *, =
int);
> > +     void                    (*remove_host) (struct sdhci_pci_slot *, =
int);
> >
> >  #ifdef CONFIG_PM_SLEEP
> >       int                     (*suspend) (struct sdhci_pci_chip *);
> > @@ -184,6 +185,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci=
_slot *slot)
> >       return (void *)slot->private;
> >  }
> >
> > +int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
> > +void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)=
;
> >  #ifdef CONFIG_PM_SLEEP
> >  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
> >  #endif
>

Thanks, Victor Shih
