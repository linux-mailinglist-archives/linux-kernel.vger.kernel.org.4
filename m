Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323996FD77D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjEJGyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjEJGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:54:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380C30F9;
        Tue,  9 May 2023 23:54:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac785015d7so75919681fa.1;
        Tue, 09 May 2023 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683701682; x=1686293682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRGiJAE+vgeRRLDYJr81r9VII9vr3kHjWTM35hbXEI4=;
        b=fEjvyg+wXB2Lo1nkhdj3WLgvY04+Xy/FqAlBUsc8dt3dFXHW0l1xWG1+CJDifoo2kz
         asz3WVGKIqqN2ar7I6H6SUNh0t8ZGF/0IDgL+Oh92p77frp6TJwh2YQtW3gfXA3gWod/
         AWGezbbU3sZh8oms9CzgJ9cOxChSDLvYHa/hDS3Eyj+AFvVVphMlMzefGF3fIZw1DS3s
         8fHGlTv7lGF5epua1EKBIWAozCD1qbmCLV5zQwC7A0vI1MMkfL3/tPVW1Ma+C84jWIzy
         GINzgt4epvzaFMIaPOelsVtGWB652MeYdXPaeFFp/b89DtJTcyt4IRuovNG4f+D5+RNX
         02/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701682; x=1686293682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRGiJAE+vgeRRLDYJr81r9VII9vr3kHjWTM35hbXEI4=;
        b=EHzSOUH4LdxkjgBFVkt0CzdUj5aFRHXjU4MyP5Qkzjli6GJtKvp2AXMtbeeM6tWfU/
         1GRYoazAVJp7NuI9/A8xd3qTMn/Ia3dZsDIyHnz26ZJOWIu/Dln4hQCOqm9CLzls5NKN
         LZNAgiXZS2EfZEkv0ujDXTCXJQW19fyb0TqX4MBnbxNog5gPrYQR5Xj6BltcyhDQrhKY
         cpcrUJsbtxbutNRqgLRDjzfb6t3K4QdeTohxlTli0DP8GW9+LAoMv6+F4WXzbWB6Edws
         Z6akwNEmbh8uhimdfnUcLjFoGloHSv1ySVvxNfwPXUG63eF5b6Qhy2aY2r7VisnafLLW
         cLVw==
X-Gm-Message-State: AC+VfDyOL7mfh5/wpF5y8Qt7umXdyFe9fCjGlcz7/Te0QfW4x1opCy2o
        y3EEdB8Vz0fNh1JL6oWPpSFF2Vf5A4J1Pg==
X-Google-Smtp-Source: ACHHUZ5fL1AcT0qKSuXRtpxFl+qViIBuKdrm+8NHLTZt2ZFcuP25p3Ja0smxCaDXQEaGPho8puJ+1A==
X-Received: by 2002:a2e:b607:0:b0:2ad:9b02:21e2 with SMTP id r7-20020a2eb607000000b002ad9b0221e2mr1552553ljn.40.1683701681408;
        Tue, 09 May 2023 23:54:41 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.95])
        by smtp.gmail.com with ESMTPSA id o7-20020a2e9447000000b002ad99aa3fa8sm783285ljh.13.2023.05.09.23.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 23:54:40 -0700 (PDT)
Message-ID: <527bf278-48a3-1b43-a23f-dd4cbb92ef19@gmail.com>
Date:   Wed, 10 May 2023 09:54:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] audit: refactor queue full checks
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, paul@paul-moore.com,
        eparis@redhat.com, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <20230508075812.76077-2-eiichi.tsukata@nutanix.com>
Content-Language: en-US, ru-RU
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <20230508075812.76077-2-eiichi.tsukata@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eiichi!

Just one one for your patch.

On 08.05.2023 10:58, Eiichi Tsukata wrote:
> Currently audit queue full checks are done in multiple places.
> Consolidate them into one audit_queue_full().
>
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>   kernel/audit.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..c15694e1a76b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -341,6 +341,12 @@ static inline int audit_rate_check(void)
>   	return retval;
>   }
>   
> +static inline int audit_queue_full(const struct sk_buff_head *queue)
> +{
> +	return audit_backlog_limit &&
> +	       (skb_queue_len(queue) > audit_backlog_limit);
It seems that we should use `>=` here.
> +}
> +
>   /**
>    * audit_log_lost - conditionally log lost audit message event
>    * @message: the message stating reason for lost audit message
> @@ -579,8 +585,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
>   	 * record on the retry queue unless it's full, in which case drop it
>   	 */
>   	if (error == -EAGAIN) {
> -		if (!audit_backlog_limit ||
> -		    skb_queue_len(&audit_retry_queue) < audit_backlog_limit) {
> +		if (!audit_queue_full(&audit_retry_queue)) {
>   			skb_queue_tail(&audit_retry_queue, skb);
>   			return;
>   		}
> @@ -589,8 +594,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
>   	}
>   
>   	/* if we have room in the hold queue, queue the message */
> -	if (!audit_backlog_limit ||
> -	    skb_queue_len(&audit_hold_queue) < audit_backlog_limit) {
> +	if (!audit_queue_full(&audit_hold_queue)) {
>   		skb_queue_tail(&audit_hold_queue, skb);
>   		return;
>   	}
> @@ -613,8 +617,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
>    */
>   static void kauditd_retry_skb(struct sk_buff *skb, __always_unused int error)
>   {
> -	if (!audit_backlog_limit ||
> -	    skb_queue_len(&audit_retry_queue) < audit_backlog_limit) {
> +	if (!audit_queue_full(&audit_retry_queue)) {
>   		skb_queue_tail(&audit_retry_queue, skb);
>   		return;
>   	}
> @@ -1564,8 +1567,7 @@ static void audit_receive(struct sk_buff  *skb)
>   	audit_ctl_unlock();
>   
>   	/* can't block with the ctrl lock, so penalize the sender now */
> -	if (audit_backlog_limit &&
> -	    (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
> +	if (audit_queue_full(&audit_queue)) {
>   		DECLARE_WAITQUEUE(wait, current);
>   
>   		/* wake kauditd to try and flush the queue */
> @@ -1866,8 +1868,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>   	if (!(auditd_test_task(current) || audit_ctl_owner_current())) {
>   		long stime = audit_backlog_wait_time;
>   
> -		while (audit_backlog_limit &&
> -		       (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
> +		while (audit_queue_full(&audit_queue)) {
>   			/* wake kauditd to try and flush the queue */
>   			wake_up_interruptible(&kauditd_wait);
>   
