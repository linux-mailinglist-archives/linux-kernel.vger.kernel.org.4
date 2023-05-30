Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25812715AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjE3JwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjE3JwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:52:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99469CD;
        Tue, 30 May 2023 02:51:42 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-565bd368e19so48152887b3.1;
        Tue, 30 May 2023 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685440301; x=1688032301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41tqy/SDEH+34/j/qpigsAL57D7O1jwtcIJzZN3pxeA=;
        b=SFONW2lE8/J6UwsbJxFWnR2EJIZmZWtvUEhVjQUQc0QmmXm8rHxYxl47kB/x2qYWIu
         pstQvVcpkBbHy7zTp6FWkstUTHBOeqH/a/Y8KlOphOzFPZZmwR9TOmTe7qzSLoaiJYF+
         2MNdq/F3HDhe9yRUktg+sTDFVOFnPXATr+OruGkU2BlR37iSXVgtFBRj5P/SNb6anlNn
         Fvk7AIL0VyCtOrgMhltiIlaAlSvIhZRbkyAIGp4NOLWjCJuKTWQNmdvi4UQGmtp1Bx7u
         xpiNTnEQZLJ6W71Hdq7gH7zUZoYlCsRgDtAU8EoJTIX1Xb5ubRG1QJIyyd71xzZsvV2O
         9NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440301; x=1688032301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41tqy/SDEH+34/j/qpigsAL57D7O1jwtcIJzZN3pxeA=;
        b=kH9tfYz71lRobx/Rw/4KiP1Itaq4Nm+00XsUZEyjLsqjkAxslg6bpjuhlCAAuNFWWd
         M1KBRgG9wb4leKsI+aGr7Vy8/2mA4j6/BAk2gmcSoHv6tmEf1hyLG7/IaND1CbUDYXoY
         o4BAtpQk+BL8TA+Dj05UC1H1Nzn0uAOwzmpDmwd1X/BdMSdI6fTQ7d/5Evyv5w4i7kaY
         SFx4SVZlxnVvSNfUUndSR8aJO+p4Zuh+sqMdqVurftecOT6uWcT26ByHrUDSKUSS3TdY
         SnIfOPcuNVjuIhzYaUvytDOmDV8kSxs373cXxn8WDqFV2pdDk4e8ZeprAX73h2eCwH/O
         U6bQ==
X-Gm-Message-State: AC+VfDw5O7NJ+U0zdduH6p7+KmCMLtUY2DGAdyFqxFrMib+5PaH3tzzK
        8Qiowluc/MMHoBxufNdKUWCxnECKuXKBympzzQE=
X-Google-Smtp-Source: ACHHUZ5zhvseaEHr+0JNu6Oqqt8fu4KLX2qMGMHRskwuZ6wUugbfbm1oljlgD8do7wzXsEH9k2XhXF2eqDpRz9J65TA=
X-Received: by 2002:a81:a043:0:b0:568:ada0:f9ea with SMTP id
 x64-20020a81a043000000b00568ada0f9eamr1479774ywg.49.1685440301513; Tue, 30
 May 2023 02:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
 <20230512104559.11218-4-victor.shih@genesyslogic.com.tw> <CACT4zj8EXyizQLnb837pzg8kEURWrO4BkVeRmtDUmTo6yh9E+g@mail.gmail.com>
In-Reply-To: <CACT4zj8EXyizQLnb837pzg8kEURWrO4BkVeRmtDUmTo6yh9E+g@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 30 May 2023 17:51:30 +0800
Message-ID: <CAK00qKBR+7_snFFavZhz6AF9nEfEaO2yZa8+y1tuUda5wRY9Zg@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
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

Hi, Ben

On Mon, May 15, 2023 at 8:15=E2=80=AFAM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> Hi Victor,
>
> On Fri, May 12, 2023 at 6:47=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > Add support SD Express card for GL9767. The workflow of the
> > SD Express card in GL9767 is as below.
> > 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> > 2. If card is inserted, Host send CMD8 to ask the capabilities
> >    of the card.
> > 3. If the card has PCIe capability and write protect is not
> >    enable, then init_sd_express() will be invoked.
> > 4. GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
> >    handover control to NVMe driver.
> > 5. If card is removed, GL9767 will return to SD mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 115 +++++++++++++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 300512740cb0..a0f9c24439be 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -158,6 +158,13 @@
> >  #define   GLI_9767_VHS_REV_M     0x1
> >  #define   GLI_9767_VHS_REV_W     0x2
> >
> > +#define PCIE_GLI_9767_CFG              0x8A0
> > +#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF          BIT(12)
> > +
> > +#define PCIE_GLI_9767_COMBO_MUX_CTL                    0x8C8
> > +#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN             BIT(6)
> > +#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN      BIT(10)
> > +
> >  #define PCIE_GLI_9767_PWR_MACRO_CTL                                   =
 0x8D0
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                     =
   GENMASK(3, 0)
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE          =
   GENMASK(15, 12)
> > @@ -175,6 +182,27 @@
> >  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF              BIT(21)
> >  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN       BIT(30)
> >
> > +#define PCIE_GLI_9767_SDHC_CAP                 0x91C
> > +#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT     BIT(5)
> > +
> > +#define PCIE_GLI_9767_SD_EXPRESS_CTL                   0x940
> > +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE                  BIT(0=
)
> > +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE   BIT(1)
> > +
> > +#define PCIE_GLI_9767_SD_DATA_MULTI_CTL                               =
 0x944
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME        GENMA=
SK(23, 16)
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE       =
   0x64
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2                      =
 0x950
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE      =
   BIT(0)
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIMER     =
   GENMASK(1, 0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2                   =
         0x954
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_ST=
ATUS_EN    GENMASK(1, 0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                   =
         0x958
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SI=
GNAL_EN    GENMASK(1, 0)
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -774,6 +802,91 @@ static void sdhci_gl9767_reset(struct sdhci_host *=
host, u8 mask)
> >         gli_set_9767(host);
> >  }
> >
> > +static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +       struct pci_dev *pdev;
> > +       u32 value;
> > +       int i;
> > +
> > +       pdev =3D slot->chip->pdev;
> > +
> > +       if (sdhci_check_ro(host)) {
> > +               mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_S=
D_EXP_1_2V);
> > +               return 0;
> > +       }
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> > +       value &=3D ~GLI_9767_VHS_REV;
> > +       value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value=
);
> > +       value &=3D ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767=
_COMBO_MUX_CTL_WAIT_PERST_EN);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value=
);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &v=
alue);
> > +       value &=3D ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
> > +       value |=3D FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNEC=
T_TIME,
> > +                           PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_=
TIME_VALUE);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, v=
alue);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS=
_REG2, &value);
> > +       value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TI=
MER;
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATU=
S_REG2, value);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS=
_EN_REG2, &value);
> > +       value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COM=
PLETE_STATUS_EN;
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATU=
S_EN_REG2, value);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL=
_EN_REG2, &value);
> > +       value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COM=
PLETE_SIGNAL_EN;
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNA=
L_EN_REG2, value);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > +       value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > +
> > +       value =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +       value &=3D ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> > +       sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> > +
> > +       value =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
> > +       value |=3D ((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);
> > +       sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &valu=
e);
> > +       value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, valu=
e);
> > +
> > +       for (i =3D 0; i < 10; i++) {
> > +               mdelay(10);
>
> A little question.
> Can you explain or comment on the reason for up to 10 loops (max. 100 ms =
wait),
> For example "because of asic specs..." or "hardware measurements".
>
> Best regards,
> Ben
>

Because specs define the time between Power valid to CLKREQ at most 1ms.
To be on the safe side I will update to 3 loops(max. 30 ms wait) in Patch v=
2.

> > +               pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_IN=
T_STATUS_REG2, &value);
> > +               if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SD=
EI_COMPLETE) {
> > +                       pci_write_config_dword(pdev, PCIE_GLI_9767_NORM=
AL_ERR_INT_STATUS_REG2,
> > +                                              value);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
> > +       if ((value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) =3D=3D PCIE_GL=
I_9767_SDHC_CAP_SDEI_RESULT) {
> > +               pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CT=
L, &value);
> > +               value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE=
;
> > +               pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_C=
TL, value);
> > +       } else {
> > +               mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_S=
D_EXP_1_2V);
> > +       }
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> > +       value &=3D ~GLI_9767_VHS_REV;
> > +       value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> > +
> > +       return 0;
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >         struct sdhci_host *host =3D slot->host;
> > @@ -806,6 +919,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_s=
lot *slot)
> >         gl9767_hw_setting(slot);
> >         gli_pcie_enable_msi(slot);
> >         slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> > +       host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> > +       host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
> >         sdhci_enable_v4_mode(host);
> >
> >         return 0;
> > --
> > 2.25.1
> >

Thanks, Victor Shih
