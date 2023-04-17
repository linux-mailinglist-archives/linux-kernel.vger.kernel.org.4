Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866076E4078
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjDQHPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDQHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:15:05 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0F426BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:15:01 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id ljEy2900B1C8whw01jEyqk; Mon, 17 Apr 2023 09:14:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1poJ3q-00GyXd-D2
        for linux-kernel@vger.kernel.org;
        Mon, 17 Apr 2023 09:14:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1poJ4H-0043KN-Pv
        for linux-kernel@vger.kernel.org;
        Mon, 17 Apr 2023 09:14:29 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.3-rc7
Date:   Mon, 17 Apr 2023 09:14:29 +0200
Message-Id: <20230417071429.965980-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com>
References: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com>
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
v6.3-rc7[1] compared to v6.2[2].

Summarized:
  - build errors: +5/-5
  - build warnings: +56/-68

JFYI, when comparing v6.3-rc7[1] to v6.3-rc6[3], the summaries are:
  - build errors: +1/-2
  - build warnings: +0/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6a8f57ae2eb07ab39a6f0ccad60c760743051026/ (all 152 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c9c3395d5e3dcc6daee66c6908354d47bf98cb0c/ (all 152 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09a9639e56c01c7a00d6c0ca63f4c7c41abe075d/ (all 152 configs)


*** ERRORS ***

5 error regressions:
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 'struct cpuinfo_um' has no member named 'apicid':  => 2157:41, 2157:48
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7086:1
  + /kisskb/src/drivers/gpu/drm/msm/msm_mdss.c: error: case label does not reduce to an integer constant:  => 299:2, 296:2, 300:2
  + /kisskb/src/fs/btrfs/send.c: error: 'right_gen' may be used uninitialized in this function [-Werror=maybe-uninitialized]:  => 1909:13, 1902:23
  + {standard input}: Error: unknown pseudo-op: `.':  => 1118

5 error improvements:
  - /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer: 94:18, 94:19 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: error: array subscript is above array bounds [-Werror=array-bounds]: 543:55 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2224 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 7082:1 => 
  - /kisskb/src/include/linux/sh_intc.h: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]: 100:63 => 
  - {standard input}: Error: unknown pseudo-op: `.cfi_def_c': 1718 => 


*** WARNINGS ***

56 warning regressions:
  + /kisskb/src/fs/btrfs/extent_io.c: warning: 'last_extent_end' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 3542:19
  + /kisskb/src/fs/btrfs/send.c: warning: 'right_gen' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1909:27, 1909:13, 1902:23
  + /kisskb/src/fs/btrfs/volumes.c: warning: 'seed_devices' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 2524:9, 2524:2
  + /kisskb/src/include/linux/list.h: warning: 'seed_devices' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 74:12, 74:19
  + modpost: WARNING: modpost: "__ndelay" [drivers/hwspinlock/omap_hwspinlock.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/aten.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/bpck.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/comm.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/dstr.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/epat.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/epia.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/fit2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/fit3.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/friq.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/frpw.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/kbic.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/ktti.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/on20.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/on26.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_parport/pata_parport.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/char/pcmcia/cm4000_cs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/ucd9000.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/iio/adc/rzg2l_adc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads7924.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/common/saa7146/saa7146.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/imx296.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/imx415.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/tc358746.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/pci/saa7146/hexium_orion.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/pci/ttpci/budget-av.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/pci/ttpci/budget-core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/pci/ttpci/budget.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/platform/renesas/vsp1/vsp1.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/platform/rockchip/rkisp1/rockchip-isp1.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/platform/samsung/s3c-camif/s3c-camif.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/memory/mtk-smi.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/dsa/mt7530.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/fealnx.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/freescale/enetc/fsl-enetc-core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mux-meson-gxl.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath12k/ath12k.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath9k/ath9k_htc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/soc/amlogic/meson-ee-pwrc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/soc/amlogic/meson-gx-pwrc-vpu.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/soc/mediatek/mtk-mutex.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/staging/media/av7110/budget-patch.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/staging/media/av7110/dvb-ttpci.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/staging/media/av7110/sp8870.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ufs/host/ufs-sprd.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/renesas_usbf.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/usb/host/xhci-rcar-hcd.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/usb/phy/phy-mv-usb.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [sound/soc/apple/snd-soc-apple-mca.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-peb2466.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [sound/soc/mediatek/mt8188/snd-soc-mt8188-afe.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "empty_zero_page" [drivers/md/dm-flakey.ko] has no CRC!:  => N/A

68 warning improvements:
  - .config: warning: override: reassigning to symbol UML_NET_MCAST: 12669, 12874, 12888, 12655 => 
  - /kisskb/src/include/linux/sh_intc.h: warning: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Wsizeof-pointer-div]: 100:63 => 
  - modpost: WARNING: modpost: "__ashldi3" [drivers/input/joystick/sidewinder.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [drivers/misc/habanalabs/habanalabs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/xilinx/xilinx_emac.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [drivers/net/virtio_net.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [drivers/net/wireless/ath/ath10k/ath10k_core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [fs/hfsplus/hfsplus.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashldi3" [net/mac80211/mac80211.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashrdi3" [drivers/nvme/target/nvmet.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashrdi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashrdi3" [fs/xfs/xfs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__ashrdi3" [fs/zonefs/zonefs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/md/dm-writecache.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/md/dm-zoned.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/hpsa.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [fs/ext2/ext2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [fs/ext4/ext4.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [fs/gfs2/gfs2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [fs/ntfs3/ntfs3.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [fs/zonefs/zonefs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [net/mac80211/mac80211.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [net/sched/act_police.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/ata/pata_samsung_cf.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/aten.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/bpck.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/comm.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/dstr.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/epat.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/epia.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/fit2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/fit3.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/friq.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/frpw.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/kbic.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/ktti.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/on20.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/on26.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/pcd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/pd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/pf.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/pg.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/block/paride/pt.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/input/touchscreen/ucb1400_ts.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-cns3xxx.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/freescale/enetc/fsl-enetc-vf.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/freescale/enetc/fsl-enetc.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/rtc/rtc-v3020.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/spi/spi-omap-100k.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/av7110/budget-patch.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/av7110/dvb-ttpci.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/av7110/sp8870.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/common/saa7146.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/saa7146/hexium_orion.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/ttpci/budget-av.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/ttpci/budget-core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/saa7146/ttpci/budget.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/media/deprecated/zr364xx/zr364xx.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/r8188eu/r8188eu.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/host/xhci-plat-hcd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/video/fbdev/tmiofb.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/video/fbdev/w100fb.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [sound/soc/samsung/snd-soc-s3c24xx-i2s.ko] has no CRC!: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
