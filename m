Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A90600601
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJQE0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJQE0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:26:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A134CA29
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:26:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m6so10047884pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFSmEv2tRk40DzOwLx5rHuZRKNkvGuZ5/J8+Egszsec=;
        b=OuOm7ZYilVJH+yXrueBOKP8N1xKMaZmarB4gJ/H+I0PmJBcMjVXIaTMyZVIH3NtWML
         lbxwnuetpluELNvSYLK550cHKIDcpL6jkabxssVj2UjTKxEWAcZZ8qtdWWnnlHlKShq+
         zEhftAcuOiMy8qiy1UDlZztIf2TqY+l37uL329rcqhU4p1yV6dbHcFHU2YdaIX008duz
         8IHcDL96TIa9hWCsRobdgJANgaHMgRxlDZNHpkixsinGWM7tlZQViPsPbiQsRfUmgbII
         YLAwyzwhDIvsG5MulUJhjn/BV5cDjw4gMzh/YROlpJ4BN9ug2B+37XKUnWvvzuknDxUJ
         3OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFSmEv2tRk40DzOwLx5rHuZRKNkvGuZ5/J8+Egszsec=;
        b=BwsWxrYob+eIzwCcBYKp7Naj4N4QcWLtiJzromCChpwvpbufbccopP3iiHnBirLB8q
         oTQxBi+H5bzfXrLzD12sUeRv16rL5c4O+lcx+4v7wrDhp+oT+tACVxVItHfK8RBUqLDh
         3/8h6w8HvDT8bhmMKA7CM30BKCLbU/9vQCmOD3R9TO3+D6C0+v6vOGeI2lvBRkUa15Fq
         b6KLjLKbMXy+JlMjtUlCIqWq58dJMc7qniILiNYS7GKJ6KkLd2fp6+j6kUwiClszwZ4V
         YOZiUdwyZlOzHT9nR3DuY2l0ri++uPOck51+B1mhvdpqSPhXcQEwVM+NDo3vQNwn6v4E
         in2w==
X-Gm-Message-State: ACrzQf3NmwcHP7isgIevXBavn/tRhWSV0nvHsTnG1DZd9rrrLiQaMLdG
        H8vqq7oMw9/jupxqC66Ui4Z/Kg==
X-Google-Smtp-Source: AMsMyM71a+Ug6iJ95KAjcgyZ0aYJkzGMGdKXdpmkfTFdL4zy5GwYwuVQTfWIArsfpLqmjo0T/UxbNw==
X-Received: by 2002:a65:6bc1:0:b0:462:4a88:4fef with SMTP id e1-20020a656bc1000000b004624a884fefmr8941522pgw.282.1665980783496;
        Sun, 16 Oct 2022 21:26:23 -0700 (PDT)
Received: from [10.4.245.17] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id b124-20020a62cf82000000b00562b752b38asm5990823pfg.145.2022.10.16.21.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 21:26:23 -0700 (PDT)
Message-ID: <5ea4949e-3e8b-2ec0-bdcf-93e5744caee1@bytedance.com>
Date:   Mon, 17 Oct 2022 12:26:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <d5d72856-417a-0fe7-4b1d-3e27c64c1a85@linux.dev>
 <802E39EA-7444-4B33-AB95-594A600FE404@joelfernandes.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <802E39EA-7444-4B33-AB95-594A600FE404@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 11:56, Joel Fernandes wrote:
> 
> 
>> On Oct 16, 2022, at 11:25 PM, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>>
>> ﻿Hello,
>>
>>> On 2022/10/4 05:44, Connor O'Brien wrote:
>>> Proxy execution is an approach to implementing priority inheritance
>>> based on distinguishing between a task's scheduler context (information
>>> required in order to make scheduling decisions about when the task gets
>>> to run, such as its scheduler class and priority) and its execution
>>> context (information required to actually run the task, such as CPU
>>> affinity). With proxy execution enabled, a task p1 that blocks on a
>>> mutex remains on the runqueue, but its "blocked" status and the mutex on
>>> which it blocks are recorded. If p1 is selected to run while still
>>> blocked, the lock owner p2 can run "on its behalf", inheriting p1's
>>> scheduler context. Execution context is not inherited, meaning that
>>> e.g. the CPUs where p2 can run are still determined by its own affinity
>>> and not p1's.
>>
>> This is cool. We have a problem (others should have encountered it too) that
>> priority inversion happened when the rwsem writer is waiting for many readers
>> which held lock but are throttled by CFS bandwidth control. (In our use case,
>> the rwsem is the mm_struct->mmap_sem)
>>
>> So I'm curious if this work can also solve this problem? If we don't dequeue
>> the rwsem writer when it blocked on the rwsem, then CFS scheduler pick it to
>> run, we can use blocked chain to find the readers to run?
> 
> That seems a lot harder and unsupported by current patch set AFAICS (my exposure to this work is about a week so take it with a grain of salt). You could have multiple readers so how would you choose which reader to proxy for (round robin?).  Also, you no longer have a chain but a tree of chains, with the leaves being each reader - so you have to track that somehow, then keep migrating the blocked tasks in the chain to each readers CPU. Possibly migrating a lot more than in the case of a single chain. Also it’s not clear if it will be beneficial as proxying for one reader does not mean you’re improving the situation if it is another reader that is in need of the boost.
> 

Thanks for your reply, it's indeed more complex than I think, and proxying for just one reader
is also less efficient.

But this rwsem priority inversion problem hurts us so much that we are afraid to use
CFS bandwidth control now. Imaging when 10 readers held mmap_sem then throttled for 20ms,
the writer will have to wait for at least 200ms, which become worse if the writer held other lock.

Thanks.

