Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A055E93C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIYO4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58162CC8B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664117778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wAMf4g97GMPZ/zZY9HnOUGLwVYUmgjVUMe6QXv7bsg=;
        b=JPMFmEaN4rahuSTXtNoX2irPKrPdHb/fjZsDR4e4RdXH5zNPiBl4jSirgryfxJ2aZY4d6m
        yCBsTkd5GPE7SibGWBIsT+ijCssQwlAyZ7R1lIOyX+j6OiYeGj+AwBiFd67qf1cmWHMQoc
        O1DHaApuSwlT/RG+ucOASBpiTdghABM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-Tmj6sBDQNK6DiF7a-0c5Mg-1; Sun, 25 Sep 2022 10:56:12 -0400
X-MC-Unique: Tmj6sBDQNK6DiF7a-0c5Mg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E3711C05143;
        Sun, 25 Sep 2022 14:56:12 +0000 (UTC)
Received: from [10.22.32.91] (unknown [10.22.32.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D50A492B04;
        Sun, 25 Sep 2022 14:56:11 +0000 (UTC)
Message-ID: <0a715ca2-0348-454a-1f49-1c4e6851346f@redhat.com>
Date:   Sun, 25 Sep 2022 10:56:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] locking/lock_events: Fix license version
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dbueso@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>
References: <a57505bf6c8ddbd68ff5a320aaf5922ec431e00e.1664117249.git.christophe.jaillet@wanadoo.fr>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <a57505bf6c8ddbd68ff5a320aaf5922ec431e00e.1664117249.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/22 10:47, Christophe JAILLET wrote:
> SPDX-License-Identifier is GPL-2.0, but the license text states "either
> version 2 of the License, or (at your option) any later version."
>
> So update the SPDX-License-Identifier to GPL-2.0-or-later.
>
> Remove the license text as well. It is useless now.
>
> Fixes: ad53fa10fa9e ("locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   kernel/locking/lock_events.h      | 12 +-----------
>   kernel/locking/lock_events_list.h | 12 +-----------
>   2 files changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
> index 8c7e7d25f09c..ba17c5be3c2b 100644
> --- a/kernel/locking/lock_events.h
> +++ b/kernel/locking/lock_events.h
> @@ -1,15 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>   /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>    * Authors: Waiman Long <longman@redhat.com>
>    */
>   
> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> index 97fb6f3f840a..7430ecd1fbc6 100644
> --- a/kernel/locking/lock_events_list.h
> +++ b/kernel/locking/lock_events_list.h
> @@ -1,15 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>   /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>    * Authors: Waiman Long <longman@redhat.com>
>    */
>   
Acked-by: Waiman Long <longman@redhat.com>

