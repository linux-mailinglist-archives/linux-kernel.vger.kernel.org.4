Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66F86BDEED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 03:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCQCiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 22:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCQCiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 22:38:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B4901E;
        Thu, 16 Mar 2023 19:37:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pd7Y43Z2Vz4x7s;
        Fri, 17 Mar 2023 13:36:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679020568;
        bh=j3/4IkFja2I/k9P2RcnV5Yt5V6zoMiVl1TEluz2mw6o=;
        h=Date:From:To:Cc:Subject:From;
        b=rBrhdRSMtXfzKY/j5B4A28stnpSgvldSG52B5Strbckv9YR6qf2x6EyjzTAP5tk2b
         pqTMIq/u7LIy3okmY52U3DHLmqh7G/836HfgLrVSwQaT127v6a2dqSGR5nhyNpV/nk
         +qG9tqyOJP9sM7K9bG/OqEkrAQLYEfJc+cp7E+0UIziykJcn/OFeJXK+9HMMukrONS
         c50/odA+XzLaT4lIDQM/6ptW2OPecrafRJ2yMEA0cxM4mdsIdZvndxkblhfRlb6xbi
         gLemrbveXzgwRPC6p/ts3fPOKJIxWSYxLrVnMdLRR1bpwrSJrwSkF8Tg+HIv9UA9bz
         +sP7S8APRzJCQ==
Date:   Fri, 17 Mar 2023 13:36:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 17
Message-ID: <20230317133607.3b1cad16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Em2YhnOMM4LQMwuRvY9NlXb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Em2YhnOMM4LQMwuRvY9NlXb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230316:

The perf tree gained a build failure so I used the version from
next-20230316.

The slab tree gained a conflict against the mm tree.

Non-merge commits (relative to Linus' tree): 3776
 4240 files changed, 139757 insertions(+), 81164 deletions(-)

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
Merging origin/master (0ddc84d2dd43 Merge tag 'for-linus' of git://git.kern=
el.org/pub/scm/virt/kvm/kvm)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (cf72cdc423b0 mm: kfence: fix usin=
g kfence_metadata without initialization in show_object())
Merging kbuild-current/fixes (05e96e96a315 kbuild: use git-archive for sour=
ce package creation)
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
Merging powerpc-fixes/fixes (f2c7e3562b4c powerpc/mm: Fix false detection o=
f read faults)
Merging s390-fixes/fixes (d7a0bdbf1727 s390: update defconfigs)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (536ecc564437 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (04504793feec Merge branch 'virtio_net-xdp-bugs')
Merging bpf/master (c7df4813b149 xsk: Add missing overflow check in xdp_ume=
m_reg)
Merging ipsec/master (c276a706ea1f xfrm: Allow transport-mode states with A=
F_UNSPEC selector)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (75014826d082 Merge branch 'mtk_eth_soc-SGMII-fixes')
Merging wireless/for-next (007ae9b268ba wifi: mac80211: Serialize ieee80211=
_handle_wake_tx_queue())
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
Merging usb.current/usb-linus (bbf860ed710b usb: gadget: Use correct endian=
ness of the wLength field for WebUSB)
Merging usb-serial-fixes/usb-linus (773e8e7d07b7 USB: serial: option: add T=
elit FE990 compositions)
Merging phy/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging staging.current/staging-linus (eeac8ede1755 Linux 6.3-rc2)
Merging iio-fixes/fixes-togreg (7b3825e9487d iio: adc: max11410: fix read_p=
oll_timeout() usage)
Merging counter-current/counter-current (fe15c26ee26e Linux 6.3-rc1)
Merging char-misc.current/char-misc-linus (f551592f7256 Merge tag 'icc-6.3-=
rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-=
misc-linus)
Merging soundwire-fixes/fixes (e6923fd863af soundwire: qcom: correct settin=
g ignore bit on v1.5.1)
Merging thunderbolt-fixes/fixes (c82510b1d87b thunderbolt: Use scale field =
when allocating USB3 bandwidth)
Merging input-current/for-linus (7ae9fb1b7ecb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (660ca9470f9c crypto: caam - Fix edesc/iv ord=
ering mixup)
Merging vfio-fixes/for-linus (4928f67bc911 vfio/mlx5: Fix the report of dir=
ty_bytes upon pre-copy)
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
Merging hwmon-fixes/hwmon (ab00709310ee hwmon: (ltc2992) Set `can_sleep` fl=
ag for GPIO chip)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (c637393d1e8f Merge branch 'misc-6.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (7c3940bf81e5 swiotlb: fix the deadlock=
 in swiotlb_do_find_slots)
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
Merging risc-v-fixes/fixes (47dd902aaee9 RISC-V: mm: Support huge page in v=
malloc_fault())
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
Merging efi-fixes/urgent (261b4ba2d70c fixup! arm64: efi: Use SMBIOS proces=
sor version to key off Ampere quirk)
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
Merging drm-misc-fixes/for-linux-next-fixes (4028cbf867f7 drm/meson: dw-hdm=
i: Fix devm_regulator_*get_enable*() conversion again)
Merging mm-stable/mm-stable (819c2608ce2c Sync mm-stable with 6.3-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (fe15c26ee26e Linux 6.3-rc1)
Merging mm/mm-everything (e1285502c35f Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (5d49fb846d7f kallsyms: expand symbol name into com=
ment for debugging)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (96d541699e5c perf kvm: Update documentation to refl=
ect new changes)
$ git reset --hard HEAD^
Merging next-20230316 version of perf
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
Merging qcom/for-next (f84f5d2e1ffd Merge branches 'arm64-defconfig-for-6.4=
', 'arm64-fixes-for-6.3', 'arm64-for-6.4', 'clk-for-6.4', 'drivers-fixes-fo=
r-6.3', 'drivers-for-6.4', 'dts-fixes-for-6.3' and 'dts-for-6.4' into for-n=
ext)
Merging renesas/next (8184e7e383be Merge branches 'renesas-drivers-for-v6.4=
' and 'renesas-dts-for-v6.4' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (6d6761582819 Merge branch 'v6.4-armsoc/dts64' in=
to for-next)
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
Merging ti/ti-next (e2d18126b21e Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging clk/clk-next (6f173737e1b5 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging clk-renesas/renesas-clk (72cd8436ece0 clk: renesas: Convert to plat=
form remove callback returning void)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (fc89d7fb499b Merge tag 'for_linus' of git=
://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging m68k/for-next (e36a82bebbf7 m68k: Only force 030 bus error if PC no=
t in exception table)
Merging m68knommu/for-next (eeac8ede1755 Linux 6.3-rc2)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (9c99b4880d17 mips: Use of_property_read_bool() for =
boolean properties)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (783394630553 parisc: Ensure page alignment in f=
lush functions)
Merging powerpc/next (3c1d9f36e985 powerpc: Simplify sysctl registration fo=
r nmi_wd_lpm_factor_ctl_table)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (4a4c459872f1 Merge patch series "riscv, mm: detect=
 svnapot cpu support at runtime")
Merging riscv-dt/riscv-dt-for-next (0e9b70c1e362 riscv: dts: microchip: add=
 mpfs specific macb reset support)
Merging riscv-soc/riscv-soc-for-next (49f965b6fbca soc: canaan: Make K210_S=
YSCTL depend on CLK_K210)
Merging s390/for-next (70cc5f4c53d5 Merge branch 'features' into for-next)
Merging sh/for-next (ff30bd6a6618 sh: clk: Fix clk_enable() to return 0 on =
NULL clk)
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (5ab18f4b061e vhost: use vhost_tasks for worker thre=
ads)
Merging vfs-idmapping/for-next (740d9119ceff Merge branch 'vfs.pipe.nonbloc=
k' into for-next)
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
Merging cifs/for-next (38e04b3e4240 Merge tag '6.3-rc2-smb3-client-fixes' o=
f git://git.samba.org/sfrench/cifs-2.6)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (4f24ebae35ff erofs: support flattened block device for m=
ulti-blob images)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (dced733d7fa9 quota: simplify two-level sysctl regist=
ration for fs_dqstats_table)
Merging ext4/dev (18b7f4107219 ext4: Fix warnings when freezing filesystem =
with journaled data)
Merging f2fs/dev (196036c45f8c f2fs: fix uninitialized skipped_gc_rwsem)
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
Merging xfs/for-next (6de4b1ab470f xfs: try to idiot-proof the allocators)
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
Merging i2c/i2c/for-next (7618417929c1 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (1dae3f1df700 i3c: dw: drop of_match_ptr for ID table)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (fe6a3acdf364 hwmon: (nct6775) update ASUS=
 WMI monitoring list A520/B360/B460/B550...)
Merging jc_docs/docs-next (10d18135135c docs/mm: Physical Memory: add examp=
le of interleaving nodes)
Merging v4l-dvb/master (eeac8ede1755 Linux 6.3-rc2)
Merging v4l-dvb-next/master (eeac8ede1755 Linux 6.3-rc2)
Merging pm/linux-next (1240ce78c05e Merge branches 'acpi-tables' and 'acpi-=
tools' into linux-next)
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
Merging net-next/main (cc6d85c1cb5c nfc: mrvl: Use of_property_read_bool() =
for boolean properties)
CONFLICT (content): Merge conflict in net/hsr/hsr_framereg.c
CONFLICT (content): Merge conflict in net/wireless/nl80211.c
Merging bpf-next/for-next (082cdc69a465 bpf: Remove misleading spec_v1 chec=
k on var-offset stack read)
Merging ipsec-next/master (f4796398f21b xfrm: Remove inner/outer modes from=
 output path)
Merging mlx5-next/mlx5-next (22551e77e550 net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (95b744508d4d qede: remove linux/version.h and linux=
/compiler.h)
Merging bluetooth/master (8abee3773899 Bluetooth: mgmt: Fix MGMT add advmon=
 with RSSI command)
Merging wireless-next/for-next (499183cc3b52 wifi: iwlwifi: Avoid disabling=
 GCC specific flag with clang)
Merging mtd/mtd/next (1a7537a39b06 Merge tag 'mtd/core-fixes-before-nvmem-l=
ayouts-for-6.4' into mtd/next)
Merging nand/nand/next (4080d5362416 mtd: parsers: remove reference to conf=
ig MTD_NAND_TMIO)
Merging spi-nor/spi-nor/next (f047382519ca Merge tag 'mtd/fixes-for-6.2-rc4=
' into spi-nor/next)
Merging crypto/master (a3e8c919b993 crypto: qat - add support for 402xx dev=
ices)
Merging drm/drm-next (8bf6e20253b2 Merge tag 'drm-intel-next-2023-03-07' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-misc/for-linux-next (165d5133731a drm/format-helper: Make "dest=
ination_pitch" test usable for mono)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tiny/cirrus.c
Merging amdgpu/drm-next (7ee938ac0060 drm/amdgpu: Don't resume IOMMU after =
incomplete init)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/soc21.c
Merging drm-intel/for-linux-next (c7d18b40a80e drm/i915/display: ignore lin=
k training failures in CI)
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
Merging fbdev/for-next (29413f05fe34 fbdev: Use of_property_present() for t=
esting DT property presence)
Merging regmap/for-next (24d80fde40c9 regmap: cache: Silence checkpatch war=
ning)
Merging sound/for-next (ce8e5f202f3e ALSA: usb-audio: remove Wireless USB d=
ead code)
Merging sound-asoc/for-next (7ebd2c965247 Merge remote-tracking branch 'aso=
c/for-6.4' into asoc-next)
Merging modules/modules-next (40cf65c2c7df dyndbg: cleanup dynamic usage in=
 ib_srp.c)
Merging input/next (d5f7638eb5fe Input: matrix_keypad - replace header incl=
usions by forward declarations)
Merging block/for-next (22dd958c3b87 Merge branch 'for-6.4/io_uring' into f=
or-next)
Merging device-mapper/for-next (d3aa3e060c4a dm stats: check for and propag=
ate alloc_percpu failure)
Merging libata/for-next (672b7ad20f7b ata: Use of_property_present() for te=
sting DT property presence)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (46d19dc62b45 mmc: sdhci-pci-o2micro: Fix SDR50 mode timin=
g issue)
Merging mfd/for-mfd-next (3030a8fd1688 mfd: da9062: Remove IRQ requirement)
Merging backlight/for-backlight-next (541ec23c603d backlight: sky81452-back=
light: Convert to platform remove callback returning void)
Merging battery/for-next (5161ec200f5a power: supply: bq256xx: Support to d=
isable charger)
Merging regulator/for-next (691c1fcda535 regulator: core: Shorten off-on-de=
lay-us for always-on/boot-on by time since booted)
Merging security/next (b9b8701b4314 security: Remove integrity from the LSM=
 list in Kconfig)
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (644f17412f5a IMA: allow/fix UML builds)
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
Merging devicetree/for-next (0a4ca303ece2 dt-bindings: crypto: fsl,sec-v4.0=
: Convert to DT schema)
Merging dt-krzk/for-next (a3e54f180247 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (6ccbe33a3952 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for QDU1000/QRU1000)
Merging spi/for-next (1e4929112507 spi: stm32: split large transfers based =
on word size instead of bytes)
Merging tip/master (24f2bb9566a6 Merge branch into tip/master: 'x86/paravir=
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
Merging kvm/next (d8708b80fa0e KVM: Change return type of kvm_arch_vm_ioctl=
() to "int")
Merging kvm-arm/next (96a4627dbbd4 Merge tag ' https://github.com/oupton/li=
nux tags/kvmarm-6.3' from into kvmarm-master/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (d8708b80fa0e KVM: Change return type of kvm_arch_vm_i=
octl() to "int")
Merging xen-tip/linux-next (7ad2c39860dc xen: remove unnecessary (void*) co=
nversions)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (02c464b73645 platform/x86: x86-android-tablet=
s: Add depends on PMIC_OPREGION)
Merging chrome-platform/for-next (db7df0cfaff3 platform/chrome: cros_ec: re=
move unneeded label and if-condition)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (1aeff6216891 dt-bindings: leds: Add QCOM fla=
sh LED controller)
Merging ipmi/for-next (d352cb47df75 ipmi: simplify sysctl registration)
Merging driver-core/driver-core-next (0433686c6092 devres: Pass unique name=
 of the resource to devm_add_action())
Merging usb/usb-next (3754c41c7686 dt-bindings: usb: snps,dwc3: support i.M=
X8MQ)
Merging thunderbolt/next (68b8e15848c4 thunderbolt: Rename shadowed variabl=
es bit to interrupt_bit and auto_clear_bit)
Merging usb-serial/usb-next (eeac8ede1755 Linux 6.3-rc2)
Merging tty/tty-next (571079f5ba93 Documentation/serial-console: Document t=
he behavior when the last console=3D parameter is not used)
CONFLICT (content): Merge conflict in drivers/tty/serial/8250/8250_em.c
Merging char-misc/char-misc-next (c2c99326cc01 misc: smpro-errmon: Add dimm=
 training failure syndrome)
Merging accel/habanalabs-next (9a6cbf54146b accel/habanalabs: expose dram r=
eserved size by kmd)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging icc/icc-next (93ce96a83f93 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (91ba2700aa75 staging: iio: meter: Drop ade7854 driver)
Merging phy-next/next (fe15c26ee26e Linux 6.3-rc1)
Merging soundwire/next (f90c359aa25f soundwire: qcom: gracefully handle too=
 many ports in DT)
Merging extcon/extcon-next (6384c02f33a9 extcon: Remove redundant null chec=
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
Merging rpmsg/for-next (e19967994d34 remoteproc/mtk_scpi_ipi: Fix one kerne=
l-doc comment)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (03810031c91d gpio: fxl6408: add I2C GPIO e=
xpander driver)
Merging gpio-intel/for-next (0928069402ec gpio: mm-lantiq: Fix typo in the =
newly added header filename)
Merging pinctrl/for-next (5c6073d29c45 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-renesas/renesas-pinctrl (9d7558ed8372 pinctrl: renesas: Dro=
p support for Renesas-specific properties)
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
Merging nvmem/for-next (6861ff20b635 MAINTAINERS: Add myself as ONIE tlv NV=
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
Merging slab/for-next (4ffff5c00595 Merge branch 'slab-remove-slob-v2r1' in=
to slab/for-next)
CONFLICT (content): Merge conflict in include/linux/slab.h
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

--Sig_/Em2YhnOMM4LQMwuRvY9NlXb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQT0hcACgkQAVBC80lX
0GxWCwf/YPn14JSZ7snjvVB0snfdQI43j+So6vMkt57wC4bjTdq58S9o15Tum1P6
2ySrE07oAbL1DOQBzRW0czOZKDbY65o/dJ8y+ggZibyqXCAL+WXEHDpw1/pAnLp/
oKILg8VMx7U7vM2DYZyuTjSKyvmromviepA1nyHstKpYA8OVgWULKswwPSVfcELk
Wt35IkP722aEuOYMUCNoLEA9EKhMx0W8GNR1WtDtqNvToB7GkxNWrTkhu1dR6F+x
8/P5fsYWHIOenKDctSCXq3hf/AhzEID0Gm/cei+6q2BnQhDAzRn6IVC5caLe9nOP
6opLgTJdn5qXREAyqnxlSXq5sPP0nA==
=xS5l
-----END PGP SIGNATURE-----

--Sig_/Em2YhnOMM4LQMwuRvY9NlXb--
