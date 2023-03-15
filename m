Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9A6BA4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCOB5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOB5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:57:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41F53D9A;
        Tue, 14 Mar 2023 18:57:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pbtmx08RWz4whh;
        Wed, 15 Mar 2023 12:57:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678845425;
        bh=K2LOCPFhcBHTUYEL+TpFILrSREfbeBgi0PeNjlXB6dU=;
        h=Date:From:To:Cc:Subject:From;
        b=gzP6xP9s6kSRwV6vHJdQlo5vpscrepfhoiXzS0UFJIPjywat81wxnb3n3fEAXNGG9
         ilPFEnQdmV/eidc3KIt2vgmm3c/Z2YOl0Nt29GLnYf1xNw+uAQBFQbO1zYR3qFUIXN
         /SXU32MxLXgFJQ6IkpDy/CWn4V86+++4Kh0Rh63P4+HeX6wiGGofkKVgiu+AsVbU+7
         qHLU66/7h6YSdd86EPtS7KisS96d6yo3zGn9m4shEgurslgVfEla2ZwzqFeHQ8W74x
         y5KHTXNR7StFjSUMy9E1ey0cxkxMyfItNTZddQ/saaATlHMPt3esfhv8qIq3uzFe6K
         6fjWmtsH00p6g==
Date:   Wed, 15 Mar 2023 12:57:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 15
Message-ID: <20230315125704.21a96df1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=0C9CU3DbWKMlJ5NCGeqxK9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=0C9CU3DbWKMlJ5NCGeqxK9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230314:

The efi-fixes tree lost its build failure.

The loongarch tree gained a conflict against the efi-fixes tree.

The net-next tree gained a conflict against the net tree.

The rcu tree lost its build failures.

Non-merge commits (relative to Linus' tree): 3240
 3674 files changed, 118968 insertions(+), 71544 deletions(-)

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
Merging origin/master (4979bf866825 Merge tag 'docs-6.3-fixes' of git://git=
.lwn.net/linux)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (5300b22d22d5 mailmap: map Rajendr=
a Nayak's old address to his current one)
Merging kbuild-current/fixes (51ab7ee81f5f Makefile: Make kernelrelease tar=
get work with M=3D)
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
Merging powerpc-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging s390-fixes/fixes (d7a0bdbf1727 s390: update defconfigs)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (536ecc564437 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (ef7592e466ef MAINTAINERS: update fsve=
rity git repo, list, and patchwork)
Merging net/main (28e8cabe80f3 net: hsr: Don't log netdev_err message on un=
known prp dst node)
Merging bpf/master (a33a6eaa19d3 Merge branch 'bpf: Allow reads from uninit=
 stack')
Merging ipsec/master (c276a706ea1f xfrm: Allow transport-mode states with A=
F_UNSPEC selector)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (064d70527aaa Merge git://git.kernel.org/pub/scm/linux/ke=
rnel/git/netfilter/nf)
Merging wireless/for-next (5683e1488aa9 wifi: mt76: connac: do not check WE=
D status for non-mmio devices)
Merging rdma-fixes/for-rc (eeac8ede1755 Linux 6.3-rc2)
Merging sound-current/for-linus (98e5eb110095 ALSA: hda/ca0132: fixup buffe=
r overrun at tuning_ctl_set())
Merging sound-asoc-fixes/for-linus (30549964ce67 ASOC: Intel: add quirk for=
 Intel 'Rooks County' NUC)
Merging regmap-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging regulator-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging spi-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging pci-current/for-linus (fe15c26ee26e Linux 6.3-rc1)
Merging driver-core.current/driver-core-linus (44ac5abac86b Documentation/s=
ecurity-bugs: move from admin-guide/ to process/)
Merging tty.current/tty-linus (18365ebf23f3 tty: vt: protect KD_FONT_OP_GET=
_TALL from unbound access)
Merging usb.current/usb-linus (82f5332d3b98 usb: dwc2: drd: fix inconsisten=
t mode if role-switch-default-mode=3D"host")
Merging usb-serial-fixes/usb-linus (773e8e7d07b7 USB: serial: option: add T=
elit FE990 compositions)
Merging phy/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging staging.current/staging-linus (eeac8ede1755 Linux 6.3-rc2)
Merging iio-fixes/fixes-togreg (7b3825e9487d iio: adc: max11410: fix read_p=
oll_timeout() usage)
Merging counter-current/counter-current (fe15c26ee26e Linux 6.3-rc1)
Merging char-misc.current/char-misc-linus (06be62083c53 nvmem: core: return=
 -ENOENT if nvmem cell is not found)
Merging soundwire-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging thunderbolt-fixes/fixes (005c26aa436a thunderbolt: Disable interrup=
t auto clear for rings)
Merging input-current/for-linus (7ae9fb1b7ecb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (660ca9470f9c crypto: caam - Fix edesc/iv ord=
ering mixup)
Merging vfio-fixes/for-linus (51cdc8bc120e kvm/vfio: Fix potential deadlock=
 on vfio group_lock)
Merging kselftest-fixes/fixes (624c60f326c6 selftests: fix LLVM build for i=
386 and x86_64)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (75dce6a941e3 mtd: nand: mxic-ecc: Fix mxic_ecc=
_data_xfer_wait_for_completion() when irq is used)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (eeac8ede1755 Linux 6.3-rc2)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (eeac8ede1755 Linux 6.3-rc2)
Merging at91-fixes/at91-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (f3e707413dbe KVM: selftests: Sync KVM exit reason=
s in selftests)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (00d85e81796b hwmon: tmp512: drop of_match_ptr fo=
r ID table)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (01666867abd4 Merge branch 'misc-6.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (1a0009abfa78 platform: mellanox: mlx-platf=
orm: Initialize shift variable to 0)
Merging samsung-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-samsung-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree-fixes/dt/linus (707344c8a188 dt-bindings: interrupt-cont=
roller: arm,gic-v3: Fix typo in description of msi-controller property)
Merging dt-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging scsi-fixes/fixes (c6001025d53a scsi: ufs: mcq: Use active_reqs to c=
heck busy in clock scaling)
Merging drm-fixes/drm-fixes (eeac8ede1755 Linux 6.3-rc2)
Merging drm-intel-fixes/for-linux-next-fixes (e0e6b416b25e drm/i915/active:=
 Fix misuse of non-idle barriers as fence trackers)
Merging mmc-fixes/fixes (92771cdd90de mmc: dw_mmc-starfive: Fix initializat=
ion of prev_err)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (1eb65c868731 Drivers: vmbus: Check for c=
hannel allocation before looking up relids)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (9b7fef255c80 Merge patch series "riscv: asid: s=
witch to alternative way to fix stale TLB entries")
Merging riscv-dt-fixes/riscv-dt-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging fpga-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging spdx/spdx-linus (fe15c26ee26e Linux 6.3-rc1)
Merging gpio-brgl-fixes/gpio/for-current (d49765b5f432 gpio: GPIO_REGMAP: s=
elect REGMAP instead of depending on it)
Merging gpio-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging erofs-fixes/fixes (3993f4f45630 erofs: use wrapper i_blocksize() in=
 erofs_file_read_iter())
Merging kunit-fixes/kunit-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (9ca6705d9d60 SUNRPC: Fix a server shutdown l=
eak)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (5b201a82cd9d perf tools: Add Adrian Hunte=
r to MAINTAINERS as a reviewer)
Merging efi-fixes/urgent (ef3efc2af044 efi: libstub: Use relocated version =
of kernel's struct screen_info)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (06615d11cc78 power: supply: da9150: Fix use af=
ter free bug in da9150_charger_remove due to race condition)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (fe15c26ee26e Linux 6.3-rc1)
Merging rust-fixes/rust-fixes (3098cb655e7c rust: bindgen: Add `alt_instr` =
as opaque type)
Merging drm-misc-fixes/for-linux-next-fixes (2cde14b187b4 accel: Build sub-=
directories based on config options)
Merging mm-stable/mm-stable (819c2608ce2c Sync mm-stable with 6.3-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (fe15c26ee26e Linux 6.3-rc1)
Merging mm/mm-everything (795b47533475 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (5d49fb846d7f kallsyms: expand symbol name into com=
ment for debugging)
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
Merging aspeed/for-next (bb13bd587d53 ARM: dts: aspeed: bonnell: Update eep=
rom size)
Merging at91/at91-next (f5200f71d927 clk: microchip: Use of_property_read_b=
ool() for boolean properties)
Merging broadcom/next (a2264238029f Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory/for-next (538c7b5b5d8b memory: atmel-ebi: Use of_pro=
perty_present() for testing DT property presence)
Merging imx-mxs/for-next (a7a9bae8c567 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (9b2797522f32 Merge branch 'v6.3-next/soc' into f=
or-next)
Merging mvebu/for-next (b80b042da860 Merge branch 'mvebu/fixes' into mvebu/=
for-next)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (381ac26819c9 Merge branches 'arm64-fixes-for-6.3', '=
arm64-for-6.4', 'clk-for-6.4', 'drivers-fixes-for-6.3', 'drivers-for-6.4', =
'dts-fixes-for-6.3' and 'dts-for-6.4' into for-next)
Merging renesas/next (cc8231630ee4 Merge branches 'renesas-arm-defconfig-fo=
r-v6.4', 'renesas-drivers-for-v6.4', 'renesas-dt-bindings-for-v6.4' and 're=
nesas-dts-for-v6.4' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (2500bdb1b0b4 Merge branch 'v6.4-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (bf460f1d8484 Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (9848e199b090 Merge branch 'for-next/scmi/fixes=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into =
for-linux-next)
Merging stm32/stm32-next (4e74ad9f3af6 ARM: configs: multi_v7: enable NVMEM=
 driver for STM32)
Merging sunxi/sunxi/for-next (6aeca5d73805 Merge branch 'sunxi/dt-for-6.4' =
into sunxi/for-next)
Merging tee/next (f8502fba45bd tee: amdtee: fix race condition in amdtee_op=
en_session)
Merging tegra/for-next (9b0d904e7e49 Merge branch for-6.3/arm64/dt into for=
-next)
Merging ti/ti-next (d0abd3ea07ab Merge branch 'ti-drivers-soc-next' into ti=
-next)
Merging xilinx/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging clk/clk-next (6f173737e1b5 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging clk-renesas/renesas-clk (1ef48138f907 clk: renesas: r9a06g032: Impr=
ove clock tables)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (3d5fd1846516 tools/perf: Add basic suppor=
t for LoongArch)
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/efi-stub=
-entry.c
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/efi-stub=
.c
Merging m68k/for-next (e36a82bebbf7 m68k: Only force 030 bus error if PC no=
t in exception table)
Merging m68knommu/for-next (eeac8ede1755 Linux 6.3-rc2)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (9c99b4880d17 mips: Use of_property_read_bool() for =
boolean properties)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (cf559f6a9e3a parisc: Replace regular spinlock w=
ith spin_trylock on panic path)
Merging powerpc/next (fe15c26ee26e Linux 6.3-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging riscv-dt/riscv-dt-for-next (0e9b70c1e362 riscv: dts: microchip: add=
 mpfs specific macb reset support)
Merging riscv-soc/riscv-soc-for-next (fe15c26ee26e Linux 6.3-rc1)
Merging s390/for-next (70cc5f4c53d5 Merge branch 'features' into for-next)
Merging sh/for-next (ff30bd6a6618 sh: clk: Fix clk_enable() to return 0 on =
NULL clk)
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (5ab18f4b061e vhost: use vhost_tasks for worker thre=
ads)
Merging vfs-idmapping/for-next (c89eb19ba772 Merge branch 'fs.misc' into fo=
r-next)
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
Merging cifs/for-next (7845e695dd80 cifs: Fix smb2_set_path_size())
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (4f24ebae35ff erofs: support flattened block device for m=
ulti-blob images)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (dced733d7fa9 quota: simplify two-level sysctl regist=
ration for fs_dqstats_table)
Merging ext4/dev (f5361da1e60d ext4: zero i_disksize when initializing the =
bootloader inode)
Merging f2fs/dev (196036c45f8c f2fs: fix uninitialized skipped_gc_rwsem)
Merging fsverity/for-next (b94b4bd7ca07 fsverity: Remove WQ_UNBOUND from fs=
verity read workqueue)
Merging fuse/for-next (1cc4606d19e3 fuse: add inode/permission checks to fi=
leattr_get/fileattr_set)
Merging gfs2/for-next (c1b0c3cfcbad gfs2: Convert gfs2_page_add_databufs to=
 folios)
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (6686991cea8e ksmbd: set FILE_NAMED_STREAMS at=
tribute in FS_ATTRIBUTE_INFORMATION)
Merging nfs/linux-next (eeac8ede1755 Linux 6.3-rc2)
Merging nfs-anna/linux-next (21fd9e8700de NFS: Correct timing for assigning=
 access cache timestamp)
Merging nfsd/nfsd-next (a5ed9be147be sunrpc: simplify two-level sysctl regi=
stration for svcrdma_parm_table)
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
Merging file-locks/locks-next (63355b9884b3 cpumask: be more careful with '=
cpumask_setall()')
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs/for-next (d291d1858419 Merge branch 'work.fd' into for-next)
Merging printk/for-next (10d639febe56 Merge branch 'for-6.3' into for-next)
Merging pci/next (b0d4fc005ef2 Merge branch 'pci/controller/rcar')
Merging pstore/for-next/pstore (5239a89b06d6 pstore: Revert pmsg_lock back =
to a normal mutex)
Merging hid/for-next (1b9a2a53046a Merge branch 'for-6.3/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (9e5f81f9a6e7 i2c: dev: Fix bus callback return va=
lues)
Merging i3c/i3c/next (1dae3f1df700 i3c: dw: drop of_match_ptr for ID table)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (5c88c4452bfe docs: hwmon: sysfs-interface=
: Fix stray colon)
Merging jc_docs/docs-next (10d18135135c docs/mm: Physical Memory: add examp=
le of interleaving nodes)
Merging v4l-dvb/master (eeac8ede1755 Linux 6.3-rc2)
Merging v4l-dvb-next/master (eeac8ede1755 Linux 6.3-rc2)
Merging pm/linux-next (d64b2bdbf627 Merge branches 'acpi-docs', 'acpi-video=
' and 'acpi-x86' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (b8f3a396a7ee cpufreq: Use of_pr=
operty_present() for testing DT property presence)
Merging cpupower/cpupower (fe15c26ee26e Linux 6.3-rc1)
Merging devfreq/devfreq-next (b7405e3f62d6 PM / devfreq: exynos: Use of_pro=
perty_present() for testing DT property presence)
Merging opp/opp/linux-next (e9eadc282719 opp: Use of_property_present() for=
 testing DT property presence)
Merging thermal/thermal/linux-next (6828e402d06f thermal/drivers/st: Remove=
 syscfg based driver)
Merging dlm/next (1361737f102d fs: dlm: switch lkb_sbflags to atomic ops)
Merging rdma/for-next (f2f6e1661d38 IB/rdmavt: Fix target union member for =
rvt_post_one_wr())
Merging net-next/main (bcc858689db5 net: Use of_property_present() for test=
ing DT property presence)
CONFLICT (content): Merge conflict in net/hsr/hsr_framereg.c
CONFLICT (content): Merge conflict in net/wireless/nl80211.c
Merging bpf-next/for-next (3c2611bac08a selftests/bpf: Fix trace_virtqueue_=
add_sgs test issue with LLVM 17.)
Merging ipsec-next/master (95b744508d4d qede: remove linux/version.h and li=
nux/compiler.h)
Merging mlx5-next/mlx5-next (22551e77e550 net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (95b744508d4d qede: remove linux/version.h and linux=
/compiler.h)
Merging bluetooth/master (1c991f006035 Bluetooth: L2CAP: Delay identity add=
ress updates)
Merging wireless-next/for-next (4c4ca9f7c4ca Merge ath-next from git://git.=
kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mtd/mtd/next (1a7537a39b06 Merge tag 'mtd/core-fixes-before-nvmem-l=
ayouts-for-6.4' into mtd/next)
Merging nand/nand/next (4080d5362416 mtd: parsers: remove reference to conf=
ig MTD_NAND_TMIO)
Merging spi-nor/spi-nor/next (f047382519ca Merge tag 'mtd/fixes-for-6.2-rc4=
' into spi-nor/next)
Merging crypto/master (a3e8c919b993 crypto: qat - add support for 402xx dev=
ices)
Merging drm/drm-next (eeac8ede1755 Linux 6.3-rc2)
Merging drm-misc/for-linux-next (a66172fa7859 drm/pl111: Use GEM DMA fbdev =
emulation)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tiny/cirrus.c
Merging amdgpu/drm-next (136a1f7e9240 drm/amdkfd: Fixed kfd_process cleanup=
 on module exit.)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/soc21.c
Merging drm-intel/for-linux-next (68070b76c4aa drm/i915/dp: Don't roundup m=
ax bpp, while computing compressed bpp)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ba=
cklight.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_bi=
os.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/skl_wate=
rmark.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_driver.c
Merging drm-tegra/for-next (b9930311641c gpu: host1x: Fix uninitialized var=
iable use)
Merging drm-msm/msm-next (1844e680d56b drm/msm/dp: set self refresh aware b=
ased on PSR support)
Merging drm-msm-lumag/msm-next-lumag (0c3f3cfd8ef2 drm/msm/dp: set self ref=
resh aware based on PSR support)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (e140980ef211 fbdev: omapfb: remove omap1 osk driver)
Merging regmap/for-next (24d80fde40c9 regmap: cache: Silence checkpatch war=
ning)
Merging sound/for-next (ce8e5f202f3e ALSA: usb-audio: remove Wireless USB d=
ead code)
Merging sound-asoc/for-next (48be72b5ab35 Merge remote-tracking branch 'aso=
c/for-6.4' into asoc-next)
Merging modules/modules-next (40cf65c2c7df dyndbg: cleanup dynamic usage in=
 ib_srp.c)
Merging input/next (d5f7638eb5fe Input: matrix_keypad - replace header incl=
usions by forward declarations)
Merging block/for-next (b933f225b80f Merge branch 'pipe-nonblock' into for-=
next)
Merging device-mapper/for-next (d9a02e016aaf dm crypt: avoid accessing unin=
itialized tasklet)
Merging libata/for-next (2436b758ac25 dt-bindings: ata: Add UniPhier contro=
ller binding)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (46d19dc62b45 mmc: sdhci-pci-o2micro: Fix SDR50 mode timin=
g issue)
Merging mfd/for-mfd-next (e3ba37699d8f gpio: Add support for Intel LJCA USB=
 GPIO driver)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mfd=
/syscon.yaml
Merging backlight/for-backlight-next (b819828b33ef backlight: qcom-wled: Ad=
d PMI8950 compatible)
Merging battery/for-next (5161ec200f5a power: supply: bq256xx: Support to d=
isable charger)
Merging regulator/for-next (691c1fcda535 regulator: core: Shorten off-on-de=
lay-us for always-on/boot-on by time since booted)
Merging security/next (b9b8701b4314 security: Remove integrity from the LSM=
 list in Kconfig)
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (4958db3245fa ima: Introduce MMAP_CHECK_RE=
QPROT hook)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (e67b79850fcc selinux: stop passing selinux_state poin=
ters and their offspring)
Merging smack/next (502a29b04d85 smack_lsm: remove unnecessary type casting)
Merging tomoyo/master (ab8527429de6 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (f1324bbc4011 tpm: disable hwrng for fTPM on some AMD de=
signs)
Merging watchdog/master (cf3be7e82b12 watchdog: at91rm9200: Only warn once =
about problems in .remove())
Merging iommu/next (bedd29d793da Merge branches 'apple/dart', 'arm/exynos',=
 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree/for-next (41be03c8a9d2 dt-bindings: serial: mediatek,uar=
t: add MT8365)
Merging dt-krzk/for-next (a3e54f180247 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (6ccbe33a3952 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for QDU1000/QRU1000)
Merging spi/for-next (93d205457dcd spi: docs: adjust summary to CONFIG_SYSF=
S_DEPRECATED removal)
Merging tip/master (15dcf830b76a Merge branch into tip/master: 'x86/paravir=
t')
Merging clockevents/timers/drivers/next (ab407a1919d2 Merge tag 'clocksourc=
e.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/lin=
ux-rcu into timers/core)
Merging edac/edac-for-next (71b1e3ba3fed EDAC/skx: Fix overflows on the DRA=
M row address mapping arrays)
Merging irqchip/irq/irqchip-next (a83bf176fed4 Merge branch irq/bcm-l2-fixe=
s into irq/irqchip-next)
Merging ftrace/for-next (ca6cbe8c481a Merge tools/for-next)
CONFLICT (content): Merge conflict in Documentation/trace/kprobetrace.rst
Merging rcu/rcu/next (6b1dda8e725c Revert "rcu/kvfree: Eliminate k[v]free_r=
cu() single argument macro")
Merging kvm/next (45dd9bc75d9a KVM: SVM: hyper-v: placate modpost section m=
ismatch error)
Merging kvm-arm/next (96a4627dbbd4 Merge tag ' https://github.com/oupton/li=
nux tags/kvmarm-6.3' from into kvmarm-master/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (eeac8ede1755 Linux 6.3-rc2)
Merging xen-tip/linux-next (934ef33ee75c x86/PVH: obtain VGA console info i=
n Dom0)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (02c464b73645 platform/x86: x86-android-tablet=
s: Add depends on PMIC_OPREGION)
Merging chrome-platform/for-next (db7df0cfaff3 platform/chrome: cros_ec: re=
move unneeded label and if-condition)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (faa7f34a47f0 leds: tlc591xx: Mark OF related=
 data as maybe unused)
Merging ipmi/for-next (d352cb47df75 ipmi: simplify sysctl registration)
Merging driver-core/driver-core-next (0433686c6092 devres: Pass unique name=
 of the resource to devm_add_action())
Merging usb/usb-next (3754c41c7686 dt-bindings: usb: snps,dwc3: support i.M=
X8MQ)
Merging thunderbolt/next (ebde5ba27c64 thunderbolt: Refactor DROM reading)
Merging usb-serial/usb-next (eeac8ede1755 Linux 6.3-rc2)
Merging tty/tty-next (571079f5ba93 Documentation/serial-console: Document t=
he behavior when the last console=3D parameter is not used)
CONFLICT (content): Merge conflict in drivers/tty/serial/8250/8250_em.c
Merging char-misc/char-misc-next (c2c99326cc01 misc: smpro-errmon: Add dimm=
 training failure syndrome)
Merging accel/habanalabs-next (988bd6d32192 habanalabs: make gaudi2_is_devi=
ce_idle() static)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging icc/icc-next (93ce96a83f93 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (91ba2700aa75 staging: iio: meter: Drop ade7854 driver)
Merging phy-next/next (fe15c26ee26e Linux 6.3-rc1)
Merging soundwire/next (fe15c26ee26e Linux 6.3-rc1)
Merging extcon/extcon-next (3918953f0a49 extcon: Remove redundant null chec=
king for class)
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (d649c34cb916 vfio: Fix NULL pointer dereference caused b=
y uninitialized group->iommufd)
Merging staging/staging-next (458219ca9246 Merge 6.3-rc2 into staging-next)
Merging counter-next/counter-next (fe15c26ee26e Linux 6.3-rc1)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (fe15c26ee26e Linux 6.3-rc1)
Merging cgroup/for-next (14fffd51f902 Merge branch 'for-6.2-fixes' into for=
-next)
Merging scsi/for-next (5e5d9dce9be2 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (0b31b77f281a Merge patch series "PCI/AER: Remove=
 redundant Device Control Error Reporting Enable")
Merging vhost/linux-next (a8fd36ae67da virtio_ring: Use const to annotate r=
ead-only pointer params)
Merging rpmsg/for-next (5dfb28c257b7 remoteproc: xilinx: Add mailbox channe=
ls for rpmsg)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (0c14f3aa388d gpio: sim: Deactivate device =
in reversed order)
Merging gpio-intel/for-next (0928069402ec gpio: mm-lantiq: Fix typo in the =
newly added header filename)
Merging pinctrl/for-next (5c6073d29c45 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-renesas/renesas-pinctrl (47ea7ff19f0b pinctrl: renesas: Rem=
ove R-Car H3 ES1.* handling)
Merging pinctrl-samsung/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pwm/for-next (cf70d01a62c7 pwm: dwc: Use devm_pwmchip_add())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (e1e17d7debf4 kselftest: amd-pstate: Fix spelling mi=
stakes)
Merging kunit/test (fe15c26ee26e Linux 6.3-rc1)
Merging kunit-next/kunit (2c6a96dad579 kunit: fix bug of extra newline char=
acters in debugfs logs)
Merging livepatching/for-next (5e36be5973b6 Merge branch 'for-6.4/core' int=
o for-next)
Merging rtc/rtc-next (fe15c26ee26e Linux 6.3-rc1)
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
Merging nvmem/for-next (66b5cebb0602 MAINTAINERS: Add myself as ONIE tlv NV=
MEM layout maintainer)
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
Merging mhi/mhi-next (14853a0676c1 bus: mhi: host: pci_generic: Revert "Add=
 a secondary AT port to Telit FN990")
Merging memblock/for-next (34875d6fc52d Add tests for memblock_alloc_node())
Merging cxl/next (e686c32590f4 dax/kmem: Fix leak of memory-hotplug resourc=
es)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (e1d447157f23 firmware/efi sysfb_efi: Add quirk for Lenovo=
 IdeaPad Duet 3)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (9ebe720eb93c mm: slub: make kobj_type structure cons=
tant)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (fe15c26ee26e Linux 6.3-rc1)
Merging sysctl/sysctl-next (3cd4e895357e xen: simplify sysctl registration =
for balloon)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (714f3af11b21 cpumask: fix function descript=
ion kernel-doc notation)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging hte/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging kspp/for-next/kspp (78f7a3fd6dc6 randstruct: disable Clang 15 suppo=
rt)
Merging kspp-gustavo/for-next/kspp (edfea16a6dae drm/vmwgfx: Replace one-el=
ement array with flexible-array member)
Merging iommufd/for-next (4ed4791afb34 iommufd/selftest: Add a selftest for=
 iommufd_device_attach() with a hwpt argument)

--Sig_/=0C9CU3DbWKMlJ5NCGeqxK9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQRJfAACgkQAVBC80lX
0GxZpAf/VIzb9UPWF7o2mMtsa9CsAvo+h6jLRQXeLw5yFZwQFo9XsH29eYWjQKnN
NHzy6ZLkEH257E7puiWHcXeFh4yco+TXLz9foKTDrtLBR7Afc7lDFlCI9WxnvnRt
YY9V3WIhCFEbWDEiAdoVExthKcDe4hkuwUvko/zUIYID9KrM/VAtcFFLSRJVwVnr
mD7QMFoK56CzfAj5t55HZ2jtR2nLejDfMlAG6qoAqlLM0FvO7ZRSdJdxTY+yfyrw
ADTawnz7xj2fa4/qsr0W+tfKxkGKmFoL3/UdsA/c6pK+bSytGbq0q3ZZXtE7x5vW
hLCM+gjvCYIDVcBA2CxpV/BmaQIp2w==
=z+li
-----END PGP SIGNATURE-----

--Sig_/=0C9CU3DbWKMlJ5NCGeqxK9--
