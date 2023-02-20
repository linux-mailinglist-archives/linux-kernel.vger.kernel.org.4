Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324C969D20C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBTRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjBTRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F671C7EF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676913513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9UUOuyc1RiLX6lt0RLTFWolnPF6Xb+dal6ndxAWPtg=;
        b=Vq10yZR3A7b7rPIPnWDgQAQgBV2lsTaMzKWelkcd61Ss13FiE5LMvyESweEMWy/OnNcwC1
        KroPBbEdxcGDqXM1wUdNt0fUX/kA5ebUGSRhFO4HxxONu4XuY1KkdT0VuETToscb3pU5bN
        c+JZ6QxDt69QE0nCg7iD4brf2iUcJ8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-0ZToPXgeO9mm24tFAWT64g-1; Mon, 20 Feb 2023 12:18:30 -0500
X-MC-Unique: 0ZToPXgeO9mm24tFAWT64g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7618288562A;
        Mon, 20 Feb 2023 17:18:29 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4C9A492C3C;
        Mon, 20 Feb 2023 17:18:28 +0000 (UTC)
Message-ID: <248fbb79-744b-4e49-71de-a6d3d0a0e7ef@redhat.com>
Date:   Mon, 20 Feb 2023 12:18:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] docs: locking: refer to the actual existing config names
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230220165749.12850-1-lukas.bulwahn@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230220165749.12850-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 11:57, Lukas Bulwahn wrote:
> The config is actually called CONFIG_RT_MUTEXES, not CONFIG_RT_MUTEX.
>
> The config CONFIG_LOCK_TORTURE_TEST should be connected by underscore, for
> the sake of consistent referencing to configs in the kernel documentation.
>
> Address those issues.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   Documentation/locking/locktorture.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
> index dfaf9fc883f4..7f56fc0d7c31 100644
> --- a/Documentation/locking/locktorture.rst
> +++ b/Documentation/locking/locktorture.rst
> @@ -5,7 +5,7 @@ Kernel Lock Torture Test Operation
>   CONFIG_LOCK_TORTURE_TEST
>   ========================
>   
> -The CONFIG LOCK_TORTURE_TEST config option provides a kernel module
> +The CONFIG_LOCK_TORTURE_TEST config option provides a kernel module
>   that runs torture tests on core kernel locking primitives. The kernel
>   module, 'locktorture', may be built after the fact on the running
>   kernel to be tested, if desired. The tests periodically output status
> @@ -67,7 +67,7 @@ torture_type
>   
>   		     - "rtmutex_lock":
>   				rtmutex_lock() and rtmutex_unlock() pairs.
> -				Kernel must have CONFIG_RT_MUTEX=y.
> +				Kernel must have CONFIG_RT_MUTEXES=y.
>   
>   		     - "rwsem_lock":
>   				read/write down() and up() semaphore pairs.
Acked-by: Waiman Long <longman@redhat.com>

