Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687DE63B8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiK2DOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiK2DOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:14:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43279FD1;
        Mon, 28 Nov 2022 19:14:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLnVz0LMBz4x2c;
        Tue, 29 Nov 2022 14:14:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669691659;
        bh=VpD+z7RbnplYYc2rXcy4q11XM9CMPMEzsbLXLJbqQR8=;
        h=Date:From:To:Cc:Subject:From;
        b=jEZ44C1t2sC3XcDHyymljPXbG0Fhm6Ma3jax2GInwL+eaRSi2YOul4scf9C97WZId
         Olwo4EaresrCBwuu1KMpwbfZf98Ae0uOti628smaL4MZltb9PWJ1Iuwk+o9sqeq9c+
         wYFtnqJs7wDOR2lVRNpVQ9CAdxoOgMTGFA6tr3vy84lcgr09gqrGw91g8EBptU/PDq
         g7HrTXbnxiNv6XJxSuSLjpHcurFOkeLNq4SB3dDweNeuy7N9MWKUJpqluYnw4j5ReZ
         sofsljR95AeyYRr7bwTHNMvaT27bjPJdfunCD+BKAur7exW3WIL801fjx4JsOdQzGX
         5kFXkxCXNIdjw==
Date:   Tue, 29 Nov 2022 14:14:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 29
Message-ID: <20221129141415.65a7c89c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e6XvzWPIYDqREDkeK2L/99p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e6XvzWPIYDqREDkeK2L/99p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221128:

The thermal tree still had complex conflicts against the pm tree so I dropp=
ed
the thermal tree for today.

The net-next tree still had its build failure so I used the version from
next-20221125.

The driver-core tree still had its build failures so I used the version from
next-20221125.

Non-merge commits (relative to Linus' tree): 10451
 9988 files changed, 453983 insertions(+), 182243 deletions(-)

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

I am currently merging 370 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (b7b275e60bcd Linux 6.1-rc7)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (a7b5a1852eb7 Kconfig.debug: provi=
de a little extra FRAME_WARN leeway when KASAN is enabled)
Merging kbuild-current/fixes (869e4ae4cd2a nios2: add FORCE for vmlinuz.gz)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (340a982825f7 ARM: 9266/1: mm: fix no-MMU ZERO_PA=
GE() implementation)
Merging arm64-fixes/for-next/fixes (5b47348fc0b1 arm64/mm: fix incorrect fi=
le_map_count for non-leaf pmd/pud)
Merging arm-soc-fixes/arm/fixes (b10dbd6fbd7d Merge tag 'v6.2-rockchip-dts3=
2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip =
into arm/fixes)
Merging davinci-current/davinci/for-current (9abf2313adc1 Linux 6.1-rc1)
Merging drivers-memory-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED =
as BI_RNG_SEED)
Merging powerpc-fixes/fixes (2e7ec190a0e3 powerpc/64s: Add missing declarat=
ion for machine_check_early_boot())
Merging s390-fixes/fixes (adba1a9b81d5 MAINTAINERS: add S390 MM section)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (f2fc2280faab Merge branch 'wwan-iosm-fixes')
Merging bpf/master (8be602dadb2f selftests/bpf: Make test_bench_attach seri=
al)
Merging ipsec/master (40781bfb836e xfrm: Fix ignored return value in xfrm6_=
init())
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (3e8f7abcc347 wifi: mac8021: fix possible oob acc=
ess in ieee80211_get_rate_duration)
Merging rdma-fixes/for-rc (094226ad94f4 Linux 6.1-rc5)
Merging sound-current/for-linus (ecae4c8954a1 Merge tag 'asoc-fix-v6.1-rc6'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (3d1bb6cc1a65 ASoC: cs42l51: Correct PGA=
 Volume minimum value)
Merging regmap-fixes/for-linus (84498d1fb35d regmap-irq: Use the new num_co=
nfig_regs property in regmap_add_irq_chip_fwnode)
Merging regulator-fixes/for-linus (b7b275e60bcd Linux 6.1-rc7)
Merging spi-fixes/for-linus (2f030feedc40 Merge remote-tracking branch 'spi=
/for-6.0' into spi-linus)
Merging pci-current/for-linus (ac9ccce8717d MAINTAINERS: Include PCI bindin=
gs in host bridge entry)
Merging driver-core.current/driver-core-linus (eb7081409f94 Linux 6.1-rc6)
Merging tty.current/tty-linus (eb7081409f94 Linux 6.1-rc6)
Merging usb.current/usb-linus (b7b275e60bcd Linux 6.1-rc7)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (eb7081409f94 Linux 6.1-rc6)
Merging phy/fixes (819b885cd886 phy: ralink: mt7621-pci: add sentinel to qu=
irks table)
Merging staging.current/staging-linus (eb7081409f94 Linux 6.1-rc6)
Merging iio-fixes/fixes-togreg (86fdd15e10e4 iio: fix memory leak in iio_de=
vice_register_eventset())
Merging counter-current/counter-current (fd5ac974fc25 counter: stm32-lptime=
r-cnt: fix the check on arr and cmp registers update)
Merging char-misc.current/char-misc-linus (b7b275e60bcd Linux 6.1-rc7)
Merging soundwire-fixes/fixes (49a467310dc4 soundwire: qcom: check for outa=
nding writes before doing a read)
Merging thunderbolt-fixes/fixes (b7b275e60bcd Linux 6.1-rc7)
Merging input-current/for-linus (81cd7e848927 Input: i8042 - fix leaking of=
 platform device on module removal)
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
Merging v4l-dvb-fixes/fixes (5eef2141776d media: v4l2-dv-timings.c: fix too=
 strict blanking sanity checks)
Merging reset-fixes/reset/fixes (ae358d71d462 reset: npcm: fix iprst2 and i=
prst4 setting)
Merging mips-fixes/mips-fixes (094226ad94f4 Linux 6.1-rc5)
Merging at91-fixes/at91-fixes (6a3fc8c330d1 ARM: at91: fix build for SAMA5D=
3 w/o L2 cache)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (fe08e36be9ec Merge branch 'kvm-dwmw2-fixes' into =
HEAD)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (2745705ee6aa hwmon: (asus-ec-sensors) Add checks=
 for devm_kcalloc)
Merging nvdimm-fixes/libnvdimm-fixes (472faf72b33d device-dax: Fix duplicat=
e 'hmem' device registration)
Merging cxl-fixes/fixes (8f401ec1c897 cxl/region: Recycle region ids)
Merging btrfs-fixes/next-fixes (ee267181ea70 Merge branch 'misc-6.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (10bc8e4af659 vfs: fix copy_file_range() averts fil=
esystem freeze protection)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (b44fd994e451 platform/x86: ideapad-laptop:=
 Add module parameters to match DMI quirk tables)
Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging devicetree-fixes/dt/linus (60d865bd5a9b of: property: decrement nod=
e refcount in of_fwnode_get_reference_args())
Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging scsi-fixes/fixes (f014165faa7b scsi: iscsi: Fix possible memory lea=
k when device_register() failed)
Merging drm-fixes/drm-fixes (b7b275e60bcd Linux 6.1-rc7)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (b7b275e60bcd Linux 6.1-rc7)
Merging mmc-fixes/fixes (a3cab1d21324 mmc: sdhci-esdhc-imx: correct CQHCI e=
xit halt state check)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
Merging gnss-fixes/gnss-linus (247f34f7b803 Linux 6.1-rc2)
Merging hyperv-fixes/hyperv-fixes (25c94b051592 Drivers: hv: vmbus: fix pos=
sible memory leak in vmbus_device_register())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (fcae44fd36d0 RISC-V: vdso: Do not add missing s=
ymbols to version section in linker script)
Merging riscv-dt-fixes/riscv-dt-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging spdx/spdx-linus (6cad1ecd4e32 testing: use the copyleft-next-0.3.1 =
SPDX tag)
Merging gpio-brgl-fixes/gpio/for-current (ec851b23084b gpiolib: fix memory =
leak in gpiochip_setup_dev())
Merging gpio-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging erofs-fixes/fixes (37020bbb71d9 erofs: fix missing xas_retry() in f=
scache mode)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (618887768bb7 kunit: update NULL vs IS_ERR(=
) tests)
Merging ubifs-fixes/fixes (7bdd6967fec5 ubi: ensure that VID header offset =
+ VID header size <=3D alloc, size)
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (ac8db824ead0 NFSD: Fix reads with a non-zero offs=
et that don't end on a page boundary)
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
Merging drm-misc-fixes/for-linux-next-fixes (a6a00d7e8ffd fbcon: Use kzallo=
c() in fbcon_prepare_logo())
Merging kbuild/for-next (8818039f959b kbuild: add ability to make source rp=
m buildable using koji)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (0c3852adae83 Merge remote-tracking branch 'torvalds=
/master' into perf/core)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (ffcb75458460 dma-mapping: reject __GFP_COMP i=
n dma_alloc_attrs)
CONFLICT (content): Merge conflict in sound/core/memalloc.c
Merging asm-generic/master (5e5ff73c2e58 asm-generic/io: Add _RET_IP_ to MM=
IO trace for more accurate debug info)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (834f757d299e Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (1de8ff3d6b60 Merge branches 'for-next/acpi', '=
for-next/asm-const', 'for-next/cpufeature', 'for-next/dynamic-scs', 'for-ne=
xt/errata', 'for-next/fpsimd', 'for-next/ftrace', 'for-next/insn', 'for-nex=
t/kbuild', 'for-next/kdump', 'for-next/mm', 'for-next/perf', 'for-next/self=
tests', 'for-next/stacks', 'for-next/trivial', 'for-next/uaccess' and 'for-=
next/undef-traps' into for-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (e377f2aeadda soc: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (e57e6bb6476d Merge branch 'v6.2/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (6924945aaa86 Merge branch 'asahi-soc/=
soc' into asahi-soc/for-next)
Merging aspeed/for-next (45c86167adde soc: nuvoton: Add SoC info driver for=
 WPCM450)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/nuvoton-wpcm450-sup=
ermicro-x9sci-ln4f.dts
Merging at91/at91-next (fb18447f4da5 Merge branch 'at91-defconfig' into at9=
1-next)
Merging broadcom/next (64610429f8de Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (53ad523ac435 ARM: davinci: fix repeated w=
ords in comments)
Merging drivers-memory/for-next (8dd7e4af5853 memory: omap-gpmc: fix coveri=
ty issue "Control flow issues")
Merging imx-mxs/for-next (e114f7b74f59 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (6b6221595e05 Merge branch 'v6.2-tmp/dts64' into =
for-next)
Merging mvebu/for-next (ce88856dec4f Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (6435241fd536 Merge branch 'musb-for-v6.2' into for-n=
ext)
Merging qcom/for-next (4d2b529bce12 Merge branches 'arm64-defconfig-for-6.2=
', 'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2', 'drivers-for-6.2', =
'dts-for-6.2' and 'arm64-fixes-for-6.1' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (00841e945654 Merge branch 'renesas-arm-dt-for-v6.2' i=
nto renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (db6c57f2afd5 Merge branch 'v6.2-clock/next' into=
 for-next)
Merging samsung-krzk/for-next (4407a1eb1faf Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (907b02743965 Merge branch 'for-next/juno' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (4cca342b840e ARM: dts: stm32: Rename mdio0 to mdi=
o on DHCOR Testbench board)
Merging sunxi/sunxi/for-next (47be7c123211 Merge branch 'sunxi/clk-for-6.2'=
 into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (d71332dded9d Merge branch for-6.2/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (6a5ab20fb961 Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (58f0622adf00 Merge branch 'zynqmp/dt' into for-nex=
t)
Merging clk/clk-next (ebb6a9acf2e0 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (8178e245fa95 clk: imx: rename imx_obtain_fixed_cl=
k_hw() to imx_get_clk_hw_by_name())
Merging clk-renesas/renesas-clk (777bcc85e1fb clk: renesas: r8a779f0: Fix E=
thernet Switch clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (7e2004906fb5 Revert "csky: Add support for restart=
able sequence")
Merging loongarch/loongarch-next (247f34f7b803 Linux 6.1-rc2)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (b7b275e60bcd Linux 6.1-rc7)
Merging microblaze/next (5cfe469c2654 microblaze/PCI: Moving PCI iounmap an=
d dependent code)
Merging mips/mips-next (c5ed1fe0801f MIPS: vpe-cmp: fix possible memory lea=
k while module exiting)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (a77319726641 parisc: Fix kgdb_pdc console keybo=
ard input)
Merging powerpc/next (a9ffb8ee7b65 powerpc: Use "grep -E" instead of "egrep=
")
Merging powerpc-objtool/topic/objtool (a39818a3fb2b objtool/powerpc: Implem=
ent arch_pc_relative_reloc())
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (effae0e3d9e1 riscv: Kconfig: Enable cpufreq kconfi=
g menu)
Merging riscv-dt/riscv-dt-for-next (4563db4b7988 Merge branch 'riscv-thead_=
c9xx' into riscv-dt-for-next)
Merging riscv-soc/riscv-soc-for-next (8fbf94fea0b4 soc: sifive: ccache: fix=
 missing of_node_put() in sifive_ccache_init())
Merging s390/for-next (e3d93340dfa6 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/next (193cb8372424 uml: Remove the initialization of statics to=
 0)
Merging xtensa/xtensa-for-next (b8c4f4db2436 xtensa: update config files)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (e95f86d0c525 Merge branch 'fs.ovl.setgid' i=
nto for-next)
Merging fscrypt/master (aa9979900808 fscrypt: add comment for fscrypt_valid=
_enc_modes_v1())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (1dd7bb25658d afs: remove afs_cache_netfs and afs_zap_=
permits() declarations)
Merging btrfs/for-next (07d7d9dff0c8 Merge branch 'for-next-next-v6.1-20221=
123' into for-next-20221123)
CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
Applying: btrfs: fix up for "fs: pass dentry to set acl method"
Merging ceph/master (5bd76b8de5b7 ceph: fix NULL pointer dereference for re=
q->r_session)
Merging cifs/for-next (587506fda17c cifs: Parse owner/group for stat in smb=
311 posix extensions)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (0717326aca9f erofs: switch to prepare_ondemand_read() in=
 fscache mode)
Merging exfat/dev (612d2ddeed4d exfat: replace magic numbers with Macros)
Merging ext3/for_next (6b46bb32a8b5 Pull ext2 fixes from Al and Rong Tao.)
Merging ext4/dev (4e3c51f4e805 fs: do not update freeing inode i_io_list)
Merging f2fs/dev (967eaad1fed5 f2fs: fix to set flush_merge opt and show no=
flush_merge)
Merging fsverity/fsverity (3764b89a7dc5 fsverity: stop using PG_error to tr=
ack error status)
Merging fuse/for-next (1b0e94993dbe fuse: optional supplementary group in c=
reate requests)
Merging gfs2/for-next (288fc8606762 Merge tag 'gfs2-nopid-for-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (5e40d197b564 ksmbd: use F_SETLK when unlockin=
g a file)
Merging nfs/linux-next (5776a9cd2a66 NFS: Fix a race in nfs_call_unlink())
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (40f2e475046f SUNRPC: Fix crasher in unwrap_integ_dat=
a())
Merging ntfs3/master (36963cf225f8 fs/ntfs3: Make if more readable)
CONFLICT (content): Merge conflict in fs/ntfs3/bitmap.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Applying: fix up for "fs: rename current get acl method"
Merging orangefs/for-next (2ad4b6f5e117 Orangefs: change iterate to iterate=
_shared)
Merging overlayfs/overlayfs-next (58f40d56c40a ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (669d204469c4 ubi: fastmap: Add fastmap control support =
for 'UBI_IOCATT' ioctl)
Merging v9fs/9p-next (391c18cf776e 9p/xen: check logical size for buffer si=
ze)
Merging xfs/for-next (28b4b0596343 xfs: fix incorrect i_nlink caused by ino=
de racing)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (f1bd37a47352 iomap: directly use logical bloc=
k size)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (0513283941f6 Add process name and pid to loc=
ks warning)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (7b2f9d90994c Merge branch 'work.misc' into for-next)
CONFLICT (content): Merge conflict in fs/erofs/fscache.c
Merging printk/for-next (11f1e536902b Merge branch 'for-6.2' into for-next)
Merging pci/next (0a9dc1e9365b Merge branch 'pci/kbuild')
Merging pstore/for-next/pstore (38b91847c314 pstore: Alert on backend write=
 error)
Merging hid/for-next (780f0d711574 Merge branch 'for-6.1/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (ee98d665b461 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (9494c53e1389 hwmon: (aquacomputer_d5next)=
 Add support for Quadro flow sensor pulses)
Merging jc_docs/docs-next (520076d5df31 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (a7bab6f8b73f Merge tag 'br-v6.2e' of git://linuxtv.=
org/hverkuil/media_tree into media_stage)
Merging v4l-dvb-next/master (6a5a4514854a media: ipu3-cio2: make the bridge=
 depend on i2c)
Merging pm/linux-next (dee69e7005ce Merge branches 'thermal-core' and 'ther=
mal-intel' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (4370232c727b cpufreq: qcom-hw: =
Add CPU clock provider support)
Merging cpupower/cpupower (5975e2558e2d tools/cpupower: Choose base_cpu to =
display default cpupower details)
Merging devfreq/devfreq-next (5fdded844892 PM/devfreq: governor: Add a priv=
ate governor_data for governor)
Merging opp/opp/linux-next (dba79b78ecc1 dt-bindings: opp-v2: Fix clock-lat=
ency-ns prop in example)
Merging thermal/thermal/linux-next (9d2bc364f677 thermal/drivers/qcom/tsens=
: Simplify debugfs init function)
CONFLICT (content): Merge conflict in drivers/thermal/thermal_sysfs.c
$ git merge --abort
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (7a5e9f1f83e3 fs: dlm: fix building without lockdep)
Merging rdma/for-next (b4d46c57d2fb RDMA/erdma: Fix a typo in annotation)
Merging net-next/master (c672e3727989 octeontx2-pf: Add support to filter p=
acket based on IP fragment)
CONFLICT (content): Merge conflict in tools/perf/util/stat.c
$ git reset --hard HEAD^
Merging next-20221125 version of net-next
CONFLICT (content): Merge conflict in tools/perf/util/stat.c
[master 1e3008e84da4] next-20221125/net-next
Merging bpf-next/for-next (2b3e8f6f5b93 docs/bpf: Add BPF_MAP_TYPE_XSKMAP d=
ocumentation)
CONFLICT (content): Merge conflict in include/linux/bpf.h
CONFLICT (content): Merge conflict in tools/lib/bpf/ringbuf.c
Merging ipsec-next/master (b198d7b40ad9 Merge branch 'xfrm: add extack supp=
ort to some more message types')
Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (f492d22c0e7f dt-bindings: bluetooth: broadcom: ad=
d BCM43430A0 & BCM43430A1)
Merging wireless-next/for-next (eceb024ee3ee Merge ath-next from git://git.=
kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mtd/mtd/next (2399401feee2 mtd: maps: pxa2xx-flash: fix memory leak=
 in probe)
Merging nand/nand/next (6408cc05a50a mtd: rawnand: Drop obsolete dependenci=
es on COMPILE_TEST)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/brcm,brcmnand.yaml
Merging spi-nor/spi-nor/next (1799cd8540b6 mtd: spi-nor: add SFDP fixups fo=
r Quad Page Program)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/jedec,spi-nor.yaml
Merging crypto/master (83478938f78f hwrng: u2fzero - account for high quali=
ty RNG)
Merging drm/drm-next (2847b6681547 Merge tag 'mediatek-drm-next-6.2' of htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-ne=
xt)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_gem=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_job=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_ttm=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_mst_types.c
Merging drm-misc/for-linux-next (b02897e56b4e Revert "drm/fb-helper: Perfor=
m damage handling in deferred-I/O helper")
Merging amdgpu/drm-next (10d2d1fc05f0 drm/amdgpu: Partially revert "drm/amd=
gpu: update drm_display_info correctly when the edid is read")
Merging drm-intel/for-linux-next (3d335a523b93 Merge tag 'drm-intel-next-20=
22-11-18' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-tegra/for-next (08fef75f5e17 gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (d73b1d02de08 drm/msm: Hangcheck progress detectio=
n)
Merging drm-msm-lumag/msm-next-lumag (8d1d17d47eae Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi' and 'msm-next-lumag-mdp5' into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (a3b4c2f9b039 drm/etnaviv: switch to PFN mappi=
ngs)
Merging fbdev/for-next (652888c46397 fbdev: ep93xx-fb: Add missing clk_disa=
ble_unprepare in ep93xxfb_probe())
Merging regmap/for-next (23a441cb2cbe Merge remote-tracking branch 'regmap/=
for-6.2' into regmap-next)
Merging sound/for-next (e4baf8453646 ALSA: pcm: fix tracing reason in hw_pt=
r_error)
Merging sound-asoc/for-next (35ffc87fd6aa Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-next)
Merging modules/modules-next (c86a514f5fad kallsyms: Remove unneeded semico=
lon)
Merging input/next (9f4211bf7f81 HID: add mapping for camera access keys)
Merging block/for-next (115724d2cc4d Merge branch 'for-6.2/block' into for-=
next)
CONFLICT (content): Merge conflict in io_uring/net.c
Merging device-mapper/for-next (984bf2cc531e dm integrity: clear the journa=
l on suspend)
Merging libata/for-next (3d8a3ae3d966 ata: libata: fix commands incorrectly=
 not getting retried during NCQ error)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (cb713d1f69ae memstick/ms_block: Add check for alloc_order=
ed_workqueue)
Merging mfd/for-mfd-next (2c9918463543 mfd: tc6393xb: Remove #ifdef guards =
for PM related functions)
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (571650b3a30f power: supply: bq25890: Only use pda=
ta->regulator_init_data for vbus)
Merging regulator/for-next (ac4c72aa67dd Merge remote-tracking branch 'regu=
lator/for-6.2' into regulator-next)
Merging security/next (572302af1258 reiserfs: Add missing calls to reiserfs=
_security_free())
CONFLICT (content): Merge conflict in security/commoncap.c
Merging apparmor/apparmor-next (4295c60bbe9e apparmor: Fix uninitialized sy=
mbol 'array_size' in policy_unpack_test.c)
CONFLICT (content): Merge conflict in security/apparmor/domain.c
Merging integrity/next-integrity (25369175ce84 ima: Fix misuse of dereferen=
ce of pointer in template_desc_init_fields())
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
Merging tpmdd/next (beaff73d55b3 tpm: tpm_tis: Add the missed acpi_put_tabl=
e() to fix memory leak)
Merging watchdog/master (9ec0b7e06835 watchdog: aspeed: Enable pre-timeout =
interrupt)
Merging iommu/next (69a6c7d969f5 Merge branches 'arm/allwinner', 'arm/exyno=
s', 'arm/mediatek', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 's390', 'x86/vt=
-d', 'x86/amd' and 'core' into next)
Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode_=
name(), syscall()})
Merging devicetree/for-next (876c881f9f41 dt-bindings: leds: sgm3140: Docum=
ent ocp8110 compatible)
Merging dt-krzk/for-next (043d4036e8ee Merge branch 'next/dt' into for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (1652433287cf Merge remote-tracking branch 'spi/for-6.=
2' into spi-next)
Merging tip/master (7613c41a0d75 Merge x86/cache into tip/master)
CONFLICT (content): Merge conflict in arch/x86/crypto/sha1_ni_asm.S
CONFLICT (content): Merge conflict in arch/x86/crypto/sha256-avx-asm.S
CONFLICT (content): Merge conflict in arch/x86/crypto/sha256-avx2-asm.S
CONFLICT (content): Merge conflict in arch/x86/crypto/sha256-ssse3-asm.S
CONFLICT (content): Merge conflict in arch/x86/crypto/sha256_ni_asm.S
CONFLICT (content): Merge conflict in arch/x86/crypto/sm3-avx-asm_64.S
CONFLICT (content): Merge conflict in arch/x86/crypto/sm4-aesni-avx-asm_64.S
CONFLICT (content): Merge conflict in arch/x86/crypto/sm4-aesni-avx2-asm_64=
.S
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
CONFLICT (modify/delete): drivers/iommu/iommu-sva-lib.c deleted in HEAD and=
 modified in tip/master.  Version tip/master of drivers/iommu/iommu-sva-lib=
.c left in tree.
CONFLICT (content): Merge conflict in drivers/pci/controller/Kconfig
CONFLICT (content): Merge conflict in drivers/pci/controller/dwc/Kconfig
CONFLICT (content): Merge conflict in drivers/pci/controller/mobiveil/Kconf=
ig
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/hmm=
/hmm_bo.c
CONFLICT (content): Merge conflict in tools/objtool/check.c
$ git rm -f drivers/iommu/iommu-sva-lib.c
Applying: fix up for "iommu: Rename iommu-sva-lib.{c,h}"
Merging clockevents/timers/drivers/next (af246cc6d0ed clocksource/drivers/a=
rm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value)
Merging edac/edac-for-next (ad5befcd0e1d Merge branch 'edac-misc' into edac=
-for-next)
Merging irqchip/irq/irqchip-next (73d95dbcf75e Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (bd604f3db49c ftrace: Avoid needless updates of the=
 ftrace function call)
Merging rcu/rcu/next (39035b41bccb tools/memory-model: Use "grep -E" instea=
d of "egrep")
Merging kvm/next (d72cf8ffe460 Merge tag 'kvm-s390-master-6.1-1' of https:/=
/git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (34afaeadba94 Merge branch kvm-arm64/pmu-unchained int=
o kvmarm-master/next)
Merging kvms390/next (bedac519eefa s390/vfio-ap: check TAPQ response code w=
hen waiting for queue reset)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Merging xen-tip/linux-next (1e9b10076d75 x86/xen: Fix memory leak in xen_in=
it_lock_cpu())
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (e32354bb8fe3 platform/x86/intel/hid: Add modu=
le-params for 5 button array + SW_TABLET_MODE reporting)
Merging chrome-platform/for-next (5a2d96623670 platform/chrome: cros_usbpd_=
notify: Fix error handling in cros_usbpd_notify_init())
Merging hsi/for-next (3ffa9f713c39 HSI: omap_ssi_core: Fix error handling i=
n ssi_init())
Merging leds/for-next (5f52a8ba7e91 dt-bindings: leds: Add 'cpuX' to 'linux=
,default-trigger')
Merging ipmi/for-next (0eb1762f3c77 ipmi/watchdog: Include <linux/kstrtox.h=
> when appropriate)
Merging driver-core/driver-core-next (ff62b8e6588f driver core: make struct=
 class.devnode() take a const *)
$ git reset --hard HEAD^
Merging next-20221125 version of driver-core
Merging usb/usb-next (9d1566e1f36b Merge 6.1-rc7 into usb-next)
Merging thunderbolt/next (a5cfc9d65879 thunderbolt: Add wake on connect/dis=
connect on USB4 ports)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (e88906b169eb USB: serial: cp210x: add Kamstrup=
 RF sniffer PIDs)
Merging tty/tty-next (6373ab4dfee7 serial: atmel: don't stop the transmitte=
r when doing PIO)
Merging char-misc/char-misc-next (6e6df27064aa Merge tag 'iio-fixes-for-6.1=
d' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-m=
isc-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/addac/adi,ad74413r.yaml
CONFLICT (content): Merge conflict in drivers/firmware/raspberrypi.c
Merging coresight/next (c767c3474013 coresight: etm4x: fix repeated words i=
n comments)
Merging fpga/for-next (ee31d5038c06 dt-bindings: fpga: document Lattice sys=
CONFIG FPGA manager)
Merging icc/icc-next (26e90ec7a840 Merge branch 'icc-sc8280xp-l3' into icc-=
next)
Merging iio/togreg (f84eec02b724 iio: addac: ad74413r: fix blank line after=
 declaration warning)
Merging phy-next/next (bea3ce759b46 phy: ti: phy-j721e-wiz: add j721s2-wiz-=
10g module support)
Merging soundwire/next (7cbf00bd4142 soundwire: intel: split auxdevice to d=
ifferent file)
Merging extcon/extcon-next (de05153ffce5 extcon: usbc-tusb320: Convert to i=
2c's .probe_new())
Merging gnss/gnss-next (247f34f7b803 Linux 6.1-rc2)
Merging vfio/next (2f5d8cef45c3 vfio/mlx5: Fix a typo in mlx5vf_cmd_load_vh=
ca_state())
Merging staging/staging-next (9dadff066244 staging: iio: ade7854: Convert t=
o i2c's .probe_new())
Merging counter-next/counter-next (30a0b95b1335 Linux 6.1-rc3)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (3a0c95b61385 dmaengine: tegra: Add support for dma-=
channel-mask)
Merging cgroup/for-next (674b745e22b3 cgroup: remove rcu_read_lock()/rcu_re=
ad_unlock() in critical section of spin_lock_irq())
Merging scsi/for-next (0cfd1fc5a347 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (4e80eef45ad7 scsi: sg: Fix get_user() in call sg=
_scsi_ioctl())
Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
Merging rpmsg/for-next (56d906bb66a7 Merge branches 'rproc-next' and 'hwspi=
nlock-next' into for-next)
CONFLICT (content): Merge conflict in include/linux/firmware/xlnx-zynqmp.h
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (4ef339bc053a gpiolib: Unify access to the =
device properties)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging gpio-intel/for-next (8d259847243d gpiolib: cdev: Fix typo in kernel=
 doc for struct line)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (c05e8b14f374 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging pinctrl-intel/for-next (b14ef61314b3 pinctrl: intel: Add Intel Moor=
efield pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (80d34260f36c pinctrl: renesas: gpi=
o: Use dynamic GPIO base if no function GPIOs)
Merging pinctrl-samsung/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging pwm/for-next (50315945d178 dt-bindings: pwm: renesas,tpu: Add r8a77=
9g0 support)
Merging userns/for-next (b5df013cd194 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, retire_mq_sys=
ctls-for-v5.19, and unpriv-ipc-sysctls-for-v6.2 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (00dd59519141 selftests: splice_read: Fix sysfs read=
 cases)
Merging kunit/test (9abf2313adc1 Linux 6.1-rc1)
Merging kunit-next/kunit (11300092f6f4 kunit: improve KTAP compliance of KU=
nit test output)
CONFLICT (content): Merge conflict in lib/kunit/string-stream.c
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (a6ceee26fd5e rtc: pcf85063: Fix reading alarm)
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
Merging nvmem/for-next (18133a57a935 dt-bindings: nvmem: add YAML schema fo=
r the ONIE tlv layout)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (fea858dc5d90 iommu/hyper-v: Allow hyperv irq re=
mapping without x2apic)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (094226ad94f4 Linux 6.1-rc5)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (5562c6a9657e bus: mhi: host: pci_generic: Add definit=
ion for some VIDs)
Merging memblock/for-next (80c2fe022ef5 memblock tests: remove completed TO=
DO item)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging cxl/next (3b39fd6cf12c cxl: Replace HDM decoder granularity magic n=
umbers)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (196dff2712ca efi: random: combine bootloader provided RNG=
 seed with RNG protocol output)
CONFLICT (modify/delete): arch/x86/boot/compressed/efi_thunk_64.S deleted i=
n HEAD and modified in efi/next.  Version efi/next of arch/x86/boot/compres=
sed/efi_thunk_64.S left in tree.
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/Makefile
$ git rm -f arch/x86/boot/compressed/efi_thunk_64.S
Applying: fix up for "efi: libstub: Permit mixed mode return types other th=
an efi_status_t"
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (c2216860479e Merge branch 'slub-tiny-v1r6' into slab=
/for-next)
CONFLICT (content): Merge conflict in include/linux/percpu.h
Merging random/master (f6c78a73202c random: remove extraneous period in com=
ment)
Merging landlock/next (0b4ab8cd635e Merge tag 'landlock-6.1-rc4' into landl=
ock-next)
Merging rust/rust-next (fd9517a1603f init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
Merging execve/for-next/execve (cd57e443831d exec: Remove FOLL_FORCE for st=
ack setup)
CONFLICT (content): Merge conflict in fs/binfmt_elf.c
Merging bitmap/bitmap-for-next (27bc50fc9064 Merge tag 'mm-stable-2022-10-0=
8' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging hte/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging kspp/for-next/kspp (9af98f78d2cd mm/pgtable: Fix multiple -Wstringo=
p-overflow warnings)
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging unsigned-char/unsigned-char (0445d1bae1cc lib: assume char is unsig=
ned)
Merging iommufd/for-next (86f4f88ede4c Merge tag 'v6.1-rc6' into iommufd.gi=
t for-next)
Merging mm-stable/mm-stable (ea0ffd0c08d0 swap: add a limit for readahead p=
age-cluster value)
CONFLICT (content): Merge conflict in mm/hugetlb.c
Merging mm-nonmm-stable/mm-nonmm-stable (7b9cbc7701d5 scripts/spelling.txt:=
 add more spellings to spelling.txt)
Merging mm/mm-everything (a722cd8e3f2d Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/damon/sysfs.c
CONFLICT (content): Merge conflict in mm/gup.c
CONFLICT (content): Merge conflict in mm/huge_memory.c

--Sig_/e6XvzWPIYDqREDkeK2L/99p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOFeQcACgkQAVBC80lX
0GzwzggAiyxP9q5cuk3DPGEtV2AX0IZuWSB8zj1V/5DlktE1cjRczR6jThVO6klq
QO3rvZGThP2Icz4RCkg36Gg8jhVMk5qI2/tBY2FVzISgHLXsPpLQkAL3rfweOMXw
o91R/k7wuqJYozzlTKUCrzFMBSJMkVj6WwReiiwHe3rpVUusrSnn5u3TuioHcAYH
7m9BCSFYnIGYfiahoJhjIfhyFD2RVybKEuT73/R4zTIwUphqh7Wo5mUn0yC+zjde
n+tYt++Kh70TnpD2mJWmGS5ixeaWiGXglqmYm1KukGFB5lsysxfwwf+ipNTT0pTt
bRzyL0IPafAz6J/v3dwO1KetdjZBQA==
=CCqz
-----END PGP SIGNATURE-----

--Sig_/e6XvzWPIYDqREDkeK2L/99p--
