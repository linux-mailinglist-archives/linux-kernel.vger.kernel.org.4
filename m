Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80F5BC5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiISJrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiISJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:47:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F0113E85;
        Mon, 19 Sep 2022 02:47:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWKbL6gKbz4xD1;
        Mon, 19 Sep 2022 19:47:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663580847;
        bh=rBpXkn2a6r8+DtNnE8DN84WgIOU/7mMfFAngXbcbGQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=SPJU74Z+Rl33AkA+srC2orQUIwhy/miVwavZ16FYsjax+qKPo+x9ctEFQbOXUGauA
         G7eXD/pjdxOMjgPdVuZl9oiLMv9OwYEwjQluT03x+knvPXw4Gm+IwnwfLKMFVNHgaj
         YJHXvlhz3xxPgjdmSAVvwZ6tAT/OdjkuOPC1QtmntMYIEOWHXMBZB9CrNcY6oj62Pq
         vpSViP6GaHh0hMgjMZnZKGF6jlvidzeszp3khhcswwQ3G16G9D+xfzU8cl3j2qyMSS
         fTx5MjtqIvGpPw4UdCdpyc+PY/uLqsl3iAiTKr3lSec0rZlnk+0cxiDHK6dNsUvgK0
         HGeC+OYnH6kXw==
Date:   Mon, 19 Sep 2022 19:47:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 19
Message-ID: <20220919194725.32232f61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0tHkmJ6t/sDOUugjqci7+sA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0tHkmJ6t/sDOUugjqci7+sA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220916:

The drm tree gained a conflict against Linus' tree.

The kvm-arm tree gained a conflict against the arm64 tree.

The drivers-x86 tree gained a conflict against the pm tree.

The efi tree gaiined a build failure so I used the version from
next-20220916.

Non-merge commits (relative to Linus' tree): 7173
 8416 files changed, 417008 insertions(+), 182486 deletions(-)

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

I am currently merging 359 trees (counting Linus' and 98 trees of bug
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
Merging origin/master (521a547ced64 Linux 6.0-rc6)
Merging fixes/fixes (1c23f9e627a7 Linux 6.0-rc2)
Merging mm-hotfixes/mm-hotfixes-unstable (3312b0e85108 mm/page_isolation: f=
ix isolate_single_pageblock() isolation behavior)
Merging kbuild-current/fixes (80e78fcce86d Linux 6.0-rc5)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (25af7406df59 ARM: 9229/1: amba: Fix use-after-fr=
ee in amba_read_periphid())
Merging arm64-fixes/for-next/fixes (3fe3fd5f3072 arm64: mm: fix resume for =
52-bit enabled builds)
Merging arm-soc-fixes/arm/fixes (aaa58141a5d7 Merge tag 'at91-fixes-6.0-2' =
of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixe=
s)
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
Merging net/master (96628951869c tcp: Use WARN_ON_ONCE() in tcp_read_skb())
Merging bpf/master (83c10cc362d9 bpf: Ensure correct locking around vulnera=
ble function find_vpid())
Merging ipsec/master (26dbd66eab80 esp: choose the correct inner protocol f=
or GSO on inter address family tunnels)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (781b80f452fc wifi: mt76: fix 5 GHz connection re=
gression on mt76x0/mt76x2)
Merging rdma-fixes/for-rc (a261786fdc0a RDMA/irdma: Report RNR NAK generati=
on in device caps)
Merging sound-current/for-linus (5f80d6bd2b01 ALSA: hda/hdmi: Fix the conve=
rter reuse for the silent stream)
Merging sound-asoc-fixes/for-linus (d56ba9a04d75 ASoC: imx-card: Fix refcou=
nt issue with of_node_put)
Merging regmap-fixes/for-linus (80e78fcce86d Linux 6.0-rc5)
Merging regulator-fixes/for-linus (80e78fcce86d Linux 6.0-rc5)
Merging spi-fixes/for-linus (80e78fcce86d Linux 6.0-rc5)
Merging pci-current/for-linus (0e1fa5155a36 MAINTAINERS: Add Mahesh J Salga=
onkar as EEH maintainer)
Merging driver-core.current/driver-core-linus (d8ab4685adc1 Revert "driver =
core: Set fw_devlink.strict=3D1 by default")
Merging tty.current/tty-linus (1d10cd4da593 serial: tegra-tcu: Use uart_xmi=
t_advance(), fixes icount.tx accounting)
Merging usb.current/usb-linus (ce001778dfc3 Merge tag 'thunderbolt-for-v6.0=
-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt =
into usb-linus)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (d640c4cb8f2f USB: serial: option: add Q=
uectel RM520N)
Merging phy/fixes (0a6fc70d76bd phy: marvell: phy-mvebu-a3700-comphy: Remov=
e broken reset support)
Merging staging.current/staging-linus (7e18e42e4b28 Linux 6.0-rc4)
Merging iio-fixes/fixes-togreg (f57f4fb09850 iio: light: tsl2583: Fix modul=
e unloading)
Merging counter-current/counter-current (8294b04153c3 counter: Realign coun=
ter_comp comment block to 80 characters)
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
Merging mips-fixes/mips-fixes (80e78fcce86d Linux 6.0-rc5)
Merging at91-fixes/at91-fixes (f5fc22cbbdcd ARM: dts: lan966x: Fix the inte=
rrupt number for internal PHYs)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (29250ba51bc1 Merge tag 'kvm-s390-master-6.0-1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvms390-fixes/master (ca922fecda6c KVM: s390: pci: Hook to access K=
VM lowlevel from VFIO)
Merging hwmon-fixes/hwmon (80e78fcce86d Linux 6.0-rc5)
Merging nvdimm-fixes/libnvdimm-fixes (17d9c15c9b9e fsdax: Fix infinite loop=
 in dax_iomap_rw())
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (351ff18f7481 Merge branch 'misc-6.0' into n=
ext-fixes)
Merging vfs-fixes/fixes (bfbfb6182ad1 nfsd_splice_actor(): handle compound =
pages)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (647e82dbf851 platform/x86: p2sb: Fix UAF w=
hen caller uses resource name)
Merging samsung-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-samsung-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging devicetree-fixes/dt/linus (de11663b75b0 dt-bindings: pinctrl: qcom:=
 drop non-working codeaurora.org emails)
Merging dt-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging scsi-fixes/fixes (e0e0747de0ea scsi: mpt3sas: Fix return value chec=
k of dma_get_required_mask())
Merging drm-fixes/drm-fixes (25100377a21a Merge tag 'drm-intel-fixes-2022-0=
9-15' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (8787f6fab413 Revert "drm/i915=
/display: Re-add check for low voltage sku for max dp source rate")
Merging mmc-fixes/fixes (35ca91d1338a mmc: moxart: fix 4-bit bus width and =
remove 8-bit bus width)
Merging rtc-fixes/rtc-fixes (568035b01cfb Linux 6.0-rc1)
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (f0880e2cb7e1 Drivers: hv: Never allocate=
 anything besides framebuffer from framebuffer memory region)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (c589e3ca27c9 RISC-V: Avoid coupling the T-Head =
CMOs and Zicbom)
Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use a=
n mpfs specific l2 compatible)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging spdx/spdx-linus (568035b01cfb Linux 6.0-rc1)
Merging gpio-brgl-fixes/gpio/for-current (09eed5a1ed3c gpio: mt7621: Make t=
he irqchip immutable)
Merging gpio-intel-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-intel-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging erofs-fixes/fixes (80e78fcce86d Linux 6.0-rc5)
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
Merging irqchip-fixes/irq/irqchip-fixes (e7ccba7728cf irqchip/loongson-pch-=
lpc: Add dependence on LoongArch)
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
Merging drm-misc-fixes/for-linux-next-fixes (b0b9408f1326 drm/rockchip: Fix=
 return type of cdn_dp_connector_mode_valid)
Merging kbuild/for-next (5f5ef75d1c4b scripts: remove unused argument 'type=
')
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (62e64c9d2fd1 perf test: Add basic core_wide express=
ion test)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (9fc18f6d56d5 dma-mapping: mark dma_supported =
static)
Merging asm-generic/master (fdc5bebfb66b parisc: hide ioread64 declaration =
on 32-bit)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (5d6dd664478f Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (ebbb0b0b3724 Merge branches 'for-next/misc', '=
for-next/kselftest', 'for-next/doc', 'for-next/sve', 'for-next/sysreg', 'fo=
r-next/gettimeofday', 'for-next/stacktrace', 'for-next/atomics', 'for-next/=
el1-exceptions', 'for-next/a510-erratum-2658417' and 'for-next/alternatives=
' into for-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (d2c3fe578acd Merge branch 'arm/soc' into for-next)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (727d51a3ed30 Merge branch 'v6.1/dt64' into for-ne=
xt)
Merging aspeed/for-next (7bc156fbb726 ARM: config: aspeed_g5: Enable PECI)
Merging at91/at91-next (a3e83ce7ece6 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (122de0c73256 Merge branch 'maintainers/next' into ne=
xt)
Merging drivers-memory/for-next (f492ddd4aaad Merge branch 'for-v6.1/mediat=
ek' into for-next)
Merging imx-mxs/for-next (26f60c42dc9d Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (cbb1618792e2 Merge branch 'v6.0-next/soc' into f=
or-next)
Merging mvebu/for-next (74de3ae81a42 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (8efe5dea6753 Merge branch 'omap-for-v6.1/dt' into fo=
r-next)
Merging qcom/for-next (49a649b9cbf3 Merge branches 'arm64-defconfig-for-6.1=
', 'arm64-for-6.1', 'clk-for-6.1', 'defconfig-for-6.1', 'drivers-for-6.1', =
'dts-for-6.1' and 'arm64-fixes-for-6.0' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (2918d1d088b5 Merge branches 'renesas-arm-dt-for-v6.1'=
 and 'renesas-arm-soc-for-v6.1' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (ecd61e0144d0 Merge branch 'v6.1-clock/next' into=
 for-next)
Merging samsung-krzk/for-next (37ff5e2f7bd2 Merge branch 'next/drivers' int=
o for-next)
Merging scmi/for-linux-next (1f3a176f26cc Merge tag 'ffa-updates-6.1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-lin=
ux-next)
Merging stm32/stm32-next (400a100c28fe ARM: dts: stm32: argon: remove spide=
v node)
Merging sunxi/sunxi/for-next (1cd67985e174 Merge branch 'sunxi/drivers-for-=
6.1' into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (761c03270244 Merge branch for-6.1/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (acf3fdc88665 arm64: dts: ti: k3-am625-sk: Add epwm node=
s)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (de86412dc79f Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (9dfb5937c56b clk: imx93: add SAI IPG clk)
Merging clk-renesas/renesas-clk (e46a1a9943c0 clk: renesas: r8a779g0: Add E=
therAVB clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (45fef4c4b9c9 csky: abiv1: Fixup compile error)
Merging loongarch/loongarch-next (b90cb1053190 Linux 6.0-rc3)
Merging m68k/for-next (feb159347bb0 m68k: Allow kexec on M68KCLASSIC with M=
MU enabled only)
Merging m68knommu/for-next (9ad3a9ca3510 m68knommu: fix non-mmu classic 680=
00 legacy timer tick selection)
Merging microblaze/next (568035b01cfb Linux 6.0-rc1)
Merging mips/mips-next (0153682e9e6a MIPS: dts: lantiq: rename dts files wi=
th soc name being the prefix)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (52e0ea900202 openrisc: io: Define iounmap argume=
nt as volatile)
Merging parisc-hd/for-next (521a547ced64 Linux 6.0-rc6)
Merging powerpc/next (f88aabad33ea Revert "powerpc/rtas: Implement reentran=
t rtas call")
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (096b52fd2bb4 perf: RISC-V: throttle perf events)
Merging risc-v-mc/dt-for-next (7eac0081a8e9 riscv: dts: microchip: add qspi=
 compatible fallback)
Merging s390/for-next (55ee8c8941e4 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (af3e16101cee um: include sys/types.h for size_t)
Merging xtensa/xtensa-for-next (e3ddb8bbe0f8 xtensa: add FDPIC and static P=
IE support for noMMU)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (0978c7c41fe2 acl: fix the comments of posix=
_acl_xattr_set)
Merging fscrypt/master (18136e49cb00 fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (caeaee0f40e2 Merge branch 'for-next-next-v6.0-20220=
913' into for-next-20220913)
Merging ceph/master (0edddc4160b9 ceph: remove Sage's git tree from documen=
tation)
Merging cifs/for-next (521a547ced64 Linux 6.0-rc6)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (80e78fcce86d Linux 6.0-rc5)
Merging exfat/dev (2e9ceb6728f1 exfat: fix overflow for large capacity part=
ition)
Merging ext3/for_next (11fdae37d482 Pull udf splice fix.)
Merging ext4/dev (d95efb14c0b8 ext4: add ioctls to get/set the ext4 superbl=
ock uuid)
Merging f2fs/dev (108d4d310318 f2fs: fix to do sanity check on summary info)
Merging fsverity/fsverity (8377e8a24bba fs-verity: use kmap_local_page() in=
stead of kmap())
Merging fuse/for-next (247861c325c2 fuse: retire block-device-based superbl=
ock on force unmount)
Merging gfs2/for-next (204c0300c4e9 gfs2: Switch from strlcpy to strscpy)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (a0bc3210f376 ksmbd: update documentation)
Merging nfs/linux-next (3245cb65fd91 Merge tag 'devicetree-fixes-for-6.0-2'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux)
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (395289f8a048 NFSD: Return nfserr_serverfault if spli=
ce_ok but buf->pages have data)
CONFLICT (content): Merge conflict in fs/nfsd/vfs.c
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
Merging statx-dioalign/statx-dioalign (61a223df421f xfs: support STATX_DIOA=
LIGN)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of g=
it://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging vfs/for-next (0a97e98ab197 Merge branches 'work.path' and 'work.fil=
e_inode' into for-next)
Merging printk/for-next (c0a684057235 Merge branch 'for-6.1/trivial' into f=
or-next)
Merging pci/next (c327b44793ae Merge branch 'remotes/lorenzo/pci/qcom')
Merging pstore/for-next/pstore (27001e611bb6 pstore/zone: Use GFP_ATOMIC to=
 allocate zone buffer)
Merging hid/for-next (d9c1c1a0a501 Merge branch 'for-6.1/logitech' into for=
-next)
Merging i2c/i2c/for-next (42950eb189c8 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (568035b01cfb Linux 6.0-rc1)
Merging dmi/dmi-for-next (d2139dfca361 firmware: dmi: Use the proper access=
or for the version field)
Merging hwmon-staging/hwmon-next (9f74e9d42e76 hwmon: (emc2305) Remove unne=
cessary range check)
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
Merging thermal/thermal/linux-next (64b269c00227 thermal/core: Add a check =
before calling set_trip_temp())
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (56171e0db23a fs: dlm: const void resource name parameter)
Merging rdma/for-next (db77d84cfe36 RDMA/rtrs-clt: Kill xchg_paths)
Merging net-next/master (44a8535fb87c Merge branch 'octeontx2-cn10k-ptp')
Merging bpf-next/for-next (571f9738bfb3 bpf/btf: Use btf_type_str() wheneve=
r possible)
Merging ipsec-next/master (50c448bbc198 Merge remote-tracking branch 'xfrm:=
 start adding netlink extack support')
CONFLICT (content): Merge conflict in include/net/dst_metadata.h
Merging mlx5-next/mlx5-next (4ced81c02b03 net/mlx5: Add IFC bits and enums =
for crypto key)
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/fw.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/main.c
CONFLICT (content): Merge conflict in include/linux/mlx5/device.h
CONFLICT (content): Merge conflict in include/linux/mlx5/mlx5_ifc.h
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (812e92b824c1 Bluetooth: RFCOMM: Fix possible dead=
lock on socket shutdown/release)
Merging wireless-next/for-next (d5350756c03c wifi: rtl8xxxu: Remove copy-pa=
ste leftover in gen2_update_rate_mask)
Merging mtd/mtd/next (7ec4cdb32173 mtd: core: check partition before derefe=
rence)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (072d36eefd6f crypto: qat - use reference to structur=
e in dma_map_single())
Merging drm/drm-next (d1e2d6b78ffc Merge tag 'drm-intel-next-2022-08-29' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n30/display_mode_vba_30.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/icl_dsi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/vlv_dsi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_hdmi.c
Merging drm-misc/for-linux-next (c989a62484ad drm/gma500: Call acpi_video_r=
egister_backlight())
CONFLICT (content): Merge conflict in drivers/gpu/drm/gma500/power.c
Merging amdgpu/drm-next (dacd2d2d9d80 drm/amd/display: fix boolconv.cocci w=
arning)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn32/=
dcn32_resource_helpers.c
Merging drm-intel/for-linux-next (21f0b7dabf9c drm/i915: Fix return type of=
 mode_valid function hook)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
Applying: drm/i915: fix up for "drm/i915: Rename ggtt_view as gtt_view"
Merging drm-tegra/for-next (4d74f5f6b0be drm/tegra: Convert to using is_hdm=
i from display info)
Merging drm-msm/msm-next (e8b595f7b058 drm/msm/hdmi: make hdmi_phy_8996 OF =
clk provider)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/dsi/dsi_cfg.c
Merging drm-msm-lumag/msm-next-lumag (e8b595f7b058 drm/msm/hdmi: make hdmi_=
phy_8996 OF clk provider)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (61a6920bb604 drm/etnaviv: fix power register =
offset on GC300)
Merging fbdev/for-next (1c23f9e627a7 Linux 6.0-rc2)
Merging regmap/for-next (694cf81e9000 Merge remote-tracking branch 'regmap/=
for-6.1' into regmap-next)
Merging sound/for-next (7883017bbcc5 ALSA: ppc: Switch to use for_each_chil=
d_of_node() macro)
Merging sound-asoc/for-next (5287d5b77fc2 Merge remote-tracking branch 'aso=
c/for-6.1' into asoc-next)
Merging modules/modules-next (77d6354bd422 module/decompress: generate sysf=
s string at compile time)
Merging input/next (437d49b051e8 dt-bindings: input: auo-pixcir-ts: fix gpi=
o and interrupt properties)
Merging block/for-next (52f3156bd209 Merge branch 'for-6.1/block' into for-=
next)
Merging device-mapper/for-next (c8e2f5c3682d dm verity: enable WQ_HIGHPRI o=
n verify_wq)
Merging libata/for-next (e7840a9aae6f MAINTAINERS: Add maintainers for DWC =
AHCI SATA driver)
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (627a78b2dec6 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (e00e66be677a dt-bindings: mfd: sprd: Add bindings=
 for ums512 global registers)
CONFLICT (modify/delete): drivers/mfd/intel_soc_pmic_core.c deleted in mfd/=
for-mfd-next and modified in HEAD.  Version HEAD of drivers/mfd/intel_soc_p=
mic_core.c left in tree.
$ git rm -f drivers/mfd/intel_soc_pmic_core.c
Applying: mfd: fix up for "i2c: Make remove callback return void"
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (55cafd4ba42c power: supply: bq25890: Fix enum con=
version in bq25890_power_supply_set_property())
CONFLICT (content): Merge conflict in drivers/power/supply/cw2015_battery.c
Merging regulator/for-next (663ec13e89b4 Merge remote-tracking branch 'regu=
lator/for-6.1' into regulator-next)
Merging security/next (1e7d8bcbe37d lockdown: ratelimit denial messages)
CONFLICT (content): Merge conflict in security/selinux/include/classmap.h
Merging apparmor/apparmor-next (79eb2711c919 apparmor: correct config refer=
ence to intended one)
Merging integrity/next-integrity (5926586f291b ima: fix blocking of securit=
y.ima xattrs of unsupported algorithms)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (09b71adab095 selinux: remove the unneeded result vari=
able)
Merging smack/next (f393b3fd2a4b smack: cleanup obsolete mount option flags)
Merging tomoyo/master (6879c2d3b960 Merge tag 'pinctrl-v6.0-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl)
Merging tpmdd/next (863ed94c589f tpm: Add check for Failure mode for TPM2 m=
odules)
Merging watchdog/master (b90cb1053190 Linux 6.0-rc3)
Merging iommu/next (d154e4a92f79 Merge branches 'iommu/fixes', 'arm/omap', =
'virtio', 'x86/amd' and 'core' into next)
Merging audit/next (934f70d9d498 audit: remove selinux_audit_rule_update() =
declaration)
Merging devicetree/for-next (a607a850ba1f dt-bindings: nvmem: u-boot,env: a=
dd basic NVMEM cells)
Merging dt-krzk/for-next (a70369e1b7f6 ARM: dts: sunplus: sp7021: drop inco=
rrect spi-max-frequency)
Merging mailbox/mailbox-for-next (68584e380ef5 mailbox: apple: Implement po=
ll_data() operation)
Merging spi/for-next (7f9c088f08cb Merge remote-tracking branch 'spi/for-6.=
1' into spi-next)
Merging tip/master (82eedfedea44 Merge branch into tip/master: 'x86/timers')
Merging clockevents/timers/drivers/next (c19e18637d89 clocksource/drivers/s=
un4i: Remove unnecessary (void*) conversions)
Merging edac/edac-for-next (166b48e4c9e2 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (2bd1753e8c43 Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (07a451dae367 Merge branch 'trace/for-next-core' in=
to trace/for-next)
Merging rcu/rcu/next (7139c19d2ea1 rcu: Synchronize ->qsmaskinitnext in rcu=
_boost_kthread_setaffinity())
Merging kvm/next (372d07084593 KVM: selftests: Fix ambiguous mov in KVM_ASM=
_SAFE())
Merging kvm-arm/next (c317c6d2d2c6 Merge branch kvm-arm64/aarch32-raz-idreg=
s into kvmarm-master/next)
CONFLICT (content): Merge conflict in arch/arm64/kvm/sys_regs.c
Merging kvms390/next (3ed2607b18cc KVM: s390: pci: fix plain integer as NUL=
L pointer warnings)
Merging xen-tip/linux-next (ce6b8ccdef95 xen/xenbus: fix xenbus_setup_ring(=
))
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (8902437ce3e7 leds: simatic-ipc-leds-gpio: Mak=
e simatic_ipc_led_gpio_table static)
CONFLICT (content): Merge conflict in drivers/acpi/acpi_video.c
CONFLICT (content): Merge conflict in drivers/platform/mellanox/mlxreg-lc.c
Merging chrome-platform/for-next (348a2e8c93d3 platform/chrome: cros_ec_typ=
ec: Register partner PDOs)
Merging hsi/for-next (551e325bbd3f HSI: omap_ssi_port: Fix dma_map_sg error=
 check)
Merging leds/for-next (568035b01cfb Linux 6.0-rc1)
Merging ipmi/for-next (ba5829c6543f ipmi:ipmb: Fix a vague comment and a ty=
po)
Merging driver-core/driver-core-next (a791dc135325 Merge 6.0-rc5 into drive=
r-core-next)
Merging usb/usb-next (7eb2bf871454 usb: misc: usb3503: call clk_disable_unp=
repare in the error handling)
Merging thunderbolt/next (387a42cfcf92 thunderbolt: Fix spelling mistake "s=
imultaneusly" -> "simultaneously")
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (cfebcd53e65e USB: serial: ftdi_sio: add suppor=
t for HP and HA devices)
Merging tty/tty-next (ccf3a570410a termios: kill uapi termios.h that are id=
entical to generic one)
Merging char-misc/char-misc-next (ceecbbddbf54 comedi: convert sysfs snprin=
tf to sysfs_emit)
Merging coresight/next (5fc1531dd771 hwtracing: hisi_ptt: Fix up for "iommu=
/dma: Make header private")
Merging fpga/for-next (562d0bf2cab8 fpga: m10bmc-sec: d5005 bmc secure upda=
te driver)
Merging icc/icc-next (aff72c797ff0 Merge branch 'icc-ignore-return-val' int=
o icc-next)
Merging iio/togreg (2f61ff827296 iio: pressure: icp10100: Switch from UNIVE=
RSAL to DEFINE_RUNTIME_DEV_PM_OPS().)
Merging phy-next/next (af96579dc317 phy: ti: gmii-sel: Add support for CPSW=
5G GMII SEL in J7200)
Merging soundwire/next (279e46bc2986 soundwire: intel: cleanup WakeEnable a=
nd WakeStatus)
Merging extcon/extcon-next (822a6200734c extcon: usbc-tusb320: Add USB TYPE=
-C support)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (f39856aacb07 vfio/mlx5: Set the driver DMA logging callb=
acks)
Merging staging/staging-next (9634b371b66a staging: wlan-ng: remove unused =
p80211wext_handler_def declaration)
Merging counter-next/counter-next (a12224997bec counter: Move symbols into =
COUNTER namespace)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (84dd3b2b95ef dmaengine: dw-axi-dmac: Drop obsolete =
dependency on COMPILE_TEST)
Merging cgroup/for-next (a2675ab75dff Merge branch 'for-6.1' into for-next)
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
Applying: sched/psi: fix up for "cgroup: Remove CFTYPE_PRESSURE"
Merging scsi/for-next (b17671d204f7 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (7f615c1b5986 scsi: scsi_transport_fc: Use %u for=
 dev_loss_tmo)
Merging vhost/linux-next (8f113a4ad40d virtio: drop vp_legacy_set_queue_siz=
e)
Merging rpmsg/for-next (5a3a3b45c357 Merge branches 'rpmsg-next', 'rproc-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (d9e7f0e32051 gpiolib: of: factor out conve=
rsion from OF flags)
Merging gpio-intel/for-next (0ea76c401f92 gpiolib: acpi: Add a quirk for As=
us UM325UAZ)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (04fa696fc49c Merge branch 'devel' into for-next)
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
Merging kselftest/next (2626cd3b3126 docs:kselftest: fix kselftest_module.h=
 path of example module)
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
Merging nvmem/for-next (60bbaad38109 nvmem: u-boot-env: fix crc32 casting t=
ype)
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
Merging mhi/mhi-next (e4e9631b2c88 bus: mhi: host: always print detected mo=
dem name)
Merging memblock/for-next (3e4519b7afc2 memblock tests: add generic NUMA te=
sts for memblock_alloc_try_nid*)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging cxl/next (1cd8a2537eb0 cxl/hdm: Fix skip allocations vs multiple pm=
em allocations)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (18f1da83d2ac loongarch: efi: enable generic EFI compresse=
d boot)
$ git reset --hard HEAD^
Merging next-20220916 version of efi
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (2f00d5a2a893 Merge branch 'slab/for-6.1/fit_rcu_head=
' into slab/for-next)
Merging random/master (b931eaf6ef5c random: restore O_NONBLOCK support)
Merging landlock/next (4908e7a3045c Merge branch 'landlock-next-truncate' i=
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
Merging execve/for-next/execve (33a2d6bc3480 Revert "fs/exec: allow to unsh=
are a time namespace on vfork+exec")
Merging bitmap/bitmap-for-next (b9be19eef355 drivers/base: Fix unsigned com=
parison to -1 in CPUMAP_FILE_MAX_BYTES)
Merging hte/for-next (568035b01cfb Linux 6.0-rc1)
Merging kspp/for-next/kspp (06c1c49d0cd1 fortify: Adjust KUnit test for mod=
ular build)
CONFLICT (content): Merge conflict in lib/Kconfig.debug
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging mm-stable/mm-stable (088b8aa537c2 mm: fix PageAnonExclusive clearin=
g racing with concurrent RCU GUP-fast)
Merging mm-nonmm-stable/mm-nonmm-stable (b81475117547 latencytop: use the l=
ast element of latency_record of system)
Merging mm/mm-everything (0e619e8f8ee4 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in block/blk-map.c
CONFLICT (content): Merge conflict in crypto/Kconfig
CONFLICT (content): Merge conflict in fs/exec.c
CONFLICT (content): Merge conflict in mm/hugetlb.c
CONFLICT (content): Merge conflict in mm/slub.c
CONFLICT (content): Merge conflict in mm/vmscan.c
CONFLICT (content): Merge conflict in tools/testing/selftests/vm/hmm-tests.c
Applying: mm/slab: fix up for "mm: kmsan: call KMSAN hooks from SLUB code"
Applying: crypto: x86: kmsan: disable accelerated configs in KMSAN builds
Applying: Revert "drm/msm/gem: Evict active GEM objects when necessary"

--Sig_/0tHkmJ6t/sDOUugjqci7+sA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMoOq0ACgkQAVBC80lX
0GwWjwf8DuOWLNhipy27/4rhsXodfaiQZDu6OITGBz3XIhHoDPsGqdr30mge0t6/
PhPGYbS2dbjREciRosoxT/rQOu+F9BRieCzrJFmywqYcDlVD1HydQWuMKxPgsRmR
Ut5l4jLTUUPxgGuATq76KRW7N3LX3jsfS9HZUViU7eKkuaIvNibYGPwYnDhWipCr
rwCFH+vpfKGZ1f3I1yu121Xmoh3Y6ASVafDBlC3AVQVTb+dcIF1fw4sXEYdtc0BI
UOkXAh1/CPznaWkLw2kRiZhKRkDSytZ/vJLfAb1516iBUI1WLA9JEdJ7gpxalxTg
rtsZPfSXMsRYP1Fk61jMPEFBubm/jg==
=xEZ0
-----END PGP SIGNATURE-----

--Sig_/0tHkmJ6t/sDOUugjqci7+sA--
