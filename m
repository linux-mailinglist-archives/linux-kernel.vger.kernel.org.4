Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29762B382
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiKPGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKPGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:52:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46067286E3;
        Tue, 15 Nov 2022 22:52:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBty64d1xz4xZh;
        Wed, 16 Nov 2022 17:51:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668581518;
        bh=qDhdyW8MnECjVtY4ngev+nIhLFtOp8yRCdzjX/XQq3A=;
        h=Date:From:To:Cc:Subject:From;
        b=gPE5FODkFglmgswTcdcQDUQ7gdRzr2a703SNZYYZj92rJZe+vrSNuIyNo7c6QySiJ
         7SRPuz+HIwyJHBHsC04nl58ZESPjRz+2K+azL63z5I0Cg0Ns+sG2y7C/pgXnx7gqgi
         3OSBDVEdFrzPDL1/wS/zOkNdacRZGVr0QL4AQsD5zWmR7yfFvhjZY80Y7TyIwClKNc
         4LotJozYMv1XkTmg+Skz+eUIrVsrdqeqs1QDDoLHuElpQGJQBesv1uvfU9c5J4U4H8
         PkTWpNa5JrE9r/aKyub4R1gQlDzyzo8sEfii+NVL3e/XuiKpeM1ymlwY3qDDOytq18
         /JJcsvYmYzLLQ==
Date:   Wed, 16 Nov 2022 17:51:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 16
Message-ID: <20221116175156.1a642e1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G/D+zLaP.Rv4=I=be4hXTAC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G/D+zLaP.Rv4=I=be4hXTAC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221115:

The arm64 tree gained a build failure so I used the version from
next-20221115.

The net-next tree gained a build failure for which I reverted a commmit.

The bpf-next tree gained a conflict against the net tree.

The drm-misc tree gained conflicts against Linus' tree and the
drm-misc-fixes tree.  It also gained a build failure so I used the version
from next-20221115.

The amdgpu tree gained a conflict against the drm-misc tree.

The block tree gained a build failure so I used the version from
next-20221115.

The modules tree lost its difficult semantic conflict against the
net-next tree.

The kvms390 tree gained a conflict against the kvm-arm tree.

The pinctrl tree gained a build failure so I used the version from
next-20221114.

Non-merge commits (relative to Linus' tree): 7494
 7539 files changed, 352622 insertions(+), 142153 deletions(-)

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

I am currently merging 367 trees (counting Linus' and 102 trees of bug
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
Merging origin/master (81e7cfa3a9eb Merge tag 'erofs-for-6.1-rc6-fixes' of =
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (fb99dcaa3634 hugetlb: don't delet=
e vma_lock in hugetlb MADV_DONTNEED processing)
Merging kbuild-current/fixes (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (340a982825f7 ARM: 9266/1: mm: fix no-MMU ZERO_PA=
GE() implementation)
Merging arm64-fixes/for-next/fixes (2598ac6ec493 arm64: ftrace: Define ftra=
ce_stub_graph only with FUNCTION_GRAPH_TRACER)
Merging arm-soc-fixes/arm/fixes (6827df0911c3 MAINTAINERS: repair Microchip=
 corei2c driver entry)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging davinci-current/davinci/for-current (9abf2313adc1 Linux 6.1-rc1)
Merging drivers-memory-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED =
as BI_RNG_SEED)
Merging powerpc-fixes/fixes (02a771c9a68a powerpc/32: Select ARCH_SPLIT_ARG=
64)
Merging s390-fixes/fixes (30d17fac6aae scripts/min-tool-version.sh: raise m=
inimum clang version to 15.0.0 for s390)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (9d45921ee4cb bridge: switchdev: Fix memory leaks when c=
hanging VLAN protocol)
Merging bpf/master (47df8a2f78bc bpf, perf: Use subprog name when reporting=
 subprog ksymbol)
Merging ipsec/master (7f57f8165cb6 af_key: Fix send_acquire race with pfkey=
_register)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (91018bbcc664 Merge tag 'wireless-2022-11-03' of =
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless)
Merging rdma-fixes/for-rc (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging sound-current/for-linus (1abfd71ee8f3 ALSA: hda/realtek: Fix the sp=
eaker output on Samsung Galaxy Book Pro 360)
Merging sound-asoc-fixes/for-linus (39bd801d6908 ASoC: soc-pcm: Don't zero =
TDM masks in __soc_pcm_open())
Merging regmap-fixes/for-linus (84498d1fb35d regmap-irq: Use the new num_co=
nfig_regs property in regmap_add_irq_chip_fwnode)
Merging regulator-fixes/for-linus (d246d88b8d9d Merge remote-tracking branc=
h 'regulator/for-6.0' into regulator-linus)
Merging spi-fixes/for-linus (6c59b26fdeb4 Merge remote-tracking branch 'spi=
/for-6.0' into spi-linus)
Merging pci-current/for-linus (39a654f39efb MAINTAINERS: Add Manivannan Sad=
hasivam as Qcom PCIe RC maintainer)
Merging driver-core.current/driver-core-linus (1edfe4ea16ca kernfs: Fix spu=
rious lockdep warning in kernfs_find_and_get_node_by_id())
Merging tty.current/tty-linus (3ec17cb325ac docs/driver-api/miscellaneous: =
Remove kernel-doc of serial_core.c)
Merging usb.current/usb-linus (181135bb20dc usb: add NO_LPM quirk for Realf=
orce 87U Keyboard)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (148f4b32b450 USB: serial: option: add F=
ibocom FM160 0x0111 composition)
Merging phy/fixes (819b885cd886 phy: ralink: mt7621-pci: add sentinel to qu=
irks table)
Merging staging.current/staging-linus (937ec9f7d5f2 staging: rtl8192e: remo=
ve bogus ssid character sign test)
Merging iio-fixes/fixes-togreg (398e3479874f dt-bindings: iio: adc: Remove =
the property "aspeed,trim-data-valid")
Merging counter-current/counter-current (30a0b95b1335 Linux 6.1-rc3)
Merging char-misc.current/char-misc-linus (65946690ed8d firmware: coreboot:=
 Register bus in module init)
Merging soundwire-fixes/fixes (49a467310dc4 soundwire: qcom: check for outa=
nding writes before doing a read)
Merging thunderbolt-fixes/fixes (094226ad94f4 Linux 6.1-rc5)
Merging input-current/for-linus (26c263bf1847 Input: i8042 - apply probe de=
fer to more ASUS ZenBook models)
Merging crypto-current/master (9f6035af06b5 crypto: x86/polyval - Fix crash=
es when keys are not 16-byte aligned)
Merging vfio-fixes/for-linus (e806e223621e vfio/pci: Check the device set o=
pen count on reset)
Merging kselftest-fixes/fixes (89c1017aac67 selftests/pidfd_test: Remove th=
e erroneous ',')
Merging modules-fixes/modules-linus (77d6354bd422 module/decompress: genera=
te sysfs string at compile time)
Merging dmaengine-fixes/fixes (c47e6403fa09 dmaengine: at_hdmac: Check retu=
rn code of dma_async_device_register)
Merging backlight-fixes/for-backlight-fixes (6dfad94814c7 dt-bindings: back=
light: qcom-wled: Add PMI8950 compatible)
Merging mtd-fixes/mtd/fixes (c717b9b7d6de mtd: onenand: omap2: add dependen=
cy on GPMC)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (de547896aac6 media: vivid.rst: loop_video is s=
et on the capture devnode)
Merging reset-fixes/reset/fixes (ae358d71d462 reset: npcm: fix iprst2 and i=
prst4 setting)
Merging mips-fixes/mips-fixes (094226ad94f4 Linux 6.1-rc5)
Merging at91-fixes/at91-fixes (cef8cdc0d0e7 ARM: at91: pm: avoid soft reset=
ting AC DLL)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (6d3085e4d89a KVM: x86/mmu: Block all page faults =
during kvm_zap_gfn_range())
Merging kvms390-fixes/master (b6662e377727 KVM: s390: pci: Fix allocation s=
ize of aift kzdev elements)
Merging hwmon-fixes/hwmon (d802a72b9bc1 hwmon: (i5500_temp) fix missing pci=
_disable_device())
Merging nvdimm-fixes/libnvdimm-fixes (b3bbcc5d1da1 Merge branch 'for-6.0/da=
x' into libnvdimm-fixes)
Merging cxl-fixes/fixes (8f401ec1c897 cxl/region: Recycle region ids)
Merging btrfs-fixes/next-fixes (46f159e1491a Merge branch 'misc-6.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (7ee47dcfff18 fs: use acquire ordering in __fget_li=
ght())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (d0ddc0c94bc2 platform/x86: ideapad-laptop:=
 Add module parameters to match DMI quirk tables)
Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging devicetree-fixes/dt/linus (917c362b5f8a MAINTAINERS: of: collapse o=
verlay entry into main device tree entry)
Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging scsi-fixes/fixes (ecb8c2580d37 scsi: scsi_debug: Make the READ CAPA=
CITY response compliant with ZBC)
Merging drm-fixes/drm-fixes (094226ad94f4 Linux 6.1-rc5)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (4f68332b2f89 drm/i915/ttm: fi=
x uaf with lmem_userfault_list handling)
Merging mmc-fixes/fixes (f002f45a00ee mmc: sdhci-esdhc-imx: use the correct=
 host caps for MMC_CAP_8_BIT_DATA)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
Merging gnss-fixes/gnss-linus (247f34f7b803 Linux 6.1-rc2)
Merging hyperv-fixes/hyperv-fixes (c234ba804292 PCI: hv: Only reuse existin=
g IRTE allocation for Multi-MSI)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (fcae44fd36d0 RISC-V: vdso: Do not add missing s=
ymbols to version section in linker script)
Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use a=
n mpfs specific l2 compatible)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging spdx/spdx-linus (6cad1ecd4e32 testing: use the copyleft-next-0.3.1 =
SPDX tag)
Merging gpio-brgl-fixes/gpio/for-current (30a0b95b1335 Linux 6.1-rc3)
Merging gpio-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging erofs-fixes/fixes (37020bbb71d9 erofs: fix missing xas_retry() in f=
scache mode)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (618887768bb7 kunit: update NULL vs IS_ERR(=
) tests)
Merging ubifs-fixes/fixes (c18a80c6861f jffs2: correct logic when creating =
a hole in jffs2_write_begin)
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (5a01c805441b NFSD: Fix trace_nfsd_fh_verify_err()=
 crasher)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (94d957ae513f perf tools: Add the include/=
perf/ directory to .gitignore)
Merging efi-fixes/urgent (9b9eaee9828f arm64: efi: Fix handling of misalign=
ed runtime regions and drop warning)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (767e684367e4 power: supply: ab8500: Defer ther=
mal zone probe)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (30a0b95b1335 Linux 6.1-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (0a3e0fb8cfee Revert "drm: hide=
 unregistered connectors from GETCONNECTOR IOCTL")
Merging kbuild/for-next (2df76606db9d Merge tag 'kbuild-fixes-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (20c8a5e317d1 perf stat: Add print_aggr_cgroup() for=
 --for-each-cgroup and --topdown)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (8d58aa484920 swiotlb: reduce the swiotlb buff=
er size on allocation failure)
Merging asm-generic/master (defbab270d45 include/uapi/linux/swab: Fix poten=
tially missing __always_inline)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (a893cdeb4f7c Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (4c021b15f46d Merge branch 'for-next/fixes' int=
o for-next/core)
$ git reset --hard HEAD^
Merging next-20221115 version of arm64
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (4af176ea7d85 soc: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (d0f68bca64e6 Merge branch 'v6.2/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (56fed763f6b2 arm64: dts: apple: Add A=
DMAC resets on t8103/t600x)
Merging aspeed/for-next (2e8e3a453fa4 ARM: dts: aspeed: Add Delta AHE-50DC =
BMC)
Merging at91/at91-next (4fb3808be768 Merge branch 'at91-defconfig' into at9=
1-next)
Merging broadcom/next (64610429f8de Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (53ad523ac435 ARM: davinci: fix repeated w=
ords in comments)
Merging drivers-memory/for-next (8dd7e4af5853 memory: omap-gpmc: fix coveri=
ty issue "Control flow issues")
Merging imx-mxs/for-next (f4a24e68cfe3 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (8886777f958a Merge branch 'v6.1-next/soc' into f=
or-next)
Merging mvebu/for-next (d5c48679d56c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (b610ba9a796a Merge branch 'omap-for-v6.2/dt' into fo=
r-next)
Merging qcom/for-next (4d2b529bce12 Merge branches 'arm64-defconfig-for-6.2=
', 'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2', 'drivers-for-6.2', =
'dts-for-6.2' and 'arm64-fixes-for-6.1' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (dff206d23462 Merge branch 'renesas-arm-dt-for-v6.2' i=
nto renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (a59b9360b072 Merge branch 'v6.2-clock/next' into=
 for-next)
Merging samsung-krzk/for-next (5a549e2d0bab Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (59f2f4b8a757 fs/userfaultfd: Fix maple tree it=
erator in userfaultfd_unregister())
Merging stm32/stm32-next (7ad436adc788 ARM: multi_v7_defconfig: enable Type=
-C UCSI and STM32G0 as modules)
Merging sunxi/sunxi/for-next (1c50050ca1eb arm64: dts: allwinner: a64: enab=
le Bluetooth on Pinebook)
Merging tee/next (bd52407221b4 optee: Add __init/__exit annotations to modu=
le init/exit funcs)
Merging tegra/for-next (48cec8916921 Merge branch for-6.2/arm64/defconfig i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging ti/ti-next (03041f3d1e54 Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (5eeec1fd8360 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging clk-renesas/renesas-clk (7506b57f33e9 clk: renesas: r8a779f0: Fix E=
thernet Switch clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (7e2004906fb5 Revert "csky: Add support for restart=
able sequence")
Merging loongarch/loongarch-next (247f34f7b803 Linux 6.1-rc2)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (094226ad94f4 Linux 6.1-rc5)
Merging microblaze/next (493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-fo=
r-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-nam=
espace)
Merging mips/mips-next (094226ad94f4 Linux 6.1-rc5)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (247f34f7b803 Linux 6.1-rc2)
Merging powerpc/next (247f34f7b803 Linux 6.1-rc2)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (be79afc740b5 riscv: Enable HAVE_ARCH_HUGE_VMALLOC =
for 64BIT)
Merging risc-v-mc/dt-for-next (83fd23ba1618 Merge remote-tracking branch 'k=
org-me/riscv-soc-for-next' into dt-for-next)
Merging s390/for-next (deb36b17a8fa Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/next (193cb8372424 uml: Remove the initialization of statics to=
 0)
Merging xtensa/xtensa-for-next (b8c4f4db2436 xtensa: update config files)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (c0192a847c96 Merge branch 'fs.acl.rework' i=
nto for-next)
Merging fscrypt/master (0e91fc1e0f5c fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (d9fdb1cf2db1 Merge branch 'for-next-next-v6.1-20221=
111' into for-next-20221111)
CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
Applying: btrfs: fix up for "fs: pass dentry to set acl method"
Merging ceph/master (5bd76b8de5b7 ceph: fix NULL pointer dereference for re=
q->r_session)
Merging cifs/for-next (9898f0456aa3 cifs: Fix wrong return value checking w=
hen GETFLAGS)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (312fe643ad11 erofs: clean up erofs_iget())
Merging exfat/dev (3d0cdf1b32dc exfat: hint the empty entry which at the en=
d of cluster chain)
Merging ext3/for_next (0327e0ff8296 Pull kerneldoc warning fix.)
Merging ext4/dev (0d043351e5ba ext4: fix fortify warning in fs/ext4/fast_co=
mmit.c:1551)
Merging f2fs/dev (967eaad1fed5 f2fs: fix to set flush_merge opt and show no=
flush_merge)
Merging fsverity/fsverity (276616fff35d fsverity: stop using PG_error to tr=
ack error status)
Merging fuse/for-next (cbed990fb813 fuse: Rearrange fuse_allow_current_proc=
ess checks)
Merging gfs2/for-next (288fc8606762 Merge tag 'gfs2-nopid-for-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (5e40d197b564 ksmbd: use F_SETLK when unlockin=
g a file)
Merging nfs/linux-next (094226ad94f4 Linux 6.1-rc5)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (ca55b9bf7c16 lockd: fix file selection in nlmsvc_can=
cel_blocked)
Merging ntfs3/master (36963cf225f8 fs/ntfs3: Make if more readable)
CONFLICT (content): Merge conflict in fs/ntfs3/bitmap.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Applying: fix up for "fs: rename current get acl method"
Merging orangefs/for-next (2ad4b6f5e117 Orangefs: change iterate to iterate=
_shared)
Merging overlayfs/overlayfs-next (b337e5ae0e42 ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (669d204469c4 ubi: fastmap: Add fastmap control support =
for 'UBI_IOCATT' ioctl)
Merging v9fs/9p-next (a8e633c60447 net/9p: clarify trans_fd parse_opt failu=
re handling)
Merging xfs/for-next (eab06d36b0ac xfs: Print XFS UUID on mount and umount =
events.)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (f1bd37a47352 iomap: directly use logical bloc=
k size)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (7e7b21bb5576 filelock: new helper: vfs_inode=
_has_locks)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (3aca47127a64 fs: drop useless condition from inode_ne=
eds_update_time)
Merging printk/for-next (950a9751c1d1 Merge branch 'for-6.2' into for-next)
Merging pci/next (3d6750ce8b7f Merge branch 'pci/kbuild')
Merging pstore/for-next/pstore (38b91847c314 pstore: Alert on backend write=
 error)
Merging hid/for-next (dcefe092751d Merge branches 'for-6.2/hid-bpf' and 'fo=
r-6.1/upstream-fixes' into for-next)
Merging i2c/i2c/for-next (ee98d665b461 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (27fea302952d hwmon: (nct6775) add ASUS CR=
OSSHAIR VIII/TUF/ProArt B550M)
Merging jc_docs/docs-next (83a8fd24e609 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (1e284ea984d3 Merge git://linuxtv.org/sailus/media_t=
ree into media_stage)
Merging v4l-dvb-next/master (a7bab6f8b73f Merge tag 'br-v6.2e' of git://lin=
uxtv.org/hverkuil/media_tree into media_stage)
Merging pm/linux-next (60453df62d30 Merge branches 'thermal-core' and 'ther=
mal-intel' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (9901c21bcaf2 cpufreq: qcom-hw: =
Fix memory leak in qcom_cpufreq_hw_read_lut())
Merging cpupower/cpupower (9abf2313adc1 Linux 6.1-rc1)
Merging devfreq/devfreq-next (9abf2313adc1 Linux 6.1-rc1)
Merging opp/opp/linux-next (dba79b78ecc1 dt-bindings: opp-v2: Fix clock-lat=
ency-ns prop in example)
Merging thermal/thermal/linux-next (9d2bc364f677 thermal/drivers/qcom/tsens=
: Simplify debugfs init function)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (775af207464b fs: dlm: use WARN_ON_ONCE() instead of WARN_=
ON())
Merging rdma/for-next (3574cfdca285 RDMA/mana: Remove redefinition of basic=
 u64 type)
Merging net-next/master (7eba4505394e net: dcb: move getapptrust to separat=
e function)
CONFLICT (content): Merge conflict in include/linux/bpf.h
CONFLICT (content): Merge conflict in tools/perf/util/stat.c
Merging bpf-next/for-next (32637e33003f bpf: Expand map key argument of bpf=
_redirect_map to u64)
CONFLICT (content): Merge conflict in include/linux/bpf.h
Merging ipsec-next/master (cc2bbbfd9a50 xfrm: Remove not-used total variabl=
e)
Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (e32c8d8c6f29 Bluetooth: hci_conn: add missing hci=
_dev_put() in iso_listen_bis())
Merging wireless-next/for-next (901c247f9687 wifi: rtw89: 8852b: change deb=
ug mask of message of no TX resource)
Merging mtd/mtd/next (077dc37db1e1 mtd: inftlcore: fix repeated words in co=
mments)
Merging nand/nand/next (075e181fba72 dt-bindings: mtd: brcm,brcmnand: updat=
e interrupts description)
Merging spi-nor/spi-nor/next (bb0e9c600ce2 mtd: spi-nor: core: Add an error=
 message when failing to exit the 4-byte address mode)
Merging crypto/master (557ffd5a4726 crypto: qat - remove ADF_STATUS_PF_RUNN=
ING flag from probe)
Merging drm/drm-next (c02f20d38fb9 drm/nouveau/disp: fix incorrect/broken h=
dmi methods)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n321/dcn321_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/di=
splay_mode_structs.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dd=
i.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.c
CONFLICT (add/add): Merge conflict in drivers/gpu/drm/i915/display/intel_dk=
l_phy.c
CONFLICT (add/add): Merge conflict in drivers/gpu/drm/i915/display/intel_dk=
l_phy.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
ll_mgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_lv=
ds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_sd=
vo.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gem/i915_gem_dma=
buf.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
Merging drm-misc/for-linux-next (0e308efe232a drm/connector: Add pixel cloc=
k to cmdline mode)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
CONFLICT (modify/delete): drivers/gpu/drm/nouveau/nouveau_fbcon.c deleted i=
n HEAD and modified in drm-misc/for-linux-next.  Version drm-misc/for-linux=
-next of drivers/gpu/drm/nouveau/nouveau_fbcon.c left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_hdmi.c
$ git rm -f drivers/gpu/drm/nouveau/nouveau_fbcon.c
Applying: drm-misc: fix up for "drm/fb-helper: Move generic fbdev emulation=
 into separate source file"
$ git reset --hard HEAD^
Merging next-20221115 version of drm-misc
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
CONFLICT (modify/delete): drivers/gpu/drm/nouveau/nouveau_fbcon.c deleted i=
n HEAD and modified in 69c7717c20cc87105b8b54ba43d12ca4e432a1a5.  Version 6=
9c7717c20cc87105b8b54ba43d12ca4e432a1a5 of drivers/gpu/drm/nouveau/nouveau_=
fbcon.c left in tree.
$ git rm -f drivers/gpu/drm/nouveau/nouveau_fbcon.c
[master 5e1c9b8587bb] next-20221115/drm-misc
Applying: drm-misc: fix up for "drm/fb-helper: Move generic fbdev emulation=
 into separate source file"
[master 7b38c72aa39f] next-20221115/drm-misc
Merging amdgpu/drm-next (0788a47e7cec drm/amdgpu: stop resubmittting jobs i=
n amdgpu_pci_resume)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/display_mode_vba_util_32.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu11/si=
enna_cichlid_ppt.c
CONFLICT (content): Merge conflict in include/drm/gpu_scheduler.h
Merging drm-intel/for-linux-next (c27a2b527d4d drm/i915: remove circ_buf.h =
includes)
Merging drm-tegra/for-next (8a378bd19b6e drm/tegra: Switch to using devm_fw=
node_gpiod_get())
Merging drm-msm/msm-next (7f7a942c0a33 Merge tag 'drm-next-20221025' of git=
://linuxtv.org/pinchartl/media into drm-next)
Merging drm-msm-lumag/msm-next-lumag (ee417928fe0a Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi' and 'msm-next-lumag-mdp5' into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4bce24427251 drm/etnaviv: disable tx clock ga=
ting for GC7000 rev6203)
Merging fbdev/for-next (11c94e2e52b5 fbdev: vermilion: decrease reference c=
ount in error path)
Merging regmap/for-next (84498d1fb35d regmap-irq: Use the new num_config_re=
gs property in regmap_add_irq_chip_fwnode)
Merging sound/for-next (f60b29142b3d ALSA: memalloc: Allocate more contiguo=
us pages for fallback case)
Merging sound-asoc/for-next (e05faeff2600 Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-next)
Merging modules/modules-next (30f3bb09778d kallsyms: Add self-test facility)
Merging input/next (ae6b18e631d6 Input: msg2638 - add support for msg2138)
Merging block/for-next (067707e91646 Merge branch 'for-6.2/io_uring' into f=
or-next)
$ git reset --hard HEAD^
Merging next-20221115 version of block
Merging device-mapper/for-next (5434ee8d2857 dm clone: Fix typo in block_de=
vice format specifier)
Merging libata/for-next (6c57e74e6e03 ata: ahci: Remove linux/msi.h include)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (175568abe9ca mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (2c9918463543 mfd: tc6393xb: Remove #ifdef guards =
for PM related functions)
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (09b327c991d2 dt-bindings: power: supply: bq25890:=
 use one fallback compatible)
Merging regulator/for-next (01a10370d550 Merge remote-tracking branch 'regu=
lator/for-6.2' into regulator-next)
Merging security/next (b10b9c342f75 lsm: make security_socket_getpeersec_st=
ream() sockptr_t safe)
Merging apparmor/apparmor-next (4295c60bbe9e apparmor: Fix uninitialized sy=
mbol 'array_size' in policy_unpack_test.c)
Merging integrity/next-integrity (8c1d6a050a0f ima: Fix memory leak in __im=
a_inode_hash())
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (048be156491f selinux: remove the sidtab context conve=
rsion indirect calls)
CONFLICT (content): Merge conflict in security/selinux/ss/services.c
CONFLICT (content): Merge conflict in security/selinux/ss/sidtab.c
CONFLICT (content): Merge conflict in security/selinux/ss/sidtab.h
Applying: selinux: fix up for "selinux: enable use of both GFP_KERNEL and G=
FP_ATOMIC in convert_context()"
Merging smack/next (1a3065e92046 smack_lsm: remove unnecessary type casting)
Merging tomoyo/master (88ba4e14d341 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (fd6628650d1a KEYS: trusted: tee: Make registered shm de=
pendency explicit)
Merging watchdog/master (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging iommu/next (7e8eec906b5b Merge branches 'arm/allwinner', 'arm/rockc=
hip', 'ppc/pamu', 's390', 'x86/amd' and 'core' into next)
Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode_=
name(), syscall()})
Merging devicetree/for-next (7c7c3a79213e dt-bindings: PCI: xilinx-nwl: Con=
vert to YAML schemas of Xilinx NWL PCIe Root Port Bridge)
Merging dt-krzk/for-next (0d2e98b51908 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (c95a70055115 Merge remote-tracking branch 'spi/for-6.=
2' into spi-next)
Merging tip/master (6db34baf0d6a Merge sched/urgent into tip/master)
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
CONFLICT (modify/delete): drivers/iommu/iommu-sva-lib.c deleted in HEAD and=
 modified in tip/master.  Version tip/master of drivers/iommu/iommu-sva-lib=
.c left in tree.
CONFLICT (content): Merge conflict in include/linux/bpf.h
$ git rm -f drivers/iommu/iommu-sva-lib.c
Applying: fix up for "iommu: Rename iommu-sva-lib.{c,h}"
Merging clockevents/timers/drivers/next (af246cc6d0ed clocksource/drivers/a=
rm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value)
Merging edac/edac-for-next (b998a2babf4e Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (732d69c80cb0 Merge branch irq/misc-6.1 in=
to irq/irqchip-next)
Merging ftrace/for-next (0934ae9977c2 tracing: Fix reading strings from syn=
thetic events)
Merging rcu/rcu/next (cede97a6d18c refscale: Add tests using SLAB_TYPESAFE_=
BY_RCU)
Merging kvm/next (d72cf8ffe460 Merge tag 'kvm-s390-master-6.1-1' of https:/=
/git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (eb8be68e907e Merge branch kvm-arm64/misc-6.2 into kvm=
arm-master/next)
Merging kvms390/next (89204d8846ed KVM: s390: pv: module parameter to fence=
 asynchronous destroy)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Merging xen-tip/linux-next (4abb77fc5531 xen/platform-pci: use define inste=
ad of literal number)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (309e0a6ed6e3 platform/x86: dell-ddv: Warn if =
ePPID has a suspicious length)
Merging chrome-platform/for-next (015e4b05c377 platform/chrome: cros_ec_spi=
: Set PROBE_PREFER_ASYNCHRONOUS)
Merging hsi/for-next (f5181c35ed7b HSI: omap_ssi_core: fix unbalanced pm_ru=
ntime_disable())
Merging leds/for-next (5f52a8ba7e91 dt-bindings: leds: Add 'cpuX' to 'linux=
,default-trigger')
Merging ipmi/for-next (0eb1762f3c77 ipmi/watchdog: Include <linux/kstrtox.h=
> when appropriate)
Merging driver-core/driver-core-next (f613facc82cf mfd: vexpress-sysreg: Fi=
x resource compound literal assignments)
Merging usb/usb-next (dd65a243a915 usb/usbip: Fix v_recv_cmd_submit() to us=
e PIPE_BULK define)
Merging thunderbolt/next (a5cfc9d65879 thunderbolt: Add wake on connect/dis=
connect on USB4 ports)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (247f34f7b803 Linux 6.1-rc2)
Merging tty/tty-next (5c30f3e4a6e6 tty: Move TIOCSTI toggle variable before=
 kerndoc)
Merging char-misc/char-misc-next (e8433659bf70 Revert "drivers: bus: simple=
-pm-bus: Use clocks")
Merging coresight/next (3c728e079d83 coresight: etm4x: add CPU hotplug supp=
ort for probing)
Merging fpga/for-next (ee31d5038c06 dt-bindings: fpga: document Lattice sys=
CONFIG FPGA manager)
Merging icc/icc-next (1498a5a79980 dt-bindings: interconnect: qcom,msm8998-=
bwmon: Correct SC7280 CPU compatible)
Merging iio/togreg (021882de1a48 iio: pressure: bmp280: convert to i2c's .p=
robe_new())
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/addac/adi,ad74413r.yaml
Merging phy-next/next (742859441d44 phy: renesas: Add Renesas Ethernet SERD=
ES driver for R-Car S4-8)
Merging soundwire/next (febc50b82bc9 dt-bindings: soundwire: Convert text b=
indings to DT Schema)
Merging extcon/extcon-next (9abf2313adc1 Linux 6.1-rc1)
Merging gnss/gnss-next (247f34f7b803 Linux 6.1-rc2)
Merging vfio/next (2f5d8cef45c3 vfio/mlx5: Fix a typo in mlx5vf_cmd_load_vh=
ca_state())
Merging staging/staging-next (a614e753e8e7 staging: r8188eu: drop removal/s=
top check in dump_mgntframe_and_wait_ack)
Merging counter-next/counter-next (30a0b95b1335 Linux 6.1-rc3)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (3a0c95b61385 dmaengine: tegra: Add support for dma-=
channel-mask)
Merging cgroup/for-next (79a7f41f7f5a cgroup: cgroup refcnt functions shoul=
d be exported when CONFIG_DEBUG_CGROUP_REF)
Merging scsi/for-next (46c80503f387 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (e56ca6bcd213 scsi: target: Use kstrtobool() inst=
ead of strtobool())
Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
Merging rpmsg/for-next (38e723045f68 Merge branches 'rproc-next' and 'hwspi=
nlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (739be9b6a84b gpio: sl28cpld: Replace irqch=
ip mask_invert with unmask_base)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging gpio-intel/for-next (8d259847243d gpiolib: cdev: Fix typo in kernel=
 doc for struct line)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (8555c646407d Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (b14ef61314b3 pinctrl: intel: Add Intel Moor=
efield pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (41a87e789c7c pinctrl: renesas: rzg=
2l: remove unnecessary check from rzg2l_dt_node_to_map())
Merging pinctrl-samsung/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging pwm/for-next (bf22908680cc pwm: tegra: Ensure the clock rate is not=
 less than needed)
Merging userns/for-next (b5df013cd194 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, retire_mq_sys=
ctls-for-v5.19, and unpriv-ipc-sysctls-for-v6.2 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (35eee9a363be selftests: rtc: skip when RTC is not p=
resent)
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (0462681e207c rtc: snvs: Allow a time difference on cl=
ock register read)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging ntb/ntb-next (1a3f7484e076 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (4e92863862d1 Merge branch 'for-linus/secc=
omp' into for-next/seccomp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (371fcbd32b26 dt-bindings: slimbus: qcom,slim-ngd:=
 convert to DT schema)
Merging nvmem/for-next (5b4eaafbeac4 nvmem: u-boot-env: add Broadcom format=
 support)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (0b90efa6ca81 clocksource: hyper-v: Add TSC page=
 support for root partition)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (9abf2313adc1 Linux 6.1-rc1)
Merging kunit/test (9abf2313adc1 Linux 6.1-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (870f63b7cd78 kunit: eliminate KUNIT_INIT_*_ASSERT=
_STRUCT macros)
CONFLICT (content): Merge conflict in lib/kunit/string-stream.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (d8425a8c3a84 bus: mhi: host: pci_generic: Add HP vari=
ant of T99W175)
Merging memblock/for-next (80c2fe022ef5 memblock tests: remove completed TO=
DO item)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging cxl/next (9abf2313adc1 Linux 6.1-rc1)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (c5fa6df0a498 efi: random: combine bootloader provided RNG=
 seed with RNG protocol output)
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/Makefile
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (8f17b4988138 Merge branch 'slab/for-6.2/kmalloc_redz=
one' into slab/for-next)
Merging random/master (1679374191e5 random: always mix cycle counter in add=
_latent_entropy())
Merging landlock/next (0b4ab8cd635e Merge tag 'landlock-6.1-rc4' into landl=
ock-next)
Merging rust/rust-next (fd9517a1603f init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
Merging sysctl/sysctl-next (c06a17fe056b kernel/sysctl-test: use SYSCTL_{ZE=
RO/ONE_HUNDRED} instead of i_{zero/one_hundred})
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
Merging execve/for-next/execve (ef20c5139c31 binfmt_elf: simplify error han=
dling in load_elf_phdrs())
Merging bitmap/bitmap-for-next (27bc50fc9064 Merge tag 'mm-stable-2022-10-0=
8' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging hte/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging kspp/for-next/kspp (0eaf29a03298 Merge branch 'for-linus/hardening'=
 into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging unsigned-char/unsigned-char (be79268b55ed lib: assume char is unsig=
ned)
Merging iommufd/for-next (6bb16a9c6776 iommufd: Allow iommufd to supply /de=
v/vfio/vfio)
CONFLICT (content): Merge conflict in drivers/vfio/vfio_main.c
Merging mm-stable/mm-stable (ea0ffd0c08d0 swap: add a limit for readahead p=
age-cluster value)
CONFLICT (content): Merge conflict in mm/hugetlb.c
Merging mm-nonmm-stable/mm-nonmm-stable (9e68ef4e0c6a scripts/spelling.txt:=
 add more spellings to spelling.txt)
Merging mm/mm-everything (4db08853c212 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/damon/sysfs.c
CONFLICT (content): Merge conflict in mm/gup.c
CONFLICT (content): Merge conflict in mm/huge_memory.c
CONFLICT (content): Merge conflict in mm/vmscan.c
Applying: Revert "tcp: Add listening address to SYN flood message"

--Sig_/G/D+zLaP.Rv4=I=be4hXTAC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN0iI0ACgkQAVBC80lX
0GwbWQf+NU3KXighwDdX3ozixSnTRGPiR6laGplptK0Xt7OcbsrtQ9zc9eTsjHj7
VHiKrRBFGwGsWFvI2hmTw0MN83o7I4qgLF+u4aqr9ueBzPErKybZ0W6hhon/KHii
42thZX5mDnxISqeJBZWYpDuoWU4BKPGRJdHP5uMqsx3TBLvwFqCPkx9ckPrT+3SV
i1amE+Da6MbIfs4wO8vEwEyMWbDo6GOwcWOiU8uyTp3jFKfQcS+ynbXwmlyY7YOc
L4I0ZJDwku/SXCWMg9m85jDvlJyssF8t+5sbAExlOA6Ss9JL530jne52aqJGvJlL
g/QyPjzvZ/kkuw8INwC3leJJOMvYpw==
=ExVO
-----END PGP SIGNATURE-----

--Sig_/G/D+zLaP.Rv4=I=be4hXTAC--
