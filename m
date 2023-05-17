Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051DB705CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjEQCFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjEQCFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:05:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27944483;
        Tue, 16 May 2023 19:05:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QLbzq1Wnrz4x1f;
        Wed, 17 May 2023 12:05:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684289143;
        bh=OxWhFnFcsfZ+AOjh0CJuEf5h429BpKKN7i2dUaVUH/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=L92CzBHuDBzMQJJ9VtF8d3kLSfDSJjv/0tn4JJr7PPRUz5A06GcG7aVqFMAAxyXZ8
         lHI0iMSW9t4M0RIEIDzGtoDoidPjGQ/+8C9FDUNT3K/242G+ceRMSZAtF8rS7o+rvy
         k9gWYghpLJIQPK05pamCQx7T7fH17PIwuyHNDEHgolDdOLcFhuSlhV7A5rBXITPynu
         bCS6QM0lFbqf1ocDSLF3v6QvCjYsaLulIjwi8129HRnTHDwXiF3C0AsvAyTH859e8o
         xlzaqef71264A9yZXF8gvMpWDayNbNJ78/8zofZS0AE+6EJL4I0UVgkEIHstwh5jXz
         28owtfVzwQ83w==
Date:   Wed, 17 May 2023 12:05:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 17
Message-ID: <20230517120541.01ae1b8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8cHZH2/cAoE3DXKVa/1MSeC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8cHZH2/cAoE3DXKVa/1MSeC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230516:

Non-merge commits (relative to Linus' tree): 2504
 2969 files changed, 89123 insertions(+), 38921 deletions(-)

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
Merging origin/master (f1fcbaa18b28 Linux 6.4-rc2)
Merging fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging mm-hotfixes/mm-hotfixes-unstable (61bddfc93843 nilfs2: fix incomple=
te buffer cleanup in nilfs_btnode_abort_change_key())
CONFLICT (content): Merge conflict in MAINTAINERS
Merging kbuild-current/fixes (f1fcbaa18b28 Linux 6.4-rc2)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (fd2d1cb8c545 arm64: Make the ARCH_FORCE=
_MAX_ORDER config input prompt unconditional)
Merging arm-soc-fixes/arm/fixes (d75eecc3d170 Merge tag 'qcom-arm64-fixes-f=
or-6.3-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux int=
o arm/fixes)
Merging davinci-current/davinci/for-current (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (aaee8c7f2a17 m68k: kexec: Include <linux/re=
boot.h>)
Merging powerpc-fixes/fixes (8133a3f0aa66 powerpc/crypto: Fix aes-gcm-p10 b=
uild when VSX=3Dn)
Merging s390-fixes/fixes (2facd5d3980f s390/ipl: fix IPIB virtual vs physic=
al address confusion)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (225c657945c4 net: bcmgenet: Restore phy_stop() depending =
upon suspend/close)
Merging bpf/master (a820ca1a739b samples/bpf: Drop unnecessary fallthrough)
Merging ipsec/master (8680407b6f8f xfrm: Check if_id in inbound policy/secp=
ath match)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (225c657945c4 net: bcmgenet: Restore phy_stop() depending=
 upon suspend/close)
Merging wireless/for-next (098abbd48ec1 mac80211_hwsim: fix memory leak in =
hwsim_new_radio_nl)
Merging wpan/master (bd4e3d82f4cc MAINTAINERS: Add wpan patchwork)
Merging rdma-fixes/for-rc (78b6a9a3f445 MAINTAINERS: Update maintainers of =
HiSilicon RoCE)
Merging sound-current/for-linus (3b44ec8c5c44 ALSA: hda: Fix Oops by 9.1 su=
rround channel names)
Merging sound-asoc-fixes/for-linus (9be0b3a0074a ASoC: SOF: Intel: hda-mlin=
k: fixes and extensions)
Merging regmap-fixes/for-linus (70a640c0efa7 regmap: REGMAP_KUNIT should no=
t select REGMAP)
Merging regulator-fixes/for-linus (2bf1c45be3b8 regulator: Fix error checki=
ng for debugfs_create_dir)
Merging spi-fixes/for-linus (445164e8c136 spi: dw: Replace spi->chip_select=
 references with function calls)
Merging pci-current/for-linus (3b8803494a06 PCI/DPC: Quirk PIO log size for=
 Intel Ice Lake Root Ports)
Merging driver-core.current/driver-core-linus (f1fcbaa18b28 Linux 6.4-rc2)
Merging tty.current/tty-linus (8fb9ea65c9d1 vc_screen: reload load of struc=
t vc_data pointer in vcs_write() to avoid UAF)
Merging usb.current/usb-linus (fe82f16aafda xhci: Fix incorrect tracking of=
 free space on transfer rings)
Merging usb-serial-fixes/usb-linus (09a9639e56c0 Linux 6.3-rc6)
Merging phy/fixes (2a881183dc5a phy: qcom-snps: correct struct qcom_snps_hs=
phy kerneldoc)
Merging staging.current/staging-linus (b3dad076a058 staging: octeon: delete=
 my name from TODO contact)
Merging iio-fixes/fixes-togreg (55720d242052 dt-bindings: iio: adc: renesas=
,rcar-gyroadc: Fix adi,ad7476 compatible value)
Merging counter-current/counter-current (ac9a78681b92 Linux 6.4-rc1)
Merging char-misc.current/char-misc-linus (0fa53349c3ac binder: add lockles=
s binder_alloc_(set|get)_vma())
Merging soundwire-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging thunderbolt-fixes/fixes (c4af8e3fecd0 thunderbolt: Clear registers =
properly when auto clear isn't in use)
Merging input-current/for-linus (7b63a88bb62b Input: psmouse - fix OOB acce=
ss in Elantech protocol)
Merging crypto-current/master (b8969a1b6967 crypto: api - Fix CRYPTO_USER c=
hecks for report function)
Merging vfio-fixes/for-linus (4928f67bc911 vfio/mlx5: Fix the report of dir=
ty_bytes upon pre-copy)
Merging kselftest-fixes/fixes (d7eafa64a158 tools/nolibc: Fix build of stdi=
o.h due to header ordering)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (93942b704615 mtd: rawnand: meson: fix bitmask =
for length in command word)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (280a8ab81733 media: dvb-core: Fix use-after-fr=
ee due to race condition at dvb_ca_en50221)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging at91-fixes/at91-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (1a5304fecee5 Merge tag 'parisc-for-6.4-1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (ac9a78681b92 Linux 6.4-rc1)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (764d102ef94e cxl: Add missing return to cdat read =
error path)
Merging btrfs-fixes/next-fixes (a9b282be7894 Merge branch 'misc-6.4' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (95e4b25192e9 platform/mellanox: mlxbf-pmc:=
 fix sscanf() error checking)
Merging samsung-krzk-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-samsung-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging devicetree-fixes/dt/linus (6997f847cbb7 MAINTAINERS: add Conor as a=
 dt-bindings maintainer)
Merging dt-krzk-fixes/fixes (8bbec86ce6d6 dt-bindings: PCI: fsl,imx6q: fix =
assigned-clocks warning)
Merging scsi-fixes/fixes (1a7edd041f2d scsi: ufs: core: Fix I/O hang that o=
ccurs when BKOPS fails in W-LUN suspend)
Merging drm-fixes/drm-fixes (f1fcbaa18b28 Linux 6.4-rc2)
Merging drm-intel-fixes/for-linux-next-fixes (5896f2d363d5 drm/i915/hdcp: C=
heck if media_gt exists)
Merging mmc-fixes/fixes (81dce1490e28 mmc: sdhci-esdhc-imx: make "no-mmc-hs=
400" works)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (ec97e112985c Drivers: hv: vmbus: Call hv=
_synic_free() if hv_synic_alloc() fails)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (3b90b09af5be riscv: Fix orphan section warnings=
 caused by kernel/pi)
Merging riscv-dt-fixes/riscv-dt-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (a7a041f2ddf3 soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (3c66c757bfb1 dt-bindings: fpga: replace Ivan Born=
yakov maintainership)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging spdx/spdx-linus (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl-fixes/gpio/for-current (976d3c6778e9 selftests: gpio: gpi=
o-sim: Fix BUG: test FAILED due to recent change)
Merging gpio-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-intel-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging erofs-fixes/fixes (ae0bac799263 erofs: avoid pcpubuf.c inclusion if=
 CONFIG_EROFS_FS_ZIP is off)
Merging kunit-fixes/kunit-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (21a3f3328972 NFSD: Remove open coding of str=
ing copy)
Merging irqchip-fixes/irq/irqchip-fixes (cddb536a73ef irqchip/mbigen: Unify=
 the error handling in mbigen_of_create_domain())
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (760ebc45746b perf lock contention: Add em=
pty 'struct rq' to satisfy libbpf 'runqueue' type verification)
Merging efi-fixes/urgent (0b1d9debe303 efi/libstub: randomalloc: Return EFI=
_OUT_OF_RESOURCES on failure)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (95339f40a8b6 power: supply: Fix logic checking=
 if system is running from battery)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (f1fcbaa18b28 Linux 6.4-rc2)
Merging rust-fixes/rust-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging v9fs-fixes/fixes/next (36896bc97c0e fs/9p: Fix a datatype used with=
 V9FS_DIRECT_IO)
Merging w1-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (2d2f5f1e8fd9 accel/qaic: silen=
ce some uninitialized variable warnings)
Merging mm-stable/mm-stable (ac9a78681b92 Linux 6.4-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (ac9a78681b92 Linux 6.4-rc1)
Merging mm/mm-everything (7d4c988c8910 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf-tools-next (c0d68601cbce perf test: Add cputype testing t=
o perf stat)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (ec274aff21b6 swiotlb: Omit total_used and use=
d_hiwater if !CONFIG_DEBUG_FS)
Merging asm-generic/master (f1fcbaa18b28 Linux 6.4-rc2)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (fc6750b0d4a9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (0fddb79bf283 arm64: lds: move .got section out=
 of .text)
Merging arm-perf/for-next/perf (257aedb72e73 drivers/perf: hisi: add NULL c=
heck for name)
Merging arm-soc/for-next (8ecfe9a0e657 soc: document merges)
Merging amlogic/for-next (0618cb14da6a Merge branch 'v6.5/arm-dt' into for-=
next)
Merging asahi-soc/asahi-soc/for-next (f41aba157819 Merge branch 'asahi-soc/=
dt' into asahi-soc/for-next)
Merging aspeed/for-next (7d4f0b0df7c5 ARM: dts: aspeed-g6: Add UDMA node)
Merging at91/at91-next (ad5125686a4f Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (bba5ad8482de Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory/for-next (3d56c7364389 memory: renesas-rpc-if: Fix P=
HYCNT.STRTIM setting)
Merging imx-mxs/for-next (efdde75fee54 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (e586dd447172 Merge branch 'v6.3-next/soc' into f=
or-next)
Merging mvebu/for-next (e5cfa586d513 ARM: dts: armada388-clearfog: add miss=
ing phy-modes)
Merging omap/for-next (c45167f4f5cf Merge branch 'omap-for-v6.4/dt' into fo=
r-next)
Merging qcom/for-next (4272e06e19f3 Merge branches 'arm64-defconfig-for-6.5=
', 'arm64-fixes-for-6.4', 'arm64-for-6.5', 'drivers-fixes-for-6.4' and 'dri=
vers-for-6.5' into for-next)
Merging renesas/next (21330625d0f5 Merge branches 'renesas-arm-defconfig-fo=
r-v6.5' and 'renesas-drivers-for-v6.5' into renesas-next)
Merging reset/reset/next (afb39e2bd36a reset: mpfs: select AUXILIARY_BUS)
Merging rockchip/for-next (e11ff0914d61 Merge branch 'v6.5-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (5b248db78d1a Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (e06854e84add Merge tags 'scmi-fix-6.4', 'juno-=
fixes-6.4' and 'ffa-fixes-6.4' of git://git.kernel.org/pub/scm/linux/kernel=
/git/sudeep.holla/linux into for-linux-next)
Merging stm32/stm32-next (b195a9d7f721 ARM: dts: stm32: add STM32MP1-based =
Phytec board)
Merging sunxi/sunxi/for-next (7081db38231a Merge branch 'sunxi/dt-for-6.4' =
into sunxi/for-next)
Merging tee/next (86dfcfab4fe0 Merge branch 'optee_fix_async_notif_for-v6.3=
' into next)
Merging tegra/for-next (d52733725601 Merge branch for-6.5/arm64/dt into for=
-next)
Merging ti/ti-next (f76b8c20b477 arm64: dts: ti: k3-am62x-sk-common: Add ma=
in_uart1 and wkup_uart nodes)
Merging xilinx/for-next (12ac543351cc Merge branch 'zynqmp/dt' into for-nex=
t)
Merging clk/clk-next (ac9a78681b92 Linux 6.4-rc1)
Merging clk-imx/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging clk-renesas/renesas-clk (7f91fe3a71aa clk: renesas: r8a779a0: Add P=
WM clock)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (ac9a78681b92 Linux 6.4-rc1)
Merging loongarch/loongarch-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging m68k/for-next (4decdb267a47 nubus: Remove proc entries before addin=
g them)
Merging m68knommu/for-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (ac9a78681b92 Linux 6.4-rc1)
Merging openrisc/for-next (c91b4a07655d openrisc: Add floating point regset)
Merging parisc-hd/for-next (b645c02c3594 parisc: Allow 64-bit STI calls in =
PDC firmware abstration)
Merging powerpc/next (f1fcbaa18b28 Linux 6.4-rc2)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging riscv-dt/riscv-dt-for-next (6361b7de262a riscv: dts: starfive: jh71=
10: Add watchdog node)
Merging riscv-soc/riscv-soc-for-next (ac9a78681b92 Linux 6.4-rc1)
Merging s390/for-next (6572a756ef6f Merge branch 'features' into for-next)
Merging sh/for-next (bc9d1f0cecd2 sh: j2: Use ioremap() to translate device=
 tree address into kernel memory)
Merging uml/next (6032aca0deb9 um: make stub data pages size tweakable)
Merging xtensa/xtensa-for-next (d0f94ebe1864 xtensa: add asm-prototypes.h)
Merging pidfd/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging vfs-idmapping/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging fscrypt/for-next (83e57e47906c fscrypt: optimize fscrypt_initialize=
())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (48ad328fe62d Merge branch 'for-next-next-v6.4-20230=
515' into for-next-20230515)
Merging ceph/master (a12e5342fa27 ceph: silence smatch warning in reconnect=
_caps_cb())
Merging cifs/for-next (60c48b7c9ee9 SMB3: drop reference to cfile before se=
nding oplock break)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (ac9a78681b92 Linux 6.4-rc1)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (df9c5af6a4ef Merge ext2 direct IO conversion to ioma=
p.)
Merging ext4/dev (2a534e1d0d15 ext4: bail out of ext4_xattr_ibody_get() fai=
ls for any reason)
Merging f2fs/dev (08c3eab525ef f2fs: remove some dead code)
Merging fsverity/for-next (e08e901faa8f fsverity: use shash API instead of =
ahash API)
Merging fuse/for-next (c68ea140050e fuse: remove duplicate check for nodeid)
Merging gfs2/for-next (6ddd5e9eaadf gfs2: Don't remember delete unless it's=
 successful)
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (e7b8b8ed9960 ksmbd: smb2: Allow messages padd=
ed to 8byte boundary)
Merging nfs/linux-next (e8d018dd0257 Linux 6.3-rc3)
Merging nfs-anna/linux-next (fbd2a05f29a9 NFSv4.2: Rework scratch handling =
for READ_PLUS)
Merging nfsd/nfsd-next (8c49a0ffaed0 NFSD: trace nfsctl operations)
Merging ntfs3/master (1f60ec888102 fs/ntfs3: Add support /proc/fs/ntfs3/<de=
v>/volinfo and /proc/fs/ntfs3/<dev>/label)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging xfs/for-next (2254a7396a0c xfs: fix xfs_inodegc_stop racing with mo=
d_delayed_work)
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
Merging iomap/iomap-for-next (3fd41721cd5c iomap: Add DIO tracepoints)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (63355b9884b3 cpumask: be more careful with '=
cpumask_setall()')
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (16bff6f075a1 Merge branch 'for-6.4' into for-next)
Merging pci/next (174977dc80b7 Merge branch 'pci/controller/vmd')
Merging pstore/for-next/pstore (48f2c681df43 pstore/ram: Convert to platfor=
m remove callback returning void)
Merging hid/for-next (d777b19c6356 Merge branch 'for-6.4/amd-sfh' into for-=
next)
Merging i2c/i2c/for-next (03230ddddf9d Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (6b496a94c590 i3c: ast2600: set variable ast2600_i3c_o=
ps storage-class-specifier to static)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (92613681c009 Documentation/hwmon: Move mi=
splaced entry in hwmon docs index)
Merging jc_docs/docs-next (bd415b5c9552 Documentation/filesystems: ramfs-ro=
otfs-initramfs: use :Author:)
Merging v4l-dvb/master (ac9a78681b92 Linux 6.4-rc1)
Merging v4l-dvb-next/master (a23a3041c733 Merge tag 'v6.4-rc2' into media_s=
tage)
Merging pm/linux-next (a3c2d8b60e2f Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (11a3b0ac33d9 cpufreq: imx6q: do=
n't warn for disabling a non-existing frequency)
Merging cpupower/cpupower (c2adb1877b76 cpupower: Make TSC read per CPU for=
 Mperf monitor)
Merging devfreq/devfreq-next (376b1446153c PM / devfreq: exynos-ppmu: Use d=
evm_platform_get_and_ioremap_resource())
Merging opp/opp/linux-next (ac9a78681b92 Linux 6.4-rc1)
Merging thermal/thermal/linux-next (2afa82d1fc64 dt-bindings: thermal: qcom=
-tsens: Correct unit address)
Merging dlm/next (7a40f1f18a88 fs: dlm: stop unnecessarily filling zero ms_=
extra bytes)
Merging rdma/for-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging net-next/main (e641577eb6e8 Merge branch 'spdx-conversion-for-bondi=
ng-8390-and-i825xx-drivers')
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fec_ma=
in.c
Merging bpf-next/for-next (108598c39eef bpf: Fix memleak due to fentry atta=
ch failure)
Merging ipsec-next/master (b2cbac9b9b28 net: Remove low_thresh in ip defrag)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (e641577eb6e8 Merge branch 'spdx-conversion-for-bond=
ing-8390-and-i825xx-drivers')
Merging bluetooth/master (fd4fbf8cd81f Bluetooth: Check for ISO support in =
controller)
Merging wireless-next/for-next (103d6e9d61e0 wifi: rtl8xxxu: Rename some re=
gisters)
Merging wpan-next/master (1af3de62f03f ieee802154: ca8210: Flag the driver =
as being limited)
Merging wpan-staging/staging (1af3de62f03f ieee802154: ca8210: Flag the dri=
ver as being limited)
Merging mtd/mtd/next (7227aacb62ae Merge tag 'nand/for-6.4' into mtd/next)
Merging nand/nand/next (ec185b18c223 mtd: nand: Convert to platform remove =
callback returning void)
Merging spi-nor/spi-nor/next (df6def86b9dc mtd: spi-nor: spansion: Add supp=
ort for s25hl02gt and s25hs02gt)
Merging crypto/master (ac52578d6e8d hwrng: virtio - Fix race on data_avail =
and actual data)
Merging drm/drm-next (ac9a78681b92 Linux 6.4-rc1)
Merging drm-misc/for-linux-next (519ce291168a drm/panel: Modify innolux hj1=
10iz panel initial code)
CONFLICT (content): Merge conflict in drivers/video/fbdev/stifb.c
Merging amdgpu/drm-next (d3295311e589 drm/amdgpu/display: Enable DC_FP for =
LoongArch)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/Kconfig
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/dc_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn31/=
dcn31_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn32/=
dcn32_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.h
CONFLICT (content): Merge conflict in include/drm/display/drm_dp.h
Merging drm-intel/for-linux-next (c598c335da42 drm/i915/tc: Reset TypeC PHY=
s left enabled in DP-alt mode after the sink disconnects)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dd=
i.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (ac7e7c9c65ec drm/msm/dpu: drop unused macros from=
 hw catalog)
Merging drm-msm-lumag/msm-next-lumag (ac7e7c9c65ec drm/msm/dpu: drop unused=
 macros from hw catalog)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging regmap/for-next (7e5a77cccd1f Merge remote-tracking branch 'regmap/=
for-6.5' into regmap-next)
Merging sound/for-next (bcdbd3b7888e ALSA: emu10k1: enable bit-exact playba=
ck, part 2: voice attenuation)
Merging ieee1394/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging sound-asoc/for-next (c9a873c0adf4 Merge remote-tracking branch 'aso=
c/for-6.5' into asoc-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging modules/modules-next (0b891c83d8c5 module: include internal.h in mo=
dule/dups.c)
Merging input/next (17caa38a988e dt-bindings: input: cypress,cyapa: convert=
 to dtschema)
Merging block/for-next (69e6e23f4fd8 Merge branch 'for-6.5/block' into for-=
next)
Merging device-mapper/for-next (38d11da522aa dm: don't lock fs when the map=
 is NULL in process of resume)
Merging libata/for-next (f19c694f744f ata: pata_parport: Fix frpw module co=
de indentation and style)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (d4ebc9419afb Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (9bdc4322bbd1 mfd: Remove redundant dev_set_drvdat=
a() from I2C drivers)
Merging backlight/for-backlight-next (fb200218b40b backlight: as3711: Use o=
f_property_read_bool() for boolean properties)
Merging battery/for-next (eae36cb82440 power: reset: add HAS_IOPORT depende=
ncies)
Merging regulator/for-next (dd5250193155 Merge remote-tracking branch 'regu=
lator/for-6.5' into regulator-next)
Merging security/next (ac9a78681b92 Linux 6.4-rc1)
Merging apparmor/apparmor-next (0bb84cff96af apparmor: fix missing error ch=
eck for rhashtable_insert_fast)
Merging integrity/next-integrity (644f17412f5a IMA: allow/fix UML builds)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (c52df19e3759 selinux: small cleanups in selinux_audit=
_rule_init())
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (933fd4391e3d workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more L=
enovo devices)
Merging watchdog/master (fc4354c6e5c2 Merge tag 'mm-stable-2023-05-06-10-49=
' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging iommu/next (e51b4198396c Merge branches 'iommu/fixes', 'arm/allwinn=
er', 'arm/exynos', 'arm/mediatek', 'arm/omap', 'arm/renesas', 'arm/rockchip=
', 'arm/smmu', 'ppc/pamu', 'unisoc', 'x86/vt-d', 'x86/amd', 'core' and 'pla=
tform-remove_new' into next)
Merging audit/next (ac9a78681b92 Linux 6.4-rc1)
Merging devicetree/for-next (c50eb01940c7 Merge branch 'dt/address-cleanups=
' into dt/next)
Merging dt-krzk/for-next (1e0e1e8ba86a Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (d396133dced4 dt-bindings: mailbox: qcom: =
add compatible for IPQ9574 SoC)
Merging spi/for-next (1d5d2ef7b86f Merge remote-tracking branch 'spi/for-6.=
5' into spi-next)
Merging tip/master (0932447780e1 Merge branch into tip/master: 'smp/core')
CONFLICT (content): Merge conflict in tools/perf/arch/x86/include/arch-test=
s.h
CONFLICT (content): Merge conflict in tools/perf/arch/x86/tests/arch-tests.c
Merging clockevents/timers/drivers/next (158009f1b4a3 timekeeping: Fix refe=
rences to nonexistent ktime_get_fast_ns())
Merging edac/edac-for-next (6c79e42169fe EDAC/amd64: Add support for ECC on=
 family 19h model 60h-7Fh)
Merging irqchip/irq/irqchip-next (2ff1b0839ddd Merge branch irq/misc-6.4 in=
to irq/irqchip-next)
Merging ftrace/for-next (3862f86c1529 Merge tools/for-next)
Merging rcu/rcu/next (d6e962af2fdd Merge branch 'atomicdoc.2023.05.11a' int=
o HEAD)
Applying: fixup for "RDMA/rxe: Add error messages"
Merging kvm/next (7a8016d95651 Merge tag 'kvm-s390-next-6.4-2' of https://g=
it.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (801d857f9811 Merge branch kvm-arm64/eager-page-splitt=
ing into kvmarm/next)
Merging kvms390/next (8a46df7cd135 KVM: s390: pci: fix virtual-physical con=
fusion on module unload/load)
Merging kvm-riscv/riscv_kvm_next (2f4d58f7635a RISC-V: KVM: Virtualize per-=
HART AIA CSRs)
Merging kvm-x86/next (5c291b93e5d6 Merge branch 'pmu')
Merging xen-tip/linux-next (cbfac7707ba1 xen/blkback: move blkif_get_x86_*_=
req() into blkback.c)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (4d19140f762c Merge branch 'for-6.5' into for-n=
ext)
Merging drivers-x86/for-next (f5a08ed51ed7 platform/x86: toshiba: constify =
pointers to hwmon_channel_info)
Merging chrome-platform/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging hsi/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (7a9496d0feb5 dt-bindings: leds: Drop redunda=
nt cpus enum match)
Merging ipmi/for-next (d08076678ce7 ipmi:ssif: Drop if blocks with always f=
alse condition)
Merging driver-core/driver-core-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging usb/usb-next (a4422ff22142 usb: typec: qcom: Add Qualcomm PMIC Type=
-C driver)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/gadget.c
CONFLICT (content): Merge conflict in drivers/usb/gadget/udc/core.c
Merging thunderbolt/next (ac9a78681b92 Linux 6.4-rc1)
Merging usb-serial/usb-next (a095edfc15f0 USB: serial: option: add UNISOC v=
endor and TOZED LT70C product)
Merging tty/tty-next (d5b3d02d0b10 serial: Make uart_remove_one_port() retu=
rn void)
Merging char-misc/char-misc-next (c21c0f9a20a9 Binder: Add async from to tr=
ansaction record)
Merging accel/habanalabs-next (e8478792ca56 accel/habanalabs: mask part of =
hmmu page fault captured address)
Merging coresight/next (18996a113f25 coresight: etm_pmu: Set the module fie=
ld)
Merging fastrpc/for-next (3f6b4c6f0bd0 fastrpc: Don't assert held reservati=
on lock for dma-buf mmapping)
Merging fpga/for-next (da4da5b2d708 fpga: dfl-fme: constify pointers to hwm=
on_channel_info)
Merging icc/icc-next (b7590f3841f4 dt-bindings: interconnect: qcom,msm8998-=
bwmon: Resolve MSM8998 support)
Merging iio/togreg (a508fbfed333 iio: kx022a: Probe asynchronously)
Merging phy-next/next (8d087a09c701 phy: ti: gmii-sel: Enable USXGMII mode =
for J784S4)
Merging soundwire/next (9420c9719f03 soundwire: bus: Don't filter slave ale=
rts)
Merging extcon/extcon-next (4e30418def07 extcon: Drop unneeded assignments)
CONFLICT (content): Merge conflict in drivers/extcon/extcon.c
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (705b004ee377 docs: kvm: vfio: Suggest KVM_DEV_VFIO_GROUP=
_ADD vs VFIO_GROUP_GET_DEVICE_FD ordering)
Merging w1/for-next (b332af5398a3 w1: Replace usage of found with dedicated=
 list iterator variable)
Merging staging/staging-next (1f3413dc8eb0 staging: rtl8192e: Refactor tmp_=
ofdm_index variable assignment)
Merging counter-next/counter-next (228354ed692f tools/counter: Makefile: Re=
move lingering 'include' directories on make clean)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (ceb434d56826 dmaengine: ti: k3-udma: Add support fo=
r J721S2 CSI BCDMA instance)
Merging cgroup/for-next (2ef269ef1ac0 cgroup/cpuset: Free DL BW in case can=
_attach() fails)
Merging scsi/for-next (1a7edd041f2d scsi: ufs: core: Fix I/O hang that occu=
rs when BKOPS fails in W-LUN suspend)
Merging scsi-mkp/for-next (44ef1604ae94 Merge patch series "smartpqi update=
s")
Merging vhost/linux-next (ebddc00f450d vhost_net: revert upend_idx only on =
retriable error)
Merging rpmsg/for-next (de598695a2ad remoteproc: stm32: Allow hold boot man=
agement by the SCMI reset controller)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (6c19974d1e83 dt-bindings: gpio: Convert ST=
MPE GPIO to YAML schema)
Merging gpio-intel/for-next (782eea0c89f7 gpiolib: acpi: Add a ignore wakeu=
p quirk for Clevo NL5xNU)
Merging pinctrl/for-next (0ad8190a7aa0 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-renesas/renesas-pinctrl (5d32cead772c pinctrl: renesas: Fix=
 spaces followed by tabs)
Merging pinctrl-samsung/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pwm/for-next (247ee6c78040 pwm: Remove unused radix tree)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (f8424c54d041 selftests/clone3: test clone3 with exi=
t signal in flags)
Merging kunit/test (ac9a78681b92 Linux 6.4-rc1)
Merging kunit-next/kunit (a5ce66ad292b kunit: example: Provide example exit=
 functions)
Merging livepatching/for-next (5e36be5973b6 Merge branch 'for-6.4/core' int=
o for-next)
Merging rtc/rtc-next (e99ab4abebf8 rtc: armada38x: use devm_platform_iorema=
p_resource_byname())
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (a3c10035d12f eeprom: at24: Use dev_err_probe fo=
r nvmem register failure)
Merging ntb/ntb-next (942cc9ceccb6 ntb: intel: Remove redundant pci_clear_m=
aster)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging nvmem/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (a494aef23dfc PCI: hv: Replace retarget_msi_inte=
rrupt_params with hyperv_pcpu_input_arg)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (ac9a78681b92 Linux 6.4-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (1d1493bdc25f bus: mhi: host: Use mhi_tryset_pm_state(=
) for setting fw error state)
Merging memblock/for-next (e4bfeb6d6f39 Fix some coding style errors in mem=
block.c)
Merging cxl/next (bfe58458fd25 cxl/mbox: Update CMD_RC_TABLE)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (0153431c85af efi: make kobj_type structure constant)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (ed4cdfbeb873 Merge branch 'slab/for-6.4/slob-removal=
' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (ac9a78681b92 Linux 6.4-rc1)
Merging sysctl/sysctl-next (1685b445d778 sysctl: stop exporting register_sy=
sctl_table)
Merging execve/for-next/execve (60592fb6b67c coredump, vmcore: Set p_align =
to 4 for PT_NOTE)
Merging bitmap/bitmap-for-next (714f3af11b21 cpumask: fix function descript=
ion kernel-doc notation)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (55c84a5cf2c7 fortify: strcat: Move definition t=
o use fortified strlcat())
Merging kspp-gustavo/for-next/kspp (00168b415a60 uapi: net: ipv6: Replace f=
ake flex-array with flex-array member)
Merging iommufd/for-next (f1fcbaa18b28 Linux 6.4-rc2)

--Sig_/8cHZH2/cAoE3DXKVa/1MSeC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRkNnUACgkQAVBC80lX
0GzFmggAoziOKLzy/OR2HIuXX/sgut0d4wcvNpUsGTDzRc9Z+0QByG9hxdqDoao8
tgttFuuewDIF9TsqSP2FdJCe3Zzf4xktFsqu3g4CsnP+EY6IeI41v0IOuOGyeyMO
ggZM1NRXd4QjnAexiEsnGEro0VNQKB6MtwhtOGrp3PKZ+4got508hLU9QwY8CLFE
Li9M47t5enYC0FJ0x9SDLw+OQqjTPMd4fWQGR+7FwszYVm8dZxe3oacNNq1yg4M1
lZY++VbKhqhQSNRCyfT4HldzClXbmy/Xxpm8t5JlOyJuLltz/+VpFeWYmgEAV7TI
9sO8MiNhxsn4U2+NyuY6ksar/gKCOg==
=Bz94
-----END PGP SIGNATURE-----

--Sig_/8cHZH2/cAoE3DXKVa/1MSeC--
