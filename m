Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B996A32C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBZQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:23:46 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C1DEB40
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:23:45 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id cf14so4333939qtb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcpRif0/nyISXGZBTlI6XTPUCNr7MqrEsC0iU84mP18=;
        b=kuxN9hYINaVZbF8I0GOUxZpb33zSs9DbhFz6ccdhT6v5oqtMAoQ4E65VxW9RCedJf1
         k8A4CVUMzBSw25r7uO80v4exlpTOfSrgEdiq3Ai0/YTkvlgOjf1IxoagQ+3ZbeoOwzUO
         rdB4COEV2Ex3zLRo7SitfIAp+BtLBroWy5t/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcpRif0/nyISXGZBTlI6XTPUCNr7MqrEsC0iU84mP18=;
        b=NSi6jHW8AmjuEkBCJN+Iq1tjlDY2hLjURD+DwrUjnVB2Zdm2BhnRdOqlGRpjxPxXtx
         DhuaTVsRDeDoTehWAF0RoP9Z0hP23x0aDOFDyzfkj6KqkPJb/FQfZrHyUhQL95uXo0w8
         Jr7yPS8xXnaIif+Uwk1wCez/rDzUDim7N1mD8K4b26vCmO47LCExz5po8Rv4vcSgIzSA
         1+G9B9MSIulXESbW1HUzNHvoRb3ma+d1/MrHEMtnWc+WVJcAAz93c5y8J+uXj6wtHNxJ
         4W08mPSETo3CkSfRJKXp1b7vpCopOWdxccjlmQrvybnYw23O7bls+SPOobb9vLwVLsR8
         ZA5g==
X-Gm-Message-State: AO0yUKU70mLZzIFW5JbBajQGi50unT/voIwrRPUYR1eYyfumrLAZIOFl
        +9M5PnjC59taN9dXPc88Z/ijYw==
X-Google-Smtp-Source: AK7set9e1aTZzywk1H7dfnFtWZ5TCRoKhCgXdwBK/XBW0edsIuW3lQlcWHwDsvQZAkkzY6sN6o6SGw==
X-Received: by 2002:a05:622a:14d:b0:3af:4d45:b73 with SMTP id v13-20020a05622a014d00b003af4d450b73mr37089461qtw.33.1677428624463;
        Sun, 26 Feb 2023 08:23:44 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id l22-20020ac84596000000b003b9e1d3a502sm3146609qtn.54.2023.02.26.08.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 08:23:43 -0800 (PST)
Date:   Sun, 26 Feb 2023 16:23:42 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/uHjpbJ3JmVAe9d@google.com>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:52:51PM +0100, Jonas Oberhauser wrote:
> As stated in the documentation and implied by its name, the ppo
> (preserved program order) relation is intended to link po-earlier
> to po-later instructions under certain conditions.  However, a
> corner case currently allows instructions to be linked by ppo that
> are not executed by the same thread, i.e., instructions are being
> linked that have no po relation.
> 
> This happens due to the mb/strong-fence/fence relations, which (as
> one case) provide order when locks are passed between threads
> followed by an smp_mb__after_unlock_lock() fence.  This is
> illustrated in the following litmus test (as can be seen when using
> herd7 with `doshow ppo`):
> 
> P0(int *x, int *y)
> {
>     spin_lock(x);
>     spin_unlock(x);
> }
> 
> P1(int *x, int *y)
> {
>     spin_lock(x);
>     smp_mb__after_unlock_lock();
>     *y = 1;
> }
> 
> The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
> P0 passes a lock to P1 which then uses this fence.
> 
> The patch makes ppo a subrelation of po by letting fence contribute
> to ppo only in case the fence links events of the same thread.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>  tools/memory-model/linux-kernel.cat | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index cfc1b8fd46da..adf3c4f41229 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -82,7 +82,7 @@ let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
>  let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
> -let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
> +let ppo = to-r | to-w | (fence & int) | (po-unlock-lock-po & int)

Alternatively can be the following appended diff? Requires only single 'int'
in ->ppo then and prevents future similar issues caused by sub relations.
Also makes clear that ->ppo can only be CPU-internal.

Or would that not work for some reason? For the test you shared at least, the
graphs are the same.

Either way:

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---8<-----------------------

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 07f884f9b2bf..63052d1628e9 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -70,7 +70,7 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
-let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
+let ppo = (to-r | to-w | fence | po-unlock-lock-po) & int
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
