Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4671028D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjEYBws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEYBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:52:46 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C19B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:52:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjQ-SMm_1684979561;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VjQ-SMm_1684979561)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 09:52:42 +0800
Message-ID: <1684979484.282963-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Date:   Thu, 25 May 2023 09:51:24 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), mst@redhat.com
References: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
In-Reply-To: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 20:36:12 +0800, Rong Tao <rtoax@foxmail.com> wrote:
> From: Rong Tao <rongtao@cestc.cn>
>
> Ignore executions for ringtest.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Is this the resend mail? Or a new version?

I replyed to your last mail.

THanks.


> ---
>  tools/virtio/ringtest/.gitignore | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/virtio/ringtest/.gitignore
>
> diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
> new file mode 100644
> index 000000000000..100b9e30c0f4
> --- /dev/null
> +++ b/tools/virtio/ringtest/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +/noring
> +/ptr_ring
> +/ring
> +/virtio_ring_0_9
> +/virtio_ring_inorder
> +/virtio_ring_poll
> --
> 2.39.1
>
>
