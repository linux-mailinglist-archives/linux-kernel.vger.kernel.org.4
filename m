Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A79605AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJTJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJTJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:17:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF81BFB97;
        Thu, 20 Oct 2022 02:17:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w18so45852899ejq.11;
        Thu, 20 Oct 2022 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijAZiBjO3w0y1kvusgRiOelSTdrXihYwCd2kzIFwaGs=;
        b=EpuGO0hZUcyRg18HdoToRuQnkUQJhKA77WFdMukfQb/RbDQDxHL0enGmIn0EqusrB4
         0Rfm2GO+gmrd+9/TiSSNoMDNlXyaP6I1ylJDndRamZ3q3ju5gwgYx5fmCG3vmibCcjua
         g3kWybmZcLiVSfM6lorgbzJfSO+/CP5KNSjiUhUhsJbfz/b/9+XoaAaQE0LAQDjz/HsI
         UBYjThQ4UdPQOMEHg1WDsUOMqMxM5wfkE/foRHAx+ilfv4pzZrcJ+3agR9GegscC/K4i
         LkRmFhlqLz4t6+ZW+mKBRr8ESGCmGNt3e/1a6Cya6dii2DSDGEZie5xDGrMpROZj1Jgk
         3ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijAZiBjO3w0y1kvusgRiOelSTdrXihYwCd2kzIFwaGs=;
        b=lyuwyIdU0i/xCge9r6g6q6djwJUyKaDAM7yqIKJRo/VWEGtiI7HT/viIFOclGfbN6r
         GKKPCkGi9FnWz+maqF2px+gY0qFEPtMs1CSro37Vp2wHi1O+D9DIBZ+mX3Z7YItLRQCe
         K5jk3Mx1wK/npXNas+RjyJsIm4g8qZPrsB/6n2x9e7+CWpDMdSTMCYNKG+tybqGBObqu
         C8LGGJdBS9BUDonNVZqRr2zQXqhhZOfyuOAhFo+qgKTil0k360v8TsiVrui+2nO4dgZy
         sY2yFF6bMAYZz7Vx6HRQ8+R/uvLVl8qj9GZCxMKsyBBu8CYkp44Eo8gMUqPCAjitBw7e
         1i3g==
X-Gm-Message-State: ACrzQf2CSsAQm3UsH8RYQJLYUXyvxWrShwuvrLMH3KUQb/oj62Mz1i8H
        fsYRKAWTj1P/jg9+St25nAjYQTcgFsTF5FtVz0w=
X-Google-Smtp-Source: AMsMyM4aprYfd77BrZhcLjIeRA3YKHSKMc9W9DhAYJ7Dgjpqn9yKGmc6i2ZKCYcolLWMgV/lb7UGii5PNx7S7USak3w=
X-Received: by 2002:a17:907:6d9b:b0:78d:ce6a:3300 with SMTP id
 sb27-20020a1709076d9b00b0078dce6a3300mr9640449ejc.91.1666257431179; Thu, 20
 Oct 2022 02:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221020013535.27843-1-zhewang116@gmail.com> <DM6PR04MB6575A7FE015D8690F5094957FC2A9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575A7FE015D8690F5094957FC2A9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Zhe Wang <zhewang116@gmail.com>
Date:   Thu, 20 Oct 2022 17:16:59 +0800
Message-ID: <CAJxzgGoGcqi5H0-CAtSz4ELoK4ShG0ObEkbz4Z2kALFvULw8wg@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: ufs: core: Let delay value after LPM can be
 modified by vendor
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "zhe.wang1@unisoc.com" <zhe.wang1@unisoc.com>,
        "zhenxiong.lai@unisoc.com" <zhenxiong.lai@unisoc.com>,
        "yuelin.tang@unisoc.com" <yuelin.tang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avri Altman <Avri.Altman@wdc.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=9B=9B 15:16=E5=86=99=E9=81=93=EF=BC=9A
>
> > From: Zhe Wang <zhe.wang1@unisoc.com>
> >
> > Some UFS devices require that the VCC should drop below 0.1V after
> > turning off, otherwise device may not resume successfully. And
> > because the power-off rate is different on different SOC platforms.
> > Therefore, we hope that the delay can be modified by vendor to
> > adjust the most appropriate delay value.
> >
> > Signed-off-by: Zhe Wang <zhe.wang1@unisoc.com>
> > ---
> >  drivers/ufs/core/ufshcd.c | 11 +++++++++--
> >  include/ufs/ufshcd.h      |  2 ++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 7256e6c43ca6..f6350231da0e 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -89,6 +89,9 @@
> >  /* Polling time to wait for fDeviceInit */
> >  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
> >
> > +/* Default value of turn off VCC rail: 5000us */
> > +#define UFS_VCC_TURNOFF_DELAY_US 5000
> > +
> >  #define ufshcd_toggle_vreg(_dev, _vreg, _on)                          =
 \
> >         ({                                                             =
 \
> >                 int _ret;                                              =
 \
> > @@ -7784,6 +7787,9 @@ static int ufs_get_device_desc(struct ufs_hba
> > *hba)
> >
> >         ufs_fixup_device_setup(hba);
> >
> > +       if (hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
> > !hba->vcc_turnoff_delay)
> > +               hba->vcc_turnoff_delay =3D UFS_VCC_TURNOFF_DELAY_US;
> Couldn't find where otherwise you are setting this value?
> Also, UFS_DEVICE_QUIRK_DELAY_AFTER_LPM is only set for MTK.
> Are you planning at some point adding your own host driver?
>

We are still preparing and discussing our own UFS host driver code,
which will be uploaded once we are done.

> > +
> >         ufshcd_wb_probe(hba, desc_buf);
> >
> >         ufshcd_temp_notif_probe(hba, desc_buf);
> > @@ -8917,8 +8923,9 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba
> > *hba)
> >          * Some UFS devices require delay after VCC power rail is turne=
d-off.
> >          */
> >         if (vcc_off && hba->vreg_info.vcc &&
> > -               hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM)
> > -               usleep_range(5000, 5100);
> > +               hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
> > +               hba->vcc_turnoff_delay)
> > +               usleep_range(hba->vcc_turnoff_delay, hba->vcc_turnoff_d=
elay +
> > 100);
> >  }
> >
> >  #ifdef CONFIG_PM
> > diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> > index 9f28349ebcff..bfde3cb962fb 100644
> > --- a/include/ufs/ufshcd.h
> > +++ b/include/ufs/ufshcd.h
> > @@ -828,6 +828,7 @@ struct ufs_hba_monitor {
> >   *     device
> >   * @complete_put: whether or not to call ufshcd_rpm_put() from inside
> >   *     ufshcd_resume_complete()
> > + * @vcc_turnoff_delay: VCC turnoff delay value.
> >   */
> >  struct ufs_hba {
> >         void __iomem *mmio_base;
> > @@ -975,6 +976,7 @@ struct ufs_hba {
> >  #endif
> >         u32 luns_avail;
> >         bool complete_put;
> > +       u32 vcc_turnoff_delay;
> Can this be part of struct ufs_vreg instead?
> Also maybe vcc_turnoff_delay_us?
>
> Thanks,
> Avri
> >  };
> >
> >  /* Returns true if clocks can be gated. Otherwise false */
> > --
> > 2.17.1
>

Thanks for your suggestion, I will modify it in V2.

Thanks,
Zhe Wang
