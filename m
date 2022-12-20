Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA513651790
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiLTBMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLTBMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:12:22 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F311C15;
        Mon, 19 Dec 2022 17:12:21 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so13791434fac.2;
        Mon, 19 Dec 2022 17:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lq/bPpBCckHEaeP84YP3OrcTYEbg/cWVNuiIRlyVbI=;
        b=g/O1s/D3tvfBRYJ2Wye5c7f4XYfv166pE5fioZRzYwubTPG08SMDxO9oT+zx1BhPA8
         lFncyyszK60VnZE52h+uHVCtQPFTWlPOg94FQKxJbC72YCK3qmBBobeGBmtRzLiM1WgX
         0PwQfekubVdARZjxKOcoQW4G6aI8PnFFbGfC+0MedoMmfrm6qw3uRcBfVedwDrGixALg
         E6eM5CWlNr46zzFAOD5l0UrLtH0TsGEysVOGh5cpWWq3v8UuwLOxG6UJAc/bhHTMJlcd
         uB9LzRI7A0mL+7xC7sdEypX+Dxvlfh79iVRjQr/ktQa4N/HVX7dbnDo96J+nUbRkrPy7
         qiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lq/bPpBCckHEaeP84YP3OrcTYEbg/cWVNuiIRlyVbI=;
        b=iMO4vYlk+A2TNNm12byynqGyD1JK5OEPVWoGNfq5pEAshh4Qx7UMmxjtuHFN9+afjm
         U00SNYwtKkiLtks8PjZnylpqPO96BFiqaLp7/tL/YBqsZ0MYvmC7H1/VPdZprnIeTyI7
         Xq0D0y0nrrCxmJ6urJo8Xge/Q6tGJxnNupsQW0dW/K4KzwFhR1UgjzD5tqhQZVyMTG6D
         /Zmb5I+UNy1Z3WanBLAaOOvU/y+ZB9k951Sp5cY9w6vYpTjQQogWLce2hloZ6kRhfN4y
         xuGYJpXQiPSsSORlLfvjyXXtFgwcnl2pqkbZwEBNN688UN+7XmAPgAAk/z/DjESNQl8E
         wp4A==
X-Gm-Message-State: AFqh2kp2gZWnUPv5z+MOFH8Dl95Fjy2sThGjkl+o2Cz7fdMUuT2llYOb
        +A9cofzmJmze4q/9ihkpZedzyhVaMNm2P/bKDZjvZcg5hIuorg==
X-Google-Smtp-Source: AMrXdXvuRgQtXAwjFfk9/mnVgfNiZbzBjawi/L0Sh5W9B5ZhAw+IwM6N3XmCJ6TQWIH2gIxMrpv4G0xHb1Sb/sUHNeU=
X-Received: by 2002:a05:6870:9e43:b0:144:9744:2be3 with SMTP id
 pt3-20020a0568709e4300b0014497442be3mr998112oab.93.1671498740519; Mon, 19 Dec
 2022 17:12:20 -0800 (PST)
MIME-Version: 1.0
References: <yq15zo86nvk.fsf@oracle.com> <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com> <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
 <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com> <CADvTj4rd+Z8S8vwnsmn2a7BXDPBwx1iqWRmE+SbtWep=Lnr20g@mail.gmail.com>
 <BYAPR11MB36066925274C38555F20FB17FA339@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4qH5xuK9ecEPi3Pm9t962E=nnH0oTBqWv4UPmibeASqdQ@mail.gmail.com>
 <BYAPR11MB36065EE0321C0AE6A4A3ECC7FA049@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4oej_E3tHm6tzOAhA=n2WughvDfQsaxKbP5Sxb+CeZu=w@mail.gmail.com>
 <BYAPR11MB360625E5945D5D3B29571857FA099@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4oNCrwHBRu-rUZtnxoqVkvyxG_Cg07RTAuwpNsGfjWKcw@mail.gmail.com>
 <BYAPR11MB3606FB1E651EC9B51BD8A0B7FA1B9@BYAPR11MB3606.namprd11.prod.outlook.com>
 <BYAPR11MB3606E15393A4C11CCFAF9C53FAE69@BYAPR11MB3606.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3606E15393A4C11CCFAF9C53FAE69@BYAPR11MB3606.namprd11.prod.outlook.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 19 Dec 2022 18:12:09 -0700
Message-ID: <CADvTj4qJZH5PoFJRKVF9zfQZAG-GOt2QHC7fDGiLPzo+iOX0cw@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
To:     Sagar.Biradar@microchip.com
Cc:     martin.petersen@oracle.com, khorenko@virtuozzo.com,
        christian@grossegger.com, aacraid@microsemi.com,
        Don.Brace@microchip.com, Tom.White@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilbert.Wu@microchip.com
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

On Fri, Dec 16, 2022 at 1:44 PM <Sagar.Biradar@microchip.com> wrote:
>
> Hi James / Konstantin,
> Here are the details that we have compiled so far . .
> I will just repost the problem definition and the concerns discussed so f=
ar (to avoid back and forth)...
>
> Issue : Series 6 Patch [regression] aacraid: Host adapter constantly abor=
ts under load (https://bugzilla.redhat.com/show_bug.cgi?id=3D1724077)
>
> Synopsis: running mkfs.ext4 on different disks on the same controller in =
parallel. (Nothing seems to break, appears to always recover, but there are=
 a lot of timeouts.)
> [  699.442950] aacraid: Host adapter reset request. SCSI hang ?
> [  759.515013] aacraid 0000:03:00.0: Issuing IOP reset
> [  850.296705] aacraid 0000:03:00.0: IOP reset succeeded
> * with kernel 3.10.0-862.20.2.el7.x86_64 - PASS
> * with kernel 3.10.0-957.21.3.el7.x86_64 - FAIL
>
> Konstantin=E2=80=99s patch (https://lkml.org/lkml/2019/8/19/758) : upon t=
esting the patch on the Virtuozzo kernel, it was found to be working fine, =
and the same issue was observed on Ubuntu later.
> But MCHP knows this patch/change will have issues with Xeon V2 interrupts=
, adding this change into the tree can harm the customers who use this proc=
essor. (CPU Intel Xeon E5-2609/2630/2650 v2 ( E5-26XX V2))
> However, the patch may work fine on Xeon V3/V4 and later processors.
>
> Adaptec ASK Article references our concern : https://ask.adaptec.com/app/=
answers/detail/a_id/17400/kw/msi
> Though the article lists appears like a "VMware" specific - the issue is =
independent of the Operating system.
> We have discovered a conflict between the Series 6 and 6E RAID controller=
s, VMware ESXi 5.5 and Intel Xeon V2 processors that is caused by incorrect=
 interrupt handling.
> The system is using the legacy interrupt handling but needs to be switche=
d to MSI (Message Signaled Interrupts) instead.
> This issue caused by switching to the legacy mode occurs on CPU Intel Xeo=
n E5-2609/2630/2650 v2 ( E5-26XX V2).
> * Note: Xeon V2 is =E2=80=9CIvy Bridge=E2=80=9D
>
> Workaround: The proposed solution would be to let the driver use the MSI =
mechanism with the aacraid driver parameter "msi" set to 1 (=E2=80=9Cmsi=3D=
1") .  ("echo 1 > /sys/module/aacraid/parameters/msi")

Hmm, so this commit indicates that series 6 raid cards should be always usi=
ng
MSI interrupts regardless of that msi param:
https://github.com/torvalds/linux/commit/9022d375bd22869ba3e5ad3635f00427cf=
b934fc

However it appears that the aac_msi check wasn't removed here, maybe it
should have been?:
https://github.com/torvalds/linux/blob/v6.1/drivers/scsi/aacraid/rx.c#L647

>
> Konstantin,
> Is it possible for you or someone you know to test on your original test =
bed with the "msi" set to "1", and post the results?
> We are parallelly working on additional tests locally.
> Please write to me if you need more information
>
>
> Thanks in advance
> Sagar
>
>
> -----Original Message-----
> From: Sagar.Biradar@microchip.com <Sagar.Biradar@microchip.com>
> Sent: Tuesday, December 6, 2022 11:30 AM
> To: james.hilliard1@gmail.com
> Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com; christian@grosseg=
ger.com; aacraid@microsemi.com; Don Brace - C33706 <Don.Brace@microchip.com=
>; Tom White - C33503 <Tom.White@microchip.com>; linux-scsi@vger.kernel.org=
; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly=
 resets under high io load
>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>
> Hi James,
> We were in the process of finding the related information and we have fin=
ally found some details.
> I am reviewing that as I write this email.
> I will get back to you once I review and sort that information with more =
details.
>
> Thanks
> Sagar
>
> -----Original Message-----
> From: James Hilliard <james.hilliard1@gmail.com>
> Sent: Sunday, December 4, 2022 5:26 AM
> To: Sagar Biradar - C34249 <Sagar.Biradar@microchip.com>
> Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com; christian@grosseg=
ger.com; aacraid@microsemi.com; Don Brace - C33706 <Don.Brace@microchip.com=
>; Tom White - C33503 <Tom.White@microchip.com>; linux-scsi@vger.kernel.org=
; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly=
 resets under high io load
>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>
> On Thu, Nov 17, 2022 at 11:36 PM <Sagar.Biradar@microchip.com> wrote:
> >
> > Hi James,
> > Thanks for your response.
> > This issue seems to be slightly different and may have been originating=
 from the drive itself (not too sure).
>
> Yeah, the drive was having hardware issues, although it does sound like a=
 potential error condition that's not being correctly handled by aacraid.
>
> >
> > The original issue I was talking about would still occur with the missi=
ng legacy interrupt on certain processors.
> > We are still actively looking into the old "int-x missing" issue that w=
e suspect might possibly originate from the patch.
>
> Hmm, are there any available details on this "int-x missing" issue, I cou=
ldn't find any public details/reports relating to that.
>
> Is there a list of CPU's known to be affected?
>
> Does it occur in the vendor aacraid release that has this patch merged?
>
> >
> >
> >
> > -----Original Message-----
> > From: James Hilliard <james.hilliard1@gmail.com>
> > Sent: Thursday, November 17, 2022 3:26 AM
> > To: Sagar Biradar - C34249 <Sagar.Biradar@microchip.com>
> > Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com;
> > christian@grossegger.com; aacraid@microsemi.com; Don Brace - C33706
> > <Don.Brace@microchip.com>; Tom White - C33503
> > <Tom.White@microchip.com>; linux-scsi@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405
> > constantly resets under high io load
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > On Tue, Nov 15, 2022 at 10:05 AM <Sagar.Biradar@microchip.com> wrote:
> > >
> > > Hi James,
> > > I have looked into the patch thoroughly.
> > > We suspect this change might expose an old legacy interrupt issue on =
some processors.
> >
> > I did see this error once with this patch when a drive was having issue=
s:
> > [ 4306.357531] aacraid: Host adapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 4335.030025] aacraid: Host adapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 4335.030111] aacraid: Host adapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 4335.030172] aacraid: Host adapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 4335.189886] aacraid: Host bus reset request. SCSI hang ?
> > [ 4335.189951] aacraid 0000:81:00.0: outstanding cmd: midlevel-0 [ 4335=
.189989] aacraid 0000:81:00.0: outstanding cmd: lowlevel-0 [ 4335.190101] a=
acraid 0000:81:00.0: outstanding cmd: error handler-3 [ 4335.190141] aacrai=
d 0000:81:00.0: outstanding cmd: firmware-0 [ 4335.190177] aacraid 0000:81:=
00.0: outstanding cmd: kernel-0 [ 4335.274070] aacraid 0000:81:00.0: Contro=
ller reset type is 3 [ 4335.274142] aacraid 0000:81:00.0: Issuing IOP reset=
 [ 4365.862127] aacraid 0000:81:00.0: IOP reset succeeded [ 4365.895079] aa=
craid: Comm Interface type2 enabled [ 4374.938119] aacraid 0000:81:00.0: Sc=
heduling bus rescan [ 4387.022913] sd 0:1:41:0: [sdi] 27344764928 512-byte =
logical blocks:
> > (14.0 TB/12.7 TiB)
> > [ 4387.022988] sd 0:1:41:0: [sdi] 4096-byte physical blocks [ 5643.7143=
01] aacraid: Host adapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 5672.349423] BUG: kernel NULL pointer dereference, address: 000000000=
0000018 [ 5672.351532] #PF: supervisor read access in kernel mode [ 5672.35=
3262] #PF: error_code(0x0000) - not-present page [ 5672.354860] PGD 8000007=
ad6ac7067 P4D 8000007ad6ac7067 PUD 7af0892067 PMD 0 [ 5672.356444] Oops: 00=
00 [#1] SMP PTI
> > [ 5672.358075] CPU: 9 PID: 644201 Comm: cc1plus Tainted: P           O
> >      5.15.64-1-pve #1
> > [ 5672.359749] Hardware name: Supermicro Super Server/X10DRC, BIOS 3.4
> > 05/21/2021
> > [ 5672.361465] RIP: 0010:dma_direct_unmap_sg+0x49/0x1a0
> > [ 5672.363223] Code: ec 20 89 4d d4 4c 89 45 c8 85 d2 0f 8e bb 00 00
> > 00 49 89 fe 49 89 f7 89 d3 45 31 ed 4c 8b 05 ae fd b0 01 49 8b be 60
> > 02 00 00 <45> 8b 4f 18 49 8b 77 10 49 f7 d0 48 85 ff 0f 84 06 01 00 00
> > 4c 8b [ 5672.367024] RSP: 0000:ffffa4ff58c7cde0 EFLAGS: 00010046 [
> > 5672.369020] RAX: 0000000000000000 RBX: 0000000000000003 RCX:
> > 0000000000000001 [ 5672.371073] RDX: 0000000000000003 RSI:
> > 0000000000000000 RDI: 0000000000000000 [ 5672.373007] RBP:
> > ffffa4ff58c7ce28 R08: 0000000000000000 R09: 0000000000000001 [
> > 5672.374795] R10: 0000000000000000 R11: ffffa4ff58c7cff8 R12:
> > 0000000000000000 [ 5672.376418] R13: 0000000000000000 R14:
> > ffff88968e1ec0d0 R15: 0000000000000000 [ 5672.378136] FS:
> > 00007ff103d25ac0(0000) GS:ffff89547fac0000(0000)
> > knlGS:0000000000000000
> > [ 5672.379760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5672=
.381402] CR2: 0000000000000018 CR3: 0000007ae90cc004 CR4: 00000000001706e0 =
[ 5672.383023] Call Trace:
> > [ 5672.384673]  <IRQ>
> > [ 5672.386282]  ? task_tick_fair+0x88/0x530 [ 5672.386469] aacraid: Hos=
t adapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 5672.387921]  dma_unmap_sg_attrs+0x32/0x50 [ 5672.391431] aacraid: Ho=
st adapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 5672.393273]  scsi_dma_unmap+0x3b/0x50 [ 5672.397079] aacraid: Host a=
dapter abort request.
> >                aacraid: Outstanding commands on (0,1,41,0):
> > [ 5672.398180]  aac_srb_callback+0x88/0x3c0 [aacraid]
> >
> > Does that look related?
> >
> > >
> > > We are currently debugging and digging further details to be able to =
explain it in much detailed fashion.
> > > I will keep you the thread posted as soon as we have something intere=
sting.
> > >
> > > Sagar
> > >
> > > -----Original Message-----
> > > From: James Hilliard <james.hilliard1@gmail.com>
> > > Sent: Monday, November 14, 2022 12:13 AM
> > > To: Sagar Biradar - C34249 <Sagar.Biradar@microchip.com>
> > > Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com;
> > > christian@grossegger.com; aacraid@microsemi.com; Don Brace - C33706
> > > <Don.Brace@microchip.com>; Tom White - C33503
> > > <Tom.White@microchip.com>; linux-scsi@vger.kernel.org; Linux Kernel
> > > Mailing List <linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405
> > > constantly resets under high io load
> > >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >
> > > On Thu, Oct 27, 2022 at 1:17 PM <Sagar.Biradar@microchip.com> wrote:
> > > >
> > > > Hi James and Konstantin,
> > > >
> > > > *Limiting the audience to avoid spamming*
> > > >
> > > > Sorry for delayed response as I was on vacation.
> > > > This one got missed somehow as someone else was looking into this a=
nd is no longer with the company.
> > > >
> > > > I will look into this, meanwhile I wanted to check if you (or someo=
ne else you know) had a chance to test this thoroughly with the latest kern=
el?
> > > > I will get back to you with some more questions or the confirmation=
 in a day or two max.
> > >
> > > Did this ever get looked at?
> > >
> > > As this exact patch was merged into the vendor aacraid a while ago I'=
m not sure why it wouldn't be good to merge to mainline as well.
> > >
> > > Vendor aacraid release with this patch merged:
> > > https://download.adaptec.com/raid/aac/linux/aacraid-linux-src-1.2.1-
> > > 60
> > > 001.tgz
> > >
> > > >
> > > >
> > > > Thanks for your patience.
> > > > Sagar
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: James Hilliard <james.hilliard1@gmail.com>
> > > > Sent: Thursday, October 27, 2022 1:40 AM
> > > > To: Martin K. Petersen <martin.petersen@oracle.com>
> > > > Cc: Konstantin Khorenko <khorenko@virtuozzo.com>; Christian
> > > > Gro=C3=9Fegger <christian@grossegger.com>; linux-scsi@vger.kernel.o=
rg;
> > > > Adaptec OEM Raid Solutions <aacraid@microsemi.com>; Sagar Biradar
> > > > -
> > > > C34249 <Sagar.Biradar@microchip.com>; Linux Kernel Mailing List
> > > > <linux-kernel@vger.kernel.org>; Don Brace - C33706
> > > > <Don.Brace@microchip.com>
> > > > Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405
> > > > constantly resets under high io load
> > > >
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > know the content is safe
> > > >
> > > > On Wed, Oct 19, 2022 at 2:03 PM Konstantin Khorenko <khorenko@virtu=
ozzo.com> wrote:
> > > > >
> > > > > On 10.10.2022 14:31, James Hilliard wrote:
> > > > > > On Tue, Feb 22, 2022 at 10:41 PM Martin K. Petersen
> > > > > > <martin.petersen@oracle.com> wrote:
> > > > > >>
> > > > > >>
> > > > > >> Christian,
> > > > > >>
> > > > > >>> The faulty patch (Commit: 395e5df79a9588abf) from 2017
> > > > > >>> should be repaired with Konstantin Khorenko (1):
> > > > > >>>
> > > > > >>>    scsi: aacraid: resurrect correct arc ctrl checks for
> > > > > >>> Series-6
> > > > > >>
> > > > > >> It would be great to get this patch resubmitted by Konstantin
> > > > > >> and acked by Microchip.
> > > >
> > > > Can we merge this as is since microchip does not appear to be maint=
aining this driver any more or responding?
> > > >
> > > > > >
> > > > > > Does the patch need to be rebased?
> > > > >
> > > > > James, i have just checked - the old patch (v3) applies cleanly o=
nto latest master branch.
> > > > >
> > > > > > Based on this it looks like someone at microchip may have alrea=
dy reviewed:
> > > > > > v3 changes:
> > > > > >   * introduced another wrapper to check for devices except for =
Series 6
> > > > > >     controllers upon request from Sagar Biradar (Microchip)
> > > > >
> > > > > Well, back in the year 2019 i've created a bug in RedHat
> > > > > bugzilla
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1724077
> > > > > (the bug is private, this is default for Redhat bugs)
> > > > >
> > > > > In this bug Sagar Biradar (with the email @microchip.com)
> > > > > suggested me to rework the patch - i've done that and sent the v3=
.
> > > > >
> > > > > And nothing happened after that, but in a ~year (2020-06-19) the
> > > > > bug was closed with the resolution NOTABUG and a comment that S6 =
users will find the patch useful.
> > > > >
> > > > > i suppose S6 is so old that RedHat just does not have customers
> > > > > using it and Microchip company itself is also not that interested=
 in handling so old hardware issues.
> > > > >
> > > > > Sorry, i was unable to get a final ack from Microchip, i've
> > > > > written direct emails to the addresses which is found in the
> > > > > internet, tried to connect via linkedin, no luck.
> > > > >
> > > > > --
> > > > > Konstantin Khorenko
