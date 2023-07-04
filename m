Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434CB74772E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGDQuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGDQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:50:11 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604301AC;
        Tue,  4 Jul 2023 09:50:10 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-98502b12fd4so159176666b.1;
        Tue, 04 Jul 2023 09:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489409; x=1691081409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5cBryZiaNRPz8kx7gh4MVw5Ah9onbshYDFqDwi4BYc=;
        b=QuKfXXg85bxnGeWmtXXVrxF7M7c3mSLSQF5JDDR95gTJEF/eIj5YzBpiGln/sHjq4x
         TJO2Ei2E2+yMkCWqiI3HE0TaDMEV26PrG5kKjM+xloRKlwdjPpuoSoIQWX4LzIIw5a+2
         g+93WCLV/Drsk08H0tLEJ1ArfVyv4hHeXzXKQDz9srfCmviyL5C0qFr1gALEY2vRpu03
         m6L9Kz9QDfr4DQhgWZUFQiOaFOH59FeDGZ+isxg68Sb/8E9Mf+NFlWdRjAZfkoEXkIJ9
         NXYoO16ZwD4EVyXGweOJTpMdoERzQDUhd0N/URm8fjEKJxldzOB+r1tHQ39G6ev6qPV+
         4SqQ==
X-Gm-Message-State: ABy/qLYsOJbNe8gtYLFEvXqsdczEUdvZmxhDExA07Gf8H8z9b9Ikl7qJ
        Jcs8BdWTsF9ijWmwEDtP19lwSk3g637ukaUSG+PzlqZ2Y7c=
X-Google-Smtp-Source: APBJJlF3Lx1P9ewy7I9YMWK02Z5rHswNClZAnOm01hQRnHM1SXbhAKIx8pk40Yyomcs6A1FAabp/EnDsb3ULxve6lhM=
X-Received: by 2002:a17:907:101d:b0:974:5480:6270 with SMTP id
 ox29-20020a170907101d00b0097454806270mr9790447ejb.0.1688489408530; Tue, 04
 Jul 2023 09:50:08 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jul 2023 18:49:57 +0200
Message-ID: <CAJZ5v0gDV_rDDs0ur=Ct6=4CcCsFQLoO0yGz9-UrnyO0AKLCjw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.5-rc1-2

with top-most commit 40c565a429d706951f18fe07ccd9f6fded23a4dc

 Merge branches 'pm-cpufreq' and 'pm-cpuidle'

on top of commit 40e8e98f512fc76891ae2328a63e2e4ffdbe3010

 Merge tag 'pm-6.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.5-rc1.

These add support for new hardware (ap807 and AM62A7), fix several issues
in cpufreq drivers and in the operating performance points (OPP) framework,
fix up intel_idle after recent changes and add documentation.

Specifics:

 - Add missing __init annotation to one function in the intel_idle
   driver (Rafael Wysocki).

 - Make intel_pstate use a correct scaling factor when mapping HWP
   performance levels to frequency values on hybrid-capable systems
   with disabled E-cores (Srinivas Pandruvada).

 - Fix Kconfig dependencies of the cpufreq-dt-platform driver (Viresh
   Kumar).

 - Add support to build cpufreq-dt-platdev as a module (Zhipeng Wang).

 - Don't allocate Sparc's cpufreq_driver dynamically (Viresh Kumar).

 - Add support for TI's AM62A7 platform (Vibhore Vardhan).

 - Add support for Armada's ap807 platform (Russell King (Oracle)).

 - Add support for StarFive JH7110 SoC (Mason Huo).

 - Fix voltage selection for Mediatek Socs (Daniel Golle).

 - Fix error handling in Tegra's cpufreq driver (Christophe JAILLET).

 - Document Qualcomm's IPQ8074 in DT bindings (Robert Marko).

 - Don't warn for disabling a non-existing frequency for imx6q cpufreq
   driver (Christoph Niedermaier).

 - Use dev_err_probe() in Qualcomm's cpufreq driver (Andrew Halaney).

 - Simplify performance state related logic in the OPP core (Viresh
   Kumar).

 - Fix use-after-free and improve locking around lazy_opp_tables (Viresh
   Kumar, Stephan Gerhold).

 - Minor cleanups - using dev_err_probe() and rate-limiting debug
   messages (Andrew Halaney, Adrián Larumbe).

Thanks!


---------------

Adrián Larumbe (1):
      OPP: rate-limit debug messages when no change in OPP is required

Andrew Halaney (3):
      cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when failing to
get icc paths
      OPP: Use dev_err_probe() when failing to get icc_path
      OPP: Properly propagate error along when failing to get icc_path

Christoph Niedermaier (1):
      cpufreq: imx6q: don't warn for disabling a non-existing frequency

Christophe JAILLET (1):
      cpufreq: tegra194: Fix an error handling path in tegra194_cpufreq_probe()

Daniel Golle (1):
      cpufreq: mediatek: correct voltages for MT7622 and MT7623

Mason Huo (1):
      cpufreq: dt-platdev: Add JH7110 SOC to the allowlist

Rafael J. Wysocki (1):
      intel_idle: Add __init annotation to matchup_vm_state_with_baremetal()

Robert Marko (1):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ8074

Russell King (Oracle) (1):
      cpufreq: armada-8k: add ap807 support

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix scaling for hybrid-capable systems
with disabled E-cores

Stephan Gerhold (1):
      opp: Fix use-after-free in lazy_opp_tables after probe deferral

Vibhore Vardhan (2):
      cpufreq: ti-cpufreq: Add support for AM62A7
      cpufreq: dt-platdev: Blacklist ti,am62a7 SoC

Viresh Kumar (7):
      cpufreq: sparc: Don't allocate cpufreq_driver dynamically
      OPP: Staticize `lazy_opp_tables` in of.c
      OPP: Protect `lazy_opp_tables` list with `opp_table_lock`
      OPP: don't drop performance constraint on OPP table removal
      OPP: pstate is only valid for genpd OPP tables
      OPP: Simplify the over-designed pstate <-> level dance
      cpufreq: Make CONFIG_CPUFREQ_DT_PLATDEV depend on OF

Zhipeng Wang (1):
      cpufreq: dt-platdev: Support building as module

---------------

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |  1 +
 drivers/cpufreq/Kconfig                            |  3 +-
 drivers/cpufreq/armada-8k-cpufreq.c                | 16 +++---
 drivers/cpufreq/cpufreq-dt-platdev.c               |  5 ++
 drivers/cpufreq/imx6q-cpufreq.c                    | 30 +++++------
 drivers/cpufreq/intel_pstate.c                     | 58 ++++++++++++++++++----
 drivers/cpufreq/mediatek-cpufreq.c                 | 13 +++--
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  2 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c               | 58 +++++++---------------
 drivers/cpufreq/sparc-us3-cpufreq.c                | 58 +++++++---------------
 drivers/cpufreq/tegra194-cpufreq.c                 |  6 ++-
 drivers/cpufreq/ti-cpufreq.c                       |  1 +
 drivers/idle/intel_idle.c                          |  2 +-
 drivers/opp/core.c                                 | 44 +++++++++-------
 drivers/opp/debugfs.c                              |  1 -
 drivers/opp/of.c                                   | 40 ++++++++-------
 drivers/opp/opp.h                                  |  6 +--
 17 files changed, 180 insertions(+), 164 deletions(-)
