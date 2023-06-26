Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5829B73E8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFZS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFZS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:28:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775C10FC;
        Mon, 26 Jun 2023 11:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B372A60F30;
        Mon, 26 Jun 2023 18:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6150FC433CA;
        Mon, 26 Jun 2023 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804045;
        bh=oa7yE+3ySae3rH4cl/URCngMV0dxkeH3DHR09x6k8bw=;
        h=From:To:Cc:Subject:Date:From;
        b=YbKGlC1gfuUyPerAeKYTcNrsjx4VIRPOhA9wotsI12kvTcE0a1NRyevkNQbwsNued
         ze7p/+XomrVOlNJJyEctZ7aIld1uR7/XN0zvTIucPiagEELNUHARaXocvyfmaDqHKA
         H5QbWe5x2PucKZ/7dN9EOCdfLxJpQ9ymS92hqHpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 000/170] 6.1.36-rc1 review
Date:   Mon, 26 Jun 2023 20:09:29 +0200
Message-ID: <20230626180800.476539630@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.36-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.36-rc1
X-KernelTest-Deadline: 2023-06-28T18:08+00:00
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

This is the start of the stable review cycle for the 6.1.36 release.
There are 170 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.36-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.36-rc1

Steve French <stfrench@microsoft.com>
    smb: move client and server files to common directory fs/smb

Clark Wang <xiaoning.wang@nxp.com>
    i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
    x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Marc Zyngier <maz@kernel.org>
    KVM: arm64: Restore GICv2-on-GICv3 functionality

Andrey Smetanin <asmetanin@yandex-team.ru>
    vhost_net: revert upend_idx only on retriable error

Shannon Nelson <shannon.nelson@amd.com>
    vhost_vdpa: tell vqs about the negotiated

Min Li <lm0963hack@gmail.com>
    drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Min Li <lm0963hack@gmail.com>
    drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl

Inki Dae <inki.dae@samsung.com>
    drm/exynos: vidi: fix a wrong error return

Nitesh Shetty <nj.shetty@samsung.com>
    null_blk: Fix: memory release when memory_backed=1

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Fix erroneous ADS touchscreen polarities

Simon Horman <horms@kernel.org>
    i2c: mchp-pci1xxxx: Avoid cast to incompatible function type

Sayed, Karimuddin <karimuddin.sayed@intel.com>
    ALSA: hda/realtek: Add "Intel Reference board" and "NUC 13" SSID in the ALC256

Chancel Liu <chancel.liu@nxp.com>
    ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/purgatory: disable branch profiling

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Don't get stuck writing page onto itself under direct I/O

Sicong Jiang <kevin.jiangsc@gmail.com>
    ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ASoC: nau8824: Add quirk to active-high jack-detect

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: add proper error paths in qcom_swrm_startup()

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    soundwire: dmi-quirks: add new mapping for HP Spectre x360

Herve Codina <herve.codina@bootlin.com>
    ASoC: simple-card: Add missing of_node_put() in case of error

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag

Clark Wang <xiaoning.wang@nxp.com>
    spi: lpspi: disable lpspi module irq in DMA mode

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/cio: unregister device when the only path is gone

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x SDW

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7280-idp: drop incorrect dai-cells from WCD938x SDW

Hans de Goede <hdegoede@redhat.com>
    Input: soc_button_array - add invalid acpi_index DMI quirk handling

Uday Shankar <ushankar@purestorage.com>
    nvme: improve handling of long keep alives

Uday Shankar <ushankar@purestorage.com>
    nvme: check IO start time when deciding to defer KA

Uday Shankar <ushankar@purestorage.com>
    nvme: double KA polling frequency to avoid KATO with TBKAS on

Dan Carpenter <dan.carpenter@linaro.org>
    usb: gadget: udc: fix NULL dereference in remove()

Shida Zhang <zhangshida@kylinos.cn>
    btrfs: fix an uninitialized variable warning in btrfs_log_inode

Osama Muhammad <osmtendev@gmail.com>
    nfcsim.c: Fix error checking for debugfs_create_dir

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: cec: core: don't set last_initiator if tx in progress

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: cec: core: disable adapter in cec_devnode_unregister

Steve French <stfrench@microsoft.com>
    smb3: missing null check in SMB2_change_notify

Marc Zyngier <maz@kernel.org>
    arm64: Add missing Set/Way CMO encodings

Denis Arefev <arefev@swemel.ru>
    HID: wacom: Add error check to wacom_parse_and_register()

Maurizio Lombardi <mlombard@redhat.com>
    scsi: target: iscsi: Prevent login threads from racing between each other

Michael Walle <mwalle@kernel.org>
    gpiolib: Fix irq_domain resource tracking for gpiochip_irqchip_add_domain()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    gpio: sifive: add missing check for platform_get_irq

Jiawen Wu <jiawenwu@trustnetic.com>
    gpiolib: Fix GPIO chip IRQ initialization restriction

Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
    arm64: dts: rockchip: fix nEXTRST on SOQuartz

Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
    arm64: dts: rockchip: Enable GPU on SOQuartz CM4

Maciej Żenczykowski <maze@google.com>
    revert "net: align SO_RCVMARK required privileges with SO_MARK"

Eric Dumazet <edumazet@google.com>
    sch_netem: acquire qdisc lock in netem_change()

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: Register notify handler only if SPS is enabled

Danielle Ratson <danieller@nvidia.com>
    selftests: forwarding: Fix race condition in mirror installation

Jens Axboe <axboe@kernel.dk>
    io_uring/net: use the correct msghdr union member in io_sendmsg_copy_hdr

Jiri Olsa <jolsa@kernel.org>
    bpf: Force kprobe multi expected_attach_type for kprobe_multi link

Florent Revest <revest@chromium.org>
    bpf/btf: Accept function names that contain dots

Francesco Dolcini <francesco.dolcini@toradex.com>
    Revert "net: phy: dp83867: perform soft reset and retain established link"

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nfnetlink_osf: fix module autoload

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow updates of anonymous sets

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject unbound chain set before commit phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject unbound anonymous set before commit phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow element updates of bound anonymous sets

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_pipapo: .walk does not deal with generations

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: drop map element references from preparation phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix chain binding transaction logic

Ross Lagerwall <ross.lagerwall@citrix.com>
    be2net: Extend xmit workaround to BE3 chip

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix handling of LLDP frames

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix handling of BPDUs on MT7530 switch

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch

Terin Stock <terin@cloudflare.com>
    ipvs: align inner_mac_header for encapsulation

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: usdhi60rol0: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: sh_mmcif: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: sdhci-acpi: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: owl: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap_hsmmc: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: mvsdio: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: mtk-sd: fix deferred probing

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Avoid high load if QCA7000 is not available

Íñigo Huguet <ihuguet@redhat.com>
    sfc: use budget for TX completions

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Fix wrong action data allocation in decap action

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    xfrm: Linearize the skb after offloading if needed.

Magali Lemes <magali.lemes@canonical.com>
    selftests: net: fcnal-test: check if FIPS mode is enabled

Magali Lemes <magali.lemes@canonical.com>
    selftests: net: vrf-xfrm-tests: change authentication and encryption algos

Magali Lemes <magali.lemes@canonical.com>
    selftests: net: tls: check if FIPS mode is enabled

Yonghong Song <yhs@fb.com>
    bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.

Maciej Żenczykowski <maze@google.com>
    xfrm: fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets

Maxim Mikityanskiy <maxim@isovalent.com>
    bpf: Fix verifier id tracking of scalars on spill

Eduard Zingerman <eddyz87@gmail.com>
    bpf: track immediate values written to stack by BPF_ST instruction

Reiji Watanabe <reijiw@google.com>
    KVM: arm64: PMU: Restore the host's PMUSERENR_EL0

Benedict Wong <benedictwong@google.com>
    xfrm: Ensure policies always checked on XFRM-I input path

Eyal Birger <eyal.birger@gmail.com>
    xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c

Benedict Wong <benedictwong@google.com>
    xfrm: Treat already-verified secpath entries as optional

Chen Aotian <chenaotian2@163.com>
    ieee802154: hwsim: Fix possible memory leaks

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: meson-gx: fix deferred probing

Roberto Sassu <roberto.sassu@huawei.com>
    memfd: check for non-NULL file_seals in memfd_create() syscall

Lee Jones <lee@kernel.org>
    x86/mm: Avoid using set_pgd() outside of real PGD pages

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Jens Axboe <axboe@kernel.dk>
    io_uring/poll: serialize poll linked timer start with poll removal

Andrew Powers-Holmes <aholmes@omnom.net>
    arm64: dts: rockchip: Fix rk356x PCIe register and range mappings

Russ Weight <russell.h.weight@intel.com>
    regmap: spi-avmm: Fix regmap_bus max_raw_write

Teresa Remmet <t.remmet@phytec.de>
    regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK

Neil Armstrong <neil.armstrong@linaro.org>
    spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()

Mukesh Sisodiya <mukesh.sisodiya@intel.com>
    wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0

Krister Johansen <kjlx@templeofstupid.com>
    bpf: ensure main program has an extable

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: sunxi: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: bcm2835: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: sdhci-spear: fix deferred probing

Christophe Kerello <christophe.kerello@foss.st.com>
    mmc: mmci: stm32: fix max busy timeout calculation

Martin Hundebøll <martin@geanix.com>
    mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Stephan Gerhold <stephan@gerhold.net>
    mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916

Jisheng Zhang <jszhang@kernel.org>
    mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex in freezer_css_{online,offline}()

Xiu Jianfeng <xiujianfeng@huawei.com>
    cgroup: Do not corrupt task iteration when rebinding subsystem

Paolo Abeni <pabeni@redhat.com>
    mptcp: consolidate fallback and non fallback state machine

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix possible list corruption on passive MPJ

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix possible divide by zero in recvmsg()

Paolo Abeni <pabeni@redhat.com>
    mptcp: handle correctly disconnect() failures

Jens Axboe <axboe@kernel.dk>
    io_uring/net: disable partial retries for recvmsg with cmsg

Jens Axboe <axboe@kernel.dk>
    io_uring/net: clear msg_controllen on partial sendmsg retry

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Add a per-bus mutex state_lock

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev

Dexuan Cui <decui@microsoft.com>
    Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix a race condition bug in hv_pci_query_relations()

Michael Kelley <mikelley@microsoft.com>
    Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails

Gavin Shan <gshan@redhat.com>
    KVM: Avoid illegal stage2 mapping on invalid memory slot

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix buffer corruption due to concurrent device reads

Prathu Baronia <prathubaronia2011@gmail.com>
    scripts: fix the gfp flags header path in gfp-translate

Rafael Aquini <aquini@redhat.com>
    writeback: fix dereferencing NULL mapping->host on writeback_page_template

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: fix "userspace pm add & remove address"

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip fail tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip userspace PM tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip test if iptables/tc cmds fail

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: skip TCP_INQ checks if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: diag: skip listen tests if not supported

Shuah Khan <skhan@linuxfoundation.org>
    selftests/mount_setattr: fix redefine struct mount_attr build error

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip MPC backups tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip fullmesh flag tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip backup if set flag on ID not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip implicit tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: support RM_ADDR for used endpoints or not

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip Fastclose tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: support local endpoint being tracked or not

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip check if MIB counter not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: helpers to skip tests

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: use 'iptables-legacy' if available

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: lib: skip if not below kernel version

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: userspace pm: skip if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: skip getsockopt checks if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: relax expected returned size

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: pm nl: skip fullmesh flag checks if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: pm nl: remove hardcoded default limits

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: connect: skip disconnect tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: connect: skip transp tests if not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: lib: skip if missing symbol

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: fix ShellCheck warnings

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: remove duplicated entries in usage

Thomas Gleixner <tglx@linutronix.de>
    tick/common: Align tick period during sched_timer setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate session id and tree id in the compound request

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out-of-bound read in smb2_write

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate command payload size

Matthew Garrett <mjg59@srcf.ucam.org>
    tpm_crb: Add support for CRB devices based on Pluton

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Claim locality in interrupt handler

Alexei Starovoitov <ast@kernel.org>
    mm: Fix copy_from_user_nofault().

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Avoid deadlock on rescan after device resume

Robert Hodaszi <robert.hodaszi@digi.com>
    tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: make rx_watermark configurable for different platforms

Tom Chung <chiahsuan.chung@amd.com>
    drm/amd/display: fix the system hang while disable PSR

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Add wrapper to call planes and stream update

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Use dc_update_planes_and_stream


-------------

Diffstat:

 MAINTAINERS                                        |   8 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   2 +-
 arch/arm/boot/dts/imx7d-pico-hobbit.dts            |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |   2 -
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |   2 -
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts      |  18 +-
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi  |  34 +-
 arch/arm64/boot/dts/rockchip/rk3568.dtsi           |  14 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           |   7 +-
 arch/arm64/include/asm/sysreg.h                    |   6 +
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  13 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |  11 +-
 arch/s390/purgatory/Makefile                       |   1 +
 arch/x86/kernel/apic/x2apic_phys.c                 |   5 +-
 arch/x86/mm/kaslr.c                                |   8 +-
 arch/x86/net/bpf_jit_comp.c                        |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 -
 drivers/acpi/sleep.c                               |  16 +-
 drivers/ata/libata-core.c                          |   3 +-
 drivers/ata/libata-eh.c                            |   2 +-
 drivers/ata/libata-scsi.c                          |  22 +-
 drivers/base/regmap/regmap-spi-avmm.c              |   2 +-
 drivers/block/null_blk/main.c                      |   1 +
 drivers/char/tpm/tpm_crb.c                         | 100 ++++-
 drivers/char/tpm/tpm_tis_core.c                    |   2 +
 drivers/gpio/gpio-sifive.c                         |   8 +-
 drivers/gpio/gpiolib.c                             |  11 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  73 +++-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   2 -
 drivers/gpu/drm/radeon/radeon_gem.c                |   4 +-
 drivers/hid/wacom_sys.c                            |   7 +-
 drivers/hv/channel_mgmt.c                          |  18 +-
 drivers/hv/vmbus_drv.c                             |   5 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |   4 +-
 drivers/i2c/busses/i2c-mchp-pci1xxxx.c             |   6 +-
 drivers/input/misc/soc_button_array.c              |  30 ++
 drivers/media/cec/core/cec-adap.c                  |   8 +-
 drivers/media/cec/core/cec-core.c                  |   2 +
 drivers/media/cec/core/cec-priv.h                  |   1 +
 drivers/mmc/host/bcm2835.c                         |   4 +-
 drivers/mmc/host/litex_mmc.c                       |   1 +
 drivers/mmc/host/meson-gx-mmc.c                    |  14 +-
 drivers/mmc/host/mmci.c                            |   3 +-
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/mmc/host/mvsdio.c                          |   2 +-
 drivers/mmc/host/omap.c                            |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |   6 +-
 drivers/mmc/host/owl-mmc.c                         |   2 +-
 drivers/mmc/host/sdhci-acpi.c                      |   2 +-
 drivers/mmc/host/sdhci-msm.c                       |   3 +
 drivers/mmc/host/sdhci-spear.c                     |   4 +-
 drivers/mmc/host/sh_mmcif.c                        |   2 +-
 drivers/mmc/host/sunxi-mmc.c                       |   4 +-
 drivers/mmc/host/usdhi6rol0.c                      |   6 +-
 drivers/net/dsa/mt7530.c                           |  20 +-
 drivers/net/dsa/mt7530.h                           |   5 +
 drivers/net/ethernet/emulex/benet/be_main.c        |   4 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |   9 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |   3 +-
 drivers/net/ethernet/sfc/ef10.c                    |  25 +-
 drivers/net/ethernet/sfc/ef100_nic.c               |   7 +-
 drivers/net/ethernet/sfc/ef100_tx.c                |   4 +-
 drivers/net/ethernet/sfc/ef100_tx.h                |   2 +-
 drivers/net/ethernet/sfc/tx_common.c               |   4 +-
 drivers/net/ethernet/sfc/tx_common.h               |   2 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |   6 +-
 drivers/net/phy/dp83867.c                          |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   2 +
 drivers/nfc/nfcsim.c                               |   4 -
 drivers/nvme/host/core.c                           |  48 +-
 drivers/nvme/host/nvme.h                           |   1 +
 drivers/pci/controller/pci-hyperv.c                | 139 +++---
 drivers/platform/x86/amd/pmf/core.c                |  10 +-
 drivers/s390/cio/device.c                          |   5 +-
 drivers/soundwire/dmi-quirks.c                     |   7 +
 drivers/soundwire/qcom.c                           |  17 +-
 drivers/spi/spi-fsl-lpspi.c                        |   7 +-
 drivers/spi/spi-geni-qcom.c                        |   2 +
 drivers/target/iscsi/iscsi_target_nego.c           |   4 +-
 drivers/tty/serial/fsl_lpuart.c                    |  14 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |   3 +
 drivers/vhost/net.c                                |  11 +-
 drivers/vhost/vdpa.c                               |  13 +
 fs/Kconfig                                         |   9 +-
 fs/Makefile                                        |   4 +-
 fs/btrfs/tree-log.c                                |   2 +-
 fs/gfs2/file.c                                     |  17 +-
 fs/nilfs2/page.c                                   |  10 +-
 fs/nilfs2/segbuf.c                                 |   6 +
 fs/nilfs2/segment.c                                |   7 +
 fs/nilfs2/super.c                                  |  25 +-
 fs/smb/Kconfig                                     |  11 +
 fs/smb/Makefile                                    |   5 +
 fs/{cifs => smb/client}/Kconfig                    |   0
 fs/{cifs => smb/client}/Makefile                   |   0
 fs/{cifs => smb/client}/asn1.c                     |   0
 fs/{cifs => smb/client}/cached_dir.c               |   0
 fs/{cifs => smb/client}/cached_dir.h               |   0
 fs/{cifs => smb/client}/cifs_debug.c               |   0
 fs/{cifs => smb/client}/cifs_debug.h               |   0
 fs/{cifs => smb/client}/cifs_dfs_ref.c             |   0
 fs/{cifs => smb/client}/cifs_fs_sb.h               |   0
 fs/{cifs => smb/client}/cifs_ioctl.h               |   0
 fs/{cifs => smb/client}/cifs_spnego.c              |   0
 fs/{cifs => smb/client}/cifs_spnego.h              |   0
 .../client}/cifs_spnego_negtokeninit.asn1          |   0
 fs/{cifs => smb/client}/cifs_swn.c                 |   0
 fs/{cifs => smb/client}/cifs_swn.h                 |   0
 fs/{cifs => smb/client}/cifs_unicode.c             |   0
 fs/{cifs => smb/client}/cifs_unicode.h             |   0
 fs/{cifs => smb/client}/cifs_uniupr.h              |   0
 fs/{cifs => smb/client}/cifsacl.c                  |   0
 fs/{cifs => smb/client}/cifsacl.h                  |   0
 fs/{cifs => smb/client}/cifsencrypt.c              |   2 +-
 fs/{cifs => smb/client}/cifsfs.c                   |   0
 fs/{cifs => smb/client}/cifsfs.h                   |   0
 fs/{cifs => smb/client}/cifsglob.h                 |   2 +-
 fs/{cifs => smb/client}/cifspdu.h                  |   2 +-
 fs/{cifs => smb/client}/cifsproto.h                |   0
 fs/{cifs => smb/client}/cifsroot.c                 |   0
 fs/{cifs => smb/client}/cifssmb.c                  |   0
 fs/{cifs => smb/client}/connect.c                  |   0
 fs/{cifs => smb/client}/dfs_cache.c                |   0
 fs/{cifs => smb/client}/dfs_cache.h                |   0
 fs/{cifs => smb/client}/dir.c                      |   0
 fs/{cifs => smb/client}/dns_resolve.c              |   0
 fs/{cifs => smb/client}/dns_resolve.h              |   0
 fs/{cifs => smb/client}/export.c                   |   0
 fs/{cifs => smb/client}/file.c                     |   0
 fs/{cifs => smb/client}/fs_context.c               |   0
 fs/{cifs => smb/client}/fs_context.h               |   0
 fs/{cifs => smb/client}/fscache.c                  |   0
 fs/{cifs => smb/client}/fscache.h                  |   0
 fs/{cifs => smb/client}/inode.c                    |   2 +-
 fs/{cifs => smb/client}/ioctl.c                    |   0
 fs/{cifs => smb/client}/link.c                     |   0
 fs/{cifs => smb/client}/misc.c                     |   0
 fs/{cifs => smb/client}/netlink.c                  |   0
 fs/{cifs => smb/client}/netlink.h                  |   0
 fs/{cifs => smb/client}/netmisc.c                  |   0
 fs/{cifs => smb/client}/nterr.c                    |   0
 fs/{cifs => smb/client}/nterr.h                    |   0
 fs/{cifs => smb/client}/ntlmssp.h                  |   0
 fs/{cifs => smb/client}/readdir.c                  |   0
 fs/{cifs => smb/client}/rfc1002pdu.h               |   0
 fs/{cifs => smb/client}/sess.c                     |   0
 fs/{cifs => smb/client}/smb1ops.c                  |   0
 fs/{cifs => smb/client}/smb2file.c                 |   0
 fs/{cifs => smb/client}/smb2glob.h                 |   0
 fs/{cifs => smb/client}/smb2inode.c                |   0
 fs/{cifs => smb/client}/smb2maperror.c             |   0
 fs/{cifs => smb/client}/smb2misc.c                 |   0
 fs/{cifs => smb/client}/smb2ops.c                  |   0
 fs/{cifs => smb/client}/smb2pdu.c                  |   2 +-
 fs/{cifs => smb/client}/smb2pdu.h                  |   0
 fs/{cifs => smb/client}/smb2proto.h                |   0
 fs/{cifs => smb/client}/smb2status.h               |   0
 fs/{cifs => smb/client}/smb2transport.c            |   0
 fs/{cifs => smb/client}/smbdirect.c                |   0
 fs/{cifs => smb/client}/smbdirect.h                |   0
 fs/{cifs => smb/client}/smbencrypt.c               |   2 +-
 fs/{cifs => smb/client}/smberr.h                   |   0
 fs/{cifs => smb/client}/trace.c                    |   0
 fs/{cifs => smb/client}/trace.h                    |   0
 fs/{cifs => smb/client}/transport.c                |   0
 fs/{cifs => smb/client}/unc.c                      |   0
 fs/{cifs => smb/client}/winucase.c                 |   0
 fs/{cifs => smb/client}/xattr.c                    |   0
 fs/{smbfs_common => smb/common}/Makefile           |   4 +-
 fs/{smbfs_common => smb/common}/arc4.h             |   0
 fs/{smbfs_common => smb/common}/cifs_arc4.c        |   0
 fs/{smbfs_common => smb/common}/cifs_md4.c         |   0
 fs/{smbfs_common => smb/common}/md4.h              |   0
 fs/{smbfs_common => smb/common}/smb2pdu.h          |   0
 fs/{smbfs_common => smb/common}/smbfsctl.h         |   0
 fs/{ksmbd => smb/server}/Kconfig                   |   0
 fs/{ksmbd => smb/server}/Makefile                  |   0
 fs/{ksmbd => smb/server}/asn1.c                    |   0
 fs/{ksmbd => smb/server}/asn1.h                    |   0
 fs/{ksmbd => smb/server}/auth.c                    |   2 +-
 fs/{ksmbd => smb/server}/auth.h                    |   0
 fs/{ksmbd => smb/server}/connection.c              |   0
 fs/{ksmbd => smb/server}/connection.h              |   0
 fs/{ksmbd => smb/server}/crypto_ctx.c              |   0
 fs/{ksmbd => smb/server}/crypto_ctx.h              |   0
 fs/{ksmbd => smb/server}/glob.h                    |   0
 fs/{ksmbd => smb/server}/ksmbd_netlink.h           |   0
 .../server}/ksmbd_spnego_negtokeninit.asn1         |   0
 .../server}/ksmbd_spnego_negtokentarg.asn1         |   0
 fs/{ksmbd => smb/server}/ksmbd_work.c              |   0
 fs/{ksmbd => smb/server}/ksmbd_work.h              |   0
 fs/{ksmbd => smb/server}/mgmt/ksmbd_ida.c          |   0
 fs/{ksmbd => smb/server}/mgmt/ksmbd_ida.h          |   0
 fs/{ksmbd => smb/server}/mgmt/share_config.c       |   0
 fs/{ksmbd => smb/server}/mgmt/share_config.h       |   0
 fs/{ksmbd => smb/server}/mgmt/tree_connect.c       |   0
 fs/{ksmbd => smb/server}/mgmt/tree_connect.h       |   0
 fs/{ksmbd => smb/server}/mgmt/user_config.c        |   0
 fs/{ksmbd => smb/server}/mgmt/user_config.h        |   0
 fs/{ksmbd => smb/server}/mgmt/user_session.c       |   0
 fs/{ksmbd => smb/server}/mgmt/user_session.h       |   0
 fs/{ksmbd => smb/server}/misc.c                    |   0
 fs/{ksmbd => smb/server}/misc.h                    |   0
 fs/{ksmbd => smb/server}/ndr.c                     |   0
 fs/{ksmbd => smb/server}/ndr.h                     |   0
 fs/{ksmbd => smb/server}/nterr.h                   |   0
 fs/{ksmbd => smb/server}/ntlmssp.h                 |   0
 fs/{ksmbd => smb/server}/oplock.c                  |   0
 fs/{ksmbd => smb/server}/oplock.h                  |   0
 fs/{ksmbd => smb/server}/server.c                  |  33 +-
 fs/{ksmbd => smb/server}/server.h                  |   0
 fs/{ksmbd => smb/server}/smb2misc.c                |  33 +-
 fs/{ksmbd => smb/server}/smb2ops.c                 |   0
 fs/{ksmbd => smb/server}/smb2pdu.c                 |  44 +-
 fs/{ksmbd => smb/server}/smb2pdu.h                 |   0
 fs/{ksmbd => smb/server}/smb_common.c              |   0
 fs/{ksmbd => smb/server}/smb_common.h              |   2 +-
 fs/{ksmbd => smb/server}/smbacl.c                  |   0
 fs/{ksmbd => smb/server}/smbacl.h                  |   0
 fs/{ksmbd => smb/server}/smbfsctl.h                |   0
 fs/{ksmbd => smb/server}/smbstatus.h               |   0
 fs/{ksmbd => smb/server}/transport_ipc.c           |   0
 fs/{ksmbd => smb/server}/transport_ipc.h           |   0
 fs/{ksmbd => smb/server}/transport_rdma.c          |   0
 fs/{ksmbd => smb/server}/transport_rdma.h          |   0
 fs/{ksmbd => smb/server}/transport_tcp.c           |   0
 fs/{ksmbd => smb/server}/transport_tcp.h           |   0
 fs/{ksmbd => smb/server}/unicode.c                 |   0
 fs/{ksmbd => smb/server}/unicode.h                 |   0
 fs/{ksmbd => smb/server}/uniupr.h                  |   0
 fs/{ksmbd => smb/server}/vfs.c                     |   2 +-
 fs/{ksmbd => smb/server}/vfs.h                     |   0
 fs/{ksmbd => smb/server}/vfs_cache.c               |   0
 fs/{ksmbd => smb/server}/vfs_cache.h               |   0
 fs/{ksmbd => smb/server}/xattr.h                   |   0
 include/acpi/acpixf.h                              |   1 +
 include/acpi/actbl3.h                              |   1 +
 include/linux/gpio/driver.h                        |   8 +
 include/linux/libata.h                             |   2 +-
 include/linux/regulator/pca9450.h                  |   4 +-
 include/net/netfilter/nf_tables.h                  |  31 +-
 include/net/xfrm.h                                 |   1 +
 include/trace/events/writeback.h                   |   2 +-
 io_uring/net.c                                     |  17 +-
 io_uring/poll.c                                    |   9 +-
 kernel/bpf/btf.c                                   |  20 +-
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  28 +-
 kernel/cgroup/cgroup.c                             |  20 +-
 kernel/cgroup/legacy_freezer.c                     |   8 +-
 kernel/time/tick-common.c                          |  13 +-
 kernel/time/tick-sched.c                           |  13 +-
 mm/maccess.c                                       |  16 +-
 mm/memfd.c                                         |   3 +-
 mm/usercopy.c                                      |   2 +-
 net/core/sock.c                                    |   6 -
 net/ipv4/esp4_offload.c                            |   3 +
 net/ipv4/xfrm4_input.c                             |   1 +
 net/ipv6/esp6_offload.c                            |   3 +
 net/ipv6/xfrm6_input.c                             |   3 +
 net/mptcp/protocol.c                               |  80 ++--
 net/mptcp/subflow.c                                |  17 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   2 +
 net/netfilter/nf_tables_api.c                      | 328 +++++++++++---
 net/netfilter/nfnetlink_osf.c                      |   1 +
 net/netfilter/nft_immediate.c                      |  90 +++-
 net/netfilter/nft_set_bitmap.c                     |   5 +-
 net/netfilter/nft_set_hash.c                       |  23 +-
 net/netfilter/nft_set_pipapo.c                     |  20 +-
 net/netfilter/nft_set_rbtree.c                     |   5 +-
 net/netfilter/xt_osf.c                             |   1 -
 net/sched/sch_netem.c                              |   8 +-
 net/xfrm/Makefile                                  |   2 +
 net/xfrm/xfrm_input.c                              |   1 +
 .../{xfrm_interface.c => xfrm_interface_core.c}    |  54 ++-
 net/xfrm/xfrm_policy.c                             |  12 +
 scripts/gfp-translate                              |   6 +-
 sound/pci/hda/patch_realtek.c                      |   2 +
 sound/soc/amd/yc/acp6x-mach.c                      |   7 +
 sound/soc/codecs/nau8824.c                         |  24 +
 sound/soc/codecs/wcd938x-sdw.c                     |   1 -
 sound/soc/fsl/fsl_sai.c                            |  11 +-
 sound/soc/fsl/fsl_sai.h                            |   1 +
 sound/soc/generic/simple-card.c                    |   1 +
 .../bpf/verifier/bounds_mix_sign_unsign.c          | 110 +++--
 .../selftests/mount_setattr/mount_setattr_test.c   |   7 -
 tools/testing/selftests/net/fcnal-test.sh          |  27 +-
 .../net/forwarding/mirror_gre_bridge_1d.sh         |   4 +
 .../net/forwarding/mirror_gre_bridge_1q.sh         |   4 +
 tools/testing/selftests/net/mptcp/config           |   1 +
 tools/testing/selftests/net/mptcp/diag.sh          |  47 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   8 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  15 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 481 +++++++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  64 +++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |  18 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  20 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  27 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   7 +-
 tools/testing/selftests/net/tls.c                  |  24 +-
 tools/testing/selftests/net/vrf-xfrm-tests.sh      |  32 +-
 virt/kvm/kvm_main.c                                |  20 +-
 313 files changed, 2180 insertions(+), 811 deletions(-)


