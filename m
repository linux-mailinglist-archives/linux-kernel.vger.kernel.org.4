Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2B6020AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJRB6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJRB5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:57:55 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509F792C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:57:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t25so7870719qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYBybDD0u6tBbkRf/y6+33fBQuf81SuzZ3qkKShzqXo=;
        b=p+dXBnaxZehl4mOjVDpE2yLZ0KftYMUKql3vXjTCmM8Z+qHqGelLFBsl9c0/m4hOrl
         10I2LqYvX8mu5Bh6o5k5XOhpC2x8WEZsB9GyTBYNnNR0xFDvxyPRi9xc0reVAKLB8bkI
         O9BV/ExKagQ+2zvxw4NxT9nboJpr/FC/I6nAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYBybDD0u6tBbkRf/y6+33fBQuf81SuzZ3qkKShzqXo=;
        b=t1uU3H1e3oIPJQ7i1GdFk4S8UqMbVxdLqc8VtO3zGw8lLxVFojXm+xW0BcayX7YVUF
         QxP3iFYWXd27r5KxqpIH5MgjM6FCNANRYDfCdjk1MRJRoeP+m0SxDFGV7bv5EZZOrJos
         Js/A+AQ0zTLwgpgUTSnXcUUApXwaMa/uAKSekIFFo1u5Bs3Izf2IBvcBmegx/rdsXaBX
         7atoPSdat3kPyEYT7b/Gn1uzUWyBKy2vMbgeiKRCSiXwSDk1Re7O3R1Ee1go8QMiymMW
         U5jcA7SYhmIg6HxfgS+wD8iwVTed58N0dFfErhGcOLRH98SIi+E4BM5uUXmLc4UCUEZ4
         QTog==
X-Gm-Message-State: ACrzQf1YgqFtQRHfWPOcy2vnRxGxLwQBI8xd0pZpAIUvotUfa8QYurdn
        WVxTNbkBdGyKNRtcjnrLiYirzg==
X-Google-Smtp-Source: AMsMyM7H8PCmJN/9txCa9cXhPqnjtQrTU1FftHwRYLb3DfXTYtJFyyFGrYYqrEaG3KfahdnzGa+BqA==
X-Received: by 2002:ae9:ef04:0:b0:6ea:adcf:4c02 with SMTP id d4-20020ae9ef04000000b006eaadcf4c02mr345852qkg.779.1666058265413;
        Mon, 17 Oct 2022 18:57:45 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bp17-20020a05620a459100b006ce3f1af120sm1275114qkb.44.2022.10.17.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 18:57:45 -0700 (PDT)
Date:   Tue, 18 Oct 2022 01:57:44 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
Message-ID: <Y04IGLudV7tYORUd@google.com>
References: <20221018013906.3890007-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018013906.3890007-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:39:06AM +0800, Zqiang wrote:
> When enable CONFIG_PROVE_RCU and built modules, the following
> error appear:
> 
> ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
> ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
> 
> This commit fix it by exporting the srcu_check_nmi_safety().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/rcu/srcutree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 382236dd5e46..bcd629f5f902 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -651,6 +651,7 @@ void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
>  	}
>  	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
>  }
> +EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
>  #endif /* CONFIG_PROVE_RCU */
>  
>  /*
> -- 
> 2.25.1
> 
