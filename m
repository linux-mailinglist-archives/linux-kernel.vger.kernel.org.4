Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41909740A90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjF1IHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:07:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:40343 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjF1ICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:02:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QrT8T08MRz4wZy;
        Wed, 28 Jun 2023 14:27:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687926473;
        bh=rdxUwaUb6xNkehcBGxAzE5Yj+ywE81j0+CtZx7UWPSc=;
        h=Date:From:To:Cc:Subject:From;
        b=LqR+M9bDCW3gYipEeSoiP/Xg8JX08kKibXvYSE6i4K69OZgPAWRDWyXPLSrDfOmuW
         ZQBNLQ4wL/8EgmbBFbHAxfpjF2GNKvqiORJurtKIA10D5OYFX1PhkqgCVmcwvWmrQ7
         q/rn6YuxyUyfvqMA0WTh0FEMdX2n3nPjF3R+KUV9KWi/XsL6aXBrC/T+McJn7gNa1/
         uFBq02kScBleMm9/xAt4AvJ7RHU+UUmLA0I0fHolHbdJrFhLD1fAwETP/YlC5X2iae
         VRpAYTqk+CzNOqc/BZNiQ0TVDDXx+vsPFQFZR27kfR+ILudf2ScOr20IdtbdCA5fBw
         vtMwlE0DJ17qg==
Date:   Wed, 28 Jun 2023 14:27:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 28
Message-ID: <20230628142751.0527c993@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j3WpnQUtP5NY5I1HO2b9zHx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j3WpnQUtP5NY5I1HO2b9zHx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do *not* add any v5.6 related stuff to your linux-next included
branches until after v5.5-rc1 has been released.

Changes since 20230627:

The parisc-hd tree gained a conflict against the mm-nonmm-stable tree.

The net-next tree lost its its build failure.

The bluetooth tree still had its build failure for which I reverted a commi=
t.

The crypto tree lost its boot failure.

Non-merge commits (relative to Linus' tree): 10068
 12546 files changed, 469858 insertions(+), 145529 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There is also the merge.log file in the Next
directory.  Between each merge, the tree was built with a ppc64_defconfig
for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
and a native build of tools/perf. After the final fixups (if any), I do
an x86_64 modules_install followed by builds for x86_64 allnoconfig,
powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
defconfig and htmldocs. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 363 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (18eb3b6dff00 Merge tag 'for-linus-6.5-rc1-tag' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/xen/tip)
Merging fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging mm-hotfixes/mm-hotfixes-unstable (9c54505463c1 mm-shmem-fix-race-in=
-shmem_undo_range-w-thp-fix)
Merging kbuild-current/fixes (f1fcbaa18b28 Linux 6.4-rc2)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (0e2aba694866 arm64: mm: pass original f=
ault address to handle_mm_fault() in PER_VMA_LOCK block)
Merging arm-soc-fixes/arm/fixes (5b017b5ed2bc Merge tag 'v6.4-rockchip-dtsf=
ixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchi=
p into arm/fixes)
Merging davinci-current/davinci/for-current (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (4055eabe04a2 m68k: defconfig: Update defcon=
figs for v6.4-rc1)
Merging powerpc-fixes/fixes (6995e2de6891 Linux 6.4)
Merging s390-fixes/fixes (ad3d770b83af s390/defconfigs: set CONFIG_NET_TC_S=
KB_EXT=3Dy)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (3674fbf0451d Merge git://git.kernel.org/pub/scm/linux/ker=
nel/git/netdev/net)
CONFLICT (content): Merge conflict in fs/splice.c
Merging bpf/master (6709d4b7bc2e net: nfc: Fix use-after-free caused by nfc=
_llcp_find_local)
Merging ipsec/master (f015b900bc32 xfrm: Linearize the skb after offloading=
 if needed.)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (6709d4b7bc2e net: nfc: Fix use-after-free caused by nfc_=
llcp_find_local)
Merging wireless/for-next (f1a0898b5d6a wifi: iwlwifi: mvm: spin_lock_bh() =
to fix lockdep regression)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (45a3e24f65e9 Linux 6.4-rc7)
Merging sound-current/for-linus (d6048fdc8702 Merge tag 'asoc-v6.5' of http=
s://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging sound-asoc-fixes/for-linus (d900d9a435ca ASoC: tegra: Fix SFC conve=
rsion for few rates)
Merging regmap-fixes/for-linus (c8e796895e23 regmap: spi-avmm: Fix regmap_b=
us max_raw_write)
Merging regulator-fixes/for-linus (b9e6bee2bcb1 regulator: da9063: fix null=
 pointer deref with partial DT config)
Merging spi-fixes/for-linus (1527b076ae2c spi: zynqmp-gqspi: fix clock imba=
lance on probe failure)
Merging pci-current/for-linus (ac9a78681b92 Linux 6.4-rc1)
Merging driver-core.current/driver-core-linus (9561de3a55be Linux 6.4-rc5)
Merging tty.current/tty-linus (45a3e24f65e9 Linux 6.4-rc7)
Merging usb.current/usb-linus (45a3e24f65e9 Linux 6.4-rc7)
Merging usb-serial-fixes/usb-linus (45a3e24f65e9 Linux 6.4-rc7)
Merging phy/fixes (9561de3a55be Linux 6.4-rc5)
Merging staging.current/staging-linus (b3dad076a058 staging: octeon: delete=
 my name from TODO contact)
Merging iio-fixes/fixes-togreg (c57fa0037024 meson saradc: fix clock divide=
r mask length)
Merging counter-current/counter-current (9b53a1342216 counter: Fix menuconf=
ig "Counter support" submenu entries disappearance)
Merging char-misc.current/char-misc-linus (9561de3a55be Linux 6.4-rc5)
Merging soundwire-fixes/fixes (858fd168a95c Linux 6.4-rc6)
Merging thunderbolt-fixes/fixes (45a3e24f65e9 Linux 6.4-rc7)
Merging input-current/for-linus (bf4ed21778f2 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (6ab39f99927e crypto: x86/aria - Use 16 byte =
alignment for GFNI constant vectors)
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (dbcf76390eb9 selftests/ftrace: Improve integ=
ration with kselftest runner)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (e14fd2af7a1d dmaengine: at_hdmac: Extend the=
 Flow Controller bitfield to three bits)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c4d28e30a8d0 mtd: rawnand: marvell: don't set =
the NAND frequency select)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (ec21a38df77a Revert "media: dvb-core: Fix use-=
after-free on race condition at dvb_frontend")
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (4897a898a216 mips: Move initrd_start check a=
fter initrd address sanitisation.)
Merging at91-fixes/at91-fixes (6b0db163ff92 ARM: dts: at91: sama7g5ek: fix =
debounce delay property for shdwc)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (2623b3dc875a Merge tag 'kvmarm-fixes-6.4-4' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (b153a0bb4199 hwmon: (pmbus/adm1275) Fix problems=
 with temperature monitoring on ADM1272)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (a70fc4ed20a6 cxl/port: Fix NULL pointer access in =
devm_cxl_add_port())
Merging btrfs-fixes/next-fixes (4d0998044f33 Merge branch 'misc-6.4' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (146b6f6855e7 platform/x86/amd/pmf: Registe=
r notify handler only if SPS is enabled)
Merging samsung-krzk-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-samsung-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging devicetree-fixes/dt/linus (c7753ed71c16 dt-bindings: pinctrl: qcom,=
pmic-mpp: Fix schema for "qcom,paired")
Merging dt-krzk-fixes/fixes (8bbec86ce6d6 dt-bindings: PCI: fsl,imx6q: fix =
assigned-clocks warning)
Merging scsi-fixes/fixes (9cefd6e7e0a7 scsi: lpfc: Fix incorrect big endian=
 type assignment in bsg loopback path)
Merging drm-fixes/drm-fixes (9bd9be5cbaf8 Merge tag 'drm-misc-fixes-2023-06=
-21' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (7c457259721f drm/i915/psr: Fi=
x BDW PSR AUX CH data register offsets)
Merging mmc-fixes/fixes (413db4997302 mmc: usdhi60rol0: fix deferred probin=
g)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (44c026a73be8 Linux 6.4-rc3)
Merging hyperv-fixes/hyperv-fixes (067d6ec7ed5b PCI: hv: Add a per-bus mute=
x state_lock)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (b104dbedbe61 Documentation: RISC-V: patch-accep=
tance: mention patchwork's role)
Merging riscv-dt-fixes/riscv-dt-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (a7a041f2ddf3 soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (44c026a73be8 Linux 6.4-rc3)
Merging spdx/spdx-linus (45a3e24f65e9 Linux 6.4-rc7)
Merging gpio-brgl-fixes/gpio/for-current (ff7a1790fbf9 gpiolib: Fix irq_dom=
ain resource tracking for gpiochip_irqchip_add_domain())
Merging gpio-intel-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-intel-fixes/fixes (7877cb91f108 Linux 6.4-rc4)
Merging erofs-fixes/fixes (7877cb91f108 Linux 6.4-rc4)
Merging kunit-fixes/kunit-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (d7dbed457c2e nfsd: Fix creation time seriali=
zation order)
Merging irqchip-fixes/irq/irqchip-fixes (91539341a3b6 irqchip/gic: Correctl=
y validate OF quirk descriptors)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (b6dad5178cea Merge tag 'nios2_fix_v6.4' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux)
Merging efi-fixes/urgent (36e4fc57fc16 efi: Bump stub image version for mac=
OS HVF compatibility)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (95339f40a8b6 power: supply: Fix logic checking=
 if system is running from battery)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (dbe245cdf518 iommufd: Call iopt_area_contig_d=
one() under the lock)
Merging rust-fixes/rust-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging v9fs-fixes/fixes/next (36896bc97c0e fs/9p: Fix a datatype used with=
 V9FS_DIRECT_IO)
Merging w1-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (a590f03d8de7 drm/ttm: Don't le=
ak a resource on swapout move error)
Merging mm-stable/mm-stable (acc72d59c750 mm/hugetlb: remove hugetlb_set_pa=
ge_subpool())
CONFLICT (content): Merge conflict in fs/btrfs/file.c
CONFLICT (content): Merge conflict in include/linux/mm.h
CONFLICT (content): Merge conflict in mm/gup.c
Merging mm-nonmm-stable/mm-nonmm-stable (4afc9a402aa3 kernel/time/posix-stu=
bs.c: remove duplicated include)
Merging mm/mm-everything (1e8d64bb8c96 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (2f5d532dc466 kbuild: respect GNU Make -w flag)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf-tools-next (ad5f604e186a perf test: Fix a compile error o=
n pe-file-parsing.c)
CONFLICT (content): Merge conflict in tools/perf/arch/x86/include/arch-test=
s.h
CONFLICT (content): Merge conflict in tools/perf/arch/x86/tests/arch-tests.c
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (0a2f6372a43f drm/nouveau: stop using is_swiot=
lb_active)
Merging asm-generic/master (3b1ddbb62e7e Merge tag 'virt-to-pfn-for-arch-v6=
.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integra=
tor into asm-generic)
CONFLICT (content): Merge conflict in fs/netfs/iterator.c
Applying: fix up for "Move netfs_extract_iter_to_sg() to lib/scatterlist.c"
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (1faf70485ea9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (abc17128c81a Merge branch 'for-next/feat_s1pie=
' into for-next/core)
Merging arm-perf/for-next/perf (dea0f4146f66 docs: perf: Fix warning from '=
make htmldocs' in hisi-pmu.rst)
Merging arm-soc/for-next (f4bf81ea0c9f soc: document merges)
Merging amlogic/for-next (057889cb4244 Merge branch 'v6.5/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
Merging aspeed/for-next (7d4f0b0df7c5 ARM: dts: aspeed-g6: Add UDMA node)
Merging at91/at91-next (20c5a7864675 Merge branch 'clk-microchip' into at91=
-next)
Merging broadcom/next (df928e5b5570 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory/for-next (6a66fb9ffe7b dt-bindings: memory-controlle=
rs: drop unneeded quotes)
Merging imx-mxs/for-next (89c016c82e46 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (703b10801b44 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (f581c395fcb8 Merge branches 'omap-for-v6.5/ti-sysc' =
and 'omap-for-v6.5/cleanup' into for-next)
Merging qcom/for-next (e62f7f072b12 Merge branches 'arm64-defconfig-for-6.5=
', 'arm64-fixes-for-6.4', 'arm64-fixes-for-6.5', 'clk-for-6.5', 'drivers-fi=
xes-for-6.4', 'drivers-for-6.5', 'dts-fixes-for-6.4' and 'dts-for-6.5' into=
 for-next)
Merging renesas/next (7762defcdaf0 Merge branch 'renesas-drivers-for-v6.5' =
into renesas-next)
Merging reset/reset/next (afb39e2bd36a reset: mpfs: select AUXILIARY_BUS)
Merging rockchip/for-next (dd738a0f90f7 Merge branch 'v6.5-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (878094dcccc3 Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (83ff850e73ba Merge tag 'scmi-updates-6.5' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (c9cb7e72e293 MAINTAINERS: add entry for ARM/STM32=
 ARCHITECTURE)
Merging sunxi/sunxi/for-next (1bcb932283c9 Merge branch 'sunxi/dt-for-6.5' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (3281fba16642 Merge branch for-6.5/arm64/dt into for=
-next)
Merging ti/ti-next (b0f8e128b3b4 Merge branch 'ti-k3-config-next' into ti-n=
ext)
Merging xilinx/for-next (a736607599a5 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (b21154256dbf dt-bindings: mfd: ti,j721e-system-contro=
ller: Remove syscon from example)
Merging clk-imx/for-next (878b02d5f3b5 clk: imx: clk-imx8mp: improve error =
handling in imx8mp_clocks_probe())
Merging clk-renesas/renesas-clk (7df8eea64a41 clk: renesas: rzg2l: Convert =
to readl_poll_timeout_atomic())
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (dd64621a2a97 csky: uprobes: Restore thread.trap_no)
Merging loongarch/loongarch-next (1048493d7aa2 LoongArch: Remove five DIE_*=
 definitions in kdebug.h)
Merging m68k/for-next (4055eabe04a2 m68k: defconfig: Update defconfigs for =
v6.4-rc1)
Merging m68knommu/for-next (858fd168a95c Linux 6.4-rc6)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (e47084e116fc MIPS: Loongson64: DTS: Add RTC support=
 to Loongson-2K1000)
Merging openrisc/for-next (c91b4a07655d openrisc: Add floating point regset)
Merging parisc-hd/for-next (8362d0b61b09 parisc: Mark image_size __maybe_un=
used in perf.c)
CONFLICT (content): Merge conflict in arch/parisc/kernel/smp.c
Merging powerpc/next (54a11654de16 powerpc: remove checks for binutils olde=
r than 2.25)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (488833ccdcac Merge patch series "dt-bindings: risc=
v: cpus: switch to unevaluatedProperties: false")
CONFLICT (content): Merge conflict in MAINTAINERS
Merging riscv-dt/riscv-dt-for-next (273235194e4d RISC-V: make ARCH_THEAD pr=
eclude XIP_KERNEL)
Merging riscv-soc/riscv-soc-for-next (ac9a78681b92 Linux 6.4-rc1)
Merging s390/for-next (192e2d6e04d0 Merge branch 'features' into for-next)
Merging sh/for-next (a8ac2961148e sh: Avoid using IRQ0 on SH3 and SH4)
Merging uml/next (6032aca0deb9 um: make stub data pages size tweakable)
Merging xtensa/xtensa-for-next (f7667ca106df xtensa: dump userspace code ar=
ound the exception PC)
Merging pidfd/for-next (757777eef55b pid: Replace struct pid 1-element arra=
y with flex-array)
Merging fscrypt/for-next (d617ef039fb8 fscrypt: Replace 1-element array wit=
h flexible array)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (20e0c0a8e8ef Merge branch 'for-next-next-v6.4-20230=
621' into for-next-20230621)
Merging ceph/master (3a8a2b8a0029 ceph: don't let check_caps skip sending r=
esponses for revoke msgs)
Merging cifs/for-next (ec6bed0d31f6 cifs: print client_guid in DebugData)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (8241fdd3cdfe erofs: clean up zmap.c)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (b6075c721ab4 Pull UDF uninit var access fix.)
Merging ext4/dev (2ef6c32a914b ext4: avoid updating the superblock on a r/o=
 mount if not needed)
CONFLICT (content): Merge conflict in fs/ext4/ioctl.c
CONFLICT (content): Merge conflict in fs/ext4/super.c
Merging f2fs/dev (6770410fe962 f2fs: remove i_xattr_sem to avoid deadlock a=
nd fix the original issue)
Merging fsverity/for-next (672d6ef4c775 fsverity: improve documentation for=
 builtin signature support)
Merging fuse/for-next (6a567e920fd0 fuse: ioctl: translate ENOSYS in outarg)
Merging gfs2/for-next (1e5c9f08374b gfs2: Use memcpy_{from,to}_page where a=
ppropriate)
Merging jfs/jfs-next (95e2b352c03b FS: JFS: Check for read-only mounted fil=
esystem in txBegin)
Merging ksmbd/ksmbd-for-next (09301a2df187 ksmbd: avoid field overflow warn=
ing)
Merging nfs/linux-next (cded49ba3662 nfs: don't report STATX_BTIME in ->get=
attr)
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (6995e2de6891 Linux 6.4)
Merging ntfs3/master (1f60ec888102 fs/ntfs3: Add support /proc/fs/ntfs3/<de=
v>/volinfo and /proc/fs/ntfs3/<dev>/label)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (62149a745eee ovl: add Amir as co-maintain=
er)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging xfs/for-next (c3b880acadc9 xfs: fix ag count overflow during growfs)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (3fd41721cd5c iomap: Add DIO tracepoints)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (0d6aeec73f8c selftests: add OFD lock tests)
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (ed3195f557c3 Merge branches 'vfs.misc', 'v6.5/=
vfs.mount', 'fs.ntfs', 'vfs.rename.locking' and 'vfs.backing.file' into vfs=
.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (16bff6f075a1 Merge branch 'for-6.4' into for-next)
Merging pci/next (6ecac465eee8 Merge branch 'pci/controller/remove-void-cal=
lbacks')
CONFLICT (content): Merge conflict in include/linux/pci_ids.h
Merging pstore/for-next/pstore (d97038d5ec20 pstore/ram: Add check for kstr=
dup)
Merging hid/for-next (2a4b950dc6f0 Merge branch 'for-6.5/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (e67e24a52c72 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (49b472ebc61d i3c: master: svc: add NACK check after s=
tart byte sent)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (4dbbaf8fbdbd hwmon: (oxp-sensors) Add sup=
port for AOKZOE A1 PRO)
Merging jc_docs/docs-next (caec546cf65c Merge branch 'arch-arm64-rb' into d=
ocs-next)
CONFLICT (file location): Documentation/arm64/kdump.rst added in HEAD insid=
e a directory that was renamed in jc_docs/docs-next, suggesting it should p=
erhaps be moved to Documentation/arch/arm64/kdump.rst.
CONFLICT (file location): Documentation/arm64/ptdump.rst added in HEAD insi=
de a directory that was renamed in jc_docs/docs-next, suggesting it should =
perhaps be moved to Documentation/arch/arm64/ptdump.rst.
Merging v4l-dvb/master (be9aac187433 Merge tag 'v6.4-rc5' into media_stage)
Merging v4l-dvb-next/master (57713028261e Merge tag 'br-v6.5h' of git://lin=
uxtv.org/hverkuil/media_tree into media_stage)
Merging pm/linux-next (1d70c4c81b35 Merge branch 'pm-opp' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (5ee64250286e cpufreq: qcom-cpuf=
req-hw: Use dev_err_probe() when failing to get icc paths)
Merging cpupower/cpupower (25891bc945f7 cpupower: Bump soname version)
Merging devfreq/devfreq-next (a83bfdca8b20 PM / devfreq: mtk-cci: Fix varia=
ble deferencing before NULL check)
Merging opp/opp/linux-next (5fb2864cbd50 OPP: Properly propagate error alon=
g when failing to get icc_path)
Merging thermal/thermal/linux-next (57c9eaa4de53 thermal/drivers/qcom/temp-=
alarm: Use dev_err_probe)
Merging dlm/next (fc4ea4229c2b fs: dlm: remove filter local comms on close)
Merging rdma/for-next (5f004bcaee4c Merge tag 'v6.4' into rdma.git for-next)
Merging net-next/main (ae230642190a Merge branch 'af_unix-followup-fixes-fo=
r-so_passpidfd')
Merging bpf-next/for-next (771ca3de2502 Merge branch 'sfc-next')
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (a412dbf40ff3 netfilter: nf_tables: limit allowed ra=
nge via nla_policy)
Merging bluetooth/master (e63d8ed98082 Bluetooth: msft: Extended monitor tr=
acking by address filter)
Applying: Revert "Bluetooth: hci_sock: Forward credentials to monitor"
Merging wireless-next/for-next (31b5a547622b wifi: ieee80211: fix erroneous=
 NSTR bitmap size checks)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (cf431a599832 Merge branch 'nand/next' into mtd/next)
Merging nand/nand/next (ad5c18c75d2a dt-bindings: mtd: marvell-nand: Conver=
t to YAML DT scheme)
Merging spi-nor/spi-nor/next (df6def86b9dc mtd: spi-nor: spansion: Add supp=
ort for s25hl02gt and s25hs02gt)
Merging crypto/master (486bfb05913a crypto: akcipher - Do not copy dst if i=
t is NULL)
CONFLICT (content): Merge conflict in crypto/asymmetric_keys/public_key.c
Merging drm/drm-next (2222dcb0775d Merge tag 'drm-msm-next-2023-06-18' of h=
ttps://gitlab.freedesktop.org/drm/msm into drm-next)
CONFLICT (content): Merge conflict in include/drm/gpu_scheduler.h
Merging drm-misc/for-linux-next (cf683e8870bd fbdev: Use /* */ comment in i=
nitializer macro)
Merging amdgpu/drm-next (5694c7dd1075 drm/amd/pm: Add GFX v9.4.3 unique id =
to sysfs)
Merging drm-intel/for-linux-next (5b7826355e5b drm/i915: Add missing forwar=
d declarations/includes to display power headers)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (cd036d542afb drm/msm/a6xx: Add A610 speedbin supp=
ort)
Merging drm-msm-lumag/msm-next-lumag (452c46ccf603 drm/msm/dsi: split dsi_c=
trl_config() function)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (295b6c02f84b drm/etnaviv: slow down FE idle p=
olling)
Merging fbdev/for-next (c2d22806aecb fbdev: fix potential OOB read in fast_=
imageblit())
CONFLICT (content): Merge conflict in drivers/video/fbdev/hitfb.c
Merging regmap/for-next (1e897fca0b3b Merge remote-tracking branch 'regmap/=
for-6.5' into regmap-next)
Merging sound/for-next (d6048fdc8702 Merge tag 'asoc-v6.5' of https://git.k=
ernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging ieee1394/for-next (3ff256751a28 firewire: net: fix use after free i=
n fwnet_finish_incoming_packet())
Merging sound-asoc/for-next (f37f8a15168a Merge remote-tracking branch 'aso=
c/for-6.5' into asoc-next)
Merging modules/modules-next (0eeaf1eb40a3 kallsyms: make kallsyms_show_val=
ue() as generic function)
Merging input/next (8c9cce9cb81b Input: pm8941-powerkey - fix debounce on g=
en2+ PMICs)
Merging block/for-next (3261ea42710e Merge branch 'for-6.5/block-late' into=
 for-next)
Merging device-mapper/for-next (95b7527be4b6 dm: verity-loadpin: Add NULL p=
ointer check for 'bdev' parameter)
CONFLICT (content): Merge conflict in drivers/md/dm-thin-metadata.c
Merging libata/for-next (fd3ac6e80497 dt-bindings: phy: rockchip: rk3588 ha=
s two reset lines)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (06b5d4fea89c dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul =
support)
Merging mfd/for-mfd-next (a6b6790c020a mfd: Switch two more drivers back to=
 use struct i2c_driver::probe)
Merging backlight/for-backlight-next (c1ff7da03e16 video: backlight: lp855x=
: Get PWM for PWM mode during probe)
Merging battery/for-next (ef8d95b4a3af MAINTAINERS: add documentation file =
for Microchip SAMA5D2 shutdown controller)
Merging regulator/for-next (e68a81cec046 Merge remote-tracking branch 'regu=
lator/for-6.5' into regulator-next)
Merging security/next (4be22f16a4a1 device_cgroup: Fix kernel-doc warnings =
in device_cgroup)
Merging apparmor/apparmor-next (97a79eea1797 apparmor: Fix kernel-doc heade=
r for verify_dfa_accept_index)
Merging integrity/next-integrity (95526d13038c ima: Fix build warnings)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (447a5688005e selinux: avoid bool as identifier name)
CONFLICT (content): Merge conflict in security/selinux/Makefile
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (e52fa5e9fbe1 workqueue: Warn attempt to flush system=
-wide workqueues.)
Merging tpmdd/next (bcd6987b87b1 tpm: Switch i2c drivers back to use .probe=
())
Merging watchdog/master (547cc9be86f4 Merge tag 'perf_urgent_for_v6.4' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging iommu/next (a7a334076dd7 Merge branches 'iommu/fixes', 'arm/smmu', =
'ppc/pamu', 'virtio', 'x86/vt-d', 'core' and 'x86/amd' into next)
Merging audit/next (e455ca40dbcf audit: avoid missing-prototype warnings)
Merging devicetree/for-next (ecdb004843ed dt-bindings: interrupt-controller=
: add Ralink SoCs interrupt controller)
Merging dt-krzk/for-next (0ff3c07556e6 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (8fe72b76db79 mailbox: mailbox-test: fix a=
 locking issue in mbox_test_message_write())
Merging spi/for-next (8fed873e8921 Merge remote-tracking branch 'spi/for-6.=
5' into spi-next)
Merging tip/master (5bfdb24bed4c Merge branch into tip/master: 'x86/sgx')
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in include/linux/syscalls.h
CONFLICT (content): Merge conflict in mm/gup.c
CONFLICT (content): Merge conflict in mm/migrate.c
Applying: perf test amd: Fix build failure with amd-ibs-via-core-pmu.c
Applying: fix up for "init: consolidate prototypes in linux/init.h"
Merging clockevents/timers/drivers/next (8b5bf64c89c7 clocksource/drivers/c=
adence-ttc: Fix memory leak in ttc_timer_probe)
Merging edac/edac-for-next (852667c317ae Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (a82f3119d543 Merge branch irq/misc-6.5 in=
to irq/irqchip-next)
Merging ftrace/for-next (61c692f56fec Merge tools/for-next)
Merging rcu/rcu/next (c70bbbbdf3a6 rcutorture: Remove obsolete BOOTPARAM_HO=
TPLUG_CPU0 Kconfig option)
Merging kvm/next (39428f6ea9ea Merge tag 'kvmarm-fixes-6.4-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvm-arm/next (192df2aa0113 KVM: arm64: Fix misuse of KVM_ARM_VCPU_P=
OWER_OFF bit index)
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Merging kvms390/next (db54dfc9f71c s390/uv: Update query for secret-UVCs)
Merging kvm-riscv/riscv_kvm_next (07f225b58424 RISC-V: KVM: Remove unneeded=
 semicolon)
CONFLICT (content): Merge conflict in arch/riscv/include/uapi/asm/kvm.h
Merging kvm-x86/next (88bb466c9dec Merge branches 'generic', 'misc', 'mmu',=
 'selftests', 'svm', 'vmx' and 'pmu')
CONFLICT (content): Merge conflict in Documentation/process/maintainer-hand=
books.rst
Merging xen-tip/linux-next (fb9b7b4b2b82 x86: xen: add missing prototypes)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (ee360b1c5001 Merge branch 'for-6.5-cleanup-ord=
ered' into for-next)
CONFLICT (content): Merge conflict in include/linux/workqueue.h
Merging drivers-x86/for-next (d2a7bd369099 platform/x86:intel/pmc: Add Mete=
or Lake IOE-M PMC related maps)
Merging chrome-platform/for-next (2b8cc5858a07 platform/chrome: cros_ec_spi=
: Use %*ph for printing hexdump of a small buffer)
Merging hsi/for-next (42877c38ac78 HSI: omap_ssi_port: Drop error checking =
for debugfs_create_dir)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (7bd932d9adbc leds: sgm3140: Add richtek,rt50=
33-led compatible)
Merging ipmi/for-next (e87443a5f68d ipmi: Change request_module to request_=
module_nowait)
Merging driver-core/driver-core-next (a91845b9a872 sysfs: Skip empty folder=
s creation)
Merging usb/usb-next (18af4b5c9791 usb: host: xhci-plat: Set XHCI_STATE_REM=
OVING before resuming XHCI HC)
Merging thunderbolt/next (481012b479fe thunderbolt: Add test case for 3 Dis=
playPort tunnels)
Merging usb-serial/usb-next (ffa5f7a3bf28 USB: serial: option: add LARA-R6 =
01B PIDs)
Merging tty/tty-next (e534755c9412 tty_audit: make data of tty_audit_log() =
const)
Merging char-misc/char-misc-next (adfdaf81f9d4 bsr: fix build problem with =
bsr_class static cleanup)
Merging accel/habanalabs-next (e6f49e96bc57 accel/habanalabs: refactor erro=
r info reset)
Merging coresight/next (6c50384ef8b9 hwtracing: hisi_ptt: Fix potential sle=
ep in atomic context)
Merging fastrpc/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging fpga/for-next (47147d56f92e fpga: zynq-fpga: Ensure proper xCAP int=
erface switch)
Merging icc/icc-next (1400725e4515 Merge branch 'icc-qos' into icc-next)
Merging iio/togreg (9e66fb524495 samples: Add userspace example for TI TPS6=
594 PFSM)
Merging phy-next/next (a454850a815e dt-bindings: phy: brcm,brcmstb-usb-phy:=
 Fix error in "compatible" conditional schema)
Merging soundwire/next (a4857d1afdd1 soundwire: stream: Make master_list or=
dered to prevent deadlocks)
Merging extcon/extcon-next (94da3da96c35 dt-bindings: extcon: wlf,arizona: =
drop unneeded quotes)
Merging gnss/gnss-next (44c026a73be8 Linux 6.4-rc3)
Merging vfio/next (ff598081e5b9 vfio/mdev: Move the compat_class initializa=
tion to module init)
Merging w1/for-next (b332af5398a3 w1: Replace usage of found with dedicated=
 list iterator variable)
Merging staging/staging-next (4a22870cede3 staging: rtl8192e: Remove whites=
pace and blank lines)
Merging counter-next/counter-next (9b53a1342216 counter: Fix menuconfig "Co=
unter support" submenu entries disappearance)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (907514a7dc4c dmaengine: sprd: Don't set chancnt)
Merging cgroup/for-next (fd99fa7cff4d Merge branch 'for-6.5' into for-next)
Merging scsi/for-next (95c5539096a3 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/nvme/host/Makefile
Merging scsi-mkp/for-next (6f0a92fd7db1 scsi: smartpqi: Replace one-element=
 arrays with flexible-array members)
Merging vhost/linux-next (7845945bbedd virtio_net: support dma premapped)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (81aceef4b71d Merge branches 'hwspinlock-next' and '=
rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (0ff9f5e57c5b of: unittest: drop assertions=
 for GPIO hog messages)
Merging gpio-intel/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl/for-next (9f0648f13e34 Merge tag 'intel-pinctrl-v6.5-1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel)
Merging pinctrl-intel/for-next (9314d0530276 pinctrl: cherryview: Drop goto=
 label)
Merging pinctrl-renesas/renesas-pinctrl (5d32cead772c pinctrl: renesas: Fix=
 spaces followed by tabs)
Merging pinctrl-samsung/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pwm/for-next (92554cdd428f dt-bindings: pwm: convert pwm-bcm2835 bi=
ndings to YAML)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (8cd0d8633e2d selftests/ftace: Fix KTAP output order=
ing)
Merging kunit/test (ac9a78681b92 Linux 6.4-rc1)
Merging kunit-next/kunit (2e66833579ed MAINTAINERS: Add source tree entry f=
or kunit)
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (1b733a9ebc3d rtc: Add rtc driver for the Loongson fam=
ily chips)
Merging nvdimm/libnvdimm-for-next (1ea7ca1b0901 dax: enable dax fault handl=
er to report VM_FAULT_HWPOISON)
Merging at24/at24/for-next (a3c10035d12f eeprom: at24: Use dev_err_probe fo=
r nvmem register failure)
Merging ntb/ntb-next (942cc9ceccb6 ntb: intel: Remove redundant pci_clear_m=
aster)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging nvmem/for-next (ac1c0d15aedc nvmem: core: add support for fixed cel=
ls *layout*)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (a494aef23dfc PCI: hv: Replace retarget_msi_inte=
rrupt_params with hyperv_pcpu_input_arg)
Merging auxdisplay/auxdisplay (def85dce1451 auxdisplay: Switch i2c drivers =
back to use .probe())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (ac9a78681b92 Linux 6.4-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (6bb6aba2f57a bus: mhi: host: pci_generic: Add support=
 for Quectel EM160R-GL modem)
Merging memblock/for-next (de649e7f5edb memblock: Update nid info in memblo=
ck debugfs)
Merging cxl/next (71baec7b8500 cxl/pci: Use correct flag for sanitize polli=
ng)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (2e28a798c309 efi/libstub: Disable PCI DMA before grabbing=
 the EFI memory map)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (7bc162d5cc4d Merge branches 'slab/for-6.5/prandom', =
'slab/for-6.5/slab_no_merge' and 'slab/for-6.5/slab-deprecate' into slab/fo=
r-next)
CONFLICT (content): Merge conflict in arch/mips/configs/ci20_defconfig
CONFLICT (content): Merge conflict in mm/slab_common.c
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (35ca42399297 selftests/landlock: Add hostfs tests)
CONFLICT (content): Merge conflict in arch/um/Kconfig
Merging rust/rust-next (d2e3115d7171 rust: error: `impl Debug` for `Error` =
with `errname()` integration)
Merging sysctl/sysctl-next (2f2665c13af4 sysctl: replace child with an enum=
eration)
Merging execve/for-next/execve (aa88054b7090 binfmt_elf: fix comment typo s=
/reset/regset/)
Merging bitmap/bitmap-for-next (2a3110e3f97d MAINTAINERS: Add bitfield.h to=
 the BITMAP API record)
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (acf15e07eb06 netfilter: ipset: Replace strlcpy =
with strscpy)
Merging kspp-gustavo/for-next/kspp (1fa89cccd288 media: venus: hfi_cmds: Re=
place fake flex-arrays with flexible-array members)
Merging iommufd/for-next (f1fcbaa18b28 Linux 6.4-rc2)

--Sig_/j3WpnQUtP5NY5I1HO2b9zHx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSbtscACgkQAVBC80lX
0Gw5CQf+MQCPFb0QW8ecIukvapa+GnT9El16vtUpcvVumUt3M9DwFTU1RAavPNmt
ZivBTozpGsPshy+OjziT7fzZlqo22xFByAUgAE/rsP8M8ijP1m4k+peec0NDZrQh
AwBK8NGc3BmBepXLO6SIHXtuSG3fMdmJbCVBpKpRNS/4boubtoEUaWLV3cPhHesm
k36+HZPwE83EnbZZLItDC2CXoN+yJ3GK4oRilWvyZclwHAlBmVvh0hhjAK+LLY3h
92tL1UrUhwoTHmLW967MPW5PPo8H5+wGISHyY7nAXDM4sUm2P4+GGsitJCYMf01l
iHpsoyYUDzL9ZWHj7TTzWdahn0F31Q==
=/WsP
-----END PGP SIGNATURE-----

--Sig_/j3WpnQUtP5NY5I1HO2b9zHx--
