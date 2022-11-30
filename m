Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CAC63E0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiK3TkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiK3TkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:40:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7CD8C45B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:40:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m19so24228154edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98zeIMBH0W3RLt+Fp+Yzmkk0Rvjajs1ZMHuz47k0oRk=;
        b=Ej83uBVjcRpD5UMAKZObwpQ+PbJQqifAenDMDyDJhsQQEAFwXSgoAmInrktMFeGd1D
         Rv37aNrcfm737NzSpBzLM1sJq1PAAfSnoX3sjRKqvltRncMZ9JAzuAtensm0R1G4OS9t
         A4UDBse0+A1tcd5cRgGiYMfw/WHKCkw8R9UF6EYsgjMG+uwji0j4Alsow++jCKWAprJj
         Dgdb7OCIdBGGvkN4Cynnzt3B2Yui8aPMsQCFYgBJoWbh2twnpWZdPXeH63IfDePWmY3V
         Y57XS+CGlS6hWJ8VNZ+aqksM3X7kt7v52P4x+pb32c8qFHWdxMssrnCz9xF292/dHujg
         oXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98zeIMBH0W3RLt+Fp+Yzmkk0Rvjajs1ZMHuz47k0oRk=;
        b=JvVQ4rbLGy/HDYMClrOVR1H/34jfmrl95XDDv85uM8ncgoOweW/QC9WSgpTgREcAK0
         Ur45GJ7RxxxO+ihj4HX/bdjG627He8xRHhvuWOcDPjQLnDinXCc3zb7iFP5TrBhbMJkz
         MHtOuG/2hI5K+OjFmWpHD1l7LZ3PVrhvK4ld6bwShhDx6gKl0sYGz7AD5RZ8JOR3OfNx
         b5PUy3B8vzWD+k09wLsWvbnUQ4ZlEaxx7Du+7tMiJ+7p+y1IQoM7YzNBqRRdnTjDZaNa
         e9ImPzPCur9hyReFkh1ogcz8EIdODUdmB7f48PmKgyFRAjjHDzawy8Tv5NyiO2eXLMgm
         Hm7w==
X-Gm-Message-State: ANoB5pkA4TOsajndl6E6ifkcLorZ9ht/RJpbWyEBi6gsoPG2wvccCjME
        a4e9keKLj8KWRI+z2YBpA0ZTGME8No7jWejzLTcRlwEhPLw=
X-Google-Smtp-Source: AA0mqf6QZLf6o6EcgkGaIDNmKKDe9Lkj9iL8O1A+Bf/LH1MNOzf2XqAfYKusTY0yAUnSF68weHxz5zqocd9jwOA/bHY=
X-Received: by 2002:a05:6402:4284:b0:461:8156:e0ca with SMTP id
 g4-20020a056402428400b004618156e0camr2609018edc.271.1669837216769; Wed, 30
 Nov 2022 11:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com>
 <Y3f9O0S8kVXZ+py+@mail-itl> <CAKf6xpvUcR=rta6SD7mw_pvgQJTxKjN5VHpC6x-zCAiaJ=pKfg@mail.gmail.com>
 <Y3kFYeml1CPL318u@mail-itl> <CAKf6xpts-u_JUtTGnzhxmRHZYVFnVMksTERZWS8EC+7BGsoViw@mail.gmail.com>
 <Y3ukZqLaTqzjY/ro@mail-itl> <Y4S7R2dN7kpJnPpY@mail-itl>
In-Reply-To: <Y4S7R2dN7kpJnPpY@mail-itl>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Wed, 30 Nov 2022 14:40:04 -0500
Message-ID: <CAKf6xpvV076SaJ_PtNwyuNSDYmi0aZoNF9cT3oQJLyjSwBK3ug@mail.gmail.com>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled
To:     =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
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

On Mon, Nov 28, 2022 at 8:44 AM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Mon, Nov 21, 2022 at 05:16:37PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Mon, Nov 21, 2022 at 10:41:34AM -0500, Jason Andryuk wrote:
> > > On Sat, Nov 19, 2022 at 11:33 AM Marek Marczykowski-G=C3=B3recki
> > > <marmarek@invisiblethingslab.com> wrote:
> > > >
> > > > On Sat, Nov 19, 2022 at 09:36:54AM -0500, Jason Andryuk wrote:
> > > > > Hi, Marek,
> > > > >
> > > > > On Fri, Nov 18, 2022 at 4:46 PM Marek Marczykowski-G=C3=B3recki
> > > > > <marmarek@invisiblethingslab.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 18, 2022 at 03:46:47PM -0500, Jason Andryuk wrote:
> > > > > > > I was trying to test your xen-pciback v3 patch, and I am havi=
ng
> > > > > > > assignment fail consistently now.  It is actually failing to
> > > > > > > quarantine to domIO in the first place, which matches the fai=
lure from
> > > > > > > the other day (when I more carefully read through the logs). =
 It now
> > > > > > > consistently fails to quarantine on every boot unlike the oth=
er day
> > > > > > > where it happened once.
> > > > > >
> > > > > > Does this include the very first assignment too, or only after =
domain
> > > > > > reboot? If the latter, maybe some cleanup missed clearing MASKA=
LL?
> > > > >
> > > > > It's the quarantine during dom0 boot that fails.  Later assignmen=
t
> > > > > during VM boot fails.  I tried warm reboots and cold boots and it
> > > > > happened both times.
> > > > >
> > > > > I also modified my initrd to halt in there and checked the config
> > > > > space.  MASKALL wasn't set at that time.  I need to double check =
-
> > > > > MASKALL may have been unset after dom0 booted in that case.
> > > > >
> > > > > I'll test more to figure when and how MASKALL is getting set.
> > >
> > > I'm testing with a laptop without a battery.  It seems MASKALL remain=
s
> > > set when rebooting or when left plugged in.
> > >
> > > From unplugged, a cold boot doesn't have MASKALL set and the network =
vm boots.
> > >
> > > After that, rebooting the laptop leaves MASKALL set on the NIC when
> > > the laptop reboots.   NIC assignment fails.
> > >
> > > Shutdown and later boot while left plugged in keeps MASKALL set.  NIC
> > > assignment fails.  I have only tested this scenario for short periods
> > > of time, so I don't know if it would eventually clear after a longer
> > > time.
> >
> > That's interesting, seems like firmware is not resetting the device
> > properly. Maybe related to enabled wake on lan?
> >
> > Anyway, resetting the device at domain create/destroy is AFAIR normally
> > done by pciback (at the instruction by the toolstack). Should it maybe
> > be done when assigning to pciback initially too? Or maybe in this
> > specific case, device reset doesn't properly clear MASKALL, so pciback
> > should clear it explicitly (after ensuring the MSI-X enable is cleared
> > too)?
>
> Can you check if `echo 1 > /sys/bus/pci/devices/$SBDF/reset` clears
> MASKALL on this device?

`echo 1 > ..../reset` did not clear MASKALL.

After shutting down the domain with the iwlwifi card, lspci from dom0 shows=
:
MSI-X: Enable+ Count=3D16 Masked+

Hmm, Xen logged:
(XEN) cannot disable IRQ 137: masking MSI-X on 0000:00:14.3

Oh, looking back, I see that was logged during my earlier testing of
this patch set, but I missed it.

It seems like Xen set Enable and Masked itself in __pci_disable_msix()
since memory decoding is not enabled.

I'm still investigating, but I wanted to give an update.  It seems
like Xen should clear MASKALL when booting.  Something like clearing
MASKALL in pdev_msi_init() when !ENABLE & MASKALL.  However, I have
seen the system boot with both Enable and Maskall set on the iwlwifi
nic.  Is it risky to just unilaterally clear both of those when
enumerating PCI devices?  It doesn't seem appropriate to leave them
set without a driver controlling them.

-Jason
