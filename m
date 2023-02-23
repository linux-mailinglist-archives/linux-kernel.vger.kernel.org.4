Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2336A01A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjBWDzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWDza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:55:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479937576;
        Wed, 22 Feb 2023 19:55:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMfLc4kMrz4x7y;
        Thu, 23 Feb 2023 14:55:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677124520;
        bh=3Q7ciSGDVN7w5+ktMqgC+nS98VV/73MOimvDpazZFqY=;
        h=Date:From:To:Cc:Subject:From;
        b=uLeigbAI41bPNX1wFpABGuPAamVXmhKHOQHSTgdhITLifDmqgDbHfvJ48GDwkN9F0
         F89KJSUd8vHPOma/vQg9ZgJ4DRxYW61iV3YaqxUEDxoD7Bo06nsrWDm07ZyjiIf/ww
         VyIUzPleOlvzoaIvRyxuKU8rR6AcJJUjPrRRDZyOLu5F+1P9J1wI+wP7Zi42xXZ0eN
         eYBOgiGcG2iBDBSCipz995fLQKwXwwbxOb5wmEtV66I2/jQhNnpn7AeIFw21RwCL0D
         9ahqNy+rppSWuJ4im8/IrTq6mrFDCpBfEd+k2St8sGjBoTVIh1vOQ0tweB1zeG/DpX
         0nyQuYlO0p+PQ==
Date:   Thu, 23 Feb 2023 14:55:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 23
Message-ID: <20230223145519.11eb6515@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P/Xm8G.9VUvifwrmxs3I=nB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P/Xm8G.9VUvifwrmxs3I=nB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Removed tree: powerpc-objtool (no longer needed)

Changes since 20230222:

The mm-stable tree still had its complex conflict against the ext4
tree, so I used the ext4 from next-20230217.

Non-merge commits (relative to Linus' tree): 6632
 6355 files changed, 231512 insertions(+), 143983 deletions(-)

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

I am currently merging 355 trees (counting Linus' and 100 trees of bug
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
Merging origin/master (876206933031 Merge tag 'scsi-misc' of git://git.kern=
el.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (9ff343544b57 mailmap: map Georgi =
Djakov's old Linaro address to his current one)
Merging kbuild-current/fixes (22e46f6480e8 kbuild: modinst: Fix build error=
 when CONFIG_MODULE_SIG_KEY is a PKCS#11 URI)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2f62847cf6ae ARM: 9287/1: Reduce __thumb2__ defi=
nition to crypto files that require it)
Merging arm64-fixes/for-next/fixes (853e2dac25c1 arm64: perf: reject CHAIN =
events at creation time)
Merging arm-soc-fixes/arm/fixes (afeff81765c6 Merge tag 'davinci-fixes-for-=
v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into arm/=
fixes)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (1e5b5df65af9 m68k: /proc/hardware should de=
pend on PROC_FS)
Merging powerpc-fixes/fixes (c9c3395d5e3d Linux 6.2)
Merging s390-fixes/fixes (7ab41c2c08a3 s390/decompressor: specify __decompr=
ess() buf len to avoid overflow)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (31e1be62abde MAINTAINERS: update fscry=
pt git repo)
Merging fsverity-current/for-current (ef7592e466ef MAINTAINERS: update fsve=
rity git repo, list, and patchwork)
Merging net/master (5b7c4cabbb65 Merge tag 'net-next-6.3' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging bpf/master (5b7c4cabbb65 Merge tag 'net-next-6.3' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec/master (8222d5910dae xfrm: Zero padding when dumping algos an=
d encap)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (92f3e96d642f netfilter: nf_tables: allow to fetch set =
elements when table has an owner)
Merging wireless/for-next (7c15430822e7 wifi: ath11k: allow system suspend =
to survive ath11k)
Merging rdma-fixes/for-rc (ceaa837f96ad Linux 6.2-rc8)
Merging sound-current/for-linus (e97fc9cffbb9 Merge tag 'asoc-fix-v6.2-rc8-=
2' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into fo=
r-linus)
Merging sound-asoc-fixes/for-linus (6699c94a3e3e Merge remote-tracking bran=
ch 'asoc/for-6.2' into asoc-linus)
Merging regmap-fixes/for-linus (697c3892d825 regmap: apply reg_base and reg=
_downshift for single register ops)
Merging regulator-fixes/for-linus (ac763232264c Merge remote-tracking branc=
h 'regulator/for-6.2' into regulator-linus)
Merging spi-fixes/for-linus (574fbb95cd9d spi: intel: Check number of chip =
selects after reading the descriptor)
Merging pci-current/for-linus (1b929c02afd3 Linux 6.2-rc1)
Merging driver-core.current/driver-core-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging tty.current/tty-linus (4ec5183ec486 Linux 6.2-rc7)
Merging usb.current/usb-linus (ceaa837f96ad Linux 6.2-rc8)
Merging usb-serial-fixes/usb-linus (4ec5183ec486 Linux 6.2-rc7)
Merging phy/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging staging.current/staging-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging iio-fixes/fixes-togreg (03fada47311a iio: accel: kionix-kx022a: Get=
 the timestamp from the driver's private data in the trigger_handler)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (4ec5183ec486 Linux 6.2-rc7)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging input-current/for-linus (7ae9fb1b7ecb Merge branch 'next' into for-=
linus)
CONFLICT (modify/delete): drivers/input/touchscreen/ucb1400_ts.c deleted in=
 HEAD and modified in input-current/for-linus.  Version input-current/for-l=
inus of drivers/input/touchscreen/ucb1400_ts.c left in tree.
$ git rm -f drivers/input/touchscreen/ucb1400_ts.c
Merging crypto-current/master (8b8447531864 crypto: x86/aria-avx - Do not u=
se avx2 instructions)
Merging vfio-fixes/for-linus (51cdc8bc120e kvm/vfio: Fix potential deadlock=
 on vfio group_lock)
Merging kselftest-fixes/fixes (a49fb7218ed8 selftests: amd-pstate: Don't de=
lete source files via Makefile)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c0f7ae27539f MAINTAINERS: Update email of Tudo=
r Ambarus)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (89c08aef8f8d media: videobuf2: set q->streamin=
g later)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (88603b6dc419 Linux 6.2-rc2)
Merging at91-fixes/at91-fixes (9bfa2544dbd1 ARM: dts: at91: sam9x60: fix th=
e ddr clock for sam9x60)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (2c10b61421a2 kvm: initialize all of the kvm_debug=
regs structure before sending it to userspace)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (e2de0e6abd91 hwmon: (asus-ec-sensors) add missin=
g mutex path)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (000f66519f1a Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (9c7417b5ec44 coredump: Move dump_emit_page() to ki=
ll unused warning)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (eb4b55f2f26f platform/x86/intel/vsec: Add =
support for Meteor Lake)
Merging samsung-krzk-fixes/fixes (a3583e92d188 ARM: dts: exynos: correct TM=
U phandle in Odroid XU3 family)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (707344c8a188 dt-bindings: interrupt-cont=
roller: arm,gic-v3: Fix typo in description of msi-controller property)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (15600159bcc6 scsi: Revert "scsi: core: map PQ=3D1=
, PDT=3Dother values to SCSI_SCAN_TARGET_PRESENT")
Merging drm-fixes/drm-fixes (c9c3395d5e3d Linux 6.2)
Merging drm-intel-fixes/for-linux-next-fixes (c9c3395d5e3d Linux 6.2)
Merging mmc-fixes/fixes (3f18c5046e63 mmc: jz4740: Work around bug on JZ476=
0(B))
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (25c94b051592 Drivers: hv: vmbus: fix pos=
sible memory leak in vmbus_device_register())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (950b879b7f02 riscv: Fixup race condition on PG_=
dcache_clean in flush_icache_pte)
Merging riscv-dt-fixes/riscv-dt-fixes (43d5f5d63699 riscv: dts: sifive: fu7=
40: fix size of pcie 32bit memory)
Merging riscv-soc-fixes/riscv-soc-fixes (730892135b7d soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging spdx/spdx-linus (5dc4c995db9e Linux 6.2-rc4)
Merging gpio-brgl-fixes/gpio/for-current (c9c3395d5e3d Linux 6.2)
Merging gpio-intel-fixes/fixes (a69982c37cd0 gpiolib: acpi: Add a ignore wa=
keup quirk for Clevo NH5xAx)
Merging pinctrl-intel-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging erofs-fixes/fixes (e02ac3e7329f erofs: clean up parsing of fscache =
related options)
Merging kunit-fixes/kunit-fixes (254c71374a70 kunit: fix kunit_test_init_se=
ction_suites(...))
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (4102db175b5d nfsd: don't destroy global nfs4=
_file table in per-net shutdown)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (3ef9fec011d4 tools arch x86: Sync the msr=
-index.h copy with the kernel sources)
Merging efi-fixes/urgent (190233164cd7 arm64: efi: Force the use of SetVirt=
ualAddressMap() on eMAG and Altra Max machines)
Merging zstd-fixes/zstd-linus (7f18d6eececb lib: zstd: Backport fix for in-=
place decompression)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging rust-fixes/rust-fixes (2a02b7a19794 rust: kernel: Mark rust_fmt_arg=
ument as extern "C")
Merging drm-misc-fixes/for-linux-next-fixes (1b9b4f922f96 drm/nouveau/fb/gp=
102-: cache scrubber binary on first load)
Merging kbuild/for-next (bf3a52637d30 kbuild: deb-pkg: improve the usabilit=
y of source package)
CONFLICT (content): Merge conflict in arch/arm/mach-s3c/Makefile
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
Merging arm64/for-next/core (b61b82f81e09 arm64: pass ESR_ELx to die() of c=
fi_handler)
Merging arm-perf/for-next/perf (e8a709dc2a91 perf: arm_spe: Print the versi=
on of SPE detected)
Merging arm-soc/for-next (1eebd1aaa62b soc: document merges)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging amlogic/for-next (b6520fc7ee57 Merge branch 'v6.2/fixes' into for-n=
ext)
Merging asahi-soc/asahi-soc/for-next (22991d8d5725 soc: apple: rtkit: Add r=
egister dump decoding to crashlog)
Merging aspeed/for-next (52dfcf784bbf soc: nuvoton: Add SoC info driver for=
 WPCM450)
Merging at91/at91-next (05ccf9c9c2fc Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (b691373a1bec Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (c9c3395d5e3d Linux 6.2)
Merging drivers-memory/for-next (957b573ea840 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (fd5368f6f08b Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (74ba8bb2bfb2 Merge branch 'v6.2-next/soc' into f=
or-next)
Merging mvebu/for-next (b80b042da860 Merge branch 'mvebu/fixes' into mvebu/=
for-next)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (e34ca36eb310 Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-for-6.3' and 'dts-for-6.3' into=
 for-next)
Merging renesas/next (8dd3dae1705b Merge branches 'renesas-arm-defconfig-fo=
r-v6.3', 'renesas-drivers-for-v6.3', 'renesas-dt-bindings-for-v6.3' and 're=
nesas-dts-for-v6.3' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (cc2b5be472c0 Merge branch 'v6.3-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (dd3d835d31ed Merge branch 'fixes' into for-n=
ext)
Merging scmi/for-linux-next (6d796c50f84c Linux 6.2-rc6)
Merging stm32/stm32-next (4e74ad9f3af6 ARM: configs: multi_v7: enable NVMEM=
 driver for STM32)
Merging sunxi/sunxi/for-next (caea0128c038 Merge branch 'sunxi/dt-for-6.3' =
into sunxi/for-next)
Merging tee/next (816477edfba6 mm: Remove get_kernel_pages())
Merging tegra/for-next (de98d45290c7 Merge branch for-6.3/arm64/dt into for=
-next)
Merging ti/ti-next (47d72bbb6c0f arm64: dts: ti: Makefile: Rearrange entrie=
s alphabetically)
Merging xilinx/for-next (a18426505c2b Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (8a9fbf00acfe Merge branch 'clk-cleanup' into clk-next)
Merging clk-imx/for-next (4e197ee880c2 clk: imx6ul: add ethernet refclock m=
ux support)
Merging clk-renesas/renesas-clk (b1dec4e78599 clk: renesas: rcar-gen3: Disa=
ble R-Car H3 ES1.*)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (0634f7d9177a selftests/ftrace: Add LoongA=
rch kprobe args string tests support)
Merging m68k/for-next (1e5b5df65af9 m68k: /proc/hardware should depend on P=
ROC_FS)
Merging m68knommu/for-next (5aa52ccf692b m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (1b929c02afd3 Linux 6.2-rc1)
Merging mips/mips-next (91dc288f4edf MIPS: vpe-mt: drop physical_memsize)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (3125e3b8f24c parisc: update kbuild doc. aliases=
 for parisc64)
Merging powerpc/next (f82cdc37c4bd powerpc/pseries: Avoid hcall in plpks_is=
_available() on non-pseries)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (eb9be8310c58 RISC-V: add a spin_shadow_stack decla=
ration)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/hwcap.h
CONFLICT (content): Merge conflict in arch/riscv/include/asm/vdso/processor=
.h
Merging riscv-dt/riscv-dt-for-next (d9c36d016f61 Merge patch series "Add a =
devicetree for the Aldec PolarFire SoC TySoM")
Merging riscv-soc/riscv-soc-for-next (f3460326e38d Merge patch series "JH71=
10 PMU Support")
Merging s390/for-next (1a41151889b5 Merge branch 'features' into for-next)
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (2372745ea25a selftests: add tests for prctl(SET_HID=
E_SELF_EXE))
Merging vfs-idmapping/for-next (9db35c4c2bc4 Merge branch 'fs.misc' into fo=
r-next)
Merging fscrypt/for-next (097d7c1fcb8d fscrypt: clean up fscrypt_add_test_d=
ummy_key())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (80d1eec6927a Merge branch 'for-next-current-v6.2-20=
230221' into for-next-20230221)
Merging ceph/master (e7d84c6a1296 ceph: flush cap releases when the session=
 is flushed)
Merging cifs/for-next (fdbf80721525 update internal module version number f=
or cifs.ko)
CONFLICT (content): Merge conflict in fs/cifs/fscache.c
CONFLICT (content): Merge conflict in fs/cifs/misc.c
CONFLICT (content): Merge conflict in fs/cifs/smb2ops.c
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (8d1b80a79452 erofs: fix an error code in z_erofs_init_zi=
p_subsystem())
Merging exfat/dev (5742d6a467d1 exfat: handle unreconized benign secondary =
entries)
Merging ext3/for_next (90e4f9e49826 Pull udf fixup for syzbot allocation fa=
ilure handling bug.)
Merging ext4/dev (2c2dec1e86cc ext4: fix incorrect options show of original=
 mount_opt and extend mount_opt2)
$ git reset --hard HEAD^
Merging next-20230217 version of ext4
Merging f2fs/dev (ddf1eca4fc5a f2fs: drop unnecessary arg for f2fs_ioc_*())
CONFLICT (content): Merge conflict in fs/f2fs/file.c
CONFLICT (content): Merge conflict in fs/f2fs/namei.c
Merging fsverity/for-next (51e4e3153ebc fscrypt: support decrypting data fr=
om large folios)
Merging fuse/for-next (1cc4606d19e3 fuse: add inode/permission checks to fi=
leattr_get/fileattr_set)
CONFLICT (content): Merge conflict in fs/fuse/file.c
Merging gfs2/for-next (c1b0c3cfcbad gfs2: Convert gfs2_page_add_databufs to=
 folios)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (d3ca9f7aeba7 ksmbd: fix possible memory leak =
in smb2_lock())
Merging nfs/linux-next (c9c3395d5e3d Linux 6.2)
Merging nfs-anna/linux-next (1683ed16ff1a fs/nfs: Replace kmap_atomic() wit=
h kmap_local_page() in dir.c)
Merging nfsd/nfsd-next (4b471a8b847b NFSD: Clean up nfsd_symlink())
Merging ntfs3/master (2024476646ed fs/ntfs3: Fix root inode checking)
CONFLICT (content): Merge conflict in fs/ntfs3/file.c
CONFLICT (content): Merge conflict in fs/ntfs3/ntfs_fs.h
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (8fcf2d012c86 ubi: block: Fix a possible use-after-free =
bug in ubiblock_create())
Merging v9fs/9p-next (2ce10bad1e96 9p/rdma: unmap receive dma buffer in rdm=
a_request()/post_recv())
Merging v9fs-ericvh/ericvh/for-next (291ca06aad93 fs/9p: Fix revalidate)
CONFLICT (content): Merge conflict in fs/9p/vfs_inode.c
CONFLICT (content): Merge conflict in fs/9p/vfs_inode_dotl.c
Merging xfs/for-next (60b730a40c43 xfs: fix uninitialized variable access)
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
Merging iomap/iomap-for-next (471859f57d42 iomap: Rename page_ops to folio_=
ops)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (eca3a04f140a Merge tag 'dlm-6.3' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm)
Merging iversion/iversion-next (eca3a04f140a Merge tag 'dlm-6.3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm)
Merging vfs/for-next (e9f33f8668ab Merge branches 'work.misc', 'work.namesp=
ace', 'work.alpha', 'work.minix' and 'work.sysv' into for-next)
Merging printk/for-next (10d639febe56 Merge branch 'for-6.3' into for-next)
Merging pci/next (3eb5d0f26f4e Merge branch 'pci/misc')
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (fd467c123ef6 Merge branch 'for-6.3/mcp2221' into for-=
next)
Merging i2c/i2c/for-next (dc67b2d90438 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging i3c/i3c/next (e826acc18bc7 i3c: transfer pid from boardinfo to devi=
ce info)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (5720a18baa46 hwmon: Deprecate [devm_]hwmo=
n_device_register_with_groups)
Merging jc_docs/docs-next (e076f253283c Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (83e0f265aa8d Merge git://git.linuxtv.org/media_stag=
e into media_tree)
CONFLICT (modify/delete): drivers/media/platform/ti/davinci/vpbe_display.c =
deleted in HEAD and modified in v4l-dvb/master.  Version v4l-dvb/master of =
drivers/media/platform/ti/davinci/vpbe_display.c left in tree.
CONFLICT (modify/delete): drivers/media/platform/ti/davinci/vpbe_osd.c dele=
ted in HEAD and modified in v4l-dvb/master.  Version v4l-dvb/master of driv=
ers/media/platform/ti/davinci/vpbe_osd.c left in tree.
CONFLICT (modify/delete): drivers/media/platform/ti/davinci/vpbe_venc.c del=
eted in HEAD and modified in v4l-dvb/master.  Version v4l-dvb/master of dri=
vers/media/platform/ti/davinci/vpbe_venc.c left in tree.
CONFLICT (content): Merge conflict in drivers/staging/media/Kconfig
CONFLICT (content): Merge conflict in drivers/staging/media/Makefile
$ git rm -f drivers/media/platform/ti/davinci/vpbe_display.c drivers/media/=
platform/ti/davinci/vpbe_osd.c drivers/media/platform/ti/davinci/vpbe_venc.c
Merging v4l-dvb-next/master (5dd1c455130d media: imx-mipi-csis: Check csis_=
fmt validity before use)
Merging pm/linux-next (ea150b53b1fd Merge branch 'thermal' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (ba38f3cbe7db dt-bindings: opp: =
opp-v2-kryo-cpu: enlarge opp-supported-hw maximum)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (eca4c0eea534 OPP: fix error checking in opp_mig=
rate_dentry())
Merging thermal/thermal/linux-next (6828e402d06f thermal/drivers/st: Remove=
 syscfg based driver)
Merging dlm/next (723b197bbdf1 fs: dlm: remove unnecessary waker_up() calls)
Merging rdma/for-next (66fb1d5df6ac IB/mlx5: Extend debug control for CC pa=
rameters)
Merging net-next/master (5b7c4cabbb65 Merge tag 'net-next-6.3' of git://git=
.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging bpf-next/for-next (5b7c4cabbb65 Merge tag 'net-next-6.3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (75da437a2f17 Merge branch '40GbE' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging mlx5-next/mlx5-next (22551e77e550 net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (3fcdf2dfefb6 net: bcmgenet: Support wake-up from =
s2idle)
Merging bluetooth/master (58c6156a4d4b Bluetooth: hci_mrvl: Add serdev supp=
ort for 88W8997)
Merging wireless-next/for-next (38ae31922969 wifi: rtl8xxxu: add LEDS_CLASS=
 dependency)
Merging mtd/mtd/next (84549c816dc3 mtd: parsers: ofpart: add workaround for=
 #size-cells 0)
Merging nand/nand/next (ef3e6327ff04 mtd: rawnand: sunxi: Precompute the EC=
C_CTL register value)
Merging spi-nor/spi-nor/next (f047382519ca Merge tag 'mtd/fixes-for-6.2-rc4=
' into spi-nor/next)
Merging crypto/master (8b8447531864 crypto: x86/aria-avx - Do not use avx2 =
instructions)
Merging drm/drm-next (a48bba98380c msm/fbdev: fix unused variable warning w=
ith clang.)
CONFLICT (content): Merge conflict in Documentation/accel/introduction.rst
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gpu_error.c
Merging drm-misc/for-linux-next (e034b8a18d4b drm/msm: Fix possible uniniti=
alized access in fbdev)
Merging amdgpu/drm-next (80c6d6804f31 drm/amd/display: disable SubVP + DRR =
to prevent underflow)
Merging drm-intel/for-linux-next (8038510b1fe4 drm/i915: Fix system suspend=
 without fbdev being initialized)
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
Merging fbdev/for-next (4ec5183ec486 Linux 6.2-rc7)
Merging regmap/for-next (40f4b0586810 Merge remote-tracking branch 'regmap/=
for-6.3' into regmap-next)
Merging sound/for-next (7933b90b4289 Merge branch 'for-linus' into for-next)
Merging sound-asoc/for-next (6699c94a3e3e Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-linus)
Merging modules/modules-next (d6f55bb48579 module: make module_ktype struct=
ure constant)
Merging input/next (586dc36226dd Input: hp_sdc_rtc - mark an unused functio=
n as __maybe_unused)
Merging block/for-next (35e06dd0c2d3 Merge branch 'io_uring-6.3' into for-n=
ext)
Merging device-mapper/for-next (d695e44157c8 dm: remove unnecessary (void*)=
 conversion in event_callback())
Merging libata/for-next (8844f0aa8dc4 ata: pata_parport: Fix ida_alloc retu=
rn value error check)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (571f235163ac mmc: meson-gx: Use devm_platform_get_and_ior=
emap_resource())
CONFLICT (content): Merge conflict in MAINTAINERS
Merging mfd/for-mfd-next (59c54c599746 dt-bindings: mfd: qcom,tcsr: Add com=
patible for IPQ5332)
Merging backlight/for-backlight-next (ad614f81d2e8 backlight: ktz8866: Conv=
ert to i2c's .probe_new())
Merging battery/for-next (c142872ea40a power: reset: odroid-go-ultra: fix I=
2C dependency)
CONFLICT (content): Merge conflict in drivers/power/supply/Makefile
Merging regulator/for-next (ac763232264c Merge remote-tracking branch 'regu=
lator/for-6.2' into regulator-linus)
Merging security/next (88603b6dc419 Linux 6.2-rc2)
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (4958db3245fa ima: Introduce MMAP_CHECK_RE=
QPROT hook)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (88603b6dc419 Linux 6.2-rc2)
Merging smack/next (c0e48d3f7722 smackfs: Added check catlen)
Merging tomoyo/master (5fc44ba8be52 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (5b7c4cabbb65 Merge tag 'net-next-6.3' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging watchdog/master (4443f6ce0d12 watchdog: at91rm9200: Only warn once =
about problems in .remove())
Merging iommu/next (bedd29d793da Merge branches 'apple/dart', 'arm/exynos',=
 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (6c6cd913accd audit: update the mailing list in MAINTAIN=
ERS)
Merging devicetree/for-next (1ba7dfb905b3 dt-bindings: regulator: Add mps,m=
pq7932 power-management IC)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mmc=
/nvidia,tegra20-sdhci.yaml
Merging dt-krzk/for-next (825475539974 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (de82c25dab9a Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
Merging tip/master (c5a864380fe8 Merge branch into tip/master: 'objtool/cor=
e')
Merging clockevents/timers/drivers/next (ab407a1919d2 Merge tag 'clocksourc=
e.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/lin=
ux-rcu into timers/core)
Merging edac/edac-for-next (feac08675023 Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (a83bf176fed4 Merge branch irq/bcm-l2-fixe=
s into irq/irqchip-next)
Merging ftrace/for-next (ca6cbe8c481a Merge tools/for-next)
CONFLICT (content): Merge conflict in Documentation/trace/histogram.rst
CONFLICT (content): Merge conflict in Documentation/trace/kprobetrace.rst
Merging rcu/rcu/next (690ae0037d5b Merge branch 'kcsan.2023.02.22a' into HE=
AD)
Merging kvm/next (ddad47bfb955 Merge tag 'kvm-x86-apic-6.3' of https://gith=
ub.com/kvm-x86/linux into HEAD)
CONFLICT (content): Merge conflict in arch/x86/include/asm/cpufeatures.h
CONFLICT (content): Merge conflict in arch/x86/kvm/reverse_cpuid.h
Merging kvm-arm/next (96a4627dbbd4 Merge tag ' https://github.com/oupton/li=
nux tags/kvmarm-6.3' from into kvmarm-master/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (62ef199250cd Merge branches 'apic', 'generic', 'misc'=
, 'mmu', 'pmu', 'selftests', 'svm' and 'vmx' into next)
Merging xen-tip/linux-next (4ecc96cba8d9 xen: sysfs: make kobj_type structu=
re constant)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (0d9bdd8a5501 platform/x86: nvidia-wmi-ec-back=
light: Add force module parameter)
Merging chrome-platform/for-next (b0d8a67715da platform/chrome: cros_ec_typ=
ec: Fix spelling mistake)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (056f65c3938b leds: Remove ide-disk trigger)
Merging ipmi/for-next (befb28f2676a ipmi: ipmb: Fix the MODULE_PARM_DESC as=
sociated to 'retry_time_ms')
Merging driver-core/driver-core-next (88cd618dcc7b debugfs: drop inline con=
stant formatting for ERR_PTR(-ERROR))
CONFLICT (content): Merge conflict in drivers/base/core.c
CONFLICT (content): Merge conflict in include/linux/acpi.h
Merging usb/usb-next (1243741f6b02 Merge tag 'usb-serial-6.3-rc1' of https:=
//git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging thunderbolt/next (06cbcbfaa651 thunderbolt: Add missing kernel-doc =
comment to tb_tunnel_maximum_bandwidth())
Merging usb-serial/usb-next (617c331d9107 USB: serial: option: add support =
for VW/Skoda "Carstick LTE")
Merging tty/tty-next (72206cc730b5 tty: n_gsm: add keep alive support)
Merging char-misc/char-misc-next (6ec363fc6142 scripts/tags.sh: fix incompa=
tibility with PCRE2)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/fpga/dfl.c
CONFLICT (content): Merge conflict in drivers/fpga/dfl.h
Merging accel/habanalabs-next (f96b302a6b46 habanalabs/gaudi2: remove unnee=
ded irq_handler variable)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (ffa562d00072 fpga: bridge: return errors in the show=
() method of the "state" attribute)
CONFLICT (content): Merge conflict in drivers/fpga/dfl.h
Merging icc/icc-next (7bf0008a5293 Merge branch 'icc-dt' into icc-next)
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
Merging staging/staging-next (b5929325f063 staging: r8188eu: Revert "stagin=
g: r8188eu: simplify rtw_get_ff_hwaddr")
CONFLICT (content): Merge conflict in MAINTAINERS
Merging counter-next/counter-next (01f714ee022e counter: fix dependency ref=
erences for config MICROCHIP_TCB_CAPTURE)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (e922bbf37564 dmaengine: idma64: Update bytes_transf=
erred field)
Merging cgroup/for-next (14fffd51f902 Merge branch 'for-6.2-fixes' into for=
-next)
Merging scsi/for-next (1a10df75c93f Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (901b894af5b9 scsi: zfcp: Trace when request remo=
ve fails after qdio send fails)
Merging vhost/linux-next (0d0a7dda9cdf vp_vdpa: fix the crash in hot unplug=
 with vp_vdpa)
Merging rpmsg/for-next (c7d00a6f6e4c Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Applying: remoteproc: fix for "iommu: Add a gfp parameter to iommu_map()"
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (4827aae06133 gpio: sim: Use %pfwP specifie=
r instead of calling fwnode API directly)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (099f37a539e6 pinctrl: qcom: Add support for i2c s=
pecific pull feature)
Merging pinctrl-intel/for-next (88f8ac47bddc pinctrl: Proofreading and upda=
ting the documentation (part 2))
Merging pinctrl-renesas/renesas-pinctrl (698485cd875b pinctrl: renesas: r8a=
77950: Add VIN[45] pins, groups, and functions)
Merging pinctrl-samsung/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pwm/for-next (cf70d01a62c7 pwm: dwc: Use devm_pwmchip_add())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (bbf45b2ab467 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (0eb15a47bf43 selftests/user_events: add a note abou=
t user_events.h dependency)
Merging kunit/test (1b929c02afd3 Linux 6.2-rc1)
Merging kunit-next/kunit (82649c7c0da4 kunit: Add printf attribute to fail_=
current_test_impl)
Merging livepatching/for-next (b2e118419db3 Merge branch 'for-6.3/cleanup-r=
elocations' into for-next)
Merging rtc/rtc-next (38892c48e547 rtc: rx6110: Remove unused of_gpio,h)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ntb/ntb-next (0310a30a9395 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging nvmem/for-next (fa7876365ad2 nvmem: stm32: fix OPTEE dependency)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (b14033a3e6ba x86/hyperv: Fix hv_get/set_registe=
r for nested bringup)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (1b929c02afd3 Linux 6.2-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (3c54a3ff0a2c bus: mhi: ep: Fix off by one in mhi_ep_p=
rocess_cmd_ring())
Merging memblock/for-next (2fe03412e2e1 memblock: Avoid useless checks in m=
emblock_merge_regions().)
Merging cxl/next (e686c32590f4 dax/kmem: Fix leak of memory-hotplug resourc=
es)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (e1d447157f23 firmware/efi sysfb_efi: Add quirk for Lenovo=
 IdeaPad Duet 3)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/efi.h
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
Merging sysctl/sysctl-next (f1aa2eb5ea05 sysctl: fix proc_dobool() usabilit=
y)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (18e93f4dc099 bitmap: switch from inline to =
__always_inline)
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (78f7a3fd6dc6 randstruct: disable Clang 15 suppo=
rt)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (939204e4df96 Merge tag 'v6.2' into iommufd.git fo=
r-next)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/usnic/usnic_uio=
m.c
Merging mm-stable/mm-stable (f7a449f77960 mm: memcontrol: rename memcg_kmem=
_enabled())
CONFLICT (content): Merge conflict in Documentation/admin-guide/cgroup-v1/m=
emory.rst
CONFLICT (content): Merge conflict in Documentation/admin-guide/mm/numaperf=
.rst
CONFLICT (modify/delete): drivers/gpu/drm/i810/i810_dma.c deleted in HEAD a=
nd modified in mm-stable/mm-stable.  Version mm-stable/mm-stable of drivers=
/gpu/drm/i810/i810_dma.c left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/hw/hfi1/file_ops.c
CONFLICT (modify/delete): drivers/staging/media/deprecated/meye/meye.c dele=
ted in HEAD and modified in mm-stable/mm-stable.  Version mm-stable/mm-stab=
le of drivers/staging/media/deprecated/meye/meye.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/deprecated/stkwebcam/stk-we=
bcam.c deleted in HEAD and modified in mm-stable/mm-stable.  Version mm-sta=
ble/mm-stable of drivers/staging/media/deprecated/stkwebcam/stk-webcam.c le=
ft in tree.
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in fs/cifs/file.c
CONFLICT (content): Merge conflict in fs/nfs/write.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in include/linux/memcontrol.h
CONFLICT (content): Merge conflict in mm/memcontrol.c
$ git rm -f drivers/gpu/drm/i810/i810_dma.c drivers/staging/media/deprecate=
d/meye/meye.c drivers/staging/media/deprecated/stkwebcam/stk-webcam.c
Applying: accel/ivpu: fix up for "mm: introduce vma->vm_flags wrapper funct=
ions"
Applying: udf: fix up for "fs: convert writepage_t callback to pass a folio"
Applying: mm: fixup for "mm: implement memory-deny-write-execute as a prctl"
Applying: gfs2: fix up for "fs: convert writepage_t callback to pass a foli=
o"
Merging mm-nonmm-stable/mm-nonmm-stable (817013880a68 Update CREDITS file e=
ntry for Jesper Juhl)
Merging mm/mm-everything (45364ba26b60 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/acco=
unting/delay-accounting.rst

--Sig_/P/Xm8G.9VUvifwrmxs3I=nB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP246cACgkQAVBC80lX
0GxyRwgAklWFaCqdh3/O5FavUywTrM/aWeVidN5QzM0vCXWEg38Cxwts8bIBnSz0
bbdqNv8KWgCnj/ap3DnjVneTxN3ymScZ9rsEsdq0Vjl0SbZdygPdfkzdacb1XFrz
2LxUrcTxtf2Ss2Sn8pOgT4yPAMxp+up6ZHjTbIeuwhQ1bEflnt/a3KYNLOlaY2Ic
5cxKDb5K6ulVL1VvIoBNd2cqaEqiLu0+SomZ6MEWlXwPfgzGjVvcIaaiWcYy8DiI
+LfoQf3sAM2rbVMNeDsSVPjmaApgEJw1hQG0Rex1sD6f93yF0haZK49AHfACTfLK
7f7N1Zzn572b3Tg/1IcjWNzPkxH/1Q==
=iLsg
-----END PGP SIGNATURE-----

--Sig_/P/Xm8G.9VUvifwrmxs3I=nB--
