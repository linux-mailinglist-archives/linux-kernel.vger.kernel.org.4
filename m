Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D47036FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbjEORPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243880AbjEORPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403E1A5;
        Mon, 15 May 2023 10:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477A462B8D;
        Mon, 15 May 2023 17:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C6BC433D2;
        Mon, 15 May 2023 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170830;
        bh=8pLSGXBAUio/nOfEIAq/avpFgomncxR3WrIF4g5/joE=;
        h=From:To:Cc:Subject:Date:From;
        b=RAYov+OUO/3/+nB2JZvVywIGPqakiHhV/C/VwH3PjPF74hHkIkad39fqyGkjTueaV
         kPlRQu4T5RqrBh97QFQR95cp77f7x4OziUFeVmSe7IHfj6vLPurZgJBCcjQSdomSKP
         jYKSuQY3/KAA+Rv4o2WiJhHkcE1WUVyyDL2r6q/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.2 000/242] 6.2.16-rc1 review
Date:   Mon, 15 May 2023 18:25:26 +0200
Message-Id: <20230515161721.802179972@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.16-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.2.16-rc1
X-KernelTest-Deadline: 2023-05-17T16:17+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.2.16 release.
There are 242 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.16-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.2.16-rc1

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fix hang when skipping modeset

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-spi: Re-organise transfer bits_per_word adaptation

Linus Torvalds <torvalds@linux-foundation.org>
    x86: fix clear_user_rep_good() exception handling annotation

Mario Limonciello <mario.limonciello@amd.com>
    x86/amd_nb: Add PCI ID for family 19h model 78h

Jani Nikula <jani.nikula@intel.com>
    drm/dsc: fix DP_DSC_MAX_BPP_DELTA_* macro values

Theodore Ts'o <tytso@mit.edu>
    ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Theodore Ts'o <tytso@mit.edu>
    ext4: remove a BUG_ON in ext4_mb_release_group_pa()

Jan Kara <jack@suse.cz>
    ext4: fix lockdep warning when enabling MMP

Theodore Ts'o <tytso@mit.edu>
    ext4: bail out of ext4_xattr_ibody_get() fails for any reason

Theodore Ts'o <tytso@mit.edu>
    ext4: add bounds checking in get_max_inline_xattr_value_size()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix deadlock when converting an inline directory in nojournal mode

Theodore Ts'o <tytso@mit.edu>
    ext4: improve error handling from ext4_dirhash()

Theodore Ts'o <tytso@mit.edu>
    ext4: improve error recovery code paths in __ext4_remount()

Baokun Li <libaokun1@huawei.com>
    ext4: check iomap type only if ext4_iomap_begin() does not fail

Jan Kara <jack@suse.cz>
    ext4: avoid deadlock in fs reclaim with page writeback

Jan Kara <jack@suse.cz>
    ext4: fix data races when using cached status extents

Tudor Ambarus <tudor.ambarus@linaro.org>
    ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Ye Bin <yebin10@huawei.com>
    ext4: fix WARNING in mb_find_extent

John Stultz <jstultz@google.com>
    locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers

Jani Nikula <jani.nikula@intel.com>
    drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage

Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
    drm: Add missing DP DSC extended capability definitions.

Leo Chen <sancchen@amd.com>
    drm/amd/display: Change default Z8 watermark values

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Update Z8 SR exit/enter latencies

Leo Chen <sancchen@amd.com>
    drm/amd/display: Lowering min Z8 residency time

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Update minimum stutter residency for DCN314 Z8

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Add minimum Z8 residency debug option

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Fix Z8 support configurations

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Check pipe source size when using skl+ scalers

Animesh Manna <animesh.manna@intel.com>
    drm/i915/mtl: update scaler source and destination limits for MTL

Lionel Landwerlin <lionel.g.landwerlin@intel.com>
    drm/i915: disable sampler indirect state in bindless heap

Haridhar Kalvala <haridhar.kalvala@intel.com>
    drm/i915/mtl: Add Wa_14017856879

Radhakrishna Sripada <radhakrishna.sripada@intel.com>
    drm/i915/mtl: Add workarounds Wa_14017066071 and Wa_14017654203

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/adreno: adreno_gpu: Use suspend() instead of idle() on load error

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Refactoring of various minor issues

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: insert timestamp to packed Bluetooth (BT) events

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: Set a default resolution for older tablets

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Use `amdgpu_ucode_*` helpers for MES

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Add a new helper for loading/validating microcode

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Load MES microcode during early_init

Guchun Chen <guchun.chen@amd.com>
    drm/amd/pm: avoid potential UBSAN issue on legacy asics

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend

Guchun Chen <guchun.chen@amd.com>
    drm/amd/pm: parse pp_handle under appropriate conditions

Alvin Lee <Alvin.Lee2@amd.com>
    drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes

Lin.Cao <lincao12@amd.com>
    drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)

Yifan Zhang <yifan1.zhang@amd.com>
    drm/amdgpu: change gfx 11.0.4 external_id range

Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
    drm/amdgpu/jpeg: Remove harvest checking for JPEG3

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras

Horatio Zhang <Hongkun.Zhang@amd.com>
    drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

Horatio Zhang <Hongkun.Zhang@amd.com>
    drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fini

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu: drop redundant sched job cleanup when cs is aborted

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix flickering caused by S/G mode

Samson Tam <Samson.Tam@amd.com>
    drm/amd/display: filter out invalid bits in pipe_fuses

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Fix 4to1 MPC black screen with DPP RCO

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Add NULL plane_state check for cursor disable logic

James Cowgill <james.cowgill@blaize.com>
    drm/panel: otm8009a: Set backlight parent to panel device

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-eiointc: Fix registration of syscore_ops

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-eiointc: Fix returned value on parsing MADT

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-pch-pic: Fix registration of syscore_ops

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-pch-pic: Fix pch_pic_acpi_init calling

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix potential corruption when moving a directory

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: factor out victim_entry usage from general rb_tree use

Hans de Goede <hdegoede@redhat.com>
    drm/i915/dsi: Use unconditional msleep() instead of intel_dsi_msleep()

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix workqueue leak on bind errors

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix missing wq allocation error handling

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix vram leak on bind errors

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix drm device leak on bind errors

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix NULL-deref on irq uninstall

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix NULL-deref on snapshot tear down

Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
    drm/i915/color: Fix typo for Plane CSC indexes

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: lt8912b: Fix DSI Video Mode

Johan Hovold <johan+linaro@kernel.org>
    drm/msm/adreno: fix runtime PM imbalance at gpu load

Zev Weiss <zev@bewilderbeest.net>
    ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: s5pv210: correct MIPI CSIS clock name

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: exynos: fix WM8960 clock name in Itop Elite

Zev Weiss <zev@bewilderbeest.net>
    ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks

Luis Chamberlain <mcgrof@kernel.org>
    sysctl: clarify register_sysctl_init() base directory order

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: rcar_rproc: Call of_node_put() on iteration error

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: imx_rproc: Call of_node_put() on iteration error

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: imx_dsp_rproc: Call of_node_put() on iteration error

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: st: Call of_node_put() on iteration error

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: stm32: Call of_node_put() on iteration error

Luis Chamberlain <mcgrof@kernel.org>
    proc_sysctl: enhance documentation

Luis Chamberlain <mcgrof@kernel.org>
    proc_sysctl: update docs for __register_sysctl_table()

Randy Dunlap <rdunlap@infradead.org>
    sh: nmi_debug: fix return value of __setup handler

Randy Dunlap <rdunlap@infradead.org>
    sh: init: use OF_EARLY_FLATTREE for early init

Randy Dunlap <rdunlap@infradead.org>
    sh: mcount.S: fix build error when PRINTK is not enabled

Randy Dunlap <rdunlap@infradead.org>
    sh: math-emu: fix macro redefined warning

Steve French <stfrench@microsoft.com>
    SMB3: force unmount was failing to close deferred close files

Steve French <stfrench@microsoft.com>
    smb3: fix problem remounting a share after shutdown

Jan Kara <jack@suse.cz>
    inotify: Avoid reporting event with invalid wd

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: thinkpad_acpi: Add profile force ability

Andrey Avdeev <jamesstoun@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Fae <faenkhauser@gmail.com>
    platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: thinkpad_acpi: Fix platform profiles on T490

Hans de Goede <hdegoede@redhat.com>
    platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    platform/x86/intel-uncore-freq: Return error on write frequency

Steve French <stfrench@microsoft.com>
    cifs: release leases for deferred close handles when freezing

Pawel Witek <pawel.ireneusz.witek@gmail.com>
    cifs: fix pcchunk length type in smb2_copychunk_range

Filipe Manana <fdmanana@suse.com>
    btrfs: fix backref walking not returning all inode refs

Naohiro Aota <Naohiro.Aota@wdc.com>
    btrfs: zoned: fix full zone super block reading on ZNS

Naohiro Aota <Naohiro.Aota@wdc.com>
    btrfs: zoned: zone finish data relocation BG with last IO

Filipe Manana <fdmanana@suse.com>
    btrfs: fix space cache inconsistency after error loading it from disk

Anastasia Belova <abelova@astralinux.ru>
    btrfs: print-tree: parent bytenr must be aligned to sector size

Qu Wenruo <wqu@suse.com>
    btrfs: make clear_cache mount option to rebuild FST without disabling it

Christoph Hellwig <hch@lst.de>
    btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't free qgroup space unless specified

Boris Burkov <boris@bur.io>
    btrfs: fix encoded write i_size corruption with no-holes

xiaoshoukui <xiaoshoukui@gmail.com>
    btrfs: fix assertion of exclop condition when starting balance

Qu Wenruo <wqu@suse.com>
    btrfs: properly reject clear_cache and v1 cache for block-group-tree

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones

Filipe Manana <fdmanana@suse.com>
    btrfs: fix btrfs_prev_leaf() to not return the same key twice

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retbleed: Fix return thunk alignment

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: hit ENOENT on unexisting chain/flowtable update with missing attributes

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: rename function to destroy hook list

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: extended netlink error reporting for netdevice

Paulo Alcantara <pc@manguebit.com>
    cifs: avoid potential races when handling multiple dfs tcons

Shyam Prasad N <sprasad@microsoft.com>
    cifs: check only tcon status on tcon related functions

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix potential memory leak

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue from smb2 close and logoff with multichannel

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: destroy expired sessions

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: block asynchronous requests when making a delay on session setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue from session setup and logoff

Dawei Li <set_pte_at@outlook.com>
    ksmbd: Implements sess->ksmbd_chann_list as xarray

Sean Christopherson <seanjc@google.com>
    KVM: x86: Preserve TDP MMU roots until they are explicitly invalidated

Sean Christopherson <seanjc@google.com>
    KVM: x86/mmu: Replace open coded usage of tdp_mmu_page with is_tdp_mmu_page()

David Matlack <dmatlack@google.com>
    KVM: x86/mmu: Move TDP MMU VM init/uninit behind tdp_mmu_enabled

David Matlack <dmatlack@google.com>
    KVM: x86/mmu: Change tdp_mmu to a read-only parameter

Dmitrii Dolgov <9erthalion6@gmail.com>
    perf stat: Separate bperf from bpf_profiler

Yang Jihong <yangjihong1@huawei.com>
    perf tracepoint: Fix memory leak in is_valid_tracepoint()

Yang Jihong <yangjihong1@huawei.com>
    perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Olivier Bacon <olivierb89@gmail.com>
    crypto: engine - fix crypto_queue backlog handling

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: engine - Use crypto_request_complete

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Add scaffolding to change completion function signature

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

James Clark <james.clark@arm.com>
    perf cs-etm: Fix timeless decode mode detection

Markus Elfring <Markus.Elfring@web.de>
    perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events power9: Remove UTF-8 characters from JSON files

Yang Jihong <yangjihong1@huawei.com>
    perf ftrace: Make system wide the default target for latency subcommand

Patrice Duroux <patrice.duroux@gmail.com>
    perf tests record_offcpu.sh: Fix redirection of stderr to stdin

Thomas Richter <tmricht@linux.ibm.com>
    perf vendor events s390: Remove UTF-8 characters from JSON file

Namhyung Kim <namhyung@kernel.org>
    perf hist: Improve srcfile sort key performance (really)

Adrian Hunter <adrian.hunter@intel.com>
    perf script: Fix Python support when no libtraceevent

Roman Lozko <lozko.roma@gmail.com>
    perf scripts intel-pt-events.py: Fix IPC output for Python 2

Ian Rogers <irogers@google.com>
    perf build: Support python/perf.so testing

Kan Liang <kan.liang@linux.intel.com>
    perf record: Fix "read LOST count failed" msg with sample read

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: correct the counting of XDP sent frames

Wei Fang <wei.fang@nxp.com>
    net: enetc: check the index of the SFI rather than the handle

Wenliang Wang <wangwenliang.1995@bytedance.com>
    virtio_net: suppress cpu stall when free_unused_bufs

Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
    ice: block LAN in case of VF to VF offload

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix network connectivity with multiple CPU ports

Daniel Golle <daniel@makrotopia.org>
    net: dsa: mt7530: split-off common parts from mt7531_setup

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix corrupt frames using trgmii on 40 MHz XTAL MT7621

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: fix race in gmap_make_secure()

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: pv: fix asynchronous teardown for small VMs

Ruliang Lin <u202112092@hust.edu.cn>
    ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Chia-I Wu <olvaffe@gmail.com>
    drm/amdgpu: add a missing lock for AMDGPU_SCHED

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Shannon Nelson <shannon.nelson@amd.com>
    ionic: catch failure from devlink_alloc

Ido Schimmel <idosch@nvidia.com>
    ethtool: Fix uninitialized number of lanes

Shannon Nelson <shannon.nelson@amd.com>
    ionic: remove noise from ethtool rxnfc error msg

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-vf: Detach LF resources on probe cleanup

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Disable packet I/O for graceful exit

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Skip PFs if not enabled

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Fix issues with NPC field hash extract

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Update/Fix NPC field hash extract feature

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Update correct mask to filter IPv4 fragments

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Add validation for lmac type

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-pf: Increase the size of dmac filter flows

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Fix depth of cam and mem table.

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Fix start and end bit for scan config

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Secure APR table update with the lock

Jeremy Sowden <jeremy@azazel.net>
    selftests: netfilter: fix libmnl pkg-config usage

Radhakrishna Sripada <radhakrishna.sripada@intel.com>
    drm/i915/mtl: Add the missing CPU transcoder mask in intel_device_info

Felix Fietkau <nbd@nbd.name>
    net: ethernet: mtk_eth_soc: drop generic vlan rx offload, only use DSA untagging

Guo Ren <guoren@kernel.org>
    riscv: compat_syscall_table: Fixup compile warning

David Howells <dhowells@redhat.com>
    rxrpc: Fix timeout of a call that hasn't yet been granted a channel

David Howells <dhowells@redhat.com>
    rxrpc: Make it so that a waiting process can be aborted

David Howells <dhowells@redhat.com>
    rxrpc: Fix hard call timeout units

Andy Moreton <andy.moreton@amd.com>
    sfc: Fix module EEPROM reporting for QSFP modules

Hayes Wang <hayeswang@realtek.com>
    r8152: move setting r8153b_rx_agg_chg_indicate()

Hayes Wang <hayeswang@realtek.com>
    r8152: fix the poor throughput for 2.5G devices

Hayes Wang <hayeswang@realtek.com>
    r8152: fix flow control issue of RTL8156A

Victor Nogueira <victor@mojatatu.com>
    net/sched: act_mirred: Add carrier check

Akhil R <akhilrajeev@nvidia.com>
    i2c: tegra: Fix PEC support for SMBUS block read

Sia Jee Heng <jeeheng.sia@starfivetech.com>
    RISC-V: mm: Enable huge page support to kernel_page_present() function

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()

Tao Su <tao1.su@linux.intel.com>
    block: Skip destroyed blkg when restart in blkg_destroy_all()

Maxim Korotkov <korotkov.maxim.s@gmail.com>
    writeback: fix call of incorrect macro

Angelo Dureghello <angelo.dureghello@timesys.com>
    net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

Antoine Tenart <atenart@kernel.org>
    net: ipv6: fix skb hash for some RST packets

Andrea Mayer <andrea.mayer@uniroma2.it>
    selftests: srv6: make srv6_end_dt46_l3vpn_test more robust

Cong Wang <cong.wang@bytedance.com>
    sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Vlad Buslov <vladbu@nvidia.com>
    net/sched: cls_api: remove block_cb from driver_list before freeing

Eric Dumazet <edumazet@google.com>
    tcp: fix skb_copy_ubufs() vs BIG TCP

Cosmo Chou <chou.cosmo@gmail.com>
    net/ncsi: clear Tx enable mode when handling a Config required AEN

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: mcs: Do not reset PN while updating secy

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: mcs: Fix shared counters logic

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: mcs: Clear stats before freeing resource

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: mcs: Match macsec ethertype along with DMAC

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: mcs: Fix NULL pointer dereferences

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: mcs: Fix MCS block interrupt

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: mcs: Config parser to skip 8B header

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-af: mcs: Write TCAM_DATA and TCAM_MASK registers at once

Geetha sowjanya <gakula@marvell.com>
    octeonxt2-af: mcs: Fix per port bypass config

John Hickey <jjh@daedalian.us>
    ixgbe: Fix panic during XDP_TX with > 64 CPUs

David Howells <dhowells@redhat.com>
    rxrpc: Fix potential data race in rxrpc_wait_to_be_connected()

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Update bounding box values for DCN321

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Do not clear GPINT register when releasing DMUB from reset

Cruise Hung <Cruise.Hung@amd.com>
    drm/amd/display: Reset OUTBOX0 r/w pointer on DMUB reset

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fixes for dcn32_clk_mgr implementation

Hersen Wu <hersenxs.wu@amd.com>
    drm/amd/display: Return error code on DSC atomic check failure

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Add missing WA and MCLK validation

Zheng Wang <zyytlz.wz@163.com>
    scsi: qedi: Fix use after free bug in qedi_remove()

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: soc-acpi-byt: Fix "WM510205" match no longer working

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Extend dbg log messages to err and info

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Change rxe_dbg to rxe_dbg_dev

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Remove rxe_alloc()

Sean Christopherson <seanjc@google.com>
    KVM: x86/mmu: Refresh CR0.WP prior to checking for emulated permission faults

Mathias Krause <minipli@grsecurity.net>
    KVM: VMX: Make CR0.WP a guest owned bit

Mathias Krause <minipli@grsecurity.net>
    KVM: x86: Make use of kvm_read_cr*_bits() when testing bits

Mathias Krause <minipli@grsecurity.net>
    KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP enabled

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86/mmu: Avoid indirect call for get_cr3

Ryan Lin <tsung-hua.lin@amd.com>
    drm/amd/display: Ext displays with dock can't recognized after resume

ZhangPeng <zhangpeng362@huawei.com>
    fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
    mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s25hx SEMPER flash

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix counts of child nodes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mailbox: zynq: Switch to flexible array to simplify code

Manivannan Sadhasivam <mani@kernel.org>
    soc: qcom: llcc: Do not create EDAC platform device on SDM845

Manivannan Sadhasivam <mani@kernel.org>
    qcom: llcc/edac: Support polling mode for ECC handling

Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
    mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx SEMPER flash

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: spi-nor: Add a RWW flag

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: wcd938x: fix accessing regmap on unattached devices

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: constify static sdw_slave_ops struct

Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
    crypto: ccp - Clear PSP interrupt status register before calling handler

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Execute gadget stop after halting the controller

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: gadget: drop dead hibernation code


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  |    2 +-
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts  |    4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |    2 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |    2 +-
 arch/riscv/kernel/Makefile                         |    1 +
 arch/riscv/mm/pageattr.c                           |    8 +
 arch/s390/kernel/uv.c                              |   32 +-
 arch/s390/kvm/pv.c                                 |    5 +
 arch/s390/mm/gmap.c                                |    7 +
 arch/sh/Kconfig.debug                              |    2 +-
 arch/sh/kernel/head_32.S                           |    6 +-
 arch/sh/kernel/nmi_debug.c                         |    4 +-
 arch/sh/kernel/setup.c                             |    4 +-
 arch/sh/math-emu/sfp-util.h                        |    4 -
 arch/x86/include/asm/kvm_host.h                    |   13 +-
 arch/x86/kernel/amd_nb.c                           |    2 +
 arch/x86/kvm/kvm_cache_regs.h                      |    2 +-
 arch/x86/kvm/mmu.h                                 |   32 +-
 arch/x86/kvm/mmu/mmu.c                             |  110 ++-
 arch/x86/kvm/mmu/paging_tmpl.h                     |    2 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         |  130 ++-
 arch/x86/kvm/mmu/tdp_mmu.h                         |    7 +-
 arch/x86/kvm/pmu.c                                 |    4 +-
 arch/x86/kvm/vmx/nested.c                          |    4 +-
 arch/x86/kvm/vmx/vmx.c                             |    6 +-
 arch/x86/kvm/vmx/vmx.h                             |   18 +
 arch/x86/kvm/x86.c                                 |   12 +
 arch/x86/lib/clear_page_64.S                       |    2 +-
 arch/x86/lib/retpoline.S                           |    4 +-
 block/blk-cgroup.c                                 |    3 +
 crypto/algapi.c                                    |    3 +
 crypto/crypto_engine.c                             |   10 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    2 +-
 drivers/crypto/ccp/psp-dev.c                       |    6 +-
 drivers/edac/qcom_edac.c                           |   52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   59 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   36 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |    1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c             |  107 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   98 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   28 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    1 +
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |    5 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    3 +
 drivers/gpu/drm/amd/display/dc/dc.h                |    1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   16 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |    8 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c  |   13 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c    |   23 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   |   10 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h   |    2 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c    |    1 +
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    |    1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |    1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |   12 +-
 .../drm/amd/display/dc/dcn321/dcn321_resource.c    |   10 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   15 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |   18 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |    4 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |    5 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.h |    1 +
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c |   24 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |   23 +-
 .../drm/amd/display/dc/inc/hw_sequencer_private.h  |    4 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  |    3 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   25 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |    1 -
 drivers/gpu/drm/i915/display/icl_dsi.c             |    2 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |   11 -
 drivers/gpu/drm/i915/display/intel_dsi_vbt.h       |    1 -
 drivers/gpu/drm/i915/display/skl_scaler.c          |   57 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   22 +-
 drivers/gpu/drm/i915/gt/intel_gt_regs.h            |    4 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   33 +
 drivers/gpu/drm/i915/i915_pci.c                    |    2 +
 drivers/gpu/drm/i915/i915_reg.h                    |    4 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   16 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   52 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |    2 +-
 drivers/hid/wacom_wac.c                            |   38 +-
 drivers/hid/wacom_wac.h                            |    1 +
 drivers/i2c/busses/i2c-tegra.c                     |   40 +-
 drivers/infiniband/sw/rxe/rxe.c                    |    8 +-
 drivers/infiniband/sw/rxe/rxe.h                    |   45 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |    6 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c               |    4 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c               |    6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |    2 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |    4 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |   46 -
 drivers/infiniband/sw/rxe/rxe_pool.h               |    3 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   16 +-
 drivers/infiniband/sw/rxe/rxe_srq.c                |    6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   61 +-
 drivers/irqchip/irq-loongson-eiointc.c             |   32 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |    6 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               |   13 +-
 drivers/mtd/spi-nor/core.c                         |    6 +
 drivers/mtd/spi-nor/core.h                         |    4 +
 drivers/mtd/spi-nor/debugfs.c                      |    2 +
 drivers/mtd/spi-nor/spansion.c                     |   20 +-
 drivers/net/dsa/mt7530.c                           |  113 ++-
 drivers/net/dsa/mv88e6xxx/chip.c                   |    1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    1 -
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |   13 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |    3 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    6 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    8 +
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |    5 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   19 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c    |  110 +--
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h    |   26 +-
 .../ethernet/marvell/octeontx2/af/mcs_cnf10kb.c    |   63 ++
 .../net/ethernet/marvell/octeontx2/af/mcs_reg.h    |    6 +-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |   37 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   49 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |    2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |   13 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |    5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   26 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h |    4 +
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  123 ++-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.h   |   10 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |   48 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    6 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   14 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |    2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  106 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |    1 -
 .../net/ethernet/pensando/ionic/ionic_devlink.c    |    2 +
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    2 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c        |   11 +-
 drivers/net/usb/r8152.c                            |   84 +-
 drivers/net/virtio_net.c                           |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |    1 +
 drivers/platform/x86/hp/hp-wmi.c                   |    1 +
 .../uncore-frequency/uncore-frequency-common.c     |    6 +-
 drivers/platform/x86/thinkpad_acpi.c               |   24 +-
 drivers/platform/x86/touchscreen_dmi.c             |   41 +
 drivers/remoteproc/imx_dsp_rproc.c                 |   12 +-
 drivers/remoteproc/imx_rproc.c                     |    7 +-
 drivers/remoteproc/rcar_rproc.c                    |    9 +-
 drivers/remoteproc/st_remoteproc.c                 |    5 +-
 drivers/remoteproc/stm32_rproc.c                   |    6 +-
 drivers/scsi/qedi/qedi_main.c                      |    3 +
 drivers/soc/qcom/llcc-qcom.c                       |   15 +-
 drivers/spi/spi-fsl-cpm.c                          |   23 +
 drivers/spi/spi-fsl-spi.c                          |   49 +-
 drivers/usb/dwc3/gadget.c                          |   59 +-
 drivers/watchdog/dw_wdt.c                          |    7 +-
 fs/afs/afs.h                                       |    4 +-
 fs/afs/internal.h                                  |    2 +-
 fs/afs/rxrpc.c                                     |    8 +-
 fs/btrfs/backref.c                                 |   19 +-
 fs/btrfs/backref.h                                 |    6 +
 fs/btrfs/block-rsv.c                               |    3 +-
 fs/btrfs/ctree.c                                   |   32 +-
 fs/btrfs/disk-io.c                                 |   25 +-
 fs/btrfs/file-item.c                               |    5 +-
 fs/btrfs/free-space-cache.c                        |    7 +-
 fs/btrfs/free-space-tree.c                         |   50 +-
 fs/btrfs/free-space-tree.h                         |    3 +-
 fs/btrfs/inode.c                                   |    3 +
 fs/btrfs/ioctl.c                                   |    4 +-
 fs/btrfs/print-tree.c                              |    6 +-
 fs/btrfs/relocation.c                              |    2 +-
 fs/btrfs/super.c                                   |    6 +-
 fs/btrfs/zoned.c                                   |   17 +-
 fs/cifs/cifsfs.c                                   |   16 +
 fs/cifs/cifsglob.h                                 |    2 +-
 fs/cifs/connect.c                                  |   24 +-
 fs/cifs/dfs.c                                      |   14 +-
 fs/cifs/dfs_cache.c                                |  137 ++-
 fs/cifs/dfs_cache.h                                |    9 +
 fs/cifs/file.c                                     |    8 +-
 fs/cifs/smb2ops.c                                  |    2 +-
 fs/ext4/balloc.c                                   |   25 +
 fs/ext4/ext4.h                                     |   24 +
 fs/ext4/extents_status.c                           |   30 +-
 fs/ext4/hash.c                                     |    6 +-
 fs/ext4/inline.c                                   |   17 +-
 fs/ext4/inode.c                                    |   20 +-
 fs/ext4/mballoc.c                                  |    6 +-
 fs/ext4/migrate.c                                  |   11 +-
 fs/ext4/mmp.c                                      |   30 +-
 fs/ext4/namei.c                                    |   53 +-
 fs/ext4/super.c                                    |   19 +-
 fs/ext4/xattr.c                                    |    5 +-
 fs/f2fs/extent_cache.c                             |   36 +-
 fs/f2fs/f2fs.h                                     |   15 +-
 fs/f2fs/gc.c                                       |  139 ++-
 fs/f2fs/gc.h                                       |   14 +-
 fs/f2fs/namei.c                                    |   16 +-
 fs/f2fs/segment.c                                  |    6 +-
 fs/fs-writeback.c                                  |    2 +-
 fs/ksmbd/connection.c                              |   68 +-
 fs/ksmbd/connection.h                              |   58 +-
 fs/ksmbd/mgmt/tree_connect.c                       |    3 +
 fs/ksmbd/mgmt/user_session.c                       |  138 +--
 fs/ksmbd/mgmt/user_session.h                       |    5 +-
 fs/ksmbd/server.c                                  |    3 +-
 fs/ksmbd/smb2pdu.c                                 |  122 +--
 fs/ksmbd/smb2pdu.h                                 |    2 +
 fs/ksmbd/transport_tcp.c                           |    2 +-
 fs/notify/inotify/inotify_fsnotify.c               |   11 +-
 fs/ntfs3/bitmap.c                                  |    3 +-
 fs/ntfs3/frecord.c                                 |    2 +-
 fs/ntfs3/fsntfs.c                                  |    6 +-
 fs/ntfs3/namei.c                                   |   10 +
 fs/ntfs3/ntfs.h                                    |    3 -
 fs/proc/proc_sysctl.c                              |   42 +-
 include/crypto/algapi.h                            |    7 +
 include/drm/display/drm_dp.h                       |   10 +-
 include/drm/display/drm_dp_helper.h                |    5 +-
 include/linux/crypto.h                             |    6 +
 include/linux/pci_ids.h                            |    1 +
 include/net/af_rxrpc.h                             |   21 +-
 kernel/locking/rwsem.c                             |    8 +-
 net/core/skbuff.c                                  |   20 +-
 net/ethtool/ioctl.c                                |    2 +-
 net/ipv6/sit.c                                     |    8 +-
 net/ipv6/tcp_ipv6.c                                |    2 +-
 net/ncsi/ncsi-aen.c                                |    1 +
 net/netfilter/nf_tables_api.c                      |   69 +-
 net/packet/af_packet.c                             |    2 +-
 net/rxrpc/af_rxrpc.c                               |    3 +
 net/rxrpc/ar-internal.h                            |    1 +
 net/rxrpc/call_object.c                            |    9 +-
 net/rxrpc/sendmsg.c                                |   22 +-
 net/sched/act_mirred.c                             |    2 +-
 net/sched/cls_api.c                                |    1 +
 sound/soc/codecs/rt1316-sdw.c                      |    2 +-
 sound/soc/codecs/rt1318-sdw.c                      |    2 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |    2 +-
 sound/soc/codecs/rt715-sdca-sdw.c                  |    2 +-
 sound/soc/codecs/wcd938x-sdw.c                     | 1039 +++++++++++++++++++-
 sound/soc/codecs/wcd938x.c                         | 1003 +------------------
 sound/soc/codecs/wcd938x.h                         |    1 +
 sound/soc/codecs/wsa881x.c                         |    2 +-
 sound/soc/codecs/wsa883x.c                         |    2 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  |    2 +-
 sound/usb/caiaq/input.c                            |    1 +
 tools/perf/Build                                   |    2 +-
 tools/perf/Makefile.perf                           |    7 +-
 tools/perf/builtin-ftrace.c                        |    6 +-
 tools/perf/builtin-record.c                        |    2 +-
 tools/perf/builtin-script.c                        |    2 +-
 tools/perf/builtin-stat.c                          |    4 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |    4 +-
 .../pmu-events/arch/powerpc/power9/pipeline.json   |    2 +-
 .../perf/pmu-events/arch/s390/cf_z16/extended.json |   10 +-
 tools/perf/scripts/Build                           |    4 +-
 tools/perf/scripts/python/Perf-Trace-Util/Build    |    2 +-
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |    4 +
 tools/perf/scripts/python/intel-pt-events.py       |    2 +-
 tools/perf/tests/make                              |    5 +-
 tools/perf/tests/shell/record_offcpu.sh            |    2 +-
 tools/perf/util/Build                              |    2 +-
 tools/perf/util/cs-etm.c                           |   34 +-
 tools/perf/util/evsel.h                            |    5 +
 tools/perf/util/pmu.c                              |    2 +-
 tools/perf/util/scripting-engines/Build            |    2 +-
 .../util/scripting-engines/trace-event-python.c    |   75 +-
 tools/perf/util/sort.c                             |   10 +-
 tools/perf/util/symbol-elf.c                       |    2 +-
 tools/perf/util/trace-event-scripting.c            |    9 +-
 tools/perf/util/tracepoint.c                       |    1 +
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh      |   10 +-
 tools/testing/selftests/netfilter/Makefile         |    7 +-
 285 files changed, 3973 insertions(+), 2755 deletions(-)


