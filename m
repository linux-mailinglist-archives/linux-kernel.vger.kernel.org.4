Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CA6EE9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjDYWAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjDYWAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:00:03 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF09C167;
        Tue, 25 Apr 2023 14:59:58 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-187de655f15so2563811fac.3;
        Tue, 25 Apr 2023 14:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682459997; x=1685051997;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g83TrdrOaVoK4GEo5wExmHqkdH+owVXyvSQpvIzsVFw=;
        b=YICfcCbrPnXhHq9y+t5GRqo0gHODwRv8shW3MA16WUeKCoXCQmsURgscJGyxfO7KbD
         1yD2RVHDHcIFR0t0Njlt2MBNkrfVt+8jkQvYOLdJAVcBRGtrhYoSfUrQ0+QnX4fN9WSX
         87oacxi2NYQkPggIK3Z8g+lVOj7uybb++w3RQQMo5I7+IJBA2VGMjB6EvpKAlR0Jt15Q
         PbrC2l6ROeaFY7dAVqaY6FMv/w5o6SZPkC95YV0whUmq9nxf14xqhF3bySBd1NVZm/3F
         JkDOcuvMu5w/80YmX6M3hkWbUPTVDhSJepCtSyzJsfS7A0wi0tfotQ+gbjeuBNowoBEY
         66Hw==
X-Gm-Message-State: AAQBX9eVq/dx0mdCfEtqajnrgTMR+GRrn9jfP7QuJy3xUhFmsGyOT456
        fAdIWeRzvFvH2QbJZJ7iMw==
X-Google-Smtp-Source: AKy350a+JeehJFDan1WaIL8v6C8hTujDTC4eGxGe1ESfoEi0j8yD5JB8GmL5QqHaoE9cF8r2FRErjg==
X-Received: by 2002:a05:6870:a11a:b0:180:be0e:299f with SMTP id m26-20020a056870a11a00b00180be0e299fmr13289445oae.0.1682459997537;
        Tue, 25 Apr 2023 14:59:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n3-20020a056870e40300b00172ac40356csm5925211oag.50.2023.04.25.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:59:57 -0700 (PDT)
Received: (nullmailer pid 2286987 invoked by uid 1000);
        Tue, 25 Apr 2023 21:59:56 -0000
Date:   Tue, 25 Apr 2023 16:59:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL 2/2] Devicetree updates for v6.4
Message-ID: <20230425215956.GA2285208-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 2/2 DT updates. I ended up with this branch merged in at 
the top of my tree, so I'm just sending it to you separately. 

There's a 2 merge conflicts with char-misc tree. linux-next has the 
correct resolutions.

Rob


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.4-2

for you to fetch changes up to 1c5e9170ad93d3bd62a7ed8380e60b62c88b90a8:

  bus: tegra-gmi: Replace of_platform.h with explicit includes (2023-04-21 09:20:56 -0500)

----------------------------------------------------------------
Devicetree updates for v6.4, part 2:

- First part of DT header detangling dropping cpu.h from of_device.h
  and replacing some includes with forward declarations. A handful of
  drivers needed some adjustment to their includes as a result.

- Refactor of_device.h to be used by bus drivers rather than various
  device drivers. This moves non-bus related functions out of
  of_device.h. The end goal is for of_platform.h and of_device.h to stop
  including each other.

- Refactor open coded parsing of "ranges" in some bus drivers to use DT
  address parsing functions

- Add some new address parsing functions of_property_read_reg(),
  of_range_count(), and of_range_to_resource() in preparation to convert
  more open coded parsing of DT addresses to use them.

- Treewide clean-ups to use of_property_read_bool() and
  of_property_present() as appropriate. The ones here are the ones
  that didn't get picked up elsewhere.

----------------------------------------------------------------
Rob Herring (34):
      bus: uniphier-system-bus: Remove open coded "ranges" parsing
      of: Make devtree_lock declaration private
      of: Move of_device_(add|register|unregister) to of_platform.h
      of: Move of_device_get_match_data() declaration
      of: Move CPU node related functions to their own file
      of: Drop unnecessary includes in headers
      ARM: sunxi: Drop of_device.h include
      ARM: cpuidle: Drop of_device.h include
      riscv: Add explicit include for cpu.h
      riscv: cacheinfo: Adjust includes to remove of_device.h
      cacheinfo: Adjust includes to remove of_device.h
      clocksource: ingenic: Add explicit include for cpuhotplug.h
      thermal: cpuidle_cooling: Adjust includes to remove of_device.h
      soc: mediatek: mtk-svs: Add explicit include for cpu.h
      cpufreq: Adjust includes to remove of_device.h
      cpufreq: sun50i: Add explicit include for cpu.h
      cpuidle: Adjust includes to remove of_device.h
      irqchip: loongson-eiointc: Add explicit include for cpuhotplug.h
      OPP: Adjust includes to remove of_device.h
      of: Drop cpu.h include from of_device.h
      of: unittest: Add bus address range parsing tests
      of/address: Add of_range_to_resource() helper
      of/address: Add support for 3 address cell bus
      of/address: Add of_range_count() helper
      of/address: Add of_property_read_reg() helper
      bus: mvebu-mbus: Remove open coded "ranges" parsing
      sparc: Use of_property_present() for testing DT property presence
      sparc: Use of_property_read_bool() for boolean properties
      sbus: display7seg: Use of_property_read_bool() for boolean properties
      soc: fsl: Use of_property_present() for testing DT property presence
      virt: fsl: Use of_property_present() for testing DT property presence
      w1: w1-gpio: Use of_property_read_bool() for boolean properties
      hte: Use of_property_present() for testing DT property presence
      bus: tegra-gmi: Replace of_platform.h with explicit includes

 arch/arm/kernel/cpuidle.c                   |   1 -
 arch/arm/mach-sunxi/mc_smp.c                |   1 -
 arch/riscv/kernel/cacheinfo.c               |   1 -
 arch/riscv/kernel/setup.c                   |   2 +-
 arch/sparc/include/asm/prom.h               |   3 +
 arch/sparc/kernel/of_device_32.c            |   4 +-
 arch/sparc/kernel/of_device_64.c            |   6 +-
 arch/sparc/kernel/of_device_common.c        |   2 +-
 arch/sparc/kernel/pci_schizo.c              |   2 +-
 arch/sparc/kernel/power.c                   |   2 +-
 arch/sparc/kernel/prom_64.c                 |   2 +-
 arch/sparc/kernel/time_32.c                 |   2 +-
 drivers/base/cacheinfo.c                    |   2 +-
 drivers/bus/mvebu-mbus.c                    |  58 ++------
 drivers/bus/tegra-gmi.c                     |   4 +-
 drivers/bus/uniphier-system-bus.c           |  54 ++-----
 drivers/clocksource/ingenic-timer.c         |   3 +-
 drivers/cpufreq/cpufreq-dt-platdev.c        |   1 -
 drivers/cpufreq/kirkwood-cpufreq.c          |   2 +-
 drivers/cpufreq/maple-cpufreq.c             |   2 +-
 drivers/cpufreq/pmac32-cpufreq.c            |   2 +-
 drivers/cpufreq/pmac64-cpufreq.c            |   2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c           |   4 +-
 drivers/cpufreq/spear-cpufreq.c             |   2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c      |   3 +-
 drivers/cpufreq/tegra124-cpufreq.c          |   1 -
 drivers/cpufreq/tegra20-cpufreq.c           |   2 +-
 drivers/cpuidle/cpuidle-psci.c              |   1 -
 drivers/cpuidle/cpuidle-qcom-spm.c          |   3 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c         |   2 +-
 drivers/cpuidle/dt_idle_states.c            |   1 -
 drivers/hte/hte.c                           |   2 +-
 drivers/irqchip/irq-loongson-eiointc.c      |   5 +-
 drivers/of/Makefile                         |   2 +-
 drivers/of/address.c                        |  76 +++++++++-
 drivers/of/base.c                           | 187 -------------------------
 drivers/of/cpu.c                            | 210 ++++++++++++++++++++++++++++
 drivers/of/of_private.h                     |   1 +
 drivers/of/unittest-data/tests-address.dtsi |   9 +-
 drivers/of/unittest.c                       | 150 ++++++++++++++++++++
 drivers/opp/of.c                            |   2 +-
 drivers/sbus/char/display7seg.c             |   5 +-
 drivers/soc/fsl/qbman/dpaa_sys.c            |   8 +-
 drivers/soc/mediatek/mtk-svs.c              |   1 +
 drivers/thermal/cpuidle_cooling.c           |   3 +-
 drivers/virt/fsl_hypervisor.c               |   2 +-
 drivers/w1/masters/w1-gpio.c                |   2 +-
 include/linux/cpufreq.h                     |   1 -
 include/linux/of.h                          |  32 +++--
 include/linux/of_address.h                  |  31 ++++
 include/linux/of_device.h                   |  29 +---
 include/linux/of_platform.h                 |  10 +-
 52 files changed, 568 insertions(+), 377 deletions(-)
 create mode 100644 drivers/of/cpu.c
