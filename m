Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394FB5E8C04
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiIXL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiIXL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55216A47B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6892612AE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3101C433C1;
        Sat, 24 Sep 2022 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664020776;
        bh=axbyS8YAM4QQSY1yS3FTgI/u3Ns113h/lqMf58freK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRuFzaPtjqruAjQ6LAxwG+Y3t00sAVYnS5GQeMR1c9M9Nw6lwql8/n4at8NFf7i00
         ltPXuCCjdrk/rBtgcD0vwLTKC4eW3lK4h85dFVC3vjkVH1YX+euCEC7ggVGYJQB7D+
         KUGVdawSgMaKtBGA5kymwy6whH/72U06bucqn17s=
Date:   Sat, 24 Sep 2022 13:59:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: Remove duplicate include
Message-ID: <Yy7xJQ0hcMBD61FH@kroah.com>
References: <20220909091504.4255-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909091504.4255-1-hanyihao@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:15:03AM -0700, Yihao Han wrote:
> Fix following checkinclude.pl warning:
>  ./drivers/base/node.c: linux/hugetlb.h is included more than once.
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  drivers/base/node.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 80b1e91b9608..cf115d5a9b8a 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -20,7 +20,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> -#include <linux/hugetlb.h>
>  
>  static struct bus_type node_subsys = {
>  	.name = "node",
> -- 
> 2.17.1
> 

Yous subject line is not correct, please be more careful.
