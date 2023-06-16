Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86E732686
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjFPFNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjFPFNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:13:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7041426B3;
        Thu, 15 Jun 2023 22:13:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qj6kW60gTz4wfy;
        Fri, 16 Jun 2023 15:13:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686892403;
        bh=vrChDn0Sa0eHSczN7vbMTrpy/Bt7Pjh0Ej4vbxoDHII=;
        h=Date:From:To:Cc:Subject:From;
        b=BycCFIrnW2fdcdrGQ2+l5dcajvKIfhn4pZN2VVcfHCUqcFvh00pWQ05tHMY3Gb8Pz
         NABxafbLoOnjrv36K4hg8a/vKS/883Gm49MYruNa05VH01L8uDNNijZyci+IOFTY4o
         WBN/NmKe16Yob/VdwJDbC175bkGPSzjXf8A/9NGYaqKSswekRR71Z31/k5/sexW9Yd
         fd5lmhl1IZV+DFggWeE7dsC98fkBn+1kd34EZ6SIWkcf3ScB+3DaXS/XVz5tXeuK+i
         zv8QPIVw5rnnOcgrc6XKq5/vh2fZt90l7E2TMtVKQcJo/In9X3siktlOXU6Pa6/CvS
         K5t6MDsFc4XJQ==
Date:   Fri, 16 Jun 2023 15:13:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 16
Message-ID: <20230616151321.6be80e68@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3ds0ERB.bS57LyBvRQXEwbw";
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

--Sig_/3ds0ERB.bS57LyBvRQXEwbw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230615:

The arm-soc tree still had its build failure so I used the version from
next-20230609.

The f2fs tree gained a conflict against the mm tree.

The net-next tree still had its build failure for which I applied a patch.

The bluetooth tree still had its build failure for which I reverted a commi=
t.

The block tree gained conflicts against the mm tree.

The scsi-mkp tree still has its build failure so I used the version from
next-20230614.

Non-merge commits (relative to Linus' tree): 9556
 10033 files changed, 437848 insertions(+), 143476 deletions(-)

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
Merging origin/master (b6dad5178cea Merge tag 'nios2_fix_v6.4' of git://git=
.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux)
Merging fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging mm-hotfixes/mm-hotfixes-unstable (e4cdb4618b91 selftests/mm: fix cr=
oss compilation with LLVM)
Merging kbuild-current/fixes (f1fcbaa18b28 Linux 6.4-rc2)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (0e2aba694866 arm64: mm: pass original f=
ault address to handle_mm_fault() in PER_VMA_LOCK block)
Merging arm-soc-fixes/arm/fixes (5cdd5ec17654 Merge tag 'imx-fixes-6.4-2' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fix=
es)
Merging davinci-current/davinci/for-current (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (b845b574f86d m68k: Move signal frame follow=
ing exception on 68020/030)
Merging powerpc-fixes/fixes (dfaed3e1fa70 powerpc/64s/radix: Fix exit lazy =
tlb mm switch with irqs enabled)
Merging s390-fixes/fixes (03c5c83b70dc s390/purgatory: disable branch profi=
ling)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (8f0e3703571f Merge branch 'udplite-dccp-print-deprecation=
-notice')
Merging bpf/master (b78b34c6043e Merge branch 'bpf: fix NULL dereference du=
ring extable search')
Merging ipsec/master (842665a9008a xfrm: Use xfrm_state selector for BEET i=
nput)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (ab39b113e747 Merge tag 'for-net-2023-06-05' of git://git=
.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (f1a0898b5d6a wifi: iwlwifi: mvm: spin_lock_bh() =
to fix lockdep regression)
Merging wpan/master (bd4e3d82f4cc MAINTAINERS: Add wpan patchwork)
Merging rdma-fixes/for-rc (0c7e314a6352 RDMA/rxe: Fix rxe_cq_post)
Merging sound-current/for-linus (7f122623dbcd Merge tag 'asoc-fix-v6.4-rc6-=
2' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into fo=
r-linus)
Merging sound-asoc-fixes/for-linus (f9fd804aa0a3 ASoC: tegra: Fix Master Vo=
lume Control)
Merging regmap-fixes/for-linus (44e46572f0ba regmap: regcache: Don't sync r=
ead-only registers)
Merging regulator-fixes/for-linus (b00de0000a69 regulator: qcom-rpmh: Fix r=
egulators for PM8550)
Merging spi-fixes/for-linus (9d7054fb3ac2 spi: spi-geni-qcom: correctly han=
dle -EPROBE_DEFER from dma_request_chan())
Merging pci-current/for-linus (40994ce0ea01 MAINTAINERS: Add Chuanhua Lei a=
s Intel LGM GW PCIe maintainer)
Merging driver-core.current/driver-core-linus (9561de3a55be Linux 6.4-rc5)
Merging tty.current/tty-linus (a82c3df955f8 tty: serial: fsl_lpuart: reduce=
 RX watermark to 0 on LS1028A)
Merging usb.current/usb-linus (286d9975a838 usb: gadget: udc: core: Prevent=
 soft_connect_store() race)
Merging usb-serial-fixes/usb-linus (f1832e2b5e49 USB: serial: option: add Q=
uectel EM061KGL series)
Merging phy/fixes (9561de3a55be Linux 6.4-rc5)
Merging staging.current/staging-linus (b3dad076a058 staging: octeon: delete=
 my name from TODO contact)
Merging iio-fixes/fixes-togreg (c57fa0037024 meson saradc: fix clock divide=
r mask length)
Merging counter-current/counter-current (ac9a78681b92 Linux 6.4-rc1)
Merging char-misc.current/char-misc-linus (9561de3a55be Linux 6.4-rc5)
Merging soundwire-fixes/fixes (858fd168a95c Linux 6.4-rc6)
Merging thunderbolt-fixes/fixes (9f9666e65359 thunderbolt: Mask ring interr=
upt on Intel hardware as well)
Merging input-current/for-linus (feee70f45686 Input: xpad - delete a Razer =
DeathAdder mouse VID/PID entry)
Merging crypto-current/master (6ab39f99927e crypto: x86/aria - Use 16 byte =
alignment for GFNI constant vectors)
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (dbcf76390eb9 selftests/ftrace: Improve integ=
ration with kselftest runner)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (e14fd2af7a1d dmaengine: at_hdmac: Extend the=
 Flow Controller bitfield to three bits)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c4d28e30a8d0 mtd: rawnand: marvell: don't set =
the NAND frequency select)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (ec21a38df77a Revert "media: dvb-core: Fix use-=
after-free on race condition at dvb_frontend")
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (4897a898a216 mips: Move initrd_start check a=
fter initrd address sanitisation.)
Merging at91-fixes/at91-fixes (6b0db163ff92 ARM: dts: at91: sama7g5ek: fix =
debounce delay property for shdwc)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (f211b45057d8 Merge tag 'kvm-x86-fixes-6.4' of htt=
ps://github.com/kvm-x86/linux into HEAD)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (b153a0bb4199 hwmon: (pmbus/adm1275) Fix problems=
 with temperature monitoring on ADM1272)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (a70fc4ed20a6 cxl/port: Fix NULL pointer access in =
devm_cxl_add_port())
Merging btrfs-fixes/next-fixes (e53b4a53bd88 Merge branch 'misc-6.4' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (fb109fba7284 platform/x86: int3472: Avoid =
crash in unregistering regulator gpio)
Merging samsung-krzk-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-samsung-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging devicetree-fixes/dt/linus (c7753ed71c16 dt-bindings: pinctrl: qcom,=
pmic-mpp: Fix schema for "qcom,paired")
Merging dt-krzk-fixes/fixes (8bbec86ce6d6 dt-bindings: PCI: fsl,imx6q: fix =
assigned-clocks warning)
Merging scsi-fixes/fixes (9cefd6e7e0a7 scsi: lpfc: Fix incorrect big endian=
 type assignment in bsg loopback path)
Merging drm-fixes/drm-fixes (858fd168a95c Linux 6.4-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (858fd168a95c Linux 6.4-rc6)
Merging mmc-fixes/fixes (3c40eb814532 mmc: meson-gx: remove redundant mmc_r=
equest_done() call from irq context)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (44c026a73be8 Linux 6.4-rc3)
Merging hyperv-fixes/hyperv-fixes (ec97e112985c Drivers: hv: vmbus: Call hv=
_synic_free() if hv_synic_alloc() fails)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (b104dbedbe61 Documentation: RISC-V: patch-accep=
tance: mention patchwork's role)
Merging riscv-dt-fixes/riscv-dt-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (a7a041f2ddf3 soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (44c026a73be8 Linux 6.4-rc3)
Merging spdx/spdx-linus (9561de3a55be Linux 6.4-rc5)
Merging gpio-brgl-fixes/gpio/for-current (c1bcb976d8fe gpio: sifive: add mi=
ssing check for platform_get_irq)
Merging gpio-intel-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-intel-fixes/fixes (7877cb91f108 Linux 6.4-rc4)
Merging erofs-fixes/fixes (7877cb91f108 Linux 6.4-rc4)
Merging kunit-fixes/kunit-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (c034203b6a9d nfsd: fix double fget() bug in =
__write_ports_addfd())
Merging irqchip-fixes/irq/irqchip-fixes (91539341a3b6 irqchip/gic: Correctl=
y validate OF quirk descriptors)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (48b1320a674e Merge tag 'for-6.4-rc4-tag' =
of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging efi-fixes/urgent (36e4fc57fc16 efi: Bump stub image version for mac=
OS HVF compatibility)
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
Merging drm-misc-fixes/for-linux-next-fixes (55b94bb8c424 drm/nouveau: add =
nv_encoder pointer check for NULL)
Merging mm-stable/mm-stable (a6e79df92e4a mm/gup: disallow FOLL_LONGTERM GU=
P-fast writing to file-backed mappings)
Merging mm-nonmm-stable/mm-nonmm-stable (a94181ec064b syscalls: add sys_ni_=
posix_timers prototype)
Merging mm/mm-everything (14fe0e6faaf3 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (9ac40f75debf linux/export.h: rename 'sec' argument=
 to 'license')
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf-tools-next (701677b95764 perf srcline: Add a timeout to r=
eading from addr2line)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (0a2f6372a43f drm/nouveau: stop using is_swiot=
lb_active)
Merging asm-generic/master (3b1ddbb62e7e Merge tag 'virt-to-pfn-for-arch-v6=
.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integra=
tor into asm-generic)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (fc6750b0d4a9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (4e01fcb528a3 Merge branch 'for-next/feat_s1pie=
' into for-next/core)
Merging arm-perf/for-next/perf (b1acb4e5601b dt-bindings: perf: fsl-imx-ddr=
: Add i.MX93 compatible)
Merging arm-soc/for-next (15d2ee76762d Merge branch 'soc/arm' into for-next)
$ git reset --hard HEAD^
Merging next-20230609 version of arm-soc
Merging amlogic/for-next (b857a3593956 Merge branch 'v6.5/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
Merging aspeed/for-next (7d4f0b0df7c5 ARM: dts: aspeed-g6: Add UDMA node)
Merging at91/at91-next (9c8457a847fa Merge branch 'clk-microchip' into at91=
-next)
Merging broadcom/next (3d86637615ea Merge branch 'devicetree/next' into nex=
t)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging davinci/davinci/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory/for-next (6a66fb9ffe7b dt-bindings: memory-controlle=
rs: drop unneeded quotes)
Merging imx-mxs/for-next (89c016c82e46 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (64687391f64d Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (f581c395fcb8 Merge branches 'omap-for-v6.5/ti-sysc' =
and 'omap-for-v6.5/cleanup' into for-next)
Merging qcom/for-next (a4a7415fec01 Merge branches 'arm64-defconfig-for-6.5=
', 'arm64-fixes-for-6.4', 'arm64-for-6.5', 'clk-for-6.5', 'drivers-fixes-fo=
r-6.4', 'drivers-for-6.5', 'dts-fixes-for-6.4' and 'dts-for-6.5' into for-n=
ext)
Merging renesas/next (7762defcdaf0 Merge branch 'renesas-drivers-for-v6.5' =
into renesas-next)
Merging reset/reset/next (afb39e2bd36a reset: mpfs: select AUXILIARY_BUS)
Merging rockchip/for-next (dd738a0f90f7 Merge branch 'v6.5-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (878094dcccc3 Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (83ff850e73ba Merge tag 'scmi-updates-6.5' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (c9cb7e72e293 MAINTAINERS: add entry for ARM/STM32=
 ARCHITECTURE)
Merging sunxi/sunxi/for-next (1bcb932283c9 Merge branch 'sunxi/dt-for-6.5' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (d7e22e94908d Merge branch for-6.5/arm64/dt into for=
-next)
Merging ti/ti-next (b0f8e128b3b4 Merge branch 'ti-k3-config-next' into ti-n=
ext)
Merging xilinx/for-next (a736607599a5 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (c3b087685dc6 Merge branch 'clk-cleanup' into clk-next)
Merging clk-imx/for-next (878b02d5f3b5 clk: imx: clk-imx8mp: improve error =
handling in imx8mp_clocks_probe())
Merging clk-renesas/renesas-clk (7df8eea64a41 clk: renesas: rzg2l: Convert =
to readl_poll_timeout_atomic())
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (ac9a78681b92 Linux 6.4-rc1)
Merging loongarch/loongarch-next (47e1ed2a5b9d LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (4055eabe04a2 m68k: defconfig: Update defconfigs for =
v6.4-rc1)
Merging m68knommu/for-next (858fd168a95c Linux 6.4-rc6)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (5cad8323040b mips: dts: ralink: mt7628a: Unify pinc=
trl-single pin group nodes)
Merging openrisc/for-next (c91b4a07655d openrisc: Add floating point regset)
Merging parisc-hd/for-next (fc49c9672cda parisc: Check if IRQs are disabled=
 when calling arch_local_irq_restore())
Merging powerpc/next (4adc95a3edc1 powerpc: update ppc_save_regs to save cu=
rrent r1 in pt_regs)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (d5e45e810e0e Merge patch series "riscv: Add vector=
 ISA support")
CONFLICT (content): Merge conflict in MAINTAINERS
Merging riscv-dt/riscv-dt-for-next (e2c510d6d630 riscv: dts: starfive: Add =
cpu scaling for JH7110 SoC)
Merging riscv-soc/riscv-soc-for-next (ac9a78681b92 Linux 6.4-rc1)
Merging s390/for-next (c561c922e242 Merge branch 'features' into for-next)
Merging sh/for-next (a8ac2961148e sh: Avoid using IRQ0 on SH3 and SH4)
Merging uml/next (6032aca0deb9 um: make stub data pages size tweakable)
Merging xtensa/xtensa-for-next (f29cf77609cc xtensa: add load/store excepti=
on handler)
Merging pidfd/for-next (757777eef55b pid: Replace struct pid 1-element arra=
y with flex-array)
Merging fscrypt/for-next (d617ef039fb8 fscrypt: Replace 1-element array wit=
h flexible array)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (f829918353ef Merge branch 'for-next-next-v6.4-20230=
615' into for-next-20230615)
CONFLICT (content): Merge conflict in fs/btrfs/file.c
Merging ceph/master (409e873ea3c1 ceph: fix use-after-free bug for inodes w=
hen flushing capsnaps)
Merging cifs/for-next (7a043feb6cc0 Merge tag '6.4-rc6-smb3-client-fixes' o=
f git://git.samba.org/sfrench/cifs-2.6)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (e2754cbc5c68 erofs: use separate xattr parsers for listx=
attr/getxattr)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (15bb03a6c517 Pull cleanup of fsnotify_open() callsit=
es.)
Merging ext4/dev (63ec000b35a3 ext4: refactoring to use the unified helper =
ext4_quotas_off())
Merging f2fs/dev (18a87f3eaef5 f2fs: do not issue small discard commands du=
ring checkpoint)
CONFLICT (content): Merge conflict in fs/f2fs/file.c
Merging fsverity/for-next (74836ecbc5c7 fsverity: rework fsverity_get_diges=
t() again)
Merging fuse/for-next (c68ea140050e fuse: remove duplicate check for nodeid)
Merging gfs2/for-next (0a7aaa252413 gfs2: gfs2_freeze_lock_shared cleanup)
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (6aa78d3c48c3 ksmbd: use kvzalloc instead of k=
vmalloc)
Merging nfs/linux-next (9561de3a55be Linux 6.4-rc5)
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (4e9b3eefef36 SUNRPC: Use sysfs_emit in place of str=
lcpy/sprintf)
Merging ntfs3/master (1f60ec888102 fs/ntfs3: Add support /proc/fs/ntfs3/<de=
v>/volinfo and /proc/fs/ntfs3/<dev>/label)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4016239de435 ovl: implement lazy lookup o=
f lowerdata in data-only layers)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging xfs/for-next (c3b880acadc9 xfs: fix ag count overflow during growfs)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (3fd41721cd5c iomap: Add DIO tracepoints)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (63355b9884b3 cpumask: be more careful with '=
cpumask_setall()')
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (27648ae8b791 Merge branches 'vfs.misc', 'v6.5/=
vfs.mount', 'fs.ntfs', 'vfs.rename.locking' and 'vfs.backing.file' into vfs=
.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (16bff6f075a1 Merge branch 'for-6.4' into for-next)
Merging pci/next (5b9283e1ec21 Merge branch 'pci/controller/endpoint')
Merging pstore/for-next/pstore (d97038d5ec20 pstore/ram: Add check for kstr=
dup)
Merging hid/for-next (e2cbca364fe7 Merge branch 'for-6.4/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (8e5b414887ab Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (49b472ebc61d i3c: master: svc: add NACK check after s=
tart byte sent)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (7357b1876b21 hwmon: (tmp464) Use maple tr=
ee register cache)
Merging jc_docs/docs-next (d27e40b55481 docs: crypto: async-tx-api: fix typ=
o in struct name)
Merging v4l-dvb/master (be9aac187433 Merge tag 'v6.4-rc5' into media_stage)
Merging v4l-dvb-next/master (57713028261e Merge tag 'br-v6.5h' of git://lin=
uxtv.org/hverkuil/media_tree into media_stage)
Merging pm/linux-next (06c8e224e003 Merge branch 'acpi-sleep' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (3b062a086984 cpufreq: dt-platde=
v: Support building as module)
Merging cpupower/cpupower (25891bc945f7 cpupower: Bump soname version)
Merging devfreq/devfreq-next (a83bfdca8b20 PM / devfreq: mtk-cci: Fix varia=
ble deferencing before NULL check)
Merging opp/opp/linux-next (af0fd0fd64f3 OPP: Simplify the over-designed ps=
tate <-> level dance)
Merging thermal/thermal/linux-next (c6872f3055ab thermal/drivers/mediatek/l=
vts_thermal: Register thermal zones as hwmon sensors)
Merging dlm/next (1696c75f1864 fs: dlm: add send ack threshold and append a=
cks to msgs)
Merging rdma/for-next (830f93f47068 RDMA/bnxt_re: optimize the parameters p=
assed to helper functions)
Merging net-next/main (97c5209b3d37 leds: trigger: netdev: uninitialized va=
riable in netdev_trig_activate())
CONFLICT (content): Merge conflict in fs/netfs/iterator.c
CONFLICT (content): Merge conflict in include/linux/mlx5/driver.h
CONFLICT (content): Merge conflict in tools/testing/selftests/net/mptcp/mpt=
cp_join.sh
Applying: fix up for "Move netfs_extract_iter_to_sg() to lib/scatterlist.c"
Applying: Fix a sparc64 use of the gso functions
Merging bpf-next/for-next (c03531e087b5 Merge branch 'verify scalar ids map=
ping in regsafe()')
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (4f325e26277b ipvs: dynamically limit the connection=
 hash table)
Merging bluetooth/master (817efd3cad74 Bluetooth: hci_sock: Forward credent=
ials to monitor)
CONFLICT (content): Merge conflict in net/bluetooth/hci_event.c
Applying: Revert "Bluetooth: hci_sock: Forward credentials to monitor"
Merging wireless-next/for-next (5bc9a34ce87b wifi: rtw89: fix spelling typo=
 of IQK debug messages)
Merging wpan-next/master (1af3de62f03f ieee802154: ca8210: Flag the driver =
as being limited)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (3b270fac8443 mtd: otp: Put factory OTP/NVRAM into the=
 entropy pool)
Merging nand/nand/next (46c37b99b5cb mtd: rawnand: meson: check buffer leng=
th)
Merging spi-nor/spi-nor/next (df6def86b9dc mtd: spi-nor: spansion: Add supp=
ort for s25hl02gt and s25hs02gt)
Merging crypto/master (e3023094dffb dm crypt: Avoid using MAX_CIPHER_BLOCKS=
IZE)
Merging drm/drm-next (e245db7b1451 Merge tag 'mediatek-drm-next-6.5' of htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-ne=
xt)
  353491c48697 ("Revert "drm/amd/display: Block optimize on consecutive FAM=
S enables"")
  360930985ec9 ("Revert "drm/amd/display: Do not set drr on pipe commit"")
  5a03159ab7ef ("Revert "drm/amdgpu: switch to golden tsc registers for rav=
en/raven2"")
  a15a77c8e61d ("Revert "drm/amdgpu: change the reference clock for raven/r=
aven2"")
  f9bfc9fff299 ("Revert "drm/amdgpu: Differentiate between Raven2 and Raven=
/Picasso according to revision id"")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_hd=
cp.c
Merging drm-misc/for-linux-next (cf683e8870bd fbdev: Use /* */ comment in i=
nitializer macro)
Merging amdgpu/drm-next (72f1de49ffb9 drm/dp_mst: Clear MSG_RDY flag before=
 sending new message)
Merging drm-intel/for-linux-next (d4b62a1a251d drm/i915/mtl: Cleanup usage =
of phy lane reset)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (1b90e8f8879c drm/msm/adreno: change adreno_is_* f=
unctions to accept const argument)
Merging drm-msm-lumag/msm-next-lumag (518269541298 drm/msm/dsi: split dsi_c=
trl_config() function)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (79a3908d1ea6 fbdev: omapfb: lcd_mipid: Fix an error=
 handling path in mipid_spi_probe())
Merging regmap/for-next (15e42a8ed690 Merge remote-tracking branch 'regmap/=
for-6.5' into regmap-next)
Merging sound/for-next (79597c8bf64c ALSA: ac97: Fix possible NULL derefere=
nce in snd_ac97_mixer)
CONFLICT (content): Merge conflict in include/linux/pci_ids.h
Merging ieee1394/for-next (06f45435d985 firewire: core: obsolete usage of G=
FP_ATOMIC at building node tree)
Merging sound-asoc/for-next (cd10910d410b Merge remote-tracking branch 'aso=
c/for-6.5' into asoc-next)
Merging modules/modules-next (0eeaf1eb40a3 kallsyms: make kallsyms_show_val=
ue() as generic function)
Merging input/next (8c9cce9cb81b Input: pm8941-powerkey - fix debounce on g=
en2+ PMICs)
Merging block/for-next (00e4e45897a7 Merge branch 'for-6.5/block' into for-=
next)
CONFLICT (content): Merge conflict in fs/ext4/super.c
CONFLICT (content): Merge conflict in fs/splice.c
CONFLICT (content): Merge conflict in include/linux/mm.h
CONFLICT (content): Merge conflict in mm/gup.c
Merging device-mapper/for-next (e6b8a879c75e Merge branch 'dm-6.4' into for=
-next (dm-6.5))
CONFLICT (content): Merge conflict in drivers/md/dm-thin-metadata.c
Merging libata/for-next (00134556058c ata: pata_octeon_cf: Add missing head=
er include)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (ae6a2c44052f mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (d918e0d58244 mfd: intel-lpss: Add missing check f=
or platform_get_resource)
Merging backlight/for-backlight-next (a8b09e6fe3ee dt-bindings: backlight: =
pwm: Make power-supply not required)
Merging battery/for-next (4dea2fd6e83c power: reset: qcom-pon: add support =
for pm8941-pon)
Merging regulator/for-next (8ae573f7757c Merge remote-tracking branch 'regu=
lator/for-6.5' into regulator-next)
Merging security/next (b432b5517644 MAINTAINERS: move labeled networking to=
 "supported")
Merging apparmor/apparmor-next (e31dd6e412f7 apparmor: fix: kzalloc perms t=
ables for shared dfas)
Merging integrity/next-integrity (95526d13038c ima: Fix build warnings)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (447a5688005e selinux: avoid bool as identifier name)
CONFLICT (content): Merge conflict in security/selinux/Makefile
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (e52fa5e9fbe1 workqueue: Warn attempt to flush system=
-wide workqueues.)
Merging tpmdd/next (bcd6987b87b1 tpm: Switch i2c drivers back to use .probe=
())
Merging watchdog/master (fc4354c6e5c2 Merge tag 'mm-stable-2023-05-06-10-49=
' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging iommu/next (fe420865bd74 Merge branches 'arm/smmu', 'ppc/pamu', 'vi=
rtio', 'x86/amd' and 'core' into next)
Merging audit/next (e455ca40dbcf audit: avoid missing-prototype warnings)
Merging devicetree/for-next (222e0a8e2f8a dt-bindings: display: panel: mipi=
-dbi-spi: add spi-3wire property)
Merging dt-krzk/for-next (0ff3c07556e6 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (8fe72b76db79 mailbox: mailbox-test: fix a=
 locking issue in mbox_test_message_write())
Merging spi/for-next (5f18392ba2fa Merge remote-tracking branch 'spi/for-6.=
5' into spi-next)
Merging tip/master (45af195ec129 Merge x86/build into tip/master)
CONFLICT (content): Merge conflict in tools/objtool/check.c
CONFLICT (content): Merge conflict in tools/perf/arch/x86/include/arch-test=
s.h
CONFLICT (content): Merge conflict in tools/perf/arch/x86/tests/arch-tests.c
Applying: perf test amd: Fix build failure with amd-ibs-via-core-pmu.c
Applying: fix up for "objtool: Move noreturn function list to separate file"
Merging clockevents/timers/drivers/next (158009f1b4a3 timekeeping: Fix refe=
rences to nonexistent ktime_get_fast_ns())
Merging edac/edac-for-next (852667c317ae Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (2b384e01fd12 Merge branch irq/gic-v3-asr8=
601 into irq/irqchip-next)
Merging ftrace/for-next (3862f86c1529 Merge tools/for-next)
Merging rcu/rcu/next (2d52a9ced37b docs/RCU: Add the missing rcu_read_unloc=
k())
Applying: fixup for "RDMA/rxe: Add error messages"
Merging kvm/next (39428f6ea9ea Merge tag 'kvmarm-fixes-6.4-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvm-arm/next (e1e315c4d528 Merge branch kvm-arm64/misc into kvmarm/=
next)
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Merging kvms390/next (4551948e1e18 KVM: s390: vsie: fix the length of APCB =
bitmap)
Merging kvm-riscv/riscv_kvm_next (95c99104cb42 RISC-V: KVM: Probe for SBI e=
xtension status)
Merging kvm-x86/next (06812fcb9360 Merge branches 'generic', 'misc', 'mmu',=
 'selftests', 'svm', 'vmx' and 'pmu')
Merging xen-tip/linux-next (8225b0e17c07 x86: xen: add missing prototypes)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (ee360b1c5001 Merge branch 'for-6.5-cleanup-ord=
ered' into for-next)
Merging drivers-x86/for-next (966cca72ab20 platform/x86/dell/dell-rbtn: Fix=
 resources leaking on error path)
Merging chrome-platform/for-next (2b8cc5858a07 platform/chrome: cros_ec_spi=
: Use %*ph for printing hexdump of a small buffer)
Merging hsi/for-next (42877c38ac78 HSI: omap_ssi_port: Drop error checking =
for debugfs_create_dir)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (e338a05e76ca dt-bindings: leds: Add binding =
for AW200xx)
Merging ipmi/for-next (02210d52641a dt-bindings: ipmi: aspeed,ast2400-kcs-b=
mc: drop unneeded quotes)
Merging driver-core/driver-core-next (16b58423b4c3 Merge 6.4-rc5 into drive=
r-core-next)
Merging usb/usb-next (df49f2a0ac4a Revert "usb: common: usb-conn-gpio: Set =
last role to unknown before initial detection")
Merging thunderbolt/next (87200371817e thunderbolt: Enable/disable sideband=
 depending on USB4 port offline mode)
Merging usb-serial/usb-next (c9d934053d9e USB: serial: report unsupported b=
reak signalling)
Merging tty/tty-next (f3710f5e9e1a tty: serial: samsung_tty: Use abs() to s=
implify some code)
Merging char-misc/char-misc-next (9e66fb524495 samples: Add userspace examp=
le for TI TPS6594 PFSM)
Merging accel/habanalabs-next (e6f49e96bc57 accel/habanalabs: refactor erro=
r info reset)
Merging coresight/next (3b79104f8003 Documentation: trace: Add documentatio=
n for Coresight Dummy Trace)
Merging fastrpc/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging fpga/for-next (47147d56f92e fpga: zynq-fpga: Ensure proper xCAP int=
erface switch)
Merging icc/icc-next (1400725e4515 Merge branch 'icc-qos' into icc-next)
Merging iio/togreg (9e66fb524495 samples: Add userspace example for TI TPS6=
594 PFSM)
Merging phy-next/next (1eac0f956608 dt-bindings: phy: qcom,qmp-usb: fix bin=
dings error)
Merging soundwire/next (038306aabee6 soundwire: debugfs: Add missing SCP re=
gisters)
Merging extcon/extcon-next (94da3da96c35 dt-bindings: extcon: wlf,arizona: =
drop unneeded quotes)
Merging gnss/gnss-next (44c026a73be8 Linux 6.4-rc3)
Merging vfio/next (d9824f70e52c vfio/pci: Also demote hiding standard cap m=
essages)
Merging w1/for-next (b332af5398a3 w1: Replace usage of found with dedicated=
 list iterator variable)
Merging staging/staging-next (c6e9da9d5566 staging: rtl8192e: clean unneces=
sary braces warning on r8192E_phy.c)
Merging counter-next/counter-next (d428487471ba counter: i8254: Introduce t=
he Intel 8254 interface library module)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (907514a7dc4c dmaengine: sprd: Don't set chancnt)
Merging cgroup/for-next (18740f47e5fa Merge branch 'for-6.5' into for-next)
Merging scsi/for-next (9b9561dbcb76 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (aca416ac0b1f Merge patch series "qla2xxx klocwor=
k fixes")
$ git reset --hard HEAD^
Merging next-20230614 version of scsi-mkp
Merging vhost/linux-next (233cc7c52210 Revert "virtio-blk: support completi=
on batching for the IRQ path")
Merging rpmsg/for-next (1ca04f21b204 remoteproc: stm32: Fix error code in s=
tm32_rproc_parse_dt())
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (ae128bb36d23 dt-bindings: gpio: pca9570: a=
dd gpio-line-names property)
Merging gpio-intel/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl/for-next (386ea4292487 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (d1bfdf867d50 pinctrl: intel: refine ->irq_s=
et_type() hook)
Merging pinctrl-renesas/renesas-pinctrl (5d32cead772c pinctrl: renesas: Fix=
 spaces followed by tabs)
Merging pinctrl-samsung/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pwm/for-next (247ee6c78040 pwm: Remove unused radix tree)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (8cd0d8633e2d selftests/ftace: Fix KTAP output order=
ing)
Merging kunit/test (ac9a78681b92 Linux 6.4-rc1)
Merging kunit-next/kunit (2e66833579ed MAINTAINERS: Add source tree entry f=
or kunit)
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (38e0689b27f8 rtc: stm32: remove dedicated wakeup mana=
gement)
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
Merging nvmem/for-next (ac1c0d15aedc nvmem: core: add support for fixed cel=
ls *layout*)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (a494aef23dfc PCI: hv: Replace retarget_msi_inte=
rrupt_params with hyperv_pcpu_input_arg)
Merging auxdisplay/auxdisplay (def85dce1451 auxdisplay: Switch i2c drivers =
back to use .probe())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (ac9a78681b92 Linux 6.4-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (6bb6aba2f57a bus: mhi: host: pci_generic: Add support=
 for Quectel EM160R-GL modem)
Merging memblock/for-next (de649e7f5edb memblock: Update nid info in memblo=
ck debugfs)
Merging cxl/next (a70fc4ed20a6 cxl/port: Fix NULL pointer access in devm_cx=
l_add_port())
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (d0a1865cf7e2 efi/esrt: Allow ESRT access without CAP_SYS_=
ADMIN)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (62f69e4be588 Merge branches 'slab/for-6.5/prandom', =
'slab/for-6.5/slab_no_merge' and 'slab/for-6.5/slab-deprecate' into slab/fo=
r-next)
CONFLICT (content): Merge conflict in arch/mips/configs/ci20_defconfig
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (35ca42399297 selftests/landlock: Add hostfs tests)
Merging rust/rust-next (d2e3115d7171 rust: error: `impl Debug` for `Error` =
with `errname()` integration)
Merging sysctl/sysctl-next (2b2e5c0d817f sysctl: replace child with a flags=
 var)
Merging execve/for-next/execve (36650a357eac binfmt: Slightly simplify elf_=
fdpic_map_file())
Merging bitmap/bitmap-for-next (714f3af11b21 cpumask: fix function descript=
ion kernel-doc notation)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (a5a319ec2c22 um: Use HOST_DIR for mrproper)
Merging kspp-gustavo/for-next/kspp (1fa89cccd288 media: venus: hfi_cmds: Re=
place fake flex-arrays with flexible-array members)
Merging iommufd/for-next (f1fcbaa18b28 Linux 6.4-rc2)

--Sig_/3ds0ERB.bS57LyBvRQXEwbw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSL73EACgkQAVBC80lX
0GwPqwf+OnXjJSxgb7XZ6IvOX+O/1pZlZpAIznpf24O+3IhdWIsoRN2Tt95773HP
7EefBH0eu9cRUwsZ/57J0wKSVOUKyaGiOOPqB/pzavXnvbLs4t55/tTCcZ/yaIrE
5+yktNV+7PJVfH6SBDFenQ8kRs9XDolsr9jImHSdXuwrE5SCWuNoA3ZGH4m8NXdr
hvL9tPv9eALIIWqwynVAm19Ymh/KaTzgsRnwBOWVJu+tsLr3q9wwmgPivkJExsC2
3XnJIIAo3RPjMPhIO+vvsUnOfWHGEY5kYvU1Sv6/NxtNyqkG1aAbS9eQhfqh2PSx
bXP4jBAEL2cCde7BHcDob8+xkMPHKQ==
=cxme
-----END PGP SIGNATURE-----

--Sig_/3ds0ERB.bS57LyBvRQXEwbw--
