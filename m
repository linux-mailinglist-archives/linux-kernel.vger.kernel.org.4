Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F726DEC06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDLGpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDEEF0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59EC962A4B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A87CC433D2;
        Wed, 12 Apr 2023 06:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681281907;
        bh=aiQNM/97bmUXgS5XFHqTPDiqeyhbGdwSHXUiXu9v6Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsHRkyonhUag2Cv/qcDKVBYfbbGwnRgZUd2W1d6KSdBvp9B4xpG/zb6hgcl68zTDw
         s6txxg6N+PITAbhNm4qKXA+e7SGSL8a+Kc+1qdVQDNXre68GwTQr/tUHDPyE8ZaFyJ
         eENYdywDi5vqSAqq2XItUYpK+YxBgqZH6NdAH0z0=
Date:   Wed, 12 Apr 2023 08:45:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuang Zhang <zhangchuang1909@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        zhangchuang3 <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] BINDER:Allow tracing of binder_txn_latency_free
Message-ID: <2023041204-outreach-oppose-b2a3@gregkh>
References: <20230412033332.342521-1-zhangchuang1909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412033332.342521-1-zhangchuang1909@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:33:32AM +0800, Chuang Zhang wrote:
> From: zhangchuang3 <zhangchuang3@xiaomi.com>
> 
> The author forgot to EXPORT and need Export
> binder_txn_latency_free trace point.
> 
> Signed-off-by: zhangchuang3 <zhangchuang3@xiaomi.com>

I doubt you sign documents as "zhangchuang3", please always just use
your name, not your email alias.

And as this is coming from a gmail account, I can't ferify that this
really is an xiaomi.com address, why not just use your company address?

> ---
>  drivers/android/binder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index fb56bfc45096..320cf08805d4 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6604,5 +6604,6 @@ device_initcall(binder_init);
>  
>  #define CREATE_TRACE_POINTS
>  #include "binder_trace.h"
> +EXPORT_TRACEPOINT_SYMBOL_GPL(binder_txn_latency_free);

What in-kernel code needs this?

thanks,

greg k-h
