Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE326AD4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCGChh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCGChf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:37:35 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B45652C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:36:59 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id cp12so7182148pfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 18:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678156619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDKMtd6lom5Ib4tE02IeIT4xLjwj2prJfYqYEwpnO5I=;
        b=TgcoMgRaq9SieKQosaCeju55ChEd6LMI5sdcrzGWP7Ujloyn2tO+uke1WUD3+9WZu7
         mTW6qlr0UH+5K7pPYbbYKhs116Gbu2tp0N9DbW3+2P5XD4/S5z3GVyPQWw5ygl7XvgsF
         Z95rFJsQlqrPTcI+1zgY+BXiJY1CYU84v0RQErmiGOqrhnmEhWPKxVyRu7a7Ck3mEdIP
         NQgtdqybd78YZVKKh/PoBSY3G7FRIX9dY+Alx0k0a/1rcStJuLKCCaMtCfqDvFisGmq3
         vuKj0I8UvA6CDMfNH76O+fzij/IxyfsJdhJcg0gqsouGNKMZJFGy9h72i5r3AvUrOLqz
         Y8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678156619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HDKMtd6lom5Ib4tE02IeIT4xLjwj2prJfYqYEwpnO5I=;
        b=mFw9PTdUjdr0mvltBpIMGDdc/FeW0b1WbIAW0vxSP0LP6rAn29WcFhRXznovMZwRMS
         hwYGQhjR3BmyYRZhL9wDR4IQ6qgd4bHwcwXoGlnJr30cQKq5ERog8dfZ74y3V3nA+kX6
         aALDpiqE7DJ6JMF24ca8ZZvuaNhzeEmo1Lsmr4pIMhfTOf+i7vTn9tdLubkTDtuXlsIv
         CoO02q/Rjpc8Ggv7uPjpYhlOlExKUhvOWJ93PU6KUzuf36U0VKH7EAce1i3gU8930XZk
         Q3VziREbk2AcivQkmkOetVFBYZyxRDk1EAAYQnjZ5eprer6ZzthjAmGNHxljZInU2a58
         Tfxg==
X-Gm-Message-State: AO0yUKW0fUXfHCumGoLw5b7yCNjuG1PJWJim0S3q1B83LpZGWr3wwpls
        4BmzVSqpb6oS89rDc9x9gr83SZ0JnwoVxeXJ64oe/yUN
X-Google-Smtp-Source: AK7set8kDPXt0cKCbfbOc/EhXLxBzIiQFM/s0cVQfpqnEqKOV0jli1fL8m3XLc/7K+o0dhyr8RD/rQ==
X-Received: by 2002:a62:8489:0:b0:5a9:bf42:fcc5 with SMTP id k131-20020a628489000000b005a9bf42fcc5mr15842166pfd.0.1678156618674;
        Mon, 06 Mar 2023 18:36:58 -0800 (PST)
Received: from [10.54.24.141] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id q19-20020a62e113000000b005dd98927cc5sm6944453pfh.76.2023.03.06.18.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 18:36:58 -0800 (PST)
Message-ID: <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
Date:   Tue, 7 Mar 2023 10:36:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
 <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
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



On 2023/3/6 21:49, David Hildenbrand wrote:
> On 06.03.23 03:49, Haifeng Xu wrote:
>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
>> set or not, so remove the check in handle_mm_fault().
> 
> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
> 
> However, that requires now always an indirect function call -- do we care about dropping that optimization?
> 
> 

If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.

if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible 
compare to the whole mm user falut preocess. And that won't cause stack overflow error.

Thanks.
