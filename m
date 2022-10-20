Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23D6056AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJTFP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJTFPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:15:22 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BDAA2AAD;
        Wed, 19 Oct 2022 22:15:20 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id n63so131510vsc.8;
        Wed, 19 Oct 2022 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdG+ouZ9mtQkIdf4wHomoStwFFAJkNb2nocVArRayto=;
        b=qcr0zMjKq3TOa3Pa8KBFhWaFdI4kIGIo3H4i9h1VOh6DkXWXvPRidfiZwbNgy2YcwU
         zvYzEsYm6VyQUEyZXlY0ANcs4VmRGa08jsQh/Pdj5aeKrIc+Up/27YkQqaMco3BppiXV
         sCx2ZFHlC3jjVS2Aj1yeYllAxr35/n9Px+fkYlhMPQfvVD4IkkPaUpIXTJNZ1GvFd8Bs
         hTJo742KS+C2BRzQZIduAZYr/2IPeeWe33Qb2FfXXislrjkXx+m3YG+e39+G8lpUuymf
         fucfDDgBtBs8AH0hFYDIzo/e4inbexX3/9to29l0yTtpaEj8uYOrd/DpsMVQHL81zS9i
         TYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdG+ouZ9mtQkIdf4wHomoStwFFAJkNb2nocVArRayto=;
        b=T57W8No4yg0I7VmCY558ipfxG61XKvFyDMx3QewGN3dkvtBySHWmiUAANGDE8XI0vn
         n+fBLU8hUEshaNEf81c75oK/bBxX+GDPWcKW31uVEG5Tn/pzBnTyQ7c4wh3z707CRt7j
         swAPq6xIvMZQ3Y7AzIvNCT75GQES43WI1LL+HYV4hFrWDhhztk5OHAeAvf/LRaAemYGS
         VHYWwR+8z005XH7V+rk7ijOMvYAbVteEpvWr+cVvMz/h91GmG+ql+0JBoNx9rF6tqLlj
         50LUd6lcm34hGcvOWDt87H0PkdtWOu30qopyKHy2BzExWL0B361oWv7SLoa2zrpHVNQ1
         8owQ==
X-Gm-Message-State: ACrzQf0ckrb5nsXzEOn+ykPr3r5vb083iGqCrJBX503rXLRP2lYboGR3
        xz5WT6dwn4m+TDA8xUn9o7Sa40ii0FK6aG8OTAA=
X-Google-Smtp-Source: AMsMyM4kBXwe7Pz4GdlrpkzlBWPfvfXtoQ8udCX9lfGy33wGyMNCLOEIlDKT7YviXHxdyz9ACHbc6ge/oFrwYkneBaY=
X-Received: by 2002:a05:6102:25b:b0:3a7:65fe:899f with SMTP id
 a27-20020a056102025b00b003a765fe899fmr5339724vsq.12.1666242919733; Wed, 19
 Oct 2022 22:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
 <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
 <bee1807b7d072b221c44ac8c2ed8064939d33696.camel@gmail.com>
 <CAFN68yVdwrECaDvNuok_4V-54UZUJU9+dn5icaiPdj6BXEZuVA@mail.gmail.com>
 <8678f69aa94003b357c4c8ef42cd6ce5c7487f8d.camel@gmail.com> <CAFN68yUKXquOLqL_6oBRjfDGDT=NgQPF3cpo7bkHyJ1gNTDbZA@mail.gmail.com>
In-Reply-To: <CAFN68yUKXquOLqL_6oBRjfDGDT=NgQPF3cpo7bkHyJ1gNTDbZA@mail.gmail.com>
From:   =?UTF-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>
Date:   Thu, 20 Oct 2022 13:15:08 +0800
Message-ID: <CAFN68yVLdwrJBivqjGfGd7qiGp_h8FwucBLvSH97wNiyik4nQw@mail.gmail.com>
Subject: Re: [PATCH] ufs: core: Disable auto h8 before ssu
To:     Bean Huo <huobean@gmail.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
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

Dear ALL
Do you agree this patch? I'd like to hear your opinion about this.

Thanks.

=E9=AB=98=E4=B8=A5=E5=87=AF <gaoyankaigeren@gmail.com> =E4=BA=8E2022=E5=B9=
=B410=E6=9C=8814=E6=97=A5=E5=91=A8=E4=BA=94 18:15=E5=86=99=E9=81=93=EF=BC=
=9A
>
> hi Bean
> Yes, This is the time from when the system enters idle to when auto h8
> is issued.
> This patch is just to ensure that there is no continuous action of
> "auto h8 exit" before dme h8 enter, it has nothing to do with idle
> time.
> The reason I want to ensure this order is because when there is an
> action of "auto h8 exit", most devices take a certain amount of time
> to get the state ready.
> Immediately after the action of "auto h8 exit" is completed and "dme
> h8 enter" is followed, the device will be abnormal.
> And I think it's more of a common patch for all platforms, Patch can
> adapt different vendors,and align to ufshcd_auto_hibern8_enable in
> __ufshcd_wl_resume.
>
> Bean Huo <huobean@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=94 13:48=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, 2022-10-14 at 10:44 +0800, =E9=AB=98=E4=B8=A5=E5=87=AF wrote:
> > > " UFSHCI has idle time before bringing Link into hibern8 mode, " I
> > > think  ufs put the link to h8 during the time
> >
> >
> > no,  it is ufs controller. see the ufshci spec:
> >
> > "Auto-Hibern8 Idle Timer Value (AH8ITV): This is the timer that UFS
> > subsystem must be idle before UFS host *controller* may put UniPro link
> > into Hibernate state autonomously. The idle timer value is multiplied
> > by the indicated timer scale to yield an absolute timer value. ....
> >
> > ...
> > Any non-zero value will enable Auto-Hibernate idle timer.
> > UFS host controller shall put Unipro link out of Hibernate state when
> > the link communication is required. The mechanism to decide when the
> > Unipro link needs to become active is host controller specific
> > implementation, and is transparent to the software."
> >
> >
