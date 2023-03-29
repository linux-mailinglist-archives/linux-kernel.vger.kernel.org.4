Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6D6CCFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjC2Bxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC2Bxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:53:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F410FB;
        Tue, 28 Mar 2023 18:53:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PmV2Q0fZMz4whh;
        Wed, 29 Mar 2023 12:53:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680054814;
        bh=u8MZWApJvGQtLgrEVEWZZpIK5lc+/pVHt2GyP1O97Cw=;
        h=Date:From:To:Cc:Subject:From;
        b=razaklnx4PnFvScf8am/Zy9ZhtdRe3mwVOymMtKvL5Jnuiqjd2lZuvRqSZpvw7T6i
         oxoIiqDtpZr5RaiipssmgOiG+38HTJI40leWmjPsDzyVTAjQVF7emO/FmkYSMzElC/
         9QCSAI2PSqndvpDZC0BO198TSTya/vu4qsHZ9qXkWf3lUyGVvF7m2qagK6mmS8AA/K
         ztO4ux0cULK152oi0T3QKKa07lRngI8TfwFVnyBlQVzgsYQqsQmZ/72MSqizkld7E4
         45NB2eq2whAidyWWDWhQpJSiWaJfzcYpCarvXNIi0rie0TjfD3pr+uhk4vYu24F0N5
         BgAHFsXXqlsJA==
Date:   Wed, 29 Mar 2023 12:53:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 29
Message-ID: <20230329125333.09fabc9c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hJJWlJDQW_+fb6K4yPa.Vw+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hJJWlJDQW_+fb6K4yPa.Vw+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230328:

The devicetree tree gained conflicts against the sound-asoc tree.

Non-merge commits (relative to Linus' tree): 6848
 7845 files changed, 271008 insertions(+), 167437 deletions(-)

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

I am currently merging 355 trees (counting Linus' and 101 trees of bug
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
Merging origin/master (fcd476ea6a88 Merge tag 'urgent-rcu.2023.03.28a' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (389470deaf54 nilfs2: initialize "=
struct nilfs_binfo_dat"->bi_pad field)
Merging kbuild-current/fixes (fb27e70f6e40 modpost: Fix processing of CRCs =
on 32-bit build machines)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (ceac10c83b33 ARM: 9290/1: uaccess: Fix KASAN fal=
se-positives)
Merging arm64-fixes/for-next/fixes (e8d018dd0257 Linux 6.3-rc3)
Merging arm-soc-fixes/arm/fixes (ec7d8bd7d40f Merge tag 'qcom-driver-fixes-=
for-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into=
 soc/fixes)
Merging davinci-current/davinci/for-current (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (e36a82bebbf7 m68k: Only force 030 bus error=
 if PC not in exception table)
Merging powerpc-fixes/fixes (fd7276189450 powerpc: Don't try to copy PPR fo=
r task with NULL pt_regs)
Merging s390-fixes/fixes (f9bbf25e7b2b s390/ptrace: fix PTRACE_GET_LAST_BRE=
AK error handling)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (917fd7d6cdda Merge branch 'xen-netback-fix-issue-introduc=
ed-recently')
Merging bpf/master (a6f6a95f2580 LoongArch, bpf: Fix jit to skip speculatio=
n barrier opcode)
Merging ipsec/master (c276a706ea1f xfrm: Allow transport-mode states with A=
F_UNSPEC selector)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (ebd3b826343b Merge tag 'linux-can-fixes-for-6.3-20230327=
' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can)
Merging wireless/for-next (f355f7014574 wifi: mac80211: fix mesh path disco=
very based on unicast packets)
Merging rdma-fixes/for-rc (6bd1bca858f1 RDMA/erdma: Defer probing if netdev=
ice can not be found)
Merging sound-current/for-linus (fa4e7a6fa12b ALSA: usb-audio: Fix regressi=
on on detection of Roland VS-100)
Merging sound-asoc-fixes/for-linus (44378cd113e5 ASoC: da7213.c: add missin=
g pm_runtime_disable())
Merging regmap-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging regulator-fixes/for-linus (02bcba0b9f9d regulator: Handle deferred =
clk)
Merging spi-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging pci-current/for-linus (cdce67099117 PCI: dwc: Fix PORT_LINK_CONTROL=
 update when CDM check enabled)
Merging driver-core.current/driver-core-linus (44ac5abac86b Documentation/s=
ecurity-bugs: move from admin-guide/ to process/)
Merging tty.current/tty-linus (e8d018dd0257 Linux 6.3-rc3)
Merging usb.current/usb-linus (197b6b60ae7b Linux 6.3-rc4)
Merging usb-serial-fixes/usb-linus (773e8e7d07b7 USB: serial: option: add T=
elit FE990 compositions)
Merging phy/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging staging.current/staging-linus (eeac8ede1755 Linux 6.3-rc2)
Merging iio-fixes/fixes-togreg (363c7dc72f79 iio: adc: ti-ads7950: Set `can=
_sleep` flag for GPIO chip)
Merging counter-current/counter-current (00f4bc5184c1 counter: 104-quad-8: =
Fix Synapse action reported for Index signals)
Merging char-misc.current/char-misc-linus (4bffd2c7a3fc Merge tag 'iio-fixe=
s-for-6.3a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-linus)
Merging soundwire-fixes/fixes (e6923fd863af soundwire: qcom: correct settin=
g ignore bit on v1.5.1)
Merging thunderbolt-fixes/fixes (58cdfe6f58b3 thunderbolt: Rename shadowed =
variables bit to interrupt_bit and auto_clear_bit)
Merging input-current/for-linus (cbedf1a33970 Input: i8042 - add TUXEDO dev=
ices to i8042 quirk tables for partial fix)
Merging crypto-current/master (660ca9470f9c crypto: caam - Fix edesc/iv ord=
ering mixup)
Merging vfio-fixes/for-linus (4928f67bc911 vfio/mlx5: Fix the report of dir=
ty_bytes upon pre-copy)
Merging kselftest-fixes/fixes (05107edc9101 selftests: sigaltstack: fix -Wu=
ninitialized)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (b771baf3988a dmaengine: xilinx: xdma: Fix so=
me kernel-doc comments)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (e732e39ed992 mtd: rawnand: meson: invalidate c=
ache on polling ECC bit)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (55f1ecb11990 media: v4l: subdev: Make link val=
idation safer)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (ab327f8acdf8 mips: bmips: BCM6358: disable R=
AC flush for TP1)
Merging at91-fixes/at91-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (9e347ba03029 Merge tag 'kvm-riscv-fixes-6.3-1' of=
 https://github.com/kvm-riscv/linux into HEAD)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (968b66ffeb79 hwmon (it87): Fix voltage scaling f=
or chips with 10.9mV  ADCs)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (711442e29f16 cxl/region: Fix passthrough-decoder d=
etection)
Merging btrfs-fixes/next-fixes (33c5d9294a1e Merge branch 'misc-6.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (0eee5ae10256 swiotlb: fix slot alignme=
nt checks)
Merging drivers-x86-fixes/fixes (441d901fbf66 platform/x86: gigabyte-wmi: a=
dd support for B650 AORUS ELITE AX)
Merging samsung-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-samsung-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree-fixes/dt/linus (707344c8a188 dt-bindings: interrupt-cont=
roller: arm,gic-v3: Fix typo in description of msi-controller property)
Merging dt-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging scsi-fixes/fixes (d684a7a26f7d scsi: mpt3sas: Don't print sense poo=
l info twice)
Merging drm-fixes/drm-fixes (197b6b60ae7b Linux 6.3-rc4)
Merging drm-intel-fixes/for-linux-next-fixes (5c95b2d5d44f drm/i915/perf: D=
rop wakeref on GuC RC error)
Merging mmc-fixes/fixes (2265098fd6a6 mmc: sdhci_am654: Set HIGH_SPEED_ENA =
for SDR12 and SDR25)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (f8acb24aaf89 x86/hyperv: Block root part=
ition functionality in a Confidential VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (e89c2e815e76 riscv: Handle zicsr/zifencei issue=
s between clang and binutils)
Merging riscv-dt-fixes/riscv-dt-fixes (8056dc043d7f riscv: dts: canaan: dro=
p invalid spi-max-frequency)
Merging riscv-soc-fixes/riscv-soc-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging fpga-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging spdx/spdx-linus (fe15c26ee26e Linux 6.3-rc1)
Merging gpio-brgl-fixes/gpio/for-current (d49765b5f432 gpio: GPIO_REGMAP: s=
elect REGMAP instead of depending on it)
Merging gpio-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging erofs-fixes/fixes (3993f4f45630 erofs: use wrapper i_blocksize() in=
 erofs_file_read_iter())
Merging kunit-fixes/kunit-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (49025ba389ec NFSv4: Fix NFS_V4 select RPCSEC=
_GSS_KRB5)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (5b201a82cd9d perf tools: Add Adrian Hunte=
r to MAINTAINERS as a reviewer)
Merging efi-fixes/urgent (0b1d9debe303 efi/libstub: randomalloc: Return EFI=
_OUT_OF_RESOURCES on failure)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (06615d11cc78 power: supply: da9150: Fix use af=
ter free bug in da9150_charger_remove due to race condition)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (fe15c26ee26e Linux 6.3-rc1)
Merging rust-fixes/rust-fixes (3098cb655e7c rust: bindgen: Add `alt_instr` =
as opaque type)
Merging v9fs-fixes/fixes/next (707823e7f22f 9P FS: Fix wild-memory-access w=
rite in v9fs_get_acl)
Merging drm-misc-fixes/for-linux-next-fixes (34224133458c accel/ivpu: Fix I=
PC buffer header status field value)
Merging mm-stable/mm-stable (6c21ff5ad887 sync mm.git with v6.3-rc4, as the=
 baseline for this -rc cycle)
Merging mm-nonmm-stable/mm-nonmm-stable (197b6b60ae7b Linux 6.3-rc4)
Merging mm/mm-everything (3892f54b605b Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (b26e7a4b4ef6 kallsyms: expand symbol name into com=
ment for debugging)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (d2278cf6dd09 perf stat: Suppress warning when using=
 cpum_cf events on s390)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (bd89d69a529f dma-debug: add cacheline to user=
/kernel space dump messages)
Merging asm-generic/master (a13408c20526 char/agp: introduce asm-generic/ag=
p.h)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (7e01cedfc602 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (11d8cb1f7824 Merge branches 'for-next/asm', 'f=
or-next/misc' and 'for-next/mm' into for-next/core)
Merging arm-perf/for-next/perf (4248d043e462 Revert "ARM: mach-virt: Select=
 PMUv3 driver by default")
Merging arm-soc/for-next (55377fbf32ff soc: document merges)
Merging amlogic/for-next (ae68fb187b59 Merge branch 'v6.4/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (f41aba157819 Merge branch 'asahi-soc/=
dt' into asahi-soc/for-next)
Merging aspeed/for-next (bb13bd587d53 ARM: dts: aspeed: bonnell: Update eep=
rom size)
Merging at91/at91-next (f5200f71d927 clk: microchip: Use of_property_read_b=
ool() for boolean properties)
Merging broadcom/next (89ec1caa5e4a Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory/for-next (20c082a2ba25 memory: stm32-fmc2-ebi: depen=
ds on ARCH_STM32 instead of MACH_STM32MP157)
Merging imx-mxs/for-next (21a06ce12590 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (83e265f43faf Merge branch 'v6.3-next/soc' into f=
or-next)
Merging mvebu/for-next (b80b042da860 Merge branch 'mvebu/fixes' into mvebu/=
for-next)
Merging omap/for-next (c45167f4f5cf Merge branch 'omap-for-v6.4/dt' into fo=
r-next)
Merging qcom/for-next (d3f367351d2d Merge branches 'arm64-defconfig-for-6.4=
', 'arm64-fixes-for-6.3', 'arm64-for-6.4', 'clk-for-6.4', 'drivers-fixes-fo=
r-6.3', 'drivers-for-6.4', 'dts-fixes-for-6.3' and 'dts-for-6.4' into for-n=
ext)
Merging renesas/next (8184e7e383be Merge branches 'renesas-drivers-for-v6.4=
' and 'renesas-dts-for-v6.4' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (52964e8dd25b Merge branch 'v6.4-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (fb656e801725 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (46e4d4e6800d Merge branch 'for-next/scmi/fixes=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into =
for-linux-next)
Merging stm32/stm32-next (623ac593a360 ARM: dts: stm32: add uart nodes and =
uart aliases on stm32mp135f-dk)
Merging sunxi/sunxi/for-next (2928f01211bf Merge branch 'sunxi/dt-for-6.4' =
into sunxi/for-next)
Merging tee/next (f8502fba45bd tee: amdtee: fix race condition in amdtee_op=
en_session)
Merging tegra/for-next (09870af4487f Merge branch for-6.4/arm64/dt into for=
-next)
Merging ti/ti-next (f3910d4b06af Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (ec1696c3440f Merge remote-tracking branch 'zynqmp/=
soc' into for-next)
Merging clk/clk-next (f7b5a248213f Merge branch 'clk-broadcom' into clk-nex=
t)
Merging clk-imx/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging clk-renesas/renesas-clk (72cd8436ece0 clk: renesas: Convert to plat=
form remove callback returning void)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (fc89d7fb499b Merge tag 'for_linus' of git=
://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging m68k/for-next (fda1941b8eab m68k: Remove obsolete config NO_KERNEL_=
MSG)
Merging m68knommu/for-next (efe3fea1cfd6 m68k: Kconfig.machine: remove obso=
lete configs ROMBASE and ROMSIZE)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (101f26c72825 MIPS: octeon: Fix compile error)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (783394630553 parisc: Ensure page alignment in f=
lush functions)
Merging powerpc/next (3a713753d3cb powerpc: Simplify sysctl registration fo=
r nmi_wd_lpm_factor_ctl_table)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (e97be4fbc1b1 Merge patch series "Add RISC-V 32 NOM=
MU support")
Merging riscv-dt/riscv-dt-for-next (0e9b70c1e362 riscv: dts: microchip: add=
 mpfs specific macb reset support)
Merging riscv-soc/riscv-soc-for-next (49f965b6fbca soc: canaan: Make K210_S=
YSCTL depend on CLK_K210)
Merging s390/for-next (5aed5bd9e869 Merge branch 'features' into for-next)
Merging sh/for-next (c2bd1e18c6f8 sh: mcount.S: fix build error when PRINTK=
 is not enabled)
CONFLICT (content): Merge conflict in Documentation/kbuild/kbuild.rst
Merging uml/next (04df97e150c8 Documentation: rust: Fix arch support table)
Merging xtensa/xtensa-for-next (e313de5b5b04 MAINTAINERS: xtensa: drop linu=
x-xtensa@linux-xtensa.org mailing list)
Merging pidfd/for-next (6e890c5d5021 vhost: use vhost_tasks for worker thre=
ads)
Merging vfs-idmapping/for-next (a6bd1ccc33b8 Merge branch 'fs.misc' into fo=
r-next)
Merging fscrypt/for-next (41b2ad80fdca fscrypt: use WARN_ON_ONCE instead of=
 WARN_ON)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (80d1eec6927a Merge branch 'for-next-current-v6.2-20=
230221' into for-next-20230221)
Merging ceph/master (f7c4d9b133c7 rbd: avoid use-after-free in do_rbd_add()=
 when rbd_dev_create() fails)
Merging cifs/for-next (197b6b60ae7b Linux 6.3-rc4)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (4f24ebae35ff erofs: support flattened block device for m=
ulti-blob images)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (18cb347a8b38 reiserfs: remove unused sched_count var=
iable)
Merging ext4/dev (463f2e46bf7c ext4: convert some BUG_ON's in mballoc to us=
e WARN_RATELIMITED instead)
Merging f2fs/dev (2f3d837dbaa0 f2fs: add compression feature check for all =
compress mount opt)
Merging fsverity/for-next (80069b37a7f5 fsverity: explicitly check for buff=
er overflow in build_merkle_tree())
Merging fuse/for-next (c68ea140050e fuse: remove duplicate check for nodeid)
Merging gfs2/for-next (cfcdb5bad34f gfs2: Fix inode height consistency chec=
k)
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (2824861773eb ksmbd: remove unused is_char_all=
owed function)
Merging nfs/linux-next (e8d018dd0257 Linux 6.3-rc3)
Merging nfs-anna/linux-next (943d045a6d79 SUNRPC: fix shutdown of NFS TCP c=
lient socket)
Merging nfsd/nfsd-next (808793c597cc SUNRPC: Ensure server-side sockets hav=
e a sock->file)
Merging ntfs3/master (788ee1605c2e fs/ntfs3: Fix root inode checking)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (f773f0a331d6 ubi: Fix deadlock caused by recursively ho=
lding work_sem)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (58fb744cdc37 fs/9p: Add new options to=
 Documentation)
Merging xfs/for-next (4dfb02d5cae8 xfs: fix mismerged tracepoints)
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
Merging iomap/iomap-for-next (471859f57d42 iomap: Rename page_ops to folio_=
ops)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (63355b9884b3 cpumask: be more careful with '=
cpumask_setall()')
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs/for-next (d291d1858419 Merge branch 'work.fd' into for-next)
Merging printk/for-next (a0ff0cd28d2c Merge branch 'for-6.4' into for-next)
Merging pci/next (b0d4fc005ef2 Merge branch 'pci/controller/rcar')
Merging pstore/for-next/pstore (5239a89b06d6 pstore: Revert pmsg_lock back =
to a normal mutex)
Merging hid/for-next (6e661c67d392 Merge branch 'for-6.3/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (7618417929c1 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (2810f1de814a i3c: svc: Convert to platform remove cal=
lback returning void)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (8a863eb1b116 hwmon: (nct6775) update ASUS=
 WMI monitoring list B360/H410/H610/Z390...)
Merging jc_docs/docs-next (4f1bb0386dfc docs: create a top-level arch/ dire=
ctory)
CONFLICT (content): Merge conflict in Documentation/admin-guide/index.rst
Merging v4l-dvb/master (eeac8ede1755 Linux 6.3-rc2)
Merging v4l-dvb-next/master (71937240a472 media: ov2685: Select VIDEO_V4L2_=
SUBDEV_API)
Merging pm/linux-next (075e225e906f Merge branches 'acpi-sysfs', 'acpi-apei=
', 'acpi-properties' and 'acpi-tables' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (b8f3a396a7ee cpufreq: Use of_pr=
operty_present() for testing DT property presence)
Merging cpupower/cpupower (fe15c26ee26e Linux 6.3-rc1)
Merging devfreq/devfreq-next (b7405e3f62d6 PM / devfreq: exynos: Use of_pro=
perty_present() for testing DT property presence)
Merging opp/opp/linux-next (e9eadc282719 opp: Use of_property_present() for=
 testing DT property presence)
Merging thermal/thermal/linux-next (8591494bec96 thermal/drivers/ti: Use fi=
xed update interval)
Merging dlm/next (1361737f102d fs: dlm: switch lkb_sbflags to atomic ops)
Merging rdma/for-next (d649c638dc26 RDMA/erdma: Use fixed hardware page siz=
e)
Merging net-next/main (86e2eca4dded net: ethernet: ti: am65-cpsw: enable p0=
 host port rx_vlan_remap)
Merging bpf-next/for-next (d08ab82f59d5 libbpf: Fix double-free when linker=
 processes empty sections)
CONFLICT (content): Merge conflict in Documentation/bpf/bpf_devel_QA.rst
Applying: bpf, test_run: fix up for "bpf, test_run: fix &xdp_frame misplace=
ment for LIVE_FRAMES"
Merging ipsec-next/master (f4796398f21b xfrm: Remove inner/outer modes from=
 output path)
Merging mlx5-next/mlx5-next (f4244e55e4c3 net/mlx5: Set out of order (ooo) =
by default)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (323fe43cf9ae net: phy: Improved PHY error reporting=
 in state machine)
Merging bluetooth/master (cb3248d369af bluetooth: Add device 13d3:3571 to d=
evice tables)
CONFLICT (content): Merge conflict in net/bluetooth/hci_sync.c
Merging wireless-next/for-next (2af3b2a631b1 mac80211_hwsim: add PMSR repor=
t support via virtio)
Merging mtd/mtd/next (e6026eb080fa mtd: lpddr_cmds: remove unused words var=
iable)
Merging nand/nand/next (bb685c1f35c3 mtd: rawnand: stm32_fmc2: depends on A=
RCH_STM32 instead of MACH_STM32MP157)
Merging spi-nor/spi-nor/next (6afcc84080c4 mtd: spi-nor: spansion: Add supp=
ort for Infineon S25FS256T)
Merging crypto/master (9117e682b8b7 crypto: caam - remove unnecessary (void=
*) conversions)
Merging drm/drm-next (2fcc1fa5f906 Merge tag 'exynos-drm-next-for-v6.4' of =
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-n=
ext)
Merging drm-misc/for-linux-next (7fa5047a436b drm: Use of_property_present(=
) for testing DT property presence)
Merging amdgpu/drm-next (402f3aff8c82 drm/radeon: Only build fbdev if DRM_F=
BDEV_EMULATION is set)
Merging drm-intel/for-linux-next (99e067637862 drm/i915: remove unused conf=
ig DRM_I915_UNSTABLE)
Merging drm-tegra/for-next (b9930311641c gpu: host1x: Fix uninitialized var=
iable use)
Merging drm-msm/msm-next (f73343fae5fb drm/msm: Update generated headers)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/adreno/adreno_gpu=
.c
Merging drm-msm-lumag/msm-next-lumag (d32b37069f56 Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i' and 'msm-next-lumag-mdp4' into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (b61c2c09c5a3 video: fbdev: xilinxfb: Convert to pla=
tform remove callback returning void)
Merging regmap/for-next (c4bf2c90af6d regmap: Removed compressed cache supp=
ort)
Merging sound/for-next (03f62c9cefdb ALSA: docs: A few more words for PCM X=
RUN handling and stream locks)
Merging sound-asoc/for-next (5fe5e255c114 Merge remote-tracking branch 'aso=
c/for-6.4' into asoc-next)
Merging modules/modules-next (3edf091d5c12 Documentation: core-api: update =
kernel-doc reference to kmod.c)
Merging input/next (77987b872fcf dt-bindings: input: Drop unneeded quotes)
Merging block/for-next (a9ea7aab3111 Merge branch 'iter-ubuf' into for-next)
Applying: fix up for "iov_iter: add copy_page_to_iter_nofault()"
Merging device-mapper/for-next (aeb52e33e193 dm bio prison v1: intelligentl=
y size dm_bio_prison's prison_regions)
Merging libata/for-next (140b26035b2d ata: pata_parport-bpck6: Declare mode=
_map as static)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (c7461f3e689f mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (368eb79f738a dt-bindings: mfd: qcom,spmi-pmic: Ad=
d PM2250)
Merging backlight/for-backlight-next (fb200218b40b backlight: as3711: Use o=
f_property_read_bool() for boolean properties)
Merging battery/for-next (86c0ef8652f7 power: supply: generic-adc-battery: =
style fixes)
Merging regulator/for-next (072fdff9422a Merge remote-tracking branch 'regu=
lator/for-6.4' into regulator-next)
Merging security/next (0d57b970df35 security: Remove security_old_inode_ini=
t_security())
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (644f17412f5a IMA: allow/fix UML builds)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (340133318800 selinux: clean up dead code after removi=
ng runtime disable)
Merging smack/next (502a29b04d85 smack_lsm: remove unnecessary type casting)
Merging tomoyo/master (ab8527429de6 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (e52a6162cf6b tpm: remove unnecessary (void*) conversion=
s)
Merging watchdog/master (cf3be7e82b12 watchdog: at91rm9200: Only warn once =
about problems in .remove())
Merging iommu/next (b266151aed18 Merge branches 'iommu/fixes', 'arm/allwinn=
er', 'arm/mediatek', 'arm/omap', 'arm/renesas', 'ppc/pamu', 'x86/amd' and '=
core' into next)
Merging audit/next (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree/for-next (c9c9d764daee of: unittest: Convert to platform=
 remove callback returning void)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/sou=
nd/qcom,lpass-rx-macro.yaml
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/sou=
nd/qcom,lpass-tx-macro.yaml
Merging dt-krzk/for-next (efb75299863e Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (6ccbe33a3952 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for QDU1000/QRU1000)
Merging spi/for-next (0623ec17c45e spi: xilinx: Use devm_platform_get_and_i=
oremap_resource())
Merging tip/master (4b7aa0abddff Merge x86/sev into tip/master)
CONFLICT (content): Merge conflict in mm/userfaultfd.c
Merging clockevents/timers/drivers/next (ab407a1919d2 Merge tag 'clocksourc=
e.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/lin=
ux-rcu into timers/core)
Merging edac/edac-for-next (2bd27ac926dd Merge ras/edac-misc into for-next)
Merging irqchip/irq/irqchip-next (a83bf176fed4 Merge branch irq/bcm-l2-fixe=
s into irq/irqchip-next)
Merging ftrace/for-next (cd17e0c74a07 Merge bootconfig/for-next)
Merging rcu/rcu/next (4be50def5715 Revert "rcu/kvfree: Eliminate k[v]free_r=
cu() single argument macro")
CONFLICT (content): Merge conflict in drivers/infiniband/sw/rxe/rxe_mr.c
Applying: fixup for "RDMA/rxe: Add error messages"
Merging kvm/next (d8708b80fa0e KVM: Change return type of kvm_arch_vm_ioctl=
() to "int")
Merging kvm-arm/next (96a4627dbbd4 Merge tag ' https://github.com/oupton/li=
nux tags/kvmarm-6.3' from into kvmarm-master/next)
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (27d6845d258b Merge branches 'generic', 'misc', 'mmu',=
 'pmu', 'selftests', 'svm', 'vmx' and 'cmd_msrs')
Merging xen-tip/linux-next (aadbd07ff8a7 x86/PVH: avoid 32-bit build warnin=
g when obtaining VGA console info)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (704bc669e1dd workqueue: Introduce show_freezab=
le_workqueues)
Merging drivers-x86/for-next (6f561677c2f2 platform/x86/intel: vsec: Use in=
tel_vsec_dev_release() to simplify init() error cleanup)
Merging chrome-platform/for-next (9ce5f3b3c18e Merge tag 'tag-chrome-platfo=
rm-fixes-for-v6.3-rc4' into for-kernelci)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (8faac9aba0d8 leds: rgb: mt6370: Fix implicit=
 declaration for FIELD_GET)
Merging ipmi/for-next (d352cb47df75 ipmi: simplify sysctl registration)
Merging driver-core/driver-core-next (517d4927aabe driver core: bus: consti=
fy class_unregister/destroy())
CONFLICT (content): Merge conflict in arch/s390/kernel/topology.c
Applying: fixup for "driver core: bus: mark the struct bus_type for sysfs c=
allbacks as constant"
Merging usb/usb-next (97318d6427f6 Merge 6.3-rc4 into usb-next)
Merging thunderbolt/next (ebde5ba27c64 thunderbolt: Refactor DROM reading)
Merging usb-serial/usb-next (197b6b60ae7b Linux 6.3-rc4)
Merging tty/tty-next (f16a70c0472e Merge 6.3-rc3 into tty-next)
Merging char-misc/char-misc-next (1fb1ea0d9cb8 mei: Move uuid.h to the MEI =
namespace)
CONFLICT (modify/delete): drivers/char/pcmcia/cm4000_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/cm4000_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/cm4040_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/cm4040_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/scr24x_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/scr24x_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/synclink_cs.c deleted in char=
-misc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pc=
mcia/synclink_cs.c left in tree.
$ git rm -f drivers/char/pcmcia/cm4000_cs.c drivers/char/pcmcia/cm4040_cs.c=
 drivers/char/pcmcia/scr24x_cs.c drivers/char/pcmcia/synclink_cs.c
Merging accel/habanalabs-next (bc621ca26962 accel/habanalabs: fix HBM MMU i=
nterrupt handling)
Merging coresight/next (197b6b60ae7b Linux 6.3-rc4)
Merging fpga/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging icc/icc-next (403ade557dd1 interconnect: qcom: rpm: drop bogus pm d=
omain attach)
Merging iio/togreg (225dc61e2fa8 iio: adc: stm32-adc: set some stm32-adc.c =
variables storage-class-specifier to static)
Merging phy-next/next (84a59a314263 phy: xgene: Depend on ARCH_XGENE rather=
 than plain arm64)
Merging soundwire/next (6c469871e801 soundwire: stream: restore cumulative =
bus bandwidth when compute_params callback failed)
Merging extcon/extcon-next (3beb28f4c805 extcon: usbc-tusb320: add USB_ROLE=
_SWITCH dependency)
CONFLICT (content): Merge conflict in drivers/extcon/extcon.c
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (d649c34cb916 vfio: Fix NULL pointer dereference caused b=
y uninitialized group->iommufd)
Merging staging/staging-next (b07c8ef8c60a staging: greybus: Inline pwm_chi=
p_to_gb_pwm_chip())
Merging counter-next/counter-next (fe15c26ee26e Linux 6.3-rc1)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (fe8f1a2e9b7c dt-bindings: dma: apple,admac: Add t81=
12-admac compatible)
Merging cgroup/for-next (70a0eb104712 Merge branch 'for-6.4' into for-next)
Merging scsi/for-next (54b700cb9d4b Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (882f4adac9a8 scsi: target: tcm_loop: Remove redu=
ndant driver match function)
Merging vhost/linux-next (35395770f803 virtio_ring: don't update event idx =
on get_buf)
Merging rpmsg/for-next (e19967994d34 remoteproc/mtk_scpi_ipi: Fix one kerne=
l-doc comment)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (2093bcd87232 gpio: xlp: Convert to immutab=
le irq_chip)
Merging gpio-intel/for-next (782eea0c89f7 gpiolib: acpi: Add a ignore wakeu=
p quirk for Clevo NL5xNU)
Merging pinctrl/for-next (4b7e73b5db33 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-renesas/renesas-pinctrl (9d7558ed8372 pinctrl: renesas: Dro=
p support for Renesas-specific properties)
Merging pinctrl-samsung/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pwm/for-next (cf70d01a62c7 pwm: dwc: Use devm_pwmchip_add())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (5290586186d2 selftests: prctl: Add new prctl test f=
or PR_SET_VMA action)
Merging kunit/test (fe15c26ee26e Linux 6.3-rc1)
Merging kunit-next/kunit (99be6588118b kunit: Use gfp in kunit_alloc_resour=
ce() kernel-doc)
Merging livepatching/for-next (5e36be5973b6 Merge branch 'for-6.4/core' int=
o for-next)
Merging rtc/rtc-next (0e6255fa3f64 rtc: meson-vrtc: Use ktime_get_real_ts64=
() to get the current time)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging ntb/ntb-next (0310a30a9395 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging nvmem/for-next (c60363be9b76 nvmem: layouts: onie-tlv: Drop wrong m=
odule alias)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (fe15c26ee26e Linux 6.3-rc1)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (fe15c26ee26e Linux 6.3-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (14853a0676c1 bus: mhi: host: pci_generic: Revert "Add=
 a secondary AT port to Telit FN990")
Merging memblock/for-next (34875d6fc52d Add tests for memblock_alloc_node())
Merging cxl/next (e686c32590f4 dax/kmem: Fix leak of memory-hotplug resourc=
es)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (bac363715a7c efi/libstub: Look for initrd LoadFile2 proto=
col on image handle)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (2f26f6a8ccd5 Merge branch 'slab/for-6.3-rc4/fixes' i=
nto slab/for-next)
CONFLICT (content): Merge conflict in include/linux/slab.h
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (fe15c26ee26e Linux 6.3-rc1)
Merging sysctl/sysctl-next (c521126610c3 mm: compaction: move compaction sy=
sctl to its own file)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (714f3af11b21 cpumask: fix function descript=
ion kernel-doc notation)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging hte/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging kspp/for-next/kspp (78f7a3fd6dc6 randstruct: disable Clang 15 suppo=
rt)
Merging kspp-gustavo/for-next/kspp (edfea16a6dae drm/vmwgfx: Replace one-el=
ement array with flexible-array member)
Merging iommufd/for-next (4ed4791afb34 iommufd/selftest: Add a selftest for=
 iommufd_device_attach() with a hwpt argument)

--Sig_/hJJWlJDQW_+fb6K4yPa.Vw+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQjmh0ACgkQAVBC80lX
0GzkbAf/avgegJmGv9e32JEtW8w747q3YxQ7YJdfZ/ZYwwpohQS3ps4efvw1h4iG
cP5uemG/AZrkR4FlTWBtSjnC9qMk1iWlFSZwCe2yALgTaKiLzKC6MbbXfZPtXw6H
zlarJDjStynB1/ppj0cWa92mlZDamaFkXhlw1lP9jGJEl0aD0Dq4rREoCqJUmHyr
0m98OHhJWnQsju8V5WBoIHNvubtddG8LzhaPxe6aQK796qc+n1g4OD+y5O12zjLP
4zSFUT2BC3baRdlc6zZ5vMOlFHwbLfcPr49nLaM1jwIllAm/UmnRLVA4ISVS7WMO
Yz4LYgPVJ2DsaAnbUfQcgbE8R+qCuA==
=W0GY
-----END PGP SIGNATURE-----

--Sig_/hJJWlJDQW_+fb6K4yPa.Vw+--
