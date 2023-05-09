Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED946FBD4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjEICct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjEICcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:32:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1F10CF
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=YNI/F7qyrCLspgi+tP41OwTJ6KrpGQKLIcl5Qot8Wck=; b=kzTcjm5Vrf0x9vkMuJZ+8Ex8Uz
        SyVNyRD2pyGfET+Ko5vi28OkVY2+X4TjCoV4eDEFPaVMP/OT31Nhy92iumqjmI+UGoiPw/35A3yYb
        voLqFJujXkp0OT+ZvpZjIP+Nu45ntbN8uyKowE/2z4j6E6kOSvbtZBk1uHYLb6pYw5EsOv+ElsklM
        6ACUdDnEtyqA0BEVIlWNSxYDKpnN1rHbvDhcoQQSi8N4sLIFpkIR2sgCxWAKkwnY/JWvQJqyPeI+9
        YXUkZ+fHMTJbWNW/EL5+EKe3zNQ8QIjwrRxgyki96y1gEuhEDNVozrJKcq6Ar0M9Hn+jiOw7QMX6n
        gUtafUBQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwD9Y-0027kk-2S;
        Tue, 09 May 2023 02:32:36 +0000
Message-ID: <628d3801-0a9e-c25b-c509-6db98a8afc14@infradead.org>
Date:   Mon, 8 May 2023 19:32:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2] locking: Fix a typo of comment
Content-Language: en-US
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <BE152DE8EF273104+ZFmu4JjPKLhla6Y9@TP-P15V>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <BE152DE8EF273104+ZFmu4JjPKLhla6Y9@TP-P15V>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/23 19:24, Wang Honghui wrote:
> 
> As title
> 
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>  kernel/locking/mutex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index d973fe6041bf..fe7335fb63d4 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -362,7 +362,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
>  		 * checking lock->owner still matches owner. And we already
>  		 * disabled preemption which is equal to the RCU read-side
>  		 * crital section in optimistic spinning code. Thus the

		   critical

> -		 * task_strcut structure won't go away during the spinning
> +		 * task_struct structure won't go away during the spinning
>  		 * period

		   period.

>  		 */
>  		barrier();
> @@ -401,7 +401,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
>  
>  	/*
>  	 * We already disabled preemption which is equal to the RCU read-side
> -	 * crital section in optimistic spinning code. Thus the task_strcut
> +	 * crital section in optimistic spinning code. Thus the task_struct

	   critical

>  	 * structure won't go away during the spinning period.
>  	 */
>  	owner = __mutex_owner(lock);

-- 
~Randy
