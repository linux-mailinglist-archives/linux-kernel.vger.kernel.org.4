Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2278631B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiKUI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKUI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:29:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8B1C423;
        Mon, 21 Nov 2022 00:29:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NG0tF2Hq2z4xN1;
        Mon, 21 Nov 2022 19:29:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669019365;
        bh=gtBzJcNoG/vQFGH3XqlJ42lPIs+QRAwbUAYIwD8L24U=;
        h=Date:From:To:Cc:Subject:From;
        b=S3ny88OLBueC/o8nihcsQngvkZMQNSIib/newrqTNfOK8IyRwS8cfbEeZ3o8uDwPQ
         upnA4FEtTqj/fkxtJCqyZHCcpdnCj/ahcne5grrDQCOzmBqmQKhYx3uO0aDTc3FH/x
         5J2FDAoEyRQq55Aazh7FkrTKrT8gFnzKiUDkpUXiYSsRij77FF9zi2IuHVnrkc+Ltm
         S4pC+7hvdCJdWFqVC1Uuqx811Ym9InJ1eXNqgVCBCE8wY72TrUBtErXfUNbGzLfLHG
         wv0Wiomr7Mcb1y/h87PETOr0pN+rUwnOVY+FElf7KfvzTl+VZGs1c0X/DAz5KxQ3Rv
         vjhsgNAnw5VRg==
Date:   Mon, 21 Nov 2022 19:29:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 21
Message-ID: <20221121192924.69331df5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KHo8gYl1sG0FAnI_pNTaLpW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KHo8gYl1sG0FAnI_pNTaLpW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221118:

The arm64 tree lost its build failure.

The riscv-dt tree gained a conflict against the renesas tree.

The printk tree gained a build failure so I used the version from
next-20221118.

The thermal tree still had complex conflicts against the pm tree so I dropp=
ed
the thermal tree for today.

The net-next tree still had its build failure but I used a supplied patch.

The bpf-next tree gained a conflict against the bpf tree.

The drm tree gained a conflict against the drm-misc-fixes tree.

The block tree gained a conflict against Linus' tree.

The security tree gained a conflict against Linus' tree.

The apparmor tree gained a conflict against the security tree.

The tip tree gained a conflict against the pci tree.

Non-merge commits (relative to Linus' tree): 8306
 8253 files changed, 386387 insertions(+), 152815 deletions(-)

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
Merging origin/master (894909f95aa1 Merge tag 'x86_urgent_for_v6.1_rc6' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (f9d5e6380ee8 mm/cgroup/reclaim: f=
ix dirty pages throttling on cgroup v1)
Merging kbuild-current/fixes (77c51ba552a1 Merge tag 'scsi-fixes' of git://=
git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (340a982825f7 ARM: 9266/1: mm: fix no-MMU ZERO_PA=
GE() implementation)
Merging arm64-fixes/for-next/fixes (5b47348fc0b1 arm64/mm: fix incorrect fi=
le_map_count for non-leaf pmd/pud)
Merging arm-soc-fixes/arm/fixes (0d6a10dc2b97 Merge tag 'imx-fixes-6.1-2' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fix=
es)
Merging davinci-current/davinci/for-current (9abf2313adc1 Linux 6.1-rc1)
Merging drivers-memory-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED =
as BI_RNG_SEED)
Merging powerpc-fixes/fixes (eb761a1760bf powerpc: Fix writable sections be=
ing moved into the rodata region)
Merging s390-fixes/fixes (e3c11025bcd2 s390: avoid using global register fo=
r current_stack_pointer)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (7cef6b73fba9 macsec: Fix invalid error code set)
Merging bpf/master (6f04180ca64b Merge branch 'libbpf: Fixes for ring buffe=
r')
Merging ipsec/master (8947f5eba24e xfrm: Fix ignored return value in xfrm6_=
init())
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (91018bbcc664 Merge tag 'wireless-2022-11-03' of =
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless)
Merging rdma-fixes/for-rc (094226ad94f4 Linux 6.1-rc5)
Merging sound-current/for-linus (05530ef7cf7c ALSA: seq: Fix function proto=
type mismatch in snd_seq_expand_var_event)
Merging sound-asoc-fixes/for-linus (f5f8ad3fcdc4 ASoC: SOF: dai: move AMD_H=
S to end of list to restore backwards-compatibility)
Merging regmap-fixes/for-linus (84498d1fb35d regmap-irq: Use the new num_co=
nfig_regs property in regmap_add_irq_chip_fwnode)
Merging regulator-fixes/for-linus (a9d7897f3364 Merge remote-tracking branc=
h 'regulator/for-6.0' into regulator-linus)
Merging spi-fixes/for-linus (23cf6bdf194a Merge remote-tracking branch 'spi=
/for-6.0' into spi-linus)
Merging pci-current/for-linus (ac9ccce8717d MAINTAINERS: Include PCI bindin=
gs in host bridge entry)
Merging driver-core.current/driver-core-linus (894909f95aa1 Merge tag 'x86_=
urgent_for_v6.1_rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/t=
ip)
Merging tty.current/tty-linus (894909f95aa1 Merge tag 'x86_urgent_for_v6.1_=
rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging usb.current/usb-linus (894909f95aa1 Merge tag 'x86_urgent_for_v6.1_=
rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (c1547f12df8b USB: serial: option: add u=
-blox LARA-L6 modem)
Merging phy/fixes (819b885cd886 phy: ralink: mt7621-pci: add sentinel to qu=
irks table)
Merging staging.current/staging-linus (894909f95aa1 Merge tag 'x86_urgent_f=
or_v6.1_rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging iio-fixes/fixes-togreg (86fdd15e10e4 iio: fix memory leak in iio_de=
vice_register_eventset())
Merging counter-current/counter-current (30a0b95b1335 Linux 6.1-rc3)
Merging char-misc.current/char-misc-linus (894909f95aa1 Merge tag 'x86_urge=
nt_for_v6.1_rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging soundwire-fixes/fixes (49a467310dc4 soundwire: qcom: check for outa=
nding writes before doing a read)
Merging thunderbolt-fixes/fixes (094226ad94f4 Linux 6.1-rc5)
Merging input-current/for-linus (81cd7e848927 Input: i8042 - fix leaking of=
 platform device on module removal)
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
Merging backlight-fixes/for-backlight-fixes (6dfad94814c7 dt-bindings: back=
light: qcom-wled: Add PMI8950 compatible)
Merging mtd-fixes/mtd/fixes (c717b9b7d6de mtd: onenand: omap2: add dependen=
cy on GPMC)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (de547896aac6 media: vivid.rst: loop_video is s=
et on the capture devnode)
Merging reset-fixes/reset/fixes (ae358d71d462 reset: npcm: fix iprst2 and i=
prst4 setting)
Merging mips-fixes/mips-fixes (094226ad94f4 Linux 6.1-rc5)
Merging at91-fixes/at91-fixes (40a2226e8bfa ARM: dts: at91: sam9g20ek: enab=
le udc vbus gpio pinctrl)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (6d3085e4d89a KVM: x86/mmu: Block all page faults =
during kvm_zap_gfn_range())
Merging kvms390-fixes/master (b6662e377727 KVM: s390: pci: Fix allocation s=
ize of aift kzdev elements)
Merging hwmon-fixes/hwmon (595fc93c64f8 hwmon: (coretemp) fix pci device re=
fcount leak in nv1a_ram_new())
Merging nvdimm-fixes/libnvdimm-fixes (b3bbcc5d1da1 Merge branch 'for-6.0/da=
x' into libnvdimm-fixes)
Merging cxl-fixes/fixes (8f401ec1c897 cxl/region: Recycle region ids)
Merging btrfs-fixes/next-fixes (46f159e1491a Merge branch 'misc-6.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (406c706c7b7f vfs: vfs_tmpfile: ensure O_EXCL flag =
is enforced)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (b44fd994e451 platform/x86: ideapad-laptop:=
 Add module parameters to match DMI quirk tables)
Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging devicetree-fixes/dt/linus (917c362b5f8a MAINTAINERS: of: collapse o=
verlay entry into main device tree entry)
Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging scsi-fixes/fixes (f014165faa7b scsi: iscsi: Fix possible memory lea=
k when device_register() failed)
Merging drm-fixes/drm-fixes (b1010b93fe90 Merge tag 'drm/tegra/for-6.1-rc6'=
 of https://gitlab.freedesktop.org/drm/tegra into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (4f68332b2f89 drm/i915/ttm: fi=
x uaf with lmem_userfault_list handling)
Merging mmc-fixes/fixes (489d144563f2 mmc: core: Fix ambiguous TRIM and DIS=
CARD arg)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
Merging gnss-fixes/gnss-linus (247f34f7b803 Linux 6.1-rc2)
Merging hyperv-fixes/hyperv-fixes (c234ba804292 PCI: hv: Only reuse existin=
g IRTE allocation for Multi-MSI)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (fcae44fd36d0 RISC-V: vdso: Do not add missing s=
ymbols to version section in linker script)
Merging riscv-dt-fixes/riscv-dt-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging spdx/spdx-linus (6cad1ecd4e32 testing: use the copyleft-next-0.3.1 =
SPDX tag)
Merging gpio-brgl-fixes/gpio/for-current (30a0b95b1335 Linux 6.1-rc3)
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
Merging cel-fixes/for-rc (5a01c805441b NFSD: Fix trace_nfsd_fh_verify_err()=
 crasher)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (94d957ae513f perf tools: Add the include/=
perf/ directory to .gitignore)
Merging efi-fixes/urgent (9b9eaee9828f arm64: efi: Fix handling of misalign=
ed runtime regions and drop warning)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (767e684367e4 power: supply: ab8500: Defer ther=
mal zone probe)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (30a0b95b1335 Linux 6.1-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (c19083c72ea7 dma-buf: Use dma_=
fence_unwrap_for_each when importing fences)
Merging kbuild/for-next (2df76606db9d Merge tag 'kbuild-fixes-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (63a3bf5e8d9e libperf: Add missing 'struct perf_cpu_=
map' forward declaration to perf/cpumap.h)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (8d58aa484920 swiotlb: reduce the swiotlb buff=
er size on allocation failure)
Merging asm-generic/master (defbab270d45 include/uapi/linux/swab: Fix poten=
tially missing __always_inline)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (a893cdeb4f7c Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (2ed6cab9589d Merge branches 'for-next/acpi', '=
for-next/asm-const', 'for-next/cpufeature', 'for-next/dynamic-scs', 'for-ne=
xt/errata', 'for-next/fpsimd', 'for-next/ftrace', 'for-next/insn', 'for-nex=
t/kbuild', 'for-next/kdump', 'for-next/mm', 'for-next/perf', 'for-next/self=
tests', 'for-next/stacks', 'for-next/trivial', 'for-next/uaccess' and 'for-=
next/undef-traps' into for-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (dee829332025 Merge branch 'arm/fixes' into for-ne=
xt)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (d0f68bca64e6 Merge branch 'v6.2/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (56fed763f6b2 arm64: dts: apple: Add A=
DMAC resets on t8103/t600x)
Merging aspeed/for-next (45c86167adde soc: nuvoton: Add SoC info driver for=
 WPCM450)
Merging at91/at91-next (ecdb99be14fa Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (64610429f8de Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (53ad523ac435 ARM: davinci: fix repeated w=
ords in comments)
Merging drivers-memory/for-next (8dd7e4af5853 memory: omap-gpmc: fix coveri=
ty issue "Control flow issues")
Merging imx-mxs/for-next (e114f7b74f59 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (8886777f958a Merge branch 'v6.1-next/soc' into f=
or-next)
Merging mvebu/for-next (d5c48679d56c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (b610ba9a796a Merge branch 'omap-for-v6.2/dt' into fo=
r-next)
Merging qcom/for-next (4d2b529bce12 Merge branches 'arm64-defconfig-for-6.2=
', 'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2', 'drivers-for-6.2', =
'dts-for-6.2' and 'arm64-fixes-for-6.1' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (b905b8e5fc04 Merge branches 'renesas-arm-defconfig-fo=
r-v6.2' and 'renesas-arm-dt-for-v6.2' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (a59b9360b072 Merge branch 'v6.2-clock/next' into=
 for-next)
Merging samsung-krzk/for-next (5a549e2d0bab Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (25882cfe4a6b Merge branch 'for-next/juno' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (4cca342b840e ARM: dts: stm32: Rename mdio0 to mdi=
o on DHCOR Testbench board)
Merging sunxi/sunxi/for-next (47be7c123211 Merge branch 'sunxi/clk-for-6.2'=
 into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (ad797481d176 Merge branch for-6.2/arm64/defconfig i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging ti/ti-next (578f5f9663a4 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (5eeec1fd8360 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging clk-renesas/renesas-clk (777bcc85e1fb clk: renesas: r8a779f0: Fix E=
thernet Switch clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (7e2004906fb5 Revert "csky: Add support for restart=
able sequence")
Merging loongarch/loongarch-next (247f34f7b803 Linux 6.1-rc2)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (094226ad94f4 Linux 6.1-rc5)
Merging microblaze/next (493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-fo=
r-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-nam=
espace)
Merging mips/mips-next (094226ad94f4 Linux 6.1-rc5)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (a3abf3070cfb parisc: led: Fix potential null-pt=
r-deref in start_task())
Merging powerpc/next (247f34f7b803 Linux 6.1-rc2)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (effae0e3d9e1 riscv: Kconfig: Enable cpufreq kconfi=
g menu)
Merging riscv-dt/riscv-dt-for-next (4563db4b7988 Merge branch 'riscv-thead_=
c9xx' into riscv-dt-for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ris=
cv/cpus.yaml
Merging riscv-soc/riscv-soc-for-next (8fbf94fea0b4 soc: sifive: ccache: fix=
 missing of_node_put() in sifive_ccache_init())
Merging s390/for-next (1b4a632248b3 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/next (193cb8372424 uml: Remove the initialization of statics to=
 0)
Merging xtensa/xtensa-for-next (b8c4f4db2436 xtensa: update config files)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (c0192a847c96 Merge branch 'fs.acl.rework' i=
nto for-next)
Merging fscrypt/master (02aef4225258 fscrypt: pass super_block to fscrypt_p=
ut_master_key_activeref())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (50dc36ec61e2 afs: Stop implementing ->writepage())
Merging btrfs/for-next (d9fdb1cf2db1 Merge branch 'for-next-next-v6.1-20221=
111' into for-next-20221111)
CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
Applying: btrfs: fix up for "fs: pass dentry to set acl method"
Merging ceph/master (5bd76b8de5b7 ceph: fix NULL pointer dereference for re=
q->r_session)
Merging cifs/for-next (4217458b1ea8 cifs: Fix OOB read in parse_server_inte=
rfaces())
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (312fe643ad11 erofs: clean up erofs_iget())
Merging exfat/dev (3d0cdf1b32dc exfat: hint the empty entry which at the en=
d of cluster chain)
Merging ext3/for_next (0327e0ff8296 Pull kerneldoc warning fix.)
Merging ext4/dev (0d043351e5ba ext4: fix fortify warning in fs/ext4/fast_co=
mmit.c:1551)
Merging f2fs/dev (967eaad1fed5 f2fs: fix to set flush_merge opt and show no=
flush_merge)
Merging fsverity/fsverity (276616fff35d fsverity: stop using PG_error to tr=
ack error status)
Merging fuse/for-next (cbed990fb813 fuse: Rearrange fuse_allow_current_proc=
ess checks)
Merging gfs2/for-next (288fc8606762 Merge tag 'gfs2-nopid-for-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (5e40d197b564 ksmbd: use F_SETLK when unlockin=
g a file)
Merging nfs/linux-next (094226ad94f4 Linux 6.1-rc5)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (228597fae37c NFSD: add CB_RECALL_ANY tracepoints)
Merging ntfs3/master (36963cf225f8 fs/ntfs3: Make if more readable)
CONFLICT (content): Merge conflict in fs/ntfs3/bitmap.c
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Applying: fix up for "fs: rename current get acl method"
Merging orangefs/for-next (2ad4b6f5e117 Orangefs: change iterate to iterate=
_shared)
Merging overlayfs/overlayfs-next (b337e5ae0e42 ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (669d204469c4 ubi: fastmap: Add fastmap control support =
for 'UBI_IOCATT' ioctl)
Merging v9fs/9p-next (ebd09c8245aa 9p/xen: check logical size for buffer si=
ze)
Merging xfs/for-next (64c80dfd04d1 xfs: Print XFS UUID on mount and umount =
events.)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (f1bd37a47352 iomap: directly use logical bloc=
k size)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (0513283941f6 Add process name and pid to loc=
ks warning)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (3aca47127a64 fs: drop useless condition from inode_ne=
eds_update_time)
Merging printk/for-next (fdcd6d5311fa Merge branch 'rework/console-list-loc=
k' into for-next)
$ git reset --hard HEAD^
Merging next-20221118 version of printk
Merging pci/next (0a9dc1e9365b Merge branch 'pci/kbuild')
Merging pstore/for-next/pstore (38b91847c314 pstore: Alert on backend write=
 error)
Merging hid/for-next (afd050b81385 Merge branch 'for-6.2/sony' into for-nex=
t)
Merging i2c/i2c/for-next (ee98d665b461 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (2c71b3246ec3 hwmon: (gsc-hwmon) Switch to=
 flexible array to simplify code)
Merging jc_docs/docs-next (83a8fd24e609 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (1e284ea984d3 Merge git://linuxtv.org/sailus/media_t=
ree into media_stage)
Merging v4l-dvb-next/master (a7bab6f8b73f Merge tag 'br-v6.2e' of git://lin=
uxtv.org/hverkuil/media_tree into media_stage)
Merging pm/linux-next (17c15ec1ead8 Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (9901c21bcaf2 cpufreq: qcom-hw: =
Fix memory leak in qcom_cpufreq_hw_read_lut())
Merging cpupower/cpupower (9abf2313adc1 Linux 6.1-rc1)
Merging devfreq/devfreq-next (5fdded844892 PM/devfreq: governor: Add a priv=
ate governor_data for governor)
Merging opp/opp/linux-next (dba79b78ecc1 dt-bindings: opp-v2: Fix clock-lat=
ency-ns prop in example)
Merging thermal/thermal/linux-next (9d2bc364f677 thermal/drivers/qcom/tsens=
: Simplify debugfs init function)
CONFLICT (content): Merge conflict in drivers/thermal/thermal_sysfs.c
$ git merge --abort
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (775af207464b fs: dlm: use WARN_ON_ONCE() instead of WARN_=
ON())
Merging rdma/for-next (34a046f08b62 RDMA/rtrs-srv: Remove kobject_del from =
rtrs_srv_destroy_once_sysfs_root_folders)
Merging net-next/master (8bd8dcc5e47f net: ethernet: mediatek: ppe: assign =
per-port queues for offloaded traffic)
CONFLICT (content): Merge conflict in tools/perf/util/stat.c
Applying: Revert "tcp: Add listening address to SYN flood message"
CONFLICT (content): Merge conflict in net/ipv4/tcp_input.c
Patch failed at 0001 Revert "tcp: Add listening address to SYN flood messag=
e"
Merging bpf-next/for-next (35ffb1d9bff0 Merge branch 'clean-up bpftool from=
 legacy support')
CONFLICT (content): Merge conflict in include/linux/bpf.h
CONFLICT (content): Merge conflict in tools/lib/bpf/ringbuf.c
Merging ipsec-next/master (cc2bbbfd9a50 xfrm: Remove not-used total variabl=
e)
Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (c3fd63f7fe5a Bluetooth: silence a dmesg error mes=
sage in hci_request.c)
Merging wireless-next/for-next (8cf4f8c7d99a Merge tag 'rxrpc-next-20221116=
' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs)
Merging mtd/mtd/next (085679b15b5a mtd: parsers: refer to ARCH_BCMBCA inste=
ad of ARCH_BCM4908)
Merging nand/nand/next (c13bf589e5cf mtd: rawnand: marvell: Enable NFC/DEVB=
US arbiter)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/brcm,brcmnand.yaml
Merging spi-nor/spi-nor/next (bb0e9c600ce2 mtd: spi-nor: core: Add an error=
 message when failing to exit the 4-byte address mode)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/jedec,spi-nor.yaml
Merging crypto/master (75df46b598b5 crypto: hisilicon/sec - remove continuo=
us blank lines)
Merging drm/drm-next (4e291f2f5853 Merge tag 'drm-misc-next-2022-11-10-1' o=
f git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_job=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n321/dcn321_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/di=
splay_mode_structs.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dd=
i.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.c
CONFLICT (add/add): Merge conflict in drivers/gpu/drm/i915/display/intel_dk=
l_phy.c
CONFLICT (add/add): Merge conflict in drivers/gpu/drm/i915/display/intel_dk=
l_phy.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
ll_mgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_lv=
ds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_sd=
vo.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gem/i915_gem_dma=
buf.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/rcar-du/Kconfig
CONFLICT (content): Merge conflict in drivers/gpu/drm/scheduler/sched_entit=
y.c
Merging drm-misc/for-linux-next (e3ddd2d25533 Revert "drm/fb-helper: Perfor=
m damage handling in deferred-I/O helper")
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_hdmi.c
Merging amdgpu/drm-next (aec3bb3a01de drm/amdgpu: make psp_ring_init common)
CONFLICT (content): Merge conflict in include/drm/gpu_scheduler.h
Merging drm-intel/for-linux-next (f322ed0d76ef drm/i915/dvo: Use per device=
 debugs)
Merging drm-tegra/for-next (1eb336ed12cd gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (d73b1d02de08 drm/msm: Hangcheck progress detectio=
n)
Merging drm-msm-lumag/msm-next-lumag (ee417928fe0a Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi' and 'msm-next-lumag-mdp5' into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (a3b4c2f9b039 drm/etnaviv: switch to PFN mappi=
ngs)
Merging fbdev/for-next (55b68e63ab2c fbdev: matroxfb: Convert to i2c's .pro=
be_new())
Merging regmap/for-next (84498d1fb35d regmap-irq: Use the new num_config_re=
gs property in regmap_add_irq_chip_fwnode)
Merging sound/for-next (1cf47b044acd ALSA: ppc: keywest: Convert to i2c's .=
probe_new())
Merging sound-asoc/for-next (37ed0f6be09e Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-next)
Merging modules/modules-next (c86a514f5fad kallsyms: Remove unneeded semico=
lon)
Merging input/next (b76f64caa42e Input: max8997 - convert to modern way to =
get a reference to a PWM)
Merging block/for-next (40fa774af7fd Merge branch 'for-6.2/io_uring' into f=
or-next)
CONFLICT (content): Merge conflict in io_uring/net.c
Merging device-mapper/for-next (984bf2cc531e dm integrity: clear the journa=
l on suspend)
Merging libata/for-next (3d8a3ae3d966 ata: libata: fix commands incorrectly=
 not getting retried during NCQ error)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (b95b1620f447 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (2c9918463543 mfd: tc6393xb: Remove #ifdef guards =
for PM related functions)
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (922bde5a0955 power: supply: z2_battery: Convert t=
o i2c's .probe_new())
Merging regulator/for-next (ad2bb56a85cb Merge remote-tracking branch 'regu=
lator/for-6.2' into regulator-next)
Merging security/next (f6fbd8cbf3ed lsm,fs: fix vfs_getxattr_alloc() return=
 type and caller error paths)
CONFLICT (content): Merge conflict in security/commoncap.c
Merging apparmor/apparmor-next (4295c60bbe9e apparmor: Fix uninitialized sy=
mbol 'array_size' in policy_unpack_test.c)
CONFLICT (content): Merge conflict in security/apparmor/domain.c
Merging integrity/next-integrity (25369175ce84 ima: Fix misuse of dereferen=
ce of pointer in template_desc_init_fields())
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
Merging tomoyo/master (88ba4e14d341 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (fd6628650d1a KEYS: trusted: tee: Make registered shm de=
pendency explicit)
Merging watchdog/master (9ec0b7e06835 watchdog: aspeed: Enable pre-timeout =
interrupt)
Merging iommu/next (d3dbd9c2a0a4 Merge branches 'iommu/fixes', 'arm/allwinn=
er', 'arm/exynos', 'arm/mediatek', 'arm/rockchip', 'ppc/pamu', 's390', 'x86=
/amd' and 'core' into next)
Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode_=
name(), syscall()})
Merging devicetree/for-next (5f431a92028b dt-bindings: Drop type from 'cpus=
' property)
Merging dt-krzk/for-next (043d4036e8ee Merge branch 'next/dt' into for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (d86d298f31fa Merge remote-tracking branch 'spi/for-6.=
2' into spi-next)
Merging tip/master (15ce088a8698 Merge x86/microcode into tip/master)
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
CONFLICT (modify/delete): drivers/iommu/iommu-sva-lib.c deleted in HEAD and=
 modified in tip/master.  Version tip/master of drivers/iommu/iommu-sva-lib=
.c left in tree.
CONFLICT (content): Merge conflict in drivers/pci/controller/Kconfig
CONFLICT (content): Merge conflict in drivers/pci/controller/dwc/Kconfig
CONFLICT (content): Merge conflict in drivers/pci/controller/mobiveil/Kconf=
ig
$ git rm -f drivers/iommu/iommu-sva-lib.c
Applying: fix up for "iommu: Rename iommu-sva-lib.{c,h}"
Merging clockevents/timers/drivers/next (af246cc6d0ed clocksource/drivers/a=
rm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value)
Merging edac/edac-for-next (b998a2babf4e Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (732d69c80cb0 Merge branch irq/misc-6.1 in=
to irq/irqchip-next)
Merging ftrace/for-next (0934ae9977c2 tracing: Fix reading strings from syn=
thetic events)
Merging rcu/rcu/next (875c6ddbe1c7 tools: memory-model: Add rmw-sequences t=
o the LKMM)
Merging kvm/next (d72cf8ffe460 Merge tag 'kvm-s390-master-6.1-1' of https:/=
/git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (0981abb32a04 Merge branch kvm-arm64/pmu-unchained int=
o kvmarm-master/next)
Merging kvms390/next (89204d8846ed KVM: s390: pv: module parameter to fence=
 asynchronous destroy)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Merging xen-tip/linux-next (4abb77fc5531 xen/platform-pci: use define inste=
ad of literal number)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (f32e02417614 platform/x86: ideapad-laptop: su=
pport for more special keys in WMI)
Merging chrome-platform/for-next (f9e510dc92df platform/chrome: cros_ec: Co=
nvert to i2c's .probe_new())
Merging hsi/for-next (8acbca3a92b8 headers: Remove some left-over license t=
ext in include/uapi/linux/hsi/)
Merging leds/for-next (5f52a8ba7e91 dt-bindings: leds: Add 'cpuX' to 'linux=
,default-trigger')
Merging ipmi/for-next (0eb1762f3c77 ipmi/watchdog: Include <linux/kstrtox.h=
> when appropriate)
Merging driver-core/driver-core-next (1d926e259d8f vmlinux.lds.h: add HEADE=
RED_SECTION_* macros)
Merging usb/usb-next (dd65a243a915 usb/usbip: Fix v_recv_cmd_submit() to us=
e PIPE_BULK define)
Merging thunderbolt/next (a5cfc9d65879 thunderbolt: Add wake on connect/dis=
connect on USB4 ports)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (247f34f7b803 Linux 6.1-rc2)
Merging tty/tty-next (a3be423f0657 tty: n_gsm: Delete unneeded semicolon)
Merging char-misc/char-misc-next (e8433659bf70 Revert "drivers: bus: simple=
-pm-bus: Use clocks")
Merging coresight/next (3c728e079d83 coresight: etm4x: add CPU hotplug supp=
ort for probing)
Merging fpga/for-next (ee31d5038c06 dt-bindings: fpga: document Lattice sys=
CONFIG FPGA manager)
Merging icc/icc-next (26e90ec7a840 Merge branch 'icc-sc8280xp-l3' into icc-=
next)
Merging iio/togreg (021882de1a48 iio: pressure: bmp280: convert to i2c's .p=
robe_new())
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/addac/adi,ad74413r.yaml
Merging phy-next/next (742859441d44 phy: renesas: Add Renesas Ethernet SERD=
ES driver for R-Car S4-8)
Merging soundwire/next (febc50b82bc9 dt-bindings: soundwire: Convert text b=
indings to DT Schema)
Merging extcon/extcon-next (de05153ffce5 extcon: usbc-tusb320: Convert to i=
2c's .probe_new())
Merging gnss/gnss-next (247f34f7b803 Linux 6.1-rc2)
Merging vfio/next (2f5d8cef45c3 vfio/mlx5: Fix a typo in mlx5vf_cmd_load_vh=
ca_state())
Merging staging/staging-next (ccdbe14b77a5 staging: rtl8192e: Rename pHTInf=
o)
Merging counter-next/counter-next (30a0b95b1335 Linux 6.1-rc3)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (3a0c95b61385 dmaengine: tegra: Add support for dma-=
channel-mask)
Merging cgroup/for-next (79a7f41f7f5a cgroup: cgroup refcnt functions shoul=
d be exported when CONFIG_DEBUG_CGROUP_REF)
Merging scsi/for-next (6f1be50a0e3d Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (ae8011fe076d scsi: target: core: Change the way =
target_xcopy_do_work() sets restiction on max I/O)
Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
Merging rpmsg/for-next (38e723045f68 Merge branches 'rproc-next' and 'hwspi=
nlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (40059212f99c dt-bindings: gpio: gpio-davin=
ci: Increase maxItems in gpio-line-names)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging gpio-intel/for-next (8d259847243d gpiolib: cdev: Fix typo in kernel=
 doc for struct line)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (b6b904083dfc Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging pinctrl-intel/for-next (b14ef61314b3 pinctrl: intel: Add Intel Moor=
efield pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (80d34260f36c pinctrl: renesas: gpi=
o: Use dynamic GPIO base if no function GPIOs)
Merging pinctrl-samsung/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging pwm/for-next (bf22908680cc pwm: tegra: Ensure the clock rate is not=
 less than needed)
Merging userns/for-next (b5df013cd194 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, retire_mq_sys=
ctls-for-v5.19, and unpriv-ipc-sysctls-for-v6.2 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (2dfb010d2aaf cpufreq: amd-pstate: fix spdxcheck war=
nings for amd-pstate-ut.c)
Merging kunit/test (9abf2313adc1 Linux 6.1-rc1)
Merging kunit-next/kunit (870f63b7cd78 kunit: eliminate KUNIT_INIT_*_ASSERT=
_STRUCT macros)
CONFLICT (content): Merge conflict in lib/kunit/string-stream.c
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (a6ceee26fd5e rtc: pcf85063: Fix reading alarm)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging ntb/ntb-next (1a3f7484e076 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (4e92863862d1 Merge branch 'for-linus/secc=
omp' into for-next/seccomp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (371fcbd32b26 dt-bindings: slimbus: qcom,slim-ngd:=
 convert to DT schema)
Merging nvmem/for-next (18133a57a935 dt-bindings: nvmem: add YAML schema fo=
r the ONIE tlv layout)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (0b90efa6ca81 clocksource: hyper-v: Add TSC page=
 support for root partition)
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
Merging cxl/next (3b39fd6cf12c cxl: Replace HDM decoder granularity magic n=
umbers)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (196dff2712ca efi: random: combine bootloader provided RNG=
 seed with RNG protocol output)
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/Makefile
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (8f17b4988138 Merge branch 'slab/for-6.2/kmalloc_redz=
one' into slab/for-next)
Merging random/master (9148de3196ed random: reseed in delayed work rather t=
han on-demand)
Merging landlock/next (0b4ab8cd635e Merge tag 'landlock-6.1-rc4' into landl=
ock-next)
Merging rust/rust-next (fd9517a1603f init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
Merging execve/for-next/execve (cd57e443831d exec: Remove FOLL_FORCE for st=
ack setup)
Merging bitmap/bitmap-for-next (27bc50fc9064 Merge tag 'mm-stable-2022-10-0=
8' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging hte/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging kspp/for-next/kspp (0ad811cc08a9 drm/sti: Fix return type of sti_{d=
vo,hda,hdmi}_connector_mode_valid())
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging unsigned-char/unsigned-char (0445d1bae1cc lib: assume char is unsig=
ned)
Merging iommufd/for-next (57f62422b6f0 Merge remote-tracking branch 'linus/=
master' into k.o-iommufd/for-next)
Merging mm-stable/mm-stable (ea0ffd0c08d0 swap: add a limit for readahead p=
age-cluster value)
CONFLICT (content): Merge conflict in mm/hugetlb.c
Merging mm-nonmm-stable/mm-nonmm-stable (7b9cbc7701d5 scripts/spelling.txt:=
 add more spellings to spelling.txt)
Merging mm/mm-everything (ebb7f740fdeb Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/gup.c
CONFLICT (content): Merge conflict in mm/huge_memory.c

--Sig_/KHo8gYl1sG0FAnI_pNTaLpW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN7NuQACgkQAVBC80lX
0GyKYggAh++Q5pfLQj/VAb9YAFyC7B9umE/bRJ/j4pzpiCUf2KJsx4Fp6CRtxwnh
Nm7MKYGO150awQVctJoJuNpBwYgvmel9pQgJ89oO1zW16gh/nESmU7kOpF3n2BUY
g4hpnnB4Kq/Q3V2q5OeRbJiUmsy0Exlq2SkHoLKuv5ZHhz1zqKAZvoE682C0lKFK
ZZaQEQWE63Pt9QFvPnPO/03AwwOBkg+OgRxBcyEJ81bK8cVz2cH/ldzDrCdChJkN
iredb3hRCIb0+dl+d2Fto4ougrKWv1mbDg1L1d0Oai2DD59GVpbrfzMlKIeYiAkZ
3L/OWqmgumlCcMFr2AFgVCPWXYyOiQ==
=b0XR
-----END PGP SIGNATURE-----

--Sig_/KHo8gYl1sG0FAnI_pNTaLpW--
