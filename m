Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC076995F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBPNk5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Feb 2023 08:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBPNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:40:56 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D6C4C6FD;
        Thu, 16 Feb 2023 05:40:54 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id v11so432826edx.12;
        Thu, 16 Feb 2023 05:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hmg5RzB21Jr5bKY7vwvW6Iqw9vw+rKTENWRtMlyFWmU=;
        b=2vhfxYnCbuuHGl+9DCdVesrRXkr42TK2tvm2RqvWJ9xajCWk4T8NZnk0RNjBo2vuvu
         nXwLJe79dpzB3dZnJoqIJhARTlGElWt3Cv/hmo5S24c5jubREW4ifRn6eDa+13fNmCVT
         sLVlY2OzK1BVzTcsof5Y/Jq8zTkMT08uW2kb0oWXWwiomRlrnYHa2qub0HLP+XqrGglC
         fpvNU3RhL+z7rrPRWmcPftu5MBjensKTWwJKZ6YvB2Dv6re9xnwkf+iu1DTmnA4e9c7F
         rnY28dXR5yqCl11MrBqoJjZXdh6e3g+Od5+RPv5+kCOOX3vdDtq1VYIkyF51zP9/2t+O
         tHjA==
X-Gm-Message-State: AO0yUKWHPYV0OIksGnKCLwmBN8xtyiFPhAc7dNRxE78EUEcD0pPFXrjs
        zx0QHMEhUqlZ4QEH0iUxgNZTCJHvUZsA30L7d1KCZoD2ksE=
X-Google-Smtp-Source: AK7set+mTz4bhi1FTDeS7s30RSNQAYyIcpkwuBlx4Fv8RzuSM5jsLS7v5vHiQa9jX4tuC8/lcCq/qtlTo5FkwWWxiFA=
X-Received: by 2002:a17:906:4e4d:b0:8b1:3298:c587 with SMTP id
 g13-20020a1709064e4d00b008b13298c587mr2916547ejw.2.1676554852886; Thu, 16 Feb
 2023 05:40:52 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Feb 2023 14:40:41 +0100
Message-ID: <CAJZ5v0iCmhEQSVZ8nKPZz63uQ+svRst_3N-WoxwOa617H4h9=w@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm sending this ahead of time, because I will be traveling next week
and I don't want to delay the integration of the changes below just
because of my absence.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.3-rc1

with top-most commit dd855f01e8d194d2dfeda36b620203c623c10430

 Merge branches 'pm-tools' and 'pm-docs'

on top of commit 6f098cde9df2c86d60db727d6270272751943674

 cpufreq: qcom-hw: Add missing null pointer check

to receive power management updates for 6.3-rc1.

These add EPP support to the AMD P-state cpufreq driver, add support for
new platforms to the Intel RAPL power capping driver, intel_idle and the
Qualcomm cpufreq driver, enable thermal cooling for Tegra194, drop the
custom cpufreq driver for loongson1 that is not necessary any more (and
the corresponding cpufreq platform device), fix assorted issues and
clean up code.

Specifics:

 - Add EPP support to the AMD P-state cpufreq driver (Perry Yuan, Wyes
   Karny, Arnd Bergmann, Bagas Sanjaya).

 - Drop the custom cpufreq driver for loongson1 that is not necessary
   any more and the corresponding cpufreq platform device (Keguang
   Zhang).

 - Remove "select SRCU" from system sleep, cpufreq and OPP Kconfig
   entries (Paul E. McKenney).

 - Enable thermal cooling for Tegra194 (Yi-Wei Wang).

 - Register module device table and add missing compatibles for
   cpufreq-qcom-hw (Nícolas F. R. A. Prado, Abel Vesa and Luca Weiss).

 - Various dt binding updates for qcom-cpufreq-nvmem and opp-v2-kryo-cpu
   (Christian Marangi).

 - Make kobj_type structure in the cpufreq core constant (Thomas
   Weißschuh).

 - Make cpufreq_unregister_driver() return void (Uwe Kleine-König).

 - Make the TEO cpuidle governor check CPU utilization in order to refine
   idle state selection (Kajetan Puchalski).

 - Make Kconfig select the haltpoll cpuidle governor when the haltpoll
   cpuidle driver is selected and replace a default_idle() call in that
   driver with arch_cpu_idle() to allow MWAIT to be used (Li RongQing).

 - Add Emerald Rapids Xeon support to the intel_idle driver (Artem
   Bityutskiy).

 - Add ARCH_SUSPEND_POSSIBLE dependencies for ARMv4 cpuidle drivers to
   avoid randconfig build failures (Arnd Bergmann).

 - Make kobj_type structures used in the cpuidle sysfs interface
   constant (Thomas Weißschuh).

 - Make the cpuidle driver registration code update microsecond values
   of idle state parameters in accordance with their nanosecond values
   if they are provided (Rafael Wysocki).

 - Make the PSCI cpuidle driver prevent topology CPUs from being
   suspended on PREEMPT_RT (Krzysztof Kozlowski).

 - Document that pm_runtime_force_suspend() cannot be used with
   DPM_FLAG_SMART_SUSPEND (Richard Fitzgerald).

 - Add EXPORT macros for exporting PM functions from drivers (Richard
   Fitzgerald).

 - Remove /** from non-kernel-doc comments in hibernation code (Randy
   Dunlap).

 - Fix possible name leak in powercap_register_zone() (Yang Yingliang).

 - Add Meteor Lake and Emerald Rapids support to the intel_rapl power
   capping driver (Zhang Rui).

 - Modify the idle_inject power capping facility to support 100% idle
   injection (Srinivas Pandruvada).

 - Fix large time windows handling in the intel_rapl power capping
   driver (Zhang Rui).

 - Fix memory leaks with using debugfs_lookup() in the generic PM
   domains and Energy Model code (Greg Kroah-Hartman).

 - Add missing 'cache-unified' property in the example for kryo OPP
   bindings (Rob Herring).

 - Fix error checking in opp_migrate_dentry() (Qi Zheng).

 - Let qcom,opp-fuse-level be a 2-long array for qcom SoCs (Konrad
   Dybcio).

 - Modify some power management utilities to use the canonical ftrace
   path (Ross Zwisler).

 - Correct spelling problems for Documentation/power/ as reported by
   codespell (Randy Dunlap).

Thanks!


---------------

Abel Vesa (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550 compatible

Arnd Bergmann (2):
      cpufreq: amd-pstate: avoid uninitialized variable use
      cpuidle: add ARCH_SUSPEND_POSSIBLE dependencies

Artem Bityutskiy (1):
      intel_idle: add Emerald Rapids Xeon support

Bagas Sanjaya (1):
      Documentation: amd-pstate: disambiguate user space sections

Christian Marangi (3):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify supported opp tables
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
      dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum

Greg Kroah-Hartman (2):
      PM: domains: fix memory leak with using debugfs_lookup()
      PM: EM: fix memory leak with using debugfs_lookup()

Kajetan Puchalski (2):
      cpuidle: teo: Optionally skip polling states in teo_find_shallower_state()
      cpuidle: teo: Introduce util-awareness

Keguang Zhang (2):
      cpufreq: loongson1: Delete obsolete driver
      MIPS: loongson32: Drop obsolete cpufreq platform device

Konrad Dybcio (1):
      dt-bindings: opp: v2-qcom-level: Let qcom,opp-fuse-level be a 2-long array

Krzysztof Kozlowski (1):
      cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT

Li RongQing (2):
      cpuidle-haltpoll: select haltpoll governor
      cpuidle-haltpoll: Replace default_idle() with arch_cpu_idle()

Luca Weiss (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing compatibles

Nícolas F. R. A. Prado (1):
      cpufreq: mediatek-hw: Register to module device table

Paul E. McKenney (3):
      drivers/opp: Remove "select SRCU"
      drivers/cpufreq: Remove "select SRCU"
      PM: sleep: Remove "select SRCU"

Perry Yuan (10):
      ACPI: CPPC: Add AMD pstate energy performance preference cppc control
      Documentation: amd-pstate: add EPP profiles introduction
      cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors
      cpufreq: amd-pstate: implement amd pstate cpu online and offline callback
      cpufreq: amd-pstate: implement suspend and resume callbacks
      cpufreq: amd-pstate: add driver working mode switch support
      Documentation: amd-pstate: add amd pstate driver mode introduction
      Documentation: introduce amd pstate active mode kernel command
line options
      cpufreq: amd-pstate: convert sprintf with sysfs_emit()
      Documentation: amd-pstate: introduce new global sysfs attributes

Qi Zheng (1):
      OPP: fix error checking in opp_migrate_dentry()

Rafael J. Wysocki (1):
      cpuidle: driver: Update microsecond values of state parameters as needed

Randy Dunlap (2):
      PM: hibernate: swap: don't use /** for non-kernel-doc comments
      Documentation: power: correct spelling

Richard Fitzgerald (2):
      PM: runtime: Document that force_suspend() is incompatible with
SMART_SUSPEND
      PM: Add EXPORT macros for exporting PM functions

Rob Herring (1):
      dt-bindings: opp: opp-v2-kryo-cpu: Add missing 'cache-unified'
property in example

Ross Zwisler (1):
      PM: tools: use canonical ftrace path

Srinivas Pandruvada (1):
      powercap: idle_inject: Support 100% idle injection

Thomas Weißschuh (2):
      cpufreq: Make kobj_type structure constant
      cpuidle: sysfs: make kobj_type structures constant

Uwe Kleine-König (2):
      cpufreq: Make cpufreq_unregister_driver() return void
      cpufreq: davinci: Fix clk use after free

Wyes Karny (2):
      cpufreq: amd-pstate: optimize driver working mode selection in
amd_pstate_param()
      cpufreq: amd-pstate: Fix invalid write to MSR_AMD_CPPC_REQ

Yang Yingliang (1):
      powercap: fix possible name leak in powercap_register_zone()

Yi-Wei Wang (1):
      cpufreq: tegra194: Enable CPUFREQ thermal cooling

Zhang Rui (3):
      powercap: intel_rapl: add support for Meteor Lake
      powercap: intel_rapl: add support for Emerald Rapids
      powercap: intel_rapl: Fix handling for large time window

---------------

 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst        |  78 ++-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   5 +
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |  81 ++-
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   |  18 +-
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   4 +-
 Documentation/power/suspend-and-interrupts.rst     |   2 +-
 arch/mips/include/asm/mach-loongson32/cpufreq.h    |  18 -
 arch/mips/include/asm/mach-loongson32/platform.h   |   1 -
 arch/mips/loongson32/common/platform.c             |  16 -
 arch/mips/loongson32/ls1b/board.c                  |   1 -
 arch/x86/kernel/process.c                          |   1 +
 drivers/acpi/cppc_acpi.c                           |  67 ++
 drivers/base/power/domain.c                        |   5 +-
 drivers/base/power/runtime.c                       |   4 +
 drivers/cpufreq/Kconfig                            |  10 -
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/amd-pstate.c                       | 705 ++++++++++++++++++++-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   5 +-
 drivers/cpufreq/cpufreq.c                          |  10 +-
 drivers/cpufreq/davinci-cpufreq.c                  |   4 +-
 drivers/cpufreq/loongson1-cpufreq.c                | 222 -------
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   5 +-
 drivers/cpufreq/omap-cpufreq.c                     |   4 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   4 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |   3 +-
 drivers/cpuidle/Kconfig                            |   1 +
 drivers/cpuidle/Kconfig.arm                        |  10 +
 drivers/cpuidle/cpuidle-haltpoll.c                 |   2 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |   7 +-
 drivers/cpuidle/cpuidle-psci.c                     |   3 +
 drivers/cpuidle/driver.c                           |   4 +
 drivers/cpuidle/governors/teo.c                    | 102 ++-
 drivers/cpuidle/sysfs.c                            |   6 +-
 drivers/idle/intel_idle.c                          |   2 +
 drivers/opp/Kconfig                                |   1 -
 drivers/opp/debugfs.c                              |   2 +-
 drivers/powercap/idle_inject.c                     |   6 +-
 drivers/powercap/intel_rapl_common.c               |  13 +-
 drivers/powercap/powercap_sys.c                    |  14 +-
 include/acpi/cppc_acpi.h                           |  12 +
 include/linux/amd-pstate.h                         |  32 +
 include/linux/cpufreq.h                            |   2 +-
 include/linux/pm.h                                 |   4 +
 kernel/power/Kconfig                               |   1 -
 kernel/power/energy_model.c                        |   5 +-
 kernel/power/swap.c                                |  16 +-
 tools/power/pm-graph/sleepgraph.py                 |   4 +-
 .../x86/amd_pstate_tracer/amd_pstate_trace.py      |   4 +-
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  10 +-
 50 files changed, 1160 insertions(+), 384 deletions(-)
