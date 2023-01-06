Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1A65FC06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjAFHdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjAFHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:33:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE846AD95;
        Thu,  5 Jan 2023 23:33:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l26so494321wme.5;
        Thu, 05 Jan 2023 23:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fryLgUhyc4PP68FzTGHDLJwZ8g1kpMrCFCBcKvTSbIM=;
        b=Mbqqc4SfDl3i56U8CiGCOj+H2nPqKWcc12YtYWpqSfK0x15AstNbluvOdr2oPmiliG
         fc6zDseyy4eNH8VzpRuJmuXBS+ZtI5WICcU4/YgST9aN0o6jR6lGzFQviERtx1OVyIuL
         IXcWDQ5MyxHpSHQ+Z6aMYbiL7CeDOv6cEESo4EarXDxRJ8RSXCi5xsulU6ln66e+YYy1
         Ums3GDYdLhjYZFtuYEHTk/urEZKHE499xsXrYix4MgioddCTlRDBp6ch6S71aQGVUce2
         QYgdn7WXk5mKKk+DuYd1WATw2wQCJxt5n8jqIpEtv5hprPvJBneRWUbD/lCGPGUwdojf
         rriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fryLgUhyc4PP68FzTGHDLJwZ8g1kpMrCFCBcKvTSbIM=;
        b=XMilSmCW0QgrewwfP1nG7SBFCz0WeFZyDa4LnHGaz4u9gBLDEZ8zZvfdfM8YMvhDXw
         NBW+sJwWjbogotM6I3ZsL+Vak5QmJN4y1GyjYCNzm9htUR7R3HL2y2kYYWa9tbFSg4Wx
         h8YFby6E0QboiBFjl/fkmJiUv/AbMJG9ToJo2/vk2Pzp+yxyY+n6FZpgwKxUIhH7ZlQw
         V2su0lWC6tJH5FoFMaE2ILAoDiTgycqQsbwiuiIOOzZB/PTltw3c/vp5t0hV4QZ5j5xb
         qeYgouIQRQ5oVr94Kj+769iCIw8g2H7VvNWmerWQlv/p2CHbagJl/W/SKk/UyHtVkazm
         jUOA==
X-Gm-Message-State: AFqh2ko/Bo8BlkAyYuwtoPFV7FvGGDRn3a1w+RdYo/L6mFB4Aw9egRoF
        kjxg7uGwfYjI47y+hrZJPpY=
X-Google-Smtp-Source: AMrXdXtrcCS7Q3zoliyIo93NAmMqzefmn1311SdNqJbWKYGFmApsuGCWfyU7SHOWGLkVONfzKGXv5Q==
X-Received: by 2002:a05:600c:250:b0:3d2:2830:b8bb with SMTP id 16-20020a05600c025000b003d22830b8bbmr42185381wmj.34.1672990385260;
        Thu, 05 Jan 2023 23:33:05 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c301300b003d6b71c0c92sm5470479wmh.45.2023.01.05.23.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:04 -0800 (PST)
Date:   Fri, 6 Jan 2023 10:33:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v2 10/13] media: verisilicon: Add Rockchip AV1 decoder
Message-ID: <202301060326.FJvy51O1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103170058.810597-11-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/dt-bindings-media-rockchip-vpu-Add-rk3588-vpu-compatible/20230104-010906
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230103170058.810597-11-benjamin.gaignard%40collabora.com
patch subject: [PATCH v2 10/13] media: verisilicon: Add Rockchip AV1 decoder
config: ia64-randconfig-m041-20230101
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:121 rockchip_vpu981_get_frame_index() error: buffer overflow 'frame->reference_frame_ts' 8 <= 8
drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:167 rockchip_vpu981_av1_dec_frame_ref() error: buffer overflow 'frame->global_motion.type' 8 <= 9
drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:1947 rockchip_vpu981_av1_dec_run() warn: missing error code 'ret'

vim +121 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c

9223ba771533395 Benjamin Gaignard 2023-01-03  109  
9223ba771533395 Benjamin Gaignard 2023-01-03  110  static int rockchip_vpu981_get_frame_index(struct hantro_ctx *ctx, int ref)
9223ba771533395 Benjamin Gaignard 2023-01-03  111  {
9223ba771533395 Benjamin Gaignard 2023-01-03  112  	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
9223ba771533395 Benjamin Gaignard 2023-01-03  113  	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
9223ba771533395 Benjamin Gaignard 2023-01-03  114  	const struct v4l2_ctrl_av1_frame *frame = ctrls->frame;
9223ba771533395 Benjamin Gaignard 2023-01-03  115  	u64 timestamp;
9223ba771533395 Benjamin Gaignard 2023-01-03  116  	int i, idx = frame->ref_frame_idx[ref];
9223ba771533395 Benjamin Gaignard 2023-01-03  117  
9223ba771533395 Benjamin Gaignard 2023-01-03  118  	if (idx >= AV1_MAX_FRAME_BUF_COUNT || idx < 0)
                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Should this be V4L2_AV1_TOTAL_REFS_PER_FRAME?

9223ba771533395 Benjamin Gaignard 2023-01-03  119  		return AV1_INVALID_IDX;
9223ba771533395 Benjamin Gaignard 2023-01-03  120  
9223ba771533395 Benjamin Gaignard 2023-01-03 @121  	timestamp = frame->reference_frame_ts[idx];
                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


9223ba771533395 Benjamin Gaignard 2023-01-03  122  	for (i = 0; i < AV1_MAX_FRAME_BUF_COUNT; i++) {
9223ba771533395 Benjamin Gaignard 2023-01-03  123  		if (!av1_dec->frame_refs[i].used)
9223ba771533395 Benjamin Gaignard 2023-01-03  124  			continue;
9223ba771533395 Benjamin Gaignard 2023-01-03  125  		if (av1_dec->frame_refs[i].timestamp == timestamp)
9223ba771533395 Benjamin Gaignard 2023-01-03  126  			return i;
9223ba771533395 Benjamin Gaignard 2023-01-03  127  	}
9223ba771533395 Benjamin Gaignard 2023-01-03  128  
9223ba771533395 Benjamin Gaignard 2023-01-03  129  	return AV1_INVALID_IDX;
9223ba771533395 Benjamin Gaignard 2023-01-03  130  }
9223ba771533395 Benjamin Gaignard 2023-01-03  131  
9223ba771533395 Benjamin Gaignard 2023-01-03  132  static int rockchip_vpu981_get_order_hint(struct hantro_ctx *ctx, int ref)
9223ba771533395 Benjamin Gaignard 2023-01-03  133  {
9223ba771533395 Benjamin Gaignard 2023-01-03  134  	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
9223ba771533395 Benjamin Gaignard 2023-01-03  135  	int idx = rockchip_vpu981_get_frame_index(ctx, ref);
9223ba771533395 Benjamin Gaignard 2023-01-03  136  
9223ba771533395 Benjamin Gaignard 2023-01-03  137  	if (idx != AV1_INVALID_IDX)
9223ba771533395 Benjamin Gaignard 2023-01-03  138  		return av1_dec->frame_refs[idx].order_hint;
9223ba771533395 Benjamin Gaignard 2023-01-03  139  
9223ba771533395 Benjamin Gaignard 2023-01-03  140  	return 0;
9223ba771533395 Benjamin Gaignard 2023-01-03  141  }
9223ba771533395 Benjamin Gaignard 2023-01-03  142  
9223ba771533395 Benjamin Gaignard 2023-01-03  143  static int rockchip_vpu981_av1_dec_frame_ref(struct hantro_ctx *ctx,
9223ba771533395 Benjamin Gaignard 2023-01-03  144  					     u64 timestamp)
9223ba771533395 Benjamin Gaignard 2023-01-03  145  {
9223ba771533395 Benjamin Gaignard 2023-01-03  146  	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
9223ba771533395 Benjamin Gaignard 2023-01-03  147  	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
9223ba771533395 Benjamin Gaignard 2023-01-03  148  	const struct v4l2_ctrl_av1_frame *frame = ctrls->frame;
9223ba771533395 Benjamin Gaignard 2023-01-03  149  	int i;
9223ba771533395 Benjamin Gaignard 2023-01-03  150  
9223ba771533395 Benjamin Gaignard 2023-01-03  151  	for (i = 0; i < AV1_MAX_FRAME_BUF_COUNT; i++) {
9223ba771533395 Benjamin Gaignard 2023-01-03  152  		if (!av1_dec->frame_refs[i].used) {
9223ba771533395 Benjamin Gaignard 2023-01-03  153  			int j;
9223ba771533395 Benjamin Gaignard 2023-01-03  154  
9223ba771533395 Benjamin Gaignard 2023-01-03  155  			av1_dec->frame_refs[i].width =
9223ba771533395 Benjamin Gaignard 2023-01-03  156  			    frame->frame_width_minus_1 + 1;
9223ba771533395 Benjamin Gaignard 2023-01-03  157  			av1_dec->frame_refs[i].height =
9223ba771533395 Benjamin Gaignard 2023-01-03  158  			    frame->frame_height_minus_1 + 1;
9223ba771533395 Benjamin Gaignard 2023-01-03  159  			av1_dec->frame_refs[i].mi_cols =
9223ba771533395 Benjamin Gaignard 2023-01-03  160  			    DIV_ROUND_UP(frame->frame_width_minus_1 + 1, 8);
9223ba771533395 Benjamin Gaignard 2023-01-03  161  			av1_dec->frame_refs[i].mi_rows =
9223ba771533395 Benjamin Gaignard 2023-01-03  162  			    DIV_ROUND_UP(frame->frame_height_minus_1 + 1, 8);
9223ba771533395 Benjamin Gaignard 2023-01-03  163  			av1_dec->frame_refs[i].timestamp = timestamp;
9223ba771533395 Benjamin Gaignard 2023-01-03  164  			av1_dec->frame_refs[i].frame_type = frame->frame_type;
9223ba771533395 Benjamin Gaignard 2023-01-03  165  			av1_dec->frame_refs[i].order_hint = frame->order_hint;
9223ba771533395 Benjamin Gaignard 2023-01-03  166  			av1_dec->frame_refs[i].gm_mode =
9223ba771533395 Benjamin Gaignard 2023-01-03 @167  				frame->global_motion.type[V4L2_AV1_REF_LAST_FRAME + i];
9223ba771533395 Benjamin Gaignard 2023-01-03  168  			if (!av1_dec->frame_refs[i].vb2_ref)
9223ba771533395 Benjamin Gaignard 2023-01-03  169  				av1_dec->frame_refs[i].vb2_ref = hantro_get_dst_buf(ctx);
9223ba771533395 Benjamin Gaignard 2023-01-03  170  
9223ba771533395 Benjamin Gaignard 2023-01-03  171  			for (j = 0; j < V4L2_AV1_TOTAL_REFS_PER_FRAME; j++)
9223ba771533395 Benjamin Gaignard 2023-01-03  172  				av1_dec->frame_refs[i].order_hints[j] = frame->order_hints[j];
9223ba771533395 Benjamin Gaignard 2023-01-03  173  
9223ba771533395 Benjamin Gaignard 2023-01-03  174  			av1_dec->frame_refs[i].used = true;
9223ba771533395 Benjamin Gaignard 2023-01-03  175  			av1_dec->current_frame_index = i;
9223ba771533395 Benjamin Gaignard 2023-01-03  176  			return i;
9223ba771533395 Benjamin Gaignard 2023-01-03  177  		}
9223ba771533395 Benjamin Gaignard 2023-01-03  178  	}
9223ba771533395 Benjamin Gaignard 2023-01-03  179  
9223ba771533395 Benjamin Gaignard 2023-01-03  180  	return AV1_INVALID_IDX;
9223ba771533395 Benjamin Gaignard 2023-01-03  181  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

