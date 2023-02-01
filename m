Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB5F685E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBAEVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAEVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:21:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782058665;
        Tue, 31 Jan 2023 20:20:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P67xf1yW7z4x1h;
        Wed,  1 Feb 2023 15:20:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675225222;
        bh=FIATVsRjQB4rtG7WGBYw+xpM0YjqX/qe6DWiz6mj65I=;
        h=Date:From:To:Cc:Subject:From;
        b=Me1dGet/rWjTvRhSZ//0GrufN+GVp1GwQNEYXQLse0mUcACqQ3m83VrH1p7xYgplN
         UKblgwuTgSjorybqVtO1HXgm/xo6npxuQquGTYCfV+A9efPGl9SVe8xpQzac/wYwFt
         jnfY7/NLa4NY9LFwnyKD1AV2GOgWUNnZl1WC3KQojsTNqlo1c2S5Bi5H1rvQFj8oNo
         uQz2T8UM5LRrDiq0xIL0taiV29j64qNSze/NNFDPm4kGRYJhTUXlofqARzy11f66J6
         Qrzw4j/uZ9DCNZq6ELwywtFFQ3sqC65NHlr8HWIvOxJTL8SpCGyWnBHRHk4ZzJMS0U
         jYwQ1qmB2szNA==
Date:   Wed, 1 Feb 2023 15:20:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 1
Message-ID: <20230201152021.6e5ce6b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JBOjpK7Vkvc/yBwOUQQqt8l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JBOjpK7Vkvc/yBwOUQQqt8l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230131:

The jc_docs tree gained a conflict against the hwmon-staging tree.

The sound-asoc tree gained conflicts against the arm-soc tree and a
build failure so I used the version from next-20230131.

The iommu tree gained a conflict against the rdma-fixes tree.

The kunit-next tree gained a conflict against the kunit-fixes tree.

Non-merge commits (relative to Linus' tree): 8871
 9776 files changed, 366532 insertions(+), 354182 deletions(-)

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
Merging origin/master (58706f7fb045 Merge tag 'scsi-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (da68efd721da lib: parser: optimiz=
e match_NUMBER apis to use local array)
Merging kbuild-current/fixes (22e46f6480e8 kbuild: modinst: Fix build error=
 when CONFIG_MODULE_SIG_KEY is a PKCS#11 URI)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2f62847cf6ae ARM: 9287/1: Reduce __thumb2__ defi=
nition to crypto files that require it)
Merging arm64-fixes/for-next/fixes (a428eb4b99ab Partially revert "perf/arm=
-cmn: Optimise DTC counter accesses")
Merging arm-soc-fixes/arm/fixes (8a74191c899e Merge tag 'imx-fixes-6.2-2' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fix=
es)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (553b20b211c4 m68k: defconfig: Update defcon=
figs for v6.1-rc1)
Merging powerpc-fixes/fixes (111bcb373853 powerpc/64s/radix: Fix RWX mappin=
g with relocated kernel)
Merging s390-fixes/fixes (7ab41c2c08a3 s390/decompressor: specify __decompr=
ess() buf len to avoid overflow)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (31e1be62abde MAINTAINERS: update fscry=
pt git repo)
Merging fsverity-current/for-current (ef7592e466ef MAINTAINERS: update fsve=
rity git repo, list, and patchwork)
Merging net/master (de5ca4c3852f net: sched: sch: Bounds check priority)
Merging bpf/master (a6efc42a86c0 selftest: net: Improve IPV6_TCLASS/IPV6_HO=
PLIMIT tests apparmor compatibility)
Merging ipsec/master (0a9e5794b21e xfrm: annotate data-race around use_time)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (f2b0b5210f67 net/x25: Fix to not accept on connected s=
ocket)
Merging wireless/for-next (80f8a66dede0 Revert "wifi: mac80211: fix memory =
leak in ieee80211_if_add()")
Merging rdma-fixes/for-rc (c956940a4ab7 RDMA/umem: Use dma-buf locked API t=
o solve deadlock)
Merging sound-current/for-linus (c7a806d9ce67 ALSA: firewire-motu: fix unre=
leased lock warning in hwdep device)
Merging sound-asoc-fixes/for-linus (2036890282d5 ASoC: rt715-sdca: fix cloc=
k stop prepare timeout issue)
Merging regmap-fixes/for-linus (697c3892d825 regmap: apply reg_base and reg=
_downshift for single register ops)
Merging regulator-fixes/for-linus (4bb3d82a1820 regulator: dt-bindings: sam=
sung,s2mps14: add lost samsung,ext-control-gpios)
Merging spi-fixes/for-linus (35bba23e6732 Merge remote-tracking branch 'spi=
/for-6.2' into spi-6.2)
Merging pci-current/for-linus (ad34656db3b9 MAINTAINERS: Move to shared PCI=
 tree)
Merging driver-core.current/driver-core-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging tty.current/tty-linus (226fae124b2d vc_screen: move load of struct =
vc_data pointer in vcs_read() to avoid UAF)
Merging usb.current/usb-linus (2fa89458af99 usb: gadget: f_uac2: Fix incorr=
ect increment of bNumEndpoints)
Merging usb-serial-fixes/usb-linus (71dfd381a7c0 USB: serial: option: add Q=
uectel EM05CN modem)
Merging phy/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging staging.current/staging-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging iio-fixes/fixes-togreg (6327a930ab7b drivers: iio: adc: ltc2497: fi=
x LSB shift)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (9944028659e6 Merge tag 'iio-fixe=
s-for-6.2a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-next)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (6d796c50f84c Linux 6.2-rc6)
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
Merging dmaengine-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
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
Merging hwmon-fixes/hwmon (2fbb848b65cd hwmon: (nct6775) Fix incorrect pare=
nthesization in nct6775_write_fan_div())
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (19398821b25a cxl/pmem: Fix nvdimm unregistration w=
hen cxl_pmem driver is absent)
Merging btrfs-fixes/next-fixes (62e590cc91d0 Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (9c7417b5ec44 coredump: Move dump_emit_page() to ki=
ll unused warning)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (eebf82012ddd platform/x86: thinkpad_acpi: =
Fix thinklight LED brightness returning 255)
Merging samsung-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (2f7e5f85a13d of/address: Return an error=
 when no valid dma-ranges are found)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (15600159bcc6 scsi: Revert "scsi: core: map PQ=3D1=
, PDT=3Dother values to SCSI_SCAN_TARGET_PRESENT")
Merging drm-fixes/drm-fixes (6d796c50f84c Linux 6.2-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (47a2bd9d985b drm/i915/adlp: F=
ix typo for reference clock)
Merging mmc-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (25c94b051592 Drivers: hv: vmbus: fix pos=
sible memory leak in vmbus_device_register())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (c1d610586946 riscv: Move call to init_cpu_topol=
ogy() to later initialization stage)
Merging riscv-dt-fixes/riscv-dt-fixes (43d5f5d63699 riscv: dts: sifive: fu7=
40: fix size of pcie 32bit memory)
Merging riscv-soc-fixes/riscv-soc-fixes (730892135b7d soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging spdx/spdx-linus (5dc4c995db9e Linux 6.2-rc4)
Merging gpio-brgl-fixes/gpio/for-current (6d796c50f84c Linux 6.2-rc6)
Merging gpio-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging erofs-fixes/fixes (e02ac3e7329f erofs: clean up parsing of fscache =
related options)
Merging kunit-fixes/kunit-fixes (254c71374a70 kunit: fix kunit_test_init_se=
ction_suites(...))
Merging ubifs-fixes/fixes (7bdd6967fec5 ubi: ensure that VID header offset =
+ VID header size <=3D alloc, size)
Merging memblock-fixes/fixes (115d9d77bb0f mm: Always release pages to the =
buddy allocator in memblock_free_late().)
Merging nfsd-fixes/nfsd-fixes (4bdbba54e9b1 nfsd: don't free files uncondit=
ionally in __nfsd_file_cache_purge)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (f883675bf652 Merge tag 'gpio-fixes-for-v6=
.2-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging efi-fixes/urgent (e1fabbc83cb1 efi: Remove Matthew Garrett as efiva=
rfs maintainer)
Merging zstd-fixes/zstd-linus (0a2cbd1f53f3 lib: zstd: Fix -Wstringop-overf=
low warning)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging rust-fixes/rust-fixes (6618d69aa129 rust: print: avoid evaluating a=
rguments in `pr_*` macros in `unsafe` blocks)
Merging drm-misc-fixes/for-linux-next-fixes (90741096769b drm/nouveau/acr/g=
m20b: regression fixes)
Merging kbuild/for-next (a753df4a3705 setlocalversion: do not append git co=
mmit hash if localversion* exists)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (5670ebf54bd2 perf cs-etm: Ensure that Coresight tim=
estamps don't go backwards)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (3622b86f49f8 dma-mapping: reject GFP_COMP for=
 noncoherent allocations)
Merging asm-generic/master (32975c491ee4 uapi: Add missing _UAPI prefix to =
<asm-generic/types.h> include guard)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (ba07b4efc989 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (8154ffb7a518 Merge branches 'for-next/sysreg',=
 'for-next/sme', 'for-next/kselftest', 'for-next/misc', 'for-next/sme2', 'f=
or-next/tpidr2', 'for-next/scs', 'for-next/compat-hwcap', 'for-next/ftrace'=
, 'for-next/efi-boot-mmu-on', 'for-next/ptrauth' and 'for-next/pseudo-nmi' =
into for-next/core)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging arm-perf/for-next/perf (4998897b1e96 perf: arm_spe: Support new SPE=
v1.2/v8.7 'not taken' event)
Merging arm-soc/for-next (dc1ced73f4a4 soc: document merges)
CONFLICT (content): Merge conflict in arch/arm/mach-s3c/Makefile
Merging amlogic/for-next (330d3c9dec55 Merge branch 'v6.3/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (22991d8d5725 soc: apple: rtkit: Add r=
egister dump decoding to crashlog)
Merging aspeed/for-next (82f423102f9b soc: nuvoton: Add SoC info driver for=
 WPCM450)
Merging at91/at91-next (78712fb81548 Merge branch 'clk-microchip-fixes' int=
o at91-next)
Merging broadcom/next (9b385edf71bd Merge branch 'devicetree-arm64/next' in=
to next)
Merging davinci/davinci/for-next (eaafab7e8e26 MAINTAINERS: make me the mai=
ntainer of DaVinci platforms)
Merging drivers-memory/for-next (682a91c4375f Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (fd5368f6f08b Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (e1c7411b49c5 Merge branch 'v6.2-next/soc' into f=
or-next)
Merging mvebu/for-next (80502ffab2fa arm64: dts: marvell: AC5/AC5X: Fix add=
ress for UART1)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (3866989ec2c3 Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-for-6.3' and 'dts-for-6.3' into=
 for-next)
Merging renesas/next (8dd3dae1705b Merge branches 'renesas-arm-defconfig-fo=
r-v6.3', 'renesas-drivers-for-v6.3', 'renesas-dt-bindings-for-v6.3' and 're=
nesas-dts-for-v6.3' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (bc6e0c1cea1b Merge branch 'v6.3-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (dbeabba3b8e8 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (ef4e5bc30a08 Merge branch 'for-next/cacheinfo'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into f=
or-linux-next)
Merging stm32/stm32-next (2f33df889e99 ARM: dts: stm32: Use new media bus t=
ype macros)
Merging sunxi/sunxi/for-next (caea0128c038 Merge branch 'sunxi/dt-for-6.3' =
into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (de98d45290c7 Merge branch for-6.3/arm64/dt into for=
-next)
Merging ti/ti-next (175357d1deed arm64: dts: ti: iot2050: Add support for M=
.2 variant)
Merging xilinx/for-next (a18426505c2b Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (623880b50033 Merge branch 'clk-mediatek' into clk-nex=
t)
Merging clk-imx/for-next (4e197ee880c2 clk: imx6ul: add ethernet refclock m=
ux support)
Merging clk-renesas/renesas-clk (bd176e46e9c2 clk: renesas: r8a779g0: Add C=
AN-FD clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (5dc4c995db9e Linux 6.2-rc4)
Merging m68k/for-next (be6c50d315f9 selftests/seccomp: Add m68k support)
Merging m68knommu/for-next (a4531ea58a66 m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (1b929c02afd3 Linux 6.2-rc1)
Merging mips/mips-next (109d587a4b4d MIPS: Fix a compilation issue)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (d4b96839a473 parisc: Ensure page-aligned addres=
ses in cache flush and copy functions)
Merging powerpc/next (bab537805a10 powerpc: Check !irq instead of irq =3D=
=3D NO_IRQ and remove NO_IRQ)
Merging powerpc-objtool/topic/objtool (1b929c02afd3 Linux 6.2-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (285b6a18daf1 RISC-V: Fix do_notify_resume / do_wor=
k_pending prototype)
CONFLICT (content): Merge conflict in arch/riscv/kernel/probes/simulate-ins=
n.h
Merging riscv-dt/riscv-dt-for-next (d9c36d016f61 Merge patch series "Add a =
devicetree for the Aldec PolarFire SoC TySoM")
Merging riscv-soc/riscv-soc-for-next (f3460326e38d Merge patch series "JH71=
10 PMU Support")
Merging s390/for-next (b611616cfdd9 Merge branch 'features' into for-next)
Merging uml/next (43ee0357e15b um: vector: Fix memory leak in vector_config)
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
Merging fscrypt/for-next (5dc4c995db9e Linux 6.2-rc4)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (a192a142956b Merge branch 'for-next-next-v6.2-20230=
127' into for-next-20230127)
Merging ceph/master (8e1858710d9a ceph: avoid use-after-free in ceph_fl_rel=
ease_lock())
Merging cifs/for-next (fea27f5e9e3a cifs: get rid of unneeded conditional i=
n cifs_get_num_sgs())
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (e809f631b128 erofs: simplify iloc())
Merging exfat/dev (5742d6a467d1 exfat: handle unreconized benign secondary =
entries)
Merging ext3/for_next (085cf7b7e2ef udf: Fix file counting in LVID)
Merging ext4/dev (1da18e38cb97 ext4: fix reserved cluster accounting in __e=
s_remove_extent())
Merging f2fs/dev (de6b3a5e09b2 f2fs: fix to update age extent in f2fs_do_ze=
ro_range())
CONFLICT (content): Merge conflict in fs/f2fs/namei.c
Merging fsverity/for-next (51e4e3153ebc fscrypt: support decrypting data fr=
om large folios)
Merging fuse/for-next (1cc4606d19e3 fuse: add inode/permission checks to fi=
leattr_get/fileattr_set)
Merging gfs2/for-next (b66f723bb552 gfs2: Improve gfs2_make_fs_rw error han=
dling)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (7a17c61ee3b2 ksmbd: Fix spelling mistake "exc=
ceed" -> "exceeded")
Merging nfs/linux-next (2241ab53cbb5 Linux 6.2-rc5)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/nfsd-next (c2abab2b888b NFSD: fix problems with cleanup on err=
ors in nfsd4_copy)
Merging ntfs3/master (57c94236401b fs/ntfs3: Refactoring of various minor i=
ssues)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (8d0960731a26 jffs2: Fix list_del corruption if compress=
ors initialized failed)
Merging v9fs/9p-next (1a4f69ef15ec 9p/client: fix data race on req->status)
Merging v9fs-ericvh/ericvh/for-next (32a145a90935 fs/9p: Fix revalidate)
CONFLICT (content): Merge conflict in fs/9p/vfs_inode.c
CONFLICT (content): Merge conflict in fs/9p/vfs_inode_dotl.c
Merging xfs/for-next (601a27ea09a3 xfs: fix extent busy updating)
Merging zonefs/for-next (43592c46375a zonefs: Cache zone group directory in=
odes)
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
Merging printk/for-next (930348ab0ad9 Merge branch 'rework/buffers-cleanup'=
 into for-next)
Merging pci/next (78913b41945a Merge branch 'remotes/lorenzo/pci/switchtec')
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (06f8ed62c952 Merge branch 'for-6.2/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (726ba204f4c7 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (e826acc18bc7 i3c: transfer pid from boardinfo to devi=
ce info)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (5e5c0d034105 hwmon: (aquacomputer_d5next)=
 Add support for Aquacomputer Poweradjust 3)
Merging jc_docs/docs-next (747a5a95bf3e Merge branch 'docs-mw' into docs-ne=
xt)
CONFLICT (content): Merge conflict in Documentation/hwmon/index.rst
Merging v4l-dvb/master (6599e683db1b Merge tag 'v6.2-rc1' into media_tree)
Merging v4l-dvb-next/master (7120d6bfd6d0 media: tm6000: remove deprecated =
driver)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/staging/media/Kconfig
CONFLICT (content): Merge conflict in drivers/staging/media/Makefile
Merging pm/linux-next (ab970ed365c9 Merge branch 'thermal' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (4e52565af94e dt-bindings: cpufr=
eq: cpufreq-qcom-hw: Add SM8550 compatible)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (68d8ad3bd9c3 dt-bindings: opp: v2-qcom-level: L=
et qcom,opp-fuse-level be a 2-long array)
Merging thermal/thermal/linux-next (a2c81dc59d41 Merge back thermal control=
 material for 6.3.)
Merging dlm/next (723b197bbdf1 fs: dlm: remove unnecessary waker_up() calls)
Merging rdma/for-next (627122280c87 RDMA/mlx5: Add work to remove temporary=
 entries from the cache)
Merging net-next/master (df54fde451db net: ipa: use dev PM wakeirq handling)
Merging bpf-next/for-next (c1a3daf7363b Merge branch 'Support bpf trampolin=
e for s390x')
Merging ipsec-next/master (9f92752788d7 Merge branch 'adding-sparx5-is0-vca=
p-support')
Merging mlx5-next/mlx5-next (c4d508fbe54a net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (f5be9caf7bf0 net: ethtool: fix NULL pointer deref=
erence in pause_prepare_data())
Merging bluetooth/master (70fe6c1eb822 Bluetooth: hci_conn: Refactor hci_bi=
nd_bis() since it always succeeds)
Merging wireless-next/for-next (4ca69027691a wifi: wireless: deny wireless =
extensions on MLO-capable devices)
Merging mtd/mtd/next (c705e63a323a dt-bindings: mtd: partitions: Fix partit=
ion node name pattern)
Merging nand/nand/next (b56265257d38 mtd: rawnand: fsl_elbc: Propagate HW E=
CC settings to HW)
Merging spi-nor/spi-nor/next (59273180299a mtd: spi-nor: Create macros to d=
efine chip IDs and geometries)
Merging crypto/master (42a9a08b9aa6 crypto: engine - Fix excess parameter d=
oc warning)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging drm/drm-next (aebd8f0c6f82 Merge v6.2-rc6 into drm-next)
CONFLICT (content): Merge conflict in Documentation/accel/introduction.rst
Merging drm-misc/for-linux-next (aebd8f0c6f82 Merge v6.2-rc6 into drm-next)
Merging amdgpu/drm-next (44900af0401f drm/amd/display: Properly handle addi=
tional cases where DCN is not supported)
Merging drm-intel/for-linux-next (155c6b16eec2 Merge tag 'amd-drm-next-6.3-=
2023-01-27' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-tegra/for-next (2abdd44e3126 drm/tegra: nvdec: Use tegra_dev_io=
mmu_get_stream_id())
Merging drm-msm/msm-next (dbd7a2a941b8 PM / devfreq: Fix build issues with =
devfreq disabled)
Merging drm-msm-lumag/msm-next-lumag (1d233b1cb149 drm/msm/dpu: set pdpu->i=
s_rt_pipe early in dpu_plane_sspp_atomic_update())
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (30527af2bed1 drm/etnaviv: Remove #ifdef guard=
s for PM related functions)
Merging fbdev/for-next (ee9fffdc3887 fbdev: omapfb: Use kstrtobool() instea=
d of strtobool())
Merging regmap/for-next (e2f1700e954c Merge remote-tracking branch 'regmap/=
for-6.3' into regmap-next)
Merging sound/for-next (372a0d7856be ALSA: doc: Fix PCM interface section t=
ypos)
Merging sound-asoc/for-next (ae97ba516c13 Merge remote-tracking branch 'aso=
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
oc/pxa/e800_wm9712.c
$ git rm -f sound/soc/cirrus/ep93xx-ac97.c sound/soc/ti/davinci-vcif.c
$ git reset --hard HEAD^
Merging next-20230131 version of sound-asoc
CONFLICT (modify/delete): sound/soc/pxa/e740_wm9705.c deleted in HEAD and m=
odified in eeb6b0feb597e8fb88c4e1459323060e17350752.  Version eeb6b0feb597e=
8fb88c4e1459323060e17350752 of sound/soc/pxa/e740_wm9705.c left in tree.
CONFLICT (modify/delete): sound/soc/pxa/e750_wm9705.c deleted in HEAD and m=
odified in eeb6b0feb597e8fb88c4e1459323060e17350752.  Version eeb6b0feb597e=
8fb88c4e1459323060e17350752 of sound/soc/pxa/e750_wm9705.c left in tree.
CONFLICT (modify/delete): sound/soc/pxa/e800_wm9712.c deleted in HEAD and m=
odified in eeb6b0feb597e8fb88c4e1459323060e17350752.  Version eeb6b0feb597e=
8fb88c4e1459323060e17350752 of sound/soc/pxa/e800_wm9712.c left in tree.
$ git rm -f sound/soc/pxa/e740_wm9705.c sound/soc/pxa/e750_wm9705.c sound/s=
oc/pxa/e800_wm9712.c
[master 588d260c9b06] next-20230131/sound-asoc
Merging modules/modules-next (fbed4fea6422 module: Use kstrtobool() instead=
 of strtobool())
Merging input/next (04f8b4ea20c8 Input: pmic8xxx-keypad - fix a Kconfig spe=
lling mistake & hyphenation)
CONFLICT (modify/delete): drivers/input/touchscreen/ucb1400_ts.c deleted in=
 HEAD and modified in input/next.  Version input/next of drivers/input/touc=
hscreen/ucb1400_ts.c left in tree.
$ git rm -f drivers/input/touchscreen/ucb1400_ts.c
Merging block/for-next (4f8ff8a48858 Merge branch 'for-6.3/block' into for-=
next)
Applying: fixup for "ublk_drv: add mechanism for supporting unprivileged ub=
lk device"
Merging device-mapper/for-next (22c40e134c4c dm cache: Add some documentati=
on to dm-cache-background-tracker.h)
Merging libata/for-next (72f2b0b21850 drivers/block: Move PARIDE protocol m=
odules to drivers/ata/pata_parport)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (2cda1de0cb57 mmc: uniphier-sd: Add control to switch UHS =
speed)
Merging mfd/for-mfd-next (a5f31a668da1 dt-bindings: mfd: qcom,tcsr: Add com=
patible for IPQ5332)
Merging backlight/for-backlight-next (718c35c8d594 backlight: ktz8866: Add =
support for Kinetic KTZ8866 backlight)
Merging battery/for-next (6adaa9a4ece4 power: supply: bq25890: Add new linu=
x,iinlim-percentage property)
Merging regulator/for-next (78169d8f0799 Merge remote-tracking branch 'regu=
lator/for-6.3' into regulator-next)
Merging security/next (88603b6dc419 Linux 6.2-rc2)
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (b8dc57947379 ima: fix ima_delete_rules() =
kernel-doc warning)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (88603b6dc419 Linux 6.2-rc2)
Merging smack/next (c0e48d3f7722 smackfs: Added check catlen)
Merging tomoyo/master (5fc44ba8be52 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (b0474a20b153 tpm: Add reserved memory event log)
Merging watchdog/master (1b929c02afd3 Linux 6.2-rc1)
Merging iommu/next (28dcba7e10b6 Merge branches 'apple/dart', 'arm/exynos',=
 'arm/renesas', 'arm/smmu', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/usnic/usnic_uio=
m.c
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_type1.c
Merging audit/next (88603b6dc419 Linux 6.2-rc2)
Merging devicetree/for-next (8da765cca292 dt-bindings: vendor-prefixes: doc=
ument lineartechnology)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mmc=
/nvidia,tegra20-sdhci.yaml
Merging dt-krzk/for-next (e912da7a8875 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (30bfe8c1a9b8 Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
Merging tip/master (99f9b95e30d3 Merge x86/cpu into tip/master)
CONFLICT (modify/delete): arch/arm/mach-omap2/pm24xx.c deleted in HEAD and =
modified in tip/master.  Version tip/master of arch/arm/mach-omap2/pm24xx.c=
 left in tree.
$ git rm -f arch/arm/mach-omap2/pm24xx.c
Merging clockevents/timers/drivers/next (e09903cea09e clocksource/drivers/r=
iscv: Get rid of clocksource_arch_init() callback)
Merging edac/edac-for-next (4c5be17ae445 Merge branch 'edac-drivers' into e=
dac-for-next)
Merging irqchip/irq/irqchip-next (6ed54e1789a2 Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (9f712417e1fc Merge remote-tracking branch 'ftrace/=
bootconfig/for-next' into trace/for-next)
Merging rcu/rcu/next (d0df85c4fd09 tick/nohz: Fix cpu_is_hotpluggable() by =
checking with nohz subsystem)
Merging kvm/next (7cb79f433e75 KVM: PPC: Fix refactoring goof in kvmppc_e50=
0mc_init())
CONFLICT (content): Merge conflict in arch/x86/kvm/reverse_cpuid.h
Merging kvm-arm/next (a875b2475abf Merge remote-tracking branch 'oupton/kvm=
arm/next' into kvmarm-master/next)
Merging kvms390/next (99b63f55dc51 KVM: s390: remove unused gisa_clear_ipm_=
gisc() function)
Merging kvm-x86/next (0c681eed164c Merge branches 'apic', 'generic', 'misc'=
, 'mmu', 'pmu', 'selftests', 'svm' and 'vmx' into next)
CONFLICT (content): Merge conflict in arch/x86/include/asm/cpufeatures.h
Merging xen-tip/linux-next (ca0d80778e48 xen/pvcalls-back: fix permanently =
masked event channel)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (b7233286202b platform/x86: hp-wmi: Ignore Win=
-Lock key events)
Merging chrome-platform/for-next (478f32ab4daa platform/chrome: cros_typec_=
vdm: Fix VDO copy)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (4aea8f30475f Documentation: leds: Correct sp=
elling)
Merging ipmi/for-next (041fae9c105a Merge tag 'f2fs-for-6.2-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging driver-core/driver-core-next (90be1f15c398 driver core: soc: remove=
 layering violation for the soc_bus)
CONFLICT (content): Merge conflict in include/linux/acpi.h
Merging usb/usb-next (e4157519ad46 Documentation: usb: correct spelling)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
cs.c
Applying: i915: fix up for "drm/i915: Fix up locking around dumping request=
s lists"
Merging thunderbolt/next (06cbcbfaa651 thunderbolt: Add missing kernel-doc =
comment to tb_tunnel_maximum_bandwidth())
Merging usb-serial/usb-next (b7bfaa761d76 Linux 6.2-rc3)
Merging tty/tty-next (ed0400ad547c serial: liteuart: Correct error rollback)
Merging char-misc/char-misc-next (dd08ebe76132 Merge tag 'counter-updates-f=
or-6.3a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into =
char-misc-next)
CONFLICT (content): Merge conflict in drivers/fpga/dfl.c
CONFLICT (content): Merge conflict in drivers/fpga/dfl.h
Merging accel/habanalabs-next (4dc7c58023e8 habanalabs: Fix list of /sys/cl=
ass/habanalabs/hl<n>/status)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (ffa562d00072 fpga: bridge: return errors in the show=
() method of the "state" attribute)
CONFLICT (content): Merge conflict in drivers/fpga/dfl.h
Merging icc/icc-next (baafcfaca839 Merge branch 'icc-dt' into icc-next)
Merging iio/togreg (4ae612e4af95 iio: adc: ad7291: Fix indentation error by=
 adding extra spaces)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging phy-next/next (b41499a1085b phy: phy-can-transceiver: Add support f=
or NXP TJR1443)
Merging soundwire/next (66f95de7c13b soundwire: cadence: further simplify l=
ow-level xfer_msg_defer() callback)
Merging extcon/extcon-next (2e85d0a0201d extcon: qcom-spmi: Switch to platf=
orm_get_irq_byname_optional)
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (f4f0c25e5d72 vfio/mlx5: Improve the target side flow to =
reduce downtime)
Merging staging/staging-next (88c190736580 staging: r8188eu: remove usb_ops=
_linux.h)
Merging counter-next/counter-next (01f714ee022e counter: fix dependency ref=
erences for config MICROCHIP_TCB_CAPTURE)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (4b23603a251d dmaengine: drivers: Use devm_platform_=
ioremap_resource())
Merging cgroup/for-next (54b970021f92 Merge branch 'for-6.2-fixes' into for=
-next)
Merging scsi/for-next (e9f87b59c685 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (5adca38c0b97 Merge patch series "Enable DMA clus=
tering in the UFS driver")
Merging vhost/linux-next (70ebfab5cc05 vdpa: mlx5: support per virtqueue dm=
a device)
Merging rpmsg/for-next (10de8156ed71 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Applying: remoteproc: fix for "iommu: Add a gfp parameter to iommu_map()"
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (eed5a3bfafe6 gpiolib: of: Move enum of_gpi=
o_flags to its only user)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (a682f992f36a Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (88f8ac47bddc pinctrl: Proofreading and upda=
ting the documentation (part 2))
Merging pinctrl-renesas/renesas-pinctrl (698485cd875b pinctrl: renesas: r8a=
77950: Add VIN[45] pins, groups, and functions)
Merging pinctrl-samsung/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pwm/for-next (2781f8e92036 pwm: lp3943: Drop unused i2c include)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (88a51b4f2e65 ktest.pl: Add shell commands to variab=
les)
Merging kselftest/next (c837391e4499 selftests: tdx: Use installed kernel h=
eaders search path)
Merging kunit/test (1b929c02afd3 Linux 6.2-rc1)
Merging kunit-next/kunit (766f4f2514d2 lib/hashtable_test.c: add test for t=
he hashtable structure)
CONFLICT (content): Merge conflict in lib/kunit/test.c
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (f51c8f644047 rtc: rx8010: use IRQ flags obtained from=
 fwnode)
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
Merging nvmem/for-next (7a8419b8e2aa nvmem: stm32: fix OPTEE dependency)
CONFLICT (content): Merge conflict in drivers/nvmem/core.c
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
Merging mhi/mhi-next (62c0f48fa940 bus: mhi: ep: Fix off by one in mhi_ep_p=
rocess_cmd_ring())
Merging memblock/for-next (2fe03412e2e1 memblock: Avoid useless checks in m=
emblock_merge_regions().)
Merging cxl/next (623c0751336e cxl/mbox: Fix Payload Length check for Get L=
og command)
CONFLICT (content): Merge conflict in drivers/cxl/pci.c
Applying: fix up for "cxl: fix cxl_report_and_clear() RAS UE addr mis-assig=
nment"
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (3b7221033c0e efi: zboot: Use EFI protocol to remap code/d=
ata with the right attributes)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (001aa6a1f0a0 Merge branch 'slab/for-6.3/cleanups' in=
to slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (8677e555f17f selftests/landlock: Test ptrace as much=
 as possible with Yama)
Merging rust/rust-next (18a174f235e7 rust: types: implement `ForeignOwnable=
` for `Arc<T>`)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (2386459394d2 lib/cpumask: update comment fo=
r cpumask_local_spread())
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (82737f3d0128 Merge branches 'for-linus/hardenin=
g' and 'for-next/hardening' into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (84798f284994 iommufd: Add three missing structure=
s in ucmd_buffer)
Merging mm-stable/mm-stable (5ab0fc155dc0 Sync mm-stable with mm-hotfixes-s=
table to pick up dependent patches)
  55ab834a86a9 ("Revert "mm: add nodes=3D arg to memory.reclaim"")
  8ef852f1cb42 ("Revert "mm: kmemleak: alloc gray object for reserved regio=
n with direct map"")
CONFLICT (content): Merge conflict in Documentation/admin-guide/cgroup-v1/m=
emory.rst
CONFLICT (content): Merge conflict in fs/buffer.c
Merging mm-nonmm-stable/mm-nonmm-stable (077010cef0ae Sync with v6.2-rc4)
Merging mm/mm-everything (4f206e661f00 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
  373605127740 ("Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata regi=
on before/after use"")
  c9bf9a8f2139 ("Revert "mm/compaction: fix set skip in fast_find_migratebl=
ock"")
CONFLICT (modify/delete): drivers/gpu/drm/i810/i810_dma.c deleted in HEAD a=
nd modified in mm/mm-everything.  Version mm/mm-everything of drivers/gpu/d=
rm/i810/i810_dma.c left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/hw/hfi1/file_ops.c
CONFLICT (content): Merge conflict in drivers/remoteproc/qcom_q6v5_mss.c
CONFLICT (modify/delete): drivers/staging/media/deprecated/meye/meye.c dele=
ted in HEAD and modified in mm/mm-everything.  Version mm/mm-everything of =
drivers/staging/media/deprecated/meye/meye.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/deprecated/stkwebcam/stk-we=
bcam.c deleted in HEAD and modified in mm/mm-everything.  Version mm/mm-eve=
rything of drivers/staging/media/deprecated/stkwebcam/stk-webcam.c left in =
tree.
CONFLICT (content): Merge conflict in fs/aio.c
$ git rm -f drivers/gpu/drm/i810/i810_dma.c drivers/staging/media/deprecate=
d/meye/meye.c drivers/staging/media/deprecated/stkwebcam/stk-webcam.c
Applying: udf: fix up for "fs: convert writepage_t callback to pass a folio"
Applying: accel/ivpu: fix up for "mm: introduce vma->vm_flags wrapper funct=
ions"
Applying: gfs2: fix up for "fs: convert writepage_t callback to pass a foli=
o"
Applying: mm: fixup for "mm: implement memory-deny-write-execute as a prctl"

--Sig_/JBOjpK7Vkvc/yBwOUQQqt8l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZ6IUACgkQAVBC80lX
0Gzemgf/eVcEebksLNbwLesLGS8XAISGpAjS+eMtV7ilxyk4RoPvPnJ9KVtfUKVt
7ZFl0udv2mEwVpUGskkICKCS8XHKpWI5DuSkBDj73ey2+Hz1dDk3cexA0cXHUvvw
qWWXLrkVuwn+CCSwiQEUh7Ozs6Nm5NhT+yLHe86sl3D9dSiKi+0q+6LayLj7f5F1
EwOVeBfQCtoPAICP0oki+8gI2YAOKsa+HmKnzrlDys83chN5OUyXoMgZYbixBlH5
DXVnbeyMAtlFz4KEj/4e5Tghyn2CXUZnlBAjD8u7rKVHnwo5i5/iNVQ1v8a/qFkQ
enCVOCjDONgO0rkWTluwKViVRRmy9Q==
=VIlK
-----END PGP SIGNATURE-----

--Sig_/JBOjpK7Vkvc/yBwOUQQqt8l--
