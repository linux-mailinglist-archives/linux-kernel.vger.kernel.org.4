Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2A73814D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjFUKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjFUKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:30:24 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B11713;
        Wed, 21 Jun 2023 03:29:56 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-791b8500a21so414434241.2;
        Wed, 21 Jun 2023 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343395; x=1689935395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMCux8A+vayWMu4AoFWo6pfmWLbJpk84dfEsjo0cqwo=;
        b=Z5bevpMLpE2IDCFfw5EQ/5KNQOTTNzgCsthy3AAgRYnibGyJXr/da5d2tlIQl085oI
         o4L8vVxNwfPJzBDudECRTPThyNxsnTWCEQvaF7QZD4C9tow0Wz5OgyH3scXfiyNZ0nhP
         KfuMMhYL4V0kbcnbMFJIBk9Ny3ITzXzkmkR3+ZSlF5Wgf+aIpA60fmTRlR9DZD3TEGEw
         UIniagQ7yTpLIY0Ef67spcgOxsS59xsnDzGQftimz/abdWDEYPW2zgBs3G2N2lvudLL0
         yyacvXpAcrMinJasgSE/+LF9PXPUmsMlkVWlHy0Mn0AOqtCnZ9pU/N7WfAEy/ehoFRxg
         FQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343395; x=1689935395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMCux8A+vayWMu4AoFWo6pfmWLbJpk84dfEsjo0cqwo=;
        b=ZLPpAlA9OxsnV+BfWO7LMziMZDxpOtbbgmFyPJz2uOZztp+a5GKW4gnX8kHBBzsm5G
         KgU73cA4DaDSUx2xC8BZAFsLIK2PZeNFX2PJFHoo2IzkVDpiEoZWGOA+A8hZJbx1SryP
         ZrYAB4UCl3ZdrCLJ7ALV5xwgbjMFhKIvrEOwH7qz4IZUYfMQyr8RaaOmeNJDJ6GkNGiY
         gjS5qMcp+pqUbj5ZpQam8NakKoD0Kn5Ivn+SHnQrKDG2GD3Erd4e1KTA6/i9GJnXd52E
         8lR9/ikXKhUYfHtzoreeXZS7OjfNFuZOXOK8pRVw0+rCPDawmx/Asm19batR6Ll4Vokg
         +yjw==
X-Gm-Message-State: AC+VfDzxW3AlRVMW9f5UsbvT2BbaqDVCTqe4TYHS5kZPimMWDLm/2EGn
        KwuOc3qpJHKdUhDBziX5W4vNTbay7agZsToh9eE=
X-Google-Smtp-Source: ACHHUZ6hZltHCLh+QgJr+Y0kyXz5qi/YTuZZu+Gy1Mmc/SbM/u2KoI/8O69BkZ+RHAlLq498F+eO/YXlQlRXe53ghEU=
X-Received: by 2002:a67:f8cd:0:b0:440:b33b:e7ea with SMTP id
 c13-20020a67f8cd000000b00440b33be7eamr2915043vsp.19.1687343395122; Wed, 21
 Jun 2023 03:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-17-victor.shih@genesyslogic.com.tw> <d92adcc7-5303-5d2c-0d41-f28143b3e469@intel.com>
In-Reply-To: <d92adcc7-5303-5d2c-0d41-f28143b3e469@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:29:43 +0800
Message-ID: <CAK00qKDVU5_JF4kBAM2dwj55n35KhJQWr0AAQ_hghJcFBwPLsw@mail.gmail.com>
Subject: Re: [PATCH V7 16/23] mmc: sdhci-uhs2: add clock operations
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

On Wed, Apr 12, 2023 at 9:13=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index e2972be1889f..71ac76065886 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/module.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/ktime.h>
>
> There is no ktime in this patch
>

I will update it to the V8 version.

> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -328,6 +329,37 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> >       return 0;
> >  }
> >
> > +static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     u16 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +     clk &=3D ~SDHCI_CLOCK_CARD_EN;
> > +     sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     u16 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +     u32 val;
> > +     /* 20ms */
> > +     int timeout_us =3D 20000;
>
> Let's put the comment on the end and put the lines in
> descending line length i.e.
>
>         int timeout_us =3D 20000; /* 20ms */
>         u32 val;
>

I will update it to the V8 version.

> > +
> > +     clk |=3D SDHCI_CLOCK_CARD_EN;
> > +     sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +     if (read_poll_timeout_atomic(sdhci_readw, val, (val & SDHCI_CLOCK=
_INT_STABLE),
> > +                                  10, timeout_us, true, host, SDHCI_CL=
OCK_CONTROL)) {
>
> atomic does not seem to be needed here
>

I will update it to the V8 version.

> > +             pr_err("%s: Internal clock never stabilised.\n", mmc_host=
name(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return 1;
>
>                 return -EIO;
>

I will update it to the V8 version.

> > +     }
> > +     return 0;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
>

Thanks, Victor Shih
