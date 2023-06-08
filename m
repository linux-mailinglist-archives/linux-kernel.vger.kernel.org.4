Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62B17275DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjFHDnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjFHDnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:43:32 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB326A2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:43:26 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38c35975545so154635b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 20:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686195804; x=1688787804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRRRAPdSVzI8M9rvQggGQiRbSztg9qbVFhL3kk5Uitk=;
        b=k2FOWi+JcACAzDU+ZGQT9P9bnpZyTJkHxuw1hF6HSsmvpxmeqzvbdcZBeqC9HxgrkC
         PsxfaXw+kQ1k/ct9ZviD+ZV2ELL0q3m3P0r37TJA7UAISodYQ1LNyppf2rVG141oTg/C
         B0plzjKcFdAfc8oEnppR7Vrr4HE5JMsphgPnzaDoLfVU0WmSSYYmelH12WXJmqWx1cbB
         Le47SFQ1BJxXsv1fjtFNzJmF3JjGAUk/b5/5MaXBPDcXXNVFpMXhDbWV9xfpnIZNuM+t
         y6ZT8BdxNVsYXj4bxlhb/0LSukso7wAHl+2FMcNCn6ULIpdJQQ2q6I/5df9ZAJhdiI9R
         pwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686195804; x=1688787804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HRRRAPdSVzI8M9rvQggGQiRbSztg9qbVFhL3kk5Uitk=;
        b=iP3kIV9BuKlA+Esrp9T+M5AoYxVa3e3pdqs8yJ0MAlNiAJ0fySzy2mgBGROR1LwXnM
         XVBKJ+ipMXkuG/qoiJNmnBMH4tX6aqns+R/XB46AIWTYpzqG1c8XGCF5vLomWN+30cdl
         70Ani7/4SfkdNhbWzAoNcIPvNF6vrXq/rgWHKZw+rZ07OibdyZrnUOaHIwi9qKgZ3wIo
         BFcaEitRkrFTK7l6evAq/M4sD1m2s9kHZr+uw53M+6r5h/hoIN8F2ibGptdbHVrUXhAP
         h5oClJ9buVykqXx5LkF+YldqAhpHMshjnaB+OV5lZSSiTuHpRlcAlsXgJGXEHiePj0Bz
         hjmw==
X-Gm-Message-State: AC+VfDxOvcAPQ2wUYy4dV7djnP9abt4/8h1yEw9g1nd/tlZ/ulO4oZEu
        1T4uobRkYaKCcIfwtz7jXsToGw==
X-Google-Smtp-Source: ACHHUZ4gsJ0M9aOZJ2VO4EhOiSSGeFEKY1ZAvD1n9gGanEgCz9OJe0JyECSr5LSSQuWazSMWS4ATqw==
X-Received: by 2002:a05:6808:5c1:b0:396:40c4:a2ef with SMTP id d1-20020a05680805c100b0039640c4a2efmr6960714oij.11.1686195804558;
        Wed, 07 Jun 2023 20:43:24 -0700 (PDT)
Received: from [10.54.24.10] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id bk24-20020a17090b081800b0023a84911df2sm253263pjb.7.2023.06.07.20.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 20:43:24 -0700 (PDT)
Message-ID: <17614a28-aabb-5c9e-5840-8fcbbd0b0e91@shopee.com>
Date:   Thu, 8 Jun 2023 11:43:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] mm/mm_init.c: add debug messsge for dma zone
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230607090734.1259-1-haifeng.xu@shopee.com>
 <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
 <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/7 18:22, David Hildenbrand wrote:
> On 07.06.23 12:16, Michal Hocko wrote:
>> On Wed 07-06-23 09:07:34, Haifeng Xu wrote:
>>> If freesize is less than dma_reserve, print warning message to report
>>> this case.
>>
>> Why?
> 
> I'd like to second that question, and add
> 
> a) Did you run into that scenario?
> b) What can an admin do in that case with that error messages?
> 
> If it reveals a buggy situation, maybe a WARN_ON_ONCE() is warranted ... but maybe only if anybody actually ran into that issue.
> 

I didn't run into that scenario, just from code review. I think the account for reserved pages is similar to memmap pages, if freesize
is less than memmap pages, it print a warning message, so for dma_reserve, it can also does the same thing.
