Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CDB6C76BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCXE4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCXE40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:56:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735C28D3D;
        Thu, 23 Mar 2023 21:56:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjVKd6sP0z4xD5;
        Fri, 24 Mar 2023 15:56:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679633782;
        bh=LinJFvcMc899fAw3kRVptglydi5sEEa+qgdnT8ur3Bw=;
        h=Date:From:To:Cc:Subject:From;
        b=nkxYp1hcSk7fFrHzvasH7MCAYjL0lBxJ4XgrZSVgMwcoxKwJbWmVX6aQfIGQD6Z7n
         hVhcctpzvOsG03hDAQfsWz0GtGoeBaoaUyXa2k9NvlA9O/Ap3v/wuVyTIJoBzxhSth
         1BC4hvAwiaGwgbOPgopcoOI+48xMfGm1E9DWPAiR3OGV3BdfcuMlF0aB9AMpkgwHEN
         yacpYvfOx4WWIcSgyPshKnriWJcatzULlSCFvsy4JQVnkftHHVbM7sMcPn8eKIp2RM
         TObOg0XBsuTVtly9K7nx0h6I6nTrHgVtO16s/EReV1osSjenJ/ovqa1fAgHuKG3qFX
         81G7tNQ0yzGKQ==
Date:   Fri, 24 Mar 2023 15:56:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 24
Message-ID: <20230324155621.0e1d3d49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aYemPuEKcUbeW9=fTOoru3b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aYemPuEKcUbeW9=fTOoru3b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230323:

The perf tree lost its its build failure.

The sh tree gained a conflict against the parisc-hd tree.

The jc_docs tree gained a conflict against the driver-core.current tree.

The net-next tree gained a conflict against the net tree.

The block tree gained a semantic conflict against the mm tree.

The tmpdd tree still had its build failure so I used the version from
next-20230320.

The gpio-brgl tree lost its build failure.

Non-merge commits (relative to Linus' tree): 6123
 7024 files changed, 235724 insertions(+), 145875 deletions(-)

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
Merging origin/master (1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (3b6bee9490e1 mm: kfence: fix hand=
ling discontiguous page)
Merging kbuild-current/fixes (fb27e70f6e40 modpost: Fix processing of CRCs =
on 32-bit build machines)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (ceac10c83b33 ARM: 9290/1: uaccess: Fix KASAN fal=
se-positives)
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
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (1b4ae19e432d Merge tag 'for-netdev' of https://git.kernel=
.org/pub/scm/linux/kernel/git/bpf/bpf)
Merging bpf/master (915efd8a446b xdp: bpf_xdp_metadata use EOPNOTSUPP for n=
o driver support)
Merging ipsec/master (c276a706ea1f xfrm: Allow transport-mode states with A=
F_UNSPEC selector)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (bb765a743377 mlxsw: spectrum_fid: Fix incorrect local po=
rt type)
Merging wireless/for-next (f355f7014574 wifi: mac80211: fix mesh path disco=
very based on unicast packets)
Merging rdma-fixes/for-rc (6bd1bca858f1 RDMA/erdma: Defer probing if netdev=
ice can not be found)
Merging sound-current/for-linus (5f4efc9dfcfd ALSA: hda/realtek: Fix suppor=
t for Dell Precision 3260)
Merging sound-asoc-fixes/for-linus (a4a3203426f4 ASoC: codecs: lpass: fix t=
he order or clks turn off during suspend)
Merging regmap-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging regulator-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging spi-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging pci-current/for-linus (cdce67099117 PCI: dwc: Fix PORT_LINK_CONTROL=
 update when CDM check enabled)
Merging driver-core.current/driver-core-linus (44ac5abac86b Documentation/s=
ecurity-bugs: move from admin-guide/ to process/)
Merging tty.current/tty-linus (e8d018dd0257 Linux 6.3-rc3)
Merging usb.current/usb-linus (5021383242ad usb: dwc2: fix a race, don't po=
wer off/on phy for dual-role mode)
Merging usb-serial-fixes/usb-linus (773e8e7d07b7 USB: serial: option: add T=
elit FE990 compositions)
Merging phy/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging staging.current/staging-linus (eeac8ede1755 Linux 6.3-rc2)
Merging iio-fixes/fixes-togreg (363c7dc72f79 iio: adc: ti-ads7950: Set `can=
_sleep` flag for GPIO chip)
Merging counter-current/counter-current (00f4bc5184c1 counter: 104-quad-8: =
Fix Synapse action reported for Index signals)
Merging char-misc.current/char-misc-linus (4dd52392b5d7 Merge tag 'coresigh=
t-fixes-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/li=
nux into char-misc-linus)
Merging soundwire-fixes/fixes (e6923fd863af soundwire: qcom: correct settin=
g ignore bit on v1.5.1)
Merging thunderbolt-fixes/fixes (58cdfe6f58b3 thunderbolt: Rename shadowed =
variables bit to interrupt_bit and auto_clear_bit)
Merging input-current/for-linus (754ff5060daf Input: alps - fix compatibili=
ty with -funsigned-char)
Merging crypto-current/master (660ca9470f9c crypto: caam - Fix edesc/iv ord=
ering mixup)
Merging vfio-fixes/for-linus (4928f67bc911 vfio/mlx5: Fix the report of dir=
ty_bytes upon pre-copy)
Merging kselftest-fixes/fixes (05107edc9101 selftests: sigaltstack: fix -Wu=
ninitialized)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (b771baf3988a dmaengine: xilinx: xdma: Fix so=
me kernel-doc comments)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (e732e39ed992 mtd: rawnand: meson: invalidate c=
ache on polling ECC bit)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (55f1ecb11990 media: v4l: subdev: Make link val=
idation safer)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (ab327f8acdf8 mips: bmips: BCM6358: disable R=
AC flush for TP1)
Merging at91-fixes/at91-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (f3e707413dbe KVM: selftests: Sync KVM exit reason=
s in selftests)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (968b66ffeb79 hwmon (it87): Fix voltage scaling f=
or chips with 10.9mV  ADCs)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (c637393d1e8f Merge branch 'misc-6.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (0eee5ae10256 swiotlb: fix slot alignme=
nt checks)
Merging drivers-x86-fixes/fixes (acd0acb802b9 platform/surface: aggregator:=
 Add missing fwnode_handle_put())
Merging samsung-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-samsung-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree-fixes/dt/linus (707344c8a188 dt-bindings: interrupt-cont=
roller: arm,gic-v3: Fix typo in description of msi-controller property)
Merging dt-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging scsi-fixes/fixes (a13faca032ac scsi: scsi_dh_alua: Fix memleak for =
'qdata' in alua_activate())
Merging drm-fixes/drm-fixes (e8d018dd0257 Linux 6.3-rc3)
Merging drm-intel-fixes/for-linux-next-fixes (22aa20e4c5dc Revert "drm/i915=
/hwmon: Enable PL1 power limit")
Merging mmc-fixes/fixes (2265098fd6a6 mmc: sdhci_am654: Set HIGH_SPEED_ENA =
for SDR12 and SDR25)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (f8acb24aaf89 x86/hyperv: Block root part=
ition functionality in a Confidential VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (e89c2e815e76 riscv: Handle zicsr/zifencei issue=
s between clang and binutils)
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
Merging nfsd-fixes/nfsd-fixes (5f24a8725fe7 SUNRPC: Fix a crash in gss_krb5=
_checksum())
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (5b201a82cd9d perf tools: Add Adrian Hunte=
r to MAINTAINERS as a reviewer)
Merging efi-fixes/urgent (0b1d9debe303 efi/libstub: randomalloc: Return EFI=
_OUT_OF_RESOURCES on failure)
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
Merging drm-misc-fixes/for-linux-next-fixes (1a70ca89d59c drm/bridge: lt891=
2b: return EPROBE_DEFER if bridge is not found)
Merging mm-stable/mm-stable (819c2608ce2c Sync mm-stable with 6.3-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (fe15c26ee26e Linux 6.3-rc1)
Merging mm/mm-everything (4f8ccd52f237 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (b26e7a4b4ef6 kallsyms: expand symbol name into com=
ment for debugging)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (96d541699e5c perf kvm: Update documentation to refl=
ect new changes)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (9b07d27d0fbb swiotlb: mark swiotlb_memblock_a=
lloc() as __init)
Merging asm-generic/master (a13408c20526 char/agp: introduce asm-generic/ag=
p.h)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (7e01cedfc602 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (010338d729c1 arm64: kaslr: don't pretend KASLR=
 is enabled if offset < MIN_KIMG_ALIGN)
Merging arm-perf/for-next/perf (e8a709dc2a91 perf: arm_spe: Print the versi=
on of SPE detected)
Merging arm-soc/for-next (811bbcfc8ea2 Merge branch 'soc/arm' into for-next)
Merging amlogic/for-next (da2e9232b20f Merge branch 'v6.4/arm-dt' into for-=
next)
Merging asahi-soc/asahi-soc/for-next (22991d8d5725 soc: apple: rtkit: Add r=
egister dump decoding to crashlog)
Merging aspeed/for-next (bb13bd587d53 ARM: dts: aspeed: bonnell: Update eep=
rom size)
Merging at91/at91-next (f5200f71d927 clk: microchip: Use of_property_read_b=
ool() for boolean properties)
Merging broadcom/next (a2264238029f Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory/for-next (2ae66ecc0825 memory: tegra: remove redunda=
nt variable initialization)
Merging imx-mxs/for-next (a7a9bae8c567 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (9b2797522f32 Merge branch 'v6.3-next/soc' into f=
or-next)
Merging mvebu/for-next (b80b042da860 Merge branch 'mvebu/fixes' into mvebu/=
for-next)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (ac7094420ac8 Merge branches 'arm64-defconfig-for-6.4=
', 'arm64-fixes-for-6.3', 'arm64-for-6.4', 'clk-for-6.4', 'drivers-fixes-fo=
r-6.3', 'drivers-for-6.4', 'dts-fixes-for-6.3' and 'dts-for-6.4' into for-n=
ext)
Merging renesas/next (8184e7e383be Merge branches 'renesas-drivers-for-v6.4=
' and 'renesas-dts-for-v6.4' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (52964e8dd25b Merge branch 'v6.4-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (fb656e801725 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (9848e199b090 Merge branch 'for-next/scmi/fixes=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into =
for-linux-next)
Merging stm32/stm32-next (19f969c0c738 ARM: dts: stm32: Add coprocessor det=
ach mbox on stm32mp15xx-osd32 SoM)
Merging sunxi/sunxi/for-next (fe8c68a87add Merge branch 'sunxi/dt-for-6.4' =
into sunxi/for-next)
Merging tee/next (f8502fba45bd tee: amdtee: fix race condition in amdtee_op=
en_session)
Merging tegra/for-next (09870af4487f Merge branch for-6.4/arm64/dt into for=
-next)
Merging ti/ti-next (9790831f6dbf Merge branches 'ti-k3-dts-next', 'ti-k3-co=
nfig-next' and 'ti-drivers-soc-next' into ti-next)
Merging xilinx/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging clk/clk-next (ea09982f9781 Merge branch 'clk-socfpga' into clk-next)
Merging clk-imx/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging clk-renesas/renesas-clk (72cd8436ece0 clk: renesas: Convert to plat=
form remove callback returning void)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (fc89d7fb499b Merge tag 'for_linus' of git=
://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging m68k/for-next (fda1941b8eab m68k: Remove obsolete config NO_KERNEL_=
MSG)
Merging m68knommu/for-next (8fc6ba5f96bc m68k: Kconfig.machine: remove obso=
lete configs ROMBASE and ROMSIZE)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (a45e5fe79234 MIPS: ath79: remove obsolete ATH79_DEV=
_* configs)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (783394630553 parisc: Ensure page alignment in f=
lush functions)
Merging powerpc/next (3a713753d3cb powerpc: Simplify sysctl registration fo=
r nmi_wd_lpm_factor_ctl_table)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (4b740779ac03 Merge patch series "RISC-V: Apply Zic=
boz to clear_page")
Merging riscv-dt/riscv-dt-for-next (0e9b70c1e362 riscv: dts: microchip: add=
 mpfs specific macb reset support)
Merging riscv-soc/riscv-soc-for-next (49f965b6fbca soc: canaan: Make K210_S=
YSCTL depend on CLK_K210)
Merging s390/for-next (1485d9a4eecf Merge branch 'features' into for-next)
Merging sh/for-next (c2bd1e18c6f8 sh: mcount.S: fix build error when PRINTK=
 is not enabled)
CONFLICT (content): Merge conflict in Documentation/kbuild/kbuild.rst
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (1d3b7a788ca7 xtensa: fix KASAN report for s=
how_stack)
Merging pidfd/for-next (6e890c5d5021 vhost: use vhost_tasks for worker thre=
ads)
Merging vfs-idmapping/for-next (407dd0b9bbb3 Merge branch 'vfs.open.directo=
ry.creat' into for-next)
Merging fscrypt/for-next (704d0e7a9b7d fscrypt: new helper function - fscry=
pt_prepare_lookup_partial())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (80d1eec6927a Merge branch 'for-next-current-v6.2-20=
230221' into for-next-20230221)
Merging ceph/master (f7c4d9b133c7 rbd: avoid use-after-free in do_rbd_add()=
 when rbd_dev_create() fails)
Merging cifs/for-next (6bf7e0cfafcd SMB3: Close deferred file handles if we=
 get handle lease break)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (4f24ebae35ff erofs: support flattened block device for m=
ulti-blob images)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (fae0a2b2077c ext2: remove redundant assignment to po=
inter end)
Merging ext4/dev (da8c7d2105be ext4: convert some BUG_ON's in mballoc to us=
e WARN_RATELIMITED instead)
Merging f2fs/dev (d15180a8d1d7 f2fs: fix to handle filemap_fdatawrite() err=
or in f2fs_ioc_decompress_file/f2fs_ioc_compress_file)
Merging fsverity/for-next (2da81b847943 fs-verity: simplify sysctls with re=
gister_sysctl())
Merging fuse/for-next (1cc4606d19e3 fuse: add inode/permission checks to fi=
leattr_get/fileattr_set)
Merging gfs2/for-next (260595b43977 Reinstate "GFS2: free disk inode which =
is deleted by remote node -V2")
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (178d1a8798e2 ksmbd: return unsupported error =
on smb1 mount)
Merging nfs/linux-next (e8d018dd0257 Linux 6.3-rc3)
Merging nfs-anna/linux-next (943d045a6d79 SUNRPC: fix shutdown of NFS TCP c=
lient socket)
Merging nfsd/nfsd-next (3077f83bfb9e sunrpc: simplify two-level sysctl regi=
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
Merging xfs/for-next (e9b60c7f9713 pcpcntr: remove percpu_counter_sum_all())
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
Merging i3c/i3c/next (2810f1de814a i3c: svc: Convert to platform remove cal=
lback returning void)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (90fdf77348ce hwmon: (pwm-fan) set usage_p=
ower on PWM state)
Merging jc_docs/docs-next (4f1bb0386dfc docs: create a top-level arch/ dire=
ctory)
CONFLICT (content): Merge conflict in Documentation/admin-guide/index.rst
Merging v4l-dvb/master (eeac8ede1755 Linux 6.3-rc2)
Merging v4l-dvb-next/master (71937240a472 media: ov2685: Select VIDEO_V4L2_=
SUBDEV_API)
Merging pm/linux-next (fc5f43f31bdc Merge branch 'thermal-acpi' into linux-=
next)
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
Merging rdma/for-next (901d9d62416b RDMA/erdma: Minor refactor of device in=
it flow)
Merging net-next/main (fcb3a4653bc5 net/sched: act_api: use the correct TCA=
_ACT attributes in dump)
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/en_tc.c
Applying: fix up for "net/mlx5e: Initialize link speed to zero"
Merging bpf-next/for-next (226bc6ae6405 Merge branch 'Transit between BPF T=
CP congestion controls.')
CONFLICT (content): Merge conflict in Documentation/bpf/bpf_devel_QA.rst
Applying: bpf, test_run: fix up for "bpf, test_run: fix &xdp_frame misplace=
ment for LIVE_FRAMES"
Merging ipsec-next/master (f4796398f21b xfrm: Remove inner/outer modes from=
 output path)
Merging mlx5-next/mlx5-next (f4244e55e4c3 net/mlx5: Set out of order (ooo) =
by default)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (b0e214d21203 netfilter: keep conntrack reference un=
til IPsecv6 policy checks are done)
Merging bluetooth/master (db0fc80ec686 Bluetooth: NXP: select CONFIG_CRC8)
CONFLICT (content): Merge conflict in net/bluetooth/hci_sync.c
Merging wireless-next/for-next (0dd45ebc08de wifi: mac80211_hwsim: EMA supp=
ort)
Merging mtd/mtd/next (85ef1236fb69 dt-bindings: mtd: Drop unneeded quotes)
Merging nand/nand/next (cb70cf99abae mtd: rawnand: remove unused is_imx51_n=
fc and imx53_nfc functions)
Merging spi-nor/spi-nor/next (6afcc84080c4 mtd: spi-nor: spansion: Add supp=
ort for Infineon S25FS256T)
Merging crypto/master (e6af5c0c4d32 crypto: stm32 - Save and restore betwee=
n each request)
Merging drm/drm-next (d36d68fd1925 Merge tag 'drm-habanalabs-next-2023-03-2=
0' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into dr=
m-next)
Merging drm-misc/for-linux-next (6a17b4d1b52f drm/bridge: ps8640: Add a cac=
he for EDID)
Merging amdgpu/drm-next (5ee33d905f89 drm/amd/amdgpu: limit one queue per g=
ang)
Merging drm-intel/for-linux-next (883631771038 drm/i915/mtl: Add HDCP GSC i=
nterface)
Merging drm-tegra/for-next (b9930311641c gpu: host1x: Fix uninitialized var=
iable use)
Merging drm-msm/msm-next (f73343fae5fb drm/msm: Update generated headers)
Merging drm-msm-lumag/msm-next-lumag (0c3f3cfd8ef2 drm/msm/dp: set self ref=
resh aware based on PSR support)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (b61c2c09c5a3 video: fbdev: xilinxfb: Convert to pla=
tform remove callback returning void)
Merging regmap/for-next (24d80fde40c9 regmap: cache: Silence checkpatch war=
ning)
Merging sound/for-next (b1e675d1b57e ALSA: ac97: Remove redundant driver ma=
tch function)
Merging sound-asoc/for-next (02c1d648c990 Merge remote-tracking branch 'aso=
c/for-6.4' into asoc-next)
Merging modules/modules-next (6e82310365ba module: already_uses() - reduce =
pr_debug output volume)
Merging input/next (6906f5060d39 Input: iqs62x-keys - suppress duplicated e=
rror message in .remove())
Merging block/for-next (3b0721519be2 Merge branch 'for-6.4/io_uring' into f=
or-next)
Applying: fix up for "iov_iter: add copy_page_to_iter_nofault()"
Merging device-mapper/for-next (f0d87d8f9a23 dm thin: speed up cell_defer_n=
o_holder())
Merging libata/for-next (083ad04d3172 ata: pata_parport-bpck6: reduce inden=
ts in bpck6_open)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (bad4c304c7e8 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (368eb79f738a dt-bindings: mfd: qcom,spmi-pmic: Ad=
d PM2250)
Merging backlight/for-backlight-next (fb200218b40b backlight: as3711: Use o=
f_property_read_bool() for boolean properties)
Merging battery/for-next (86c0ef8652f7 power: supply: generic-adc-battery: =
style fixes)
Merging regulator/for-next (58973046c1bf regulator: qcom-rpmh: Use PROBE_FO=
RCE_SYNCHRONOUS)
Merging security/next (0d57b970df35 security: Remove security_old_inode_ini=
t_security())
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (644f17412f5a IMA: allow/fix UML builds)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (79781fe466b0 selinux: update the file list in MAINTAI=
NERS)
Merging smack/next (502a29b04d85 smack_lsm: remove unnecessary type casting)
Merging tomoyo/master (ab8527429de6 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (923c8dfa9a36 tpm: fix build break in tpm-chip.c caused =
by AMD fTPM quirk)
$ git reset --hard HEAD^
Merging next-20230320 version of tpmdd
Merging watchdog/master (cf3be7e82b12 watchdog: at91rm9200: Only warn once =
about problems in .remove())
Merging iommu/next (3578e36f238e Merge branches 'iommu/fixes', 'arm/allwinn=
er', 'arm/mediatek', 'arm/omap', 'arm/renesas', 'ppc/pamu', 'x86/amd' and '=
core' into next)
Merging audit/next (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree/for-next (c9c9d764daee of: unittest: Convert to platform=
 remove callback returning void)
Merging dt-krzk/for-next (efb75299863e Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (6ccbe33a3952 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for QDU1000/QRU1000)
Merging spi/for-next (bc43c5ec1a97 spi: f_ospi: Add missing spi_mem_default=
_supports_op() helper)
Merging tip/master (7f9fb2f71489 Merge branch 'x86/tdx')
CONFLICT (content): Merge conflict in mm/userfaultfd.c
Merging clockevents/timers/drivers/next (ab407a1919d2 Merge tag 'clocksourc=
e.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/lin=
ux-rcu into timers/core)
Merging edac/edac-for-next (196088de1ab2 Merge ras/edac-misc into for-next)
Merging irqchip/irq/irqchip-next (a83bf176fed4 Merge branch irq/bcm-l2-fixe=
s into irq/irqchip-next)
Merging ftrace/for-next (cd17e0c74a07 Merge bootconfig/for-next)
Merging rcu/rcu/next (852d232ed60f rcu/rcuscale: Stop kfree_scale_thread th=
read(s) after unloading rcuscale)
Merging kvm/next (d8708b80fa0e KVM: Change return type of kvm_arch_vm_ioctl=
() to "int")
Merging kvm-arm/next (96a4627dbbd4 Merge tag ' https://github.com/oupton/li=
nux tags/kvmarm-6.3' from into kvmarm-master/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (e7fb48afd673 Merge branches 'misc', 'mmu', 'svm' and =
'cmd_msrs')
Merging xen-tip/linux-next (aadbd07ff8a7 x86/PVH: avoid 32-bit build warnin=
g when obtaining VGA console info)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (704bc669e1dd workqueue: Introduce show_freezab=
le_workqueues)
Merging drivers-x86/for-next (fd3c35845390 platform/x86: pcengines-apuv2: D=
rop platform:pcengines-apuv2 module-alias)
Merging chrome-platform/for-next (db7df0cfaff3 platform/chrome: cros_ec: re=
move unneeded label and if-condition)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (8faac9aba0d8 leds: rgb: mt6370: Fix implicit=
 declaration for FIELD_GET)
Merging ipmi/for-next (d352cb47df75 ipmi: simplify sysctl registration)
Merging driver-core/driver-core-next (bf6479dbe743 cpuidle: move to use bus=
_get_dev_root())
CONFLICT (content): Merge conflict in arch/s390/kernel/topology.c
Merging usb/usb-next (8be174835f07 usb: ftdi-elan: Delete driver)
Merging thunderbolt/next (ebde5ba27c64 thunderbolt: Refactor DROM reading)
Merging usb-serial/usb-next (e8d018dd0257 Linux 6.3-rc3)
Merging tty/tty-next (f16a70c0472e Merge 6.3-rc3 into tty-next)
Merging char-misc/char-misc-next (abae262640ef Merge 6.3-rc3 into char-misc=
-next)
CONFLICT (modify/delete): drivers/char/pcmcia/cm4000_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/cm4000_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/cm4040_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/cm4040_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/scr24x_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/scr24x_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/synclink_cs.c deleted in char=
-misc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pc=
mcia/synclink_cs.c left in tree.
$ git rm -f drivers/char/pcmcia/cm4000_cs.c drivers/char/pcmcia/cm4040_cs.c=
 drivers/char/pcmcia/scr24x_cs.c drivers/char/pcmcia/synclink_cs.c
Merging accel/habanalabs-next (bfa94e507628 accel/habanalabs: send disable =
pci when compute ctx is active)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging icc/icc-next (403ade557dd1 interconnect: qcom: rpm: drop bogus pm d=
omain attach)
Merging iio/togreg (225dc61e2fa8 iio: adc: stm32-adc: set some stm32-adc.c =
variables storage-class-specifier to static)
Merging phy-next/next (84a59a314263 phy: xgene: Depend on ARCH_XGENE rather=
 than plain arm64)
Merging soundwire/next (6c469871e801 soundwire: stream: restore cumulative =
bus bandwidth when compute_params callback failed)
Merging extcon/extcon-next (3beb28f4c805 extcon: usbc-tusb320: add USB_ROLE=
_SWITCH dependency)
CONFLICT (content): Merge conflict in drivers/extcon/extcon.c
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (d649c34cb916 vfio: Fix NULL pointer dereference caused b=
y uninitialized group->iommufd)
Merging staging/staging-next (1bd51241bde4 Staging: nvec: Remove macro defi=
nition to_nvec_led)
Merging counter-next/counter-next (fe15c26ee26e Linux 6.3-rc1)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (fe8f1a2e9b7c dt-bindings: dma: apple,admac: Add t81=
12-admac compatible)
Merging cgroup/for-next (70a0eb104712 Merge branch 'for-6.4' into for-next)
Merging scsi/for-next (2b6ac25dfa2a Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (e05c006dac08 Merge patch series "mpi3mr: Few Enh=
ancements and minor fixes")
CONFLICT (content): Merge conflict in drivers/scsi/mpi3mr/mpi3mr_fw.c
Merging vhost/linux-next (c1c331a8287f tools/virtio: fix typo in README ins=
tructions)
Merging rpmsg/for-next (e19967994d34 remoteproc/mtk_scpi_ipi: Fix one kerne=
l-doc comment)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (2093bcd87232 gpio: xlp: Convert to immutab=
le irq_chip)
Merging gpio-intel/for-next (782eea0c89f7 gpiolib: acpi: Add a ignore wakeu=
p quirk for Clevo NL5xNU)
Merging pinctrl/for-next (454c44542d35 Merge branch 'devel' into for-next)
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
Merging kunit-next/kunit (99be6588118b kunit: Use gfp in kunit_alloc_resour=
ce() kernel-doc)
Merging livepatching/for-next (5e36be5973b6 Merge branch 'for-6.4/core' int=
o for-next)
Merging rtc/rtc-next (0e6255fa3f64 rtc: meson-vrtc: Use ktime_get_real_ts64=
() to get the current time)
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
Merging nvmem/for-next (c60363be9b76 nvmem: layouts: onie-tlv: Drop wrong m=
odule alias)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (fe15c26ee26e Linux 6.3-rc1)
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
Merging efi/next (bac363715a7c efi/libstub: Look for initrd LoadFile2 proto=
col on image handle)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (2f26f6a8ccd5 Merge branch 'slab/for-6.3-rc4/fixes' i=
nto slab/for-next)
CONFLICT (content): Merge conflict in include/linux/slab.h
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (fe15c26ee26e Linux 6.3-rc1)
Merging sysctl/sysctl-next (3bacdffa1756 mm: memory-failure: Move memory fa=
ilure sysctls to its own file)
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

--Sig_/aYemPuEKcUbeW9=fTOoru3b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQdLXUACgkQAVBC80lX
0GwG8wf+KM8htxE3PvSbp3xhueUyfvmMBkz64KaOjJmeRWcB4b/Z5K3NF3xKcDKO
/ZEkR0MCxDsEKQGDphLyGk6IUsIxkIN91VZAEyDqxCreajheTQaKWfSKLnQuHIiP
33bG74+sf/Q/DmFRdtEgwFlt/e9JlS9FnGaDQdqvvaWvt5U46AOA09BaK2I4D4Si
/PLBsQC33W3PjqBt1l269bD6E5Sd6/yRWQNqkAAQmPNP0t0V9N4l3Os43FY3W8Wo
4+rqK5QSGwve0bQmPYqECZSd/r/R8pgzJt5AenzGORW02h2eYL12K1kwzpguUPRD
k/lMpndBxyKn+jfcIYu2aMFKA0W1OQ==
=G0C6
-----END PGP SIGNATURE-----

--Sig_/aYemPuEKcUbeW9=fTOoru3b--
