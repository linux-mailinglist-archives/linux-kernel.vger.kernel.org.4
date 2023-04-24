Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56286ED3D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjDXRnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjDXRnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A935C72B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D4D61C4F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 17:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4097C433EF;
        Mon, 24 Apr 2023 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682358219;
        bh=LCu1z2foNofLVVx12LIuTMFiH/53gIBxbTwTF1jRmwc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qM9uTmL/8n1DrwVgKgxtv1jCdG9D3f8UbQ3B6Jtikwk+M8gji1dBZNjBd+e3j1Pjl
         p1BQUC4mmoQlMC0EKyomwvIND6uuio1MxN7cEphezmkjHjqKdmaNO3wZ+ayQaiuzfC
         /hbaV6fATpJ0X6yTnf63sLKiGU1WUmfTiuMKQQTXZjhRDQchXlefkkQ9mdH2PCEa66
         dlVkF0A3a4SW1LGxMaPGQYFmSjZ1eKSFXNWxkI2LkEBeknnuLNfUMkEH+TS81b1JZX
         tRRHFtr5m3MtGUx2s/tGVs6UISAVi888kMsDCGlWUshAULIFIRSiDkbUeoeUS8TVqV
         8st4MhSOJJpww==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 323C615404E7; Mon, 24 Apr 2023 10:43:39 -0700 (PDT)
Date:   Mon, 24 Apr 2023 10:43:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/slab: add a missing semicolon on
 SLAB_TYPESAFE_BY_RCU example code
Message-ID: <21cd0c00-4738-49f7-899f-ec3792520bfb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230415033159.4249-1-sj@kernel.org>
 <20230415033159.4249-2-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415033159.4249-2-sj@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 03:31:58AM +0000, SeongJae Park wrote:
> An example code snippet for SLAB_TYPESAFE_BY_RCU is missing a semicolon.
> Add it.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Or please let me know if you would like me to take it.  (Probably better
going up through the usual slab route, though.)

							Thanx, Paul

> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index f8b1d63c63a3..b18e56c6f06c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -53,7 +53,7 @@
>   * stays valid, the trick to using this is relying on an independent
>   * object validation pass. Something like:
>   *
> - *  rcu_read_lock()
> + *  rcu_read_lock();
>   * again:
>   *  obj = lockless_lookup(key);
>   *  if (obj) {
> -- 
> 2.25.1
> 
