Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396336D7FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbjDEOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbjDEOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:45:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DEA6EA9;
        Wed,  5 Apr 2023 07:45:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y15so46956846lfa.7;
        Wed, 05 Apr 2023 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680705930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOxxZY9RNn9bm4yf3kFSibCqB8hmwqKXKidGV7ApoK4=;
        b=OzkZGfkA5d8e2CNUH50innVfzRwjTOxllQpvyDJ5y5Q52zk5H+nMgEeCR+XHX73wox
         zDJb6IqwCHi7Ww0JqKaDVuUnOxEvqj7XchoaiL9XVnpX54WgXF49uhhpN9/Au+A7nRJ4
         Ftw8MTdxkgzHICDGfhDT0/LBsC8+wy8FdvNg881/UisFvOTbFx0BoBdXb0sImTGJDKeu
         vtkpH2BYIACCm2AgIhLGDAlEvG/ZTnbNy2kyj9VECyEwZ967CIH7eDFfP7yD8jusLdtS
         xytX+93yCVI8OpS6XokOpKJyVdMfduTAD2g88k+t1/ClSuuW0R9fwIT38x775apae7N1
         we2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680705930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOxxZY9RNn9bm4yf3kFSibCqB8hmwqKXKidGV7ApoK4=;
        b=OG71N7YO6hTRkWatGbR4OFw3Y5OANVR0GG8J1CnDF8PCBajSI31+FNXCmVs/cjTktG
         F3tbKlIQfcKOBo4qn/Lm1NysTFmM+8OYCwrWE6mwaCldQnZc7RivF3/vesgb12KT2i9o
         apSLmZs+7ERXNnAYyUWnnOG6OIw3AA9DGW64glH6283wohZdBqJJL29U3tMq71ZVxpY8
         CSPn8Rg05v3YRnYduIp3EwlAdUWxKXsMvFis3VUTTSWsqEcUdWRCROKfNwPSD08JcJ8T
         zlDEhV5kDi6pk9MTQ67AdgaPrlrt95xD6YhTeYsZDYcnpO/GL96R1MZWUA5iMuXpqg2F
         SPOg==
X-Gm-Message-State: AAQBX9cNuQAH5HHMF4wVB1REM2B/cPbHmOJJl9/1Ocb/fRSg5trmk2ly
        +kvjzu/nDBpM/OFS/Gc7aW4=
X-Google-Smtp-Source: AKy350YI+jV9h17L+DW0ttvweanabNwf05OXkKzgcExo8wB/m7FcseRZ3JtcGenPHSDozbsR+fhNYQ==
X-Received: by 2002:a05:6512:141:b0:4e8:1798:f9e1 with SMTP id m1-20020a056512014100b004e81798f9e1mr1482090lfo.57.1680705930218;
        Wed, 05 Apr 2023 07:45:30 -0700 (PDT)
Received: from pc636 (host-90-233-209-177.mobileonline.telia.com. [90.233.209.177])
        by smtp.gmail.com with ESMTPSA id h13-20020a19700d000000b004eb353132f5sm2431109lfc.122.2023.04.05.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:45:29 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 5 Apr 2023 16:45:27 +0200
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/kvfree: Invoke debug_rcu_bhead_unqueue() with check
 bnode->snap is done
Message-ID: <ZC2Jh6CaeHHpkWLW@pc636>
References: <20230405021359.606321-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405021359.606321-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 10:13:59AM +0800, Zqiang wrote:
> This commit make debug_rcu_bhead_unqueue() be invoked with check
> the bnode structure's->snap is done in kvfree_rcu_bulk().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3461fc2640b9..17b5d115aec1 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2943,8 +2943,8 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
>  	unsigned long flags;
>  	int i;
>  
> -	debug_rcu_bhead_unqueue(bnode);
>  	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
> +		debug_rcu_bhead_unqueue(bnode);
>  		rcu_lock_acquire(&rcu_callback_map);
>  		if (idx == 0) { // kmalloc() / kfree().
>  			trace_rcu_invoke_kfree_bulk_callback(
> -- 
> 2.32.0
>
Since we leak, looks like correct to me:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
