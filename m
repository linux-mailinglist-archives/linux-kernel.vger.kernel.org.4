Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599D62CD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiKPV4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiKPVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:55:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20D2ED5D;
        Wed, 16 Nov 2022 13:55:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g10so347371plo.11;
        Wed, 16 Nov 2022 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIDLUT5RMY0voR23cPJtsl+vCPEHABGwnHVFJLzi0bs=;
        b=iW1RGDYvEosrQZqIxZ8vDVjj5TotkwnuzG5V1Ip8RGTJnKV4w0pi2BsqQjVoIDpV8S
         nb5LP+/j2c9iL7kf3fKMMTeH5ShL41RfekdTFWF8FRWD6xSH9/SQYY5O+XbwzOPgkDCw
         gmVdUgYrd9CK0MH4ex1y7Sn9pXILbDxuLPvicJ3qWalNbzOKBWF9YupXG76sv9GBYRM/
         3fO0ehFmCT3FBKJMWOWY8HVW0qRwbzFW7pmXJTvBNn6TtHsWpUeCYIULgiXRXVPdijk0
         zyyS6ZQOS9u951u7dSH62emjuBocRBpcILr5PfVqqnyieAaOtMDZJnk9TxiwZc25jfrP
         Y0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIDLUT5RMY0voR23cPJtsl+vCPEHABGwnHVFJLzi0bs=;
        b=azFPCvaCOXMLd2y8N1oQEb13wtX6vjTgvNpASOz7dtDy2WsQlbTJ8hA9/9DznrNT/P
         1VlB8DHG2rUPSCkNo2W3iEwBJi6UkxuqpnILWvwFEJYp+FfjHqrb7sqreFJ1t0BOvijX
         u0fcg14/eSjLWMBKrgAYTEoBOw6ZibJEyXHSDx+Ka5VDfMV/YX3Aby3DHNJk/QegerBT
         xEF+XxUgMUHycBXkUWoqeRY8tkT93KCBrPiJb8lo/DeXEkvbKpjpnbZtsVn9oUPxbAkN
         BR6nCfyqfuDUkig1CDt2/H/ffgMNtn/x3iqP00SnvA3rzobjLUN0vfO0joa2emOkBWmB
         eDfA==
X-Gm-Message-State: ANoB5pmYE1EtimBJEHVfa3+MFYW2kHYNmJAuoJPi5xaJfWyZlQT5/LMC
        tpaTSYkjYNdIyOBINpsCcjjNq1JSqBuLT3taAW4=
X-Google-Smtp-Source: AA0mqf45I9pyHHqJAuZUKQyq2e2h3M2ml60xpjwsVYhCAmk87JYlXInBvyos//lq1BNj1JEnof8M/bmBkbJE4yd6L2Q=
X-Received: by 2002:a17:902:7583:b0:188:d6c7:e7b7 with SMTP id
 j3-20020a170902758300b00188d6c7e7b7mr8992183pll.16.1668635751046; Wed, 16 Nov
 2022 13:55:51 -0800 (PST)
MIME-Version: 1.0
References: <yq15zo86nvk.fsf@oracle.com> <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com> <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
 <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com> <CADvTj4rd+Z8S8vwnsmn2a7BXDPBwx1iqWRmE+SbtWep=Lnr20g@mail.gmail.com>
 <BYAPR11MB36066925274C38555F20FB17FA339@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4qH5xuK9ecEPi3Pm9t962E=nnH0oTBqWv4UPmibeASqdQ@mail.gmail.com> <BYAPR11MB36065EE0321C0AE6A4A3ECC7FA049@BYAPR11MB3606.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB36065EE0321C0AE6A4A3ECC7FA049@BYAPR11MB3606.namprd11.prod.outlook.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 16 Nov 2022 17:55:39 -0400
Message-ID: <CADvTj4oej_E3tHm6tzOAhA=n2WughvDfQsaxKbP5Sxb+CeZu=w@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
To:     Sagar.Biradar@microchip.com
Cc:     martin.petersen@oracle.com, khorenko@virtuozzo.com,
        christian@grossegger.com, aacraid@microsemi.com,
        Don.Brace@microchip.com, Tom.White@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 15, 2022 at 10:05 AM <Sagar.Biradar@microchip.com> wrote:
>
> Hi James,
> I have looked into the patch thoroughly.
> We suspect this change might expose an old legacy interrupt issue on some=
 processors.

I did see this error once with this patch when a drive was having issues:
[ 4306.357531] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 4335.030025] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 4335.030111] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 4335.030172] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 4335.189886] aacraid: Host bus reset request. SCSI hang ?
[ 4335.189951] aacraid 0000:81:00.0: outstanding cmd: midlevel-0
[ 4335.189989] aacraid 0000:81:00.0: outstanding cmd: lowlevel-0
[ 4335.190101] aacraid 0000:81:00.0: outstanding cmd: error handler-3
[ 4335.190141] aacraid 0000:81:00.0: outstanding cmd: firmware-0
[ 4335.190177] aacraid 0000:81:00.0: outstanding cmd: kernel-0
[ 4335.274070] aacraid 0000:81:00.0: Controller reset type is 3
[ 4335.274142] aacraid 0000:81:00.0: Issuing IOP reset
[ 4365.862127] aacraid 0000:81:00.0: IOP reset succeeded
[ 4365.895079] aacraid: Comm Interface type2 enabled
[ 4374.938119] aacraid 0000:81:00.0: Scheduling bus rescan
[ 4387.022913] sd 0:1:41:0: [sdi] 27344764928 512-byte logical blocks:
(14.0 TB/12.7 TiB)
[ 4387.022988] sd 0:1:41:0: [sdi] 4096-byte physical blocks
[ 5643.714301] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 5672.349423] BUG: kernel NULL pointer dereference, address: 0000000000000=
018
[ 5672.351532] #PF: supervisor read access in kernel mode
[ 5672.353262] #PF: error_code(0x0000) - not-present page
[ 5672.354860] PGD 8000007ad6ac7067 P4D 8000007ad6ac7067 PUD 7af0892067 PMD=
 0
[ 5672.356444] Oops: 0000 [#1] SMP PTI
[ 5672.358075] CPU: 9 PID: 644201 Comm: cc1plus Tainted: P           O
     5.15.64-1-pve #1
[ 5672.359749] Hardware name: Supermicro Super Server/X10DRC, BIOS 3.4
05/21/2021
[ 5672.361465] RIP: 0010:dma_direct_unmap_sg+0x49/0x1a0
[ 5672.363223] Code: ec 20 89 4d d4 4c 89 45 c8 85 d2 0f 8e bb 00 00
00 49 89 fe 49 89 f7 89 d3 45 31 ed 4c 8b 05 ae fd b0 01 49 8b be 60
02 00 00 <45> 8b 4f 18 49 8b 77 10 49 f7 d0 48 85 ff 0f 84 06 01 00 00
4c 8b
[ 5672.367024] RSP: 0000:ffffa4ff58c7cde0 EFLAGS: 00010046
[ 5672.369020] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00001
[ 5672.371073] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 5672.373007] RBP: ffffa4ff58c7ce28 R08: 0000000000000000 R09: 00000000000=
00001
[ 5672.374795] R10: 0000000000000000 R11: ffffa4ff58c7cff8 R12: 00000000000=
00000
[ 5672.376418] R13: 0000000000000000 R14: ffff88968e1ec0d0 R15: 00000000000=
00000
[ 5672.378136] FS:  00007ff103d25ac0(0000) GS:ffff89547fac0000(0000)
knlGS:0000000000000000
[ 5672.379760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5672.381402] CR2: 0000000000000018 CR3: 0000007ae90cc004 CR4: 00000000001=
706e0
[ 5672.383023] Call Trace:
[ 5672.384673]  <IRQ>
[ 5672.386282]  ? task_tick_fair+0x88/0x530
[ 5672.386469] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 5672.387921]  dma_unmap_sg_attrs+0x32/0x50
[ 5672.391431] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 5672.393273]  scsi_dma_unmap+0x3b/0x50
[ 5672.397079] aacraid: Host adapter abort request.
               aacraid: Outstanding commands on (0,1,41,0):
[ 5672.398180]  aac_srb_callback+0x88/0x3c0 [aacraid]

Does that look related?

>
> We are currently debugging and digging further details to be able to expl=
ain it in much detailed fashion.
> I will keep you the thread posted as soon as we have something interestin=
g.
>
> Sagar
>
> -----Original Message-----
> From: James Hilliard <james.hilliard1@gmail.com>
> Sent: Monday, November 14, 2022 12:13 AM
> To: Sagar Biradar - C34249 <Sagar.Biradar@microchip.com>
> Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com; christian@grosseg=
ger.com; aacraid@microsemi.com; Don Brace - C33706 <Don.Brace@microchip.com=
>; Tom White - C33503 <Tom.White@microchip.com>; linux-scsi@vger.kernel.org=
; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly=
 resets under high io load
>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>
> On Thu, Oct 27, 2022 at 1:17 PM <Sagar.Biradar@microchip.com> wrote:
> >
> > Hi James and Konstantin,
> >
> > *Limiting the audience to avoid spamming*
> >
> > Sorry for delayed response as I was on vacation.
> > This one got missed somehow as someone else was looking into this and i=
s no longer with the company.
> >
> > I will look into this, meanwhile I wanted to check if you (or someone e=
lse you know) had a chance to test this thoroughly with the latest kernel?
> > I will get back to you with some more questions or the confirmation in =
a day or two max.
>
> Did this ever get looked at?
>
> As this exact patch was merged into the vendor aacraid a while ago I'm no=
t sure why it wouldn't be good to merge to mainline as well.
>
> Vendor aacraid release with this patch merged:
> https://download.adaptec.com/raid/aac/linux/aacraid-linux-src-1.2.1-60001=
.tgz
>
> >
> >
> > Thanks for your patience.
> > Sagar
> >
> >
> > -----Original Message-----
> > From: James Hilliard <james.hilliard1@gmail.com>
> > Sent: Thursday, October 27, 2022 1:40 AM
> > To: Martin K. Petersen <martin.petersen@oracle.com>
> > Cc: Konstantin Khorenko <khorenko@virtuozzo.com>; Christian Gro=C3=9Feg=
ger
> > <christian@grossegger.com>; linux-scsi@vger.kernel.org; Adaptec OEM
> > Raid Solutions <aacraid@microsemi.com>; Sagar Biradar - C34249
> > <Sagar.Biradar@microchip.com>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Don Brace - C33706
> > <Don.Brace@microchip.com>
> > Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405
> > constantly resets under high io load
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > On Wed, Oct 19, 2022 at 2:03 PM Konstantin Khorenko <khorenko@virtuozzo=
.com> wrote:
> > >
> > > On 10.10.2022 14:31, James Hilliard wrote:
> > > > On Tue, Feb 22, 2022 at 10:41 PM Martin K. Petersen
> > > > <martin.petersen@oracle.com> wrote:
> > > >>
> > > >>
> > > >> Christian,
> > > >>
> > > >>> The faulty patch (Commit: 395e5df79a9588abf) from 2017 should be
> > > >>> repaired with Konstantin Khorenko (1):
> > > >>>
> > > >>>    scsi: aacraid: resurrect correct arc ctrl checks for Series-6
> > > >>
> > > >> It would be great to get this patch resubmitted by Konstantin and
> > > >> acked by Microchip.
> >
> > Can we merge this as is since microchip does not appear to be maintaini=
ng this driver any more or responding?
> >
> > > >
> > > > Does the patch need to be rebased?
> > >
> > > James, i have just checked - the old patch (v3) applies cleanly onto =
latest master branch.
> > >
> > > > Based on this it looks like someone at microchip may have already r=
eviewed:
> > > > v3 changes:
> > > >   * introduced another wrapper to check for devices except for Seri=
es 6
> > > >     controllers upon request from Sagar Biradar (Microchip)
> > >
> > > Well, back in the year 2019 i've created a bug in RedHat bugzilla
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1724077
> > > (the bug is private, this is default for Redhat bugs)
> > >
> > > In this bug Sagar Biradar (with the email @microchip.com) suggested
> > > me to rework the patch - i've done that and sent the v3.
> > >
> > > And nothing happened after that, but in a ~year (2020-06-19) the bug
> > > was closed with the resolution NOTABUG and a comment that S6 users wi=
ll find the patch useful.
> > >
> > > i suppose S6 is so old that RedHat just does not have customers
> > > using it and Microchip company itself is also not that interested in =
handling so old hardware issues.
> > >
> > > Sorry, i was unable to get a final ack from Microchip, i've written
> > > direct emails to the addresses which is found in the internet, tried
> > > to connect via linkedin, no luck.
> > >
> > > --
> > > Konstantin Khorenko
