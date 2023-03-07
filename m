Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F86AD599
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCGDUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCGDUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:20:18 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17405868A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 19:20:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so10657464pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 19:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678159214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fxxnRhDuO7Ys+K4s57yszbFoRf4ztzBuG5QcJ/0FD4=;
        b=EMbz1ctztmPUvdbZPA2uJIMRn7teZTdcsfUEzUi3t6M4+05hP7/8mVDgWQ2ff02HVn
         OQhuU2EqgvOgEskuEovItUaDq5uXuAIA56CjOBs+0ah4tk5LkcC0htl2iQOvsasi0VBz
         SI6DsrS20s3Jz6j2Lg2ywbH7hxBuG5XwrNymoUuqIKeojcwDc1khJPQUwtunyGDE+DZU
         QFR+o7BrXVL1lpjJFWePPe1ykU4+tE1et2zhF0gpsst9O9WJleDfcR9nJ2gAAz4Tnnr+
         L96j7JSg6qw64T2SpdVPagRECn5weuIc1FcEL0gdxbaMXXn03r9Tn4H6jo9V+1njY5dC
         +jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678159214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7fxxnRhDuO7Ys+K4s57yszbFoRf4ztzBuG5QcJ/0FD4=;
        b=uHuHaY+gp1ZnLVKOJfusmTrV0aiGDd7iYTK6HtSU49uL4aiSoN4JwHSty57jSHqrlo
         6SyvvMq2nXqb9KNxZJ+RXtPdnpm3reLWqAA67BBi9pyNYHFD5HCC6v3/giJYLRbCh+3V
         QomlPmG24/CfMHU9V5bqKdMghOyz/TKNsz0NVyrroyNY4bJA2s75mQIAlWVMnO95d5va
         O41uul7cV/BWc6+g0BLkvBcR9/5iJzd/SVmXpXLmYF5JiIP0LbrpNcUodCv9jznjeqFE
         yci7jFP3JsyIYsD32F0STQy52AexIZUByoMvXwqXE2KxHcpxNrKOzBcKURR2fujJXGTM
         bwKA==
X-Gm-Message-State: AO0yUKUokZjXRFO57btZEtC45OO4cnxg1bg7pNPgkwJJeY2C6p5bey6c
        6l6ZQZoDfbd6vfXPWNrr3FQGmbiBRhvIxmv0CUU=
X-Google-Smtp-Source: AK7set+LwCg1AubccRkdobphpPfAUZQxKqQOMurMIZ8yDBA5RBE6hmJRYXtorjhQwKZUnJnSQDQk6Q==
X-Received: by 2002:a17:902:c94c:b0:19b:33c0:4091 with SMTP id i12-20020a170902c94c00b0019b33c04091mr17654674pla.52.1678159214455;
        Mon, 06 Mar 2023 19:20:14 -0800 (PST)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170903430600b0019ab3308554sm7388794plb.85.2023.03.06.19.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 19:20:14 -0800 (PST)
Message-ID: <4b2b0132-eb6f-d0a9-e6bb-6b23d3cbcd48@shopee.com>
Date:   Tue, 7 Mar 2023 11:20:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
 <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
 <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
 <ZAamFX/hq6Y/iNJb@casper.infradead.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZAamFX/hq6Y/iNJb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/7 10:48, Matthew Wilcox wrote:
> On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
>> On 2023/3/6 21:49, David Hildenbrand wrote:
>>> On 06.03.23 03:49, Haifeng Xu wrote:
>>>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
>>>> set or not, so remove the check in handle_mm_fault().
>>>
>>> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
>>>
>>> However, that requires now always an indirect function call -- do we care about dropping that optimization?
>>>
>>>
>>
>> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
>>
>> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible 
>> compare to the whole mm user falut preocess. And that won't cause stack overflow error.
> 
> I suggest you measure it.

Ok, I'll make a simple test.
