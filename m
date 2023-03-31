Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4943C6D1E65
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCaK4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCaKz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:55:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2221E71C;
        Fri, 31 Mar 2023 03:55:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso8435144pjf.0;
        Fri, 31 Mar 2023 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLhcZIwgRI3L/SWzNLNahUg81Pb7tu3nUSLCMy3FEQs=;
        b=fpQg2PEuQx1nufKIt5VTBbMELFCEwKoR1Krpe+zQ3x6ax8yUiD8PQXlYw9E1dkrY7z
         PV+mHXHEhEaRM2gF5uss9bJp+4gRln07iVp74p9LvioOt1dmO8d1cpjL8rAklTGsb8uT
         gc/PY6qJX6rlkBbSeZMmgXlA14UJTqtgD0zHw8KUkzJ5Ro3edrLiubCjVy48uAgfi7bE
         nEcrauk9duWoeGNfRynwfjSCtoS9Ip8B9Vc3i9Uc0xtwZNE4X6un+6Re7zvwiqhiwP54
         6sJZ+NVfRuSL8tPYi/NqVZnCpAdMGWdYItRajzV+xgCxB9DbuYPmajOTmm23KIzY1q//
         hzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLhcZIwgRI3L/SWzNLNahUg81Pb7tu3nUSLCMy3FEQs=;
        b=0n+3fw64qlgrAMixMemniAPTs2ERaYqNE8mO1tVsejJKSEiQIDF7SAL9rJaZWv/nq1
         d3wMNm8vBUrVtYzCtqa7QBodISPBaK+vqbJzvW4vzOD2d3YBHfvsyG5atf7hdGwzYiOb
         f5/WhuZ4C99SFoU/t/y+x6NyPqE4Pv7uEIf9SJNjrn8/qIVjX/rtqEm6kpHcwuHykrEx
         PNFpvQAHwErrDHHQeYrHoZJrKUp9tfRIq28t2ZlieK1WkEP4ufNEoTLsTfv3s9KDoZNV
         EkkXDWOKbvdIusYRHNT+Jk9a5nP4IBoP3Bc332SthNgW1s7w9nhiCH4nCBMRDvymf0Km
         4ZZQ==
X-Gm-Message-State: AAQBX9dYMnIwN+d9uVbDPl/Qy4GK/45pb8//wALHc711nxf7VXyVpR8t
        7lTaTPXyPjXhUMSkdy631v4=
X-Google-Smtp-Source: AKy350aPZuwXzXt+u/FqyLk2DmMqWblDyK4rJK04YvqiPn+kNF2MhIa2q7/fnqVXtYpYert8g3sI1g==
X-Received: by 2002:a17:90b:3811:b0:23d:1bed:298e with SMTP id mq17-20020a17090b381100b0023d1bed298emr30145978pjb.45.1680260154015;
        Fri, 31 Mar 2023 03:55:54 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-983f-c7ff-3efd-77d9-6c16.emome-ip6.hinet.net. [2001:b400:e25c:983f:c7ff:3efd:77d9:6c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b0019acd3151d0sm1287665plb.114.2023.03.31.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:55:53 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V7 00/23] Add support UHS-II for GL9755
Date:   Fri, 31 Mar 2023 18:55:23 +0800
Message-Id: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
=======
These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.

About UHS-II, roughly deal with the following three parts:
1) A UHS-II detection and initialization:
- Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
  [2]).
- Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
- In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
  3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
  Setup Sequence.

2) Send Legacy SD command through SD-TRAN
- Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
  compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
  Types and Format Overview[3]).
- Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
  CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).

3) UHS-II Interrupt
- Except for UHS-II error interrupts, most interrupts share the original
  interrupt registers.

Patch structure
===============
patch#1-#6:  for core
patch#7-#22: for sdhci
patch#23:    for GL9755

Changes in v7 (Mar. 31, 2023)
* rebased to the linux-kernel-v6.3.0-rc3 in Ulf Hansson next branch.
* according to the guidance and overall architecture provided 
  by Ulf Hansson, Ben Chuang and Jason Lai to implement the
  UHS-2 Core function based on the patches of the [V4,0/6] 
  Preparations to support SD UHS-II cards[5].
* according to the guidance and comments provided by 
  Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement 
  the UHS-2 Host function based on the patches of the 
  [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
* implement the necessary function to let the UHS-2 Core/Host
  work properly.
* fix most of checkpatch warnings/errors.
* according to the guidance and comments provided by 
  Adrian Hunter, Ben Chuang to implement the UHS-2 
  Host function based on the patches of the 
  [V5,00/26] Add support UHS-II for GL9755[6].
* according to the guidance and comments provided by 
  Ulf Hanssion, Adrian Hunter, Ben Chuang to implement the UHS-2 
  Host function based on the patches of the 
  [V6,00/24] Add support UHS-II for GL9755[7].
* The uhs2_post_attach_sd() function is no longer needed so drop
  the V6 version of the Patch#22.
* Modifies the usage of the flags used by the sdhci host for
  MMC_UHS2_INITIALIZED.
* Patch#1: Drop unnecessary bracket.
* Patch#2: Drop sd_uhs2_set_ios function.
           Used ->uhs2_control() callback for uhs2_set_ios
           in sd_uhs2_power_up().
           Used ->uhs2_control() callback for uhs2_set_ios
           in sd_uhs2_power_off().
           Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
           Modify sd_uhs2_legacy_init to avoid the
           sd_uhs2_reinit cycle issue.
* Patch#5: Drop unnecessary definitions.
* Patch#6: Drop unnecessary function.
           Drop uhs2_state in favor of ios->timing.
* Patch#7: Reorder values and positions of definitions.
* Patch#9: Used sdhci_uhs2_mode function to simplify.
* Patch#11: Drop pwr variable in sdhci_uhs2_set_power function.
* Patch#14: Modify some descriptions.
            Drop unnecessary function.
* Patch#15: Drop using uhs2_reset ops and use sdhci_uhs2_reset function
            in the sdhci_do_detect_init function.
* Patch#17: Drop unnecessary function.
* Patch#18: Drop unnecessary whitespace changes.
            Cancel the export state of some functions.
* Patch#19: Drop unnecessary function.
            Used sdhci_uhs2_mode function to simplify.
            Modify some descriptions.
            Cancel the export state of some functions.
* Patch#20: Drop using __sdhci_uhs2_host function and use
            __sdhci_add_host function in sdhci_uhs2_add_host function.
            Cancel the export state of some functions.
* Patch#23: Drop using uhs2_post_attach_sd function.

Reference
=========
[1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
[2] SD Host Controller Simplified Specification 4.20
[3] UHS-II Simplified Addendum 1.02
[4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.19831-1-takahiro.akashi@linaro.org/
[5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.10738-1-jasonlai.genesyslogic@gmail.com/
[6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647.11076-1-victor.shih@genesyslogic.com.tw/
[7] https://patchwork.kernel.org/project/linux-mmc/cover/20221213090047.3805-1-victor.shih@genesyslogic.com.tw/

----------------- original cover letter from v6 -----------------
Summary
=======
These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.

About UHS-II, roughly deal with the following three parts:
1) A UHS-II detection and initialization:
- Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
  [2]).
- Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
- In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
  3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
  Setup Sequence.

2) Send Legacy SD command through SD-TRAN
- Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
  compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
  Types and Format Overview[3]).
- Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
  CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).

3) UHS-II Interrupt
- Except for UHS-II error interrupts, most interrupts share the original
  interrupt registers.

Patch structure
===============
patch#1-#6:  for core
patch#7-#23: for sdhci
patch#24:    for GL9755

Changes in v6 (Dec. 12, 2022)
* rebased to the linux-kernel-v6.1.0-rc8 in Ulf Hansson next branch.
* according to the guidance and overall architecture provided 
  by Ulf Hansson, Ben Chuang and Jason Lai to implement the
  UHS-2 Core function based on the patches of the [V4,0/6] 
  Preparations to support SD UHS-II cards[5].
* according to the guidance and comments provided by 
  Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement 
  the UHS-2 Host function based on the patches of the 
  [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
* implement the necessary function to let the UHS-2 Core/Host
  work properly.
* fix most of checkpatch warnings/errors.
* according to the guidance and comments provided by 
  Adrian Hunter, Ben Chuang to implement the UHS-2 
  Host function based on the patches of the 
  [V5,00/26] Add support UHS-II for GL9755[6].
* The uhs2_post_attach_sd() has implemented in Patch#6 and 
  Patch#17 so drop the V5 version of the Patch#23.
* Modifies the usage of the flags used by the sdhci host for
  MMC_UHS2_INITIALIZED.
* Patch#5: Drop unused definitions and functions.
* Patch#7: Rename definitions.
           Use BIT() GENMASK() in some cases.
* Patch#8: Merge V5 version of Patch[7] and Patch[9] into 
           V6 version of Patch[8].
* Patch#9: Drop unnecessary function.
           Rename used definitions.
* Patch#10: Drop unnecessary function and simplify some code.
* Patch#11: Drop unnecessary function.
            Add new mmc_opt_regulator_set_ocr function.
* Patch#13: Drop unnecessary function.
            Use GENMASK() and FIELD_PREP() in some cases.
* Patch#14: Drop unnecessary function.
            Modify return value in some function.
            Use GENMASK() and FIELD_PREP() in some cases.
* Patch#15: Drop unnecessary function.
            Rename used definitions.
            Use GENMASK() and FIELD_GET() in some cases.
            Wrap at 100 columns in some functions.
* Patch#16: Drop unnecessary function.
* Patch#17: Drop unnecessary function.
            Drop the unnecessary parameter when call the DBG()
            function.
            Rename used definitions.
            Cancel the export state of some functions.
            Use GENMASK() and FIELD_PREP() in some cases.
* Patch#18: Drop unnecessary function.
            Add uhs2_dev_cmd function to simplify some functions.
            Rename used definitions.
            Cancel the export state of some functions.
            Use GENMASK() and FIELD_PREP() in some cases.
* Patch#19: Drop unnecessary function.
            Add sdhci_uhs2_mode() in some functions.
            Rename used definitions.
            Cancel the export state of some functions.
* Patch#20: Add new complete_work_fn/thread_irq_fn variables in
            struct sdhci_host.
            Use complete_work_fn/thread_irq_fn variables in 
            sdhci_alloc_host()/sdhci_uhs2_add_host().
            Rename used definitions.
* Patch[24]: Rename used definitions.

Reference
=========
[1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
[2] SD Host Controller Simplified Specification 4.20
[3] UHS-II Simplified Addendum 1.02
[4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.19831-1-takahiro.akashi@linaro.org/
[5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.10738-1-jasonlai.genesyslogic@gmail.com/
[6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647.11076-1-victor.shih@genesyslogic.com.tw/

----------------- original cover letter from v5 -----------------
Summary
=======
These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.

About UHS-II, roughly deal with the following three parts:
1) A UHS-II detection and initialization:
- Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
  [2]).
- Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
- In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
  3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
  Setup Sequence.

2) Send Legacy SD command through SD-TRAN
- Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
  compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
  Types and Format Overview[3]).
- Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
  CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).

3) UHS-II Interrupt
- Except for UHS-II error interrupts, most interrupts share the original
  interrupt registers.

Patch structure
===============
patch#1-#6:  for core
patch#7-#25: for sdhci
patch#26:    for GL9755

Changes in v5 (Oct. 19, 2022)
* rebased to the linux-kernel-v6.1-rc1 in Ulf Hansson next branch.
* according to the guidance and overall architecture provided 
  by Ulf Hansson, Ben Chuang and Jason Lai to implement the
  UHS-2 Core function based on the patches of the [V4,0/6] 
  Preparations to support SD UHS-II cards[5].
* according to the guidance and comments provided by 
  Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement 
  the UHS-2 Host function based on the patches of the 
  [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
* implement the necessary function to let the UHS-2 Core/Host
  work properly.
* fix most of checkpatch warnings/errors

Reference
=========
[1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
[2] SD Host Controller Simplified Specification 4.20
[3] UHS-II Simplified Addendum 1.02
[4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.19831-1-takahiro.akashi@linaro.org/
[5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.10738-1-jasonlai.genesyslogic@gmail.com/
 
----------------- original cover letter from v3.1 -----------------
This is an interim snapshot of our next version, v4, for enabling
UHS-II on MMC/SD.

It is focused on 'sdhci' side to address Adrian's comments regarding
"modularising" sdhci-uhs2.c.
The whole aim of this version is to get early feedback from Adrian (and
others) on this issue. Without any consensus about the code structure,
it would make little sense to go further ahead on sdhci side.
(Actually, Adrian has made no comments other than "modularising" so far.)

I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
set to meet what I believe Adrian expects; no UHS-II related code in
Legacy (UHS-I) code or sdhci.c.

Nevertheless, almost of all changes I made are trivial and straightforward
in this direction, and I believe that there is no logic changed since v3
except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-II
command sequences in addition to UHS-II errors. So I added extra handlings.

I admit that there is plenty of room for improvements (for example,
handling host->flags), but again the focal point here is how sdhci-uhs2.c
should be built as a module.

Please review this series (particularly Patch#8-#26 and #27) from this
viewpoint in the first place.
(Ben is working on 'host' side but there is no change on 'host' side
in this submission except a minor tweak.)

Thanks,
-Takahiro Akashi

------ original cover letter from v3 ------
Summary
=======
These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.

About UHS-II, roughly deal with the following three parts:
1) A UHS-II detection and initialization:
- Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
  [2]).
- Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
- In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
  3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
  Setup Sequence.

2) Send Legacy SD command through SD-TRAN
- Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
  compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
  Types and Format Overview[3]).
- Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
  CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).

3) UHS-II Interrupt
- Except for UHS-II error interrupts, most interrupts share the original
  interrupt registers.

Patch structure
===============
patch#1-#7: for core
patch#8-#17: for sdhci
patch#18-#21: for GL9755

Tests
=====
Ran 'dd' command to evaluate the performance:
(SanDisk UHS-II card on GL9755 controller)
                             Read    Write
UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
UHS-II enabled         :  206MB/s   80MB/s

TODO
====
- replace some define with BIT macro

Reference
=========
[1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
[2] SD Host Controller Simplified Specification 4.20
[3] UHS-II Simplified Addendum 1.02

Changes in v3 (Jul. 10, 2020)
* rebased to v5.8-rc4
* add copyright notice
* reorganize the patch set and split some commits into smaller ones
* separate uhs-2 headers from others
* correct wrong spellings
* fix most of checkpatch warnings/errors
* remove all k[cz]alloc() from the code
* guard sdhci-uhs2 specific code with
      'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
* make sdhci-uhs2.c as a module
* trivial changes, including
  - rename back sdhci-core.c to sdhci.c
  - allow vendor code to disable uhs2 if v4_mode == 0
      in __sdhci_add_host()
  - merge uhs2_power_up() into mmc_power_up()
  - remove flag_uhs2 from mmc_attach_sd()
  - add function descriptions to EXPORT'ed functions
  - other minor code optimization

Changes in v2 (Jan. 9, 2020)
* rebased to v5.5-rc5

AKASHI Takahiro (1):
  mmc: sdhci-pci: add UHS-II support framework

Ulf Hansson (1):
  mmc: core: Extend support for mmc regulators with a vqmmc2

Victor Shih (21):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Add definitions for SD UHS-II cards
  mmc: core: Support UHS-II card control and access
  mmc: sdhci: add UHS-II related definitions in headers
  mmc: sdhci: add UHS-II module and add a kernel configuration
  mmc: sdhci-uhs2: dump UHS-II registers
  mmc: sdhci-uhs2: add reset function and uhs2_mode function
  mmc: sdhci-uhs2: add set_power() to support vdd2
  mmc: sdhci-uhs2: skip signal_voltage_switch()
  mmc: sdhci-uhs2: add set_timeout()
  mmc: sdhci-uhs2: add set_ios()
  mmc: sdhci-uhs2: add detect_init() to detect the interface
  mmc: sdhci-uhs2: add clock operations
  mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
  mmc: sdhci-uhs2: add request() and others
  mmc: sdhci-uhs2: add irq() and others
  mmc: sdhci-uhs2: add add_host() and others to set up the driver
  mmc: sdhci-uhs2: add pre-detect_init hook
  mmc: sdhci-pci-gli: enable UHS-II mode for GL9755

 drivers/mmc/core/Makefile         |    2 +-
 drivers/mmc/core/block.c          |   18 +-
 drivers/mmc/core/bus.c            |   38 +-
 drivers/mmc/core/core.c           |   25 +-
 drivers/mmc/core/core.h           |    1 +
 drivers/mmc/core/host.h           |    7 +
 drivers/mmc/core/mmc_ops.c        |   25 +-
 drivers/mmc/core/mmc_ops.h        |    1 +
 drivers/mmc/core/regulator.c      |   34 +
 drivers/mmc/core/sd.c             |   13 +-
 drivers/mmc/core/sd.h             |    4 +
 drivers/mmc/core/sd_ops.c         |   11 +
 drivers/mmc/core/sd_ops.h         |   18 +
 drivers/mmc/core/sd_uhs2.c        | 1366 +++++++++++++++++++++++++++++
 drivers/mmc/host/Kconfig          |   10 +
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/sdhci-pci-core.c |   16 +-
 drivers/mmc/host/sdhci-pci-gli.c  |  276 +++++-
 drivers/mmc/host/sdhci-pci.h      |    3 +
 drivers/mmc/host/sdhci-uhs2.c     | 1350 ++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h     |  191 ++++
 drivers/mmc/host/sdhci.c          |  277 +++---
 drivers/mmc/host/sdhci.h          |   83 +-
 include/linux/mmc/card.h          |   36 +
 include/linux/mmc/core.h          |   13 +
 include/linux/mmc/host.h          |   89 ++
 include/linux/mmc/sd_uhs2.h       |  240 +++++
 27 files changed, 3988 insertions(+), 160 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/sd_uhs2.h

-- 
2.25.1

