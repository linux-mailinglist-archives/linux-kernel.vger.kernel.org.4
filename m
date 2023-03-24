Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD55A6C76C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCXFBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXFBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:01:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB7322790;
        Thu, 23 Mar 2023 22:01:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so3287197edb.6;
        Thu, 23 Mar 2023 22:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679634074;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjRWCU/VLQErX2z0uvL/aL2jDlqWYNpnjGy6qbEOGGE=;
        b=AV4afuHsts3hAqNjn+9LdAhIgZ+Zdmq1EJCCmlG/TdZACcSB8wehdUwVsHhv/Dopjp
         RTph8NS7MUsrtZ+Ev++hdhIOfeWehOCfOIUWSVtYW+uK0vaIPqUYPxuffx6LMoIXSNOz
         5SaDg2awjB3Bdo2P0vjaJHPPrMIRZIaUZnRD1Vfpb69yaq96zT/2rXIpk2EvucvO+aNV
         HBT40USzBCx+QgLCahLeo9aFpJ+igenZMfPloCpeBZK3bUsAfR+2LFmLSJ/EuHxaBLDk
         bGbsEr6dFrTrDeMWRxE69GUfgXTX4AJXn6YIuA7BWne11xTaWAPULAXH/wzrufLxu+i0
         dxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679634074;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjRWCU/VLQErX2z0uvL/aL2jDlqWYNpnjGy6qbEOGGE=;
        b=0nsRnMePvc7bP9DrlNeIoiJIiQMPFXJzUxAvMZ3/ZyqIy9BOPY3As5lQW3gUuDkqpL
         6LrF97UTlrQ4mHKPbcLURA3xsgg8XPb5Il+TxLl4qakPKfn0om7G3bd83C5lz0R06GM8
         988daSRnkSQEoisYTlghYWvHNB9jBev4N77JkrmrnqqqEfNMDwnkTxQW1FS17UAJmqG4
         C4b2yAjaPsjx5o9Eeu6o0XK/NPO7mtUMx0l9mmCYSO5FWv35YDjG/QNMQvO7mJ2MRAch
         SEKCkiw9utTPLLtDUA9RRXpmcRXI8x5mThud/1MQG5aXD8MQpFrxSK+YyIYcl+WTb1eo
         HFag==
X-Gm-Message-State: AAQBX9dbHDv+gkOnmYtedonxEc/hz/i58asQ/BwlMERhCwsnLW2l0UNl
        t5OdQUiUcNDPSdtxM2DCk4tMfHFy0mwIIw==
X-Google-Smtp-Source: AKy350Z6AhniQxuCsI+BdYd/geEC5/fUia7TructKG3W3ffPTO5hgdA9jsSFB3KZs+E/YxUvVP/DzA==
X-Received: by 2002:a05:6402:1503:b0:4fd:2b0e:ce87 with SMTP id f3-20020a056402150300b004fd2b0ece87mr1438213edw.24.1679634073874;
        Thu, 23 Mar 2023 22:01:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c24-20020a50d658000000b00501d5432f2fsm5249889edj.60.2023.03.23.22.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:01:13 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:01:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jernel@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic
 allocated
Message-ID: <4e2cb832-de83-4ba6-bd8a-119a19038cfe@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321102855.346732-3-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230321-183154
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230321102855.346732-3-benjamin.gaignard%40collabora.com
patch subject: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic allocated
config: arm64-randconfig-m041-20230319 (https://download.01.org/0day-ci/archive/20230324/202303240148.lKRnUqW9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303240148.lKRnUqW9-lkp@intel.com/

smatch warnings:
include/media/videobuf2-core.h:1272 vb2_queue_add_buffer() warn: sleeping in atomic context
drivers/media/common/videobuf2/videobuf2-core.c:2456 vb2_core_queue_init() warn: Please consider using kcalloc instead of kmalloc_array

vim +1272 include/media/videobuf2-core.h

625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1263  static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1264  {
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1265  	bool ret = false;
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1266  
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1267  	spin_lock(&q->bufs_lock);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^
Holding a spin lock.

487d3f14d12ecf Benjamin Gaignard 2023-03-21  1268  
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1269  	if (vb->index >= q->max_num_bufs) {
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1270  		struct vb2_buffer **tmp;
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1271  
487d3f14d12ecf Benjamin Gaignard 2023-03-21 @1272  		tmp = krealloc_array(q->bufs, q->max_num_bufs * 2, sizeof(*q->bufs), GFP_KERNEL);
                                                                                                                                     ^^^^^^^^^^
Sleeping allocation.  GFP_ATOMIC?  Or is there a way to move the
allocation outside the lock?

487d3f14d12ecf Benjamin Gaignard 2023-03-21  1273  		if (!tmp)
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1274  			goto realloc_failed;
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1275  
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1276  		q->max_num_bufs *= 2;
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1277  		q->bufs = tmp;
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1278  	}
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1279  
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1280  	if (vb->index < q->max_num_bufs) {
625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1281  		q->bufs[vb->index] = vb;
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1282  		ret = true;
625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1283  	}
625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1284  
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1285  realloc_failed:
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1286  	spin_unlock(&q->bufs_lock);
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1287  
487d3f14d12ecf Benjamin Gaignard 2023-03-21  1288  	return ret;
625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1289  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

