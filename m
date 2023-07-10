Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A59474C9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGJBis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGJBiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:38:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C5E43;
        Sun,  9 Jul 2023 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688953096;
        bh=yK7v5qFVZoxzPDkYfxR+1VQtbsPTeIfB0bbSKvxmCbw=;
        h=Date:From:To:Cc:Subject:From;
        b=S6K2EMptAemlBIbAE+rgKqaI/lkVhA9AYxSd0gOi4xjjhFNm4RhEbhOsKfzqVmFY9
         +8XUO0QsHPyI2p8k+pr8mesN82prxfmg2c2yQbxJ8t2Nb+6WuHl7hCrOahn6wN/Stl
         tnxu/7xWnqBfP4uPI7IaQCrMJgajZ3xToird0Gtj901w1OIcyV17+102e0sN1hUTeB
         iT/xSyTXkHN73adULwUHgUPaZFTOK+7GtV2mvZu/Y2JriGu2DLs4gh9Fsy+HgTYGNa
         qpUuu2OF5NiD+5A0NcCai3ooI4gBwZdVGL2h0O+mxwBtX+uV3+4TE/yLFX7kkk3E34
         rsd9WlrilEiRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QzmqD2YFLz4wZJ;
        Mon, 10 Jul 2023 11:38:16 +1000 (AEST)
Date:   Mon, 10 Jul 2023 11:38:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 10
Message-ID: <20230710113814.4a4916cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XepbcBo.6WpHo1efLqFHApi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XepbcBo.6WpHo1efLqFHApi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230707:

The bluetooth tree still had its build failure for which I reverted a commi=
t.

Non-merge commits (relative to Linus' tree): 668
 794 files changed, 16774 insertions(+), 7903 deletions(-)

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
Merging origin/master (06c2afb862f9 Linux 6.5-rc1)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (571109cb0f47 mm-shmem-fix-race-in=
-shmem_undo_range-w-thp-fix)
Merging kbuild-current/fixes (c17414a273b8 Merge tag 'sh-for-v6.5-tag1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (0e2aba694866 arm64: mm: pass original f=
ault address to handle_mm_fault() in PER_VMA_LOCK block)
Merging arm-soc-fixes/arm/fixes (6722e46513e0 bus: ixp4xx: fix IXP4XX_EXP_T=
1_MASK)
Merging davinci-current/davinci/for-current (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (4055eabe04a2 m68k: defconfig: Update defcon=
figs for v6.4-rc1)
Merging powerpc-fixes/fixes (6995e2de6891 Linux 6.4)
Merging s390-fixes/fixes (ad3d770b83af s390/defconfigs: set CONFIG_NET_TC_S=
KB_EXT=3Dy)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (73c4d1b307ae net: lan743x: select FIXED_PHY)
Merging bpf/master (496720b7cfb6 Merge branch 'Fix for check_max_stack_dept=
h')
Merging ipsec/master (d1e0e61d617b net: xfrm: Amend XFRMA_SEC_CTX nla_polic=
y structure)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (1a7d09a737a0 Merge tag 'nf-23-06-27' of git://git.kernel=
.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging wireless/for-next (f1a0898b5d6a wifi: iwlwifi: mvm: spin_lock_bh() =
to fix lockdep regression)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (45a3e24f65e9 Linux 6.4-rc7)
Merging sound-current/for-linus (5251605f4d29 ALSA: hda/realtek: Add quirk =
for ASUS ROG GZ301V)
Merging sound-asoc-fixes/for-linus (f186c31c04a0 Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (c8e796895e23 regmap: spi-avmm: Fix regmap_b=
us max_raw_write)
Merging regulator-fixes/for-linus (701c1cef8e02 Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (d0e1c60318ac Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (ac9a78681b92 Linux 6.4-rc1)
Merging driver-core.current/driver-core-linus (fe1de5516796 Merge tag 'soun=
dwire-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/sound=
wire)
Merging tty.current/tty-linus (fe1de5516796 Merge tag 'soundwire-6.5-rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire)
Merging usb.current/usb-linus (fe1de5516796 Merge tag 'soundwire-6.5-rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire)
Merging usb-serial-fixes/usb-linus (45a3e24f65e9 Linux 6.4-rc7)
Merging phy/fixes (9561de3a55be Linux 6.4-rc5)
Merging staging.current/staging-linus (fe1de5516796 Merge tag 'soundwire-6.=
5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire)
Merging iio-fixes/fixes-togreg (3af5d5b9a262 iio: adc: ina2xx: avoid NULL p=
ointer dereference on OF device match)
Merging counter-current/counter-current (9b53a1342216 counter: Fix menuconf=
ig "Counter support" submenu entries disappearance)
Merging char-misc.current/char-misc-linus (06c2afb862f9 Linux 6.5-rc1)
Merging soundwire-fixes/fixes (858fd168a95c Linux 6.4-rc6)
Merging thunderbolt-fixes/fixes (6995e2de6891 Linux 6.4)
Merging input-current/for-linus (2479191c30fe Input: cpcap-pwrbutton - repl=
ace GPLv2 boilerplate with SPDX)
Merging crypto-current/master (0b7ec177b589 crypto: algif_hash - Fix race b=
etween MORE and non-MORE sends)
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
Merging kvm-fixes/master (2623b3dc875a Merge tag 'kvmarm-fixes-6.4-4' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (b153a0bb4199 hwmon: (pmbus/adm1275) Fix problems=
 with temperature monitoring on ADM1272)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (a70fc4ed20a6 cxl/port: Fix NULL pointer access in =
devm_cxl_add_port())
Merging btrfs-fixes/next-fixes (4d0998044f33 Merge branch 'misc-6.4' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (146b6f6855e7 platform/x86/amd/pmf: Registe=
r notify handler only if SPS is enabled)
Merging samsung-krzk-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-samsung-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging devicetree-fixes/dt/linus (c7753ed71c16 dt-bindings: pinctrl: qcom,=
pmic-mpp: Fix schema for "qcom,paired")
Merging dt-krzk-fixes/fixes (8bbec86ce6d6 dt-bindings: PCI: fsl,imx6q: fix =
assigned-clocks warning)
Merging scsi-fixes/fixes (9cefd6e7e0a7 scsi: lpfc: Fix incorrect big endian=
 type assignment in bsg loopback path)
Merging drm-fixes/drm-fixes (9bd9be5cbaf8 Merge tag 'drm-misc-fixes-2023-06=
-21' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (6995e2de6891 Linux 6.4)
Merging mmc-fixes/fixes (fa700d73494a mmc: Revert "mmc: core: Allow mmc_sta=
rt_host() synchronously detect a card")
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (44c026a73be8 Linux 6.4-rc3)
Merging hyperv-fixes/hyperv-fixes (55e544e1a922 x86/hyperv: Improve code fo=
r referencing hyperv_pcpu_input_arg)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (533925cb7604 Merge tag 'riscv-for-linus-6.5-mw1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging riscv-dt-fixes/riscv-dt-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (44c026a73be8 Linux 6.4-rc3)
Merging spdx/spdx-linus (45a3e24f65e9 Linux 6.4-rc7)
Merging gpio-brgl-fixes/gpio/for-current (ff7a1790fbf9 gpiolib: Fix irq_dom=
ain resource tracking for gpiochip_irqchip_add_domain())
Merging gpio-intel-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-intel-fixes/fixes (7877cb91f108 Linux 6.4-rc4)
Merging erofs-fixes/fixes (7877cb91f108 Linux 6.4-rc4)
Merging kunit-fixes/kunit-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (d7dbed457c2e nfsd: Fix creation time seriali=
zation order)
Merging irqchip-fixes/irq/irqchip-fixes (567f67acac94 irqchip/gic-v3: Enabl=
e Rockchip 3588001 erratum workaround for RK3588S)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (b6dad5178cea Merge tag 'nios2_fix_v6.4' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux)
Merging efi-fixes/urgent (36e4fc57fc16 efi: Bump stub image version for mac=
OS HVF compatibility)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (95339f40a8b6 power: supply: Fix logic checking=
 if system is running from battery)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (dbe245cdf518 iommufd: Call iopt_area_contig_d=
one() under the lock)
Merging rust-fixes/rust-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging v9fs-fixes/fixes/next (36896bc97c0e fs/9p: Fix a datatype used with=
 V9FS_DIRECT_IO)
Merging w1-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (15008052b34e drm/fbdev-dma: Fi=
x documented default preferred_bpp value)
CONFLICT (content): Merge conflict in include/drm/gpu_scheduler.h
Merging mm-stable/mm-stable (e85d5ff24c0c Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (8f6328c0a936 Merge branch 'master'=
 into mm-nonmm-stable)
Merging mm/mm-everything (9aba4752d690 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (c17414a273b8 Merge tag 'sh-for-v6.5-tag1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf-tools-next (bcd981db12e6 perf test: Fix event parsing tes=
t when PERF_PMU_CAP_EXTENDED_HW_TYPE isn't supported.)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (8ac04063354a swiotlb: reduce the number of ar=
eas to match actual memory pool size)
Merging asm-generic/master (4dd595c34c4b syscalls: Remove file path comment=
s from headers)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (1faf70485ea9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (893b24181b4c arm64: sme: Use STR P to clear FF=
R context field in streaming SVE mode)
Merging arm-perf/for-next/perf (dea0f4146f66 docs: perf: Fix warning from '=
make htmldocs' in hisi-pmu.rst)
Merging arm-soc/for-next (6722e46513e0 bus: ixp4xx: fix IXP4XX_EXP_T1_MASK)
Merging amlogic/for-next (76483eaf2109 Merge branch 'v6.6/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
Merging aspeed/for-next (7d4f0b0df7c5 ARM: dts: aspeed-g6: Add UDMA node)
Merging at91/at91-next (20c5a7864675 Merge branch 'clk-microchip' into at91=
-next)
Merging broadcom/next (df928e5b5570 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory/for-next (6a66fb9ffe7b dt-bindings: memory-controlle=
rs: drop unneeded quotes)
Merging imx-mxs/for-next (89c016c82e46 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (703b10801b44 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (f581c395fcb8 Merge branches 'omap-for-v6.5/ti-sysc' =
and 'omap-for-v6.5/cleanup' into for-next)
Merging qcom/for-next (e62f7f072b12 Merge branches 'arm64-defconfig-for-6.5=
', 'arm64-fixes-for-6.4', 'arm64-fixes-for-6.5', 'clk-for-6.5', 'drivers-fi=
xes-for-6.4', 'drivers-for-6.5', 'dts-fixes-for-6.4' and 'dts-for-6.5' into=
 for-next)
Merging renesas/next (7762defcdaf0 Merge branch 'renesas-drivers-for-v6.5' =
into renesas-next)
Merging reset/reset/next (afb39e2bd36a reset: mpfs: select AUXILIARY_BUS)
Merging rockchip/for-next (dd738a0f90f7 Merge branch 'v6.5-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (6d4e38cedf31 Merge branch 'next/clk' into fo=
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
Merging tegra/for-next (3281fba16642 Merge branch for-6.5/arm64/dt into for=
-next)
Merging ti/ti-next (b0f8e128b3b4 Merge branch 'ti-k3-config-next' into ti-n=
ext)
Merging xilinx/for-next (a736607599a5 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (f679e89acdd3 clk: tegra: Avoid calling an uninitializ=
ed function)
Merging clk-imx/for-next (878b02d5f3b5 clk: imx: clk-imx8mp: improve error =
handling in imx8mp_clocks_probe())
Merging clk-renesas/renesas-clk (7df8eea64a41 clk: renesas: rzg2l: Convert =
to readl_poll_timeout_atomic())
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (dd64621a2a97 csky: uprobes: Restore thread.trap_no)
Merging loongarch/loongarch-next (5ee35c769663 LoongArch: Remove five DIE_*=
 definitions in kdebug.h)
Merging m68k/for-next (4055eabe04a2 m68k: defconfig: Update defconfigs for =
v6.4-rc1)
Merging m68knommu/for-next (858fd168a95c Linux 6.4-rc6)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (06c2afb862f9 Linux 6.5-rc1)
Merging openrisc/for-next (10f061c8fb59 openrisc: Union fpcsr and oldmask i=
n sigcontext to unbreak userspace ABI)
Merging parisc-hd/for-next (6995e2de6891 Linux 6.4)
Merging powerpc/next (abaa02fc944f powerpc: dts: turris1x.dts: Fix PCIe MEM=
 size for pci2 node)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (e8605e8fdf42 Merge patch series "riscv: some CMO a=
lternative related clean up")
Merging riscv-dt/riscv-dt-for-next (06c2afb862f9 Linux 6.5-rc1)
Merging riscv-soc/riscv-soc-for-next (1fcaaa1d489c riscv: Kconfig: Add sele=
ct ARM_AMBA to SOC_STARFIVE)
Merging s390/for-next (b0324ab87db7 Merge branch 'features' into for-next)
Merging sh/for-next (7497840d462c sh: Provide unxlate_dev_mem_ptr() in asm/=
io.h)
Merging uml/next (6032aca0deb9 um: make stub data pages size tweakable)
Merging xtensa/xtensa-for-next (b4e8c8a6bdd2 xtensa: ISS: fix call to split=
_if_spec)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (d617ef039fb8 fscrypt: Replace 1-element array wit=
h flexible array)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (20e0c0a8e8ef Merge branch 'for-next-next-v6.4-20230=
621' into for-next-20230621)
Merging ceph/master (257e6172ab36 ceph: don't let check_caps skip sending r=
esponses for revoke msgs)
Merging cifs/for-next (709c44d0bbb6 cifs: if deferred close is disabled the=
n close files immediately)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (8241fdd3cdfe erofs: clean up zmap.c)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (eccf9ae28312 Pull patch forbiding superblock / mount=
 marks on internal kernel mounts.)
Merging ext4/dev (2ef6c32a914b ext4: avoid updating the superblock on a r/o=
 mount if not needed)
Merging f2fs/dev (6843306689af Merge tag 'net-6.5-rc1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/netdev/net)
Merging fsverity/for-next (672d6ef4c775 fsverity: improve documentation for=
 builtin signature support)
Merging fuse/for-next (6a567e920fd0 fuse: ioctl: translate ENOSYS in outarg)
Merging gfs2/for-next (94c76955e86a Merge tag 'gfs2-v6.4-rc5-fixes' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (95e2b352c03b FS: JFS: Check for read-only mounted fil=
esystem in txBegin)
Merging ksmbd/ksmbd-for-next (8976e9d00395 Merge tag '6.5-rc-ksmbd-server-f=
ixes-part1' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (5b4a82a0724a Revert "NFSv4: Retry LOCK on OLD_STATE=
ID during delegation return")
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (9e268189cb14 SUNRPC: Remove net/sunrpc/auth_gss/gss=
_krb5_seqnum.c)
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (e115496cf1c0 ovl: auto generate uuid for =
new overlay filesystems)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging xfs/for-next (ed04a91f718e xfs: fix uninit warning in xfs_growfs_da=
ta)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (447a0bc108e4 iomap: drop me [hch] from MAINTA=
INERS for iomap)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (0d6aeec73f8c selftests: add OFD lock tests)
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (b48f591aff4a Merge branches 'vfs.readdir' and =
'vfs.misc' into vfs.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (16bff6f075a1 Merge branch 'for-6.4' into for-next)
Merging pci/next (6ecac465eee8 Merge branch 'pci/controller/remove-void-cal=
lbacks')
Merging pstore/for-next/pstore (d97038d5ec20 pstore/ram: Add check for kstr=
dup)
Merging hid/for-next (2a4b950dc6f0 Merge branch 'for-6.5/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (6537ed3904a3 i2c: mpc: Drop unused variable)
Merging i3c/i3c/next (49b472ebc61d i3c: master: svc: add NACK check after s=
tart byte sent)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (4dbbaf8fbdbd hwmon: (oxp-sensors) Add sup=
port for AOKZOE A1 PRO)
Merging jc_docs/docs-next (016571b6d52d Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (c61480a2ea5e media: wl128x: fix a clang warning)
Merging v4l-dvb-next/master (c61480a2ea5e media: wl128x: fix a clang warnin=
g)
Merging pm/linux-next (bd9bb08847da Merge branches 'acpi-scan' and 'acpi-bu=
s' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (5ee64250286e cpufreq: qcom-cpuf=
req-hw: Use dev_err_probe() when failing to get icc paths)
Merging cpupower/cpupower (25891bc945f7 cpupower: Bump soname version)
Merging devfreq/devfreq-next (a83bfdca8b20 PM / devfreq: mtk-cci: Fix varia=
ble deferencing before NULL check)
Merging opp/opp/linux-next (5fb2864cbd50 OPP: Properly propagate error alon=
g when failing to get icc_path)
Merging thermal/thermal/linux-next (57c9eaa4de53 thermal/drivers/qcom/temp-=
alarm: Use dev_err_probe)
Merging dlm/next (fc4ea4229c2b fs: dlm: remove filter local comms on close)
Merging rdma/for-next (5f004bcaee4c Merge tag 'v6.4' into rdma.git for-next)
Merging net-next/main (6843306689af Merge tag 'net-6.5-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf-next/for-next (c628747cc880 libbpf: only reset sec_def handler =
when necessary)
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (61dc651cdfe8 Merge tag 'nf-next-23-06-26' of git://=
git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next)
Merging bluetooth/master (70ec552ac638 Bluetooth: hci_sync: Don't double pr=
int name in add/remove adv_monitor)
Applying: Revert "Bluetooth: hci_sock: Forward credentials to monitor"
Merging wireless-next/for-next (31b5a547622b wifi: ieee80211: fix erroneous=
 NSTR bitmap size checks)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (cf431a599832 Merge branch 'nand/next' into mtd/next)
Merging nand/nand/next (ad5c18c75d2a dt-bindings: mtd: marvell-nand: Conver=
t to YAML DT scheme)
Merging spi-nor/spi-nor/next (df6def86b9dc mtd: spi-nor: spansion: Add supp=
ort for s25hl02gt and s25hs02gt)
Merging crypto/master (486bfb05913a crypto: akcipher - Do not copy dst if i=
t is NULL)
Merging drm/drm-next (6725f3322807 Merge tag 'drm-misc-next-fixes-2023-07-0=
6' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (59bba51ec2a5 drm/panel: Fine tune Starry-i=
li9882t panel HFP and HBP)
Merging amdgpu/drm-next (3de4536fe42d drm/amdgpu: Fix errors & warnings in =
gfx_v10_0.c)
Merging drm-intel/for-linux-next (f6cf3883df47 drm/i915: use mock device in=
fo for creating mock device)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (cd036d542afb drm/msm/a6xx: Add A610 speedbin supp=
ort)
Merging drm-msm-lumag/msm-next-lumag (452c46ccf603 drm/msm/dsi: split dsi_c=
trl_config() function)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (295b6c02f84b drm/etnaviv: slow down FE idle p=
olling)
Merging fbdev/for-next (c1cd7a7a231a fbdev: imxfb: Convert to devm_platform=
_ioremap_resource())
Merging regmap/for-next (1e897fca0b3b Merge remote-tracking branch 'regmap/=
for-6.5' into regmap-next)
Merging sound/for-next (5251605f4d29 ALSA: hda/realtek: Add quirk for ASUS =
ROG GZ301V)
Merging ieee1394/for-next (3ff256751a28 firewire: net: fix use after free i=
n fwnet_finish_incoming_packet())
Merging sound-asoc/for-next (f186c31c04a0 Merge remote-tracking branch 'aso=
c/for-6.4' into asoc-linus)
Merging modules/modules-next (0eeaf1eb40a3 kallsyms: make kallsyms_show_val=
ue() as generic function)
Merging input/next (685b37704ce6 dt-bindings: input: touchscreen: edt-ft5x0=
6: Add 'threshold' property)
Merging block/for-next (8833cf913f44 Merge branch 'block-6.5' into for-next)
Merging device-mapper/for-next (e2c789cab60a dm: get rid of GFP_NOIO workar=
ounds for __vmalloc and kvmalloc)
Merging libata/for-next (fd3ac6e80497 dt-bindings: phy: rockchip: rk3588 ha=
s two reset lines)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (06b5d4fea89c dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul =
support)
Merging mfd/for-mfd-next (b05740d71bd2 dt-bindings: mfd: max77541: Add ADI =
MAX77541/MAX77540)
Merging backlight/for-backlight-next (a33677b9211b backlight: led_bl: Take =
led_access lock when required)
Merging battery/for-next (ef8d95b4a3af MAINTAINERS: add documentation file =
for Microchip SAMA5D2 shutdown controller)
Merging regulator/for-next (701c1cef8e02 Merge remote-tracking branch 'regu=
lator/for-6.4' into regulator-linus)
Merging security/next (4be22f16a4a1 device_cgroup: Fix kernel-doc warnings =
in device_cgroup)
Merging apparmor/apparmor-next (97a79eea1797 apparmor: Fix kernel-doc heade=
r for verify_dfa_accept_index)
CONFLICT (content): Merge conflict in security/apparmor/policy.c
Merging integrity/next-integrity (95526d13038c ima: Fix build warnings)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (447a5688005e selinux: avoid bool as identifier name)
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (1c7873e33645 mm: lock newly mapped VMA with correcte=
d ordering)
Merging tpmdd/next (f42582c6b23a tpm: Switch i2c drivers back to use .probe=
())
Merging watchdog/master (2500df55a615 dt-bindings: watchdog: Add Loongson-1=
 watchdog)
Merging iommu/next (a7a334076dd7 Merge branches 'iommu/fixes', 'arm/smmu', =
'ppc/pamu', 'virtio', 'x86/vt-d', 'core' and 'x86/amd' into next)
Merging audit/next (e455ca40dbcf audit: avoid missing-prototype warnings)
Merging devicetree/for-next (31e9f406efae dt-bindings: soc: qcom: stats: Up=
date maintainer email)
Merging dt-krzk/for-next (0ff3c07556e6 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (d0e1c60318ac Merge remote-tracking branch 'spi/for-6.=
4' into spi-linus)
Merging tip/master (ac442f6a364d Merge branch into tip/master: 'x86/core')
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in include/linux/syscalls.h
CONFLICT (content): Merge conflict in mm/gup.c
CONFLICT (content): Merge conflict in mm/migrate.c
Merging clockevents/timers/drivers/next (8b5bf64c89c7 clocksource/drivers/c=
adence-ttc: Fix memory leak in ttc_timer_probe)
Merging edac/edac-for-next (852667c317ae Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (a82f3119d543 Merge branch irq/misc-6.5 in=
to irq/irqchip-next)
Merging ftrace/for-next (61c692f56fec Merge tools/for-next)
Merging rcu/rcu/next (c70bbbbdf3a6 rcutorture: Remove obsolete BOOTPARAM_HO=
TPLUG_CPU0 Kconfig option)
Merging kvm/next (255006adb3da Merge tag 'kvm-x86-vmx-6.5' of https://githu=
b.com/kvm-x86/linux into HEAD)
Merging kvm-arm/next (192df2aa0113 KVM: arm64: Fix misuse of KVM_ARM_VCPU_P=
OWER_OFF bit index)
Merging kvms390/next (db54dfc9f71c s390/uv: Update query for secret-UVCs)
Merging kvm-riscv/riscv_kvm_next (07f225b58424 RISC-V: KVM: Remove unneeded=
 semicolon)
Merging kvm-x86/next (88bb466c9dec Merge branches 'generic', 'misc', 'mmu',=
 'selftests', 'svm', 'vmx' and 'pmu')
Merging xen-tip/linux-next (21a235bce123 xen/virtio: Fix NULL deref when a =
bridge of PCI root bus has no parent)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (ee360b1c5001 Merge branch 'for-6.5-cleanup-ord=
ered' into for-next)
Merging drivers-x86/for-next (d2a7bd369099 platform/x86:intel/pmc: Add Mete=
or Lake IOE-M PMC related maps)
Merging chrome-platform/for-next (2b8cc5858a07 platform/chrome: cros_ec_spi=
: Use %*ph for printing hexdump of a small buffer)
Merging hsi/for-next (42877c38ac78 HSI: omap_ssi_port: Drop error checking =
for debugfs_create_dir)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (877e91191ccf leds: leds-mt6323: Adjust retur=
n/parameter types in wled get/set callbacks)
Merging ipmi/for-next (b02bb79eee07 ipmi: fix potential deadlock on &kcs_bm=
c->lock)
Merging driver-core/driver-core-next (fe1de5516796 Merge tag 'soundwire-6.5=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire)
Merging usb/usb-next (fe1de5516796 Merge tag 'soundwire-6.5-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire)
Merging thunderbolt/next (481012b479fe thunderbolt: Add test case for 3 Dis=
playPort tunnels)
Merging usb-serial/usb-next (ffa5f7a3bf28 USB: serial: option: add LARA-R6 =
01B PIDs)
Merging tty/tty-next (fe1de5516796 Merge tag 'soundwire-6.5-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire)
Merging char-misc/char-misc-next (06c2afb862f9 Linux 6.5-rc1)
Merging accel/habanalabs-next (e6f49e96bc57 accel/habanalabs: refactor erro=
r info reset)
Merging coresight/next (6c50384ef8b9 hwtracing: hisi_ptt: Fix potential sle=
ep in atomic context)
Merging fastrpc/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging fpga/for-next (47147d56f92e fpga: zynq-fpga: Ensure proper xCAP int=
erface switch)
Merging icc/icc-next (1400725e4515 Merge branch 'icc-qos' into icc-next)
Merging iio/togreg (9e66fb524495 samples: Add userspace example for TI TPS6=
594 PFSM)
Merging phy-next/next (a454850a815e dt-bindings: phy: brcm,brcmstb-usb-phy:=
 Fix error in "compatible" conditional schema)
Merging soundwire/next (a4857d1afdd1 soundwire: stream: Make master_list or=
dered to prevent deadlocks)
Merging extcon/extcon-next (94da3da96c35 dt-bindings: extcon: wlf,arizona: =
drop unneeded quotes)
Merging gnss/gnss-next (44c026a73be8 Linux 6.4-rc3)
Merging vfio/next (ff598081e5b9 vfio/mdev: Move the compat_class initializa=
tion to module init)
Merging w1/for-next (b332af5398a3 w1: Replace usage of found with dedicated=
 list iterator variable)
Merging staging/staging-next (fe1de5516796 Merge tag 'soundwire-6.5-rc1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire)
Merging counter-next/counter-next (9b53a1342216 counter: Fix menuconfig "Co=
unter support" submenu entries disappearance)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (907514a7dc4c dmaengine: sprd: Don't set chancnt)
Merging cgroup/for-next (fd99fa7cff4d Merge branch 'for-6.5' into for-next)
Merging scsi/for-next (e0d21060a8f6 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (a97ccaa4f043 Merge patch series "Improve checks =
in blk_revalidate_disk_zones()")
Merging vhost/linux-next (373abdba01d4 vdpa_sim: offer VHOST_BACKEND_F_ENAB=
LE_AFTER_DRIVER_OK)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (81aceef4b71d Merge branches 'hwspinlock-next' and '=
rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (0ff9f5e57c5b of: unittest: drop assertions=
 for GPIO hog messages)
Merging gpio-intel/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl/for-next (3bc551a3007a pinctrl: amd: Unify debounce handlin=
g into amd_pinconf_set())
Merging pinctrl-intel/for-next (9314d0530276 pinctrl: cherryview: Drop goto=
 label)
Merging pinctrl-renesas/renesas-pinctrl (5d32cead772c pinctrl: renesas: Fix=
 spaces followed by tabs)
Merging pinctrl-samsung/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pwm/for-next (92554cdd428f dt-bindings: pwm: convert pwm-bcm2835 bi=
ndings to YAML)
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
Merging rtc/rtc-next (1b733a9ebc3d rtc: Add rtc driver for the Loongson fam=
ily chips)
Merging nvdimm/libnvdimm-for-next (1ea7ca1b0901 dax: enable dax fault handl=
er to report VM_FAULT_HWPOISON)
Merging at24/at24/for-next (a3c10035d12f eeprom: at24: Use dev_err_probe fo=
r nvmem register failure)
Merging ntb/ntb-next (bff6efc54bd0 ntb: hw: amd: Fix debugfs_create_dir err=
or checking)
Merging seccomp/for-next/seccomp (f373d301908a perf/benchmark: add a new be=
nchmark for seccom_unotify)
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
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (ac9a78681b92 Linux 6.4-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (6bb6aba2f57a bus: mhi: host: pci_generic: Add support=
 for Quectel EM160R-GL modem)
Merging memblock/for-next (de649e7f5edb memblock: Update nid info in memblo=
ck debugfs)
Merging cxl/next (fe77cc2e5a6a cxl: Fix one kernel-doc comment)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (2e28a798c309 efi/libstub: Disable PCI DMA before grabbing=
 the EFI memory map)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (7bc162d5cc4d Merge branches 'slab/for-6.5/prandom', =
'slab/for-6.5/slab_no_merge' and 'slab/for-6.5/slab-deprecate' into slab/fo=
r-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (35ca42399297 selftests/landlock: Add hostfs tests)
Merging rust/rust-next (d2e3115d7171 rust: error: `impl Debug` for `Error` =
with `errname()` integration)
Merging sysctl/sysctl-next (5664eaac4dcf sysctl: fix unused proc_cap_handle=
r() function warning)
Merging execve/for-next/execve (aa88054b7090 binfmt_elf: fix comment typo s=
/reset/regset/)
Merging bitmap/bitmap-for-next (2a3110e3f97d MAINTAINERS: Add bitfield.h to=
 the BITMAP API record)
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (01f23c5f1526 usb: ch9: Replace bmSublinkSpeedAt=
tr 1-element array with flexible array)
Merging kspp-gustavo/for-next/kspp (40ca06d71d60 uapi: wireless: Replace ze=
ro-length array with flexible-array member)
Merging iommufd/for-next (f1fcbaa18b28 Linux 6.4-rc2)

--Sig_/XepbcBo.6WpHo1efLqFHApi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSrYQcACgkQAVBC80lX
0Gwd1wf+N1ZQVI+1i+JxnP3O6hVU0R2XASuStM6NKQe572YZIJvgu5WDkLtMWrPE
E0we6ZuSMRItq03eh2p4F2Y25y+lcyvRVSx9MGsWeja3xRLLbhkVhdeEWrAkIG4I
w4igE/0gNJIEej/iYJtWqEUyv95dMfbnMIlA47QVSY2HTqg2Muv6Iy91aUOkEQhp
iUy5CRPrJL5Q7jBt9ngoV+bV5gCcLbCGXFjawa8i7FNenxcKy8HuM+Tf/LzYG1+H
+sF6lm7w3rnTtATfW6FLaqOMKFY8p3QUX5Rwm3G7WQ7KBVJvo/XScFLI5PapXi5+
PNUa72P4MoMv0c0z032kpZqk578ELA==
=4xbl
-----END PGP SIGNATURE-----

--Sig_/XepbcBo.6WpHo1efLqFHApi--
