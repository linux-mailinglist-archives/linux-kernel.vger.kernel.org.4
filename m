Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74C56C73E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCWXLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCWXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:11:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ED5FF29
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:11:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 518BC3200681;
        Thu, 23 Mar 2023 19:11:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 23 Mar 2023 19:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679613087; x=1679699487; bh=2rW/87ETWD5jh
        MIHF2OdIMo1SriFDPE0qXDeXQlInQo=; b=O35dTJ5pBBwM1f2ZeAI4pnXWPcl07
        ByQH4ClCFarMEcBxNZy9zasI7rGGPDWMYpQJ5iuKrVpAeWi+uzCg4YWoyhjrmAOK
        sA0L0Zdz1wzxAzn5gQoe6/zioZKmSabHXAoGkqsHNrAFpDkWNe9kTQpCEEeH+jxu
        vT8hu5OybHgHq/FTeuDe/EYn1EDMoIEpP7SFYMJ5yyJqgojlrxiwfbvtQntDnNEO
        6wZ29ERNIBdlaeUP2Djna/cqeMp8Gh+Ue3Ar/zHIIFQY2j5v3k0Hd6vGgzdkeotN
        OA81iEJ6W9SdObThSVC2RjVJ79366r/2lxAjxBl9Vojk/WdNMFwKOi+EA==
X-ME-Sender: <xms:ntwcZIad5GPU8o9tcbTECNkzCngg3saufUWi5YJG7gkouCaoyIoZuQ>
    <xme:ntwcZDaSW6G5HKJlx4WfrSSISp0P9h20kK8RF0cLQEok5y92ySHba8RHGRc_Tsxzq
    QYyPI1GS8_N6KTxXT8>
X-ME-Received: <xmr:ntwcZC8dgo7c9rit5VqrC18aKvAgb26Cvy9o5n_sr9YkM1k2Iy9czCwPWowLBE05_QYTkKmrtgKhClrn6mjxz9TpM25NGfkTlTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeghedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:ntwcZCoT1oHwF74N4TMHcjHG6MsxKAs34pA1mVZ2c2yaeuIfQP_6RA>
    <xmx:ntwcZDqpWfA0f4NNMCFNXTxG9x0EqVTZ_VqhG_eJIFMBz7ewOInTzg>
    <xmx:ntwcZATGlbJHlf-3twiU2ObRx-LaHsSAnwbcVJmyaJBztNrsdxsLRg>
    <xmx:n9wcZMCZ6KhVxgrQtRMwh3oJW-pHGJWsEtgXwQcmTJJyFf3QtjIgAg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 19:11:24 -0400 (EDT)
Date:   Fri, 24 Mar 2023 10:13:51 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Brad Boyer <flar@allandria.com>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
In-Reply-To: <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com>
Message-ID: <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org>
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org> <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-1418837779-1679613231=:7816"
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1418837779-1679613231=:7816
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Mar 2023, Geert Uytterhoeven wrote:

> On Thu, Mar 23, 2023 at 7:02=E2=80=AFAM Finn Thain <fthain@linux-m68k.org=
> wrote:
> > Some Nubus cards have many ROM resources. A single Radius video card
> > produced well over a thousand entries under /proc/bus/nubus/. Populatin=
g
> > /proc/bus/nubus on a slow machine with several such cards installed tak=
es
> > long enough that the user may think that the system is wedged. All thos=
e
> > procfs entries also consume significant RAM though they are not normall=
y
> > needed (except by developers). Omit these resources from /proc/bus/nubu=
s/
> > by default and add a kernel parameter to enable them when needed.
> > On the test machine, this saved 300 kB and 10 seconds.
> >
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
>=20
> Thanks for your patch!
>=20

Thanks for your review.

> > Checkpatch says "externs should be avoided in .c files" and if this one
> > appeared twice I would agree. But as it only appears once, I can't see
> > any advantage to putting it in a new .h file instead of the .c file...
>=20
> The advantage is that it allows the compiler to check that the=20
> signatures of the declaration and the definition do match, now and in=20
> the future.
>=20

Ah yes, I forgot that we use a header file to make sure that the header=20
file is correct ;-)

> > --- a/drivers/nubus/nubus.c
> > +++ b/drivers/nubus/nubus.c
> > @@ -34,6 +34,9 @@
> >
> >  LIST_HEAD(nubus_func_rsrcs);
> >
> > +bool procfs_rsrcs;
> > +module_param(procfs_rsrcs, bool, 0444);
>=20
> With the expanded functionality, is "rsrcs" still a good name?
> Perhaps this should be an integer, so you can define different
> levels? E.g.
>   - 0 =3D just devices
>   - 1 =3D above + boards + public resources
>   - 2 =3D above + private resources

That really depends on how the proc entries get used. I think it's=20
probably going to be developers who would use them so I consider all of=20
this to be outside of the UAPI and subject to change. But it would be nice=
=20
to hear from other developers on that point.

Regarding terminology, the files in /proc/bus/nubus/*/ are termed=20
"records" or "entries" while the subdirectories may represent boards, slot=
=20
resources or tables of entries. So a parameter like "proc_entries" (in=20
effect nubus.proc_entries) might be more apt than "procfs_rsrcs".

Linux "devices" correspond to the "functional resources" offered by a=20
card. (Other resources have other purposes.)

I don't know where the "local/private" designation originates from. It's=20
not to be found in Apple's book, "Designing Cards and Drivers for the=20
Macintosh". AFAIK, there's no distinction between "public" and "private"=20
like you might expect to find between the slot resources needed by Apple's=
=20
Slot Manager and those needed by 3rd party drivers. E.g. the=20
NUBUS_RESID_MAC_ADDRESS and NUBUS_RESID_GAMMADIR slot resources were=20
Apple-defined, even though nubus.c describes them as "local/private".

Note that this patch doesn't affect the /proc/bus/nubus/boards file which=
=20
lists category, type, dr_sw, dr_hw for every functional resource=20
implemented by every board.

> (disclaimer: I know nothing about NuBus and the current /proc/nubus
> layout)

Here's an example from my LCIII. There's only one card (in slot e) and it=
=20
has minimal resources and entries. e/1 is the "vendor info" slot resource,=
=20
e/1/3 is the "revision" entry from that slot resource.

# grep -ar . /proc/bus/nubus
/proc/bus/nubus/e/1/1:
/proc/bus/nubus/e/1/2:Ethernet A-Series
/proc/bus/nubus/e/1/20:
/proc/bus/nubus/e/1/24/1:A-Series
/proc/bus/nubus/e/1/24/3:001
/proc/bus/nubus/e/1/24/4:SS DEV
/proc/bus/nubus/e/80/1:

/proc/bus/nubus/e/80/2:Network_Ethernet_A_Series
/proc/bus/nubus/e/80/a:
/proc/bus/nubus/e/80/80:[snipped binary MAC address]
/proc/bus/nubus/devices:e       0004 0001 010c 0100     fe000000
#=20

With this patch, only the /proc/bus/nubus/devices file appears by default.=
=20
nubus.c captures that information for bus matching purposes, but the=20
/proc/bus/nubus/e/* inodes are unused AFAIK. I think they were put there=20
so that userland programs could find uses for them. Problem is, it can be=
=20
expensive to do that, depending on the card ROM, and hence this patch.

>=20
> Should this be documented? I know there is currently nothing about NuBus=
=20
> under Documentation/.
>=20

Probably...

> > +
> >  /* Meaning of "bytelanes":
> >
> >     The card ROM may appear on any or all bytes of each long word in
> > @@ -574,7 +577,9 @@ nubus_get_functional_resource(struct nubus_board *b=
oard, int slot,
> >                 default:
> >                         /* Local/Private resources have their own
> >                            function */
> > -                       nubus_get_private_resource(fres, dir.procdir, &=
ent);
> > +                       if (procfs_rsrcs)
> > +                               nubus_get_private_resource(fres, dir.pr=
ocdir,
> > +                                                          &ent);
> >                 }
> >         }
> >
> > diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
> > index 2c320a84fd72..844e86636798 100644
> > --- a/drivers/nubus/proc.c
> > +++ b/drivers/nubus/proc.c
> > @@ -51,11 +51,13 @@ static struct proc_dir_entry *proc_bus_nubus_dir;
> >   * /proc/bus/nubus/x/ stuff
> >   */
> >
> > +extern bool procfs_rsrcs;
> > +
> >  struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board)
> >  {
> >         char name[2];
> >
> > -       if (!proc_bus_nubus_dir)
> > +       if (!proc_bus_nubus_dir || !procfs_rsrcs)
> >                 return NULL;
> >         snprintf(name, sizeof(name), "%x", board->slot);
> >         return proc_mkdir(name, proc_bus_nubus_dir);
> > @@ -72,7 +74,7 @@ struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct=
 proc_dir_entry *procdir,
> >         char name[9];
> >         int lanes =3D board->lanes;
> >
> > -       if (!procdir)
> > +       if (!procdir || !procfs_rsrcs)
> >                 return NULL;
> >         snprintf(name, sizeof(name), "%x", ent->type);
> >         remove_proc_subtree(name, procdir);
> > @@ -157,7 +159,7 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry =
*procdir,
> >         char name[9];
> >         struct nubus_proc_pde_data *pded;
> >
> > -       if (!procdir)
> > +       if (!procdir || !procfs_rsrcs)
> >                 return;
> >
> >         snprintf(name, sizeof(name), "%x", ent->type);
> > @@ -176,7 +178,7 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *pro=
cdir,
> >         char name[9];
> >         unsigned char *data =3D (unsigned char *)ent->data;
> >
> > -       if (!procdir)
> > +       if (!procdir || !procfs_rsrcs)
> >                 return;
> >
> >         snprintf(name, sizeof(name), "%x", ent->type);
>=20
---1463811774-1418837779-1679613231=:7816--
