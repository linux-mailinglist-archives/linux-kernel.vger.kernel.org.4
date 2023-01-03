Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C314865BF57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjACLrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjACLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:47:42 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B99FAEE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:47:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 141so1624694pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lte8LDhEJIxGGWKB/4JLfmA0N1/tL9JoU9hj31lh5uY=;
        b=Y5fij6qsrNvFmIwoTp3ZNzS1obYJILzRs9/MnbLcXXxSlxsk1RxnTlUsuIIwuUamwY
         NTFENGoUZYcHhYeq86TPzi6KM/odchYoL9blMXulgXNGEo/unagn8Sn6zwvDUt05by4v
         mbFeaTOhGHa0hiNFFtgpwoYetj/KuH3PKStZW8A51AjTlxiwdHm8FKCYQAVX9/mREIux
         B0ES+Uw1xdfW7A8fG9uaWN/EDoSv7XQVNsOSc6C4YX4WkLShENItIyFyh4izB3bHXnNz
         q7rXDSS2EIyTi8bIWnkIujL/kVP1bAechQbHVMy2RzywgigFL0Cnr16W1og9IfaDmExS
         yJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lte8LDhEJIxGGWKB/4JLfmA0N1/tL9JoU9hj31lh5uY=;
        b=ykq++iVr7sOObYj1FRVjqLQetuk65By/hSlpXEls8C9kMIi2WOnxTMCuPVjPC8K8AG
         Qq7jX1guBwfp5G9e1b72Bewg48YokUb5BRDSb/lIY/U7xhufgKY6KV4Xn0pu31PuJAtX
         TZNn6xg+GCbeBT+GWF+OyGXcTNsYwvXyYRiMcrY2mnAhEIqUi+3Jr3yXteqR2mEWq1BY
         uy1YjVJ7/S8kskOu2yiqtiZVczvE7fxZ+5yqc4B66lrZlszJqWM5+prLsBAwRssUv3z/
         j/qsM3wfdxiiMnxXs9BLzrsJ8tTf4gZ563EcPfqXy9db5/ehxS575cX2B/uQtGkvEjt7
         fbyQ==
X-Gm-Message-State: AFqh2koLJ0tiMs7zzmq9aPFiGlEIw1ajzk8CrGDQsBFpHet9s8Mz30Vd
        19d5fCyMiuMJ6BDzAzay4mF4mnUvfJXCt2cvgsKAtQ==
X-Google-Smtp-Source: AMrXdXvWSePVIXt7wXMnhDqA5yFN7mt4MQ4d5PwDwXRBP28F9LICHeMll3QLuUAm3ffj4MLCUNRw/4js8nmfEiFpZnY=
X-Received: by 2002:a63:24c4:0:b0:499:c23c:d65b with SMTP id
 k187-20020a6324c4000000b00499c23cd65bmr1443717pgk.541.1672746457362; Tue, 03
 Jan 2023 03:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw> <CAK00qKDrk0=Zn35HVyak=rFw+QM-h9PXjji_G7yHQT+H8LAAZg@mail.gmail.com>
In-Reply-To: <CAK00qKDrk0=Zn35HVyak=rFw+QM-h9PXjji_G7yHQT+H8LAAZg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Jan 2023 12:47:01 +0100
Message-ID: <CAPDyKFqYnS294tbB62=fa4ZtdYycJBT2G2vmhHeLHjdyaH9X=w@mail.gmail.com>
Subject: Re: [PATCH V6 00/24] Add support UHS-II for GL9755
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 at 12:04, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf and Adrian
>
> Excuse me for disturbing your nice vacation, if you already have a
> closer look at
>  a paragraph at the series after you finish the vacation, could you let
>  me know your comments first, let me check it first.

I am catching up on my backlog, so I am soon ready to have a look at
this. Thanks for posting the new version!

Although, please note that my bandwidth is a bit limited this and next week too.

Kind regards
Uffe

>
> Thanks, Victor Shih
>
> On Tue, Dec 13, 2022 at 5:01 PM Victor Shih <victorshihgli@gmail.com> wrote:
> >
> > Summary
> > =======
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the original
> >   interrupt registers.
> >
> > Patch structure
> > ===============
> > patch#1-#6:  for core
> > patch#7-#23: for sdhci
> > patch#24:    for GL9755
> >
> > Changes in v6 (Dec. 12, 2022)
> > * rebased to the linux-kernel-v6.1.0-rc8 in Ulf Hansson next branch.
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
> > * fix most of checkpatch warnings/errors.
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang to implement the UHS-2
> >   Host function based on the patches of the
> >   [V5,00/26] Add support UHS-II for GL9755[6].
> > * The uhs2_post_attach_sd() has implemented in Patch#6 and
> >   Patch#17 so drop the V5 version of the Patch#23.
> > * Modifies the usage of the flags used by the sdhci host for
> >   MMC_UHS2_INITIALIZED.
> > * Patch#5: Drop unused definitions and functions.
> > * Patch#7: Rename definitions.
> >            Use BIT() GENMASK() in some cases.
> > * Patch#8: Merge V5 version of Patch[7] and Patch[9] into
> >            V6 version of Patch[8].
> > * Patch#9: Drop unnecessary function.
> >            Rename used definitions.
> > * Patch#10: Drop unnecessary function and simplify some code.
> > * Patch#11: Drop unnecessary function.
> >             Add new mmc_opt_regulator_set_ocr function.
> > * Patch#13: Drop unnecessary function.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#14: Drop unnecessary function.
> >             Modify return value in some function.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#15: Drop unnecessary function.
> >             Rename used definitions.
> >             Use GENMASK() and FIELD_GET() in some cases.
> >             Wrap at 100 columns in some functions.
> > * Patch#16: Drop unnecessary function.
> > * Patch#17: Drop unnecessary function.
> >             Drop the unnecessary parameter when call the DBG()
> >             function.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#18: Drop unnecessary function.
> >             Add uhs2_dev_cmd function to simplify some functions.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#19: Drop unnecessary function.
> >             Add sdhci_uhs2_mode() in some functions.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> > * Patch#20: Add new complete_work_fn/thread_irq_fn variables in
> >             struct sdhci_host.
> >             Use complete_work_fn/thread_irq_fn variables in
> >             sdhci_alloc_host()/sdhci_uhs2_add_host().
> >             Rename used definitions.
> > * Patch[24]: Rename used definitions.
> >
> > Reference
> > =========
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.10738-1-jasonlai.genesyslogic@gmail.com/
> > [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647.11076-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v5 -----------------
> > Summary
> > =======
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the original
> >   interrupt registers.
> >
> > Patch structure
> > ===============
> > patch#1-#6:  for core
> > patch#7-#25: for sdhci
> > patch#26:    for GL9755
> >
> > Changes in v5 (Oct. 19, 2022)
> > * rebased to the linux-kernel-v6.1-rc1 in Ulf Hansson next branch.
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
> > =========
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.10738-1-jasonlai.genesyslogic@gmail.com/
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
> > (Actually, Adrian has made no comments other than "modularising" so far.)
> >
> > I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> > set to meet what I believe Adrian expects; no UHS-II related code in
> > Legacy (UHS-I) code or sdhci.c.
> >
> > Nevertheless, almost of all changes I made are trivial and straightforward
> > in this direction, and I believe that there is no logic changed since v3
> > except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-II
> > command sequences in addition to UHS-II errors. So I added extra handlings.
> >
> > I admit that there is plenty of room for improvements (for example,
> > handling host->flags), but again the focal point here is how sdhci-uhs2.c
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
> > =======
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the original
> >   interrupt registers.
> >
> > Patch structure
> > ===============
> > patch#1-#7: for core
> > patch#8-#17: for sdhci
> > patch#18-#21: for GL9755
> >
> > Tests
> > =====
> > Ran 'dd' command to evaluate the performance:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > UHS-II enabled         :  206MB/s   80MB/s
> >
> > TODO
> > ====
> > - replace some define with BIT macro
> >
> > Reference
> > =========
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
> >   - allow vendor code to disable uhs2 if v4_mode == 0
> >       in __sdhci_add_host()
> >   - merge uhs2_power_up() into mmc_power_up()
> >   - remove flag_uhs2 from mmc_attach_sd()
> >   - add function descriptions to EXPORT'ed functions
> >   - other minor code optimization
> >
> > Changes in v2 (Jan. 9, 2020)
> > * rebased to v5.5-rc5
> >
> > AKASHI Takahiro (1):
> >   mmc: sdhci-pci: add UHS-II support framework
> >
> > Ben Chuang (1):
> >   mmc: sdhci-uhs2: add post-mmc_attach_sd hook
> >
> > Ulf Hansson (3):
> >   mmc: core: Prepare to support SD UHS-II cards
> >   mmc: core: Announce successful insertion of an SD UHS-II card
> >   mmc: core: Extend support for mmc regulators with a vqmmc2
> >
> > Victor Shih (19):
> >   mmc: core: Cleanup printing of speed mode at card insertion
> >   mmc: core: Add definitions for SD UHS-II cards
> >   mmc: core: Support UHS-II card control and access
> >   mmc: sdhci: add UHS-II related definitions in headers
> >   mmc: sdhci: add UHS-II module and add a kernel configuration
> >   mmc: sdhci-uhs2: dump UHS-II registers
> >   mmc: sdhci-uhs2: add reset function and uhs2_mode function
> >   mmc: sdhci-uhs2: add set_power() to support vdd2
> >   mmc: sdhci-uhs2: skip signal_voltage_switch()
> >   mmc: sdhci-uhs2: add set_timeout()
> >   mmc: sdhci-uhs2: add set_ios()
> >   mmc: sdhci-uhs2: add detect_init() to detect the interface
> >   mmc: sdhci-uhs2: add clock operations
> >   mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
> >   mmc: sdhci-uhs2: add request() and others
> >   mmc: sdhci-uhs2: add irq() and others
> >   mmc: sdhci-uhs2: add add_host() and others to set up the driver
> >   mmc: sdhci-uhs2: add pre-detect_init hook
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> >
> >  drivers/mmc/core/Makefile         |    2 +-
> >  drivers/mmc/core/block.c          |    6 +-
> >  drivers/mmc/core/bus.c            |   37 +-
> >  drivers/mmc/core/core.c           |   37 +-
> >  drivers/mmc/core/core.h           |    1 +
> >  drivers/mmc/core/host.h           |    4 +
> >  drivers/mmc/core/mmc_ops.c        |   25 +-
> >  drivers/mmc/core/mmc_ops.h        |    1 +
> >  drivers/mmc/core/regulator.c      |   34 +
> >  drivers/mmc/core/sd.c             |   11 +-
> >  drivers/mmc/core/sd.h             |    3 +
> >  drivers/mmc/core/sd_ops.c         |   13 +
> >  drivers/mmc/core/sd_ops.h         |    3 +
> >  drivers/mmc/core/sd_uhs2.c        | 1400 ++++++++++++++++++++++++++++
> >  drivers/mmc/host/Kconfig          |   10 +
> >  drivers/mmc/host/Makefile         |    1 +
> >  drivers/mmc/host/sdhci-pci-core.c |   16 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  |  309 ++++++-
> >  drivers/mmc/host/sdhci-pci.h      |    3 +
> >  drivers/mmc/host/sdhci-uhs2.c     | 1414 +++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     |  188 ++++
> >  drivers/mmc/host/sdhci.c          |  343 ++++---
> >  drivers/mmc/host/sdhci.h          |  100 +-
> >  include/linux/mmc/card.h          |   47 +
> >  include/linux/mmc/core.h          |   13 +
> >  include/linux/mmc/host.h          |   91 ++
> >  include/linux/mmc/sd_uhs2.h       |  263 ++++++
> >  27 files changed, 4205 insertions(+), 170 deletions(-)
> >  create mode 100644 drivers/mmc/core/sd_uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/sd_uhs2.h
> >
> > --
> > 2.25.1
> >
