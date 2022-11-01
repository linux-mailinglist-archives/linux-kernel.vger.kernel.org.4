Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3473B614330
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKACYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiKACYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:24:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6011C0C;
        Mon, 31 Oct 2022 19:24:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bj12so33821852ejb.13;
        Mon, 31 Oct 2022 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J3s3tI2j2Qn6BkpsJBYtMA+5eI+AX0GxeIgAMtraoU=;
        b=U7Ie6xQNb4C2weKKZuaTltMEj8Xajqf58th8AXVSnk585L+Fa/VpU/bJRTZSyqnUKD
         p4lDOQz3OsPVzgXQZYq096AzLwpsczlAHFRaH4AXakSPoododscr6fJSbjCW+P2VlY2q
         7m+Wjp4dMKZoYtx7g3bZjLvExI3c+Yxh/X/It36nB14R4lbfY7wn9zTT9rFH7gz/OgUz
         4S//HYluWFcJTP0KYXm9FtVyCZjY2y6Dwb50bxltxQD5adM6Y2r3iN13+CaFHFj0k6CF
         Dj7rZIIqIrJMilkmMbNsrpuryxEvks3QhxKciKviQIlmcrPdRKd0+6z5RbpZ44xOrNFv
         67DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J3s3tI2j2Qn6BkpsJBYtMA+5eI+AX0GxeIgAMtraoU=;
        b=6iAn3vvUtRub9bK0P8oBakLibM6uuG/5/KpYfkvIZR2hJ0LqGDEQpFZvcpFTkv4/op
         Sj/vHa4h4vthI9jkIn5I1wxmFUGMVa6MToTT/Z8fFXgI4qzxkkwVIjsP+ci7zEUtpr2k
         +eI+9dIlHgSlMYoX+YrtAUX9tUA/clOXV2gZjgu6XcnumeseOL1oliTDu9pTc0QtJGU8
         bFKHQw+yZy4X/KW6tCn6C4jv7M10zKWfjR+JqSlv01pKFfQ7HOcbO9DvJSIVl5IHYt6i
         7ZVzXZJWrhCJ6XoRScKcjSs8octzxQlaf3/qhic6h92gzw2qSd2Hw5iUT2GwIEDPf5Bt
         FIFQ==
X-Gm-Message-State: ACrzQf2kpAay6V6tWBEV82VBUrC5Qo002zM0DHwa7b0m3TFnXYA4oIwD
        7MDE9+Stn7xRDyWoFmRnn+H7lYXlzHsi7ANFkAE=
X-Google-Smtp-Source: AMsMyM63rF7A5Imgxepaxr90kbSMUZzL0T6448Ve9LG/3haLL2rVdQ0BXcOWXTSTKm7eAwF+p6LfHBdxDI6IA77/miA=
X-Received: by 2002:a17:907:8d07:b0:7ad:cdf2:7b66 with SMTP id
 tc7-20020a1709078d0700b007adcdf27b66mr8615443ejc.699.1667269480400; Mon, 31
 Oct 2022 19:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw> <CAPDyKFonqFO3ckMv9imjvsMPYYX5r7N5uhSdDq5rUbw6woFh5g@mail.gmail.com>
In-Reply-To: <CAPDyKFonqFO3ckMv9imjvsMPYYX5r7N5uhSdDq5rUbw6woFh5g@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 1 Nov 2022 10:24:27 +0800
Message-ID: <CAK00qKC9UhWwEGBue9=PtpU9QFfByXCRKHFUJZtLKsrvg6k6oA@mail.gmail.com>
Subject: Re: [PATCH V5 00/26] Add support UHS-II for GL9755
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

Hi, Ulf

Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2022=E5=B9=B410=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A7:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, 19 Oct 2022 at 13:06, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#25: for sdhci
> > patch#26:    for GL9755
> >
> > Changes in v5 (Oct. 19, 2022)
> > * rebased to the linux-kernel-v6.1-rc1 in Ulf Hansson next branch.
>
> Thanks for rebasing!
>
> Although, future wise, if you make any kind of changes to any patch in
> the series, please bump the version and explain what has been changed.
> This avoids confusion.
>
> I need some more time to have a closer look at the series, so I will
> get back to you again.
>
> Kind regards
> Uffe
>

I will follow your advice. When I make any kind of changes to any patch in
 the series, I will update the version and explain it.

I have a small hope that if you already have a closer look a paragraph at
 the series, could you let me know your comments first, let me check it fir=
st.

Thanks, Victor Shih

>
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
> >
> > ----------------- original cover letter from v3.1 -----------------
> > This is an interim snapshot of our next version, v4, for enabling
> > UHS-II on MMC/SD.
> >
> > It is focused on 'sdhci' side to address Adrian's comments regarding
> > "modularising" sdhci-uhs2.c.
> > The whole aim of this version is to get early feedback from Adrian (and
> > others) on this issue. Without any consensus about the code structure,
> > it would make little sense to go further ahead on sdhci side.
> > (Actually, Adrian has made no comments other than "modularising" so far=
.)
> >
> > I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> > set to meet what I believe Adrian expects; no UHS-II related code in
> > Legacy (UHS-I) code or sdhci.c.
> >
> > Nevertheless, almost of all changes I made are trivial and straightforw=
ard
> > in this direction, and I believe that there is no logic changed since v=
3
> > except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-=
II
> > command sequences in addition to UHS-II errors. So I added extra handli=
ngs.
> >
> > I admit that there is plenty of room for improvements (for example,
> > handling host->flags), but again the focal point here is how sdhci-uhs2=
.c
> > should be built as a module.
> >
> > Please review this series (particularly Patch#8-#26 and #27) from this
> > viewpoint in the first place.
> > (Ben is working on 'host' side but there is no change on 'host' side
> > in this submission except a minor tweak.)
> >
> > Thanks,
> > -Takahiro Akashi
> >
> > ------ original cover letter from v3 ------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7: for core
> > patch#8-#17: for sdhci
> > patch#18-#21: for GL9755
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'dd' command to evaluate the performance:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > UHS-II enabled         :  206MB/s   80MB/s
> >
> > TODO
> > =3D=3D=3D=3D
> > - replace some define with BIT macro
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> >
> > Changes in v3 (Jul. 10, 2020)
> > * rebased to v5.8-rc4
> > * add copyright notice
> > * reorganize the patch set and split some commits into smaller ones
> > * separate uhs-2 headers from others
> > * correct wrong spellings
> > * fix most of checkpatch warnings/errors
> > * remove all k[cz]alloc() from the code
> > * guard sdhci-uhs2 specific code with
> >       'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
> > * make sdhci-uhs2.c as a module
> > * trivial changes, including
> >   - rename back sdhci-core.c to sdhci.c
> >   - allow vendor code to disable uhs2 if v4_mode =3D=3D 0
> >       in __sdhci_add_host()
> >   - merge uhs2_power_up() into mmc_power_up()
> >   - remove flag_uhs2 from mmc_attach_sd()
> >   - add function descriptions to EXPORT'ed functions
> >   - other minor code optimization
> >
> > Changes in v2 (Jan. 9, 2020)
> > * rebased to v5.5-rc5
> >
> > AKASHI Takahiro (5):
> >   mmc: sdhci: add a kernel configuration for enabling UHS-II support
> >   mmc: sdhci: add UHS-II module
> >   mmc: sdhci-uhs2: dump UHS-II registers
> >   mmc: sdhci-uhs2: add set_timeout()
> >   mmc: sdhci-pci: add UHS-II support framework
> >
> > Ben Chuang (1):
> >   mmc: sdhci-uhs2: add post-mmc_attach_sd hook
> >
> > Ulf Hansson (4):
> >   mmc: core: Cleanup printing of speed mode at card insertion
> >   mmc: core: Prepare to support SD UHS-II cards
> >   mmc: core: Announce successful insertion of an SD UHS-II card
> >   mmc: core: Extend support for mmc regulators with a vqmmc2
> >
> > Victor Shih (16):
> >   mmc: core: Add definitions for SD UHS-II cards
> >   mmc: core: Support UHS-II card control and access
> >   mmc: sdhci: add UHS-II related definitions in headers
> >   mmc: sdhci-uhs2: add reset function and uhs2_mode function
> >   mmc: sdhci-uhs2: add set_power() to support vdd2
> >   mmc: sdhci-uhs2: skip signal_voltage_switch()
> >   mmc: sdhci-uhs2: add set_ios()
> >   mmc: sdhci-uhs2: add detect_init() to detect the interface
> >   mmc: sdhci-uhs2: add clock operations
> >   mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
> >   mmc: sdhci-uhs2: add request() and others
> >   mmc: sdhci-uhs2: add irq() and others
> >   mmc: sdhci-uhs2: add add_host() and others to set up the driver
> >   mmc: sdhci-uhs2: add pre-detect_init hook
> >   mmc: core: add post-mmc_attach_sd hook
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> >
> >  drivers/mmc/core/Makefile         |    2 +-
> >  drivers/mmc/core/block.c          |    6 +-
> >  drivers/mmc/core/bus.c            |   38 +-
> >  drivers/mmc/core/core.c           |   49 +-
> >  drivers/mmc/core/core.h           |    1 +
> >  drivers/mmc/core/host.h           |    4 +
> >  drivers/mmc/core/mmc_ops.c        |   25 +-
> >  drivers/mmc/core/mmc_ops.h        |    1 +
> >  drivers/mmc/core/regulator.c      |   34 +
> >  drivers/mmc/core/sd.c             |   16 +-
> >  drivers/mmc/core/sd.h             |    3 +
> >  drivers/mmc/core/sd_ops.c         |   18 +
> >  drivers/mmc/core/sd_ops.h         |    3 +
> >  drivers/mmc/core/sd_uhs2.c        | 1394 +++++++++++++++++++++++++
> >  drivers/mmc/host/Kconfig          |   10 +
> >  drivers/mmc/host/Makefile         |    1 +
> >  drivers/mmc/host/sdhci-pci-core.c |   17 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  |  310 +++++-
> >  drivers/mmc/host/sdhci-pci.h      |    3 +
> >  drivers/mmc/host/sdhci-uhs2.c     | 1606 +++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     |  226 ++++
> >  drivers/mmc/host/sdhci.c          |  342 +++---
> >  drivers/mmc/host/sdhci.h          |  125 ++-
> >  include/linux/mmc/card.h          |   47 +
> >  include/linux/mmc/core.h          |   13 +
> >  include/linux/mmc/host.h          |   99 ++
> >  include/linux/mmc/sd_uhs2.h       |  263 +++++
> >  27 files changed, 4486 insertions(+), 170 deletions(-)
> >  create mode 100644 drivers/mmc/core/sd_uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/sd_uhs2.h
> >
> > --
> > 2.25.1
> >

Thanks, Victor Shih
