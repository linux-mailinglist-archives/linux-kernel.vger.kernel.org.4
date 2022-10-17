Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D04E6009FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJQJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJQJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:12:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A51B2192;
        Mon, 17 Oct 2022 02:12:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o21so7795649ple.5;
        Mon, 17 Oct 2022 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mqbn+objq+w7lHxKBM1l5X6+7xdMWJwq73AsnPKEo8=;
        b=QmBENWprmyq0sCjUC7T0PhcNY+DNCsZx4HhXh3Thvx7b9a87h1mh4/dVlrcH19ZOQv
         wF3p3G2IMKjPR0N7bjgBzDelx3WP7d2iTeTKg1uFBjcVms94P8mTkRAhySuU01UtpG8W
         oWMtnay9HJmL4GAe2ZPaEuNpHPfg8GlFLBWLG9LolrZMjB3ycKoWYybRYSHn8i6S3CeE
         xRb/f+iFuMqjakt4LWCQ/UDojGic6lRukHEKK8/qVxCgspeho952gDH10sTg6Eo7+sAy
         ghCDyUF+J5aj6m8RVP6BgGHdFV68g6eGQWO0C8H0YZ9poErh82lswU7lPgIfy1x0EkoS
         zI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Mqbn+objq+w7lHxKBM1l5X6+7xdMWJwq73AsnPKEo8=;
        b=OaRZ11096oYR/aC5fDeyGsjBq6HlJ3CftVIecgDilnY7YQZGTMSxWURoWO3BCNVRlK
         Yz14MiNFuGvlyX9hxcg8IzQ3wKzhT5pc7Ab854re+xphMZPQTCDSNe8yxKNmK1se1qjC
         XfotPUkPTj6rCPoLvcnnjW7Y5eu550n/yDiFOsRkxra837gFlrRASAzUZnpctc5Y9ZwY
         8G1NTnlNWHQk2uMIuBcsHz6oRoX672ECN3pbgPR81HCTL8gEyHHPynfdADmpjHcf3Cyr
         EkzxR82v528ae96DZ7hEHn0IUFMVaw8/4uHWAAKqNImaB/sE/ehgqElLqnE8VaYlbY85
         XQXA==
X-Gm-Message-State: ACrzQf02tZx75LUVjK7kfTbhUQjxgMB2PKj7+zgma+UGz9fe/aJGXA1O
        bW8RyxqCJWKQo0YvwXgamySBG7cpMik=
X-Google-Smtp-Source: AMsMyM4RpwwPdl4sMaS4DQ+7boqUxN40x9sbGDgoDcazvahTQAHmInhGxFKu1jdWzxuPZCFo7+VA0Q==
X-Received: by 2002:a17:902:aa46:b0:178:9ee5:c7f1 with SMTP id c6-20020a170902aa4600b001789ee5c7f1mr11377835plr.69.1665997928927;
        Mon, 17 Oct 2022 02:12:08 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:08 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 00/26] Add support UHS-II for GL9755
Date:   Mon, 17 Oct 2022 17:11:27 +0800
Message-Id: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
patch#7-#25: for sdhci
patch#26:    for GL9755

Changes in v5 (Oct. 14, 2022)
* rebased to linux-v6.0.
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

AKASHI Takahiro (6):
  mmc: sdhci: add a kernel configuration for enabling UHS-II support
  mmc: sdhci: add UHS-II module
  mmc: sdhci-uhs2: dump UHS-II registers
  mmc: sdhci-uhs2: add set_timeout()
  mmc: core: add post-mmc_attach_sd hook
  mmc: sdhci-pci: add UHS-II support framework

Ben Chuang (1):
  mmc: sdhci-uhs2: add post-mmc_attach_sd hook

Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2

Victor Shih (15):
  mmc: core: Add definitions for SD UHS-II cards
  mmc: core: Support UHS-II card control and access
  mmc: sdhci: add UHS-II related definitions in headers
  mmc: sdhci-uhs2: add reset function and uhs2_mode function
  mmc: sdhci-uhs2: add set_power() to support vdd2
  mmc: sdhci-uhs2: skip signal_voltage_switch()
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
 drivers/mmc/core/block.c          |    6 +-
 drivers/mmc/core/bus.c            |   38 +-
 drivers/mmc/core/core.c           |   49 +-
 drivers/mmc/core/core.h           |    1 +
 drivers/mmc/core/host.h           |    4 +
 drivers/mmc/core/mmc_ops.c        |   25 +-
 drivers/mmc/core/mmc_ops.h        |    1 +
 drivers/mmc/core/regulator.c      |   34 +
 drivers/mmc/core/sd.c             |   17 +-
 drivers/mmc/core/sd.h             |    3 +
 drivers/mmc/core/sd_ops.c         |   18 +
 drivers/mmc/core/sd_ops.h         |    3 +
 drivers/mmc/core/sd_uhs2.c        | 1394 ++++++++++++++++++++++++
 drivers/mmc/host/Kconfig          |   10 +
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/sdhci-pci-core.c |   17 +-
 drivers/mmc/host/sdhci-pci-gli.c  |  310 +++++-
 drivers/mmc/host/sdhci-pci.h      |    3 +
 drivers/mmc/host/sdhci-uhs2.c     | 1634 +++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h     |  226 ++++
 drivers/mmc/host/sdhci.c          |  335 +++---
 drivers/mmc/host/sdhci.h          |  125 ++-
 include/linux/mmc/card.h          |   47 +
 include/linux/mmc/core.h          |   13 +
 include/linux/mmc/host.h          |   99 ++
 include/linux/mmc/sd_uhs2.h       |  263 +++++
 27 files changed, 4507 insertions(+), 171 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/sd_uhs2.h

-- 
2.25.1

