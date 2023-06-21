Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026EB738104
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFUK3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjFUK3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:29:01 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE4D10D0;
        Wed, 21 Jun 2023 03:28:54 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4715758343aso1755874e0c.1;
        Wed, 21 Jun 2023 03:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343334; x=1689935334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DePKvnQF58e7NgVJzJR+MJy8hVAWvCat6JztHMBEOEs=;
        b=ihBu3CWYl2pzRaktU1TEgJkUaK+BVQGxBX87Ah/HVKVyDXAUuWZt5YMIm2EspeAHAI
         sDpdejQfTXJEpdicBbtKAby3YJYccyIdFhXV6h1b6TUZBR11vZpMflmvrMSOvUBJMPNm
         nQuhPANQ7kCQz0U1hy85clD5XTX0/3ajKf5OF1nGwgqrfjZxztrq9+nyQL3+0BYu1WBq
         X5hvEqB2YkrWt2mDVo2S56Taf9YwkYOGXBZeq6xtd7myymnrxcvMPUKJcSndTs17Kr57
         HRSY29mCIsYec5XGBlVxsJEeXOwptM1vAzVRWt53JkylEtKaaS95MTm/MC0HnZnog41x
         B7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343334; x=1689935334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DePKvnQF58e7NgVJzJR+MJy8hVAWvCat6JztHMBEOEs=;
        b=b7eGfjf4dJTgVjL+qSD0jaNRQIsx7g5Y3I7mO+hInLjVRG+CbZATDOIhuluyMzsA91
         7ONpE2xSe7jnEIehZTMFi9DxTW2iJ2bmVP6uliL4Hx0a5+kOrL/ndTTJOp/+0rDireaG
         6V2w85eaKGyD6TTMovdCovSqhmIlk8dgR+j72hkjGoMaPzXFPl+x2YivJhVX9TAF0LJ4
         f2JmN1RiVNPDatC2L2+k9cxRltdsnpF1Z7RUI2jXMUosSrwBuStGEHrIcDOPAv9rdLqy
         aMKkCjBXGf5VXnO1HWZtTX83yPygJs3qdawpj5v3e0BC9K+/LdwyFVLz/4Ux1DNmQdFn
         AP1Q==
X-Gm-Message-State: AC+VfDy/K5K79caa8XnVYro5UvrEA8v4GMF/rCOSXMCBixBRHWkYj0E3
        aCNei9r0x3PUQ6s7IMFtgQeookLczu5Ern5aB0Q=
X-Google-Smtp-Source: ACHHUZ6dOxjO5Wv1a3t72CZoI+4tK5Lj4vcRay90kKn5VJZZGCtSj6NPJvfAk28Jvpui/RquSimuKf+zBEV3o4N+kKo=
X-Received: by 2002:a1f:418e:0:b0:471:24c3:6cd3 with SMTP id
 o136-20020a1f418e000000b0047124c36cd3mr5588568vka.11.1687343333674; Wed, 21
 Jun 2023 03:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-11-victor.shih@genesyslogic.com.tw> <08355847-0639-3ac9-23b6-6788f3ca5400@intel.com>
In-Reply-To: <08355847-0639-3ac9-23b6-6788f3ca5400@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:28:41 +0800
Message-ID: <CAK00qKDYjDC6k-9sYAEYdtYFsOx0HvKab6s03Zxp6=xFoRYHxQ@mail.gmail.com>
Subject: Re: [PATCH V7 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
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

On Wed, Apr 12, 2023 at 9:10=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  2 ++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 524d7cb6f2fd..67621eaabafc 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -10,7 +10,9 @@
> >   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/module.h>
> > +#include <linux/iopoll.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -49,6 +51,50 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Low level functions                                                =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +bool sdhci_uhs2_mode(struct sdhci_host *host)
> > +{
> > +     return host->mmc->flags & MMC_UHS2_SUPPORT;
> > +}
> > +
> > +/**
> > + * sdhci_uhs2_reset - invoke SW reset
> > + * @host: SDHCI host
> > + * @mask: Control mask
> > + *
> > + * Invoke SW reset, depending on a bit in @mask and wait for completio=
n.
> > + */
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> > +{
> > +     unsigned long timeout;
> > +     u32 val;
> > +
> > +     sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> > +
> > +     if (mask & SDHCI_UHS2_SW_RESET_FULL)
> > +             host->clock =3D 0;
> > +
> > +     /* Wait max 100 ms */
> > +     timeout =3D 100000;
> > +
> > +     /* hw clears the bit when it's done */
> > +     if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> > +                                  timeout, true, host, SDHCI_UHS2_SW_R=
ESET)) {
> > +             pr_err("%s: %s: Reset 0x%x never completed.\n",
> > +                                            __func__, mmc_hostname(hos=
t->mmc), (int)mask);
>
> CHECK: Alignment should match open parenthesis
> #70: FILE: drivers/mmc/host/sdhci-uhs2.c:89:
> +               pr_err("%s: %s: Reset 0x%x never completed.\n",
> +                                              __func__, mmc_hostname(hos=
t->mmc), (int)mask);
>

I will fix it in the V8 version.

> > +             pr_err("%s: clean reset bit\n",
> > +                                            mmc_hostname(host->mmc));
>
> Line wrap not needed
>

I will update it to the V8 version.

> > +             sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> > +             return;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index e948119348da..6834893eee85 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -178,5 +178,7 @@
> >  struct sdhci_host;
> >
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> > +bool sdhci_uhs2_mode(struct sdhci_host *host);
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >
> >  #endif /* __SDHCI_UHS2_H */
>

Thanks, Victor Shih
