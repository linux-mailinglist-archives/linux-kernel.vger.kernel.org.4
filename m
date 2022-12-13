Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64064AEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiLMEvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiLMEvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:51:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35518B00;
        Mon, 12 Dec 2022 20:51:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWR056xkQz4xP9;
        Tue, 13 Dec 2022 15:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670907062;
        bh=ltv4Ljux3VyG9T9Ij0MWSUc/F8eblmOUf3ksOWrRFB8=;
        h=Date:From:To:Cc:Subject:From;
        b=gVH1ueSF4FJP8+dU3VnfrIwT7pMXTQqYAA8pvrhlUh9MXmrgLFnl4nHentYbt0087
         EHXGaYD9stMddeO5JJXkiZLOZaSTm9Q+/2HlfcWylHkMmnhZU1hiCLa2JGCdq0m4kn
         1TY0MT4iy61AH1s5U3tw9TxmIeLbz+JDyv6gR0UWtydFi6OGC0JPCmf/1RNNw4ZgH+
         1Dn6vf6lQvGG/yfB6msVlK8ZyKUDweWJiNy0El3B/AiCynGOA6iaIDTShaMVvMGj3T
         /FiN3RbgulsslMpD87Df29ZKgBhu+F0EqX9hn9KnAFg1KimvDnvYGout9CIwYaGZNo
         xRWXu3dFNA64w==
Date:   Tue, 13 Dec 2022 15:51:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 13
Message-ID: <20221213155100.04e8b17e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z0E=W8q0/TJJEz5KkeHeqZD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z0E=W8q0/TJJEz5KkeHeqZD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221208:

Removed tree: unsigned-char (finished with)

The mm-hotfixes tree gained a build failure for which I reverted a commit.

The risc-v tree gained a conflict against Linus' tree.

The thermal tree lost its complex conflicts.

The fbdev tree gained a conflict against the drm tree.

The tip tree gained a build failure for which I reverted a commit.

The efi tree gained a conflict against Linus' tree.

The random tree gained a build failure so I used the version from
next-20221208.

Non-merge commits (relative to Linus' tree): 11593
 10584 files changed, 494936 insertions(+), 196146 deletions(-)

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

I am currently merging 369 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (691806e977a3 Merge tag 'thermal-6.2-rc1' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (b7edf4b1cdb1 mm: hwpoison: suppor=
t recovery from ksm_might_need_to_copy())
Applying: Revert "mm: hwpoison: support recovery from ksm_might_need_to_cop=
y()"
Merging kbuild-current/fixes (869e4ae4cd2a nios2: add FORCE for vmlinuz.gz)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (73a0b6ee5d62 ARM: 9278/1: kfence: only handle tr=
anslation faults)
Merging arm64-fixes/for-next/fixes (b7d9aae40484 Revert "arm64: dma: Drop c=
ache invalidation from arch_dma_prep_coherent()")
Merging arm-soc-fixes/arm/fixes (ef19964da8a6 Revert "ARM: dts: imx7: Fix N=
AND controller size-cells")
Merging davinci-current/davinci/for-current (9abf2313adc1 Linux 6.1-rc1)
Merging drivers-memory-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (553b20b211c4 m68k: defconfig: Update defcon=
figs for v6.1-rc1)
Merging powerpc-fixes/fixes (2e7ec190a0e3 powerpc/64s: Add missing declarat=
ion for machine_check_early_boot())
Merging s390-fixes/fixes (adba1a9b81d5 MAINTAINERS: add S390 MM section)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (a38a211e9e0c Merge branch 'mptcp-fix-ipv6-reqsk-ops-and=
-some-netlink-error-codes')
Merging bpf/master (01de1123322e drivers: net: qlcnic: Fix potential memory=
 leak in qlcnic_sriov_init())
Merging ipsec/master (1799c1b85e29 Merge branch '40GbE' of git://git.kernel=
.org/pub/scm/linux/kernel/git/tnguy/net-queue)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (3e8f7abcc347 wifi: mac8021: fix possible oob acc=
ess in ieee80211_get_rate_duration)
Merging rdma-fixes/for-rc (094226ad94f4 Linux 6.1-rc5)
Merging sound-current/for-linus (b47068b4aa53 Merge tag 'asoc-fix-v6.1-rc7'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (3d1bb6cc1a65 ASoC: cs42l51: Correct PGA=
 Volume minimum value)
Merging regmap-fixes/for-linus (84498d1fb35d regmap-irq: Use the new num_co=
nfig_regs property in regmap_add_irq_chip_fwnode)
Merging regulator-fixes/for-linus (02228f6aa6a6 regulator: da9211: Use irq =
handler when ready)
Merging spi-fixes/for-linus (648caa567416 Merge remote-tracking branch 'spi=
/for-6.0' into spi-linus)
Merging pci-current/for-linus (ac9ccce8717d MAINTAINERS: Include PCI bindin=
gs in host bridge entry)
Merging driver-core.current/driver-core-linus (eb7081409f94 Linux 6.1-rc6)
Merging tty.current/tty-linus (eb7081409f94 Linux 6.1-rc6)
Merging usb.current/usb-linus (b7b275e60bcd Linux 6.1-rc7)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (188c9c2e0c7f USB: serial: f81534: fix d=
ivision by zero on line-speed change)
Merging phy/fixes (819b885cd886 phy: ralink: mt7621-pci: add sentinel to qu=
irks table)
Merging staging.current/staging-linus (eb7081409f94 Linux 6.1-rc6)
Merging iio-fixes/fixes-togreg (95e3f901f7b1 iio: imu: fxos8700: fix ACCEL =
measurement range selection)
Merging counter-current/counter-current (fd5ac974fc25 counter: stm32-lptime=
r-cnt: fix the check on arr and cmp registers update)
Merging char-misc.current/char-misc-linus (b7b275e60bcd Linux 6.1-rc7)
Merging soundwire-fixes/fixes (49a467310dc4 soundwire: qcom: check for outa=
nding writes before doing a read)
Merging thunderbolt-fixes/fixes (830b3c68c1fb Linux 6.1)
Merging input-current/for-linus (e291c116f60f Merge branch 'next' into for-=
linus)
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
Merging backlight-fixes/for-backlight-fixes (8ab33943cde7 backlight: pwm_bl=
: Drop support for legacy PWM probing)
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
Merging kvm-fixes/master (34e30ebbe48c KVM: Document the interaction betwee=
n KVM_CAP_HALT_POLL and halt_poll_ns)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (76dcd734eca2 Linux 6.1-rc8)
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
Merging drivers-x86-fixes/fixes (e4678483f9bc platform/x86/amd: pmc: Add a =
workaround for an s0i3 issue on Cezanne)
Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging devicetree-fixes/dt/linus (60d865bd5a9b of: property: decrement nod=
e refcount in of_fwnode_get_reference_args())
Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging scsi-fixes/fixes (f014165faa7b scsi: iscsi: Fix possible memory lea=
k when device_register() failed)
Merging drm-fixes/drm-fixes (c4252650a8c4 Merge tag 'drm-misc-fixes-2022-12=
-08' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (830b3c68c1fb Linux 6.1)
Merging mmc-fixes/fixes (76dcd734eca2 Linux 6.1-rc8)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
Merging gnss-fixes/gnss-linus (247f34f7b803 Linux 6.1-rc2)
Merging hyperv-fixes/hyperv-fixes (25c94b051592 Drivers: hv: vmbus: fix pos=
sible memory leak in vmbus_device_register())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (39cefc5f6cd2 RISC-V: Fix a race condition durin=
g kernel stack overflow)
Merging riscv-dt-fixes/riscv-dt-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging spdx/spdx-linus (6cad1ecd4e32 testing: use the copyleft-next-0.3.1 =
SPDX tag)
Merging gpio-brgl-fixes/gpio/for-current (63ff545af73f gpio/rockchip: fix r=
efcount leak in rockchip_gpiolib_register())
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
Merging efi-fixes/urgent (7572ac3c979d arm64: efi: Revert "Recover from syn=
chronous exceptions ...")
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (767e684367e4 power: supply: ab8500: Defer ther=
mal zone probe)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (30a0b95b1335 Linux 6.1-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (c4252650a8c4 Merge tag 'drm-mi=
sc-fixes-2022-12-08' of git://anongit.freedesktop.org/drm/drm-misc into drm=
-fixes)
Merging kbuild/for-next (4bf73588165b kbuild: Port silent mode detection to=
 future gnu make.)
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
Merging arm/for-next (1907710cab84 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (5f4c374760b0 Merge branch 'for-next/undef-trap=
s' into for-next/core)
Merging arm-perf/for-next/perf (4361251cef46 arm_pmu: Drop redundant armpmu=
->map_event() in armpmu_event_init())
Merging arm-soc/for-next (9e86b8206ade Merge branch 'soc/dt' into for-next)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (e57e6bb6476d Merge branch 'v6.2/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (296921e39d36 Merge branch 'asahi-soc/=
dt' into asahi-soc/for-next)
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
Merging qcom/for-next (7608329e874c Merge branches 'arm64-defconfig-for-6.2=
', 'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2', 'drivers-for-6.2' a=
nd 'dts-for-6.2' into for-next)
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
Merging scmi/for-linux-next (76dcd734eca2 Linux 6.1-rc8)
Merging stm32/stm32-next (4cca342b840e ARM: dts: stm32: Rename mdio0 to mdi=
o on DHCOR Testbench board)
Merging sunxi/sunxi/for-next (47be7c123211 Merge branch 'sunxi/clk-for-6.2'=
 into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (65de8bad744b Merge branch for-6.2/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (6a5ab20fb961 Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (8d8f1c4d6675 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (0e2c9884cbba Merge branches 'clk-mediatek', 'clk-trac=
e', 'clk-qcom' and 'clk-microchip' into clk-next)
Merging clk-imx/for-next (8178e245fa95 clk: imx: rename imx_obtain_fixed_cl=
k_hw() to imx_get_clk_hw_by_name())
Merging clk-renesas/renesas-clk (777bcc85e1fb clk: renesas: r8a779f0: Fix E=
thernet Switch clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (7e2004906fb5 Revert "csky: Add support for restart=
able sequence")
Merging loongarch/loongarch-next (a82b165c888a LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (af5d74e32eb8 m68k: use strscpy() to instead of =
strncpy())
Merging microblaze/next (5cfe469c2654 microblaze/PCI: Moving PCI iounmap an=
d dependent code)
Merging mips/mips-next (4c587a982603 MIPS: OCTEON: warn only once if deprec=
ated link status is being used)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (60c95270ef64 parisc: Align parisc MADV_XXX cons=
tants with all other architectures)
Merging powerpc/next (13959373e9c9 powerpc/qspinlock: Fix 32-bit build)
Merging powerpc-objtool/topic/objtool (a39818a3fb2b objtool/powerpc: Implem=
ent arch_pc_relative_reloc())
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (d01404fa7b8c Merge patch series "riscv: alternativ=
e-macros.h cleanups")
CONFLICT (content): Merge conflict in arch/riscv/configs/defconfig
Merging riscv-dt/riscv-dt-for-next (4563db4b7988 Merge branch 'riscv-thead_=
c9xx' into riscv-dt-for-next)
Merging riscv-soc/riscv-soc-for-next (8fbf94fea0b4 soc: sifive: ccache: fix=
 missing of_node_put() in sifive_ccache_init())
Merging s390/for-next (286c89ef3b34 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/next (43ee0357e15b um: vector: Fix memory leak in vector_config)
Merging xtensa/xtensa-for-next (8939c58d68f9 xtensa: add __umulsidi3 helper)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (e175af42241c Merge branch 'fs.acl.rework' i=
nto for-next)
Merging fscrypt/master (41952551acb4 fscrypt: add additional documentation =
for SM4 support)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (1dd7bb25658d afs: remove afs_cache_netfs and afs_zap_=
permits() declarations)
Merging btrfs/for-next (d1a1795bb77b Merge branch 'for-next-next-v6.1-20221=
205' into for-next-20221205)
CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
Applying: btrfs: fix up for "fs: pass dentry to set acl method"
Merging ceph/master (68c62bee9d08 ceph: try to check caps immediately after=
 async creating finishes)
Merging cifs/for-next (f7f291e14dde cifs: fix oops during encryption)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (c505feba4c0d erofs: validate the extent length for uncom=
pressed pclusters)
Merging exfat/dev (7064197e9f89 exfat: reuse exfat_find_location() to simpl=
ify exfat_get_dentry_set())
Merging ext3/for_next (1acc506685db Merge UDF hole handling fixes.)
Merging ext4/dev (1da18e38cb97 ext4: fix reserved cluster accounting in __e=
s_remove_extent())
Merging f2fs/dev (7411143f2021 f2fs: fix some format WARNING in debug.c and=
 sysfs.c)
Merging fsverity/fsverity (a4bbf53d88c7 fsverity: simplify fsverity_get_dig=
est())
Merging fuse/for-next (1b0e94993dbe fuse: optional supplementary group in c=
reate requests)
Merging gfs2/for-next (b4cc2cee751c gfs2: Simplify function gfs2_upgrade_io=
pen_glock)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (72ee45fd46d0 ksmbd: Convert to use sysfs_emit=
()/sysfs_emit_at() APIs)
Merging nfs/linux-next (7fd461c47c6c NFSv4.2: Change the default KConfig va=
lue for READ_PLUS)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (e78e274eb22d NFSD: Avoid clashing function prototype=
s)
Merging ntfs3/master (36963cf225f8 fs/ntfs3: Make if more readable)
CONFLICT (content): Merge conflict in fs/ntfs3/bitmap.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Applying: fix up for "fs: rename current get acl method"
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (637d13b57d85 ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (8d0960731a26 jffs2: Fix list_del corruption if compress=
ors initialized failed)
Merging v9fs/9p-next (07ef71b3d83d 9p/client: fix data race on req->status)
Merging xfs/for-next (4883f57a2d86 xfs: remove restrictions for fsdax and r=
eflink)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (f1bd37a47352 iomap: directly use logical bloc=
k size)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (f2f2494c8aa3 Add process name and pid to loc=
ks warning)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (9ea606dbbc50 Merge branch 'work.misc' into for-next)
CONFLICT (content): Merge conflict in fs/binfmt_elf.c
CONFLICT (content): Merge conflict in fs/erofs/fscache.c
Merging printk/for-next (348af86ecc06 Merge branch 'rework/console-list-loc=
k' into for-next)
Merging pci/next (f826afe5eae8 Merge branch 'pci/kbuild')
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/pci=
/snps,dw-pcie.yaml
Merging pstore/for-next/pstore (e6b842741b4f pstore: Avoid kcore oops by vm=
ap()ing with VM_IOREMAP)
Merging hid/for-next (d9beee49918d Merge branch 'for-6.2/hid-bpf' into for-=
next)
Merging i2c/i2c/for-next (38cf3e4fa7d0 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (08dcf0732cb4 MAINTAINERS: mark I3C DRIVER FOR SYNOPSY=
S DESIGNWARE orphan)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (364ffd2537c4 hwmon: (emc2305) fix pwm nev=
er being able to set lower)
Merging jc_docs/docs-next (c2016863bbfd Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (3178804c64ef Merge tag 'br-v6.2i' of git://linuxtv.=
org/hverkuil/media_tree into media_stage)
CONFLICT (content): Merge conflict in drivers/media/common/videobuf2/frame_=
vector.c
Merging v4l-dvb-next/master (3178804c64ef Merge tag 'br-v6.2i' of git://lin=
uxtv.org/hverkuil/media_tree into media_stage)
Merging pm/linux-next (25f35436e149 Merge branch 'acpi-ec-next' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (8ff150aa6fe2 dt-bindings: cpufr=
eq: cpufreq-qcom-hw: Add QDU1000/QRU1000 cpufreq)
Merging cpupower/cpupower (8c37df3d635e cpupower: rapl monitor - shows the =
used power consumption in uj for each rapl domain)
Merging devfreq/devfreq-next (7fc7f25419f5 PM / devfreq: event: use devm_pl=
atform_get_and_ioremap_resource())
Merging opp/opp/linux-next (d61525e07e69 dt-bindings: opp: opp-v2-kryo-cpu:=
 Add missing 'cache-unified' property in example)
Merging thermal/thermal/linux-next (c64c9a768c09 Revert "thermal/sysfs: Rem=
ove unnecessary check in trip_point_hyst_show()")
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (7a5e9f1f83e3 fs: dlm: fix building without lockdep)
Merging rdma/for-next (dbc94a0fb817 IB/IPoIB: Fix queue count inconsistency=
 for PKEY child interfaces)
Merging net-next/master (8150f0cfb24f Merge branch 'bridge-mcast-extensions=
-for-evpn')
CONFLICT (content): Merge conflict in tools/perf/util/stat.c
Merging bpf-next/for-next (15eb16217621 dt-bindings: net: Convert Socionext=
 NetSec Ethernet to DT schema)
Merging ipsec-next/master (abe2343d37c2 xfrm: Fix spelling mistake "oflload=
" -> "offload")
Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (7aca0ac4792e Bluetooth: Wait for HCI_OP_WRITE_AUT=
H_PAYLOAD_TO to complete)
Merging wireless-next/for-next (832c3f66f53f Merge tag 'iwlwifi-next-for-ka=
lle-2022-12-07' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/i=
wlwifi-next)
Merging mtd/mtd/next (a34506e08db7 Merge tag 'spi-nor/for-6.2' into mtd/nex=
t)
Merging nand/nand/next (6408cc05a50a mtd: rawnand: Drop obsolete dependenci=
es on COMPILE_TEST)
Merging spi-nor/spi-nor/next (1799cd8540b6 mtd: spi-nor: add SFDP fixups fo=
r Quad Page Program)
Merging crypto/master (453de3eb08c4 crypto: ux500/cryp - delete driver)
Merging drm/drm-next (66efff515a65 Merge tag 'amd-drm-next-6.2-2022-12-07' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_gem=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_job=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_ttm=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_gt.c
Merging drm-misc/for-linux-next (b02897e56b4e Revert "drm/fb-helper: Perfor=
m damage handling in deferred-I/O helper")
Merging amdgpu/drm-next (1d4624cd72b9 drm/amdgpu: handle polaris10/11 overl=
ap asics (v2))
Merging drm-intel/for-linux-next (d4d4c6fbae38 drm/i915/perf: Do not parse =
context image for HSW)
Merging drm-tegra/for-next (08fef75f5e17 gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (d73b1d02de08 drm/msm: Hangcheck progress detectio=
n)
Merging drm-msm-lumag/msm-next-lumag (1eca2464c1db dt-bindings: msm/dsi: Do=
n't require vcca-supply on 14nm PHY)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (1e7a215378a7 drm/etnaviv: convert user fence =
tracking to XArray)
Merging fbdev/for-next (225e095bbd3a fbdev: offb: make offb driver tristate)
CONFLICT (content): Merge conflict in drivers/video/fbdev/Kconfig
Merging regmap/for-next (e6bc64403134 Merge remote-tracking branch 'regmap/=
for-6.2' into regmap-next)
Merging sound/for-next (ee0b089d6600 ALSA: hda/hdmi: fix stream-id config k=
eep-alive for rt suspend)
Merging sound-asoc/for-next (e85b1f5a9769 ASoC: dt-bindings: fsl-sai: Reins=
tate i.MX93 SAI compatible string)
Merging modules/modules-next (b7d23abc80f1 livepatch: Call klp_match_callba=
ck() in klp_find_callback() to avoid code duplication)
Merging input/next (c3991107a28a Input: elants_i2c - delay longer with rese=
t asserted)
Merging block/for-next (36c17b90feae Merge branch 'for-6.2/io_uring-next' i=
nto for-next)
CONFLICT (content): Merge conflict in io_uring/net.c
Merging device-mapper/for-next (7991dbff6849 dm thin: Use last transaction'=
s pmd->root when commit failed)
Merging libata/for-next (f07788079f51 ata: ahci: fix enum constants for gcc=
-13)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (ff874dbc4f86 mmc: sdhci-sprd: Disable CLK_AUTO when the c=
lock is less than 400K)
Merging mfd/for-mfd-next (1ca8a011ddca dt-bindings: Fix maintainer email fo=
r a few ROHM ICs)
Merging backlight/for-backlight-next (0de796b6047d backlight: tosa: Convert=
 to i2c's .probe_new())
Merging battery/for-next (104bb8a66345 power: supply: fix null pointer dere=
ferencing in power_supply_get_battery_info)
Merging regulator/for-next (064021c4977e Merge remote-tracking branch 'regu=
lator/for-6.2' into regulator-next)
Merging security/next (577cc1434e4c lsm: Fix description of fs_context_pars=
e_param)
CONFLICT (content): Merge conflict in security/commoncap.c
Merging apparmor/apparmor-next (4295c60bbe9e apparmor: Fix uninitialized sy=
mbol 'array_size' in policy_unpack_test.c)
CONFLICT (content): Merge conflict in security/apparmor/domain.c
Merging integrity/next-integrity (b6018af440a0 ima: Fix hash dependency to =
correct algorithm)
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
Merging tomoyo/master (be9c59066d8e workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (eaabc245b02a tpm: st33zp24: remove pointless checks on =
probe)
Merging watchdog/master (9ec0b7e06835 watchdog: aspeed: Enable pre-timeout =
interrupt)
Merging iommu/next (e3eca2e4f648 Merge branches 'arm/allwinner', 'arm/exyno=
s', 'arm/mediatek', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 's390', 'x86/vt=
-d', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in include/linux/iommu.h
Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode_=
name(), syscall()})
Merging devicetree/for-next (580f9896e088 dt-bindings: leds: Add missing re=
ferences to common LED schema)
Merging dt-krzk/for-next (0c2cd289d0bd Merge branch 'next/dt' into for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (29c73939d3e3 Merge remote-tracking branch 'spi/for-6.=
2' into spi-next)
Merging tip/master (892cd97d2c73 Merge branch into tip/master: 'locking/urg=
ent')
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
CONFLICT (content): Merge conflict in drivers/clocksource/arm_arch_timer.c
CONFLICT (content): Merge conflict in drivers/clocksource/arm_arch_timer.c
CONFLICT (modify/delete): drivers/iommu/iommu-sva-lib.c deleted in HEAD and=
 modified in tip/master.  Version tip/master of drivers/iommu/iommu-sva-lib=
.c left in tree.
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/hmm=
/hmm_bo.c
CONFLICT (content): Merge conflict in tools/objtool/check.c
$ git rm -f drivers/iommu/iommu-sva-lib.c
Applying: fix up for "iommu: Rename iommu-sva-lib.{c,h}"
Applying: fix up for "mm: Pass down mm_struct to untagged_addr()"
Applying: Revert "x86/mm: Fix sparse warnings in untagged_ptr()"
Merging clockevents/timers/drivers/next (83571a438903 dt-bindings: timer: r=
enesas,cmt: Add r8a779g0 CMT support)
Merging edac/edac-for-next (ad5befcd0e1d Merge branch 'edac-misc' into edac=
-for-next)
Merging irqchip/irq/irqchip-next (6ed54e1789a2 Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (3ffea0bc4bbb Merge branch 'trace/probes/for-next' =
into trace/for-next)
Merging rcu/rcu/next (1ab6c3f2e923 Merge branch 'nolibc.2022.10.28a' into H=
EAD)
Merging kvm/next (9352e7470a1b Merge remote-tracking branch 'kvm/queue' int=
o HEAD)
CONFLICT (content): Merge conflict in arch/x86/include/asm/cpufeatures.h
CONFLICT (content): Merge conflict in arch/x86/kvm/cpuid.c
CONFLICT (content): Merge conflict in include/linux/mm.h
Merging kvm-arm/next (753d734f3f34 Merge remote-tracking branch 'arm64/for-=
next/sysregs' into kvmarm-master/next)
Merging kvms390/next (bedac519eefa s390/vfio-ap: check TAPQ response code w=
hen waiting for queue reset)
Merging xen-tip/linux-next (8b997b2bb2c5 xen/privcmd: Fix a possible warnin=
g in privcmd_ioctl_mmap_resource())
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
CONFLICT (content): Merge conflict in include/linux/percpu.h
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (b0b698b80c56 platform/mellanox: mlxbf-pmc: Fi=
x event typo)
Merging chrome-platform/for-next (c88d317f7473 platform/chrome: use sysfs_e=
mit() instead of scnprintf())
Merging hsi/for-next (3ffa9f713c39 HSI: omap_ssi_core: Fix error handling i=
n ssi_init())
Merging leds/for-next (7cb092a0336c leds: MAINTAINERS: include dt-bindings =
headers)
Merging ipmi/for-next (c6f613e5f35b ipmi/watchdog: use strscpy() to instead=
 of strncpy())
Merging driver-core/driver-core-next (f18caf261398 device property: Fix doc=
umentation for fwnode_get_next_parent())
CONFLICT (modify/delete): drivers/block/pktcdvd.c deleted in HEAD and modif=
ied in driver-core/driver-core-next.  Version driver-core/driver-core-next =
of drivers/block/pktcdvd.c left in tree.
CONFLICT (content): Merge conflict in include/linux/blkdev.h
$ git rm -f drivers/block/pktcdvd.c
Applying: fix up for "drivers/accel: define kconfig and register a new majo=
r"
Merging usb/usb-next (81c25247a2a0 usb: gadget: uvc: Rename bmInterfaceFlag=
s -> bmInterlaceFlags)
Merging thunderbolt/next (a5cfc9d65879 thunderbolt: Add wake on connect/dis=
connect on USB4 ports)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (63b8ed26cd09 USB: serial: xr: avoid requesting=
 zero DTE rate)
Merging tty/tty-next (6373ab4dfee7 serial: atmel: don't stop the transmitte=
r when doing PIO)
Merging char-misc/char-misc-next (f361c96c7518 Merge tag 'extcon-next-for-6=
.2' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into ch=
ar-misc-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/adc/qcom,spmi-vadc.yaml
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/addac/adi,ad74413r.yaml
CONFLICT (content): Merge conflict in drivers/firmware/raspberrypi.c
Merging accel/habanalabs-next (ef197f0eb758 habanalabs: fix wrong variable =
type used for vzalloc)
Merging coresight/next (c767c3474013 coresight: etm4x: fix repeated words i=
n comments)
Merging fpga/for-next (ee31d5038c06 dt-bindings: fpga: document Lattice sys=
CONFIG FPGA manager)
Merging icc/icc-next (26e90ec7a840 Merge branch 'icc-sc8280xp-l3' into icc-=
next)
Merging iio/togreg (0dec19b344b5 iio: light: tsl2563: Keep Makefile sorted =
by module name)
Merging phy-next/next (bea3ce759b46 phy: ti: phy-j721e-wiz: add j721s2-wiz-=
10g module support)
Merging soundwire/next (7cbf00bd4142 soundwire: intel: split auxdevice to d=
ifferent file)
Merging extcon/extcon-next (5313121b22fd extcon: usbc-tusb320: Convert to i=
2c's .probe_new())
Merging gnss/gnss-next (247f34f7b803 Linux 6.1-rc2)
Merging vfio/next (70be6f322860 vfio/mlx5: error pointer dereference in err=
or handling)
Merging staging/staging-next (37aa6b982370 vme: Use root_device_register() =
not underlined version)
Merging counter-next/counter-next (30a0b95b1335 Linux 6.1-rc3)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (25483dedd2f5 dmaengine: Revert "dmaengine: remove s=
3c24xx driver")
Merging cgroup/for-next (674b745e22b3 cgroup: remove rcu_read_lock()/rcu_re=
ad_unlock() in critical section of spin_lock_irq())
Merging scsi/for-next (a8e23ee4dedc Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (68ad83188d78 scsi: qla2xxx: Fix crash when I/O a=
bort times out)
Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
Merging rpmsg/for-next (b3af356e6243 Merge branches 'rproc-next' and 'hwspi=
nlock-next' for-next)
CONFLICT (content): Merge conflict in include/linux/firmware/xlnx-zynqmp.h
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (bdbbae241a04 gpiolib: protect the GPIO dev=
ice against being dropped while in use by user-space)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging gpio-intel/for-next (8d259847243d gpiolib: cdev: Fix typo in kernel=
 doc for struct line)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (6c19feafb377 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/soc/fsl/qe/gpio.c
Merging pinctrl-intel/for-next (b14ef61314b3 pinctrl: intel: Add Intel Moor=
efield pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (80d34260f36c pinctrl: renesas: gpi=
o: Use dynamic GPIO base if no function GPIOs)
Merging pinctrl-samsung/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging pwm/for-next (8fa22f4b88e8 pwm: pca9685: Convert to i2c's .probe_ne=
w())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (88a51b4f2e65 ktest.pl: Add shell commands to variab=
les)
Merging kselftest/next (d5ba85d6d8be selftests/ftrace: Use long for synthet=
ic event probe test)
Merging kunit/test (9abf2313adc1 Linux 6.1-rc1)
Merging kunit-next/kunit (054be257f28c Documentation: dev-tools: Clarify re=
quirements for result description)
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack.c
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Applying: fixup for "apparmor: make unpack_array return a trianary value"
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (b279e3276c24 dt-bindings: rtc: m41t80: Mark the clock=
: subnode as deprecated)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging ntb/ntb-next (1a3f7484e076 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (b9069728a70c seccomp: document the "filte=
r_count" field)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (94c40c9882f1 slimbus: qcom-ngd: Add check for pla=
tform_driver_register)
Merging nvmem/for-next (18133a57a935 dt-bindings: nvmem: add YAML schema fo=
r the ONIE tlv layout)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (32c97d980e2e x86/hyperv: Remove unregister sysc=
ore call from Hyper-V cleanup)
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
Merging cxl/next (f04facfb993d cxl/region: Fix memdev reuse check)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (c2530a04a73e arm64: efi: Account for the EFI runtime stac=
k in stack unwinder)
CONFLICT (content): Merge conflict in arch/arm64/kernel/stacktrace.c
CONFLICT (content): Merge conflict in arch/loongarch/kernel/efi.c
CONFLICT (modify/delete): arch/x86/boot/compressed/efi_thunk_64.S deleted i=
n HEAD and modified in efi/next.  Version efi/next of arch/x86/boot/compres=
sed/efi_thunk_64.S left in tree.
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/Makefile
$ git rm -f arch/x86/boot/compressed/efi_thunk_64.S
Applying: fix up for "efi: libstub: Permit mixed mode return types other th=
an efi_status_t"
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (dc19745ad0e4 Merge branch 'slub-tiny-v1r6' into slab=
/for-next)
Merging random/master (5d1056fb3dd8 random: do not include <asm/archrandom.=
h> from random.h)
CONFLICT (content): Merge conflict in include/linux/percpu.h
CONFLICT (content): Merge conflict in kernel/events/core.c
$ git reset --hard HEAD^
Merging next-20221208 version of random
Merging landlock/next (0b4ab8cd635e Merge tag 'landlock-6.1-rc4' into landl=
ock-next)
Merging rust/rust-next (b9ecf9b9ac59 rust: types: add `Opaque` type)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
Merging execve/for-next/execve (6a46bf558803 binfmt_misc: fix shift-out-of-=
bounds in check_special_flags)
Merging bitmap/bitmap-for-next (6f1e040c80ed lib/cpumask: update comment fo=
r cpumask_local_spread())
Merging hte/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging kspp/for-next/kspp (d272e01fa0a2 ksmbd: replace one-element arrays =
with flexible-array members)
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (d6c55c0a20e5 iommufd: Change the order of MSI set=
up)
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
CONFLICT (content): Merge conflict in drivers/vfio/Makefile
CONFLICT (content): Merge conflict in drivers/vfio/vfio_main.c
Applying: vfio: fix up for "driver core: make struct class.devnode() take a=
 const *"
Merging mm-stable/mm-stable (c45bc55a9995 mm/hugetlb: set head flag before =
setting compound_order in __prep_compound_gigantic_folio)
CONFLICT (content): Merge conflict in drivers/media/common/videobuf2/frame_=
vector.c
CONFLICT (content): Merge conflict in mm/hugetlb.c
Merging mm-nonmm-stable/mm-nonmm-stable (12b677f2c697 ipc: fix memory leak =
in init_mqueue_fs())
Merging mm/mm-everything (51b0cdaec129 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)

--Sig_/z0E=W8q0/TJJEz5KkeHeqZD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOYBLQACgkQAVBC80lX
0GzOGAf7BLihNldJTxOUCdpK3oh7zBidngbD+vv/hrt3SlgF3Bsy/oQ0wR7bJPdB
1tqDLar/+uK2drjRu4LlnvAkTZo+Lnq2gsS+t4RcgbhObr2VYjWi90GrdqursuoZ
8EQBcMm/CHj+sjkdwQDpPaROZMrg7igtbaXE6QXAQij1qhCAzvnFGhyR9bNCbE9V
K1iZv2/s7y4H5vjOEXbNJyR0910P8H51ru2jVIK9IdK0un2C16jilj8/pbFo0dwS
XRfzc0OqMYToOOWsdlG3PgoBIrEvpWifw0v7DDZxBNyfq0QauaejPnIt62amBzZc
76Mihb3QlD4IX8uewX5jDBlmzY717A==
=PUZl
-----END PGP SIGNATURE-----

--Sig_/z0E=W8q0/TJJEz5KkeHeqZD--
