Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83AD6E024B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 01:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDLXH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 19:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDLXHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 19:07:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01783F8;
        Wed, 12 Apr 2023 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7HhdItHAdBJmzHTfScdmkqFlRVS7ZJYIvKVZxWllbFs=; b=c/bWin99hoForEDgQPu1N4UZ4Y
        hBduKaO0LsfpESU/IMcijRkepfGBTxWY0HBPfNVbAPlAw0shj6Ib6g4cbFeq0yy4EoM+ZNoYkZpDs
        CjtxHuNMmmRCL4caf7ZxJNp1rEonD/fyg6gPaeJ0Pagjl226Si0kLPJCi3wHtCctWaw78BSY/lBe9
        59cVGuJ565MxSAt2wHXfjSNsOSjCQyY8uPp+KdHghPELTPPeEulhX4YLCKDsJhxSV8QX+gln5NQHn
        vuk8ILybfVXDjzJhz6RkScRdV/CR675gkW8KRDGTfjwTbTNDIkN7iWLzcK016chE2K2//+sZA9/p+
        c2vvkq3Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmjYc-004bMr-2J;
        Wed, 12 Apr 2023 23:07:18 +0000
Message-ID: <2ecbfefe-10bc-4abc-eb07-e0f14229eb1a@infradead.org>
Date:   Wed, 12 Apr 2023 16:07:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dma-buf/sync_file: Fix doc build warning
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hackmann <ghackmann@google.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230330142720.882045-1-robdclark@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230330142720.882045-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 07:27, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Fixes warning:
> 
>   include/uapi/linux/sync_file.h:77: warning: Function parameter or member 'num_fences' not described in 'sync_file_info'
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 2d75c88fefb2 ("staging/android: refactor SYNC IOCTLs")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/uapi/linux/sync_file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
> index d61752dca4c6..ff1f38889dcf 100644
> --- a/include/uapi/linux/sync_file.h
> +++ b/include/uapi/linux/sync_file.h
> @@ -56,7 +56,7 @@ struct sync_fence_info {
>   * @name:	name of fence
>   * @status:	status of fence. 1: signaled 0:active <0:error
>   * @flags:	sync_file_info flags
> - * @num_fences	number of fences in the sync_file
> + * @num_fences:	number of fences in the sync_file
>   * @pad:	padding for 64-bit alignment, should always be zero
>   * @sync_fence_info: pointer to array of struct &sync_fence_info with all
>   *		 fences in the sync_file

-- 
~Randy
