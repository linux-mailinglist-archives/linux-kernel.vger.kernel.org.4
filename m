Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A72738137
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjFUKa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFUKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:30:18 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B861BC;
        Wed, 21 Jun 2023 03:29:49 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4714e9f07c0so1439332e0c.2;
        Wed, 21 Jun 2023 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343389; x=1689935389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1hCR/RpFfEM3DxPOLTmi3chu8PDZxhhdS78MW46lzc=;
        b=I6RJ+0o32sU5w6BZaNTQXMXumXgZMD2x8fhpMR5GMt/079xCwBfWjqc8GM9Y7Mmh62
         v+oKk3ezKIqqcop8ZkZWmTNy3dTR2sBGzSTn/y9WtKQVMyNHQPHaYpHlaOUU2ni2sPlS
         +jtgMeNdXPBuuvqMxa6ymF9I7zcXh65lEo/ONQWKbjmu7wJvc5TPMm54EPOouMWg+qgo
         XDX8IsXW88qXx4rNgeXv/hY88/gKd1QEDkD9ohiivE9RskxiPht8h8j+BdFFWTmLQAol
         vYPwMqhLQ01NT24ReVxf6hCqbvnIpJMEgVVOZKT+WI9/eA+sX9hUVMxUr9+TR/2iVJdz
         qQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343389; x=1689935389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1hCR/RpFfEM3DxPOLTmi3chu8PDZxhhdS78MW46lzc=;
        b=a85ym0JcxMXvNlw3biqEF/pwv8XNKUMKvISvbObR6zSZ/6+SAqZva7VecBYGOiYnv+
         78HM7KGAgSDUboNClOtPXRIU9+8KNN0nEe89lCv9tEQ1Uek+2Bc3BZnKQVaq2fYebdjA
         5XxUmRsKLaHcFoR+diN4VwF4BvBQ46HKUzy7yAR7gPOCNVZ2URW/IHFyeLWGuoekVN9c
         fa85kvQ+nAYybYC12GwDu+pprJwoTCvXPSwqescUfnFk+kWH620kMDUXsaO4wTbcP7y+
         aB1l3P2Dq5EnDNf1+c65X0INvh8eM5ZEQMZ4R1z5uHyKt1Rh8UyFWNw162qgI4paaekk
         uMOg==
X-Gm-Message-State: AC+VfDwypGnxzyX5L2M9aMkdbIz5mFH+kKGsxX0uY220hu8eWmhzhbSg
        SmdFj0Qa2PJgtW0S0SzcTC8mwXWEYCSH7Ro8Lnw=
X-Google-Smtp-Source: ACHHUZ5usrw26q+Ew7a7uwoG/WauIdZremjztT1Qw12eQ3UauWzOHMSCcuWCFw7OrYIK84jMVEyvQhnuoBkkDrIGSOs=
X-Received: by 2002:a1f:3f02:0:b0:471:2aa6:41f4 with SMTP id
 m2-20020a1f3f02000000b004712aa641f4mr3917248vka.7.1687343388843; Wed, 21 Jun
 2023 03:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-16-victor.shih@genesyslogic.com.tw> <5feaa219-946a-cafd-a9f0-6ab344788f04@intel.com>
In-Reply-To: <5feaa219-946a-cafd-a9f0-6ab344788f04@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:29:36 +0800
Message-ID: <CAK00qKB5PtQg2mgba7Hc+s1yPD4gVjsvkzw0pAe_AQWu4DcPCg@mail.gmail.com>
Subject: Re: [PATCH V7 15/23] mmc: sdhci-uhs2: add detect_init() to detect the interface
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
> > Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_ini=
t
> > operation. After detected, the host's UHS-II capabilities will be set u=
p
> > here and interrupts will also be enabled.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 117 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 9b519bd6d76e..e2972be1889f 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -334,6 +334,123 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
> > +{
> > +     /* 100ms */
> > +     int timeout =3D 100000;
> > +     u32 val;
> > +
> > +     udelay(200); /* wait for 200us before check */
>
> There does not seem to be any need for this function
> to be atomic, so this should use usleep_range() not udelay().
>

I will update it to the V8 version.

> > +
> > +     if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_=
IF_DETECT),
> > +                                  100, timeout, true, host, SDHCI_PRES=
ENT_STATE)) {
>
> Does not need to be atomic
>

I will update it to the V8 version.

> > +             pr_warn("%s: not detect UHS2 interface in 200us.\n", mmc_=
hostname(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return -EIO;
> > +     }
> > +
> > +     /* Enable UHS2 error interrupts */
> > +     sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_IN=
T_ERROR_MASK);
> > +
> > +     /* 150ms */
> > +     timeout =3D 150000;
> > +     if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_=
LANE_SYNC),
>
> Does not need to be atomic
>

I will update it to the V8 version.

> > +                                  100, timeout, true, host, SDHCI_PRES=
ENT_STATE)) {
> > +             pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostna=
me(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return -EIO;
> > +     }
> > +
> > +     DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.=
\n",
> > +         mmc_hostname(host->mmc));
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_init(struct sdhci_host *host)
> > +{
> > +     u16 caps_ptr =3D 0;
> > +     u32 caps_gen =3D 0;
> > +     u32 caps_phy =3D 0;
> > +     u32 caps_tran[2] =3D {0, 0};
> > +     struct mmc_host *mmc =3D host->mmc;
> > +
> > +     caps_ptr =3D sdhci_readw(host, SDHCI_UHS2_CAPS_PTR);
> > +     if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> > +             pr_err("%s: SDHCI_UHS2_CAPS_PTR(%d) is wrong.\n",
> > +                    mmc_hostname(mmc), caps_ptr);
> > +             return -ENODEV;
> > +     }
> > +     caps_gen =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_OFFSET)=
;
> > +     caps_phy =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_PHY_OFF=
SET);
> > +     caps_tran[0] =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRA=
N_OFFSET);
> > +     caps_tran[1] =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRA=
N_1_OFFSET);
> > +
> > +     /* General Caps */
> > +     mmc->uhs2_caps.dap =3D caps_gen & SDHCI_UHS2_CAPS_DAP_MASK;
> > +     mmc->uhs2_caps.gap =3D FIELD_GET(SDHCI_UHS2_CAPS_GAP_MASK, caps_g=
en);
> > +     mmc->uhs2_caps.n_lanes =3D FIELD_GET(SDHCI_UHS2_CAPS_LANE_MASK, c=
aps_gen);
> > +     mmc->uhs2_caps.addr64 =3D (caps_gen & SDHCI_UHS2_CAPS_ADDR_64) ? =
1 : 0;
> > +     mmc->uhs2_caps.card_type =3D FIELD_GET(SDHCI_UHS2_CAPS_DEV_TYPE_M=
ASK, caps_gen);
> > +
> > +     /* PHY Caps */
> > +     mmc->uhs2_caps.phy_rev =3D caps_phy & SDHCI_UHS2_CAPS_PHY_REV_MAS=
K;
> > +     mmc->uhs2_caps.speed_range =3D FIELD_GET(SDHCI_UHS2_CAPS_PHY_RANG=
E_MASK, caps_phy);
> > +     mmc->uhs2_caps.n_lss_sync =3D FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS=
_SYN_MASK, caps_phy);
> > +     mmc->uhs2_caps.n_lss_dir =3D FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_=
DIR_MASK, caps_phy);
> > +     if (mmc->uhs2_caps.n_lss_sync =3D=3D 0)
> > +             mmc->uhs2_caps.n_lss_sync =3D 16 << 2;
> > +     else
> > +             mmc->uhs2_caps.n_lss_sync <<=3D 2;
> > +     if (mmc->uhs2_caps.n_lss_dir =3D=3D 0)
> > +             mmc->uhs2_caps.n_lss_dir =3D 16 << 3;
> > +     else
> > +             mmc->uhs2_caps.n_lss_dir <<=3D 3;
> > +
> > +     /* LINK/TRAN Caps */
> > +     mmc->uhs2_caps.link_rev =3D caps_tran[0] & SDHCI_UHS2_CAPS_TRAN_L=
INK_REV_MASK;
> > +     mmc->uhs2_caps.n_fcu =3D FIELD_GET(SDHCI_UHS2_CAPS_TRAN_N_FCU_MAS=
K, caps_tran[0]);
> > +     if (mmc->uhs2_caps.n_fcu =3D=3D 0)
> > +             mmc->uhs2_caps.n_fcu =3D 256;
> > +     mmc->uhs2_caps.host_type =3D FIELD_GET(SDHCI_UHS2_CAPS_TRAN_HOST_=
TYPE_MASK, caps_tran[0]);
> > +     mmc->uhs2_caps.maxblk_len =3D FIELD_GET(SDHCI_UHS2_CAPS_TRAN_BLK_=
LEN_MASK, caps_tran[0]);
> > +     mmc->uhs2_caps.n_data_gap =3D caps_tran[1] & SDHCI_UHS2_CAPS_TRAN=
_1_N_DATA_GAP_MASK;
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     int ret =3D -EIO;
> > +
> > +     DBG("Begin do uhs2 detect init.\n");
> > +
> > +     if (sdhci_uhs2_interface_detect(host)) {
> > +             pr_warn("%s: cannot detect UHS2 interface.\n",
> > +                     mmc_hostname(host->mmc));
> > +             goto out;
>
> Might as well be
>
>                 return -EIO;
>

I will update it to the V8 version.

> > +     }
> > +
> > +     if (sdhci_uhs2_init(host)) {
> > +             pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc))=
;
> > +             goto out;
>
> Might as well be
>
>                 return -EIO;
>

I will update it to the V8 version.

> > +     }
> > +
> > +     /* Init complete, do soft reset and enable UHS2 error irqs. */
> > +     sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +     sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_IN=
T_ERROR_MASK);
> > +     /*
> > +      * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
> > +      * by SDHCI_UHS2_SW_RESET_SD
> > +      */
> > +     sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +     sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +
> > +     ret =3D 0;
> > +out:
> > +     return ret;
>
> Might as well be
>
>         return 0;
>
> so "out:" and ret not needed.
>

I will update it to the V8 version.

> > +}
> > +
> >  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> >       host->mmc_host_ops.start_signal_voltage_switch =3D
>

Thanks, Victor Shih
