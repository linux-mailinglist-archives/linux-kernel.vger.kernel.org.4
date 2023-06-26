Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6773D984
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjFZIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjFZIT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:19:56 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211883
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:19:54 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e662:523d:cfc0:1ef2])
        by michel.telenet-ops.be with bizsmtp
        id DkKq2A02i0kkhwT06kKq5P; Mon, 26 Jun 2023 10:19:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qDhRq-000QMw-Tt
        for linux-kernel@vger.kernel.org;
        Mon, 26 Jun 2023 10:19:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qDhRu-008lsO-Mh
        for linux-kernel@vger.kernel.org;
        Mon, 26 Jun 2023 10:19:50 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.4
Date:   Mon, 26 Jun 2023 10:19:50 +0200
Message-Id: <20230626081950.2090627-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
References: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.4[1] compared to v6.3[2].

Summarized:
  - build errors: +2/-11
  - build warnings: +31/-19

JFYI, when comparing v6.4[1] to v6.4-rc7[3], the summaries are:
  - build errors: +1/-0
  - build warnings: +1/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (all 160 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/457391b0380335d5e9a5babdec90ac53928b23b4/ (152 out of 160 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/45a3e24f65e90a047bef86f927ebdc4c710edaa1/ (all 160 configs)


*** ERRORS ***

2 error regressions:
  + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45
  + {standard input}: Error: branch to a symbol in another ISA mode: 4985, 4980 => 5012, 5023, 5017, 5028

11 error improvements:
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 'struct cpuinfo_um' has no member named 'apicid': 2157:48, 2157:41 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]: 2161:1 => 
  - /kisskb/src/drivers/gpu/drm/msm/msm_mdss.c: error: case label does not reduce to an integer constant: 299:2, 296:2, 300:2 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]: 641:28 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]: 641:28 => 
  - /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: 'op' is used uninitialized [-Werror=uninitialized]: 523:27, 564:27 => 
  - /kisskb/src/fs/btrfs/send.c: error: 'right_gen' may be used uninitialized in this function [-Werror=maybe-uninitialized]: 1902:23, 1909:13 => 
  - /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'gimple_call_addr_fndecl' was not declared in this scope: 2790:10 => 
  - /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'is_gimple_reg' was not declared in this scope: 2556:18 => 
  - /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field 'call_clobbered' has incomplete type 'pt_solution': 284:22 => 
  - /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field 'call_used' has incomplete type 'pt_solution': 283:22 => 


*** WARNINGS ***

31 warning regressions:
  + /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1128 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 400:1
  + modpost: WARNING: modpost: "__ashldi3" [drivers/input/joystick/sidewinder.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/xilinx/xilinx_emac.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/virtio_net.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/wireless/ath/ath10k/ath10k_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [fs/hfsplus/hfsplus.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [net/mac80211/mac80211.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashrdi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashrdi3" [fs/xfs/xfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/md/dm-writecache.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/md/dm-zoned.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/hpsa.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/ext2/ext2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/ext4/ext4.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/gfs2/gfs2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/ntfs3/ntfs3.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [net/mac80211/mac80211.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [net/sched/act_police.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-mv64xxx.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/hwmon/sfctemp.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/platform/nxp/imx8-isi/imx8-isi.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-cadence.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ptp/ptp_dfl_tod.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/spi/spi-davinci.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/thermal/mediatek/auxadc_thermal.ko] has no CRC!:  => N/A

19 warning improvements:
  - .config: warning: override: reassigning to symbol GCC_PLUGIN_SANCOV: 12711, 12930 => 
  - .config: warning: override: reassigning to symbol UML_NET_ETHERTAP: 12716, 12949, 12730, 12935 => 12827, 13048
  - .config: warning: override: reassigning to symbol UML_NET_SLIP: 12732, 12951, 12718, 12937 => 13050, 12829
  - .config: warning: override: reassigning to symbol UML_NET_SLIRP: 12942, 12723, 12737, 12956 => 13055, 12834
  - /kisskb/src/fs/btrfs/send.c: warning: 'right_gen' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1909:13, 1902:23, 1909:27 => 
  - /kisskb/src/fs/btrfs/volumes.c: warning: 'seed_devices' may be used uninitialized in this function [-Wmaybe-uninitialized]: 2524:2, 2524:9 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 404:1 => 
  - /kisskb/src/include/linux/list.h: warning: 'seed_devices' may be used uninitialized in this function [-Wmaybe-uninitialized]: 74:12, 74:19 => 
  - /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 170:24, 102:21 => 
  - /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/config/mips/mips.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 2913:20 => 
  - /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 126:24 => 
  - modpost: WARNING: modpost: "__udelay" [drivers/char/pcmcia/cm4000_cs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/char/pcmcia/synclink_cs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/noon010pc30.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/vs6624.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/intel/ixgb/ixgb.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-thunderbay-emmc.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/host/u132-hcd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/misc/ftdi-elan.ko] has no CRC!: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
