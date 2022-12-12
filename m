Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01C64A54C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiLLQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiLLQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:52:38 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FF2AA;
        Mon, 12 Dec 2022 08:52:36 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id fu10so9474923qtb.0;
        Mon, 12 Dec 2022 08:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7HxV0X1+WqowedNa369L94qe5K3WbpADZLwYHiuUaA=;
        b=7xyJPOJTz6phkM30fEEKLEdDZqH9u35gG9RYUdf2gzTUAcxQ7L/G1RP113rKTVSL1z
         D/XxzNJOppgleihbQbEpEcwV081v3dognMlkc8zPMJeA/K3YGC1wrgGpBij5EdePhrjN
         Ikoz7Ou8HquikKTbicdyaZlCIC5QXHGIDSUWguJ0bXc+7mfFA8ypaV2wkvlev6h8hTUn
         r9fxJ0dPtoRo3Mm+duOVtOmnoFbsrra/OeX5lP+UhWlXS9hgaMHnRFFYus1Z5uQeO3OE
         8PG8qCOax4aXhhpTnwl62SettWbK9tqPLNPmFtkyXilPZNkh3OBI+uAZK3aGzZd6rnC2
         3nNg==
X-Gm-Message-State: ANoB5plA0+spbiZqpi5RgzEUGPBgW3X+w9QdHDBbMI1wEn5CAmWZRcax
        G+JLlXdZF0/Xlb9Nk3rWwt7vsa9kGe2v7iCLQi/Hh+06ZOU=
X-Google-Smtp-Source: AA0mqf4+rkpt1ltD7L/yiWJEk4haxUSVa8hCjCX+kcHHFGvMVjZrrjMDsgNThTcnkneTzNRgokG0PgWcWkwv4/v7e5U=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr87400342qtb.147.1670863955803; Mon, 12
 Dec 2022 08:52:35 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Dec 2022 17:52:24 +0100
Message-ID: <CAJZ5v0hWMeHrg-6eBdFUJXbv__mNw+byREMnHUiuy=Ktw7ttxw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.2-rc1

with top-most commit ed6a00471dd444af085164f987e3d5e8145da35a

 Merge branches 'pm-devfreq' and 'pm-tools'

on top of commit 76dcd734eca23168cb008912c0f69ff408905235

 Linux 6.1-rc8

to receive power management updates for 6.2-rc1.

These include two new drivers (cpufreq driver for Apple SoC CPU
P-states and the SCMI Powercap based power capping driver), other new
hardware support and driver extensions (Qualcomm cpufreq driver and
its DT bindings, TI cpufreq driver, intel_pstate, intel-uncore-freq),
a bunch of fixes and cleanups all over and a cpupower utility update
including new features related to RAPL support.

Specifics:

 - Fix nasty and hard to debug race condition introduced by mistake
   in the runtime PM core code and clean up that code somewhat on
   top of the fix (Rafael Wysocki).

 - Generalize of_perf_domain_get_sharing_cpumask phandle format (Hector
   Martin).

 - Add new cpufreq driver for Apple SoC CPU P-states (Hector Martin).

 - Update Qualcomm cpufreq driver, including:
   * CPU clock provider support,
   * Generic cleanups or reorganization.
   * Potential memleak fix.
   * Fix of the return value of cpufreq_driver->get().
   (Manivannan Sadhasivam, Chen Hui).

 - Update Qualcomm cpufreq driver's DT bindings, including:
   * Support for CPU clock provider.
   * Missing cache-related properties fixes.
   * Support for QDU1000/QRU1000.
   (Manivannan Sadhasivam, Rob Herring, Melody Olvera).

 - Add support for ti,am625 SoC and enable build of ti-cpufreq for
   ARCH_K3 (Dave Gerlach, and Vibhore Vardhan).

 - Use flexible array to simplify memory allocation in the tegra186
   cpufreq driver (Christophe JAILLET).

 - Convert cpufreq statistics code to use sysfs_emit_at() (ye xingchen).

 - Allow intel_pstate to use no-HWP mode on Sapphire Rapids (Giovanni
   Gherdovich).

 - Add missing pci_dev_put() to the amd_freq_sensitivity cpufreq driver
   (Xiongfeng Wang).

 - Initialize the kobj_unregister completion before calling
   kobject_init_and_add() in the cpufreq core code (Yongqiang Liu).

 - Defer setting boost MSRs in the ACPI cpufreq driver (Stuart Hayes,
   Nathan Chancellor).

 - Make intel_pstate accept initial EPP value of 0x80 (Srinivas
   Pandruvada).

 - Make read-only array sys_clk_src in the SPEAr cpufreq driver static
   (Colin Ian King).

 - Make array speeds in the longhaul cpufreq driver static (Colin Ian
   King).

 - Use str_enabled_disabled() helper in the ACPI cpufreq driver (Andy
   Shevchenko).

 - Drop a reference to CVS from cpufreq documentation (Conghui Wang).

 - Improve kernel messages printed by the PSCI cpuidle driver (Ulf
   Hansson).

 - Make the DT cpuidle driver return the correct number of parsed idle
   states, clean it up and clarify a comment in it (Ulf Hansson).

 - Modify the tasks freezing code to avoid using pr_cont() and refine an
   error message printed by it (Rafael Wysocki).

 - Make the hibernation core code complain about memory map mismatches
   during resume to help diagnostics (Xueqin Luo).

 - Fix mistake in a kerneldoc comment in the hibernation code (xiongxin).

 - Reverse the order of performance and enabling operations in the
   generic power domains code (Abel Vesa).

 - Power off[on] domains in hibernate .freeze[thaw]_noirq hook of in the
   generic power domains code (Abel Vesa).

 - Consolidate genpd_restore_noirq() and genpd_resume_noirq() (Shawn
   Guo).

 - Pass generic PM noirq hooks to genpd_finish_suspend() (Shawn Guo).

 - Drop generic power domain status manipulation during hibernate
   restore (Shawn Guo).

 - Fix compiler warnings with make W=1 in the idle_inject power capping
   driver (Srinivas Pandruvada).

 - Use kstrtobool() instead of strtobool() in the power capping sysfs
   interface (Christophe JAILLET).

 - Add SCMI Powercap based power capping driver (Cristian Marussi).

 - Add Emerald Rapids support to the intel-uncore-freq driver (Artem
   Bityutskiy).

 - Repair slips in kernel-doc comments in the generic notifier code
   (Lukas Bulwahn).

 - Fix several DT issues in the OPP library reorganize code around
   opp-microvolt-<named> DT property (Viresh Kumar).

 - Allow any of opp-microvolt, opp-microamp, or opp-microwatt properties
   to be present without the others present (James Calligeros).

 - Fix clock-latency-ns property in DT example (Serge Semin).

 - Add a private governor_data for devfreq governors (Kant Fan).

 - Reorganize devfreq code to use device_match_of_node() and
   devm_platform_get_and_ioremap_resource() instead of open coding
   them (ye xingchen, Minghao Chi).

 - Make cpupower choose base_cpu to display default cpupower details
   instead of picking CPU 0 (Saket Kumar Bhaskar).

 - Add Georgian translation to cpupower documentation (Zurab
   Kargareteli).

 - Introduce powercap intel-rapl library, powercap-info command, and
   RAPL monitor into cpupower (Thomas Renninger).

Thanks!


---------------

Abel Vesa (1):
      PM: domains: Reverse the order of performance and enabling ops

Andy Shevchenko (1):
      cpufreq: ACPI: Use str_enabled_disabled() helper

Artem Bityutskiy (1):
      platform/x86: intel-uncore-freq: add Emerald Rapids support

Chen Hui (1):
      cpufreq: qcom-hw: Fix memory leak in qcom_cpufreq_hw_read_lut()

Christophe JAILLET (2):
      powercap: Use kstrtobool() instead of strtobool()
      cpufreq: tegra186: Use flexible array to simplify memory allocation

Colin Ian King (2):
      cpufreq: longhaul: Make array speeds static const
      cpufreq: SPEAr: Make read-only array sys_clk_src static

Conghui Wang (1):
      cpufreq: Remove CVS version control contents from documentation

Cristian Marussi (1):
      powercap: arm_scmi: Add SCMI Powercap based driver

Dave Gerlach (4):
      cpufreq: ti-cpufreq: Add support for AM625
      cpufreq: dt-platdev: Blacklist ti,am625 SoC
      arm64: dts: ti: k3-am625: Introduce operating-points table
      cpufreq: ti: Enable ti-cpufreq for ARCH_K3

Giovanni Gherdovich (1):
      cpufreq: intel_pstate: Add Sapphire Rapids support in no-HWP mode

Hector Martin (2):
      cpufreq: Generalize of_perf_domain_get_sharing_cpumask phandle format
      cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states

James Calligeros (1):
      OPP: decouple dt properties in opp_parse_supplies()

Kant Fan (1):
      PM/devfreq: governor: Add a private governor_data for governor

Lukas Bulwahn (1):
      notifier: repair slips in kernel-doc comments

Manivannan Sadhasivam (7):
      cpufreq: qcom-hw: Remove un-necessary cpumask_empty() check
      cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
      cpufreq: qcom-hw: Use cached dev pointer in probe()
      cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq
      cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
      cpufreq: qcom-hw: Add CPU clock provider support

Melody Olvera (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QDU1000/QRU1000 cpufreq

Minghao Chi (1):
      PM / devfreq: event: use devm_platform_get_and_ioremap_resource()

Nathan Chancellor (1):
      cpufreq: ACPI: Remove unused variables 'acpi_cpufreq_online' and 'ret'

Rafael J. Wysocki (5):
      PM: runtime: Do not call __rpm_callback() from rpm_idle()
      PM: runtime: Relocate rpm_callback() right after __rpm_callback()
      PM: sleep: Avoid using pr_cont() in the tasks freezing code
      PM: sleep: Refine error message in try_to_freeze_tasks()
      PM: runtime: Adjust white space in the core code

Rob Herring (1):
      dt-bindings: cpufreq: qcom: Add missing cache related properties

Saket Kumar Bhaskar (1):
      tools/cpupower: Choose base_cpu to display default cpupower details

Serge Semin (1):
      dt-bindings: opp-v2: Fix clock-latency-ns prop in example

Shawn Guo (4):
      PM: domains: Drop genpd status manipulation for hibernate restore
      PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
      PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
      PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq hook

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Allow EPP 0x80 setting by the firmware
      powercap: idle_inject: Fix warnings with make W=1

Stuart Hayes (2):
      cpufreq: ACPI: Defer setting boost MSRs
      cpufreq: ACPI: Only set boost MSRs on supported CPUs

Thomas Renninger (2):
      cpupower: Introduce powercap intel-rapl library and powercap-info command
      cpupower: rapl monitor - shows the used power consumption in uj
for each rapl domain

Ulf Hansson (3):
      cpuidle: psci: Extend information in log about OSI/PC mode
      cpuidle: dt: Return the correct numbers of parsed idle states
      cpuidle: dt: Clarify a comment and simplify code in dt_init_idle_driver()

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am625-sk: Add 1.4GHz OPP

Viresh Kumar (4):
      dt-bindings: opp: Fix usage of current in microwatt property
      dt-bindings: opp: Fix named microwatt property
      OPP: Parse named opp-microwatt property too
      OPP: Simplify opp_parse_supplies() by restructuring it

Xiongfeng Wang (1):
      cpufreq: amd_freq_sensitivity: Add missing pci_dev_put()

Xueqin Luo (1):
      PM: hibernate: Complain about memory map mismatches during resume

Yongqiang Liu (1):
      cpufreq: Init completion before kobject_init_and_add()

Zurab Kargareteli (1):
      cpupower: Add Georgian translation

xiongxin (1):
      PM: hibernate: Fix mistake in kerneldoc comment

ye xingchen (3):
      PM / devfreq: Use device_match_of_node()
      PM / devfreq: event: Use device_match_of_node()
      cpufreq: stats: Convert to use sysfs_emit_at() API

---------------

 Documentation/cpu-freq/index.rst                   |   9 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |  31 +
 .../devicetree/bindings/opp/opp-v2-base.yaml       |   6 +-
 Documentation/devicetree/bindings/opp/opp-v2.yaml  |   2 +-
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             |   9 +
 arch/arm64/boot/dts/ti/k3-am625.dtsi               |  51 ++
 drivers/base/power/domain.c                        | 150 ++--
 drivers/base/power/runtime.c                       | 145 +--
 drivers/cpufreq/Kconfig.arm                        |  13 +-
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/acpi-cpufreq.c                     |  43 +-
 drivers/cpufreq/amd_freq_sensitivity.c             |   2 +
 drivers/cpufreq/apple-soc-cpufreq.c                | 352 ++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/cpufreq.c                          |   2 +-
 drivers/cpufreq/cpufreq_stats.c                    |  16 +-
 drivers/cpufreq/intel_pstate.c                     |  10 +-
 drivers/cpufreq/longhaul.c                         |   4 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |  14 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 206 +++--
 drivers/cpufreq/spear-cpufreq.c                    |   2 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |  11 +-
 drivers/cpufreq/ti-cpufreq.c                       |  36 +
 drivers/cpuidle/cpuidle-psci-domain.c              |   3 +-
 drivers/cpuidle/dt_idle_states.c                   |  11 +-
 drivers/devfreq/devfreq-event.c                    |   2 +-
 drivers/devfreq/devfreq.c                          |   8 +-
 drivers/devfreq/event/exynos-nocp.c                |   3 +-
 drivers/devfreq/governor_userspace.c               |  12 +-
 drivers/opp/of.c                                   | 228 +++--
 .../x86/intel/uncore-frequency/uncore-frequency.c  |   1 +
 drivers/powercap/Kconfig                           |  13 +
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/arm_scmi_powercap.c               | 509 +++++++++++
 drivers/powercap/idle_inject.c                     |   3 +
 drivers/powercap/powercap_sys.c                    |   3 +-
 include/linux/cpufreq.h                            |  28 +-
 include/linux/devfreq.h                            |   7 +-
 kernel/notifier.c                                  |   6 +-
 kernel/power/process.c                             |  25 +-
 kernel/power/snapshot.c                            |  12 +-
 tools/power/cpupower/Makefile                      |  15 +-
 tools/power/cpupower/lib/powercap.c                | 290 ++++++
 tools/power/cpupower/lib/powercap.h                |  54 ++
 tools/power/cpupower/man/cpupower-powercap-info.1  |  25 +
 tools/power/cpupower/po/ka.po                      | 983 +++++++++++++++++++++
 tools/power/cpupower/utils/builtin.h               |   2 +
 tools/power/cpupower/utils/cpufreq-info.c          |   4 +-
 tools/power/cpupower/utils/cpuidle-info.c          |   4 +-
 tools/power/cpupower/utils/cpupower-info.c         |   4 +-
 tools/power/cpupower/utils/cpupower.c              |   1 +
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |   7 +-
 .../cpupower/utils/idle_monitor/idle_monitors.def  |   1 +
 .../cpupower/utils/idle_monitor/rapl_monitor.c     | 148 ++++
 tools/power/cpupower/utils/powercap-info.c         | 117 +++
 tools/power/pm-graph/sleepgraph.py                 |   2 +-
 57 files changed, 3132 insertions(+), 519 deletions(-)
