Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF4738211
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjFUKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjFUK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:29:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07F010FF;
        Wed, 21 Jun 2023 03:29:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76300f4d7eeso289950085a.1;
        Wed, 21 Jun 2023 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343356; x=1689935356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6oydh2z+9BD2xN5fYVOiouomjrPMUylVGUWJZe+hs4=;
        b=n98aPdiX6veuuN4Da8g8gQRJOGH6lsx9hRrYGQJg7H6cdrIu60xKtpaDLqpPNYGYmO
         x5f1gEim4yZ8NLzZ01dQhnVb5E1e9/kowi8sluFE74WVUX5dCgO2fFqLdRotmSaHqEmP
         PZLAF9I5PVeQmpBc37E3iDL6NknbM3tjH6WxvCE4PyOU5WtXsgeUBHu0Y9n+5ze4VP6Y
         evSIw6Yu7NoDTzFhOEyT/iQgQoyfxCt0VaxGdSS+JEiAXaTkED7IgQNR3sS5JhLC84Rj
         4A6ujyjJpVPoLqSV/QbbkG8dYEsKpwHAD3G1cEALKkoEpb9NuOu8XMo/7qUUjA482/aD
         ZJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343356; x=1689935356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6oydh2z+9BD2xN5fYVOiouomjrPMUylVGUWJZe+hs4=;
        b=CRYGDW9quiHGfOtYAc/ZN55G/NzChXkCNe1oVS31kVvA2DckxsmFq5aXAzvggXNKcI
         wYdAAl3+KYlvX2ILM2PUZrbDvthuF+kIpluvwMma+SYCkOBJGLiXD1FKhFeSQh9AFWMq
         +C5JjX/WRbQxcL2sVdZhu4g+FgFUlkdutZgDnfz2AkYqKOS81xdNxHov1XFv8Api1fPd
         ZRC5ypEi7fDJ/1m4bL+5K90U+8WgmPOuQoTycdPQnoSFA+bwKfSBFIMeHgKEO3WmvGDf
         xoFmTFcqycsaF/x93YqVq2wN7wLm8q0/G1mU2KVjbJqHruLXIC07Bwx/73n5aQwqE8J3
         zOtA==
X-Gm-Message-State: AC+VfDxfpfuul1KMW26KXuOZVzWBNNZJdN+vObRpWjvW8XqaA2nf4Kmc
        P5DVoGKY8+GZU4tBLMvJmOKY2NWfAi+ZBs4kTno=
X-Google-Smtp-Source: ACHHUZ4p4zoYoFzRTH6ahFnCEbnGUHwAgBZA2jgVk/C1RG6uIyBddlPhWOOa8FLusqfsjh/gtPfjyvYULXCR35TIcY8=
X-Received: by 2002:a05:620a:2091:b0:762:733d:4286 with SMTP id
 e17-20020a05620a209100b00762733d4286mr9015337qka.66.1687343356027; Wed, 21
 Jun 2023 03:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-14-victor.shih@genesyslogic.com.tw> <ef06dc89-2de2-7607-2938-a5d76875310b@intel.com>
In-Reply-To: <ef06dc89-2de2-7607-2938-a5d76875310b@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:29:03 +0800
Message-ID: <CAK00qKB-xp1pJQevUH4FFYC8JGORXGqAtwaKB9Um9P=jdm5ZPA@mail.gmail.com>
Subject: Re: [PATCH V7 13/23] mmc: sdhci-uhs2: add set_timeout()
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
> > This is a UHS-II version of sdhci's set_timeout() operation.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  2 files changed, 73 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 388d87537847..e2e9ce51b768 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/bitfield.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -144,6 +145,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host=
 *host, unsigned char mode,
> >       }
> >  }
> >
> > +static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res=
, u8 *dead_lock)
> > +{
> > +     u8 count;
> > +     unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
> > +     /* timeout in us */
> > +     cmd_res_timeout =3D 5 * 1000;
> > +     dead_lock_timeout =3D 1 * 1000 * 1000;
>
> Initialization should be combined with declaration,
> and by descending line length looks neater i.e.
>
>         unsigned int dead_lock_timeout =3D 1 * 1000 * 1000;
>         unsigned int cmd_res_timeout =3D 5 * 1000;
>         unsigned int current_timeout;
>         u8 count;
>

I will update it to the V8 version.

> > +
> > +     /*
> > +      * Figure out needed cycles.
> > +      * We do this in steps in order to fit inside a 32 bit int.
> > +      * The first step is the minimum timeout, which will have a
> > +      * minimum resolution of 6 bits:
> > +      * (1) 2^13*1000 > 2^22,
> > +      * (2) host->timeout_clk < 2^16
> > +      *     =3D>
> > +      *     (1) / (2) > 2^6
> > +      */
> > +     count =3D 0;
> > +     current_timeout =3D (1 << 13) * 1000 / host->timeout_clk;
> > +     while (current_timeout < cmd_res_timeout) {
> > +             count++;
> > +             current_timeout <<=3D 1;
> > +             if (count >=3D 0xF)
> > +                     break;
> > +     }
> > +
> > +     if (count >=3D 0xF) {
> > +             DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n"=
,
> > +                 mmc_hostname(host->mmc), count);
> > +             count =3D 0xE;
> > +     }
> > +     *cmd_res =3D count;
> > +
> > +     count =3D 0;
> > +     current_timeout =3D (1 << 13) * 1000 / host->timeout_clk;
> > +     while (current_timeout < dead_lock_timeout) {
> > +             count++;
> > +             current_timeout <<=3D 1;
> > +             if (count >=3D 0xF)
> > +                     break;
> > +     }
> > +
> > +     if (count >=3D 0xF) {
> > +             DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n=
",
> > +                 mmc_hostname(host->mmc), count);
> > +             count =3D 0xE;
> > +     }
> > +     *dead_lock =3D count;
> > +
> > +     return count;
> > +}
> > +
> > +static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
> > +{
> > +     u8 cmd_res, dead_lock;
> > +
> > +     sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +     cmd_res |=3D FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead=
_lock);
> > +     sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +}
> > +
> > +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd)
> > +{
> > +     __sdhci_set_timeout(host, cmd);
> > +
> > +     if (sdhci_uhs2_mode(host))
> > +             __sdhci_uhs2_set_timeout(host);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * MMC callbacks                                                      =
       *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index 6834893eee85..fc03a178b676 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -180,5 +180,6 @@ struct sdhci_host;
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> > +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
>
> Really should forward declare 'struct mmc_command' as was done
> for 'struct sdhci_host'
>

I will update it to the V8 version.

> >
> >  #endif /* __SDHCI_UHS2_H */
>

Thanks, Victor Shih
