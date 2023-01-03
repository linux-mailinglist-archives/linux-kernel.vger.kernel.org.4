Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D265BB9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbjACIKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjACIKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:10:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D62A5;
        Tue,  3 Jan 2023 00:10:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w1so16522511wrt.8;
        Tue, 03 Jan 2023 00:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rhra4FwBLg9m+4+vXc8PagED9PkYQV87HgCAw5sVyGw=;
        b=j+XlRJVpT1qKfnC2AxhtVc/ggk7DEd8k2JQ0rMZwlNii2ZBFjUuxQR/VXHBhh91K28
         pmEAXBb/YmxXGYFyjl4gbD4/2PiGZbvEVPByjAy5vv7bKTgI+OZ50MK1DIHMQWkxG68v
         H5suyFrFCzmMiptA3TFpBpDZFZxLq0c8VhnPwskLzhJTKUEV+ylGogbn/CjZR5cZuthT
         pVMKt1SlEXrQuyovEesbKcxRCVQGdPvL8buXdt7S1pv4IVDjyTsFWlIYcHIr1J6Whinn
         DoayYibLUxXEBtLfXoLOsZXr78MEu82Goq+GVk4qOntDSCZJKfluplI1sz7LURH+J6Se
         vGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhra4FwBLg9m+4+vXc8PagED9PkYQV87HgCAw5sVyGw=;
        b=ojWJLy40r7mo54wPhv8HgYSJ0ryE3wNTy4MnWZ5V24/pluTuC7fTKvJm57pWq+TGI3
         GaceFlzI++IgKQx7QgZUni6STWRm9GftchbffgwnaiKFBqtmIll/qnvqa8VQKS1jpMKM
         tDxJVOPGPG164iI2ImApAjFGZ2/IeUXBRU5KRsh4OweO/cUZaolWlhEUTGub5TuNb8aS
         n/9M8XXfuhk3DgCVirwa+Lrn/P8FaoWABzo0RuZT8mMs7jvGBWpynmJsCxdTHsZ/89Ad
         c13zvAOlGhX3E0Fn1Z8+aXfRMAhNA1qvfbieWoKWSRYvQCsHBvsgKlx6H/WcSkBh1yRt
         3Nvg==
X-Gm-Message-State: AFqh2krbF5BRoD4JdzAmqE/Ue+a/6Ta7P53bY5XbKAg272Zmrg/Z6ZLI
        9YnUjIvShZdTwgMqqEjO7Po=
X-Google-Smtp-Source: AMrXdXv/uk1zP1kYRS/c+8VoEC6y4FltnfhA/6OWf2EN57lLq/sB77bBrAkhalJ1LlxlSXxW+N8fBQ==
X-Received: by 2002:a5d:69cd:0:b0:242:6b2f:4988 with SMTP id s13-20020a5d69cd000000b002426b2f4988mr26824641wrw.46.1672733404229;
        Tue, 03 Jan 2023 00:10:04 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm30838470wrj.68.2023.01.03.00.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:10:03 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:09:58 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c:467
 h264_encode_frame() warn: missing error code? 'ret'
Message-ID: <202301030703.ZBnsKl0x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69b41ac87e4a664de78a395ff97166f0b2943210
commit: 2023a99811110aebba9eee4aa09ef7bd21a8a249 media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
config: ia64-randconfig-m041-20230101
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c:467 h264_encode_frame() warn: missing error code? 'ret'

vim +/ret +467 drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c

2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  435  static int h264_encode_frame(struct venc_h264_inst *inst,
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  436  			     struct venc_frm_buf *frm_buf,
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  437  			     struct mtk_vcodec_mem *bs_buf,
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  438  			     unsigned int *bs_size)
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  439  {
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  440  	int ret = 0;
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  441  	unsigned int irq_status;
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  442  	struct venc_frame_info frame_info;
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  443  
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  444  	mtk_vcodec_debug_enter(inst);
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  445  	mtk_vcodec_debug(inst, "frm_cnt = %d\n ", inst->frm_cnt);
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  446  	frame_info.frm_count = inst->frm_cnt;
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  447  	frame_info.skip_frm_count = inst->skip_frm_cnt;
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  448  	frame_info.frm_type = h264_frame_type(inst);
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  449  	mtk_vcodec_debug(inst, "frm_count = %d,skip_frm_count =%d,frm_type=%d.\n",
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  450  			 frame_info.frm_count, frame_info.skip_frm_count,
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  451  			 frame_info.frm_type);
10d0f56800b313 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Dafna Hirschfeld 2021-10-22  452  	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME, frm_buf, bs_buf, &frame_info);
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  453  	if (ret)
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  454  		return ret;
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  455  
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  456  	/*
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  457  	 * skip frame case: The skip frame buffer is composed by vpu side only,
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  458  	 * it does not trigger the hw, so skip the wait interrupt operation.
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  459  	 */
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  460  	if (inst->vpu_inst.state == VEN_IPI_MSG_ENC_STATE_SKIP) {
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  461  		*bs_size = inst->vpu_inst.bs_size;
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  462  		memcpy(bs_buf->va,
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  463  		       inst->work_bufs[VENC_H264_VPU_WORK_BUF_SKIP_FRAME].va,
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  464  		       *bs_size);
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  465  		++inst->frm_cnt;
0dc4b328612579 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Yunfei Dong      2020-08-21  466  		++inst->skip_frm_cnt;
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03 @467  		return ret;

This seems intentional.  Just do "return 0;" here to make the code more
readable.

2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  468  	}
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  469  
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  470  	irq_status = h264_enc_wait_venc_done(inst);
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  471  	if (irq_status != MTK_VENC_IRQ_STATUS_FRM) {
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  472  		mtk_vcodec_err(inst, "irq_status=%d failed", irq_status);
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  473  		return -EIO;
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  474  	}
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  475  
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  476  	*bs_size = h264_read_reg(inst, VENC_PIC_BITSTREAM_BYTE_CNT);
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  477  
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  478  	++inst->frm_cnt;
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  479  	mtk_vcodec_debug(inst, "frm %d bs_size %d key_frm %d <-",
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  480  			 inst->frm_cnt, *bs_size, inst->vpu_inst.is_key_frm);
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  481  
2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  482  	return ret;

Here too.

2cc93862d4840f drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c Tiffany Lin      2016-05-03  483  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


