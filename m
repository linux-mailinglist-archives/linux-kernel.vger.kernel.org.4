Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB26CBC96
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1Keh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1Kef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:34:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088096E89
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:34:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z42so11955530ljq.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679999661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBJXkpYafqivBcbNlrQuUJmPyhRhZxAZpwT/By5GE8w=;
        b=p9qWyY2EK1v3QYhsmBzD8YVLpewv4/lw1ue1sdIACv5OgEFk9uirTqMMO5mzh+A2gc
         u5iKU8WxBOdw4Ts2ktB3677dF9vrThll2ObDxgS0ZMrkh+7ccZs83Vqq9kmK5pEtb5eg
         EJVSoyT0x64QjPnytXMKujaUAJJlAAmVNQs/zXPSlPtKxZa63ZaDo/BhLOAMIenQINTR
         ZpHOuC1w19cU7V8e3tyJKHgJGAkDXp/4SgxnuQ2TaKCOHFfROCirdLP3sfS+VAiosFOt
         VGXAA3asOpCiCk6xnFoW7trGUrUowAnO+FXSoaylypsmHvnohSAcH+7kDp8vHZvum2gC
         4ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679999661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBJXkpYafqivBcbNlrQuUJmPyhRhZxAZpwT/By5GE8w=;
        b=RV5fr16zRwpQa3ZlGQclK1VnclwuyY3Tm0ntAb8DVpi2UWaJpWaz0mok0m7ODO8cqh
         mr2CG60VbeemaFGfGFFU4C+b2uCeimZxvSnmAAO/5vgbCQG/AwFaRxD69fH793gKTa4V
         aDNonUC0HU0uxb2tQj3Z6/zuxwntA30mMWKIqNMjQBXHXIaS6m3/Jvu5dvbNdtQ71D4c
         vNQ8LEZNZ9Vidr0USGFJ1ywIf1EFHtSJZNStPX9X0+m5MpkHvW3lpzjBwq9Sjmb5qdzY
         w3wuvV/yubfuyaSrBdkWVefAYia4U91qTFVtVzudmBcA9e4CDK2j9aA6LNJatqBPI7i9
         6+7Q==
X-Gm-Message-State: AAQBX9czmfwiCvjWX8ZH6gCe2wl2r7WqgpHxoJCNhzsKOgB71pg7j+EY
        HkeCHmaw/e6AZ0gK0tr7PBBOWFum7lM=
X-Google-Smtp-Source: AKy350bJGqbczSZTknHZ2qtR5hvBR/MKIbLAWmTKZVOxrO9lfjfd0j+EsUWfNQhawriVY4xpX6TZ1A==
X-Received: by 2002:a2e:9d83:0:b0:299:57eb:ef34 with SMTP id c3-20020a2e9d83000000b0029957ebef34mr4472155ljj.53.1679999661072;
        Tue, 28 Mar 2023 03:34:21 -0700 (PDT)
Received: from [192.168.0.106] ([91.123.150.38])
        by smtp.gmail.com with ESMTPSA id o22-20020a2e9456000000b0029caabd3c7asm3754253ljh.54.2023.03.28.03.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:34:20 -0700 (PDT)
Message-ID: <a9799084-fef5-73b2-3631-6d61c713a18f@gmail.com>
Date:   Tue, 28 Mar 2023 13:34:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] xen/pvcalls: don't call bind_evtchn_to_irqhandler() under
 lock
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230328093924.12260-1-jgross@suse.com>
Content-Language: en-US
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
In-Reply-To: <20230328093924.12260-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.03.23 12:39, Juergen Gross wrote:

Hello Juergen


> bind_evtchn_to_irqhandler() shouldn't be called under spinlock, as it
> can sleep.
> 
> This requires to move the calls of create_active() out of the locked
> regions. This is no problem, as the worst which could happen would be
> a spurious call of the interrupt handler, causing a spurious wake_up().
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/lkml/Y+JUIl64UDmdkboh@kadam/
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/xen/pvcalls-front.c | 46 ++++++++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> index d5d589bda243..6e5d712e3115 100644
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@ -227,22 +227,31 @@ static irqreturn_t pvcalls_front_event_handler(int irq, void *dev_id)
>   
>   static void free_active_ring(struct sock_mapping *map);
>   
> -static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
> -				   struct sock_mapping *map)
> +static void pvcalls_front_destroy_active(struct pvcalls_bedata *bedata,
> +					 struct sock_mapping *map)
>   {
>   	int i;
>   
>   	unbind_from_irqhandler(map->active.irq, map);
>   
> -	spin_lock(&bedata->socket_lock);
> -	if (!list_empty(&map->list))
> -		list_del_init(&map->list);
> -	spin_unlock(&bedata->socket_lock);
> +	if (bedata) {
> +		spin_lock(&bedata->socket_lock);
> +		if (!list_empty(&map->list))
> +			list_del_init(&map->list);
> +		spin_unlock(&bedata->socket_lock);
> +	}
>   
>   	for (i = 0; i < (1 << PVCALLS_RING_ORDER); i++)
>   		gnttab_end_foreign_access(map->active.ring->ref[i], NULL);
>   	gnttab_end_foreign_access(map->active.ref, NULL);
> +
>   	free_active_ring(map);
> +}
> +
> +static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
> +				   struct sock_mapping *map)
> +{
> +	pvcalls_front_destroy_active(bedata, map);
>   
>   	kfree(map);
>   }
> @@ -433,19 +442,18 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
>   		pvcalls_exit_sock(sock);
>   		return ret;
>   	}
> -
> -	spin_lock(&bedata->socket_lock);
> -	ret = get_request(bedata, &req_id);
> +	ret = create_active(map, &evtchn);
>   	if (ret < 0) {
> -		spin_unlock(&bedata->socket_lock);
>   		free_active_ring(map);
>   		pvcalls_exit_sock(sock);
>   		return ret;
>   	}
> -	ret = create_active(map, &evtchn);
> +
> +	spin_lock(&bedata->socket_lock);
> +	ret = get_request(bedata, &req_id);
>   	if (ret < 0) {
>   		spin_unlock(&bedata->socket_lock);
> -		free_active_ring(map);
> +		pvcalls_front_destroy_active(NULL, map);
>   		pvcalls_exit_sock(sock);
>   		return ret;
>   	}
> @@ -821,28 +829,28 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
>   		pvcalls_exit_sock(sock);
>   		return ret;
>   	}
> -	spin_lock(&bedata->socket_lock);
> -	ret = get_request(bedata, &req_id);
> +	ret = create_active(map2, &evtchn);
>   	if (ret < 0) {
> +		free_active_ring(map2);
> +		kfree(map2);
>   		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
>   			  (void *)&map->passive.flags);
>   		spin_unlock(&bedata->socket_lock);


Looks like we also need to remove spin_unlock() above, correct?


> -		free_active_ring(map2);
> -		kfree(map2);
>   		pvcalls_exit_sock(sock);
>   		return ret;
>   	}
>   
> -	ret = create_active(map2, &evtchn);
> +	spin_lock(&bedata->socket_lock);
> +	ret = get_request(bedata, &req_id);
>   	if (ret < 0) {
> -		free_active_ring(map2);
> -		kfree(map2);
>   		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
>   			  (void *)&map->passive.flags);
>   		spin_unlock(&bedata->socket_lock);
> +		pvcalls_front_free_map(bedata, map2);
>   		pvcalls_exit_sock(sock);
>   		return ret;
>   	}
> +
>   	list_add_tail(&map2->list, &bedata->socket_mappings);
>   
>   	req = RING_GET_REQUEST(&bedata->ring, req_id);
