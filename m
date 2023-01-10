Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC56637B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjAJDJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjAJDJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:09:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDEB186BB;
        Mon,  9 Jan 2023 19:09:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrbQ15Y2vz4xND;
        Tue, 10 Jan 2023 14:09:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673320169;
        bh=+SXFdsmFtqb44JPdne/yLkL4kpysBoIGZd6rOy2To4k=;
        h=Date:From:To:Cc:Subject:From;
        b=MzVXX8DVG1eScgih6FcU5s9Ic1bi1RvuyDA8skht91Qcl0sB6eBzvLlz9i73qyIXE
         0Kmcp++vI40XtIurAKViBziNzDu+dYtAHIk9G+ifhe6UlAjN3MIVRi56oliJbZsRK6
         jgFBoQCHukiHto2AHyy8Wd8PTs67sU2vNXxalKOiMCsuF3iJD2f49iQTU2DQbcrEHo
         XrFrakVrCwELeBE+p8lf9Hawzrnk8SW2QRuhF68dsPLNAcGd1DWAdQ2djFmHxyBz60
         Cx47ryfcy8pC+HBsR1WgqiQJjC+UtPRswNShRPOgsy+qzW5joz4Cy1ClO4lcoUoyK0
         mN5AFfVtFaX+g==
Date:   Tue, 10 Jan 2023 14:09:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 10
Message-ID: <20230110140928.627d3d64@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xk=MqL3xMcHw1Dayo.yTs.n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xk=MqL3xMcHw1Dayo.yTs.n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230109:

The davinci tree gained a conflict against the arm-soc tree

The omap tree gained a conflict against the arm-soc tree

The sound-asoc tree gained a conflict against the arm-soc tree

The mm tree gained a conflict against the fsverity tree.

Non-merge commits (relative to Linus' tree): 3123
 4115 files changed, 103401 insertions(+), 197745 deletions(-)

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

I am currently merging 353 trees (counting Linus' and 98 trees of bug
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
Merging origin/master (1fe4fd6f5cad Merge tag 'xfs-6.2-fixes-2' of git://gi=
t.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (17caeba2dfb6 mm: hwposion: suppor=
t recovery from ksm_might_need_to_copy())
Merging kbuild-current/fixes (de7312ad7988 kbuild: export top-level LDFLAGS=
_vmlinux only to scripts/Makefile.vmlinux)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (73a0b6ee5d62 ARM: 9278/1: kfence: only handle tr=
anslation faults)
Merging arm64-fixes/for-next/fixes (68a63a412d18 arm64: Fix build with CC=
=3Dclang, CONFIG_FTRACE=3Dy and CONFIG_STACK_TRACER=3Dy)
Merging arm-soc-fixes/arm/fixes (6f85602d5fde Merge tag 'v6.1-soc-fixes' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into ar=
m/fixes)
Merging davinci-current/davinci/for-current (1b929c02afd3 Linux 6.2-rc1)
Merging drivers-memory-fixes/fixes (cb8fd6f75775 memory: mvebu-devbus: Fix =
missing clk_disable_unprepare in mvebu_devbus_probe())
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (553b20b211c4 m68k: defconfig: Update defcon=
figs for v6.1-rc1)
Merging powerpc-fixes/fixes (be5f95c8779e powerpc/vmlinux.lds: Don't discar=
d .comment)
Merging s390-fixes/fixes (f993d24a948d s390: fix -Wundef warning for CONFIG=
_KERNEL_ZSTD)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (7d6ceeb1875c af_unix: selftest: Fix the size of the par=
ameter to connect())
Merging bpf/master (a3d81bc1eaef bpf: Skip task with pid=3D1 in send_signal=
_common())
Merging ipsec/master (571f3dd0d01b Merge tag 'rxrpc-fixes-20230107' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (7d6ceeb1875c af_unix: selftest: Fix the size of =
the parameter to connect())
Merging rdma-fixes/for-rc (b7bfaa761d76 Linux 6.2-rc3)
Merging sound-current/for-linus (70051cffb31b ALSA: control-led: use strscp=
y in set_led_id())
Merging sound-asoc-fixes/for-linus (c9fb35f685b2 ASoC: dt-bindings: qcom,lp=
ass-tx-macro: correct clocks on SC7280)
Merging regmap-fixes/for-linus (f309b44844bd Merge remote-tracking branch '=
regmap/for-6.1' into regmap-linus)
Merging regulator-fixes/for-linus (f528fe213a6a regulator: qcom-rpmh: PM855=
0 ldo11 regulator is an nldo)
Merging spi-fixes/for-linus (50028988403a spi: spidev: remove debug message=
s that access spidev->spi without locking)
Merging pci-current/for-linus (760d560f71c8 PCI: dwc: Adjust to recent remo=
val of PCI_MSI_IRQ_DOMAIN)
Merging driver-core.current/driver-core-linus (88603b6dc419 Linux 6.2-rc2)
Merging tty.current/tty-linus (88603b6dc419 Linux 6.2-rc2)
Merging usb.current/usb-linus (b7bfaa761d76 Linux 6.2-rc3)
Merging usb-serial-fixes/usb-linus (1b929c02afd3 Linux 6.2-rc1)
Merging phy/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging staging.current/staging-linus (88603b6dc419 Linux 6.2-rc2)
Merging iio-fixes/fixes-togreg (bffb7d9d1a3d iio:adc:twl6030: Enable measur=
ement of VAC)
Merging counter-current/counter-current (1b929c02afd3 Linux 6.2-rc1)
Merging char-misc.current/char-misc-linus (88603b6dc419 Linux 6.2-rc2)
Merging soundwire-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging thunderbolt-fixes/fixes (84ee211c8321 thunderbolt: Disable XDomain =
lane 1 only in software connection manager)
Merging input-current/for-linus (3c44e2b6cde6 Revert "Input: synaptics - sw=
itch touchpad on HP Laptop 15-da3001TU to RMI mode")
Merging crypto-current/master (736f88689c69 crypto: arm64/sm4 - fix possibl=
e crash with CFI enabled)
Merging vfio-fixes/for-linus (e806e223621e vfio/pci: Check the device set o=
pen count on reset)
Merging kselftest-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging modules-fixes/modules-linus (4f1354d5c6a3 livepatch: Call klp_match=
_callback() in klp_find_callback() to avoid code duplication)
Merging dmaengine-fixes/fixes (f96a483f8e13 MAINTAINERS: update Jie Hai's e=
mail address)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c0f7ae27539f MAINTAINERS: Update email of Tudo=
r Ambarus)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (542d3c03fd89 media: sun6i-isp: params: Unregis=
ter pending buffer on cleanup)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (88603b6dc419 Linux 6.2-rc2)
Merging at91-fixes/at91-fixes (1b929c02afd3 Linux 6.2-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (a5496886eb13 Merge branch 'kvm-late-6.1-fixes' in=
to HEAD)
Merging kvms390-fixes/master (0dd4cdccdab3 KVM: s390: vsie: Fix the initial=
ization of the epoch extension (epdx) field)
Merging hwmon-fixes/hwmon (2fbb848b65cd hwmon: (nct6775) Fix incorrect pare=
nthesization in nct6775_write_fan_div())
Merging nvdimm-fixes/libnvdimm-fixes (472faf72b33d device-dax: Fix duplicat=
e 'hmem' device registration)
Merging cxl-fixes/fixes (8f401ec1c897 cxl/region: Recycle region ids)
Merging btrfs-fixes/next-fixes (b64c3d095a84 Merge branch 'misc-6.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (10bc8e4af659 vfs: fix copy_file_range() averts fil=
esystem freeze protection)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging drivers-x86-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging samsung-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-samsung-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging devicetree-fixes/dt/linus (064e32dc5b03 of: fdt: Honor CONFIG_CMDLI=
NE* even without /chosen node, take 2)
Merging dt-krzk-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging scsi-fixes/fixes (a67aad57d9ae scsi: libsas: Grab the ATA port lock=
 in sas_ata_device_link_abort())
Merging drm-fixes/drm-fixes (5193326c4c5a Merge tag 'drm-intel-fixes-2023-0=
1-05' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (afce71ff6daa drm/i915: Fix po=
tential context UAFs)
Merging mmc-fixes/fixes (8509419758f2 mmc: sunxi-mmc: Fix clock refcount im=
balance during unbind)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
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
Merging spdx/spdx-linus (1b929c02afd3 Linux 6.2-rc1)
Merging gpio-brgl-fixes/gpio/for-current (694175cd8a16 gpio: sifive: Fix re=
fcount leak in sifive_gpio_probe)
Merging gpio-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl-intel-fixes/fixes (1b929c02afd3 Linux 6.2-rc1)
Merging erofs-fixes/fixes (722f5debea5c erofs: fix kvcalloc() misuse with _=
_GFP_NOFAIL)
Merging kunit-fixes/kunit-fixes (88603b6dc419 Linux 6.2-rc2)
Merging ubifs-fixes/fixes (7bdd6967fec5 ubi: ensure that VID header offset =
+ VID header size <=3D alloc, size)
Merging memblock-fixes/fixes (115d9d77bb0f mm: Always release pages to the =
buddy allocator in memblock_free_late().)
Merging cel-fixes/for-rc (5304930dbae8 NFSD: Use set_bit(RQ_DROPME))
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (481028dbf1da perf tools: Fix build on uCl=
ibc systems by adding missing sys/types.h include)
Merging efi-fixes/urgent (7b817a995091 efi: tpm: Avoid READ_ONCE() for acce=
ssing the event log)
Merging zstd-fixes/zstd-linus (70d822cfb782 Merge branch 'zstd-next' into z=
std-linus)
Merging battery-fixes/fixes (d137900f237a power: supply: axp288_fuel_gauge:=
 Added check for negative values)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (88603b6dc419 Linux 6.2-rc2)
Merging drm-misc-fixes/for-linux-next-fixes (0688773f0710 drm: Add orientat=
ion quirk for Lenovo ideapad D330-10IGL)
Merging kbuild/for-next (83344be3eb46 kbuild: rust: move rust/target.json t=
o scripts/)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
Merging dma-mapping/for-next (3622b86f49f8 dma-mapping: reject GFP_COMP for=
 noncoherent allocations)
Merging asm-generic/master (32975c491ee4 uapi: Add missing _UAPI prefix to =
<asm-generic/types.h> include guard)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (1907710cab84 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (c0cd1d541704 Revert "arm64: errata: Workaround=
 possible Cortex-A715 [ESR|FAR]_ELx corruption")
Merging arm-perf/for-next/perf (4361251cef46 arm_pmu: Drop redundant armpmu=
->map_event() in armpmu_event_init())
Merging arm-soc/for-next (2e5392c15d96 Merge branch 'arm/boardfile-remove-w=
ip' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc into for-nex=
t)
Merging amlogic/for-next (7c49c17dc941 Merge branch 'v6.2/fixes' into for-n=
ext)
Merging asahi-soc/asahi-soc/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging aspeed/for-next (45c86167adde soc: nuvoton: Add SoC info driver for=
 WPCM450)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/nuvoton-wpcm450-sup=
ermicro-x9sci-ln4f.dts
Merging at91/at91-next (1b929c02afd3 Linux 6.2-rc1)
Merging broadcom/next (64610429f8de Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (84bde55c050b ARM: davinci: fix repeated w=
ords in comments)
CONFLICT (modify/delete): arch/arm/mach-davinci/board-dm365-evm.c deleted i=
n HEAD and modified in davinci/davinci/for-next.  Version davinci/davinci/f=
or-next of arch/arm/mach-davinci/board-dm365-evm.c left in tree.
$ git rm -f arch/arm/mach-davinci/board-dm365-evm.c
Merging drivers-memory/for-next (13f35b3c72f4 Merge branch 'for-v6.3/renesa=
s-rpc-if' into for-next)
Merging imx-mxs/for-next (beb902cee34c Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (c7a343cf1811 Merge branch 'v6.2-next/soc' into f=
or-next)
Merging mvebu/for-next (a4d5d2ef5b1f Revert "ARM: dts: armada-39x: Fix comp=
atible string for gpios")
Merging omap/for-next (6435241fd536 Merge branch 'musb-for-v6.2' into for-n=
ext)
CONFLICT (content): Merge conflict in arch/arm/mach-omap1/Kconfig
Merging qcom/for-next (eb223fb5efc1 Merge branches 'arm64-defconfig-for-6.3=
', 'arm64-fixes-for-6.2', 'arm64-for-6.3', 'clk-for-6.3', 'drivers-fixes-fo=
r-6.2', 'drivers-for-6.3', 'dts-fixes-for-6.2' and 'dts-for-6.3' into for-n=
ext)
Merging renesas/next (7cf590dd4235 Merge branches 'renesas-arm-defconfig-fo=
r-v6.3', 'renesas-arm-dt-for-v6.3', 'renesas-drivers-for-v6.3' and 'renesas=
-riscv-dt-for-v6.3' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (f8ddca807e78 Merge branch 'v6.3-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (e4c33114e1cf Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (98333bf901c3 Merge commit 'e325285de2cd' into =
for-linux-next)
Merging stm32/stm32-next (275f031df397 ARM: dts: stm32: add dfsdm node on s=
tm32mp131)
Merging sunxi/sunxi/for-next (6aa58dfeaacf Merge branch 'sunxi/clk-for-6.3'=
 into sunxi/for-next)
Merging tee/next (4a56b125ba20 Merge branch 'fixes' into next)
Merging tegra/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ti/ti-next (1b929c02afd3 Linux 6.2-rc1)
Merging xilinx/for-next (a7669037d438 Merge remote-tracking branch 'git/zyn=
qmp/soc' into for-next)
Merging clk/clk-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-imx/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging clk-renesas/renesas-clk (d969103ac89d clk: renesas: r9a09g011: Add =
SDHI/eMMC clock and reset entries)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (4a3ec00957fd csky: delay: Add function alignment)
Merging loongarch/loongarch-next (5535f4f70cfc LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (553b20b211c4 m68k: defconfig: Update defconfigs for =
v6.1-rc1)
Merging m68knommu/for-next (8fbf1bb2410e m68k: nommu: Fix misspellings of "=
DragonEngine")
Merging microblaze/next (5cfe469c2654 microblaze/PCI: Moving PCI iounmap an=
d dependent code)
Merging mips/mips-next (88603b6dc419 Linux 6.2-rc2)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (32125c5c95f2 parisc: Limit amount of kgdb break=
points on parisc)
Merging powerpc/next (1b929c02afd3 Linux 6.2-rc1)
Merging powerpc-objtool/topic/objtool (1b929c02afd3 Linux 6.2-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (b07de94d4501 Merge patch series "Allow calls in al=
ternatives")
CONFLICT (content): Merge conflict in arch/riscv/kernel/probes/simulate-ins=
n.h
Merging riscv-dt/riscv-dt-for-next (093ee97e24f8 Merge tag 'soc2arch-immuta=
ble' into riscv-dt-for-next)
Merging riscv-soc/riscv-soc-for-next (6635e91648ce soc: sifive: ccache: Add=
 StarFive JH7110 support)
Merging s390/for-next (b990b4dd9a93 Merge branch 'features' into for-next)
Merging uml/next (43ee0357e15b um: vector: Fix memory leak in vector_config)
Merging xtensa/xtensa-for-next (4414c1f5c7a3 xtensa: drop unused members of=
 struct thread_struct)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (4e1da8fe0313 posix_acl: Use try_cmpxchg in =
get_acl)
Merging fscrypt/master (41952551acb4 fscrypt: add additional documentation =
for SM4 support)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (a9eb558a5bea afs: Stop implementing ->writepage())
Merging btrfs/for-next (b1bc7d5d9896 Merge branch 'for-next-next-v6.2-20230=
105' into for-next-20230105)
Merging ceph/master (8e1858710d9a ceph: avoid use-after-free in ceph_fl_rel=
ease_lock())
Merging cifs/for-next (e918a107edf8 cifs: remove redundant assignment to th=
e variable match)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (3ae2c449e412 erofs/zmap.c: Fix incorrect offset calculat=
ion)
Merging exfat/dev (15b0de571a39 exfat: fix inode->i_blocks for non-512 byte=
 sector size device)
Merging ext3/for_next (1fb40763a58c udf: remove redundant variable netype)
Merging ext4/dev (1da18e38cb97 ext4: fix reserved cluster accounting in __e=
s_remove_extent())
Merging f2fs/dev (bde7c1e851b2 MAINTAINERS: Add f2fs's patchwork)
Merging fsverity/fsverity (9723b0df9161 ext4: allow verity with fs block si=
ze < PAGE_SIZE)
Merging fuse/for-next (1b0e94993dbe fuse: optional supplementary group in c=
reate requests)
Merging gfs2/for-next (6b46a06100dd gfs2: Remove support for glock holder a=
uto-demotion (2))
Merging jfs/jfs-next (a60dca73a1a8 jfs: makes diUnmount/diMount in jfs_moun=
t_rw atomic)
Merging ksmbd/ksmbd-for-next (83dcedd5540d ksmbd: fix infinite loop in ksmb=
d_conn_handler_loop())
Merging nfs/linux-next (5e9a7b9c2ea1 NFS: Fix up a sparse warning)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (0cf7baa62282 nfsd: fix potential race in nfs4_find_f=
ile)
Merging ntfs3/master (e3ab3260c918 fs/ntfs3: fix spelling mistake "attibute=
" -> "attribute")
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
Merging iomap/iomap-for-next (f1bd37a47352 iomap: directly use logical bloc=
k size)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (a295243efa2d filelock: move file locking def=
initions to separate header file)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (9ea606dbbc50 Merge branch 'work.misc' into for-next)
Merging printk/for-next (da6554d2173d Merge branch 'for-6.3' into for-next)
Merging pci/next (1b929c02afd3 Linux 6.2-rc1)
Merging pstore/for-next/pstore (88603b6dc419 Linux 6.2-rc2)
Merging hid/for-next (bd92d2065ad1 Merge branch 'for-6.2/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (59b3484a571e Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (08dcf0732cb4 MAINTAINERS: mark I3C DRIVER FOR SYNOPSY=
S DESIGNWARE orphan)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (b0587c87abc8 hwmon: (coretemp) Simplify p=
latform device handling)
Merging jc_docs/docs-next (7021e29503a3 Merge branch 'docs-fixes' into docs=
-next)
Merging v4l-dvb/master (6599e683db1b Merge tag 'v6.2-rc1' into media_tree)
Merging v4l-dvb-next/master (d4acfa22b634 media: sun6i-isp: params: Unregis=
ter pending buffer on cleanup)
Merging pm/linux-next (4f0d85674885 Merge branch 'thermal' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c956541736b9 cpufreq: apple-soc=
: Switch to the lowest frequency on suspend)
Merging cpupower/cpupower (1b929c02afd3 Linux 6.2-rc1)
Merging devfreq/devfreq-next (7fc7f25419f5 PM / devfreq: event: use devm_pl=
atform_get_and_ioremap_resource())
Merging opp/opp/linux-next (5b2ad5acaf5a dt-bindings: opp: opp-v2-kryo-cpu:=
 Add missing 'cache-unified' property in example)
Merging thermal/thermal/linux-next (3a151494dc04 thermal/drivers/armada: Us=
e strscpy() to instead of strncpy())
Merging dlm/next (aa7f4a21f6e5 fs/dlm: Remove "select SRCU")
Merging rdma/for-next (bd99ede8ef2d RDMA/irdma: Remove extra ret variable i=
n favor of existing err)
Merging net-next/master (12c1604ae1a3 net: skb: remove old comments about f=
rag_size for build_skb())
Merging bpf-next/for-next (6d0c4b11e743 libbpf: Poison strlcpy())
Merging ipsec-next/master (7e68dd7d07a2 Merge tag 'net-next-6.2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mlx5-next/mlx5-next (1b929c02afd3 Linux 6.2-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (2685a7e30bf1 Bluetooth: qca: Fix sparse warnings)
Merging wireless-next/for-next (d1c722867f80 net: lan966x: Remove a useless=
 test in lan966x_ptp_add_trap())
Merging mtd/mtd/next (a30144c02c84 mtd: dataflash: remove duplicate SPI ID =
table)
Merging nand/nand/next (568494db6809 mtd: remove tmio_nand driver)
Merging spi-nor/spi-nor/next (55398beb0846 mtd: spi-nor: sfdp: Use SFDP_DWO=
RD() macro for optional parameter tables)
Merging crypto/master (c970d42001f2 crypto: x86/aria - implement aria-avx51=
2)
Merging drm/drm-next (03a0a1040895 Merge tag 'drm-misc-next-2023-01-03' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (2349183d32d8 drm/panel: add visionox vtdr6=
130 DSI panel driver)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tests/drm_format_help=
er_test.c
Merging amdgpu/drm-next (3f7a3e5b89de drm/amdgpu: Fixed bug on error when u=
nloading amdgpu)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
Merging drm-intel/for-linux-next (a6fd6f94d361 drm/i915: Fix timeslots argu=
ment for DP DSC SST case)
Merging drm-tegra/for-next (08fef75f5e17 gpu: host1x: Staticize host1x_sync=
pt_fence_ops)
Merging drm-msm/msm-next (d73b1d02de08 drm/msm: Hangcheck progress detectio=
n)
Merging drm-msm-lumag/msm-next-lumag (93b7771df3f2 Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi', 'msm-next-lumag-mdp5' and 'msm-next-lumag-mdp4' =
into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (30527af2bed1 drm/etnaviv: Remove #ifdef guard=
s for PM related functions)
Merging fbdev/for-next (66dc2cb32919 fbdev: g364fb: Fix a compilation issue=
 by using uintptr_t)
Merging regmap/for-next (861fa35db66c Merge branch 'regmap-linus' into regm=
ap-next)
Merging sound/for-next (f0117128879b ALSA: firewire-lib: keep history to pr=
ocess isochronous packet)
Merging sound-asoc/for-next (8f61609d96c2 Merge remote-tracking branch 'aso=
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
Merging modules/modules-next (aa4f47a680bf test_kmod: stop kernel-doc warni=
ngs)
Merging input/next (c3991107a28a Input: elants_i2c - delay longer with rese=
t asserted)
Merging block/for-next (5afb6bfb79b6 Merge branch 'for-6.3/io_uring' into f=
or-next)
Merging device-mapper/for-next (7991dbff6849 dm thin: Use last transaction'=
s pmd->root when commit failed)
Merging libata/for-next (002c487119f2 ata: libata-scsi: improve ata_scsiop_=
maint_in())
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (1cb6f443cbdc Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (15a072efe92b mfd: cs5535: Don't build on UML)
Merging backlight/for-backlight-next (73516cbcf8d9 backlight: pwm_bl: Drop =
support for legacy PWM probing)
Merging battery/for-next (4e9498b835ab power: supply: bq25890: Support boar=
ds with more then one charger IC)
Merging regulator/for-next (04ee8ff6c3da Merge remote-tracking branch 'regu=
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
Merging tomoyo/master (cf3b3d6e3a0b locking/lockdep: add debug_show_all_loc=
k_holders())
Merging tpmdd/next (ceb626750358 crypto: certs: fix FIPS selftest dependenc=
y)
Merging watchdog/master (1b929c02afd3 Linux 6.2-rc1)
Merging iommu/next (e3eca2e4f648 Merge branches 'arm/allwinner', 'arm/exyno=
s', 'arm/mediatek', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 's390', 'x86/vt=
-d', 'x86/amd' and 'core' into next)
Merging audit/next (88603b6dc419 Linux 6.2-rc2)
Merging devicetree/for-next (3db50cb6db77 dt-bindings: i2c: Convert Synquac=
er I2C to DT schema)
Merging dt-krzk/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging mailbox/mailbox-for-next (53c60d100427 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for SM8550)
Merging spi/for-next (90416d92b7c5 Merge remote-tracking branch 'spi/for-6.=
3' into spi-next)
Merging tip/master (b0bfb80ce4ab Merge branch into tip/master: 'x86/platfor=
m')
Merging clockevents/timers/drivers/next (2eff537b37ca dt-bindings: timer: r=
k-timer: Add rktimer for rv1126)
Merging edac/edac-for-next (fed431d5c33a Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (6ed54e1789a2 Merge branch irq/misc-6.2 in=
to irq/irqchip-next)
Merging ftrace/for-next (14b7bc94a4f6 Merge branch 'trace/trace/for-next' i=
nto trace/for-next)
Merging rcu/rcu/next (5ceaf736da84 rcu: Avoid stack overflow due to __rcu_i=
rq_enter_check_tick() being kprobe-ed)
Merging kvm/next (fc471e831016 Merge branch 'kvm-late-6.1' into HEAD)
Merging kvm-arm/next (753d734f3f34 Merge remote-tracking branch 'arm64/for-=
next/sysregs' into kvmarm-master/next)
Merging kvms390/next (bedac519eefa s390/vfio-ap: check TAPQ response code w=
hen waiting for queue reset)
Merging xen-tip/linux-next (f57034cedeb6 xen/pvcalls: free active map buffe=
r on pvcalls_front_free_map)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (c76feb0d5dfd workqueue: Make show_pwq() use ru=
n-length encoding)
Merging drivers-x86/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging chrome-platform/for-next (957445d730ba platform/chrome: cros_ec: Sh=
utdown on EC Panic)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (870b4252c7b6 leds: turris-omnia: Convert to =
i2c's .probe_new())
Merging ipmi/for-next (041fae9c105a Merge tag 'f2fs-for-6.2-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging driver-core/driver-core-next (88603b6dc419 Linux 6.2-rc2)
Merging usb/usb-next (c2fb9a214da1 Merge 6.2-rc3 into usb-next)
Merging thunderbolt/next (953ff25fc9fb thunderbolt: Refactor tb_acpi_add_li=
nk())
Merging usb-serial/usb-next (1b929c02afd3 Linux 6.2-rc1)
Merging tty/tty-next (88603b6dc419 Linux 6.2-rc2)
Merging char-misc/char-misc-next (88603b6dc419 Linux 6.2-rc2)
Merging accel/habanalabs-next (12697efffad9 habanalabs: extend fatal messag=
es to contain PCI info)
Merging coresight/next (88603b6dc419 Linux 6.2-rc2)
Merging fpga/for-next (b0753e1c0af1 fpga: microchip-spi: separate data fram=
e write routine)
Merging icc/icc-next (dbdbdf891e39 Merge branch 'icc-dt' into icc-next)
Merging iio/togreg (bbd9b7e19be9 dt-bindings: iio: adc: maxim,max1363: fix =
interface typo)
Merging phy-next/next (1b929c02afd3 Linux 6.2-rc1)
Merging soundwire/next (545c365185a4 soundwire: stream: Move remaining regi=
ster accesses over to no_pm)
Merging extcon/extcon-next (5313121b22fd extcon: usbc-tusb320: Convert to i=
2c's .probe_new())
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (70be6f322860 vfio/mlx5: error pointer dereference in err=
or handling)
Merging staging/staging-next (88603b6dc419 Linux 6.2-rc2)
Merging counter-next/counter-next (1b929c02afd3 Linux 6.2-rc1)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (ab223bc0edd2 dt-bindings: dma: qcom: gpi: add compa=
tible for sm8550)
Merging cgroup/for-next (980660cae799 docs: cgroup-v1: use numbered lists f=
or user interface setup)
Merging scsi/for-next (dfc05e6aca60 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (2d95c6deb64d Merge patch series "scsi: ufs: core=
: Always read the descriptors with max length")
Merging vhost/linux-next (b00ab69ec381 virtio: vdpa: new SolidNET DPU drive=
r.)
Merging rpmsg/for-next (90d6db82626b Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (f9beb1b2a139 gpio: regmap: use new regmap_=
might_sleep())
Merging gpio-intel/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging pinctrl/for-next (14277fa3ac14 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (afa349bbb5d7 pinctrl: intel: Get rid of unu=
sed members in struct intel_function)
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
Merging rtc/rtc-next (e88f319a2546 rtc: ds1742: use devm_platform_get_and_i=
oremap_resource())
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging ntb/ntb-next (1a3f7484e076 NTB: ntb_transport: fix possible memory =
leak while device_register() fails)
Merging seccomp/for-next/seccomp (88603b6dc419 Linux 6.2-rc2)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging nvmem/for-next (e5e0a06796b0 dt-bindings: nvmem: Fix spelling mista=
ke "platforn" -> "platform")
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (32c97d980e2e x86/hyperv: Remove unregister sysc=
ore call from Hyper-V cleanup)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (1b929c02afd3 Linux 6.2-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (1a6bd3fd0d9d mhi: Update Makefile to used Kconfig fla=
gs)
Merging memblock/for-next (80c2fe022ef5 memblock tests: remove completed TO=
DO item)
Merging cxl/next (589c3357370a PCI/CXL: Export native CXL error reporting c=
ontrol)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (1b929c02afd3 Linux 6.2-rc1)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (ca0a62c99a1b Merge branch 'slab/for-6.3/cleanups' in=
to slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (4dd6da345ac2 landlock: Explain file descriptor acces=
s rights)
Merging rust/rust-next (b9ecf9b9ac59 rust: types: add `Opaque` type)
Merging sysctl/sysctl-next (0dff89c4488f sched: Move numa_balancing sysctls=
 to its own file)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in fs/hugetlbfs/inode.c
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
CONFLICT (content): Merge conflict in mm/zsmalloc.c
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (2386459394d2 lib/cpumask: update comment fo=
r cpumask_local_spread())
Merging hte/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging kspp/for-next/kspp (439a1bcac648 fortify: Use __builtin_dynamic_obj=
ect_size() when available)
Merging kspp-gustavo/for-next/kspp (b942a520d9e4 bcache: Replace zero-lengt=
h arrays with DECLARE_FLEX_ARRAY() helper)
Merging iommufd/for-next (b7bfaa761d76 Linux 6.2-rc3)
Merging mm-stable/mm-stable (a7383cfbda1d Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (7e45f8095574 Merge branch 'master'=
 into mm-nonmm-stable)
Merging mm/mm-everything (879ab834621f Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in Documentation/admin-guide/cgroup-v1/m=
emory.rst
CONFLICT (content): Merge conflict in fs/buffer.c

--Sig_/xk=MqL3xMcHw1Dayo.yTs.n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO81ugACgkQAVBC80lX
0GxLfggAk2SGUSgOOhO4tiTDwVN1KUo6+s4VPfntJ0547Oy30D0/bOE12B8OhUsU
6eSUau3N1efKDFdPP4L6ab6pO4Go5KlM5o7Z+bExPMLVOkg1xGA9WCtrBjUr+dRc
JdhVoSL3+XLYfVo17GR50QCu7tdl4YWdBLA8SkgM3v7GGFSPGF2//U/Z1spgge/W
E79bdsl9i9BTCaRZ7UCaLeWM2uabxHqu0tcHn5E67OXA1OHUIPGEkFcmwuPqW6UJ
d9rj/LYWvvHoSQ+olDIfc30o1Y3lmN9Kn8P6DD+7qBF1W9z23qxU8XIXDR/nkfoM
B+FdAFv1DIBR6TGpWIf3jZuHI4fX3A==
=duAL
-----END PGP SIGNATURE-----

--Sig_/xk=MqL3xMcHw1Dayo.yTs.n--
