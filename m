Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD06AFCE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCHCZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCHCY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:24:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC461A3363;
        Tue,  7 Mar 2023 18:24:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PWbkB1SP2z4x7y;
        Wed,  8 Mar 2023 13:24:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678242290;
        bh=b1VRTw4IdniaXHoSJ/ehBFWyNzzM4517zhBp++kJQys=;
        h=Date:From:To:Cc:Subject:From;
        b=Wws8vXjuiNFfv4Rlz6TIEcIdc3vktw6b6gXYm4VLETuzuUjnXsWEb1iY22wxkMTff
         SVHo8/3QTxQ/vbysSdS3xi2SmvrNxev0V5WWeT8y0e809WBngPVef5MqMkRuD/ToiZ
         0FddY1qYq9tBVgX2jOC2HrV0XuAaa2y+W/8JESZmAhoCQiKKfNWwqR7P8HznRjev5j
         yDXhO/gY4ciYtlCTiZLk4oVkLqClmKmJlLryCpQXitlNfCp3fnw9gmhQAwKk23A20p
         UVU9MFCy8/1Wrr1MDXOWCwHG6NgjQ05dr3uYLSsIFWg2R843o9VodGrUw2bjTS6SwL
         rrnZ0dpBo2CIQ==
Date:   Wed, 8 Mar 2023 13:02:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 8
Message-ID: <20230308130239.71ac2592@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QXjIDlU7Yv.gaQ2s8Bq49r9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QXjIDlU7Yv.gaQ2s8Bq49r9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230307:

The mm tree lost its build failure.

The imx-msx tree losy its build failure.

The ext4 tree still had its complex conflict against Linus' tree, so I
used the ext4 tree from next-20230217 again.

The driver-core tree lost its boot time warning.

Non-merge commits (relative to Linus' tree): 1478
 1687 files changed, 55370 insertions(+), 27579 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386,
arm64, sparc and sparc64 defconfig and htmldocs. And finally, a simple
boot test of the powerpc pseries_le_defconfig kernel in qemu (with and
without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 354 trees (counting Linus' and 100 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (63355b9884b3 cpumask: be more careful with 'cpumask_=
setall()')
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (f32dbca5cdae mm, vmalloc: fix hig=
h order __GFP_NOFAIL allocations)
Merging kbuild-current/fixes (ced0f245ed95 kallsyms: add kallsyms_seqs_of_n=
ames to list of special symbols)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2f62847cf6ae ARM: 9287/1: Reduce __thumb2__ defi=
nition to crypto files that require it)
Merging arm64-fixes/for-next/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging arm-soc-fixes/arm/fixes (9f79762ef8d9 Merge tag 'samsung-dt-fixes-6=
.3' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/=
fixes)
Merging davinci-current/davinci/for-current (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (e36a82bebbf7 m68k: Only force 030 bus error=
 if PC not in exception table)
Merging powerpc-fixes/fixes (f8b2336f15f3 powerpc: Avoid dead code/data eli=
mination when using recordmcount)
Merging s390-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (31e1be62abde MAINTAINERS: update fscry=
pt git repo)
Merging fsverity-current/for-current (ef7592e466ef MAINTAINERS: update fsve=
rity git repo, list, and patchwork)
Merging net/main (382e363d5bed net: usb: qmi_wwan: add Telit 0x1080 composi=
tion)
Merging bpf/master (757b56a6c7bb Merge tag 'for-netdev' of https://git.kern=
el.org/pub/scm/linux/kernel/git/bpf/bpf)
Merging ipsec/master (c276a706ea1f xfrm: Allow transport-mode states with A=
F_UNSPEC selector)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (aabef97a3516 netfilter: nft_quota: copy content when c=
loning expression)
Merging wireless/for-next (52fd90638a72 wifi: wext: warn about usage only o=
nce)
Merging rdma-fixes/for-rc (fe15c26ee26e Linux 6.3-rc1)
Merging sound-current/for-linus (a8e98f3448e1 ALSA: ice1712: Delete unreach=
able code in aureon_add_controls())
Merging sound-asoc-fixes/for-linus (38d408f5b125 ASoC: Intel: avs: Machine =
board fixes)
Merging regmap-fixes/for-linus (fe15c26ee26e Linux 6.3-rc1)
Merging regulator-fixes/for-linus (fe15c26ee26e Linux 6.3-rc1)
Merging spi-fixes/for-linus (fe15c26ee26e Linux 6.3-rc1)
Merging pci-current/for-linus (fe15c26ee26e Linux 6.3-rc1)
Merging driver-core.current/driver-core-linus (ec738ca127d0 mtd: spi-nor: f=
ix memory leak when using debugfs_lookup())
Merging tty.current/tty-linus (fe15c26ee26e Linux 6.3-rc1)
Merging usb.current/usb-linus (fe15c26ee26e Linux 6.3-rc1)
Merging usb-serial-fixes/usb-linus (4ec5183ec486 Linux 6.2-rc7)
Merging phy/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging staging.current/staging-linus (fe15c26ee26e Linux 6.3-rc1)
Merging iio-fixes/fixes-togreg (03fada47311a iio: accel: kionix-kx022a: Get=
 the timestamp from the driver's private data in the trigger_handler)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (fe15c26ee26e Linux 6.3-rc1)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (7af9da8ce8f9 thunderbolt: Add quirk to dis=
able CLx)
Merging input-current/for-linus (7ae9fb1b7ecb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (660ca9470f9c crypto: caam - Fix edesc/iv ord=
ering mixup)
Merging vfio-fixes/for-linus (51cdc8bc120e kvm/vfio: Fix potential deadlock=
 on vfio group_lock)
Merging kselftest-fixes/fixes (2da789cda462 selftests: amd-pstate: fix TEST=
_FILES)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (75dce6a941e3 mtd: nand: mxic-ecc: Fix mxic_ecc=
_data_xfer_wait_for_completion() when irq is used)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (3e62aba8284d media: imx-mipi-csis: Check csis_=
fmt validity before use)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging at91-fixes/at91-fixes (9bfa2544dbd1 ARM: dts: at91: sam9x60: fix th=
e ddr clock for sam9x60)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (2c10b61421a2 kvm: initialize all of the kvm_debug=
regs structure before sending it to userspace)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (e36b87219dd6 hwmon: (nzxt-smart2) add another US=
B ID)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (2f507cde4fd3 Merge branch 'misc-6.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (caa82ae7ef52 openrisc: fix livelock in uaccess)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (1a0009abfa78 platform: mellanox: mlx-platf=
orm: Initialize shift variable to 0)
Merging samsung-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-samsung-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree-fixes/dt/linus (707344c8a188 dt-bindings: interrupt-cont=
roller: arm,gic-v3: Fix typo in description of msi-controller property)
Merging dt-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging scsi-fixes/fixes (288b3271d920 scsi: sd: Fix wrong zone_write_granu=
larity value during revalidate)
Merging drm-fixes/drm-fixes (66305069eb6d Merge tag 'drm-misc-fixes-2023-02=
-23' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging mmc-fixes/fixes (3f18c5046e63 mmc: jz4740: Work around bug on JZ476=
0(B))
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (1eb65c868731 Drivers: vmbus: Check for c=
hannel allocation before looking up relids)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (bf89b7ee52af RISC-V: fix taking the text_mutex =
twice during sifive errata patching)
Merging riscv-dt-fixes/riscv-dt-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging fpga-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging spdx/spdx-linus (fe15c26ee26e Linux 6.3-rc1)
Merging gpio-brgl-fixes/gpio/for-current (d49765b5f432 gpio: GPIO_REGMAP: s=
elect REGMAP instead of depending on it)
Merging gpio-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging erofs-fixes/fixes (83cf6dd6c187 erofs: use wrapper i_blocksize() in=
 erofs_file_read_iter())
Merging kunit-fixes/kunit-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (fd9a2e1d5138 NFSD: Protect against filesyste=
m freezing)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (14e998ed4220 tools include UAPI: Sync lin=
ux/vhost.h with the kernel sources)
Merging efi-fixes/urgent (112fd39a2722 efi: libstub: Drop Altra quirk and S=
MBIOS handling)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (fe15c26ee26e Linux 6.3-rc1)
Merging rust-fixes/rust-fixes (3098cb655e7c rust: bindgen: Add `alt_instr` =
as opaque type)
Merging drm-misc-fixes/for-linux-next-fixes (9a9a8fe26751 drm/ttm: Fix a NU=
LL pointer dereference)
Merging mm-stable/mm-stable (4b7c7c73689d dmapool: create/destroy cleanup)
Merging mm-nonmm-stable/mm-nonmm-stable (1ec35eadc3b4 Merge tag 'clk-for-li=
nus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging mm/mm-everything (b6da721b4566 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (7adf14d8aca1 kbuild: rpm-pkg: remove unneeded KERN=
ELRELEASE from modules/headers_install)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (f9fa0778ee73 perf tests stat_all_metrics: Change tr=
ue workload to sleep workload for system wide check)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (9b07d27d0fbb swiotlb: mark swiotlb_memblock_a=
lloc() as __init)
Merging asm-generic/master (a13408c20526 char/agp: introduce asm-generic/ag=
p.h)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (ba07b4efc989 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (010338d729c1 arm64: kaslr: don't pretend KASLR=
 is enabled if offset < MIN_KIMG_ALIGN)
Merging arm-perf/for-next/perf (e8a709dc2a91 perf: arm_spe: Print the versi=
on of SPE detected)
Merging arm-soc/for-next (519a0ceec9b0 soc: document merges)
Merging amlogic/for-next (001ba459dbec Merge branch 'v6.4/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (22991d8d5725 soc: apple: rtkit: Add r=
egister dump decoding to crashlog)
Merging aspeed/for-next (9dedb7244469 ARM: dts: aspeed: asrock: Correct fir=
mware flash SPI clocks)
Merging at91/at91-next (05ccf9c9c2fc Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (b691373a1bec Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging imx-mxs/for-next (9b56fc853c63 Merge branch 'imx/dt64' into for-nex=
t)
Merging mediatek/for-next (9b2797522f32 Merge branch 'v6.3-next/soc' into f=
or-next)
Merging mvebu/for-next (b80b042da860 Merge branch 'mvebu/fixes' into mvebu/=
for-next)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (37a85785f418 Merge branches 'arm64-fixes-for-6.3' an=
d 'drivers-fixes-for-6.3' into for-next)
Merging renesas/next (f8f70cfd6649 Merge branches 'renesas-dt-bindings-for-=
v6.4' and 'renesas-dts-for-v6.4' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (cc2b5be472c0 Merge branch 'v6.3-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (f0d4b4c1cdb4 Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (6d796c50f84c Linux 6.2-rc6)
Merging stm32/stm32-next (4e74ad9f3af6 ARM: configs: multi_v7: enable NVMEM=
 driver for STM32)
Merging sunxi/sunxi/for-next (caea0128c038 Merge branch 'sunxi/dt-for-6.3' =
into sunxi/for-next)
Merging tee/next (816477edfba6 mm: Remove get_kernel_pages())
Merging tegra/for-next (9b0d904e7e49 Merge branch for-6.3/arm64/dt into for=
-next)
Merging ti/ti-next (47d72bbb6c0f arm64: dts: ti: Makefile: Rearrange entrie=
s alphabetically)
Merging xilinx/for-next (a18426505c2b Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (da39ebac36f0 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (4e197ee880c2 clk: imx6ul: add ethernet refclock m=
ux support)
Merging clk-renesas/renesas-clk (1f04b7939704 clk: renesas: r8a77995: Fix V=
IN parent clock)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (8883bf83127d selftests/ftrace: Add LoongA=
rch kprobe args string tests support)
Merging m68k/for-next (1e5b5df65af9 m68k: /proc/hardware should depend on P=
ROC_FS)
Merging m68knommu/for-next (5aa52ccf692b m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (1b929c02afd3 Linux 6.2-rc1)
Merging mips/mips-next (fe15c26ee26e Linux 6.3-rc1)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (cf559f6a9e3a parisc: Replace regular spinlock w=
ith spin_trylock on panic path)
Merging powerpc/next (d0a32f5520a3 Merge tag 'powerpc-6.3-1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging riscv-dt/riscv-dt-for-next (0e9b70c1e362 riscv: dts: microchip: add=
 mpfs specific macb reset support)
Merging riscv-soc/riscv-soc-for-next (fe15c26ee26e Linux 6.3-rc1)
Merging s390/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging sh/for-next (ff30bd6a6618 sh: clk: Fix clk_enable() to return 0 on =
NULL clk)
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (c9c3395d5e3d Linux 6.2)
Merging vfs-idmapping/for-next (e499214ce3ef acl: don't depend on IOP_XATTR)
Merging fscrypt/for-next (0132b633d942 fs/buffer.c: use b_folio for fscrypt=
 work)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (80d1eec6927a Merge branch 'for-next-current-v6.2-20=
230221' into for-next-20230221)
Merging ceph/master (f7c4d9b133c7 rbd: avoid use-after-free in do_rbd_add()=
 when rbd_dev_create() fails)
Merging cifs/for-next (d0dc41119905 cifs: Move the in_send statistic to __s=
mb_send_rqst())
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (cbae96d053b2 erofs: set block size to the on-disk block =
size)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (63bceed808c5 udf: Warn if block mapping is done for =
in-ICB files)
Merging ext4/dev (2c2dec1e86cc ext4: fix incorrect options show of original=
 mount_opt and extend mount_opt2)
CONFLICT (content): Merge conflict in fs/ext4/inode.c
$ git merge --abort
Merging f2fs/dev (c4ca1f716473 f2fs: convert to use bitmap API)
Merging fsverity/for-next (4f92f4c24b75 fs-verity: simplify sysctls with re=
gister_sysctl())
Merging fuse/for-next (1cc4606d19e3 fuse: add inode/permission checks to fi=
leattr_get/fileattr_set)
Merging gfs2/for-next (c1b0c3cfcbad gfs2: Convert gfs2_page_add_databufs to=
 folios)
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (6686991cea8e ksmbd: set FILE_NAMED_STREAMS at=
tribute in FS_ATTRIBUTE_INFORMATION)
Merging nfs/linux-next (c9c3395d5e3d Linux 6.2)
Merging nfs-anna/linux-next (1683ed16ff1a fs/nfs: Replace kmap_atomic() wit=
h kmap_local_page() in dir.c)
Merging nfsd/nfsd-next (d56cdd8b3a8e lockd: add some client-side tracepoint=
s)
Merging ntfs3/master (2024476646ed fs/ntfs3: Fix root inode checking)
CONFLICT (content): Merge conflict in fs/ntfs3/file.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/ntfs_fs.h
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (f773f0a331d6 ubi: Fix deadlock caused by recursively ho=
lding work_sem)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (9d415a425340 fs/9p: Add new mount mode=
s)
Merging xfs/for-next (8ac5b996bf51 xfs: fix off-by-one-block in xfs_discard=
_folio())
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
Merging iomap/iomap-for-next (471859f57d42 iomap: Rename page_ops to folio_=
ops)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (eca3a04f140a Merge tag 'dlm-6.3' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm)
Merging iversion/iversion-next (eca3a04f140a Merge tag 'dlm-6.3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm)
Merging vfs/for-next (24b6c17c68bf Merge branches 'work.nios2', 'work.misc'=
 and 'work.old-dio' into for-next)
Merging printk/for-next (10d639febe56 Merge branch 'for-6.3' into for-next)
Merging pci/next (fe15c26ee26e Linux 6.3-rc1)
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (ba4378b47c6f Merge branch 'for-6.3/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging i3c/i3c/next (510d2358c466 i3c: master: dw: stop hardcoding initial=
 speed)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (7032d784a133 hwmon: (nct6775) Drop unneed=
ed casting and conjunction)
Merging jc_docs/docs-next (87eae2609955 docs/mm: hugetlbfs_reserv: fix a re=
ference to a file that doesn't exist)
Merging v4l-dvb/master (3e62aba8284d media: imx-mipi-csis: Check csis_fmt v=
alidity before use)
Merging v4l-dvb-next/master (3e62aba8284d media: imx-mipi-csis: Check csis_=
fmt validity before use)
Merging pm/linux-next (06401c1b98b0 Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (ba38f3cbe7db dt-bindings: opp: =
opp-v2-kryo-cpu: enlarge opp-supported-hw maximum)
Merging cpupower/cpupower (fe15c26ee26e Linux 6.3-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (eca4c0eea534 OPP: fix error checking in opp_mig=
rate_dentry())
Merging thermal/thermal/linux-next (6828e402d06f thermal/drivers/st: Remove=
 syscfg based driver)
Merging dlm/next (1361737f102d fs: dlm: switch lkb_sbflags to atomic ops)
Merging rdma/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging net-next/main (36e5e391a25a Merge tag 'for-netdev' of https://git.k=
ernel.org/pub/scm/linux/kernel/git/bpf/bpf-next)
CONFLICT (content): Merge conflict in Documentation/bpf/bpf_devel_QA.rst
Merging bpf-next/for-next (a73dc912aa7e Merge branch 'bpf: bpf memory usage=
')
Merging ipsec-next/master (75da437a2f17 Merge branch '40GbE' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging mlx5-next/mlx5-next (22551e77e550 net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (5ca26d6039a6 Merge tag 'net-6.3-rc1' of git://git=
.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging bluetooth/master (0e21956501c0 Bluetooth: Convert MSFT filter HCI c=
md to hci_sync)
Merging wireless-next/for-next (38ae31922969 wifi: rtl8xxxu: add LEDS_CLASS=
 dependency)
Merging mtd/mtd/next (9116000828de mtd: bcm63xxpart: remove MODULE_LICENSE =
in non-modules)
Merging nand/nand/next (4080d5362416 mtd: parsers: remove reference to conf=
ig MTD_NAND_TMIO)
Merging spi-nor/spi-nor/next (f047382519ca Merge tag 'mtd/fixes-for-6.2-rc4=
' into spi-nor/next)
Merging crypto/master (8b8447531864 crypto: x86/aria-avx - Do not use avx2 =
instructions)
Merging drm/drm-next (fe15c26ee26e Linux 6.3-rc1)
Merging drm-misc/for-linux-next (047a754558d6 drm/shmem-helper: Revert acci=
dental non-GPL export)
Merging amdgpu/drm-next (920da947af28 drm/amdgpu: fix error checking in amd=
gpu_read_mm_registers for nv)
Merging drm-intel/for-linux-next (4b736ed40583 drm/i915: Get rid of the gm4=
5 HPD live state nonsense)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ba=
cklight.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_bi=
os.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/skl_wate=
rmark.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_driver.c
Merging drm-tegra/for-next (b9930311641c gpu: host1x: Fix uninitialized var=
iable use)
Merging drm-msm/msm-next (dbd7a2a941b8 PM / devfreq: Fix build issues with =
devfreq disabled)
Merging drm-msm-lumag/msm-next-lumag (1d233b1cb149 drm/msm/dpu: set pdpu->i=
s_rt_pipe early in dpu_plane_sspp_atomic_update())
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (822242608545 fbdev: omapfb: cleanup inconsistent in=
dentation)
Merging regmap/for-next (054a0da568b9 regmap: Add support for devices with =
no interrupt readback)
Merging sound/for-next (a8e98f3448e1 ALSA: ice1712: Delete unreachable code=
 in aureon_add_controls())
Merging sound-asoc/for-next (7ba38aebdee0 Merge remote-tracking branch 'aso=
c/for-6.4' into asoc-next)
Merging modules/modules-next (b1ec22f8dc85 dyndbg: use the module notifier =
callbacks)
CONFLICT (content): Merge conflict in arch/alpha/kernel/module.c
Merging input/next (d5f7638eb5fe Input: matrix_keypad - replace header incl=
usions by forward declarations)
Merging block/for-next (9fafde167433 Merge branch 'block-6.3' into for-next)
Merging device-mapper/for-next (ae75a25bd83f dm crypt: conditionally enable=
 code needed for tasklet usecases)
Merging libata/for-next (8844f0aa8dc4 ata: pata_parport: Fix ida_alloc retu=
rn value error check)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (571f235163ac mmc: meson-gx: Use devm_platform_get_and_ior=
emap_resource())
Merging mfd/for-mfd-next (e3ba37699d8f gpio: Add support for Intel LJCA USB=
 GPIO driver)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mfd=
/syscon.yaml
Merging backlight/for-backlight-next (b819828b33ef backlight: qcom-wled: Ad=
d PMI8950 compatible)
Merging battery/for-next (13af134bdc6a dt-bindings: power: supply: Revise R=
ichtek RT9467 compatible name)
Merging regulator/for-next (4eb6678ab53c regulator: rt5739: Spelling s/Rcih=
tek/Richtek/)
Merging security/next (63c1845bf1a4 lsm: styling fixes to security/security=
.c)
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (4958db3245fa ima: Introduce MMAP_CHECK_RE=
QPROT hook)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (fe15c26ee26e Linux 6.3-rc1)
Merging smack/next (c0e48d3f7722 smackfs: Added check catlen)
Merging tomoyo/master (ab8527429de6 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (8699d5244e37 tpm: disable hwrng for fTPM on some AMD de=
signs)
Merging watchdog/master (cf3be7e82b12 watchdog: at91rm9200: Only warn once =
about problems in .remove())
Merging iommu/next (bedd29d793da Merge branches 'apple/dart', 'arm/exynos',=
 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree/for-next (1ba7dfb905b3 dt-bindings: regulator: Add mps,m=
pq7932 power-management IC)
Merging dt-krzk/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging mailbox/mailbox-for-next (6ccbe33a3952 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for QDU1000/QRU1000)
Merging spi/for-next (2289fa0704b8 spi: Convert to platform remove callback=
 returning)
Merging tip/master (64bf89978935 Merge branch into tip/master: 'x86/paravir=
t')
Merging clockevents/timers/drivers/next (ab407a1919d2 Merge tag 'clocksourc=
e.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/lin=
ux-rcu into timers/core)
Merging edac/edac-for-next (feac08675023 Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (a83bf176fed4 Merge branch irq/bcm-l2-fixe=
s into irq/irqchip-next)
Merging ftrace/for-next (ca6cbe8c481a Merge tools/for-next)
CONFLICT (content): Merge conflict in Documentation/trace/kprobetrace.rst
Merging rcu/rcu/next (690ae0037d5b Merge branch 'kcsan.2023.02.22a' into HE=
AD)
Merging kvm/next (45dd9bc75d9a KVM: SVM: hyper-v: placate modpost section m=
ismatch error)
Merging kvm-arm/next (96a4627dbbd4 Merge tag ' https://github.com/oupton/li=
nux tags/kvmarm-6.3' from into kvmarm-master/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (62ef199250cd Merge branches 'apic', 'generic', 'misc'=
, 'mmu', 'pmu', 'selftests', 'svm' and 'vmx' into next)
Merging xen-tip/linux-next (99a7bcafbd0d x86/xen/time: cleanup xen_tsc_safe=
_clocksource)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging chrome-platform/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (140d9006dd01 leds: Fix reference to led_set_=
brightness() in doc)
Merging ipmi/for-next (d352cb47df75 ipmi: simplify sysctl registration)
Merging driver-core/driver-core-next (22fd6153c16a driver core: class: fix =
block class problem when removing CONFIG_SYSFS_DEPRECATED*)
Merging usb/usb-next (fe15c26ee26e Linux 6.3-rc1)
Merging thunderbolt/next (988b18553f42 thunderbolt: Refactor DROM reading)
Merging usb-serial/usb-next (617c331d9107 USB: serial: option: add support =
for VW/Skoda "Carstick LTE")
Merging tty/tty-next (fe15c26ee26e Linux 6.3-rc1)
Merging char-misc/char-misc-next (fe15c26ee26e Linux 6.3-rc1)
Merging accel/habanalabs-next (a48bba98380c msm/fbdev: fix unused variable =
warning with clang.)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (ffa562d00072 fpga: bridge: return errors in the show=
() method of the "state" attribute)
Merging icc/icc-next (723da7f4ecda Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (91ba2700aa75 staging: iio: meter: Drop ade7854 driver)
Merging phy-next/next (3584f6392f09 phy: qcom: phy-qcom-snps-eusb2: Add sup=
port for eUSB2 repeater)
Merging soundwire/next (66f95de7c13b soundwire: cadence: further simplify l=
ow-level xfer_msg_defer() callback)
Merging extcon/extcon-next (2e85d0a0201d extcon: qcom-spmi: Switch to platf=
orm_get_irq_byname_optional)
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (d649c34cb916 vfio: Fix NULL pointer dereference caused b=
y uninitialized group->iommufd)
Merging staging/staging-next (fe15c26ee26e Linux 6.3-rc1)
Merging counter-next/counter-next (01f714ee022e counter: fix dependency ref=
erences for config MICROCHIP_TCB_CAPTURE)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (e922bbf37564 dmaengine: idma64: Update bytes_transf=
erred field)
Merging cgroup/for-next (14fffd51f902 Merge branch 'for-6.2-fixes' into for=
-next)
Merging scsi/for-next (288b3271d920 scsi: sd: Fix wrong zone_write_granular=
ity value during revalidate)
Merging scsi-mkp/for-next (ffba85603c62 Merge patch series "lpfc: Update lp=
fc to revision 14.2.0.11")
Merging vhost/linux-next (0d0a7dda9cdf vp_vdpa: fix the crash in hot unplug=
 with vp_vdpa)
Merging rpmsg/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (0d8b4049bb47 kbuild, gpio: gpio-aspeed-sgp=
io: remove MODULE_LICENSE in non-modules)
Merging gpio-intel/for-next (9409d8cf78d9 gpio: elkhartlake: Introduce Inte=
l Elkhart Lake PSE GPIO)
Merging pinctrl/for-next (207baee2a08b Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-renesas/renesas-pinctrl (b37d57e1dacc pinctrl: renesas: r8a=
779g0: Add Audio SSI pins, groups, and functions)
Merging pinctrl-samsung/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pwm/for-next (cf70d01a62c7 pwm: dwc: Use devm_pwmchip_add())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (e1e17d7debf4 kselftest: amd-pstate: Fix spelling mi=
stakes)
Merging kunit/test (fe15c26ee26e Linux 6.3-rc1)
Merging kunit-next/kunit (60684c2bd350 kunit: tool: Add support for m68k un=
der QEMU)
Merging livepatching/for-next (b2e118419db3 Merge branch 'for-6.3/cleanup-r=
elocations' into for-next)
Merging rtc/rtc-next (3ca04951b004 rtc: pm8xxx: add support for nvmem offse=
t)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging ntb/ntb-next (0310a30a9395 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging nvmem/for-next (89b678f5e79a nvmem: core: return -ENOENT if nvmem c=
ell is not found)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (b14033a3e6ba x86/hyperv: Fix hv_get/set_registe=
r for nested bringup)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (fe15c26ee26e Linux 6.3-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (94e19f4fbb1e bus: mhi: ep: Demote unsupported channel=
 error log to debug)
Merging memblock/for-next (34875d6fc52d Add tests for memblock_alloc_node())
Merging cxl/next (e686c32590f4 dax/kmem: Fix leak of memory-hotplug resourc=
es)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (e1d447157f23 firmware/efi sysfb_efi: Add quirk for Lenovo=
 IdeaPad Duet 3)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (603c592a005a Merge branch 'slab/for-6.3/fixes' into =
slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (7ea01d3169a2 rust: delete rust-project.json when ru=
nning make clean)
Merging sysctl/sysctl-next (3be841ef4ea7 userfaultfd: move unprivileged_use=
rfaultfd sysctl to its own file)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (714f3af11b21 cpumask: fix function descript=
ion kernel-doc notation)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (78f7a3fd6dc6 randstruct: disable Clang 15 suppo=
rt)
Merging kspp-gustavo/for-next/kspp (edfea16a6dae drm/vmwgfx: Replace one-el=
ement array with flexible-array member)
Merging iommufd/for-next (4ed4791afb34 iommufd/selftest: Add a selftest for=
 iommufd_device_attach() with a hwpt argument)

--Sig_/QXjIDlU7Yv.gaQ2s8Bq49r9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQH7L8ACgkQAVBC80lX
0Gw3Mwf9EBM5JAy4LC20U8mePixRSrrIn4EGJyU0Jy7PNwanON9PW6ImeSYjhook
9UsaHtoEdth+qM4v9pIlwK+L6neoaQnN52z8lCpSCH6LJjBKDHkyarj4ef22Jewt
T6hxhMZdjXKzwI/X5udVBDtcpJgsrMdzckV+SGFokorPrDxV/m7aZrduudi3q8CD
XzrBRm7cCkUeHb+wYXK1ki8GiK/Dl36/3NDAoXnqK4sfYzkP13TQY+b1zu207ydT
TEWMkF2R2JDL0ylDWoGA8i2zet7etE7kv72mccdpPcxMgGZjdP43iDNpPaLsBdXG
hpkrRVD/xBE9dbfGkZFxtDAv7u3A2A==
=TAWW
-----END PGP SIGNATURE-----

--Sig_/QXjIDlU7Yv.gaQ2s8Bq49r9--
