Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4DC74C819
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 22:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGIUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGIUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 16:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5045D100;
        Sun,  9 Jul 2023 13:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A5D60C50;
        Sun,  9 Jul 2023 20:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4AEC433C8;
        Sun,  9 Jul 2023 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688934290;
        bh=bZad9AEBbM7WypzAzA7gZpA5IZHk6durLwKA/F5VEl4=;
        h=From:To:Cc:Subject:Date:From;
        b=URd5Sgr5QQedN4B3vxtlNR5I1Y8U8ST6ZKnBrAD3yfXxJo11aAHWONu1WUzOKTr79
         7AYVCzI6Z2cto6RcPPe8vqhzp37Dbn83meis5VCTrpR2EUB+AIlgw2xVKnfeH5952s
         VNLvIw/0jx6igOCzIQ9L9p9lXaPri+cHmrAX5EXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.3 000/425] 6.3.13-rc2 review
Date:   Sun,  9 Jul 2023 22:24:44 +0200
Message-ID: <20230709202353.266998088@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.13-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.13-rc2
X-KernelTest-Deadline: 2023-07-11T20:24+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.3.13 release.
There are 425 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 11 Jul 2023 20:22:29 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.13-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.13-rc2

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: fix casting from randomized structure in raid1_submit_write()

Thomas Gleixner <tglx@linutronix.de>
    x86/efi: Make efi_set_virtual_address_map IBT safe

Will Deacon <will@kernel.org>
    arm64: sme: Use STR P to clear FFR context field in streaming SVE mode

Arnd Bergmann <arnd@arndb.de>
    ksmbd: avoid field overflow warning

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix shared DFS root mounts with different prefixes

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix broken file attrs with nodfs mounts

Shyam Prasad N <sprasad@microsoft.com>
    cifs: do all necessary checks for credits within or before locking

Shyam Prasad N <sprasad@microsoft.com>
    cifs: prevent use-after-free by freeing the cfile later

Ard Biesheuvel <ardb@kernel.org>
    efi/libstub: Disable PCI DMA before grabbing the EFI memory map

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: deb-pkg: remove the CONFIG_MODULES check in buildeb

Josh Triplett <josh@joshtriplett.org>
    kbuild: builddeb: always make modules_install, to install modules.builtin*

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Fix state transitions after reset failure

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Flag partially torn down regions as unusable

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Move cache invalidation before region teardown, and before setup

Sami Tolvanen <samitolvanen@google.com>
    kbuild: Disable GCOV for *.mod.o

Sami Tolvanen <samitolvanen@google.com>
    kbuild: Fix CFI failures with GCOV

Martin Kaiser <martin@kaiser.cx>
    hwrng: st - keep clock enabled while hwrng is registered

Tarun Sahu <tsahu@linux.ibm.com>
    dax/kmem: Pass valid argument to memory_group_register_static

Dan Williams <dan.j.williams@intel.com>
    dax: Introduce alloc_dev_dax_id()

Dan Williams <dan.j.williams@intel.com>
    dax: Fix dax_mapping_release() use after free

Bharath SM <bharathsm@microsoft.com>
    SMB3: Do not send lease break acknowledgment if all file handles have been closed

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Qi Zheng <zhengqi.arch@bytedance.com>
    NFSv4.2: fix wrong shrinker_id

Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
    crypto: qat - unmap buffers before free for RSA

Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
    crypto: qat - unmap buffer before free for DH

Masahiro Yamada <masahiroy@kernel.org>
    ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Dan Carpenter <dan.carpenter@linaro.org>
    modpost: fix off by one in is_executable_section()

Stephan Müller <smueller@chronox.de>
    crypto: jitter - correct health test during initialization

Arnd Bergmann <arnd@arndb.de>
    crypto: marvell/cesa - Fix type mismatch warning

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_ABS32

Randy Dunlap <rdunlap@infradead.org>
    crypto: nx - fix build warnings when DEBUG_FS is not enabled

Masahiro Yamada <masahiroy@kernel.org>
    modpost: remove broken calculation of exception_table_entry size

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: virtio - Fix race on data_avail and actual data

Eric Farman <farman@linux.ibm.com>
    vfio/mdev: Move the compat_class initialization to module init

Xinghui Li <korantli@tencent.com>
    PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction

Shunsuke Mie <mie@igel.co.jp>
    PCI: endpoint: Fix a Kconfig prompt of vNTB driver

Namhyung Kim <namhyung@kernel.org>
    perf test: Set PERF_EXEC_PATH for script execution

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo

Tiezhu Yang <yangtiezhu@loongson.cn>
    riscv: uprobes: Restore thread.bad_cause

Xi Pardee <xi.pardee@intel.com>
    platform/x86:intel/pmc: Update maps for Meteor Lake P/M platforms

Aditya Gupta <adityag@linux.ibm.com>
    powerpc: update ppc_save_regs to save current r1 in pt_regs

Colin Ian King <colin.i.king@gmail.com>
    powerpc/powernv/sriov: perform null check on iov before dereferencing iov

Stanley Chu <stanley.chu@mediatek.com>
    scsi: ufs: core: mcq: Fix the incorrect OCS value for the device command

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Remove a ufshcd_add_command_trace() call

Namhyung Kim <namhyung@kernel.org>
    perf stat: Reset aggr stats for each run

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: at91-pio4: check return value of devm_kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: microchip-sgpio: check return value of devm_kasprintf()

Xiaolei Wang <xiaolei.wang@windriver.com>
    pinctrl: freescale: Fix a memory out of bounds when num_configs is 1

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix VAS mm use after free

Ian Rogers <irogers@google.com>
    perf tool x86: Fix perf_env memory leak

Ravi Bangoria <ravi.bangoria@amd.com>
    perf tool x86: Consolidate is_amd check into single function

Michal Wilczynski <michal.wilczynski@intel.com>
    platform/x86/dell/dell-rbtn: Fix resources leaking on error path

Aditya Gupta <adityag@linux.ibm.com>
    perf tests task_analyzer: Skip tests if no libtraceevent support

Aditya Gupta <adityag@linux.ibm.com>
    perf tests task_analyzer: Fix bad substitution ${$1}

Namhyung Kim <namhyung@kernel.org>
    perf dwarf-aux: Fix off-by-one in die_get_varname()

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform profiles

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf script: Fix allocation of evsel->priv related to per-event dump files

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()

Christophe Leroy <christophe.leroy@csgroup.eu>
    kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pinctrl: npcm7xx: Add missing check for ioremap

Wells Lu <wellslutw@gmail.com>
    pinctrl:sunplus: Add check for kmalloc

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: think-lmi: Correct NVME password handling

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: think-lmi: Correct System password interface

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: think-lmi: mutex protection around multiple WMI calls

Xi Pardee <xi.pardee@intel.com>
    platform/x86:intel/pmc: Remove Meteor Lake S platform support

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cherryview: Return correct value if pin in push-pull mode

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf bench: Add missing setlocale() call to allow usage of %'d style formatting

Thierry Reding <treding@nvidia.com>
    pinctrl: tegra: Duplicate pinmux functions table

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Fix handling of lrbp->cmd

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Increase the START STOP UNIT timeout from one to ten seconds

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Revise NPIV ELS unsol rcv cmpl logic to drop ndlp based on nlp_state

Sui Jingfeng <suijingfeng@loongson.cn>
    PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: Declare ufshcd_{hold,release}() once

Wells Lu <wellslutw@gmail.com>
    pinctrl: sunplus: Add check for kmalloc

Junyan Ye <yejunyan@hust.edu.cn>
    PCI: ftpci100: Release the clock resources

Ian Rogers <irogers@google.com>
    perf evsel: Don't let for_each_group() treat the head of the list as one of its nodes

Rongguang Wei <weirongguang@kylinos.cn>
    PCI: pciehp: Cancel bringup sequence if card is not present

Dan Carpenter <dan.carpenter@linaro.org>
    pinctrl: at91: fix a couple NULL vs IS_ERR() checks

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: at91: Use dev_err_probe() instead of custom messaging

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: at91: Don't mix non-devm calls with devm ones

Yuchen Yang <u202114568@hust.edu.cn>
    scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

Ding Hui <dinghui@sangfor.com.cn>
    PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free

Hans de Goede <hdegoede@redhat.com>
    platform/x86: lenovo-yogabook: Set default keyboard backligh brightness on probe()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: lenovo-yogabook: Reprobe devices on remove()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: lenovo-yogabook: Fix work race on remove()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors

Jinhong Zhu <jinhongzhu@hust.edu.cn>
    scsi: qedf: Fix NULL dereference in error handling

Nirmal Patel <nirmal.patel@linux.intel.com>
    PCI: vmd: Reset VMD config register between soft reboots

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: cadence: Fix Gen2 Link Retraining process

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Call iopt_area_contig_done() under the lock

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Do not access the area pointer after unlocking

Paul Cercueil <paul@crapouillou.net>
    MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts

Paul Cercueil <paul@crapouillou.net>
    MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators

Syed Saba Kareem <Syed.SabaKareem@amd.com>
    ASoC: amd: acp: clear pdm dma interrupt mask

Michael Walle <mwalle@kernel.org>
    ARM: dts: lan966x: kontron-d10: fix SPI CS

Michael Walle <mwalle@kernel.org>
    ARM: dts: lan966x: kontron-d10: fix board reset

Fei Shao <fshao@chromium.org>
    clk: Fix memory leak in devm_clk_notifier_register()

Claudiu Beznea <claudiu.beznea@microchip.com>
    ASoC: imx-audmix: check return value of devm_kasprintf()

Amir Goldstein <amir73il@gmail.com>
    ovl: update of dentry revalidate flags after copy up

Alexey Romanov <avromanov@sberdevices.ru>
    drivers: meson: secure-pwrc: always enable DMA domain

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: ti: clkctrl: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: keystone: sci-clk: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: free unused memory on probe failure

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: check return value of {devm_}kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: return error if one synth clock registration fails

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: cdce925: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: vc5: check memory returned by kasprintf()

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not released issue

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mt8173-apmixedsys: Fix return value for of_iomap() error

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: correct MERGE_3D length

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Fix usage of UMC fill record in RAS

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Fix memcpy() in sienna_cichlid_append_powerplay_table function.

Daniel Golle <daniel@makrotopia.org>
    arm64: dts: mt7986: increase bl2 partition on NAND of Bananapi R3

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz

Allen-KH Cheng <allen-kh.cheng@mediatek.com>
    arm64: dts: mediatek: Add cpufreq nodes for MT8192

Bjorn Andersson <quic_bjorande@quicinc.com>
    drm/msm/dp: Free resources after unregistering them

Bjorn Andersson <quic_bjorande@quicinc.com>
    drm/msm/dp: Drop aux devices together with DP controller

Jessica Zhang <quic_jesszhan@quicinc.com>
    drm/msm/dsi: Remove incorrect references to slice_count

Jessica Zhang <quic_jesszhan@quicinc.com>
    drm/msm/dpu: Fix slice_last_group_size calculation

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: do not enable color-management if DSPPs are not available

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Nishanth Menon <nm@ti.com>
    arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias

Thejasvi Konduru <t-konduru@ti.com>
    arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets

Siddharth Vadapalli <s-vadapalli@ti.com>
    arm64: dts: ti: k3-j784s4-evm: Enable MCU CPSW2G

Nishanth Menon <nm@ti.com>
    arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias

Andrew Davis <afd@ti.com>
    arm64: dts: ti: k3-j721e-beagleboneai64: Fix mailbox node status

Yuan Can <yuancan@huawei.com>
    clk: tegra: tegra124-emc: Fix potential memory leak

Dan Carpenter <dan.carpenter@linaro.org>
    clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()

Dan Carpenter <dan.carpenter@linaro.org>
    clk: bcm: rpi: Fix off by one in raspberrypi_discover_clocks()

Abel Vesa <abel.vesa@linaro.org>
    arm64: dts: qcom: sm8550: Add missing interconnect path to USB HC

Marijn Suijten <marijn.suijten@somainline.org>
    arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of 4k

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8550: Flush RSC sleep & wake votes

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sdm670: Flush RSC sleep & wake votes

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: qdu1000: Flush RSC sleep & wake votes

Bosi Zhang <u201911157@hust.edu.cn>
    clk: mediatek: fix of_iomap memory leak

Yuxing Liu <lyx2022@hust.edu.cn>
    clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Zhanhao Hu <zero12113@hust.edu.cn>
    clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe

Hao Luo <m202171776@hust.edu.cn>
    clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Kai Ma <kaima@hust.edu.cn>
    clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: wraparound mbox producer index

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/a5xx: really check for A510 in a5xx_gpu_init

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/a6xx: don't set IO_PGTABLE_QUIRK_ARM_OUTER_WBWA with coherent SMMU

Chia-I Wu <olvaffe@gmail.com>
    amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix access checks in rxe_check_bind_mw

Geert Uytterhoeven <geert+renesas@glider.be>
    HID: uclogic: Modular KUnit tests should not depend on KUNIT=y

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon: fix possible division-by-zero errors

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode

Chen-Yu Tsai <wenst@chromium.org>
    soc: mediatek: SVS: Fix MT8192 GPU node name

Daniil Dulov <d.dulov@aladdin.ru>
    drm/amdkfd: Fix potential deallocation of previously deallocated memory.

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/amd/display: Fix a test CalculatePrefetchSchedule()

Paul Cercueil <paul@crapouillou.net>
    MIPS: DTS: CI20: Fix ACT8600 regulator node names

Maxime Ripard <maxime@cerno.tech>
    clk: Export clk_hw_forward_rate_request()

Christian Lamparter <chunkeey@gmail.com>
    ARM: dts: BCM5301X: fix duplex-full => full-duplex

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272

Tim Harvey <tharvey@gateworks.com>
    hwmon: (gsc-hwmon) fix fan pwm temperature scaling

Olivier Moysan <olivier.moysan@foss.st.com>
    ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2

Caleb Connolly <caleb.connolly@linaro.org>
    Input: pm8941-powerkey - fix debounce on gen2+ PMICs

Keerthy <j-keerthy@ti.com>
    arm64: dts: ti: k3-j7200: Fix physical address of pin

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dpu: always clear every individual pending flush mask

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dpu: set DSC flush bit correctly at MDP CTL flush register

Wolfram Sang <wsa+renesas@sang-engineering.com>
    arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix hns_roce_table_get return value

Brendan Cunningham <bcunningham@cornelisnetworks.com>
    IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate

Arnd Bergmann <arnd@arndb.de>
    RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes

Randy Dunlap <rdunlap@infradead.org>
    soc/fsl/qe: fix usb.c build errors

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    ARM: dts: meson8: correct uart_B and uart_C clock references

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Increment max value for ALC Capture Target Volume control

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: qcom: apq8074-dragonboard: Set DMA as remotely controlled

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    memory: brcmstb_dpfe: fix testing array offset after use

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Shorten the AV96 HDMI sound card name

Douglas Anderson <dianders@chromium.org>
    arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: apq8096: fix fixed regulator name property

Luca Weiss <luca.weiss@fairphone.com>
    arm64: dts: qcom: pm7250b: add missing spmi-vadc include

Arnd Bergmann <arnd@arndb.de>
    ARM: omap2: fix missing tick_broadcast() prototype

Arnd Bergmann <arnd@arndb.de>
    ARM: ep93xx: fix missing-prototype warnings

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Frieder Schrempf <frieder.schrempf@kontron.de>
    drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Fix regulator constraints

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845-polaris: add missing touchscreen child node reg

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8550: correct pinctrl unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8550: correct crypto unit address

Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
    arm64: dts: qcom: sm8550: add QCE IP family compatible values

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8350: correct PCI phy unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8350: correct DMA controller unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm6115: correct thermal-sensor unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm630: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8996: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8994: correct SPMI unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8976: correct MMC unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8953: correct IOMMU unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct WCNSS unit address

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    arm64: dts: qcom: msm8916: Move WCN compatible to boards

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct MMC unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: ipq6018: correct qrng unit address

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: pm8998: don't use GIC_SPI for SPMI interrupts

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: msm8974: do not use underscore in node name (again)

Linus Walleij <linus.walleij@linaro.org>
    ARM/mfd/gpio: Fixup TPS65010 regression on OMAP1 OSK1

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    drm/bridge: anx7625: Prevent endless probe loop

Tony Lindgren <tony@atomide.com>
    ARM: dts: gta04: Move model property out of pinctrl node

Biju Das <biju.das.jz@bp.renesas.com>
    clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write

Jean-Philippe Brucker <jean-philippe@linaro.org>
    iommu/virtio: Return size mapped for a detached domain

Jean-Philippe Brucker <jean-philippe@linaro.org>
    iommu/virtio: Detach domain on endpoint release

Arnd Bergmann <arnd@arndb.de>
    drm/nouveau: dispnv50: fix missing-prototypes warning

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK

Vinod Polimera <quic_vpolimer@quicinc.com>
    drm/msm/disp/dpu: get timing engine status from intf status register

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dsi: don't allow enabling 14nm VCO with unprogrammed rate

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix to remove an unnecessary log

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Use unique names while registering interrupts

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix to remove unnecessary return labels

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Disable/kill tasklet only if it is enabled

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    hwmon: (f71882fg) prevent possible division by zero

Dan Carpenter <dan.carpenter@linaro.org>
    clk: imx: scu: use _safe list iterator to avoid a use after free

Alexander Stein <alexander.stein@ew.tq-group.com>
    drm/bridge: tc358767: Switch to devm MIPI-DSI helpers

Robert Marko <robert.marko@sartura.hr>
    arm64: dts: microchip: sparx5: do not use PSCI on reference boards

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix dispc quirk masking bool variables

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boards

Maíra Canal <mcanal@igalia.com>
    drm/vkms: Fix RGB565 pixel conversion

Maíra Canal <mcanal@igalia.com>
    drm: Add fixed-point helper to get rounded integer values

Maíra Canal <mcanal@igalia.com>
    drm/vkms: isolate pixel conversion functionality

Bard Liao <yung-chuan.liao@linux.intel.com>
    ASoC: Intel: sof_sdw: remove SOF_SDW_TGL_HDMI for MeteorLake devices

Trevor Wu <trevor.wu@mediatek.com>
    ASoC: dt-bindings: mediatek,mt8188-afe: correct clock name

Dan Carpenter <dan.carpenter@linaro.org>
    driver: soc: xilinx: use _safe loop iterator to avoid a use after free

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/panel: sharp-ls043t1le01: adjust mode settings

XuDong Liu <m202071377@hust.edu.cn>
    drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

Marek Vasut <marex@denx.de>
    Input: adxl34x - do not hardcode interrupt trigger type

Marek Vasut <marek.vasut+renesas@mailbox.org>
    clk: rs9: Fix .driver_data content in i2c_device_id

Alexander Stein <alexander.stein@ew.tq-group.com>
    clk: rs9: Add support for 9FGV0441

Alexander Stein <alexander.stein@ew.tq-group.com>
    clk: rs9: Support device specific dif bit calculation

Alexander Stein <alexander.stein@ew.tq-group.com>
    clk: rs9: Check for vendor/device ID

Marek Vasut <marek.vasut+renesas@mailbox.org>
    clk: vc7: Fix .driver_data content in i2c_device_id

Marek Vasut <marek.vasut+renesas@mailbox.org>
    clk: vc5: Fix .driver_data content in i2c_device_id

hfdevel@gmx.net <hfdevel@gmx.net>
    ARM: dts: meson8b: correct uart_B and uart_C clock references

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM5301X: Drop "clock-names" from the SPI node

Luc Ma <luc@sietium.com>
    drm/vram-helper: fix function names in vram helper doc

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix THS_TRAILCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TXTAGOCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix THS_ZEROCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TCLK_TRAILCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TCLK_ZEROCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix PLL target frequency

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix PLL parameters computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: always enable HS video mode

Alexander Stein <alexander.stein@ew.tq-group.com>
    drm/bridge: ti-sn65dsi83: Fix enable error path

Duoming Zhou <duoming@zju.edu.cn>
    Input: cyttsp4_core - change del_timer_sync() to timer_shutdown_sync()

Luca Weiss <luca@z3ntu.xyz>
    Input: drv260x - sleep between polling GO bit

Markus Elfring <elfring@users.sourceforge.net>
    drm/bridge: it6505: Move a variable assignment behind a null pointer check in receive_timing_debugfs_show()

Vinay Belgaumkar <vinay.belgaumkar@intel.com>
    drm/i915/guc/slpc: Provide sysfs for efficient freq

John Harrison <John.C.Harrison@Intel.com>
    drm/i915/guc: More debug print updates - GuC SLPC

Liu Shixin <liushixin2@huawei.com>
    bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Explicitly specify update type per plane info change

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    radeon: avoid double free in ci_dpm_init()

Arnd Bergmann <arnd@arndb.de>
    drm/amd/display: fix is_timing_changed() prototype

Wesley Chalmers <Wesley.Chalmers@amd.com>
    drm/amd/display: Add logging for display MALL refresh setting

Kuniyuki Iwashima <kuniyu@amazon.com>
    netlink: Add __sock_i_ino() for __netlink_diag_dump().

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: avoid suspicious RCU usage for synced VLAN-aware MAC addresses

Cambda Zhu <cambda@linux.alibaba.com>
    ipvlan: Fix return value of ipvlan_queue_xmit()

Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
    netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one

Jeremy Sowden <jeremy@azazel.net>
    lib/ts_bm: reset initial match offset for every block of text

Lin Ma <linma@zju.edu.cn>
    net: nfc: Fix use-after-free caused by nfc_llcp_find_local

Edward Cree <ecree.xilinx@gmail.com>
    sfc: fix crash when reading stats while NIC is resetting

David Howells <dhowells@redhat.com>
    ocfs2: Fix use of slab data with sendpage

Maxim Kochetkov <fido_max@inbox.ru>
    net: axienet: Move reset before 64-bit DMA detection

Kuniyuki Iwashima <kuniyu@amazon.com>
    gtp: Fix use-after-free in __gtp_encap_destroy().

Sabrina Dubroca <sd@queasysnail.net>
    selftests: rtnetlink: remove netdevsim device after ipsec offload test

Eric Dumazet <edumazet@google.com>
    bonding: do not assume skb mac_header is set

Eric Dumazet <edumazet@google.com>
    netlink: do not hard code device address lenth in fdb dumps

Eric Dumazet <edumazet@google.com>
    netlink: fix potential deadlock in netlink_set_err()

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    net: stmmac: fix double serdes powerdown

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Set hardware timestamp on transmitted packets

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Add function to set skb hwtstamps

Vincent Mailhol <mailhol.vincent@wanadoo.fr>
    can: length: fix bitstuffing count

Gilad Sever <gilad9366@gmail.com>
    bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings

Gilad Sever <gilad9366@gmail.com>
    bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint

Gilad Sever <gilad9366@gmail.com>
    bpf: Factor out socket lookup functions for the TC hookpoint.

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: convert msecs to jiffies where needed

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection

Marek Vasut <marex@denx.de>
    mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019

Ilan Peer <ilan.peer@intel.com>
    wifi: ieee80211: Fix the common size calculation for reconfiguration ML

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix regulatory disconnect with OCB/NAN

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: drop incorrect nontransmitted BSS update code

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: rewrite merging of inherited elements

Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
    wifi: mac80211: Remove "Missing iftype sband data/EHT cap" spam

Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
    wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pull from TXQs with softirqs disabled

Ziyang Huang <hzyitc@outlook.com>
    wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018

Ziyang Huang <hzyitc@outlook.com>
    wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018

Ziyang Huang <hzyitc@outlook.com>
    wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    wifi: ath11k: Add missing check for ioremap

Edwin Peer <edwin.peer@broadcom.com>
    rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO

Ilan Peer <ilan.peer@intel.com>
    wifi: mac80211: Fix permissions for valid_links debugfs entry

Remi Pommarel <repk@triplefau.lt>
    wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: Fix invalid pointer check in get_xlated_program()

Arnd Bergmann <arnd@arndb.de>
    memstick r592: make memstick_debug_get_tpc_name() static

Douglas Anderson <dianders@chromium.org>
    mmc: mediatek: Avoid ugly error message when SDIO wakeup IRQ isn't used

Zhen Lei <thunder.leizhen@huawei.com>
    kexec: fix a memory leak in crash_shrink_memory()

Douglas Anderson <dianders@chromium.org>
    watchdog/perf: more properly prevent false positives with turbo modes

Douglas Anderson <dianders@chromium.org>
    watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config

Haifeng Xu <haifeng.xu@shopee.com>
    selftests: cgroup: fix unexpected failure on test_memcg_low

Karol Kolacinski <karol.kolacinski@intel.com>
    ice: handle extts in the miscellaneous interrupt thread

Marek Vasut <marex@denx.de>
    wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown

Marek Vasut <marex@denx.de>
    wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled

Jesper Dangaard Brouer <brouer@redhat.com>
    selftests/bpf: Fix check_mtu using wrong variable type

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: recalc min chandef for new STA links

Viktor Malik <vmalik@redhat.com>
    tools/resolve_btfids: Fix setting HOSTCFLAGS

Youghandhar Chintala <quic_youghand@quicinc.com>
    wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart

Jesper Dangaard Brouer <brouer@redhat.com>
    samples/bpf: xdp1 and xdp2 reduce XDPBUFSIZE to 60

Sascha Hauer <s.hauer@pengutronix.de>
    wifi: rtw88: usb: silence log flooding error message

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: ray_cs: Fix an error handling path in ray_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: wl3501_cs: Fix an error handling path in wl3501_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: atmel: Fix an error handling path in atmel_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in orinoco_cs_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in spectrum_cs_probe()

Geert Uytterhoeven <geert+renesas@glider.be>
    regulator: core: Streamline debugfs operations

Geert Uytterhoeven <geert+renesas@glider.be>
    regulator: core: Fix more error checking for debugfs_create_dir()

Alexey Gladkov <legion@kernel.org>
    selftests/bpf: Do not use sign-file as testcase

Yafang Shao <laoar.shao@gmail.com>
    bpf: Fix memleak due to fentry attach failure

Yafang Shao <laoar.shao@gmail.com>
    bpf: Remove bpf trampoline selector

Alan Maguire <alan.maguire@oracle.com>
    bpftool: JIT limited misreported as negative value on aarch64

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()

Joy Chakraborty <joychakr@google.com>
    spi: dw: Round of n_bytes to power of 2

Stanislav Fomichev <sdf@google.com>
    bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen

Andrii Nakryiko <andrii@kernel.org>
    libbpf: fix offsetof() and container_of() to work with CO-RE

Alexander Mikhalitsyn <alexander@mihalicyn.com>
    sctp: add bpf_bypass_getsockopt proto callback

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()

Amisha Patel <amisha.patel@microchip.com>
    wifi: wilc1000: fix for absent RSN capabilities WFA testcase

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Pengcheng Yang <yangpc@wangsu.com>
    samples/bpf: Fix buffer overflow in tcp_basertt

Martin KaFai Lau <martin.lau@kernel.org>
    libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx

Peter Seiderer <ps.report@gmx.net>
    wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Jesper Dangaard Brouer <brouer@redhat.com>
    igc: Enable and fix RX hash usage by netstack

Hao Jia <jiahao.os@bytedance.com>
    sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pstore/ram: Add check for kstrdup

Roberto Sassu <roberto.sassu@huawei.com>
    ima: Fix build warnings

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Fix build warnings

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Complete description of evm_inode_setattr()

Mark Rutland <mark.rutland@arm.com>
    locking/atomic: arm: fix sync ops

Juergen Gross <jgross@suse.com>
    x86/mm: Fix __swp_entry_to_pte() for Xen PV guests

Ravi Bangoria <ravi.bangoria@amd.com>
    perf/ibs: Fix interface via core pmu events

Colin Ian King <colin.i.king@gmail.com>
    kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined

Juergen Gross <jgross@suse.com>
    x86/xen: Set MTRR state when running as Xen PV initial domain

Juergen Gross <jgross@suse.com>
    x86/mtrr: Support setting MTRR state for software defined MTRRs

Juergen Gross <jgross@suse.com>
    x86/mtrr: Replace size_or_mask and size_and_mask with a much easier concept

Juergen Gross <jgross@suse.com>
    x86/mtrr: Remove physical address size calculation

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()

Paul E. McKenney <paulmck@kernel.org>
    rcuscale: Move shutdown from wait_event() to wait_event_idle()

Paul E. McKenney <paulmck@kernel.org>
    rcutorture: Correct name of use_softirq module parameter

Paul E. McKenney <paulmck@kernel.org>
    rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs

Paul E. McKenney <paulmck@kernel.org>
    rcu: Make rcu_cpu_starting() rely on interrupts being disabled

Peng Fan <peng.fan@nxp.com>
    thermal/drivers/qoriq: Only enable supported sensors

Daniel Lezcano <daniel.lezcano@linaro.org>
    thermal/hwmon: Use the right device for devm_thermal_add_hwmon_sysfs()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    thermal/drivers/qcom/tsens-v0_1: Add mdm9607 correction offsets

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values

Matti Lehtimäki <matti.lehtimaki@gmail.com>
    thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226

Tero Kristo <tero.kristo@linux.intel.com>
    cpufreq: intel_pstate: Fix energy_performance_preference for passive

Arnd Bergmann <arnd@arndb.de>
    ARM: 9303/1: kprobes: avoid missing-declaration warnings

Ulf Hansson <ulf.hansson@linaro.org>
    PM: domains: Move the verification of in-params from genpd_add_device()

Zhang Rui <rui.zhang@intel.com>
    powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
    powercap: RAPL: fix invalid initialization for pl4_supported field

Li Yang <leoyang.li@nxp.com>
    APEI: GHES: correctly return NULL for ghes_get_devices()

Robin Murphy <robin.murphy@arm.com>
    perf/arm_cspmu: Fix event attribute type

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    perf: arm_cspmu: Set irq affinitiy only if overflow interrupt is used

Junhao He <hejunhao3@huawei.com>
    drivers/perf: hisi: Don't migrate perf to the CPU going to teardown

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/mm: Allow guest.enc_status_change_prepare() to fail

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Fix DTC reset

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    PM: domains: fix integer overflow issues in genpd_parse_state()

Feng Mingxi <m202271825@hust.edu.cn>
    clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Christoph Hellwig <hch@lst.de>
    btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED bios that get split

Christoph Hellwig <hch@lst.de>
    btrfs: make btrfs_split_bio work on struct btrfs_bio

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Wen Yang <wenyang.linux@foxmail.com>
    tick/rcu: Fix bogus ratelimit condition

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Prevent RT livelock in itimer_delete()

Gao Xiang <xiang@kernel.org>
    erofs: fix compact 4B support for 16k block size

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Prevent page release when nothing was received

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    irqchip/jcore-aic: Fix missing allocation of IRQ descriptors

Antonio Borneo <antonio.borneo@foss.st.com>
    irqchip/stm32-exti: Fix warning on initialized field overwritten

Christoph Hellwig <hch@lst.de>
    splice: don't call file_accessed in copy_splice_read

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-eiointc: Fix irq affinity setting during resume

Yu Kuai <yukuai3@huawei.com>
    block: fix blktrace debugfs entries leakage

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: submit write io directly if bitmap is not enabled

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: factor out a helper to submit normal write

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: factor out a helper to add bio to plug

Li Nan <linan122@huawei.com>
    md/raid10: fix io loss while replacement replace rdev

Li Nan <linan122@huawei.com>
    md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request

Li Nan <linan122@huawei.com>
    md/raid10: fix wrong setting of max_corr_read_errors

Li Nan <linan122@huawei.com>
    md/raid10: fix overflow of md/safe_mode_delay

Li Nan <linan122@huawei.com>
    md/raid10: check slab-out-of-bounds in md_bitmap_get_counter

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: fix dev_pm_qos memleak

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: add missing fault-injection cleanup

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: fix memory leak in dhchap_ctrl_secret

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: fix memory leak in dhchap_secret_store

NeilBrown <neilb@suse.de>
    lockd: drop inappropriate svc_get() from locked_get()

Yu Kuai <yukuai3@huawei.com>
    blk-mq: fix potential io hang by wrong 'wake_batch'

Arnd Bergmann <arnd@arndb.de>
    virt: sevguest: Add CONFIG_CRYPTO dependency

Waiman Long <longman@redhat.com>
    blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()

Tom Lendacky <thomas.lendacky@amd.com>
    x86/sev: Fix calculation of end address based on number of pages

Li Nan <linan122@huawei.com>
    blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost

Shawn Wang <shawnwang@linux.alibaba.com>
    x86/resctrl: Only show tasks' pid in current pid namespace

Gao Xiang <xiang@kernel.org>
    erofs: kill hooked chains to avoid loops on deduplicated compressed images

David Howells <dhowells@redhat.com>
    splice: Fix filemap_splice_read() to use the correct inode

Bart Van Assche <bvanassche@acm.org>
    block: Fix the type of the second bdev_op_is_zoned_write() argument

Arnd Bergmann <arnd@arndb.de>
    fs: pipe: reveal missing function protoypes

Jeff Layton <jlayton@kernel.org>
    drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2

Peter Collingbourne <pcc@google.com>
    mm: call arch_swap_restore() from do_swap_page()


-------------

Diffstat:

 .../bindings/sound/mediatek,mt8188-afe.yaml        |  36 +-
 Makefile                                           |   4 +-
 arch/arc/include/asm/linkage.h                     |   8 +-
 arch/arm/boot/dts/bcm53015-meraki-mr26.dts         |   2 +-
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts         |   2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   1 -
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   2 +-
 .../boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi  |  16 +-
 arch/arm/boot/dts/meson8.dtsi                      |   4 +-
 arch/arm/boot/dts/meson8b.dtsi                     |   4 +-
 arch/arm/boot/dts/omap3-gta04a5one.dts             |   4 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   4 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   2 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      |  11 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |   8 +-
 .../boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi    |   6 +
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi       |   6 -
 arch/arm/boot/dts/stm32mp15xx-dhcor-testbench.dtsi |   8 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   2 +-
 arch/arm/include/asm/assembler.h                   |  17 +
 arch/arm/include/asm/sync_bitops.h                 |  29 +-
 arch/arm/lib/bitops.h                              |  14 +-
 arch/arm/lib/testchangebit.S                       |   4 +
 arch/arm/lib/testclearbit.S                        |   4 +
 arch/arm/lib/testsetbit.S                          |   4 +
 arch/arm/mach-ep93xx/timer-ep93xx.c                |   3 +-
 arch/arm/mach-omap1/board-osk.c                    | 139 +++++--
 arch/arm/mach-omap2/board-generic.c                |   1 +
 arch/arm/probes/kprobes/checkers-common.c          |   2 +-
 arch/arm/probes/kprobes/core.c                     |   2 +-
 arch/arm/probes/kprobes/opt-arm.c                  |   2 -
 arch/arm/probes/kprobes/test-core.c                |   2 +-
 arch/arm/probes/kprobes/test-core.h                |   4 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso |   6 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   4 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  22 +-
 arch/arm64/boot/dts/microchip/sparx5.dtsi          |   2 +-
 .../boot/dts/microchip/sparx5_pcb_common.dtsi      |  12 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  93 +++--
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts       |   4 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   |  12 +-
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  12 +-
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     |  12 +-
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts |  12 +-
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     |  12 +-
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |  12 +-
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      |  12 +-
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi       |  22 +-
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |   4 -
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      |   8 +
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts      |  14 +-
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |   8 +
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  |  16 +-
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  12 +-
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    |  16 +-
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          |  12 +-
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |  12 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  19 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |   6 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   3 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |   2 +-
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |   7 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  11 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   3 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts              |   2 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  28 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts |   5 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  52 ++-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  29 +-
 arch/arm64/include/asm/fpsimdmacros.h              |   6 +-
 arch/mips/boot/dts/ingenic/ci20.dts                |  38 +-
 arch/powerpc/kernel/interrupt.c                    |   3 +-
 arch/powerpc/kernel/ppc_save_regs.S                |   6 +-
 arch/powerpc/kernel/signal_32.c                    |  15 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |  34 +-
 arch/powerpc/mm/init_64.c                          |   2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c         |   6 +-
 arch/powerpc/platforms/powernv/vas-window.c        |   2 +-
 arch/powerpc/platforms/pseries/vas.c               |   2 +-
 arch/riscv/kernel/probes/uprobes.c                 |   2 +
 arch/x86/coco/tdx/tdx.c                            |  51 ++-
 arch/x86/events/amd/core.c                         |   2 +-
 arch/x86/events/amd/ibs.c                          |  53 ++-
 arch/x86/include/asm/mtrr.h                        |  40 +-
 arch/x86/include/asm/perf_event.h                  |   2 +
 arch/x86/include/asm/pgtable_64.h                  |   4 +-
 arch/x86/include/asm/sev.h                         |  16 +-
 arch/x86/include/asm/x86_init.h                    |   2 +-
 arch/x86/include/uapi/asm/mtrr.h                   |   8 -
 arch/x86/kernel/cpu/mtrr/cleanup.c                 |  18 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 | 124 ++++--
 arch/x86/kernel/cpu/mtrr/mtrr.c                    |  73 +---
 arch/x86/kernel/cpu/mtrr/mtrr.h                    |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |   8 +-
 arch/x86/kernel/setup.c                            |   2 +
 arch/x86/kernel/sev.c                              |  14 +-
 arch/x86/kernel/x86_init.c                         |   2 +-
 arch/x86/mm/mem_encrypt_amd.c                      |   4 +-
 arch/x86/mm/pat/set_memory.c                       |   3 +-
 arch/x86/platform/efi/efi_64.c                     |   6 +-
 arch/x86/xen/enlighten_pv.c                        |  52 +++
 block/blk-cgroup.c                                 |   5 +
 block/blk-iocost.c                                 |   7 +-
 block/blk-mq-debugfs.c                             |   2 +-
 block/blk-mq-tag.c                                 |  15 +-
 block/blk-mq.h                                     |   3 +-
 block/genhd.c                                      |   5 +-
 crypto/jitterentropy.c                             |   9 +-
 drivers/acpi/apei/ghes.c                           |   2 +
 drivers/base/power/domain.c                        |  15 +-
 drivers/bus/ti-sysc.c                              |   4 +-
 drivers/char/hw_random/st-rng.c                    |  21 +-
 drivers/char/hw_random/virtio-rng.c                |  10 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |   4 +-
 drivers/clk/clk-cdce925.c                          |  12 +
 drivers/clk/clk-renesas-pcie.c                     |  72 +++-
 drivers/clk/clk-si5341.c                           |  38 +-
 drivers/clk/clk-versaclock5.c                      |  45 ++-
 drivers/clk/clk-versaclock7.c                      |   2 +-
 drivers/clk/clk.c                                  |   2 +
 drivers/clk/imx/clk-imx8mn.c                       |   8 +-
 drivers/clk/imx/clk-imx8mp.c                       |  24 +-
 drivers/clk/imx/clk-imx93.c                        |  15 +-
 drivers/clk/imx/clk-imxrt1050.c                    |  22 +-
 drivers/clk/imx/clk-scu.c                          |   4 +-
 drivers/clk/keystone/sci-clk.c                     |   2 +
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c       |   7 +-
 drivers/clk/mediatek/clk-mtk.c                     |   7 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |   6 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |   3 -
 drivers/clk/tegra/clk-tegra124-emc.c               |   2 +
 drivers/clk/ti/clkctrl.c                           |   7 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |   2 +-
 drivers/clocksource/timer-cadence-ttc.c            |  19 +-
 drivers/cpufreq/intel_pstate.c                     |   2 +
 drivers/crypto/marvell/cesa/cipher.c               |   2 +-
 drivers/crypto/nx/Makefile                         |   2 +-
 drivers/crypto/nx/nx.h                             |   4 +-
 drivers/crypto/qat/qat_common/qat_asym_algs.c      |  14 +-
 drivers/cxl/core/region.c                          | 102 +++--
 drivers/cxl/cxl.h                                  |  16 +-
 drivers/dax/bus.c                                  |  61 +--
 drivers/dax/dax-private.h                          |   4 +-
 drivers/dax/kmem.c                                 |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c     |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  13 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   5 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c       |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 -
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   2 +-
 .../display/dc/dml/dcn32/display_rq_dlg_calc_32.c  |   2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  18 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 128 ++++--
 drivers/gpu/drm/bridge/ite-it6505.c                |   3 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   4 +-
 drivers/gpu/drm/bridge/tc358768.c                  |  93 ++++-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  20 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |   6 +-
 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c        |  35 ++
 drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c          |   8 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c        |  95 +++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h        |   1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc_types.h  |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   3 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   8 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |  16 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  26 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   3 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   1 +
 drivers/gpu/drm/nouveau/nv50_display.h             |   4 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |  11 +-
 drivers/gpu/drm/panel/panel-simple.c               |   4 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |  28 +-
 drivers/gpu/drm/radeon/cypress_dpm.c               |   8 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |   8 +-
 drivers/gpu/drm/radeon/rv740_dpm.c                 |   8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  19 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |   4 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   4 +-
 drivers/gpu/drm/vkms/vkms_formats.c                | 131 +++---
 drivers/gpu/drm/vkms/vkms_formats.h                |   2 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |   2 +-
 drivers/hid/Kconfig                                |   2 +-
 drivers/hwmon/f71882fg.c                           |   7 +-
 drivers/hwmon/gsc-hwmon.c                          |   6 +-
 drivers/hwmon/pmbus/adm1275.c                      |  52 +--
 drivers/infiniband/hw/bnxt_re/main.c               |  20 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  40 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  46 ++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   1 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |   4 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                | 101 +++--
 drivers/infiniband/hw/hfi1/mmu_rb.h                |   3 +
 drivers/infiniband/hw/hfi1/sdma.c                  |  23 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |  47 ++-
 drivers/infiniband/hw/hfi1/sdma_txreq.h            |   2 +
 drivers/infiniband/hw/hfi1/user_sdma.c             | 137 +++----
 drivers/infiniband/hw/hfi1/user_sdma.h             |   1 -
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   7 +-
 drivers/infiniband/hw/irdma/uk.c                   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                 |  17 +-
 drivers/input/misc/adxl34x.c                       |   3 +-
 drivers/input/misc/drv260x.c                       |   1 +
 drivers/input/misc/pm8941-pwrkey.c                 |  19 +-
 drivers/input/touchscreen/cyttsp4_core.c           |   3 +-
 drivers/iommu/iommufd/device.c                     |   2 +-
 drivers/iommu/iommufd/io_pagetable.c               |  14 +-
 drivers/iommu/virtio-iommu.c                       |  57 ++-
 drivers/irqchip/irq-jcore-aic.c                    |   7 +
 drivers/irqchip/irq-loongson-eiointc.c             |   2 +-
 drivers/irqchip/irq-stm32-exti.c                   |  12 +
 drivers/md/md-bitmap.c                             |  21 +-
 drivers/md/md-bitmap.h                             |   7 +
 drivers/md/md.c                                    |   9 +-
 drivers/md/raid1-10.c                              |  42 ++
 drivers/md/raid1.c                                 |  25 +-
 drivers/md/raid10.c                                |  73 ++--
 drivers/memory/brcmstb_dpfe.c                      |   4 +-
 drivers/memstick/host/r592.c                       |   4 +-
 drivers/mfd/tps65010.c                             |  14 +-
 drivers/mmc/core/card.h                            |  30 +-
 drivers/mmc/core/quirks.h                          |  13 +
 drivers/mmc/core/sd.c                              |   2 +-
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/can/kvaser_pciefd.c                    |  39 +-
 drivers/net/ethernet/intel/ice/ice.h               |   7 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  29 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |  28 ++
 drivers/net/ethernet/intel/igc/igc_main.c          |  31 +-
 drivers/net/ethernet/sfc/ef10.c                    |  13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  10 +-
 drivers/net/gtp.c                                  |   2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   9 +-
 drivers/net/wireless/ath/ath10k/core.c             |   9 -
 drivers/net/wireless/ath/ath10k/mac.c              |   7 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   1 +
 drivers/net/wireless/ath/ath11k/core.c             |   1 +
 drivers/net/wireless/ath/ath11k/hw.c               |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   5 +
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |  27 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |   8 +-
 drivers/net/wireless/ath/ath9k/main.c              |  11 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |   4 +
 drivers/net/wireless/atmel/atmel_cs.c              |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   5 +-
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c |  13 +-
 .../net/wireless/intersil/orinoco/spectrum_cs.c    |  13 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   6 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   8 +-
 drivers/net/wireless/ray_cs.c                      |  16 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |   9 +-
 drivers/net/wireless/wl3501_cs.c                   |  16 +-
 drivers/nvme/host/core.c                           |  16 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |  27 ++
 drivers/pci/controller/pci-ftpci100.c              |  14 +-
 drivers/pci/controller/vmd.c                       |  11 +-
 drivers/pci/endpoint/functions/Kconfig             |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   2 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   8 +
 drivers/pci/pcie/aspm.c                            |  21 +-
 drivers/perf/arm-cmn.c                             |   7 +-
 drivers/perf/arm_cspmu/arm_cspmu.c                 |  11 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |   2 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 +-
 drivers/pinctrl/freescale/pinctrl-scu.c            |   3 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |  15 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   2 +
 drivers/pinctrl/pinctrl-at91-pio4.c                |   2 +
 drivers/pinctrl/pinctrl-at91.c                     |  78 ++--
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |   3 +
 drivers/pinctrl/sunplus/sppctl.c                   |  23 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |  15 +-
 drivers/pinctrl/tegra/pinctrl-tegra.h              |   3 +-
 drivers/pinctrl/tegra/pinctrl-tegra114.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra124.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra194.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra20.c            |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra210.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra30.c            |   7 +-
 drivers/platform/x86/dell/dell-rbtn.c              |  13 +-
 drivers/platform/x86/intel/pmc/core.c              |   1 -
 drivers/platform/x86/intel/pmc/core.h              |  28 +-
 drivers/platform/x86/intel/pmc/mtl.c               | 448 ++++++++++++++++++++-
 drivers/platform/x86/lenovo-yogabook-wmi.c         |  34 +-
 drivers/platform/x86/think-lmi.c                   |  20 +-
 drivers/platform/x86/thinkpad_acpi.c               |   6 +-
 drivers/powercap/Kconfig                           |   4 +-
 drivers/powercap/intel_rapl_msr.c                  |  17 +-
 drivers/regulator/core.c                           |  30 +-
 drivers/scsi/3w-xxxx.c                             |   4 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  14 +-
 drivers/scsi/qedf/qedf_main.c                      |   3 +-
 drivers/soc/amlogic/meson-secure-pwrc.c            |   2 +-
 drivers/soc/fsl/qe/Kconfig                         |   1 +
 drivers/soc/mediatek/mtk-svs.c                     |   4 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |   6 +-
 drivers/spi/spi-dw-core.c                          |   5 +-
 drivers/spi/spi-geni-qcom.c                        |   2 +-
 drivers/thermal/amlogic_thermal.c                  |   2 +-
 drivers/thermal/imx8mm_thermal.c                   |   2 +-
 drivers/thermal/imx_sc_thermal.c                   |   2 +-
 drivers/thermal/k3_bandgap.c                       |   2 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   2 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   2 +-
 drivers/thermal/qcom/tsens-v0_1.c                  |  56 ++-
 drivers/thermal/qcom/tsens.c                       |  21 +-
 drivers/thermal/qcom/tsens.h                       |   6 +-
 drivers/thermal/qoriq_thermal.c                    |  32 +-
 drivers/thermal/sun8i_thermal.c                    |  57 +--
 drivers/thermal/tegra/tegra30-tsensor.c            |   2 +-
 drivers/thermal/thermal_hwmon.c                    |   4 +-
 drivers/thermal/thermal_hwmon.h                    |   4 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   2 +-
 drivers/ufs/core/ufshcd-priv.h                     |   3 -
 drivers/ufs/core/ufshcd.c                          |  21 +-
 drivers/vfio/mdev/mdev_core.c                      |  23 +-
 drivers/video/fbdev/omap/lcd_mipid.c               |   6 +-
 drivers/virt/coco/sev-guest/Kconfig                |   1 +
 fs/btrfs/bio.c                                     |  28 +-
 fs/cifs/cifs_debug.c                               |  16 +-
 fs/cifs/cifsglob.h                                 |  10 +-
 fs/cifs/cifsproto.h                                |   2 +-
 fs/cifs/connect.c                                  |  70 ++--
 fs/cifs/dfs.c                                      |  55 +--
 fs/cifs/dfs.h                                      |  19 +-
 fs/cifs/dfs_cache.c                                |   8 +-
 fs/cifs/file.c                                     |  25 +-
 fs/cifs/misc.c                                     |  38 +-
 fs/cifs/smb2inode.c                                |   9 +-
 fs/cifs/smb2ops.c                                  |  19 +-
 fs/cifs/transport.c                                |  20 +-
 fs/erofs/zdata.c                                   |  72 +---
 fs/erofs/zmap.c                                    |   6 +-
 fs/ksmbd/smb_common.c                              |   2 +-
 fs/lockd/svc.c                                     |   1 -
 fs/nfs/nfs42xattr.c                                |  79 ++--
 fs/nfs/nfs4proc.c                                  |   1 +
 fs/ocfs2/cluster/tcp.c                             |  23 +-
 fs/overlayfs/copy_up.c                             |   2 +
 fs/overlayfs/dir.c                                 |   3 +-
 fs/overlayfs/export.c                              |   3 +-
 fs/overlayfs/namei.c                               |   3 +-
 fs/overlayfs/overlayfs.h                           |   6 +-
 fs/overlayfs/super.c                               |   2 +-
 fs/overlayfs/util.c                                |  24 +-
 fs/pstore/ram_core.c                               |   2 +
 fs/splice.c                                        |   1 -
 include/drm/drm_fixed.h                            |   6 +
 include/linux/blk-mq.h                             |   3 +-
 include/linux/blkdev.h                             |   2 +-
 include/linux/bootmem_info.h                       |   2 +
 include/linux/bpf.h                                |   1 -
 include/linux/can/length.h                         |  14 +-
 include/linux/ieee80211.h                          |   5 +-
 include/linux/mfd/tps65010.h                       |  11 +-
 include/linux/mmc/card.h                           |   1 +
 include/linux/netdevice.h                          |   9 +
 include/linux/nmi.h                                |   2 +-
 include/linux/pci.h                                |   1 +
 include/linux/pipe_fs_i.h                          |   4 -
 include/net/dsa.h                                  |  12 +-
 include/net/regulatory.h                           |  13 +-
 include/net/sock.h                                 |   1 +
 include/trace/events/timer.h                       |   6 +-
 include/ufs/ufshcd.h                               |   1 -
 init/Makefile                                      |   1 +
 kernel/bpf/cgroup.c                                |  15 +
 kernel/bpf/trampoline.c                            |  32 +-
 kernel/kcsan/core.c                                |   2 +
 kernel/kexec_core.c                                |   5 +-
 kernel/rcu/rcu.h                                   |   6 +
 kernel/rcu/rcuscale.c                              | 204 +++++-----
 kernel/rcu/tasks.h                                 |   7 +-
 kernel/rcu/tree.c                                  |  23 +-
 kernel/sched/fair.c                                |  18 +
 kernel/sched/sched.h                               |  22 +
 kernel/time/posix-timers.c                         |  43 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/watchdog_hld.c                              |   6 +-
 lib/ts_bm.c                                        |   4 +-
 mm/filemap.c                                       |   4 +-
 mm/memory.c                                        |   7 +
 net/core/filter.c                                  | 126 ++++--
 net/core/rtnetlink.c                               | 104 ++---
 net/core/sock.c                                    |  17 +-
 net/dsa/dsa.c                                      |   2 +-
 net/dsa/slave.c                                    |  84 ++--
 net/dsa/switch.c                                   |   4 +-
 net/dsa/switch.h                                   |   3 +
 net/mac80211/debugfs_netdev.c                      |   2 +-
 net/mac80211/sta_info.c                            |   2 +
 net/mac80211/util.c                                |   4 +-
 net/netfilter/nf_conntrack_proto_dccp.c            |  52 ++-
 net/netfilter/nf_conntrack_sip.c                   |   2 +-
 net/netlink/af_netlink.c                           |   5 +-
 net/netlink/diag.c                                 |   7 +-
 net/nfc/llcp.h                                     |   1 -
 net/nfc/llcp_commands.c                            |  15 +-
 net/nfc/llcp_core.c                                |  49 ++-
 net/nfc/llcp_sock.c                                |  18 +-
 net/nfc/netlink.c                                  |  20 +-
 net/nfc/nfc.h                                      |   1 +
 net/sctp/socket.c                                  |  18 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |  12 +-
 net/wireless/core.c                                |  16 -
 net/wireless/reg.c                                 |  14 +-
 net/wireless/scan.c                                | 367 +++++++----------
 samples/bpf/tcp_basertt_kern.c                     |   2 +-
 samples/bpf/xdp1_kern.c                            |   2 +-
 samples/bpf/xdp2_kern.c                            |   2 +-
 scripts/Makefile.modfinal                          |   2 +-
 scripts/Makefile.vmlinux                           |   1 +
 scripts/mod/modpost.c                              |  86 ++--
 scripts/package/builddeb                           |  14 +-
 security/integrity/evm/evm_crypto.c                |   2 +-
 security/integrity/evm/evm_main.c                  |   4 +-
 security/integrity/ima/ima_modsig.c                |   3 +
 security/integrity/ima/ima_policy.c                |   3 +-
 sound/pci/ac97/ac97_codec.c                        |   4 +-
 sound/soc/amd/acp/acp-pdm.c                        |   2 +-
 sound/soc/codecs/es8316.c                          |  23 +-
 sound/soc/fsl/imx-audmix.c                         |   9 +
 sound/soc/intel/boards/sof_sdw.c                   |   2 +-
 tools/bpf/bpftool/feature.c                        |  24 +-
 tools/bpf/resolve_btfids/Makefile                  |   4 +-
 tools/lib/bpf/bpf_helpers.h                        |  15 +-
 tools/lib/bpf/btf_dump.c                           |  22 +-
 tools/perf/arch/x86/util/Build                     |   1 +
 tools/perf/arch/x86/util/env.c                     |  19 +
 tools/perf/arch/x86/util/env.h                     |   7 +
 tools/perf/arch/x86/util/evsel.c                   |  16 +-
 tools/perf/arch/x86/util/mem-events.c              |  19 +-
 tools/perf/builtin-bench.c                         |   2 +
 tools/perf/builtin-script.c                        |  16 +-
 tools/perf/builtin-stat.c                          |   2 +
 tools/perf/tests/shell/test_task_analyzer.sh       |  26 +-
 tools/perf/util/dwarf-aux.c                        |   2 +-
 tools/perf/util/evsel.h                            |  24 +-
 tools/perf/util/evsel_fprintf.c                    |   1 +
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |   2 +-
 tools/testing/selftests/bpf/test_verifier.c        |  24 +-
 tools/testing/selftests/cgroup/test_memcontrol.c   |   4 +-
 tools/testing/selftests/net/rtnetlink.sh           |   1 +
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |   2 +-
 .../selftests/rcutorture/configs/rcu/TREE03.boot   |   2 +-
 .../selftests/vDSO/vdso_test_clock_getres.c        |   4 +-
 480 files changed, 4924 insertions(+), 2872 deletions(-)


