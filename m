Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC275B57EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiILKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiILKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:09:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE23273F;
        Mon, 12 Sep 2022 03:09:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MR2QF2WWXz4xG7;
        Mon, 12 Sep 2022 20:09:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662977381;
        bh=5tnGPyHgTsdyTMU/D/dfRms+GH+Dd+TJevYnfsYOhqc=;
        h=Date:From:To:Cc:Subject:From;
        b=rU4fXOcuHMJAINnh2+ClMKd41BVK2GJZeY06ijC/Wi/zblmwuEFm6IxRzvUFXq4Px
         WYFiHAehJyaAxlCJYzs16sS4sTioFua1yiVodVSS+lsIYT+JX8WBxLD25O7VnCUfSM
         uiKCdeDBGkDuEARSbFyNcx+tbd9QwKN11y04zsroRAKsdFTwsudpZvhbab0OiHUjL2
         YNlJcIaODzER4mDZUhs2RQCAl6k53yFMTqIqkCwIINlqUf96lgnYc1VWnfH1hFoSKu
         UZTYzHKSBGqcyd0hG3gu8MxXi8nrsYZpERXRNJ8DjJEdNnhzyMy855VRNV30dpxU5Q
         8HZ6RCxtbmTXg==
Date:   Mon, 12 Sep 2022 20:09:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 12
Message-ID: <20220912200937.10563adb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zw3l3wSOM4j6mcVEugAO5R9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zw3l3wSOM4j6mcVEugAO5R9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220909:

The kbuild tree lost its build failure.

The drm-intel tree gained a conflict against the drm tree.

The battery tree gained a conflict against the i2c tree.

The coresight tree gained a semantic conflict against the iommu tree.

The cgroup tree gained conflicts against the tip tree.

The rust tree gained conflicts against Linus' tree.

Non-merge commits (relative to Linus' tree): 6004
 7686 files changed, 371734 insertions(+), 167513 deletions(-)

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

I am currently merging 358 trees (counting Linus' and 98 trees of bug
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
Merging origin/master (80e78fcce86d Linux 6.0-rc5)
Merging fixes/fixes (1c23f9e627a7 Linux 6.0-rc2)
Merging mm-hotfixes/mm-hotfixes-unstable (f7791e6177fb mm: bring back updat=
e_mmu_cache() to finish_fault())
Merging kbuild-current/fixes (c17a2538704f mksysmap: Fix the mismatch of 'L=
0' symbols in System.map)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (25af7406df59 ARM: 9229/1: amba: Fix use-after-fr=
ee in amba_read_periphid())
Merging arm64-fixes/for-next/fixes (3fe3fd5f3072 arm64: mm: fix resume for =
52-bit enabled builds)
Merging arm-soc-fixes/arm/fixes (02181e68275d ARM: dts: fix Moxa SDIO 'comp=
atible', remove 'sdhci' misnomer)
Merging drivers-memory-fixes/fixes (c941e6305958 dt-bindings: memory-contro=
llers: fsl,imx8m-ddrc: drop Leonard Crestez)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (b508128bb0d1 m68k: defconfig: Update defcon=
figs for v5.19-rc1)
Merging powerpc-fixes/fixes (a66de5283e16 powerpc/pseries: Fix plpks crash =
on non-pseries)
Merging s390-fixes/fixes (8d96bba75a43 s390/smp: enforce lowcore protection=
 on CPU restart)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (64ae13ed4784 net: core: fix flow symmetric hash)
Merging bpf/master (a37a32583e28 bpf: btf: fix truncated last_member_type_i=
d in btf_struct_resolve)
Merging ipsec/master (26dbd66eab80 esp: choose the correct inner protocol f=
or GSO on inter address family tunnels)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (4d8421f2dd88 wifi: iwlwifi: don't spam logs with=
 NSS>2 messages)
Merging rdma-fixes/for-rc (a261786fdc0a RDMA/irdma: Report RNR NAK generati=
on in device caps)
Merging sound-current/for-linus (ead3d3c5b54f ALSA: hda: Fix hang at HD-aud=
io codec unbinding due to refcount saturation)
Merging sound-asoc-fixes/for-linus (b1cd3fd42db7 ASoC: fsl_aud2htx: Add err=
or handler for pm_runtime_enable)
Merging regmap-fixes/for-linus (f5723cfc0193 regmap: spi: Reserve space for=
 register address/padding)
Merging regulator-fixes/for-linus (475043fabe8c regulator: Fix qcom,spmi-re=
gulator schema)
Merging spi-fixes/for-linus (9c9c9da7aa10 spi: spi: Fix queue hang if previ=
ous transfer failed)
Merging pci-current/for-linus (0e1fa5155a36 MAINTAINERS: Add Mahesh J Salga=
onkar as EEH maintainer)
Merging driver-core.current/driver-core-linus (ce888220d5c7 Merge tag 'scsi=
-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging tty.current/tty-linus (1d10cd4da593 serial: tegra-tcu: Use uart_xmi=
t_advance(), fixes icount.tx accounting)
Merging usb.current/usb-linus (91062e663b26 usb: dwc3: core: leave default =
DMA if the controller does not support 64-bit DMA)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (7e18e42e4b28 Linux 6.0-rc4)
Merging phy/fixes (0a6fc70d76bd phy: marvell: phy-mvebu-a3700-comphy: Remov=
e broken reset support)
Merging staging.current/staging-linus (7e18e42e4b28 Linux 6.0-rc4)
Merging iio-fixes/fixes-togreg (f57f4fb09850 iio: light: tsl2583: Fix modul=
e unloading)
Merging counter-fixes/fixes-togreg (568035b01cfb Linux 6.0-rc1)
Merging char-misc.current/char-misc-linus (ab0b4b575b46 Merge tag 'phy-fixe=
s-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into =
char-misc-linus)
Merging soundwire-fixes/fixes (4ef3f2aff126 soundwire: qcom: fix device sta=
tus array range)
Merging thunderbolt-fixes/fixes (14c7d9052837 thunderbolt: Add support for =
Intel Maple Ridge single port controller)
Merging input-current/for-linus (9c9c71168f79 Input: iforce - add support f=
or Boeder Force Feedback Wheel)
Merging crypto-current/master (874b301985ef crypto: lib - remove unneeded s=
election of XOR_BLOCKS)
Merging vfio-fixes/for-linus (873aefb376bb vfio/type1: Unpin zero pages)
Merging kselftest-fixes/fixes (bdbf0617bbc3 selftests/vm: fix inability to =
build any vm tests)
Merging modules-fixes/modules-linus (e69a66147d49 module: kallsyms: Ensure =
preemption in add_kallsyms() with PREEMPT_RT)
Merging dmaengine-fixes/fixes (e0f1b21c504f dmaengine: zynqmp_dma: Typecast=
 with enum to fix the coverity warning)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (0fddf9ad06fd mtd: rawnand: gpmi: Set WAIT_FOR_=
READY timeout based on program/erase times)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (150f7b11cb59 media: uvcvideo: Fix InterfacePro=
tocol for Quanta camera)
Merging reset-fixes/reset/fixes (51fd191422d9 reset: microchip-sparx5: issu=
e a reset on startup)
Merging mips-fixes/mips-fixes (727488e305b2 mips: Select SPARSEMEM_EXTREME)
Merging at91-fixes/at91-fixes (3d074b750d2b ARM: dts: at91: sama5d2_icp: do=
n't keep vdd_other enabled all the time)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (29250ba51bc1 Merge tag 'kvm-s390-master-6.0-1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvms390-fixes/master (ca922fecda6c KVM: s390: pci: Hook to access K=
VM lowlevel from VFIO)
Merging hwmon-fixes/hwmon (88700d1396ba hwmon: (asus-ec-sensors) autoload m=
odule via DMI data)
Merging nvdimm-fixes/libnvdimm-fixes (17d9c15c9b9e fsdax: Fix infinite loop=
 in dax_iomap_rw())
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (351ff18f7481 Merge branch 'misc-6.0' into n=
ext-fixes)
Merging vfs-fixes/fixes (3f61631d47f1 take care to handle NULL ->proc_lseek=
())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (647e82dbf851 platform/x86: p2sb: Fix UAF w=
hen caller uses resource name)
Merging samsung-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-samsung-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging devicetree-fixes/dt/linus (12ef2508f33d dt-bindings: interconnect: =
fsl,imx8m-noc: drop Leonard Crestez)
Merging dt-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging scsi-fixes/fixes (991df3dd5144 scsi: mpt3sas: Fix use-after-free wa=
rning)
Merging drm-fixes/drm-fixes (2edb79a5fb30 Merge tag 'drm-intel-fixes-2022-0=
9-08' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (151e0e0fdb4d drm/i915: consid=
er HAS_FLAT_CCS() in needs_ccs_pages)
Merging mmc-fixes/fixes (63f1560930e4 mmc: core: Fix inconsistent sd3_bus_m=
ode at UHS-I SD voltage switch failure)
Merging rtc-fixes/rtc-fixes (568035b01cfb Linux 6.0-rc1)
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (f0880e2cb7e1 Drivers: hv: Never allocate=
 anything besides framebuffer from framebuffer memory region)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (20e0fbab1600 perf: RISC-V: fix access beyond al=
located array)
Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use a=
n mpfs specific l2 compatible)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging spdx/spdx-linus (568035b01cfb Linux 6.0-rc1)
Merging gpio-brgl-fixes/gpio/for-current (826e0f2b3ba9 MAINTAINERS: Update =
HiSilicon GPIO Driver maintainer)
Merging gpio-intel-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-intel-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging erofs-fixes/fixes (2f44013e3998 erofs: fix pcluster use-after-free =
on UP platforms)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (2a2dfc869d33 tools: Add new "test" taint t=
o kernel-chktaint)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (00801cd92d91 NFSD: fix regression with setting AC=
Ls.)
Merging irqchip-fixes/irq/irqchip-fixes (c3e88d91e409 irqchip/stm32-exti: R=
emove check on always false condition)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (b6fa04765857 Merge branch 'drivers/fixes' int=
o fixes)
Merging perf-current/perf/urgent (9b4509495418 Merge tag 'for-6.0-rc4-tag' =
of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging efi-fixes/urgent (9cb636b5f6a8 efi: capsule-loader: Fix use-after-f=
ree in efi_capsule_write)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (9db5f08ca99d power: supply: ab8500: remove unu=
sed static local variable)
Merging drm-misc-fixes/for-linux-next-fixes (35b513a74eab drm/rockchip: vop=
2: Fix eDP/HDMI sync polarities)
Merging kbuild/for-next (1889bf68ff23 kbuild: use objtool-args-y to clean u=
p objtool arguments)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (62e64c9d2fd1 perf test: Add basic core_wide express=
ion test)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (9fc18f6d56d5 dma-mapping: mark dma_supported =
static)
Merging asm-generic/master (773428ffd867 asm-generic: Remove empty #ifdef S=
A_RESTORER)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (5d6dd664478f Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (daecb3077f33 Merge branches 'for-next/misc', '=
for-next/kselftest', 'for-next/doc', 'for-next/sve', 'for-next/sysreg', 'fo=
r-next/gettimeofday', 'for-next/stacktrace' and 'for-next/atomics' into for=
-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (476384181508 soc: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (727d51a3ed30 Merge branch 'v6.1/dt64' into for-ne=
xt)
Merging aspeed/for-next (7bc156fbb726 ARM: config: aspeed_g5: Enable PECI)
Merging at91/at91-next (778dde11ccc0 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (122de0c73256 Merge branch 'maintainers/next' into ne=
xt)
Merging drivers-memory/for-next (f492ddd4aaad Merge branch 'for-v6.1/mediat=
ek' into for-next)
Merging imx-mxs/for-next (bf6d46c1da57 Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (63c8a3297683 Merge branch 'v6.0-next/soc' into f=
or-next)
Merging mvebu/for-next (74de3ae81a42 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ce9683e3d9d3 Merge branch 'omap-for-v6.1/omap1' into=
 for-next)
Merging qcom/for-next (44c02daba451 Merge branches 'arm64-defconfig-for-6.1=
', 'arm64-for-6.1', 'clk-for-6.1', 'defconfig-for-6.1', 'drivers-for-6.1', =
'dts-for-6.1' and 'arm64-fixes-for-6.0' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (3319a5eda420 Merge branch 'renesas-arm-dt-for-v6.1' i=
nto renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (072b2cecbc26 Merge branch 'v6.1-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (37ff5e2f7bd2 Merge branch 'next/drivers' int=
o for-next)
Merging scmi/for-linux-next (a4c48536da97 Merge branch 'for-next/ffa' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-lin=
ux-next)
Merging stm32/stm32-next (0c8d51cb3762 ARM: dts: stm32: Create separate pin=
mux for qspi cs pin in stm32mp15-pinctrl.dtsi)
Merging sunxi/sunxi/for-next (ebb11236fe25 Merge branch 'sunxi/drivers-fixe=
s-for-6.0' into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (64356f126a65 Merge branch for-6.1/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (acf3fdc88665 arm64: dts: ti: k3-am625-sk: Add epwm node=
s)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (de86412dc79f Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (9dfb5937c56b clk: imx93: add SAI IPG clk)
Merging clk-renesas/renesas-clk (e312ae92077f dt-bindings: clock: renesas,r=
zg2l: Document RZ/Five SoC)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (45fef4c4b9c9 csky: abiv1: Fixup compile error)
Merging loongarch/loongarch-next (b90cb1053190 Linux 6.0-rc3)
Merging m68k/for-next (feb159347bb0 m68k: Allow kexec on M68KCLASSIC with M=
MU enabled only)
Merging m68knommu/for-next (7728140c8971 m68knommu: fix non-mmu classic 680=
00 legacy timer tick selection)
Merging microblaze/next (568035b01cfb Linux 6.0-rc1)
Merging mips/mips-next (568035b01cfb Linux 6.0-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (52e0ea900202 openrisc: io: Define iounmap argume=
nt as volatile)
Merging parisc-hd/for-next (b3b4f321a9ca parisc: ccio-dma: Add missing ioun=
map in error path in ccio_probe())
Merging powerpc/next (78c73c80fd86 powerpc/math-emu: Inhibit W=3D1 warnings)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (096b52fd2bb4 perf: RISC-V: throttle perf events)
Merging risc-v-mc/dt-for-next (7eac0081a8e9 riscv: dts: microchip: add qspi=
 compatible fallback)
Merging s390/for-next (acc77188e805 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (af3e16101cee um: include sys/types.h for size_t)
Merging xtensa/xtensa-for-next (0847d167d0f9 xtensa: enable ARCH_HAS_GCOV_P=
ROFILE_ALL)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (6344e66970c6 xattr: constify value argument=
 in vfs_setxattr())
Merging fscrypt/master (18136e49cb00 fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (884d0cd9fa6a Merge branch 'for-next-next-v6.0-20220=
907' into for-next-20220907)
Merging ceph/master (0edddc4160b9 ceph: remove Sage's git tree from documen=
tation)
Merging cifs/for-next (7e18e42e4b28 Linux 6.0-rc4)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (2f44013e3998 erofs: fix pcluster use-after-free on UP pl=
atforms)
Merging exfat/dev (2e9ceb6728f1 exfat: fix overflow for large capacity part=
ition)
Merging ext3/for_next (f847c74d6e89 fsnotify: remove unused declaration)
Merging ext4/dev (d95efb14c0b8 ext4: add ioctls to get/set the ext4 superbl=
ock uuid)
Merging f2fs/dev (7929216c2c33 f2fs: let FI_OPU_WRITE override FADVISE_COLD=
_BIT)
Merging fsverity/fsverity (8377e8a24bba fs-verity: use kmap_local_page() in=
stead of kmap())
Merging fuse/for-next (247861c325c2 fuse: retire block-device-based superbl=
ock on force unmount)
Merging gfs2/for-next (204c0300c4e9 gfs2: Switch from strlcpy to strscpy)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (8c9073fa857c ksmbd: constify struct path)
Merging nfs/linux-next (13bd90141804 Revert "SUNRPC: Remove unreachable err=
or condition")
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (fd5d08e3d817 nfsd: remove nfsd4_prepare_cb_recall() =
declaration)
Merging ntfs3/master (3b06a2755758 Merge tag 'ntfs3_for_6.0' of https://git=
hub.com/Paragon-Software-Group/linux-ntfs3)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (4f1196288dfb ovl: fix spelling mistakes)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (02ed50db058d net/9p: allocate appropriate reduced mes=
sage buffers)
Merging xfs/for-next (031d166f968e xfs: fix inode reservation space for rem=
oving transaction)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (478af190cb6c iomap: remove iomap_writepage)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of g=
it://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging vfs/for-next (0a97e98ab197 Merge branches 'work.path' and 'work.fil=
e_inode' into for-next)
Merging printk/for-next (c0a684057235 Merge branch 'for-6.1/trivial' into f=
or-next)
Merging pci/next (68fca83a3783 Merge branch 'remotes/lorenzo/pci/qcom')
Merging pstore/for-next/pstore (27001e611bb6 pstore/zone: Use GFP_ATOMIC to=
 allocate zone buffer)
Merging hid/for-next (d9c1c1a0a501 Merge branch 'for-6.1/logitech' into for=
-next)
Merging i2c/i2c/for-next (12452662e011 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (568035b01cfb Linux 6.0-rc1)
Merging dmi/dmi-for-next (d2139dfca361 firmware: dmi: Use the proper access=
or for the version field)
Merging hwmon-staging/hwmon-next (6fe898634301 hwmon: (mr75203) skip reset-=
control deassert for SOCs that don't support it)
Applying: hwmon: (emc2305) fix up for "i2c: Make remove callback return voi=
d"
Merging jc_docs/docs-next (7ebeef22dcc2 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (fbb6c848dd89 media: destage Hantro VPU driver)
Merging v4l-dvb-next/master (f7ec3f62d773 media: remove reference to CONFIG=
_EMBEDDED in MEDIA_SUPPORT_FILTER)
Merging pm/linux-next (2bc2aea001d3 Merge branch 'acpi-bus' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (ddf958f39741 cpufreq: tegra194:=
 Remove the unneeded result variable)
Merging cpupower/cpupower (568035b01cfb Linux 6.0-rc1)
Merging devfreq/devfreq-next (68831c5f94cb PM / devfreq: mtk-cci: Handle sr=
am regulator probe deferral)
Merging opp/opp/linux-next (c7e31e36d8a2 dt-bindings: opp: Add missing (une=
valuated|additional)Properties on child nodes)
Merging thermal/thermal/linux-next (7be4288625df thermal/of: Remove the the=
rmal_zone_of_get_sensor_id() function)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (56171e0db23a fs: dlm: const void resource name parameter)
Merging rdma/for-next (db77d84cfe36 RDMA/rtrs-clt: Kill xchg_paths)
Merging net-next/master (169ccf0e4082 net: openvswitch: fix repeated words =
in comments)
Merging bpf-next/for-next (f7c946f288e3 selftests/bpf: fix ct status check =
in bpf_nf selftests)
Merging ipsec-next/master (50c448bbc198 Merge remote-tracking branch 'xfrm:=
 start adding netlink extack support')
CONFLICT (content): Merge conflict in include/net/dst_metadata.h
Merging mlx5-next/mlx5-next (8477a2eecbd9 Merge branch 'mlx5-vfio' into mlx=
5-next)
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/fw.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/main.c
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (dd0a1794f433 Bluetooth: btintel: Mark Intel contr=
oller to support LE_STATES quirk)
Merging wireless-next/for-next (8f15a8d6786c wifi: b43: remove empty switch=
 statement)
Merging mtd/mtd/next (7ec4cdb32173 mtd: core: check partition before derefe=
rence)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (96d3e6f05f5b crypto: nx - Remove the unneeded result=
 variable)
Merging drm/drm-next (89b03aeaef16 drm/vkms: fix 32bit compilation error by=
 replacing macros)
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_hdmi.c
Merging drm-misc/for-linux-next (aaa65520280e drm/vkms: fix variable derefe=
renced before check warning)
Merging amdgpu/drm-next (780244a2fe8a drm/amd/amdgpu: Add missing CGTS*TCC_=
DISABLE to 10.3 headers)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.c
Merging drm-intel/for-linux-next (3fecf93c8608 drm/i915: Use REG_FIELD_GET(=
) to extract skl+ wm latencies)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/icl_dsi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ba=
cklight.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_bi=
os.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_bw=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/vlv_dsi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_pm.c
Merging drm-tegra/for-next (135f4c551d51 drm/tegra: vic: Use devm_platform_=
ioremap_resource())
Merging drm-msm/msm-next (d6463fd4e975 drm/msm/a6xx: Handle GMU prepare-slu=
mber hfi failure)
Merging drm-msm-lumag/msm-next-lumag (39b34f1ed43e Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i' and 'msm-next-lumag-hdmi' into msm-next-lumag)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/msm_gem.h
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (332f847212e4 drm/etnaviv: reap idle mapping i=
f it doesn't match the softpin address)
Merging fbdev/for-next (1c23f9e627a7 Linux 6.0-rc2)
Merging regmap/for-next (2049c2d39f2d Merge remote-tracking branch 'regmap/=
for-6.1' into regmap-next)
Merging sound/for-next (5b4fc3956bfd sound: oss: dmasound: remove software_=
input_volume declaration)
Merging sound-asoc/for-next (24bd49605a74 Merge remote-tracking branch 'aso=
c/for-6.1' into asoc-next)
Merging modules/modules-next (77d6354bd422 module/decompress: generate sysf=
s string at compile time)
Merging input/next (e23c69e33248 Input: xpad - add support for XBOX One Eli=
te paddles)
Merging block/for-next (99820f5e8777 Merge branch 'for-6.1/io_uring' into f=
or-next)
Merging device-mapper/for-next (c8e2f5c3682d dm verity: enable WQ_HIGHPRI o=
n verify_wq)
Merging libata/for-next (e9892dce44f2 ata: pata_macio: Remove unneeded word=
 in comments)
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (11c528aacde7 dt-bindings: mmc: renesas,sdhi: Add iommus p=
roperty)
Merging mfd/for-mfd-next (e00e66be677a dt-bindings: mfd: sprd: Add bindings=
 for ums512 global registers)
CONFLICT (modify/delete): drivers/mfd/intel_soc_pmic_core.c deleted in mfd/=
for-mfd-next and modified in HEAD.  Version HEAD of drivers/mfd/intel_soc_p=
mic_core.c left in tree.
$ git rm -f drivers/mfd/intel_soc_pmic_core.c
Applying: mfd: fix up for "i2c: Make remove callback return void"
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (f52c4d5f0bb4 power: supply: bq27xxx: fix NULL vs =
0 warnings)
CONFLICT (content): Merge conflict in drivers/power/supply/cw2015_battery.c
Merging regulator/for-next (83dcfc5e1ee1 Merge remote-tracking branch 'regu=
lator/for-6.1' into regulator-next)
Merging security/next (abec3d015fdf userfaultfd: open userfaultfds with O_R=
DONLY)
CONFLICT (content): Merge conflict in security/selinux/include/classmap.h
Merging apparmor/apparmor-next (79eb2711c919 apparmor: correct config refer=
ence to intended one)
Merging integrity/next-integrity (5926586f291b ima: fix blocking of securit=
y.ima xattrs of unsupported algorithms)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (6354324d8a3e selinux: declare read-only parameters co=
nst)
Merging smack/next (6dc5849dc6a9 SMACK: Add sk_clone_security LSM hook)
Merging tomoyo/master (841b171b4534 locking/lockdep: add debug_show_all_loc=
k_holders())
Merging tpmdd/next (863ed94c589f tpm: Add check for Failure mode for TPM2 m=
odules)
Merging watchdog/master (b90cb1053190 Linux 6.0-rc3)
Merging iommu/next (d154e4a92f79 Merge branches 'iommu/fixes', 'arm/omap', =
'virtio', 'x86/amd' and 'core' into next)
Merging audit/next (934f70d9d498 audit: remove selinux_audit_rule_update() =
declaration)
Merging devicetree/for-next (547bed8140cc dt-bindings: remoteproc: qcom,smd=
-edge: define children)
Merging dt-krzk/for-next (a70369e1b7f6 ARM: dts: sunplus: sp7021: drop inco=
rrect spi-max-frequency)
Merging mailbox/mailbox-for-next (8a8dc2b9596e mailbox: imx: clear pending =
interrupts)
Merging spi/for-next (86f7571b053d Merge remote-tracking branch 'spi/for-6.=
1' into spi-next)
Merging tip/master (746afd7df756 Merge branch into tip/master: 'x86/timers')
Merging clockevents/timers/drivers/next (c19e18637d89 clocksource/drivers/s=
un4i: Remove unnecessary (void*) conversions)
Merging edac/edac-for-next (cd687f34d565 Merge branch 'edac-misc' into edac=
-for-next)
Merging irqchip/irq/irqchip-next (2bd1753e8c43 Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (07a451dae367 Merge branch 'trace/for-next-core' in=
to trace/for-next)
Merging rcu/rcu/next (7139c19d2ea1 rcu: Synchronize ->qsmaskinitnext in rcu=
_boost_kthread_setaffinity())
Merging kvm/next (372d07084593 KVM: selftests: Fix ambiguous mov in KVM_ASM=
_SAFE())
Merging kvm-arm/next (0982c8d859f8 Merge branch kvm-arm64/nvhe-stacktrace i=
nto kvmarm-master/next)
Merging kvms390/next (f5ecfee94493 KVM: s390: resetting the Topology-Change=
-Report)
Merging xen-tip/linux-next (e9ea0b30ada0 xen/grants: prevent integer overfl=
ow in gnttab_dma_alloc_pages())
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (76fba1221e30 Merge tag 'backlight-detect-refa=
ctor-1' into review-hans)
Merging chrome-platform/for-next (20dfb7478309 platform/chrome: cros_typec_=
switch: Inline DRV_NAME)
Merging hsi/for-next (551e325bbd3f HSI: omap_ssi_port: Fix dma_map_sg error=
 check)
Merging leds/for-next (568035b01cfb Linux 6.0-rc1)
Merging ipmi/for-next (ba5829c6543f ipmi:ipmb: Fix a vague comment and a ty=
po)
Merging driver-core/driver-core-next (d11b1e908e9a driver core: remove make=
_class_name declaration)
Merging usb/usb-next (7eb2bf871454 usb: misc: usb3503: call clk_disable_unp=
repare in the error handling)
Merging thunderbolt/next (387a42cfcf92 thunderbolt: Fix spelling mistake "s=
imultaneusly" -> "simultaneously")
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (7e18e42e4b28 Linux 6.0-rc4)
Merging tty/tty-next (ccf3a570410a termios: kill uapi termios.h that are id=
entical to generic one)
Merging char-misc/char-misc-next (ceecbbddbf54 comedi: convert sysfs snprin=
tf to sysfs_emit)
Merging coresight/next (366317eae983 MAINTAINERS: Add maintainer for HiSili=
con PTT driver)
Merging fpga/for-next (562d0bf2cab8 fpga: m10bmc-sec: d5005 bmc secure upda=
te driver)
Merging icc/icc-next (aff72c797ff0 Merge branch 'icc-ignore-return-val' int=
o icc-next)
Merging iio/togreg (2f61ff827296 iio: pressure: icp10100: Switch from UNIVE=
RSAL to DEFINE_RUNTIME_DEV_PM_OPS().)
Merging phy-next/next (f340ed8664a5 phy: rockchip-inno-usb2: Return zero af=
ter otg sync)
Merging soundwire/next (279e46bc2986 soundwire: intel: cleanup WakeEnable a=
nd WakeStatus)
Applying: hwtracing: hihi_ptt: fix up for "iommu/dma: Make header private"
Merging extcon/extcon-next (822a6200734c extcon: usbc-tusb320: Add USB TYPE=
-C support)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (f39856aacb07 vfio/mlx5: Set the driver DMA logging callb=
acks)
Merging staging/staging-next (a90044ef5605 staging: rtl8723bs: Fix return t=
ype for implementation of ndo_start_xmit)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (84dd3b2b95ef dmaengine: dw-axi-dmac: Drop obsolete =
dependency on COMPILE_TEST)
Merging cgroup/for-next (a2675ab75dff Merge branch 'for-6.1' into for-next)
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
Applying: sched/psi: fix up for "cgroup: Remove CFTYPE_PRESSURE"
Merging scsi/for-next (002e36fc62e9 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (efca52749564 scsi: qla2xxx: Fix spelling mistake=
 "definiton" -> "definition")
Merging vhost/linux-next (8f113a4ad40d virtio: drop vp_legacy_set_queue_siz=
e)
Merging rpmsg/for-next (8e91742629fe Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (3af20d2723be dt-bindings: gpio: renesas,rc=
ar-gpio: Add r8a779g0 support)
Merging gpio-intel/for-next (0ea76c401f92 gpiolib: acpi: Add a quirk for As=
us UM325UAZ)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (1bac51bb77cc Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-renesas/renesas-pinctrl (96355be8f0a2 dt-bindings: pinctrl:=
 renesas: Document RZ/Five SoC)
Merging pinctrl-samsung/for-next (9d9292576810 dt-bindings: pinctrl: samsun=
g: deprecate header with register constants)
Merging pwm/for-next (8933d30c5f46 pwm: lpc18xx: Fix period handling)
Merging userns/for-next (a0b88362d2c7 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, and retire_mq=
_sysctls-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (9d732f16cb16 cpufreq: amd-pstate: Add explanation f=
or X86_AMD_PSTATE_UT)
CONFLICT (content): Merge conflict in drivers/cpufreq/amd-pstate.c
Merging livepatching/for-next (3ea7cd6069be Merge branch 'for-6.1/fixes' in=
to for-next)
Merging rtc/rtc-next (509451ac03eb rtc: gamecube: Always reset HW_SRNPROT a=
fter read)
Merging nvdimm/libnvdimm-for-next (53fc59511fc4 nvdimm/namespace: drop unne=
eded temporary variable in size_store())
Merging at24/at24/for-next (568035b01cfb Linux 6.0-rc1)
Merging ntb/ntb-next (568035b01cfb Linux 6.0-rc1)
Merging seccomp/for-next/seccomp (4e92863862d1 Merge branch 'for-linus/secc=
omp' into for-next/seccomp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (04823dd2af87 fsi: master-ast-cf: Fix missing of_node_put =
in fsi_master_acf_probe)
Merging slimbus/for-next (3f9400e61107 slimbus: qcom-ngd: simplify error pa=
ths with dev_err_probe)
Merging nvmem/for-next (2ea556524fbf dt-bindings: nvmem: Add SoC compatible=
 for sm6115)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (d180e0a1be6c Drivers: hv: Create debugfs file w=
ith hyper-v balloon usage information)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (568035b01cfb Linux 6.0-rc1)
Merging kunit/test (568035b01cfb Linux 6.0-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (568035b01cfb Linux 6.0-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (5db00d7d0d4d bus: mhi: host: always print detected mo=
dem name)
Merging memblock/for-next (42c3ba865818 memblock_tests: move variable decla=
rations to single block)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (1cd8a2537eb0 cxl/hdm: Fix skip allocations vs multiple pm=
em allocations)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (4bf232988200 Merge tag 'efi-loongarch-for-v6.1' into efi/=
next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (0e5d069dcc0c Merge branch 'slab/for-6.1/slub_validat=
ion_locking' into slab/for-next)
Merging random/master (b931eaf6ef5c random: restore O_NONBLOCK support)
Merging landlock/next (c6bea81eb6ef Merge branch 'landlock-next-truncate' i=
nto landlock-next)
Merging rust/rust-next (07a3263c2554 init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in Makefile
Applying: rust: fix up for "kbuild: move core-y and drivers-y to ./Kbuild"
Merging sysctl/sysctl-next (c06a17fe056b kernel/sysctl-test: use SYSCTL_{ZE=
RO/ONE_HUNDRED} instead of i_{zero/one_hundred})
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (1c23f9e627a7 Linux 6.0-rc2)
Merging bitmap/bitmap-for-next (b9be19eef355 drivers/base: Fix unsigned com=
parison to -1 in CPUMAP_FILE_MAX_BYTES)
Merging hte/for-next (568035b01cfb Linux 6.0-rc1)
Merging kspp/for-next/kspp (66cb2a36a96f kunit/memcpy: Avoid pathological c=
ompile-time string size)
CONFLICT (content): Merge conflict in lib/Kconfig.debug
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging mm-stable/mm-stable (088b8aa537c2 mm: fix PageAnonExclusive clearin=
g racing with concurrent RCU GUP-fast)
Merging mm-nonmm-stable/mm-nonmm-stable (b81475117547 latencytop: use the l=
ast element of latency_record of system)
Merging mm/mm-everything (2558c2ced7ce Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in block/blk-map.c
CONFLICT (content): Merge conflict in crypto/Kconfig
CONFLICT (content): Merge conflict in mm/memory-failure.c
CONFLICT (content): Merge conflict in mm/page_alloc.c
CONFLICT (content): Merge conflict in mm/slub.c
CONFLICT (content): Merge conflict in mm/vmscan.c
Applying: mm/slab: fix up for "mm: kmsan: call KMSAN hooks from SLUB code"
Applying: crypto: Kconfig: fix up for "crypto: kmsan: disable accelerated c=
onfigs under KMSAN"
Applying: Revert "drm/msm/gem: Evict active GEM objects when necessary"

--Sig_/zw3l3wSOM4j6mcVEugAO5R9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMfBWEACgkQAVBC80lX
0GyrKwgAn8NSvNDkYE36/DUIf/KghNPRF6Jro0s1OJSeNy4yobPsmKJhlSo71/xm
Oj2TPO4SFfit36ySwcZm6gZ61rXiNlXD4AdKGxdnumgBxNyuOkqN3qfWG39pUToM
+smBPdwe2RT/UlzZ7Lp0VRj3V5Vt4rP/wJXRgIS0vNvZxXICXW+riJH+yYgZdbfv
nUxpZObEapgqUbNwjp00heFDgiqiwgs74HaaaU0wSWh3gfKimsaWlyZ0vUs+BYR2
ryxLZHgBNG0dlyNB4emQjENcYuNltRE1i/ibT3X4jz7Smof5SfpypQWxBDJVlc9Z
USCyvry24MkXMEIJ3vwOhmn/gSJLaA==
=HYb2
-----END PGP SIGNATURE-----

--Sig_/zw3l3wSOM4j6mcVEugAO5R9--
