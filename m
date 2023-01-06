Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8965FC9E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjAFIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFIXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:23:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F5631B5;
        Fri,  6 Jan 2023 00:23:02 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:52f4:db34:c2f0:4d75] (unknown [IPv6:2a01:e0a:120:3210:52f4:db34:c2f0:4d75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53B2C6602D05;
        Fri,  6 Jan 2023 08:23:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672993380;
        bh=vAbwKXZOJip0G6a4yIO6tOXf4HycylFNKhbnhzsdbMU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IqnxTc2BEOyZ4I2QqXLh4/Akk+wekLf1cAMGp4vddn07ZruuijwS2NSLqexLDthYK
         VAVNaKiHicprDrfg2VfeCHQax8xGG5WL2shv+yNvL1eip/CUboUCaSuK1PhzT7nDZJ
         pbzUymBpOav9wt6abcp4cxP3hCYxwh+DAjFdcKRpkxllj+6HGbKA4e1G+rMpjxjoGS
         qheoXTb6MnL+sc2ru6TSt3fuZUe1udLAyhNBTDGLY5yZYjOIgxGMzUC7x/yjMi6btT
         wHPMXscaKVaT4DaHsL6suQwY2rXza8maognUAGxWEmC8/00uAbaPwuHl5tFdThma7/
         vORfq//kHvUnA==
Message-ID: <502dd378-db76-fbe0-c922-c0b3761e5eb8@collabora.com>
Date:   Fri, 6 Jan 2023 09:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/13] media: verisilicon: Add Rockchip AV1 decoder
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <202301060326.FJvy51O1-lkp@intel.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <202301060326.FJvy51O1-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 06/01/2023 à 08:33, Dan Carpenter a écrit :
> Hi Benjamin,
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/dt-bindings-media-rockchip-vpu-Add-rk3588-vpu-compatible/20230104-010906
> base:   git://linuxtv.org/media_tree.git master
> patch link:    https://lore.kernel.org/r/20230103170058.810597-11-benjamin.gaignard%40collabora.com
> patch subject: [PATCH v2 10/13] media: verisilicon: Add Rockchip AV1 decoder
> config: ia64-randconfig-m041-20230101
> compiler: ia64-linux-gcc (GCC) 12.1.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
>
> smatch warnings:
> drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:121 rockchip_vpu981_get_frame_index() error: buffer overflow 'frame->reference_frame_ts' 8 <= 8
> drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:167 rockchip_vpu981_av1_dec_frame_ref() error: buffer overflow 'frame->global_motion.type' 8 <= 9
> drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:1947 rockchip_vpu981_av1_dec_run() warn: missing error code 'ret'
>
> vim +121 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>
> 9223ba771533395 Benjamin Gaignard 2023-01-03  109
> 9223ba771533395 Benjamin Gaignard 2023-01-03  110  static int rockchip_vpu981_get_frame_index(struct hantro_ctx *ctx, int ref)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  111  {
> 9223ba771533395 Benjamin Gaignard 2023-01-03  112  	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  113  	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  114  	const struct v4l2_ctrl_av1_frame *frame = ctrls->frame;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  115  	u64 timestamp;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  116  	int i, idx = frame->ref_frame_idx[ref];
> 9223ba771533395 Benjamin Gaignard 2023-01-03  117
> 9223ba771533395 Benjamin Gaignard 2023-01-03  118  	if (idx >= AV1_MAX_FRAME_BUF_COUNT || idx < 0)
>                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Should this be V4L2_AV1_TOTAL_REFS_PER_FRAME?

Yes it should be.
I will fix that and the other warnings in v3.

Thanks,
Benjamin

>
> 9223ba771533395 Benjamin Gaignard 2023-01-03  119  		return AV1_INVALID_IDX;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  120
> 9223ba771533395 Benjamin Gaignard 2023-01-03 @121  	timestamp = frame->reference_frame_ts[idx];
>                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>
> 9223ba771533395 Benjamin Gaignard 2023-01-03  122  	for (i = 0; i < AV1_MAX_FRAME_BUF_COUNT; i++) {
> 9223ba771533395 Benjamin Gaignard 2023-01-03  123  		if (!av1_dec->frame_refs[i].used)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  124  			continue;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  125  		if (av1_dec->frame_refs[i].timestamp == timestamp)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  126  			return i;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  127  	}
> 9223ba771533395 Benjamin Gaignard 2023-01-03  128
> 9223ba771533395 Benjamin Gaignard 2023-01-03  129  	return AV1_INVALID_IDX;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  130  }
> 9223ba771533395 Benjamin Gaignard 2023-01-03  131
> 9223ba771533395 Benjamin Gaignard 2023-01-03  132  static int rockchip_vpu981_get_order_hint(struct hantro_ctx *ctx, int ref)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  133  {
> 9223ba771533395 Benjamin Gaignard 2023-01-03  134  	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  135  	int idx = rockchip_vpu981_get_frame_index(ctx, ref);
> 9223ba771533395 Benjamin Gaignard 2023-01-03  136
> 9223ba771533395 Benjamin Gaignard 2023-01-03  137  	if (idx != AV1_INVALID_IDX)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  138  		return av1_dec->frame_refs[idx].order_hint;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  139
> 9223ba771533395 Benjamin Gaignard 2023-01-03  140  	return 0;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  141  }
> 9223ba771533395 Benjamin Gaignard 2023-01-03  142
> 9223ba771533395 Benjamin Gaignard 2023-01-03  143  static int rockchip_vpu981_av1_dec_frame_ref(struct hantro_ctx *ctx,
> 9223ba771533395 Benjamin Gaignard 2023-01-03  144  					     u64 timestamp)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  145  {
> 9223ba771533395 Benjamin Gaignard 2023-01-03  146  	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  147  	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  148  	const struct v4l2_ctrl_av1_frame *frame = ctrls->frame;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  149  	int i;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  150
> 9223ba771533395 Benjamin Gaignard 2023-01-03  151  	for (i = 0; i < AV1_MAX_FRAME_BUF_COUNT; i++) {
> 9223ba771533395 Benjamin Gaignard 2023-01-03  152  		if (!av1_dec->frame_refs[i].used) {
> 9223ba771533395 Benjamin Gaignard 2023-01-03  153  			int j;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  154
> 9223ba771533395 Benjamin Gaignard 2023-01-03  155  			av1_dec->frame_refs[i].width =
> 9223ba771533395 Benjamin Gaignard 2023-01-03  156  			    frame->frame_width_minus_1 + 1;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  157  			av1_dec->frame_refs[i].height =
> 9223ba771533395 Benjamin Gaignard 2023-01-03  158  			    frame->frame_height_minus_1 + 1;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  159  			av1_dec->frame_refs[i].mi_cols =
> 9223ba771533395 Benjamin Gaignard 2023-01-03  160  			    DIV_ROUND_UP(frame->frame_width_minus_1 + 1, 8);
> 9223ba771533395 Benjamin Gaignard 2023-01-03  161  			av1_dec->frame_refs[i].mi_rows =
> 9223ba771533395 Benjamin Gaignard 2023-01-03  162  			    DIV_ROUND_UP(frame->frame_height_minus_1 + 1, 8);
> 9223ba771533395 Benjamin Gaignard 2023-01-03  163  			av1_dec->frame_refs[i].timestamp = timestamp;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  164  			av1_dec->frame_refs[i].frame_type = frame->frame_type;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  165  			av1_dec->frame_refs[i].order_hint = frame->order_hint;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  166  			av1_dec->frame_refs[i].gm_mode =
> 9223ba771533395 Benjamin Gaignard 2023-01-03 @167  				frame->global_motion.type[V4L2_AV1_REF_LAST_FRAME + i];
> 9223ba771533395 Benjamin Gaignard 2023-01-03  168  			if (!av1_dec->frame_refs[i].vb2_ref)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  169  				av1_dec->frame_refs[i].vb2_ref = hantro_get_dst_buf(ctx);
> 9223ba771533395 Benjamin Gaignard 2023-01-03  170
> 9223ba771533395 Benjamin Gaignard 2023-01-03  171  			for (j = 0; j < V4L2_AV1_TOTAL_REFS_PER_FRAME; j++)
> 9223ba771533395 Benjamin Gaignard 2023-01-03  172  				av1_dec->frame_refs[i].order_hints[j] = frame->order_hints[j];
> 9223ba771533395 Benjamin Gaignard 2023-01-03  173
> 9223ba771533395 Benjamin Gaignard 2023-01-03  174  			av1_dec->frame_refs[i].used = true;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  175  			av1_dec->current_frame_index = i;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  176  			return i;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  177  		}
> 9223ba771533395 Benjamin Gaignard 2023-01-03  178  	}
> 9223ba771533395 Benjamin Gaignard 2023-01-03  179
> 9223ba771533395 Benjamin Gaignard 2023-01-03  180  	return AV1_INVALID_IDX;
> 9223ba771533395 Benjamin Gaignard 2023-01-03  181  }
>
