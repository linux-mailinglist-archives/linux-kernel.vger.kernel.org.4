Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CAC65E379
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAEDaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjAEDaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:30:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11B82F793;
        Wed,  4 Jan 2023 19:30:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnX6C1YyWz4xyp;
        Thu,  5 Jan 2023 14:30:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672889411;
        bh=2b7D4KKW8u24/0qUM8l9zHiG1MWan4oee2bWQDG2g00=;
        h=Date:From:To:Cc:Subject:From;
        b=B6pGV7N+QPDgmR65VfeM80OYhV2gEMV18FsiH9tcY8ypCWc4NOaoITV1LOoue/ksV
         IIFrXx1NeZ04nXQeWeS/QRXUav2T9D4ay4EB4366XNHpyKrDqQpdTxir6sOcBBG20g
         vP5dqlh81pCj3JtwH9ML/7OnR+qmqQ+wscH/IrQZLPpXCCotOYCBSw5DMub4JrVuMk
         SxyYYsUoh294sVv+Df10SvLjRxum+Mm9fGKwEnsKBWHxjdHkas/CpzU7zeVxQSdHTT
         w94AgP+Q3xnQkhUNzlrkrzWmbpSLbOA468KJLErWC7RQVZHHEWNv8oIWrz3Ie2owUC
         lSVMFtnIqbwVg==
Date:   Thu, 5 Jan 2023 14:30:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 5
Message-ID: <20230105143009.501d0b54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zXCDc/yTYoNFMEqtE1VEk6.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zXCDc/yTYoNFMEqtE1VEk6.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221226:

Trees removed (not updated in more than a year):
	actions
	amdgpu-fixes
	cisco
	folio-iomap
	gpio-sim
	i3c-fixes
	ieee1394
	init
	integrity-fixes
	keystone
	mfd-fixes
	nios2
	pidfd-fixes
	raspberrypi
	sh
	sparc-next
	usb-gadget
	usb-gadget-fixes

The thermal tree gained conflicts against the pm tree and a build failure,
so I used the version from next-20221226.

The kspp tree exposed a build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 2334
 2593 files changed, 74653 insertions(+), 29304 deletions(-)

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

I am currently merging 351 trees (counting Linus' and 97 trees of bug
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
Merging origin/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (f3f17c0a4319 mm: hwposion: suppor=
t recovery from ksm_might_need_to_copy())
Merging kbuild-current/fixes (e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (73a0b6ee5d62 ARM: 9278/1: kfence: only handle tr=
anslation faults)
Merging arm64-fixes/for-next/fixes (b7d9aae40484 Revert "arm64: dma: Drop c=
ache invalidation from arch_dma_prep_coherent()")
Merging arm-soc-fixes/arm/fixes (6f85602d5fde Merge tag 'v6.1-soc-fixes' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into ar=
m/fixes)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (553b20b211c4 m68k: defconfig: Update defcon=
figs for v6.1-rc1)
Merging powerpc-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging s390-fixes/fixes (88603b6dc419 Linux 6.2-rc2)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (558016722e9d MAINTAINERS: Update maintainers for ptp_vm=
w driver)
Merging bpf/master (45435d8da71f bpf: Always use maximal size for copy_arra=
y())
Merging ipsec/master (7ae9888d6e1c Merge git://git.kernel.org/pub/scm/linux=
/kernel/git/netfilter/nf)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (b7dc753fe33a wifi: ath9k: use proper statements =
in conditionals)
Merging rdma-fixes/for-rc (63ce7bc02df1 RDMA/mlx5: Fix validation of max_rd=
_atomic caps for DC)
Merging sound-current/for-linus (16f1f838442d Revert "ALSA: usb-audio: Drop=
 superfluous interface setup at parsing")
Merging sound-asoc-fixes/for-linus (000bca8d706d ASoC: qcom: lpass-cpu: Fix=
 fallback SD line index handling)
Merging regmap-fixes/for-linus (f309b44844bd Merge remote-tracking branch '=
regmap/for-6.1' into regmap-linus)
Merging regulator-fixes/for-linus (f528fe213a6a regulator: qcom-rpmh: PM855=
0 ldo11 regulator is an nldo)
Merging spi-fixes/for-linus (e8bb8f19e73a spi: cadence: Fix busy cycles cal=
culation)
Merging pci-current/for-linus (760d560f71c8 PCI: dwc: Adjust to recent remo=
val of PCI_MSI_IRQ_DOMAIN)
Merging driver-core.current/driver-core-linus (88603b6dc419 Linux 6.2-rc2)
Merging tty.current/tty-linus (88603b6dc419 Linux 6.2-rc2)
Merging usb.current/usb-linus (2de5bba5890f usb: fotg210: fix OTG-only buil=
d)
Merging usb-serial-fixes/usb-linus (1b929c02afd3 Linux 6.2-rc1)
Merging phy/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging staging.current/staging-linus (88603b6dc419 Linux 6.2-rc2)
Merging iio-fixes/fixes-togreg (bffb7d9d1a3d iio:adc:twl6030: Enable measur=
ement of VAC)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (88603b6dc419 Linux 6.2-rc2)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (c28f3d803835 thunderbolt: Do not report er=
rors if on-board retimers are found)
Merging input-current/for-linus (3c44e2b6cde6 Revert "Input: synaptics - sw=
itch touchpad on HP Laptop 15-da3001TU to RMI mode")
Merging crypto-current/master (736f88689c69 crypto: arm64/sm4 - fix possibl=
e crash with CFI enabled)
Merging vfio-fixes/for-linus (e806e223621e vfio/pci: Check the device set o=
pen count on reset)
Merging kselftest-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging modules-fixes/modules-linus (4f1354d5c6a3 livepatch: Call klp_match=
_callback() in klp_find_callback() to avoid code duplication)
Merging dmaengine-fixes/fixes (f96a483f8e13 MAINTAINERS: update Jie Hai's e=
mail address)
Merging backlight-fixes/for-backlight-fixes (8ab33943cde7 backlight: pwm_bl=
: Drop support for legacy PWM probing)
Merging mtd-fixes/mtd/fixes (d19ab1f785d0 mtd: cfi: allow building spi-inte=
l standalone)
Merging v4l-dvb-fixes/fixes (542d3c03fd89 media: sun6i-isp: params: Unregis=
ter pending buffer on cleanup)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (88603b6dc419 Linux 6.2-rc2)
Merging at91-fixes/at91-fixes (6a3fc8c330d1 ARM: at91: fix build for SAMA5D=
3 w/o L2 cache)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (a5496886eb13 Merge branch 'kvm-late-6.1-fixes' in=
to HEAD)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (2fbb848b65cd hwmon: (nct6775) Fix incorrect pare=
nthesization in nct6775_write_fan_div())
Merging nvdimm-fixes/libnvdimm-fixes (472faf72b33d device-dax: Fix duplicat=
e 'hmem' device registration)
Merging cxl-fixes/fixes (8f401ec1c897 cxl/region: Recycle region ids)
Merging btrfs-fixes/next-fixes (b64c3d095a84 Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (10bc8e4af659 vfs: fix copy_file_range() averts fil=
esystem freeze protection)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging samsung-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (3367934dd303 dt-bindings: drop redundant=
 part of title (manual))
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (b99afb544dc1 scsi: libsas: Grab the ATA port lock=
 in sas_ata_device_link_abort())
Merging drm-fixes/drm-fixes (c8de526215fd Merge tag 'drm-misc-next-fixes-20=
23-01-03' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mmc-fixes/fixes (8509419758f2 mmc: sunxi-mmc: Fix clock refcount im=
balance during unbind)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (25c94b051592 Drivers: hv: vmbus: fix pos=
sible memory leak in vmbus_device_register())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging riscv-dt-fixes/riscv-dt-fixes (1b929c02afd3 Linux 6.2-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (730892135b7d soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging spdx/spdx-linus (1b929c02afd3 Linux 6.2-rc1)
Merging gpio-brgl-fixes/gpio/for-current (694175cd8a16 gpio: sifive: Fix re=
fcount leak in sifive_gpio_probe)
Merging gpio-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging erofs-fixes/fixes (37020bbb71d9 erofs: fix missing xas_retry() in f=
scache mode)
Merging kunit-fixes/kunit-fixes (93ef83050e59 kunit: alloc_string_stream_fr=
agment error handling bug fix)
Merging ubifs-fixes/fixes (7bdd6967fec5 ubi: ensure that VID header offset =
+ VID header size <=3D alloc, size)
Merging memblock-fixes/fixes (fa81ab49bbe4 memblock: Fix doc for memblock_p=
hys_free)
Merging cel-fixes/for-rc (cad853374d85 nfsd: fix handling of readdir in v4r=
oot vs. mount upcall timeout)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (54b353a20c7e perf stat: Fix handling of -=
-for-each-cgroup with --bpf-counters to match non BPF mode)
Merging efi-fixes/urgent (e006ac300308 efi: fix userspace infinite retry re=
ad efivars after EFI runtime services page fault)
Merging zstd-fixes/zstd-linus (70d822cfb782 Merge branch 'zstd-next' into z=
std-linus)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging drm-misc-fixes/for-linux-next-fixes (69555549cfa4 drm/scheduler: Fi=
x lockup in drm_sched_entity_kill())
Merging kbuild/for-next (731c4eac848f buildtar: fix tarballs with EFI_ZBOOT=
 enabled)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (09e6f9f98370 perf python: Fix splitting CC into com=
piler and options)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (3622b86f49f8 dma-mapping: reject GFP_COMP for=
 noncoherent allocations)
Merging asm-generic/master (32975c491ee4 uapi: Add missing _UAPI prefix to =
<asm-generic/types.h> include guard)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (1907710cab84 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (c0cd1d541704 Revert "arm64: errata: Workaround=
 possible Cortex-A715 [ESR|FAR]_ELx corruption")
Merging arm-perf/for-next/perf (4361251cef46 arm_pmu: Drop redundant armpmu=
->map_event() in armpmu_event_init())
Merging arm-soc/for-next (6f85602d5fde Merge tag 'v6.1-soc-fixes' of https:=
//git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into arm/fixes)
Merging amlogic/for-next (954d727eb473 Merge branch 'v6.3/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging aspeed/for-next (45c86167adde soc: nuvoton: Add SoC info driver for=
 WPCM450)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/nuvoton-wpcm450-sup=
ermicro-x9sci-ln4f.dts
Merging at91/at91-next (fb18447f4da5 Merge branch 'at91-defconfig' into at9=
1-next)
Merging broadcom/next (64610429f8de Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (84bde55c050b ARM: davinci: fix repeated w=
ords in comments)
Merging drivers-memory/for-next (13f35b3c72f4 Merge branch 'for-v6.3/renesa=
s-rpc-if' into for-next)
Merging imx-mxs/for-next (d262184e744b Merge branch 'imx/dt64' into for-nex=
t)
Merging mediatek/for-next (cb2d7e7169c6 Merge branch 'v6.1/soc-fixes' into =
for-next)
Merging mvebu/for-next (ce88856dec4f Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (6435241fd536 Merge branch 'musb-for-v6.2' into for-n=
ext)
Merging qcom/for-next (dc749e6205bd Merge branches 'arm64-fixes-for-6.2', '=
arm64-for-6.3', 'clk-for-6.3', 'drivers-for-6.3', 'dts-fixes-for-6.2' and '=
dts-for-6.3' into for-next)
Merging renesas/next (7cf590dd4235 Merge branches 'renesas-arm-defconfig-fo=
r-v6.3', 'renesas-arm-dt-for-v6.3', 'renesas-drivers-for-v6.3' and 'renesas=
-riscv-dt-for-v6.3' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (f8ddca807e78 Merge branch 'v6.3-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (e4c33114e1cf Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (98333bf901c3 Merge commit 'e325285de2cd' into =
for-linux-next)
Merging stm32/stm32-next (4cca342b840e ARM: dts: stm32: Rename mdio0 to mdi=
o on DHCOR Testbench board)
Merging sunxi/sunxi/for-next (47be7c123211 Merge branch 'sunxi/clk-for-6.2'=
 into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (65de8bad744b Merge branch for-6.2/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (1b929c02afd3 Linux 6.2-rc1)
Merging xilinx/for-next (aa95ef0c258b Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-imx/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-renesas/renesas-clk (d969103ac89d clk: renesas: r9a09g011: Add =
SDHI/eMMC clock and reset entries)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (5535f4f70cfc LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (a8d0ef28c0d9 m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (5cfe469c2654 microblaze/PCI: Moving PCI iounmap an=
d dependent code)
Merging mips/mips-next (88603b6dc419 Linux 6.2-rc2)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (d903b5d0c7e3 parisc: Limit amount of breakpoint=
s on parisc)
Merging powerpc/next (1b929c02afd3 Linux 6.2-rc1)
Merging powerpc-objtool/topic/objtool (a39818a3fb2b objtool/powerpc: Implem=
ent arch_pc_relative_reloc())
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (b07de94d4501 Merge patch series "Allow calls in al=
ternatives")
Merging riscv-dt/riscv-dt-for-next (093ee97e24f8 Merge tag 'soc2arch-immuta=
ble' into riscv-dt-for-next)
Merging riscv-soc/riscv-soc-for-next (6635e91648ce soc: sifive: ccache: Add=
 StarFive JH7110 support)
Merging s390/for-next (286c89ef3b34 Merge branch 'features' into for-next)
Merging uml/next (43ee0357e15b um: vector: Fix memory leak in vector_config)
Merging xtensa/xtensa-for-next (5b24ac2dfd3e kcsan: test: don't put the exp=
ect array on the stack)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (e175af42241c Merge branch 'fs.acl.rework' i=
nto for-next)
Merging fscrypt/master (41952551acb4 fscrypt: add additional documentation =
for SM4 support)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (a8db200f83a5 Merge branch 'for-next-next-v6.2-20230=
103' into for-next-20230103)
Merging ceph/master (8e1858710d9a ceph: avoid use-after-free in ceph_fl_rel=
ease_lock())
Merging cifs/for-next (fb8e7f7c95da cifs: fix interface count calculation d=
uring refresh)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (3ae2c449e412 erofs/zmap.c: Fix incorrect offset calculat=
ion)
Merging exfat/dev (6bbb474edef7 exfat: fix reporting fs error when reading =
dir beyond EOF)
Merging ext3/for_next (e86812bfac97 udf: Detect system inodes linked into d=
irectory hierarchy)
Merging ext4/dev (1da18e38cb97 ext4: fix reserved cluster accounting in __e=
s_remove_extent())
Merging f2fs/dev (df9d44b645b8 f2fs: let's avoid panic if extent_tree is no=
t created)
Merging fsverity/fsverity (86f66569baca fsverity: remove debug messages and=
 CONFIG_FS_VERITY_DEBUG)
Merging fuse/for-next (1b0e94993dbe fuse: optional supplementary group in c=
reate requests)
Merging gfs2/for-next (6b46a06100dd gfs2: Remove support for glock holder a=
uto-demotion (2))
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (83dcedd5540d ksmbd: fix infinite loop in ksmb=
d_conn_handler_loop())
Merging nfs/linux-next (5e9a7b9c2ea1 NFS: Fix up a sparse warning)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (af8998913b0c SUNRPC: Hoist svcxdr_init_decode() into=
 svc_process())
Merging ntfs3/master (e3ab3260c918 fs/ntfs3: fix spelling mistake "attibute=
" -> "attribute")
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (637d13b57d85 ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (8d0960731a26 jffs2: Fix list_del corruption if compress=
ors initialized failed)
Merging v9fs/9p-next (1a4f69ef15ec 9p/client: fix data race on req->status)
Merging xfs/for-next (e195605ed28b xfs: xfs_qm: remove unnecessary =E2=80=
=980=E2=80=99 values from error)
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
Merging printk/for-next (da6554d2173d Merge branch 'for-6.3' into for-next)
Merging pci/next (1b929c02afd3 Linux 6.2-rc1)
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (aa04696ebf14 Merge branch 'for-6.2/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (38cf3e4fa7d0 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (08dcf0732cb4 MAINTAINERS: mark I3C DRIVER FOR SYNOPSY=
S DESIGNWARE orphan)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (b0587c87abc8 hwmon: (coretemp) Simplify p=
latform device handling)
Merging jc_docs/docs-next (6a5eb779478e Documentation: x86: fix typo in x86=
_64/mm.rst)
Merging v4l-dvb/master (6599e683db1b Merge tag 'v6.2-rc1' into media_tree)
Merging v4l-dvb-next/master (d4acfa22b634 media: sun6i-isp: params: Unregis=
ter pending buffer on cleanup)
Merging pm/linux-next (2804f848d8e3 Merge branch 'thermal-intel-next' into =
linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c956541736b9 cpufreq: apple-soc=
: Switch to the lowest frequency on suspend)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (7fc7f25419f5 PM / devfreq: event: use devm_pl=
atform_get_and_ioremap_resource())
Merging opp/opp/linux-next (5b2ad5acaf5a dt-bindings: opp: opp-v2-kryo-cpu:=
 Add missing 'cache-unified' property in example)
Merging thermal/thermal/linux-next (cc54ca385577 thermal/acpi: Add ACPI tri=
p point routines)
CONFLICT (content): Merge conflict in drivers/thermal/intel/int340x_thermal=
/processor_thermal_device.c
CONFLICT (content): Merge conflict in drivers/thermal/intel/x86_pkg_temp_th=
ermal.c
$ git reset --hard HEAD^
Merging next-20221226 version of thermal
Merging dlm/next (7a5e9f1f83e3 fs: dlm: fix building without lockdep)
Merging rdma/for-next (cf6a05c8494a RDMA/hns: Fix refcount leak in hns_roce=
_mmap)
Merging net-next/master (1f47510ed50a Merge branch '1GbE' of git://git.kern=
el.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging bpf-next/for-next (acd3b7768048 libbpf: Return -ENODATA for missing=
 btf section)
Merging ipsec-next/master (7e68dd7d07a2 Merge tag 'net-next-6.2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mlx5-next/mlx5-next (1b929c02afd3 Linux 6.2-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (ad230933bec9 Bluetooth: btusb: Add new PID/VID 04=
89:e0f2 for MT7921)
Merging wireless-next/for-next (d1c722867f80 net: lan966x: Remove a useless=
 test in lan966x_ptp_add_trap())
Merging mtd/mtd/next (a30144c02c84 mtd: dataflash: remove duplicate SPI ID =
table)
Merging nand/nand/next (34569d869532 mtd: rawnand: sunxi: Fix the size of t=
he last OOB region)
Merging spi-nor/spi-nor/next (55398beb0846 mtd: spi-nor: sfdp: Use SFDP_DWO=
RD() macro for optional parameter tables)
Merging crypto/master (e20d5a22bd24 crypto: lib/blake2s - Split up test fun=
ction to halve stack usage)
Merging drm/drm-next (03a0a1040895 Merge tag 'drm-misc-next-2023-01-03' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (03dec92c4f78 drm/scheduler: Fix lockup in =
drm_sched_entity_kill())
Merging amdgpu/drm-next (db4107e92a81 drm/amd/display: fix dc/core/dc.c ker=
nel-doc)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
Merging drm-intel/for-linux-next (5a9b0c741844 drm/i915/dp: change aux_ctl =
reg read to polling read)
Merging drm-tegra/for-next (08fef75f5e17 gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (d73b1d02de08 drm/msm: Hangcheck progress detectio=
n)
Merging drm-msm-lumag/msm-next-lumag (1eca2464c1db dt-bindings: msm/dsi: Do=
n't require vcca-supply on 14nm PHY)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (30527af2bed1 drm/etnaviv: Remove #ifdef guard=
s for PM related functions)
Merging fbdev/for-next (764043cccd72 fbdev: omapfb: avoid stack overflow wa=
rning)
Merging regmap/for-next (861fa35db66c Merge branch 'regmap-linus' into regm=
ap-next)
Merging sound/for-next (777ad8835e43 kselftest/alsa: pcm - Add more coverag=
e by default)
Merging sound-asoc/for-next (f873f5d1cee5 Merge remote-tracking branch 'aso=
c/for-6.3' into asoc-next)
Merging modules/modules-next (a0cb6d89fd61 test_kmod: stop kernel-doc warni=
ngs)
Merging input/next (c3991107a28a Input: elants_i2c - delay longer with rese=
t asserted)
Merging block/for-next (c209f0d5e76c Merge branch 'for-6.3/io_uring' into f=
or-next)
Merging device-mapper/for-next (7991dbff6849 dm thin: Use last transaction'=
s pmd->root when commit failed)
Merging libata/for-next (002c487119f2 ata: libata-scsi: improve ata_scsiop_=
maint_in())
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (1cb6f443cbdc Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (15a072efe92b mfd: cs5535: Don't build on UML)
Merging backlight/for-backlight-next (0de796b6047d backlight: tosa: Convert=
 to i2c's .probe_new())
Merging battery/for-next (4e9498b835ab power: supply: bq25890: Support boar=
ds with more then one charger IC)
Merging regulator/for-next (5886886dc85b Merge remote-tracking branch 'regu=
lator/for-6.3' into regulator-next)
Merging security/next (88603b6dc419 Linux 6.2-rc2)
Merging apparmor/apparmor-next (4295c60bbe9e apparmor: Fix uninitialized sy=
mbol 'array_size' in policy_unpack_test.c)
Merging integrity/next-integrity (b6018af440a0 ima: Fix hash dependency to =
correct algorithm)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (88603b6dc419 Linux 6.2-rc2)
Merging smack/next (1a3065e92046 smack_lsm: remove unnecessary type casting)
Merging tomoyo/master (be9c59066d8e workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (ceb626750358 crypto: certs: fix FIPS selftest dependenc=
y)
Merging watchdog/master (1b929c02afd3 Linux 6.2-rc1)
Merging iommu/next (e3eca2e4f648 Merge branches 'arm/allwinner', 'arm/exyno=
s', 'arm/mediatek', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 's390', 'x86/vt=
-d', 'x86/amd' and 'core' into next)
Merging audit/next (88603b6dc419 Linux 6.2-rc2)
Merging devicetree/for-next (00f2a08cd785 dt-bindings: memory-controllers: =
ti,gpmc: fix typo in description)
Merging dt-krzk/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (c7f7eb906b99 Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
Merging tip/master (bdc9f60d2a62 Merge branch into tip/master: 'perf/urgent=
')
Merging clockevents/timers/drivers/next (2eff537b37ca dt-bindings: timer: r=
k-timer: Add rktimer for rv1126)
Merging edac/edac-for-next (e7a293658c20 EDAC/highbank: Fix memory leak in =
highbank_mc_probe())
Merging irqchip/irq/irqchip-next (6ed54e1789a2 Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (14b7bc94a4f6 Merge branch 'trace/trace/for-next' i=
nto trace/for-next)
Merging rcu/rcu/next (7b1ab570a718 clocksource: Permit limited-duration clo=
cksource watchdogging)
Merging kvm/next (fc471e831016 Merge branch 'kvm-late-6.1' into HEAD)
Merging kvm-arm/next (753d734f3f34 Merge remote-tracking branch 'arm64/for-=
next/sysregs' into kvmarm-master/next)
Merging kvms390/next (bedac519eefa s390/vfio-ap: check TAPQ response code w=
hen waiting for queue reset)
Merging xen-tip/linux-next (7cffcade57a4 xen: make remove callback of xen d=
river void returned)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (33e3f0a3358b workqueue: Add a new flag to spot=
 the potential UAF error)
Merging drivers-x86/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging chrome-platform/for-next (56d4b33d45e3 platform/chrome: cros_ec_uar=
t: fix race condition)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ipmi/for-next (041fae9c105a Merge tag 'f2fs-for-6.2-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging driver-core/driver-core-next (88603b6dc419 Linux 6.2-rc2)
Merging usb/usb-next (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt/next (953ff25fc9fb thunderbolt: Refactor tb_acpi_add_li=
nk())
Merging usb-serial/usb-next (1b929c02afd3 Linux 6.2-rc1)
Merging tty/tty-next (88603b6dc419 Linux 6.2-rc2)
Merging char-misc/char-misc-next (88603b6dc419 Linux 6.2-rc2)
Merging accel/habanalabs-next (4e77922046b9 habanalabs: refactor razwi/page=
-fault information structures)
Merging coresight/next (88603b6dc419 Linux 6.2-rc2)
Merging fpga/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging icc/icc-next (26e90ec7a840 Merge branch 'icc-sc8280xp-l3' into icc-=
next)
Merging iio/togreg (bbd9b7e19be9 dt-bindings: iio: adc: maxim,max1363: fix =
interface typo)
Merging phy-next/next (1b929c02afd3 Linux 6.2-rc1)
Merging soundwire/next (1b929c02afd3 Linux 6.2-rc1)
Merging extcon/extcon-next (5313121b22fd extcon: usbc-tusb320: Convert to i=
2c's .probe_new())
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (70be6f322860 vfio/mlx5: error pointer dereference in err=
or handling)
Merging staging/staging-next (88603b6dc419 Linux 6.2-rc2)
Merging counter-next/counter-next (1b929c02afd3 Linux 6.2-rc1)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (ab223bc0edd2 dt-bindings: dma: qcom: gpi: add compa=
tible for sm8550)
Merging cgroup/for-next (21786e5cb375 cgroup/cpuset: no need to explicitly =
init a global static variable)
Merging scsi/for-next (b99afb544dc1 scsi: libsas: Grab the ATA port lock in=
 sas_ata_device_link_abort())
Merging scsi-mkp/for-next (2d95c6deb64d Merge patch series "scsi: ufs: core=
: Always read the descriptors with max length")
Merging vhost/linux-next (2822599fccd9 vdpa_sim_net: Offer VIRTIO_NET_F_STA=
TUS)
Merging rpmsg/for-next (c006d3428ce2 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (5bc3518dcb43 gpiolib: sort header inclusio=
n alphabetically)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (14277fa3ac14 Merge branch 'devel' into for-next)
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
Merging kunit-next/kunit (1b929c02afd3 Linux 6.2-rc1)
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (e88f319a2546 rtc: ds1742: use devm_platform_get_and_i=
oremap_resource())
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ntb/ntb-next (1a3f7484e076 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (88603b6dc419 Linux 6.2-rc2)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging nvmem/for-next (ef1d5e775c7e MAINTAINERS: Add myself as ONIE tlv NV=
MEM layout maintainer)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (32c97d980e2e x86/hyperv: Remove unregister sysc=
ore call from Hyper-V cleanup)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (1b929c02afd3 Linux 6.2-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (1a6bd3fd0d9d mhi: Update Makefile to used Kconfig fla=
gs)
Merging memblock/for-next (80c2fe022ef5 memblock tests: remove completed TO=
DO item)
Merging cxl/next (f04facfb993d cxl/region: Fix memdev reuse check)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (c2530a04a73e arm64: efi: Account for the EFI runtime stac=
k in stack unwinder)
CONFLICT (content): Merge conflict in arch/arm64/kernel/stacktrace.c
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (ca0a62c99a1b Merge branch 'slab/for-6.3/cleanups' in=
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
CONFLICT (content): Merge conflict in fs/hugetlbfs/inode.c
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
CONFLICT (content): Merge conflict in mm/zsmalloc.c
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (2386459394d2 lib/cpumask: update comment fo=
r cpumask_local_spread())
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (f7cd05c76c70 fortify: Use __builtin_dynamic_obj=
ect_size() when available)
Applying: rxrpc: replace zero-lenth array with DECLARE_FLEX_ARRAY() helper
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (88603b6dc419 Linux 6.2-rc2)
Merging mm-stable/mm-stable (a7383cfbda1d Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (7e45f8095574 Merge branch 'master'=
 into mm-nonmm-stable)
Merging mm/mm-everything (dd5c3ba990ae Merge branch 'mm-nonmm-unstable' int=
o mm-everything)

--Sig_/zXCDc/yTYoNFMEqtE1VEk6.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2REEACgkQAVBC80lX
0GxfPwgAhqXS2cqksF0mkkD/8Df7ADI/+tu6EThsQ2gbpkAsOhHciA8/IEjS4pOd
Igl+OWk0U2LsUa4+ByamIIos61VLkH9SZ3wefUXeHr1vlpHAUBgMhSgEuczlK/QB
FJryDxI/WHucDHaOuDFxN4FmvTc5hFKpE+om2eupo0J+BsGgCGTrpLrB5zcvjC4d
BA6PnRVT5W0kFBnBXG0yT3On55v0aXVfmXylErO1QsFVTbVXKOPjaTfj+BxYmQ5n
RNpj7cVudEbRfwykYKjCA/0la+Fjsh5LXWY+ymYq4lcEylPwC5SN492ujlO5vQi9
POZPT5ewz8V2ePYF5SiNExlWFPt5jw==
=sIBA
-----END PGP SIGNATURE-----

--Sig_/zXCDc/yTYoNFMEqtE1VEk6.--
