Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A50A5FC23D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJLItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJLIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:49:29 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D385B602F;
        Wed, 12 Oct 2022 01:49:26 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id h29so6419330vsq.9;
        Wed, 12 Oct 2022 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT6vm5RgNS7C4+asnNcyhYxIo19D0jl2wY3gLjkvDnk=;
        b=DXYz02MrrRpI7kR/dn1whWhF5IKGqqVuWjIOsaP7ROb4Dr3Ddj6bnfEroAzc55pint
         v6TekMo62ZfnsTEbJhu6KysOTtdL+5Rvc5q/je5cAdnv5imEu8Sc4rL+mXQdIkau8K5b
         RzWw0477zcrDtPeoUbeUK7QZJLdC4Y5WmdRsl6kBivU9EQmpKdNl4+63jL+Yr5VGyOzI
         10GrX9RQv3NEJxL/jIrGHZ8ZcZPqPiJX/n695ofvj5TgeHWXDoVTyacUF01DHzx2lv/U
         cE5gzId7RFjrmNLw982nXTmLC3wgOlcduC+mcOA7Lm3NnKKfq4yNQMIN4eGJpBUpVfBc
         xJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT6vm5RgNS7C4+asnNcyhYxIo19D0jl2wY3gLjkvDnk=;
        b=wJQeUTtWCtP9U47TTwQ3KVC75At4idVGyDp8N54Wev0959scW3/AOEigDtoH6JoML0
         fepcMhNUIV4E5YVdEPXiDEROnRlE6LNLlPzvEV1f/rXtJiToyteerpGKBUC/a5i1eCn4
         UBuzoxnuASytlYgTySaeOL1z3b5XPDQt36GrCrMWD8BKAXZ1WgKWy374me7chiBQxnW+
         IzkIv1jaGKDXFCyYOm0JYM2nmLj/xM29rGkmaAsKCKXvXS+empP8Cy55XGA51bXU+v2I
         +NrLmOHQ3WhMppux+SxZ5EinN38gwbpOlWBS3DKmlv8o9xbtsZ+b+Vjn7SiTLGSL5Wn7
         D9PA==
X-Gm-Message-State: ACrzQf0sj8WOI3rv6DV/owFzK/QTNIucRtJkcgyps5wUAF2Dx1tsxiA1
        qo2hcW7zeSIFgPTXS+gzsfSgIv3AysDewN8LDaE=
X-Google-Smtp-Source: AMsMyM4G2XhGUXPUuWxGoZdSUuXYP327ZT1uONR9Taoxy/kh/cAG9dndchZslV6FSJHIacHdlE1TaLNtwUtHB4VLkKE=
X-Received: by 2002:a67:f510:0:b0:3a7:7afe:53c0 with SMTP id
 u16-20020a67f510000000b003a77afe53c0mr6915833vsn.53.1665564566013; Wed, 12
 Oct 2022 01:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
 <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
 <DM6PR04MB65756E9549E9DCDB4BCF8FF6FC229@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB657509954BB9AA1C22739928FC229@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657509954BB9AA1C22739928FC229@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   =?UTF-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>
Date:   Wed, 12 Oct 2022 16:49:15 +0800
Message-ID: <CAFN68yW=r+vZn0wBDrkHeoNXajcknkQOm+5tZ=dwkg+3eLqGEg@mail.gmail.com>
Subject: Re: [PATCH] ufs: core: Disable auto h8 before ssu
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Avri

TKS for your suggestion. and adjust timimg in own vop can solve this
problem surely.
but I think it's more of a common patch for all platforms,
Patch can adapt different vendors,and align to
ufshcd_auto_hibern8_enable in __ufshcd_wl_resume.
Not distinguishing pm_op can refer to ufshcd_auto_hibern8_enable in
__ufshcd_wl_resume.

Avri Altman <Avri.Altman@wdc.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=89 16:13=E5=86=99=E9=81=93=EF=BC=9A
>
> > >
> > > Dear Avri
> > >   Unisoc reports resume fail on UFS(micron FS164) during suspend/resu=
me
> > > test.
> > >   We check host inserts auto H8 enter/exit event between SSU sleep
> > > command and H8 enter command in runtime suspend .
> > >   Asfollows: SSU Sleep command --> auto H8 enter --> auto H8 exit -->
> > > H8 enter --> idle 2ms --> VCC off.
> > >   However device AQL FW can=E2=80=99t enter LPM within 2ms after seco=
nd H8
> > enter
> > > command.
> > >   FW already enter LPM after receive auto H8 enter command , Next aut=
o
> > > H8 exit command will trigger FW exit from LPM, it need take over 10ms=
,
> > and
> > > FW can=E2=80=99t enter
> > >   LPM again after second H8 enter command until device complete exit
> > from
> > > LPM. So disable auto h8 before ssu is a reasonable solution to solve =
it.
> > >   Hynix also has similar request.
> > Is this something common to all platforms?
> > If not, and you need your platform to disable h8 before ssu,
> > You can implement it in your own vop - see e.g.
> > commit 9561f58442e4 (scsi: ufs: mediatek: Support vops pre suspend to
> > disable auto-hibern8)
> Maybe to further clarify, I am not saying that your suggestion doesn't ma=
ke sense.
> It's just that you need, IMHO, to make it part of ufshcd_vops_suspend, wh=
ich I think
> Its ufshcd_system_suspend for every platform.
> And you need to get an ack on that from the other platform owners (maybe =
except
> Stanley who is doing it already).
>
> Btw, you are not checking the pm_op so your are disabling auto-h8 for run=
time-suspend
> As well.
>
> And maybe elaborate the commit log with your explanation above - making i=
t more clear.
>
> Thanks,
> Avri
> >
> > Thanks,
> > Avri
> >
> > >
> > > Avri Altman <Avri.Altman@wdc.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=BA=8C 15:07=E5=86=99=E9=81=93
> > =EF=BC=9A
> > > >
> > > > > From: Ten Gao <ten.gao@unisoc.com>
> > > > >
> > > > > Ensure auto h8 will not hit dme h8,and there won't be two h8 in a
> > > > > row after ssu.
> > > > I don't think the hw should do that.
> > > > Can you please share on which platform/host controller did you obse=
rve
> > > this?
> > > >
> > > > Thanks,
> > > > Avri
> > > > >
> > > > > Signed-off-by: Ten Gao <ten.gao@unisoc.com>
> > > > > ---
> > > > >  drivers/ufs/core/ufshcd.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.=
c
> > > > > index
> > > > > a202d7d5240d..42f93648d796 100644
> > > > > --- a/drivers/ufs/core/ufshcd.c
> > > > > +++ b/drivers/ufs/core/ufshcd.c
> > > > > @@ -4256,6 +4256,14 @@ void ufshcd_auto_hibern8_update(struct
> > > > > ufs_hba *hba, u32 ahit)  }
> > > > > EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
> > > > >
> > > > > +void ufshcd_auto_hibern8_disable(struct ufs_hba *hba) {
> > > > > +       if (!ufshcd_is_auto_hibern8_supported(hba))
> > > > > +               return;
> > > > > +
> > > > > +       ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER); }
> > > > > +
> > > > >  void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)  {
> > > > >         if (!ufshcd_is_auto_hibern8_supported(hba))
> > > > > @@ -9036,6 +9044,8 @@ static int __ufshcd_wl_suspend(struct
> > ufs_hba
> > > > > *hba, enum ufs_pm_op pm_op)
> > > > >         if (ret)
> > > > >                 goto enable_scaling;
> > > > >
> > > > > +       ufshcd_auto_hibern8_disable(hba);
> > > > > +
> > > > >         if (req_dev_pwr_mode !=3D hba->curr_dev_pwr_mode) {
> > > > >                 if (pm_op !=3D UFS_RUNTIME_PM)
> > > > >                         /* ensure that bkops is disabled */
> > > > > --
> > > > > 2.17.1
> > > >
