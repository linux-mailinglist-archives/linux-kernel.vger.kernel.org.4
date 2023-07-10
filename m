Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DC74D2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjGJKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGJKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:04 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63826B2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:00:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f087:2614:ec9d:569f])
        by andre.telenet-ops.be with bizsmtp
        id KN0C2A00H1w4dBK01N0CY3; Mon, 10 Jul 2023 12:00:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIngc-0010pP-Mt
        for linux-kernel@vger.kernel.org;
        Mon, 10 Jul 2023 12:00:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIngi-00B11T-Fe
        for linux-kernel@vger.kernel.org;
        Mon, 10 Jul 2023 12:00:12 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.5-rc1
Date:   Mon, 10 Jul 2023 12:00:12 +0200
Message-Id: <20230710100012.2625532-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
References: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.5-rc1[1] compared to v6.4[2].

Summarized:
  - build errors: +3/-4
  - build warnings: +36/-18

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5/ (all 162 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (160 out of 162 configs)


*** ERRORS ***

3 error regressions:
  + /kisskb/src/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c: error: the frame size of 1392 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]:  => 1036:1
  + error: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!:  => N/A
  + {standard input}: Error: unknown pseudo-op: `.glo':  => 1097

4 error improvements:
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 7179:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 7224:1 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]: 6163:45 => 
  - {standard input}: Error: unknown pseudo-op: `.': 1118 => 


*** WARNINGS ***

36 warning regressions:
  + modpost: WARNING: modpost: "__udelay" [drivers/char/hw_random/st-rng.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/gpio/gpio-aggregator.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/iio/pressure/mprls0025pa.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/phy/microchip_t1s.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw89/rtw89_8851b.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/qualcomm/phy-qcom-sgmii-eth.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/pinctrl/qcom/pinctrl-msm.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/pwm/pwm-microchip-core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_ice.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/spi/spi-rzv2m-csi.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [sound/soc/loongson/snd-soc-loongson-i2s-pci.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: drivers/cpufreq/sparc-us2e-cpufreq: section mismatch in reference: cpufreq_us2e_driver+0x20 (section: .data) -> us2e_freq_cpu_init (section: .init.text):  => N/A
  + modpost: WARNING: modpost: drivers/cpufreq/sparc-us3-cpufreq: section mismatch in reference: cpufreq_us3_driver+0x20 (section: .data) -> us3_freq_cpu_init (section: .init.text):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xd8 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x14 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x30 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x4c (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x68 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x84 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xa0 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xbc (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0xe0 (section: .text.unlikely) -> initcall_level_names (section: .init.data):  => N/A

18 warning improvements:
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/adl_pci9118.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/amplc_pci230.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/cb_das16_cs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/cb_pcidas.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/das800.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/mpc624.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_atmio.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_labpc_common.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl812.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl816.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl818.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/rti800.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/stmicro/stmmac/dwmac-altr-socfpga.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "empty_zero_page" [drivers/md/dm-flakey.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: vmlinux.o: section mismatch in reference: __trace_event_discard_commit (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
