Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57D5FB1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJKLxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJKLxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:53:14 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2F7F244;
        Tue, 11 Oct 2022 04:53:13 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id v81so1958034vkv.5;
        Tue, 11 Oct 2022 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ2zVHMyPDDLeUBpSc6X3pmNAkcn6FVd6l1YgBoTZJ0=;
        b=UX/sNRAB6j9gx6O7gQnV+jKQTkc5roHcuF2PetsiXVDAbDBoAajtWpiLY0sfVEch2A
         109KhX0REWxA9xoJnAw4uKtEY5EcM5T/DGU85ZU9JunVrzlEeb+/MrzWzz/LiboaU7GH
         QlrADeBu4c6jwcWLyATle8sFmQr7TpxfD2Kh9K5MsDBSOB8nc5oE8PPdnMMgoL86WtXT
         12gVewiGsppK7hB9qmeDSqX8emxZlqcMR7eS52Fk3Phdax5R7bpDGwn8xJY7VfWt2vrX
         ukGbe2YSOnBDY/plj2eG2rOH6rV4eWOcAWJivv8LX8GlnRHPvsD4BPI3Tme+0wvk05zF
         TKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ2zVHMyPDDLeUBpSc6X3pmNAkcn6FVd6l1YgBoTZJ0=;
        b=HFoSV+Q2sxCqasxnB8K+ZjayXLbybUwavJJKLPYEh/46LjdIMYZqu81ABEMUevNuo1
         oZJOuM5JohwKJctEp4iHcGp99lxBEtqmrnZ3DTQ84atLi9k5n6oZ4Z3F/67fVptYe/fH
         LtS8cFLqJrIj+CReEGdRJIEoqV+igrhHHNGbA/84ecBhARE/oFZQHIP2hQutK8keIWHO
         veRKCvKMFUoGEmlHeC/zz1xZ+Cch2H9oWqitn7MgIlIaRa+bXLQ6j4yfvBYr+Q09WVy6
         o+j9a8rw6YXnzMtXaFwYoMY2/ccmgxxMHn47mZ2M6mtQ3DWkdZUYCj6c3KEzN3cJgMmH
         Ghkw==
X-Gm-Message-State: ACrzQf0q3TB5xfwBco8TzJF1+H1W3xSnWtpSGDcwUeaMjtDxK+JhTzDE
        DhwgHLKxOHf+EkOYNlSho1pwRtIyNxvQs5mQOUM=
X-Google-Smtp-Source: AMsMyM4w3iqeyvjZqwT+AW9YB36By6WV2CFThUBOcx5ZLloMvd0RfxwgCr/4ccGkbjp2IF+Tl3T35vfi79MwKNi4TJM=
X-Received: by 2002:a1f:9b10:0:b0:3ab:4058:32e7 with SMTP id
 d16-20020a1f9b10000000b003ab405832e7mr11571981vke.15.1665489192087; Tue, 11
 Oct 2022 04:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com> <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   =?UTF-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>
Date:   Tue, 11 Oct 2022 19:53:01 +0800
Message-ID: <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
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
  Unisoc reports resume fail on UFS(micron FS164) during suspend/resume tes=
t.
  We check host inserts auto H8 enter/exit event between SSU sleep
command and H8 enter command in runtime suspend .
  Asfollows: SSU Sleep command --> auto H8 enter --> auto H8 exit -->
H8 enter --> idle 2ms --> VCC off.
  However device AQL FW can=E2=80=99t enter LPM within 2ms after second H8
enter command.
  FW already enter LPM after receive auto H8 enter command , Next auto
H8 exit command will trigger FW exit from LPM, it need take over 10ms,
and FW can=E2=80=99t enter
  LPM again after second H8 enter command until device complete exit
from LPM. So disable auto h8 before ssu is a reasonable solution to
solve it.
  Hynix also has similar request.

Avri Altman <Avri.Altman@wdc.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:07=E5=86=99=E9=81=93=EF=BC=9A
>
> > From: Ten Gao <ten.gao@unisoc.com>
> >
> > Ensure auto h8 will not hit dme h8,and there won't be two h8 in a row a=
fter
> > ssu.
> I don't think the hw should do that.
> Can you please share on which platform/host controller did you observe th=
is?
>
> Thanks,
> Avri
> >
> > Signed-off-by: Ten Gao <ten.gao@unisoc.com>
> > ---
> >  drivers/ufs/core/ufshcd.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c inde=
x
> > a202d7d5240d..42f93648d796 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -4256,6 +4256,14 @@ void ufshcd_auto_hibern8_update(struct ufs_hba
> > *hba, u32 ahit)  }  EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
> >
> > +void ufshcd_auto_hibern8_disable(struct ufs_hba *hba) {
> > +       if (!ufshcd_is_auto_hibern8_supported(hba))
> > +               return;
> > +
> > +       ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER); }
> > +
> >  void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)  {
> >         if (!ufshcd_is_auto_hibern8_supported(hba))
> > @@ -9036,6 +9044,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba
> > *hba, enum ufs_pm_op pm_op)
> >         if (ret)
> >                 goto enable_scaling;
> >
> > +       ufshcd_auto_hibern8_disable(hba);
> > +
> >         if (req_dev_pwr_mode !=3D hba->curr_dev_pwr_mode) {
> >                 if (pm_op !=3D UFS_RUNTIME_PM)
> >                         /* ensure that bkops is disabled */
> > --
> > 2.17.1
>
