Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BF63A116
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK1GQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiK1GQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:16:29 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0ED10567
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:16:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVoOaBy_1669616184;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VVoOaBy_1669616184)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 14:16:25 +0800
Message-ID: <1669616174.7244327-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] tools/virtio: remove stray characters
Date:   Mon, 28 Nov 2022 14:16:14 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com
References: <20221128034347.990-1-dave@stgolabs.net>
 <20221128034347.990-2-dave@stgolabs.net>
In-Reply-To: <20221128034347.990-2-dave@stgolabs.net>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2022 19:43:46 -0800, Davidlohr Bueso <dave@stgolabs.net> wrote:
> __read_once_size() is not a macro, remove those '/'s.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  tools/virtio/ringtest/main.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
> index 6d1fccd3d86c..9ed09caa659e 100644
> --- a/tools/virtio/ringtest/main.h
> +++ b/tools/virtio/ringtest/main.h
> @@ -149,16 +149,16 @@ static inline void busy_wait(void)
>  static __always_inline
>  void __read_once_size(const volatile void *p, void *res, int size)
>  {
> -        switch (size) {                                                 \
> -        case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;              \
> -        case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;            \
> -        case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;            \
> -        case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;            \
> -        default:                                                        \
> -                barrier();                                              \
> -                __builtin_memcpy((void *)res, (const void *)p, size);   \
> -                barrier();                                              \
> -        }                                                               \
> +	switch (size) {
> +	case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;
> +	case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;
> +	case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;
> +	case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;
> +	default:
> +		barrier();
> +		__builtin_memcpy((void *)res, (const void *)p, size);
> +		barrier();
> +	}
>  }
>
>  static __always_inline void __write_once_size(volatile void *p, void *res, int size)
> --
> 2.38.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
