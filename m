Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639DD678F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAXDkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXDkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:40:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC08A62;
        Mon, 23 Jan 2023 19:40:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1CRD5VT7z4xyF;
        Tue, 24 Jan 2023 14:40:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674531624;
        bh=VWsxq1M6QzzrNbNwRfQHMLynriUFIZys2gixvaFazrw=;
        h=Date:From:To:Cc:Subject:From;
        b=QHtHlUIMjg9uOu7B54HN8T6g5MPTiEYWN/NVyR+RSuM3UkLru+jl3vtm8dJHYhE5/
         ucOxkF/Ubgwoy3uqhQLZ8fFYGvVjl/kFwwM68Cs+cDjGI4UAIQQcOmMeGZk/IYrkvr
         3KrW/Np0CzGEoLXuCDEQ2SZ5oaX4zwmPZnLtulsRoTaeDaQ3DS0QUK+hOdXpz6Sqv4
         fDnZ8cNpD3XURVMTrNgyxKc2AfOnnK1z6K0AxhddofVA7Tmr21R4fFNGJ67+mMB1a7
         VhaV8ZmN7EOjFO7Saln9kwyHiB8XjiQEmUcxq5D9D2Z48aJvfkW6jSu5kuNvIEtxnk
         LUxVi+xPeXcAA==
Date:   Tue, 24 Jan 2023 14:40:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 24
Message-ID: <20230124144023.01f79f60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/llLmB2ggmZEa5WDBL=QFpRc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/llLmB2ggmZEa5WDBL=QFpRc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230123:

The gpio-brgl-fixes tree gained a build failure so I used the version
from next-20230123.

The zonefs tree gained conflicts against the vfs-idmapping tree.

The net-next tree gained a semantic conflict against the net tree.

The bpf-next tree gained a conflict against Linus' tree.

Non-merge commits (relative to Linus' tree): 6929
 7738 files changed, 296283 insertions(+), 318269 deletions(-)

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
Merging origin/master (7bf70dbb1882 Merge tag 'vfio-v6.2-rc6' of https://gi=
thub.com/awilliam/linux-vfio)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (4c710c0e7b96 .mailmap: update e-m=
ail address for Eugen Hristev)
Merging kbuild-current/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2f62847cf6ae ARM: 9287/1: Reduce __thumb2__ defi=
nition to crypto files that require it)
Merging arm64-fixes/for-next/fixes (68a63a412d18 arm64: Fix build with CC=
=3Dclang, CONFIG_FTRACE=3Dy and CONFIG_STACK_TRACER=3Dy)
Merging arm-soc-fixes/arm/fixes (d2c865553adb firmware: zynqmp: fix declara=
tions for gcc-13)
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
Merging net/master (9f535c870e49 ipv6: fix reachability confirmation with p=
roxy_ndp)
Merging bpf/master (74bc3a5acc82 bpf: Add missing btf_put to register_btf_i=
d_dtor_kfuncs)
Merging ipsec/master (eb6c59b735aa xfrm: compat: change expression for swit=
ch in xfrm_xlate64)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (c410cb974f2b netfilter: conntrack: handle tcp challeng=
e acks during connection reuse)
Merging wireless/for-next (80f8a66dede0 Revert "wifi: mac80211: fix memory =
leak in ieee80211_if_add()")
Merging rdma-fixes/for-rc (6601fc0d15ff IB/hfi1: Restore allocated resource=
s on failed copyout)
Merging sound-current/for-linus (87978e6ad45a ALSA: hda: Do not unset prese=
t when cleaning up codec)
Merging sound-asoc-fixes/for-linus (dcff8b7ca92d ASoC: amd: yc: Add Xiaomi =
Redmi Book Pro 15 2022 into DMI table)
Merging regmap-fixes/for-linus (1b929c02afd3 Linux 6.2-rc1)
Merging regulator-fixes/for-linus (4bb3d82a1820 regulator: dt-bindings: sam=
sung,s2mps14: add lost samsung,ext-control-gpios)
Merging spi-fixes/for-linus (9bab63a3e949 spi: spidev: fix a recursive lock=
ing error)
Merging pci-current/for-linus (1b929c02afd3 Linux 6.2-rc1)
Merging driver-core.current/driver-core-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging tty.current/tty-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging usb.current/usb-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging usb-serial-fixes/usb-linus (71dfd381a7c0 USB: serial: option: add Q=
uectel EM05CN modem)
Merging phy/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging staging.current/staging-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging iio-fixes/fixes-togreg (eb50cd5bfdac iio: hid: fix the retval in gy=
ro_3d_capture_sample)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (2241ab53cbb5 Linux 6.2-rc5)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging input-current/for-linus (9c445d2637c9 Input: i8042 - add Clevo PCX0=
DX to i8042 quirk table)
Merging crypto-current/master (736f88689c69 crypto: arm64/sm4 - fix possibl=
e crash with CFI enabled)
Merging vfio-fixes/for-linus (51cdc8bc120e kvm/vfio: Fix potential deadlock=
 on vfio group_lock)
Merging kselftest-fixes/fixes (9fdaca2c1e15 kselftest: Fix error message fo=
r unconfigured LLVM builds)
Merging modules-fixes/modules-linus (da35048f2600 kallsyms: Fix scheduling =
with interrupts disabled in self-test)
Merging dmaengine-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c0f7ae27539f MAINTAINERS: Update email of Tudo=
r Ambarus)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (a1550700629f media: v4l2-ctrls-api.c: move ctr=
l->is_new =3D 1 to the correct line)
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
Merging drivers-x86-fixes/fixes (59751dbfe4b8 platform/x86: hp-wmi: Fix cas=
t to smaller integer type warning)
Merging samsung-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (064e32dc5b03 of: fdt: Honor CONFIG_CMDLI=
NE* even without /chosen node, take 2)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (0bfe63d07578 scsi: device_handler: alua: Remove a=
 might_sleep() annotation)
Merging drm-fixes/drm-fixes (3f30a6e67ce4 Merge tag 'amd-drm-fixes-6.2-2023=
-01-19' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (2241ab53cbb5 Linux 6.2-rc5)
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
Merging gpio-brgl-fixes/gpio/for-current (de5f701724ac gpiolib: fix linker =
errors when GPIOLIB is disabled)
$ git reset --hard HEAD^
Merging next-20230123 version of gpio-brgl-fixes
Merging gpio-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging erofs-fixes/fixes (e02ac3e7329f erofs: clean up parsing of fscache =
related options)
Merging kunit-fixes/kunit-fixes (db105c37a4d6 kunit: Export kunit_running())
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
Merging drm-misc-fixes/for-linux-next-fixes (0220e4fe178c drm/i915: Fix a m=
emory leak with reused mmap_offset)
Merging kbuild/for-next (a778c9dd138b builddeb: clean generated package con=
tent)
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
Merging arm/for-next (c6b7e9e37e3d Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (ab2da03aee54 Merge branches 'for-next/sysreg',=
 'for-next/sme', 'for-next/kselftest', 'for-next/misc', 'for-next/sme2', 'f=
or-next/tpidr2', 'for-next/scs' and 'for-next/compat-hwcap' into for-next/c=
ore)
Merging arm-perf/for-next/perf (4998897b1e96 perf: arm_spe: Support new SPE=
v1.2/v8.7 'not taken' event)
Merging arm-soc/for-next (f04024276aba Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (8a28c2de8f43 Merge branch 'v6.3/arm-dt' into for-=
next)
Merging asahi-soc/asahi-soc/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging aspeed/for-next (03f90343f5b5 soc: nuvoton: Add SoC info driver for=
 WPCM450)
Merging at91/at91-next (78712fb81548 Merge branch 'clk-microchip-fixes' int=
o at91-next)
Merging broadcom/next (9b385edf71bd Merge branch 'devicetree-arm64/next' in=
to next)
Merging davinci/davinci/for-next (eaafab7e8e26 MAINTAINERS: make me the mai=
ntainer of DaVinci platforms)
Merging drivers-memory/for-next (957b573ea840 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (beb902cee34c Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (69bd8d57c880 Merge branch 'v6.2-next/soc' into f=
or-next)
Merging mvebu/for-next (80502ffab2fa arm64: dts: marvell: AC5/AC5X: Fix add=
ress for UART1)
Merging omap/for-next (f68a6fc58073 Merge branch 'omap-for-v6.3/cleanup' in=
to for-next)
Merging qcom/for-next (97c57426d969 Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-for-6.3' and 'dts-for-6.3' into=
 for-next)
Merging renesas/next (d06e3b65fc36 Merge branches 'renesas-drivers-for-v6.3=
', 'renesas-dt-bindings-for-v6.3' and 'renesas-dts-for-v6.3' into renesas-n=
ext)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (4c20692e9cb9 Merge branch 'v6.3-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (e67be70d5f4d Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (672583a235f6 Merge tag 'scmi-updates-6.3' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (2f33df889e99 ARM: dts: stm32: Use new media bus t=
ype macros)
Merging sunxi/sunxi/for-next (7879da4e62f1 Merge branch 'sunxi/drivers-for-=
6.3' into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (473cf86078a7 Merge branch for-6.3/arm64/dt into for=
-next)
Merging ti/ti-next (9ae21ac445e9 arm64: dts: ti: k3-j7200: Fix wakeup pinmu=
x range)
Merging xilinx/for-next (a18426505c2b Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (15af773367a8 Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-renesas/renesas-clk (1c052043c79a clk: renesas: cpg-mssr: Remov=
e superfluous check in resume code)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (5dc4c995db9e Linux 6.2-rc4)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (43558085185a m68k: nommu: Fix misspellings of "=
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
Merging riscv-dt/riscv-dt-for-next (3ee39354053f Merge patch series "Add a =
devicetree for the Aldec PolarFire SoC TySoM")
Merging riscv-soc/riscv-soc-for-next (f3460326e38d Merge patch series "JH71=
10 PMU Support")
Merging s390/for-next (309c79867932 Merge branch 'features' into for-next)
Merging uml/next (43ee0357e15b um: vector: Fix memory leak in vector_config)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (c26bd309eef2 Merge branch 'fs.idmapped.shme=
m' into for-next)
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
Merging fscrypt/master (41952551acb4 fscrypt: add additional documentation =
for SM4 support)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (0d3a951af7fb Merge branch 'for-next-next-v6.2-20230=
120' into for-next-20230120)
Merging ceph/master (8e1858710d9a ceph: avoid use-after-free in ceph_fl_rel=
ease_lock())
Merging cifs/for-next (ffce8c17b6ef update internal module version number f=
or cifs.ko)
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
Merging ksmbd/ksmbd-for-next (cb31792d28ef ksmbd: Remove duplicated codes)
Merging nfs/linux-next (2241ab53cbb5 Linux 6.2-rc5)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/nfsd-next (acf282e4032c nfsd: clean up potential nfsd_file ref=
count leaks in COPY codepath)
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
Merging zonefs/for-next (43592c46375a zonefs: Cache zone group directory in=
odes)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
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
Merging hid/for-next (227e8eaed1cf Merge branch 'for-6.2/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (76f3d4040250 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (e826acc18bc7 i3c: transfer pid from boardinfo to devi=
ce info)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (4d891f76a30d dt-bindings: hwmon: correct =
indentation and style in examples)
Merging jc_docs/docs-next (74685d1e7711 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (6599e683db1b Merge tag 'v6.2-rc1' into media_tree)
Merging v4l-dvb-next/master (7120d6bfd6d0 media: tm6000: remove deprecated =
driver)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/staging/media/Kconfig
CONFLICT (content): Merge conflict in drivers/staging/media/Makefile
Merging pm/linux-next (faa268e6daed Merge branch 'thermal-intel' into linux=
-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (08f0adb193c0 cpufreq: armada-37=
xx: stop using 0 as NULL pointer)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (497e92ab8c8e PM / devfreq: Remove "select SRC=
U")
Merging opp/opp/linux-next (93c697b41d14 dt-bindings: opp: v2-qcom-level: L=
et qcom,opp-fuse-level be a 2-long array)
Merging thermal/thermal/linux-next (0d568e144ead thermal/drivers/intel: Use=
 generic trip points int340x)
Merging dlm/next (aa7f4a21f6e5 fs/dlm: Remove "select SRCU")
Merging rdma/for-next (ed73a505480d RDMA/erdma: Replace zero-length arrays =
with flexible-array members)
Merging net-next/master (32e54254bab8 net: mdio: mux-meson-g12a: use devm_c=
lk_get_enabled to simplify the code)
Applying: fix up for "ethtool: Add and use ethnl_update_bool."
Merging bpf-next/for-next (ea403bb7b315 Merge branch 'libbpf-extend-argumen=
ts-tracing')
CONFLICT (content): Merge conflict in kernel/bpf/offload.c
Merging ipsec-next/master (7e68dd7d07a2 Merge tag 'net-next-6.2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mlx5-next/mlx5-next (c4d508fbe54a net/mlx5: Configure IPsec steerin=
g for egress RoCEv2 traffic)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (a7b87d2a31dc Merge branch 'mlxsw-add-support-of-l=
atency-tlv')
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
Merging crypto/master (d6b7ec11062e crypto: x86/aria-avx512 - fix build fai=
lure with old binutils)
Merging drm/drm-next (0b45ac1170ea Merge tag 'drm-intel-next-2023-01-12' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Applying: fix up for "drm/fb-helper: Set framebuffer for vga-switcheroo cli=
ents"
Merging drm-misc/for-linux-next (8681e3663411 drm/simpledrm: Support the XB=
24/AB24 format)
CONFLICT (content): Merge conflict in drivers/gpu/drm/vmwgfx/ttm_object.h
Merging amdgpu/drm-next (b4a9b36e69e9 Documentation/gpu: update dGPU asic i=
nfo table)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Merging drm-intel/for-linux-next (3af2ff0840be drm/i915: Enable a PIPEDMC w=
henever its corresponding pipe is enabled)
Merging drm-tegra/for-next (08fef75f5e17 gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (afd6dbfdfd18 Merge branch 'msm-next-lumag' into H=
EAD)
Merging drm-msm-lumag/msm-next-lumag (afd6dbfdfd18 Merge branch 'msm-next-l=
umag' into HEAD)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (30527af2bed1 drm/etnaviv: Remove #ifdef guard=
s for PM related functions)
Merging fbdev/for-next (ee9fffdc3887 fbdev: omapfb: Use kstrtobool() instea=
d of strtobool())
Merging regmap/for-next (7b3c4c370c09 regmap: Rework regmap_mdio_c45_{read|=
write} for new C45 API.)
Merging sound/for-next (bea11f0aa17a Merge branch 'topic/firewire' into for=
-next)
Merging sound-asoc/for-next (792109062788 Merge remote-tracking branch 'aso=
c/for-6.3' into asoc-next)
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
Merging input/next (8aaec1177521 Input: cros_ec_keyb - add 3 buttons for mo=
nitor function)
CONFLICT (modify/delete): drivers/input/touchscreen/ucb1400_ts.c deleted in=
 HEAD and modified in input/next.  Version input/next of drivers/input/touc=
hscreen/ucb1400_ts.c left in tree.
$ git rm -f drivers/input/touchscreen/ucb1400_ts.c
Merging block/for-next (e4b63e93c174 Merge branch 'for-6.3/io_uring' into f=
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
Merging regulator/for-next (01a16b4a0a7a Merge remote-tracking branch 'regu=
lator/for-6.3' into regulator-next)
Merging security/next (88603b6dc419 Linux 6.2-rc2)
Merging apparmor/apparmor-next (1b929c02afd3 Linux 6.2-rc1)
Merging integrity/next-integrity (b8dc57947379 ima: fix ima_delete_rules() =
kernel-doc warning)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (88603b6dc419 Linux 6.2-rc2)
Merging smack/next (1a3065e92046 smack_lsm: remove unnecessary type casting)
Merging tomoyo/master (5fc44ba8be52 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (f1f94dd2a5f5 KEYS: asymmetric: Fix ECDSA use via keyctl=
 uapi)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in fs/xfs/xfs_iomap.c
Merging watchdog/master (1b929c02afd3 Linux 6.2-rc1)
Merging iommu/next (7f3b7e7a973f Merge branches 'apple/dart', 'arm/exynos',=
 'x86/amd' and 'core' into next)
Merging audit/next (88603b6dc419 Linux 6.2-rc2)
Merging devicetree/for-next (8da765cca292 dt-bindings: vendor-prefixes: doc=
ument lineartechnology)
Merging dt-krzk/for-next (9cfaf16c1abf Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (1d9bec75ce37 Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
Merging tip/master (e5c645984a38 Merge branch into tip/master: 'x86/platfor=
m')
CONFLICT (modify/delete): arch/arm/mach-omap2/pm24xx.c deleted in HEAD and =
modified in tip/master.  Version tip/master of arch/arm/mach-omap2/pm24xx.c=
 left in tree.
$ git rm -f arch/arm/mach-omap2/pm24xx.c
Merging clockevents/timers/drivers/next (2eff537b37ca dt-bindings: timer: r=
k-timer: Add rktimer for rv1126)
Merging edac/edac-for-next (31c808755082 Merge ras/edac-urgent into for-nex=
t)
Merging irqchip/irq/irqchip-next (6ed54e1789a2 Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (14b7bc94a4f6 Merge branch 'trace/trace/for-next' i=
nto trace/for-next)
Merging rcu/rcu/next (71439cf2e338 locking/csd_lock: Remove per-CPU data in=
direction from CSD lock debugging)
Merging kvm/next (fc471e831016 Merge branch 'kvm-late-6.1' into HEAD)
Merging kvm-arm/next (3caa33887bb6 Merge remote-tracking branch 'oupton/kvm=
arm/next' into kvmarm-master/next)
Merging kvms390/next (99b63f55dc51 KVM: s390: remove unused gisa_clear_ipm_=
gisc() function)
Merging kvm-x86/next (2b031df3124e Merge branches 'apic', 'generic', 'misc'=
, 'mmu', 'pmu', 'selftests', 'svm' and 'vmx' into next)
CONFLICT (content): Merge conflict in arch/arm64/kvm/sys_regs.c
CONFLICT (content): Merge conflict in arch/powerpc/kvm/e500mc.c
CONFLICT (content): Merge conflict in arch/x86/include/asm/cpufeatures.h
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx/vmx_ops.h
Merging xen-tip/linux-next (ca0d80778e48 xen/pvcalls-back: fix permanently =
masked event channel)
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
Merging driver-core/driver-core-next (f89fd04323f7 Merge 6.2-rc5 into drive=
r-core-next)
Merging usb/usb-next (e3e9fc7fa7ad Merge 6.2-rc5 into usb-next)
Merging thunderbolt/next (6ce3563520be thunderbolt: Add support for Display=
Port bandwidth allocation mode)
Merging usb-serial/usb-next (b7bfaa761d76 Linux 6.2-rc3)
Merging tty/tty-next (ed0400ad547c serial: liteuart: Correct error rollback)
Merging char-misc/char-misc-next (99ba2ad1db62 Merge 6.2-rc5 into char-misc=
-next)
Merging accel/habanalabs-next (0b905aa14498 habanalabs: Fix list of /sys/cl=
ass/habanalabs/hl<n>/status)
CONFLICT (content): Merge conflict in drivers/Makefile
CONFLICT (content): Merge conflict in drivers/accel/Kconfig
CONFLICT (add/add): Merge conflict in drivers/accel/Makefile
Merging coresight/next (705159622cb8 Documentation: coresight: tpdm: Add du=
mmy comment after sysfs list)
Merging fpga/for-next (e5541aae450e fpga: dfl: more kernel-doc corrections)
CONFLICT (content): Merge conflict in drivers/fpga/dfl.c
CONFLICT (content): Merge conflict in drivers/fpga/dfl.h
Merging icc/icc-next (6f773d4b3bfe Merge branch 'icc-sa8775p' into icc-next)
Merging iio/togreg (354f23ac2c87 dt-bindings: iio: adc: Add NXP IMX93 ADC)
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
Merging vfio/next (7658aeda334a vfio/platform: Use GFP_KERNEL_ACCOUNT for u=
serspace persistent allocations)
Merging staging/staging-next (54573f3ef96b Merge 6.2-rc5 into staging-next)
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
Merging gpio-brgl/gpio/for-next (5bb837ebcfe3 gpio: mvebu: Use IS_REACHABLE=
 instead of IS_ENABLED for CONFIG_PWM)
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (900a37df9d98 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (88f8ac47bddc pinctrl: Proofreading and upda=
ting the documentation (part 2))
Merging pinctrl-renesas/renesas-pinctrl (b066e6ea98c7 pinctrl: renesas: r8a=
77950: Add VIN[45] pins, groups, and functions)
Merging pinctrl-samsung/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pwm/for-next (8fa22f4b88e8 pwm: pca9685: Convert to i2c's .probe_ne=
w())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (88a51b4f2e65 ktest.pl: Add shell commands to variab=
les)
Merging kselftest/next (2241ab53cbb5 Linux 6.2-rc5)
Merging kunit/test (1b929c02afd3 Linux 6.2-rc1)
Merging kunit-next/kunit (5cb26c298ffd tools/testing/kunit/kunit.py: remove=
 redundant double check)
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (c690048ed59b dt-bindings: rtc: Move rv3028 from trivi=
al-rtc.yaml into own schema file)
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
Merging nvmem/for-next (ef26c0349eb5 of: property: fix #nvmem-cell-cells pa=
rsing)
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
Merging mhi/mhi-next (1fd102893456 bus: mhi: ep: Save channel state locally=
 during suspend and resume)
Merging memblock/for-next (80c2fe022ef5 memblock tests: remove completed TO=
DO item)
Merging cxl/next (589c3357370a PCI/CXL: Export native CXL error reporting c=
ontrol)
CONFLICT (content): Merge conflict in drivers/cxl/pci.c
Applying: fix up for "cxl: fix cxl_report_and_clear() RAS UE addr mis-assig=
nment"
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (8b30ec8d5eb1 efi: efivars: prevent double registration)
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
CONFLICT (content): Merge conflict in fs/zonefs/super.c
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
CONFLICT (content): Merge conflict in mm/zsmalloc.c
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (2386459394d2 lib/cpumask: update comment fo=
r cpumask_local_spread())
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (4c870e0fee23 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (84798f284994 iommufd: Add three missing structure=
s in ucmd_buffer)
Merging mm-stable/mm-stable (9a3f21fe5cb9 selftests: vm: enable cross-compi=
lation)
CONFLICT (content): Merge conflict in Documentation/admin-guide/cgroup-v1/m=
emory.rst
CONFLICT (content): Merge conflict in fs/buffer.c
Merging mm-nonmm-stable/mm-nonmm-stable (5dc4c995db9e Linux 6.2-rc4)
Merging mm/mm-everything (be80ef2679cd Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in drivers/remoteproc/qcom_q6v5_mss.c
CONFLICT (content): Merge conflict in mm/mremap.c

--Sig_/llLmB2ggmZEa5WDBL=QFpRc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPUycACgkQAVBC80lX
0GyfpQgAkSHlBVg589918iuu83yXA46Xaz976nKGQp5ipmI2W6q2mBeG0cwtrVoU
NIZPfb0vtCqdsvQkS2GYTo3iuTxG8NrXHvP74/AMJHjjpgis445HN/yiTQGMssl/
awddYAZtMobL1FA8OQWV///RMO7yNKSTi6YtLPYLu9fz+oIUQb9LgR3k6qs+VaMI
A4NGePKmj7bJuxdLJl3rwXPsCMwU8EwQ/lx+TOhZqXpnIxB56BipVcIpVdOF/FG+
barY2cEdeYKcCnMu+LWfK5isauvhjHGBleD3phdBp0PMQR1xm+jxVE8YFuPg4jJx
ml9R+I69R2xJQ6p/+gkonAUgGgmaoA==
=m+AW
-----END PGP SIGNATURE-----

--Sig_/llLmB2ggmZEa5WDBL=QFpRc--
