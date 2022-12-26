Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596B4656116
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiLZI2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLZI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:28:27 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF98112F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:28:25 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id b77-20020a6bb250000000b006e4ec8b2364so3521822iof.20
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy3bZ15GySUtsWXcVfFSVT0vY9KDuA8riA9Tgjxs+r4=;
        b=SJhh47Mp3VM5DIkWPU0sGmXhx7XpbjSfzdL2iFJekBtOYSeX+iLIYBZ1t2XrCnttgF
         Abuhl9rEbHlqXyPMOonC1sjYOP1rKTMfHxBNH2G0SI9ogkma8s+u4sPqjZ/gnxPkRGoe
         daH2DTfHdEUZo+z2s6mNRjC9hlz7sbziUCRbhGiZRlUIBAIsNgcvLK69kultygQmAaKD
         c/3s3Pt9oMqGMFF/h9v/izjc7C1wfefmpSvyxAHLQG5v7BKKFdUXl0W7i7dk8j369CjJ
         3iB3EsN7z5lI5R4eg3uQvS5FylCr1B8LtvkttmqJRC55Wpd9xddJZAmB6J8Q7GsuYbVM
         +4+g==
X-Gm-Message-State: AFqh2kqWo7LN6jJBvvd1lAcedu3YFXnN7k7QvGNA1ksl8hz/He6gO81c
        V+xcvi3Yc2T4Hgg1tj+ejE1IBZbxGDFqW15pmXmFjGy1SSL/
X-Google-Smtp-Source: AMrXdXumupDrvixqWYgdsLMcSHiPoV/fK6u7lvw88p73uNP4UyxQ00QPXfLk2NDTmTc2nY18/JGCyr4YmwoeHBUfPv2gtrqwr3kO
MIME-Version: 1.0
X-Received: by 2002:a92:b703:0:b0:309:1c59:dd30 with SMTP id
 k3-20020a92b703000000b003091c59dd30mr1247153ili.225.1672043304854; Mon, 26
 Dec 2022 00:28:24 -0800 (PST)
Date:   Mon, 26 Dec 2022 00:28:24 -0800
In-Reply-To: <20221226033428.2301-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c2bbf05f0b6eb7d@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode (2)
From:   syzbot <syzbot+a68ef3b1f46bc3aced5c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

/hid-sensor-temperature.o
  CC      drivers/net/usb/cdc_subset.o
  CC      drivers/gpu/drm/i915/gt/intel_gsc.o
  AR      drivers/media/usb/go7007/built-in.a
  CC      drivers/media/usb/gspca/spca561.o
  CC      drivers/media/usb/em28xx/em28xx-vbi.o
  CC      drivers/net/ethernet/mellanox/mlx4/crdump.o
  CC      drivers/net/usb/zaurus.o
  CC      drivers/net/usb/mcs7830.o
  CC      fs/mpage.o
  CC      drivers/infiniband/core/uverbs_std_types_srq.o
  CC      drivers/net/vrf.o
  CC      drivers/thunderbolt/ctl.o
  CC      drivers/net/vsockmon.o
  CC      drivers/net/thunderbolt.o
  CC      fs/proc_namespace.o
  CC      drivers/infiniband/core/uverbs_std_types_wq.o
  CC      drivers/gpu/drm/drm_flip_work.o
  CC      drivers/hid/hid-mf.o
  CC      drivers/gpu/drm/drm_format_helper.o
  AR      drivers/media/usb/cx231xx/built-in.a
  CC      drivers/media/usb/em28xx/em28xx-audio.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-sysfs.o
  CC      drivers/staging/rtl8712/xmit_linux.o
  CC      drivers/net/wireless/ath/ath9k/ani.o
  CC      drivers/staging/rtl8712/usb_intf.o
  CC      drivers/android/binderfs.o
  CC      drivers/nvmem/core.o
  CC      drivers/net/usb/usbnet.o
  CC      drivers/net/usb/int51x1.o
  CC      drivers/gpu/drm/i915/i915_hwmon.o
  CC      drivers/thunderbolt/tb.o
  CC      drivers/net/usb/cdc-phonet.o
  CC      drivers/hid/hid-microsoft.o
  CC      drivers/net/wireless/ath/ath10k/ce.o
  CC      fs/eventpoll.o
  CC      drivers/media/usb/em28xx/em28xx-dvb.o
  CC      drivers/gpu/drm/drm_gem_atomic_helper.o
  CC      drivers/media/usb/gspca/spca1528.o
  CC      drivers/net/wireless/ath/ath9k/mac.o
  AR      drivers/iio/temperature/built-in.a
  CC      drivers/gpu/drm/drm_gem_framebuffer_helper.o
  AR      drivers/iio/test/built-in.a
  CC      drivers/media/usb/em28xx/em28xx-input.o
  CC      drivers/media/usb/gspca/sq905.o
  AR      drivers/iio/trigger/built-in.a
  CC      drivers/iio/industrialio-core.o
  CC      drivers/net/net_failover.o
  CC      net/mptcp/sockopt.o
  CC      drivers/net/wireless/ath/ath10k/pci.o
  CC      drivers/counter/counter-core.o
  CC      drivers/infiniband/core/uverbs_std_types_qp.o
  CC      drivers/hid/hid-monterey.o
  CC      drivers/infiniband/core/umem.o
  CC      drivers/infiniband/core/umem_dmabuf.o
  CC      drivers/net/wireless/ath/ath10k/usb.o
  CC      drivers/infiniband/core/umem_odp.o
  CC      drivers/staging/rtl8712/os_intfs.o
  CC      drivers/thunderbolt/switch.o
  CC      drivers/infiniband/core/ucma.o
  CC      drivers/net/wireless/ath/ath9k/ar9002_mac.o
  CC      drivers/net/wireless/ath/ath9k/ar9003_mac.o
  CC      drivers/net/usb/kalmia.o
  CC      drivers/media/usb/gspca/sq905c.o
  CC      fs/anon_inodes.o
  CC      fs/signalfd.o
  CC      drivers/thunderbolt/cap.o
  CC      fs/timerfd.o
  CC      drivers/gpu/drm/drm_kms_helper_common.o
  CC      drivers/staging/rtl8712/rtl871x_pwrctrl.o
  AR      drivers/net/wireless/ath/ath11k/built-in.a
  CC      drivers/net/usb/ipheth.o
  CC      net/mptcp/pm_userspace.o
  CC      fs/eventfd.o
  CC      net/mptcp/fastopen.o
  CC      net/mptcp/syncookies.o
  CC      drivers/most/core.o
  CC      drivers/net/usb/sierra_net.o
  CC      fs/userfaultfd.o
  CC      drivers/android/binder.o
  CC      net/mptcp/mptcp_diag.o
  CC      net/mptcp/bpf.o
  CC      drivers/net/wireless/ath/ath9k/ar9003_eeprom.o
  CC      drivers/media/usb/gspca/sq930x.o
  CC      drivers/gpu/drm/drm_modeset_helper.o
  CC      drivers/most/configfs.o
  CC      drivers/staging/rtl8712/rtl8712_recv.o
  CC      drivers/counter/counter-sysfs.o
  CC      drivers/gpu/drm/drm_plane_helper.o
  CC      drivers/counter/counter-chrdev.o
  CC      fs/aio.o
  CC      drivers/thunderbolt/path.o
  CC      drivers/iio/industrialio-event.o
  CC      drivers/net/wireless/ath/ath9k/ar9003_paprd.o
  CC      drivers/media/usb/gspca/sunplus.o
  CC      drivers/iio/inkern.o
  CC      drivers/net/usb/cx82310_eth.o
  CC      fs/dax.o
  CC      drivers/gpu/drm/drm_probe_helper.o
  CC      drivers/gpu/drm/drm_rect.o
  CC      drivers/thunderbolt/tunnel.o
  CC      drivers/staging/rtl8712/rtl871x_recv.o
  CC      drivers/staging/rtl8712/rtl871x_sta_mgt.o
  CC      drivers/net/wireless/ath/ath9k/btcoex.o
  CC      drivers/net/wireless/ath/ath9k/ar9003_mci.o
  CC      drivers/net/wireless/ath/ath9k/ar9003_aic.o
  CC      drivers/hid/hid-multitouch.o
  CC      drivers/net/usb/cdc_ncm.o
  CC      drivers/net/usb/huawei_cdc_ncm.o
  CC      drivers/hid/hid-nti.o
  CC      drivers/hid/hid-ntrig.o
  AR      drivers/nvmem/built-in.a
  CC      drivers/hid/hid-ortek.o
  CC      drivers/android/binder_alloc.o
  CC      drivers/net/wireless/ath/ath9k/ar9003_rtt.o
  CC      fs/locks.o
  CC      drivers/hid/hid-prodikeys.o
  CC      drivers/thunderbolt/eeprom.o
  CC      drivers/gpu/drm/drm_self_refresh_helper.o
  CC      drivers/gpu/drm/drm_simple_kms_helper.o
  CC      fs/binfmt_misc.o
  CC      drivers/net/wireless/ath/ath9k/dynack.o
  CC      drivers/net/usb/lg-vl600.o
  CC      drivers/staging/rtl8712/rtl871x_xmit.o
  CC      drivers/net/wireless/ath/ath9k/common.o
  CC      drivers/iio/industrialio-buffer.o
  CC      drivers/net/wireless/ath/ath9k/common-init.o
  CC      drivers/net/usb/qmi_wwan.o
  CC      drivers/net/usb/cdc_mbim.o
  CC      drivers/net/wireless/ath/ath9k/common-beacon.o
  CC      drivers/media/usb/gspca/stk014.o
  CC      drivers/gpu/drm/i915/display/hsw_ips.o
  CC      drivers/gpu/drm/i915/display/intel_atomic.o
  CC      drivers/gpu/drm/i915/display/intel_atomic_plane.o
  CC      drivers/gpu/drm/bridge/panel.o
  CC      drivers/net/wireless/ath/ath9k/common-debug.o
  CC      drivers/net/usb/ch9200.o
  CC      drivers/staging/rtl8712/rtl8712_xmit.o
  CC      drivers/net/wireless/ath/ath9k/htc_hst.o
  AR      drivers/media/usb/pvrusb2/built-in.a
  CC      drivers/net/usb/r8153_ecm.o
  CC      drivers/thunderbolt/domain.o
  CC      drivers/hid/hid-pl.o
  CC      fs/binfmt_script.o
  CC      fs/binfmt_elf.o
  CC      drivers/gpu/drm/drm_fbdev_generic.o
  AR      drivers/counter/built-in.a
  CC      drivers/net/wireless/ath/ath9k/hif_usb.o
  CC      fs/compat_binfmt_elf.o
  CC      drivers/thunderbolt/dma_port.o
  CC      drivers/net/wireless/ath/ath9k/wmi.o
  CC      drivers/iio/industrialio-trigger.o
  CC      drivers/thunderbolt/icm.o
  CC      fs/mbcache.o
  AR      drivers/most/built-in.a
  CC      drivers/thunderbolt/property.o
  AR      drivers/infiniband/core/built-in.a
  AR      drivers/infiniband/built-in.a
  CC      drivers/net/wireless/ath/ath9k/htc_drv_txrx.o
  CC      drivers/net/wireless/ath/ath9k/htc_drv_main.o
  CC      fs/posix_acl.o
  CC      drivers/hid/hid-penmount.o
  AR      net/mptcp/built-in.a
  AR      drivers/media/usb/em28xx/built-in.a
  CC      drivers/media/usb/gspca/stk1135.o
  AR      net/built-in.a
  CC      fs/coredump.o
  CC      drivers/hid/hid-petalynx.o
  CC      fs/drop_caches.o
  CC      fs/fhandle.o
  CC      drivers/hid/hid-picolcd_core.o
  CC      drivers/thunderbolt/xdomain.o
  CC      drivers/hid/hid-picolcd_fb.o
  CC      drivers/gpu/drm/drm_fb_helper.o
  CC      drivers/media/usb/gspca/stv0680.o
  CC      drivers/gpu/drm/drm_mipi_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_audio.o
  CC      drivers/gpu/drm/i915/display/intel_bios.o
  CC      drivers/thunderbolt/lc.o
  AR      drivers/net/wireless/ath/ath10k/built-in.a
  CC      drivers/thunderbolt/tmu.o
  CC      drivers/thunderbolt/usb4.o
  CC      drivers/thunderbolt/usb4_port.o
  CC      drivers/thunderbolt/nvm.o
  CC      drivers/thunderbolt/retimer.o
  CC      drivers/thunderbolt/quirks.o
  CC      drivers/hid/hid-picolcd_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_bw.o
  CC      drivers/hid/hid-picolcd_lcd.o
  CC      drivers/net/wireless/ath/ath9k/htc_drv_beacon.o
  CC      drivers/gpu/drm/i915/display/intel_cdclk.o
  CC      drivers/hid/hid-picolcd_leds.o
  CC      drivers/net/wireless/ath/ath9k/htc_drv_init.o
  CC      drivers/net/wireless/ath/ath9k/htc_drv_gpio.o
  CC      drivers/net/wireless/ath/ath9k/htc_drv_debug.o
  CC      drivers/gpu/drm/i915/display/intel_color.o
  CC      drivers/gpu/drm/i915/display/intel_combo_phy.o
  CC      drivers/hid/hid-picolcd_cir.o
  CC      drivers/hid/hid-picolcd_debugfs.o
  CC      drivers/hid/hid-plantronics.o
  CC      drivers/thunderbolt/acpi.o
  CC      drivers/gpu/drm/i915/display/intel_connector.o
  CC      drivers/hid/hid-primax.o
  CC      drivers/gpu/drm/i915/display/intel_crtc.o
  CC      drivers/gpu/drm/i915/display/intel_crtc_state_dump.o
  CC      drivers/hid/hid-redragon.o
  CC      drivers/media/usb/gspca/t613.o
  CC      drivers/gpu/drm/i915/display/intel_cursor.o
  CC      drivers/thunderbolt/debugfs.o
  CC      drivers/gpu/drm/i915/display/intel_display.o
  CC      drivers/gpu/drm/i915/display/intel_display_power.o
  CC      drivers/gpu/drm/i915/display/intel_display_power_map.o
  CC      drivers/hid/hid-retrode.o
  CC      drivers/hid/hid-roccat.o
  CC      drivers/hid/hid-roccat-common.o
  CC      drivers/hid/hid-roccat-arvo.o
  CC      drivers/hid/hid-roccat-isku.o
  CC      drivers/media/usb/gspca/topro.o
  AR      drivers/staging/rtl8712/built-in.a
  AR      drivers/staging/built-in.a
  CC      drivers/hid/hid-roccat-kone.o
  CC      drivers/gpu/drm/i915/display/intel_display_power_well.o
  CC      drivers/media/usb/gspca/touptek.o
  CC      drivers/gpu/drm/i915/display/intel_dmc.o
  CC      drivers/gpu/drm/i915/display/intel_dpio_phy.o
  CC      drivers/gpu/drm/i915/display/intel_dpll.o
  CC      drivers/hid/hid-roccat-koneplus.o
  CC      drivers/gpu/drm/i915/display/intel_dpll_mgr.o
  AR      drivers/iio/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_dpt.o
  CC      drivers/hid/hid-roccat-konepure.o
  CC      drivers/gpu/drm/i915/display/intel_drrs.o
  CC      drivers/hid/hid-roccat-kovaplus.o
  CC      drivers/media/usb/gspca/tv8532.o
  CC      drivers/gpu/drm/i915/display/intel_dsb.o
  CC      drivers/hid/hid-roccat-lua.o
  CC      drivers/media/usb/gspca/vc032x.o
  CC      drivers/gpu/drm/i915/display/intel_fb.o
  CC      drivers/gpu/drm/i915/display/intel_fb_pin.o
  CC      drivers/hid/hid-roccat-pyra.o
  CC      drivers/hid/hid-roccat-ryos.o
  CC      drivers/hid/hid-roccat-savu.o
  CC      drivers/hid/hid-rmi.o
  CC      drivers/gpu/drm/i915/display/intel_fbc.o
  CC      drivers/hid/hid-saitek.o
  CC      drivers/gpu/drm/i915/display/intel_fdi.o
  CC      drivers/hid/hid-samsung.o
  CC      drivers/media/usb/gspca/vicam.o
  CC      drivers/media/usb/gspca/xirlink_cit.o
  CC      drivers/media/usb/gspca/zc3xx.o
  CC      drivers/gpu/drm/i915/display/intel_fifo_underrun.o
  CC      drivers/hid/hid-sjoy.o
  CC      drivers/hid/hid-sony.o
  CC      drivers/gpu/drm/i915/display/intel_frontbuffer.o
  AR      drivers/net/usb/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_global_state.o
  CC      drivers/hid/hid-speedlink.o
  CC      drivers/hid/hid-steelseries.o
  CC      drivers/gpu/drm/i915/display/intel_hdcp.o
  CC      drivers/gpu/drm/i915/display/intel_hotplug.o
  CC      drivers/hid/hid-sunplus.o
  CC      drivers/hid/hid-gaff.o
  CC      drivers/hid/hid-tmff.o
  CC      drivers/hid/hid-thrustmaster.o
  AR      drivers/net/wireless/ath/ath9k/built-in.a
  AR      drivers/net/wireless/ath/built-in.a
  CC      drivers/hid/hid-tivo.o
  CC      drivers/gpu/drm/i915/display/intel_hti.o
  CC      drivers/gpu/drm/i915/display/intel_lpe_audio.o
  AR      drivers/net/wireless/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_modeset_verify.o
  CC      drivers/gpu/drm/i915/display/intel_modeset_setup.o
  CC      drivers/hid/hid-topseed.o
  CC      drivers/hid/hid-twinhan.o
  CC      drivers/gpu/drm/i915/display/intel_overlay.o
  CC      drivers/hid/hid-uclogic-core.o
  CC      drivers/gpu/drm/i915/display/intel_pch_display.o
  CC      drivers/gpu/drm/i915/display/intel_pch_refclk.o
  CC      drivers/gpu/drm/i915/display/intel_plane_initial.o
  CC      drivers/hid/hid-uclogic-rdesc.o
  CC      drivers/hid/hid-uclogic-params.o
  CC      drivers/hid/hid-udraw-ps3.o
  CC      drivers/gpu/drm/i915/display/intel_psr.o
  CC      drivers/gpu/drm/i915/display/intel_quirks.o
  CC      drivers/hid/hid-led.o
  CC      drivers/hid/hid-xinmo.o
  CC      drivers/hid/hid-zpff.o
  CC      drivers/hid/hid-zydacron.o
  CC      drivers/hid/wacom_wac.o
  CC      drivers/gpu/drm/i915/display/intel_sprite.o
  CC      drivers/hid/wacom_sys.o
  CC      drivers/gpu/drm/i915/display/intel_tc.o
  CC      drivers/gpu/drm/i915/display/intel_vga.o
  CC      drivers/hid/hid-waltop.o
  CC      drivers/hid/hid-wiimote-core.o
  CC      drivers/gpu/drm/i915/display/i9xx_plane.o
  CC      drivers/hid/hid-wiimote-modules.o
  AR      fs/built-in.a
  CC      drivers/hid/hid-wiimote-debug.o
  CC      drivers/gpu/drm/i915/display/skl_scaler.o
  CC      drivers/gpu/drm/i915/display/skl_universal_plane.o
  CC      drivers/hid/hid-sensor-hub.o
  CC      drivers/hid/hid-sensor-custom.o
  AR      drivers/net/ethernet/mellanox/mlx4/built-in.a
  AR      drivers/net/ethernet/mellanox/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_acpi.o
  CC      drivers/gpu/drm/i915/display/skl_watermark.o
  CC      drivers/gpu/drm/i915/display/intel_opregion.o
  AR      drivers/net/ethernet/built-in.a
  AR      drivers/net/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_fbdev.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7017.o
  AR      drivers/thunderbolt/built-in.a
  CC      drivers/gpu/drm/i915/display/dvo_ch7xxx.o
  CC      drivers/gpu/drm/i915/display/dvo_ivch.o
  CC      drivers/gpu/drm/i915/display/dvo_ns2501.o
  CC      drivers/gpu/drm/i915/display/dvo_sil164.o
  CC      drivers/gpu/drm/i915/display/dvo_tfp410.o
  CC      drivers/gpu/drm/i915/display/g4x_dp.o
  CC      drivers/gpu/drm/i915/display/g4x_hdmi.o
  CC      drivers/gpu/drm/i915/display/icl_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_crt.o
  CC      drivers/gpu/drm/i915/display/intel_ddi.o
  CC      drivers/gpu/drm/i915/display/intel_ddi_buf_trans.o
  CC      drivers/gpu/drm/i915/display/intel_dkl_phy.o
  CC      drivers/gpu/drm/i915/display/intel_display_trace.o
  CC      drivers/gpu/drm/i915/display/intel_dp.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dp_hdcp.o
  CC      drivers/gpu/drm/i915/display/intel_dp_link_training.o
  CC      drivers/gpu/drm/i915/display/intel_dp_mst.o
  CC      drivers/gpu/drm/i915/display/intel_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_dcs_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_vbt.o
  CC      drivers/gpu/drm/i915/display/intel_dvo.o
  CC      drivers/gpu/drm/i915/display/intel_gmbus.o
  CC      drivers/gpu/drm/i915/display/intel_hdmi.o
  CC      drivers/gpu/drm/i915/display/intel_lspcon.o
  CC      drivers/gpu/drm/i915/display/intel_lvds.o
  CC      drivers/gpu/drm/i915/display/intel_panel.o
  CC      drivers/gpu/drm/i915/display/intel_pps.o
  CC      drivers/gpu/drm/i915/display/intel_qp_tables.o
  CC      drivers/gpu/drm/i915/display/intel_sdvo.o
  CC      drivers/gpu/drm/i915/display/intel_snps_phy.o
  CC      drivers/gpu/drm/i915/display/intel_tv.o
  AR      drivers/media/usb/gspca/built-in.a
  AR      drivers/media/usb/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_vdsc.o
  CC      drivers/gpu/drm/i915/display/intel_vrr.o
  AR      drivers/media/built-in.a
  CC      drivers/gpu/drm/i915/display/vlv_dsi.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi_pll.o
  CC      drivers/gpu/drm/i915/i915_perf.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp_tee.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp_huc.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  AR      drivers/android/built-in.a
  AR      drivers/hid/built-in.a
  AR      drivers/gpu/drm/i915/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
vmlinux.o: warning: objtool: select_reloc_root+0x455: unreachable instruction
Killed
make[1]: *** [scripts/Makefile.vmlinux_o:61: vmlinux.o] Error 137
make[1]: *** Deleting file 'vmlinux.o'
make: *** [Makefile:1245: vmlinux_o] Error 2


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=14f5ae54480000


Tested on:

commit:         1b929c02 Linux 6.2-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a0a960480000

