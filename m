Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD92C717DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjEaLOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjEaLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:14:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D3D9;
        Wed, 31 May 2023 04:14:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bad1ae90c2eso7405354276.2;
        Wed, 31 May 2023 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685531666; x=1688123666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1j/nCV967fKglGLKqCgHuZux7JfdkGM8J/PSPEDGQY=;
        b=Ol4fqSBgxqm3S3jIgquzVmVHVli0wTWk1uLEkk5VvssClmH9V4s6+U8PToTtAEPMn1
         iYDF53rTMv8A/ggweFBASGmgb/XnjhJYOd8a743HaM++O5svVSehujsubnaDgct+bhTf
         IKNFRTN5lKpnQ+Fa6NUvmakvsMjrJ4ewr5eGAfTf1MDANMDc7+ITWhJeae7YfXlUXFrv
         P7J46FqTxHNJD+e98dVNmh8hCo7GdxumfiRAcw/e1dyq0DJz0LfzpUoxJkzYOTxFQ6yY
         cTWVttAFMWW7Yw/w7Evq90aqKElzJ+ILWCZAtp0r4IR8RIZclT5/5KGBK7uKdCiWocxL
         a13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531666; x=1688123666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1j/nCV967fKglGLKqCgHuZux7JfdkGM8J/PSPEDGQY=;
        b=Vs7CzCHucwQjh9i+F+swfPycqu2ZAeJgNU7Wy74Nubexhx5MIgtm6E+1Dj23kRl3kT
         6VIVxlZ+nJyC4GDq5yFqpFfBmxf7j8RVACCzmZwrNbfJiSL8cmo777d9/2BOZXFY1EXt
         iG4LNbjNZHp5ugi3W+SAZNQaKtwHAmdYvhd29rHlVijTjhVmqmVhi0mzOz72dV/9y9qR
         wLtfaWnkWb3r+csXv3KHoPyOW7OWMICGKL2tr7I3V78CuHiY4Eeum97pPVd+KDsm8Q1e
         Cat4T1suukDmmMYufofhccQSpe9Gde1lCo1y8vJ8Dd4BgTuLgiQ4sqak9T+6+gWoSQS+
         gvEQ==
X-Gm-Message-State: AC+VfDw5u7n2CurS2EloyTwS7kRrAVEWItPPFMl1yQbq47vUA3FQuLSs
        cXfpYMkOfzftrFmIzPj8p3Gf3ghhBF4JjH2Hm9wSt7YzDXs=
X-Google-Smtp-Source: ACHHUZ4+KFHlnxIaMAa4wDxlgQFs80sM3w/LR91q9OPvO7pbGrP/uSMQbhfRjNveQBXZUEJAzIEAOc3U7UeX2ZO/GeQ=
X-Received: by 2002:a81:4e11:0:b0:561:81b:734b with SMTP id
 c17-20020a814e11000000b00561081b734bmr5735866ywb.39.1685531665806; Wed, 31
 May 2023 04:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531095721.392664-1-victorshihgli@gmail.com>
 <20230531095721.392664-4-victorshihgli@gmail.com> <387a2f61-a732-fc6e-d221-97eed4624929@intel.com>
In-Reply-To: <387a2f61-a732-fc6e-d221-97eed4624929@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 31 May 2023 19:14:14 +0800
Message-ID: <CAK00qKCGHbJR3BYjuuZ7Uf9-Ad1M5J7HFXd7+e8w9C=gCLo+Cw@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

On Wed, May 31, 2023 at 6:17=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/05/23 12:57, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Add support SD Express card for GL9767. The workflow of the
> > SD Express card in GL9767 is as below.
> > 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> > 2. If card is inserted, Host send CMD8 to ask the capabilities
> >    of the card.
> > 3. If the card has PCIe capability, then init_sd_express()
> >    will be invoked.
> > 4. If the card has been put in write protect state then the
> >    SD features supported by SD mode but not supported by
> >    PCIe mode, therefore GL9767 switch to SD mode.
> > 5. If the card has not been put in write protect state then
> >    GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
> >    handover control to NVMe driver.
> > 6. If card is removed, GL9767 will return to SD mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 113 +++++++++++++++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 392a106cea18..bd5185476d0f 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -164,6 +164,10 @@
> >  #define PCIE_GLI_9767_CFG            0x8A0
> >  #define   PCIE_GLI_9767_CFG_LOW_PWR_OFF        BIT(12)
> >
> > +#define PCIE_GLI_9767_COMBO_MUX_CTL                  0x8C8
> > +#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN           BIT(6)
> > +#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN    BIT(10)
> > +
> >  #define PCIE_GLI_9767_PWR_MACRO_CTL                                  0=
x8D0
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                     =
 GENMASK(3, 0)
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE          =
 GENMASK(15, 12)
> > @@ -181,6 +185,9 @@
> >  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF            BIT(21)
> >  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN     BIT(30)
> >
> > +#define PCIE_GLI_9767_SDHC_CAP                       0x91C
> > +#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT   BIT(5)
> > +
> >  #define PCIE_GLI_9767_SD_PLL_CTL                     0x938
> >  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV            GENMASK(9, 0)
> >  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV            GENMASK(15, 12)
> > @@ -191,6 +198,23 @@
> >  #define PCIE_GLI_9767_SD_PLL_CTL2            0x93C
> >  #define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM         GENMASK(31, 16)
> >
> > +#define PCIE_GLI_9767_SD_EXPRESS_CTL                 0x940
> > +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE                BIT(0)
> > +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE         BIT(1)
> > +
> > +#define PCIE_GLI_9767_SD_DATA_MULTI_CTL                              0=
x944
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME      GENMASK=
(23, 16)
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE       =
 0x64
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2                     0=
x950
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE      =
 BIT(0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2                   =
       0x954
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_ST=
ATUS_EN          BIT(0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                   =
       0x958
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SI=
GNAL_EN          BIT(0)
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -935,6 +959,93 @@ static void sdhci_gl9767_reset(struct sdhci_host *=
host, u8 mask)
> >       gli_set_9767(host);
> >  }
> >
> > +static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev;
> > +     u32 value;
> > +     int i;
> > +
> > +     pdev =3D slot->chip->pdev;
> > +
> > +     if (mmc->ops->get_ro(mmc)) {
> > +             mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_=
EXP_1_2V);
> > +             return 0;
> > +     }
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value);
> > +     value &=3D ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767_C=
OMBO_MUX_CTL_WAIT_PERST_EN);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &val=
ue);
> > +     value &=3D ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
> > +     value |=3D FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_=
TIME,
> > +                         PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TI=
ME_VALUE);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, val=
ue);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_R=
EG2, &value);
> > +     value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE=
;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_=
REG2, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_E=
N_REG2, &value);
> > +     value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPL=
ETE_STATUS_EN;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_=
EN_REG2, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_E=
N_REG2, &value);
> > +     value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPL=
ETE_SIGNAL_EN;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_=
EN_REG2, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > +     value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > +
> > +     value =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +     value &=3D ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> > +     sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> > +
> > +     value =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
> > +     value |=3D ((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);
>
> Sorry I didn't notice this before but these VDD2 bits should be
> defined:
>
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f4f2085c274c..f219bdea8f28 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -99,6 +99,13 @@
>  #define  SDHCI_POWER_180       0x0A
>  #define  SDHCI_POWER_300       0x0C
>  #define  SDHCI_POWER_330       0x0E
> +/*
> + * VDD2 - UHS2 or PCIe/NVMe
> + * VDD2 power on/off and voltage select
> + */
> +#define  SDHCI_VDD2_POWER_ON   0x10
> +#define  SDHCI_VDD2_POWER_120  0x80
> +#define  SDHCI_VDD2_POWER_180  0xA0
>
>  #define SDHCI_BLOCK_GAP_CONTROL        0x2A
>
>
>

I will update it in patch v4.

> > +     sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value)=
;
> > +     value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value)=
;
> > +
> > +     for (i =3D 0; i < 2; i++) {
> > +             msleep(10);
> > +             pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_=
STATUS_REG2, &value);
> > +             if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI=
_COMPLETE) {
> > +                     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL=
_ERR_INT_STATUS_REG2,
> > +                                            value);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
> > +     if (value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) {
> > +             pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL,=
 &value);
> > +             value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
> > +             pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL=
, value);
> > +     } else {
> > +             mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_=
EXP_1_2V);
> > +
> > +             value =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
> > +             value &=3D ~((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);
>
> See above
>

I will update it in patch v4.

> > +             sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> > +
> > +             value =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +             value |=3D (SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> > +             sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> > +     }
> > +
> > +     gl9767_vhs_read(pdev);
> > +
> > +     return 0;
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >       struct sdhci_host *host =3D slot->host;
> > @@ -967,6 +1078,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_=
slot *slot)
> >       gl9767_hw_setting(slot);
> >       gli_pcie_enable_msi(slot);
> >       slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> > +     host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> > +     host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
> >       sdhci_enable_v4_mode(host);
> >
> >       return 0;
>

Thanks, Victor Shih
