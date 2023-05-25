Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39225710371
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjEYDt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:49:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ACCE2;
        Wed, 24 May 2023 20:49:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRYwB61Cgz4x2j;
        Thu, 25 May 2023 13:49:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684986587;
        bh=fYfE2lRFwvdIeyiwyHCYx908lQ4hciNs/4cBW/BsP50=;
        h=Date:From:To:Cc:Subject:From;
        b=bf0Adarq2oOpcMwumw80duCn7GUVQrDR2Cw6mkAiy1GCCFIUpbN91xWJnzaHC6Zaj
         MBy5I0oi2qkzN7uYC2VqO7E2ZZ5u7PCkv7XkP8t+a8VcQEPJevB1xrJ55bP23x+MMX
         +i4JM5Nsq9hO/XDZ2Yg/CcLUyON5kEuF9Qs7zFzEPrnOD28sqLdpM4Sp6xaT4dST7Y
         h20/ALBCAKrOYhidEfQ9oUbk8dJA2fOzN/GlVbwO8uVAupscnvYWm+Ug2qJHwGS9B5
         MbyFQWysATm4TMSAnKNt4tiOMIJh7tAsxa/8gBon1pj4D9BBNrsSkKSNsKTOs8Uj0+
         YayoQ58nqXIXg==
Date:   Thu, 25 May 2023 13:49:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 25
Message-ID: <20230525134945.7df0c294@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8azXkv3i6B5Kwdh1=UzSK6G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8azXkv3i6B5Kwdh1=UzSK6G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: There will be no linux-next releases tomorrow or on Monday.

Changes since 20230524:

The net-next tree gained a conflict against the net tree.

The crypto tree lost its build failure.

The sound tree lost its build failure.

The tip tree still had a boot failure on ppc, for which I reverted
2 commits.

Non-merge commits (relative to Linus' tree): 4146
 4989 files changed, 167057 insertions(+), 62937 deletions(-)

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

I am currently merging 363 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (933174ae28ba Merge tag 'spi-fix-v6.4-rc3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging mm-hotfixes/mm-hotfixes-unstable (a863526c7b70 riscv/purgatory: rem=
ove PGO flags)
Merging kbuild-current/fixes (f1fcbaa18b28 Linux 6.4-rc2)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (fd2d1cb8c545 arm64: Make the ARCH_FORCE=
_MAX_ORDER config input prompt unconditional)
Merging arm-soc-fixes/arm/fixes (d75eecc3d170 Merge tag 'qcom-arm64-fixes-f=
or-6.3-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux int=
o arm/fixes)
Merging davinci-current/davinci/for-current (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (b845b574f86d m68k: Move signal frame follow=
ing exception on 68020/030)
Merging powerpc-fixes/fixes (358e526a1648 powerpc/mm: Reinstate ARCH_FORCE_=
MAX_ORDER ranges)
Merging s390-fixes/fixes (89c0c62e947a s390/cio: unregister device when the=
 only path is gone)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (878ecb0897f4 ipv6: Fix out-of-bounds access in ipv6_find_=
tlv())
Merging bpf/master (f726e03564ef bpf, sockmap: Test progs verifier error wi=
th latest clang)
Merging ipsec/master (67caf26d769e Merge tag 'for-net-2023-05-19' of git://=
git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (9025944fddfe net: fec: add dma_wmb to ensure correct des=
criptor values)
Merging wireless/for-next (212457ccbd60 wifi: b43: fix incorrect __packed a=
nnotation)
Merging wpan/master (bd4e3d82f4cc MAINTAINERS: Add wpan patchwork)
Merging rdma-fixes/for-rc (56518a603fd2 RDMA/hns: Modify the value of long =
message loopback slice)
Merging sound-current/for-linus (4ca110cab465 ALSA: hda/realtek: Enable hea=
dset onLenovo M70/M90)
Merging sound-asoc-fixes/for-linus (2d7c2f9272de ASoC: codecs: wcd938x-sdw:=
 do not set can_multi_write flag)
Merging regmap-fixes/for-linus (0cc6578048e0 regmap: maple: Drop the RCU re=
ad lock while syncing registers)
Merging regulator-fixes/for-linus (a511637502b1 regulator: mt6359: add read=
 check for PMIC MT6359)
Merging spi-fixes/for-linus (4be47a5d59cb spi: mt65xx: make sure operations=
 completed before unloading)
Merging pci-current/for-linus (3b8803494a06 PCI/DPC: Quirk PIO log size for=
 Intel Ice Lake Root Ports)
Merging driver-core.current/driver-core-linus (f1fcbaa18b28 Linux 6.4-rc2)
Merging tty.current/tty-linus (8fb9ea65c9d1 vc_screen: reload load of struc=
t vc_data pointer in vcs_write() to avoid UAF)
Merging usb.current/usb-linus (ddaf098ea779 driver core: class: properly re=
ference count class_dev_iter())
Merging usb-serial-fixes/usb-linus (44c026a73be8 Linux 6.4-rc3)
Merging phy/fixes (2a881183dc5a phy: qcom-snps: correct struct qcom_snps_hs=
phy kerneldoc)
Merging staging.current/staging-linus (b3dad076a058 staging: octeon: delete=
 my name from TODO contact)
Merging iio-fixes/fixes-togreg (bbaae0c79ebd iio: imu: inv_icm42600: fix ti=
mestamp reset)
Merging counter-current/counter-current (ac9a78681b92 Linux 6.4-rc1)
Merging char-misc.current/char-misc-linus (d1d8875c8c13 binder: fix UAF of =
alloc->vma in race with munmap())
Merging soundwire-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging thunderbolt-fixes/fixes (70c2e03e9aaf thunderbolt: dma_test: Use co=
rrect value for absent rings when creating paths)
Merging input-current/for-linus (feee70f45686 Input: xpad - delete a Razer =
DeathAdder mouse VID/PID entry)
Merging crypto-current/master (6ab39f99927e crypto: x86/aria - Use 16 byte =
alignment for GFNI constant vectors)
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (dbcf76390eb9 selftests/ftrace: Improve integ=
ration with kselftest runner)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (e14fd2af7a1d dmaengine: at_hdmac: Extend the=
 Flow Controller bitfield to three bits)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (637ae8f2560b mtdchar: mark bits of ioctl handl=
er noinline)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (8c1688e897a6 Merge tag 'v6.4-rc2' into v4l_for=
_linus)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (4897a898a216 mips: Move initrd_start check a=
fter initrd address sanitisation.)
Merging at91-fixes/at91-fixes (6b0db163ff92 ARM: dts: at91: sama7g5ek: fix =
debounce delay property for shdwc)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (b9846a698c9a KVM: VMX: add MSR_IA32_TSX_CTRL into=
 msrs_to_save)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (0babf89c9cca hwmon: (f71882fg) prevent possible =
division by zero)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (a70fc4ed20a6 cxl/port: Fix NULL pointer access in =
devm_cxl_add_port())
Merging btrfs-fixes/next-fixes (7f6d8752b79e Merge branch 'misc-6.4' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (3279decb2c3c platform/x86/intel/ifs: Annot=
ate work queue on stack so object debug does not complain)
Merging samsung-krzk-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging pinctrl-samsung-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging devicetree-fixes/dt/linus (6997f847cbb7 MAINTAINERS: add Conor as a=
 dt-bindings maintainer)
Merging dt-krzk-fixes/fixes (8bbec86ce6d6 dt-bindings: PCI: fsl,imx6q: fix =
assigned-clocks warning)
Merging scsi-fixes/fixes (d54820b22e40 scsi: qla2xxx: Fix NULL pointer dere=
ference in target mode)
Merging drm-fixes/drm-fixes (79ef1c9d14c6 Merge tag 'amd-drm-fixes-6.4-2023=
-05-18' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (45dfbd992923 drm/i915: Fix PI=
PEDMC disabling for a bigjoiner configuration)
Merging mmc-fixes/fixes (0b5d5c436a5c mmc: pwrseq: sd8787: Fix WILC CHIP_EN=
 and RESETN toggling order)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (44c026a73be8 Linux 6.4-rc3)
Merging hyperv-fixes/hyperv-fixes (ec97e112985c Drivers: hv: vmbus: Call hv=
_synic_free() if hv_synic_alloc() fails)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (3b90b09af5be riscv: Fix orphan section warnings=
 caused by kernel/pi)
Merging riscv-dt-fixes/riscv-dt-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (a7a041f2ddf3 soc: microchip: mpfs:=
 handle failed system service requests)
Merging fpga-fixes/fixes (3c66c757bfb1 dt-bindings: fpga: replace Ivan Born=
yakov maintainership)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging spdx/spdx-linus (d635f6cc934b Merge tag 'drm-fixes-2023-05-20' of g=
it://anongit.freedesktop.org/drm/drm)
Merging gpio-brgl-fixes/gpio/for-current (3002b8642f01 gpio-f7188x: fix chi=
p name and pin count on Nuvoton chip)
Merging gpio-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-intel-fixes/fixes (44c026a73be8 Linux 6.4-rc3)
Merging erofs-fixes/fixes (cf7f2732b4b8 erofs: use HIPRI by default if per-=
cpu kthreads are enabled)
Merging kunit-fixes/kunit-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (d53d70084d27 nfsd: make a copy of struct iat=
tr before calling notify_change)
Merging irqchip-fixes/irq/irqchip-fixes (cddb536a73ef irqchip/mbigen: Unify=
 the error handling in mbigen_of_create_domain())
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (44c026a73be8 Linux 6.4-rc3)
Merging efi-fixes/urgent (3610dc36f4fd efi/libstub: zboot: Avoid eager eval=
uation of objcopy flags)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (95339f40a8b6 power: supply: Fix logic checking=
 if system is running from battery)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (f1fcbaa18b28 Linux 6.4-rc2)
Merging rust-fixes/rust-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging v9fs-fixes/fixes/next (36896bc97c0e fs/9p: Fix a datatype used with=
 V9FS_DIRECT_IO)
Merging w1-fixes/fixes (ac9a78681b92 Linux 6.4-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (e79d85c6c217 drm/fb-helper: Fi=
x height, width, and accel_flags in fb_var)
Merging mm-stable/mm-stable (44c026a73be8 Linux 6.4-rc3)
Merging mm-nonmm-stable/mm-nonmm-stable (44c026a73be8 Linux 6.4-rc3)
Merging mm/mm-everything (1374df24c22a Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (b230235b3865 docs: Set minimal gtags / GNU GLOBAL =
version to 6.6.5)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf-tools-next (7cdda6998ee5 Merge remote-tracking branch 'ac=
me/perf-tools' into perf-tools-next)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (ec274aff21b6 swiotlb: Omit total_used and use=
d_hiwater if !CONFIG_DEBUG_FS)
Merging asm-generic/master (6e542e9820c2 Merge tag 'virt-to-pfn-for-arch-v6=
.5' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrato=
r into asm-generic)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (fc6750b0d4a9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (0fddb79bf283 arm64: lds: move .got section out=
 of .text)
Merging arm-perf/for-next/perf (257aedb72e73 drivers/perf: hisi: add NULL c=
heck for name)
Merging arm-soc/for-next (8ecfe9a0e657 soc: document merges)
Merging amlogic/for-next (0618cb14da6a Merge branch 'v6.5/arm-dt' into for-=
next)
Merging asahi-soc/asahi-soc/for-next (f41aba157819 Merge branch 'asahi-soc/=
dt' into asahi-soc/for-next)
Merging aspeed/for-next (7d4f0b0df7c5 ARM: dts: aspeed-g6: Add UDMA node)
Merging at91/at91-next (9c8457a847fa Merge branch 'clk-microchip' into at91=
-next)
Merging broadcom/next (bba5ad8482de Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging drivers-memory/for-next (3d56c7364389 memory: renesas-rpc-if: Fix P=
HYCNT.STRTIM setting)
Merging imx-mxs/for-next (efdde75fee54 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (e586dd447172 Merge branch 'v6.3-next/soc' into f=
or-next)
Merging mvebu/for-next (64687391f64d Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (c45167f4f5cf Merge branch 'omap-for-v6.4/dt' into fo=
r-next)
Merging qcom/for-next (122540030244 Merge branches 'arm64-defconfig-for-6.5=
', 'arm64-fixes-for-6.4', 'arm64-for-6.5', 'clk-for-6.5', 'drivers-fixes-fo=
r-6.4', 'drivers-for-6.5' and 'dts-fixes-for-6.4' into for-next)
Merging renesas/next (21330625d0f5 Merge branches 'renesas-arm-defconfig-fo=
r-v6.5' and 'renesas-drivers-for-v6.5' into renesas-next)
Merging reset/reset/next (afb39e2bd36a reset: mpfs: select AUXILIARY_BUS)
Merging rockchip/for-next (9814edb27062 Merge branch 'v6.5-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (5b248db78d1a Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (e06854e84add Merge tags 'scmi-fix-6.4', 'juno-=
fixes-6.4' and 'ffa-fixes-6.4' of git://git.kernel.org/pub/scm/linux/kernel=
/git/sudeep.holla/linux into for-linux-next)
Merging stm32/stm32-next (3b1583868691 ARM: dts: stm32: fix m4_rproc refere=
nces to use SCMI for stm32mp15)
Merging sunxi/sunxi/for-next (7554aa0897a3 Merge branch 'sunxi/dt-for-6.5' =
into sunxi/for-next)
Merging tee/next (86dfcfab4fe0 Merge branch 'optee_fix_async_notif_for-v6.3=
' into next)
Merging tegra/for-next (d52733725601 Merge branch for-6.5/arm64/dt into for=
-next)
Merging ti/ti-next (6bb0b834e3c2 Merge branch 'ti-drivers-soc-next' into ti=
-next)
Merging xilinx/for-next (6c363be08288 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (be2033a8660c Merge branch 'clk-i2cid' into clk-next)
Merging clk-imx/for-next (632c60ecd25d clk: imx: scu: use _safe list iterat=
or to avoid a use after free)
Merging clk-renesas/renesas-clk (d1c20885d3b0 clk: renesas: rzg2l: Fix CPG_=
SIPLL5_CLK1 register write)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (ac9a78681b92 Linux 6.4-rc1)
Merging loongarch/loongarch-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging m68k/for-next (72b44f6577f1 nubus: Don't list slot resources by def=
ault)
Merging m68knommu/for-next (44c026a73be8 Linux 6.4-rc3)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (c5e4d83872ae mips: dts: ingenic: x1000: Add AIC dev=
ice tree node)
Merging openrisc/for-next (c91b4a07655d openrisc: Add floating point regset)
Merging parisc-hd/for-next (61e150fb3107 parisc: Fix flush_dcache_page() fo=
r usage from irq context)
Merging powerpc/next (7d3ee229ea51 powerpc: Drop MPC5200 LocalPlus bus FIFO=
 driver)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging riscv-dt/riscv-dt-for-next (6361b7de262a riscv: dts: starfive: jh71=
10: Add watchdog node)
Merging riscv-soc/riscv-soc-for-next (ac9a78681b92 Linux 6.4-rc1)
Merging s390/for-next (0f97c70a021b Merge branch 'pkey' into for-next)
Merging sh/for-next (bc9d1f0cecd2 sh: j2: Use ioremap() to translate device=
 tree address into kernel memory)
Merging uml/next (6032aca0deb9 um: make stub data pages size tweakable)
Merging xtensa/xtensa-for-next (d0f94ebe1864 xtensa: add asm-prototypes.h)
Merging pidfd/for-next (ad0ff58dc959 pid: Replace struct pid 1-element arra=
y with flex-array)
Merging fscrypt/for-next (d617ef039fb8 fscrypt: Replace 1-element array wit=
h flexible array)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (bee415fb3e64 Merge branch 'for-next-next-v6.4-20230=
522' into for-next-20230522)
Merging ceph/master (4cafd0400bcb ceph: force updating the msg pointer in n=
on-split case)
Merging cifs/for-next (294fe7893e6c smb3: update maintainer email)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (ac9a78681b92 Linux 6.4-rc1)
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (25e95089559f Merge fanotify support for FID events f=
or filesystems not supporting NFS exports.)
Merging ext4/dev (2a534e1d0d15 ext4: bail out of ext4_xattr_ibody_get() fai=
ls for any reason)
Merging f2fs/dev (8b1be8160277 f2fs: renew value of F2FS_FEATURE_*)
Merging fsverity/for-next (c61c38330e58 fsverity: use shash API instead of =
ahash API)
Merging fuse/for-next (c68ea140050e fuse: remove duplicate check for nodeid)
Merging gfs2/for-next (6ddd5e9eaadf gfs2: Don't remember delete unless it's=
 successful)
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (44c026a73be8 Linux 6.4-rc3)
Merging nfs/linux-next (e8d018dd0257 Linux 6.3-rc3)
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (bdd7ea53b5c9 NFSD: enable support for write delegat=
ion)
Merging ntfs3/master (1f60ec888102 fs/ntfs3: Add support /proc/fs/ntfs3/<de=
v>/volinfo and /proc/fs/ntfs3/<dev>/label)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging xfs/for-next (2254a7396a0c xfs: fix xfs_inodegc_stop racing with mo=
d_delayed_work)
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
Merging iomap/iomap-for-next (3fd41721cd5c iomap: Add DIO tracepoints)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (63355b9884b3 cpumask: be more careful with '=
cpumask_setall()')
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (da4e876407c4 Merge branch 'fs.ntfs' into vfs.a=
ll)
CONFLICT (content): Merge conflict in fs/ntfs/mft.c
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (16bff6f075a1 Merge branch 'for-6.4' into for-next)
Merging pci/next (a40140c9f009 Merge branch 'pci/controller/vmd')
Merging pstore/for-next/pstore (48f2c681df43 pstore/ram: Convert to platfor=
m remove callback returning void)
Merging hid/for-next (ba376baf3639 Merge branch 'for-6.5/amd-sfh' into for-=
next)
Merging i2c/i2c/for-next (03230ddddf9d Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (6b496a94c590 i3c: ast2600: set variable ast2600_i3c_o=
ps storage-class-specifier to static)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (7e880e1fb338 hwmon: (aht10) Add support f=
or compatible aht20)
Merging jc_docs/docs-next (a1d2c9b3029d docs: process: fix a typoed cross-r=
eference)
Merging v4l-dvb/master (a23a3041c733 Merge tag 'v6.4-rc2' into media_stage)
Merging v4l-dvb-next/master (382ce82fe2b1 media: v4l2-subdev.h: document cl=
ient_caps at struct v4l2_subdev_fh)
Merging pm/linux-next (28a5aae81bfd Merge branches 'acpi-x86', 'acpi-video'=
 and 'acpi-soc' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (11a3b0ac33d9 cpufreq: imx6q: do=
n't warn for disabling a non-existing frequency)
Merging cpupower/cpupower (25891bc945f7 cpupower: Bump soname version)
Merging devfreq/devfreq-next (376b1446153c PM / devfreq: exynos-ppmu: Use d=
evm_platform_get_and_ioremap_resource())
Merging opp/opp/linux-next (9e28f7a74581 OPP: rate-limit debug messages whe=
n no change in OPP is required)
Merging thermal/thermal/linux-next (2afa82d1fc64 dt-bindings: thermal: qcom=
-tsens: Correct unit address)
Merging dlm/next (57e2c2f2d94c fs: dlm: fix mismatch of plock results from =
userspace)
Merging rdma/for-next (a7dae5daf4bf RDMA/irdma: Move iw device ops initiali=
zation)
Merging net-next/main (8a5ad2ea6b87 Merge branch 'net-pcs-xpcs-cleanups-for=
-clause-73-support')
CONFLICT (content): Merge conflict in net/ipv4/raw.c
Merging bpf-next/for-next (fcf1fa29c8ea Merge branch 'libbpf: capability fo=
r resizing datasec maps')
Merging ipsec-next/master (b2cbac9b9b28 net: Remove low_thresh in ip defrag)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (dcbe4ea1985d Merge branch '1GbE' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging bluetooth/master (b7e415f145f7 Bluetooth: Fix use-after-free in hci=
_remove_ltk/hci_remove_irk)
Merging wireless-next/for-next (156d30084295 Merge ath-next from git://git.=
kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging wpan-next/master (1af3de62f03f ieee802154: ca8210: Flag the driver =
as being limited)
Merging wpan-staging/staging (1af3de62f03f ieee802154: ca8210: Flag the dri=
ver as being limited)
Merging mtd/mtd/next (a2c2690f0d74 mtd: st_spi_fsm: Use the devm_clk_get_en=
abled() helper function)
Merging nand/nand/next (ac9a78681b92 Linux 6.4-rc1)
Merging spi-nor/spi-nor/next (df6def86b9dc mtd: spi-nor: spansion: Add supp=
ort for s25hl02gt and s25hs02gt)
Merging crypto/master (66dd59b7aa55 crypto: Kconfig - warn about performanc=
e overhead of CRYPTO_STATS)
Merging drm/drm-next (33a86170888b Merge tag 'drm-misc-next-2023-05-11' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (90d63a150b85 drm/doc: Relax fdinfo string =
constraints)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging amdgpu/drm-next (fd8f7bb391fa drm/amdgpu/vcn: Modify mismatched fun=
ction name)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/Kconfig
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_crtc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/dc_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn31/=
dcn31_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn32/=
dcn32_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/display_mode_vba_32.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/display_mode_vba_32.h
CONFLICT (content): Merge conflict in include/drm/display/drm_dp.h
Merging drm-intel/for-linux-next (95c08508e237 drm/i915/display: Move featu=
re test macros to intel_display_device.h)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (ac7e7c9c65ec drm/msm/dpu: drop unused macros from=
 hw catalog)
Merging drm-msm-lumag/msm-next-lumag (584d8826077d Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp' and 'msm-next-lumag=
-dsi' into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging regmap/for-next (f6fa16ab9ee6 Merge remote-tracking branch 'regmap/=
for-6.5' into regmap-next)
Merging sound/for-next (0006fa2d3fa0 ALSA: emu10k1: fix multi-channel captu=
re config for E-MU cards)
Merging ieee1394/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging sound-asoc/for-next (55b7eb9f4dcb Merge remote-tracking branch 'aso=
c/for-6.5' into asoc-next)
Merging modules/modules-next (5950435d91cf kallsyms: remove unused arch_get=
_kallsym() helper)
Merging input/next (b00315628095 Input: tests - add test to cover all input=
_grab_device() function)
Merging block/for-next (9b728d3f0796 Merge branch 'for-6.5/block' into for-=
next)
Merging device-mapper/for-next (38d11da522aa dm: don't lock fs when the map=
 is NULL in process of resume)
Merging libata/for-next (f19c694f744f ata: pata_parport: Fix frpw module co=
de indentation and style)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (aee09fd99934 Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (84009765adb3 dt-bindings: mfd: Add bindings for A=
XP192 MFD device)
Merging backlight/for-backlight-next (fb200218b40b backlight: as3711: Use o=
f_property_read_bool() for boolean properties)
Merging battery/for-next (eae36cb82440 power: reset: add HAS_IOPORT depende=
ncies)
Merging regulator/for-next (fb8b96b03d4b Merge remote-tracking branch 'regu=
lator/for-6.5' into regulator-next)
Merging security/next (a495108ea99c capability: fix kernel-doc warnings in =
capability.c)
Merging apparmor/apparmor-next (0bb84cff96af apparmor: fix missing error ch=
eck for rhashtable_insert_fast)
Merging integrity/next-integrity (db1d1e8b9867 IMA: use vfs_getattr_nosec t=
o get the i_version)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (8bfbd046a3a8 selinux: deprecated fs ocon)
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (933fd4391e3d workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (9668133e7875 tpm: tpm_vtpm_proxy: fix a race condition =
in /dev/vtpmx creation)
Merging watchdog/master (fc4354c6e5c2 Merge tag 'mm-stable-2023-05-06-10-49=
' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
Merging iommu/next (79456bb95a2f Merge branches 'iommu/fixes', 'virtio', 'x=
86/amd' and 'core' into next)
Merging audit/next (e455ca40dbcf audit: avoid missing-prototype warnings)
Merging devicetree/for-next (c50eb01940c7 Merge branch 'dt/address-cleanups=
' into dt/next)
Merging dt-krzk/for-next (0ff3c07556e6 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (d396133dced4 dt-bindings: mailbox: qcom: =
add compatible for IPQ9574 SoC)
Merging spi/for-next (76bf90aaee83 Merge remote-tracking branch 'spi/for-6.=
5' into spi-next)
Merging tip/master (3a128547bd44 Merge branch into tip/master: 'x86/sev')
CONFLICT (content): Merge conflict in tools/perf/arch/x86/include/arch-test=
s.h
CONFLICT (content): Merge conflict in tools/perf/arch/x86/tests/arch-tests.c
Applying: Revert "arch: Remove cmpxchg_double"
Applying: Revert "slub: Replace cmpxchg_double()"
Merging clockevents/timers/drivers/next (158009f1b4a3 timekeeping: Fix refe=
rences to nonexistent ktime_get_fast_ns())
Merging edac/edac-for-next (6c79e42169fe EDAC/amd64: Add support for ECC on=
 family 19h model 60h-7Fh)
Merging irqchip/irq/irqchip-next (2ff1b0839ddd Merge branch irq/misc-6.4 in=
to irq/irqchip-next)
Merging ftrace/for-next (3862f86c1529 Merge tools/for-next)
Merging rcu/rcu/next (60901dadfadc rcuscale: Measure grace-period kthread C=
PU time)
Applying: fixup for "RDMA/rxe: Add error messages"
Merging kvm/next (39428f6ea9ea Merge tag 'kvmarm-fixes-6.4-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvm-arm/next (cad58a69de18 Merge branch kvm-arm64/misc into kvmarm/=
next)
Merging kvms390/next (8a46df7cd135 KVM: s390: pci: fix virtual-physical con=
fusion on module unload/load)
Merging kvm-riscv/riscv_kvm_next (2f4d58f7635a RISC-V: KVM: Virtualize per-=
HART AIA CSRs)
Merging kvm-x86/next (39428f6ea9ea Merge tag 'kvmarm-fixes-6.4-1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging xen-tip/linux-next (335b4223466d x86/pci/xen: populate MSI sysfs en=
tries)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (4ac49f8d6110 Merge branch 'for-6.5' into for-n=
ext)
Merging drivers-x86/for-next (e34cd89a6af7 platform/x86: lenovo-yogabook: a=
dd I2C dependency)
Merging chrome-platform/for-next (4b9abbc132b8 platform/chrome: cros_ec_lpc=
: Move host command to prepare/complete)
Merging hsi/for-next (32a31bd41be1 HSI: fix ssi_waketest() declaration)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (7a9496d0feb5 dt-bindings: leds: Drop redunda=
nt cpus enum match)
Merging ipmi/for-next (9930702cfebb ipmi_watchdog: Fix read syscall not res=
ponding to signals during sleep)
Merging driver-core/driver-core-next (f1fcbaa18b28 Linux 6.4-rc2)
Merging usb/usb-next (ee4d21aa4a22 MAINTAINERS: remove broken entries in QU=
ALCOMM TYPEC PORT MANAGER DRIVER)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/gadget.c
CONFLICT (content): Merge conflict in drivers/usb/gadget/udc/core.c
Merging thunderbolt/next (f1138fda1b0d thunderbolt: Drop retimer vendor che=
ck)
Merging usb-serial/usb-next (44c026a73be8 Linux 6.4-rc3)
Merging tty/tty-next (d5b3d02d0b10 serial: Make uart_remove_one_port() retu=
rn void)
Merging char-misc/char-misc-next (c21c0f9a20a9 Binder: Add async from to tr=
ansaction record)
Merging accel/habanalabs-next (dd931cf607e8 accel/habanalabs: move ioctl er=
ror print to debug level)
Merging coresight/next (18996a113f25 coresight: etm_pmu: Set the module fie=
ld)
Merging fastrpc/for-next (3f6b4c6f0bd0 fastrpc: Don't assert held reservati=
on lock for dma-buf mmapping)
Merging fpga/for-next (da4da5b2d708 fpga: dfl-fme: constify pointers to hwm=
on_channel_info)
Merging icc/icc-next (d07b2e0ce326 Merge branch 'icc-qos' into icc-next)
Merging iio/togreg (a508fbfed333 iio: kx022a: Probe asynchronously)
Merging phy-next/next (e45076007e35 phy: mediatek: tphy: add debugfs files)
Merging soundwire/next (9420c9719f03 soundwire: bus: Don't filter slave ale=
rts)
Merging extcon/extcon-next (4e30418def07 extcon: Drop unneeded assignments)
CONFLICT (content): Merge conflict in drivers/extcon/extcon.c
Merging gnss/gnss-next (44c026a73be8 Linux 6.4-rc3)
Merging vfio/next (6c8017c6a58d vfio/pci: Clear VFIO_IRQ_INFO_NORESIZE for =
MSI-X)
Merging w1/for-next (b332af5398a3 w1: Replace usage of found with dedicated=
 list iterator variable)
Merging staging/staging-next (1f3413dc8eb0 staging: rtl8192e: Refactor tmp_=
ofdm_index variable assignment)
Merging counter-next/counter-next (98ffe0252911 counter: 104-quad-8: Migrat=
e to the regmap API)
Merging mux/for-next (213700a8b96f dt-bindings: ti-serdes-mux: Add defines =
for J784S4 SoC)
Merging dmaengine/next (907514a7dc4c dmaengine: sprd: Don't set chancnt)
Merging cgroup/for-next (39ad5a5ef95e Merge branch 'for-6.5' into for-next)
Merging scsi/for-next (d8975ee303e6 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (f047d1e38bdf scsi: docs: sym53c8xx_2: Shorten ch=
apter heading)
Merging vhost/linux-next (ebddc00f450d vhost_net: revert upend_idx only on =
retriable error)
Merging rpmsg/for-next (1ca04f21b204 remoteproc: stm32: Fix error code in s=
tm32_rproc_parse_dt())
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (6d255623d798 gpio: brcmstb: Use devm_platf=
orm_get_and_ioremap_resource())
Merging gpio-intel/for-next (782eea0c89f7 gpiolib: acpi: Add a ignore wakeu=
p quirk for Clevo NL5xNU)
Merging pinctrl/for-next (226d95a8668c Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (44c026a73be8 Linux 6.4-rc3)
Merging pinctrl-renesas/renesas-pinctrl (5d32cead772c pinctrl: renesas: Fix=
 spaces followed by tabs)
Merging pinctrl-samsung/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging pwm/for-next (247ee6c78040 pwm: Remove unused radix tree)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (3ecb4a459a1e selftests/ftrace: Add new test case wh=
ich checks for optimized probes)
Merging kunit/test (ac9a78681b92 Linux 6.4-rc1)
Merging kunit-next/kunit (a5ce66ad292b kunit: example: Provide example exit=
 functions)
Merging livepatching/for-next (5e36be5973b6 Merge branch 'for-6.4/core' int=
o for-next)
Merging rtc/rtc-next (e99ab4abebf8 rtc: armada38x: use devm_platform_iorema=
p_resource_byname())
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (a3c10035d12f eeprom: at24: Use dev_err_probe fo=
r nvmem register failure)
Merging ntb/ntb-next (942cc9ceccb6 ntb: intel: Remove redundant pci_clear_m=
aster)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging nvmem/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (a494aef23dfc PCI: hv: Replace retarget_msi_inte=
rrupt_params with hyperv_pcpu_input_arg)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (ac9a78681b92 Linux 6.4-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (1d1493bdc25f bus: mhi: host: Use mhi_tryset_pm_state(=
) for setting fw error state)
Merging memblock/for-next (493f349e38d0 memblock: Add flags and nid info in=
 memblock debugfs)
Merging cxl/next (a70fc4ed20a6 cxl/port: Fix NULL pointer access in devm_cx=
l_add_port())
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (d86ff3333cb1 efivarfs: expose used and total size)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (f437fdcc73f5 Merge branch 'slab/for-6.5/prandom' int=
o slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (ac9a78681b92 Linux 6.4-rc1)
Merging sysctl/sysctl-next (b8cbc0855a22 sysctl: Remove register_sysctl_tab=
le)
Merging execve/for-next/execve (60592fb6b67c coredump, vmcore: Set p_align =
to 4 for PT_NOTE)
Merging bitmap/bitmap-for-next (714f3af11b21 cpumask: fix function descript=
ion kernel-doc notation)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (ef9a15665707 lkdtm/bugs: Switch from 1-element =
array to flexible array)
Merging kspp-gustavo/for-next/kspp (00168b415a60 uapi: net: ipv6: Replace f=
ake flex-array with flex-array member)
Merging iommufd/for-next (f1fcbaa18b28 Linux 6.4-rc2)

--Sig_/8azXkv3i6B5Kwdh1=UzSK6G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRu2tkACgkQAVBC80lX
0Gz6Qwf8CCHHVQherI0xMOMMlrXeSUifa44ITxlq9VmgOv1cfFeoZ3UaxbWw7W3o
GpWcuWZLaXrh31Xy/yxtU8ICePkBgw+12rGY2r521SRrSukdSKnRYa8JZPU08wdp
4Mj41N3dGNnTWiyX8kLr1syUDt22O+e43jEFGVoZcQLxxeCp8YGEwb54jcVgQCsB
FSgDabzqDwJOx2877aRo8Rlshy90TVJfLlpxDrBuvI4+NoEB7vkBqTFG44xj9HP7
49F8FYDAQjXeAnMKaBji50Ky1mZjWMcOwT95dxM6DYDymjqe9h4Szcnx/3sLqBPX
ssGDDLBTsA7S9/LluTzNFGkK28H5Hw==
=vUzP
-----END PGP SIGNATURE-----

--Sig_/8azXkv3i6B5Kwdh1=UzSK6G--
