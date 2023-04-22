Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1C6EBB07
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 21:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDVTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 15:48:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870741981
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:48:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f19c473b9eso6767845e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682192918; x=1684784918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxcD/lB1GTRmR0lN7OcwUWrczIuY5jxdZH5iQqSqalk=;
        b=Z0wR0i0q1TsAPbT9UwrwD2DYoCBYdA3KdMx+F7yIVgy5akGcr+mOd5nQ5h6Pk8AKp1
         TL7LjLX54G7M57NIPnoWFAntq+0jOP4Er80iiqwPuMdj6c50P6bOTJPYbtKQ4eKWkG+t
         l9SlPx1+varBOOLfriH8q10ZmzEP/zkap18e7dPPQ3GA4nghs6QHKJObcJHKFhO7GPcZ
         wyc419kfzLPQ+2ObzF/K8QrjIS7zeLb+xxRVPwa+8wd65sOFTkH3Q5PybzsdkEC228nE
         8bBbpAHBV7cfbwApe84fg4u6pKqKyyo+R+pj13WkwBWFS2nj6dakk7VR/lEAOeDaDLQk
         xM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682192918; x=1684784918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxcD/lB1GTRmR0lN7OcwUWrczIuY5jxdZH5iQqSqalk=;
        b=gAokY1xzLBfdvBibJsjuMeb+BqYRT96peNWZmhzGweGeW0omdNad3K48g8Z5jFrJAs
         Ko7LyBsT8HHWFbWXXQ8Z8dfBa0F8NCmvLnNZ33WWtiLKjR+ssD1awEnzw9R1AOGWRmxt
         C0/DxFw+qMR9ON7oTPXl0UsoJar4yPrnim1pJEfWFKq8fjhJtlwXCxuhLO57YOwyyDHu
         yB2ItwjvdKPzyKbBIqOcb47tv9U5M4aSobqL3KNBAu2nFF6mnqjJmSyZiwxh46YfTm1S
         c+yJ4NAFb9Ioy25IwOtFp6GMPOfhKMmL11RDpod119NpurP0TTvadAs+8ca+4hd7UJkp
         5v0g==
X-Gm-Message-State: AAQBX9fzw07fDZDg1YlrJd7EZ5byMIHTamGjIlapLUciBn+mI/afX1uG
        fyFAloUKbe1NIB/4DZgJ+pqE4g==
X-Google-Smtp-Source: AKy350ZQ9Oh5Ak2ppkWvQiuCoUe1QWT8qv9hIkV7lx92UDb5omg0IDg4PoVPfsIugth0qmnHeQ7+3g==
X-Received: by 2002:a05:600c:4691:b0:3f1:7b63:bf0e with SMTP id p17-20020a05600c469100b003f17b63bf0emr4535630wmo.18.1682192917994;
        Sat, 22 Apr 2023 12:48:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm7919141wml.48.2023.04.22.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 12:48:37 -0700 (PDT)
Date:   Sat, 22 Apr 2023 22:48:32 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Vicki Pfau <vi@endrift.com>,
        kernel-janitors@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>,
        hust-os-kernel-patches@googlegroups.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
Message-ID: <d49bb5a2-ed78-4b16-b7ea-b9c7748ca0e4@kili.mountain>
References: <20230414125603.686123-1-dzm91@hust.edu.cn>
 <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
 <011c00e7-c351-4331-8be4-1c184d5773e1@kili.mountain>
 <3ccc85bd-0541-4ffb-a207-dfc533a2c0aa@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="II/AzlqpAIHtUdcC"
Content-Disposition: inline
In-Reply-To: <3ccc85bd-0541-4ffb-a207-dfc533a2c0aa@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--II/AzlqpAIHtUdcC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The warnings from this are quite promising.

When you're writing a check, you start with a simple idea and then try
it and then filter out the common false positives.

The first 10 warnings are from loops like:

	p = NULL;

	for (i = 0; i < limit; i++) {
		if (i == 0)
			p = non_null();
		else
			*p = something();
	}

Smatch doesn't handle loops correctly.  (I know how to fix this but I've
never gotten around to it because it would make Smatch slow)...

So instead of that maybe I would do a hack to silence this type of
warning.  Not sure what...

drivers/usb/gadget/udc/amd5536udc_pci.c:61 udc_pci_remove() warn: pointer dereferenced without being set '&udc->gadget'
This one is interesting.  Seems like a real bug.

drivers/mtd/ubi/block.c:391 ubiblock_create() warn: pointer dereferenced without being set 'dev->gd'

This one too.  So maybe we could make this a separate warning where
NULL dereferences happen on error paths.  Or maybe when they happen in
printks.

So there are ways to take this first draft and massage it and get
fewer false positives, by filtering false positives or taking things
which work and creating new checks instead.

Anyway, results attached.

regards,
dan carpenter

--II/AzlqpAIHtUdcC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

drivers/usb/core/devio.c:989 parse_usbdevfs_streams() warn: pointer dereferenced without being set 'intf'
drivers/usb/gadget/udc/amd5536udc_pci.c:61 udc_pci_remove() warn: pointer dereferenced without being set '&udc->gadget'
drivers/usb/gadget/udc/snps_udc_core.c:807 udc_create_dma_chain() warn: pointer dereferenced without being set 'last'
drivers/usb/gadget/udc/mv_udc_core.c:419 req_to_dtd() warn: pointer dereferenced without being set 'last_dtd'
drivers/usb/cdns3/cdnsp-mem.c:348 cdnsp_alloc_segments_for_ring() warn: pointer dereferenced without being set '*first->next'
drivers/usb/cdns3/cdnsp-mem.c:450 cdnsp_ring_expansion() warn: pointer dereferenced without being set 'first->next'
drivers/mtd/ubi/block.c:391 ubiblock_create() warn: pointer dereferenced without being set 'dev->gd'
drivers/mtd/nftlmount.c:135 find_boot_record() warn: pointer dereferenced without being set 'nftl->ReplUnitTable'
drivers/mtd/mtdswap.c:328 mtdswap_read_markers() warn: pointer dereferenced without being set 'd->mtd'
drivers/mtd/mtdswap.c:388 mtdswap_write_marker() warn: pointer dereferenced without being set 'd->mtd'
drivers/mtd/mtdswap.c:464 mtdswap_scan_eblks() warn: pointer dereferenced without being set 'd->mtd'
drivers/mtd/spi-nor/core.c:1701 spi_nor_init_erase_cmd_list() warn: pointer dereferenced without being set 'cmd'
drivers/iommu/dma-iommu.c:1274 iommu_dma_map_sg() warn: pointer dereferenced without being set 'prev'
drivers/firmware/arm_scmi/notify.c:1709 scmi_notification_exit() warn: pointer dereferenced without being set 'ni->notify_wq'
drivers/infiniband/ulp/rtrs/rtrs-clt.c:2866 rtrs_clt_open() warn: pointer dereferenced without being set 'clt->dev.p'
drivers/staging/rtl8712/rtl871x_mlme.c:367 update_scanned_network() warn: pointer dereferenced without being set 'pnetwork'
./include/linux/list.h:75 __list_add() warn: pointer dereferenced without being set '&(prev->next)'
drivers/staging/nvec/nvec_power.c:97 nvec_power_notifier() warn: pointer dereferenced without being set 'nvec_psy'
drivers/staging/nvec/nvec_power.c:166 nvec_power_bat_notifier() warn: pointer dereferenced without being set 'nvec_bat_psy'
drivers/staging/nvec/nvec_power.c:430 nvec_power_remove() warn: pointer dereferenced without being set 'nvec_bat_psy'
drivers/staging/nvec/nvec_power.c:427 nvec_power_remove() warn: pointer dereferenced without being set 'nvec_psy'
drivers/staging/emxx_udc/emxx_udc.c:2695 nbu2ss_ep_set_halt() warn: pointer dereferenced without being set 'ep->udc'
drivers/staging/emxx_udc/emxx_udc.c:2743 nbu2ss_ep_fifo_status() warn: pointer dereferenced without being set 'ep->udc'
drivers/staging/emxx_udc/emxx_udc.c:2785 nbu2ss_ep_fifo_flush() warn: pointer dereferenced without being set 'ep->udc'
drivers/clk/meson/g12a.c:5263 meson_g12a_dvfs_setup_common() warn: pointer dereferenced without being set 'g12a_cpu_clk_dyn.hw.core'
drivers/clk/meson/g12a.c:5253 meson_g12a_dvfs_setup_common() warn: pointer dereferenced without being set 'g12a_cpu_clk_postmux0.hw.core'
drivers/clk/meson/g12a.c:5341 meson_g12b_dvfs_setup() warn: pointer dereferenced without being set 'g12a_sys_pll.hw.core'
drivers/clk/meson/g12a.c:5290 meson_g12b_dvfs_setup() warn: pointer dereferenced without being set 'g12b_cpu_clk.hw.core'
drivers/clk/meson/g12a.c:5332 meson_g12b_dvfs_setup() warn: pointer dereferenced without being set 'g12b_cpub_clk.hw.core'
drivers/clk/meson/g12a.c:5323 meson_g12b_dvfs_setup() warn: pointer dereferenced without being set 'g12b_cpub_clk_dyn.hw.core'
drivers/clk/meson/g12a.c:5313 meson_g12b_dvfs_setup() warn: pointer dereferenced without being set 'g12b_cpub_clk_postmux0.hw.core'
drivers/clk/meson/g12a.c:5300 meson_g12b_dvfs_setup() warn: pointer dereferenced without being set 'g12b_sys1_pll.hw.core'
drivers/clk/meson/g12a.c:5364 meson_g12a_dvfs_setup() warn: pointer dereferenced without being set 'g12a_cpu_clk.hw.core'
drivers/clk/meson/g12a.c:5373 meson_g12a_dvfs_setup() warn: pointer dereferenced without being set 'g12a_sys_pll.hw.core'
drivers/block/drbd/drbd_req.c:624 __req_mod() warn: pointer dereferenced without being set 'peer_device'
drivers/block/drbd/drbd_nl.c:1049 drbd_determine_dev_size() warn: pointer dereferenced without being set 'device->bitmap'
drivers/tty/serial/8250/8250_aspeed_vuart.c:345 aspeed_vuart_handle_irq() warn: pointer dereferenced without being set '&port->state->port'
drivers/hsi/clients/hsi_char.c:186 hsc_msg_alloc() warn: pointer dereferenced without being set 'msg->sgt.sgl'
drivers/isdn/hardware/mISDN/mISDNinfineon.c:1112 inf_probe() warn: pointer dereferenced without being set 'card->ipac.isac.dch.dev.D.st'
drivers/isdn/hardware/mISDN/mISDNinfineon.c:1112 inf_probe() warn: pointer dereferenced without being set 'card->ipac.isac.dch.dev.dev.p'
drivers/target/iscsi/iscsi_target.c:790 iscsi_target_cleanup_module() warn: pointer dereferenced without being set 'iscsit_global->discovery_tpg'
drivers/target/iscsi/iscsi_target.c:3650 iscsit_thread_get_cpumask() warn: pointer dereferenced without being set 'iscsit_global->allowed_cpumask'
drivers/target/iscsi/iscsi_target.c:3677 iscsit_thread_reschedule() warn: pointer dereferenced without being set 'iscsit_global->allowed_cpumask'
drivers/target/iscsi/iscsi_target_configfs.c:1169 lio_target_wwn_cpus_allowed_list_store() warn: pointer dereferenced without being set 'iscsit_global->allowed_cpumask'
drivers/gpu/drm/nouveau/nouveau_chan.c:500 nouveau_channel_new() warn: pointer dereferenced without being set '*pchan->userd'
drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:389 nvkm_uvmm_new() warn: pointer dereferenced without being set 'uvmm->vmm'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager.c:280 pm_send_set_resources() warn: pointer dereferenced without being set 'pm->priv_queue->rptr_kernel'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager.c:293 pm_send_set_resources() warn: pointer dereferenced without being set 'pm->priv_queue->wptr_kernel'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:1167 kfd_ioctl_alloc_memory_of_gpu() warn: pointer dereferenced without being set 'mem->bo'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:1585 kfd_ioctl_import_dmabuf() warn: pointer dereferenced without being set 'mem->bo'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:2309 criu_restore_memory_of_gpu() warn: pointer dereferenced without being set '*kgd_mem->bo'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:994 subvp_vblank_schedulable() warn: pointer dereferenced without being set 'subvp_pipe'
drivers/acpi/pfr_telemetry.c:173 set_pfrt_log_level() warn: pointer dereferenced without being set 'out_obj->package.elements'
drivers/acpi/pfr_telemetry.c:201 get_pfrt_log_level() warn: pointer dereferenced without being set 'out_obj->package.elements'
drivers/dma-buf/dma-resv.c:577 dma_resv_get_fences() warn: pointer dereferenced without being set '*fences'
drivers/hid/hid-multitouch.c:1107 mt_process_slot() warn: pointer dereferenced without being set 'slot->a'
drivers/md/dm-cache-target.c:1537 invalidate_lock() warn: pointer dereferenced without being set 'mg->cell'
drivers/dma/mmp_pdma.c:486 mmp_pdma_prep_memcpy() warn: pointer dereferenced without being set 'prev'
drivers/dma/mmp_pdma.c:571 mmp_pdma_prep_slave_sg() warn: pointer dereferenced without being set 'prev'
drivers/dma/mmp_pdma.c:659 mmp_pdma_prep_dma_cyclic() warn: pointer dereferenced without being set 'prev'
drivers/dma/pch_dma.c:629 pd_prep_slave_sg() warn: pointer dereferenced without being set 'prev'
drivers/dma/mediatek/mtk-cqdma.c:535 mtk_cqdma_prep_dma_memcpy() warn: pointer dereferenced without being set 'prev_tx'
drivers/pwm/pwm-lpc32xx.c:144 lpc32xx_pwm_probe() warn: pointer dereferenced without being set 'lpc32xx->chip.pwms'
drivers/media/usb/as102/as10x_cmd_stream.c:57 as10x_cmd_add_PID_filter() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd_stream.c:108 as10x_cmd_del_PID_filter() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd_stream.c:151 as10x_cmd_start_streaming() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd.c:47 as10x_cmd_turn_on() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd.c:87 as10x_cmd_turn_off() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd.c:142 as10x_cmd_set_tune() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd.c:186 as10x_cmd_get_tune_status() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd.c:239 as10x_cmd_get_tps() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd.c:298 as10x_cmd_get_demod_stats() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd.c:358 as10x_cmd_get_impulse_resp() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd_cfg.c:59 as10x_cmd_get_context() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd_cfg.c:117 as10x_cmd_set_context() warn: pointer dereferenced without being set 'prsp'
drivers/media/usb/as102/as10x_cmd_cfg.c:166 as10x_cmd_eLNA_change_mode() warn: pointer dereferenced without being set 'prsp'
drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c:431 mtk_vcodec_probe() warn: pointer dereferenced without being set 'dev->m2m_dev_dec->source'
drivers/media/pci/cx18/cx18-alsa-main.c:145 snd_cx18_init() warn: pointer dereferenced without being set 'cxsc->sc'
drivers/media/pci/cx25821/cx25821-core.c:1114 cx25821_risc_field_audio() warn: pointer dereferenced without being set 'sg'
drivers/media/pci/zoran/zr36016.c:118 zr36016_basic_test() warn: pointer dereferenced without being set 'ptr->codec->master_data'
drivers/media/pci/zoran/zr36016.c:157 zr36016_init() warn: pointer dereferenced without being set 'ptr->codec->master_data'
drivers/media/pci/zoran/zr36050.c:120 zr36050_basic_test() warn: pointer dereferenced without being set 'ptr->codec->master_data'
drivers/media/pci/zoran/zr36050.c:372 zr36050_init() warn: pointer dereferenced without being set 'ptr->codec->master_data'
drivers/media/pci/zoran/zr36060.c:114 zr36060_basic_test() warn: pointer dereferenced without being set 'ptr->codec->master_data'
drivers/media/pci/zoran/zr36060.c:327 zr36060_init() warn: pointer dereferenced without being set 'ptr->codec->master_data'
drivers/media/pci/cobalt/cobalt-alsa-main.c:111 cobalt_alsa_init() warn: pointer dereferenced without being set 'cobsc->s'
drivers/media/pci/cobalt/cobalt-alsa-main.c:111 cobalt_alsa_init() warn: pointer dereferenced without being set 'cobsc->sc'
drivers/media/pci/ivtv/ivtv-alsa-main.c:144 snd_ivtv_init() warn: pointer dereferenced without being set 'itvsc->sc'
drivers/media/common/videobuf2/videobuf2-dma-contig.c:200 vb2_dc_alloc_coherent() warn: pointer dereferenced without being set 'buf->dev'
drivers/media/common/videobuf2/videobuf2-dma-contig.c:219 vb2_dc_alloc_non_coherent() warn: pointer dereferenced without being set 'buf->dev'
drivers/scsi/initio.c:2874 initio_probe_one() warn: pointer dereferenced without being set 'prev'
drivers/scsi/libiscsi.c:3779 iscsi_conn_get_addr_param() warn: pointer dereferenced without being set 'sin6'
drivers/scsi/be2iscsi/be_main.c:2561 beiscsi_alloc_mem() warn: pointer dereferenced without being set 'mem_descr->mem_array'
drivers/input/touchscreen/iqs5xx.c:926 fw_file_store() warn: pointer dereferenced without being set 'iqs5xx->input'
drivers/crypto/caam/caampkc.c:898 caam_read_rsa_crt() warn: pointer dereferenced without being set 'ptr'
drivers/crypto/caam/caampkc.c:923 caam_read_raw_data() warn: pointer dereferenced without being set 'buf'
drivers/crypto/sa2ul.c:1528 sa_sha_cra_init_alg() warn: pointer dereferenced without being set 'ctx->fallback.ahash'
drivers/tee/tee_shm_pool.c:46 pool_op_gen_destroy_pool() warn: pointer dereferenced without being set 'pool->private_data'
drivers/net/wireless/broadcom/b43/phy_n.c:4258 b43_nphy_tx_gain_table_upload() warn: pointer dereferenced without being set 'rf_pwr_offset_table'
drivers/net/wireless/ath/wcn36xx/dxe.c:89 wcn36xx_dxe_allocate_ctl_block() warn: pointer dereferenced without being set 'prev_ctl'
drivers/net/wireless/ath/wcn36xx/dxe.c:214 wcn36xx_dxe_init_descs() warn: pointer dereferenced without being set 'prev_dxe'
drivers/net/wireless/ath/ath11k/pci.c:846 ath11k_pci_probe() warn: pointer dereferenced without being set 'ab_pci->ab->pci.msi.config'
drivers/net/xen-netback/netback.c:1535 xenvif_map_frontend_data_rings() warn: pointer dereferenced without being set '&(rxs->req_prod)'
drivers/net/xen-netback/netback.c:1520 xenvif_map_frontend_data_rings() warn: pointer dereferenced without being set '&(txs->req_prod)'
drivers/net/xen-netback/interface.c:634 xenvif_connect_ctrl() warn: pointer dereferenced without being set '&(shared->req_prod)'
drivers/net/wireguard/peer.c:41 wg_peer_create() warn: pointer dereferenced without being set 'peer->handshake.static_identity'
drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:263 dpaa2_eth_build_frag_skb() warn: pointer dereferenced without being set 'skb'
drivers/net/ethernet/freescale/fman/fman_memac.c:1016 memac_config() warn: pointer dereferenced without being set 'memac->fm'
drivers/net/ethernet/freescale/fman/fman_tgec.c:721 tgec_config() warn: pointer dereferenced without being set 'tgec->fm'
drivers/net/ethernet/netronome/nfp/abm/main.c:331 nfp_abm_vnic_alloc() warn: pointer dereferenced without being set 'alink->abm'
drivers/net/ethernet/netronome/nfp/flower/main.c:597 nfp_flower_spawn_phy_reprs() warn: pointer dereferenced without being set 'app->ctrl'
drivers/net/ethernet/netronome/nfp/bpf/jit.c:4232 nfp_bpf_opt_ldst_gather() warn: pointer dereferenced without being set 'head_ld_meta'
drivers/net/ethernet/netronome/nfp/bpf/jit.c:4211 nfp_bpf_opt_ldst_gather() warn: pointer dereferenced without being set 'head_st_meta'
drivers/net/ethernet/netronome/nfp/bpf/jit.c:4217 nfp_bpf_opt_ldst_gather() warn: pointer dereferenced without being set 'prev_ld'
drivers/net/ethernet/netronome/nfp/bpf/jit.c:4218 nfp_bpf_opt_ldst_gather() warn: pointer dereferenced without being set 'prev_st'
drivers/net/ethernet/netronome/nfp/bpf/jit.c:4358 nfp_bpf_opt_pkt_cache() warn: pointer dereferenced without being set 'range_node'
drivers/net/ethernet/pensando/ionic/ionic_txrx.c:1088 ionic_tx_tso() warn: pointer dereferenced without being set 'elem'
drivers/net/ethernet/marvell/skge.c:2633 skge_up() warn: pointer dereferenced without being set 'skge->rx_ring.start->desc'
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:2186 mlx5dr_action_destroy() warn: pointer dereferenced without being set 'action->aso'
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:2189 mlx5dr_action_destroy() warn: pointer dereferenced without being set 'action->range'
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:2162 mlx5dr_action_destroy() warn: pointer dereferenced without being set 'action->reformat'
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:2165 mlx5dr_action_destroy() warn: pointer dereferenced without being set 'action->rewrite'
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:2183 mlx5dr_action_destroy() warn: pointer dereferenced without being set 'action->sampler'
drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c:75 parse_tc_vlan_action() warn: pointer dereferenced without being set 'parse_state'
drivers/net/ethernet/cavium/thunder/nicvf_queues.c:1714 nicvf_get_rcv_skb() warn: pointer dereferenced without being set 'skb'
drivers/net/ethernet/emulex/benet/be_cmds.c:1370 be_cmd_txq_create() warn: pointer dereferenced without being set '&req->hdr'
drivers/net/ethernet/emulex/benet/be_cmds.c:1543 be_cmd_if_create() warn: pointer dereferenced without being set '&req->hdr'
drivers/net/ethernet/emulex/benet/be_cmds.c:1576 be_cmd_if_destroy() warn: pointer dereferenced without being set '&req->hdr'
drivers/net/ethernet/emulex/benet/be_cmds.c:1778 be_cmd_get_fat_dump_len() warn: pointer dereferenced without being set '&req->hdr'
drivers/net/ethernet/intel/i40e/i40e_main.c:2320 i40e_update_filter_state() warn: pointer dereferenced without being set 'add_head'
drivers/net/vxlan/vxlan_vnifilter.c:379 vxlan_vnifilter_dump_dev() warn: pointer dereferenced without being set 'vend'
drivers/misc/genwqe/card_utils.c:417 genwqe_setup_sgl() warn: pointer dereferenced without being set 'last_s'
drivers/misc/bcm-vk/bcm_vk_msg.c:1055 bcm_vk_read() warn: pointer dereferenced without being set 'entry'
drivers/base/regmap/regmap-spi-avmm.c:449 br_do_rx_and_pkt_phy_parse() warn: pointer dereferenced without being set 'tb'
drivers/soc/qcom/llcc-qcom.c:641 llcc_slice_activate() warn: pointer dereferenced without being set 'drv_data->bitmap'
drivers/soc/qcom/llcc-qcom.c:681 llcc_slice_deactivate() warn: pointer dereferenced without being set 'drv_data->bitmap'
drivers/soc/fsl/qbman/qman_test_stash.c:222 allocate_frame_data() warn: pointer dereferenced without being set 'qman_dma_portal'
block/blk-integrity.c:82 blk_rq_map_integrity_sg() warn: pointer dereferenced without being set 'sg'
security/integrity/ima/ima_main.c:1000 process_buffer_measurement() warn: pointer dereferenced without being set 'entry->template_desc'
security/integrity/ima/ima_api.c:155 ima_add_violation() warn: pointer dereferenced without being set 'entry->template_desc'
security/integrity/ima/ima_api.c:375 ima_store_measurement() warn: pointer dereferenced without being set 'entry->template_desc'
security/integrity/ima/ima_init.c:86 ima_add_boot_aggregate() warn: pointer dereferenced without being set 'entry->template_desc'
fs/btrfs/tests/free-space-tests.c:362 check_cache_empty() warn: pointer dereferenced without being set 'cache->free_space_ctl'
fs/btrfs/tests/free-space-tests.c:426 test_steal_space_from_bitmap_to_extent() warn: pointer dereferenced without being set 'cache->free_space_ctl'
fs/btrfs/extent_map.c:118 tree_insert() warn: pointer dereferenced without being set 'entry'
fs/ntfs/aops.c:1086 ntfs_write_mst_block() warn: pointer dereferenced without being set 'rec_start_bh'
fs/xfs/scrub/agheader_repair.c:761 xrep_agfl() warn: pointer dereferenced without being set 'sc->tp'
fs/xfs/scrub/rmap.c:552 xchk_rmapbt() warn: pointer dereferenced without being set 'sc->sa.rmap_cur'
fs/xfs/scrub/refcount.c:520 xchk_refcountbt() warn: pointer dereferenced without being set 'sc->sa.refc_cur'
fs/xfs/libxfs/xfs_dir2_node.c:668 xfs_dir2_leafn_lookup_for_addname() warn: pointer dereferenced without being set 'curbp'
fs/xfs/libxfs/xfs_dir2_node.c:886 xfs_dir2_leafn_lookup_for_entry() warn: pointer dereferenced without being set 'state->extrablk.bp'
fs/xfs/libxfs/xfs_da_btree.c:1150 xfs_da3_join() warn: pointer dereferenced without being set 'drop_blk->bp'
fs/ext2/dir.c:531 ext2_add_link() warn: pointer dereferenced without being set 'de'
fs/gfs2/xattr.c:1350 ea_dealloc_indirect() warn: pointer dereferenced without being set 'rgd'
fs/gfs2/bmap.c:1467 sweep_bh_for_rgrps() warn: pointer dereferenced without being set 'rd_gh->gh_gl'
fs/ecryptfs/crypto.c:1370 ecryptfs_read_metadata() warn: pointer dereferenced without being set 'ecryptfs_header_cache'
fs/ecryptfs/crypto.c:1601 ecryptfs_add_new_key_tfm() warn: pointer dereferenced without being set 'ecryptfs_key_tfm_cache'
fs/ecryptfs/keystore.c:1263 parse_tag_1_packet() warn: pointer dereferenced without being set 'ecryptfs_auth_tok_list_item_cache'
fs/ecryptfs/keystore.c:1398 parse_tag_3_packet() warn: pointer dereferenced without being set 'ecryptfs_auth_tok_list_item_cache'
fs/ecryptfs/keystore.c:2416 ecryptfs_generate_key_packet_set() warn: pointer dereferenced without being set 'ecryptfs_key_record_cache'
fs/ecryptfs/keystore.c:2497 ecryptfs_add_keysig() warn: pointer dereferenced without being set 'ecryptfs_key_sig_cache'
fs/ecryptfs/keystore.c:2517 ecryptfs_add_global_auth_tok() warn: pointer dereferenced without being set 'ecryptfs_global_auth_tok_cache'
fs/ecryptfs/inode.c:327 ecryptfs_lookup_interpose() warn: pointer dereferenced without being set 'ecryptfs_dentry_info_cache'
fs/ecryptfs/main.c:595 ecryptfs_mount() warn: pointer dereferenced without being set 'ecryptfs_dentry_info_cache'
fs/ecryptfs/main.c:489 ecryptfs_mount() warn: pointer dereferenced without being set 'ecryptfs_sb_info_cache'
fs/ecryptfs/file.c:195 ecryptfs_open() warn: pointer dereferenced without being set 'ecryptfs_file_info_cache'
fs/ecryptfs/file.c:263 ecryptfs_dir_open() warn: pointer dereferenced without being set 'ecryptfs_file_info_cache'
fs/ecryptfs/super.c:41 ecryptfs_alloc_inode() warn: pointer dereferenced without being set 'ecryptfs_inode_info_cache'
fs/ecryptfs/mmap.c:420 ecryptfs_write_inode_size_to_xattr() warn: pointer dereferenced without being set 'ecryptfs_xattr_cache'
fs/namespace.c:2274 attach_recursive_mnt() warn: pointer dereferenced without being set 'child'
fs/ceph/caps.c:3933 handle_cap_export() warn: pointer dereferenced without being set 'tcap'
fs/overlayfs/namei.c:868 ovl_lookup() warn: pointer dereferenced without being set 'd.name.name'
fs/overlayfs/super.c:831 ovl_workdir_create() warn: pointer dereferenced without being set 'work->d_inode'
fs/ubifs/lpt.c:1444 ubifs_get_pnode() warn: pointer dereferenced without being set 'branch->pnode'
fs/ocfs2/dlm/dlmmaster.c:856 dlm_get_lock_resource() warn: pointer dereferenced without being set 'mle'
fs/ocfs2/dir.c:1536 ocfs2_remove_block_from_free_list() warn: pointer dereferenced without being set 'bh'
fs/ocfs2/dir.c:1617 __ocfs2_add_entry() warn: pointer dereferenced without being set 'bh'
fs/coredump.c:777 do_coredump() warn: pointer dereferenced without being set 'cprm.file'
fs/f2fs/segment.c:1049 __lookup_discard_cmd_ret() warn: pointer dereferenced without being set 'dc'
fs/f2fs/extent_cache.c:256 __lookup_extent_node_ret() warn: pointer dereferenced without being set 'en'
kernel/bpf/btf.c:5638 btf_get_prog_ctx_type() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/btf.c:5699 get_kern_ctx_btf_id() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/bpf_struct_ops.c:322 check_zero_holes() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/bpf_struct_ops.c:429 bpf_struct_ops_map_update_elem() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/bpf_struct_ops.c:601 bpf_struct_ops_map_seq_show_elem() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/verifier.c:5639 check_ptr_to_map_access() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/verifier.c:7230 check_reg_type() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/verifier.c:18334 check_struct_ops_btf_id() warn: pointer dereferenced without being set 'btf_vmlinux'
kernel/bpf/core.c:2472 bpf_prog_array_copy() warn: pointer dereferenced without being set 'old_array'
sound/core/seq/seq_prioq.c:302 snd_seq_prioq_leave() warn: pointer dereferenced without being set 'freeprev'
sound/core/seq/seq_prioq.c:292 snd_seq_prioq_leave() warn: pointer dereferenced without being set 'prev'
sound/core/seq/seq_prioq.c:417 snd_seq_prioq_remove_events() warn: pointer dereferenced without being set 'freeprev'
sound/core/seq/seq_prioq.c:405 snd_seq_prioq_remove_events() warn: pointer dereferenced without being set 'prev'
sound/pci/ctxfi/ctdaio.c:534 get_daio_rsc() warn: pointer dereferenced without being set 'mgr->mgr.rscs'
sound/pci/ctxfi/ctdaio.c:590 put_daio_rsc() warn: pointer dereferenced without being set 'mgr->mgr.rscs'
sound/soc/codecs/ad1980.c:211 ad1980_reset() warn: pointer dereferenced without being set 'ac97->bus'
sound/soc/codecs/max98088.c:1597 max98088_handle_eq_pdata() warn: pointer dereferenced without being set 'max98088->eq_texts'
sound/soc/codecs/max98095.c:1594 max98095_handle_eq_pdata() warn: pointer dereferenced without being set 'max98095->eq_texts'
sound/soc/codecs/max98095.c:1746 max98095_handle_bq_pdata() warn: pointer dereferenced without being set 'max98095->bq_texts'
sound/soc/codecs/wm8904.c:2017 wm8904_handle_retune_mobile_pdata() warn: pointer dereferenced without being set 'wm8904->retune_mobile_texts'
sound/soc/codecs/wm8994.c:3374 wm8994_handle_retune_mobile_pdata() warn: pointer dereferenced without being set 'wm8994->retune_mobile_texts'
sound/soc/codecs/wm8996.c:2568 wm8996_retune_mobile_pdata() warn: pointer dereferenced without being set 'wm8996->retune_mobile_texts'
sound/soc/sh/fsi.c:2028 fsi_probe() warn: pointer dereferenced without being set 'master->fsia.playback.handler'
sound/soc/intel/avs/pcm.c:535 avs_dai_fe_hw_params() warn: pointer dereferenced without being set 'data->path'
sound/soc/intel/skylake/skl-topology.c:2488 skl_tplg_get_token() warn: pointer dereferenced without being set 'mconfig->pipe'
net/dccp/ipv6.c:352 dccp_v6_conn_request() warn: pointer dereferenced without being set 'dccp6_request_sock_ops.slab'
net/dccp/ipv4.c:622 dccp_v4_conn_request() warn: pointer dereferenced without being set 'dccp_request_sock_ops.slab'
net/core/skbuff.c:4467 skb_segment() warn: pointer dereferenced without being set 'tail'
net/sctp/stream_interleave.c:787 sctp_intl_retrieve_first_uo() warn: pointer dereferenced without being set 'sin'
net/sctp/stream_interleave.c:894 sctp_intl_retrieve_first() warn: pointer dereferenced without being set 'sin'
net/mac80211/mesh_pathtbl.c:560 mesh_fast_tx_cache() warn: pointer dereferenced without being set 'hdr'
net/bridge/br_vlan.c:2029 br_vlan_dump_dev() warn: pointer dereferenced without being set 'range_end'
net/bridge/br_vlan_options.c:307 br_vlan_process_options() warn: pointer dereferenced without being set 'curr_end'
net/bridge/br_vlan_options.c:713 br_vlan_rtm_process_global_options() warn: pointer dereferenced without being set 'curr_end'
net/bridge/br_netlink_tunnel.c:51 __get_num_vlan_tunnel_infos() warn: pointer dereferenced without being set 'vtend'
net/bridge/br_netlink_tunnel.c:167 br_fill_vlan_tunnel_info() warn: pointer dereferenced without being set 'vtend'
net/ipv6/ip6_input.c:128 ip6_list_rcv_finish() warn: pointer dereferenced without being set 'hint'
net/xfrm/xfrm_device.c:219 validate_xmit_xfrm() warn: pointer dereferenced without being set 'pskb'
net/ipv4/fib_semantics.c:2093 fib_select_default() warn: pointer dereferenced without being set 'fa1'
net/rds/connection.c:307 __rds_conn_create() warn: pointer dereferenced without being set 'conn'
lib/maple_tree.c:3848 mas_extend_spanning_null() warn: pointer dereferenced without being set 'l_wr_mas->slots'
lib/maple_tree.c:3863 mas_extend_spanning_null() warn: pointer dereferenced without being set 'r_wr_mas->slots'
lib/sg_split.c:87 sg_split_phys() warn: pointer dereferenced without being set 'out_sg'
mm/gup.c:1633 __mm_populate() warn: pointer dereferenced without being set 'vma'
mm/zsmalloc.c:1092 create_page_chain() warn: pointer dereferenced without being set 'prev_page'

--II/AzlqpAIHtUdcC--
