Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C86A645A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCAAmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAAme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:42:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6521536089;
        Tue, 28 Feb 2023 16:42:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PRFnK0rlTz4wgv;
        Wed,  1 Mar 2023 11:42:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677631349;
        bh=jbAWQwrXrmrsN/JMLf4dy5TfnNUKC5w4FrnOlEo6Vug=;
        h=Date:From:To:Cc:Subject:From;
        b=l3y8Bd8UYdZj4oMsCe7a3JRdnaLa/sakmzHGsOLrZ2dyPaHoT2yVgLB70YXY78bc+
         kdByPCRXNvP41DS4vCnziyPHgjMV5qNOFH2ZG9Z4Bi7Sdrib8WthBM2LIPyigcR/Z/
         xsJCQ8L+C7bklF1MnS3X/FqsKjxj34MlAGK+yaIikvbYUebuEj4iGfSHkaGEGFyg9f
         QZlMnMnvuzyzAhRhRfFzn+Rb7dpQqCw8AmB4OLZSaB0sSUg4VlrxLC/7W0j9eUmYgO
         D6JnNEf0i/6336b/e9cUWh05A5FtUKuxN5YekDqk0e7NANNpTHyIgT5mjg3ATB8Ibe
         C7n8U+45YyTzw==
Date:   Wed, 1 Mar 2023 11:42:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 1
Message-ID: <20230301114228.0ef8b27c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n62AbJySV7Y6tm=Vz=.SNte";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n62AbJySV7Y6tm=Vz=.SNte
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v6.4 related commits to your linux-next included
branches until after v6.3-rc1 has been released.

Changes since 20230228:

The ext4 tree still had its complex conflict against the mm-stable
tree, so I used the ext4 tree from next-20230217 again.

Non-merge commits (relative to Linus' tree): 889
 867 files changed, 17260 insertions(+), 9651 deletions(-)

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
Merging origin/master (e492250d5252 Merge tag 'pwm/for-6.3-rc1' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (b2ed4bee23eb fs/cramfs/inode.c: i=
nitialize file_ra_state)
Merging kbuild-current/fixes (22e46f6480e8 kbuild: modinst: Fix build error=
 when CONFIG_MODULE_SIG_KEY is a PKCS#11 URI)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2f62847cf6ae ARM: 9287/1: Reduce __thumb2__ defi=
nition to crypto files that require it)
Merging arm64-fixes/for-next/fixes (853e2dac25c1 arm64: perf: reject CHAIN =
events at creation time)
Merging arm-soc-fixes/arm/fixes (9f79762ef8d9 Merge tag 'samsung-dt-fixes-6=
.3' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/=
fixes)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (1e5b5df65af9 m68k: /proc/hardware should de=
pend on PROC_FS)
Merging powerpc-fixes/fixes (c9c3395d5e3d Linux 6.2)
Merging s390-fixes/fixes (f3dd0c53370e bpf: add missing header file include)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (31e1be62abde MAINTAINERS: update fscry=
pt git repo)
Merging fsverity-current/for-current (ef7592e466ef MAINTAINERS: update fsve=
rity git repo, list, and patchwork)
Merging net/main (8f9850dd8d23 net: phy: unlock on error in phy_probe())
Merging bpf/master (2d311f480b52 riscv, bpf: Fix patch_text implicit declar=
ation)
Merging ipsec/master (c276a706ea1f xfrm: Allow transport-mode states with A=
F_UNSPEC selector)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (fd2a55e74a99 Merge git://git.kernel.org/pub/scm/linux/=
kernel/git/netfilter/nf)
Merging wireless/for-next (52fd90638a72 wifi: wext: warn about usage only o=
nce)
Merging rdma-fixes/for-rc (ceaa837f96ad Linux 6.2-rc8)
Merging sound-current/for-linus (e97fc9cffbb9 Merge tag 'asoc-fix-v6.2-rc8-=
2' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into fo=
r-linus)
Merging sound-asoc-fixes/for-linus (f55b0f7c354b Merge remote-tracking bran=
ch 'asoc/for-6.2' into asoc-linus)
Merging regmap-fixes/for-linus (697c3892d825 regmap: apply reg_base and reg=
_downshift for single register ops)
Merging regulator-fixes/for-linus (c361e8d45e52 Merge remote-tracking branc=
h 'regulator/for-6.2' into regulator-linus)
Merging spi-fixes/for-linus (88e0861f52c5 Merge remote-tracking branch 'spi=
/for-6.2' into spi-linus)
Merging pci-current/for-linus (1b929c02afd3 Linux 6.2-rc1)
Merging driver-core.current/driver-core-linus (0c058fb94ae0 driver core: fw=
_devlink: Print full path and name of fwnode)
Merging tty.current/tty-linus (489fa31ea873 Merge branch 'work.misc' of git=
://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging usb.current/usb-linus (489fa31ea873 Merge branch 'work.misc' of git=
://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging usb-serial-fixes/usb-linus (4ec5183ec486 Linux 6.2-rc7)
Merging phy/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging staging.current/staging-linus (489fa31ea873 Merge branch 'work.misc=
' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging iio-fixes/fixes-togreg (03fada47311a iio: accel: kionix-kx022a: Get=
 the timestamp from the driver's private data in the trigger_handler)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (489fa31ea873 Merge branch 'work.=
misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (c9c3395d5e3d Linux 6.2)
Merging input-current/for-linus (7ae9fb1b7ecb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (660ca9470f9c crypto: caam - Fix edesc/iv ord=
ering mixup)
Merging vfio-fixes/for-linus (51cdc8bc120e kvm/vfio: Fix potential deadlock=
 on vfio group_lock)
Merging kselftest-fixes/fixes (a49fb7218ed8 selftests: amd-pstate: Don't de=
lete source files via Makefile)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c0f7ae27539f MAINTAINERS: Update email of Tudo=
r Ambarus)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (3e62aba8284d media: imx-mipi-csis: Check csis_=
fmt validity before use)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (88603b6dc419 Linux 6.2-rc2)
Merging at91-fixes/at91-fixes (9bfa2544dbd1 ARM: dts: at91: sam9x60: fix th=
e ddr clock for sam9x60)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (2c10b61421a2 kvm: initialize all of the kvm_debug=
regs structure before sending it to userspace)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (58326709e8f8 hwmon: (nzxt-smart2) add another US=
B ID)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (000f66519f1a Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (cd2dbcc75947 sparc: fix livelock in uaccess)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (eb4b55f2f26f platform/x86/intel/vsec: Add =
support for Meteor Lake)
Merging samsung-krzk-fixes/fixes (a3583e92d188 ARM: dts: exynos: correct TM=
U phandle in Odroid XU3 family)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (707344c8a188 dt-bindings: interrupt-cont=
roller: arm,gic-v3: Fix typo in description of msi-controller property)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (15600159bcc6 scsi: Revert "scsi: core: map PQ=3D1=
, PDT=3Dother values to SCSI_SCAN_TARGET_PRESENT")
Merging drm-fixes/drm-fixes (c9c3395d5e3d Linux 6.2)
Merging drm-intel-fixes/for-linux-next-fixes (c9c3395d5e3d Linux 6.2)
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
Merging spdx/spdx-linus (489fa31ea873 Merge branch 'work.misc' of git://git=
.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging gpio-brgl-fixes/gpio/for-current (c9c3395d5e3d Linux 6.2)
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
Merging perf-current/perf/urgent (3ef9fec011d4 tools arch x86: Sync the msr=
-index.h copy with the kernel sources)
Merging efi-fixes/urgent (5aed793ff011 efi/libstub: smbios: Drop unused 're=
csize' parameter)
Merging zstd-fixes/zstd-linus (7f18d6eececb lib: zstd: Backport fix for in-=
place decompression)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging rust-fixes/rust-fixes (2a02b7a19794 rust: kernel: Mark rust_fmt_arg=
ument as extern "C")
Merging drm-misc-fixes/for-linux-next-fixes (77bc762451c2 fbdev: chipsfb: F=
ix error codes in chipsfb_pci_init())
Merging mm-stable/mm-stable (4b7c7c73689d dmapool: create/destroy cleanup)
Merging mm-nonmm-stable/mm-nonmm-stable (21baac5614dc Kconfig.debug: fix SC=
HED_DEBUG dependency)
Merging mm/mm-everything (ad62e652e654 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (7adf14d8aca1 kbuild: rpm-pkg: remove unneeded KERN=
ELRELEASE from modules/headers_install)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (f9fa0778ee73 perf tests stat_all_metrics: Change tr=
ue workload to sleep workload for system wide check)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (9b07d27d0fbb swiotlb: mark swiotlb_memblock_a=
lloc() as __init)
Merging asm-generic/master (a13408c20526 char/agp: introduce asm-generic/ag=
p.h)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (ba07b4efc989 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (010338d729c1 arm64: kaslr: don't pretend KASLR=
 is enabled if offset < MIN_KIMG_ALIGN)
Merging arm-perf/for-next/perf (e8a709dc2a91 perf: arm_spe: Print the versi=
on of SPE detected)
Merging arm-soc/for-next (519a0ceec9b0 soc: document merges)
Merging amlogic/for-next (b6520fc7ee57 Merge branch 'v6.2/fixes' into for-n=
ext)
Merging asahi-soc/asahi-soc/for-next (22991d8d5725 soc: apple: rtkit: Add r=
egister dump decoding to crashlog)
Merging aspeed/for-next (52dfcf784bbf soc: nuvoton: Add SoC info driver for=
 WPCM450)
Merging at91/at91-next (05ccf9c9c2fc Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (b691373a1bec Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (c9c3395d5e3d Linux 6.2)
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
Merging qcom/for-next (e34ca36eb310 Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-for-6.3' and 'dts-for-6.3' into=
 for-next)
Merging renesas/next (8dd3dae1705b Merge branches 'renesas-arm-defconfig-fo=
r-v6.3', 'renesas-drivers-for-v6.3', 'renesas-dt-bindings-for-v6.3' and 're=
nesas-dts-for-v6.3' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (cc2b5be472c0 Merge branch 'v6.3-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (dd3d835d31ed Merge branch 'fixes' into for-n=
ext)
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
Merging clk/clk-next (b64baafa24d2 Merge branches 'clk-loongson' and 'clk-q=
com' into clk-next)
Merging clk-imx/for-next (4e197ee880c2 clk: imx6ul: add ethernet refclock m=
ux support)
Merging clk-renesas/renesas-clk (b1dec4e78599 clk: renesas: rcar-gen3: Disa=
ble R-Car H3 ES1.*)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (8883bf83127d selftests/ftrace: Add LoongA=
rch kprobe args string tests support)
Merging m68k/for-next (1e5b5df65af9 m68k: /proc/hardware should depend on P=
ROC_FS)
Merging m68knommu/for-next (5aa52ccf692b m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (1b929c02afd3 Linux 6.2-rc1)
Merging mips/mips-next (27fd82726995 mips: ralink: make SOC_MT7621 select P=
INCTRL)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (53a74a1dbbe5 parisc: Replace regular spinlock w=
ith spin_trylock on panic path)
Merging powerpc/next (f82cdc37c4bd powerpc/pseries: Avoid hcall in plpks_is=
_available() on non-pseries)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (6934cf8a3e0b RISC-V: improve string-function assem=
bly)
Merging riscv-dt/riscv-dt-for-next (d9c36d016f61 Merge patch series "Add a =
devicetree for the Aldec PolarFire SoC TySoM")
Merging riscv-soc/riscv-soc-for-next (f3460326e38d Merge patch series "JH71=
10 PMU Support")
Merging s390/for-next (9b5c37bbf659 s390/decompressor: add link map saving)
Merging sh/for-next (ff30bd6a6618 sh: clk: Fix clk_enable() to return 0 on =
NULL clk)
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (c9c3395d5e3d Linux 6.2)
Merging vfs-idmapping/for-next (9db35c4c2bc4 Merge branch 'fs.misc' into fo=
r-next)
Merging fscrypt/for-next (097d7c1fcb8d fscrypt: clean up fscrypt_add_test_d=
ummy_key())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (80d1eec6927a Merge branch 'for-next-current-v6.2-20=
230221' into for-next-20230221)
Merging ceph/master (f7c4d9b133c7 rbd: avoid use-after-free in do_rbd_add()=
 when rbd_dev_create() fails)
Merging cifs/for-next (d07f58c0d832 cifs: prevent data race in cifs_reconne=
ct_tcon())
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (8d1b80a79452 erofs: fix an error code in z_erofs_init_zi=
p_subsystem())
Merging exfat/dev (d5c514b6a0c0 exfat: fix the newly allocated clusters are=
 not freed in error handling)
Merging ext3/for_next (90e4f9e49826 Pull udf fixup for syzbot allocation fa=
ilure handling bug.)
Merging ext4/dev (2c2dec1e86cc ext4: fix incorrect options show of original=
 mount_opt and extend mount_opt2)
CONFLICT (content): Merge conflict in fs/ext4/inode.c
$ git merge --abort
Merging f2fs/dev (103830683cfc Merge tag 'f2fs-for-6.3-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging fsverity/for-next (51e4e3153ebc fscrypt: support decrypting data fr=
om large folios)
Merging fuse/for-next (1cc4606d19e3 fuse: add inode/permission checks to fi=
leattr_get/fileattr_set)
Merging gfs2/for-next (c1b0c3cfcbad gfs2: Convert gfs2_page_add_databufs to=
 folios)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (25ac8c12ff78 Merge tag '6.3-rc-ksmbd-fixes' o=
f git://git.samba.org/ksmbd)
Merging nfs/linux-next (c9c3395d5e3d Linux 6.2)
Merging nfs-anna/linux-next (1683ed16ff1a fs/nfs: Replace kmap_atomic() wit=
h kmap_local_page() in dir.c)
Merging nfsd/nfsd-next (fb5b855d9f34 SUNRPC: Properly terminate test case a=
rrays)
Merging ntfs3/master (2024476646ed fs/ntfs3: Fix root inode checking)
CONFLICT (content): Merge conflict in fs/ntfs3/file.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/ntfs_fs.h
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (8fcf2d012c86 ubi: block: Fix a possible use-after-free =
bug in ubiblock_create())
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (89c58cb395ec fs/9p: fix error reportin=
g in v9fs_dir_release)
Merging xfs/for-next (6e2985c938e8 xfs: restore old agirotor behavior)
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
Merging iomap/iomap-for-next (471859f57d42 iomap: Rename page_ops to folio_=
ops)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (eca3a04f140a Merge tag 'dlm-6.3' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm)
Merging iversion/iversion-next (eca3a04f140a Merge tag 'dlm-6.3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm)
Merging vfs/for-next (e9f33f8668ab Merge branches 'work.misc', 'work.namesp=
ace', 'work.alpha', 'work.minix' and 'work.sysv' into for-next)
Merging printk/for-next (10d639febe56 Merge branch 'for-6.3' into for-next)
Merging pci/next (3eb5d0f26f4e Merge branch 'pci/misc')
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (10635598711e Merge branch 'for-6.3/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (dc67b2d90438 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (07eac9c306a0 i3c: update dw-i3c-master i3c_clk_cfg fu=
nction)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (58326709e8f8 hwmon: (nzxt-smart2) add ano=
ther USB ID)
Merging jc_docs/docs-next (27a6e6b25016 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (3e62aba8284d media: imx-mipi-csis: Check csis_fmt v=
alidity before use)
Merging v4l-dvb-next/master (3e62aba8284d media: imx-mipi-csis: Check csis_=
fmt validity before use)
Merging pm/linux-next (243d50840e68 Merge branches 'pm-cpufreq' and 'powerc=
ap' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (ba38f3cbe7db dt-bindings: opp: =
opp-v2-kryo-cpu: enlarge opp-supported-hw maximum)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (eca4c0eea534 OPP: fix error checking in opp_mig=
rate_dentry())
Merging thermal/thermal/linux-next (6828e402d06f thermal/drivers/st: Remove=
 syscfg based driver)
Merging dlm/next (723b197bbdf1 fs: dlm: remove unnecessary waker_up() calls)
Merging rdma/for-next (66fb1d5df6ac IB/mlx5: Extend debug control for CC pa=
rameters)
Merging net-next/main (5ca26d6039a6 Merge tag 'net-6.3-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf-next/for-next (5b7c4cabbb65 Merge tag 'net-next-6.3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (75da437a2f17 Merge branch '40GbE' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging mlx5-next/mlx5-next (22551e77e550 net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (3fcdf2dfefb6 net: bcmgenet: Support wake-up from =
s2idle)
Merging bluetooth/master (e16f2ec5cf3a Bluetooth: ISO: fix timestamped HCI =
ISO data packet parsing)
Merging wireless-next/for-next (38ae31922969 wifi: rtl8xxxu: add LEDS_CLASS=
 dependency)
Merging mtd/mtd/next (84549c816dc3 mtd: parsers: ofpart: add workaround for=
 #size-cells 0)
Merging nand/nand/next (ef3e6327ff04 mtd: rawnand: sunxi: Precompute the EC=
C_CTL register value)
Merging spi-nor/spi-nor/next (f047382519ca Merge tag 'mtd/fixes-for-6.2-rc4=
' into spi-nor/next)
Merging crypto/master (8b8447531864 crypto: x86/aria-avx - Do not use avx2 =
instructions)
Merging drm/drm-next (a48bba98380c msm/fbdev: fix unused variable warning w=
ith clang.)
Merging drm-misc/for-linux-next (047a754558d6 drm/shmem-helper: Revert acci=
dental non-GPL export)
Merging amdgpu/drm-next (f4658f434504 drm/amd/display: Promote DAL to 3.2.2=
24)
Merging drm-intel/for-linux-next (5d2fdb255c52 Merge tag 'gvt-next-fixes-20=
23-02-23' of https://github.com/intel/gvt-linux into drm-intel-next-fixes)
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
Merging fbdev/for-next (822242608545 fbdev: omapfb: cleanup inconsistent in=
dentation)
Merging regmap/for-next (40f4b0586810 Merge remote-tracking branch 'regmap/=
for-6.3' into regmap-next)
Merging sound/for-next (7933b90b4289 Merge branch 'for-linus' into for-next)
Merging sound-asoc/for-next (f55b0f7c354b Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-linus)
Merging modules/modules-next (d6f55bb48579 module: make module_ktype struct=
ure constant)
CONFLICT (content): Merge conflict in arch/alpha/kernel/module.c
Merging input/next (d5f7638eb5fe Input: matrix_keypad - replace header incl=
usions by forward declarations)
Merging block/for-next (bdc9c96cfce2 Merge branch 'io_uring-6.3' into for-n=
ext)
Merging device-mapper/for-next (d695e44157c8 dm: remove unnecessary (void*)=
 conversion in event_callback())
Merging libata/for-next (8844f0aa8dc4 ata: pata_parport: Fix ida_alloc retu=
rn value error check)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (571f235163ac mmc: meson-gx: Use devm_platform_get_and_ior=
emap_resource())
Merging mfd/for-mfd-next (59c54c599746 dt-bindings: mfd: qcom,tcsr: Add com=
patible for IPQ5332)
Merging backlight/for-backlight-next (ad614f81d2e8 backlight: ktz8866: Conv=
ert to i2c's .probe_new())
Merging battery/for-next (13af134bdc6a dt-bindings: power: supply: Revise R=
ichtek RT9467 compatible name)
Merging regulator/for-next (c361e8d45e52 Merge remote-tracking branch 'regu=
lator/for-6.2' into regulator-linus)
Merging security/next (88603b6dc419 Linux 6.2-rc2)
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (4958db3245fa ima: Introduce MMAP_CHECK_RE=
QPROT hook)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (88603b6dc419 Linux 6.2-rc2)
Merging smack/next (c0e48d3f7722 smackfs: Added check catlen)
Merging tomoyo/master (5fc44ba8be52 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (ffe4a34b29aa tpm: disable hwrng for fTPM on some AMD de=
signs)
Merging watchdog/master (4443f6ce0d12 watchdog: at91rm9200: Only warn once =
about problems in .remove())
Merging iommu/next (bedd29d793da Merge branches 'apple/dart', 'arm/exynos',=
 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (6c6cd913accd audit: update the mailing list in MAINTAIN=
ERS)
Merging devicetree/for-next (1ba7dfb905b3 dt-bindings: regulator: Add mps,m=
pq7932 power-management IC)
Merging dt-krzk/for-next (825475539974 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (6ccbe33a3952 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for QDU1000/QRU1000)
Merging spi/for-next (88e0861f52c5 Merge remote-tracking branch 'spi/for-6.=
2' into spi-linus)
Merging tip/master (edb4f8670f6e Merge branch into tip/master: 'objtool/cor=
e')
Merging clockevents/timers/drivers/next (ab407a1919d2 Merge tag 'clocksourc=
e.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/lin=
ux-rcu into timers/core)
Merging edac/edac-for-next (feac08675023 Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (a83bf176fed4 Merge branch irq/bcm-l2-fixe=
s into irq/irqchip-next)
Merging ftrace/for-next (ca6cbe8c481a Merge tools/for-next)
CONFLICT (content): Merge conflict in Documentation/trace/kprobetrace.rst
Merging rcu/rcu/next (690ae0037d5b Merge branch 'kcsan.2023.02.22a' into HE=
AD)
Merging kvm/next (45dd9bc75d9a KVM: SVM: hyper-v: placate modpost section m=
ismatch error)
Merging kvm-arm/next (96a4627dbbd4 Merge tag ' https://github.com/oupton/li=
nux tags/kvmarm-6.3' from into kvmarm-master/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (62ef199250cd Merge branches 'apic', 'generic', 'misc'=
, 'mmu', 'pmu', 'selftests', 'svm' and 'vmx' into next)
Merging xen-tip/linux-next (99a7bcafbd0d x86/xen/time: cleanup xen_tsc_safe=
_clocksource)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (0d9bdd8a5501 platform/x86: nvidia-wmi-ec-back=
light: Add force module parameter)
Merging chrome-platform/for-next (b0d8a67715da platform/chrome: cros_ec_typ=
ec: Fix spelling mistake)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (056f65c3938b leds: Remove ide-disk trigger)
Merging ipmi/for-next (982818426a0f Merge tag 'arm-fixes-6.3-1' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging driver-core/driver-core-next (ae3419fbac84 vc_screen: don't clobber=
 return value in vcs_read)
Merging usb/usb-next (489fa31ea873 Merge branch 'work.misc' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging thunderbolt/next (06cbcbfaa651 thunderbolt: Add missing kernel-doc =
comment to tb_tunnel_maximum_bandwidth())
Merging usb-serial/usb-next (617c331d9107 USB: serial: option: add support =
for VW/Skoda "Carstick LTE")
Merging tty/tty-next (489fa31ea873 Merge branch 'work.misc' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging char-misc/char-misc-next (489fa31ea873 Merge branch 'work.misc' of =
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging accel/habanalabs-next (a48bba98380c msm/fbdev: fix unused variable =
warning with clang.)
Merging coresight/next (669c4614236a coresight: tmc: Don't enable TMC when =
it's not ready.)
Merging fpga/for-next (ffa562d00072 fpga: bridge: return errors in the show=
() method of the "state" attribute)
Merging icc/icc-next (7bf0008a5293 Merge branch 'icc-dt' into icc-next)
Merging iio/togreg (91ba2700aa75 staging: iio: meter: Drop ade7854 driver)
Merging phy-next/next (3584f6392f09 phy: qcom: phy-qcom-snps-eusb2: Add sup=
port for eUSB2 repeater)
Merging soundwire/next (66f95de7c13b soundwire: cadence: further simplify l=
ow-level xfer_msg_defer() callback)
Merging extcon/extcon-next (2e85d0a0201d extcon: qcom-spmi: Switch to platf=
orm_get_irq_byname_optional)
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (d649c34cb916 vfio: Fix NULL pointer dereference caused b=
y uninitialized group->iommufd)
Merging staging/staging-next (489fa31ea873 Merge branch 'work.misc' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging counter-next/counter-next (01f714ee022e counter: fix dependency ref=
erences for config MICROCHIP_TCB_CAPTURE)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (e922bbf37564 dmaengine: idma64: Update bytes_transf=
erred field)
Merging cgroup/for-next (14fffd51f902 Merge branch 'for-6.2-fixes' into for=
-next)
Merging scsi/for-next (81dab59be6ee Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (901b894af5b9 scsi: zfcp: Trace when request remo=
ve fails after qdio send fails)
Merging vhost/linux-next (0d0a7dda9cdf vp_vdpa: fix the crash in hot unplug=
 with vp_vdpa)
Merging rpmsg/for-next (c7d00a6f6e4c Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (4827aae06133 gpio: sim: Use %pfwP specifie=
r instead of calling fwnode API directly)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (099f37a539e6 pinctrl: qcom: Add support for i2c s=
pecific pull feature)
Merging pinctrl-intel/for-next (88f8ac47bddc pinctrl: Proofreading and upda=
ting the documentation (part 2))
Merging pinctrl-renesas/renesas-pinctrl (698485cd875b pinctrl: renesas: r8a=
77950: Add VIN[45] pins, groups, and functions)
Merging pinctrl-samsung/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pwm/for-next (cf70d01a62c7 pwm: dwc: Use devm_pwmchip_add())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (0eb15a47bf43 selftests/user_events: add a note abou=
t user_events.h dependency)
Merging kunit/test (1b929c02afd3 Linux 6.2-rc1)
Merging kunit-next/kunit (82649c7c0da4 kunit: Add printf attribute to fail_=
current_test_impl)
Merging livepatching/for-next (b2e118419db3 Merge branch 'for-6.3/cleanup-r=
elocations' into for-next)
Merging rtc/rtc-next (3ca04951b004 rtc: pm8xxx: add support for nvmem offse=
t)
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
Merging hyperv/hyperv-next (b14033a3e6ba x86/hyperv: Fix hv_get/set_registe=
r for nested bringup)
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
Merging cxl/next (e686c32590f4 dax/kmem: Fix leak of memory-hotplug resourc=
es)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (e1d447157f23 firmware/efi sysfb_efi: Add quirk for Lenovo=
 IdeaPad Duet 3)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (603c592a005a Merge branch 'slab/for-6.3/fixes' into =
slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (7ea01d3169a2 rust: delete rust-project.json when ru=
nning make clean)
Merging sysctl/sysctl-next (f1aa2eb5ea05 sysctl: fix proc_dobool() usabilit=
y)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (18e93f4dc099 bitmap: switch from inline to =
__always_inline)
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (78f7a3fd6dc6 randstruct: disable Clang 15 suppo=
rt)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (939204e4df96 Merge tag 'v6.2' into iommufd.git fo=
r-next)

--Sig_/n62AbJySV7Y6tm=Vz=.SNte
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP+n3QACgkQAVBC80lX
0GyIEAf8C8lD1h9QDe7LzCAAGUsVMBEFmRe3XBZJSWxVWfLydvhhp/02ONpCO4Vr
obIxoCNX0WalZQximuK1G5xHh2iE8CjZJj+yZWhWEaf77ger9KOgrCGRYyvZEgns
notCETpQcZRAlun++KI0361GCjLkkZTk09FOrD9TyUJ3SL5TN20OsZtnrgGUyP4S
spbxyG2BM5u0lBABZQHfaPdFq0h2MCqhvHEuo3tkqHvFeee8lKJ51KBZ7QVaxE+0
CSOCcyeSMKKtkepvl8+w1X0T6uVVQOD+wXtYn5uCSb8dTxvYEIvTBMoaUyYQwIbC
pSv1U2lseXTWt+DpJFBJ29Eat6ptyg==
=puxh
-----END PGP SIGNATURE-----

--Sig_/n62AbJySV7Y6tm=Vz=.SNte--
