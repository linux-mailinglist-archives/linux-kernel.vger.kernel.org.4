Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87C36CD8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjC2LnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjC2LnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:43:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2849310F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:42:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so15856574pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680090172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rtdQyV0q9oVWf7iT9zqh6jDfdmbrVZm1KuGQCRjagw=;
        b=Se1EbJ5QdV7CwGZKR2MPJqTyvXrNSkMYRY9I4ZB75dhn5fOGk6RHn6GTwO05Moaj1+
         eJCdNSfTgVCBnuwzelj/LB40TfMPd+T/vZIV58OmKQSRCOzCPpyKG/kHdi/6kHXI9GPX
         5yW+j08hKi5BQ0/Apb8TC3t5gTMFSvh9RDAQ/A3RDcbr0BkeZyOxOkchF33TUywjqgoS
         CWYe2VMr6KQXoBVe0eO+6XIqqcm5sb3HQlBiWMwxkSfVW7iIMDXgpsfeIG7RDzsWLEZB
         /JQBe1N6E8vFNHCasrw2qtQXeC9ZntT6FIkbAl1NMRyeRiOqG5sgAIQFs0AatYl+tONI
         40KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680090172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rtdQyV0q9oVWf7iT9zqh6jDfdmbrVZm1KuGQCRjagw=;
        b=deV6/LeJWMfzNA2L3bDdYFzUeFj4KXxqGE68at5bg5TjgbWBq0Rc3ITbRhmLHh/s7j
         3EPC76rsQnzK0KAeQLDKNGipinhQkzr1oyy4gWzJfVhWfkmJqol0kNv0cx9ojZLiabi6
         iP2eY6+weDGpn3wyAfqTV+uW7rtY5xT38v+rokI3VBzThkuUjbm2rDpU5U19bmMoXIJA
         lrltLsCUocDeW1LDT/vD9LG+mcG+T9VzlhBTYd43Nd0TwmYVHaBt8LAagXz7jETVQhXt
         fKxHYqGmIHIbv/aac9tZycFprIGGk5FV2uVsefKh/WgA5ovlAln56sNKC5AjNf7XqK0U
         tbHA==
X-Gm-Message-State: AAQBX9chWYgmIYV2gYlUjWKwAoQs8MYOf0MnKT0DatrTyuRVHiHIKSls
        kOdZamQTuyt9FImUXy3+nO4hbA==
X-Google-Smtp-Source: AKy350bTawRigOCFkONs1BjCoXDEMU4q+k6uUeg9qWpwX1yJ/AP30l3jQUkeDQFYYF1rceOFjP5Dqg==
X-Received: by 2002:a17:903:28c8:b0:1a2:19c1:a974 with SMTP id kv8-20020a17090328c800b001a219c1a974mr14861215plb.68.1680090172616;
        Wed, 29 Mar 2023 04:42:52 -0700 (PDT)
Received: from [10.3.144.50] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b0019ab151eb90sm5144283plk.139.2023.03.29.04.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:42:52 -0700 (PDT)
Message-ID: <029453d7-1b2d-3d3c-cd8e-64f5be4420bf@bytedance.com>
Date:   Wed, 29 Mar 2023 19:42:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Re: [PATCH V4 3/5] cachefiles: resend an open request if the read
 request's object is closed
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, zhujia.zj@bytedance.com
References: <20230111052515.53941-4-zhujia.zj@bytedance.com>
 <20230111052515.53941-1-zhujia.zj@bytedance.com>
 <132777.1680012744@warthog.procyon.org.uk>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <132777.1680012744@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/28 22:12, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>> +	struct cachefiles_object *object =
>> +		((struct cachefiles_ondemand_info *)work)->object;
> 
> container_of().
Thanks, will revise it.
> 
>> +			continue;
>> +		} else if (cachefiles_ondemand_object_is_reopening(object)) {
> 
> The "else" is unnecessary.
Will remove it.
> 
>> +static void ondemand_object_worker(struct work_struct *work)
>> +{
>> +	struct cachefiles_object *object =
>> +		((struct cachefiles_ondemand_info *)work)->object;
>> +
>> +	cachefiles_ondemand_init_object(object);
>> +}
> 
> I can't help but feel there's some missing exclusion/locking.  

It's indeed kind of complicated here since the async operation.
Thus we paid much attention to catching the race scenarios during coding
and reviewing.

Here are several corner case have been considered:

1. Don't repeatedly push the @work of same object into workqueue:
Use <reopening> state to represent this object. Once the object is
set to <reopening> atomicly, which means the work has been pushed to
workqueue. And other concurrent threads will not pick the <reopening>
object to workqueue.

2. Don't repeatedly set <reopening> state for the same object:
Hold the xa_lock during searching reqs and setting it to <reopening>.
Once object is set to <reopening>, the same object will be skipped.

3. etc.

Would you mind providing more hints for this issue?

> This feels like
> it really ought to be driven from the fscache object state machine.

It's a great idea. But the problem is if we add a new state to indicate
this reopening status and use fscache state machine to drive the cookie
to do reopen(), thus reopen() (in fscache module) ought to invoke
cachefiles_ondemand_init_object() (in cachefile module) to require user
daemon to open the backend file.
But it seems that fscache module should not depend on cachefiles module.
> 
