Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF97020B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjEOACB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEOACA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:02:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759213D;
        Sun, 14 May 2023 17:01:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so18208561a12.0;
        Sun, 14 May 2023 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684108916; x=1686700916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcHALSfCL/GC6DMlrpcXyI9y7ZjraMP4QnYveYiPf+4=;
        b=YFGnmczvEq0PbvVszexBH/AjfiDVmXm3CNVhWnVK6yWc/FU0eldB1wsqXK2DZtaghe
         bw9pNBKXGVBgiwVI8T5k3qVSqW03099N5DMo8cYi7YV+Sy+L4s1p7b+QISMbYJWQICSL
         aMisiSjONe3BWkUopCazxepS5P3wnDy3e0qE+x/zwGLd1geG8a7zygAeMNvWNuqwo3dU
         bkJuCZ4WQzAjzScvTPOd36Ua1/+UR43Ydk+alPxdC6u/me3OUx6VFidNihfk1cZeNcUz
         fRh3cEFDSrUTz8OaETlcORUhW1JkS7SvwUEen8NIHzeKQvtgjNZFxYozB24S96JiisRS
         m4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684108916; x=1686700916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcHALSfCL/GC6DMlrpcXyI9y7ZjraMP4QnYveYiPf+4=;
        b=C9nfVxTJeOLVmYRHaFNxP1uKKRfXx0B1/kSwnpfmjDH8XHqhS3qoXp7/2fkyZr3Fr8
         VdHPYBvFyoc/4uNygQj53ysokuVSrAmYvfVJsAY+lVEXn3hReDE18ERTgDq3rlMRYu6+
         vcbfoXLE6adzy3DfLPIzsXIQu7D/J3WTKoXeaAwfOjwgwuX8jdj/iScdS7esCyZMvST+
         hyAxr81aaFx7PblwasrqIi5AxnM/BBasUv6u8ewayR/EsX3WxPxDAQ1MI/BU4JF5OF2F
         s6S4+4YbiFqrYPww0oQjCRTldL6nj/OvDQzXiGa7pReAsQMR2CswxYvvq+GNA47CSk2y
         f0vg==
X-Gm-Message-State: AC+VfDyECvH2KYROD8VzTMaysnOA4niEZfmzUb+TY8IvnhdY9jeS2D8m
        Ch/Q9JrUs8EIxkvAaDCuomT5BzfBCoh5p79ynJE=
X-Google-Smtp-Source: ACHHUZ5jIxKtkNwQ2S8J7O+CeqpcLqCvrRw/0ijvqbeStAbUgvPg43y0c/9ii2ctylBu+8y2Zl0ZDVo4qCPxhlvTynE=
X-Received: by 2002:a05:6402:38c:b0:50c:646:da42 with SMTP id
 o12-20020a056402038c00b0050c0646da42mr26771700edv.28.1684108916150; Sun, 14
 May 2023 17:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw> <20230512104559.11218-2-victor.shih@genesyslogic.com.tw>
In-Reply-To: <20230512104559.11218-2-victor.shih@genesyslogic.com.tw>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Mon, 15 May 2023 08:01:44 +0800
Message-ID: <CACT4zj_LRArVUS4HsP134+NMm2T-PRgFGpwxmcrK87V-5rqhqg@mail.gmail.com>
Subject: Re: [PATCH V1 1/3] mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Victor,

One thing, get in the habit of running checkpatch.pl before submitting patc=
hes.

checkpatch.pl says.
"From:/Signed-off-by: email address mismatch: 'From: Victor Shih
<victorshihgli@gmail.com>' !=3D 'Signed-off-by: Victor Shih
<victor.shih@genesyslogic.com.tw>'"

It reminds you that maybe the first line of the email body needs a
line "Form: Victor Shih <victor.shih@genesyslogic.com.tw>'".

man git-format-patch and see --form option

Best regards,
Ben


On Fri, May 12, 2023 at 6:47=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> Add support for the GL9767 chipset. GL9767 supports
> SD3 mode likes UHS-I SDR50, SDR104.
> Enable MSI interrupt for GL9767. Some platform do not
> support PCI INTx and devices can not work without
> interrupt.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-core.c |   1 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 132 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |   2 +
>  3 files changed, 135 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index 01975d145200..1c2572c0f012 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1903,6 +1903,7 @@ static const struct pci_device_id pci_ids[] =3D {
>         SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
>         SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
>         SDHCI_PCI_DEVICE(GLI, 9763E, gl9763e),
> +       SDHCI_PCI_DEVICE(GLI, 9767, gl9767),
>         SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>         /* Generic SD host controller */
>         {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index 633a8ee8f8c5..300512740cb0 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -149,6 +149,32 @@
>  #define PCI_GLI_9755_PM_CTRL     0xFC
>  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
>
> +#define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> +#define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> +
> +#define PCIE_GLI_9767_VHS      0x884
> +#define   GLI_9767_VHS_REV       GENMASK(19, 16)
> +#define   GLI_9767_VHS_REV_R     0x0
> +#define   GLI_9767_VHS_REV_M     0x1
> +#define   GLI_9767_VHS_REV_W     0x2
> +
> +#define PCIE_GLI_9767_PWR_MACRO_CTL                                    0=
x8D0
> +#define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                       =
 GENMASK(3, 0)
> +#define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE            =
 GENMASK(15, 12)
> +#define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE_VALUE      =
 0x7
> +#define   PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL                =
 GENMASK(29, 28)
> +#define   PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL_VALUE          =
 0x3
> +
> +#define PCIE_GLI_9767_SCR                              0x8E0
> +#define   PCIE_GLI_9767_SCR_AUTO_AXI_W_BURST             BIT(6)
> +#define   PCIE_GLI_9767_SCR_AUTO_AXI_R_BURST             BIT(7)
> +#define   PCIE_GLI_9767_SCR_AXI_REQ                      BIT(9)
> +#define   PCIE_GLI_9767_SCR_CARD_DET_PWR_SAVING_EN       BIT(10)
> +#define   PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE0      BIT(16)
> +#define   PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE1      BIT(17)
> +#define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF              BIT(21)
> +#define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN       BIT(30)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -693,6 +719,61 @@ static void gl9755_hw_setting(struct sdhci_pci_slot =
*slot)
>         gl9755_wt_off(pdev);
>  }
>
> +static void gli_set_9767(struct sdhci_host *host)
> +{
> +       u32 value;
> +
> +       value =3D sdhci_readl(host, SDHCI_GLI_9767_GM_BURST_SIZE);
> +       value &=3D ~SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET;
> +       sdhci_writel(host, value, SDHCI_GLI_9767_GM_BURST_SIZE);
> +}
> +
> +static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
> +{
> +       struct pci_dev *pdev =3D slot->chip->pdev;
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +       value &=3D ~GLI_9767_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_PWR_MACRO_CTL, &value);
> +       value &=3D ~(PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE |
> +                  PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE |
> +                  PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL);
> +
> +       value |=3D PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE |
> +                FIELD_PREP(PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VO=
LTAGE,
> +                           PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VO=
LTAGE_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CT=
L,
> +                           PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CT=
L_VALUE);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_PWR_MACRO_CTL, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SCR, &value);
> +       value &=3D ~(PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE0 |
> +                  PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE1 |
> +                  PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN);
> +
> +       value |=3D PCIE_GLI_9767_SCR_AUTO_AXI_W_BURST |
> +                PCIE_GLI_9767_SCR_AUTO_AXI_R_BURST |
> +                PCIE_GLI_9767_SCR_AXI_REQ |
> +                PCIE_GLI_9767_SCR_CARD_DET_PWR_SAVING_EN |
> +                PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_SCR, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +       value &=3D ~GLI_9767_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> +}
> +
> +static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
> +{
> +       sdhci_reset(host, mask);
> +       gli_set_9767(host);
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host =3D slot->host;
> @@ -717,6 +798,19 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_sl=
ot *slot)
>         return 0;
>  }
>
> +static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
> +{
> +       struct sdhci_host *host =3D slot->host;
> +
> +       gli_set_9767(host);
> +       gl9767_hw_setting(slot);
> +       gli_pcie_enable_msi(slot);
> +       slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> +       sdhci_enable_v4_mode(host);
> +
> +       return 0;
> +}
> +
>  static void sdhci_gli_voltage_switch(struct sdhci_host *host)
>  {
>         /*
> @@ -740,6 +834,25 @@ static void sdhci_gli_voltage_switch(struct sdhci_ho=
st *host)
>         usleep_range(100000, 110000);
>  }
>
> +static void sdhci_gl9767_voltage_switch(struct sdhci_host *host)
> +{
> +       /*
> +        * According to Section 3.6.1 signal voltage switch procedure in
> +        * SD Host Controller Simplified Spec. 4.20, steps 6~8 are as
> +        * follows:
> +        * (6) Set 1.8V Signal Enable in the Host Control 2 register.
> +        * (7) Wait 5ms. 1.8V voltage regulator shall be stable within th=
is
> +        *     period.
> +        * (8) If 1.8V Signal Enable is cleared by Host Controller, go to
> +        *     step (12).
> +        *
> +        * Wait 5ms after set 1.8V signal enable in Host Control 2 regist=
er
> +        * to ensure 1.8V signal enable bit is set by GL9767.
> +        *
> +        */
> +       usleep_range(5000, 5500);
> +}
> +
>  static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
>  {
>         sdhci_reset(host, mask);
> @@ -1150,3 +1263,22 @@ const struct sdhci_pci_fixes sdhci_gl9763e =3D {
>  #endif
>         .add_host       =3D gl9763e_add_host,
>  };
> +
> +static const struct sdhci_ops sdhci_gl9767_ops =3D {
> +       .set_clock              =3D sdhci_set_clock,
> +       .enable_dma             =3D sdhci_pci_enable_dma,
> +       .set_bus_width          =3D sdhci_set_bus_width,
> +       .reset                  =3D sdhci_gl9767_reset,
> +       .set_uhs_signaling      =3D sdhci_set_uhs_signaling,
> +       .voltage_switch         =3D sdhci_gl9767_voltage_switch,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9767 =3D {
> +       .quirks         =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +       .quirks2        =3D SDHCI_QUIRK2_BROKEN_DDR50,
> +       .probe_slot     =3D gli_probe_slot_gl9767,
> +       .ops            =3D &sdhci_gl9767_ops,
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         =3D sdhci_pci_gli_resume,
> +#endif
> +};
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 3661a224fb04..9c8863956381 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -76,6 +76,7 @@
>  #define PCI_DEVICE_ID_GLI_9755         0x9755
>  #define PCI_DEVICE_ID_GLI_9750         0x9750
>  #define PCI_DEVICE_ID_GLI_9763E                0xe763
> +#define PCI_DEVICE_ID_GLI_9767         0x9767
>
>  /*
>   * PCI device class and mask
> @@ -195,5 +196,6 @@ extern const struct sdhci_pci_fixes sdhci_o2;
>  extern const struct sdhci_pci_fixes sdhci_gl9750;
>  extern const struct sdhci_pci_fixes sdhci_gl9755;
>  extern const struct sdhci_pci_fixes sdhci_gl9763e;
> +extern const struct sdhci_pci_fixes sdhci_gl9767;
>
>  #endif /* __SDHCI_PCI_H */
> --
> 2.25.1
>
