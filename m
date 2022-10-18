Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88860212E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJRCaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJRCaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:30:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFAE39109;
        Mon, 17 Oct 2022 19:30:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MryWC21WPz4xGQ;
        Tue, 18 Oct 2022 13:29:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666060199;
        bh=CGIN4+x9WDz3D+XuHPjM+MU1S6Xbpa8379x9hllgAdw=;
        h=Date:From:To:Cc:Subject:From;
        b=tb6773XszIbBbMMMP7NeV7e3ViT3f4GB2rMDWmHK0iU34oa7tpVE//BK/w7BNK7cB
         kxiQGE8w00qQi6aowAyK65ia3G1ndRRITmzNln5RehM6sAqzCROYHMbLgOaSYGQkP/
         SKjawdCt+i7S/HV8QH7ZNWo3M9ZOw5sDxLDQy8mfSB2j+2MIjiVDGiHuKJgzmbJQKv
         f4diXPUuCT0I/IFlW/yYSAHR/MMQWchoY4eK4NMfn1A+CTGCXJWpHpRT4pB0R+RomM
         QyJdt+HGKodznK789+yO8zgCPCRcDPC7OrwSFn/lvOuJXHWjjFa7mR8Avu7x2vHwEN
         qvKv8hFVs2CVg==
Date:   Tue, 18 Oct 2022 13:29:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 18
Message-ID: <20221018132957.5595c699@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PdGp=ZM9/g354+U.Ni7Dam3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PdGp=ZM9/g354+U.Ni7Dam3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221017:

New trees: davinci, davinci-current

The drm-intel tree gained a conflict against Linus' tree.

The rcu tree gained a conflict against Linus' tree and a build failure,
so I used the version from next-20221017..

The pinctrl-intel tree gained a build failure for which I applied a patch.

The mm tree gained a build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 1069
 908 files changed, 20661 insertions(+), 13172 deletions(-)

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

I am currently merging 364 trees (counting Linus' and 101 trees of bug
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
Merging origin/master (bbb8ceb5e242 Merge tag 'v6.1-p2' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (b997b6a43c05 gcov: support GCC 12=
.1 and newer compilers)
Merging kbuild-current/fixes (e2302539dd4f Merge tag 'xtensa-20221010' of h=
ttps://github.com/jcmvbkbc/linux-xtensa)
Merging arc-current/for-curr (d8a572789bbb arc: iounmap() arg is volatile)
Merging arm-current/fixes (14ca1a469075 ARM: 9247/1: mm: set readonly for M=
T_MEMORY_RO with ARM_LPAE)
Merging arm64-fixes/for-next/fixes (13b056696291 vmlinux.lds.h: CFI: Reduce=
 alignment of jump-table to function alignment)
Merging arm-soc-fixes/arm/fixes (bd60aafce5e1 ARM: mmp: Make some symbols s=
tatic)
Merging davinci-current/davinci/for-current (9abf2313adc1 Linux 6.1-rc1)
Merging drivers-memory-fixes/fixes (c941e6305958 dt-bindings: memory-contro=
llers: fsl,imx8m-ddrc: drop Leonard Crestez)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED =
as BI_RNG_SEED)
Merging powerpc-fixes/fixes (90d5ce82e143 powerpc/pseries: Fix CONFIG_DTL=
=3Dn build)
Merging s390-fixes/fixes (4fe89d07dcc2 Linux 6.0)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (402fe7a57287 net: ethernet: mediatek: ppe: Remove the u=
nused function mtk_foe_entry_usable())
Merging bpf/master (ea68376c8bed bpf: prevent decl_tag from being reference=
d in func_proto)
Merging ipsec/master (d83f7040e184 xfrm: lwtunnel: squelch kernel warning i=
n case XFRM encap type is not available)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (2d1f274b95c6 skmsg: pass gfp argument to alloc_s=
k_msg())
Merging rdma-fixes/for-rc (9abf2313adc1 Linux 6.1-rc1)
Merging sound-current/for-linus (a8dfb85095dd ALSA: hda/realtek: simplify t=
he return of comp_bind())
Merging sound-asoc-fixes/for-linus (d1968e740cd1 Merge remote-tracking bran=
ch 'asoc/for-6.0' into asoc-linus)
Merging regmap-fixes/for-linus (80e78fcce86d Linux 6.0-rc5)
Merging regulator-fixes/for-linus (80e78fcce86d Linux 6.0-rc5)
Merging spi-fixes/for-linus (24d1be163625 Merge remote-tracking branch 'spi=
/for-6.0' into spi-linus)
Merging pci-current/for-linus (897a66d28198 Revert "PCI: tegra: Use PCI_CON=
F1_EXT_ADDRESS() macro")
Merging driver-core.current/driver-core-linus (9abf2313adc1 Linux 6.1-rc1)
Merging tty.current/tty-linus (9abf2313adc1 Linux 6.1-rc1)
Merging usb.current/usb-linus (9abf2313adc1 Linux 6.1-rc1)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (eee48781ea19 USB: serial: qcserial: add=
 new usb-id for Dell branded EM7455)
Merging phy/fixes (2a4ea83bb8e5 phy: tegra: xusb: Fix crash during pad powe=
r on/down)
Merging staging.current/staging-linus (9abf2313adc1 Linux 6.1-rc1)
Merging iio-fixes/fixes-togreg (a10a0f385ab8 iio: bmc150-accel-core: Fix un=
safe buffer attributes)
Merging counter-current/counter-current (ec0286dce78c counter: ti-ecap-capt=
ure: fix IS_ERR() vs NULL check)
Merging char-misc.current/char-misc-linus (9abf2313adc1 Linux 6.1-rc1)
Merging soundwire-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging thunderbolt-fixes/fixes (4fe89d07dcc2 Linux 6.0)
Merging input-current/for-linus (a01aca4b0517 dt-bindings: input: touchscre=
en: Add compatible for Goodix GT7986U chip)
Merging crypto-current/master (96cb9d055445 hwrng: bcm2835 - use hwrng_msle=
ep() instead of cpu_relax())
Merging vfio-fixes/for-linus (873aefb376bb vfio/type1: Unpin zero pages)
Merging kselftest-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging modules-fixes/modules-linus (77d6354bd422 module/decompress: genera=
te sysfs string at compile time)
Merging dmaengine-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (568035b01cfb Linux 6.0-rc1)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3a99c4474112 media: rkvdec: Disable H.264 erro=
r detection)
Merging reset-fixes/reset/fixes (ae358d71d462 reset: npcm: fix iprst2 and i=
prst4 setting)
Merging mips-fixes/mips-fixes (e9f3f8f48800 MIPS: Loongson32: Fix PHY-mode =
being left unspecified)
Merging at91-fixes/at91-fixes (f5fc22cbbdcd ARM: dts: lan966x: Fix the inte=
rrupt number for internal PHYs)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (458e98746fa8 KVM: selftests: Fix nx_huge_pages_te=
st on TDP-disabled hosts)
Merging kvms390-fixes/master (189e7d876e48 KVM: s390: pci: register pci hoo=
ks without interpretation)
Merging hwmon-fixes/hwmon (3008d20f5445 hwmon: (pwm-fan) Explicitly switch =
off fan power when setting pwm1_enable to 0)
Merging nvdimm-fixes/libnvdimm-fixes (b3bbcc5d1da1 Merge branch 'for-6.0/da=
x' into libnvdimm-fixes)
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (351ff18f7481 Merge branch 'misc-6.0' into n=
ext-fixes)
Merging vfs-fixes/fixes (4f526fef91b2 [brown paperbag] fix coredump breakag=
e)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (647e82dbf851 platform/x86: p2sb: Fix UAF w=
hen caller uses resource name)
Merging samsung-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-samsung-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging devicetree-fixes/dt/linus (917c362b5f8a MAINTAINERS: of: collapse o=
verlay entry into main device tree entry)
Merging dt-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging scsi-fixes/fixes (e0e0747de0ea scsi: mpt3sas: Fix return value chec=
k of dma_get_required_mask())
Merging drm-fixes/drm-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging mmc-fixes/fixes (9972e6b40488 mmc: core: Fix kernel panic when remo=
ve non-standard SDIO card)
Merging rtc-fixes/rtc-fixes (568035b01cfb Linux 6.0-rc1)
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (f0880e2cb7e1 Drivers: hv: Never allocate=
 anything besides framebuffer from framebuffer memory region)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (145f88818d44 riscv: Pass -mno-relax only on lld=
 < 15.0.0)
Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use a=
n mpfs specific l2 compatible)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging spdx/spdx-linus (9abf2313adc1 Linux 6.1-rc1)
Merging gpio-brgl-fixes/gpio/for-current (6ebd28bd0871 gpio: tegra: Convert=
 to immutable irq chip)
Merging gpio-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging erofs-fixes/fixes (ce4b81568657 erofs: protect s_inodes with s_inod=
e_list_lock for fscache)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (93c128e709ae nfsd: ensure we always call fh_verif=
y_error tracepoint)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (1501278bb7ba Merge tag 'slab-for-6.1-rc1-=
hotfix' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab)
Merging efi-fixes/urgent (46a904dc27c8 efi: libstub: Give efi_main() asmlin=
kage qualification)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (9db5f08ca99d power: supply: ab8500: remove unu=
sed static local variable)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (4190e8bbcbc7 drm/vc4: hdmi: Ch=
eck the HSM rate at runtime_resume)
Merging kbuild/for-next (2df76606db9d Merge tag 'kbuild-fixes-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (a3a365655a28 tools arch x86: Sync the msr-index.h c=
opy with the kernel sources)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (c9cb01369b92 ARM/dma-mapping: remove the dma_=
coherent member of struct dev_archdata)
Merging asm-generic/master (2e21c1575208 alpha: fix marvel_ioread8 build re=
gression)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (072132be9f91 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (0e5d5ae837c8 arm64: Add AMPERE1 to the Spectre=
-BHB affected list)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (f43ffbd2dd3a Merge branch 'arm/fixes' into for-ne=
xt)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (c69af8a5b41f Merge branch 'v6.2/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (e9bd9228e762 arm64: dts: apple: Add A=
DMAC resets on t8103/t600x)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/dma=
/apple,admac.yaml
Merging aspeed/for-next (3617a24f4b97 ARM: dts: aspeed: ast2600-evb-a1: Add=
 compatible)
Merging at91/at91-next (a3e83ce7ece6 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (9abf2313adc1 Linux 6.1-rc1)
Merging davinci/davinci/for-next (53ad523ac435 ARM: davinci: fix repeated w=
ords in comments)
Merging drivers-memory/for-next (f3bf09c2b9c5 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (26f60c42dc9d Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (cbb1618792e2 Merge branch 'v6.0-next/soc' into f=
or-next)
Merging mvebu/for-next (d5c48679d56c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (8efe5dea6753 Merge branch 'omap-for-v6.1/dt' into fo=
r-next)
Merging qcom/for-next (e89c75d437ca Merge branches 'arm64-defconfig-for-6.1=
', 'arm64-for-6.1', 'clk-for-6.1', 'defconfig-for-6.1', 'drivers-for-6.1', =
'dts-for-6.1' and 'arm64-fixes-for-6.0' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (58a728f6c721 Merge branches 'renesas-arm-dt-for-v6.2'=
 and 'renesas-drivers-for-v6.2' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (fd72e0cdcd34 Merge branch 'v6.2-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (139b4e651563 Merge branch 'for-v6.1/late-dts=
-fixes' into for-next)
Merging scmi/for-linux-next (4fe89d07dcc2 Linux 6.0)
Merging stm32/stm32-next (400a100c28fe ARM: dts: stm32: argon: remove spide=
v node)
Merging sunxi/sunxi/for-next (1cd67985e174 Merge branch 'sunxi/drivers-for-=
6.1' into sunxi/for-next)
Merging tee/next (bd52407221b4 optee: Add __init/__exit annotations to modu=
le init/exit funcs)
Merging tegra/for-next (ecbdf04a902e Merge branch for-6.1/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (9abf2313adc1 Linux 6.1-rc1)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (9abf2313adc1 Linux 6.1-rc1)
Merging clk-imx/for-next (67e16ac1fec4 clk: imx93: add SAI IPG clk)
Merging clk-renesas/renesas-clk (adac754ab16f clk: renesas: r8a779a0: Fix S=
D0H clock name)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (9abf2313adc1 Linux 6.1-rc1)
Merging loongarch/loongarch-next (2c8577f5e455 LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED as BI_RNG=
_SEED)
Merging m68knommu/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging microblaze/next (493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-fo=
r-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-nam=
espace)
Merging mips/mips-next (90c2d2eb7ab5 MIPS: pci: lantiq: switch to using gpi=
od API)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging powerpc/next (ae5b6779fa87 powerpc: Fix 85xx build)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (ab0c23b535f3 MAINTAINERS: add RISC-V's patchwork)
Merging risc-v-mc/dt-for-next (c210b91818e8 riscv: dts: microchip: fix fabr=
ic i2c reg size)
Merging s390/for-next (bf18140d3054 s390/vmur: generate uevent on unsolicit=
ed device end)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/next (193cb8372424 uml: Remove the initialization of statics to=
 0)
Merging xtensa/xtensa-for-next (b8c4f4db2436 xtensa: update config files)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (2b00707e9737 Merge branch 'fs.vfsuid.fat' i=
nto for-next)
Merging fscrypt/master (0e91fc1e0f5c fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (56cf5ee659b5 Merge branch 'for-next-current-v6.0-20=
221017' into for-next-20221017)
Merging ceph/master (71cf0c1c4f9f ceph: remove Sage's git tree from documen=
tation)
Merging cifs/for-next (da15b7c22279 cifs: use LIST_HEAD() and list_move() t=
o simplify code)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (312fe643ad11 erofs: clean up erofs_iget())
Merging exfat/dev (2e9ceb6728f1 exfat: fix overflow for large capacity part=
ition)
Merging ext3/for_next (7241677fb18d Merge quota sanity checking fixes.)
Merging ext4/dev (1b45cc5c7b92 ext4: fix potential out of bound read in ext=
4_fc_replay_scan())
Merging f2fs/dev (bbb8ceb5e242 Merge tag 'v6.1-p2' of git://git.kernel.org/=
pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fsverity/fsverity (8377e8a24bba fs-verity: use kmap_local_page() in=
stead of kmap())
Merging fuse/for-next (09802c0a602c fuse: remove the unneeded result variab=
le)
Merging gfs2/for-next (74b1b10e29b1 gfs2: Register fs after creating workqu=
eues)
Merging jfs/jfs-next (4dc9ff146c9a jfs: remove unused declarations for jfs)
Merging ksmbd/ksmbd-for-next (f5ba1cdaf5eb ksmbd: validate share name from =
share config response)
Merging nfs/linux-next (4fe89d07dcc2 Linux 6.0)
Merging nfs-anna/linux-next (b739a5bd9d9f NFSv4/flexfiles: Cancel I/O if th=
e layout is recalled or revoked)
Merging nfsd/for-next (4fe89d07dcc2 Linux 6.0)
Merging ntfs3/master (d45da67caeda fs/ntfs3: Use strcmp to determine attrib=
ute type)
CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
Merging orangefs/for-next (2ad4b6f5e117 Orangefs: change iterate to iterate=
_shared)
Merging overlayfs/overlayfs-next (b337e5ae0e42 ovl: Kconfig: Fix spelling m=
istake "undelying" -> "underlying")
Merging ubifs/next (669d204469c4 ubi: fastmap: Add fastmap control support =
for 'UBI_IOCATT' ioctl)
Merging v9fs/9p-next (a8e633c60447 net/9p: clarify trans_fd parse_opt failu=
re handling)
Merging xfs/for-next (e033f40be262 xfs: on memory failure, only shut down f=
s after scanning all mappings)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (adc9c2e5a723 iomap: add a tracepoint for mapp=
ings returned by map_blocks)
Merging statx-dioalign/statx-dioalign (61a223df421f xfs: support STATX_DIOA=
LIGN)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of g=
it://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging vfs/for-next (7162984dce3b Merge branch 'work.tmpfile' into for-nex=
t)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting.rst
CONFLICT (content): Merge conflict in Documentation/filesystems/porting.rst
CONFLICT (content): Merge conflict in fs/overlayfs/copy_up.c
Merging printk/for-next (d81878e80ede Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (9abf2313adc1 Linux 6.1-rc1)
Merging pstore/for-next/pstore (f181c1af1385 pstore: Alert on backend write=
 error)
Merging hid/for-next (d2ca6cc9bbc5 Merge branch 'for-6.1/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (e1959cc75810 hwmon: use simple i2c probe)
Merging jc_docs/docs-next (1eb303dc5fa5 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (fbb6c848dd89 media: destage Hantro VPU driver)
Merging v4l-dvb-next/master (d67614f276c1 Merge fixes into media_stage)
CONFLICT (content): Merge conflict in drivers/media/platform/mediatek/vcode=
c/mtk_vcodec_enc_drv.c
Merging pm/linux-next (24c50c7db88e Merge branches 'acpi-docs', 'acpi-apei'=
, 'acpi-extlog' and 'acpi-resource' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c4c0efb06f17 cpufreq: qcom-cpuf=
req-hw: Add cpufreq qos for LMh)
Merging cpupower/cpupower (9abf2313adc1 Linux 6.1-rc1)
Merging devfreq/devfreq-next (fb2ac84f8acc PM / devfreq: rockchip-dfi: Fix =
an error message)
Merging opp/opp/linux-next (c7e31e36d8a2 dt-bindings: opp: Add missing (une=
valuated|additional)Properties on child nodes)
Merging thermal/thermal/linux-next (68c0c5a5d991 thermal/drivers/exynos: Fi=
x NULL pointer dereference when getting the critical temp)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (3b7610302a75 fs: dlm: fix possible use after free if trac=
ing)
Merging rdma/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging net-next/master (66ae04368efb Merge tag 'net-6.1-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf-next/for-next (0326074ff465 Merge tag 'net-next-6.1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (c39596f6ad1b Merge branch 'xfrm: add netlink ext=
ack to all the ->init_stat')
Merging mlx5-next/mlx5-next (9175d8103780 net/mlx5: Remove from FPGA IFC fi=
le not-needed definitions)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (42cf46dea905 Bluetooth: L2CAP: fix use-after-free=
 in l2cap_conn_del())
Merging wireless-next/for-next (915b96c52763 Merge tag 'wireless-next-2022-=
09-30' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-n=
ext)
Merging mtd/mtd/next (63c30d704430 Merge tag 'nand/for-6.1' into mtd/next)
Merging nand/nand/next (ba47a6ac4658 mtd: rawnand: meson: stop supporting l=
egacy clocks)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (b411b1a0c8bd crypto: aspeed - Remove redundant dev_e=
rr call)
Merging drm/drm-next (9abf2313adc1 Linux 6.1-rc1)
Merging drm-misc/for-linux-next (39dd0cc2e5bd drm/amdgpu: Fix VRAM eviction=
 issue)
Merging amdgpu/drm-next (1540031ee302 drm/amdgpu/si_dma: remove unused vari=
able in si_dma_stop())
Merging drm-intel/for-linux-next (847eec69f01a drm/i915: Extend Wa_16072976=
27 to Alderlake-P)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/skl_wate=
rmark.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_driver.c
Merging drm-tegra/for-next (778bed334508 gpu: host1x: Update host1x_memory_=
context_alloc() !IOMMU_API stub)
Merging drm-msm/msm-next (e8b595f7b058 drm/msm/hdmi: make hdmi_phy_8996 OF =
clk provider)
Merging drm-msm-lumag/msm-next-lumag (e8b595f7b058 drm/msm/hdmi: make hdmi_=
phy_8996 OF clk provider)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4bce24427251 drm/etnaviv: disable tx clock ga=
ting for GC7000 rev6203)
Merging fbdev/for-next (16b5af38dda4 fbdev: stifb: Fall back to cfb_fillrec=
t() on 32-bit HCRX cards)
Merging regmap/for-next (83eb8f73e86b Merge remote-tracking branch 'regmap/=
for-6.1' into regmap-next)
Merging sound/for-next (a8dfb85095dd ALSA: hda/realtek: simplify the return=
 of comp_bind())
Merging sound-asoc/for-next (d1968e740cd1 Merge remote-tracking branch 'aso=
c/for-6.0' into asoc-linus)
Merging modules/modules-next (77d6354bd422 module/decompress: generate sysf=
s string at compile time)
Merging input/next (d4a596eddb90 Input: dlink-dir685-touchkeys - make array=
 bl_data static const)
Merging block/for-next (e66a21e8ee24 Merge branch 'for-6.2/block' into for-=
next)
Merging device-mapper/for-next (a871fb26aba8 dm clone: Fix typo in block_de=
vice format specifier)
Merging libata/for-next (1dea5edc9085 ata: pata_mpc52xx: Replace NO_IRQ wit=
h 0)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (586c0989ac66 dt-bindings: mmc: arm,pl18x: Document interr=
upt-names is ignored)
Merging mfd/for-mfd-next (72a95859728a mfd: syscon: Remove repetition of th=
e regmap_get_val_endian())
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (189a2aaef9cb power: supply: ab8500: remove unused=
 static local variable)
Merging regulator/for-next (e5dcd639f97e Merge remote-tracking branch 'regu=
lator/for-6.1' into regulator-next)
Merging security/next (3b87d9f436b6 fs: edit a comment made in bad taste)
Merging apparmor/apparmor-next (53991aedcd34 apparmor: Fix unpack_profile()=
 warn: passing zero to 'ERR_PTR')
Merging integrity/next-integrity (bab715bdaa9e efi: Correct Macmini DMI mat=
ch in uefi cert quirk)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (e0d8259355cb selinux: increase the deprecation sleep =
for checkreqprot and runtime disable)
Merging smack/next (f393b3fd2a4b smack: cleanup obsolete mount option flags)
Merging tomoyo/master (9abf2313adc1 Linux 6.1-rc1)
Merging tpmdd/next (2d869f0b4585 selftest: tpm2: Add Client.__del__() to cl=
ose /dev/tpm* handle)
Merging watchdog/master (e25b091bed49 watchdog: Add tracing events for the =
most usual watchdog events)
Merging iommu/next (38713c6028a3 Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/omap', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into =
next)
Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode_=
name(), syscall()})
Merging devicetree/for-next (46fe5a23767a dt-bindings: clock: Convert pwm-c=
lock to DT schema)
Merging dt-krzk/for-next (983faf69b236 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (24d1be163625 Merge remote-tracking branch 'spi/for-6.=
0' into spi-linus)
Merging tip/master (c47d4723f64b Merge branch into tip/master: 'x86/mm')
Merging clockevents/timers/drivers/next (af246cc6d0ed clocksource/drivers/a=
rm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value)
Merging edac/edac-for-next (7556419180a3 EDAC/i5000: Mark as BROKEN)
Merging irqchip/irq/irqchip-next (732d69c80cb0 Merge branch irq/misc-6.1 in=
to irq/irqchip-next)
Merging ftrace/for-next (0934ae9977c2 tracing: Fix reading strings from syn=
thetic events)
Merging rcu/rcu/next (54a118fce487 srcu: Debug NMI safety even on archs tha=
t don't require it)
CONFLICT (content): Merge conflict in Documentation/RCU/checklist.rst
CONFLICT (content): Merge conflict in arch/loongarch/Kconfig
$ git reset --hard HEAD^
Merging next-20221017 version of rcu
Merging kvm/next (e18d6152ff0f Merge tag 'kvm-riscv-6.1-1' of https://githu=
b.com/kvm-riscv/linux into HEAD)
Merging kvm-arm/next (b302ca52ba82 Merge branch kvm-arm64/misc-6.1 into kvm=
arm-master/next)
Merging kvms390/next (c8a0273ac80d KVM: s390: Pass initialized arg even if =
unused)
Merging xen-tip/linux-next (a383dcb1cca8 xen/virtio: Convert PAGE_SIZE/PAGE=
_SHIFT/PFN_UP to Xen counterparts)
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (8d05fc039456 platform/x86: use PLATFORM_DEVID=
_NONE instead of -1)
Merging chrome-platform/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging hsi/for-next (811908159e7e HSI: nokia-modem: Replace of_gpio_count(=
) by gpiod_count())
Merging leds/for-next (4d1632151bde leds: pca963: fix misleading indentatio=
n)
Merging ipmi/for-next (c608966f3f9c ipmi: fix msg stack when IPMI is discon=
nected)
Merging driver-core/driver-core-next (9abf2313adc1 Linux 6.1-rc1)
Merging usb/usb-next (9abf2313adc1 Linux 6.1-rc1)
Merging thunderbolt/next (5d2569cb4a65 thunderbolt: Explicitly enable lane =
adapter hotplug events at startup)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (6b2fe3df7c0c USB: serial: ftdi_sio: clean up d=
river prefix)
Merging tty/tty-next (9abf2313adc1 Linux 6.1-rc1)
Merging char-misc/char-misc-next (9abf2313adc1 Linux 6.1-rc1)
Merging coresight/next (5fc1531dd771 hwtracing: hisi_ptt: Fix up for "iommu=
/dma: Make header private")
Merging fpga/for-next (41d26c020cb2 fpga: m10bmc-sec: Fix possible memory l=
eak of flash_buf)
Merging icc/icc-next (7360d55ba199 Merge branch 'icc-ignore-return-val' int=
o icc-next)
Merging iio/togreg (6d965885f4ea iio: adc: mcp3911: add support for oversam=
pling ratio)
Merging phy-next/next (2d93887cb4ba phy: qcom-qmp-pcie: drop bogus register=
 update)
Merging soundwire/next (9abf2313adc1 Linux 6.1-rc1)
Merging extcon/extcon-next (08099ecd9216 extcon: usbc-tusb320: fix kernel-d=
oc warning)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (b1b8132a651c vfio: More vfio_file_is_group() use cases)
Merging staging/staging-next (9abf2313adc1 Linux 6.1-rc1)
Merging counter-next/counter-next (9abf2313adc1 Linux 6.1-rc1)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (9abf2313adc1 Linux 6.1-rc1)
Merging cgroup/for-next (79a818b50873 blkcg: Update MAINTAINERS entry)
Merging scsi/for-next (9f159807a610 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/mpt3sas/mpt3sas_base.c
CONFLICT (content): Merge conflict in drivers/scsi/mpt3sas/mpt3sas_base.c
Merging scsi-mkp/for-next (67d0a917fb3f scsi: ufs: core: Remove unneeded ca=
sts from void *)
Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
Merging rpmsg/for-next (06d85ed10d15 Merge branch 'hwspinlock-next' into fo=
r-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (f5a681d23888 arm64: Remove CONFIG_ARCH_NR_=
GPIO)
Merging gpio-intel/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (9d157c89c556 MAINTAINERS: adjust STARFIVE JH7100 =
PINCTRL DRIVER after file movement)
Merging pinctrl-intel/for-next (e6b665a1c9ae pinctrl: Clean up headers)
Merging pinctrl-renesas/renesas-pinctrl (96355be8f0a2 dt-bindings: pinctrl:=
 renesas: Document RZ/Five SoC)
Merging pinctrl-samsung/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging pwm/for-next (4709f9ea338d pwm: sysfs: Replace sprintf() with sysfs=
_emit())
Merging userns/for-next (b5df013cd194 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, retire_mq_sys=
ctls-for-v5.19, and unpriv-ipc-sysctls-for-v6.2 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (9abf2313adc1 Linux 6.1-rc1)
Merging livepatching/for-next (65d22130f2c4 Merge branch 'for-6.1/sysfs-pat=
ched-object' into for-next)
Merging rtc/rtc-next (e5f12a398371 rtc: rv3028: Fix codestyle errors)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging ntb/ntb-next (568035b01cfb Linux 6.0-rc1)
Merging seccomp/for-next/seccomp (4e92863862d1 Merge branch 'for-linus/secc=
omp' into for-next/seccomp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (3f9400e61107 slimbus: qcom-ngd: simplify error pa=
ths with dev_err_probe)
Merging nvmem/for-next (60bbaad38109 nvmem: u-boot-env: fix crc32 casting t=
ype)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (154fb14df7a3 x86/hyperv: Replace kmap() with km=
ap_local_page())
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (9abf2313adc1 Linux 6.1-rc1)
Merging kunit/test (9abf2313adc1 Linux 6.1-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (9abf2313adc1 Linux 6.1-rc1)
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
Merging efi/next (d005710d183c efi: xen: Set EFI_PARAVIRT for Xen dom0 boot=
 on all architectures)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (aae2e84b50e1 Merge remote-tracking branch 'slab/for-=
6.1/common_kmalloc' into slab/for-next)
Merging random/master (6662176774c4 kcsan: remove rng selftest)
Merging landlock/next (a11599bd6ca6 landlock: Document Landlock's file trun=
cation support)
Merging rust/rust-next (fd9517a1603f init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
Merging sysctl/sysctl-next (c06a17fe056b kernel/sysctl-test: use SYSCTL_{ZE=
RO/ONE_HUNDRED} instead of i_{zero/one_hundred})
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
Merging execve/for-next/execve (9f4beead610c binfmt: remove taso from linux=
_binprm struct)
Merging bitmap/bitmap-for-next (27bc50fc9064 Merge tag 'mm-stable-2022-10-0=
8' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging hte/for-next (568035b01cfb Linux 6.0-rc1)
Merging kspp/for-next/kspp (7a8c84e1d528 Merge branch 'for-next/kcfi' into =
for-next/kspp)
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging mm-stable/mm-stable (9abf2313adc1 Linux 6.1-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (9abf2313adc1 Linux 6.1-rc1)
Merging mm/mm-everything (45c871d785d1 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Applying: fix up for "powerpc: ptrace: user_regset_copyin_ignore() always r=
eturns 0"
Applying: fix up for "pinctrl: Clean up headers"

--Sig_/PdGp=ZM9/g354+U.Ni7Dam3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNOD6YACgkQAVBC80lX
0GzK8wf/Qua1+HphUqe9YJoWaYhKp0iKilbwjAx17Ykr2pI8LOr4uY1Va9/1ybUK
Ywy2CFB/a3qph0J3cXwqvzBxIKx0vKp8QtLXmCU6KQkriRIxGCUqR7HUoRhZoxxr
mWSFclqthzpIzzUsb/hGGddwNH/TU1RwuSZYwYPPgqH8mVAonhGtaz4ShZjfRySu
tZQkUgD3poCtt0rOKhMhYPaOUDmvxib1gz50sY4lgWON9kCanJAUg8BAZEQFZnQ/
82c/y06ZxlWPD2sZ5GYSrqJEecxOJnRV3SGOWxpRUjvqVpNB4fqhLXii5gGoSVcc
Q5PkyUJKGRt5qXz5OGq+nah+VBFrNQ==
=3N24
-----END PGP SIGNATURE-----

--Sig_/PdGp=ZM9/g354+U.Ni7Dam3--
