Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02417698B46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBPD5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPD52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:57:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFF636FD2;
        Wed, 15 Feb 2023 19:57:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHLk961YVz4x5R;
        Thu, 16 Feb 2023 14:57:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676519842;
        bh=w3TsUhH/8wS23tk9xSWO4TewYh6XsU+9Wrl0eRxrk48=;
        h=Date:From:To:Cc:Subject:From;
        b=snfFNng9ZihSMvgBL6sKJHV9Ttzfik/SoIVxaxPN2r54ePyLD4GWkQLL84Gy+tLb4
         eQ1jbrSnL7GKD5M+BuTqjkpdGm8vYGdFt65o4C4EhNWZ5HUZ8bo7HnVgaqRqDLNWVg
         US3UHewyqFS+3sQUjJ03yd7VgjRdw2HlZ8Fph49I2AiPm4flsBLG/CZhDuSSvLc3tp
         2y4q5kPFTf0N8AUxZ1OYrsS8EKyokl1EF+2RRRVtEWWsx2pmjVE/Z48gNrL9RkLCvu
         3A6jozc2kET6gjjHV05BSmo7iMk6XJxYqi2yT0lds5XAAYOaQQT+SjwlBfns6N2flU
         VNyEvasACT6OQ==
Date:   Thu, 16 Feb 2023 14:57:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 16
Message-ID: <20230216145720.4275880a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0m/gUWjz=_aO6xOPe5qqqM+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0m/gUWjz=_aO6xOPe5qqqM+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230215:

The ntfs3 tree gained conflicts against the vfs-idmapping tree.

The spi tree gained a conflict against the i2c tree.

The pinctrl tree gained a conflict against the mmc tree.

The mm-stable tree gained a conflict against the nfs-anna tree.

Non-merge commits (relative to Linus' tree): 12091
 12303 files changed, 553111 insertions(+), 414262 deletions(-)

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

I am currently merging 356 trees (counting Linus' and 100 trees of bug
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
Merging origin/master (e1c04510f521 Merge tag 'pm-6.2-rc9' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (7571c5bc1cf0 mm/page_alloc.c: fix=
 page corruption caused by racy check in __free_pages)
Merging kbuild-current/fixes (22e46f6480e8 kbuild: modinst: Fix build error=
 when CONFIG_MODULE_SIG_KEY is a PKCS#11 URI)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2f62847cf6ae ARM: 9287/1: Reduce __thumb2__ defi=
nition to crypto files that require it)
Merging arm64-fixes/for-next/fixes (a428eb4b99ab Partially revert "perf/arm=
-cmn: Optimise DTC counter accesses")
Merging arm-soc-fixes/arm/fixes (bc6772bbab9a Merge tag 'amlogic-fixes-v6.2=
-rc-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux=
 into arm/fixes)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (553b20b211c4 m68k: defconfig: Update defcon=
figs for v6.1-rc1)
Merging powerpc-fixes/fixes (2ea31e2e62bb powerpc/64s/interrupt: Fix interr=
upt exit race with security mitigation switch)
Merging s390-fixes/fixes (7ab41c2c08a3 s390/decompressor: specify __decompr=
ess() buf len to avoid overflow)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (31e1be62abde MAINTAINERS: update fscry=
pt git repo)
Merging fsverity-current/for-current (ef7592e466ef MAINTAINERS: update fsve=
rity git repo, list, and patchwork)
Merging net/master (fda6c89fe3d9 net: mpls: fix stale pointer if allocation=
 fails during device rename)
Merging bpf/master (b963d9d5b943 selftests: Fix failing VXLAN VNI filtering=
 test)
Merging ipsec/master (8222d5910dae xfrm: Zero padding when dumping algos an=
d encap)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (92f3e96d642f netfilter: nf_tables: allow to fetch set =
elements when table has an owner)
Merging wireless/for-next (80f8a66dede0 Revert "wifi: mac80211: fix memory =
leak in ieee80211_if_add()")
Merging rdma-fixes/for-rc (ceaa837f96ad Linux 6.2-rc8)
Merging sound-current/for-linus (9251584af092 ALSA: hda/realtek: Enable mut=
e/micmute LEDs and speaker support for HP Laptops)
Merging sound-asoc-fixes/for-linus (5afc7eefe416 ASoC: SOF: ops: refine par=
ameters order in function snd_sof_dsp_update8)
Merging regmap-fixes/for-linus (697c3892d825 regmap: apply reg_base and reg=
_downshift for single register ops)
Merging regulator-fixes/for-linus (4bb3d82a1820 regulator: dt-bindings: sam=
sung,s2mps14: add lost samsung,ext-control-gpios)
Merging spi-fixes/for-linus (574fbb95cd9d spi: intel: Check number of chip =
selects after reading the descriptor)
Merging pci-current/for-linus (1b929c02afd3 Linux 6.2-rc1)
Merging driver-core.current/driver-core-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging tty.current/tty-linus (4ec5183ec486 Linux 6.2-rc7)
Merging usb.current/usb-linus (ceaa837f96ad Linux 6.2-rc8)
Merging usb-serial-fixes/usb-linus (4ec5183ec486 Linux 6.2-rc7)
Merging phy/fixes (49ebb0024bb3 phy: rockchip-typec: fix tcphy_get_mode err=
or case)
Merging staging.current/staging-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging iio-fixes/fixes-togreg (42ec40b0883c iio: light: vcnl4000: Fix WARN=
_ON on uninitialized lock)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (4ec5183ec486 Linux 6.2-rc7)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging input-current/for-linus (9c445d2637c9 Input: i8042 - add Clevo PCX0=
DX to i8042 quirk table)
Merging crypto-current/master (736f88689c69 crypto: arm64/sm4 - fix possibl=
e crash with CFI enabled)
Merging vfio-fixes/for-linus (51cdc8bc120e kvm/vfio: Fix potential deadlock=
 on vfio group_lock)
Merging kselftest-fixes/fixes (a49fb7218ed8 selftests: amd-pstate: Don't de=
lete source files via Makefile)
Merging modules-fixes/modules-linus (0254127ab977 module: Don't wait for GO=
ING modules)
Merging dmaengine-fixes/fixes (0a60cc31858f dmaengine: ptdma: check for nul=
l desc before calling pt_cmd_callback)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c0f7ae27539f MAINTAINERS: Update email of Tudo=
r Ambarus)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (89c08aef8f8d media: videobuf2: set q->streamin=
g later)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (88603b6dc419 Linux 6.2-rc2)
Merging at91-fixes/at91-fixes (9bfa2544dbd1 ARM: dts: at91: sam9x60: fix th=
e ddr clock for sam9x60)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (c2c46b10d526 KVM: selftests: Make reclaim_period_=
ms input always be positive)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (e2de0e6abd91 hwmon: (asus-ec-sensors) add missin=
g mutex path)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (000f66519f1a Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (9c7417b5ec44 coredump: Move dump_emit_page() to ki=
ll unused warning)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (eb4b55f2f26f platform/x86/intel/vsec: Add =
support for Meteor Lake)
Merging samsung-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (707344c8a188 dt-bindings: interrupt-cont=
roller: arm,gic-v3: Fix typo in description of msi-controller property)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (15600159bcc6 scsi: Revert "scsi: core: map PQ=3D1=
, PDT=3Dother values to SCSI_SCAN_TARGET_PRESENT")
Merging drm-fixes/drm-fixes (ceaa837f96ad Linux 6.2-rc8)
Merging drm-intel-fixes/for-linux-next-fixes (d5a1224aa68c drm/i915/gen11: =
Wa_1408615072/Wa_1407596294 should be on GT list)
Merging mmc-fixes/fixes (3f18c5046e63 mmc: jz4740: Work around bug on JZ476=
0(B))
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (25c94b051592 Drivers: hv: vmbus: fix pos=
sible memory leak in vmbus_device_register())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (950b879b7f02 riscv: Fixup race condition on PG_=
dcache_clean in flush_icache_pte)
Merging riscv-dt-fixes/riscv-dt-fixes (43d5f5d63699 riscv: dts: sifive: fu7=
40: fix size of pcie 32bit memory)
Merging riscv-soc-fixes/riscv-soc-fixes (730892135b7d soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging spdx/spdx-linus (5dc4c995db9e Linux 6.2-rc4)
Merging gpio-brgl-fixes/gpio/for-current (2f43f6020cde gpio: mlxbf2: select=
 GPIOLIB_IRQCHIP)
Merging gpio-intel-fixes/fixes (a69982c37cd0 gpiolib: acpi: Add a ignore wa=
keup quirk for Clevo NH5xAx)
Merging pinctrl-intel-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging erofs-fixes/fixes (e02ac3e7329f erofs: clean up parsing of fscache =
related options)
Merging kunit-fixes/kunit-fixes (254c71374a70 kunit: fix kunit_test_init_se=
ction_suites(...))
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (4102db175b5d nfsd: don't destroy global nfs4=
_file table in per-net shutdown)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (f883675bf652 Merge tag 'gpio-fixes-for-v6=
.2-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging efi-fixes/urgent (190233164cd7 arm64: efi: Force the use of SetVirt=
ualAddressMap() on eMAG and Altra Max machines)
Merging zstd-fixes/zstd-linus (0a2cbd1f53f3 lib: zstd: Fix -Wstringop-overf=
low warning)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging rust-fixes/rust-fixes (2a02b7a19794 rust: kernel: Mark rust_fmt_arg=
ument as extern "C")
Merging drm-misc-fixes/for-linux-next-fixes (a950b989ea29 drm/vmwgfx: Do no=
t drop the reference to the handle too soon)
Merging kbuild/for-next (0aee6bec0f44 Documentation/llvm: add Chimera Linux=
, Google and Meta datacenters)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (6a5558f11664 perf tools: Fix perf tool build error =
in util/pfm.c)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (3622b86f49f8 dma-mapping: reject GFP_COMP for=
 noncoherent allocations)
Merging asm-generic/master (a13408c20526 char/agp: introduce asm-generic/ag=
p.h)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (ba07b4efc989 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (ad4a4d3aff21 Merge branch 'for-next/signal' in=
to for-next/core)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging arm-perf/for-next/perf (e8a709dc2a91 perf: arm_spe: Print the versi=
on of SPE detected)
Merging arm-soc/for-next (14c61d210037 soc: document merges)
CONFLICT (content): Merge conflict in arch/arm/mach-s3c/Makefile
Merging amlogic/for-next (b6520fc7ee57 Merge branch 'v6.2/fixes' into for-n=
ext)
Merging asahi-soc/asahi-soc/for-next (22991d8d5725 soc: apple: rtkit: Add r=
egister dump decoding to crashlog)
Merging aspeed/for-next (af06aa236dd7 ARM: Add wpcm450_defconfig for Nuvoto=
n WPCM450)
Merging at91/at91-next (05ccf9c9c2fc Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (b691373a1bec Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (eaafab7e8e26 MAINTAINERS: make me the mai=
ntainer of DaVinci platforms)
Merging drivers-memory/for-next (957b573ea840 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (fd5368f6f08b Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (74ba8bb2bfb2 Merge branch 'v6.2-next/soc' into f=
or-next)
Merging mvebu/for-next (b80b042da860 Merge branch 'mvebu/fixes' into mvebu/=
for-next)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (b836adb6d62d Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-for-6.3' and 'dts-for-6.3' into=
 for-next)
Merging renesas/next (8dd3dae1705b Merge branches 'renesas-arm-defconfig-fo=
r-v6.3', 'renesas-drivers-for-v6.3', 'renesas-dt-bindings-for-v6.3' and 're=
nesas-dts-for-v6.3' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (cc2b5be472c0 Merge branch 'v6.3-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (da8d67f035b7 Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (6d796c50f84c Linux 6.2-rc6)
Merging stm32/stm32-next (4e74ad9f3af6 ARM: configs: multi_v7: enable NVMEM=
 driver for STM32)
Merging sunxi/sunxi/for-next (caea0128c038 Merge branch 'sunxi/dt-for-6.3' =
into sunxi/for-next)
Merging tee/next (816477edfba6 mm: Remove get_kernel_pages())
Merging tegra/for-next (de98d45290c7 Merge branch for-6.3/arm64/dt into for=
-next)
Merging ti/ti-next (47d72bbb6c0f arm64: dts: ti: Makefile: Rearrange entrie=
s alphabetically)
Merging xilinx/for-next (a18426505c2b Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (686b97633b46 Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (4e197ee880c2 clk: imx6ul: add ethernet refclock m=
ux support)
Merging clk-renesas/renesas-clk (b1dec4e78599 clk: renesas: rcar-gen3: Disa=
ble R-Car H3 ES1.*)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (2d94a107d041 selftests/ftrace: Add LoongA=
rch kprobe args string tests support)
Merging m68k/for-next (1e5b5df65af9 m68k: /proc/hardware should depend on P=
ROC_FS)
Merging m68knommu/for-next (5aa52ccf692b m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (1b929c02afd3 Linux 6.2-rc1)
Merging mips/mips-next (159c610af8cd MIPS: ralink: Use devm_platform_get_an=
d_ioremap_resource())
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (3125e3b8f24c parisc: update kbuild doc. aliases=
 for parisc64)
Merging powerpc/next (b0ae5b6f3c29 powerpc/kexec_file: print error string o=
n usable memory property update failure)
Merging powerpc-objtool/topic/objtool (1b929c02afd3 Linux 6.2-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (9a5c09dd9701 Merge patch series "Remove toolchain =
dependencies for Zicbom")
CONFLICT (content): Merge conflict in arch/riscv/include/asm/hwcap.h
CONFLICT (content): Merge conflict in arch/riscv/include/asm/vdso/processor=
.h
Merging riscv-dt/riscv-dt-for-next (d9c36d016f61 Merge patch series "Add a =
devicetree for the Aldec PolarFire SoC TySoM")
Merging riscv-soc/riscv-soc-for-next (f3460326e38d Merge patch series "JH71=
10 PMU Support")
Merging s390/for-next (1a41151889b5 Merge branch 'features' into for-next)
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (2372745ea25a selftests: add tests for prctl(SET_HID=
E_SELF_EXE))
Merging vfs-idmapping/for-next (9db35c4c2bc4 Merge branch 'fs.misc' into fo=
r-next)
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
CONFLICT (content): Merge conflict in fs/fuse/acl.c
CONFLICT (content): Merge conflict in fs/fuse/fuse_i.h
CONFLICT (content): Merge conflict in fs/fuse/xattr.c
Merging fscrypt/for-next (097d7c1fcb8d fscrypt: clean up fscrypt_add_test_d=
ummy_key())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (709357d656f0 Merge branch 'for-next-next-v6.2-20230=
215' into for-next-20230215)
Merging ceph/master (e7d84c6a1296 ceph: flush cap releases when the session=
 is flushed)
Merging cifs/for-next (e18f461adf10 cifs: Fix uninitialized memory reads fo=
r oparms.mode)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (61fef98945d0 erofs: unify anonymous inodes for blob)
Merging exfat/dev (5742d6a467d1 exfat: handle unreconized benign secondary =
entries)
Merging ext3/for_next (90e4f9e49826 Pull udf fixup for syzbot allocation fa=
ilure handling bug.)
Merging ext4/dev (1da18e38cb97 ext4: fix reserved cluster accounting in __e=
s_remove_extent())
Merging f2fs/dev (ddf1eca4fc5a f2fs: drop unnecessary arg for f2fs_ioc_*())
CONFLICT (content): Merge conflict in fs/f2fs/file.c
CONFLICT (content): Merge conflict in fs/f2fs/namei.c
Merging fsverity/for-next (51e4e3153ebc fscrypt: support decrypting data fr=
om large folios)
Merging fuse/for-next (1cc4606d19e3 fuse: add inode/permission checks to fi=
leattr_get/fileattr_set)
Merging gfs2/for-next (b66f723bb552 gfs2: Improve gfs2_make_fs_rw error han=
dling)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (fb533473d159 ksmbd: do not allow the actual f=
rame length to be smaller than the rfc1002 length)
Merging nfs/linux-next (2241ab53cbb5 Linux 6.2-rc5)
Merging nfs-anna/linux-next (1683ed16ff1a fs/nfs: Replace kmap_atomic() wit=
h kmap_local_page() in dir.c)
Merging nfsd/nfsd-next (edba207d2781 NFSD: Clean up nfsd_symlink())
Merging ntfs3/master (b268663f49c3 fs/ntfs3: Print details about mount fail=
s)
CONFLICT (content): Merge conflict in fs/ntfs3/file.c
CONFLICT (content): Merge conflict in fs/ntfs3/ntfs_fs.h
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (8fcf2d012c86 ubi: block: Fix a possible use-after-free =
bug in ubiblock_create())
Merging v9fs/9p-next (2ce10bad1e96 9p/rdma: unmap receive dma buffer in rdm=
a_request()/post_recv())
Merging v9fs-ericvh/ericvh/for-next (291ca06aad93 fs/9p: Fix revalidate)
CONFLICT (content): Merge conflict in fs/9p/vfs_inode.c
CONFLICT (content): Merge conflict in fs/9p/vfs_inode_dotl.c
Merging xfs/for-next (dd07bb8b6baf xfs: revert commit 8954c44ff477)
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
Merging iomap/iomap-for-next (471859f57d42 iomap: Rename page_ops to folio_=
ops)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (c65454a94726 fs: remove locks_inode)
CONFLICT (content): Merge conflict in fs/fuse/file.c
Merging iversion/iversion-next (58a033c9a3e0 nfsd: remove fetch_iversion ex=
port operation)
CONFLICT (content): Merge conflict in fs/stat.c
Merging vfs/for-next (e9f33f8668ab Merge branches 'work.misc', 'work.namesp=
ace', 'work.alpha', 'work.minix' and 'work.sysv' into for-next)
Merging printk/for-next (10d639febe56 Merge branch 'for-6.3' into for-next)
Merging pci/next (34d61afab691 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (858cb15643c2 Merge branch 'for-6.3/asus' into for-nex=
t)
Merging i2c/i2c/for-next (0a644cbebd3f Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (e826acc18bc7 i3c: transfer pid from boardinfo to devi=
ce info)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (a1ffd3c46267 hwmon: (mlxreg-fan) Return z=
ero speed for broken fan)
Merging jc_docs/docs-next (e076f253283c Merge branch 'docs-mw' into docs-ne=
xt)
CONFLICT (content): Merge conflict in Documentation/hwmon/index.rst
Merging v4l-dvb/master (83e0f265aa8d Merge git://git.linuxtv.org/media_stag=
e into media_tree)
CONFLICT (modify/delete): drivers/media/platform/ti/davinci/vpbe_display.c =
deleted in HEAD and modified in v4l-dvb/master.  Version v4l-dvb/master of =
drivers/media/platform/ti/davinci/vpbe_display.c left in tree.
CONFLICT (modify/delete): drivers/media/platform/ti/davinci/vpbe_osd.c dele=
ted in HEAD and modified in v4l-dvb/master.  Version v4l-dvb/master of driv=
ers/media/platform/ti/davinci/vpbe_osd.c left in tree.
CONFLICT (modify/delete): drivers/media/platform/ti/davinci/vpbe_venc.c del=
eted in HEAD and modified in v4l-dvb/master.  Version v4l-dvb/master of dri=
vers/media/platform/ti/davinci/vpbe_venc.c left in tree.
CONFLICT (content): Merge conflict in drivers/staging/media/Kconfig
CONFLICT (content): Merge conflict in drivers/staging/media/Makefile
$ git rm -f drivers/media/platform/ti/davinci/vpbe_display.c drivers/media/=
platform/ti/davinci/vpbe_osd.c drivers/media/platform/ti/davinci/vpbe_venc.c
Merging v4l-dvb-next/master (05165248df65 media: v4l2-ctrls-api.c: move ctr=
l->is_new =3D 1 to the correct line)
Merging pm/linux-next (5a9a0292e86a Merge branch 'thermal' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (ba38f3cbe7db dt-bindings: opp: =
opp-v2-kryo-cpu: enlarge opp-supported-hw maximum)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (eca4c0eea534 OPP: fix error checking in opp_mig=
rate_dentry())
Merging thermal/thermal/linux-next (a2c81dc59d41 Merge back thermal control=
 material for 6.3.)
Merging dlm/next (723b197bbdf1 fs: dlm: remove unnecessary waker_up() calls)
Merging rdma/for-next (91d088a03049 RDMA/umem: Remove unused 'work' member =
from struct ib_umem)
Merging net-next/master (894341ad3ad7 net: phylink: support validated pause=
 and autoneg in fixed-link)
CONFLICT (modify/delete): Documentation/networking/device_drivers/ethernet/=
mellanox/mlx5.rst deleted in net-next/master and modified in HEAD.  Version=
 HEAD of Documentation/networking/device_drivers/ethernet/mellanox/mlx5.rst=
 left in tree.
CONFLICT (content): Merge conflict in drivers/net/ethernet/intel/ice/ice_xs=
k.c
$ git rm -f Documentation/networking/device_drivers/ethernet/mellanox/mlx5.=
rst
Applying: fixup for "net/mlx5: Separate mlx5 driver documentation into mult=
iple pages"
Merging bpf-next/for-next (b2d9002ee9a6 Merge branch 'Improvements for BPF_=
ST tracking by verifier ')
Merging ipsec-next/master (75da437a2f17 Merge branch '40GbE' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging mlx5-next/mlx5-next (22551e77e550 net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (46b5be95b5cb netfilter: let reset rules clean out=
 conntrack entries)
Merging bluetooth/master (58c6156a4d4b Bluetooth: hci_mrvl: Add serdev supp=
ort for 88W8997)
Merging wireless-next/for-next (3caf31e7b18a wifi: mac80211: add documentat=
ion for amsdu_mesh_control)
Merging mtd/mtd/next (84549c816dc3 mtd: parsers: ofpart: add workaround for=
 #size-cells 0)
Merging nand/nand/next (ef3e6327ff04 mtd: rawnand: sunxi: Precompute the EC=
C_CTL register value)
Merging spi-nor/spi-nor/next (f047382519ca Merge tag 'mtd/fixes-for-6.2-rc4=
' into spi-nor/next)
Merging crypto/master (8b8447531864 crypto: x86/aria-avx - Do not use avx2 =
instructions)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging drm/drm-next (48075a66fca6 Merge branch 'etnaviv/next' of https://g=
it.pengutronix.de/git/lst/linux into drm-next)
CONFLICT (content): Merge conflict in Documentation/accel/introduction.rst
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/soc21.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gpu_error.c
Merging drm-misc/for-linux-next (38b2d8efd03d drm: panel-orientation-quirks=
: Add quirk for Lenovo IdeaPad Duet 3 10IGL5)
Merging amdgpu/drm-next (35f33086b1b9 drm/amd/display: Add support for mult=
iple overlay planes)
Merging drm-intel/for-linux-next (8038510b1fe4 drm/i915: Fix system suspend=
 without fbdev being initialized)
Merging drm-tegra/for-next (b9930311641c gpu: host1x: Fix uninitialized var=
iable use)
Merging drm-msm/msm-next (dbd7a2a941b8 PM / devfreq: Fix build issues with =
devfreq disabled)
Merging drm-msm-lumag/msm-next-lumag (1d233b1cb149 drm/msm/dpu: set pdpu->i=
s_rt_pipe early in dpu_plane_sspp_atomic_update())
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (4ec5183ec486 Linux 6.2-rc7)
Merging regmap/for-next (76f52deacb3d Merge remote-tracking branch 'regmap/=
for-6.3' into regmap-next)
Merging sound/for-next (5791c7699ff1 ALSA: hda: cs35l41: Enable Amp High Pa=
ss Filter)
Merging sound-asoc/for-next (d98e2e206a20 Merge remote-tracking branch 'aso=
c/for-6.3' into asoc-next)
CONFLICT (modify/delete): sound/soc/cirrus/ep93xx-ac97.c deleted in HEAD an=
d modified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/so=
c/cirrus/ep93xx-ac97.c left in tree.
CONFLICT (modify/delete): sound/soc/pxa/e740_wm9705.c deleted in HEAD and m=
odified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/soc/p=
xa/e740_wm9705.c left in tree.
CONFLICT (modify/delete): sound/soc/pxa/e750_wm9705.c deleted in HEAD and m=
odified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/soc/p=
xa/e750_wm9705.c left in tree.
CONFLICT (modify/delete): sound/soc/pxa/e800_wm9712.c deleted in HEAD and m=
odified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/soc/p=
xa/e800_wm9712.c left in tree.
CONFLICT (modify/delete): sound/soc/ti/davinci-vcif.c deleted in HEAD and m=
odified in sound-asoc/for-next.  Version sound-asoc/for-next of sound/soc/t=
i/davinci-vcif.c left in tree.
$ git rm -f sound/soc/pxa/e740_wm9705.c sound/soc/pxa/e750_wm9705.c sound/s=
oc/pxa/e800_wm9712.c sound/soc/cirrus/ep93xx-ac97.c sound/soc/ti/davinci-vc=
if.c
Merging modules/modules-next (2ece476a2346 module: replace module_layout wi=
th module_memory)
Merging input/next (04f8b4ea20c8 Input: pmic8xxx-keypad - fix a Kconfig spe=
lling mistake & hyphenation)
CONFLICT (modify/delete): drivers/input/touchscreen/ucb1400_ts.c deleted in=
 HEAD and modified in input/next.  Version input/next of drivers/input/touc=
hscreen/ucb1400_ts.c left in tree.
$ git rm -f drivers/input/touchscreen/ucb1400_ts.c
Merging block/for-next (04bdfe5bb926 Merge branch 'for-6.3/block' into for-=
next)
CONFLICT (content): Merge conflict in mm/filemap.c
Applying: fixup for "ublk_drv: add mechanism for supporting unprivileged ub=
lk device"
Merging device-mapper/for-next (b0bbd86a288a dm sysfs: make kobj_type struc=
ture constant)
CONFLICT (content): Merge conflict in drivers/md/dm-integrity.c
Merging libata/for-next (8844f0aa8dc4 ata: pata_parport: Fix ida_alloc retu=
rn value error check)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (a543f7024e35 mmc: meson-gx: support platform interrupt as=
 card detect interrupt)
Merging mfd/for-mfd-next (a5f31a668da1 dt-bindings: mfd: qcom,tcsr: Add com=
patible for IPQ5332)
Merging backlight/for-backlight-next (718c35c8d594 backlight: ktz8866: Add =
support for Kinetic KTZ8866 backlight)
Merging battery/for-next (c142872ea40a power: reset: odroid-go-ultra: fix I=
2C dependency)
CONFLICT (content): Merge conflict in drivers/power/supply/Makefile
Merging regulator/for-next (ea3efd52e962 Merge remote-tracking branch 'regu=
lator/for-6.3' into regulator-next)
Merging security/next (88603b6dc419 Linux 6.2-rc2)
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (4958db3245fa ima: Introduce MMAP_CHECK_RE=
QPROT hook)
Applying: fixup for "ima: Introduce MMAP_CHECK_REQPROT hook"
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (88603b6dc419 Linux 6.2-rc2)
Merging smack/next (c0e48d3f7722 smackfs: Added check catlen)
Merging tomoyo/master (5fc44ba8be52 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (85b93bbd1c97 tpm: add vendor flag to command code valid=
ation)
Merging watchdog/master (00bdbc9a8601 watchdog: wdat_wdt: Avoid unimplement=
ed get_timeleft)
Merging iommu/next (7eab5ffd59e6 Merge branches 'apple/dart', 'arm/exynos',=
 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/usnic/usnic_uio=
m.c
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_type1.c
Merging audit/next (6c6cd913accd audit: update the mailing list in MAINTAIN=
ERS)
Merging devicetree/for-next (25eba1598c8e dt-bindings: Fix multi pattern su=
pport in DT_SCHEMA_FILES)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mmc=
/nvidia,tegra20-sdhci.yaml
Merging dt-krzk/for-next (825475539974 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (0693537a8d4b Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging tip/master (838b9e0b67b5 Merge branch into tip/master: 'x86/build')
CONFLICT (modify/delete): arch/arm/mach-omap2/pm24xx.c deleted in HEAD and =
modified in tip/master.  Version tip/master of arch/arm/mach-omap2/pm24xx.c=
 left in tree.
CONFLICT (content): Merge conflict in arch/s390/kernel/idle.c
$ git rm -f arch/arm/mach-omap2/pm24xx.c
Merging clockevents/timers/drivers/next (ab407a1919d2 Merge tag 'clocksourc=
e.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/lin=
ux-rcu into timers/core)
Merging edac/edac-for-next (feac08675023 Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (7135b35fc959 Merge branch irq/irqdomain-l=
ocking into irq/irqchip-next)
CONFLICT (content): Merge conflict in drivers/irqchip/irq-apple-aic.c
Merging ftrace/for-next (22916110bfa3 Merge branch 'trace/tools/for-next' i=
nto trace/for-next)
CONFLICT (content): Merge conflict in Documentation/trace/histogram.rst
CONFLICT (content): Merge conflict in Documentation/trace/kprobetrace.rst
Merging rcu/rcu/next (cdd4b92e382b tools/memory-model: Provide exact SRCU s=
emantics)
Merging kvm/next (7cb79f433e75 KVM: PPC: Fix refactoring goof in kvmppc_e50=
0mc_init())
CONFLICT (content): Merge conflict in arch/x86/kvm/reverse_cpuid.h
Merging kvm-arm/next (7121a2e1d107 Merge branch kvm-arm64/nv-prefix into kv=
marm/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (9fa259abdb42 KVM: x86: Assert that emulate doesn't lo=
ad CS with garbage in !RM)
CONFLICT (content): Merge conflict in arch/x86/include/asm/cpufeatures.h
Merging xen-tip/linux-next (9a0450ada86e xen: Replace one-element array wit=
h flexible-array member)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (3004e8d2a0a9 platform/x86/amd/pmf: Add depend=
s on CONFIG_POWER_SUPPLY)
Merging chrome-platform/for-next (b0d8a67715da platform/chrome: cros_ec_typ=
ec: Fix spelling mistake)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (4aea8f30475f Documentation: leds: Correct sp=
elling)
Merging ipmi/for-next (befb28f2676a ipmi: ipmb: Fix the MODULE_PARM_DESC as=
sociated to 'retry_time_ms')
Merging driver-core/driver-core-next (ade1229caed9 dma-mapping: no need to =
pass a bus_type into get_arch_dma_ops())
CONFLICT (content): Merge conflict in drivers/base/core.c
CONFLICT (content): Merge conflict in include/linux/acpi.h
Merging usb/usb-next (8e5248c3a877 usb: dwc3: pci: add support for the Inte=
l Meteor Lake-M)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging thunderbolt/next (06cbcbfaa651 thunderbolt: Add missing kernel-doc =
comment to tb_tunnel_maximum_bandwidth())
Merging usb-serial/usb-next (617c331d9107 USB: serial: option: add support =
for VW/Skoda "Carstick LTE")
Merging tty/tty-next (370f696e4474 dt-bindings: serial: snps-dw-apb-uart: a=
dd dma & dma-names properties)
Merging char-misc/char-misc-next (e42af72223fd firmware: coreboot: Remove G=
OOGLE_COREBOOT_TABLE_ACPI/OF Kconfig entries)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/fpga/dfl.c
CONFLICT (content): Merge conflict in drivers/fpga/dfl.h
Merging accel/habanalabs-next (3315cc6cbe14 habanalabs: don't trace cpu acc=
essible dma alloc/free)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (ffa562d00072 fpga: bridge: return errors in the show=
() method of the "state" attribute)
CONFLICT (content): Merge conflict in drivers/fpga/dfl.h
Merging icc/icc-next (7bf0008a5293 Merge branch 'icc-dt' into icc-next)
Merging iio/togreg (91ba2700aa75 staging: iio: meter: Drop ade7854 driver)
Merging phy-next/next (037d05af382e phy: qcom: snps-eusb2: Add missing head=
ers)
Merging soundwire/next (66f95de7c13b soundwire: cadence: further simplify l=
ow-level xfer_msg_defer() callback)
Merging extcon/extcon-next (2e85d0a0201d extcon: qcom-spmi: Switch to platf=
orm_get_irq_byname_optional)
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (c55365a09302 docs: vfio: Update vfio.rst per latest inte=
rfaces)
Merging staging/staging-next (eec8ccab1b57 most: add maintainer entry)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging counter-next/counter-next (01f714ee022e counter: fix dependency ref=
erences for config MICROCHIP_TCB_CAPTURE)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (1f6484614d74 dmaengine: idma64: Update bytes_transf=
erred field)
Merging cgroup/for-next (14fffd51f902 Merge branch 'for-6.2-fixes' into for=
-next)
Merging scsi/for-next (1a10df75c93f Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (833f7d4819a8 scsi: ufs: core: Fix an error handl=
ing path in ufshcd_read_desc_param())
Merging vhost/linux-next (c6604d092d45 virtio_ring: introduce virtqueue_res=
et())
Merging rpmsg/for-next (c7ed92130c40 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Applying: remoteproc: fix for "iommu: Add a gfp parameter to iommu_map()"
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (4827aae06133 gpio: sim: Use %pfwP specifie=
r instead of calling fwnode API directly)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (099f37a539e6 pinctrl: qcom: Add support for i2c s=
pecific pull feature)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging pinctrl-intel/for-next (88f8ac47bddc pinctrl: Proofreading and upda=
ting the documentation (part 2))
Merging pinctrl-renesas/renesas-pinctrl (698485cd875b pinctrl: renesas: r8a=
77950: Add VIN[45] pins, groups, and functions)
Merging pinctrl-samsung/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pwm/for-next (2781f8e92036 pwm: lp3943: Drop unused i2c include)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (bbf45b2ab467 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (0eb15a47bf43 selftests/user_events: add a note abou=
t user_events.h dependency)
Merging kunit/test (1b929c02afd3 Linux 6.2-rc1)
Merging kunit-next/kunit (82649c7c0da4 kunit: Add printf attribute to fail_=
current_test_impl)
Merging livepatching/for-next (b2e118419db3 Merge branch 'for-6.3/cleanup-r=
elocations' into for-next)
Merging rtc/rtc-next (e8c9efd5d52f dt-bindings: rtc: moxart: use proper nam=
es for gpio properties)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ntb/ntb-next (0310a30a9395 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging nvmem/for-next (fa7876365ad2 nvmem: stm32: fix OPTEE dependency)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (96ec2939620c Drivers: hv: Make remove callback =
of hyperv driver void returned)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (1b929c02afd3 Linux 6.2-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (3c54a3ff0a2c bus: mhi: ep: Fix off by one in mhi_ep_p=
rocess_cmd_ring())
Merging memblock/for-next (2fe03412e2e1 memblock: Avoid useless checks in m=
emblock_merge_regions().)
Merging cxl/next (b8b9ffced017 Merge branch 'for-6.3/cxl-ram-region' into c=
xl/next)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (45d5165426ae efi: Add mixed-mode thunk recipe for GetMemo=
ryAttributes)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (603c592a005a Merge branch 'slab/for-6.3/fixes' into =
slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (1c1ea1c3e21d MAINTAINERS: Update Landlock repository)
Merging rust/rust-next (7ea01d3169a2 rust: delete rust-project.json when ru=
nning make clean)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (18e93f4dc099 bitmap: switch from inline to =
__always_inline)
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (78f7a3fd6dc6 randstruct: disable Clang 15 suppo=
rt)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (b3551ead6163 iommufd: Make sure to zero vfio_iomm=
u_type1_info before copying to user)
Merging mm-stable/mm-stable (6bdfc60cf0f9 mm: fix typo in __vm_enough_memor=
y warning)
CONFLICT (content): Merge conflict in Documentation/admin-guide/cgroup-v1/m=
emory.rst
CONFLICT (content): Merge conflict in Documentation/admin-guide/mm/numaperf=
.rst
CONFLICT (modify/delete): drivers/gpu/drm/i810/i810_dma.c deleted in HEAD a=
nd modified in mm-stable/mm-stable.  Version mm-stable/mm-stable of drivers=
/gpu/drm/i810/i810_dma.c left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/hw/hfi1/file_ops.c
CONFLICT (modify/delete): drivers/staging/media/deprecated/meye/meye.c dele=
ted in HEAD and modified in mm-stable/mm-stable.  Version mm-stable/mm-stab=
le of drivers/staging/media/deprecated/meye/meye.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/deprecated/stkwebcam/stk-we=
bcam.c deleted in HEAD and modified in mm-stable/mm-stable.  Version mm-sta=
ble/mm-stable of drivers/staging/media/deprecated/stkwebcam/stk-webcam.c le=
ft in tree.
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in fs/nfs/write.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
$ git rm -f drivers/gpu/drm/i810/i810_dma.c drivers/staging/media/deprecate=
d/meye/meye.c drivers/staging/media/deprecated/stkwebcam/stk-webcam.c
Applying: accel/ivpu: fix up for "mm: introduce vma->vm_flags wrapper funct=
ions"
Applying: udf: fix up for "fs: convert writepage_t callback to pass a folio"
Applying: mm: fixup for "mm: implement memory-deny-write-execute as a prctl"
Applying: gfs2: fix up for "fs: convert writepage_t callback to pass a foli=
o"
Merging mm-nonmm-stable/mm-nonmm-stable (817013880a68 Update CREDITS file e=
ntry for Jesper Juhl)
Merging mm/mm-everything (d4b73524ec92 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/acco=
unting/delay-accounting.rst
CONFLICT (content): Merge conflict in include/linux/memcontrol.h
CONFLICT (content): Merge conflict in mm/filemap.c
CONFLICT (content): Merge conflict in mm/memcontrol.c

--Sig_/0m/gUWjz=_aO6xOPe5qqqM+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtqaEACgkQAVBC80lX
0GxRLQgAg29ERg9p0+bO4tjdk0vWNTMWU+2WFPfA9EGmn6ZEIljS8JbesGIg40DC
cjgoHA6zQWWPq2JNR5/rEFOtpetjGIYBj9cbqCe9g4kNFKV5DR1842SPo8CbQp1t
paJSsiCANImyyAPqFGcuun/ZPEWaDlhlG95+2tkkaDlpt2IvQuwu2SHrOfC+OidP
jMC8R5/qHER2jF1n0RzNO9T94suhSnmqqAFYIpvmWy4chaf6P1rTl7O54h1STbHt
69lzg1F1a3lSSK3T2JRhsFWRvTcY+oKKChfJrO+5cQoAabvVNR0lYX89yXHGbByG
Q8gjCHmzVreToe1/2cZ4NrdN3p5+xA==
=yq55
-----END PGP SIGNATURE-----

--Sig_/0m/gUWjz=_aO6xOPe5qqqM+--
