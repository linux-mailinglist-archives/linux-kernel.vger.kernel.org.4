Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08178737FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjFUKcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjFUKbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:31:35 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62F199C;
        Wed, 21 Jun 2023 03:30:40 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4716e4adb14so1434894e0c.0;
        Wed, 21 Jun 2023 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343439; x=1689935439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4cUoiAm+jTPFw4TxaxpbXGv/0CufqGzi+w6zA8/fHE=;
        b=KfHe4WH8KQcP61hXbRfQU+3INjpMti8j6XLF2C5KCtOQ6+fUThc8/INJvAk8k1/Awx
         ZAw073x2h1tM9z4rUv5pfS94sM+vkN7sCyMSlEwxWK4b1dkqRHUrq31JabrjRsNXDOBN
         SO+2+d45pxHnb9N2k67P7bDKcggvq8fOLC7CEP/4U9SDd0CoyAZcXc9EOd8x4ZGprJqL
         JPjNc/N8Z8FACaxGc3GO+FV5EEVsHMTTG6BxO/EobaYfR1ho6AjbRlCQ/c/mvcluhXDB
         5uu6BYO7NbZv6ffMyLkDig651F5Tg1a+uN6QYpqYGYjEA9gV1/LEys/ULQYTOvFnm5fr
         Dq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343439; x=1689935439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4cUoiAm+jTPFw4TxaxpbXGv/0CufqGzi+w6zA8/fHE=;
        b=BbR8Qz2TOQbvoCyiBKOVtfdAl6Ns+mrla4e8tFcX5LzNSZ1hy9KDqXjr7IOHicc2Vp
         8jxGyidXKOzrInYz/eIoY9UdKjskCxX3GIt4G4awF2BKBUqx7xkKcZDymzYuz4m0rSyA
         uGxcgZg5RcNRThRQ+eb7epQgotkb3rg44OjyT+WK3asbyj8Ydi0fS3KUFLOpT44O81+k
         h6RpjpqTheTv0gqEEJ31UmuFni3gv5nqNTt8HGxXMR7ixywpUQwyOP8g8zpsKv2XWftj
         klIb4NxaSn9TNxNkljTxeCmkoM1xCepEs/0rdMQSqbW91it1M9nV6xsrbZF7Nsog/BC4
         OAPQ==
X-Gm-Message-State: AC+VfDwt9AZUMJuwU50JddBdgATCgZg0lo6KTbX4VvZ4tPvcBIwqyhKO
        z2AcOzeYIWna2JSpXmNlpwXcDKj6yJlAeznBGp3tO0FTS+w=
X-Google-Smtp-Source: ACHHUZ4+BUJcEKcPsQITwwo823XT9hqHD/vlGc2YXCkDrd3oPKoi9//dx06CLstbQlnhJz+gR0TpGAVZpGxt/724JW8=
X-Received: by 2002:a67:ce8a:0:b0:440:c339:9694 with SMTP id
 c10-20020a67ce8a000000b00440c3399694mr3083136vse.27.1687343439017; Wed, 21
 Jun 2023 03:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-24-victor.shih@genesyslogic.com.tw> <699030ea-b1bd-d85a-28bd-1d6735e65df8@intel.com>
In-Reply-To: <699030ea-b1bd-d85a-28bd-1d6735e65df8@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:30:26 +0800
Message-ID: <CAK00qKDwjUfSXbK=W82iecbvBEBHRSX8HvrnXJEDRRW77677cA@mail.gmail.com>
Subject: Re: [PATCH V7 23/23] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
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
> > Changes are:
> > * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
> > * Enable the internal clock when do reset on UHS-II mode.
> > * Increase timeout value before detecting UHS-II interface.
> > * Add vendor settings fro UHS-II mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/Kconfig         |   1 +
> >  drivers/mmc/host/sdhci-pci-gli.c | 276 ++++++++++++++++++++++++++++++-
> >  2 files changed, 276 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 06ab111eba3b..b89804d2da16 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -111,6 +111,7 @@ config MMC_SDHCI_PCI
> >       tristate "SDHCI support on PCI bus"
> >       depends on MMC_SDHCI && PCI
> >       select MMC_CQHCI
> > +     select MMC_SDHCI_UHS2
> >       select IOSF_MBI if X86
> >       select MMC_SDHCI_IO_ACCESSORS
> >       help
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 633a8ee8f8c5..eedf6cd5c94a 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -18,6 +18,7 @@
> >  #include "sdhci-cqhci.h"
> >  #include "sdhci-pci.h"
> >  #include "cqhci.h"
> > +#include "sdhci-uhs2.h"
> >
> >  /*  Genesys Logic extra registers */
> >  #define SDHCI_GLI_9750_WT         0x800
> > @@ -139,9 +140,36 @@
> >
> >  #define PCI_GLI_9755_PLLSSC        0x68
> >  #define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
> > +#define   PCI_GLI_9755_PLLSSC_RTL             BIT(24)
> > +#define   GLI_9755_PLLSSC_RTL_VALUE           0x1
> > +#define   PCI_GLI_9755_PLLSSC_TRANS_PASS      BIT(27)
> > +#define   GLI_9755_PLLSSC_TRANS_PASS_VALUE    0x1
> > +#define   PCI_GLI_9755_PLLSSC_RECV            GENMASK(29, 28)
> > +#define   GLI_9755_PLLSSC_RECV_VALUE          0x3
> > +#define   PCI_GLI_9755_PLLSSC_TRAN            GENMASK(31, 30)
> > +#define   GLI_9755_PLLSSC_TRAN_VALUE          0x3
> > +
> > +#define PCI_GLI_9755_UHS2_PLL            0x6C
> > +#define   PCI_GLI_9755_UHS2_PLL_SSC        GENMASK(9, 8)
> > +#define   GLI_9755_UHS2_PLL_SSC_VALUE      0x0
> > +#define   PCI_GLI_9755_UHS2_PLL_DELAY      BIT(18)
> > +#define   GLI_9755_UHS2_PLL_DELAY_VALUE    0x1
> > +#define   PCI_GLI_9755_UHS2_PLL_PDRST      BIT(27)
> > +#define   GLI_9755_UHS2_PLL_PDRST_VALUE    0x1
> >
> >  #define PCI_GLI_9755_SerDes  0x70
> > +#define   PCI_GLI_9755_UHS2_SERDES_INTR       GENMASK(2, 0)
> > +#define   GLI_9755_UHS2_SERDES_INTR_VALUE     0x3
> > +#define   PCI_GLI_9755_UHS2_SERDES_ZC1        BIT(3)
> > +#define   GLI_9755_UHS2_SERDES_ZC1_VALUE      0x0
> > +#define   PCI_GLI_9755_UHS2_SERDES_ZC2        GENMASK(7, 4)
> > +#define   GLI_9755_UHS2_SERDES_ZC2_DEFAULT    0xB
> > +#define   GLI_9755_UHS2_SERDES_ZC2_SANDISK    0x0
> >  #define PCI_GLI_9755_SCP_DIS   BIT(19)
> > +#define   PCI_GLI_9755_UHS2_SERDES_TRAN       GENMASK(27, 24)
> > +#define   GLI_9755_UHS2_SERDES_TRAN_VALUE     0xC
> > +#define   PCI_GLI_9755_UHS2_SERDES_RECV       GENMASK(31, 28)
> > +#define   GLI_9755_UHS2_SERDES_RECV_VALUE     0xF
> >
> >  #define PCI_GLI_9755_MISC        0x78
> >  #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
> > @@ -693,6 +721,244 @@ static void gl9755_hw_setting(struct sdhci_pci_sl=
ot *slot)
> >       gl9755_wt_off(pdev);
> >  }
> >
> > +static void gl9755_vendor_init(struct sdhci_host *host)
> > +{
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 serdes;
> > +     u32 pllssc;
> > +     u32 uhs2_pll;
> > +
> > +     gl9755_wt_on(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &serdes);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_TRAN;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_TRAN,
> > +                          GLI_9755_UHS2_SERDES_TRAN_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_RECV;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_RECV,
> > +                          GLI_9755_UHS2_SERDES_RECV_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_INTR;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_INTR,
> > +                          GLI_9755_UHS2_SERDES_INTR_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_ZC1;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
> > +                          GLI_9755_UHS2_SERDES_ZC1_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_ZC2;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
> > +                          GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, serdes);
> > +
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, &uhs2_pll);
> > +     uhs2_pll &=3D ~PCI_GLI_9755_UHS2_PLL_SSC;
> > +     uhs2_pll |=3D FIELD_PREP(PCI_GLI_9755_UHS2_PLL_SSC,
> > +                       GLI_9755_UHS2_PLL_SSC_VALUE);
> > +     uhs2_pll &=3D ~PCI_GLI_9755_UHS2_PLL_DELAY;
> > +     uhs2_pll |=3D FIELD_PREP(PCI_GLI_9755_UHS2_PLL_DELAY,
> > +                       GLI_9755_UHS2_PLL_DELAY_VALUE);
> > +     uhs2_pll &=3D ~PCI_GLI_9755_UHS2_PLL_PDRST;
> > +     uhs2_pll |=3D FIELD_PREP(PCI_GLI_9755_UHS2_PLL_PDRST,
> > +                       GLI_9755_UHS2_PLL_PDRST_VALUE);
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, uhs2_pll);
> > +
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_PLLSSC, &pllssc);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_RTL;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_RTL,
> > +                       GLI_9755_PLLSSC_RTL_VALUE);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_TRANS_PASS;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_TRANS_PASS,
> > +                       GLI_9755_PLLSSC_TRANS_PASS_VALUE);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_RECV;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_RECV,
> > +                       GLI_9755_PLLSSC_RECV_VALUE);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_TRAN;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_TRAN,
> > +                       GLI_9755_PLLSSC_TRAN_VALUE);
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_PLLSSC, pllssc);
> > +
> > +     gl9755_wt_off(pdev);
> > +}
> > +
> > +static void gl9755_pre_detect_init(struct sdhci_host *host)
> > +{
> > +     /* GL9755 need more time on UHS2 detect flow */
> > +     sdhci_writeb(host, 0xA7, SDHCI_UHS2_TIMER_CTRL);
> > +}
> > +
> > +static void gl9755_overcurrent_event_enable(struct sdhci_host *host,
> > +                                         bool enable)
> > +{
> > +     u32 mask;
> > +
> > +     mask =3D sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
> > +     if (enable)
> > +             mask |=3D SDHCI_INT_BUS_POWER;
> > +     else
> > +             mask &=3D ~SDHCI_INT_BUS_POWER;
> > +
> > +     sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
> > +
> > +     mask =3D sdhci_readl(host, SDHCI_INT_ENABLE);
> > +     if (enable)
> > +             mask |=3D SDHCI_INT_BUS_POWER;
> > +     else
> > +             mask &=3D ~SDHCI_INT_BUS_POWER;
> > +
> > +     sdhci_writel(host, mask, SDHCI_INT_ENABLE);
> > +}
> > +
> > +static void gl9755_set_power(struct sdhci_host *host, unsigned char mo=
de,
> > +                          unsigned short vdd)
> > +{
> > +     u8 pwr =3D 0;
> > +
> > +     if (mode !=3D MMC_POWER_OFF) {
> > +             switch (1 << vdd) {
> > +             case MMC_VDD_165_195:
> > +             /*
> > +              * Without a regulator, SDHCI does not support 2.0v
> > +              * so we only get here if the driver deliberately
> > +              * added the 2.0v range to ocr_avail. Map it to 1.8v
> > +              * for the purpose of turning on the power.
> > +              */
> > +             case MMC_VDD_20_21:
> > +                     pwr =3D SDHCI_POWER_180;
> > +                     break;
> > +             case MMC_VDD_29_30:
> > +             case MMC_VDD_30_31:
> > +                     pwr =3D SDHCI_POWER_300;
> > +                     break;
> > +             case MMC_VDD_32_33:
> > +             case MMC_VDD_33_34:
> > +                     pwr =3D SDHCI_POWER_330;
> > +                     break;
> > +             default:
> > +                     WARN(1, "%s: Invalid vdd %#x\n",
> > +                          mmc_hostname(host->mmc), vdd);
> > +                     break;
> > +             }
>
> Should be able to use sdhci_get_vdd_value() here
>

I will update it to the V8 version.

> > +
> > +             pwr |=3D SDHCI_VDD2_POWER_180;
> > +     }
> > +
> > +     if (host->pwr =3D=3D pwr)
> > +             return;
> > +
> > +     host->pwr =3D pwr;
> > +
> > +     if (pwr =3D=3D 0) {
> > +             gl9755_overcurrent_event_enable(host, false);
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +     } else {
> > +             gl9755_overcurrent_event_enable(host, false);
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             pwr |=3D (SDHCI_POWER_ON | SDHCI_VDD2_POWER_ON);
> > +
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             /* wait stable */
> > +             mdelay(5);
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             /* wait stable */
> > +             mdelay(5);
> > +             gl9755_overcurrent_event_enable(host, true);
> > +     }
> > +}
> > +
> > +static bool sdhci_wait_clock_stable(struct sdhci_host *host)
> > +{
> > +     u16 clk =3D 0;
> > +     ktime_t timeout;
> > +
> > +     /* Wait max 20 ms */
> > +     timeout =3D ktime_add_ms(ktime_get(), 20);
> > +     while (1) {
> > +             bool timedout =3D ktime_after(ktime_get(), timeout);
> > +
> > +             clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +             if (clk & SDHCI_CLOCK_INT_STABLE)
> > +                     break;
> > +             if (timedout) {
> > +                     pr_err("%s: Internal clock never stabilised.\n",
> > +                            mmc_hostname(host->mmc));
> > +                     sdhci_dumpregs(host);
> > +                     return false;
> > +             }
> > +             udelay(10);
> > +     }
>
> This could be:
>
>         if (read_poll_timeout_atomic(sdhci_readw, clk, (clk & SDHCI_CLOCK=
_INT_STABLE),
>                                      10, 20000, false, host, SDHCI_CLOCK_=
CONTROL)) {
>                 pr_err("%s: Internal clock never stabilised.\n",
>                        mmc_hostname(host->mmc));
>                 sdhci_dumpregs(host);
>                 return false;
>         }
>
>

I will update it to the V8 version.

> > +     return true;
> > +}
> > +
> > +static void gl9755_uhs2_reset_sd_tran(struct sdhci_host *host)
> > +{
> > +     /* do this on UHS2 mode */
> > +     if (host->mmc->flags & MMC_UHS2_SD_TRAN) {
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +             sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +             sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +             sdhci_uhs2_clear_set_irqs(host,
> > +                                       SDHCI_INT_ALL_MASK,
> > +                                       SDHCI_UHS2_INT_ERROR_MASK);
> > +     }
> > +}
> > +
> > +static void sdhci_gl9755_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +     ktime_t timeout;
> > +     u16 ctrl2;
> > +     u16 clk_ctrl;
> > +
> > +     /* need internal clock */
> > +     if (mask & SDHCI_RESET_ALL) {
> > +             ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +             clk_ctrl =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +             if ((ctrl2 & SDHCI_CTRL_V4_MODE) &&
> > +                 (ctrl2 & SDHCI_CTRL_UHS2_ENABLE)) {
> > +                     sdhci_writew(host,
> > +                                  SDHCI_CLOCK_INT_EN,
> > +                                  SDHCI_CLOCK_CONTROL);
> > +             } else {
> > +                     sdhci_writew(host,
> > +                                  SDHCI_CLOCK_INT_EN,
> > +                                  SDHCI_CLOCK_CONTROL);
> > +                     sdhci_wait_clock_stable(host);
> > +                     sdhci_writew(host,
> > +                                  SDHCI_CTRL_V4_MODE,
> > +                                  SDHCI_HOST_CONTROL2);
> > +             }
> > +     }
> > +
> > +     sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> > +
> > +     /* reset sd-tran on UHS2 mode if need to reset cmd/data */
> > +     if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
> > +             gl9755_uhs2_reset_sd_tran(host);
> > +
> > +     if (mask & SDHCI_RESET_ALL)
> > +             host->clock =3D 0;
> > +
> > +     /* Wait max 100 ms */
> > +     timeout =3D ktime_add_ms(ktime_get(), 100);
> > +
> > +     /* hw clears the bit when it's done */
> > +     while (1) {
> > +             bool timedout =3D ktime_after(ktime_get(), timeout);
> > +
> > +             if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> > +                     break;
> > +             if (timedout) {
> > +                     pr_err("%s: Reset 0x%x never completed.\n",
> > +                            mmc_hostname(host->mmc), (int)mask);
> > +                     sdhci_dumpregs(host);
> > +                     /* manual clear */
> > +                     sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
> > +                     return;
> > +             }
> > +             udelay(10);
> > +     }
>
> This could be:
>
>         u8 rst;
>
>         if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask),
>                                      10, 100000, false, host, SDHCI_SOFTW=
ARE_RESET)) {
>                 pr_err("%s: Reset 0x%x never completed.\n",
>                        mmc_hostname(host->mmc), (int)mask);
>                 sdhci_dumpregs(host);
>                 /* manual clear */
>                 sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
>                 return;
>         }
>
>

I will update it to the V8 version.

> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >       struct sdhci_host *host =3D slot->host;
> > @@ -713,6 +979,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_s=
lot *slot)
> >       gli_pcie_enable_msi(slot);
> >       slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> >       sdhci_enable_v4_mode(host);
> > +     gl9755_vendor_init(host);
> >
> >       return 0;
> >  }
> > @@ -1085,17 +1352,24 @@ static const struct sdhci_ops sdhci_gl9755_ops =
=3D {
> >       .read_w                 =3D sdhci_gli_readw,
> >       .read_b                 =3D sdhci_gli_readb,
> >       .set_clock              =3D sdhci_gl9755_set_clock,
> > +     .set_power              =3D gl9755_set_power,
> >       .enable_dma             =3D sdhci_pci_enable_dma,
> >       .set_bus_width          =3D sdhci_set_bus_width,
> > -     .reset                  =3D sdhci_reset,
> > +     .reset                  =3D sdhci_gl9755_reset,
> >       .set_uhs_signaling      =3D sdhci_set_uhs_signaling,
> >       .voltage_switch         =3D sdhci_gli_voltage_switch,
> > +     .dump_uhs2_regs         =3D sdhci_uhs2_dump_regs,
> > +     .set_timeout            =3D sdhci_uhs2_set_timeout,
> > +     .irq                    =3D sdhci_uhs2_irq,
> > +     .uhs2_pre_detect_init   =3D gl9755_pre_detect_init,
> >  };
> >
> >  const struct sdhci_pci_fixes sdhci_gl9755 =3D {
> >       .quirks         =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> >       .quirks2        =3D SDHCI_QUIRK2_BROKEN_DDR50,
> >       .probe_slot     =3D gli_probe_slot_gl9755,
> > +     .add_host       =3D sdhci_pci_uhs2_add_host,
> > +     .remove_host    =3D sdhci_pci_uhs2_remove_host,
> >       .ops            =3D &sdhci_gl9755_ops,
> >  #ifdef CONFIG_PM_SLEEP
> >       .resume         =3D sdhci_pci_gli_resume,
>

Thanks, Victor Shih
