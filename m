Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9D6276AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiKNHtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiKNHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:49:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366218B2D;
        Sun, 13 Nov 2022 23:49:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N9hKb0cbcz4xGW;
        Mon, 14 Nov 2022 18:49:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668412179;
        bh=5/35+oXSqVdfMg7q0gD1RSTGS4Q5CSciU4IVPe7pHMM=;
        h=Date:From:To:Cc:Subject:From;
        b=UkdFGEuOVA7uPUEPP8S6+BEp0hP0U52mZqtjLGPFwhgKVa8SAIumoG5QiVsC+LPZv
         BbJDtTs80OZGznZSQ2/8zTSrD9DfkNzLXnuMmnqyXcrgNQe5ONMyKbWXNv1l60zYhX
         jm0vdKfyGQUDDdW+1RSB3ghMF/cOrfB5Axr/NJLBI95d4bhr3ycaVHrIA5x/KhcWjd
         hStkjt/E/y4WR25BHN28CDZUjbb2Jb8Ii9J2y5iMWCrfAJjJdrAn8xzlnF0DBwRFkY
         f6yvKt4BhFBtNel2DiS56K/qfC57Dg/7W8BYreS5LSwF1eyQ82L24N+tsry/84uiVy
         lURtd7fbeks3A==
Date:   Mon, 14 Nov 2022 18:49:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 14
Message-ID: <20221114184937.30baa900@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y+V4rEJE/_66qZ0nHuVapF4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y+V4rEJE/_66qZ0nHuVapF4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221111:

The tegra tree gained a conflict against the qcom tree.

The net-next tree gained a conflict against the net tree.

The drm-intel tree gained a conflict against Linus' tree.

The modules tree gained conflicts against the net-next tree.  Also a
difficult semantic conflict against the net-next tree so I used the
version from next-20221111.

The tip tree gained a conflict against the iommu tree.

The driver-core tree gained a build failure so I used the version from
next-20221111.

Non-merge commits (relative to Linus' tree): 6854
 7050 files changed, 323171 insertions(+), 134395 deletions(-)

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
Merging origin/master (af7a05689189 Merge tag 'mips-fixes_6.1_1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/mips/linux)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (809e522e3a78 hugetlb: don't delet=
e vma_lock in hugetlb MADV_DONTNEED processing)
Merging kbuild-current/fixes (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (340a982825f7 ARM: 9266/1: mm: fix no-MMU ZERO_PA=
GE() implementation)
Merging arm64-fixes/for-next/fixes (acfc35cfcee5 arm64/syscall: Include asm=
/ptrace.h in syscall_wrapper header.)
Merging arm-soc-fixes/arm/fixes (5449cabd95bb Merge tag 'juno-fix-6.1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fi=
xes)
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
Merging net/master (9cbd48d5fa14 mctp i2c: don't count unused / invalid key=
s for flow release)
Merging bpf/master (9cbd48d5fa14 mctp i2c: don't count unused / invalid key=
s for flow release)
Merging ipsec/master (7f57f8165cb6 af_key: Fix send_acquire race with pfkey=
_register)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (91018bbcc664 Merge tag 'wireless-2022-11-03' of =
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless)
Merging rdma-fixes/for-rc (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging sound-current/for-linus (ad72c3c3f6eb ALSA: usb-audio: Drop snd_BUG=
_ON() from snd_usbmidi_output_open())
Merging sound-asoc-fixes/for-linus (39bd801d6908 ASoC: soc-pcm: Don't zero =
TDM masks in __soc_pcm_open())
Merging regmap-fixes/for-linus (84498d1fb35d regmap-irq: Use the new num_co=
nfig_regs property in regmap_add_irq_chip_fwnode)
Merging regulator-fixes/for-linus (01172d5e1b35 Merge remote-tracking branc=
h 'regulator/for-6.0' into regulator-linus)
Merging spi-fixes/for-linus (161d626f42bf Merge remote-tracking branch 'spi=
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
Merging usb-serial-fixes/usb-linus (df3414b0a245 USB: serial: option: add S=
ierra Wireless EM9191)
Merging phy/fixes (819b885cd886 phy: ralink: mt7621-pci: add sentinel to qu=
irks table)
Merging staging.current/staging-linus (937ec9f7d5f2 staging: rtl8192e: remo=
ve bogus ssid character sign test)
Merging iio-fixes/fixes-togreg (4ad09d956f8e iio: core: Fix entry not delet=
ed when iio_register_sw_trigger_type() fails)
Merging counter-current/counter-current (30a0b95b1335 Linux 6.1-rc3)
Merging char-misc.current/char-misc-linus (65946690ed8d firmware: coreboot:=
 Register bus in module init)
Merging soundwire-fixes/fixes (49a467310dc4 soundwire: qcom: check for outa=
nding writes before doing a read)
Merging thunderbolt-fixes/fixes (f0c4d9fc9cc9 Linux 6.1-rc4)
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
Merging mips-fixes/mips-fixes (648060902aa3 MIPS: pic32: treat port as sign=
ed integer)
Merging at91-fixes/at91-fixes (cef8cdc0d0e7 ARM: at91: pm: avoid soft reset=
ting AC DLL)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (6d3085e4d89a KVM: x86/mmu: Block all page faults =
during kvm_zap_gfn_range())
Merging kvms390-fixes/master (b6662e377727 KVM: s390: pci: Fix allocation s=
ize of aift kzdev elements)
Merging hwmon-fixes/hwmon (3a9a5dcb14be hwmon: (ina3221) Fix shunt sum crit=
ical calculation)
Merging nvdimm-fixes/libnvdimm-fixes (b3bbcc5d1da1 Merge branch 'for-6.0/da=
x' into libnvdimm-fixes)
Merging cxl-fixes/fixes (8f401ec1c897 cxl/region: Recycle region ids)
Merging btrfs-fixes/next-fixes (1741255d952d Merge branch 'misc-6.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (7ee47dcfff18 fs: use acquire ordering in __fget_li=
ght())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (53eb64c88f17 platform/x86: p2sb: Don't fai=
l if unknown CPU is found)
Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging devicetree-fixes/dt/linus (917c362b5f8a MAINTAINERS: of: collapse o=
verlay entry into main device tree entry)
Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging scsi-fixes/fixes (ecb8c2580d37 scsi: scsi_debug: Make the READ CAPA=
CITY response compliant with ZBC)
Merging drm-fixes/drm-fixes (b7ffd9d9ee13 Merge tag 'drm-intel-fixes-2022-1=
1-10' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (178e31ce82d0 drm/i915/userptr=
: restore probe_range behaviour)
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
Merging erofs-fixes/fixes (39bfcb8138f6 erofs: fix use-after-free of fsid a=
nd domain_id string)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (618887768bb7 kunit: update NULL vs IS_ERR(=
) tests)
Merging ubifs-fixes/fixes (c18a80c6861f jffs2: correct logic when creating =
a hole in jffs2_write_begin)
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (50256e4793a5 nfsd: put the export reference in nf=
sd4_verify_deleg_dentry)
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
Merging drm-misc-fixes/for-linux-next-fixes (4979524f5a2a drm: Fix potentia=
l null-ptr-deref in drm_vblank_destroy_worker())
Merging kbuild/for-next (2df76606db9d Merge tag 'kbuild-fixes-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (816815b85221 perf probe: Fix to get the DW_AT_decl_=
file and DW_AT_call_file as unsinged data)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (8d58aa484920 swiotlb: reduce the swiotlb buff=
er size on allocation failure)
Merging asm-generic/master (defbab270d45 include/uapi/linux/swab: Fix poten=
tially missing __always_inline)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (0c52591d22e9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (efb5c584e18c Merge branches 'for-next/acpi', '=
for-next/asm-const', 'for-next/cpufeature', 'for-next/dynamic-scs', 'for-ne=
xt/fpsimd', 'for-next/kbuild', 'for-next/mm', 'for-next/selftests', 'for-ne=
xt/trivial' and 'for-next/uaccess' into for-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (76b4abc1ae4b Merge branch 'arm/drivers' into for-=
next)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (475701ff77ef Merge branch 'v6.2/arm64-dt' into fo=
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
Merging imx-mxs/for-next (9b50871c24c0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (62078bdbd791 Merge branch 'v6.1-next/soc' into f=
or-next)
Merging mvebu/for-next (d5c48679d56c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (b610ba9a796a Merge branch 'omap-for-v6.2/dt' into fo=
r-next)
Merging qcom/for-next (8b6f5200c433 Merge branches 'arm64-defconfig-for-6.2=
', 'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2', 'drivers-for-6.2', =
'dts-for-6.2' and 'arm64-fixes-for-6.1' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (bb90a1820bf9 Merge branches 'renesas-arm-dt-for-v6.2'=
, 'renesas-dt-bindings-for-v6.2', 'renesas-riscv-defconfig-for-v6.2', 'rene=
sas-riscv-dt-for-v6.2' and 'renesas-riscv-soc-for-v6.2' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (7771a384229f Merge branch 'v6.1-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (113aec13d45e Merge branch 'next/clk' into fo=
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
Merging ti/ti-next (b7897ec0b3d2 Merge branches 'ti-drivers-soc-next', 'ti-=
k3-config-next' and 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (5eeec1fd8360 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging clk-renesas/renesas-clk (523ed9442b99 clk: renesas: r8a779g0: Add C=
MT clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (7e2004906fb5 Revert "csky: Add support for restart=
able sequence")
Merging loongarch/loongarch-next (247f34f7b803 Linux 6.1-rc2)
Merging m68k/for-next (550a998f37b4 m68k: mac: Reword comment using double =
"in")
Merging m68knommu/for-next (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging microblaze/next (493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-fo=
r-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-nam=
espace)
Merging mips/mips-next (f0c4d9fc9cc9 Linux 6.1-rc4)
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
Merging ceph/master (ffc4d66a34bb ceph: fix a NULL vs IS_ERR() check when c=
alling ceph_lookup_inode())
Merging cifs/for-next (1dcdf5f5b213 cifs: Fix connections leak when tlink s=
etup failed)
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
Merging ksmbd/ksmbd-for-next (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging nfs/linux-next (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (0883e0db49f3 NFSD: Use struct_size() helper in alloc=
_session())
Merging ntfs3/master (658015167a84 fs/ntfs3: Delete duplicate condition in =
ntfs_read_mft())
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Merging orangefs/for-next (2ad4b6f5e117 Orangefs: change iterate to iterate=
_shared)
Merging overlayfs/overlayfs-next (b337e5ae0e42 ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (669d204469c4 ubi: fastmap: Add fastmap control support =
for 'UBI_IOCATT' ioctl)
Merging v9fs/9p-next (a8e633c60447 net/9p: clarify trans_fd parse_opt failu=
re handling)
Merging xfs/for-next (4eb559dd1567 Merge tag 'refcount-cow-domain-6.1_2022-=
10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux in=
to xfs-6.1-fixesA)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (adc9c2e5a723 iomap: add a tracepoint for mapp=
ings returned by map_blocks)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of g=
it://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (3aca47127a64 fs: drop useless condition from inode_ne=
eds_update_time)
Merging printk/for-next (950a9751c1d1 Merge branch 'for-6.2' into for-next)
Merging pci/next (7ef4a88327bb Merge branch 'pci/kbuild')
Merging pstore/for-next/pstore (38b91847c314 pstore: Alert on backend write=
 error)
Merging hid/for-next (1d608ab72fa7 Merge branch 'for-6.2/ft260' into for-ne=
xt)
Merging i2c/i2c/for-next (e40ca0ba6bd0 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (2512910c126a hwmon: (coretemp) Remove obs=
olete temp_data->valid)
Merging jc_docs/docs-next (911c30946498 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging v4l-dvb-next/master (1e284ea984d3 Merge git://linuxtv.org/sailus/me=
dia_tree into media_stage)
Merging pm/linux-next (c4279b9e39bd Merge branch 'acpica' into linux-next)
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
Merging rdma/for-next (5c20311d76cb IB/mad: Don't call to function that mig=
ht sleep while in atomic context)
Merging net-next/master (b548b17a93fd tcp: tcp_wfree() refactoring)
CONFLICT (content): Merge conflict in include/linux/bpf.h
CONFLICT (content): Merge conflict in tools/perf/util/stat.c
Merging bpf-next/for-next (b548b17a93fd tcp: tcp_wfree() refactoring)
Merging ipsec-next/master (cc2bbbfd9a50 xfrm: Remove not-used total variabl=
e)
Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (6ec6368edb46 Bluetooth: btusb: Add debug message =
for CSR controllers)
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
Merging drm/drm-next (a143bc517bf3 Merge branch '00.06-gr-ampere' of https:=
//gitlab.freedesktop.org/skeggsb/nouveau into drm-next)
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
Merging drm-misc/for-linux-next (442cf8e22ba2 drm/sti: Use drm_mode_copy())
CONFLICT (modify/delete): drivers/gpu/drm/nouveau/nouveau_fbcon.c deleted i=
n HEAD and modified in drm-misc/for-linux-next.  Version drm-misc/for-linux=
-next of drivers/gpu/drm/nouveau/nouveau_fbcon.c left in tree.
$ git rm -f drivers/gpu/drm/nouveau/nouveau_fbcon.c
Applying: drm-misc: fix up for "drm/fb-helper: Move generic fbdev emulation=
 into separate source file"
Merging amdgpu/drm-next (2ebf61f2cfb9 drm/amdgpu: Fix memory leak in amdgpu=
_cs_pass1)
Merging drm-intel/for-linux-next (801543b2593b drm/i915: stop including i91=
5_irq.h from i915_trace.h)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ba=
cklight.c
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
Merging fbdev/for-next (d12d0c967945 fbdev: pxafb: Remove unnecessary print=
 function dev_err())
Merging regmap/for-next (84498d1fb35d regmap-irq: Use the new num_config_re=
gs property in regmap_add_irq_chip_fwnode)
Merging sound/for-next (d59b6f215aa8 ALSA: cs5535audio: Remove the redundan=
t assignment)
Merging sound-asoc/for-next (7ec53690d08c Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-next)
Merging modules/modules-next (ae96c4e1e6d4 kallsyms: Add self-test facility)
CONFLICT (content): Merge conflict in include/linux/module.h
CONFLICT (content): Merge conflict in kernel/module/kallsyms.c
CONFLICT (content): Merge conflict in kernel/trace/ftrace.c
$ git reset --hard HEAD^
Merging next-20221111 version of modules
Merging input/next (60f07c29e035 Input: Use kstrtobool() instead of strtobo=
ol())
Merging block/for-next (939f803c54b0 Merge branch 'for-6.2/io_uring' into f=
or-next)
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
Merging regulator/for-next (70caed054b7d Merge remote-tracking branch 'regu=
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
Merging tomoyo/master (9abf2313adc1 Linux 6.1-rc1)
Merging tpmdd/next (2d869f0b4585 selftest: tpm2: Add Client.__del__() to cl=
ose /dev/tpm* handle)
Merging watchdog/master (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging iommu/next (7e8eec906b5b Merge branches 'arm/allwinner', 'arm/rockc=
hip', 'ppc/pamu', 's390', 'x86/amd' and 'core' into next)
Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode_=
name(), syscall()})
Merging devicetree/for-next (7c7c3a79213e dt-bindings: PCI: xilinx-nwl: Con=
vert to YAML schemas of Xilinx NWL PCIe Root Port Bridge)
Merging dt-krzk/for-next (f4566aac0c0d Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (dbe44a39fb3e Merge remote-tracking branch 'spi/for-6.=
2' into spi-next)
Merging tip/master (b930cf5ce69f Merge x86/mm into tip/master)
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
Merging kvms390/next (58635d6615f1 s390/mm: fix virtual-physical address co=
nfusion for swiotlb)
Merging xen-tip/linux-next (4bff677b3015 x86/xen: simplify sysenter and sys=
call setup)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (309e0a6ed6e3 platform/x86: dell-ddv: Warn if =
ePPID has a suspicious length)
Merging chrome-platform/for-next (015e4b05c377 platform/chrome: cros_ec_spi=
: Set PROBE_PREFER_ASYNCHRONOUS)
Merging hsi/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging leds/for-next (5f52a8ba7e91 dt-bindings: leds: Add 'cpuX' to 'linux=
,default-trigger')
Merging ipmi/for-next (0eb1762f3c77 ipmi/watchdog: Include <linux/kstrtox.h=
> when appropriate)
Merging driver-core/driver-core-next (2f465b921bb8 vmlinux.lds.h: place opt=
ional header space in BOUNDED_SECTION)
$ git reset --hard HEAD^
Merging next-20221111 version of driver-core
Merging usb/usb-next (dd65a243a915 usb/usbip: Fix v_recv_cmd_submit() to us=
e PIPE_BULK define)
Merging thunderbolt/next (a5cfc9d65879 thunderbolt: Add wake on connect/dis=
connect on USB4 ports)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (247f34f7b803 Linux 6.1-rc2)
Merging tty/tty-next (5c30f3e4a6e6 tty: Move TIOCSTI toggle variable before=
 kerndoc)
Merging char-misc/char-misc-next (282a4b71816b char: xillybus: Prevent use-=
after-free due to race condition)
Merging coresight/next (3c728e079d83 coresight: etm4x: add CPU hotplug supp=
ort for probing)
Merging fpga/for-next (ee31d5038c06 dt-bindings: fpga: document Lattice sys=
CONFIG FPGA manager)
Merging icc/icc-next (1498a5a79980 dt-bindings: interconnect: qcom,msm8998-=
bwmon: Correct SC7280 CPU compatible)
Merging iio/togreg (7338e1c6a90c Documentation: ad4130: format list of in_v=
oltage-voltage_filter_mode_available modes)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/addac/adi,ad74413r.yaml
Merging phy-next/next (742859441d44 phy: renesas: Add Renesas Ethernet SERD=
ES driver for R-Car S4-8)
Merging soundwire/next (febc50b82bc9 dt-bindings: soundwire: Convert text b=
indings to DT Schema)
Merging extcon/extcon-next (9abf2313adc1 Linux 6.1-rc1)
Merging gnss/gnss-next (247f34f7b803 Linux 6.1-rc2)
Merging vfio/next (913447d06f03 vfio: Remove vfio_free_device)
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
Merging rpmsg/for-next (1b09681fdc30 Merge branches 'rproc-next' and 'hwspi=
nlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (8dab99c9eab3 gpio: davinci: add support of=
 module build)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging gpio-intel/for-next (8d259847243d gpiolib: cdev: Fix typo in kernel=
 doc for struct line)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (99bcf14b234d Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (b14ef61314b3 pinctrl: intel: Add Intel Moor=
efield pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (96355be8f0a2 dt-bindings: pinctrl:=
 renesas: Document RZ/Five SoC)
Merging pinctrl-samsung/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging pwm/for-next (bf22908680cc pwm: tegra: Ensure the clock rate is not=
 less than needed)
Merging userns/for-next (b5df013cd194 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, retire_mq_sys=
ctls-for-v5.19, and unpriv-ipc-sysctls-for-v6.2 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (d942f231afc0 selftests/vDSO: Add riscv getcpu & get=
timeofday test)
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (9abf2313adc1 Linux 6.1-rc1)
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
Merging hyperv/hyperv-next (7278ff7d1012 x86/hyperv: Expand definition of s=
truct hv_vp_assist_page)
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
Merging random/master (0475bba46135 random: always mix cycle counter in add=
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
Merging mm-stable/mm-stable (b742122b4e36 selftests/damon: add tests for DA=
MON_LRU_SORT's enabled parameter)
CONFLICT (content): Merge conflict in mm/hugetlb.c
Merging mm-nonmm-stable/mm-nonmm-stable (f0c4d9fc9cc9 Linux 6.1-rc4)
Merging mm/mm-everything (572d7e91c4cd Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/gup.c
CONFLICT (content): Merge conflict in mm/huge_memory.c

--Sig_/Y+V4rEJE/_66qZ0nHuVapF4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNx8xEACgkQAVBC80lX
0Gwn+Qf7BF/0Q8SnQFOyyRrRVQY6TWgkfa/EEFlce6mrlCRdSli9LQeRweBlc8UK
4NOQ1Y8DtNu6504/8xRcUiPqftMJIlJ5TlPgVj3lESmNxuxrNGIz0nsBklbrDvOs
+A7xl1Ulfc9qxJ0co5iafSJalq4eyOzuoCpFlbt+ikIJrHtIAJ3S+rXDkETjMRWp
T4BcCRRcP27dVeEXi9bmPrSvCLH+dRw5GiyYUCqN9JkdqIzABO2MsVZcUV3hEG4F
Dcc4Oo2gEL4kbTMX9avJ/21qIbnAiaYmTVqICthcXIZRYKxfa33a+iSnHKya21Ao
j+/PWqUYKnJ4po8wBswxvOnYnIiVNg==
=+hGJ
-----END PGP SIGNATURE-----

--Sig_/Y+V4rEJE/_66qZ0nHuVapF4--
