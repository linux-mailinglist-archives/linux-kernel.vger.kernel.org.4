Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD67381B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjFUKai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjFUK3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:29:55 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7F1BFA;
        Wed, 21 Jun 2023 03:29:42 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-471b34d1bb8so1265289e0c.3;
        Wed, 21 Jun 2023 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343381; x=1689935381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1Y57Vv6eimsMZdLgbIJlsRsErhOmXSPNzAt+5k4Q+w=;
        b=At4jnzWz0IpMFsBCluYeGeyAYD8kuXaEgveXP4HWtysmNTK68tZTcpgIEEYcu6z2Wv
         XX2ph9msNxjp8H5p5/TZhU6ZqCj6xyaEAxwIvrApC1fMLOUWX+xNhgLcbTfPypMDFLyW
         fx0z2I6vt+g2nEUnxgvU4hpUw2zZkyPHipUdWZO6foX186MYuZ1tpUsPbcUmWWgusqpX
         VgFlWJVMqrMVxXk+gWS1hrt6bW1VDarOoReso+755FInc+ZM9wWPaHzOcUD3CF0QcgRq
         IBYZFcunGNT6Sg/7b1usOUoHVuZ3leNuHx0vJbQgWNSbDYRQwSQXSP8Hj1+bN2sljHof
         92yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343381; x=1689935381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1Y57Vv6eimsMZdLgbIJlsRsErhOmXSPNzAt+5k4Q+w=;
        b=KhXb+1Ydz8ESAQkl2Y1HPBqwmk/5uG85gxyp28bcAy5Rd8Qo44PFWlr4cap9W++VY4
         DmiBzn1hphUREqtrRzS95NrcJ28SNJRk91hwP+HEsuYd72CXfZDfpRdcW+h3++la5d1J
         sLwzXVP+udUqKmnBUbx+4ffDfMwtmqQO58XV/cPYLrPh4jFXZPbxn3Fh6G35zq/E2iI7
         tE4RCbyfbUYa75LWB/RzlinflpfpfmVH1LV9SMtNdxbsvcDckDvP6+dsEy6/Zr+xfWqF
         cOuQxenkv0AmuBqs9G1vqN6YE95LLIbQQf0+OHBC5Ffq/Ak3vY7BSOqeJrG/5Ntx5ONA
         To5Q==
X-Gm-Message-State: AC+VfDzVYuu5SFyJz70EhVY2k3iEdafL9m2hEIS4hUSFCAWpOKFsbAKR
        2O5l91fc17SZLmudcXCXNNGRAwMR7LdRqNgx0GM=
X-Google-Smtp-Source: ACHHUZ43AQqBluDf7pF0KF62rNWhRF17DNuxqgCm+kMNMx2ys4M9oIsDKR6eP/mRh9/9btmgaopTnSkJOmPRuNpqYMo=
X-Received: by 2002:a67:f514:0:b0:440:9cda:df51 with SMTP id
 u20-20020a67f514000000b004409cdadf51mr6729628vsn.28.1687343381430; Wed, 21
 Jun 2023 03:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-15-victor.shih@genesyslogic.com.tw> <39300bfa-746a-7d81-fc7c-36c9be7e7aa2@intel.com>
In-Reply-To: <39300bfa-746a-7d81-fc7c-36c9be7e7aa2@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:29:29 +0800
Message-ID: <CAK00qKDqQSYkKdM8LVhH0KWmPccv+8iLkRjiUYj3DP+zo0FoXA@mail.gmail.com>
Subject: Re: [PATCH V7 14/23] mmc: sdhci-uhs2: add set_ios()
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
> > This is a sdhci version of mmc's set_ios operation.
> > It covers both UHS-I and UHS-II.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 91 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  drivers/mmc/host/sdhci.c      | 53 ++++++++++++--------
> >  drivers/mmc/host/sdhci.h      |  2 +
> >  4 files changed, 126 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index e2e9ce51b768..9b519bd6d76e 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -216,6 +216,67 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *hos=
t, struct mmc_command *cmd)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> >
> > +/**
> > + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable regis=
ter
> > + * @host:    SDHCI host
> > + * @clear:   bit-wise clear mask
> > + * @set:     bit-wise set mask
> > + *
> > + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> > + */
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set)
> > +{
> > +     u32 ier;
> > +
> > +     ier =3D sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
> > +     ier &=3D ~clear;
> > +     ier |=3D set;
> > +     sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
> > +     sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> > +
> > +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios =
*ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     u8 cmd_res, dead_lock;
> > +     u16 ctrl_2;
> > +
> > +     /* UHS2 Timeout Control */
> > +     sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +
> > +     /* change to use calculate value */
> > +     cmd_res |=3D FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead=
_lock);
> > +
> > +     sdhci_uhs2_clear_set_irqs(host,
> > +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
> > +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
> > +                               0);
> > +     sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +     sdhci_uhs2_clear_set_irqs(host, 0,
> > +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
> > +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
> > +
> > +     /* UHS2 timing. Note, UHS2 timing is disabled when powering off *=
/
> > +     ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +     if (ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A)
>
> What about MMC_TIMING_UHS2_SPEED_A_HD, MMC_TIMING_UHS2_SPEED_B and
> MMC_TIMING_UHS2_SPEED_B_HD
>

I will update it to the V8 version.

> > +             ctrl_2 |=3D SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
> > +     else
> > +             ctrl_2 &=3D ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
> > +     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +     host->timing =3D ios->timing;
> > +
> > +     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> > +             sdhci_enable_preset_value(host, true);
> > +
> > +     if (host->ops->set_power)
> > +             host->ops->set_power(host, ios->power_mode, ios->vdd);
> > +     else
> > +             sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> > +
> > +     sdhci_set_clock(host, host->clock);
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * MMC callbacks                                                      =
       *
> > @@ -237,6 +298,36 @@ static int sdhci_uhs2_start_signal_voltage_switch(=
struct mmc_host *mmc,
> >       return sdhci_start_signal_voltage_switch(mmc, ios);
> >  }
> >
> > +static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *io=
s)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +
> > +     pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> > +              mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd=
, ios->timing);
> > +
> > +     if (!sdhci_uhs2_mode(host)) {
> > +             sdhci_set_ios(mmc, ios);
> > +             return 0;
> > +     }
> > +
> > +     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > +             return 0;
> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (ios->power_mode =3D=3D MMC_POWER_OFF) {
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
>
> Above 2 should probably be: mmc_opt_regulator_set_ocr()
>

I will update it to the V8 version.

> > +             }
> > +             return -1;
> > +     }
> > +
> > +     sdhci_set_ios_common(mmc, ios);
> > +
> > +     __sdhci_uhs2_set_ios(mmc, ios);
> > +
> > +     return 0;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index fc03a178b676..33e03b1b2b80 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -181,5 +181,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index a68a2dce0efe..90d990a84d4f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -47,8 +47,6 @@
> >  static unsigned int debug_quirks =3D 0;
> >  static unsigned int debug_quirks2;
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool en=
able);
> > -
> >  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_com=
mand *cmd);
> >
> >  void sdhci_dumpregs(struct sdhci_host *host)
> > @@ -1877,6 +1875,9 @@ static u16 sdhci_get_preset_value(struct sdhci_ho=
st *host)
> >       case MMC_TIMING_MMC_HS400:
> >               preset =3D sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
> >               break;
> > +     case MMC_TIMING_UHS2_SPEED_A:
>
> What about:
>
>         case MMC_TIMING_UHS2_SPEED_A_HD:
>         case MMC_TIMING_UHS2_SPEED_B:
>         case MMC_TIMING_UHS2_SPEED_B_HD:
>
>

I will update it to the V8 version.

> > +             preset =3D sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> > +             break;
> >       default:
> >               pr_warn("%s: Invalid UHS-I mode selected\n",
> >                       mmc_hostname(host->mmc));
> > @@ -2323,24 +2324,9 @@ static bool sdhci_presetable_values_change(struc=
t sdhci_host *host, struct mmc_i
> >              (sdhci_preset_needed(host, ios->timing) || host->drv_type =
!=3D ios->drv_type);
> >  }
> >
> > -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >       struct sdhci_host *host =3D mmc_priv(mmc);
> > -     bool reinit_uhs =3D host->reinit_uhs;
> > -     bool turning_on_clk =3D false;
> > -     u8 ctrl;
> > -
> > -     host->reinit_uhs =3D false;
> > -
> > -     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > -             return;
> > -
> > -     if (host->flags & SDHCI_DEVICE_DEAD) {
> > -             if (!IS_ERR(mmc->supply.vmmc) &&
> > -                 ios->power_mode =3D=3D MMC_POWER_OFF)
> > -                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > -             return;
> > -     }
> >
> >       /*
> >        * Reset the chip on each power off.
> > @@ -2357,8 +2343,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct m=
mc_ios *ios)
> >               sdhci_enable_preset_value(host, false);
> >
> >       if (!ios->clock || ios->clock !=3D host->clock) {
> > -             turning_on_clk =3D ios->clock && !host->clock;
> > -
> >               host->ops->set_clock(host, ios->clock);
> >               host->clock =3D ios->clock;
> >
> > @@ -2374,12 +2358,38 @@ void sdhci_set_ios(struct mmc_host *mmc, struct=
 mmc_ios *ios)
> >                       mmc->max_busy_timeout /=3D host->timeout_clk;
> >               }
> >       }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> > +
> > +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     bool reinit_uhs =3D host->reinit_uhs;
> > +     bool turning_on_clk =3D false;
> > +     u8 ctrl;
> > +
> > +     host->reinit_uhs =3D false;
> > +
> > +     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > +             return;
> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (!IS_ERR(mmc->supply.vmmc) &&
> > +                 ios->power_mode =3D=3D MMC_POWER_OFF)
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             return;
> > +     }
> > +
>
> This is needed here, not later:
>
>         if (!ios->clock || ios->clock !=3D host->clock)
>                 turning_on_clk =3D ios->clock && !host->clock;
>

I will update it to the V8 version.

> > +     sdhci_set_ios_common(mmc, ios);
> >
> >       if (host->ops->set_power)
> >               host->ops->set_power(host, ios->power_mode, ios->vdd);
> >       else
> >               sdhci_set_power(host, ios->power_mode, ios->vdd);
> >
> > +     if (!ios->clock || ios->clock !=3D host->clock)
> > +             turning_on_clk =3D ios->clock && !host->clock;
> > +
>
> This chunk needs to be moved earlier, as above.
>

I will update it to the V8 version.

> >       if (host->ops->platform_send_init_74_clocks)
> >               host->ops->platform_send_init_74_clocks(host, ios->power_=
mode);
> >
> > @@ -2957,7 +2967,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u3=
2 opcode)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool en=
able)
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> >  {
> >       /* Host Controller v3.00 defines preset value registers */
> >       if (host->version < SDHCI_SPEC_300)
> > @@ -2985,6 +2995,7 @@ static void sdhci_enable_preset_value(struct sdhc=
i_host *host, bool enable)
> >               host->preset_enabled =3D enable;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
> >
> >  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *m=
rq,
> >                               int err)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 02ea4a00ad63..17d467172fe4 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -848,6 +848,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, i=
nt width);
> >  void sdhci_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)=
;
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
> >  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
>

Thanks, Victor Shih
