Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403A861310D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJaHI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaHI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:08:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869039595;
        Mon, 31 Oct 2022 00:08:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N144w1Qxwz4xN1;
        Mon, 31 Oct 2022 18:08:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667200128;
        bh=WUQirO8rShYUelTozCs5yAzFM9BxlHycHJr0vvQt4PE=;
        h=Date:From:To:Cc:Subject:From;
        b=oPcmFmnU+yfclmcizC5iH82j1YYagjHWZWJX8G0INIwI+MKZJG5n9Z1jbGmRLMA5b
         3BTXgAhYEqwL8jNXIVTxqIf7CAkYb71LoCrpfRwBZ38eqXkM/fKnZEcY7fKe++zhuy
         49guvxsKBGWmiUwRXf2+AfW2OjCpMzxREjVEjGMEiEJq3BXw+lZ58+zoja1wr5Twpn
         fn+gK5sFVx0cW44xvKCQ3YwHdSII9/uHIfaKGhc6/tvznUQI7SvSzOj+YiJXRCOaj6
         iI3zkfLLfTYLoAC4ZtiyxjAwCsWAHgmVT9aXgG+ScVLSC8G/QwWgWuzI8PqqNHgmCt
         mY36/ekqDuXQg==
Date:   Mon, 31 Oct 2022 18:08:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 31
Message-ID: <20221031180846.4b4c9f16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DRDn2IIgWRGRur8nPUuWIhU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DRDn2IIgWRGRur8nPUuWIhU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20221028:

The imx-mxs tree gained a build failure so I used the version from
next-20221028.

The amdgpu tree gained a build failure due to a bad git merge for which
I appplied a fix patch.

The cgroup tree gained a build failure so I used the version from
next-20221028.

The random tree gained a build failure so I used the version from
next-20221028.

Non-merge commits (relative to Linus' tree): 3824
 3951 files changed, 198910 insertions(+), 110216 deletions(-)

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
Merging origin/master (b72018ab8236 Merge tag 'fbdev-for-6.1-rc3' of git://=
git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (7016ff3c4f4f mm/mmap: fix memory =
leak in mmap_region())
Merging kbuild-current/fixes (fb3041d61f68 kbuild: fix SIGPIPE error messag=
e for AR=3Dgcc-ar and AR=3Dllvm-ar)
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
Merging powerpc-fixes/fixes (65722736c3ba powerpc/64s/interrupt: Fix clear =
of PACA_IRQS_HARD_DIS when returning to soft-masked context)
Merging s390-fixes/fixes (e38de4804421 s390/vfio-ap: Fix memory allocation =
for mdev_types array)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memor=
y leak on mount failure)
Merging net/master (a2c65a9d0568 net: dsa: fall back to default tagger if w=
e can't load the one from DT)
Merging bpf/master (88619e77b33d net: stmmac: rk3588: Allow multiple gmac c=
ontroller)
Merging ipsec/master (7f57f8165cb6 af_key: Fix send_acquire race with pfkey=
_register)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (69188df5f6e4 wifi: mac80211_hwsim: fix debugfs a=
ttribute ps with rc table support)
Merging rdma-fixes/for-rc (7a47e077e503 RDMA/qedr: clean up work queue on f=
ailure in qedr_alloc_resources())
Merging sound-current/for-linus (46cf1954de3f ALSA: arm: pxa: pxa2xx-ac97-l=
ib: fix return value check of platform_get_irq())
Merging sound-asoc-fixes/for-linus (6a564338a23c ASoC: fsl_asrc fsl_esai fs=
l_sai: allow CONFIG_PM=3DN)
Merging regmap-fixes/for-linus (157209ecce2b Merge remote-tracking branch '=
regmap/for-6.0' into regmap-linus)
Merging regulator-fixes/for-linus (dadd3e7cdcd1 Merge remote-tracking branc=
h 'regulator/for-6.0' into regulator-linus)
Merging spi-fixes/for-linus (5b71187f3e11 Merge remote-tracking branch 'spi=
/for-6.0' into spi-linus)
Merging pci-current/for-linus (39a654f39efb MAINTAINERS: Add Manivannan Sad=
hasivam as Qcom PCIe RC maintainer)
Merging driver-core.current/driver-core-linus (54de93cd8740 kernel/utsname_=
sysctl.c: Add missing enum uts_proc value)
Merging tty.current/tty-linus (9abf2313adc1 Linux 6.1-rc1)
Merging usb.current/usb-linus (308c316d16cb usb: dwc3: gadget: Don't set IM=
I for no_interrupt)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (df3414b0a245 USB: serial: option: add S=
ierra Wireless EM9191)
Merging phy/fixes (04948e757148 phy: qcom-qmp-combo: fix NULL-deref on runt=
ime resume)
Merging staging.current/staging-linus (937ec9f7d5f2 staging: rtl8192e: remo=
ve bogus ssid character sign test)
Merging iio-fixes/fixes-togreg (4751a9f58e4f tools: iio: iio_generic_buffer=
: Fix read size)
Merging counter-current/counter-current (d501d37841d3 counter: 104-quad-8: =
Fix race getting function mode and direction)
Merging char-misc.current/char-misc-linus (677047383296 misc: sgi-gru: use =
explicitly signed char)
Merging soundwire-fixes/fixes (49a467310dc4 soundwire: qcom: check for outa=
nding writes before doing a read)
Merging thunderbolt-fixes/fixes (247f34f7b803 Linux 6.1-rc2)
Merging input-current/for-linus (a01aca4b0517 dt-bindings: input: touchscre=
en: Add compatible for Goodix GT7986U chip)
Merging crypto-current/master (9f6035af06b5 crypto: x86/polyval - Fix crash=
es when keys are not 16-byte aligned)
Merging vfio-fixes/for-linus (873aefb376bb vfio/type1: Unpin zero pages)
Merging kselftest-fixes/fixes (3d982441308e selftests: pidfd: Fix compling =
warnings)
Merging modules-fixes/modules-linus (77d6354bd422 module/decompress: genera=
te sysfs string at compile time)
Merging dmaengine-fixes/fixes (d1ae5c45f654 dmaengine: apple-admac: Fix gra=
bbing of channels in of_xlate)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (05e258c6ec66 mtd: parsers: bcm47xxpart: Fix ha=
lfblock reads)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (de547896aac6 media: vivid.rst: loop_video is s=
et on the capture devnode)
Merging reset-fixes/reset/fixes (ae358d71d462 reset: npcm: fix iprst2 and i=
prst4 setting)
Merging mips-fixes/mips-fixes (9abf2313adc1 Linux 6.1-rc1)
Merging at91-fixes/at91-fixes (2b4337c8409b ARM: dts: at91: sama7g5: fix si=
gnal name of pin PB2)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (7353633814f6 KVM: x86/xen: Fix eventfd error hand=
ling in kvm_xen_eventfd_assign())
Merging kvms390-fixes/master (165dfb55facd KVM: s390: pv: don't allow users=
pace to set the clock under PV)
Merging hwmon-fixes/hwmon (5619c6609130 hwmon: (corsair-psu) Add USB id of =
the new HX1500i psu)
Merging nvdimm-fixes/libnvdimm-fixes (b3bbcc5d1da1 Merge branch 'for-6.0/da=
x' into libnvdimm-fixes)
Merging cxl-fixes/fixes (df4f5aa75d87 cxl/pmem: Use size_add() against inte=
ger overflow)
Merging btrfs-fixes/next-fixes (3b3aca49fa7b Merge branch 'misc-6.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (4f526fef91b2 [brown paperbag] fix coredump breakag=
e)
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (e9cf4d9b9a6f ACPI: video: Fix missing nati=
ve backlight on Chromebooks)
Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging devicetree-fixes/dt/linus (917c362b5f8a MAINTAINERS: of: collapse o=
verlay entry into main device tree entry)
Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging scsi-fixes/fixes (307539eed463 scsi: ufs: core: Fix typo in comment)
Merging drm-fixes/drm-fixes (b2196401949e Merge tag 'drm-misc-fixes-2022-10=
-27' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (63720a561b3c drm/i915/dp: Res=
et frl trained flag before restarting FRL training)
Merging mmc-fixes/fixes (8d280b1df87e mmc: sdhci_am654: 'select', not 'depe=
nds' REGMAP_MMIO)
Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI =
platforms)
Merging gnss-fixes/gnss-linus (247f34f7b803 Linux 6.1-rc2)
Merging hyperv-fixes/hyperv-fixes (9387a58b5239 x86/hyperv: fix invalid wri=
tes to MSRs during root partition kexec)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (8bc8824d3019 riscv: dts: sifive unleashed: Add =
PWM controlled LEDs)
Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use a=
n mpfs specific l2 compatible)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging spdx/spdx-linus (9abf2313adc1 Linux 6.1-rc1)
Merging gpio-brgl-fixes/gpio/for-current (9ed88fcfb1b0 MAINTAINERS: Change =
myself to a maintainer)
Merging gpio-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging pinctrl-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging erofs-fixes/fixes (ce4b81568657 erofs: protect s_inodes with s_inod=
e_list_lock for fscache)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (618887768bb7 kunit: update NULL vs IS_ERR(=
) tests)
Merging ubifs-fixes/fixes (c18a80c6861f jffs2: correct logic when creating =
a hole in jffs2_write_begin)
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (93c128e709ae nfsd: ensure we always call fh_verif=
y_error tracepoint)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (b229b6ca5abb Merge tag 'perf-tools-fixes-=
for-v6.1-2022-10-26' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/=
linux)
Merging efi-fixes/urgent (4e1c390e882d arm64: efi: Recover from synchronous=
 exceptions occurring in firmware)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (883babd43dcf power: supply: rk817: Change rk81=
7_chg_cur_to_reg to int)
Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executab=
le to fix a binutils warning)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (447fb14bf079 drm/rockchip: vop=
2: disable planes when disabling the crtc)
Merging kbuild/for-next (2df76606db9d Merge tag 'kbuild-fixes-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (78c2c767cffa perf evlist: Add missing util/event.h =
header)
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
Merging arm-soc/for-next (e46b46e69739 soc: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (97fee081d884 Merge branch 'v6.2/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (56fed763f6b2 arm64: dts: apple: Add A=
DMAC resets on t8103/t600x)
Merging aspeed/for-next (20ebe0f420d6 ARM: dts: aspeed: Remove Mihawk)
Merging at91/at91-next (9abf2313adc1 Linux 6.1-rc1)
Merging broadcom/next (9abf2313adc1 Linux 6.1-rc1)
Merging davinci/davinci/for-next (53ad523ac435 ARM: davinci: fix repeated w=
ords in comments)
Merging drivers-memory/for-next (de67fa80c669 dt-bindings: memory-controlle=
rs: arm,pl353-smc: Extend to support 'arm,pl354' SMC)
Merging imx-mxs/for-next (5341176de499 Merge branch 'imx/defconfig' into fo=
r-next)
$ git reset --hard HEAD^
Merging next-20221028 version of imx-mxs
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
Merging renesas/next (4bff929bc882 Merge branches 'renesas-arm-dt-for-v6.2'=
, 'renesas-arm-soc-for-v6.2' and 'renesas-dt-bindings-for-v6.2' into renesa=
s-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (7771a384229f Merge branch 'v6.1-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (d70c19499aaf Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (1d71de28583b Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (7ad436adc788 ARM: multi_v7_defconfig: enable Type=
-C UCSI and STM32G0 as modules)
Merging sunxi/sunxi/for-next (8907a276fec2 ARM: dts: axp22x/axp809: Add GPI=
O controller nodes)
Merging tee/next (bd52407221b4 optee: Add __init/__exit annotations to modu=
le init/exit funcs)
Merging tegra/for-next (81a9c53ea212 Merge branch for-6.2/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (f1ffcc9579f6 Merge branches 'ti-keystone-next', 'ti-k3-=
dts-next' and 'ti-drivers-soc-next' into ti-next)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (96beb9fd1d90 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging clk-renesas/renesas-clk (c82009584edb clk: renesas: rzg2l: Fix typo=
 in struct rzg2l_cpg_priv kerneldoc)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (ce0ba954805e csky: Kconfig: Fix spelling mistake "=
Meory" -> "Memory")
Merging loongarch/loongarch-next (247f34f7b803 Linux 6.1-rc2)
Merging m68k/for-next (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED as BI_RNG=
_SEED)
Merging m68knommu/for-next (247f34f7b803 Linux 6.1-rc2)
Merging microblaze/next (493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-fo=
r-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-nam=
espace)
Merging mips/mips-next (9abf2313adc1 Linux 6.1-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https:=
//github.com for openrisc)
Merging parisc-hd/for-next (ab70ef097123 parisc: Avoid printing the hardwar=
e path twice)
Merging powerpc/next (247f34f7b803 Linux 6.1-rc2)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (be79afc740b5 riscv: Enable HAVE_ARCH_HUGE_VMALLOC =
for 64BIT)
Merging risc-v-mc/dt-for-next (0d814000ad35 riscv: dts: microchip: icicle: =
Add GPIO controlled LEDs)
Merging s390/for-next (c9c4220a9132 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/next (193cb8372424 uml: Remove the initialization of statics to=
 0)
Merging xtensa/xtensa-for-next (b8c4f4db2436 xtensa: update config files)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (60aa836ec751 Merge branch 'fs.acl.rework' i=
nto for-next)
Merging fscrypt/master (0e91fc1e0f5c fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (31bf1af75b06 Merge branch 'for-next-next-v6.1-20221=
027' into for-next-20221027)
CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
Applying: btrfs: fix up for "fs: pass dentry to set acl method"
Merging ceph/master (ffc4d66a34bb ceph: fix a NULL vs IS_ERR() check when c=
alling ceph_lookup_inode())
Merging cifs/for-next (b72018ab8236 Merge tag 'fbdev-for-6.1-rc3' of git://=
git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the' =
in comment)
Merging erofs/dev (312fe643ad11 erofs: clean up erofs_iget())
Merging exfat/dev (2e9ceb6728f1 exfat: fix overflow for large capacity part=
ition)
Merging ext3/for_next (ab7720a2b117 maintainers: Add ISOFS entry)
Merging ext4/dev (1b45cc5c7b92 ext4: fix potential out of bound read in ext=
4_fc_replay_scan())
Merging f2fs/dev (d34f1e7212c1 f2fs: replace gc_urgent_high_remaining with =
gc_remaining_trials)
Merging fsverity/fsverity (8377e8a24bba fs-verity: use kmap_local_page() in=
stead of kmap())
Merging fuse/for-next (cbed990fb813 fuse: Rearrange fuse_allow_current_proc=
ess checks)
Merging gfs2/for-next (288fc8606762 Merge tag 'gfs2-nopid-for-v6.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (25e70c6162f2 fs: jfs: fix shift-out-of-bounds in dbDi=
scardAG)
Merging ksmbd/ksmbd-for-next (f5ba1cdaf5eb ksmbd: validate share name from =
share config response)
Merging nfs/linux-next (4fe89d07dcc2 Linux 6.0)
Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate =
slot failed)
Merging nfsd/for-next (2dd140804b23 NFSD: Use rhashtable for managing nfs4_=
file objects)
Merging ntfs3/master (0d6d7c61ffee fs/ntfs3: Don't use uni1 uninitialized i=
n ntfs_d_compare())
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
Merging pci/next (652ce11a7604 Merge branch 'remotes/lorenzo/pci/tegra')
Merging pstore/for-next/pstore (38b91847c314 pstore: Alert on backend write=
 error)
Merging hid/for-next (914abae32bd2 Merge branch 'for-6.2/hyperv' into for-n=
ext)
Merging i2c/i2c/for-next (fd142e074e89 Merge branch 'i2c/for-current-fixed'=
 into i2c/for-next)
Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (e9fab0e2edf9 hwmon: (pmbus/ltc2978) add s=
upport for LTC7132)
Merging jc_docs/docs-next (f907bf630e9c Merge branches 'docs-mw' and 'docs-=
fixes' into docs-next)
Merging v4l-dvb/master (247f34f7b803 Linux 6.1-rc2)
Merging v4l-dvb-next/master (de547896aac6 media: vivid.rst: loop_video is s=
et on the capture devnode)
Merging pm/linux-next (111ae903a8e6 Merge branches 'acpi-scan', 'acpi-resou=
rce' and 'acpi-pcc' into linux-next)
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
Merging rdma/for-next (4508d32ccced RDMA/core: Fix order of nldev_exit call)
Merging net-next/master (02a97e02c64f Merge tag 'mlx5-updates-2022-10-24' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging bpf-next/for-next (e39e739ab573 bpf: check max_entries before alloc=
ating memory)
Merging ipsec-next/master (cc2bbbfd9a50 xfrm: Remove not-used total variabl=
e)
Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (98f18bb78b7d Bluetooth: Add CONFIG_BT_LE_L2CAP_EC=
RED)
Merging wireless-next/for-next (a9501019f2de Merge ath-next from git://git.=
kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mtd/mtd/next (aec4d5f5ffd0 mtd: parsers: add TP-Link SafeLoader par=
titions table parser)
CONFLICT (content): Merge conflict in drivers/mtd/mtdcore.c
Merging nand/nand/next (7c3fc99819fd mtd: rawnand: cadence: support 64-bit =
slave dma interface)
Merging spi-nor/spi-nor/next (bb0e9c600ce2 mtd: spi-nor: core: Add an error=
 message when failing to exit the 4-byte address mode)
Merging crypto/master (d6e9aa6e1ea8 crypto: octeontx - fix repeated words i=
n comments)
Merging drm/drm-next (7f7a942c0a33 Merge tag 'drm-next-20221025' of git://l=
inuxtv.org/pinchartl/media into drm-next)
Merging drm-misc/for-linux-next (4dba27f1a145 drm/rockchip: lvds: fix PM us=
age counter unbalance in poweron)
Merging amdgpu/drm-next (e826963353c0 drm/amdgpu: force read discovery file=
 if set discovery=3D2)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vkm=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
Applying: fixup for bad merge of "drm/amd: Add IMU fw version to fw version=
 queries"
Merging drm-intel/for-linux-next (a6ebd538364b drm/i915/sdvo: Fix debug pri=
nt)
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
Merging fbdev/for-next (247f34f7b803 Linux 6.1-rc2)
Merging regmap/for-next (7c7aa42243cb Merge branch 'regmap-linus' into regm=
ap-next)
Merging sound/for-next (2b4e275b92b8 ALSA: asihpi: remove variable loops)
Merging sound-asoc/for-next (75ff693f7d68 Merge remote-tracking branch 'aso=
c/for-6.2' into asoc-next)
Merging modules/modules-next (dd0338eef0d4 kernel/params.c: defer most of p=
aram_sysfs_init() to late_initcall time)
Merging input/next (66603243f528 Input: add driver for Hynitron cstxxx touc=
hscreens)
Merging block/for-next (30209debe98b Merge branch 'for-6.2/block' into for-=
next)
Merging device-mapper/for-next (5434ee8d2857 dm clone: Fix typo in block_de=
vice format specifier)
Merging libata/for-next (de58fd3d80f8 ata: sata_dwc_460ex: remove variable =
num_processed)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (1537fb63f79e mmc: mediatek: add support for MT7986 SoC)
Merging mfd/for-mfd-next (df3a88e60ec1 dt-bindings: mfd: qcom,tcsr: Add sc8=
280xp binding)
Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt6370=
: Add MediaTek MT6370 support)
Merging battery/for-next (14a3d159abf8 power: supply: bq25890: Add Vsys reg=
ulator)
Merging regulator/for-next (98e2892aebdf Merge branch 'regulator-linus' int=
o regulator-next)
Merging security/next (610b17b05c5c audit: Fix some kernel-doc warnings)
Merging apparmor/apparmor-next (3265949f7cd3 apparmor: Fix memleak issue in=
 unpack_profile())
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
Merging devicetree/for-next (c2741cbe7f8a dt-bindings: media: st,stmipid02:=
 Convert the text bindings to YAML)
Merging dt-krzk/for-next (455087308947 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IRQ=
 NO_THREAD)
Merging spi/for-next (a288c52fb3ea Merge remote-tracking branch 'spi/for-6.=
2' into spi-next)
Merging tip/master (b8cc3fc13619 Merge branch into tip/master: 'x86/sev')
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
Merging clockevents/timers/drivers/next (af246cc6d0ed clocksource/drivers/a=
rm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value)
Merging edac/edac-for-next (f8c843f6693b Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (732d69c80cb0 Merge branch irq/misc-6.1 in=
to irq/irqchip-next)
Merging ftrace/for-next (0934ae9977c2 tracing: Fix reading strings from syn=
thetic events)
Merging rcu/rcu/next (ffb4efcd9d61 locking/memory-barriers.txt: Improve doc=
umentation for writel() example)
Merging kvm/next (7353633814f6 KVM: x86/xen: Fix eventfd error handling in =
kvm_xen_eventfd_assign())
Merging kvm-arm/next (b302ca52ba82 Merge branch kvm-arm64/misc-6.1 into kvm=
arm-master/next)
Merging kvms390/next (c8a0273ac80d KVM: s390: Pass initialized arg even if =
unused)
Merging xen-tip/linux-next (a383dcb1cca8 xen/virtio: Convert PAGE_SIZE/PAGE=
_SHIFT/PFN_UP to Xen counterparts)
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (225469d4acbc platform/x86: huawei-wmi: remove=
 unnecessary member)
Merging chrome-platform/for-next (d8cb88f1541f platform/chrome: cros_hps_i2=
c: make remove callback return void)
Merging hsi/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging leds/for-next (5f52a8ba7e91 dt-bindings: leds: Add 'cpuX' to 'linux=
,default-trigger')
Merging ipmi/for-next (cad3fe56d03e ipmi: Fix some kernel-doc warnings)
Merging driver-core/driver-core-next (1662cea4623f kset: fix memory leak wh=
en kset_register() returns error)
Merging usb/usb-next (8127cac0f393 usb: chipidea: usbmisc: add power lost c=
heck for imx7ulp)
Merging thunderbolt/next (2ae18cc2269f thunderbolt: ACPI: Use the helper fw=
node_find_reference())
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (247f34f7b803 Linux 6.1-rc2)
Merging tty/tty-next (9abf2313adc1 Linux 6.1-rc1)
Merging char-misc/char-misc-next (9abf2313adc1 Linux 6.1-rc1)
Merging coresight/next (5fc1531dd771 hwtracing: hisi_ptt: Fix up for "iommu=
/dma: Make header private")
Merging fpga/for-next (ee31d5038c06 dt-bindings: fpga: document Lattice sys=
CONFIG FPGA manager)
Merging icc/icc-next (9abf2313adc1 Linux 6.1-rc1)
Merging iio/togreg (6d965885f4ea iio: adc: mcp3911: add support for oversam=
pling ratio)
Merging phy-next/next (25dcaf94448f Merge branch 'fixes' into next)
Merging soundwire/next (cf43cd33b67a soundwire: qcom: add support for v1.7 =
Soundwire Controller)
Merging extcon/extcon-next (9abf2313adc1 Linux 6.1-rc1)
Merging gnss/gnss-next (247f34f7b803 Linux 6.1-rc2)
Merging vfio/next (b1b8132a651c vfio: More vfio_file_is_group() use cases)
Merging staging/staging-next (8cd75652300f staging: r8188eu: remove unused =
macros from wifi.h)
Merging counter-next/counter-next (9abf2313adc1 Linux 6.1-rc1)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (cd0ab43ec91a dmaengine: remove iop-adma driver)
Merging cgroup/for-next (6ab428604f72 cgroup: Implement DEBUG_CGROUP_REF)
$ git reset --hard HEAD^
Merging next-20221028 version of cgroup
Merging scsi/for-next (c8d0d0a1110f Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (e6629dcb00ad scsi: MAINTAINERS: Make Xiang Chen =
HiSilicon SAS controller driver maintainer)
Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
Merging rpmsg/for-next (1b09681fdc30 Merge branches 'rproc-next' and 'hwspi=
nlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (fbb19fe17eae gpio: pca9570: add slg7xl4510=
6 support)
Merging gpio-intel/for-next (8d259847243d gpiolib: cdev: Fix typo in kernel=
 doc for struct line)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (bfe66c8bb35c Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (98e63c1140a4 pinctrl: intel: Use str_enable=
_disable() helper)
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
Merging kselftest/next (94fea664ae4e selftests/ftrace: Convert tracer tests=
 to use 'requires' to specify program dependency)
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
Merging hyperv/hyperv-next (434243e8e739 hv_balloon: Add support for config=
urable order free page reporting)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (9abf2313adc1 Linux 6.1-rc1)
Merging kunit/test (9abf2313adc1 Linux 6.1-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (8f8b51f7d5c8 kunit: remove unused structure defin=
ition)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (1d96c542b291 MAINTAINERS: Remove Hemant from MHI bus)
Merging memblock/for-next (c52d25f56ffd memblock test: Update TODO list)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging cxl/next (9abf2313adc1 Linux 6.1-rc1)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (53ec9ccd138f MAINTAINERS: adjust entry after arm64 efi-en=
try.S file movement)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (938c9dbd50d4 Merge branch 'slab/for-6.2/fit_rcu_head=
' into slab/for-next)
Merging random/master (7da917e7c545 x86/espfix: Use get_random_long() rathe=
r than archrandom)
$ git reset --hard HEAD^
Merging next-20221028 version of random
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
Merging execve/for-next/execve (ef20c5139c31 binfmt_elf: simplify error han=
dling in load_elf_phdrs())
Merging bitmap/bitmap-for-next (27bc50fc9064 Merge tag 'mm-stable-2022-10-0=
8' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging hte/for-next (9abf2313adc1 Linux 6.1-rc1)
Merging kspp/for-next/kspp (cd1776b5b971 tpm: Avoid function type cast of p=
ut_device())
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging unsigned-char/unsigned-char (60881f525a34 ipvs: use explicitly sign=
ed chars)
Merging mm-stable/mm-stable (9abf2313adc1 Linux 6.1-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (9abf2313adc1 Linux 6.1-rc1)
Merging mm/mm-everything (30fa6ff7d681 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)

--Sig_/DRDn2IIgWRGRur8nPUuWIhU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNfdH4ACgkQAVBC80lX
0GzgRAgApkv444QZ2fR1daoe1GH8gihAe0g59Tvne/8KJrYFcSe/VVkQkWsx2Ga+
Hwad5d4m8As2q1sK0uOIveGFsUYStN+17A8GwkIXryPEwq123rwZrqDGXcpcljFv
F835de7HD0E4JgD7HUCJMBnmWshB1VQ8dEDtC302HASa8TGu1xFrSCVL/GFSvIUr
TjAPvSMy9qFnhjL0dOfXYgq5TRhCtuX8q/eWusBFpVnaEhy4be0ihRVbnA0aowYa
0DFZDFWDO4LJkSTpBd+TZH4cn+FnIiOFNVFA4vB0ISIiu+AHRx51R5iZk+2x+i+u
nx48D3F7YPAttLHdGFtEwgAPZkUrwQ==
=soKm
-----END PGP SIGNATURE-----

--Sig_/DRDn2IIgWRGRur8nPUuWIhU--
