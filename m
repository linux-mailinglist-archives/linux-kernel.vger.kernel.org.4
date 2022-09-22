Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA845E624C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiIVMZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiIVMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A564DE0F2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663849537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbHo+nup5LeM5CPwP1fGUjxG11sfODUSTv/mMzZKWao=;
        b=F7BF6nePpyzsWaL1KRW/jVrREfmulFWoL9gn3t2YeT8ny6uDR6oO/csExMHmgjvatQVTE6
        FCREq0JQdnzv/+ZfLyo8QWuITJmsyAPUoFICi/QgwlXqMvnV738waa9R514H6dzrdcOxgd
        dZR7nI650cD+Jrz6itBDx6h3v5pdZs0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-VDpk4jHGOvOJ7oaar4jyfA-1; Thu, 22 Sep 2022 08:25:34 -0400
X-MC-Unique: VDpk4jHGOvOJ7oaar4jyfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A402A185A78B;
        Thu, 22 Sep 2022 12:25:33 +0000 (UTC)
Received: from [10.22.33.6] (unknown [10.22.33.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD912024CC5;
        Thu, 22 Sep 2022 12:25:33 +0000 (UTC)
Message-ID: <add3dfec-36e0-1f3e-67ca-714d0ecc296d@redhat.com>
Date:   Thu, 22 Sep 2022 08:25:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] tracing: Use proper do_arch_spin_lock() API
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220921132152.1622616-1-longman@redhat.com>
 <20220921132152.1622616-3-longman@redhat.com>
 <20220921181721.3a51afe9@gandalf.local.home>
 <YywU8U7yD1nvvGlZ@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YywU8U7yD1nvvGlZ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 03:55, Peter Zijlstra wrote:
> I'm with Steve on not adding wrappers for this; people that use
> arch_spinlock_* get to keep the pieces :-)

Yes, I am going to drop patch 1 and open-code all the changes in a new 
patch.

Cheers,
Longman

