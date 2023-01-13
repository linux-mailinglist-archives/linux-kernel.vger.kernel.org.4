Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A254668A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjAMD5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjAMD5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:57:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4011A3A5;
        Thu, 12 Jan 2023 19:57:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtSLM1bKGz4xGq;
        Fri, 13 Jan 2023 14:57:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673582267;
        bh=2nyjR68jUk3qf/mZdQTQWOb6g1YT+5kkoeUCy2yQktA=;
        h=Date:From:To:Cc:Subject:From;
        b=qGLSoGIhND5UVvzqfM3/cAnG+tg+skIJDjXcmj9GseQklDx4fxaOJZTXKy+kLySSE
         v2bmUWS2LkD/dM6DDDs6TwSSuC824U1nr6jg/biWXzfMQ69tFcoV700OuO8JM+d8Wj
         19JTwwmIShZP8ypFfIaJ8F65qQCDRurbGJU+EEB5qPmR8l1jsHn9/487Ig4DljY5f8
         mi9gl+DgVmsUrmHNjiRiQlTFa18cc453JfyJSY3muUUDyA760qXl6baRjdBnSvXesC
         nUSGELgR/7N1XZmp7AEktVqQA41QV9quBW/s4Yom9i+CWOdfkGNmKcmXzazBFwnhpx
         WdTuQCFSBxyPA==
Date:   Fri, 13 Jan 2023 14:57:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 13
Message-ID: <20230113145746.1c7f51ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qbVDvdKV2B7a65aWjGZx2bH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qbVDvdKV2B7a65aWjGZx2bH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230112:

The drm-misc-fixes tree gained a build failure so I used the version
from next-20230112.

The btrfs tree gained a build failure so I used the version from
next-20230112.

The net-next tree gained a conflict against the net tree.

Non-merge commits (relative to Linus' tree): 4120
 4977 files changed, 137651 insertions(+), 212032 deletions(-)

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

I am currently merging 354 trees (counting Linus' and 99 trees of bug
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
Merging origin/master (c757fc92a3f7 Merge tag 'spi-fix-v6.2-rc3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (c7ec356e0228 mm: hwposion: suppor=
t recovery from ksm_might_need_to_copy())
Merging kbuild-current/fixes (169dd78043f7 scripts: rpm: make clear that mk=
spec script contains 4.13 feature)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (3cb0f23039e0 ARM: 9284/1: include <asm/pgtable.h=
> from proc-macros.S to fix -Wundef warnings)
Merging arm64-fixes/for-next/fixes (68a63a412d18 arm64: Fix build with CC=
=3Dclang, CONFIG_FTRACE=3Dy and CONFIG_STACK_TRACER=3Dy)
Merging arm-soc-fixes/arm/fixes (45c734817847 Merge tag 'arm-soc/for-6.2/dr=
ivers-fixes' of https://github.com/Broadcom/stblinux into arm/fixes)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (553b20b211c4 m68k: defconfig: Update defcon=
figs for v6.1-rc1)
Merging powerpc-fixes/fixes (76d588dddc45 powerpc/imc-pmu: Fix use of mutex=
 in IRQs disabled section)
Merging s390-fixes/fixes (1ecf7bd9c267 s390: update defconfigs)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (be53771c87f4 r8152: add vendor/device ID pair for Micro=
soft Devkit)
Merging bpf/master (e7895f017b79 bpf: remove the do_idr_lock parameter from=
 bpf_prog_free_id())
Merging ipsec/master (b0355dbbf13c Fix XFRM-I support for nested ESP tunnel=
s)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (696e1a48b1a1 netfilter: nft_payload: incorrect arithme=
tics when fetching VLAN header bits)
Merging wireless/for-next (f216033d770f wifi: mac80211: fix MLO + AP_VLAN c=
heck)
Merging rdma-fixes/for-rc (b7bfaa761d76 Linux 6.2-rc3)
Merging sound-current/for-linus (84aa3059f42f Merge tag 'asoc-fix-v6.2-rc3'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (64e57b219572 ASoC: Intel: sof_es8336: D=
rop reference count of ACPI device after use)
Merging regmap-fixes/for-linus (f309b44844bd Merge remote-tracking branch '=
regmap/for-6.1' into regmap-linus)
Merging regulator-fixes/for-linus (f528fe213a6a regulator: qcom-rpmh: PM855=
0 ldo11 regulator is an nldo)
Merging spi-fixes/for-linus (50028988403a spi: spidev: remove debug message=
s that access spidev->spi without locking)
Merging pci-current/for-linus (ac729baefdc3 x86/pci: Treat EfiMemoryMappedI=
O as reservation of ECAM space)
Merging driver-core.current/driver-core-linus (b7bfaa761d76 Linux 6.2-rc3)
Merging tty.current/tty-linus (b7bfaa761d76 Linux 6.2-rc3)
Merging usb.current/usb-linus (b7bfaa761d76 Linux 6.2-rc3)
Merging usb-serial-fixes/usb-linus (8a43bf34c862 USB: serial: cp210x: add S=
CALANCE LPE-9000 device id)
Merging phy/fixes (ec4a1d930110 phy: renesas: r8a779f0-eth-serdes: Fix regi=
ster setting)
Merging staging.current/staging-linus (b7bfaa761d76 Linux 6.2-rc3)
Merging iio-fixes/fixes-togreg (bffb7d9d1a3d iio:adc:twl6030: Enable measur=
ement of VAC)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (b7bfaa761d76 Linux 6.2-rc3)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (84ee211c8321 thunderbolt: Disable XDomain =
lane 1 only in software connection manager)
Merging input-current/for-linus (3c44e2b6cde6 Revert "Input: synaptics - sw=
itch touchpad on HP Laptop 15-da3001TU to RMI mode")
Merging crypto-current/master (736f88689c69 crypto: arm64/sm4 - fix possibl=
e crash with CFI enabled)
Merging vfio-fixes/for-linus (895c0747f726 vfio/type1: Respect IOMMU reserv=
ed regions in vfio_test_domain_fgsp())
Merging kselftest-fixes/fixes (9fdaca2c1e15 kselftest: Fix error message fo=
r unconfigured LLVM builds)
Merging modules-fixes/modules-linus (4f1354d5c6a3 livepatch: Call klp_match=
_callback() in klp_find_callback() to avoid code duplication)
Merging dmaengine-fixes/fixes (f96a483f8e13 MAINTAINERS: update Jie Hai's e=
mail address)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c0f7ae27539f MAINTAINERS: Update email of Tudo=
r Ambarus)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (542d3c03fd89 media: sun6i-isp: params: Unregis=
ter pending buffer on cleanup)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (88603b6dc419 Linux 6.2-rc2)
Merging at91-fixes/at91-fixes (9bfa2544dbd1 ARM: dts: at91: sam9x60: fix th=
e ddr clock for sam9x60)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (310bc39546a4 KVM: x86/xen: Avoid deadlock by addi=
ng kvm->arch.xen.xen_lock leaf node lock)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (2fbb848b65cd hwmon: (nct6775) Fix incorrect pare=
nthesization in nct6775_write_fan_div())
Merging nvdimm-fixes/libnvdimm-fixes (472faf72b33d device-dax: Fix duplicat=
e 'hmem' device registration)
Merging cxl-fixes/fixes (2ec1b17f745b cxl: fix cxl_report_and_clear() RAS U=
E addr mis-assignment)
Merging btrfs-fixes/next-fixes (41a230615a6b Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (9c7417b5ec44 coredump: Move dump_emit_page() to ki=
ll unused warning)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (cf5ac2d45f6e platform/x86: int3472/discret=
e: Ensure the clk/power enable pins are in output mode)
Merging samsung-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (064e32dc5b03 of: fdt: Honor CONFIG_CMDLI=
NE* even without /chosen node, take 2)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (f58c89700630 scsi: hisi_sas: Set a port invalid o=
nly if there are no devices attached when refreshing port id)
Merging drm-fixes/drm-fixes (5193326c4c5a Merge tag 'drm-intel-fixes-2023-0=
1-05' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (58fc14e14d28 drm/i915/gt: Cov=
er rest of SVG unit MCR registers)
Merging mmc-fixes/fixes (8509419758f2 mmc: sunxi-mmc: Fix clock refcount im=
balance during unbind)
Merging rtc-fixes/rtc-fixes (51b3802e7960 dt-bindings: rtc: qcom-pm8xxx: al=
low 'wakeup-source' property)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (25c94b051592 Drivers: hv: vmbus: fix pos=
sible memory leak in vmbus_device_register())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (b9b916aee671 riscv: uaccess: fix type of 0 vari=
able on error in get_user())
Merging riscv-dt-fixes/riscv-dt-fixes (43d5f5d63699 riscv: dts: sifive: fu7=
40: fix size of pcie 32bit memory)
Merging riscv-soc-fixes/riscv-soc-fixes (730892135b7d soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging spdx/spdx-linus (1b929c02afd3 Linux 6.2-rc1)
Merging gpio-brgl-fixes/gpio/for-current (694175cd8a16 gpio: sifive: Fix re=
fcount leak in sifive_gpio_probe)
Merging gpio-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging erofs-fixes/fixes (12724ba38992 erofs: fix kvcalloc() misuse with _=
_GFP_NOFAIL)
Merging kunit-fixes/kunit-fixes (88603b6dc419 Linux 6.2-rc2)
Merging ubifs-fixes/fixes (7bdd6967fec5 ubi: ensure that VID header offset =
+ VID header size <=3D alloc, size)
Merging memblock-fixes/fixes (115d9d77bb0f mm: Always release pages to the =
buddy allocator in memblock_free_late().)
Merging cel-fixes/for-rc (7c24fa225081 NFSD: replace delayed_work with work=
_struct for nfsd_client_shrinker)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (c757fc92a3f7 Merge tag 'spi-fix-v6.2-rc3'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging efi-fixes/urgent (608509b15a31 efi: tpm: Avoid READ_ONCE() for acce=
ssing the event log)
Merging zstd-fixes/zstd-linus (70d822cfb782 Merge branch 'zstd-next' into z=
std-linus)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging rust-fixes/rust-fixes (b7bfaa761d76 Linux 6.2-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (07a2975c65f2 drm/vc4: bo: Fix =
drmm_mutex_init memory hog)
$ git reset --hard HEAD^
Merging next-20230112 version of drm-misc-fixes
Merging kbuild/for-next (83344be3eb46 kbuild: rust: move rust/target.json t=
o scripts/)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (3622b86f49f8 dma-mapping: reject GFP_COMP for=
 noncoherent allocations)
Merging asm-generic/master (32975c491ee4 uapi: Add missing _UAPI prefix to =
<asm-generic/types.h> include guard)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (28ee13271c06 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (aaf846bef4e0 Merge branches 'for-next/sysreg',=
 'for-next/sme', 'for-next/kselftest' and 'for-next/misc' into for-next/cor=
e)
Merging arm-perf/for-next/perf (4361251cef46 arm_pmu: Drop redundant armpmu=
->map_event() in armpmu_event_init())
Merging arm-soc/for-next (94ac29dc59d0 Merge branch 'arm/boardfile-remove-w=
ip' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc into for-nex=
t)
Merging amlogic/for-next (5e7cdf919589 Merge branch 'v6.3/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging aspeed/for-next (45c86167adde soc: nuvoton: Add SoC info driver for=
 WPCM450)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/nuvoton-wpcm450-sup=
ermicro-x9sci-ln4f.dts
Merging at91/at91-next (dac8e2394ccc Merge branch 'at91-fixes' into at91-ne=
xt)
Merging broadcom/next (64610429f8de Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (eaafab7e8e26 MAINTAINERS: make me the mai=
ntainer of DaVinci platforms)
Merging drivers-memory/for-next (13f35b3c72f4 Merge branch 'for-v6.3/renesa=
s-rpc-if' into for-next)
Merging imx-mxs/for-next (beb902cee34c Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (c7a343cf1811 Merge branch 'v6.2-next/soc' into f=
or-next)
Merging mvebu/for-next (80502ffab2fa arm64: dts: marvell: AC5/AC5X: Fix add=
ress for UART1)
Merging omap/for-next (6435241fd536 Merge branch 'musb-for-v6.2' into for-n=
ext)
CONFLICT (content): Merge conflict in arch/arm/mach-omap1/Kconfig
Merging qcom/for-next (4166ff125e67 Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-fixes-for-6.2', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-fixes-fo=
r-6.2', 'drivers-for-6.3', 'dts-fixes-for-6.2' and 'dts-for-6.3' into for-n=
ext)
Merging renesas/next (1f57de01e0be Merge branch 'renesas-dts-for-v6.3' into=
 renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (832be9b52224 Merge branch 'v6.3-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (d3e7aeb494b2 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (98333bf901c3 Merge commit 'e325285de2cd' into =
for-linux-next)
Merging stm32/stm32-next (3f5ea53d7977 ARM: dts: stm32: add dfsdm node on s=
tm32mp131)
Merging sunxi/sunxi/for-next (7879da4e62f1 Merge branch 'sunxi/drivers-for-=
6.3' into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ti/ti-next (1b929c02afd3 Linux 6.2-rc1)
Merging xilinx/for-next (a7669037d438 Merge remote-tracking branch 'git/zyn=
qmp/soc' into for-next)
Merging clk/clk-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-imx/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-renesas/renesas-clk (fbfd614aeaa2 clk: renesas: cpg-mssr: Fix u=
se after free if cpg_mssr_common_init() failed)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (5535f4f70cfc LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (8fbf1bb2410e m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (5cfe469c2654 microblaze/PCI: Moving PCI iounmap an=
d dependent code)
Merging mips/mips-next (88603b6dc419 Linux 6.2-rc2)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (32125c5c95f2 parisc: Limit amount of kgdb break=
points on parisc)
Merging powerpc/next (1b929c02afd3 Linux 6.2-rc1)
Merging powerpc-objtool/topic/objtool (1b929c02afd3 Linux 6.2-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (b07de94d4501 Merge patch series "Allow calls in al=
ternatives")
CONFLICT (content): Merge conflict in arch/riscv/kernel/probes/simulate-ins=
n.h
Merging riscv-dt/riscv-dt-for-next (093ee97e24f8 Merge tag 'soc2arch-immuta=
ble' into riscv-dt-for-next)
Merging riscv-soc/riscv-soc-for-next (6635e91648ce soc: sifive: ccache: Add=
 StarFive JH7110 support)
Merging s390/for-next (8634630e9a4f Merge branch 'features' into for-next)
Merging uml/next (43ee0357e15b um: vector: Fix memory leak in vector_config)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (4e1da8fe0313 posix_acl: Use try_cmpxchg in =
get_acl)
Merging fscrypt/master (41952551acb4 fscrypt: add additional documentation =
for SM4 support)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (98e89a12003c Merge branch 'for-next-next-v6.2-20230=
112' into for-next-20230112)
CONFLICT (content): Merge conflict in fs/btrfs/tree-log.c
$ git reset --hard HEAD^
Merging next-20230112 version of btrfs
Merging ceph/master (8e1858710d9a ceph: avoid use-after-free in ceph_fl_rel=
ease_lock())
Merging cifs/for-next (a152d05ae4a7 cifs: Fix uninitialized memory read for=
 smb311 posix symlink create)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (b7bfaa761d76 Linux 6.2-rc3)
Merging exfat/dev (15b0de571a39 exfat: fix inode->i_blocks for non-512 byte=
 sector size device)
Merging ext3/for_next (1fb40763a58c udf: remove redundant variable netype)
Merging ext4/dev (1da18e38cb97 ext4: fix reserved cluster accounting in __e=
s_remove_extent())
Merging f2fs/dev (7a2b15cfa8db f2fs: support accounting iostat count and av=
g_bytes)
Merging fsverity/fsverity (db85d14dc5c5 ext4: allow verity with fs block si=
ze < PAGE_SIZE)
Merging fuse/for-next (1b0e94993dbe fuse: optional supplementary group in c=
reate requests)
Merging gfs2/for-next (6b46a06100dd gfs2: Remove support for glock holder a=
uto-demotion (2))
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (83dcedd5540d ksmbd: fix infinite loop in ksmb=
d_conn_handler_loop())
Merging nfs/linux-next (b7bfaa761d76 Linux 6.2-rc3)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (7269a5a256d3 SUNRPC: Replace pool stats with per-CPU=
 variables)
CONFLICT (content): Merge conflict in fs/nfsd/nfs4state.c
CONFLICT (content): Merge conflict in fs/nfsd/nfsctl.c
Merging ntfs3/master (e3ab3260c918 fs/ntfs3: fix spelling mistake "attibute=
" -> "attribute")
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (637d13b57d85 ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (8d0960731a26 jffs2: Fix list_del corruption if compress=
ors initialized failed)
Merging v9fs/9p-next (1a4f69ef15ec 9p/client: fix data race on req->status)
Merging xfs/for-next (601a27ea09a3 xfs: fix extent busy updating)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (f1bd37a47352 iomap: directly use logical bloc=
k size)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (c65454a94726 fs: remove locks_inode)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (557e0248a8a0 Merge branch 'work.misc' into for-next)
Merging printk/for-next (146e448200be Merge branch 'rework/buffers-cleanup'=
 into for-next)
Merging pci/next (1b929c02afd3 Linux 6.2-rc1)
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (bd92d2065ad1 Merge branch 'for-6.2/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (59b3484a571e Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (e826acc18bc7 i3c: transfer pid from boardinfo to devi=
ce info)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (b0587c87abc8 hwmon: (coretemp) Simplify p=
latform device handling)
Merging jc_docs/docs-next (730d88a72cc4 Merge branches 'docs-mw' and 'docs-=
fixes' into docs-next)
Merging v4l-dvb/master (6599e683db1b Merge tag 'v6.2-rc1' into media_tree)
Merging v4l-dvb-next/master (d4acfa22b634 media: sun6i-isp: params: Unregis=
ter pending buffer on cleanup)
Merging pm/linux-next (837dc62247d5 Merge branch 'pm-cpuidle' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (08f0adb193c0 cpufreq: armada-37=
xx: stop using 0 as NULL pointer)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (67052d09900b dt-bindings: cpufreq: cpufreq-qcom=
-hw: Add missing compatibles)
Merging thermal/thermal/linux-next (3a151494dc04 thermal/drivers/armada: Us=
e strscpy() to instead of strncpy())
Merging dlm/next (aa7f4a21f6e5 fs/dlm: Remove "select SRCU")
Merging rdma/for-next (bd99ede8ef2d RDMA/irdma: Remove extra ret variable i=
n favor of existing err)
Merging net-next/master (55b98837e37d Merge branch 'vsock-update-tools-and-=
error-handling')
CONFLICT (content): Merge conflict in drivers/net/usb/r8152.c
Merging bpf-next/for-next (db473df28906 Merge branch 'selftests/xsk: speed-=
ups, fixes, and new XDP programs')
Merging ipsec-next/master (7e68dd7d07a2 Merge tag 'net-next-6.2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mlx5-next/mlx5-next (1b929c02afd3 Linux 6.2-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (60d86034b14e Merge tag 'mlx5-updates-2023-01-10' =
of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging bluetooth/master (7ed38304a633 Bluetooth: Fix possible deadlock in =
rfcomm_sk_state_change)
Merging wireless-next/for-next (d1c722867f80 net: lan966x: Remove a useless=
 test in lan966x_ptp_add_trap())
Merging mtd/mtd/next (a30144c02c84 mtd: dataflash: remove duplicate SPI ID =
table)
Merging nand/nand/next (568494db6809 mtd: remove tmio_nand driver)
Merging spi-nor/spi-nor/next (55398beb0846 mtd: spi-nor: sfdp: Use SFDP_DWO=
RD() macro for optional parameter tables)
Merging crypto/master (c970d42001f2 crypto: x86/aria - implement aria-avx51=
2)
Merging drm/drm-next (03a0a1040895 Merge tag 'drm-misc-next-2023-01-03' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (6e41acd2e535 drm/vkms: reintroduce prepare=
_fb and cleanup_fb functions)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tests/drm_format_help=
er_test.c
Merging amdgpu/drm-next (0c2dece8fb54 drm/amdkfd: Page aligned memory reser=
ve size)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd_gpuvm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_proces=
s.c
Merging drm-intel/for-linux-next (0fe76b198d48 drm/i915/display: Check sour=
ce height is > 0)
Merging drm-tegra/for-next (08fef75f5e17 gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (d73b1d02de08 drm/msm: Hangcheck progress detectio=
n)
Merging drm-msm-lumag/msm-next-lumag (4102e58923f1 Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi', 'msm-next-lumag-mdp5' and 'msm-next-lumag-mdp4' =
into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (30527af2bed1 drm/etnaviv: Remove #ifdef guard=
s for PM related functions)
Merging fbdev/for-next (66dc2cb32919 fbdev: g364fb: Fix a compilation issue=
 by using uintptr_t)
Merging regmap/for-next (861fa35db66c Merge branch 'regmap-linus' into regm=
ap-next)
Merging sound/for-next (af13842cad44 ALSA: firewire-lib: compute extra dela=
y for runtime of PCM substream)
Merging sound-asoc/for-next (5ef2c797ae4a Merge remote-tracking branch 'aso=
c/for-6.3' into asoc-next)
CONFLICT (modify/delete): sound/soc/pxa/e740_wm9705.c deleted in HEAD and m=
odified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/soc/p=
xa/e740_wm9705.c left in tree.
CONFLICT (modify/delete): sound/soc/pxa/e750_wm9705.c deleted in HEAD and m=
odified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/soc/p=
xa/e750_wm9705.c left in tree.
CONFLICT (modify/delete): sound/soc/pxa/e800_wm9712.c deleted in HEAD and m=
odified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/soc/p=
xa/e800_wm9712.c left in tree.
$ git rm -f sound/soc/pxa/e740_wm9705.c sound/soc/pxa/e750_wm9705.c sound/s=
oc/pxa/e800_wm9712.c
Merging modules/modules-next (aa4f47a680bf test_kmod: stop kernel-doc warni=
ngs)
Merging input/next (407da561244b Merge tag 'v6.2-rc3' into next)
CONFLICT (modify/delete): drivers/input/touchscreen/ucb1400_ts.c deleted in=
 HEAD and modified in input/next.  Version input/next of drivers/input/touc=
hscreen/ucb1400_ts.c left in tree.
$ git rm -f drivers/input/touchscreen/ucb1400_ts.c
Merging block/for-next (73f41663622d Merge branch 'for-6.3/iter-ubuf' into =
for-next)
Merging device-mapper/for-next (7991dbff6849 dm thin: Use last transaction'=
s pmd->root when commit failed)
Merging libata/for-next (5f76b5883713 ata: libata: exclude FUA support for =
known buggy drives)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (1cb6f443cbdc Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (153e461670b9 mfd: simple-mfd-i2c: Fix incoherent =
comment regarding DT registration)
Merging backlight/for-backlight-next (73516cbcf8d9 backlight: pwm_bl: Drop =
support for legacy PWM probing)
Merging battery/for-next (4e9498b835ab power: supply: bq25890: Support boar=
ds with more then one charger IC)
Merging regulator/for-next (04ee8ff6c3da Merge remote-tracking branch 'regu=
lator/for-6.3' into regulator-next)
Merging security/next (88603b6dc419 Linux 6.2-rc2)
Merging apparmor/apparmor-next (1b929c02afd3 Linux 6.2-rc1)
Merging integrity/next-integrity (b6018af440a0 ima: Fix hash dependency to =
correct algorithm)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (88603b6dc419 Linux 6.2-rc2)
Merging smack/next (1a3065e92046 smack_lsm: remove unnecessary type casting)
Merging tomoyo/master (cf3b3d6e3a0b locking/lockdep: add debug_show_all_loc=
k_holders())
Merging tpmdd/next (ceb626750358 crypto: certs: fix FIPS selftest dependenc=
y)
Merging watchdog/master (1b929c02afd3 Linux 6.2-rc1)
Merging iommu/next (e3eca2e4f648 Merge branches 'arm/allwinner', 'arm/exyno=
s', 'arm/mediatek', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 's390', 'x86/vt=
-d', 'x86/amd' and 'core' into next)
Merging audit/next (88603b6dc419 Linux 6.2-rc2)
Merging devicetree/for-next (3db50cb6db77 dt-bindings: i2c: Convert Synquac=
er I2C to DT schema)
Merging dt-krzk/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (17da31eac52c Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
Merging tip/master (66f3c4b916b5 Merge branch 'x86/cpu')
Merging clockevents/timers/drivers/next (2eff537b37ca dt-bindings: timer: r=
k-timer: Add rktimer for rv1126)
Merging edac/edac-for-next (fed431d5c33a Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (6ed54e1789a2 Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (14b7bc94a4f6 Merge branch 'trace/trace/for-next' i=
nto trace/for-next)
Merging rcu/rcu/next (19213bf117ac tools: rcu: Add usage function and check=
 for argument)
CONFLICT (content): Merge conflict in security/tomoyo/Kconfig
Merging kvm/next (fc471e831016 Merge branch 'kvm-late-6.1' into HEAD)
Merging kvm-arm/next (753d734f3f34 Merge remote-tracking branch 'arm64/for-=
next/sysregs' into kvmarm-master/next)
Merging kvms390/next (bedac519eefa s390/vfio-ap: check TAPQ response code w=
hen waiting for queue reset)
Merging xen-tip/linux-next (f57034cedeb6 xen/pvcalls: free active map buffe=
r on pvcalls_front_free_map)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (e02b93124855 workqueue: Unbind kworkers before=
 sending them to exit())
Merging drivers-x86/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging chrome-platform/for-next (2ae3c610e7d2 platform/chrome: cros_ec_lpc=
: initialize the buf variable)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (6e04532c0848 leds: is31fl319x: Wrap mutex_de=
stroy() for devm_add_action_or_rest())
Merging ipmi/for-next (041fae9c105a Merge tag 'f2fs-for-6.2-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging driver-core/driver-core-next (7bbb89b420d9 driver core: change to_s=
ubsys_private() to use container_of_const())
Merging usb/usb-next (c2fb9a214da1 Merge 6.2-rc3 into usb-next)
Merging thunderbolt/next (953ff25fc9fb thunderbolt: Refactor tb_acpi_add_li=
nk())
Merging usb-serial/usb-next (b7bfaa761d76 Linux 6.2-rc3)
Merging tty/tty-next (b7bfaa761d76 Linux 6.2-rc3)
Merging char-misc/char-misc-next (b7bfaa761d76 Linux 6.2-rc3)
Merging accel/habanalabs-next (d8c965c0fe88 habanalabs: remove unnecessary =
(void*) conversions)
Merging coresight/next (9266af7545d4 coresight: etm4x: Fix accesses to TRCS=
EQRSTEVR and TRCSEQSTR)
Merging fpga/for-next (b0753e1c0af1 fpga: microchip-spi: separate data fram=
e write routine)
Merging icc/icc-next (dbdbdf891e39 Merge branch 'icc-dt' into icc-next)
Merging iio/togreg (bbd9b7e19be9 dt-bindings: iio: adc: maxim,max1363: fix =
interface typo)
Merging phy-next/next (8b3c08aa648e dt-bindings: phy: mediatek,tphy: add su=
pport for mt7986)
Merging soundwire/next (545c365185a4 soundwire: stream: Move remaining regi=
ster accesses over to no_pm)
Merging extcon/extcon-next (2e85d0a0201d extcon: qcom-spmi: Switch to platf=
orm_get_irq_byname_optional)
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (70be6f322860 vfio/mlx5: error pointer dereference in err=
or handling)
Merging staging/staging-next (b7bfaa761d76 Linux 6.2-rc3)
Merging counter-next/counter-next (1b929c02afd3 Linux 6.2-rc1)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (ab223bc0edd2 dt-bindings: dma: qcom: gpi: add compa=
tible for sm8550)
Merging cgroup/for-next (32a47817d075 cgroup/cpuset: fix a few kernel-doc w=
arnings & coding style)
Merging scsi/for-next (e7c055b78928 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (201e0a7c7f36 scsi: mvumi: Replace 1-element arra=
ys with flexible array members)
Merging vhost/linux-next (66c78aa2b9ba virtio: vdpa: new SolidNET DPU drive=
r.)
Merging rpmsg/for-next (90d6db82626b Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (e3d4a634954c gpio: pcf857x: Implement get_=
multiple/set_multiple methods)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (8f18c3f3e3ac Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (afa349bbb5d7 pinctrl: intel: Get rid of unu=
sed members in struct intel_function)
Merging pinctrl-renesas/renesas-pinctrl (80d34260f36c pinctrl: renesas: gpi=
o: Use dynamic GPIO base if no function GPIOs)
Merging pinctrl-samsung/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pwm/for-next (8fa22f4b88e8 pwm: pca9685: Convert to i2c's .probe_ne=
w())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (88a51b4f2e65 ktest.pl: Add shell commands to variab=
les)
Merging kselftest/next (1b929c02afd3 Linux 6.2-rc1)
Merging kunit/test (1b929c02afd3 Linux 6.2-rc1)
Merging kunit-next/kunit (88603b6dc419 Linux 6.2-rc2)
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (4cd0ca1fe9a7 rtc: ds1307: Convert to i2c's .probe_new=
())
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ntb/ntb-next (1a3f7484e076 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (88603b6dc419 Linux 6.2-rc2)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging nvmem/for-next (ad80e15904ec nvmem: core: fix return value)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (26520c34e621 Drivers: hv: Enable vmbus driver f=
or nested root partition)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (1b929c02afd3 Linux 6.2-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (ccf27a84fe9a bus: mhi: host: Update mhi driver descri=
ption)
Merging memblock/for-next (80c2fe022ef5 memblock tests: remove completed TO=
DO item)
Merging cxl/next (589c3357370a PCI/CXL: Export native CXL error reporting c=
ontrol)
CONFLICT (content): Merge conflict in drivers/cxl/pci.c
Applying: fix up for "cxl: fix cxl_report_and_clear() RAS UE addr mis-assig=
nment"
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (2a5b4ccf0de1 efi/earlycon: Speed up scrolling by disregar=
ding empty space)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (c7b311d5d5dc Merge branch 'slab/for-6.3/cleanups' in=
to slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (4dd6da345ac2 landlock: Explain file descriptor acces=
s rights)
Merging rust/rust-next (b9ecf9b9ac59 rust: types: add `Opaque` type)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in fs/hugetlbfs/inode.c
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
CONFLICT (content): Merge conflict in mm/zsmalloc.c
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (2386459394d2 lib/cpumask: update comment fo=
r cpumask_local_spread())
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (439a1bcac648 fortify: Use __builtin_dynamic_obj=
ect_size() when available)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (b062007c63eb iommu: Remove IOMMU_CAP_INTR_REMAP)
Merging mm-stable/mm-stable (12b98f333f6b Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (18e6340365ea Merge branch 'master'=
 into mm-nonmm-stable)
Merging mm/mm-everything (050a073bc82d Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in Documentation/admin-guide/cgroup-v1/m=
emory.rst
CONFLICT (content): Merge conflict in fs/buffer.c

--Sig_/qbVDvdKV2B7a65aWjGZx2bH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPA1roACgkQAVBC80lX
0GyjtggAhmRorukJetLyBa7sYiXYCMLUqDXG41fn6HaZarbZuM5ZECZaz/gioEHO
z1ErXTt9ZpHJI8551xzoE9LWNMmyyjxkunGntrnssHTHgmZiBTJ4S7t9uK/4ksdJ
WY8pCF8dIbHDr/rxnkX3bKu0jiwpr/7rO21O0fnzkxCbF/jwL+wZ6WmkWbU3wvHv
KvqHAPDJd+U0posOR62yt0o36gCVyc8rcF3Y4HuMBqDDTAk5t3I42O+L3hBNm2Qh
Ayp/5WJ3P3VlI1ETyYERJfcD3aXhjx/tWmaDgrXhdMTUfvoMp6T7KDXdlZj3sWVU
aVlLRXgA7iLRngGbdBYv9Z0f5Lb/WQ==
=nQC6
-----END PGP SIGNATURE-----

--Sig_/qbVDvdKV2B7a65aWjGZx2bH--
