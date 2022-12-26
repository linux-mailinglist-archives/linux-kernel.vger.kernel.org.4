Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A143565615B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiLZJG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLZJGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:06:25 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC36C63
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 01:06:23 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so3524519iow.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 01:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07b4kXvm56nZs3lipVKxYSQWUylrzB2fgQe2b5YAdXo=;
        b=7hhgJZSqSQRUkjI/wys8pAhdkYn2csOXTKSNMJO4NTon5lGTVcIfsw+1DNZMYseobe
         beOqLeuGJFtjnplg5sN5sluG8kgCx8gtzqVZFyyjvTy9a6D+oAAbR1LnRotA15VjLZQe
         iBWiShgyp9izq3xSxW74+u9A9jo6J89INqpXoi0SOWHzzu3SYO8vkfDhnQYNDMJ7mtpY
         dBcniBmPCdmfZgxPAwerAmwnlXQzpIozQ6rUjFgOOZtjxcnJTav3m8R6vCVYmYGrfMgz
         SyuASn8D16kqnez4OkjkPb5NASBweU0Y8WadFsXZr35JhtZGiAD8blbbO6ob3dEXCabP
         DQTA==
X-Gm-Message-State: AFqh2kqXFfDoKXiRnfFUpWJ5+xjRSlQvRBcpCF0Vvxw2/PXyR7qHfFvX
        I+k5UCoPR8zrR7qiIlgBB7gx0kx1b+1r0AARizeRONZgE3Dj
X-Google-Smtp-Source: AMrXdXsweuIi68gIYqY14y6YALOlT28W7KrjsKp2Rfve9Z/uRHg7DA997tdn9yUQererqfJagUqfQB+SDpbEc0Ay2Vr4yVCjNoTg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:146:b0:30b:e8b8:eb69 with SMTP id
 j6-20020a056e02014600b0030be8b8eb69mr1059254ilr.196.1672045583139; Mon, 26
 Dec 2022 01:06:23 -0800 (PST)
Date:   Mon, 26 Dec 2022 01:06:23 -0800
In-Reply-To: <20221226085641.2445-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000080c9905f0b77340@google.com>
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

types_device.o
  CC      drivers/gpu/drm/i915/display/intel_dpio_phy.o
  CC      drivers/infiniband/core/uverbs_std_types_async_fd.o
  CC      drivers/media/usb/gspca/vc032x.o
  CC      drivers/infiniband/core/uverbs_std_types_srq.o
  CC      drivers/platform/x86/asus-wmi.o
  CC      drivers/platform/x86/eeepc-laptop.o
  CC      drivers/platform/x86/p2sb.o
  CC      drivers/comedi/proc.o
  AR      drivers/perf/built-in.a
  CC      drivers/extcon/extcon-intel-cht-wc.o
  CC      drivers/greybus/connection.o
  CC      drivers/ras/ras.o
  CC      drivers/ras/debugfs.o
  CC      drivers/staging/greybus/gbphy.o
  CC      drivers/infiniband/core/uverbs_std_types_wq.o
  CC      drivers/gpu/drm/i915/display/intel_dpll.o
  CC      drivers/bcma/driver_chipcommon_b.o
  CC      drivers/hid/hid-corsair.o
  AR      drivers/platform/surface/built-in.a
  CC      drivers/greybus/control.o
  CC      drivers/crypto/qat/qat_common/adf_pfvf_utils.o
  CC      drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.o
  AR      drivers/iio/accel/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_dpll_mgr.o
  CC      fs/xfs/xfs_pnfs.o
  AR      drivers/iio/afe/built-in.a
  CC      drivers/hid/hid-cp2112.o
  CC      drivers/staging/greybus/usb.o
  CC      drivers/gpu/drm/i915/display/intel_dpt.o
  CC      drivers/hid/hid-cypress.o
  CC      drivers/hid/hid-dr.o
  CC      drivers/hid/hid-emsff.o
  CC      drivers/greybus/svc.o
  CC      drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.o
  CC      drivers/greybus/svc_watchdog.o
  AR      drivers/iio/adc/built-in.a
  AR      drivers/iio/amplifiers/built-in.a
  CC      drivers/greybus/operation.o
  CC      drivers/iio/buffer/industrialio-triggered-buffer.o
  CC      drivers/staging/rtl8712/rtl871x_security.o
  CC      drivers/iio/buffer/kfifo_buf.o
  CC      drivers/hid/hid-elecom.o
  CC      drivers/media/usb/gspca/vicam.o
  CC      drivers/media/usb/gspca/xirlink_cit.o
  CC      drivers/hid/hid-elo.o
  CC      drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.o
  AR      drivers/comedi/drivers/built-in.a
  CC      drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.o
  CC      drivers/infiniband/core/uverbs_std_types_qp.o
  CC      drivers/infiniband/core/umem.o
  CC      drivers/infiniband/core/umem_dmabuf.o
  CC      drivers/thunderbolt/nhi.o
  AR      drivers/extcon/built-in.a
  CC      drivers/greybus/es2.o
  CC      drivers/crypto/qat/qat_common/adf_gen2_pfvf.o
  CC      drivers/crypto/qat/qat_common/adf_gen4_pfvf.o
  AR      drivers/iio/cdc/built-in.a
  AR      drivers/iio/chemical/built-in.a
  CC      drivers/infiniband/core/umem_odp.o
  CC      drivers/hid/hid-ezkey.o
  CC      drivers/hid/hid-gembird.o
  AR      drivers/iio/common/cros_ec_sensors/built-in.a
  AR      drivers/hwtracing/intel_th/built-in.a
  CC      drivers/staging/rtl8712/rtl871x_eeprom.o
  CC      drivers/android/binderfs.o
  AR      drivers/iio/dac/built-in.a
  CC      drivers/iio/common/hid-sensors/hid-sensor-attributes.o
  CC      drivers/android/binder.o
  CC      drivers/android/binder_alloc.o
  AR      drivers/comedi/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_drrs.o
  CC      drivers/staging/rtl8712/rtl8712_efuse.o
  CC      drivers/thunderbolt/nhi_ops.o
  AR      drivers/iio/common/ms_sensors/built-in.a
  CC      drivers/thunderbolt/ctl.o
  CC      drivers/thunderbolt/tb.o
  CC      drivers/thunderbolt/switch.o
  CC      drivers/infiniband/core/ucma.o
  CC      drivers/thunderbolt/cap.o
  CC      drivers/hid/hid-gfrm.o
  CC      drivers/gpu/drm/i915/display/intel_dsb.o
  AR      drivers/staging/greybus/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_fb.o
  AR      drivers/bcma/built-in.a
  CC      drivers/hid/hid-gt683r.o
  CC      drivers/thunderbolt/path.o
  CC      drivers/counter/counter-core.o
  CC      drivers/nvmem/core.o
  CC      drivers/gpu/drm/i915/display/intel_fb_pin.o
  CC      drivers/thunderbolt/tunnel.o
  CC      drivers/media/usb/gspca/zc3xx.o
  CC      drivers/thunderbolt/eeprom.o
  CC      drivers/thunderbolt/domain.o
  CC      drivers/thunderbolt/dma_port.o
  CC      drivers/iio/common/hid-sensors/hid-sensor-trigger.o
  CC      drivers/most/core.o
  AR      drivers/iio/buffer/built-in.a
  CC      drivers/hid/hid-gyration.o
  CC      drivers/most/configfs.o
  CC      drivers/hid/hid-holtek-kbd.o
  CC      drivers/thunderbolt/icm.o
  AR      drivers/iio/dummy/built-in.a
  CC      drivers/counter/counter-sysfs.o
  CC      drivers/thunderbolt/property.o
  CC      drivers/gpu/drm/i915/display/intel_fbc.o
  CC      drivers/hid/hid-holtek-mouse.o
  CC      drivers/iio/gyro/hid-sensor-gyro-3d.o
  CC      drivers/thunderbolt/xdomain.o
  CC      drivers/staging/rtl8712/hal_init.o
  CC      drivers/staging/rtl8712/usb_halinit.o
  AR      drivers/ras/built-in.a
  CC      drivers/hid/hid-holtekff.o
  CC      drivers/gpu/drm/i915/display/intel_fdi.o
  AR      drivers/iio/common/scmi_sensors/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_fifo_underrun.o
  CC      drivers/staging/rtl8712/usb_ops.o
  AR      drivers/iio/common/ssp_sensors/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_frontbuffer.o
  CC      drivers/gpu/drm/i915/display/intel_global_state.o
  AR      drivers/iio/common/st_sensors/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_hdcp.o
  AR      drivers/crypto/qat/qat_common/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_hotplug.o
  CC      drivers/gpu/drm/i915/display/intel_hti.o
  AR      drivers/crypto/qat/built-in.a
  AR      drivers/crypto/built-in.a
  AR      drivers/iio/frequency/built-in.a
  AR      drivers/iio/filter/built-in.a
  CC      drivers/counter/counter-chrdev.o
  CC      drivers/thunderbolt/lc.o
  CC      drivers/hid/hid-icade.o
  AR      drivers/iio/health/built-in.a
  CC      drivers/thunderbolt/tmu.o
  CC      drivers/iio/humidity/hid-sensor-humidity.o
  AR      drivers/greybus/built-in.a
  CC      drivers/staging/rtl8712/usb_ops_linux.o
  CC      drivers/gpu/drm/i915/display/intel_lpe_audio.o
  CC      drivers/staging/rtl8712/rtl871x_io.o
  AR      fs/xfs/built-in.a
  CC      drivers/hid/hid-ite.o
  CC      drivers/staging/rtl8712/rtl8712_io.o
  AR      fs/built-in.a
  CC      drivers/hid/hid-kensington.o
  CC      drivers/hid/hid-keytouch.o
  CC      drivers/gpu/drm/i915/display/intel_modeset_verify.o
  CC      drivers/thunderbolt/usb4.o
  CC      drivers/staging/rtl8712/rtl871x_ioctl_linux.o
  CC      drivers/thunderbolt/usb4_port.o
  CC      drivers/gpu/drm/i915/display/intel_modeset_setup.o
  CC      drivers/hid/hid-kye.o
  CC      drivers/gpu/drm/i915/display/intel_overlay.o
  CC      drivers/thunderbolt/nvm.o
  AR      drivers/iio/gyro/built-in.a
  CC      drivers/thunderbolt/retimer.o
  CC      drivers/gpu/drm/i915/display/intel_pch_display.o
  AR      drivers/iio/common/hid-sensors/built-in.a
  AR      drivers/iio/common/built-in.a
  CC      drivers/staging/rtl8712/rtl871x_ioctl_rtl.o
  CC      drivers/iio/light/hid-sensor-als.o
  AR      drivers/iio/imu/bmi160/built-in.a
  AR      drivers/iio/imu/bno055/built-in.a
  AR      drivers/iio/imu/inv_icm42600/built-in.a
  AR      drivers/iio/imu/inv_mpu6050/built-in.a
  AR      drivers/vhost/built-in.a
  AR      drivers/iio/imu/st_lsm6dsx/built-in.a
  CC      drivers/iio/light/hid-sensor-prox.o
  CC      drivers/thunderbolt/quirks.o
  AR      drivers/iio/multiplexer/built-in.a
  CC      drivers/iio/magnetometer/hid-sensor-magn-3d.o
  CC      drivers/staging/rtl8712/rtl871x_ioctl_set.o
  AR      drivers/iio/imu/st_lsm9ds0/built-in.a
  CC      drivers/thunderbolt/acpi.o
  AR      drivers/iio/imu/built-in.a
  CC      drivers/thunderbolt/debugfs.o
  AR      drivers/iio/humidity/built-in.a
  CC      drivers/staging/rtl8712/rtl8712_led.o
  CC      drivers/gpu/drm/i915/display/intel_pch_refclk.o
  CC      drivers/staging/rtl8712/rtl871x_mlme.o
  CC      drivers/gpu/drm/i915/display/intel_plane_initial.o
  CC      drivers/iio/orientation/hid-sensor-incl-3d.o
  CC      drivers/hid/hid-lcpower.o
  CC      drivers/gpu/drm/i915/display/intel_psr.o
  CC      drivers/iio/orientation/hid-sensor-rotation.o
  CC      drivers/hid/hid-lenovo.o
  CC      drivers/staging/rtl8712/ieee80211.o
  CC      drivers/hid/hid-lg.o
  CC      drivers/gpu/drm/i915/display/intel_quirks.o
  CC      drivers/hid/hid-lgff.o
  CC      drivers/staging/rtl8712/rtl871x_mp_ioctl.o
  CC      drivers/staging/rtl8712/rtl871x_mp.o
  CC      drivers/gpu/drm/i915/display/intel_sprite.o
  CC      drivers/staging/rtl8712/mlme_linux.o
  AR      drivers/nvmem/built-in.a
  CC      drivers/staging/rtl8712/recv_linux.o
  AR      drivers/media/usb/gspca/built-in.a
  AR      drivers/media/usb/built-in.a
  CC      drivers/staging/rtl8712/xmit_linux.o
  CC      drivers/staging/rtl8712/usb_intf.o
  AR      drivers/media/built-in.a
  CC      drivers/hid/hid-lg2ff.o
  CC      drivers/hid/hid-lg3ff.o
  CC      drivers/hid/hid-lg4ff.o
  CC      drivers/gpu/drm/i915/display/intel_tc.o
  CC      drivers/staging/rtl8712/os_intfs.o
  CC      drivers/staging/rtl8712/rtl871x_pwrctrl.o
  AR      drivers/platform/x86/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_vga.o
  AR      drivers/platform/built-in.a
  CC      drivers/staging/rtl8712/rtl8712_recv.o
  AR      drivers/iio/light/built-in.a
  CC      drivers/hid/hid-lg-g15.o
  CC      drivers/gpu/drm/i915/display/i9xx_plane.o
  CC      drivers/gpu/drm/i915/display/skl_scaler.o
  CC      drivers/staging/rtl8712/rtl871x_recv.o
  AR      drivers/iio/position/built-in.a
  AR      drivers/most/built-in.a
  CC      drivers/staging/rtl8712/rtl871x_sta_mgt.o
  AR      drivers/iio/potentiometer/built-in.a
  CC      drivers/gpu/drm/i915/display/skl_universal_plane.o
  AR      drivers/iio/potentiostat/built-in.a
  CC      drivers/gpu/drm/i915/display/skl_watermark.o
  CC      drivers/hid/hid-logitech-dj.o
  AR      drivers/counter/built-in.a
  CC      drivers/hid/hid-logitech-hidpp.o
  AR      drivers/iio/orientation/built-in.a
  CC      drivers/staging/rtl8712/rtl871x_xmit.o
  AR      drivers/staging/wlan-ng/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_acpi.o
  CC      drivers/iio/pressure/hid-sensor-press.o
  AR      drivers/iio/proximity/built-in.a
  CC      drivers/hid/hid-magicmouse.o
  CC      drivers/staging/rtl8712/rtl8712_xmit.o
  AR      drivers/iio/resolver/built-in.a
  CC      drivers/hid/hid-mf.o
  CC      drivers/gpu/drm/i915/display/intel_opregion.o
  CC      drivers/hid/hid-microsoft.o
  CC      drivers/iio/temperature/hid-sensor-temperature.o
  CC      drivers/gpu/drm/i915/display/intel_fbdev.o
  AR      drivers/iio/magnetometer/built-in.a
  AR      drivers/iio/test/built-in.a
  AR      drivers/iio/trigger/built-in.a
  CC      drivers/iio/industrialio-core.o
  AR      drivers/md/built-in.a
  CC      drivers/gpu/drm/i915/display/dvo_ch7017.o
  CC      drivers/hid/hid-monterey.o
  CC      drivers/hid/hid-multitouch.o
  CC      drivers/hid/hid-nti.o
  CC      drivers/hid/hid-ntrig.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7xxx.o
  CC      drivers/iio/industrialio-event.o
  CC      drivers/hid/hid-ortek.o
  CC      drivers/iio/inkern.o
  CC      drivers/iio/industrialio-buffer.o
  CC      drivers/gpu/drm/i915/display/dvo_ivch.o
  CC      drivers/iio/industrialio-trigger.o
  CC      drivers/hid/hid-prodikeys.o
  CC      drivers/gpu/drm/i915/display/dvo_ns2501.o
  CC      drivers/hid/hid-pl.o
  CC      drivers/gpu/drm/i915/display/dvo_sil164.o
  CC      drivers/gpu/drm/i915/display/dvo_tfp410.o
  CC      drivers/hid/hid-penmount.o
  AR      drivers/infiniband/core/built-in.a
  AR      drivers/iio/pressure/built-in.a
  CC      drivers/hid/hid-petalynx.o
  CC      drivers/gpu/drm/i915/display/g4x_dp.o
  CC      drivers/gpu/drm/i915/display/g4x_hdmi.o
  AR      drivers/infiniband/built-in.a
  CC      drivers/gpu/drm/i915/display/icl_dsi.o
  CC      drivers/hid/hid-picolcd_core.o
  CC      drivers/gpu/drm/i915/display/intel_backlight.o
  CC      drivers/hid/hid-picolcd_fb.o
  AR      drivers/iio/temperature/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_crt.o
  CC      drivers/gpu/drm/i915/display/intel_ddi.o
  CC      drivers/hid/hid-picolcd_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_ddi_buf_trans.o
  CC      drivers/gpu/drm/i915/display/intel_display_trace.o
  CC      drivers/gpu/drm/i915/display/intel_dkl_phy.o
  CC      drivers/gpu/drm/i915/display/intel_dp.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux.o
  CC      drivers/hid/hid-picolcd_lcd.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dp_hdcp.o
  CC      drivers/hid/hid-picolcd_leds.o
  CC      drivers/gpu/drm/i915/display/intel_dp_link_training.o
  CC      drivers/gpu/drm/i915/display/intel_dp_mst.o
  CC      drivers/gpu/drm/i915/display/intel_dsi.o
  CC      drivers/hid/hid-picolcd_cir.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_dcs_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_vbt.o
  CC      drivers/hid/hid-picolcd_debugfs.o
  CC      drivers/hid/hid-plantronics.o
  CC      drivers/hid/hid-primax.o
  CC      drivers/gpu/drm/i915/display/intel_dvo.o
  CC      drivers/hid/hid-redragon.o
  CC      drivers/gpu/drm/i915/display/intel_gmbus.o
  CC      drivers/gpu/drm/i915/display/intel_hdmi.o
  CC      drivers/hid/hid-retrode.o
  CC      drivers/hid/hid-roccat.o
  CC      drivers/gpu/drm/i915/display/intel_lspcon.o
  CC      drivers/gpu/drm/i915/display/intel_lvds.o
  CC      drivers/hid/hid-roccat-common.o
  CC      drivers/hid/hid-roccat-arvo.o
  CC      drivers/hid/hid-roccat-isku.o
  CC      drivers/hid/hid-roccat-kone.o
  CC      drivers/gpu/drm/i915/display/intel_panel.o
  AR      drivers/thunderbolt/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_pps.o
  CC      drivers/gpu/drm/i915/display/intel_qp_tables.o
  CC      drivers/gpu/drm/i915/display/intel_sdvo.o
  CC      drivers/hid/hid-roccat-koneplus.o
  CC      drivers/gpu/drm/i915/display/intel_snps_phy.o
  CC      drivers/gpu/drm/i915/display/intel_tv.o
  CC      drivers/gpu/drm/i915/display/intel_vdsc.o
  CC      drivers/gpu/drm/i915/display/intel_vrr.o
  CC      drivers/hid/hid-roccat-konepure.o
  CC      drivers/hid/hid-roccat-kovaplus.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi.o
  CC      drivers/hid/hid-roccat-lua.o
  CC      drivers/hid/hid-roccat-pyra.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi_pll.o
  CC      drivers/hid/hid-roccat-ryos.o
  CC      drivers/hid/hid-roccat-savu.o
  CC      drivers/gpu/drm/i915/i915_perf.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp.o
  CC      drivers/hid/hid-rmi.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp_tee.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp_huc.o
  AR      drivers/staging/rtl8712/built-in.a
  AR      drivers/staging/built-in.a
  CC      drivers/hid/hid-saitek.o
  CC      drivers/hid/hid-samsung.o
  CC      drivers/hid/hid-sjoy.o
  CC      drivers/hid/hid-sony.o
  CC      drivers/hid/hid-speedlink.o
  CC      drivers/hid/hid-steelseries.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      drivers/hid/hid-sunplus.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  CC      drivers/hid/hid-gaff.o
  CC      drivers/hid/hid-tmff.o
  CC      drivers/hid/hid-thrustmaster.o
  CC      drivers/hid/hid-tivo.o
  CC      drivers/hid/hid-topseed.o
  CC      drivers/hid/hid-uclogic-core.o
  CC      drivers/hid/hid-twinhan.o
  CC      drivers/hid/hid-uclogic-rdesc.o
  AR      drivers/iio/built-in.a
  CC      drivers/hid/hid-uclogic-params.o
  CC      drivers/hid/hid-udraw-ps3.o
  CC      drivers/hid/hid-led.o
  CC      drivers/hid/hid-xinmo.o
  CC      drivers/hid/hid-zpff.o
  CC      drivers/hid/hid-zydacron.o
  CC      drivers/hid/wacom_sys.o
  CC      drivers/hid/hid-waltop.o
  CC      drivers/hid/wacom_wac.o
  CC      drivers/hid/hid-wiimote-core.o
  CC      drivers/hid/hid-wiimote-modules.o
  CC      drivers/hid/hid-wiimote-debug.o
  CC      drivers/hid/hid-sensor-hub.o
  CC      drivers/hid/hid-sensor-custom.o
  AR      drivers/android/built-in.a
  AR      drivers/hid/built-in.a
  AR      drivers/gpu/drm/i915/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
Killed
make[1]: *** [scripts/Makefile.vmlinux_o:61: vmlinux.o] Error 137
make[1]: *** Deleting file 'vmlinux.o'
make: *** [Makefile:1245: vmlinux_o] Error 2


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=119409ff880000


Tested on:

commit:         72a85e2b Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15072ae4480000

