Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BAC67493D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjATCOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjATCOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:14:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC2D9F077;
        Thu, 19 Jan 2023 18:14:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NyjjV1QMQz4xxJ;
        Fri, 20 Jan 2023 13:14:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674180846;
        bh=wv4NSZ1JUcXNbyyuIRUNAq/uHiy+L7GMPU+d4d1Pusc=;
        h=Date:From:To:Cc:Subject:From;
        b=E4aC/jQStO/ve+42BjISiHbDB7oS9JLEBypOUHus/ZPiImwNbJKJ0K7ufQv8SuDo3
         Dc/OvYTKL2KcOG610OeTFxV7rRTQi/kdolmtHJQCRbv06LT/CrWCGcTayQ9YzyY4yc
         JufqHBtG88UmSwV4cwXZaT984tjSmdILfsIwaZFxqYVNxJPaImpAy3N546hP0wB2eb
         u5sA+hANDiGmKRoxCZaApxpuqjwJKW/3JgG6wHYUxiYqMPyLRURjhlgwjSJgT5NioG
         9k/G6oOsbC0nbKqhdbIwc2zrBLOe74P5TWLbXOaSCY+0pZ6t6Y3zTbUj6rKCzzT6Nb
         nGG9IxompypTg==
Date:   Fri, 20 Jan 2023 13:14:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 20
Message-ID: <20230120131405.27ca716d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n.euDGwv4xG4bia3n+ipR2v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n.euDGwv4xG4bia3n+ipR2v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230119:

New tree: kvm-x86

The tty.current tree gained a build failure so I used the version
from next-20230119.

The devicetree-fixes tree lost its build failure.

The vfs-idmapping tree lost its build failure.

The block tree gained a semantic conflict against the vfs-idmapping tree.

The kvm-x86 tree gained a conflict against the tip tree.

The accel tree gained a conflict against the drm-misc tree.

Non-merge commits (relative to Linus' tree): 6118
 6995 files changed, 255893 insertions(+), 278816 deletions(-)

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

I am currently merging 355 trees (counting Linus' and 99 trees of bug
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
Merging origin/master (d368967cb103 Merge tag 'printk-for-6.2-rc5' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/printk/linux)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (89c08deebe0a mm-mremap-fix-mremap=
-expanding-for-vmas-with-vm_ops-close-checkpatch-fixes)
Merging kbuild-current/fixes (13e1df09284d kheaders: explicitly validate ex=
istence of cpio command)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (3cb0f23039e0 ARM: 9284/1: include <asm/pgtable.h=
> from proc-macros.S to fix -Wundef warnings)
Merging arm64-fixes/for-next/fixes (68a63a412d18 arm64: Fix build with CC=
=3Dclang, CONFIG_FTRACE=3Dy and CONFIG_STACK_TRACER=3Dy)
Merging arm-soc-fixes/arm/fixes (e2f7096f1e76 Merge tag 'riscv-dt-fixes-for=
-v6.2-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux i=
nto arm/fixes)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (553b20b211c4 m68k: defconfig: Update defcon=
figs for v6.1-rc1)
Merging powerpc-fixes/fixes (f12cd06109f4 powerpc/64s/hash: Make stress_hpt=
_timer_fn() static)
Merging s390-fixes/fixes (41e1992665a2 s390: workaround invalid gcc-11 out =
of bounds read warning)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (6c977c5c2e4c net: dsa: microchip: ksz9477: port map cor=
rection in ALU table entry register)
Merging bpf/master (bdb7fdb0aca8 bpf: Fix a possible task gone issue with b=
pf_send_signal[_thread]() helpers)
Merging ipsec/master (eb6c59b735aa xfrm: compat: change expression for swit=
ch in xfrm_xlate64)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (c410cb974f2b netfilter: conntrack: handle tcp challeng=
e acks during connection reuse)
Merging wireless/for-next (80f8a66dede0 Revert "wifi: mac80211: fix memory =
leak in ieee80211_if_add()")
Merging rdma-fixes/for-rc (0f097f08c9b3 lib/scatterlist: Fix to calculate t=
he last_pg properly)
Merging sound-current/for-linus (b9cee506da2b ALSA: hda/via: Avoid potentia=
l array out-of-bound in add_secret_dac_path())
Merging sound-asoc-fixes/for-linus (c1619ea22d95 ASoC: SOF: sof-audio: Fixe=
s for widget prepare and)
Merging regmap-fixes/for-linus (1b929c02afd3 Linux 6.2-rc1)
Merging regulator-fixes/for-linus (f528fe213a6a regulator: qcom-rpmh: PM855=
0 ldo11 regulator is an nldo)
Merging spi-fixes/for-linus (9bab63a3e949 spi: spidev: fix a recursive lock=
ing error)
Merging pci-current/for-linus (1b929c02afd3 Linux 6.2-rc1)
Merging driver-core.current/driver-core-linus (9be182da0a75 driver core: Fi=
x test_async_probe_init saves device in wrong array)
Merging tty.current/tty-linus (5342ab0af450 tty: serial: qcom_geni: avoid d=
uplicate struct member init)
$ git reset --hard HEAD^
Merging next-20230119 version of tty.current
Merging usb.current/usb-linus (dcbf1742ed10 Merge tag 'usb-serial-6.2-rc5' =
of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into us=
b-linus)
Merging usb-serial-fixes/usb-linus (71dfd381a7c0 USB: serial: option: add Q=
uectel EM05CN modem)
Merging phy/fixes (bc30c15f2754 phy: phy-can-transceiver: Skip warning if n=
o "max-bitrate")
Merging staging.current/staging-linus (7d83299351fe staging: vchiq_arm: fix=
 enum vchiq_status return types)
Merging iio-fixes/fixes-togreg (eb50cd5bfdac iio: hid: fix the retval in gy=
ro_3d_capture_sample)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (36225a7c72e9 w1: fix WARNING aft=
er calling w1_process())
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
Merging modules-fixes/modules-linus (da35048f2600 kallsyms: Fix scheduling =
with interrupts disabled in self-test)
Merging dmaengine-fixes/fixes (95e5fda3b5f9 ptdma: pt_core_execute_cmd() sh=
ould use spinlock)
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
Merging btrfs-fixes/next-fixes (17e71b26b929 Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (9c7417b5ec44 coredump: Move dump_emit_page() to ki=
ll unused warning)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (fde5f74ccfc7 platform/x86: thinkpad_acpi: =
Fix profile mode display in AMT mode)
Merging samsung-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (064e32dc5b03 of: fdt: Honor CONFIG_CMDLI=
NE* even without /chosen node, take 2)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (0bfe63d07578 scsi: device_handler: alua: Remove a=
 might_sleep() annotation)
Merging drm-fixes/drm-fixes (e695bc7e5423 Merge tag 'drm-msm-fixes-2023-01-=
12' of https://gitlab.freedesktop.org/drm/msm into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (afdecb232740 drm/i915/dg2: In=
troduce Wa_18019271663)
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
Merging spdx/spdx-linus (5dc4c995db9e Linux 6.2-rc4)
Merging gpio-brgl-fixes/gpio/for-current (4cb786180dfb gpiolib: acpi: Add a=
 ignore wakeup quirk for Clevo NL5xRU)
Merging gpio-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging erofs-fixes/fixes (e02ac3e7329f erofs: clean up parsing of fscache =
related options)
Merging kunit-fixes/kunit-fixes (88603b6dc419 Linux 6.2-rc2)
Merging ubifs-fixes/fixes (7bdd6967fec5 ubi: ensure that VID header offset =
+ VID header size <=3D alloc, size)
Merging memblock-fixes/fixes (115d9d77bb0f mm: Always release pages to the =
buddy allocator in memblock_free_late().)
Merging nfsd-fixes/nfsd-fixes (7c24fa225081 NFSD: replace delayed_work with=
 work_struct for nfsd_client_shrinker)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (3d9c07c4cfc0 perf test build-id: Fix test=
 check for PE file)
Merging efi-fixes/urgent (e1fabbc83cb1 efi: Remove Matthew Garrett as efiva=
rfs maintainer)
Merging zstd-fixes/zstd-linus (8cbf4bb547b7 lib: zstd: Fix -Wstringop-overf=
low warning)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging rust-fixes/rust-fixes (6618d69aa129 rust: print: avoid evaluating a=
rguments in `pr_*` macros in `unsafe` blocks)
Merging drm-misc-fixes/for-linux-next-fixes (0220e4fe178c drm/i915: Fix a m=
emory leak with reused mmap_offset)
Merging kbuild/for-next (83344be3eb46 kbuild: rust: move rust/target.json t=
o scripts/)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (03953a697bdd perf vendor events intel: Add Emerald =
Rapids)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (3622b86f49f8 dma-mapping: reject GFP_COMP for=
 noncoherent allocations)
Merging asm-generic/master (32975c491ee4 uapi: Add missing _UAPI prefix to =
<asm-generic/types.h> include guard)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (8dac5d145457 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (aaf846bef4e0 Merge branches 'for-next/sysreg',=
 'for-next/sme', 'for-next/kselftest' and 'for-next/misc' into for-next/cor=
e)
Merging arm-perf/for-next/perf (4998897b1e96 perf: arm_spe: Support new SPE=
v1.2/v8.7 'not taken' event)
Merging arm-soc/for-next (f04024276aba Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (d5a00b8562d9 Merge branch 'v6.3/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging aspeed/for-next (701ce17d6429 arm: dts: aspeed: tyan s8036: Enable =
kcs interrupts)
Merging at91/at91-next (dac8e2394ccc Merge branch 'at91-fixes' into at91-ne=
xt)
Merging broadcom/next (0ceda79d227d Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (eaafab7e8e26 MAINTAINERS: make me the mai=
ntainer of DaVinci platforms)
Merging drivers-memory/for-next (13f35b3c72f4 Merge branch 'for-v6.3/renesa=
s-rpc-if' into for-next)
Merging imx-mxs/for-next (beb902cee34c Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (c31242e67f68 Merge branch 'v6.2-next/soc' into f=
or-next)
Merging mvebu/for-next (80502ffab2fa arm64: dts: marvell: AC5/AC5X: Fix add=
ress for UART1)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (97c57426d969 Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-for-6.3' and 'dts-for-6.3' into=
 for-next)
Merging renesas/next (1f57de01e0be Merge branch 'renesas-dts-for-v6.3' into=
 renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (14359f2e99a2 Merge branch 'v6.3-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (4cbfe83f1adc Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (b6651aac2d5b Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (2f33df889e99 ARM: dts: stm32: Use new media bus t=
ype macros)
Merging sunxi/sunxi/for-next (7879da4e62f1 Merge branch 'sunxi/drivers-for-=
6.3' into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (8ed4a4e82113 Merge branch for-6.3/arm64/dt into for=
-next)
Merging ti/ti-next (1b929c02afd3 Linux 6.2-rc1)
Merging xilinx/for-next (a18426505c2b Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (15af773367a8 Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-renesas/renesas-clk (fbfd614aeaa2 clk: renesas: cpg-mssr: Fix u=
se after free if cpg_mssr_common_init() failed)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (5dc4c995db9e Linux 6.2-rc4)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (ccf890f7ad7f m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (5cfe469c2654 microblaze/PCI: Moving PCI iounmap an=
d dependent code)
Merging mips/mips-next (88603b6dc419 Linux 6.2-rc2)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (32125c5c95f2 parisc: Limit amount of kgdb break=
points on parisc)
Merging powerpc/next (53ab112a9508 Merge branch 'fixes' into next)
Merging powerpc-objtool/topic/objtool (1b929c02afd3 Linux 6.2-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (ae4d39f75308 Merge patch "RISC-V: fix incorrect ty=
pe of ARCH_CANAAN_K210_DTB_SOURCE")
CONFLICT (content): Merge conflict in arch/riscv/kernel/probes/simulate-ins=
n.h
Merging riscv-dt/riscv-dt-for-next (093ee97e24f8 Merge tag 'soc2arch-immuta=
ble' into riscv-dt-for-next)
Merging riscv-soc/riscv-soc-for-next (6635e91648ce soc: sifive: ccache: Add=
 StarFive JH7110 support)
Merging s390/for-next (33f34442fd7c Merge branch 'features' into for-next)
Merging uml/next (43ee0357e15b um: vector: Fix memory leak in vector_config)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (2cd08b5469ca Merge branch 'fs.idmapped.mnt_=
idmap.conversion' into for-next)
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
Merging fscrypt/master (41952551acb4 fscrypt: add additional documentation =
for SM4 support)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (92c317b80311 Merge branch 'for-next-next-v6.2-20230=
119' into for-next-20230119)
Merging ceph/master (8e1858710d9a ceph: avoid use-after-free in ceph_fl_rel=
ease_lock())
Merging cifs/for-next (820f62b78692 cifs: account for primary channel in th=
e interface list)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (b7bfaa761d76 Linux 6.2-rc3)
Merging exfat/dev (5742d6a467d1 exfat: handle unreconized benign secondary =
entries)
Merging ext3/for_next (7a5fa171a286 ext2: propagate errors from ext2_prepar=
e_chunk)
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
Merging nfs/linux-next (5dc4c995db9e Linux 6.2-rc4)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/nfsd-next (37e6459693f5 SUNRPC: Fix whitespace damage in svcau=
th_unix.c)
Merging ntfs3/master (57c94236401b fs/ntfs3: Refactoring of various minor i=
ssues)
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
Merging iomap/iomap-for-next (471859f57d42 iomap: Rename page_ops to folio_=
ops)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (c65454a94726 fs: remove locks_inode)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
CONFLICT (content): Merge conflict in fs/stat.c
Merging vfs/for-next (557e0248a8a0 Merge branch 'work.misc' into for-next)
Merging printk/for-next (930348ab0ad9 Merge branch 'rework/buffers-cleanup'=
 into for-next)
Merging pci/next (bb7da376b4fd Merge branch 'remotes/lorenzo/pci/imx6')
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (b1cb3ece45ae Merge branch 'for-6.3/hid-bpf' into for-=
next)
Merging i2c/i2c/for-next (59b3484a571e Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (e826acc18bc7 i3c: transfer pid from boardinfo to devi=
ce info)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (4d891f76a30d dt-bindings: hwmon: correct =
indentation and style in examples)
Merging jc_docs/docs-next (75565c561977 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (6599e683db1b Merge tag 'v6.2-rc1' into media_tree)
Merging v4l-dvb-next/master (d4acfa22b634 media: sun6i-isp: params: Unregis=
ter pending buffer on cleanup)
Merging pm/linux-next (afd822f01cda Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (08f0adb193c0 cpufreq: armada-37=
xx: stop using 0 as NULL pointer)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (93c697b41d14 dt-bindings: opp: v2-qcom-level: L=
et qcom,opp-fuse-level be a 2-long array)
Merging thermal/thermal/linux-next (de8ef0ab026c thermal/drivers/qcom: Remo=
ve duplicate set next trip point interrupt code)
Merging dlm/next (aa7f4a21f6e5 fs/dlm: Remove "select SRCU")
Merging rdma/for-next (1ec82317a1da IB/hfi1: Use dma_mmap_coherent for matc=
hing buffers)
Merging net-next/master (3ef4a8c8963b Merge branch 'net-phy-remove-probe_ca=
pabilities')
CONFLICT (content): Merge conflict in drivers/net/ipa/ipa_interrupt.c
CONFLICT (content): Merge conflict in drivers/net/ipa/ipa_interrupt.h
Merging bpf-next/for-next (92afc5329a5b selftests/bpf: Fix build errors if =
CONFIG_NF_CONNTRACK=3Dm)
Merging ipsec-next/master (7e68dd7d07a2 Merge tag 'net-next-6.2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mlx5-next/mlx5-next (c4d508fbe54a net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (68e5b6aa2795 xdp: document xdp_do_flush() before =
napi_complete_done())
Merging bluetooth/master (7ed38304a633 Bluetooth: Fix possible deadlock in =
rfcomm_sk_state_change)
Merging wireless-next/for-next (4ca69027691a wifi: wireless: deny wireless =
extensions on MLO-capable devices)
Merging mtd/mtd/next (a30144c02c84 mtd: dataflash: remove duplicate SPI ID =
table)
Merging nand/nand/next (a2cfa6a24c61 mtd: rawnand: vf610_nfc: use regular c=
omments for functions)
Merging spi-nor/spi-nor/next (55398beb0846 mtd: spi-nor: sfdp: Use SFDP_DWO=
RD() macro for optional parameter tables)
Merging crypto/master (596f674dc9a7 crypto: p10-aes-gcm - Revert implementa=
tion)
Merging drm/drm-next (0b45ac1170ea Merge tag 'drm-intel-next-2023-01-12' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Applying: fix up for "drm/fb-helper: Set framebuffer for vga-switcheroo cli=
ents"
Merging drm-misc/for-linux-next (ebd05c0e12ed drm/panel: vtdr6130: fix unus=
ed ret in visionox_vtdr6130_bl_update_status)
CONFLICT (content): Merge conflict in drivers/gpu/drm/vmwgfx/ttm_object.h
Merging amdgpu/drm-next (b4a9b36e69e9 Documentation/gpu: update dGPU asic i=
nfo table)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Merging drm-intel/for-linux-next (24d97468f4f3 drm/i915/display: Convert i9=
xx_pipe_crc_auto_source to void)
Merging drm-tegra/for-next (08fef75f5e17 gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (33f868db99f1 drm/msm/gpu: Add default devfreq thr=
esholds)
Merging drm-msm-lumag/msm-next-lumag (3d7e16707c3e Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi', 'msm-next-lumag-mdp5' and 'msm-next-lumag-mdp4' =
into msm-next-lumag)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/msm_drv.c
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (30527af2bed1 drm/etnaviv: Remove #ifdef guard=
s for PM related functions)
Merging fbdev/for-next (ee9fffdc3887 fbdev: omapfb: Use kstrtobool() instea=
d of strtobool())
Merging regmap/for-next (7b3c4c370c09 regmap: Rework regmap_mdio_c45_{read|=
write} for new C45 API.)
Merging sound/for-next (81c254a65ceb ALSA: fireface: fix locking bug in ff4=
00_copy_msg_to_user())
Merging sound-asoc/for-next (8dc08c82afbf ASoC: mediatek: Add support for M=
T8188 SoC)
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
Merging modules/modules-next (98edf74195fb module: Use kstrtobool() instead=
 of strtobool())
Merging input/next (407da561244b Merge tag 'v6.2-rc3' into next)
CONFLICT (modify/delete): drivers/input/touchscreen/ucb1400_ts.c deleted in=
 HEAD and modified in input/next.  Version input/next of drivers/input/touc=
hscreen/ucb1400_ts.c left in tree.
$ git rm -f drivers/input/touchscreen/ucb1400_ts.c
Merging block/for-next (15fa664f1d84 Merge branch 'for-6.3/io_uring' into f=
or-next)
Applying: fixup for "ublk_drv: add mechanism for supporting unprivileged ub=
lk device"
Merging device-mapper/for-next (7991dbff6849 dm thin: Use last transaction'=
s pmd->root when commit failed)
Merging libata/for-next (38d431229bfb ata: libata: exclude FUA support for =
known buggy drives)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (18b84603a198 mmc: pwrseq_sd8787: Allow being built-in irr=
espective of dependencies)
Merging mfd/for-mfd-next (153e461670b9 mfd: simple-mfd-i2c: Fix incoherent =
comment regarding DT registration)
Merging backlight/for-backlight-next (73516cbcf8d9 backlight: pwm_bl: Drop =
support for legacy PWM probing)
Merging battery/for-next (4e9498b835ab power: supply: bq25890: Support boar=
ds with more then one charger IC)
Merging regulator/for-next (79dcc147a612 Merge remote-tracking branch 'regu=
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
Merging tomoyo/master (5fc44ba8be52 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (a7464dee2b4f tpm_crb: Add support for CRB devices based=
 on Pluton)
Merging watchdog/master (1b929c02afd3 Linux 6.2-rc1)
Merging iommu/next (6a399c3b99ee Merge branches 'iommu/fixes', 'x86/amd' an=
d 'core' into next)
Merging audit/next (88603b6dc419 Linux 6.2-rc2)
Merging devicetree/for-next (aa222f9311e1 dt-bindings: PCI: Convert Rockchi=
p RK3399 PCIe to DT schema)
Merging dt-krzk/for-next (d3897e5e296e Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (33e3e5c381ce Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
Merging tip/master (195df42eb64d Merge branch into tip/master: 'x86/platfor=
m')
CONFLICT (modify/delete): arch/arm/mach-omap2/pm24xx.c deleted in HEAD and =
modified in tip/master.  Version tip/master of arch/arm/mach-omap2/pm24xx.c=
 left in tree.
$ git rm -f arch/arm/mach-omap2/pm24xx.c
Merging clockevents/timers/drivers/next (2eff537b37ca dt-bindings: timer: r=
k-timer: Add rktimer for rv1126)
Merging edac/edac-for-next (23dc3f7720c7 Merge ras/edac-urgent into for-nex=
t)
Merging irqchip/irq/irqchip-next (6ed54e1789a2 Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (14b7bc94a4f6 Merge branch 'trace/trace/for-next' i=
nto trace/for-next)
Merging rcu/rcu/next (c3aceb71874a rcutorture: Add srcu_lockdep.sh)
Merging kvm/next (fc471e831016 Merge branch 'kvm-late-6.1' into HEAD)
CONFLICT (content): Merge conflict in arch/x86/kvm/reverse_cpuid.h
Merging kvm-arm/next (753d734f3f34 Merge remote-tracking branch 'arm64/for-=
next/sysregs' into kvmarm-master/next)
Merging kvms390/next (bedac519eefa s390/vfio-ap: check TAPQ response code w=
hen waiting for queue reset)
Merging kvm-x86/next (d608497bbfa0 Merge branches 'apic', 'generic', 'misc'=
, 'mmu', 'pmu', 'selftests', 'svm' and 'vmx' into next)
CONFLICT (content): Merge conflict in arch/x86/include/asm/cpufeatures.h
Merging xen-tip/linux-next (b50fab54944f x86/xen/time: prefer tsc as clocks=
ource when it is invariant)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c63a2e52d5e0 workqueue: Fold rebind_worker() w=
ithin rebind_workers())
Merging drivers-x86/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging chrome-platform/for-next (6514bac4a321 platform/chrome: cros_ec_pro=
to: remove big stub objects from stack)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (6e04532c0848 leds: is31fl319x: Wrap mutex_de=
stroy() for devm_add_action_or_rest())
Merging ipmi/for-next (041fae9c105a Merge tag 'f2fs-for-6.2-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging driver-core/driver-core-next (ed9f918174cb driver core: bus: move b=
us notifier logic into bus.c)
Merging usb/usb-next (82b0417e4bfc usb: cdnsp: : add scatter gather support=
 for ISOC endpoint)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/nvidia/tegra234-p=
3701-0000.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/nvidia/tegra234-p=
3737-0000+p3701-0000.dts
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/nvidia/tegra234.d=
tsi
CONFLICT (content): Merge conflict in drivers/usb/host/xhci.c
CONFLICT (content): Merge conflict in drivers/usb/host/xhci.h
CONFLICT (content): Merge conflict in drivers/usb/typec/ucsi/ucsi.c
Merging thunderbolt/next (6ce3563520be thunderbolt: Add support for Display=
Port bandwidth allocation mode)
Merging usb-serial/usb-next (b7bfaa761d76 Linux 6.2-rc3)
Merging tty/tty-next (5dc4c995db9e Linux 6.2-rc4)
Merging char-misc/char-misc-next (5dc4c995db9e Linux 6.2-rc4)
Merging accel/habanalabs-next (f65c5dac2073 docs: accel: Fix debugfs path)
CONFLICT (content): Merge conflict in drivers/Makefile
CONFLICT (content): Merge conflict in drivers/accel/Kconfig
CONFLICT (add/add): Merge conflict in drivers/accel/Makefile
Merging coresight/next (fd30b085deeb coresight: trace-id: Add debug & test =
macros to Trace ID allocation)
Merging fpga/for-next (3afe90d5b7a4 fpga: dfl: kernel-doc corrections)
Merging icc/icc-next (6f773d4b3bfe Merge branch 'icc-sa8775p' into icc-next)
Merging iio/togreg (c44e031bcff1 iio: chemical: scd30_core: Switch to use d=
ev_err_probe())
CONFLICT (content): Merge conflict in MAINTAINERS
Merging phy-next/next (fb1ff01307ee dt-bindings: phy: tegra-xusb: Convert t=
o json-schema)
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/phy=
/nvidia,tegra194-xusb-padctl.yaml
Merging soundwire/next (545c365185a4 soundwire: stream: Move remaining regi=
ster accesses over to no_pm)
Merging extcon/extcon-next (2e85d0a0201d extcon: qcom-spmi: Switch to platf=
orm_get_irq_byname_optional)
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (70be6f322860 vfio/mlx5: error pointer dereference in err=
or handling)
Merging staging/staging-next (4193769b6dfd staging: r8188eu: convert PHY_BB=
Config8188E() to common error logic)
CONFLICT (content): Merge conflict in drivers/staging/vc04_services/include=
/linux/raspberrypi/vchiq.h
Merging counter-next/counter-next (01f714ee022e counter: fix dependency ref=
erences for config MICROCHIP_TCB_CAPTURE)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (4b23603a251d dmaengine: drivers: Use devm_platform_=
ioremap_resource())
Merging cgroup/for-next (32a47817d075 cgroup/cpuset: fix a few kernel-doc w=
arnings & coding style)
Merging scsi/for-next (4be502c27dba Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (85e182b48a33 scsi: ufs: qcom: dt-bindings: Allow=
 'dma-coherent' property)
Merging vhost/linux-next (66c78aa2b9ba virtio: vdpa: new SolidNET DPU drive=
r.)
Merging rpmsg/for-next (10de8156ed71 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (7e3643bfbb7e gpio: pcf857x: Drop unneeded =
explicit casting)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (900a37df9d98 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (88f8ac47bddc pinctrl: Proofreading and upda=
ting the documentation (part 2))
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
Merging ntb/ntb-next (0310a30a9395 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging nvmem/for-next (ad80e15904ec nvmem: core: fix return value)
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
Merging efi/next (2cf9e278efef efi: efivars: make efivar_supports_writes() =
return bool)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (001aa6a1f0a0 Merge branch 'slab/for-6.3/cleanups' in=
to slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (366617a69e60 selftests/landlock: Skip overlayfs test=
s when not supported)
Merging rust/rust-next (dec1df547d81 rust: prelude: prevent doc inline of e=
xternal imports)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in fs/hugetlbfs/inode.c
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
CONFLICT (content): Merge conflict in mm/zsmalloc.c
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (2386459394d2 lib/cpumask: update comment fo=
r cpumask_local_spread())
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (4f85531a3be9 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (b062007c63eb iommu: Remove IOMMU_CAP_INTR_REMAP)
Merging mm-stable/mm-stable (9a3f21fe5cb9 selftests: vm: enable cross-compi=
lation)
CONFLICT (content): Merge conflict in Documentation/admin-guide/cgroup-v1/m=
emory.rst
CONFLICT (content): Merge conflict in fs/buffer.c
Merging mm-nonmm-stable/mm-nonmm-stable (077010cef0ae Sync with v6.2-rc4)
Merging mm/mm-everything (baaa3edb7cc0 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)

--Sig_/n.euDGwv4xG4bia3n+ipR2v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJ+O0ACgkQAVBC80lX
0GwXdgf/Zu8z4YPjmElvM5E2Y3VJmTG6qjt7ZJ6Km+IPrC42czR9zbBcfifcBKLE
RaPlf/0bJroPDCuIcZuUjmc+rYp/1HDRsrRibQ0S8p/4Pq30F5RODHcjVpmmTNVp
/sbdKRJZs1R4mvKOsVtO8wIwQbCp+xUEj1+PvcsbzQf+I2GuMZxvQjtysr0Rp0vP
dN8+RZfxbE3qx51Aw7hqHVmlJk+WAj/j5ABLprj/SPGLo/yakgUYtbtj0bAtGfcr
nJJLtqieEso9O9yZF56FXUd9MBx2e/heCG9uBrwZWaQEybtLAPrJ1vlQTTKsrdU5
4bLiecwZNLLT93lqG/ZEJcTt8UP3QA==
=T9QU
-----END PGP SIGNATURE-----

--Sig_/n.euDGwv4xG4bia3n+ipR2v--
