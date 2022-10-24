Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9EF60991A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJXER0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJXERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:17:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A466110;
        Sun, 23 Oct 2022 21:17:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MwhcF5BS9z4x1V;
        Mon, 24 Oct 2022 15:17:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666585037;
        bh=aAwXFOXnCqB2vMcFduiPYIAjOYgVz8I+xKEVQrONrr0=;
        h=Date:From:To:Cc:Subject:From;
        b=KKeJ8JY75ee56+DKPOvavwsbMgiv49YW0jbLnZzAhf7jQOe539gpCVQbhJ8zU2thz
         cwHUkZcm7lxSbw9gWS2plSnsFbVD9gnPD5SuVNpaZq0kV6JSz4Z0l5XZssVnZ2qd8U
         Jfg59Fy++Dmt/IUaCE+34wCEBD8BdijuXOrBjMc8Co9/4gQjW68wKaiUW8JRVTtlt6
         Ae2fXUvbBVGNjuAZOtC8j9lcdAe36InpnDDcwzjn1oHIfvvDYf9i17e70rW8Stc5/j
         7nMhtK9Zjb/DQIjSkR0OErV8fg1Jm868WobIJRw1N2vv/MxRAhNloXnN7Wp6QiTQBt
         peAau4uYstXgQ==
Date:   Mon, 24 Oct 2022 15:17:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 24
Message-ID: <20221024151716.2709f711@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.aHLsoJgXDi6LoxE0/0afar";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.aHLsoJgXDi6LoxE0/0afar
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221021:

New tree: iversion

The drm-misc tree lost its build failure.

The random tree gained a semantic conflict against the tip tree.

Non-merge commits (relative to Linus' tree): 2347
 2392 files changed, 89859 insertions(+), 38468 deletions(-)

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

I am currently merging 365 trees (counting Linus' and 101 trees of bug
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
Merging origin/master (ca4582c286aa Revert "mfd: syscon: Remove repetition =
of the regmap_get_val_endian()")
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (6e07e2326ee0 mm/page_isolation: f=
ix clang deadcode warning)
Merging kbuild-current/fixes (9a21115ca50e Documentation: kbuild: Add descr=
iption of git for reproducible builds)
Merging arc-current/for-curr (4fd9df10cb7a ARC: mm: fix leakage of memory a=
llocated for PTE)
Merging arm-current/fixes (14ca1a469075 ARM: 9247/1: mm: set readonly for M=
T_MEMORY_RO with ARM_LPAE)
Merging arm64-fixes/for-next/fixes (13b056696291 vmlinux.lds.h: CFI: Reduce=
 alignment of jump-table to function alignment)
Merging arm-soc-fixes/arm/fixes (bd60aafce5e1 ARM: mmp: Make some symbols s=
tatic)
Merging davinci-current/davinci/for-current (9abf2313adc1 Linux 6.1-rc1)
Merging drivers-memory-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED =
as BI_RNG_SEED)
Merging powerpc-fixes/fixes (2147783d6bf0 powerpc/pseries: Use lparcfg to r=
econfig VAS windows for DLPAR CPU)
Merging s390-fixes/fixes (4fe89d07dcc2 Linux 6.0)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (0bda03623e6b nfp: only clean `sp_indiff` when applicati=
on firmware is unloaded)
Merging bpf/master (bed54aeb6ac1 Merge branch 'Wait for busy refill_work wh=
en destroying bpf memory allocator')
Merging ipsec/master (4b549ccce941 xfrm: replay: Fix ESN wrap around for GS=
O)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (69188df5f6e4 wifi: mac80211_hwsim: fix debugfs a=
ttribute ps with rc table support)
Merging rdma-fixes/for-rc (ffad65329ba8 IB/hfi1: Correctly move list in sc_=
disable())
Merging sound-current/for-linus (f86bfeb689f2 ALSA: hda/realtek: Add anothe=
r HP ZBook G9 model quirks)
Merging sound-asoc-fixes/for-linus (e9441675edc1 ASoC: SOF: Intel: hda-code=
c: fix possible memory leak in hda_codec_device_init())
Merging regmap-fixes/for-linus (157209ecce2b Merge remote-tracking branch '=
regmap/for-6.0' into regmap-linus)
Merging regulator-fixes/for-linus (dadd3e7cdcd1 Merge remote-tracking branc=
h 'regulator/for-6.0' into regulator-linus)
Merging spi-fixes/for-linus (b15397144d0c Merge remote-tracking branch 'spi=
/for-6.0' into spi-linus)
Merging pci-current/for-linus (e6aa4edd2f5b MAINTAINERS: Update Kishon's em=
ail address in PCI endpoint subsystem)
Merging driver-core.current/driver-core-linus (54de93cd8740 kernel/utsname_=
sysctl.c: Add missing enum uts_proc value)
Merging tty.current/tty-linus (9abf2313adc1 Linux 6.1-rc1)
Merging usb.current/usb-linus (fb8f60dd1b67 usb: bdc: change state when por=
t disconnected)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (eee48781ea19 USB: serial: qcserial: add=
 new usb-id for Dell branded EM7455)
Merging phy/fixes (2a4ea83bb8e5 phy: tegra: xusb: Fix crash during pad powe=
r on/down)
Merging staging.current/staging-linus (9abf2313adc1 Linux 6.1-rc1)
Merging iio-fixes/fixes-togreg (d843d0de5366 iio: adc: at91-sama5d2_adc: ge=
t rid of 5 degrees Celsius adjustment)
Merging counter-current/counter-current (b098eb99aa1b counter: 104-quad-8: =
Fix race getting function mode and direction)
Merging char-misc.current/char-misc-linus (39114b881c94 Merge tag 'iio-fixe=
s-for-6.1a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-linus)
Merging soundwire-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging thunderbolt-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging input-current/for-linus (a01aca4b0517 dt-bindings: input: touchscre=
en: Add compatible for Goodix GT7986U chip)
Merging crypto-current/master (874b301985ef crypto: lib - remove unneeded s=
election of XOR_BLOCKS)
Merging vfio-fixes/for-linus (873aefb376bb vfio/type1: Unpin zero pages)
Merging kselftest-fixes/fixes (cb05c81ada76 selftests/ftrace: fix dynamic_e=
vents dependency check)
Merging modules-fixes/modules-linus (77d6354bd422 module/decompress: genera=
te sysfs string at compile time)
Merging dmaengine-fixes/fixes (d1ae5c45f654 dmaengine: apple-admac: Fix gra=
bbing of channels in of_xlate)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (05e258c6ec66 mtd: parsers: bcm47xxpart: Fix ha=
lfblock reads)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3a99c4474112 media: rkvdec: Disable H.264 erro=
r detection)
Merging reset-fixes/reset/fixes (ae358d71d462 reset: npcm: fix iprst2 and i=
prst4 setting)
Merging mips-fixes/mips-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging at91-fixes/at91-fixes (f5fc22cbbdcd ARM: dts: lan966x: Fix the inte=
rrupt number for internal PHYs)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (9aec606c1609 tools: include: sync include/api/lin=
ux/kvm.h)
Merging kvms390-fixes/master (189e7d876e48 KVM: s390: pci: register pci hoo=
ks without interpretation)
Merging hwmon-fixes/hwmon (5619c6609130 hwmon: (corsair-psu) Add USB id of =
the new HX1500i psu)
Merging nvdimm-fixes/libnvdimm-fixes (b3bbcc5d1da1 Merge branch 'for-6.0/da=
x' into libnvdimm-fixes)
Merging cxl-fixes/fixes (df4f5aa75d87 cxl/pmem: Use size_add() against inte=
ger overflow)
Merging btrfs-fixes/next-fixes (351ff18f7481 Merge branch 'misc-6.0' into n=
ext-fixes)
Merging vfs-fixes/fixes (4f526fef91b2 [brown paperbag] fix coredump breakag=
e)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (647e82dbf851 platform/x86: p2sb: Fix UAF w=
hen caller uses resource name)
Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging devicetree-fixes/dt/linus (917c362b5f8a MAINTAINERS: of: collapse o=
verlay entry into main device tree entry)
Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging scsi-fixes/fixes (307539eed463 scsi: ufs: core: Fix typo in comment)
Merging drm-fixes/drm-fixes (cbc543c59e8e Merge tag 'drm-misc-fixes-2022-10=
-20' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging mmc-fixes/fixes (9972e6b40488 mmc: core: Fix kernel panic when remo=
ve non-standard SDIO card)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
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
Merging fpga-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging spdx/spdx-linus (9abf2313adc1 Linux 6.1-rc1)
Merging gpio-brgl-fixes/gpio/for-current (7d1aa08aff06 gpio: tegra: Convert=
 to immutable irq chip)
Merging gpio-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging erofs-fixes/fixes (ce4b81568657 erofs: protect s_inodes with s_inod=
e_list_lock for fscache)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (618887768bb7 kunit: update NULL vs IS_ERR(=
) tests)
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
Merging perf-current/perf/urgent (a3a365655a28 tools arch x86: Sync the msr=
-index.h copy with the kernel sources)
Merging efi-fixes/urgent (37926f96302d efi: runtime: Don't assume virtual m=
appings are missing if VA =3D=3D PA =3D=3D 0)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (883babd43dcf power: supply: rk817: Change rk81=
7_chg_cur_to_reg to int)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (cb8e30ddb7e3 drm/bridge: ps864=
0: Add back the 50 ms mystery delay after HPD)
Merging kbuild/for-next (2df76606db9d Merge tag 'kbuild-fixes-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (a3a365655a28 tools arch x86: Sync the msr-index.h c=
opy with the kernel sources)
Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Attr=
ibutes: Introduce __access_*() function attribute)
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
Merging aspeed/for-next (20ebe0f420d6 ARM: dts: aspeed: Remove Mihawk)
Merging at91/at91-next (a3e83ce7ece6 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (9abf2313adc1 Linux 6.1-rc1)
Merging davinci/davinci/for-next (53ad523ac435 ARM: davinci: fix repeated w=
ords in comments)
Merging drivers-memory/for-next (a11a5debdf4b dt-bindings: memory-controlle=
r: st,stm32: Split off MC properties)
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
Merging qcom/for-next (0df6c177c8f1 Merge branches 'arm64-defconfig-for-6.2=
', 'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2', 'drivers-for-6.2', =
'dts-for-6.2' and 'arm64-fixes-for-6.1' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (58a728f6c721 Merge branches 'renesas-arm-dt-for-v6.2'=
 and 'renesas-drivers-for-v6.2' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (28d1c473ccec Merge branch 'v6.1-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (d70c19499aaf Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (4fe89d07dcc2 Linux 6.0)
Merging stm32/stm32-next (c8ce0dd75515 ARM: dts: stm32: Add DHCOR based Tes=
tbench board)
Merging sunxi/sunxi/for-next (1cd67985e174 Merge branch 'sunxi/drivers-for-=
6.1' into sunxi/for-next)
Merging tee/next (bd52407221b4 optee: Add __init/__exit annotations to modu=
le init/exit funcs)
Merging tegra/for-next (ecbdf04a902e Merge branch for-6.1/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (9abf2313adc1 Linux 6.1-rc1)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (6af4fb71b1b6 Merge branch 'clk-cleanup' into clk-next)
Merging clk-imx/for-next (67e16ac1fec4 clk: imx93: add SAI IPG clk)
Merging clk-renesas/renesas-clk (888a35816452 clk: renesas: r8a779a0: Fix S=
D0H clock name)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (ce0ba954805e csky: Kconfig: Fix spelling mistake "=
Meory" -> "Memory")
Merging loongarch/loongarch-next (9abf2313adc1 Linux 6.1-rc1)
Merging m68k/for-next (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED as BI_RNG=
_SEED)
Merging m68knommu/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging microblaze/next (493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-fo=
r-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-nam=
espace)
Merging mips/mips-next (9abf2313adc1 Linux 6.1-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (0907acbec947 parisc: Show MPE model string at b=
ootup)
Merging powerpc/next (9abf2313adc1 Linux 6.1-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (ab0c23b535f3 MAINTAINERS: add RISC-V's patchwork)
Merging risc-v-mc/dt-for-next (0d814000ad35 riscv: dts: microchip: icicle: =
Add GPIO controlled LEDs)
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
Merging vfs-idmapping/for-next (b4dd412d4a62 Merge branch 'fs.ovl.setgid' i=
nto for-next)
Merging fscrypt/master (0e91fc1e0f5c fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (56cf5ee659b5 Merge branch 'for-next-current-v6.0-20=
221017' into for-next-20221017)
Merging ceph/master (ffc4d66a34bb ceph: fix a NULL vs IS_ERR() check when c=
alling ceph_lookup_inode())
Merging cifs/for-next (99c0260067b3 cifs: Fix pages leak when writedata all=
oc failed in cifs_write_from_iter())
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
Merging fuse/for-next (9388ac8224cb fuse: allow non-extending parallel dire=
ct writes on the same file)
Merging gfs2/for-next (288fc8606762 Merge tag 'gfs2-nopid-for-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (dee874452409 jfs: remove redundant assignments to ipa=
imap and ipaimap2)
Merging ksmbd/ksmbd-for-next (f5ba1cdaf5eb ksmbd: validate share name from =
share config response)
Merging nfs/linux-next (4fe89d07dcc2 Linux 6.0)
Merging nfs-anna/linux-next (b739a5bd9d9f NFSv4/flexfiles: Cancel I/O if th=
e layout is recalled or revoked)
Merging nfsd/for-next (501d9d0781fb NFSD: Trace delegation revocations)
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
Merging xfs/for-next (d08af40340ca xfs: Fix unreferenced object reported by=
 kmemleak in xfs_sysfs_init())
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (adc9c2e5a723 iomap: add a tracepoint for mapp=
ings returned by map_blocks)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of g=
it://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion ex=
port operation)
Merging vfs/for-next (3aca47127a64 fs: drop useless condition from inode_ne=
eds_update_time)
Merging printk/for-next (dd283899b31c Merge branch 'for-6.2' into for-next)
Merging pci/next (9abf2313adc1 Linux 6.1-rc1)
Merging pstore/for-next/pstore (38b91847c314 pstore: Alert on backend write=
 error)
Merging hid/for-next (edab71d7d2a8 Merge branch 'for-6.2/mcp2221' into for-=
next)
Merging i2c/i2c/for-next (fd142e074e89 Merge branch 'i2c/for-current-fixed'=
 into i2c/for-next)
Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (82067edc4508 hwmon: (adm1177) simplify us=
ing devm_regulator_get_enable())
Merging jc_docs/docs-next (687baf517f9c Merge branches 'docs-mw' and 'docs-=
fixes' into docs-next)
Merging v4l-dvb/master (9abf2313adc1 Linux 6.1-rc1)
Merging v4l-dvb-next/master (d67614f276c1 Merge fixes into media_stage)
Merging pm/linux-next (89871b5c10a0 Merge branch 'acpi-scan' into linux-nex=
t)
Merging cpufreq-arm/cpufreq/arm/linux-next (889a50aedcd2 cpufreq: sun50i: S=
witch to use dev_err_probe() helper)
Merging cpupower/cpupower (9abf2313adc1 Linux 6.1-rc1)
Merging devfreq/devfreq-next (9abf2313adc1 Linux 6.1-rc1)
Merging opp/opp/linux-next (c7e31e36d8a2 dt-bindings: opp: Add missing (une=
valuated|additional)Properties on child nodes)
Merging thermal/thermal/linux-next (9d2bc364f677 thermal/drivers/qcom/tsens=
: Simplify debugfs init function)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (3b7610302a75 fs: dlm: fix possible use after free if trac=
ing)
Merging rdma/for-next (c1842f34fcee IB/iser: open code iser_disconnected_ha=
ndler)
Merging net-next/master (3bd5549bd479 dt-bindings: net: adin1110: Document =
reset)
Merging bpf-next/for-next (8f4bc15b9ad7 selftests/bpf: Add write to hashmap=
 to array_map iter test)
Merging ipsec-next/master (e2ac2a00dae1 enic: define constants for legacy i=
nterrupts offset)
Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (f334dabe7dae Bluetooth: hci_core: fix error handl=
ing in hci_register_dev())
Merging wireless-next/for-next (80e5acb6dd72 wifi: rtl8xxxu: Fix reads of u=
ninitialized variables hw_ctrl_s1, sw_ctrl_s1)
CONFLICT (content): Merge conflict in net/mac80211/util.c
Merging mtd/mtd/next (aec4d5f5ffd0 mtd: parsers: add TP-Link SafeLoader par=
titions table parser)
CONFLICT (content): Merge conflict in drivers/mtd/mtdcore.c
Merging nand/nand/next (7c3fc99819fd mtd: rawnand: cadence: support 64-bit =
slave dma interface)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (96cb9d055445 hwrng: bcm2835 - use hwrng_msleep() ins=
tead of cpu_relax())
Merging drm/drm-next (9abf2313adc1 Linux 6.1-rc1)
Merging drm-misc/for-linux-next (16d2a3f2ad1d nouveau/dmem: Remove duplicat=
ed include in nouveau_dmem.c)
Merging amdgpu/drm-next (fb5e487f910e drm/amdgpu: skip mes self test for gc=
 11.0.3 in recover)
Merging drm-intel/for-linux-next (f5e674e92e95 drm/i915: Introduce intel_cr=
tc_needs_color_update())
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
Merging fbdev/for-next (cc67482c9e5f fbdev: smscufx: Fix several use-after-=
free bugs)
Merging regmap/for-next (7c7aa42243cb Merge branch 'regmap-linus' into regm=
ap-next)
Merging sound/for-next (a293e8ec8279 Merge branch 'topic/hda-ext-cleanup' i=
nto for-next)
Merging sound-asoc/for-next (f39cd819877a Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-next)
Merging modules/modules-next (77d6354bd422 module/decompress: generate sysf=
s string at compile time)
Merging input/next (d4a596eddb90 Input: dlink-dir685-touchkeys - make array=
 bl_data static const)
Merging block/for-next (e66a21e8ee24 Merge branch 'for-6.2/block' into for-=
next)
Merging device-mapper/for-next (5434ee8d2857 dm clone: Fix typo in block_de=
vice format specifier)
Merging libata/for-next (43c10618700b ata: remove palmchip pata_bk3710 driv=
er)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (586c0989ac66 dt-bindings: mmc: arm,pl18x: Document interr=
upt-names is ignored)
Merging mfd/for-mfd-next (72a95859728a mfd: syscon: Remove repetition of th=
e regmap_get_val_endian())
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging regulator/for-next (98e2892aebdf Merge branch 'regulator-linus' int=
o regulator-next)
Merging security/next (3b87d9f436b6 fs: edit a comment made in bad taste)
Merging apparmor/apparmor-next (53991aedcd34 apparmor: Fix unpack_profile()=
 warn: passing zero to 'ERR_PTR')
Merging integrity/next-integrity (5adedd42245a KEYS: encrypted: fix key ins=
tantiation with user-provided data)
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
Merging watchdog/master (82ebbe65d781 drivers: watchdog: exar_wdt.c fix use=
 after free)
Merging iommu/next (620bf9f98136 iommu/vt-d: Clean up si_domain in the init=
_dmars() error path)
Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode_=
name(), syscall()})
Merging devicetree/for-next (ae5a16c8da92 scripts: dtc: only show unique un=
it address warning for enabled nodes)
Merging dt-krzk/for-next (3485cbb3725c Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (8ffd0df2d2fc Merge remote-tracking branch 'spi/for-6.=
2' into spi-next)
Merging tip/master (df0819e9f275 Merge branch into tip/master: 'x86/paravir=
t')
Merging clockevents/timers/drivers/next (af246cc6d0ed clocksource/drivers/a=
rm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value)
Merging edac/edac-for-next (7556419180a3 EDAC/i5000: Mark as BROKEN)
Merging irqchip/irq/irqchip-next (732d69c80cb0 Merge branch irq/misc-6.1 in=
to irq/irqchip-next)
Merging ftrace/for-next (0934ae9977c2 tracing: Fix reading strings from syn=
thetic events)
Merging rcu/rcu/next (ba38687626ad selftests/nolibc: Add 7 tests for memcmp=
())
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
Merging chrome-platform/for-next (d8cb88f1541f platform/chrome: cros_hps_i2=
c: make remove callback return void)
Merging hsi/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging leds/for-next (5f52a8ba7e91 dt-bindings: leds: Add 'cpuX' to 'linux=
,default-trigger')
Merging ipmi/for-next (c608966f3f9c ipmi: fix msg stack when IPMI is discon=
nected)
Merging driver-core/driver-core-next (59789f3418dd device property: Constif=
y parameter in device_dma_supported() and device_get_dma_attr())
Merging usb/usb-next (8127cac0f393 usb: chipidea: usbmisc: add power lost c=
heck for imx7ulp)
Merging thunderbolt/next (b9589c417fed thunderbolt: Remove redundant assign=
ment to variable len)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (6b2fe3df7c0c USB: serial: ftdi_sio: clean up d=
river prefix)
Merging tty/tty-next (9abf2313adc1 Linux 6.1-rc1)
Merging char-misc/char-misc-next (9abf2313adc1 Linux 6.1-rc1)
Merging coresight/next (5fc1531dd771 hwtracing: hisi_ptt: Fix up for "iommu=
/dma: Make header private")
Merging fpga/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging icc/icc-next (7360d55ba199 Merge branch 'icc-ignore-return-val' int=
o icc-next)
Merging iio/togreg (6d965885f4ea iio: adc: mcp3911: add support for oversam=
pling ratio)
Merging phy-next/next (2d93887cb4ba phy: qcom-qmp-pcie: drop bogus register=
 update)
Merging soundwire/next (f74495761df1 soundwire: dmi-quirks: add quirk varia=
nt for LAPBC710 NUC15)
Merging extcon/extcon-next (9abf2313adc1 Linux 6.1-rc1)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (b1b8132a651c vfio: More vfio_file_is_group() use cases)
Merging staging/staging-next (19cbe487f55f staging: rtl8723bs: use tab inst=
ead of spaces for indent)
Merging counter-next/counter-next (9abf2313adc1 Linux 6.1-rc1)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (cd0ab43ec91a dmaengine: remove iop-adma driver)
Merging cgroup/for-next (79a818b50873 blkcg: Update MAINTAINERS entry)
Merging scsi/for-next (031a4e28a29d Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (7029e2151a7c scsi: ufs: Fix a deadlock between P=
M and the SCSI error handler)
Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
Merging rpmsg/for-next (06d85ed10d15 Merge branch 'hwspinlock-next' into fo=
r-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (99d18d42c942 gpiolib: of: add a quirk for =
reset line polarity for Himax LCDs)
Merging gpio-intel/for-next (ce3a0a29fb9f gpio: merrifield: Use str_enable_=
disable() helper)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (b6f5e4402f45 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (da0a173092a5 pinctrl: Clean up headers)
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
Merging kselftest/next (de3ee3f63400 selftests: Use optional USERCFLAGS and=
 USERLDFLAGS)
Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' int=
o for-next)
Merging rtc/rtc-next (9abf2313adc1 Linux 6.1-rc1)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging ntb/ntb-next (568035b01cfb Linux 6.0-rc1)
Merging seccomp/for-next/seccomp (4e92863862d1 Merge branch 'for-linus/secc=
omp' into for-next/seccomp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging nvmem/for-next (9abf2313adc1 Linux 6.1-rc1)
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
Merging kunit-next/kunit (11e76194937b Documentation: Kunit: Update archite=
cture.rst for minor fixes)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (e4e9631b2c88 bus: mhi: host: always print detected mo=
dem name)
Merging memblock/for-next (3e4519b7afc2 memblock tests: add generic NUMA te=
sts for memblock_alloc_try_nid*)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging cxl/next (9abf2313adc1 Linux 6.1-rc1)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (32d3f1d8ba58 efi: libstub: Deduplicate ftrace command lin=
e argument filtering)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (aae2e84b50e1 Merge remote-tracking branch 'slab/for-=
6.1/common_kmalloc' into slab/for-next)
Merging random/master (14fbd1e5183c treewide: use get_random_u32_between() =
when possible)
Merging landlock/next (4bc90a766ea5 Merge branch 'landlock-test-build-fix' =
into landlock-next)
Merging rust/rust-next (fd9517a1603f init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
Merging sysctl/sysctl-next (c06a17fe056b kernel/sysctl-test: use SYSCTL_{ZE=
RO/ONE_HUNDRED} instead of i_{zero/one_hundred})
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in include/linux/migrate.h
CONFLICT (content): Merge conflict in mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
Merging execve/for-next/execve (0a8aedc2d060 exec: Add comments on check_un=
safe_exec() fs counting)
Applying: fix up for "prandom: remove prandom_u32_max()"
Merging bitmap/bitmap-for-next (27bc50fc9064 Merge tag 'mm-stable-2022-10-0=
8' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging hte/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging kspp/for-next/kspp (7c2c416bb9d7 fortify: Short-circuit known-safe =
calls to strscpy())
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging unsigned-char/unsigned-char (d2f6725b6c31 -funsigned-char, x86: mak=
e struct p4_event_bind::cntr signed array)
Merging mm-stable/mm-stable (9abf2313adc1 Linux 6.1-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (9abf2313adc1 Linux 6.1-rc1)
Merging mm/mm-everything (7f002e2ca3e6 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)

--Sig_/.aHLsoJgXDi6LoxE0/0afar
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNWEcwACgkQAVBC80lX
0GyitQf7B4k7cByJUTl6gsrRVjD3vcAqZk5QL467/MuLWbPCVnecfyr0QN4LtShF
lH2z+OItps+9DrpeDc2rUgia+rOxinCxpgtjh2QCXuJQAR1tsai6IiZJcyoc1djA
ltoeCNSAuQJPMMCG8jO6CL+JJIzf2LhxP5jFYqrlxymZWqGhKb0+JItzPwdjsZgg
uotGFk+KrJTXwRH/yhK/LFlYHtHf6mGNJ7j4H3pid4LVulOxtCGT/DNwlz5NBtSl
+yYD7yvXUvagQ1J3q89PNv15DB/d9onCpnlVEphI/kSbui8Qc7pvy/yn5ObVu9OV
KY0zJ38WTfK70W0ZuLEl7qZzhcQatw==
=kPhy
-----END PGP SIGNATURE-----

--Sig_/.aHLsoJgXDi6LoxE0/0afar--
