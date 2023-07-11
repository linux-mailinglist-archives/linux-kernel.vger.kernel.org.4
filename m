Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261C74F2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGKPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:06:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC01310CF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:06:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2640a8ceefdso4225264a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689088002; x=1691680002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JvD88681HbiR2SoA2cEn2GGKO41btg39V7tlXMdvHns=;
        b=SVxtXNSX/kk+vJJKUkRSVBRWD1pizRMYKn3HL0clFDyxAD/8hCluES1y3RMCdY63hR
         /+KoCLJD7jD6dXnlqLbcuIuASY+2JsGoGy1fRXXMTUAcQKU35+etOofgjGazN7fNyEw3
         vakYdfPQfA3ZW8jCjhyhbLwp8uOWsF+aectobcPRJO50KIVh9qSPKIXhhmwe1QVU7rqQ
         RrP60Ps0s4wf1/XbulQeaE+rsPNHzoVxj7i+Gav14CO2UDAQRrLUnP7lQT4kJknDTR6X
         p3D5Ymrq18qQ1DTz0p5KnygCq+e7Z/zF96du2xWPHRoeroGq5p/lpkrYckrxVcsF9eRl
         P1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088002; x=1691680002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvD88681HbiR2SoA2cEn2GGKO41btg39V7tlXMdvHns=;
        b=cvanlNDSTqhMSjGYTkR4yGPsuClk6vZ35ijvwcYDH94LagYNf5YNSg7MPPTPxBgtdE
         3j8SWgdquFn0n+T1KAloJ0hkZ+Cvm6BRG/JtDuPuCuVIhCAlPWIiL13KfkfH2Z3ySm7W
         9WvNATL898avIIaqypXozpcv0cLTKhq5G9aBnaTmhsMX3Vovjgva3l/C6ME23WkAGX3c
         GoO5QNUZBsOJ1tN6FMe/FOczSVoBulohY4iiC05eJLQGKdKVC8J+YhvjlaP0oqrwwhpj
         9yFj6INR3jsx2Em38QghQuucglMlt9U9Otp4p5HlJI0QkRCm8JTHFjB59/+zui7fxxVh
         2tFQ==
X-Gm-Message-State: ABy/qLZ36hXmkIsz1mbEWOFH6KhhGa8JMldtNMzoMU45/RTrDbedtZ8E
        fggNK0RWHJFdJZKm4ne/lYdGuI/lXCfCrOLZdBqaNw==
X-Google-Smtp-Source: APBJJlFioyrNC+tB096lda4kFRj/UzJoN48xYCtcyAoXLHRvqiM1qJKYlTnKrYWB6Pr0UoaN+kLQW+T0aBD1vXiuBbI=
X-Received: by 2002:a17:90a:ac0d:b0:262:ec13:d3a with SMTP id
 o13-20020a17090aac0d00b00262ec130d3amr17436983pjq.28.1689088001969; Tue, 11
 Jul 2023 08:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230710164705.3985996-1-Naresh.Solanki@9elements.com>
 <20230710164705.3985996-2-Naresh.Solanki@9elements.com> <a307e9d6-bdd3-4fff-bf9b-f8919b6b0d69@roeck-us.net>
In-Reply-To: <a307e9d6-bdd3-4fff-bf9b-f8919b6b0d69@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 11 Jul 2023 17:06:30 +0200
Message-ID: <CABqG17iNH7tzs4GqJKu=Wd+nq3e03zjrJMKOcrd9eGpBf0aRWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (dimmtemp) Add Sapphire Rappids support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, 10 Jul 2023 at 20:48, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Jul 10, 2023 at 06:47:04PM +0200, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > This patch extends the functionality of the hwmon (dimmtemp) to include
> > support for Sapphire Rappids platform.
> >
> > Sapphire Rappids can accommodate up to 8 CPUs, each with 16 DIMMs. To
> > accommodate this configuration, the maximum supported DIMM count is
> > increased, and the corresponding Sapphire Rappids ID and threshold code
> > are added.
> >
> > The patch has been tested on a 4S system with 64 DIMMs installed.
> > Default thresholds are utilized for Sapphire Rappids, as accessing the
> > threshold requires accessing the UBOX device on Uncore bus 0, which can
> > only be achieved using MSR access. The non-PCI-compliant MMIO BARs are
> > not available for this purpose.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> Does this patch depend on the other patch, the one introducing
> Sapphire Rappids to peci/cputemp ?
Yes they are dependent.
Will bundle them together & resend.

~Naresh

>
> Guenter
>
> > ---
> >  drivers/hwmon/peci/dimmtemp.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
> > index ce89da3937a0..ea4ac5a023cf 100644
> > --- a/drivers/hwmon/peci/dimmtemp.c
> > +++ b/drivers/hwmon/peci/dimmtemp.c
> > @@ -30,8 +30,10 @@
> >  #define DIMM_IDX_MAX_ON_ICX  2
> >  #define CHAN_RANK_MAX_ON_ICXD        4
> >  #define DIMM_IDX_MAX_ON_ICXD 2
> > +#define CHAN_RANK_MAX_ON_SPR 128
> > +#define DIMM_IDX_MAX_ON_SPR  2
> >
> > -#define CHAN_RANK_MAX                CHAN_RANK_MAX_ON_HSX
> > +#define CHAN_RANK_MAX                CHAN_RANK_MAX_ON_SPR
> >  #define DIMM_IDX_MAX         DIMM_IDX_MAX_ON_HSX
> >  #define DIMM_NUMS_MAX                (CHAN_RANK_MAX * DIMM_IDX_MAX)
> >
> > @@ -534,6 +536,15 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
> >       return 0;
> >  }
> >
> > +static int
> > +read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u32 *data)
> > +{
> > +     /* Use defaults */
> > +     *data = (95 << 16) | (90 << 8);
> > +
> > +     return 0;
> > +}
> > +
> >  static const struct dimm_info dimm_hsx = {
> >       .chan_rank_max  = CHAN_RANK_MAX_ON_HSX,
> >       .dimm_idx_max   = DIMM_IDX_MAX_ON_HSX,
> > @@ -576,6 +587,13 @@ static const struct dimm_info dimm_icxd = {
> >       .read_thresholds = &read_thresholds_icx,
> >  };
> >
> > +static const struct dimm_info dimm_spr = {
> > +     .chan_rank_max  = CHAN_RANK_MAX_ON_SPR,
> > +     .dimm_idx_max   = DIMM_IDX_MAX_ON_SPR,
> > +     .min_peci_revision = 0x40,
> > +     .read_thresholds = &read_thresholds_spr,
> > +};
> > +
> >  static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
> >       {
> >               .name = "peci_cpu.dimmtemp.hsx",
> > @@ -601,6 +619,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
> >               .name = "peci_cpu.dimmtemp.icxd",
> >               .driver_data = (kernel_ulong_t)&dimm_icxd,
> >       },
> > +     {
> > +             .name = "peci_cpu.dimmtemp.spr",
> > +             .driver_data = (kernel_ulong_t)&dimm_spr,
> > +     },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);
> > --
> > 2.41.0
> >
